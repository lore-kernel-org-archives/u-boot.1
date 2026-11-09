Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892F3606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fRZwf/9P;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fNP+aVe1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 63A59608CE;
	Mon,  9 Nov 2026 17:29:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id scgmefVZZU0n; Mon,  9 Nov 2026 17:29:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A6871607C2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794245381;
	b=I2uGzHYU6NMO25RnmvddQWPYjw8LNbP37FmzMF489i3KYSJtU73D2OSCU/PCadiK1rdS
	 t8CQuxmFaIe/KPBEDlixLM+tJbl/xk38MDewPC7SBi4BsGFqOHMC+qe13WzkcDN6v4gyG
	 eO+lLcMjo9WnB7EfIVVrWr6uhACBkSOiId7RMNycyUCWrtgwp+95moAGid7C9iircEwlz
	 18O0hvIW5yu/gJJ39QVY/DxPsrA6QnOhQOnWTv3rDaOPX27A+WjswyU2iekZ++/NWLm1Y
	 5jeO8cpp1uuIq4rhcZw0D5/IsycYiENHErcRscnVfsg4YGpeSJg81TcO3QLAD86vnFg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794245381;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=zH+hTKSzp+eyOHDDiVG1wceOu/lOYvO555zdf/OxgQ8=;
	b=NfSxV2gq6IQQK/xANTeKrQt0ShT2isSQw/YKIW0j+/ksh7bHAcMddcXSARcwLsGH7BVp
	 C0+Gvn7Bq5fFgsd+MbLPEJrZOQbqLD09EH8hJRAed4rd5YKUOxTdncY+WBiF9tlvXRi79
	 ZSg7x55VamBivZPO3TNrU1HkBc7xj6OhXJR0ONccf0jBSnMNjqg1RfIllTiT6YeWppmNK
	 bOXs0pOrIQLjfehsUCsuFPmLwUJB0XxK5Hd6Kj1TLQ8VOg5aAVv9tPwGnbcJCRukHpegA
	 LxbZ+ESAGnmZj1q5lCbzpriiaU+Y788pAzqLAVNcIaa1I/DG5IjhS6MPAZ+WEUpfx8A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794245381;
	bh=zH+hTKSzp+eyOHDDiVG1wceOu/lOYvO555zdf/OxgQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fRZwf/9PKD0Otys3VDbshlM78C89lv8GsVkFC9j0mIMjM7oner/wRjH0Pld4VfoLi
	 swk8RJ8Aszlt3cqgV3SaOO/x2wjvJ6pII4sDZl0xJZIVhiECcLvP9Sch44504n7/+p
	 TNH5GV7ZHxt6+pDDQaKrzkMC9Sa704RbRWqEldo4XC+o6/t3fTyw/mXFHbm8DjrOFs
	 v8zIpBftnH+A8M1EurdHGggMiOTotMuqRqIx8nCV1biVhnJVclktUfqYorpOC153X9
	 BaNwO8/2PUx9bANQjt0dAYc3D5eDdpAAp1/6tU+IsXbI46xYjyIhUh3QvZHGjNkts5
	 4nHxSOfbmPWCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A6871607C2;
	Mon,  9 Nov 2026 17:29:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E2D98971
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C977E810DA
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E4psrvqX1qwE for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 17:29:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E3EEA810DE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=fNP+aVe1
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E3EEA810DE
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:38 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so10897225e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 09:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794245376; x=1794850176;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zH+hTKSzp+eyOHDDiVG1wceOu/lOYvO555zdf/OxgQ8=;
 b=fNP+aVe1eF0WCVLHK1XJ5C9dw5lYSK1l2TzvOOy5YhEUqQkiMqnAVCz+jd/1Wvg8id
 SHwuQf4uqdQWdmjx5UE4rzFRumZ+7gLp8JaxPz95GCpYvM6e947n8Eyuuz1Eoq1lRUYL
 83z84WtvQ/KuxZCWvGTbjZxYe6LDH8W798ySFAaXXFm0+NybJ1fABmMu6bQrff8KjDwi
 O74IYQCKoRMyiHUoQRSNErrnNhfjTFH+6FrGadHdg/iG4hnqoA09yFgNQr7jRJA6Moi7
 qpLlWVMNvnRZcWXXK4Px12eUIkigzUP+zYpaQMbjgVTADPPyPy8oh3l09P8wbzZvuIPB
 Zalg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794245376; x=1794850176;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zH+hTKSzp+eyOHDDiVG1wceOu/lOYvO555zdf/OxgQ8=;
 b=uDoeA5xde0/Np4iNm53ijkWBCK75117rvZhJhT3QBgIG3oy8GJHrJCLFJgLXYEXuxc
 /ElBkqciud2GhLzZIitZ7d3ncS4wfGlr3IvJjD/K3QXDqIYD+V46wWo54tnmpP05hPzI
 g9VEdj9lo1OxYTEzL0pww/JAPPIsqo56YaxIjBREOM9qe4aEt8giXpTivxIXz2jfzohp
 erTuvw+ju3N6UwibE9eLWVapPwyAeTfXenFLe9Ov+EkqivsMwWITJ/g7dIYnAJcVshjP
 0ihk58Gvs8qoHABdJSTRYzpGQ7Agv9ofYOLBhzT9QacfhnCRLvqpEmifMGSxsK0V1F3H
 gJeA==
