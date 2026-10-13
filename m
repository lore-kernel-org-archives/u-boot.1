Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E73CC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 08:47:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE94B406D4;
	Tue, 13 Oct 2026 08:47:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kA_MOjYWs3nq; Tue, 13 Oct 2026 08:47:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D8931406D1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791881230;
	b=RFZMZG0bSsy8o4FufM18oUOnxUgq3n5jT9CplGHF3T6XYq+WsEODEOd5gVBVEwu9YA0F
	 /tK+h0ta9+GW0zCeiImZy/HFKwRstxwdTOUqROGXhmMQQLnegQoT2wB101ovB9cVkywBl
	 ZH1H7U0h44jLlPXmhBdg2+arqECZ+nsqh2YLOFWluwTD1xjQ3W5TrjZLdjeWl4IBrdaNZ
	 CLf9kmnUHQDkvBer4uYYc+nLCHfR1CtnEhDzpDmtnmyW+S6tMX4s+GqooV3ZoP72kEBWg
	 /bCJVwvZ59UCV5cvuiHlBwx5vZkprJyWmDZ45LELW8QykCnTEreRA0aUBTUyTUF+LcA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791881230;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=TIJhBzJL3YJcKCRaHeSs5WmlxFngLH6TlVu72Y5KECM=;
	b=HfbgdTmrjBiZf2bfoO9kMH8I24wh1xLMmj4q48hwjWoEe/jJeFF4LyZivszy3+6poUnY
	 vn8lr57cyKordexQ1DvakLTv1hg12g2AvhdvuH4xPHM6ueSEZ+kvBulF8o/h3X9mCnKJx
	 cHT1wi4YwrOR+K/wfgINJD/ras2b0HXRrI8fc748uurS7w7ZcXSVT0Pk1iEsA3bpESJHK
	 CNFzIbTqdG9QQ22EYG6Woq9kGMprEQNi5K5ZUzjsb7xnZVg35c2d7buU/BlGvUfyZerU0
	 peGhPGJ0drhAQdbkq95X1Pq/YtmNPDkwL89q1tjzzzc7PgcVbnMvOrpDpLaCGKJZ75w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=gvD42rVt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791881230;
	bh=TIJhBzJL3YJcKCRaHeSs5WmlxFngLH6TlVu72Y5KECM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0BG+aQ+MUX/xK+yQzGt+pMCJR8C+2+MwLlnQf30V7PNrpKJAV6KarPnbJNWnMjQJB
	 OVtg85aLULQNRCsaJUbFIk0q/x+LL55wS7kBTG4nYvqdshFfooRcOCUKZ9wbQaW7NF
	 oD+5dcvWdvn65yAuvG4J0kWqfQ4h1ivg8v4gAo9R6zam9abEv1hUpdPaWqPOUuq5mA
	 tt9zBGcJ+80ToNdmJUW6HfVRwlE0yeJC+YgmcUJh2hQMNx7HWUhQfscLziJEs7/fEb
	 tqc4hREcOBoytS2IKuROGh47aFJS4KukScg9CjS5XqSEWBHiPiPIrtELeUC/Gocd48
	 1IgIJmK7z7dCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D8931406D1;
	Tue, 13 Oct 2026 08:47:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 29CD81E9
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:47:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 266EB406CF
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:47:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id imYZYlNuKgET for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 08:47:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 05057406A8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791881228;
 b=Db2XcAlI51mTy0XB0a8pCq9Wh16s2EjrYijt9ygnmSvOdGjqCdNmvP3fMr9+G4YJpMSO
 Z/vIsdWP5eU9TeHhihNfRQtTtOmtPI09arS1kvSDaKhmnMjZJK+OaDLtkpVIIt5EykcCX
 wcvGMBwyeQy6yEgBGFz7X9l0oQ1rAv0VI/uQC0F/JfHByBFrDHotnyFhvLkUPB9HN/uFj
 imin/Kl9fexHz2LGMSdhf8OKSgH93n/3pFM0NzuJUUKWrywvOZClIBHUv9uyZOSYoBKoc
 jXXXLr+wagMlx0mztGgVurElEwNNixfjGI7fwyFsyJbEaL98bVQko/kPodp+nOfsfJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791881228;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=TIJhBzJL3YJcKCRaHeSs5WmlxFngLH6TlVu72Y5KECM=;
 b=XUEUNMQeF78eH+uhIL47RlnEeH/agmP+g4qpqX0kq0znPBIOODoXgL1X/8Y9mzywXkn2
 RAEoTcQa1fJg4lgOLSgy4QG7zFF4L/obBcHMiYSnodax7D3RHqr3+r4iIPrl7l6kSjQW/
 dcGGALNMTxWUCEdqNyMPHW5U+tAJ7kIKrd9Ye6/C8NxqVW13mzhZzVWJZ1nliy61KRuVq
 eZP/ZtMMOUNizHmLUmelmUbrY5t3jLFTfJcAyyG7rv2eBJ7kvsp8ePSJzvE0RiODoPhHJ
 kkdjUS1Baovww5Wdzq8Dyimr71KXWaAExmdDuylMLnYXUIWrAuVZ/GFv7KA/uGh+K6A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=gvD42rVt; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=gvD42rVt
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 05057406A8
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:47:05 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a018dc1f98so21249015e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791881224; x=1792486024;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TIJhBzJL3YJcKCRaHeSs5WmlxFngLH6TlVu72Y5KECM=;
 b=gvD42rVtTBL1PD4Iu+h0o6GksSiSubXaWy0Sxpcg5uXGzDCA1hONC5A+bRpjs0i5TU
 3UxzK8Xgavw+LUu5J4PEXN7Ojv/RnVCEMiug+e/ujQtWiRLANSRd1giRWSTSsgrzeAH5
 9ZmTViGD7uV3MHXImq3eik2h7JuOFo98qiaqS0NS87S3TOFJ750vDZlvqWXoawP+Judf
 2YeF3JQrotNHighke4shzDTMqvLrrIuX3sB2CK0dnjGqcWOElsAH2eLeIu45VnRdVEO3
 RwK4i785tCSuUBLYhwgsZQn5lPiMVlQLHU9FemvDMePdPoXddQagoL49idB+FJFD271N
 Pv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791881224; x=1792486024;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TIJhBzJL3YJcKCRaHeSs5WmlxFngLH6TlVu72Y5KECM=;
 b=HRYKy2h+Ht8keAZvaW2ThKW60qUueDapKvgX//tBTgVQodHoPNqSqUyaIIcGAxKlqT
 BdBvZTS894WoK6IqQo3w++yGmIOr42qEgzcSTIiYj9Pk8PrQqqls8EO1nRRqf2CnrfK8
 FvA9wLwwFgdWCz+dJdYoFo5e78AzuYxTQg0bdRM4kcGiQQfrdzOPv5MFghYdaSDOIxkk
 DOLywaeD4rLrZIG89q5MNs+C8jPkQDk2kO54bowrgEy88tQsHAb25JYJB0Ca2C1tPOs8
 KV0jIuvS3Fq4o2dmOBQRJOaVn9fQGj4UjTCh0Vf9IfzjM/i9W6+2PVfzaBlXvFJLgfpn
 rptw==
