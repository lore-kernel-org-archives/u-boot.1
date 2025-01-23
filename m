Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B01C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 13:01:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEBB38078B;
	Thu, 23 Jan 2025 14:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="QQ85jp28";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF60E80275; Thu, 23 Jan 2025 10:12:10 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1D0480137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 10:12:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 721A3257BE;
 Thu, 23 Jan 2025 10:12:08 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2REKCUdmIKhD; Thu, 23 Jan 2025 10:12:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1737623527; bh=LFDgcbW7ywqIZcBiz1WshGRhaGfPFtMFYPsrbO3v8oQ=;
 h=From:To:Cc:Subject:Date;
 b=QQ85jp28H+mJ0hdvg3K3QOLkJq467/OFQotd/xYX7pzwStLVPkbpDyRU66/R+rgSV
 vTZz0qDXVK9qr8BDEampn0BLEhCX6Hj5j3KnKWcHhDDqiVA6rLtL6IjeacB6P89Iq1
 Jj57U3jjij8gWgfSqT4jWfT+AYSwYiyQ43D1Hd8/m2tSTcRvdXIgRkTT/F0Zx8zU8X
 1+KMSic3UIt4ezv4tAjh9gyiOvn1uX45Ol2rD11cHQwZj+CaWkrYVLgTROeu6P9GxN
 nIYRASsUZu1ZjMxO9DOKEeQ1OzxbIwIHfLGio0LDUOl93EzuyRTaLY8Lg+zXB/7Eis
 6R7jaOyB5e2pw==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Conor Dooley <conor.dooley@microchip.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
	Yao Zi <ziyao@disroot.org>
Subject: [RFC PATCH 0/3] Unify implementation of cleanup_before_linux() for
 RISC-V ports
Date: Thu, 23 Jan 2025 09:11:32 +0000
Message-ID: <20250123091134.63634-2-ziyao@disroot.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 23 Jan 2025 14:01:27 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This series introduces a generic version of cleanup_before_linux(),
because most RISC-V SoCs have similar implementation. Ports for generic
platforms and JH7110 are converted to use it for now: these devices are
available to me and I have verified that Linux boots with these changes.

With a quick look at the codebase, I think this could be done for all
RISC-V ports ultimately. Thanks for your feedback and review.

Yao Zi (3):
  riscv: add a generic implementation for cleanup_before_linux()
  riscv: cpu: generic: fallback to generic cleanup_before_linux()
  riscv: cpu: jh7110: fallback to generic cleanup_before_linux()

 arch/riscv/cpu/cpu.c            | 17 +++++++++++++++++
 arch/riscv/cpu/generic/Makefile |  1 -
 arch/riscv/cpu/generic/cpu.c    | 22 ----------------------
 arch/riscv/cpu/jh7110/Makefile  |  1 -
 arch/riscv/cpu/jh7110/cpu.c     | 23 -----------------------
 5 files changed, 17 insertions(+), 47 deletions(-)
 delete mode 100644 arch/riscv/cpu/generic/cpu.c
 delete mode 100644 arch/riscv/cpu/jh7110/cpu.c

-- 
2.48.0