X-Gm-Message-State: APuU4Z9P41Ke9qMgNJhhLMcbU5alvnDdDumeQhmtoTM7LQlp85cgH3iO
 SsJ77XKnleI6vd/ljW7qDIjFG2Irsoj/R/OOZqkA4FfUt9eQp/szrgTcsRgKT4xRbz8=
X-Gm-Gg: AYBFou1j5XsUZE8HS7359Q+E2yTXwFdRLgROAZbA1UxYjsvcEt1X1l+XyvfN5ZtBuiE
 nPkO+lE6UTEVxcfJjb7r6Zp3wl4Gzm30Mm3WoIlUMGH+Pr1rTBUv6BF2kgQ1T7EgBs1AJT9ZhSi
 GdITcwJFIHHRd3YCYiY29DgLo5WGtdCZEwvKFx2BrZYAYoWzoz4PYLAyEMssKspaZZvIKiUsPUD
 SKrsPj2pHMnMMRsu93JXYQ/JTyr54vLycygOSnMVsU+t3Ng341c8bxpyBUD+DUAO9dASzsb5qle
 gSDwUg7jyR01HO6D0tOtDTwaQJS4z3BuN2OVX4swa8L+qA0nOhvafeFR0L3U+gOsln/kFt6+ijJ
 VNXFJdOwjZ2PvBsTYxyfjuMPZLAJdnPyryfpxub4mzbMxTwLKSFK3HPkUBrLMBs5Ob+NiQL1JH/
 2QxSQYJ/K4uckTOh3hUO95VEtwpdrPBTDgs2qlFlg6OMr1xDQjbA5tLnDWODy0eISDqh2cdSKwk
 hxF/r6nVbMfr4CSBtzef2DIj5YQ43ypuVpsmFktbO9cfMBFLWxLML/4UqWbtZpQrnzha/bi2t3C
 49nGUK5G2xj2Ha8N+lWbxPQCIRwsux0=
X-Received: by 2002:a05:600c:c106:b0:4b2:406b:f3bd with SMTP id
 5b1f17b1804b1-4b963c78dd1mr75143105e9.23.1794245376354; 
 Mon, 09 Nov 2026 09:29:36 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835d2c027sm109750f8f.24.2026.11.09.09.29.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 09:29:36 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <u-boot@0leil.net>, Andre Przywara <andre.przywara@arm.com>,
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Warren <twarren@nvidia.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com,
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Subject: [PATCH 06/11] video: sunxi: de2: Tell the display the frame buffer
 size
Date: Mon, 09 Nov 2026 17:29:35 +0000
Message-ID: <5e2ceb08-8dbd-48e7-acf6-ec30f5ccef0c@gmail.com>
In-Reply-To: <2399d63c-ddd0-44b0-bb81-d5d9d2a8a8b4@gmail.com>
References: <2399d63c-ddd0-44b0-bb81-d5d9d2a8a8b4@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

The DE2 driver reserves a frame buffer for LCD_MAX_WIDTH x
LCD_MAX_HEIGHT at 32bpp, but takes whatever mode the HDMI encoder reads
from the display's EDID, while sunxi_dw_hdmi_mode_valid() only checks
the pixel clock. A display announcing a larger mode makes the frame
buffer run past the reserved memory.

Pass the reserved size and depth to the display before reading the
timing, so that only modes which fit are used.

Fixes: 56009451d843 ("sunxi: video: Add A64/H3/H5 HDMI driver")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 drivers/video/sunxi/sunxi_de2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/sunxi/sunxi_de2.c b/drivers/video/sunxi/sunxi_de2.c
index ab36ee1595b..383cf47b907 100644
--- a/drivers/video/sunxi/sunxi_de2.c
+++ b/drivers/video/sunxi/sunxi_de2.c
@@ -181,6 +181,7 @@ static int sunxi_de2_init(struct udevice *dev, ulong fbbase,
 			  enum video_log2_bpp l2bpp,
 			  struct udevice *disp, int mux, bool is_composite)
 {
+	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 	struct video_priv *uc_priv = dev_get_uclass_priv(dev);
 	struct display_timing timing;
 	struct display_plat *disp_uc_plat;
@@ -194,6 +195,8 @@ static int sunxi_de2_init(struct udevice *dev, ulong fbbase,
 	}
 
 	disp_uc_plat->source_id = mux;
+	disp_uc_plat->fb_size = plat->size;
+	disp_uc_plat->fb_bpp = 1 << l2bpp;
 
 	ret = display_read_timing(disp, &timing);
 	if (ret) {
