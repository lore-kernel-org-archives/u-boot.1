Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091CA606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MYBKG7yd;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rVTWNHcD
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D61D1811DC;
	Fri, 23 Oct 2026 11:40:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KgV0620cctwe; Fri, 23 Oct 2026 11:40:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 01AF9811AB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792755640;
	b=tCFWYPYbQRZNHkIRhkqj7a2SKED/1CHoGeEc/TdRsn498bUsgGcfvS93K2bagHsrEdrv
	 fvg/f94qY9G4ZmpwdASAWNW+TnHgAtv8ZMEUQivzNtyH9ejbZQaJoSzZazqwOZbimCP6O
	 cmjftoFrTAi994Vj2Ovdk50M9NdTO8TN7alv24wE97UCryg8RiyQD3cO8CC0oNRzomxDc
	 cwmlXrESzjgnQqL0fgiDTU1VcAHQx3bah7zg8UKeP7iHte26mFT79ei+k34N6pKjh3RPL
	 LxgqU22cIh/FR7DsUuh+NahnjumhvNKHZ4Ra0Caa4xAv4ts23TabYPYZm6d0fR+LMHA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792755640;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Q+emGxUaVpGbn4MT3q8ZkyWE9WI21GcmpIdR3Uwnj5A=;
	b=FdoTD4ClpPVfoxYWmBk0kK5Gtf1eDTbZXpGGvZ1Q+3sPWsqklcz9HND5/EXu5W/ySmWj
	 Iih9Y3IyaCd/AvVJlbXv7L1BL83EeYNIa++7W9XFvRi0I/Uq6+701Cuw4wqKLU8MuT8qH
	 I+JFjdor/VZ8iqqtKWJEsda0nZqkmStRVXzTAnGabrNDamuMcP61EMWLcxGFez8vvmMVM
	 JaR5NoQ3qaIzv15WqmK6MuCnb3oc/9NLza2Ec4sYvU64jhZw3aPT0TAJCGmhU5TApsbUb
	 epFlstQPuUi26zsAAUegZKxiGE6Wds/9mKy2dWhA0TqIsh6yaZoXKuI1/VK70vvIqdg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792755640;
	bh=Q+emGxUaVpGbn4MT3q8ZkyWE9WI21GcmpIdR3Uwnj5A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MYBKG7ydRVljq3bintRFopz+Kv8xl9YJBpWQYpVEJ53lqkLhuM/hEfSwZ8GB4LF9K
	 cK4lneGEw2IAykYdGBv83ZXPC1VN6lVzsiiJ4ZriRhQRP0d1X9U8tTpA1R45SQrBg9
	 3kx5qoFC8ooOEXxaCuv02prLp1h484BIuU0kps+Y/8kSZBsx2dlvVA7SKzoW9dd33U
	 SWxeG2+JEa/D3rWbvIdRFDeIdv2gqfDadIGHqM/87ECfFZ2Wcl0EEfi6yiIYZWq7uf
	 1RQj625RlhDC36pKYzOgwm3+J3JtxKhYjVRMOv08t7Ezg/F9XHB4KlA/15oeCmNkez
	 up31ZN8ogbVMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 01AF9811AB;
	Fri, 23 Oct 2026 11:40:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B94B380
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:40:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1CE5A408B3
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:40:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PAo19Jc0YsAL for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 11:40:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E2336408AB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1134"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792755637;
 b=T6w6rmvhwhfQJGucXg38jQoifxG/aaaEe2dvbivuA6wTttaUJrROsrkWKykPOrlBfIOr
 XasgVaTwURy0YlcJKipHtBR4WDmpa9GemH3mhtyw9VsiymNZx7Uj6brcno64KceagSZgC
 hjb5b7f44Bv4ZZqp9jVBPcM5CdfC8iJ8rFwBkt6Puzx9sHpmBJguAxmLiIP+XC7Xd4p0I
 /d77JSN80q5O46iBJPDL8OverQcpYHl0tgbwTrUBPRu2BbmHvvGvfhPmRdog177Ay21JY
 WVSgihtOZbOAcxhkXcsYSjr4amyq03QyV4JL4ldC+r+zt/FFOEVF88KeA4PhMwvWqVA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792755637;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=Q+emGxUaVpGbn4MT3q8ZkyWE9WI21GcmpIdR3Uwnj5A=;
 b=mT/2FfnlsErq/tpjRTpL6eDnABywf2rbDGhyKfhLBJfnpQw/wy8re98MkJPxNX40bUcB
 yEIJgbbsv5jdoUfm3dlZh/PXUdGT2yvxfwFieRfPojO4LZtz3D+JkuLrEIhaQaH46c3q+
 0ZH5qNxvjJ6qAA7eNj0Gom1vVRlBMiBj6ux0fcbhVcG3d59ycBavZjmVUDCUgqJXLnF3V
 d3Q/wJptYpv304lfHkpbUZJy9QPoDSfJSsNd4Y1g2cGCSiqB3zpVFwaCqTMtor5A/v7NJ
 vXzTEBQ2V4EJkPRtfaFWdaDzuXgSyyxh+fU+tKN8DDVfPS0D/0Kh0YqVIQ5NA/9Uzeg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=rVTWNHcD; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1134"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=rVTWNHcD
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E2336408AB
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:40:36 +0000 (UTC)
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8b06c0794cfso7418807b3.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:40:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792755635; cv=none;
 d=google.com; s=arc-20260327;
 b=ZaDjxf+bBldjuMzei75aTwzZqV8HIBlIqeq5bkD3oJI/w+gQrfE0bf14K1JAalypwc
 JSTxiqatO+qubyXU2+29bN3KX+kzJBGLctTZ71EJLTr2KDtFmPENnHFEDuOiFhyi82YC
 /DJp+ebwtJb8i0awuuqssZAy11+OMrst3SdNQR/k60IXsR2v0moYucsU10XwMtxJLkA9
 qP6N3wJ6wKZ7wECYqQbFK2eHfq3/QcAALnp5abXHIWNCRPkPQxFCpP9pOTBfU2fsVVI+
 46JxXg1STK3Jf5QR50zCVKTiTgwSVz9XWKXH7PqT3ugSY6WYS0Jd/IMrFUZ/mi7M2ZKY
 bvTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Q+emGxUaVpGbn4MT3q8ZkyWE9WI21GcmpIdR3Uwnj5A=;
 fh=gnGblfd3HC0RBv1wmPbiw0dGi7xbHBYmQSSviHbFO2w=;
 b=M7pqTpIFnxobOHKSp6UjhJ9T6HYNfeNHdLR1h677tuaTbG0D3lCVyAQBJdYtgRkKu3
 LZou4Aptz5sEnKHms4QsUIhT+spI78mq7NavtR2gjXTB2YfEuNm0ACBGeHYyhgHpZ8Vq
 LKYgl1w3m1JrXOdI8xb+HTnNc7Wl2QnXof/Dtfp4RSIPVkkf1a+0zvSCiW6+Ak/gISly
 rekRYPzOVYoenctIw7FeuMvdqGnmKZG9MQwUTil1Ay/zOBu9U8PYZqsxTwf4lIxthM6+
 BDjUpaQ70l5KHZq3nFs/kimEvvnFbup8B2fHvrKaSaBZ8rJrC/v8aZ4toG12GlDN/vWu
 OavQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792755635; x=1793360435;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Q+emGxUaVpGbn4MT3q8ZkyWE9WI21GcmpIdR3Uwnj5A=;
 b=rVTWNHcDHVP5GWEYZPTJmMnf76ATK3u4/9xtC8BPQjyVL+dyN6lH2JSzA/A2EB01xF
 XairpvFypjkxNVgzhie4wIOWhrWtgCUM6FT/ehqJut3NrXK8WZmZdAeYp/FJKRqHGqx3
 OtPbJ491mdoIwoKb3F8ee8oC/WL+ZhH7x2HmuTd+0XUgACO4bGG+kwyFOb5ciyQDUJmW
 qY8U4yCkegZVVVLKocHe/CMz3HiQff0Mtwg7ZBCevHdZcQwMH26lSpTrPy6e0E4JxF9p
 8dUcjxQlglSBay1tRPdFiyWikft97NgLHi+jUKN1Tbf55r3EfIqBcYBrY0mOTerrSTf1
 Tg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792755635; x=1793360435;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Q+emGxUaVpGbn4MT3q8ZkyWE9WI21GcmpIdR3Uwnj5A=;
 b=gc+6zOPLAbtExQ/tSkBTyhsicppiQi/m8CfBZnIhYJGRDqJS0brruKVRc3mmU0Bza6
 uUZ/OI5rbiD1zMSK19OOQAuajbjn0YZRHnNi3hATE26iE6WvHCO7uCijigRZQksypFUT
 5SOlFBaBrmEBj1DP7s1DgrVAVJOA3ijlLJpANBwzWU+PryxsbhSpc8rr/V6G05RC+2j3
 2fij8040e37hNfRnCn1f6Ir3iK55ax5N5Hl95Up65VlUBXWhYzx0IQMLmb0ZFxwIK8KB
 tAOQm5OsiuNjaDtWovqSf4P4w7lLWNCVeF2KYtRwEiNYL80XB6Gn3AWMeuQ5DbH088+u
 umkQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwzw39oOASdEcz5VvZe0+oflyGhaAWZZtkWiRGqMRn6aV36Rloq1BgIsqw6uarF6lJ6VGbQeeE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKHcUk02FqRcbM4819ltbHI0YNSMw47ShlFEMU/jZI4VzJHyxEg
 0HSQjB/1mYgxIY4ECHLnlgqK1k/YTs70B3edIKKUdvXGu5NccQjK9ZKUygKfFk0tz83clhYQAJ0
 /yp9/ArrZIsfbjpGbWGUTeIVAbri5Jqikuw/qs4lQDZh9QaOPX285AHk=
