Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8CC606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BtUs85He;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RwZ2vDq1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B636A608D4;
	Thu, 22 Oct 2026 19:02:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tSldcY3OOoRP; Thu, 22 Oct 2026 19:02:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 63B4F6080C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792695766;
	b=L3GqNck//klKcfZ4GCD1Xh7FSt4qyFc+szhadwZR+SOgA7SI6Lcf9ueAw97o7UwIyegm
	 SEnRnC6hBWRlz84+cvDir+yDfC/z25QuiR5qI+7DX1DdwtQHGY6RGNLUmkl0uWMFmoOsm
	 afqoWjbXLb3lsACefxw8uQ08AJZONkQSK7rsvHp+5voVaZQrthqwSvGRRWVmCodG1S392
	 vtEiiHG/EYf2nRk9HUciVeke/KtqFpiCRIxtqxq+N46Iy6BMWjgqUb1a8h/xbg/Jf84G3
	 EX6UBBq72Kmkm66bjSyKJrKUcvVys9TPWSDADPTH/o9HS8Culn3hWeEUzYQy7pZVT/A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792695766;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=KBErSyJG09rD9AvcVDpyec60ukNDIBqIGVK+JNckzu4=;
	b=AVtHBlVZUrAofaPT89byuwOzfzfaSFmsmBEK1kJDmZRS+vCQnCuKnCxeyIiWYvGosLV0
	 /48r+a977Rs2eulTru4rQECe0y4LeCkZlA/hKDad2RCUnRshipI0Qgbtg6DD9BVMiFVBh
	 v4V6/mbyBaX6y0XFTUCDeDoYoQX23RfAORrTmQpcBnQJRpOpGWzUe4vajuuliStYS5rEN
	 tpHayO3n9iRG7U0HdvjL6WCbXHD2zEAt3ZFcBLTSX0hP9b8HB2DKftzgBbckKKWlWX9mZ
	 lH9ln5LtIAYCQcBhV5i8jpx47MDPSGi7ykoP9ZYxuV26hcVFAXBaa542+QdwKP2y9FQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792695766;
	bh=KBErSyJG09rD9AvcVDpyec60ukNDIBqIGVK+JNckzu4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BtUs85HedbDJ/XP+XXHWC84NYzZEchEFFWAw3nCxO3UqR+dYXaeIkchIDujXhDdlT
	 94WaPsL97BB46qOGp+xZg3HKBhiYpyrlkjaCE0bgdgmrmwOPGgH8K9+9G5GfIcFiPz
	 dV61PmwGS1RUgSgLcLpAAWG+TT7gpLWu+kLMymu33GhqB2CRsQXdHdVZfBXhI1Ebot
	 OeECadRG5gNdf048EnS4ogliMMkOpu9vZYD/+5UTa4qpSLwpXOxDhTZXdz3yeQCTr7
	 B5u8/lTh7MZBbjFm6DCwRwWVyh/pL7a4pFLJpqZ10Y1tbwqWXaGpTGTuT9NB28nNfQ
	 mqbs84tcQTllA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 63B4F6080C;
	Thu, 22 Oct 2026 19:02:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id ABBE93C1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 920184098D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SylpN9f0_d9J for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 19:02:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9C36F406CE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792695762;
 b=cAsTt5E3458wjzOdOKKutHiLWMb5JOPoincPF5yAlZtIy+HRlXiX1rBA/e5z3y2O+t6r
 4+9BD9tfRRjnXCoMsVIrpta1CDtz3AmZ0kckix4E3Cj8QIAP84dO1ZT+yJ85fTDRm+8By
 CK66wlYNbhv7GqRWmAcfvHLn/HsgjVqud6JgsL79CvBM0S3ggygv46STrMl1NxZ77cb4j
 Ak88Cs/ACH+03uZnL/iTpe90S2Oo5QHRkIeNdliA7y7o1nBiNu7NZEuBGS5OOTemnzNgL
 KmLPmVrVc5w1Y7FC3C4MXh3RY1S9oICUCUrhgpb6yC4GRi0OVshn225eveVOcfQKjEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792695762;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=KBErSyJG09rD9AvcVDpyec60ukNDIBqIGVK+JNckzu4=;
 b=QRDyVQN3SXiJHRc366D2/ELhttPATJ1XCc900GfbeD45nTdZcftOS0yzVF1C+5EPb8fg
 B3TjGTk9x5DtUhABJMn7nxYJBnCINAtpkJFdCqiae7BQxZboKrlbnHw8uZ5FkzwiHboHc
 wtbYN6uuOF11FQ2kpqpGOuOVtpZ01Nrd63sabLak7YpFHHTNOkFaXS4NQvucEb5yQf2nB
 vmaDAsB21U3G3Pe1z1qtnmGs2hHxylOmE+mHoJLXlHNoLXyJlsEKV4+r9Dz3ph5NxRZJa
 D5nzygy4HJ2qN7fgbp28QPO+4INEbZxP6Rv3ddX2lYbuQmdL+/Olui+bOGyfe/XoO+A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RwZ2vDq1; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=RwZ2vDq1
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9C36F406CE
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:40 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a2074a66beso1055375e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792695757; x=1793300557;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KBErSyJG09rD9AvcVDpyec60ukNDIBqIGVK+JNckzu4=;
 b=RwZ2vDq1GLBZ4SfM7NSQuwwY7fqEzcVYb8zGVaBK1amuNuqmndJk5/s2wazymdDkfx
 CGBnGcmL0WcQ7oGGZJ52CvQAMYwxo6ZvBo/fcL0Mlo7v7XGwuvP8/Sc7wl7QonU+aAKG
 FsOrpdpUxXtPfpKt2FFLa5SxN+1ArBu7RMISls6Rrnwf6n6fA8msUhA0/nCb614JN3Ke
 brAL38rIrz7UVnGBEtuTtv1jLyWUUAwv2Z1AXh180LpW/abzlqWto/ZDWl6OZxOUjpV1
 ZYo8axihBXUoArC/bXLBpVgNgEMNOvxxnqoEubxW5ArUS78fE9jZiOOxtVxX9cFsR4mS
 uiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792695757; x=1793300557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KBErSyJG09rD9AvcVDpyec60ukNDIBqIGVK+JNckzu4=;
 b=i5tKVEG3v5UbWoGOON7ebaWEGDYwN6MlyLrMOPuNh1T9O7NTuZmoKMmr561aEa2D4X
 8c3Q4l7ti5r5Z177FV8NuVhxDdXgtTQ519/cKcGSo2VutyPowX0BryDyToeh695APwGR
 99DxBnBG1L6dnS2Um8aOPNuEW5Tj7+SSRnwXiUoXhxsOdRh+vN3IYi7D+5lyvp8qmTPd
 KyetsgoBLcu2f6kF1kRCPtWyeP0QpWeiFz9xCa0zTg4AgPzY6DZvzH97CoQn7r6WyWac
 Yqp9j5sJkudLJI1FWobkTfv3WrRjIsNifm0mANy44VQbIZy3NOrB1U7G7Xa6Swwp+5XA
 ygKA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8PLK+wJDDjdvfuXbmEfv9puI9GTVhb+C6BVbm7Rz8rd0hD5Lju5xH7dcpDjpuQN4ZLDtMnSg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIpa0mqM0asD7KWMgF8PHRoTwGuEMr/SYm1FYkjrK+zvEHwQwll
 lP9AzMstJMJHHz/daKJhWPH7gCe23zwmky0TvtPAHUSRYyQm4UlNhO5u
