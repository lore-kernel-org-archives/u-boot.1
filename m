Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA3AC98324
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 08:33:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5ACD2810A0;
	Sun, 27 Sep 2026 08:33:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w-6pBJcl3m-J; Sun, 27 Sep 2026 08:33:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8C5D280E17
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790498013;
	b=r6yb16suSXNEv3+JU6dqIz7bXFYSrirYH9YWTTkih9b2t2F12ddgr6BS4EGA1SSnQYke
	 SQ2VRHujX97pAcv/FKRZ+UfRwis64EdnLnFHYjz01P+PPsd7AyDB427UCCzBkZQDUwL8C
	 5yRfzgM04XXinzNA/vVLtRbaI4/+ys4SvEpgADj8xTDCxMVRomdYKCL10EQT5wnPw4VEo
	 +/4d7bKoC3JONvvxaUegjviQcoqPtZFJ9ENT7n6QeGNfGjue2L1GRYvSelHjMOjRiMPZA
	 9TPsQXHXP1ZcPa02HFa0gkkh0AjlSe97tSqeEk9vMmTGVwE3yFeOBxyKHtLnLzxuv+A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790498013;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=dEjWCqn65437tROPF+6UYfjHYt/VkEmP+dFDhdHS3sk=;
	b=ogkrUGT2iFk+z7kuzfo0omCKyolVWuhRcE0wuHRAEvz765TgOc8jfDKe8IcIvfmtEjAd
	 RkIkqBd56aWU2en27cadhI3JFySzBEzRc2+OJ/6GYBvoRRiZmTkuhI9Mp6dIU3TGcE6n7
	 PaCXviuG7tZ9ryqUUJp/ephC0Q0iE1s+RQ5/jLHyuF7n+AvReOAP1iToG6tAbPvgF8RWi
	 k03qQ+Ci8kVVDXkLFqPrFSfM+q8yKgbkcZODFkFH4iE13VhgNJaK7eZ1cvS+wtLmcTR47
	 CvtIAwpyxYZvbbiZ16R6unWKP65Wun7d/+zbgJNSih3Mrszt2eX/By6Qcu7hN73drGg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790498013;
	bh=dEjWCqn65437tROPF+6UYfjHYt/VkEmP+dFDhdHS3sk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mE8ckjG8vBSwhM3pvoiNgEtJCQ0U9LOzJAipwDgdBwqbNXUr2B3tDtNtlhkOrapCJ
	 Wj6ahzENklEdboLZHi48daVQb8znvyV9yT0vki6BUP99tTxryfEFVPts5jPX5NUoLT
	 eJDOdBZWBv/7MzxFIQBT0LL2AriZDzalUD7HMQd0EYXvsAsxt401e0hEDDayPz1hAQ
	 Omuzf6kUm3XlbPd2BAzCYJ7UK7vCslIoLuquxwyWAg246aKPnWXExQPaFbZKbMVDO7
	 OPwzkb3qR6evv53976NQz/rdtAspXhgoQqNxWmq1aODihqnQEZfB+aNtjFC2ocL2be
	 dj9vN9rJt2Emw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C5D280E17;
	Sun, 27 Sep 2026 08:33:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 21ADC2B6
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 08:33:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 13033406C2
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 08:33:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nhJqapt2ucaP for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 08:33:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0D179406AB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790498011;
 b=b5iqohpRjt4ALcqG3QGaWQLH+sXvc3prPODSwAVdK2rGbkg5CqVS95F9CM/74ZuVSogK
 VQY99fuSjyJAUe+3GEXEyKV98FbaEk5PEimyG1bXDv7vH2qLy4r2PqrxkegeNu/8Ymlc9
 rmgkNI5fAKAa7o2vQ01a2i1WKpTFcU/YMdlR8wYq7x708RuovREU+PPpRuXfmwF7B8Laf
 gcFu15zPSxkV3Dc57YoAw4bAoNVqFaZSVsOwxLGhf2+JZObFEEGvCpEgl0QOfIl7sibCO
 IDhWRIT8oHEg03j/QtFgpgNCouqvz08iSfsQlKWLdP6Bs/Zsg5vK5uDV83IDiNKmoTg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790498011;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=dEjWCqn65437tROPF+6UYfjHYt/VkEmP+dFDhdHS3sk=;
 b=X+aCoEaFvi+VOxb0rbMZGZU2mriN5MuMavgE2SqN76FE5+2AZUQLjVQ3bgN3A8L2qbIQ
 L9jE3/UMpSqjZ+SIhqw1xp6Ezih655kxljNSHAQ2AcBLxmdfBanx26UJ1rR2eQNcVPPVS
 sfSCCCqcBeFvaVWb5BIdlMHgWYhVgD6KN9ns6HC7p6yJez+JNcWfry7//N9FgVUaG2qbz
 0c14W3QuqGYJHoWRL1KKN3lsy0amr4JHEZ+emVY2XIn+Ik+Sw54Rk16UUEO0Ff8xdj3E0
 dcTi3drOdObjPQx0v2qWyLWqtU41qSPGv9amFiyw0GgjPxQZ13PuSShW9gatOAidnHg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=N2p63Kxc; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:34::e;
 helo=mail-ej2-x0e.google.com; envelope-from=massimo.pegorer@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=N2p63Kxc
