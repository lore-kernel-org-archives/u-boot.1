Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86319606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eOfVaCfy;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fy7aoKmI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 637F240721;
	Mon, 26 Oct 2026 16:07:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xMSEQKgzXD_j; Mon, 26 Oct 2026 16:07:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AF7454071D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793030844;
	b=ejNqYfcKS060ceWxhZvC5lClBbBC9KrU23GumciVVj32ki7OCGtGaYKCc3eotsR/af2j
	 fgrjEytxPIok6afxBIapkNcl7AB+RCsjSO2JKk8OI9/shGm9HQtHXYd+0flrJS5XbtkZc
	 YEuB0TJo7M5RQVgM1N1V0hzuCh6LyaXBG6rGNQqs2CWogp2s9GhOSY5an8dKd72pjI3Aj
	 58Qoqwmet7v7fn5W9XWJZ2oV1ODJBlHbZuWEe9m+Xb/y9sg3Q+OYObYg6JzReo1bVl37f
	 ny2+3v7OOfOqNAeW8ntEV0xPPw3NTBCByosTiC3sCM0xU1jnZiUbR03zF73WyHltyQg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793030844;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2MJRutecE7IIll1WK+eYK9OkudKZS80BhGXzCaQaRN4=;
	b=eyNBt6nWpEf29zNQpOi5tcgapB+hAcmq2hqRwhHSikZ0UpGoktGLa4RQrrWO55bi5oJB
	 JgtL/Ja7NuG10X6o0H5RTfZTFcPjoCGvxn6tmqcAUTs+Pn//cJoI5jy5gV5DDSJ5uUk2a
	 kVmrkEn9NYQYG2xKbN6lkTyoQe8fFBjEs14f4FLXRsW1yUhXQhmnoVpod/I+Zh/2Y3EeE
	 arZDjoaE4lXH2EveMbP3TUN+CN9OlyrzGz/4dzoVi7u0u9SSQRLNS9MRe8ORgNLF/zgz3
	 SxXp/ZA3JeSoZrS+sxPk5b4Yv9e4WWEVGxC787cb5aB47Dri3PIIDr4lTCdsDs3j9RQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793030844;
	bh=2MJRutecE7IIll1WK+eYK9OkudKZS80BhGXzCaQaRN4=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eOfVaCfyvT2rzC2T1Ohws340U4TgHhfz8hJSMOwEisDa0cKeAbrugsZdZG1wfqseK
	 FObutaELBtupo79D13i7dGwmOKrgTYItA+Q0mkCe2mRC2memKnxyJ6ah166nfqoLDA
	 BUfpI7nBxCZ7rQi+U3+EPgwYg8BbConAm01Rw8iHJY/htEwVeLNyiUTiUOH3MbyjP2
	 8UJl4e5q0Qjja1aU/HUTJHutkKsGyVjxP1qhRKsVslG4/kT7Xfz5pkHaCcXoky+Lcb
	 NHsUlSlnfHZ6KI3wPuEWpWwxTfZKe9ZT3Rgfp9ojQhWw5NRKOoKpRqDQKQuHY/x9BO
	 j722Svj3KyBuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AF7454071D;
	Mon, 26 Oct 2026 16:07:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6589D235
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:07:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4BA5740093
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:07:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 97FXJTvsn2rn for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:07:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 90E1D40062
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793030842;
 b=Z1oADOv7shn7IUBvU/Nuw5fOR020PqSrNsmC1g9p/yyqjMKQgY7f8+x3LG04i1Q4tMKC
 Khv4QErSKNfGmTTw+jwcdfJ+2/6qKjW3d1lA/M9JMaWxb/+Hb9GgXDNb2sTURYBBslgJl
 1VcZUEibscf+bV5FTAbtc8SzSlMF6gQCfGWGT7Es8XMcGsY2xgoB2Er4K1lwq4y6Jd+Vs
 E8piK7HjmRJdoPWjsQ3meo5RxOLJcznev/DL7FBa7EEIyr/UEVAUgdC3pYM4kVG6tscO7
 PKKKXvEJw/qrCs1hgD7+5hJB5G+Luy1nPvi58K81qn0HOsbveNfNL+w70mOZHP27bmg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793030842;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=2MJRutecE7IIll1WK+eYK9OkudKZS80BhGXzCaQaRN4=;
 b=T6nKOFdakiaCbPP99F8YSKXCED3YDW5er6VWy0AimbYsI1QiM5PgJvGBqqlEcMSN6Z1o
 0vuV3H/o7vMxS44z+vEDrkB7GF03pOfVbZVd4N07yEwg3GEa9IiLJ0R6IH9qQDB8Dag2+
 bWu+r2QMAyGR3KN7NORvChQFzTMYYA83f9y/ZzOz7oOanmL0bJBahA4swozZwrqeqlLWi
 6ynO4RFULK2hD9/f6AwhtbbbG6tVzGnf9U4dp6fM4UMXytP048blvn5zRFBY95zq1Pfqh
 2dhII04IlXdtr55/ceW0ICbZfYpLmRQbh5/fXX+cm92DOBMNttFGlWnM5rVa4oqqSDw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=fy7aoKmI; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=fy7aoKmI
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 90E1D40062
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:07:22 +0000 (UTC)
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-cc52c1b8286so29079a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:07:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793030841; cv=none;
 d=google.com; s=arc-20260327;
 b=r/xmnj+s3qJnM3dRZTrvThpFrw6PO6cfO4MFm/WfL+vAajH/GDOKa6sYsV230aYLPy
 Yze4sbppggALI8l/ovwGM1NeLYc4Wmos1gV8AlcLuKhWXXynCT9TH3FpNPIVZgrWWDld
 p0YBhnBHodSaM3TB4NmCOnpUzLq7fFCSgURw5XwWI4gAuV/VBSuJ+YZOb5eVHK6beYo2
 HRq+gIrun+hX2nhe8WMWW/4uAlz76xYwN7t8GxDWv52k34NRqjrubuKj5iydOOg9myI8
 4KoVX8p7XKL3IP8wJritoE7A2QZOvcnyKHXq/O0ihe3tvEc1YZdYRPAKdgGRuxnh1NnV
 +bgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=2MJRutecE7IIll1WK+eYK9OkudKZS80BhGXzCaQaRN4=;
 fh=Vi46RdmyXd0SupGlsPtmZZi6NaJCBu3Vb80GVjkTlag=;
 b=f+Ykfmx9nnqm4ujnPdxrZOCVPPLW8lYNEsVg4l5ZPFA9dgoQaTTm7mU1y7tOcGzKTd
 Yz96al1DOJDPQU6WvCJbN5WFNSJcwL9fHVgVh3r/rRVJES/pUNfgFpTkjOcR5ws5lKr7
 1pB3WlmHLfJRSQ6HTkLlvng67MpH8I4cY54H6ytcgEaworETZgCIGGozAzrk3FXLNJpn
 roEYnW3oVr/pLjLBLcxlQn8qQ8/pftaRJrHNhi2VLD44tGHj0cl1XoPlBRLf5ujAKL5q
 ViqE6kqEAnbPFnYBtEW/K0DKhVbRW4+cz07ebiEG/CCYOVUsX3VRcbNKuZ2TgioAkunJ
 MDgA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793030841; x=1793635641;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2MJRutecE7IIll1WK+eYK9OkudKZS80BhGXzCaQaRN4=;
 b=fy7aoKmIvqOdh2bKa1vWNVoicw+Lh9xvqfeGboWHSvk82Ue8yx7TNlrRYBL59b5ln8
 Iimvr4r8u0Jeo6YFG0gQOXoMdgQA7eRj0TB3w8g2NGIZGoAK89Y83Db3RlQF5mKQFTIK
 GnVnj5uS2pVF4nFefUA6Hw6QzNaA3IxDlkthk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793030841; x=1793635641;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2MJRutecE7IIll1WK+eYK9OkudKZS80BhGXzCaQaRN4=;
 b=XpfT3hKp0SsM8A+K3orOyiz7vSFvbxsCQu1t2tnfEKI4pu3XoVso1iDEohuo8J8DNH
 2Q1sKz2rx6QstnkdcIiAJ16zeueg9YkzwL4vb+A15DkTqcxchgW8Riah7DdYGW/Ij1NT
 FJ/tCwRxle2pVmbPsouawkFqrsjDd6rx8G/w/AyJRVemExmmjuKRpOLUx0lzdmu2jeMR
 JGwwnkB+MggLUclrIPdEKYLswqAbmQuMvt6a9YcgPO57QqRGRkljjV2Zctw86vg1LVtD
 1c2aP+KZ8vDgtuWmsPMIq8EzP6qNjjv5ncAcJsCShXdf3Z32hRBCnWVEsAO4pcIjEc0p
 qWow==
