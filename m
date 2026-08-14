Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDBCC5DF67
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 11:21:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A638810E0;
	Fri, 14 Aug 2026 11:21:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4cDAd6yoAzyS; Fri, 14 Aug 2026 11:21:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C6DBD811B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786706496;
	bh=1OhgzFEVze+jII0D/0v+X890JS1+yZPhDe5DZ1pA1SI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IKe7T8oovjlc2kSFOPa4Ez9GDnV8BXCESTosJYk5qk6VhYHb7QXBj0CN+cff56m5g
	 SQB7zHfBbBCndQpTg6ne1giKUwuMYbw5tvDQGDIahKHJZkBZQPytqkyPhf6DVlOH89
	 m/ST++4PIqaeOP6a1FS2m3uXN4I62Y9wZfWJq2ofUYNkwv/LO5/wAQvP2QfeA3YDq6
	 FTlnP75maWf/C0o13iXKlWDYJBIPqTIVgSl7eRmd72me2A1jWYt2GeV32wM2AyrKhQ
	 8nutyTrA0l+WrcDKlDYg/+pJ/Nkfgerro4PSvytO7jzQyaqTjY1S0r5U2GutgqCdcn
	 zc0AsXg6gv4Eg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6DBD811B2;
	Fri, 14 Aug 2026 11:21:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D864B139C
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:21:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ABA1181118
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:21:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3Sx20ah__9AX for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 11:21:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=fra.schnyder@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6444781108
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6444781108
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Mw3G5cpO
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6444781108
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:21:28 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4954f5e8020so4908215e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 04:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786706486; x=1787311286;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1OhgzFEVze+jII0D/0v+X890JS1+yZPhDe5DZ1pA1SI=;
 b=Mw3G5cpO7NrW5HjnXNkW/TimRmttKWIp9AkhWTIEYDIedzFSO96cHurZ55S1efMSOp
 z5zeqcTiscB0tTCeTemcC9/QTk6z41bQcpnZE/Qdj19v8I8igi2CphNcP2rCqDud4Uoa
 tNRTDRjHDLKVIk0UmZajV6i6Y5BuRgMewvHYw2w/FmLL1ZUKTmP2KtYnBtHetL4t9JQy
 aTFt257ArWNJuoxpZBrk1U2oOnf5L6hg/Gx/EkR4Xpw0uuePYZy9adnQ7N/LXTe/7Tcw
 ulv60nPFDGqVQVMEntp1SBxwSgjxMW9km82pMIAdDISOi8HFcvFMUealqg1OFLRLi9oB
 9Avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786706486; x=1787311286;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1OhgzFEVze+jII0D/0v+X890JS1+yZPhDe5DZ1pA1SI=;
 b=NWiyRqF2dIUkgwObihQUvu16v7PwdidryZiM0xF995OLOBXddkKnlib7FMnkB9G50h
 u5w9Zfkq3/uXdnSvDi2WUHFj9J8frhEWHHm7VZ2Syzz4bza79J4UYPRQtfLSfJyxqge2
 axwso+IIbsexXH/ZUMrITu5V8DZ7yQcuu856ICLOUsj+fw196HuE5IfKidvcf1k7Niz2
 kJlMddpoizzts0AwjCK1YLElXRbmuq8cLeEdK1v1ggmBWgANVyGZNJ45kztAziqwemh4
 fj2N4+kiS0WrFtajxs1kVepEeMNDtdpUPb070u5LSZ97jTdj35VkpUdbpEJrel+B2yoR
 kNkA==
X-Gm-Message-State: AOJu0YwWzkYg3uJJ598QLrgNMZL9KWTWDryLMe7kFOKNjERwL1njmBZa
 YSFzu+ar1C/rHfH2v4OMlblbvRcuv6qXh3OR+ozq+tqR4++73+HM3YW2
