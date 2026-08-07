Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552D4C5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 09:04:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5AA3C40A09;
	Fri,  7 Aug 2026 09:04:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id twZv1jTxPdVl; Fri,  7 Aug 2026 09:04:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CE39D409FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786093494;
	bh=3H3NYoPWhl+T8MCnYtjtx7u/1U7I3ndcX87FESdoNvI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LPBorECy/NIVmfCeUe+BHcFrrGM1DgJ/1qxu0m0/KXG7hgPFKe8FLRxxc5dZpmlYO
	 xBoeq/Jfe/Ox8qmzvuldytcvS1ZaZc2SyFhv9NYfqflcRWo9hgPKx/rQH7LVxLHYye
	 NY+r4WNCQsAO1FeMxVGKxr74nETxEM6IW+yzHp94J8ajiiqunxZ4VJ1Gpt14ZJZyzl
	 ZeBkqGs9gZ+gHxcXaAGCEInc1/GxZjy+AI0zCABcQ1sC7Pf/9xCVHWRnNCjI6IbQpa
	 6ADS/1BWnpQHf/pxIFqWJoyLc7uQeqnA42UV/Wua/3nOAga3vPGTOFqvbM3TOoplEm
	 eFsFiM/k4Hl1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE39D409FC;
	Fri,  7 Aug 2026 09:04:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D9A15D3
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 09:04:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BFE91606CE
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 09:04:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mfbb1EqmUzYB for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 09:04:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D216F606A9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D216F606A9
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D216F606A9
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 09:04:49 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c2020421077so512550866b.3
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 02:04:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786093487; cv=none;
 d=google.com; s=arc-20260327;
 b=GnBxAJPe/ezxZ9yJhYYY/gBsG7zccFTTMvEzahCqfA9W49y1Fm1yyRM+PoTMeDS8ct
 gi8wB6ksrb5mTiErQcYevNp6DcvruSJuVibcwjifUv+OZNhk6TetgRxkCBnU5p8S+X84
 vS4Qv6w2jFI68FJzf+VewO3iBj5zfsFIabXeakBCLxamo1Fjtuo1GZDA/UYWx7BpYvZc
 7wgjnr2YRqLA27Oz2MnbLGR+2k2ezmVKt9B9rpXbVha8ueIQTht5JhbvDpAAUpjzlDdT
 IVPt98xYpZY5TpH2FvtzbiMXxJPbF81+fwU83dsbMqVBQt7r9r4Sn6Pum3i8uol5rF7r
 40Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3H3NYoPWhl+T8MCnYtjtx7u/1U7I3ndcX87FESdoNvI=;
 fh=xUJ7PCNoxdNJN6vjL4STV57XEsTGEGWLsStiYCNoKJs=;
 b=RpCjWFppopSTD2tyXncCsOa/JNwuBVMoV6arA7vUWsAQh2KauvpgfTRDes0c4JJAg6
 7JJfqZ+3DPRCs/qCM53I4epf9KIO2usTnbMC1d0FwUIGvIGyZBip8BnhcfIIuGPyAZ6q
 W/n5Cw1cN/bYeMc2Eq2yj+s63nKHHY8oBTwF2bM/SuczQxYQntHHSwJ4Asna5F43wr9e
 jb+3BgqpCxvE8b9d18mOPFDeqSGr6BWW/J7hr1HSicVgxuRsp0ni4oWdzTItIZgvXsEG
 UdAaz691fSdk/UJuC9fn81nsP9oiy0my98UVrmXZEkiY82F/E6QkByG4xcJa1SctjhXp
 H7lg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786093487; x=1786698287;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3H3NYoPWhl+T8MCnYtjtx7u/1U7I3ndcX87FESdoNvI=;
 b=c74Sdx74wWCNjU7KSiZaLawbS+v/kj28b0Pl/fyPUAree8Uex/d3/NsgaHYdxJXAB0
 u/wwbRNlBk4Urg/WU7Tt7WNMXQyoS3mliu0b0l/hFkl250LXuPP99aAT7QieSCvIp0JT
 zbu3wXv+xh2okfluEPuuyuxCHomwjpbP0lRrbad3pJjLezInIMB9dZMlSGBzpuEaOHzU
 3fOi5n2nUNq0FwDH78SX4pF9RHKecxCLtwInjZy+eRF6GQvZX8xWIzwcaSrdBsdvTf+3
 ZAXdMQxbJ/dM9mehyrTqG2w2pQcjOiP7VHyP0GFUVVF5dWc5gdik0eC9oz7DefSu51S6
 +woQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Roy8KSiVmC4OnqE1V/UzLBcFIrU5iZ2+9Its8PDjC4qXfGZsShU5oofkbNFawF+MT4elc1+LHw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyDywIyAwSmB9lR79eUEki1qwTdC88rnGwPFHwwykDf13gdAEri
 xy2jo2ElhhYnUpjNZSDkqYM7Uy5dAwFMxQCqlHo73tmfg1IZ/mTLTwxjnQl9cUOT+JOp+ST0Dpu
 jlJZqnVRyLeFrfm0G0O5DAVv1b2kzyMEuyml6f9H8aLiVkyg/3Qo3bchmpQ==