X-Gm-Gg: AYBFou1Z6wexbycyw0zoJ/4dD8E/rBHZzRUCQZONf7IcEpPqn37vwFume4OkIy9AT7K
 uuOHIpnnZHGtbco7/8g8SUDdNpITS1UFdyJ1xgImggJMXzCH5DiMqCp5/xUqS8v8FANCefiuOq3
 LgbInXGhHsMSe8qF9IGb12taTn3jh3Notoby6z3NbHtQK3HKvS8d/Odc2rrJQftayUlq1V/AGtz
 eVdwrDs/AcIK+WTbMAbtXozNHfMgK64iLNh1r6PwXgbQUBskgE8hiIjx8f+ZyoK1MkaDkjsuckD
 0OV00usffhVnmRiCY8/hqucIfn7D3MH76eQu+1U6XXBmy2WyTwQIoiZ8a24tdYddS31qQfYuma3
 BLyVjvYsET9P8u6+4G1defnGDw88B2onaUYqhGWulzBrX60ymf6kbtnNaUddbeDMzo68rYSwNO4
 Fxu/mRsl4DvA9I/KXS4UwpqZOxN1eDC2Dpdk6WnNq8dxA2lRUocZmiqsiFJ8JMssZvMd48wgKXm
 KUig68k7XA6XYtY2nwbmGgtIZ/PSB8s0F4nsjVLwdgKtdmKPhaim/8JnOEApeMBxS8atCD4IkaD
 jPkGeb/S27xtoNsGZAdddNx+o9dSHsMledPOGfWA3HIWjdSgSiid2sAP8mrRnb0VV3mJ/nqQxmm
 34PAQd56TLTU3DmrTSddqPFoAhstL8/sEeafSl1YKSK3QZva8Q4QxH55c5JsMg3eX/Kq8/MLXwN
 nWFa06H7o8wtG+qhC2i8QPWPpB9OOQfzBkgX4=
