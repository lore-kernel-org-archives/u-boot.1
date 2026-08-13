Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E313FC5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 08:01:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88FC360A6B;
	Thu, 13 Aug 2026 08:01:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uF2GvZfuyQ4l; Thu, 13 Aug 2026 08:00:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A610B6085D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786608059;
	bh=wo2FRFALqXXVyYWb2iFgBAElnNOIluupD8THSzLqeII=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wXPSDIUrifPtRoSNO7jgY/oyPab2/rm6lAd1ydDxmxaPQHh7bi6JbzWnc9xYrdHWy
	 TcOeYz2bA4tPx60Vb2gX0jtMGs5XjnS6f9nNWN83qTtxletdEq3NHZS9Xlgpel+zs4
	 VTHwydAutjzEHf/MWPI0oya/YhmOqb+WWkvsYjGxLQQF1GfV2U+AZc992MjCFHbdVn
	 hEnJE2sz0fWbAE75PE3egyJGQklU3J43/CTWWfu18cjEGm1znnNGuPf3Ddc8wClBHn
	 zwK7eJa1KYxzK1Sks7kCPvm0SBn6zD2DfpFh9UxtZxZUZL/e1eaIMA8/QNZ/dshkk0
	 m29Qdk8iC6F8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A610B6085D;
	Thu, 13 Aug 2026 08:00:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 88712109
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:00:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 85C6B81118
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:00:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 27qI44bGvgTB for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 08:00:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=fra.schnyder@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A3776810F6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A3776810F6
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A3776810F6
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:00:57 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4980dc26022so3799275e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 01:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786608055; x=1787212855;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wo2FRFALqXXVyYWb2iFgBAElnNOIluupD8THSzLqeII=;
 b=Pkaw6OFGC9loZg6z4FUuifq9knsrAE2L8HN8vlW7CoDK5tHIfWM8D2yvSgYUhGywld
 dRpMevf7f78laswjX+dM5Rd7UCoLBHd5vJaQ29ii3VWH4wVE7ppTGL1BwJAzQeUdGlHu
 zuo8vtJUhhWTZFl8kOxM8F3V4TVtClk5tfNE2tehCtauN53Us8a3Z/6ndYGJsKTmq4/f
 0/UQtg3Fm+jOFV8jmfDT5NHGGczT5sAgL7yl0bOUw0HO5WeKDOjl0cPSIYBs2nj07dLh
 9WgyGk298Sn2eFxhACMb7/peTkA0JGL+ii7IKVbVpSBvvmZHkCBYI2bI3YYFSW64N6IG
 sA3g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoIzB7M/E7vyXhZoZapWgWGyrNsyzCB1JkOegJN9649h14eUDu7pHsmei33Mq0yk7zGRWa+y2s=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yxz+cjBXhcWnhpksDks5J5IW7xgTDAbR19U8MnZHtjZKRxdBFt/
 Re8HaDOzN+OMRFm98/4VPVVxwDq2ecJ9QPV21H8jpcpaG0ofUGviGSzt
X-Gm-Gg: AR+sD12GTs/GSgEqpu5/SvQjDjDp2s1Z9iRxEg0KgO+z2LLa4W6Iy86H1fVujht9seE
 y6DeNtOP1R4ymiKsHz+vbt81Ggg2J3cQkxZq0CoQUenkDmVgtwLmIcl/JmXC66uNlMK2ZGkXMxf
 hwVeBzkyhLqpTpVJBltkPTao0KMdH9w5QoSCT9NVyN20yzjM8X4A75V+L3roAHJ5PvFjO3OFMu1
 0srBQhh7q8Pwt0Cv6CaVRK2qL1lZPeOdb4QHMF+nr4Kn2xjEbOmsKY09c5dkH8pBx/pHFDZcvCu
 +OQIwduRSBo/MmIhtCceGzXh2iyxT0s6Fn2Ko/zzI7LGQxIT5BA46gxt9TsoWsu70QLx03x9MK2
 /rYCDmYd/f9tCgt9Y90LMqCc0Wij6hoJAKkneqervP/QgpLIzrP1i3tZzm5Wjw802uaXF4Pk5bR
 uODac4yzWcVDTA3x5jKupPmeJLjrc6Yj1pA8/7lI2jWVYCHUn1W1zjnbtSfVFvl4go00N/MXt1n
 Itg33doCVlXr3GOGtNDJzRXa0G4kDg51eq+dWnDhUoq7CSa7sMNaTv1MOy0gwZer/NDK7CcY52G
 8QkFCaioRDGtOs49mvcMXe4dDgEXqL/41B0QPw==
X-Received: by 2002:a05:600c:1914:b0:499:5210:c537 with SMTP id
 5b1f17b1804b1-499821c59b9mr37977725e9.1.1786608033244; 
 Thu, 13 Aug 2026 01:00:33 -0700 (PDT)