X-Gm-Gg: AR+sD10bVKFeHJXvTkWW8iBW5AI0GmBwk9qvwyoshJuhm8/KjrQbB3ciznMPZornwrk
 ZbzRW4Sed2G12KilSVgXsr2XG4ddTQDlLE87h1/WPXzyx096jgLOfswMEW2/yRoN3cxYwzdhgdK
 sxkUC6jRdLqbkjGNNy+VRgkMiH98KzsABtHNegfafcKM8/F6TBBy1LTaGsmKeo7GytvzOuuUxhr
 oKTnx9Ty9htA3shNR8plhomU0hnhyz2vkqNtjWEkr2e76WrJdglL220jnY2R6H4mokfXuDrq510
 HLIv+BjBjeeploWxhpMTZFgbff0zOZKmF+mKadQdlnJcosUQK781Xb16a/51v0fbOupou3pwVq9
 8mIl13V33SahJDz/Ce274tgz9MwICV/hKFDU3ViwVz2/SZGG4UkjHZhsFD+T4RTF3jl01q5ssZn
 FH3P8QbQ/VVwK4posmuckS1XLny7fIlB1TXR9LhzTs3nwHAczx1MylQ04svCO1zDcFitPUoM8x+
 /zoNrisnQEUuAozd4Tfm/xUFEPiisHQH1sJyTws8DAFuSU/TuzDSjubEB+OgPvn3cfKlozMuTLX
 9LsEOSqCFg1kLhw5eLxX2U5y0ZmW1CUJxY8WQw==
X-Received: by 2002:a7b:c015:0:b0:499:80d0:8b73 with SMTP id
 5b1f17b1804b1-49987927ebfmr59182905e9.4.1786706486247; 
 Fri, 14 Aug 2026 04:21:26 -0700 (PDT)
Received: from [127.0.1.1]
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988b2a509sm41692355e9.14.2026.08.14.04.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 04:21:25 -0700 (PDT)
From: Franz Schnyder <fra.schnyder@gmail.com>
Date: Fri, 14 Aug 2026 13:21:21 +0200
Subject: [PATCH 6/8] toradex: common: Decouple board sysinfo from the
 product ID table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-get-rid-pid4-table-v1-6-b8605ac094d0@toradex.com>
References: <20260814-get-rid-pid4-table-v1-0-b8605ac094d0@toradex.com>
In-Reply-To: <20260814-get-rid-pid4-table-v1-0-b8605ac094d0@toradex.com>
To: u-boot@lists.u-boot-project.org, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>
X-Mailer: b4 0.15.2
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

From: Franz Schnyder <franz.schnyder@toradex.com>

The sysinfo currently uses the Toradex product ID table to print a
detailed board model string. With various new SoMs that are released by
Toradex, the PID table grows and needs maintenance effort which can be
avoided.

Rather than printing the board model based on the PID table, rely on
the model property of the device tree and the data written to the config
block during manufacturing, which already describes the HW correctly.

For example, the printed board model string will change from:
 Model: Toradex 0075 Verdin AM62 Dual 1GB WB IT V1.2A
 Serial#: 15412798
and become:
 Model: Toradex Verdin AM62 WB on Verdin Development Board
 Toradex SoM: 0075 V1.2A (00751200)
 Serial#: 15412798

This removes detailed SKU information such as the number of cores,
memory size, WB capability and temperature rating, but the PID4, PID8
and revision of the SoM are still printed. The detailed information of
the SoM can still be looked up using the printed information on the
official Toradex website.

Decouple board sysinfo from the Toradex product ID table, making the
0243 Aquila iMX95 the last entry being made to it.

Link: https://www.toradex.com/computer-on-modules
Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
---
 board/toradex/common/tdx-common.c | 53 +++++++++++++++++++++++++++++----------
 board/toradex/common/tdx-common.h |  7 ++++++
 2 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/board/toradex/common/tdx-common.c b/board/toradex/common/tdx-common.c