X-Gm-Gg: AR+sD13BFb/SykVEutrhTKrpZ/cvwD4Lmca+SBbqZGA731Pk8lMjXCyw1UQWLY1vuZY
 9SnEZf/YNZW/24GCgc7WOs9Xl7KXFVoVUoA8y5ZLs0rVwHfmeV8gwdjgAmAXAHFlUVcIziPhDoV
 iSdf0rWRHzDPmyvKgcK4tCjXe/BAr1CmiNhulwEqZznPmBQ13y58YeJ1+Wx3f8kUu+dJcXfvczw
 lqdN2L1hggMLPm9SsjbiswIewnuXOAq4oX9i5wFUajwXR+JmmuXqI5Yf18mCjlVkRrlsQmdTqwf
 ge8YzHO286qKz9hg2Aq44HJ0OHx0oix9LNmEpgm/K6GmA+rlN+JFSZPpmuLS7iEIItxX9KfvAnn
 X/PqYHjQ0QLFC3WptbDk04yWMSHr9hRN+6mP8HxAyFCRhqyODBc0iPJMvs7t2Ajc=
X-Received: by 2002:a17:907:944a:b0:c1f:e9d3:a3f0 with SMTP id
 a640c23a62f3a-c2039ad2363mr863183266b.7.1786093487323; Fri, 07 Aug 2026
 02:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-mtk-clk-mt8189-fix-missing-qualifiers-v1-1-92f3f0e44817@baylibre.com>
In-Reply-To: <20260731-mtk-clk-mt8189-fix-missing-qualifiers-v1-1-92f3f0e44817@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 7 Aug 2026 11:04:34 +0200
X-Gm-Features: AUfX_mxRrXJjNOuYr4DTHW0bCn73mAOZoY-5iVYiJeSJWYTYsQy7yml6hqAbrqc
Message-ID: <CAEHHSvYAE9=L4aoCdy0eGBLEZ7-91_P+s56TTWrLaG5GYmx8hQ@mail.gmail.com>
Subject: Re: [PATCH] clk: mediatek: mt8189: add missing qualifiers
To: David Lechner <dlechner@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786093487; x=1786698287;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3H3NYoPWhl+T8MCnYtjtx7u/1U7I3ndcX87FESdoNvI=;
 b=LoyeLnvuP2Q5NrKW03czGPrOmT+C0iLPVwJyFb8C4qnsOfUcTqZ+ekwO7wa9KjI5XY
 v1kqhrRQHSAxZ8HVWZobvyB9rclXk5HSNcCA7M5hKRNZP2lB+UKPTSAEpQBeRaXBG/FA
 V2mgUhVyfhkXu1BXSL4MxLk9pdgPjDj3kKpcPP4RWEMK2IpWCU4h5XBP2nFTVMrYXmIm
 8xi/ZJjZplVMWJ8bjr/WZDeorZvCvBSeRt2UgQ5QeMR8o09DaS5l/2O8e3rS2OcaQ32k
 xTnfqUWamPjNke3TZDq8zBv05NiixFHCVpmZO8ZKZSgXGF2gXDJ2YzmG+aMlmuhPy0TB
 aJ8w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=LoyeLnvu
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

Le ven. 31 juil. 2026 =C3=A0 21:25, David Lechner <dlechner@baylibre.com> a=
 =C3=A9crit :
>
> Add a missing const and a missing static qualifier to a couple of
> lookup tables.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/clk/mediatek/clk-mt8189.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk=
-mt8189.c
> index 15e040569e7..3724dffcc3a 100644
> --- a/drivers/clk/mediatek/clk-mt8189.c
> +++ b/drivers/clk/mediatek/clk-mt8189.c
> @@ -291,7 +291,7 @@ enum {
>         CLK_PAD_AUD_ADC_EXT,
>  };
>
> -static ulong ext_clock_rates[] =3D {
> +static const ulong ext_clock_rates[] =3D {
>         [CLK_PAD_CLK32K] =3D 32000,
>         [CLK_PAD_CLK26M] =3D 26 * MHZ,
>         [CLK_PAD_ULPOSC] =3D 260 * MHZ,
> @@ -1124,7 +1124,7 @@ static const struct mtk_parent ecc_parents[] =3D {
>                               _mux_clr_ofs, _shift, _width, _gate,       =
       \
>                               _upd_ofs, _upd, CLK_MUX_SETCLR_UPD)
>
> -const struct mtk_composite top_muxes[] =3D {
> +static const struct mtk_composite top_muxes[] =3D {
>         /* CLK_CFG_0 */
>         MUX_CLR_SET_UPD(CLK_TOP_AXI_SEL, axi_parents, CLK_CFG_0, CLK_CFG_=
0_SET,
>                         CLK_CFG_0_CLR, 0, 3, CLK_CFG_UPDATE, TOP_MUX_AXI_=
SHIFT),
>
> ---
> base-commit: 11dfa5a8d20610ad7ca015a25cdcdf0bb35ff05b
> change-id: 20260731-mtk-clk-mt8189-fix-missing-qualifiers-80950f2fbf19
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
