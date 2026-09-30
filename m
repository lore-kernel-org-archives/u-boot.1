Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C12CA5FB1
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 07:57:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC1AA60862;
	Wed, 30 Sep 2026 07:57:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P-ktGHbZnSoI; Wed, 30 Sep 2026 07:57:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E86DD60855
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790755028;
	b=EBN5UVLpd3TouIV4Hjgo9VMGRtIojOPhjqFBJA9gmwTNuP+WR0s3FcqOy6NO3BOIm+hJ
	 bTk8gVyyx7Z0h9ttIDTk/+aFWxa4aaQMdlK8sdb7C817WgF5VGZpdbvBZoUN2hM9EgAex
	 sotR2XJLjvfmfJID3SHBJzZoycC9sk0BkQ9lqz3tvBX09vDaOfnFsz1Dh//G7cNghYhf1
	 7DHC01lJiLk8ZxBj0tJniK3gTIEMURNpkIOLzlVoqMw2CUsHw/n3TjyFMIWunTIfMycjS
	 dbpO6D4FQNNl1WSyZSleBjWFIs5A7ea2kcEd0+bNd+8gkwfhBTE7Kv/26ksas65QZ4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790755028;
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
	bh=5yy1tazquae/ozFEGHm3P7Kx6XM+iF1iyaQvFtMJso0=;
	b=enAUQI8xCaIhJxuSfX4HEAhiy2FqrR8+JXE2G8gCEIy1CqfeiYS7gGfPap/FoR1t8AKY
	 YOuH7WZJSr8niLhlibuoQdqeEMMp/nAmgR2AVJo2CGBKIZubn8IE1+L16rocji9R8NG8a
	 6IUOqZoiFUW6SlvMXLuhgcblpPBbvo37KcPz5ShPDr61mPPLrhBxesrQfRa01fZRtM2Wd
	 G2VnEb4N18v6ShU8au61bwWASt4/IcYPn0e4FM6ErMujHmcXLGdpX+iIz+ZpefHA6vMXg
	 os2ReQw4JKAeogiPhnT4mWlMMJEf2syoMgKoTXCD7txm4lhwqSEc96BhS1k7EWHhe7g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=UBqAb8ja;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790755028;
	bh=5yy1tazquae/ozFEGHm3P7Kx6XM+iF1iyaQvFtMJso0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N1rd/2w8nwJF9jVbkChhH2pB72tUqBSVbOVmoMRPPl5xwP7ZGPYD8ffwVnVJdD4/k
	 j0kPPWljXQhHc85mhSiKqOlNR0VBx1Ul+DHuEignsX5+tG2lxWc8DRT9OXSm5jEnNB
	 uteqfVes1Rw26ypDhT0vzzpmayRUwMnFplLmmGINTMAC0GTVL8CPIh992T+i7GBJkA
	 YzCCbySI/qAaXd0GVK9dJn64EXWpXmFsV1hqAGWdAOOCtbKJK6MJfBAHZBxaNOBf49
	 KSyXXzFQmLLPl6vvwZfjXP7QQiQSAyPsTfvrYsHJSHlHPZuvMhSe9hDi5mGAWYgCF0
	 7ryV3PNJf9acA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E86DD60855;
	Wed, 30 Sep 2026 07:57:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 619963D8
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 07:57:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 52E1C60855
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 07:57:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XldYjEbmf9QY for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 07:57:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 57E4A60842
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790755025;
 b=tf7dvGFoV3WmC8lwQRkWhlUmzO2s0143NxLWD4hhQmitrAN+SgCSHiAtmAt7TYAPaxPh
 V6rplQv7ex9wboSIr98qSDxyWhbhicmZ7Yen18mi5khioM0J2lle7xqyzyqJPM387RU6/
 NVHRx5f+X5kyVJT6qE1Dd6IaLHkBtFpnjxrp0KNPsUV53BGvlXKDUTENmoNfTS+Z1iOLJ
 3Q/VnMs3+w1nzZuRNuikCHNUKj/vr9lLS3inqb7TT2Ki1godzIDZlFyOXvajnAuPjwZNp
 2yTJbnrAlYQmHfsgjQZc1J8ORap/2dYU3CRnaejq6P7MVwRORU5EuxmGdAjfA9bwrVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790755025;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=5yy1tazquae/ozFEGHm3P7Kx6XM+iF1iyaQvFtMJso0=;
 b=k74gWsY9fEAkKqWRTbRiG03mVRi5B4Pz9QLJAZ5EH7Egu8Cn3khZixdZW6zx6Qv/LKES
 uFSuGe8KBUjUDSjOuFRZbg6ajKsD69UUNn0DVvpgesZf0hviyqgQu33DLzuT+xKAjTlyR
 0OLmfraUTNoyfdcqm6SxBj6RPvUnrvcZvtSSIYM+T/yu3NJFpBu4HHHTE0E8WpfELU0ui
 n6IdO4G7elUDYPzuvueqr8hSI8mRNVQovuWa5vwQTUBjcXE4aEJnoE0UNr07QHSxpUNiW
 7xx1hDsXtDJHrFybcTkPefqQoH3CCOiBh63qVixKlaBnyzYTDGuosqHOafNIY3iX2iA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=UBqAb8ja; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=UBqAb8ja
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 57E4A60842
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 07:57:03 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d822dso37170255e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 00:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790755022; x=1791359822;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5yy1tazquae/ozFEGHm3P7Kx6XM+iF1iyaQvFtMJso0=;
 b=UBqAb8jaRXPyJjGnuiJs/D/V02/hdFJaD5fV7pzMlg7tXDwqVM7l03dkH47zUJUeHz
 cfbP4vCxR+hnPMgF561oYOQkaYHHehqgZkyyBLPuKrLvQLy0H4b6GX94lMRtH+hGeAye
 okExsvyBUT6V6Z5Ze/GEC3OiEg6YR7BT9WGu/dqs1EActCsn1xs+pzjplidc/fchuGpj
 C6cUTRHPcg8xHI3zhYqYE0jNN1AgTOEM1iWBUFHso4A5hBpAOuYanFuQhd/vUBOeb9rf
 CzOico1Sh2Ldp15C8k7hsmq9cjLqhs/aJVhr6fMSb422KKoh6EtKe0Tmsush8MDdrtKC
 vUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790755022; x=1791359822;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5yy1tazquae/ozFEGHm3P7Kx6XM+iF1iyaQvFtMJso0=;
 b=0sR1LEmb5QlpOLDDBVFl8rJ+/2r9xWfY3nKs8gmPvbZLOy7qVB6bMGABio+pXXOSZL
 EIezS6Jygno/xXclKGyskKgxOd6CjBchx7zk4RMIGjbM4Ejos6+LCOx9UdlD7aKvZy6x
 MB17TrO0Gh4wsilKmHjNdptdrtPbxhllZOQIHJmWbFdGygqKy4A8NPVv1IxTk7DERuOp
 IhRjvDxMhJI8v/MPn45v5WlyBxvqpeIxhrUrDjPCS2TzwKdgP/EjXlHFh8VOExQrUapy
 G6bOPVnTLhXwMqmdvI6zpWpHq8whLCJGvE/fVisGYPHGkZ8P17iozINkqRAuGzbg2tkx
 bXqA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/HeyfPciigECDpoNCvKSeBtastX5KiPtz9v70NmZlI9v6vSEHL326BhI7LIft/hQp6FA5eq4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kXDSfttNMCa+VRyDvswpAGkfI2pyb+HoPAqYr2NrhIU1HuBVPk
 JImKDLqQlFG7TokcyZUPcC7UHiyobTMyuE+9zrlXkOZZxV9nycYFsbsVPO18iG7rATI=