X-Gm-Gg: AYBFou2tGvX7kXtCg3D/C5xFJIaMUBxt9ZVxxbLJguJx64F2LOEgP/2y8i14Q5Dpf9y
 OaJD9vCNSCXnwS2OPZsbwpk3b4zUpHTYa90GrP4OXjBL0Cx0ubO+txe7cNGcmLCBCOPGmztS/7S
 5exHNIT7A8Agh9pS98pGTmDnH6W1IkROCoDW7Ii7+m4VVNniEzgYwSXPTqjRzldJYfCerTDrQSr
 xwA3INdqTLSJDcCR13svgng8QKz2ho1aq4MenMgFf1S+IPmwgw79Vfqvh433d988t8RbtdJ5kbS
 pGZzNLx93fkwmm9L5eZ51yH3+PBHp3myAvCfku27kt10aTyImdoLVKIp+4uUIz2gH5h4TsD0KT9
 HqlIonEBa7ucgr1qGCgw0Omv973AitY17r/7wRpjsqJlqSo0zwkwUMvb/8TwZegy1aBK6Of+Yiw
 JYTWCT9CjQ5buvl9dZgFlF+ymLgoqbWPOxN8MGuP2vcLu8PtsdKEfV18PUziHQS+4sJxaWD1Wzj
 9CHqvc7a+KIHp7gAlWpdrmJrxaq1vMz29BkkTS01bmgRrzQKoAnBOggQkTJLnSeUCSSn8scanG5
 KT/G1b+2NWAk0VYl9Dy/6/MVh7TRHpfeRVAeAJkpQ0Y+5dyYzbzKYOP/8cyC
