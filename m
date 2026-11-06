Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F74B606A328
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 07:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sGLCJIQo;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=h0DL4SkL
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA12580FD8;
	Fri,  6 Nov 2026 07:16:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HXO-nWuw-WgK; Fri,  6 Nov 2026 07:16:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4336180FB1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793949367;
	b=IgmiPRxvRZFH/kB6j+WLu3b35Gfo4ogURANcydNvxHplcU8LorXfad/z5Q1sHiJXq0Qm
	 6z8LeUvJTNprjjxL4WB+FEukUPczvI2YKIUvdMkx1tFjFjAOe9E/1erMpQVsLz1gOkGBH
	 XwvdG8XL6IJFfz//qFOAnc0Kk2jS/ttHT/Ndrc9PSBH+QpIMmdsKU79OuRkT3D8bDuS4T
	 Txw5Ythr8rwAJNOcQ9RhMGI0KNdPz87vOh2TEl3YSXoKx98LXGy5eD85EZHt0KiiO4pBE
	 nK0fjTUKZwk9zrqnxJ6EFi912ca/z0mwuiwXB5njzxGGN6TF9RWgYaTi6vZr0YOHtCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793949367;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ap7y9KJZgpB9smIQhs9B8wtHHWuLFeg4RiGGOAbbJHE=;
	b=EptVIsZBjd0z7y8zacwGo+uaTOVJU7z3cjoLfKtYJD5AjWI3dZqWL+wNRCI8N1Eka2sH
	 0vewb/Za5iyiKOyDVcp8n/iS9qvnOUQBRxgleNtEWX0Olv8F/ZVZz/5/qrPi/zoXq7rUN
	 6Ee0IIFDc1FGMJGwekURJncm1WaigGkjEnQZ3XIR0UzMYNyw+TXM8Q4HLtyEDWYTH8KLJ
	 atSUdMb3yESWj48SEt2nZr9qJcP2xnsdHfBJlrbFP+OP8MjPU8znVnmMROKII0Nj22p8p
	 YyBGnEVkLqQYm++vOwfWk5yZ4ypguwQBf76HB8zzorRHgjpl8HgU8mJpd6y6uNp56BQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=h0DL4SkL;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793949367;
	bh=ap7y9KJZgpB9smIQhs9B8wtHHWuLFeg4RiGGOAbbJHE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sGLCJIQoQfq40L64lKGc8wBbtV/u3mqNp02HsjtJH1O0l18cyA/AuKPeArEDP8hcr
	 IZVFUpAssUnP1KjgYDo/yP5qI52TUwYMCUM6ILrm8Mqzw8qNw2V7wXqCA6BBmG+8c4
	 MhAU80qkqv0RDhF/Fnc71eRoecjd2ll/Hkn1febKSPj6W4Vkeu9i1JPT1n5+EztVvK
	 PTaR4SUlZCNzJOwsoLkfPPqgbX1a21Y5Xs6nAY+H6rQp6k/Zq3l23qmtWTuUf1ubQu
	 96sOTpJUP0xVVjFLrJFuIwtKmnN6gq+Ya/PzkRZo/x2XGz5xRyk8RXpTzecSIj/v5K
	 tZnje1e0KNfpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4336180FB1;
	Fri,  6 Nov 2026 07:16:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C3D3D2FE
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:16:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B53B880FB1
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:16:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cdfeqqQ-1xiN for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 07:16:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A015180F95
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1129"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=h0DL4SkL
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A015180F95
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:16:03 +0000 (UTC)
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8b0d91601bdso12338037b3.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 23:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793949363; x=1794554163;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ap7y9KJZgpB9smIQhs9B8wtHHWuLFeg4RiGGOAbbJHE=;
 b=h0DL4SkLrb8wL5zR9UHA/bATtYyTTVkxVqp8lSwYbWh20aCNDaNK06WrsQI+bEnlPX
 CoNbNq0L2OYpfAKAb6AptIeJrBJizO7bL7woSwJjncFz7sMxAohFKhmX+KX89AHb+NA1
 NVwy7tUKwZhF6UA1iniKtqXbTSW6IUm4D1x9iNqxXwAIml5JPxyoU6UQD0gve4qPOhDO
 LE/IHP73gzRhsCYsuNdrkoufHMYmlgtK1H5wQ87R51Oc8PceMh0hjZ7B9G8LOPT3VLa3
 IdJmcxesKlY6vQwe6ruKzCQBsl31aBgb0PWr5ZAHMENXDIBcI1sjV4YFC1g3iB0t9ylq
 4apg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793949363; x=1794554163;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ap7y9KJZgpB9smIQhs9B8wtHHWuLFeg4RiGGOAbbJHE=;
 b=BlIRWo9mPX790QKGj5n+tFNMHSg6+dc5GXlcgeW4CNOYEKAnpwPL+74w7/h+mFBkRX
 B4jFaqz0R/0Lk1bt0HZGvFZED0aFZXnsbOAOVHT84W5zab9XAv94fYjdGSZnkZPfzRAr
 IjYMgyxSnzgUMk6LFFQiIo7RdSdaJdVTRzSOxqdODAy9PXNwPiqyzHvTnEwkKOUr2/hM
 xulKNYmB+lsT+YSNeboqpIJbBdEirNWQoUjMqRUOOpI7S2cUloMb4+0pgr/mg83E12i1
 jWJKnbCYWTdETc12snAVG/0CTcTJ4Hv++iwciNNW+RBNtQ6ZWgvX9Y0DTJO7juaD9vfU
 eROw==