Received: from [127.0.1.1]
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499821652dbsm38369735e9.9.2026.08.13.01.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 01:00:32 -0700 (PDT)
From: Franz Schnyder <fra.schnyder@gmail.com>
Date: Thu, 13 Aug 2026 10:00:31 +0200
Subject: [PATCH] toradex: apalis-imx8: select QP/QM device tree from OTP fuse
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-simplify-apalis-imx8-v1-1-7239ebeb5b38@toradex.com>
X-B4-Tracking: v=1; b=H4sIAJ55fWoC/yXMQQ6CMBBG4auQWTMJpdGgVzEs2jLobwCbDpoaw
 t2tuvwW722kkiBK52qjJC8oHkuBqSsKN7dchTEUU9u0x6YzlhVznDC+2UU3QRlz7liC93YwJ2v
 8gUoak4zIv+2l/1uf/i5h/b5o3z/DdXPheAAAAA==
X-Change-ID: 20260813-simplify-apalis-imx8-ecbb3d1931b5
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786608055; x=1787212855;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wo2FRFALqXXVyYWb2iFgBAElnNOIluupD8THSzLqeII=;
 b=cnLvPpUEj+iHB55qSNUaLrF9l7rbmx3EZ6nxq4oybkH9qqaab4c3CQ4DIhQlm/l0ad
 G5CyxHpMXcm8dXJLSAkoRoxEPK9Dxyzz5f73VdHzT0N+XKXm5SpovlvPclU06JfiS88i
 tsBY+9SeEWby/i29YWDenAzd216L8n/nOW2I25Y7UGGSva11sR4gzB/5plh5Z55q3Ck2
 aFDE3yf4AuspVznDo64F6b0iO+jg8zVvKgJ1qi1393jMcEIc3sa2iJZmHCiyUx3+vIkd
 zSUgjgti1aOucpICsT4zsXdJ3PiozEkEj1dpa0EEu+ENWUgl/k32UqhGGvCjuuFLeD3p
 NYIg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=cnLvPpUE
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

The Apalis iMX8QM and iMX8QP can be distinguished reading out the OTP
fuse word 6. This logic is already used for memory layout selection
and can also be reused to select the corresponding device tree.

Decouple the device tree selection from the Toradex product PID table by
moving the OTP-based QP/QM detection into a helper function used by
both memory layout and device tree selection.

Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
---
 board/toradex/apalis-imx8/apalis-imx8.c | 34 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/board/toradex/apalis-imx8/apalis-imx8.c b/board/toradex/apalis-imx8/apalis-imx8.c
index b915673d9e3..ec30ceb3a68 100644
--- a/board/toradex/apalis-imx8/apalis-imx8.c
+++ b/board/toradex/apalis-imx8/apalis-imx8.c
@@ -120,20 +120,26 @@ static void get_tdx_user_fuse(struct tdx_user_fuses *tdxuserfuse)
 	tdxuserfuse->ramid = fuse_block & GENMASK(3, 0);
 }
 
-void board_mem_get_layout(u64 *phys_sdram_1_start,
-			  u64 *phys_sdram_1_size,
-			  u64 *phys_sdram_2_start,
-			  u64 *phys_sdram_2_size)
+static bool is_imx8qp(void)
 {
-	u32 is_quadplus = 0, val = 0;
-	struct tdx_user_fuses tdxramfuses;
+	u32 val = 0;
 	int scierr = sc_misc_otp_fuse_read(-1, 6, &val);
 
 	if (!scierr) {
 		/* QP has one A72 core disabled */
-		is_quadplus = ((val >> 4) & 0x3) != 0x0;
+		return ((val >> 4) & 0x3) != 0x0;
 	}
 
+	return false;
+}
+
+void board_mem_get_layout(u64 *phys_sdram_1_start,
+			  u64 *phys_sdram_1_size,
+			  u64 *phys_sdram_2_start,
+			  u64 *phys_sdram_2_size)
+{
+	struct tdx_user_fuses tdxramfuses;
+
 	get_tdx_user_fuse(&tdxramfuses);
 
 	*phys_sdram_1_start = PHYS_SDRAM_1;
@@ -154,7 +160,7 @@ void board_mem_get_layout(u64 *phys_sdram_1_start,
 		*phys_sdram_2_size = SZ_4G + SZ_2G;
 		break;
 	default:
-		if (is_quadplus)
+		if (is_imx8qp())
 			/* Our QP based SKUs only have 2 GB RAM (PHYS_SDRAM_1_SIZE) */
 			*phys_sdram_2_size = 0x0UL;
 		else
@@ -245,18 +251,10 @@ static void select_dt_from_module_version(void)
 	else
 		env_set("variant", "-v1.1");
 
-	switch (tdx_hw_tag.prodid) {
-	/* Select Apalis iMX8QP device trees */
-	case APALIS_IMX8QP_WIFI_BT:
-	case APALIS_IMX8QP:
-	case APALIS_IMX8QP_WIFI_BT_1300MHZ:
-	case APALIS_IMX8QP_1300MHZ:
+	if (is_imx8qp())
 		env_set("soc", "imx8qp");
-		break;
-	default:
+	else
 		env_set("soc", "imx8qm");
-		break;
-	}
 }
 
 static int do_select_dt_from_module_version(struct cmd_tbl *cmdtp, int flag,

---
base-commit: 36c377b9859ffb53eb1e39ea31e8d96d1e0fe1e5
change-id: 20260813-simplify-apalis-imx8-ecbb3d1931b5

Best regards,
--  
Franz Schnyder <franz.schnyder@toradex.com>