X-Received: by 2002:a05:690c:f06:b0:873:5bb2:6c06 with SMTP id
 00721157ae682-8b157db5f77mr17236637b3.48.1792755634818; Fri, 23 Oct 2026
 04:40:34 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022235602.221357-1-heinrich.schuchardt@canonical.com>
 <CAC_iWjKOd0LSgJhAxDE=emrzgn7pW8CygaSCPSvkK_nyzYD7Lw@mail.gmail.com>
 <81cfd720-f3c2-4807-9fd8-867d465b755f@canonical.com>
In-Reply-To: <81cfd720-f3c2-4807-9fd8-867d465b755f@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 23 Oct 2026 14:39:58 +0300
X-Gm-Features: AclHuK-ZoXPaF74PYmsR0kr1xYmaSDSwh0PiRP7pqmcmA_6li_ULFHREtMvQSKU
Message-ID: <CAC_iWjLPxJ=TV5RtG0yGLSuDyN2GxsVPiJrHE_k6OCKSEoX3Zw@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: fix HII GetString()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 u-boot@lists.u-boot-project.org
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 at 14:19, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 10/23/26 09:25, Ilias Apalodimas wrote:
> > Hi Heinrich
> >
> > On Fri, 23 Oct 2026 at 02:56, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> * Add missing parameter checks required by the UEFI spec.
> >> * Return EFI_INVALID_LANGUAGE if a string does not exist in the requested
> >>    language.
> >> * Handle querying the string size with *string_size == 0 and string = NULL.
> >>
> >> Fixes: c9bfb22296b0 ("efi_loader: Initial HII database protocols")
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >> v3:
> >>          Update commit message to indicate that parameter checks are added.
> >>          Correct a misspelled variable.
> >> v2:
> >>          string_id == 0 is not used by our code. Return EFI_NOT_FOUND.
> >> ---
> >>   lib/efi_loader/efi_hii.c | 34 ++++++++++++++++++++++++----------
> >>   1 file changed, 24 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/lib/efi_loader/efi_hii.c b/lib/efi_loader/efi_hii.c
> >> index 90dff91e5d4..47325f7d8aa 100644
> >> --- a/lib/efi_loader/efi_hii.c
> >> +++ b/lib/efi_loader/efi_hii.c
> >> @@ -910,41 +910,55 @@ get_string(const struct efi_hii_string_protocol *this,
> >>   {
> >>          struct efi_hii_packagelist *hii = package_list;
> >>          struct efi_string_table *stbl;
> >> +       efi_status_t ret;
> >>
> >>          EFI_ENTRY("%p, \"%s\", %p, %u, %p, %p, %p", this, language,
> >>                    package_list, string_id, string, string_size,
> >>                    string_font_info);
> >>
> >> -       if (!package_list || !efi_hii_packagelist_exists(package_list))
> >> -               return EFI_EXIT(EFI_NOT_FOUND);
> >> +       if (!language || !string_size || (*string_size && !string)) {
> >> +               ret = EFI_INVALID_PARAMETER;
> >> +               goto out;
> >> +       }
> >> +
> >> +       if (!package_list ||
> >> +           !efi_hii_packagelist_exists(package_list) ||
> >> +           !string_id ||
> >> +           string_id > hii->max_string_id) {
> >> +               ret = EFI_NOT_FOUND;
> >> +               goto out;
> >> +       }
> >>
> >> +       ret = EFI_INVALID_LANGUAGE;
> >>          list_for_each_entry(stbl, &hii->string_tables, link) {
> >>                  if (language_match((char *)language, stbl->language)) {
> >>                          efi_string_t str;
> >>                          size_t len;
> >>
> >>                          if (stbl->nstrings < string_id)
> >> -                               return EFI_EXIT(EFI_NOT_FOUND);
> >> +                               goto out;
> >>
> >>                          str = stbl->strings[string_id - 1].string;
> >>                          if (str) {
> >>                                  len = u16_strsize(str);
> >>                                  if (*string_size < len) {
> >>                                          *string_size = len;
> >> -
> >> -                                       return EFI_EXIT(EFI_BUFFER_TOO_SMALL);
> >> +                                       ret = EFI_BUFFER_TOO_SMALL;
> >> +                                       goto out;
> >>                                  }
> >> -                               memcpy(string, str, len);
> >>                                  *string_size = len;
> >> +                               if (string)
> >
> > This is always going to be true since u16_strsize() include the
> > terminator. It's a nit so I am fine fixing it during the merge
> >
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> string is the pointer variable passed into GetString().
> The value of string is not changed by our implementation.
>
> The UEFI specification allows to call the GetString() service with
>
>      String == NULL && StringLength == 0
>
> to retrieve the length of the buffer before allocating a buffer for it.
> We must not call memcpy() if string is NULL.

I am not sure I follow you here. If string is NULL, aren't we exiting
really early at the beginning of the function?

Thanks
/Ilias
>
> Best regards
>
> Heinrich
>
> >
> >> +                                       memcpy(string, str, len);
> >> +                               ret = EFI_SUCCESS;
> >> +                               goto out;
> >>                          } else {
> >> -                               return EFI_EXIT(EFI_NOT_FOUND);
> >> +                               goto out;
> >>                          }
> >> -
> >> -                       return EFI_EXIT(EFI_SUCCESS);
> >>                  }
> >>          }
> >>
> >> -       return EFI_EXIT(EFI_NOT_FOUND);
> >> +out:
> >> +       return EFI_EXIT(ret);
> >>   }
> >>
> >>   static efi_status_t EFIAPI
> >> --
> >> 2.53.0
> >>
>