X-Gm-Message-State: APuU4Z/xfXSP5VZAyRFM8jsBiM55ElIurWH1FqQpZoTPoGKufGH1/6A7
 fpfwhPozkA4MclmkAMCFO3mxX6Ii1R1Zd/TNrbzVOgfyojLMSRwLhKcLQF4t44HmowMvPenZ15Y
 AEi5U1Wl4un3so9UKAtfMOQprnPGY5j5IlsdmZtsqsE5/FuQFQk0r9onkPg==
X-Gm-Gg: AYBFou2q3thnnqqTA8mLguLDxhxVPZJ3/BXrxLkjinCY3CoGwTw01rfRNh6daQk6Aws
 tnJABo2PaGI6+N0qndMcoEfmhvEyHcv32bo5nUK6w7cwZdJkcBShHsgKD5KOwotQniA4XfGvgnd
 +bp5jt4Mxkoisr3gKl0D1E+K0seaplxYFAdovNiGUwyKQfdVYIzABVdMUg3wClm/5+XUqPkKuIv
 5FRRW28nPHYTq03Hkwikt1mk/ZeMIDWk32GsyzGcxJLmfbjSHAHNTlGi3bv1jHqMKoMRPdk7ues
 wR3NX1oMJaobDeyt5DWuf4ji/UrNoOcr5uFAbceEMCYVwmiVf8pDk0iQM1oA1VUX6F2sPTGRpkN
 eJHHUKmV8JpzZWgqdWPztAFKL+DnW9u65Nu8dxlW8tr7cIlOmBFYauoU/Pqq5i5g5DZQ0Qem9Nz
 sdc63rpUbWI331jairs+7fVfRAOu2k8fisaFI9Z0p0itFCYiPdMwI6rvJDRnRFOApHSf1iwtEmk
 rZVXzXmo2GV9e+I6M0eRv3wvVVwBb7shsVBPypOiQUHRxqaljesgn4yXunA8OcX0d5WkRymrEJH
 mSnOwxQ/dSsBTEyNfiFTZaA7mw5mjClyNYWnWDYMiZN/8pwzoOLYMElRBEp9Vu5ObBvrJrYfg/+
 rblXCzzNHLQ/+JZYKkL59GadeCzBwlJxLQj/RVCZ7PPS0yTJiiTwrUbEtb8ISrt+cRhhibWIQbc
 WFsJs4Wz0fC3a7075154yiDxVps6KE6MgvuXs=
X-Received: by 2002:a05:690c:4428:b0:8a9:8744:c07d with SMTP id
 00721157ae682-8b328e17a07mr26270387b3.18.1793949362523; Thu, 05 Nov 2026
 23:16:02 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027163252.378154-1-tkirchner@emlix.com>
In-Reply-To: <20261027163252.378154-1-tkirchner@emlix.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 6 Nov 2026 09:15:25 +0200
X-Gm-Features: AclHuK-CqW8B7mHCd99cB1hD5bFZ0C9ippqQ0567i_UqSEC00yhD2b1tOaH2lw0
Message-ID: <CAC_iWjL2rmPRxGT9wJXLvLsnpZdSitMqc8+SbTvKjXzWY3d_aA@mail.gmail.com>
Subject: Re: [PATCH 1/1] tpm: use phase-specific CONFIG check in
 tpm_uclass_post_probe
To: Tycho Kirchner <tkirchner@emlix.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
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

On Tue, 27 Oct 2026 at 18:33, Tycho Kirchner <tkirchner@emlix.com> wrote:
>
> CONFIG_TPM_RNG has no SPL variant. With CONFIG_SPL_TPM=y and
> CONFIG_TPM_RNG=y, if a TPM is used in the SPL, device_bind_driver()
> then fails with ENOENT. Thus, make TPM_RNG a phase-specific symbol.
>
> Signed-off-by: Tycho Kirchner <tkirchner@emlix.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  drivers/tpm/tpm-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tpm/tpm-uclass.c b/drivers/tpm/tpm-uclass.c
> index 0fade2dcc0a..26cfda90ec3 100644
> --- a/drivers/tpm/tpm-uclass.c
> +++ b/drivers/tpm/tpm-uclass.c
> @@ -156,7 +156,7 @@ static int tpm_uclass_post_probe(struct udevice *dev)
>         const char *drv = TPM_RNG_DRV_NAME;
>         struct udevice *child;
>
> -       if (IS_ENABLED(CONFIG_TPM_RNG)) {
> +       if (CONFIG_IS_ENABLED(TPM_RNG)) {
>                 ret = device_find_first_child_by_uclass(dev, UCLASS_RNG,
>                                                         &child);
>
> --
> 2.47.3
>
