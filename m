Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0539EEA86A
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 22:36:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 668E483AAB;
	Thu, 12 Feb 2026 23:36:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nwl.cc header.i=@nwl.cc header.b="I+pYZ3LV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18E7E83B9D; Thu, 12 Feb 2026 23:36:09 +0100 (CET)
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C231883015
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 23:36:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=phil@nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
 s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FLCssvcDglcQzIFtpB5+GYh968vFrn03MteDCEEWo5g=; b=I+pYZ3LV6YMpgwWqn0jq5qOsOx
 3mpsKUPd/BRwq9gcDv7mhJdn8H7DKG3omYD/ZvAOkrygu+lC0mEAbux8c0FkXyOPyKzvTWGqod+CJ
 SmqXC0dOWoURsEwrYatl+BznTXNX/6wRyolY4gAMnqPlWfs64E3xEQ+eGTd3SbVRZxLM6wpnjxLbD
 OqKUg61/Gkl6pM2t6jaa6avBy2bWWlxsFkNT6TLpcRU08CG+lPE3176RKh9+e9QBlziCY1k6xNsXJ
 MZ0EbIwzOPvVNIpXDQx0vmxLskqrNo7k8QB87LYYALhCbQLSyqV740iB+ZpN/avPSGmjskiVC7s9f
 zM7V+j+g==;
Authentication-Results: mail.nwl.cc; iprev=pass (localhost) smtp.remote-ip=::1
Received: from localhost ([::1] helo=base)
 by orbyte.nwl.cc with esmtp (Exim 4.98.2)
 (envelope-from <phil@nwl.cc>) id 1vqfI6-000000006kJ-20ou;
 Thu, 12 Feb 2026 23:36:06 +0100
From: Phil Sutter <phil@nwl.cc>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 0/2] Synology: common: Fix typo and fallout
Date: Thu, 12 Feb 2026 23:31:08 +0100
Message-ID: <20260212223110.20267-1-phil@nwl.cc>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Patch 2 fixes a trivial typo which disabled building of legacy.c by
accident. Compiling for some of the boards now including this source again
fails though due to undefined readl(). Fix this in a preceeding patch 1
to retain bisectability.

Changes since v1:
- New patch 1
- Drop unrelated chunk from patch 2

Phil Sutter (2):
  board: Synology: legacy.c: Include asm/io.h
  board: Synology: common: Fix typo in Makefile

 board/Synology/common/Makefile | 2 +-
 board/Synology/common/legacy.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.52.0

