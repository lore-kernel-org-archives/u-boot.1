Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECDD606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Mf/quR4n;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=Lqt8pe/1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1167081109;
	Wed, 28 Oct 2026 18:47:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nKcL8MuAfwrN; Wed, 28 Oct 2026 18:47:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 58B9D81329
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793213229;
	b=HtNYOXu49l15muj7XZmneQ2XjhXdd+8XMHB3bBRp3SdDp/dMUPmytDhFlhaUyhR/P5n3
	 wSaOWbCTqoI97Qjrk6JDK/nNq+QLy9bvLDL0RkpVnMbLb4A+8pi2xA3R2TEgpSbQ4fS8x
	 rcUKQOVAlsas8becBJstl5MFUhtzh+nVlKqYDPx7lFgncTQ6R+QtrhtlaMszSGprHQ6mL
	 nQOEwhbIxX9ye19ICVU82ZzKDR4MyhJENTGy09tDn+9qZrK4EEECozOmTvsArhYGUzOIk
	 aGabV5IDd94PUo62YTjbGgEbxrfjxPxClyEaicCjckshxC9fIh8zeC9m2zd+m8IGfig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793213229;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6H/SdWVLTsUkiWbtzINRbPL3qVq1vyz++W68xeAF35A=;
	b=N4ikFB9JZXkPjOJDVDgoJSwWDjCyVE8flOx6l/y+8XxuD3u3IvSNZTy43VtN268jnnZi
	 jFPmqn3H+KhGdlc0SUcgQLa2rVsADwvT2PDsbTBMXWWA1ZpCV/Gc75HNMtM5zFmqB1m1r
	 PuOOrh8GELWF4vxd/5NMzlv2rg0dNW5LsDG7OrLqYieOL0yvHwQBGYzLfjAyksALmgF0Z
	 0nUtBoTVsASiuwtFPM84lDUL1iNffTvqOVLPkKakm8xhMMyVQkZHC6ngwtN41EZlLRTXi
	 ZIh09T2mWPOlbPQS+2rkogHFPh9jq0YPT1QDkSRNzJqn3XmZEmdGOAA0jWzT/yMSgPg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b="Lqt8pe/1";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793213229;
	bh=6H/SdWVLTsUkiWbtzINRbPL3qVq1vyz++W68xeAF35A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mf/quR4nHRDUHEaqzTBjmznohJ1Ok8YhRwvf2lcYdka2zUS3K7BZmV8p+PMQN14cM
	 uYkhdYW67zH1uM1t2IJVojhOGOcfb0JaM4H50sLwQxN2IW68qzsmSZ0RsduDTrAEe4
	 8fXdyXePmkkPrWrlfE/hKorOqy2DzDkDqtSJTi+bCw++ADroLyj1JFNvOgCn+HInvU
	 MjGQfxQ0o95kxuzVSQRqX3HlK0qIDyFNvie01StILHEyfLk1Q0S7/ZV2DjHsR9yIjO
	 DBl8uPFQ454ZcHiEVfhCFNadmYlyOHhXi0d2n+tOtQBbIwxEbTF9CEMgreXP9c+1oI
	 +7IOZEulDrm0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58B9D81329;
	Wed, 28 Oct 2026 18:47:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2478F362
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:47:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 095DC81109
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:47:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YLscHAy6CK04 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 18:47:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2F9A581329
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793213226;
 b=YWM3SO7KaNb8Ulu+os0BfXc3tvq5GN9EOV3LSDO9DzQ/koB5TE6tDzKmEqfEZFmVTQ9N
 fGnZNM9zI7igDbm60Fs31L3OFRKBXt6dNEUD27shhPOzfSYiTTkvPgCt9PNQJZ9vz0EmJ
 v+zLcZ0NHKgKk3+YZJU4jCrTVMCJL/6hWEwZElTFX0BxNJV3TrLV4zda++52x3NN/NY55
 BbxMW1NSuSWbGn1DEDr88OjfPP2zU+jvvTjDEd1DYn/NGeJs4ctjHfdc1LK/9U7s9DbeP
 QwRNrJnrFlWqgWo8fLPMq6IPo3VrwRu8YkCnwlnweBy/3ykLQHJ9HGIMP7RBHNZxYdw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793213226;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=6H/SdWVLTsUkiWbtzINRbPL3qVq1vyz++W68xeAF35A=;
 b=QWHNBCC/vtvdA84oitBLy6EkAn0dp45e6GI5TfGsrJd7NL4+YPr/WFcO5MNTjs8N+vE2
 tiU1ro1x3cZm2NFtFJctfj+l1SA01E7eIU8+dtcWbOTa+rbcJuiYao4txabVncIArYL0g
 1TS1kOAhT4x5vPbQVNcjA43aP1sSwlVMClguljQ4hcIT/9tAzh1B9pdp68UILgc5C46M0
 r3gLRfNexCTBnQOZ0N7xpgr7Ct4wCj8rYapSgC/bcl4vBCVTYndbnqnuBxyDm9lUHnohZ
 4xte3s3tt6x1AIK3Yqp9+VA14DibkiIhHT5bebLhFr62t9WA9Dne7hb843p6FY+vARw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b="Lqt8pe/1"; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de
 header.a=rsa-sha256 header.s=s2025 header.b=Lqt8pe/1
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2F9A581329
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793213170;
 bh=6H/SdWVLTsUkiWbtzINRbPL3qVq1vyz++W68xeAF35A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Lqt8pe/1a2l9WiSRmgobLqLqbD8Tr62n5ddamcij7wy/a6TLfH88CSdiCXBE/e4dT
 b9m2Ou4XyWSKXid72xRiVU3ol2lL2br7sMiWHucv7vcS2O1p3IA83I6pjnMjtbDctO
 E1hpIWiTq/T1RqTrVIEr/lxhhZj3f2KZohEyFVx9mGdWeQz15K+IRKPmhCYVRU1+db
 7oJg4UDWQ3VHQu/lvdrHlmHsLb6e9GG5R3SDVC/TKYvmNuyTeWjrfvI21YXEorqhxB
 yvYe2SM8R3zRHPANco16uHRvu49c57lhXRCUubO2/0jL+WZPt7k36wd056THreb2jt
 Lb1pZnrFkOi0w==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 1E048B22050E;
 Wed, 28 Oct 2026 19:46:08 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>
Cc: E Shattow <e@freeshell.de>
Subject: [PATCH v1 3/3] configs: spacemit: k3: enable CONFIG_BOOTSTD_FULL
Date: Wed, 28 Oct 2026 11:45:07 -0700
Message-ID: <20261028184526.1887640-4-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028184526.1887640-1-e@freeshell.de>
References: <20261028184526.1887640-1-e@freeshell.de>
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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