X-Received: by 2002:a05:600d:19:b0:4a1:f625:2108 with SMTP id
 5b1f17b1804b1-4a1fdd40492mr94337815e9.33.1792695756737; 
 Thu, 22 Oct 2026 12:02:36 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-48e37a0e841sm189495f8f.54.2026.10.22.12.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:02:36 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Zhengping Zhang <zhengping.zhang@airoha.com>,
 David Lechner <dlechner@baylibre.com>, Wayen Yan <win847@gmail.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 06/16] reset: airoha: Add support for Airoha AN7583 reset
Date: Thu, 22 Oct 2026 21:01:48 +0200
Message-ID: <20261022190206.666950-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022190206.666950-1-ansuelsmth@gmail.com>
References: <20261022190206.666950-1-ansuelsmth@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adapt the Airoha reset driver to support Airoha AN7583 node structure.
In AN7583 the register is exposed by the parent syscon hence a different
logic needs to be applied. Also the reset line differ from AN7581 hence
a dedicated table is needed.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/reset/reset-airoha.c | 60 ++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/reset/reset-airoha.c b/drivers/reset/reset-airoha.c
index ef8c47a067bb..071f29b6f222 100644
--- a/drivers/reset/reset-airoha.c
+++ b/drivers/reset/reset-airoha.c
@@ -15,6 +15,7 @@
 
 #include <dt-bindings/reset/airoha,en7523-reset.h>
 #include <dt-bindings/reset/airoha,en7581-reset.h>
+#include <dt-bindings/reset/airoha,an7583-reset.h>
 
 #define RST_NR_PER_BANK			32
 
@@ -138,6 +139,60 @@ static const u16 en7581_rst_map[] = {
 	[EN7581_XPON_MAC_RST]		= RST_NR_PER_BANK + 31,
 };
 
