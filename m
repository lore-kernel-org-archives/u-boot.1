Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79359606A31B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SIa+anw/;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=Zs2s51JE
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5309860AA1;
	Wed, 21 Oct 2026 16:51:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0DBZxovu2JvW; Wed, 21 Oct 2026 16:51:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 989F3608E9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792601474;
	b=n9Vi44LeA6AC159Po2EHw87XVF0/TsgVKnH1KiDLowWxLbcWDgD5P1RNy0Br3lwlxu00
	 7SqIVyRQ+wtGFfV5rrTlttp2mLsLlWkLzh2dZcChQOica8meIIwKy0nUQQhsCeuv4s5Nq
	 IzCZlRQEoKz38P2hakb+RimZCSnTy80CJ4JEji7b8sbMHLZwwE1wCXIXGr6h8J4lNsxrj
	 qqlz1L2LwRm9yczGO2BbDDZoGrTz2A9wZnWMtrPKgJQ2jDJ/z72I2K4b1V65kXxQMIHzG
	 s5kb4+fG7ztdVHuPygb5kVi1RokrUq58njxEn1wi4ki6fOI1gAjxn/b71aW/lTMQtBA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792601474;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0FWJv0KgzH34FyDInZ8S78tjnONGz3ciWixVQ4bq26k=;
	b=oRhI6joEY3mJ2HpetuB/sw5wNIFPCI+kX0eBOZWLdLmTg7hXOHBZoUaL1ESEWJ1P0PVR
	 OJkzEsLa8Ywb4PPygskXtalB5Mf1I+vThsMvufwlsQQrWPMbxd2mUqKey4Ilh7BHW3dm/
	 /C4R7DJX2+LtMeGOf0F9o92dhsv8yNG2CTkT/5fWqpoZNfx3G87ZBsyuGK/HAS7MQhx/G
	 HWsfM4RQN8IEy5Ki9SOc4gDLoQnbu+BRB+jDoAmNywkVanAeZY4IUjAAQ9pfy3y73n4hr
	 0G6McwJ8d4o88yuwvNnBl+bPYR3WS2/qCcavXtWfpI82RQhEWAoC+LttFEE9XW8Rwjw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=Zs2s51JE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792601474;
	bh=0FWJv0KgzH34FyDInZ8S78tjnONGz3ciWixVQ4bq26k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SIa+anw/4kHqTMqT7Z5l5tNldXcJARRzaVo5Ie9C/JZXx8u+NCaFQzyMROkSjETJZ
	 9I8ThnvP7254fN6sgLTpqdbW49omv99s9gb7Frc/1eqEJ4HPHSlfuDxrLRW9HF/64L
	 Dj7d2Ej5WQiICknlVG5w7prOb5bTiKs4IFShyxbx2CwG3TZjxYthiNArJW6OJsgEgH
	 IORysZtqS+nk/RpIt4cJpUIEi70QbbmAqOiySh/inIxX8EXNgMNN+NHZpEfs9gwNq/
	 vrnUpH85CvVRXtifD/g0OG3Jg2qbYMR+OyBBP3CNICbDdL1la4dLbEgi0ddkZSrK0o
	 nS/FL1XR9B9vg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 989F3608E9;
	Wed, 21 Oct 2026 16:51:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BD73595C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:51:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AD21B608E9
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:51:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 36mTMQPj0pBF for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:51:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E99E660A62
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792601472;
 b=BHXdrxvvWw7YmtQFz/pc9+9md/n1GPQIXSc0B9ELHFJRnY5L9g5cpqdc0PMxWX2MP94l
 IV1TTnC+hLNomwyAMoGd+hpSVsvns+tVS2451d+fWAstYkXIvl+djUGXUPgs4gUQat89y
 9eHYm9d+ZPJG0J0XQIArYw3CX8mvFh7qhwkP7uofDFvM6jJ4bP/b1W53HaUj9V7YuFWAu
 /6l9cWmeEgTGl2VRCtt7ELpWnFno38VKXqNCZ52DyqTNk5MX4FtutiWtleauTPbURbwc0
 A8wmP7/Hg3cOQXnlAR2DzvgbhZFHd7o0ez6ks/0OlhwK+FnkNImbQbbiv0VEn7ZWP4A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792601472;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=0FWJv0KgzH34FyDInZ8S78tjnONGz3ciWixVQ4bq26k=;
 b=eLKmCdUzPCDaeHsPzky9ZZsQI792M94/HG+rsBlrVtlx8IkmIT/F2SRe+A6yrvZXkWH8
 nLpUtK59Sk4niTzBRhq9F/r6bZ3UFDoSJaRNGo4ewpqwyC0dqTV7t6HvjnTHXJ5QPfjMn
 7RafEeNaA2Y2L3kEA8HkOJedscwuXnPF3tHSJsAWzQn04xiwjwcWDHHf6qV59F2cq/Ola
 LdheGu3tHmtrOqk2Dja+wfAV60ySG7xKA1pss0AGq1xa615eUGtXM8rrScu644GU2Buhv
 /djXN6UJ3LBUrVhN9Xv0sx1wxjfZY8D/3qrNeG+XDDPJNB+bZnZa+iqiVfsaJKlrPGA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=Zs2s51JE; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=Zs2s51JE
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E99E660A62
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1792601449;
 bh=0FWJv0KgzH34FyDInZ8S78tjnONGz3ciWixVQ4bq26k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Zs2s51JEIpy6/7SJY0G717f0Sw75waXamE0lIQr3TBObxtQFY4F0PKQmEEXMXSE/A
 AM3FrfXm9pGRnFX+zxXt9CO1z1rbtvRdMKkvhp/mYSeWhkp7xmkQlkjD4m6m4viki3
 oFl+57nnrZ3TYUIauM3lBSAPMSzW74vfeQkw2BluqADTmmHxvx6uIa183VtKCWFgOU
 vTJnChSbabtyl0hiIpeebk1Mhb8k5p5yPhG0l8yVpf5kc1yegyv/M/KnaKvWgfDKi+
 Xmq1fbyMIWbrczR1/Mr2BiefKqYHlwU/3UJHnsETuxPc2XWHmXDS2U53hXmTE9NdVJ
 JAI12aZGzRBbA==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 7125DB22189A;
 Wed, 21 Oct 2026 18:50:48 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>
