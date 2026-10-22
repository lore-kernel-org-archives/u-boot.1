Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996E4606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 10:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mCkkrl6z;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=cB8yiVAy
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 769D6812B1;
	Thu, 22 Oct 2026 10:39:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RBGHb9r04zy1; Thu, 22 Oct 2026 10:39:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C799C8126B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792665592;
	b=MY+cWbiO/EmG4Gi3OQGJ7uziKFZSChB5EkbPboABGZI09Lk/DarcfQ8phMkMxP6oEzkn
	 Q8KbXFNXBqsyj6sJkYJVEMhK4dFIgeyiA6sKnQjMldAtUxVKA4v41j1kJavuItvm670iZ
	 Z8KOxONuoWY4IKrEap4TaUZBgPG/Jz4XI5ITiSr3vRa3a5Ve1UNhaj74qpdKkV0KdthVU
	 91hZw9a5CsOJ70zVzMTS6bFtFEOWOJwg9ifBtWiDkgzMwqLmdg0R5JLQLy8P50WWkpjyV
	 xXHgtDXrhk0sgckxitXkX4tomRImjt9zw/cVhzkAOEPgSXFEi1YHtsBuqwT6RqTDT6g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792665592;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bT+eddL5cA5L6Fqw2OCr4wYMQj88utQiOH1GyS/3LsE=;
	b=Hft4gmkrhnrSJhsfrfwL39/Mi0uiXxCxzWVtmD4PoMxKxwyQSktJAriiYAAlqm0tZmUV
	 ZfSPGcn7jq5spUM0aihwk13dAOBNKL7+OLv34q1ejwYKSw9odk36FHGC33IFYSEl9uDfI
	 CuUZai9IgR668zs61gQOMlIhZ/p99hW7HOmC0lFRQ7OuwaB5LG2X9lBSs1OEcRQNABJNp
	 EuzBway4ILJCowpV6htGuDoQGoUd/SBN6tjANoNZI6uPgJrSqM7YrhZZTRvnlsvrkVETb
	 WgL19iPumPgmWVug1yXQ8k1tuLX5X1BoDOZ7RdPP+QcrCWWDvGirJ7y11EDkr7iCvAQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792665591;
	bh=bT+eddL5cA5L6Fqw2OCr4wYMQj88utQiOH1GyS/3LsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mCkkrl6zjod0nD62RyW/yOWHS1Fwr8wzHsr0ALipL4qRSeEk6mBlmaukUyNomlO9y
	 W3QSkFRan0VFapC92qH/e+nxhNZM8iDX2pUc4WPyy8ihu6uikr03Z5NH9TMjmJLf22
	 76PBWEHHUTbUemIa0XwFxXsCOWHPrkL3jw0p4a+iQXwlifhvJWfbrBmbT+COTym4oK
	 3zEZ2epDjMhhcR70icU3U48O9ocexTWHjRRzKa3Wu9/WKNSab6T0uM1LKwF0XwNYLO
	 j6tHAak7yduGZts+jeRR9RZKI6I8wra/aRx1ZdYYftA2k4TTEGvOO+nYaCiuCzhcSd
	 U5ZgWM/eBAT4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C799C8126B;
	Thu, 22 Oct 2026 10:39:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 29D9B1184
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:39:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 262B440904
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:39:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id va5-j4gB0vju for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 10:39:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 86783408C4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792665588;
 b=IAjD/U+Z6uayBPx0Hm35RhZxP6uujvG0oI4wO3GzXFNQt74m1Vw8viPuBjUmA1cFDie1
 JIHoRwtAYo5xkeMPeTsMavrpXddjX/mwNPWCBLMc4OTOlkq3wd36HXRuGAeRzu7nHaq7v
 CNOwYYzMyh8Hl1yASUXZwomwo3kfaY+VGN7KgComy/4xStlpSw8h0QPoqy+7mGA/ozihc
 FuetCaZGO72E1LMkri6MinouFRns95LPn0Otx+UepqAN2SKEjq89o4dCP8Wsz/ZkohUOr
 8jReaqaVmKe6fRvZYSttT7wb+EYBMhg94OYnDcSgIPOHNSVQnW8B+Z28iYOT+w0MNeg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792665588;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=bT+eddL5cA5L6Fqw2OCr4wYMQj88utQiOH1GyS/3LsE=;
 b=oTi3pibh2TkT8Eus7a19DHSnxj8QyU4Gky0w5ZsM62CJgi99o2hlqTzgNdpPfrzWJM91
 wXMBtFH2eutGEz3krKDSBC8y+SpZ32kczcWecp9iVxiWxdsQhz1r/nacAu+uGMYnbWbZ9
 iz2Lk8MhDQIFpmqk/2+pElANLadh29XiokzFxOGn8q1jbM5A1gC6yfxOFFqY6T8h7jO7F
 a6xT8AuVL8mQubQ7aIGuJ0R9iHqwGfD+M3rINumxsXI2ttfrDpkbNWJgMa2vKqYtwEOGz
 2W6Cw5jeyce7rlTotn9O7PsWBNI7Al7rFHzX0l/6bb1eoi20kbtL/LzZS1dSlTaD9zw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=cB8yiVAy; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=cB8yiVAy
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 86783408C4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1792665575;
 bh=bT+eddL5cA5L6Fqw2OCr4wYMQj88utQiOH1GyS/3LsE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cB8yiVAykE/S1SRUyuOu+U9w2aSifq+YGlvncc1NT8AD2s+gg4coQL2ZzQtu2STKv
 nm8MlXHd7AL0ujfVp6LvqpU2X3E+SXFCfmAhKKF826G1vWjmwp1E+G6thHdINvKIGb
 ExSq1IPMSrrpgPrtFK4Kwf6lrK/v8AVLqilPFoQgvpZENJObeWXVYyCpMGcTnBPwkx
 tAMtTU6y20LGAU6OY5/25uqHB19GBAWTEW+8GimADL9chy84Y6hSjdFh7Z++zrGoQ4
 T52J0WBYA/jvBSweC4GvDVczJszEN0CtKmMea6QFJ5EVVxoQ+wIQaIEFZ94vaKsQgL
 IXZNCpTX/Kolw==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 00443B2201AF;
 Thu, 22 Oct 2026 12:39:33 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>
