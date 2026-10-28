Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67A4606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZgOijjaX;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pFMNj/r4
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9478040887;
	Wed, 28 Oct 2026 14:48:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nRTqTMPoSUwy; Wed, 28 Oct 2026 14:47:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 08C3240856
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198879;
	b=GUhz5nCLUK1WKg8KDm/NSzclcHc75q0Jvyw14grH6HLr9K+rz2OQHIG0G8Tnm34bMvIT
	 7plOkFRi0A0K3Cmolv8h/qjDFuB0r+/uHLd8qclPZAXCpgUfWeh1iFNef/SfbFFn40I1f
	 Na2LC6Xeq/lwIbOYRXKsddG6otOn0c6xUVZnU68QRCPoR+ztU5DEybcsVM+bF+benm3lG
	 TasxkKiqe4hWqXzZAwkfL5+21whhTucPQ60fw0ffVSJQZBIIYkoqfEkpgRqBFL+y0yqv/
	 znk7GPRTgeq4cZgrVbCfyQvdgXM0wvKdYiAwxd/EZJFndld1toxZcmlQzcCqAQdlfSg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198879;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LbjcFKAznweHRgGgX0VjTtglsPL9ZT3eoDgSNrxm1C8=;
	b=KUGANzA7nSO6H29hBMHm1MBvppFx833Bjry6FQjTaeAZExS0iGqmtV1LcwuZL6F2UQfh
	 R6PO7fX2ugrNzPnADZG/mD19HthiEII6eWg2oid2YvycV8Rh27qUHHjkq5w/ypjOexT5o
	 YQUtX1gskg1o2pIgZENgWXMwLQnfAPX5hGwUrtHL8ndAmWQ/pDj1mg5yKznTT8fy+dd1K
	 0hCdQ1IUz3FJraNk0L2dF8rVmpGwvh3TC3VuAfTUihi2ir3jb5w3hqVdCrBtyoiHn1LDw
	 vMTw98PFBjiR0fmww0im0UpgtKlAlxDD1NYacJfMnrcLbTQtQLJvOLvdzsnKu3ZUqIw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198879;
	bh=LbjcFKAznweHRgGgX0VjTtglsPL9ZT3eoDgSNrxm1C8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZgOijjaXaGkvDakLLOr9XZRUXiUXsHgTVScJoRiEpGO075KkSb/cylC7wXCPV1eDz
	 GKGrMpqcbyYfQZ+f2LhvmWDHnF8JqQDsBloDhIFljYyKmBu4zX2lqG57oZxPFMS53a
	 kNtiF+PA625lyyEYStbxj7J3suRVfhEH6+hm3OGWdzj0R/umf+IXKduN7EXt+PD2Mi
	 HUcWMVEIRPma6QRwg+oZyjGq0hWru7W4ix/3epkAMBBtkDDJ0f6t9yBuJbsq1Ltcm5
	 mf8qHa0wxWmfbMSqh0AtKXVVz/WoXrqRWsUAy+HFMgRf+kMisNtvVhyGLYvDx5D5HQ
	 OAO7Lu7gskceQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08C3240856;
	Wed, 28 Oct 2026 14:47:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A85E5380
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8EBCE808C0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xoUlLdaJuwdk for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:16:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9C4BF80CCA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196965;
 b=B2ul00ceEBvdXAA0MwZT+T3HkK1ggwENe3F6hu86laQlJbJJISZLLnIw+EqzdpvWwBrr
 pVMFz7TwEWGo/KnswTTf9eMVvTIq3xyijKlaAl9giwFe+nldW3A+6/LYK5LFJ+10pS16f
 ExNuxxnO5zD91HJWFhuApcpZDb6MFWuUV79FPLF0x0i6t3Y9tjh0HfK2J7AH0DeIP/pyQ
 4KH5jadQBT3Vajb2p3r2l+Oe+A1tIAFyqV63mLnbXPeabwf8JSmM3UjWk0A1eFPx4UgGI
 otqbVtd5h+1w9WH0Hl5FMqf4d/ETK0kyNClh2GMdpykaBGkZwD95uGMF5AU52lU7BBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196965;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=LbjcFKAznweHRgGgX0VjTtglsPL9ZT3eoDgSNrxm1C8=;
 b=p0TINHOb0DwFwZcB/ZRxl1RgYcuRJxSa75nJ/Ea+T/GCZGVpmCBaiKNelH0yidIQedce
 YOlhCneXrWxHaunzcRJZaDdO43qqXkZPhfSBkDgTka6QExm/lGsf/c4PrM3GYpcBSYQaA
 A2z+fWg05jp3OzsUZ1FmSxPaUAqojytGOfyq02WovCXcBYXHFwyIvYcdXrIRiYyA2UvE5
 H9qvk805nQ0Ah9upuH0+NPw4Inwbk8TjyecrZH49mB2CJADcW3SuVIrBdUL3K0yaQderB
 12qyxLXnVcE0CoqZWTluvJu9mrmzctR7grOLDh1S5MRsrMIxexuo91RTID4quV6EIAg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="pFMNj/r4"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=pFMNj/r4
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9C4BF80CCA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:04 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c407213696aso10465366b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196962; x=1793801762;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LbjcFKAznweHRgGgX0VjTtglsPL9ZT3eoDgSNrxm1C8=;
 b=pFMNj/r4EIjDX3oY79wsCy6CGjJ9PHYNlI02MkLc74LjGytVR86whxvWyqBRHft59b
 ozEAXYwterasbkPnsvi5hkCkbzq5UGPJ0v87GTZe8YlfV82VzDeLJgt38svF7V+6nHdX
 f9tP6uVy+ZXUPePjJbCr7rk0WxLeBmyucr77LxKn5os2fnRGRMB4K1pBHwDe0CkvDKsZ
 X3hCnFLlGmLbcdK1zMAsDwTCAimClMGOGWo/5slOyU0PkfJF+2MEVZ33lUMtFe6pXRvV
 yk4qR7MrIiBf53UwxXbZrDkSaI15OJe03Zc4HA6caVGw1zMVKbzmPvrhXtCo3MZEPsrV
 kyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196962; x=1793801762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LbjcFKAznweHRgGgX0VjTtglsPL9ZT3eoDgSNrxm1C8=;
 b=fZDR36+axTBVhzSb1ZRGbHDSfTM6YgMuIcyiERISib8WgHVcm7THJ2Sk+FbH+x+7As
 myyZyLUwokySqCpywLWB0PuJFgOPiT6Dblm9gdqkg5+zwwC+xjlv1gjJWk1To/bIPiQ3
 3Mmal9ZnUkuRSDqY3ZujZE+TCACpHGC3ySeryZhaOzKZQnSvADHoDZipkNp5gRksaImg
 BNW1ckbCq3Det0zVxxyX+oG9JlCINzR9spmM9+x5Y+GVV+bjHndQvBzh5nzUXv+a4ylF
 2n7jGD29gPQ9UK/jGR5AgiXY1I5LF9D+vz1CVqVr5O4P8YEK8/nfpCOfcpYTzu4Cz2aq
 a9Fg==
