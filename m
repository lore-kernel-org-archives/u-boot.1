Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12117C5516E
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 20:24:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E666540D77;
	Thu, 30 Jul 2026 20:24:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q1lu1UYl3WWG; Thu, 30 Jul 2026 20:24:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 71B7940C9A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785443088;
	bh=RI0YflAdhBu34903k6tQFEVZjP6paJ/f6TNRnc7wlec=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=01SyGnJL79izo2RK0yL1SGDe5vmDiBuFtxmW9JyDh19xlzObJM+2Jed6ME+DCs/Ry
	 8mxiKzOGwqMwbAMhpZEpsKdlkNAqunRz283ybx3PCMHDe884CEYmkcy6phAkSBrlkH
	 d1UG20+ehOFPWG+b+VD4CumYqwPyDAIxww3jGqhq6duueY734bBdOl3+ggWTCTBzF2
	 pBEI23paz9s3uPooWgCWbLXxfy00oC0Q50xY+yQplYcR3fQJkRCbF6EHDybCqNFaRz
	 QXNn8684/9Px+E1vYtGp/0TAU0gpwuhuaKLD2b+H/HxqJn5Tkvw0ZR1W1E4m+dUlBT
	 g7yXqxQ7ThIkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71B7940C9A;
	Thu, 30 Jul 2026 20:24:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B7F2769
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 19:38:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9852A81235
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 19:38:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 96BI2Oyo-vZR for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 19:38:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=elliotjb@elliotjb.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 288678122F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 288678122F
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 288678122F
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 19:38:25 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7621384A0A; Thu, 30 Jul 2026 21:38:22 +0200 (CEST)
Received: from MTA-12-4.privateemail.com (mta-12-4.privateemail.com
 [198.54.127.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50E75849BC
 for <u-boot@lists.denx.de>; Thu, 30 Jul 2026 21:38:20 +0200 (CEST)
Received: from mail.privateemail.com (K8S-PROD-WORKER-15 [77.233.63.4])
 by mta-12.privateemail.com (Postfix) with ESMTPA id 4h9zyG5Tfdz3hhTY;
 Thu, 30 Jul 2026 15:38:14 -0400 (EDT)
From: Elliot Berman <elliotjb@elliotjb.com>
Subject: [PATCH 0/3] qemu-x86: Wire up EFI capsule updates on pflash
Date: Thu, 30 Jul 2026 12:37:44 -0700
Message-Id: <20260730-qemu-x86-pflash-v1-0-fb403348e29b@elliotjb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyNL3cLU3FLdCgsz3YK0nMTiDN1EE0MjS9OUROPkFEMloK6CotS0zAq
 widGxEH5xaVJWanIJyBil2loAtGeDA3MAAAA=
X-Change-ID: 20260729-qemu-x86-pflash-a41295da3cd1
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Elliot Berman <elliotjb@elliotjb.com>
X-Mailer: b4 0.15.2
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 30 Jul 2026 20:24:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=elliotjb.com; s=default; t=1785440298;
 bh=rkXEj/SksFc+5RE70buuCC0cRK1mBEoNnBcw0ykDUxw=;
 h=From:Subject:Date:To:Cc:From;
 b=qd9BqI4JKgIbEYMrxrfXcs1n2w3QhRm3U+/9vxlfKPyKU9qg8SbK5OjlxxqrUtvsK
 s0nRbXgiaTJhTuLt7CZDVPfkxLga/XdYIGuWSxwa/PAdgrIeBo/5xUSuFG23kmYDy8
 USkpbdRiaa6CFs9+1+Tr5FujvSrm8S21alYQdOF2Y3csbFtNyxXaAZc0GxuGxfwBhy
 7alB4LKH9+xwZkxReYfchK/+DTv0iGNvv+Y2ItveRMYZxmyRrgKSLy4PCGGOFbTmp4
 gmPdkfddZXGe4Q5zUUsb39cEpJOobqqNPZ9pf4ESKHM9u3udePcDYP3S2YXoBvDmXt
 HoE+5havJ5yXA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=elliotjb.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=elliotjb.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=elliotjb.com header.i=@elliotjb.com header.a=rsa-sha256
 header.s=default header.b=qd9BqI4J
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=elliotjb.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=elliotjb@elliotjb.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=elliotjb.com header.i=@elliotjb.com header.b="qd9BqI4J";
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

QEMU's x86 machines map a CFI NOR pflash device, mirroring the mechanism
qemu-arm64 already uses for capsule updates. This series describes that
pflash region in the x86 device trees and wires up the board code so
EFI capsule updates can target the u-boot partition on it.

Adding the pflash node to devicetree is safe even when QEMU is run
without -pflash. The same address range is backed by the BIOS ROM
instead, so the cfi-flash probe harmlessly reports no flash rather than
breaking existing -bios based boots.

Signed-off-by: Elliot Berman <elliotjb@elliotjb.com>
---
Elliot Berman (3):
      x86: qemu: Describe pflash
      qemu-x86: Wire support for applying capsule updates to pflash
      x86: emulation: enable cfi flash drivers

 arch/x86/dts/pflash.dtsi               | 14 +++++++++++++
 arch/x86/dts/qemu-x86_i440fx.dts       |  1 +
 arch/x86/dts/qemu-x86_q35.dts          |  1 +
 board/emulation/common/Kconfig         |  2 ++
 board/emulation/common/qemu_dfu.c      |  6 ++++--
 board/emulation/common/qemu_mtdparts.c |  6 ++++--
 board/emulation/qemu-x86/Kconfig       |  3 +++
 board/emulation/qemu-x86/Makefile      |  3 +++
 board/emulation/qemu-x86/qemu-x86.c    | 38 ++++++++++++++++++++++++++++++++++
 configs/qemu-x86_64_defconfig          | 13 ++++++++++++
 configs/qemu-x86_defconfig             | 13 ++++++++++++
 11 files changed, 96 insertions(+), 4 deletions(-)
---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20260729-qemu-x86-pflash-a41295da3cd1

Best regards,
--  
Elliot Berman <elliotjb@elliotjb.com>