Cc: E Shattow <e@freeshell.de>
Subject: [PATCH v2 2/2] configs: spacemit: k3: enable mtdparts in main app
Date: Wed, 21 Oct 2026 09:50:02 -0700
Message-ID: <20261021165016.1395485-3-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021165016.1395485-1-e@freeshell.de>
References: <20261021165016.1395485-1-e@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

add default mtdparts and mtdids consistent with k3-pico-itx.dts

Signed-off-by: E Shattow <e@freeshell.de>
---
 configs/spacemit_k3_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/spacemit_k3_defconfig b/configs/spacemit_k3_defconfig
index afe3a3b42939..2be660820ab8 100644
--- a/configs/spacemit_k3_defconfig
+++ b/configs/spacemit_k3_defconfig
@@ -26,6 +26,7 @@ CONFIG_SYS_PBSIZE=276
 CONFIG_HUSH_PARSER=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
+CONFIG_CMD_MTD=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_DNS=y
 CONFIG_CMD_MII=y
@@ -36,6 +37,9 @@ CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_MTDIDS_DEFAULT="nor0=spi0.0"
+CONFIG_MTDPARTS_DEFAULT="spi0.0:128k(bootinfo),512k(fsbl),64k(env),1024k(esos),384k(opensbi),-(uboot)"
 CONFIG_DEVICE_TREE_INCLUDES="spacemit-k3-u-boot.dtsi"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
@@ -50,6 +54,7 @@ CONFIG_SYS_I2C_SPACEMIT_K1=y
 CONFIG_MISC=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_MTD=y
 CONFIG_PHY_GIGE=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_SPACEMIT=y
-- 
2.53.0