X-Gm-Message-State: AFq9FYLVkJT9gst3yBQojjWyo6ZBpoDFSYTBkVDz2BWwB41CtabXMNmT
 U7PSeCo2m+dYPoMfzvz5PgMnxuLywceLgL6gq/5q3FW+q8phERH6HHXYlpVakWLghveeHvPjFMc
 //+s8g4l0dwpY11Nt3zks2Wz1fMA8rucxID+VqS9d
X-Gm-Gg: AYBFou0HbY/MQxMZoNMEzBk+4K3AjJwK06Dou2bfkBDSm7zjY7KbKVmY74V7GtlkPYE
 OAZGxl5vkghd335Brs6clQUoNCLGXogUZGEgiSxPFuS6u91ESpZte2boHq+s/EziCz9iu+Rx63M
 pR2k+tJBOmSTBKuHzLIx8Ru9hYMdjZu/I+lDvabJm9p3JvI75pyysdkX7n2GMh0btIjTFyhrYFt
 7Q8eIgZl0qOXdhfswNRlyEIbLcHkvi4CIUC9hOTc5QtzomJnjCAaBQuP9s9sXtVf8bpqgxJu+Q+
 lh4dgaKJbCS9vENRVbI7dRXeF+TIJFIPXSQYBPf1Hn5MjXKvcdWCUGpNaZX8WwzTpp3w/8w0h73
 SeTrV1NlXSVSnC1RgWQIdT7CJKNPT3+7aDZE=
