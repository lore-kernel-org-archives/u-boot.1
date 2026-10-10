Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FD1CA9EBE
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 08:50:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF46860727;
	Sat, 10 Oct 2026 08:50:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b0FVEpcs-HRI; Sat, 10 Oct 2026 08:50:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A4D0460656
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791622228;
	b=IiZseR97HprSN8Qb/QlZo5ePHu2Zvc9LinhUN5rF1DdfFItz8u2W/zjJIpYuhmQPxkp4
	 4ZNhHaOpJll7ln12g/OEf39qi/pR1XLjh+Z80eiRaHACUY4F8CkQf/KsQk6y33VyxnbTj
	 GDE8RqjZDDozJxp3rsZSD6jf9WetZ7YJQmf4mukl0Q2Rnuf1o0XIQDO60WD6VsNZmYs+h
	 +lw4zTLo1Phes7vwYlO2vMQTZFEoJ/aEE4WKS6BRmiBzu89GhPlzavqddGd1ygOKDrrfa
	 VnCKSTUekYWrWlEY/b4F8X4fUhPU1G0lNkU4YNNvSVqoyaMLYgS3eag1aj5Ruce44Dw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791622228;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=L9H6KAndEiXJvVYnQH30QrAxrefTj2n6dbAkUwRZyyo=;
	b=kAgHtKMqw7rcnZzz6uSyQ252voj7kdC435y+6rlA4zW8hz0XyOg8sG7RYop12WMnUJpU
	 vi6hxVz+s6D4doIBkJK+xN7p+QaKN0WXUtvx80PSAMDdr3s60/9DUij/ETgkXE4zPVD7A
	 hqRz7X1/n6wavvPULaVu1iwnhG9c/MfJ10bVQf1kZpryI/nQX98ROmIo5h8z9S4/DzPUf
	 nYzt+GG0p7dGc8QLDAP7Rjkfl+K2thKCm5XQau87DNXSdDZ6iCLQf8j7RVVaPUNg9l6K5
	 vgwYTcx3WYM1XsYftjICrxMwnHvcpoAw4Xn3FxKzWDgOg63NI7Qc+CoewXtAG3i0VNA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791622228;
	bh=L9H6KAndEiXJvVYnQH30QrAxrefTj2n6dbAkUwRZyyo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=f1uLCWebsrcNDYrerEHdfrtZpZnZ2dk5b0HVIR7y3PBA2Y95yU/BI9FD4J9e6piJ8
	 C6DbfSIffnrZPu2VTt/+aIO5mFdhZTpQO8cJEdwyk51bt2j87qNWXwqxbwPWe5ovcE
	 g88B9k0OUNj+ERjYF2I6ArcukiD5p2pE+6QsHq9/ff5ZIfkZDezQ77Exk9IZVRDvCA
	 su5IQg/p9g9/y+KNBQlcz7FKEgFJKVxk2v9eiAKOhx4Iw+BTwYyLRtr1ZoYnD96ha6
	 KRQxL+M8BFTq2jUUVhf/vSgI/wD3C4EW3a4SsUTIrKHmiSMwu/enqaIgyZTbkQqAU9
	 k2O0w2rBv0nBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A4D0460656;
	Sat, 10 Oct 2026 08:50:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 56DA4380
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 08:50:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 35DBF813F1
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 08:50:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uqKkjrw0RzUh for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 08:50:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B560E81180
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791622225;
 b=llhvNCfbESANKi2zB1eixYrFnYkGTZvQ2yHR1nJWchTmfvV/gXvsVLNZqei4wM75Pdpr
 7nNV1T9ekIbPx6zGL/ui/+EiOdIEzPZBexX4SsYgxMgruN6rWX9dZoBTd+TVmTvwkstOK
 WCPbdl3jIG+kCL+WBrmVqiaX/48Agtzr+A+5N4SZIh+qlDcXx4z3MbQ16brX6yFMzc45C
 Kafg85PmB4AkkIxymWlWuusIvjOYmA1p4AGyStaXNM4cgEVhQAKaH4ERz8XNvQwJ/XqbQ
 PKGUyZud1FOFRYNQHlG7mTVpZBZqgV7lthfcFFk3aiPWA9DOr4Qeb2Bfg2HNMxXHWkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791622225;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=L9H6KAndEiXJvVYnQH30QrAxrefTj2n6dbAkUwRZyyo=;
 b=fuiVkAoPxkgSRLVfNtA3riRKqt5453CbuYYjkui5IOZq9Ilg6eS+oahq0H4C5IdscswH
 XQzvJo2YIx0+2EYqt4MMkxyEpPIuLtyA3fMg8MYjAMoAv8EUPPYf933jjalP/EDsRkqIF
 g5fbK7KiaTgKFdecPi2o8dvoWFIdgk0dwRJ4jB6AnhZPsmxKSXwlmjgcOafYPMc6C9Qll
 VsZALvPjAAmdz01alAZLGAfsA6NnTRsBXJTAtMOUL7EpzAB7JjZFl6MDu2IvN2YiCyKhy
 vqXJGnpCBBVIMmNwXm2ro0e9E/5H+QiMCnpL6ofq1f0DGuxAd4qx41zMFJN8uOwY6Iw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=mrVoH52w; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=mrVoH52w
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B560E81180
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 08:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1791622217;
 bh=L9H6KAndEiXJvVYnQH30QrAxrefTj2n6dbAkUwRZyyo=;
 h=From:To:Cc:Subject:Date:From;
 b=mrVoH52w7WFGZB6YeUrEExxCpZ0auEij1WzC18A2RpNYQ1pcpJjkne/4nemxncdO2
 PMB//7fxtlUheDrwPDcazUH43AYIWAYCzEYQTd3MiH4YF1JYmGl+iYHvLBCNNdNFAL
 +RUC8UNa8BACIlyqXyMviti8YK8RdG92KYSGnmqK7ZgkoISZDV0AZ1gxnhBKGG9JEw
 ShtVCCtHHhQufqiRYuw8KQYs1ZsZjAEH3pjzyFbqV+emi/SIcwu9t4AmcrCcXGV0Ln
 Q/exc8+F5WZ4/Q34DuJXjgqNgD3IFE+SnRWuXtpPVQ29hyGP73t4zAkPBG1g31RMJh
 37Lc8sHuHqj4g==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 8ABC5B220503;
 Sat, 10 Oct 2026 10:50:15 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Leo Liang <leo.liang@sifive.com>,
 E Shattow <e@freeshell.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH] configs: starfive: enable mtdparts on visionfive2
