Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D442A606A31B
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 19:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=F4Bjxamw;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K0A+CmYn
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 948D4405F8;
	Sun, 25 Oct 2026 19:31:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ArQt_pSBiJBX; Sun, 25 Oct 2026 19:31:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BB1D3405F3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792956675;
	b=Kc4IU3WyIuL2S6XHZGUitMrb0tNBuTle9pYr+o95yNuO8V04iC0lFjIb5+hn6hpLVn7E
	 vG1aB3vfLkzkCEZMPWmNoprbmLElJhW+dxlh8qjhxUJZ78zrpvX95SERl95dPR3EmnwKy
	 q5FhOhCxZDurD9+XaKA9g42t8wbVi4wCRcyKkl8FrnCtL3I0EOea5oDWHP287EcA2zW42
	 18yr7/PAtKOM9P12JyJYLLL3Lt//EQ9Z/HtGaBvujBbEZUfay6xIubrQ/tpKYOArncnrn
	 cSmIsT/fbXwXAT4OgFQp95u2QDQRykLGa7PidVd4zwOP6+KD5p8O6qk2exvYeelwzug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792956675;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BlPdOqiySV5iWz33mCkcntVYGT9M5C8zZpAFp+k2pRI=;
	b=BQjcXjIZrkvW6cIYh9NY+gGFaCXiPwSybDdXcDOH89nb51wfNSbGGvP60VlJaHRSv5GA
	 FJetSAAhUEMNwSKtsj8Y3soTqmrLQZW2LO/NDd7QjvOETBmj6wAqph9q3KSJn83A0O4jH
	 aOC4cicXbKeLd7uHV2Mw9zuwXge8oBSKNcQ2x22k2BqJt4ks1gkK2aaFQdBF7X01rZV6d
	 7pdomEw9WaJABSS44hpeaQ/dMaSgF8XM9zLiZy+BHrcgG60qEoZ6RDoLyLLuSV4Qdu82u
	 ax/j5MwGc2xI8WhKN0kShOAWkbH1kzkbFcGFVNeMXJVizHDvBhMr96RHffqvI66EN/A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792956675;
	bh=BlPdOqiySV5iWz33mCkcntVYGT9M5C8zZpAFp+k2pRI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F4BjxamwzX9zlKCwsy2DsdZLuKMOVxZV5m34Et5k4Z2VaeC/Fi0t0JErpKEKODk8a
	 xx/hQ9W8SHVXx5hkp6x2UxIFxsS3Pl+YUW/4o2KuPrORdlP0aSn8Z9mdu9KzvjF1XL
	 /TZfIxX8Aaq1zhiLuOL1trBPENraAeBn47OZT2buvhcRkM0z0ojh4Cbk+l1RvBC6Hs
	 bU3/mcsICV6RIh0vlR4TfoW7xOjMbkfhJ2pWDDtWRxLPXJXkIUtFAAAxZfyyRrW7lf
	 FEM+cc13kRNYckrJ8l9llSNZkOYjjLYw7DgR3RxKXQHCkkXT1KwBrYe4J+5IZb62mz
	 7hZi9vTjuSAoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB1D3405F3;
	Sun, 25 Oct 2026 19:31:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1838579F
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 19:31:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0A29460601
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 19:31:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qeqVvvqdT6yq for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 19:31:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 10D4F60600
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792956670;
 b=jQT+T9Pbv6L0AzfFOrQAspPQU+/EYvz/pV7bVhkX60Fw+NJ9YnD+pyBIFFTIe0VOE5ty
 YDWjnyKPHTykWTmH1r0dqkaVQPVusg+OyIriQdd7f4by/idiMPgL9qFXDfyfdZzqUbzb6
 eTGXkNxmZbwJWHge/KLxnhhIe/dmKkLewWLEpOB9nY4o3as0dONpEjPj6+DSqtgSvQva5
 yGd7MRXUSKfkh4OfzI+odGMCE8Cm1iV+yHYNLF5qmQXKU/Kfm8zqIbT+4vShc05+hhc+7
 5JlGHi5qrRmYFeUwNTrZsQ4KQtiideHipn/Fzywf0CyDAJV7ElnpFatHvAw4tevJ1lQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792956670;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Sender:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer;
 bh=BlPdOqiySV5iWz33mCkcntVYGT9M5C8zZpAFp+k2pRI=;
 b=BjsHqdPevKx5TqvM1YMZqANhycWXlTYI48r7H+rIrsQSdCA4LWnFSnI2Yl/AMvJ2223c
 aitvjj2St5H7R6AflbUSXoJ1ABYqjZ7rn6Ke1yJxu7d0BwNCq6t2FWuBmQ6LnzeBu1/dC
 J2SwuymWNq4zzf/Rnme8fv6C6o7U3OBs9iSKyZCaE3xsNOIiyl4ucpqdFa0cz2rQLITLJ
 U4QYctaqOQT58LDa804QPVNt6hCry9emCpb/2RtkosXdSldXrOAEO+oNYgiLP5UIi9Gyb
 RABWtHhDCHWxgktx6x0SPRags2sCcnA/7Ei0hZ6W1NRc6qQuJuK/J58lmtUdOGlxYjQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=K0A+CmYn; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=K0A+CmYn
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 10D4F60600
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 19:31:09 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so13611125e9.3
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 12:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792956668; x=1793561468;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BlPdOqiySV5iWz33mCkcntVYGT9M5C8zZpAFp+k2pRI=;
 b=K0A+CmYnn6jy7/Y7GMwSx2dOD2VBMBzeJ6MabSQqq9bqUd4aRMDF0x28cRaj2iwTfU
 QJKSg8lSYo7ZrTB0hxxjh+KXlO7t4NK2NpoO7cFh/xnuf0fE1UJJYCQFdz6XvB54FqJ+
 cHCobQ088WpHwSV71EMuApl/4MCPLFYJIzmWHooFEv4bNBPG4n6SBs0QtNb/hgXjRt7c
 LaOxuesjkHzqrw3t1IN+yQzhNZdCQ7LlZCAh8AlH8EODdPccFsnswu49fajJNjZdjuhl
 1hN978YlifVicGqNi/hoaIqFvVOI3cg2S3PCBMBzca2ONZlX/i9u5Pho85zR/OCYJtS3
 6f1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792956668; x=1793561468;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BlPdOqiySV5iWz33mCkcntVYGT9M5C8zZpAFp+k2pRI=;
 b=Quk10QWPamtEJta1Mj0WIfCJLy6ZrbZaS4nwCl0Mctx5Tf4QBJggDieqCLdQjpn78Z
 6eIUSzwEFX3GDqYgtP+zifE4CXQQnyiSUxBkmD7WAIu5jBq24q+56Oio2UtI0L7ovtZu
 +3r7nJDg+JL8ugwGb9OAXXfXAU4uKX4+h1jp9K7doSSBjgU20mj2zukUardHBGWb5lNz
 sDBeewaLWzSzELPC7dvncCQJ/pIW9oh5OF+eY8Ww/xAMARUEGM9dUDnEhSJ7Y7CMRKQ1
 b8ZTEbb3DftXsAOAOAnLs3PmLOcEw2gNAfWjMssw9dNamfN+R4Y8t5vBr1Ts0PEaP591
 cfpw==