+static const u16 an7583_rst_map[] = {
+	/* RST_CTRL2 */
+	[AN7583_XPON_PHY_RST]		= 0,
+	[AN7583_GPON_OLT_RST]		= 1,
+	[AN7583_CPU_TIMER2_RST]		= 2,
+	[AN7583_HSUART_RST]		= 3,
+	[AN7583_UART4_RST]		= 4,
+	[AN7583_UART5_RST]		= 5,
+	[AN7583_I2C2_RST]		= 6,
+	[AN7583_XSI_MAC_RST]		= 7,
+	[AN7583_XSI_PHY_RST]		= 8,
+	[AN7583_NPU_RST]		= 9,
+	[AN7583_TRNG_MSTART_RST]	= 12,
+	[AN7583_DUAL_HSI0_RST]		= 13,
+	[AN7583_DUAL_HSI1_RST]		= 14,
+	[AN7583_DUAL_HSI0_MAC_RST]	= 16,
+	[AN7583_DUAL_HSI1_MAC_RST]	= 17,
+	[AN7583_XPON_XFI_RST]		= 18,
+	[AN7583_WDMA_RST]		= 19,
+	[AN7583_WOE0_RST]		= 20,
+	[AN7583_HSDMA_RST]		= 22,
+	[AN7583_TDMA_RST]		= 24,
+	[AN7583_EMMC_RST]		= 25,
+	[AN7583_SOE_RST]		= 26,
+	[AN7583_XFP_MAC_RST]		= 28,
+	[AN7583_MDIO0]			= 30,
+	[AN7583_MDIO1]			= 31,
+	/* RST_CTRL1 */
+	[AN7583_PCM1_ZSI_ISI_RST]	= RST_NR_PER_BANK + 0,
+	[AN7583_FE_PDMA_RST]		= RST_NR_PER_BANK + 1,
+	[AN7583_FE_QDMA_RST]		= RST_NR_PER_BANK + 2,
+	[AN7583_PCM_SPIWP_RST]		= RST_NR_PER_BANK + 4,
+	[AN7583_CRYPTO_RST]		= RST_NR_PER_BANK + 6,
+	[AN7583_TIMER_RST]		= RST_NR_PER_BANK + 8,
+	[AN7583_PCM1_RST]		= RST_NR_PER_BANK + 11,
+	[AN7583_UART_RST]		= RST_NR_PER_BANK + 12,
+	[AN7583_GPIO_RST]		= RST_NR_PER_BANK + 13,
+	[AN7583_GDMA_RST]		= RST_NR_PER_BANK + 14,
+	[AN7583_I2C_MASTER_RST]		= RST_NR_PER_BANK + 16,
+	[AN7583_PCM2_ZSI_ISI_RST]	= RST_NR_PER_BANK + 17,
+	[AN7583_SFC_RST]		= RST_NR_PER_BANK + 18,
+	[AN7583_UART2_RST]		= RST_NR_PER_BANK + 19,
+	[AN7583_GDMP_RST]		= RST_NR_PER_BANK + 20,
+	[AN7583_FE_RST]			= RST_NR_PER_BANK + 21,
+	[AN7583_USB_HOST_P0_RST]	= RST_NR_PER_BANK + 22,
+	[AN7583_GSW_RST]		= RST_NR_PER_BANK + 23,
+	[AN7583_SFC2_PCM_RST]		= RST_NR_PER_BANK + 25,
+	[AN7583_PCIE0_RST]		= RST_NR_PER_BANK + 26,
+	[AN7583_PCIE1_RST]		= RST_NR_PER_BANK + 27,
+	[AN7583_CPU_TIMER_RST]		= RST_NR_PER_BANK + 28,
+	[AN7583_PCIE_HB_RST]		= RST_NR_PER_BANK + 29,
+	[AN7583_XPON_MAC_RST]		= RST_NR_PER_BANK + 31,
+};
+
 static int airoha_reset_update(struct airoha_reset_priv *priv,
 			       unsigned long id, bool assert)
 {
@@ -227,6 +282,11 @@ static int airoha_reset_probe(struct udevice *dev)
 		return reset_init(dev, en7581_rst_map,
 				  ARRAY_SIZE(en7581_rst_map));
 
+	if (ofnode_device_is_compatible(dev_ofnode(dev),
+					"airoha,an7583-scu"))
+		return reset_init(dev, an7583_rst_map,
+				 ARRAY_SIZE(an7583_rst_map));
+
 	return -ENODEV;
 }
 
-- 
2.55.0