Date: Sat, 10 Oct 2026 01:49:31 -0700
Message-ID: <20261010084940.62326-1-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

add default mtdparts and mtdids consistent with jh7110-common.dtsi
---

This allows us to update the documentation to be slightly less likely
that the user would type the wrong offset by using mtd part names:

-    loady && sf update $loadaddr 0 $filesize
-        StarFive # loady && sf update $loadaddr 0 $filesize
+    loady && sf update $loadaddr spl
+        StarFive # loady && sf update $loadaddr spl

However that documentation update is planned for after the mtdparts
addition lands in release. It would be preferable to derive mtdparts
layout at runtime from device tree; if there is some way to do that
sensibly please offer some advice how to do so in the review. Thanks!

---
 configs/starfive_visionfive2_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 45de1c1cb671..2bc39593849f 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -78,6 +78,9 @@ CONFIG_CMD_WDT=y
 CONFIG_CMD_WGET=y
 CONFIG_WGET_HTTPS=y
 CONFIG_CMD_BOOTSTAGE=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_MTDIDS_DEFAULT="nor0=spi0.0"
+CONFIG_MTDPARTS_DEFAULT="spi0.0:960k(spl),64k(uboot-env),-(uboot)"
 CONFIG_OF_BOARD=y
 CONFIG_DEVICE_TREE_INCLUDES="starfive-visionfive2-u-boot.dtsi"
 CONFIG_OF_LIST="starfive/jh7110-deepcomputing-fml13v01 starfive/jh7110-milkv-mars starfive/jh7110-milkv-marscm-emmc starfive/jh7110-milkv-marscm-lite starfive/jh7110-orangepi-rv starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b starfive/jh7110-starfive-visionfive-2-lite starfive/jh7110-starfive-visionfive-2-lite-emmc"
@@ -107,6 +110,7 @@ CONFIG_SPI_FLASH_EON=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_ISSI=y
 CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_MTD=y
 CONFIG_DM_MDIO=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_DWC_ETH_QOS=y

base-commit: 837387a5aebc5cd53b9143926891cec024fcad3e
-- 
2.53.0

