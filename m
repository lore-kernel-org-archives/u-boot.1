Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5DF606A31A
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WTY9989J;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ydzel9MV
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8631080D9D;
	Sun, 25 Oct 2026 19:31:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mht1g6Xihvjc; Sun, 25 Oct 2026 19:31:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BCB578091C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792956677;
	b=BGkaUcMRIFZsrcrE1i/HmljpRY0xkTczPr9wbnmkZ2YMgweJzHCxpiMhaiIaOaUCrmhw
	 G6oYaamk/yJkVbzXyKuGwMWcCiHEntJM2NHdQ4s2X+Tk40VU8aI7rPEhjeSzH2KSXENrI
	 J+O4ouw9O6o1R3Z9kAlPfvro/FGgyfLZgIKfzHtSsgYS2wQpDAvRcrLD99TH4k6OIME4a
	 fd/TI+WVZDqNuBsWjta54FbyFV2BZIdOiLui6iM2kksGoQoKZ7p8QKdEZORCYhaxPoRW7
	 094l6AR7NK60ifhc/wkywSD7yLCTrO4kQIhCasiQ5nKFvaZigWz0Ard6RVFK3CKgTUQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792956677;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zuWLyObgweZE12IzO6FfB/9joY7OvxWm/dubelr749g=;
	b=bRjp7Qx3+DWu/0vCycHrZcYK7RjywnIG3nJPwb3k+Bh3RivHv/sUVJ9lH4nJ4DO+wWbx
	 BaPzA1MgOaZA2t7YD6atYozH4AohyaiJ5xt7Biq3pP9Awn1YAx9Fllm28ldYGOrNreWZI
	 7Sne9KrDrG7EqkkHkRnQLDxAhYOVqTLr4hD5MxOC7ZRWtG8pnHxCnHh054nU6ruqsLq4K
	 b8ja+wT3S0+lK3LiLUF0blfr/cmJ9os8knxb8z3FqFILbBZTNlSf12l/COvharvJnHPdb
	 1vppZI2yhHAExM5pyA60KhfRf1t02L4YoYBi4OgveMPCNpqemcJEW9M+ficKY+qZwtg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792956677;
	bh=zuWLyObgweZE12IzO6FfB/9joY7OvxWm/dubelr749g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WTY9989JoODZ9nmxDaheRphXxYjVXJ/CSArCVJlDKfYI91VhCBQQe3nixurKo8Ap2
	 POeTyfXQlSM78qDgQRZbneWQ8rES5SJRrlgAs+wf+W+z2ia1D8V7hnNkTgBdd3Gyp2
	 2/dgTa1KoiE7w/8G1vsKSDXjm25Ry/kR0HYKG6TTu2/cIk74l1xyH2Fjrtc9QG4LGu
	 vcNQLpeMsnrXbLLhQSoXTF0OC+76iBf4jvPAQnoiryQhzG/cjIWG3dztFTM7EJ/SDp
	 wit+qTW/s6oZ/cJI5h779JjUkCbBdhWSW6mUUaWgPJ/PrjpF2LzaH4fwXEyIO3HsdX
	 DBrhBbbn+3Chg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCB578091C;
	Sun, 25 Oct 2026 19:31:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 05A1779F
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 19:31:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E024E405F3
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 19:31:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SxKywGV6E2mR for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 19:31:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 00C4C405EF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792956671;
 b=Xurpn7ePHO2we7qy9r7a7bYa4beg4RGuFwao12Jyrx9X+nOJSZrysn+HhoyxQY3vszum
 hcUsTUZMNImrp9iRb0Df6gWCAEBwv4LRyRj1lMTVbf5BUJSVy30qKKtprVsN9vTfp49dN
 PllvrTIzyqOGyn5eUNLX8YXwPKxAdKmLtz3dSsWmrONuXpbRc7HZlGk+obXq/VD9v2JjZ
 bD/+YEtUcU0JXSrB0+zLAZzcRd91lFYlCQCG2aTzvo9KuqnIjpDfcg5u1wfCQHIwQlo4U
 oi5MmkDzCOAN7vg1S8R9j04xC3SPPfFYmBkda0UUMzD7nDzIibnaHO6psI9XoE6hHVQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792956671;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Sender:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer;
 bh=zuWLyObgweZE12IzO6FfB/9joY7OvxWm/dubelr749g=;
 b=f9bDKawOtA99sIUeOdG4AOHlIuL4B26MlIplPpVICBf28SQdcYCgCZy9AH211bs8iya1
 7S5657pZW2TG1laAR71AT97CppVEZBKeb5SH4VwAbT/OqPD+7AWnX1i4ozOUocipi2Ft5
 v2n+81Cd4YVhOwFou89J74Ahr0KpzAx0PRtSKsYmLzG6ETgIPw1oA437lSytfPBT1Fqlo
 hRJ6quEXE39NwAZZxKk9b3Kiw+QGQqfHGFt8Mfcrq3yHfMn7SRFxIqvusrjochfAXDcUx
 ECRGN8zf1tW3naQned1LUEPOC3r4IASyo6mBWQVQul9AXnDpwbCiZBv236GljaNZJSA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Ydzel9MV; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Ydzel9MV
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 00C4C405EF
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 19:31:10 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48afcd7ba9bso1254987f8f.3
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 12:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792956668; x=1793561468;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zuWLyObgweZE12IzO6FfB/9joY7OvxWm/dubelr749g=;
 b=Ydzel9MV/vMNd1ju9Nl4Coa5PPzZG5PdNDjoVjnty7BY9bnjsYacQb/Ydc+iDwt8To
 4cClhiC+PSMBr/Yoebul7UMFpIphR+wuS0MOktbLS2n+UGeY3EcZCK97Q0WdVsAllWj/
 CP5DvvlO34VGNgm+eV42LAgFvqpmCF9ubQitRoHm1Y99iOr5oXJXP3/qF/od3g+xZpnC
 qD1ojo+Br9/xBtAeuYJ4MFnkB1zPMcBSzkz1qU5qlwam9/hIQ4egOMRRB6kmQKjU4iuw
 4h6c0zSnOXjK/r2kgwmH3g0UF9WCc4LSvWQ233m7PV5Ir2IHHXIKPcImw+oRW8KkDVIL
 bDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792956668; x=1793561468;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zuWLyObgweZE12IzO6FfB/9joY7OvxWm/dubelr749g=;
 b=0No2TYNSDlR1+jxYO15ozsV32/zvRTBBi1lvKHOJ44uducj3lJctwl7HAaek3pcqCW
 nwt2HtaqhtZkkMpbdmAwLalVeBY2/0DIqJtzY2NKzuavxofV8NoaDlRD1M7RxS6fMRud
 sj8dlaNoOH3gxJj7+7WYrvJcXVVvpLPsDJA73BnVxxf3W3UIyDJMpXAAgwucCCzH/axy
 yK8ByYr5+vXiPnbEu6fHpRQ5nnwe8gVdHEfA4zYG91bWMO0ZK0f3wJbCwmdtNF297PNP
 KsSPmW+MdNNbb3vazJSapFjWFo6UxRwE2QZwyTQsW1i0V9YeTeDuzPS9eYDjUcTt07oU
 NKcw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJ5Lb8liu+Esecb/iMrCO+AAZcRCJy6g9YBV7CobApBFdZ0ocuqvxCkiyr77bUuR76O99AoZI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYImbBWtVYaJBWShP5qMNXk65HtPijxSIbGu/iDtF61SQlU6A8fy
 ZdS9qJy1gWX9iLz5rWHs/by1o1CcrWBhYa6aOuiVYDO/P75VnRDa1JAC0uRdAw==