X-Received: by 2002:a17:90a:d603:b0:3ae:3e9b:5265 with SMTP id
 98e67ed59e1d1-3ae4029a8f9mr53842a91.26.1793030841430; Mon, 26 Oct 2026
 09:07:21 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 09:07:18 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 10:41:10 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261021-rinta-watchdog-gettimeout-v1-4-e7f3157b8bab@nokia.com>
References: <20261021-rinta-watchdog-gettimeout-v1-0-e7f3157b8bab@nokia.com>
 <20261021-rinta-watchdog-gettimeout-v1-4-e7f3157b8bab@nokia.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 09:07:18 -0700
X-Gm-Features: AclHuK8MXUHKc2eCYePi7D3BANHsBE-lQfHYfjN-5QjvQfGbgmB0J3P4dXZjP1Y
Message-ID: <CAFLszTisVm4d8jZfngRrPwQfXmvJx-k=NfJ=spRYOZ6YEUHmDg@mail.gmail.com>
Subject: Re: [PATCH 4/7] watchdog: designware_wdt: add get_timeout operation
To: juuso.rinta@nokia.com
Cc: u-boot@lists.u-boot-project.org, Stefan Roese <stefan.roese@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Yuri Zaporozhets <yuriz@vodafonemail.de>, 
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Juuso,

On 2026-10-21T08:08:13, Juuso Rinta <juuso.rinta@nokia.com> wrote:
> watchdog: designware_wdt: add get_timeout operation
>
> Implement the get_timeout operation for the designware watchdog driver.
>
> Add a define for the timeout shift used by both the getter and the setter
> instead of the hardcoded 16.
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
>
>  drivers/watchdog/designware_wdt.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)

> diff --git a/drivers/watchdog/designware_wdt.c b/drivers/watchdog/designware_wdt.c
> @@ -90,6 +92,22 @@ static int designware_wdt_stop(struct udevice *dev)
> +	if (!designware_wdt_is_enabled(priv->base))
> +		return -ENODATA;
> +	if (!priv->clk_khz)
> +		return -EINVAL;

I don't think the clk_khz check can trigger. With CLK enabled, probe()
already fails with -EINVAL if the rate is zero; otherwise clk_khz
comes from CFG_DW_WDT_CLOCK_KHZ. The setter uses clk_khz without a
check too. Please can you drop it, unless you have a case in mind?

> +	top = readl(priv->base + DW_WDT_TORR) & 0xF;
> +	*timeout_ms = (1ULL << (DW_WDT_TIMEOUT_SHIFT + top)) / priv->clk_khz;

Since you are replacing the hard-coded 16 with a define, it would be
worth doing the same for the 0xF mask, e.g. DW_WDT_TORR_TOP_MASK using
GENMASK(3, 0). The 15 in the setter's clamp() is the same limit.

The calculation looks right: 2^(16 + TOP) cycles, matching
dw_wdt_top_in_seconds() in Linux. Rounding down seems fine, since it
makes the servicing-interval warning err on the safe side.

Regards,
Simon