index 81f7fa09002..2a8589f5e41 100644
--- a/board/toradex/common/tdx-common.c
+++ b/board/toradex/common/tdx-common.c
@@ -104,8 +104,25 @@ __weak int print_bootinfo(void)
 
 int checkboard(void)
 {
-	if (valid_cfgblock)
-		printf("Serial#: %s\n", tdx_serial_str);
+	struct udevice *sysinfo;
+	int ret;
+
+	if (valid_cfgblock) {
+		char str[96], str2[96];
+
+		ret = sysinfo_get_and_detect(&sysinfo);
+		if (ret) {
+			log_debug("Failed to get sysinfo data: %d\n", ret);
+			return ret;
+		}
+
+		if (!sysinfo_get_str(sysinfo, SYSID_TDX_PID8, sizeof(str), str) &&
+		    !sysinfo_get_str(sysinfo, SYSID_TDX_BOARD_REV, sizeof(str2), str2))
+			printf("Toradex SoM: %s (%s)\n", str2, str);
+
+		if (!sysinfo_get_str(sysinfo, SYSID_TDX_SERIAL, sizeof(str), str))
+			printf("Serial#: %s\n", str);
+	}
 
 #ifdef CONFIG_TDX_CFG_BLOCK_EXTRA
 	if (tdx_carrier_board_name)
@@ -202,23 +219,33 @@ static int tdx_detect(struct udevice *dev)
 
 static int tdx_get_str(struct udevice *dev, int id, size_t size, char *val)
 {
-	int ret = -ENOTSUPP;
-	int idx;
-
 	switch (id) {
 	case SYSID_BOARD_MODEL:
-		idx = get_toradex_modules_idx(tdx_hw_tag.prodid);
+		const char *model;
 
-		snprintf(val, size,
-			 "Toradex %04d %s %s",
-			 tdx_hw_tag.prodid,
-			 toradex_modules[idx].name,
-			 tdx_board_rev_str);
+		model = fdt_getprop(gd->fdt_blob, 0, "model", NULL);
+		if (!model)
+			return -ENODATA;
 
-		ret = 0;
+		strlcpy(val, model, size);
+		return 0;
+
+	case SYSID_TDX_BOARD_REV:
+		snprintf(val, size, "%04d %s", tdx_hw_tag.prodid, tdx_board_rev_str);
+		return 0;
+
+	case SYSID_TDX_PID8:
+		snprintf(val, size, "%04d%0d%0d%02d", tdx_hw_tag.prodid,
+			 tdx_hw_tag.ver_major, tdx_hw_tag.ver_minor,
+			 tdx_hw_tag.ver_assembly);
+		return 0;
+
+	case SYSID_TDX_SERIAL:
+		strlcpy(val, tdx_serial_str, size);
+		return 0;
 	}
 
-	return ret;
+	return -EOPNOTSUPP;
 }
 
 static const struct udevice_id sysinfo_tdx_ids[] = {
diff --git a/board/toradex/common/tdx-common.h b/board/toradex/common/tdx-common.h
index db3369a8f9e..7fb1cc8ecc8 100644
--- a/board/toradex/common/tdx-common.h
+++ b/board/toradex/common/tdx-common.h
@@ -7,6 +7,7 @@
 #define _TDX_COMMON_H
 
 #include <asm-generic/u-boot.h>
+#include <sysinfo.h>
 
 #define TORADEX_USB_PRODUCT_NUM_OFFSET	0x4000
 #define TDX_USB_VID			0x1B67
@@ -14,4 +15,10 @@
 int ft_common_board_setup(void *blob, struct bd_info *bd);
 u32 get_board_revision(void);
 
+enum {
+	SYSID_TDX_BOARD_REV = SYSID_USER,
+	SYSID_TDX_PID8,
+	SYSID_TDX_SERIAL,
+};
+
 #endif /* _TDX_COMMON_H */

-- 
2.43.0

