Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76697606A31D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 08:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zyz0SBiS;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=etNK9oYg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2875C80E2A;
	Wed, 28 Oct 2026 08:41:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dWFR5MuF4zJw; Wed, 28 Oct 2026 08:41:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6354280DF5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793176906;
	b=jJTE0sR14C6llfx9e3j2OtiiArFAbKBnD/zipxidCGI3Af1ltkRkGbpDi6R4OxSJY70K
	 oPuZA2KzPesHTzu1bXTd+ZgcjGWcnXGHK1dv6aBtlw+pHp1H+VU9/Vd8iLcc0GZuoZDtI
	 PvlJo85SX/31PJ8bUb6yVD20r+AEkF87m3sP0JjGTqZ+abgDZAEGwanixxkTojAXFgQ9X
	 CBaYG3iBXNabYM3JV7D7X6rZjAfhO7al+wqpfh6btaAOoKHQkWBlrkyxy4OGeqMoAf+zj
	 +U5SIx+Bqz6CH1IDASEaXxVgR3SzUV2nusYHvRHsopON2PcFHiVrJaF8mOKfnnUhkQg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793176906;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=27nMZBp8gmGX7B1joT7TERaV4+3+VtjmecTGJZHxf8A=;
	b=H+pD3Sx1zigfgNu7ZbxX/YxNuGT6MFvU+OdqOrD2KydekTScqPzuHEu1zJmn7EOb0Q0l
	 OZvlmDvpjLSUaHm7tbzntyVNojemhj0TNZ/8sMhwLM1fYVporejC8zbxgYu/bF01RbnwS
	 5IL0PLzlSgNcU/yTW002XV1kFQXZEXqGzPZQLfGejO+gd4gwhq9kNMxMkTqoQ1F/7+6HU
	 kky/lxYVgIwZOQd6nlJiRHSEMeipJ4ZrTfWvGFnU1AO910gZghHTPyTcML//430hhPV0M
	 Sq4iNif2btqovKJluqT0LWON7xJsF6ON/HeT2twjR+kYCRrQ/2O7oVOeYE1H8Vr/kRQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793176906;
	bh=27nMZBp8gmGX7B1joT7TERaV4+3+VtjmecTGJZHxf8A=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zyz0SBiS/1eLlOto0cbaUVyQVaVnDTv9PYWzzNoDUKa1Y2htaBj4UlafaZ0enzpKR
	 76wimENOu4/utNmM30nOv/RnCcxM1wlX3Xqth4uSqBVyU+Ww6SWOv0PwUE25Mb59W4
	 8z24xnsQ8uwrHf7OXJqOogKWMrpo9uasZzU3BAFjSnJVGtASHAGtVjezfD/j17jK2m
	 xbMIFe18AHYLvtq/nN+c4SIMBkw/XF2KQ9iilA7p7tnKfT3LZnBGpURqy8DRvVolzT
	 Bw0f9Br52B21YMR2+/psr7ADPH4lGmY61qwWA+RmUIcgeNv5fOD/N/B6QNkfT63aE+
	 yflxoJ4CbVzfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6354280DF5;
	Wed, 28 Oct 2026 08:41:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E7DD4BC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:41:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 147C060658
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:41:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XcH_E7QS-ADm for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 08:41:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 13B49605F1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793176904;
 b=PF2kMJeK24Yy4auTDu6JWZd/3q1thQOlkwzhOE6bmJUOSuEtw7PLEuFZEz5gzipVAR7K
 3w+m9hBWiaWCRHS3N5G8/w3ONu2RVsQpz7ozosdb6hBfPOY5WEfONd6GdDm1JhFs8oroy
 7fWU5A1aD615ldsjebijD7axPPPnucGMZF7VXVVrbmG4BkEan/I0yEPuQ9iACytz1DXXK
 LmXy/3RAG37D/5OLujRtfTQXab+Yx2HVpmsXrh4XUsdA5GZO2hYBjtzm5yN9jPA5gUtSu
 lrw8pCBXe8UxBBmRdIOAeLYFWJcHbEF7EpFYLekEt4wotjP6ZCoXttCOyPkwcjjCYaw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793176904;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=27nMZBp8gmGX7B1joT7TERaV4+3+VtjmecTGJZHxf8A=;
 b=dqGxq8AlQUl/56EuF42RmIc3ftANvm0XVjgR8hLGMDvkKVUAxOy245zSTKQJx0ohstVY
 MjX04YQURccERb3scJrW9dR5xC/r2avnDitQcb8VoBotiWCfV/XMvk+7aBHB1BvYKwc/f
 50P3pZNz0XyEuMTTFdeXaQ4d5yllOLUNMnUVKJGbpP8wH+usjMBel/Cp2Ye30KX1Qq46P
 gjr7EcFnCNsq8aWzbZU9M9uC0dZteCkr0XxDeyDw2AmJfwo+FJfAFqhhPrzWIaLkjpFdD
 UJsFCa2m1GE6fYahFHOK18CoKthC9iSHWKJZqzXuP+3yumMkwUlwPoWZlEovbEWEz9A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=etNK9oYg; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=etNK9oYg
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 13B49605F1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:41:43 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6b1ec41d8e9so867448a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 01:41:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793176902; cv=none;
 d=google.com; s=arc-20260327;
 b=nMmPNlu/SepIt7S+kLep9ADJzt2oEfbP4q3FlMNbqcpj+hvmsDb5pR7RrE6MBAWVtH
 9c8D8v2vNHmt/7JB8U6+9mA9gyEVimzTw1BsNIx2apJ0F7KzygFoDlL2Qly3tgT6lPES
 byBa4tPQE9O/DJy8mMiD6nqeGNUdBAO4HlKQ6DqlBu5UWdTCC17lk/9Tbaed1+R16uHc
 nz6zBa9QC+m56wY3tw0hEOohEhA0oUgcsDJUxsPP9vGEkctIQfu1Hed7z//KuYusj/WN
 HMngXdxh9vK44hZl+o2c35LN5c/9U9awvz7/UWzCmGFdM0KEXmJWrWNAiDgT2jQlmqLH
 vJYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=27nMZBp8gmGX7B1joT7TERaV4+3+VtjmecTGJZHxf8A=;
 fh=MobRHbWoZgdLw31Ff1oMaU7mF/Pjw9wcT8En/nD/I3g=;
 b=E4KJWAYrRuX3ozjYStGG41TYfVyg7e9mlDhysmYhMDbogp4WlKSfshIkt1f9VHH/X6
 I/B227ccMA+rOCrElv56gWaKkMRHw7EA8AtVgPXTME8SHHPUNDpQICiDpt2X0PGVXR3S
 9F5y9mnt0yY6QDQrvQWE2tvemMlayZy7XhetCH6PYHFiS4+6+23/ITlznByMUKmLj35n
 RKXLi2Y/i+m7guxqf/DInsqbIqK2qrN9/ue27fHEpiLSW8Zq98yjsE7P1Xv178l7djRi
 sM7EaUbVnao3xFdKvK9pR+Qpy5LlPb0x7ABxwFY/QCg+gIEJaU4GpK3gxa9oec4iLT+u
 g7IQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793176902; x=1793781702;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=27nMZBp8gmGX7B1joT7TERaV4+3+VtjmecTGJZHxf8A=;
 b=etNK9oYgKWkY//6OWc7x4YpFnHBtrDOv/WsHAd+BbEck/XhI9t8pHNMyv3SAGUjBtv
 91/e6sWxBu50qXfJLvvUeNuFfuAuzWobfSe7ktNM0NjcwWFWC+WlOKArkDxPFqeZELEQ
 zmK9QQq4np4OJonUNJcF/Y1MOwHgqd0VHEtwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793176902; x=1793781702;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=27nMZBp8gmGX7B1joT7TERaV4+3+VtjmecTGJZHxf8A=;
 b=ptW3h16Kp0bLSaG0H/5mEbCShKjd+wxkY5WetTzAnM+FhUoW50JZncPJwojM1FsOHm
 tEzT7hp8kEIVTXhR2iaMr1nPAW8LymKwChYzcrACbWJ9aYi71cuFNYG2VHQAqO/JgnYw
 fwPOhLqIPZbd4Erp8ktoeTlWBlR+i3wQhJli8ak+nxOLLtMPyQI2fJmPp3ZZIfnK8Z2n
 piJPhp+8HwLQ0JpUcY0qh5Vkx5x9mxIbO8pRwvtL6S5HXtgvA+ifnVIdFTNVq10e8df1
 DcP5/X/j9pR/dVLNxiJP6o4KT7QJ8Sh3DJHZz8ewwtLUHrwQahfYW48nr1GXa+p/qB1r
 ylKQ==