X-Forwarded-Encrypted: i=1;
 AKwUvBztDFoo0mY9t0vkhE5xrdIXSalqtMLrF7fkwKHRpW0zhwv19b5jO5PFg5wmA+AA39SLXtuOiaw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJoCTDspyvQNRk5NDPMP+xa2I530IU3LX1S+e3px7tRH9vUxAJ5
 D7pchsrWT7TyaTv4zKAmFV+HXn4i0HWk8yOKAmRF5Nu9JaXNGGFPWiR10wMSUw==
X-Gm-Gg: AYBFou1I4dXSVsrPfRqhtYd3rKAm/0Lp76nB1ul2SRVn2bH1i7YqJ27H/jbzfudy5q5
 9+X/QWhu29X1ylU9HOhockLOM5It2CBFPRM42AFakrTSD5ZNqBMTisheWFCdBN+1zHPNlE9azMg
 O6xtVtvl/x2c7IKkzDB/XlvinZ52SZzPSxW3+sOIfDNmZfJwRkYdRKTvZqn3vcEVaACzTthJS+Q
 sZIDn3lDgD/i1RYEeJt6mp7pcO0LdR0L0/STToUD0lvEDEW0CvgYojS++MGtL+X5CpvXBshxqm0
 102im+lCifGANx3ZDmygyiy7wuTkOVks+qfa2EJbnM9nrk+L/amgbv8PYFfli7AFxRkh6EZbORt
 mwDSOnM2nukc0kENnzPgIUkluK8jTh3QTDL8shI6lLt3fqBReti+0QzXewUfw8BDgRBPKt6sm25
 yLpmHIjwQEibUqEzCZCJE1gnoVKtTykNQjlDovF37Bj+W7kPVN0UYOwHeS29un242GQgGZS9DdJ
 /Oxvcw5fmgNPsivzvUE6BgH3zWanpqriR16YLfjykm5o9tboYDJJejk1v2iSis0gkQ=