X-Gm-Message-State: AFq9FYIswaOvM2uGKSA4mPXko+nxCHnJOO4ptNAxh9/6qs+NyGkJIrOl
 SAZhlsEUpMudMMYovK4QptxqIVWMw6fWsv/MzItWQXAZC3Xy/a2heR9aMx1M4RGyZuuSek6c09w
 9uTtP
X-Gm-Gg: AYBFou1Qp2CVB/m7TbZtqdbFOFKTDh7+AzJkdoSEp4XGZMPYj4T9fFhHYbF6yQr3Q6X
 YmYVWsknxnU2+Y+EX/GJtiUY+9FY72D/hhXIfdpTtV3lSktk0YKWpVAiKx65QAuNvr+N9oCkP5H
 W+a+Tm5n9LHBzaX4rvuY2vv2/k5TjQ3KGVlyM+wD25TgSNhXkUGnjdPc4yE4yaHjiSKtnSBAN/s
 cKGRb3etJIuLqonZlkY28nZ5Wv0w/Qvkl5uu2MRrj0I0VBTFYuLVP6HoSFk1kX+epZEEnS8C2tT
 0dcxcw6GIIwxDiwBPA2YwON9CKUocceNWqAmM5RFcMZAc5w0j+vwheeOJkkIDhGVw3d+z2iiZPn
 TurvlTVDbqxfWeGBl63AoDEJhQe1HFoT3pZxs7M8EijuLTQx7dLaGePfpuOZycQzWz6adF87Cwm
 NaJWA3KXsS2o7MHWstR91fTeN05Ev2C2icfBL02LbH6fJZ0pQPoUcAYnRuh/5dLTGzC+Th3R2xB
 loRNJnNXcCw76Ce13ku2LZlMqTnUOgunX9IzXvWIV3UOPyeTpMhkDPX55KJ4GM7jA3Tt3JD6Tuo
 iJOf7D/SFRmgVIntgAo+nAkHuYYLyaQIOpljD27BsXa92O3yec/w1urdKzT+h38cYNPM6ssW98q
 UZLufudjnN6Y=
