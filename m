Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88018C982D2
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 17:20:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 501A98114D;
	Thu, 17 Sep 2026 17:20:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ud1X_RKIgdtA; Thu, 17 Sep 2026 17:20:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2EFA981125
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789665626;
	b=lQ4ZbxXPr6zAYEposwcRV7hdcgSCE2rKzg92tCE9U81LFvWlvN9PzUnnd2RPdB9rAXLu
	 EvUQkNgA9aHtNK2Inrrx7FEGiA/VPxjvgefp5bFRZJbshO77mT0Pk5C6zEi6RfkR4MEEk
	 hN7++dXDbaC8NK4/HwbwjJXGcFEJqmLDkIYoyDk8NajAAWSVo6O9aO5oH/TSWAXKD2nXY
	 AB9J81I/Q67CmG8azfO8WUvcHgCtwdDmPo2UUFb+62DXHdcayy+xeB2If8K5h9/6176CP
	 4PFiAcFPlUTNtTM5iBHRP9KQPzxkuvyd4Cv1/HF1yCiy3g7Zti1B/wNoRvAWly+lpGw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789665626;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mT98R5tlkpl2RSLyaLYoJxl+h/FHpxi4TdDrDM1NfeY=;
	b=thoiKxqwMOxOgyxWVIb4/YpnP6fXkAUFDm72g/7TzsjQ3oCyunReDukMOpyZONhQPmw0
	 hmBxuXGDtx60R9do+Qy1Nj82f/ib6n3gJiy9FqOGkdP4q8oLm4D7UPdHnshReLw75lxO9
	 t4EPLF6tiN9f/BrLkCUn7MHcMrZFSPxgqh0oQMwEoS20o/MpFdSEEnKgN7YRO1Ovc/9rw
	 JxnmxBs5yQjx4pG8Ck/gA6UEBKlF1Fc9r+cz6vR5xuQWu1FxHPOehc4POSHxlgsN0q95/
	 1sDveoTfEKu1FjWxGGX9DYoxUIgCxh3mAw4wSwTUmByoiuIoRrRtD0zv8tW5CijgEZQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789665626;
	bh=mT98R5tlkpl2RSLyaLYoJxl+h/FHpxi4TdDrDM1NfeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Iwsm1YUwbR5fx9PXnTE7x+/WTvnkdM2zYph4D/6/g0X2UlFVc5KVan2qNfEy5Mhy3
	 F1qUDjg5VI31gXHRIUifJ5I1EcV31iSWYMwYkHmJaZMnZLK2DTfrnir/MfcimUd1Mj
	 TDVcLBmrmlsfZrLvhoJw9QNmJYH9h9d3uhuMPUgS1YtWHawt+pmRSoc03yJTDYtaTO
	 5uzhXxzPRekdG8MIqL0h5MOjd58H/Belj1C59VVm6ecU5y+OPLIIuFhCF4+EPovx3H
	 UEelk1XFF5eb/LDSfs/iTTHQUPPIZJEKqZ8h2qQMYeYIbBsSEfJX5ZGw02UtTzIH6f
	 VkxugBsWNMEpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2EFA981125;
	Thu, 17 Sep 2026 17:20:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 51F663AF
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 37C5360B2D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OA0NweW10su7 for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 17:19:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 833FA60B58
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789665556;
 b=GbA3btrVAQ+T5Lat2/Of/nH2I5ZOT1RwQfKGmuSjTFSiAKoR2W3boziwxHwy0OCyB7q3
 ktkfK0qoQfZYYDBKZWjp4250nvlqCqokJGfhQx3uYvXpzCHChOT6I1zScDJ8wYo4KOSB1
 8JX6PN0w54Fl689RjiiXpGKjn5rbgj0QByXAplR4cUTWZkFhQXqbiLgOYiYwookI4LMMz
 vaxLYReLN/XckHGuAxWq3hOYPCTdtp4YuEy3WsIZYZ98zgejEKYbjIoE/PWY9cBv8Gx64
 soJnLEUpk2BwJYKgfkZ0pXQGxcU7gNhV9XPbfRkwfwiA5eB7Ld07p44Ih6gOrgb6H4Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789665556;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=mT98R5tlkpl2RSLyaLYoJxl+h/FHpxi4TdDrDM1NfeY=;
 b=Y0jv+GFuPdK4C5BYvsSMAzHAgcI50GLST+2WQ3eQAJuojrmq9MbIOlql6VHbAXE1rYJq
 kK/qUYb3weCaCBcbIlIVwPEq2oLKI6BB1n10AWolQh45jX4nGOKjnFqrQP0fL17ZXsv0U
 6RZIH80pOvTVp8VX5B5M1qXBU0/yG3nD87WTvma6GLpAG82yvzqUq2GD/aq28UNV5DNv9
 rRPANxITMLYCuUFlhwWVXRrUj2wZnBhl4YM+zWkXvS91GNKLjfn0sr+B2dTNbsFKb88ru
 r0i3sMCLOFEZaAXAHEEKI0Qq/8K3miZ1/SWDQLWK5G+orbQbnczFx1MueWgtp8zhlTg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=jqrdpYJD; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=jqrdpYJD
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 833FA60B58
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A8691596;
 Thu, 17 Sep 2026 10:19:12 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EC253F7B4;
 Thu, 17 Sep 2026 10:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789665555; bh=aM10VLhpXNM8/G86USgFPpTFy72Mx+4yKmnh8XdfccA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jqrdpYJDNiT5hl9jARrZw8/z7DP05CjmOHmYzlNis+B29udH5rE1T3oLPhBGFmWmP
 LzJUo1WGxICOTs+eCIaD751ek3ouTLym3xHPbv8KaKyzvAE0v9jAuQz/1LHroseyML
 dViLhgqsvhkmMMHo26yi/Hu/0VhxvO5KWGgkPWJ4=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