Received: from mail-ej2-x0e.google.com (mail-ej2-x0e.google.com
 [IPv6:2a00:1450:4864:34::e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0D179406AB
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 08:33:30 +0000 (UTC)
Received: by mail-ej2-x0e.google.com with SMTP id
 a640c23a62f3a-c2c570f6f36so128513566b.3
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 01:33:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790498008; cv=none;
 d=google.com; s=arc-20260327;
 b=a8WOy/zzzjrKOdwq8wH1hIvwA2+MkJZzLSW8BaVG+ghaxiycBbRu3mNV4nGFCGtsFt
 8LDnloc/lOGRd5KYi/5ZlxU8xlPQike9/bqHPeUKUK8z6BDNxmlu6bIpEt5wmXuU+HGl
 bd6POZS9ujgnjjj3xewu17KJN81CvxKmTR0YZDUHPJQ0eAjwVT7svuux9v9Sq6QMHw5c
 3CoktXNKNTMpooKcfC+tHen6jCEQSAoNTozkx0unI/1yvg309Ccvpa5eKt3RKrhTE3hn
 N8bmrUftqD1pN3sFwk5MhL7bod1j6ghwzMQjCNvlZG4IykEjn9/YWJTP3zYnBAj9WKXR
 ZR+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dEjWCqn65437tROPF+6UYfjHYt/VkEmP+dFDhdHS3sk=;
 fh=KUkSYol8Pxngg1MzvLgxxAgGjKKz267hkx2NOuW9IbQ=;
 b=DX8DS2m5T+MSf/h9kG1MhwMfyEOEenrqACDz53FWDCpM6/ZvsdVrsd7k/FgylzX8t9
 +JH81pmwkfxO7UNqvJiV2mlxKnDPKe1AEdKfwi1S0Fwv9PKfMX/71xHGqzL3WUkPIE73
 4CK2d9DDtybGxQw0ZsSqxk7xeXDI2A1nC7gaQOYVb8DBeINNgATK+DfnRLQSgsndyR74
 SKmvtxUCl++04+tZ4GtSo033ochG74PtvscjTkWnJk17M+izjvP8Dr95sfcPVp9PbQe5
 mwvcRUu+vexWuN0JFrUy1n9Ac3BcigGPS62TN/TAfbOkgfpO+Zfp4i1f5ecBq7sbZ3nl
 0BwQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790498008; x=1791102808;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dEjWCqn65437tROPF+6UYfjHYt/VkEmP+dFDhdHS3sk=;
 b=N2p63KxcKpexBMMoZQ3xUT6TRy90hBjveDfalU/4Nz/q5ce4NTYxnlUF5sNV02kakY
 zkfKTWuXsTMb8825YR+MKKyVaMFsX9W6KEpnhSEgy8Fz8PLk4Ijy/oPmHGmQOJBKNZT7
 W+ZEVcWDKEfWg748qj8ri85xTG8k8Gg2asV7X6ltgUykZCRzSSw9vpptY9lLk/HDViwT
 RUgCO3qR90HqM2xNi6q/WMjRtgmbosnyeWOVrHCAOQsDYye+JnhvWvOtX7uPk/Gp8UP+
 f2kgqOgUbFM1Ksb0B1QCB2jG4o0Q/wMBZO8krUSXShcgDvbnGgdVq6E6KrhepeLNiFo5
 A0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790498008; x=1791102808;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dEjWCqn65437tROPF+6UYfjHYt/VkEmP+dFDhdHS3sk=;
 b=Di+YHWXkJzxGqQ3r5DCD+thi/7g722vlgVLmlH5ZEqT4ssfQ2gH1/PagkApGP/jIEL
 v4X34a66xBK550PNg4Cz/F+QuUqY6cymcJBSb5hJey7R2mj0oHU6O+20ZYEJuGQXY5Iz
 SvWJFWUjWC6L0H5NdXVHKO7iTcbpfIMV3s2/gYxoU3fm7HDNeFmtaBtToc9u/6T89ixg
 Xjo33V1fsCx48ZrXo+JVG97ampfqY4cK2zZImw6HCk+x9+7Rf5hq/h/NWsN59+xB1crz
 N+sPoYLOhw+RG9mB6F8DtyCzHCCp+YTfzcM4R9ZBnwgI+pHM+2ojYKHV81mubNKqvcoW
 uotQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxaBQBEcCHX5yrWStOPR6tjC4+54ftTJb6M2hn6wpKo5busVZsbNSVkr+5NGx3oaHuuPlRpc5c=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIqBEe56NiE7xebpCw9X3t8wy3oF6hFf7RjL697q1r6IWjQySu+
 gFh8rH3eLgxnRP9c3g3/J1Xyx/YYKkvevISujS3YHk3SaEhkWoe/xfi0fN2ZAu8Vasj760DqBvq
 8maZP+7W3kZHqV5hSPU80LMs+HqGKEXA=
X-Gm-Gg: AYBFou0cZQ3pisA+9yUDudnFT15bmBOLfCeL9dnRp+zpg5wVxV7p/HHGk+toV+KXziW
 zsUPt4Fas0C+aZgASYOTbeurnXeSWBvtlcnXUnZSkS4Lu4Lbxn36PCXvlRfpGSRyIDy+R6p257x
 5tbvoOW5M0294UCtGbIa46aQ6I+Yyz7Bv1fvhOPmbb2KA3eywy0Cj0xj8KMj2NI9fk3sacKTXZy
 Erjy5A1YymN9tdhcpkiHZ7kbLkcQxVt+6N8IHYHnthK70FqTct6JYNuSJ4cjHpEE/rP3anRImAG
 Fjvew5Wcz5UvXrHvGN63WUi7Fo3DxJ4rWMuk4ph23KQfUcbSMJhQJQ==
X-Received: by 2002:a17:907:e8f:b0:c29:63f2:99bb with SMTP id
 a640c23a62f3a-c2ac26820b5mr976427066b.47.1790498008434; Sun, 27 Sep 2026
 01:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260804214442.2592597-1-jonas@kwiboo.se>
 <20260804214442.2592597-5-jonas@kwiboo.se>
In-Reply-To: <20260804214442.2592597-5-jonas@kwiboo.se>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 27 Sep 2026 10:33:17 +0200
X-Gm-Features: AclHuK9GO9_CwreRnBTsMWcUKSy5c9iMR3R88PR0BjQPUkoSeTPnFNQJ5qRGbUA
Message-ID: <CAC928HbEk6wha23vnMBMgpgsDs0ir3q+zWH8pypsHz9TbzwKzg@mail.gmail.com>
Subject: Re: [PATCH 04/10] clk: rockchip: rk3568: Use fixed PMU CRU base
 address
To: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <u-boot@0leil.net>
Content-Type: text/plain; charset="UTF-8"
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

Hi Jonas,

On 8/4/2026 9:44 PM, Jonas Karlman wrote:
>
> The RK3568 PMU PLL helpers lookup the PMU CRU udevice before accessing
> PMU PLL regs. This may trigger a full PMU clock driver probe to get the
> PMU CRU base address from the clock driver private data, something that
> can take several ms.
>
> Change to use the RK3568 specific PMU CRU base address consant directly
> to simplify and remove the unneeded complexity of using runtime lookup
> in SoC specific code.

If we agree on using constants, we should do this throughout the whole source
file, replacing any reference to priv->cru and priv->pmucru with constants. I
know it sounds quite old-fashioned, but if abstraction provides no advantage,
IMO it's just obfuscating the triviality, thus I would drop it and focus on
consistency, instead.

>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/clk/rockchip/clk_rk3568.c | 34 +++++--------------------------
>  1 file changed, 5 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
> index 5a05f1b4de00..eaf51728520a 100644
> --- a/drivers/clk/rockchip/clk_rk3568.c
> +++ b/drivers/clk/rockchip/clk_rk3568.c
> @@ -94,44 +94,20 @@ static ulong
>  rk3568_pmu_pll_set_rate(struct rk3568_clk_priv *priv,
>                         ulong pll_id, ulong rate)

Please, drop the priv argument too, as unused (it was already, of course).

>  {
> -       struct udevice *pmucru_dev;
> -       struct rk3568_pmuclk_priv *pmu_priv;
> -       int ret;
> -
> -       ret = uclass_get_device_by_driver(UCLASS_CLK,
> -                                         DM_DRIVER_GET(rockchip_rk3568_pmucru),
> -                                         &pmucru_dev);
> -       if (ret) {
> -               printf("%s: could not find pmucru device\n", __func__);
> -               return ret;
> -       }
> -       pmu_priv = dev_get_priv(pmucru_dev);
> -
> -       rockchip_pll_set_rate(&rk3568_pll_clks[pll_id],
> -                             pmu_priv->pmucru, pll_id, rate);
> +       static void * const pmu_cru_base = (void *)RK3568_PMU_CRU_BASE;
>
> -       return 0;
> +       return rockchip_pll_set_rate(&rk3568_pll_clks[pll_id],
> +                                    pmu_cru_base, pll_id, rate);
>  }
>  #endif
>
>  static ulong rk3568_pmu_pll_get_rate(struct rk3568_clk_priv *priv,
>                                      ulong pll_id)

Ditto.

>  {
> -       struct udevice *pmucru_dev;
> -       struct rk3568_pmuclk_priv *pmu_priv;
> -       int ret;
> -
> -       ret = uclass_get_device_by_driver(UCLASS_CLK,
> -                                         DM_DRIVER_GET(rockchip_rk3568_pmucru),
> -                                         &pmucru_dev);
> -       if (ret) {
> -               printf("%s: could not find pmucru device\n", __func__);
> -               return ret;
> -       }
> -       pmu_priv = dev_get_priv(pmucru_dev);
> +       static void * const pmu_cru_base = (void *)RK3568_PMU_CRU_BASE;
>
>         return rockchip_pll_get_rate(&rk3568_pll_clks[pll_id],
> -                                     pmu_priv->pmucru, pll_id);
> +                                    pmu_cru_base, pll_id);
>  }
>
>  /*
> --
> 2.54.0