X-Gm-Gg: AYBFou2QK+NdVz/em4rsX0snJQ4P4gTUlvckeYTeHDTfbFtDv3FMta4Cl4lx1p+EiPN
 f6m9kepNvfTK9DJqHKXswUnFgpwRLMh/Ox2TRxk47Km8WGiH3ytNwe9rk5GTsjgRk0TZ4JbPJNu
 T70OEJA6fsOT0qPOX9pJqmPd8weAiRGtGALMEAzLwcArmfTLlnLDeldd2I9HaSlFYMIw7FWTjRA
 dPIfyxXEJ8CheN84adB3ZvfSwF9v4NZtBcnyHKKVCq/CwNDiONOxzu5N9lL78ZcFrGHRLBaPMzW
 gUG9MDj706/SNEZUElUmKk+i9x1Z7YSkNHJkS5mORHNiE9+C9a1JzgFlR1V46WjtQNuMY6sp+D0
 2EmFHigCKSXgR43MFoWKTeojGVIpwaJGz/dyNECeGaemjumA1ZXVtPO1P4f6GcRor4kctnukPPT
 Wr97yJhov/ZWeor9mTY2USOcqh1M5P506RMfKVHSGVSOou2uIkJsXZuoPo3pl/WIDGr3UqK9xJE
 ofj+TGU8mmq2IuY1YZdVWgD+4IOUcclJuWnROkZrjLji4mxRr7qO19tiJie/LLCaRtnksb0RXg/
 k+6P6mnkqKDUYOxc2nEG15ID1KSnMvlFB2ocgww4fUlw9Kt2ctf7vVY=