Subject: [PATCH v6 23/24] fwu_arm_psa: corstone1000: Set Boot0001 for on-disk
 FWU
Date: Thu, 17 Sep 2026 18:18:09 +0100
Message-ID: <20260917171810.4122899-24-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
References: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 17:19:43 +0000
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

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Set Boot0001 to point to the ESP partition path

On-disk FWU requires setting the boot option to where the
EFI System Partition (ESP) is so U-Boot's capsule driver
can detect the ESP partition and start the FWU.

Corstone-1000 supports on-disk FWU on FVP.
The ESP partition is at mmc 1:1 and is accessible with boot option 1.

To avoid setting manually Boot0001 at factory level, Boot0001 is
set in the bootcmd. So, before starting the on-disk FWU, the bootcmd
will be executed and Boot0001 will be set automatically.

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
---
 board/armltd/corstone1000/corstone1000.env | 8 ++++++++
 configs/corstone1000_defconfig             | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/board/armltd/corstone1000/corstone1000.env b/board/armltd/corstone1000/corstone1000.env
index ee318b1b1c3..fc55d160e7d 100644
--- a/board/armltd/corstone1000/corstone1000.env
+++ b/board/armltd/corstone1000/corstone1000.env
@@ -1,5 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 
+/*
+ * Copyright 2023, 2025-2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ */
+
 usb_pgood_delay=250
 boot_bank_flag=0x08005006
 kernel_addr_r=0x88200000
+prepare_ondisk_fwu=
+	if mmc dev 1; then
+		efidebug boot add -B 1 OnDiskFWU mmc 1:1 / ;
+	fi;
diff --git a/configs/corstone1000_defconfig b/configs/corstone1000_defconfig
index ef45d42f50e..931e82a0813 100644
--- a/configs/corstone1000_defconfig
+++ b/configs/corstone1000_defconfig
@@ -26,7 +26,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyAMA0 loglevel=9 ip=dhcp earlyprintk"
-CONFIG_BOOTCOMMAND="echo Loading kernel from $kernel_addr to memory ... ; unzip $kernel_addr 0x90000000; loadm 0x90000000 $kernel_addr_r $filesize; usb start; usb reset; run distro_bootcmd; bootefi $kernel_addr_r $fdtcontroladdr;"
+CONFIG_BOOTCOMMAND="echo Loading kernel from $kernel_addr to memory ... ; unzip $kernel_addr 0x90000000; loadm 0x90000000 $kernel_addr_r $filesize; usb start; usb reset; run prepare_ondisk_fwu ; run distro_bootcmd; bootefi $kernel_addr_r $fdtcontroladdr;"
 CONFIG_CONSOLE_RECORD=y
 CONFIG_SYS_CBSIZE=512
 CONFIG_LOGLEVEL=7
-- 
2.43.0