X-Forwarded-Encrypted: i=1;
 AKwUvBynnceD0DYAMpPxApZHl65z5YjIJ4Jzx7wtTkltOgUOxPRcst3hYCae/UnjfRptCXm3/UquahE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLLTptovLQcl8gFwPfMDycnPxZP0w60yxo5N2HdyCwmAzvlkHXJ
 6XwB2H7JbF+qwvIsP3AwFMSjMojo88434NNJ0uVinG6OdE85RuWDaQiR6cUaDDzVtYo=
X-Gm-Gg: AYBFou3KaY4KixVXG8MFikTgNdbKpJQ9arNEab/xGP58Oh4RQk31T5NgTeiRuf/M0u8
 pZA28TNKzlIbkEAsLG1ltVx/yPVAWvXDaqt5oGWOihTF58ScFfCNtavWTFUBXDDHFWp+B6qbuuQ
 fcP1st9Dne8BjgRmwRh1PHdOOhIgMfJjN/aCoUErXvSMtFpq/fKtRQxYXuDOMGIG3l1LUcoRM3k
 ZIFRmrIlSYj7yYSn8FnjX87sqx/GBd0F5IwLjksblPZYLz1aCpUfhiOh8/VeU+Q2xbGH5meO6Zp
 VLQ4hb4MljIl+75gDy33kJoJ8QyxcJDmcK6/6D0WLD8kMlM9+cQiXLWigIcIgQQUCg6+tjMVABT
 IMi16GBEZX586MqnYDKA9zlUXw1axpoEpB6bUI4CdOITsZ80C/q8k/kKP0JDb43iKJPhuP/1WMo
 aLsANDVEjBqasUxxRyG6kcNyIcmOUDgfLI4WGJ0LJjtBOOTMdSQvIiFDklNeaMW1JVJDYTZijkQ
 F4wRue/6r11G9B0NMxOX8ldvsjaUFyqbNM3Touc6Zlcq7DPwXxssrUNg0LrPutD3jfJPp+XBMj4
 N+J8byOLeuiI7KKVRQbIoVF2AJwb5v4+d4SLu/z+k7uJiK2/ytyHht+inbgzlg1YaQ==