X-Received: by 2002:a05:600c:c09a:b0:4a4:3a2d:15da with SMTP id
 5b1f17b1804b1-4a43a2d1805mr51966455e9.15.1792956667675; 
 Sun, 25 Oct 2026 12:31:07 -0700 (PDT)
Received: from [127.0.1.1] ([151.51.254.197]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a0aa0bcsm176549365e9.4.2026.10.25.12.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 12:31:07 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 25 Oct 2026 20:30:49 +0100
Subject: [PATCH v2 2/4] ram: rockchip: px30: allow multiple SDRAM types
 selection
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-ddr-multi-v2-2-b82ff9c860ba@gmail.com>
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

Allow the inclusion of more than one SDRAM parameters set in the PX30
sdram driver. The driver applies included sets in alphabetical order
(DDR3, DDR4, LPDDR2, LPDDR3), stopping at the first one that makes
SDRAM initialization function to complete with success. This order is
debatable and not based on any specific reason.

Due to limited PX30 TPL maximum size, including support for more than
one SDRAM type can require disabling some configuration options such
as CONFIG_RAM_ROCKCHIP_DEBUG.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 drivers/ram/rockchip/sdram_px30.c | 40 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/ram/rockchip/sdram_px30.c b/drivers/ram/rockchip/sdram_px30.c
index c7ff924b2c5..7f51b9c4f8f 100644
--- a/drivers/ram/rockchip/sdram_px30.c
+++ b/drivers/ram/rockchip/sdram_px30.c
@@ -123,27 +123,24 @@ u32 addrmap[][8] = {
 
 struct dram_info dram_info;
 
-#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR3) + \
-	IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4) + \
-	IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2) + \
-	IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3) > 1
-#error "This driver only supports one DRAM configuration at a time"
-#endif
-
 struct px30_sdram_params sdram_configs[] = {
 #if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR3)
 #include	"sdram-px30-ddr3-detect-333.inc"
-#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4)
+#endif
+#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4)
 #include	"sdram-px30-ddr4-detect-333.inc"
-#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2)
+#endif
+#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2)
 #include	"sdram-px30-lpddr2-detect-333.inc"
-#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3)
+#endif
+#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3)
 #include	"sdram-px30-lpddr3-detect-333.inc"
-#else
-#error "Please select suitable DRAM type CONFIG_RAM_ROCKCHIP option"
 #endif
 };
 
+static_assert(ARRAY_SIZE(sdram_configs) > 0,
+	      "Please select suitable DRAM type CONFIG_RAM_ROCKCHIP options");
+
 struct ddr_phy_skew skew = {
 #include	"sdram-px30-ddr_skew.inc"
 };
@@ -691,19 +688,11 @@ out:
 	return ret;
 }
 
-struct px30_sdram_params
-		*get_default_sdram_config(void)
-{
-	sdram_configs[0].skew = &skew;
-
-	return &sdram_configs[0];
-}
-
 /* return: 0 = success, other = fail */
 int sdram_init(void)
 {
 	struct px30_sdram_params *sdram_params;
-	int ret = 0;
+	int ret = 1;
 
 	dram_info.phy = (void *)DDR_PHY_BASE_ADDR;
 	dram_info.pctl = (void *)DDRC_BASE_ADDR;
@@ -713,8 +702,13 @@ int sdram_init(void)
 	dram_info.ddr_grf = (void *)DDR_GRF_BASE_ADDR;
 	dram_info.pmugrf = (void *)PMUGRF_BASE_ADDR;
 
-	sdram_params = get_default_sdram_config();
-	ret = sdram_init_detect(&dram_info, sdram_params);
+	for (int i = 0; i < ARRAY_SIZE(sdram_configs); i++) {
+		sdram_configs[i].skew = &skew;
+		sdram_params = &sdram_configs[i];
+		ret = sdram_init_detect(&dram_info, sdram_params);
+		if (ret == 0)
+			break;
+	}
 
 	if (ret)
 		goto error;

-- 
2.34.1

