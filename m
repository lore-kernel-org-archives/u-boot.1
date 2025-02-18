Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDABC02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 07:38:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 829BA8043C;
	Tue, 18 Feb 2025 08:38:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iZNRUQsw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2056F80737; Tue, 18 Feb 2025 08:38:10 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 030DA80104
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 08:38:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-abb999658fbso217938366b.3
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 23:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739864287; x=1740469087; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GL0znVOupzF8Gc+pjFLvuX3uebBJI8HmPgv3XDXxvSQ=;
 b=iZNRUQswLh9i8TGFal2yGdwkck1kWEsdaUyJZsYV67zsVUJL9W5tdDri3MGQxuoPfB
 bhJUlbYmTdpPPmgVzfLWlxRGR9sd8Tu1S2JvCgE5OiGejP3uAMu0qXKW9bMCV8hlbXrX
 NbwZUMqBvAb5Gtuv+rm+252s+gCyyEzs4bsmN6a/PQPFFuKv7nggGFuxMuqYrpOzUXkX
 jtpNukKyDnboGY1OX3SBcmXXbG7c1vKl/aqRpknBQcZezCVZEpnOrz+BBsHV3n6BLBjr
 q+e0eWKmJcAhMaTfyqcoTmThKtjWeA1gzy3NEw5Nwyw2VyUJHYXKlADGMZ0MRwUAPxyO
 hVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739864287; x=1740469087;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GL0znVOupzF8Gc+pjFLvuX3uebBJI8HmPgv3XDXxvSQ=;
 b=NQx0G/2OgopYmr/63l/5bg7h1uz6a7NQNVyoZUvk+66KNRWgfdrfK5lRpPVxtcY6UQ
 IXlC6Wg25D0+nzphbLJ+2PfqWefHt3uCsCkYQCrTjK/tbhdWjnFd5UTmRqG8udoWLIKB
 V4IpF9aNG+9Z59IlpHdFzm4OW5fE6wxO9ykktXkOajYM8WgBJyphgQnmdeGnPpYlX50+
 a2ZsFV/yuOSzIKvCdF+jmMFZhNU1V1Ay1Eruz2Ar+RMRrf2OjanuDQW9I9PPUA6uci9j
 0GtiiUUpuDrHjC3iHY/1s2nkewXex4GMe1AODzGZHarWacHpMGcNdhcuq7Yx8HoJi+Xt
 P9Ag==
X-Gm-Message-State: AOJu0YwoU3fuY00ev+LHVVfZVBP9hEqJRwmgyjzhIRBmzHqZTyG6aEu/
 zkMOSiqDmvGsw06nLebJpS218zRVCSUb/eSNNoeKRJzcGWXaQMteO200mV/k0OTc+B4LQuBixkT
 R
X-Gm-Gg: ASbGncsw76+pqI+96nssrmkMMI6YJHAuAXKy76YSr6Z29+7U6/ZfwkaoKR/0IBxjt1W
 I5Va2a4puYsLt50vt7dwMr/8v7yjrLyB/kpkZtrNtd6YPqnKHLXQPKGrVtjmWflhK5hGMNh4/D3
 q5P4z5nGoWjC1zRkGANkoRrOehFaF2f1nOh/fQp6VwM0Y4cT4FfOZ+zpgwSVk5HOklwlQY2OcLC
 m73NV/uBeKVsJVwZ+MkGY2iCNQkmuzxh/GKsLmMdmRKO0PfEXkbOktqW3MMxRnDxNxloKzn5Zy5
 +sAlnwL68B4bjVsWssoD+7gm7jcGSga/2IMCM4nqwpxqwkE=
X-Google-Smtp-Source: AGHT+IHCJBdFqMkgHHMidDcW6feT25N9mDtfLhGVoohNKT00IdA+G+Xtroo1dem12+zaTx72QYSDEg==
X-Received: by 2002:a05:6402:2385:b0:5e0:49e4:2180 with SMTP id
 4fb4d7f45d1cf-5e049e4233bmr17384573a12.25.1739864287376; 
 Mon, 17 Feb 2025 23:38:07 -0800 (PST)
Received: from hera (ppp176092155198.access.hol.gr. [176.92.155.198])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aba532323cbsm1016769166b.14.2025.02.17.23.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 23:38:06 -0800 (PST)
Date: Tue, 18 Feb 2025 09:38:04 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Michel Alex <Alex.Michel@wiedemann-group.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/1] tpm: fixed the nv_define_space command in TPMv2
Message-ID: <Z7Q43GmC4mpcG249@hera>
References: <AS1P250MB060864865460745C69F23D74A9FF2@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS1P250MB060864865460745C69F23D74A9FF2@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Michel

On Thu, Feb 13, 2025 at 12:43:34PM +0000, Michel Alex wrote:
> Added 2 HMAC bytes to the command message

Please cc the TPM maintainers, otherwise I might miss this patch.

What the patch does is obvious, can you add a better explanation of
- what it fixes / what was broken?
- pointers to spec that define the hmac size and placement?

Thanks
/Ilias
>
> Signed-off-by: Alex Michel <alex.michel@wiedemann-group.com>
> ---
>  lib/tpm-v2.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> index 9ca7933c094..4a082af78af 100644
> --- a/lib/tpm-v2.c
> +++ b/lib/tpm-v2.c
> @@ -264,7 +264,7 @@ u32 tpm2_nv_define_space(struct udevice *dev, u32 space_index,
>  	 * chunks below.
>  	 */
>  	const int platform_len = sizeof(u32);
> -	const int session_hdr_len = 13;
> +	const int session_hdr_len = 15;
>  	const int message_len = 14;
>  	uint offset = TPM2_HDR_LEN + platform_len + session_hdr_len +
>  		message_len;
> @@ -277,11 +277,12 @@ u32 tpm2_nv_define_space(struct udevice *dev, u32 space_index,
>  		/* handles 4 bytes */
>  		tpm_u32(TPM2_RH_PLATFORM),	/* Primary platform seed */
>
> -		/* session header 13 bytes */
> +		/* session header 15 bytes */
>  		tpm_u32(9),			/* Header size */
>  		tpm_u32(TPM2_RS_PW),		/* Password authorisation */
>  		tpm_u16(0),			/* nonce_size */
>  		0,				/* session_attrs */
> +		tpm_u16(0),			/* HMAC size */
>  		tpm_u16(0),			/* auth_size */
>
>  		/* message 14 bytes + policy */
> --
> 2.43.0
>
