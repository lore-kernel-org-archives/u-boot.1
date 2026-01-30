Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C51D73EBA
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 04:04:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7A98841E6;
	Fri, 30 Jan 2026 05:04:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.b="ffhatDWb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B90898418A; Fri, 30 Jan 2026 05:04:53 +0100 (CET)
Received: from cascadia.aikidev.net (cascadia.aikidev.net
 [IPv6:2600:3c01:e000:267:0:a171:de7:c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3398841E6
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 05:04:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vagrant@aikidev.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=debian.org;
 s=1.vagrant.user; t=1769745890;
 bh=wKgpkBKH58xUmax42GxMOK4mNAZTktIvfZoGi72AsvU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ffhatDWbYab0LSqQqsBmkRiNb3MasnvZMiU7gokvDMKsAF4WB2knlCjKRMZt1diXf
 mE/n+zM1igvmwy0Y9rHyVdZ+ladsBsSiewYKOWl60rvPLSEESzwGC1Y1nUHIAzOqhM
 OZQb7flQUK1YmVhFuQam2dtmDheTF1bo9yiTwkSmVfmvwV3RvmFEdTRYbQzGFHAn1M
 kA5T/jmp7PcKq3ylQ6fYZipZKfxu+KPMgqNVS/eJjT1PxmHeCDJlilbrWCjneoMwFT
 Qk3NLuA/Eb0lAzrJkZKte0KMLzXmGphTjg4ZOZ1dmJ+QaNFKeP1GTk5xdQnEMZmQEc
 3FlydpsJHTzRw==
Received: from localhost (unknown [IPv6:2600:3c01:e000:21:7:77:0:50])
 by cascadia.aikidev.net (Postfix) with UTF8SMTPSA id 01CEBD7E7;
 Thu, 29 Jan 2026 20:04:49 -0800 (PST)
From: vagrant@debian.org
To: u-boot@lists.denx.de
Cc: vagrant@debian.org, Tom Rini <trini@konsulko.com>,
 Green Wan <green.wan@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH 2/2] board: sifive: unmatched: set fdtfile with unquoted
 variable.
Date: Thu, 29 Jan 2026 20:04:24 -0800
Message-ID: <20260130040424.472735-2-vagrant@debian.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260130040424.472735-1-vagrant@debian.org>
References: <20260130040424.472735-1-vagrant@debian.org>
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

From: Vagrant Cascadian <vagrant@debian.org>

The fdtdfile variable contains quotes:

  printenv fdtfile
  fdtfile="sifive/hifive-unmatched-a00.dtb"

But this leads to issues which booting with an extlinux.conf format
file failing to find the .dtb file:

  Retrieving file: /usr/lib/linux-image-6.12.63+deb13-riscv64/"sifive/hifive-unmatched-a00.dtb"
  Skipping fdtdir /usr/lib/linux-image-6.12.63+deb13-riscv64/ for failure retrieving dts

Use the DEFAULT_FDT_FILE variable which has the quotes removed.

Signed-off-by: Vagrant Cascadian <vagrant@debian.org>
---
 board/sifive/unmatched/unmatched.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/sifive/unmatched/unmatched.env b/board/sifive/unmatched/unmatched.env
index 34425dc9efa..f309229481b 100644
--- a/board/sifive/unmatched/unmatched.env
+++ b/board/sifive/unmatched/unmatched.env
@@ -16,4 +16,4 @@ partitions=
     name=loader1,start=17K,size=1M,type=${type_guid_gpt_loader1};
     name=loader2,size=4MB,type=${type_guid_gpt_loader2};
     name=system,size=-,bootable,type=${type_guid_gpt_system};
-fdtfile=CONFIG_DEFAULT_FDT_FILE
+fdtfile=DEFAULT_FDT_FILE
-- 
2.47.3

