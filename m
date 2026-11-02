Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A8E606A336
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 19:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=o2F2p5S0;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=Jur6/Q21
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B579140567;
	Mon,  2 Nov 2026 19:52:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GYyIhFo9qTG3; Mon,  2 Nov 2026 19:52:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F01F24050D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793649177;
	b=HU4nSH3sEustpsp2RD76ZtMVW+yIhXa6bg4yagbY+o/ltF8MSNb4uvILEzLWpNh4EASE
	 ne5UO0RNSdaKye/Oru4PdmxGcXVejzoBjtWFxtgGTfGpj2UQdtJmmhJmh9Wyoh2W6Ko7F
	 eI8AUYcBifD+I0BQ5JQhXNhNiU52K1oqQLxb4nYrzsBGlN68O4AXGJ8NMS4s8cWXiixFO
	 sgwDWzWX86xFlzgc3qgobpspBCMfEuEPQ5SvOJsCYibTMEMCoOYOPG7QckbRLNByfxVDR
	 5nw1LFm9+wap1+pgcTt6pAPA03GraENtmZmLKRRnhuKVfD2xx+SjtFT7Oit22OWkWVA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793649177;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6H/SdWVLTsUkiWbtzINRbPL3qVq1vyz++W68xeAF35A=;
	b=lYY6KXJ4qWk3TNdvd+U5URor+4WJcZPpcXkFzI+X1pUhNsJC5Df0e1xGNmOHPHuVo2Go
	 IMyj34PDdDItMUoXgu2EeV/yEkX4nE+WDL+Qo5FQ+noT8bMSliVX72mwaennB7TzFUR5P
	 9DoFETMqQpV5tW/CmlJwlFdYt3mRkyo+G4Pmvn5lPA7GdACuX3sLnr8MiAD2at4nLiOSo
	 MboQE1YGhTI896oVusHIKNUxFQDzFaFEtEH/yjsYNyb9o9ThHUkVfKR2ual+Odriu9s/j
	 dLELSdC6kILTrkmVdNBuoMtbKbYFfyLIq5T9PcAOtleQipqhtMTZu7khp89En4D8MoA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b="Jur6/Q21";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793649177;
	bh=6H/SdWVLTsUkiWbtzINRbPL3qVq1vyz++W68xeAF35A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o2F2p5S0dNu+wQBYfMMBx0ma6yYIKcLhbF7iZN9tzEhY4MxM9tXfV3TaoZoqJUSKZ
	 WEYhxivTOo7/qAqDBtXijfRFmbQ+6Yc8Qc6oNF7G+/HQEYLQkUVXy8tI8r1robH2NK
	 Lylhimz39SSP4ujcDn28JGeUIbTQbs96OZH6PEvRsFoIlYJIWq3+3u9PYYhxIl/7JO
	 Ox1TCKqIs7cRNqzswEFWDOyxk3pM7xceNVocqHLz46dgiA+m9mwtlXLUmOy+RrT58L
	 LRTzxSYM++cSYiKSwkVPOhoAGDER9Yd9hF2S6iFhwsZGW9LHMYRgTXR/dt5TA+JIeJ
	 +uUx2vb8iedag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F01F24050D;
	Mon,  2 Nov 2026 19:52:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 46E23120
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 19:52:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2CF4240536
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 19:52:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vrj4RxFYvAnd for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 19:52:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6EA3F40515
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793649175;
 b=s5VhG6vWwujheDEMSEW3ZpZtdEKq15ix41wBYp78UtiHhHAZ2WcT67VruTLqS9nkgMLQ
 dyMGriYcGbNwsInmF3jyggFlmy5semifruSYYcDxOmAs5qzIBlcKSeaaKrw+9UuTLml/A
 bkVlbwccqFFKYUlkrNUsaqNQoUJf2Qy4fPjzZy2YoKs6L9ynH0e0+CDhWmyImWPhXSZtG
 jA+BjJaWQsCvCCb0eH7yAzFkNjthwIt0Vt1OneSDw8gTL09ZOvjzX3xU6BfW+zOkeTtd+
 /+Yep9KTmw2VAgL0liXRP3vDeS0omKa6qo7sm65CHkOo8HKxmNHsTSG9JxFF0uhHDdQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793649175;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=6H/SdWVLTsUkiWbtzINRbPL3qVq1vyz++W68xeAF35A=;
 b=EApTatcyfg8e/c7og9gI9VD8FjUYkjUdm8xTGQn+flbW5fKWwDGcOM3Rr37okgGShsPe
 SJBIdzTEDqsHXpyjUDe4LdlzuvdJttB44lAGq+KUSG/PN7MD5zPmhJqKZyz+Sucn0gUWG
 abeZQSdooBUdrhGzQPoz6+6UcjMXovMRBRqBYBs8PPLYX+kabSAT71DV0E/BJcWrPRNpD
 y7NGhFa6Tccjorx98TwD7VxMdQc24MNASv/76SKFV9mwvHqeRwNI6TqwXm39nIfDinS3/
 421YH0Ti2r7lShlaSv6+xw0Esb141bfYA7EHQiqkp+U9QGBnqWAIBh7d4ertgeFWIIw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b="Jur6/Q21"; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de
 header.a=rsa-sha256 header.s=s2025 header.b=Jur6/Q21
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6EA3F40515
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 19:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793649111;
 bh=6H/SdWVLTsUkiWbtzINRbPL3qVq1vyz++W68xeAF35A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Jur6/Q21OnGP9AAAJsfDtb4WtAns0zxzNJTs37FCt0yNbagd8h2TPt29U9Q4fOrfQ
 SydzR97Mftk9coaNGCGYSzUj+U0v4lJ8j8QZivIbnctHvQaAyAYlrbFalKMQCEX3tH
 Uw01E+1dz1GMrj8srqsJar9aXMonwV49NHzYtCYD32KMfD//Ih3594S1dGRYk4KtQE
 T+rDVahvHReiECBujbNJZ2vAJnrkrdcjUXxwDjSmecJ21Jo3OeuKJMXTmxiy5oNp7C
 PZ0TzZg8vSmjOKHKSxO17+JKkJ8MyJdYIWJwhzZ9GRlR+5pV8ERvie6O2AkIZWcrOj
 dxbigPQMfKp5Q==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id E7D9AB22066E;
 Mon,  2 Nov 2026 20:51:49 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>