X-Received: by 2002:a05:600c:3488:b0:49f:e941:d6e with SMTP id
 5b1f17b1804b1-4a18e4c05d9mr228190985e9.21.1791881223908; 
 Tue, 13 Oct 2026 01:47:03 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-8434-7c41-c701-8278-849f-666b-c282.rev.sfr.net.
 [2a02:8434:7c41:c701:8278:849f:666b:c282])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18c85009csm271972705e9.2.2026.10.13.01.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:47:03 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 06/13] video: mediatek: mtk_disp_mutex: add DVO support
From: Julien Stephan <jstephan@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261009-mtk-genio-720-edp-v1-6-4fbcf5b2904d@baylibre.com>
References: <20261009-mtk-genio-720-edp-v1-0-4fbcf5b2904d@baylibre.com>
 <20261009-mtk-genio-720-edp-v1-6-4fbcf5b2904d@baylibre.com>
Date: Tue, 13 Oct 2026 10:47:18 +0200
Message-Id: <179188123837.53105.2668338269271705271.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1791881242; l=3713;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=qGFcERccZG6QVsJbinyK7opc869EkDGH+O9wt+OfQvU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QC8fvpM/oxoiMwJcHSs+mALu5zw3pcWwsSyZoQgQ1vbkOHV/7+m+RwCl5nQp4Yu6WIutwe/Cpuf
 IdHk0sA7GyAo=
X-Developer-Key: i=jstephan@baylibre.com; a=openssh;
 fpr=SHA256:PPc8djUi3lnQXuiRHH4CZ/icbEYOsksrEsOV7pDEmZg
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