X-Gm-Message-State: AFq9FYKO/0/g5+OcR4+tKznJ3gbQ06htpL+/J0+R3v9uQ7k0+L8gx1i1
 WUiSegXGQaVbsMmL49Y0CCz2g3KxrDFV1t6G393R2G/7SybCSQzQKxYSxpsMig7B3R4hN86729r
 Rj7kdr/3yNbancRAxkJl/GNF3ZvrtUpRtz89z6B825TEhsxzdlc/PNQ==
X-Gm-Gg: AYBFou1H8uNdGtHsUbsQ7oMr1w2adDXPxUzR1yTcqIiIxB2wtUGrv/vJYoGO2ZBqDeg
 iC4lZQHaQiYezmKiObZ8n7CPYKb6RC0cwu64aHk4b0uPXQBWZn6BaQ/LLmaB2IiRLpggehbcAYV
 HkFexDdn/7ZPs6dhTgvsaor9Ox7YMsEMHoZWPeH9vm6QMz+NBNDHXSxO+5jpnx3Lo1U1iu9PAaY
 zES5gDqo4ujAiQ6UdN4iXjV6IwYM1fnHvtJwtS2G6QY80aMReGS2Sxisxid0IHWteuC3LXf4Kz9
 g4ACm0lCn8ZlzdB/BieEtMkdefMnrXed4DZ3WZwpmkEU5OnRAihad9G5kZKi+aaoKvntsvxfrYc
 aHhi5fyp7QEuY2flWW0EE7bUjqxFKuEB7YpGv
