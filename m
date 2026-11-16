Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699CC606A32A
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=y41343yr;
	dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=BnVTJcck
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4903B60666;
	Mon, 16 Nov 2026 10:28:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1lqM35vvDnJ2; Mon, 16 Nov 2026 10:28:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 964CD606AE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794824921;
	b=NQjPIa19wORa8uNaJYgJiplr7zeL8HOJIv/4h3ehzq3gkduboRMKuM3S59aU9Hzib2Eh
	 IN+zAbs2+dGkyMWW3SFBqPhMAB1B+OH1ft6GPXBocKaaj24Go3oP/XjLPu1lNPmji6Ymm
	 HAtTb5I5O/YFI3YeHfhG1heJwymtXgIzyGP5gHjCQZyykNVBnicGeSF5jhhIEotgnIZuU
	 dc7VYszGASFJOa95noe84Lhei/LYP9f5mVc5rBg+8N2qMgRnczvPjM0zXhNHBLyINN/rH
	 rsMms+B1y1g6Lmu+s2lTUOusuJoP9KEY5aSrK/CcRm5+eDqTwLaWqA3KyDzrZiEsbYw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794824921;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6H/SdWVLTsUkiWbtzINRbPL3qVq1vyz++W68xeAF35A=;
	b=nvIwlEFQ5TZSYoOtzT41dLwsvB9vTRhkv+YaufU6+RCqIkGnKsvp2QWOgEOPcfJe+0PQ
	 yzxsbV/d7GdjM6ZGn4XgPK/KpuJtAMxDhAmfuG6UOJSh5dxCPCTjcQhXwLVGzvGER2hMZ
	 sqcIueqXDZB9+mWZqdCjTRZ6jikyqWIqOmALxr3C4wldUJkim2LqV+d4T2RmS/CCY6My1
	 LMIus22Wa9/vF2VsMW9eJqGRbo0KmWHNojgxOLyzer1UZyg2nTtm1E71uv1kRDapTyXrz
	 n4IOj19uoBnZ2rrRMH0PhuDxBTb1n4GG2m0hQT5mrmPRN/5kPIYCtED474nkFelJK3g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794824921;
	bh=6H/SdWVLTsUkiWbtzINRbPL3qVq1vyz++W68xeAF35A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y41343yrJDstISHaobEMrhC73z22nsAKhQLzAs1Z9s4KGmfD80XHx60DNj7KNDhzb
	 uyrM2Cx1w+pCpGOGIoffd7McRo/XT54IJ+H29/5idJUdIstN1iInTyQQ75W+s3bQBc
	 6j4zq1JTeltSqxoSv3T3seBK4xWT/IHHgB0dI2MZvcirJEWyLltjvfqvqizUFDSXzN
	 qrNjmeW/qRCBlvJNPCetlvjuxWgaCpxwoNTQzzLgUENruZW3zZnXQFUDjczapyJKi7
	 Tqxr2SSPaXlrTmeouh/RZoAHP/CwSmz6AGLAGeQCVJCZ0HIL4fNlpFh+0CLbt5tYP9
	 xao+DFIhB63FA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 964CD606AE;
	Mon, 16 Nov 2026 10:28:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 16B964DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:28:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 050C1400FB
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:28:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id khthHVoR9EUq for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:28:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 467774009D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de
 header.a=rsa-sha256 header.s=s2025 header.b=BnVTJcck
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 467774009D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1794824861;
 bh=6H/SdWVLTsUkiWbtzINRbPL3qVq1vyz++W68xeAF35A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BnVTJcckfLFMb6j57o+HjnH2W0nadwKrroixBAMhft+yGE9CxvDkFN4UzEFMzvlcu
 tYymGVFL+f5jsico6Ln4f5nbTiMcoAp0a6cZOM/AA2jGPBV38KDI5Kx34F+UNMWxT4
 jLdozq13fSBR7+y87Bg/SoEvlmME7yQ56AcGxe/PCsxuIX0WWSVGenIf7tMkPbUlqh
 1/a8r9Z1Sr9s2rgTKVdIAXYkK8+sBcAjJjTYhd1cKrVc0H7+2tgyFjvDlKqohA2CDA
 QhMa3ksD8Bda8X+Tm2mxSmPPKC5SVnjMj7mMnNFfBcNRv8LTUcDMyrCot1UHE3zL7K
 xlO/gPYJbVWKA==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 3E499B221572;
 Mon, 16 Nov 2026 11:27:40 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: E Shattow <e@freeshell.de>
Subject: [PATCH v3 3/4] configs: spacemit: k3: enable CONFIG_BOOTSTD_FULL
Date: Mon, 16 Nov 2026 02:26:29 -0800
Message-ID: <20261116102653.36927-4-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116102653.36927-1-e@freeshell.de>
References: <20261116102653.36927-1-e@freeshell.de>
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