Cc: E Shattow <e@freeshell.de>
Subject: [PATCH v3 1/2] configs: spacemit: k3: enable spi nor flash in main app
Date: Thu, 22 Oct 2026 03:38:52 -0700
Message-ID: <20261022103907.1415045-2-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022103907.1415045-1-e@freeshell.de>
References: <20261022103907.1415045-1-e@freeshell.de>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable sf command and env storage in SPI NOR flash. SPL is not yet
upstream so this is only in the main app.

Signed-off-by: E Shattow <e@freeshell.de>
---
 configs/spacemit_k3_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/configs/spacemit_k3_defconfig b/configs/spacemit_k3_defconfig
index 586305c62322..afe3a3b42939 100644
--- a/configs/spacemit_k3_defconfig
+++ b/configs/spacemit_k3_defconfig
@@ -4,6 +4,8 @@ CONFIG_SYS_MALLOC_F_LEN=0x80000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x102300000
+CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0xa0000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="spacemit/k3-pico-itx"
 CONFIG_SYS_BOOTM_LEN=0xa000000
@@ -35,6 +37,8 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_DEVICE_TREE_INCLUDES="spacemit-k3-u-boot.dtsi"
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SYSCON=y
@@ -44,6 +48,8 @@ CONFIG_SPACEMIT_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_SPACEMIT_K1=y
 CONFIG_MISC=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_PHY_GIGE=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_SPACEMIT=y
@@ -61,4 +67,6 @@ CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SPI=y
+CONFIG_FSL_QSPI=y
 CONFIG_TIMER_EARLY=y
-- 
2.53.0

