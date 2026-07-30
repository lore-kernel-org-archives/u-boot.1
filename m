Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812CFC5516D
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 20:24:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 256EC40DA7;
	Thu, 30 Jul 2026 20:24:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x9bQQs_8SArd; Thu, 30 Jul 2026 20:24:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BF25840D31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785443094;
	bh=dBCBQKWOOAL11tn5LBk2V8fMVK+7V/XwW22PTfPcVqo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PA+es6bykF+v0qfRdArYiZS2MORwfAtGnbPwHg7Z0hcFATKR3CGsz+E7pSFjqvl2C
	 9Xt91R9wvXvphu31b3YpygcUsP3/qzfdh6ySmLc7A4vFKMYiKXQANez235+GPM4YNZ
	 fyV4geyif60AGB0MDmyjONkAG8AOd9nkPrUT2Ku9uBbBURvT3rO2iYI2pd9AVwQcb/
	 axciFlG+P3lKreIXUAVKjkoB3x4OtArMmQHKyNjAr9XkPLVXUHe5NVOWzJ+itOrgdX
	 HRGiR/Ys+NazeSmpYhSpMjYkxfmA/xmNoH33NdEoiogNQ0BNljJhj57u6dv35/9O/U
	 PFYfcyrI+/eVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF25840D31;
	Thu, 30 Jul 2026 20:24:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D5CE197
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 19:38:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6AAE340349
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 19:38:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Kq6JHOgMNyb for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 19:38:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=elliotjb@elliotjb.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0784740094
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0784740094
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0784740094
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 19:38:37 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id C885084A0A; Thu, 30 Jul 2026 21:38:35 +0200 (CEST)
Received: from MTA-12-4.privateemail.com (mta-12-4.privateemail.com
 [198.54.127.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B786E849BC
 for <u-boot@lists.denx.de>; Thu, 30 Jul 2026 21:38:33 +0200 (CEST)
Received: from mail.privateemail.com (K8S-PROD-WORKER-15 [77.233.63.4])
 by mta-12.privateemail.com (Postfix) with ESMTPA id 4h9zyX69Yrz3hhTW;
 Thu, 30 Jul 2026 15:38:27 -0400 (EDT)
From: Elliot Berman <elliotjb@elliotjb.com>
Date: Thu, 30 Jul 2026 12:37:47 -0700
Subject: [PATCH 3/3] x86: emulation: enable cfi flash drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-qemu-x86-pflash-v1-3-fb403348e29b@elliotjb.com>
References: <20260730-qemu-x86-pflash-v1-0-fb403348e29b@elliotjb.com>
In-Reply-To: <20260730-qemu-x86-pflash-v1-0-fb403348e29b@elliotjb.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Elliot Berman <elliotjb@elliotjb.com>
X-Mailer: b4 0.15.2
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 30 Jul 2026 20:24:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=elliotjb.com; s=default; t=1785440312;
 bh=p4bJ05kKz6JvjmcoU3Kuv3nM5Xf7IwfuvimuNw33ovk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=sssyYzjnP7onhrNGyA79HgxKnAb+9STkxkw4dszSwuJ32ykaAtTIxeYWKPOkJwRWn
 4vCnMmK4oATaHPTcaMu5oWFjYR0mIYQfOpmKbBzlarWgD1Avagm/OL1uM15n2T1yDw
 XUj0CX8+TTc4D6cJWKz6IcGnuhBu4gcyXCx6QoWbIhAIXmZs1kn5O1/XxFxPF6sPdM
 gyk+HyhvpfJ2a5tU5MhS7eYZUHngDc7atCPEorrcdGWlIp2UdiLUV1p11CA8ojSBlh
 R5qcCval1uoJ9F2USibN1wKD9wTwHkg2TQKYLdR+6Rbr7Cw37gOSxckvOunQ+LlYfr
 c+Uf1HIqbtA/g==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=elliotjb.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=elliotjb.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=elliotjb.com header.i=@elliotjb.com header.a=rsa-sha256
 header.s=default header.b=sssyYzjn
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=elliotjb.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=elliotjb@elliotjb.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=elliotjb.com header.i=@elliotjb.com header.b="sssyYzjn";
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

Enable MTD/CFI so the pflash node just added for qemu-x86/qemu-x86_64
can be probed, matching the flash config qemu_arm64_defconfig.

Signed-off-by: Elliot Berman <elliotjb@elliotjb.com>
---
 configs/qemu-x86_64_defconfig | 13 +++++++++++++
 configs/qemu-x86_defconfig    | 13 +++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index da3e9e7b423..d01fc5f5327 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -48,7 +48,9 @@ CONFIG_CMD_CPU=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_MEM_SEARCH=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_IDE=y
+CONFIG_CMD_MTD=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_CAT=y
@@ -58,6 +60,7 @@ CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_MTDPARTS=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_INTERFACE="virtio"
@@ -76,6 +79,16 @@ CONFIG_ATAPI=y
 CONFIG_LBA48=y
 CONFIG_SYS_64BIT_LBA=y
 CONFIG_CPU=y
+CONFIG_DFU_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_NOR_FLASH=y
+CONFIG_CFI_FLASH=y
+CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
+CONFIG_FLASH_CFI_MTD=y
+CONFIG_SYS_FLASH_CFI=y
+CONFIG_SYS_MAX_FLASH_SECT=1024
+CONFIG_SYS_MAX_FLASH_BANKS=2
+CONFIG_SYS_MAX_FLASH_BANKS_DETECT=y
 CONFIG_NVME_PCI=y
 CONFIG_SPL_PCI_PNP=y
 CONFIG_SPL_DM_RTC=y
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index dd0056ed4d0..7267af66a02 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -29,7 +29,9 @@ CONFIG_CMD_CPU=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_MEM_SEARCH=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_IDE=y
+CONFIG_CMD_MTD=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_CAT=y
@@ -39,6 +41,7 @@ CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_MTDPARTS=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FAT=y
@@ -58,6 +61,16 @@ CONFIG_ATAPI=y
 CONFIG_LBA48=y
 CONFIG_SYS_64BIT_LBA=y
 CONFIG_CPU=y
+CONFIG_DFU_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_NOR_FLASH=y
+CONFIG_CFI_FLASH=y
+CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
+CONFIG_FLASH_CFI_MTD=y
+CONFIG_SYS_FLASH_CFI=y
+CONFIG_SYS_MAX_FLASH_SECT=1024
+CONFIG_SYS_MAX_FLASH_BANKS=2
+CONFIG_SYS_MAX_FLASH_BANKS_DETECT=y
 CONFIG_NVME_PCI=y
 CONFIG_SYS_NS16550_PORT_MAPPED=y
 CONFIG_SPI=y

-- 
2.54.0