X-Gm-Gg: AYBFou05vw0aoDwQjF0iLHV0N01LaDSkavCAF3OWIiKt9h0k9HxfSgVmrJdZFf/fkND
 FgSMEl3v0MJM6WPV4p36yIkOGasmypRSjfpiDfzkvEL+rmQ0DtDEUdvy/rnRk0Z9QyIV6FYw3as
 aaeBaZBxLcCsyhVYQhsKti4VQ7ikDceL7Fq7ZB9K66nKS6LhcNswg4bhkFbzPJYzUg0Esdr2ogp
 0+9QLYdI3Qj8yU1zwaFBx+gSAnkN1mROZJ0NVUYaxO4KFwcCcwPnBFIC1guy6mLvAo+LEd9sBB/
 oVxpbG0M8EVEETUhmMA24wu6cZMVuSmB3BrdcaXaSwmRb+p80Mbbh/9Z5jQnIaX/gkQVZ2Y18j1
 8rmJrN+L6CN+Vm+GnPR04a3Bu3/4XJG7pVN/+FZ2feQB6cJIpxgG/L1ZNMtZHJXPN3+6gcvVZOG
 tXL0+Ai9LseSWuplWiROITMZkzrbw3NBIn6DISpAa3OfX9TbmyXz7tlzYXE1QpbaFQ1Ye86YQif
 bFc9yauuohgkSTsv6DRaZBCYhmTHI5tHJ1S0tzx6vOmLupdYK9ahEnl/uzwxQXMuUc=