X-Received: by 2002:a05:600d:d:b0:4a0:1c10:12ee with SMTP id
 5b1f17b1804b1-4a01c103630mr870495e9.3.1790755021498; 
 Wed, 30 Sep 2026 00:57:01 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a015cf21dcsm29074575e9.2.2026.09.30.00.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 00:57:00 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/3] clk: mediatek: select mux inputs by rate
From: Julien Stephan <jstephan@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20260925-clk-mtk-propagate-rate-v1-3-8c7169b4eeb5@baylibre.com>
References: <20260925-clk-mtk-propagate-rate-v1-0-8c7169b4eeb5@baylibre.com>
 <20260925-clk-mtk-propagate-rate-v1-3-8c7169b4eeb5@baylibre.com>
Date: Wed, 30 Sep 2026 09:59:16 +0200
Message-Id: <179075515607.1985961.10590188925633230211.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1790755159; l=2586;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=yzEDIN0A2yvBoX3Q0cAlfAdvBRJ40BDlhRNT8KDEyBI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGqVRT5mlTZaS6Pt6DRcwcmTAUlnEoE5nPeIjaxalm7BDFY22U29HUjEiSL1erTyWJbqWctkmL/
 F8UZICEBz3gg=
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

> Make set_rate on a mux, or on a gate in front of one, select the
> fastest mux input that does not exceed the requested rate, as Linux does
> for these muxes. Add round_rate so the result can be predicted without
> touching the hardware. Both paths share one helper with an apply flag,
> so they cannot disagree about what a request would produce.
>
> Only a PLL can change its own frequency, so asking any other clock for
> a rate fails with -EINVAL today. A display driver typically sets its
> own PLL and then asks for its pixel clock, a gate behind a mux, for the
> resulting rate, which only works if the request reaches the mux.
>
> A request never retunes a PLL indirectly: it stops at a PLL or a fixed
> factor, which report the rate they run at. PLLs are shared, the audio
> PLLs in particular feed unrelated blocks, and U-Boot has no rate change
> notifiers to keep that safe. Linux sets CLK_SET_RATE_PARENT on these
> clocks, but relies on that protection.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
>
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
> index dd2d7e4e755..78e02963bdf 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> [ ... 133 lines skipped ... ]
> @@ -573,15 +587,39 @@ static ulong mtk_pll_get_rate(struct clk *clk)
>  	return __mtk_pll_recalc_rate(pll, xtal_rate, pcw, postdiv);
>  }
>
> -static ulong mtk_clk_set_rate(struct clk *clk, ulong rate)
> +/*
> + * Report the rate the PLL would actually end up at if asked for @rate,
> + * without touching the hardware. The requested rate is rarely hit exactly
> + * because it has to be expressed as a pcw/post-divider pair, and it is
> + * clamped to the PLL's fmax.
> + */
> +static ulong mtk_pll_round_rate(struct clk *clk, ulong rate)
>  {
>  	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
> +	const struct mtk_parent *parent = &priv->tree->pll_parent;
> +	ulong xtal_rate;
>  	u32 pcw = 0;
>  	u32 postdiv;
>  	int ret;
>
> -	if (!mtk_clk_id_is_pll(priv->tree, clk->id))
> -		return -EINVAL;
> +	ret = mtk_pll_calc_values(priv, clk, &pcw, &postdiv, rate);
> +	if (ret)
> +		return ret;
> +
> +	xtal_rate = mtk_find_parent_rate(priv, clk, parent->id, parent->flags);
> +	if (IS_ERR_VALUE(xtal_rate))
> +		return xtal_rate;

This is already done in mtk_pll_calc_values(), so maybe we could change
mtk_pll_calc_values() contract to return the xtal_rate (or use a out
param) to avoid doing this a second time here

-- 
Julien Stephan <jstephan@baylibre.com>