X-Received: by 2002:a05:6402:42c9:b0:6b2:e2:d965 with SMTP id
 4fb4d7f45d1cf-6b49cc0c193mr1020068a12.32.1793176901751; Wed, 28 Oct 2026
 01:41:41 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 01:41:39 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 01:41:32 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261027231552.60390-1-marek.vasut+renesas@mailbox.org>
References: <20261027231552.60390-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 Oct 2026 01:41:39 -0700
X-Gm-Features: AclHuK9IBQfm6ljxH_2Ap24Z3y2SyTIR_vR6yrN1ERPArTPNyvUQy8YR_OxkWwQ
Message-ID: <CAFLszThhg2QQgw0q0tiY4=11Ze4gBTsQbZ=arnKD5QuaCs7nfw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tools: mkimage: Simplify fit_pre_load_data() data
 types
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.u-boot-project.org, Aristo Chen <aristo.chen@canonical.com>, 
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

On 2026-10-27T23:15:27, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> tools: mkimage: Simplify fit_pre_load_data() data types
>
> The fdt_getprop() already returns strings, use const char *
> and get rid of the void types and multiple type casts. No
> functional change.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
>  tools/image-host.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)

> diff --git a/tools/image-host.c b/tools/image-host.c
> @@ -1721,7 +1721,7 @@ static int fit_pre_load_data_key_rsa(const char *keydir, void *keydest,
>  static int fit_pre_load_data_key_ecdsa(const char *keydir, void *keydest,
> -				       int pre_load_noffset, const void *key_name,
> +				       int pre_load_noffset, const char *key_name,
>  				       const void *algo_name)

(not sure if you missed these or decided not to do them, so here they
are again just in case)

The 'algo_name' parameter is still const void * here, so the two (char
*) casts in the 'Can't find valid checksum/crypto' fprintf() calls
remain. Please can you change it to const char * too and drop those
casts?

> diff --git a/tools/image-host.c b/tools/image-host.c
> @@ -1794,10 +1794,9 @@ int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
> -		fprintf(stderr, "The name of the algo is invalid: %s\n",
> -			(char *)algo_name);
> +		fprintf(stderr, "The name of the algo is invalid: %s\n", algo_name);

This line is 84 columns, so please can you keep the wrap?

Regards,
Simon