X-Received: by 2002:a05:600c:4f4f:b0:4a3:5a42:b29c with SMTP id
 5b1f17b1804b1-4a35acbc00bmr89994905e9.26.1792956668530; 
 Sun, 25 Oct 2026 12:31:08 -0700 (PDT)
Received: from [127.0.1.1] ([151.51.254.197]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a0aa0bcsm176549365e9.4.2026.10.25.12.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 12:31:08 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 25 Oct 2026 20:30:50 +0100
Subject: [PATCH v2 3/4] ram: rockchip: reduce debugging code size
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-ddr-multi-v2-3-b82ff9c860ba@gmail.com>
References: <20261025-ddr-multi-v2-0-b82ff9c860ba@gmail.com>
In-Reply-To: <20261025-ddr-multi-v2-0-b82ff9c860ba@gmail.com>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Slightly optimize SDRAM driver debugging code to reduce required space
in the case of PX30 SoC TPL, allowing further code to be included such
as multiple SDRAM types support.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 drivers/ram/rockchip/sdram_common.c | 49 ++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 30 deletions(-)

diff --git a/drivers/ram/rockchip/sdram_common.c b/drivers/ram/rockchip/sdram_common.c
index b7a8fce607c..b46de5d9044 100644
--- a/drivers/ram/rockchip/sdram_common.c
+++ b/drivers/ram/rockchip/sdram_common.c
@@ -11,39 +11,34 @@
 #include <asm/arch-rockchip/sdram_common.h>
 
 #ifdef CONFIG_RAM_ROCKCHIP_DEBUG
-void sdram_print_dram_type(unsigned char dramtype)
+static const char *sdram_get_dram_type_string(unsigned char dramtype)
 {
 	switch (dramtype) {
-	case DDR3:
-		printascii("DDR3");
-		break;
-	case DDR4:
-		printascii("DDR4");
-		break;
-	case LPDDR2:
-		printascii("LPDDR2");
-		break;
-	case LPDDR3:
-		printascii("LPDDR3");
-		break;
-	case LPDDR4:
-		printascii("LPDDR4");
-		break;
-	default:
-		printascii("Unknown Device");
-		break;
+	case DDR3:	return "DDR3";
+	case DDR4:	return "DDR4";
+	case LPDDR2:	return "LPDDR2";
+	case LPDDR3:	return "LPDDR3";
+	case LPDDR4:	return "LPDDR4";
+	default:	return "Unknown Device";
 	}
 }
 
+void sdram_print_dram_type(unsigned char dramtype)
+{
+	printascii(sdram_get_dram_type_string(dramtype));
+}
+
 void sdram_print_ddr_info(struct sdram_cap_info *cap_info,
 			  struct sdram_base_params *base, u32 split)
 {
-	u64 cap;
-	u32 bg;
+	u64 cap = sdram_get_cs_cap(cap_info, 3, base->dramtype);
 
-	bg = (cap_info->dbw == 0) ? 2 : 1;
+	if (cap_info->row_3_4)
+		cap = cap * 3 / 4;
+	else if (split)
+		cap = cap / 2 + (split << 24) / 2;
 
-	sdram_print_dram_type(base->dramtype);
+	printascii(sdram_get_dram_type_string(base->dramtype));
 
 	printascii(", ");
 	printdec(base->ddr_freq);
@@ -57,7 +52,7 @@ void sdram_print_ddr_info(struct sdram_cap_info *cap_info,
 	printdec(0x1 << cap_info->bk);
 	if (base->dramtype == DDR4) {
 		printascii(" BG=");
-		printdec(1 << bg);
+		printdec(1 << ((cap_info->dbw == 0) ? 2 : 1));
 	}
 	printascii(" CS0 Row=");
 	printdec(cap_info->cs0_row);
@@ -80,12 +75,6 @@ void sdram_print_ddr_info(struct sdram_cap_info *cap_info,
 	printascii(" Die BW=");
 	printdec(8 << cap_info->dbw);
 
-	cap = sdram_get_cs_cap(cap_info, 3, base->dramtype);
-	if (cap_info->row_3_4)
-		cap = cap * 3 / 4;
-	else if (split)
-		cap = cap / 2 + (split << 24) / 2;
-
 	printascii(" Size=");
 	printdec(cap >> 20);
 	printascii("MB\n");

-- 
2.34.1