> Add the MT8189 OVL -> DVO pipeline alongside its OVL -> DSI one,
> selecting the DVO0 module and start-of-frame source instead. The MT8189
> drives its eDP output through a DVO stage in place of the DSI, on the
> same mutex instance and with the same overlay and RDMA modules.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
>
> diff --git a/drivers/video/mediatek/mtk_disp_mutex.c b/drivers/video/mediatek/mtk_disp_mutex.c
> index 99e46711db5..1a7ea414f40 100644
> --- a/drivers/video/mediatek/mtk_disp_mutex.c
> +++ b/drivers/video/mediatek/mtk_disp_mutex.c
> @@ -51,7 +51,10 @@
>  #define MT8188_MUTEX_MOD_DISP1_DISP_MIXER	30
>  #define MT8188_MUTEX_MOD_DISP1_DPI1		38
>
> -/* The MT8365 and MT8366 DSI pipelines use instance 0 of the mmsys mutex */
> +/*
> + * The MT8365 and MT8366 DSI pipelines, and the MT8189 DSI and DVO ones, use
> + * instance 0 of the mmsys mutex
> + */
>  #define MUTEX_DSI_ID		0
>
>  /* the MT8365 shifts the end-of-frame selector by 6 instead of 7 */
> @@ -82,15 +85,26 @@
>  #define MT8189_MUTEX_MOD_DISP_RDMA0	4
>  #define MT8189_MUTEX_MOD_DISP_DSI0	22
>
> +/* the DVO output stage replaces the DSI on the eDP path of the same mmsys */
> +#define MT8189_MUTEX_SOF_DVO0		5
> +#define MT8189_MUTEX_EOF_DVO0		(MT8189_MUTEX_SOF_DVO0 << 7)
> +
> +#define MT8189_MUTEX_MOD_DISP_DVO0	21
> +
>  /**
>   * struct mtk_disp_mutex_data - per-SoC mutex data
>   * @dsi_mod: MOD0 bits of the components of the OVL -> DSI pipeline
>   * @dsi_sof: start and end-of-frame selectors of the DSI
> + * @dvo_mod: MOD0 bits of the components of the OVL -> DVO pipeline, 0 on
> + *	     the SoCs without a DVO output stage
> + * @dvo_sof: start and end-of-frame selectors of the DVO
>   * @no_clk: the mutex has no clock of its own
>   */
>  struct mtk_disp_mutex_data {
>  	u32 dsi_mod;
>  	u32 dsi_sof;
> +	u32 dvo_mod;
> +	u32 dvo_sof;
>  	bool no_clk;
>  };
>
> @@ -145,8 +159,19 @@ static const struct mtk_disp_mutex_data mt8189_mutex_data = {
>  		   MUTEX_MOD_BIT(MT8189_MUTEX_MOD_DISP_RDMA0) |
>  		   MUTEX_MOD_BIT(MT8189_MUTEX_MOD_DISP_DSI0),
>  	.dsi_sof = MT8189_MUTEX_EOF_DSI0 | MT8189_MUTEX_SOF_DSI0,
> +	.dvo_mod = MUTEX_MOD_BIT(MT8189_MUTEX_MOD_DISP_OVL0) |
> +		   MUTEX_MOD_BIT(MT8189_MUTEX_MOD_DISP_RDMA0) |
> +		   MUTEX_MOD_BIT(MT8189_MUTEX_MOD_DISP_DVO0),
> +	.dvo_sof = MT8189_MUTEX_EOF_DVO0 | MT8189_MUTEX_SOF_DVO0,
>  };
>
> +static void mtk_disp_mutex_enable(struct udevice *dev, u32 mod, u32 sof)
> +{
> +	mtk_disp_comp_write(dev, DISP_MUTEX_MOD0(MUTEX_DSI_ID), mod);
> +	mtk_disp_comp_write(dev, DISP_MUTEX_SOF(MUTEX_DSI_ID), sof);
> +	mtk_disp_comp_write(dev, DISP_MUTEX_EN(MUTEX_DSI_ID), MUTEX_EN);
> +}
> +
>  int mtk_disp_mutex_ovl_dsi_enable(struct udevice *dev)
>  {
>  	struct mtk_disp_mutex_priv *mutex = dev_get_priv(dev);
> @@ -156,11 +181,21 @@ int mtk_disp_mutex_ovl_dsi_enable(struct udevice *dev)
>  		return -EOPNOTSUPP;
>  	}
>
> -	mtk_disp_comp_write(dev, DISP_MUTEX_MOD0(MUTEX_DSI_ID),
> -			    mutex->data->dsi_mod);
> -	mtk_disp_comp_write(dev, DISP_MUTEX_SOF(MUTEX_DSI_ID),
> -			    mutex->data->dsi_sof);
> -	mtk_disp_comp_write(dev, DISP_MUTEX_EN(MUTEX_DSI_ID), MUTEX_EN);
> +	mtk_disp_mutex_enable(dev, mutex->data->dsi_mod, mutex->data->dsi_sof);
> +
> +	return 0;
> +}
> +
> +int mtk_disp_mutex_ovl_dvo_enable(struct udevice *dev)
> +{
> +	struct mtk_disp_mutex_priv *mutex = dev_get_priv(dev);
> +
> +	if (!mutex->data || !mutex->data->dvo_mod) {

any reason to check only data->dvo_mod?  should we also check for
data->dvo_sof?

should we also add same check on mtk_disp_mutex_ovl_dsi_enable?

-- 
Julien Stephan <jstephan@baylibre.com>