X-Received: by 2002:a17:906:5192:10b0:c40:5ee3:8694 with SMTP id
 a640c23a62f3a-c49bdee7e16mr263197666b.4.1793196962260; 
 Wed, 28 Oct 2026 07:16:02 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd650890sm629859266b.51.2026.10.28.07.16.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:16:01 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 03/30] phy: cadence: use reset_control_assert() from
 reset.h
Date: Wed, 28 Oct 2026 15:15:27 +0100
Message-ID: <20261028141554.3073545-4-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141554.3073545-1-anders.roxell@linaro.org>
References: <20261028141554.3073545-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:47 +0000
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

reset.h now has reset_control_assert() and reset_control_deassert().
They return 0 for a NULL reset and call reset_assert() and
reset_deassert() otherwise.

The sierra driver had its own copy of that in cdns_reset_assert() and
cdns_reset_deassert(), and torrent mapped the names to reset_assert()
and reset_deassert() with a define. Drop both and use the helpers from
reset.h.

The only change in behaviour is in torrent: a NULL phy_rst now returns
0 instead of a NULL dereference.

Suggested-by: Marek Vasut <marek.vasut@mailbox.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/phy/cadence/phy-cadence-sierra.c  | 18 ------------------
 drivers/phy/cadence/phy-cadence-torrent.c |  2 --
 2 files changed, 20 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 9f8a6d8d43d0..d8b2e040c50d 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -258,8 +258,6 @@ struct cdns_sierra_pll_mux {
 	struct regmap_field     *termen_field;
 };
 
-#define reset_control_assert(rst) cdns_reset_assert(rst)
-#define reset_control_deassert(rst) cdns_reset_deassert(rst)
 #define reset_control reset_ctl
 
 enum cdns_sierra_phy_type {
@@ -336,22 +334,6 @@ struct cdns_sierra_phy {
 	unsigned int already_configured;
 };
 
-static inline int cdns_reset_assert(struct reset_control *rst)
-{
-	if (rst)
-		return reset_assert(rst);
-	else
-		return 0;
-}
-
-static inline int cdns_reset_deassert(struct reset_control *rst)
-{
-	if (rst)
-		return reset_deassert(rst);
-	else
-		return 0;
-}
-
 static int cdns_sierra_link_init(struct phy *gphy)
 {
 	struct cdns_sierra_inst *ins = dev_get_priv(gphy->dev);
diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index c903fcdb3317..b9f61cbeaace 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -215,8 +215,6 @@ static const struct reg_field phy_pma_cmn_ctrl_2 =
 static const struct reg_field phy_pma_pll_raw_ctrl =
 					REG_FIELD(PHY_PMA_PLL_RAW_CTRL, 0, 1);
 
-#define reset_control_assert reset_assert
-#define reset_control_deassert reset_deassert
 #define reset_control reset_ctl
 #define reset_control_put reset_free
 
-- 
2.53.0