Cc: E Shattow <e@freeshell.de>
Subject: [PATCH v2 3/3] configs: spacemit: k3: enable CONFIG_BOOTSTD_FULL
Date: Mon,  2 Nov 2026 11:50:42 -0800
Message-ID: <20261102195101.103363-4-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102195101.103363-1-e@freeshell.de>
References: <20261102195101.103363-1-e@freeshell.de>
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

Define minimal env variables for boot in spacemit-k3.h with fdtfile
as the CFG_EXTRA_ENV_SETTINGS sentinel, and enable CONFIG_BOOTSTD_FULL

Signed-off-by: E Shattow <e@freeshell.de>
---
 configs/spacemit_k3_defconfig | 9 +--------
 include/configs/spacemit-k3.h | 6 ++++++
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/configs/spacemit_k3_defconfig b/configs/spacemit_k3_defconfig
index f49442951c8f..9bf582564d07 100644
--- a/configs/spacemit_k3_defconfig
+++ b/configs/spacemit_k3_defconfig
@@ -19,25 +19,18 @@ CONFIG_RISCV_SMODE=y
 CONFIG_RISCV_ISA_ZICBOM=y
 CONFIG_STACK_SIZE=0x100000
 CONFIG_FIT=y
-CONFIG_SUPPORT_RAW_INITRD=y
+CONFIG_BOOTSTD_FULL=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
 # CONFIG_BOARD_INIT is not set
-CONFIG_HUSH_PARSER=y
 CONFIG_CMD_TLV_EEPROM=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MTD=y
-CONFIG_CMD_DHCP=y
 CONFIG_CMD_DNS=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
 CONFIG_CMD_WGET=y
-CONFIG_CMD_PXE=y
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nor0=d420c000.spi"
 CONFIG_MTDPARTS_DEFAULT="d420c000.spi:128k(bootinfo),512k(fsbl),64k(env),1024k(esos),384k(opensbi),-(uboot)"
diff --git a/include/configs/spacemit-k3.h b/include/configs/spacemit-k3.h
index 9dd545e2a3b2..39d10059926e 100644
--- a/include/configs/spacemit-k3.h
+++ b/include/configs/spacemit-k3.h
@@ -6,6 +6,12 @@
 #ifndef __SPACEMIT_K3_H
 #define __SPACEMIT_K3_H
 
+#define CFG_EXTRA_ENV_SETTINGS \
+	"ramdisk_addr_r=0x130000000\0" \
+	"fdt_addr_r=0x138000000\0" \
+	"kernel_addr_r=0x140000000\0" \
+	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"
+
 #define CFG_SYS_NS16550_IER	0x40
 
 #define RISCV_SMODE_TIMER_FREQ	24000000
-- 
2.53.0

