Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14269C982D7
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 18:31:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B275A60BE6;
	Fri, 18 Sep 2026 18:31:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vLKKVW0RQZEY; Fri, 18 Sep 2026 18:31:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D884360DB7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789756264;
	b=PKb+Owz8tplzt3Ir8dKgJDH1HzYyXFK0QLwvk/ZZFLqfgIfvin9ouyS2V8Ympa2fxqil
	 OyPzDdpawaFU0yzRTBMuGT3/xxw1aPHQtBj6E/DHfT+mgZMk5uCWnYRkWsT6I5GQWasnw
	 h0p1MJxYuyn95ummMnmfE5U6ZIHEktfNb9zI025067THxvgXyRxNrLlrmEhJaOGXwD38k
	 wqiRATrvkMCyTcuBhl8rI3nSb1tuFZQhkvikvxZm5Us11M13diexQViSdgG5GyI7SlEw4
	 tUCAoaehTFVy7SCzP+uTf/jkeY6CCknQPT8wQmJgQ/beAbJn7S/iMkGRuHyZ+hzbcyw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789756264;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=z5nx7+duNrNl1iM8JjiFsBpSfT+8Nf3t/nDI1RpXAw0=;
	b=g5ASHj4iN4u73UBndztCJnCMSMgNFXVMnAm1HTreqOxPMO9mA2FxJfyjXT6Zx/uCEPeD
	 CIF2E/p5Y5tz4/iXXujCDe5t9/FwUGtESCRzMLABcZDWtvlghaNmLhxPo9xer0NOAV1GF
	 92lMy4HomIPXsNgiWjmXhyIdqcksnBZVdjzlgWyMHxH+YBgNv9Zw1uCHGk7PZ1vAtNlwj
	 2AI/ZdeHR6Mw1MugtWoeHLIFDMMd0VdTnInW2yrHENbkXO5zJvwRg/WRneXAZnSJ765EK
	 wQgkUqw8n+VUeHYVIo7cX3JIrW7BXxDnU/d4NYA1nYwAHrcI8mmj6hmU7pPZhH0B21w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789756264;
	bh=z5nx7+duNrNl1iM8JjiFsBpSfT+8Nf3t/nDI1RpXAw0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eqm2hqLMgHr/zMXHmIboyoHgsmKtuqfgg4kVVaGgkxQPIWyAwtKZg0JtUMWmILV+5
	 V28ENoZSdFkPZBVYzaad3c3dTnAqYL5Vxu5uFQiySsPuNXzBLhrD1iERRg6ooEiFOU
	 T3rif3M7+hbFgYk7O58WbT6J19ZI+xBXO0Ex+7d0em43IA9WKE8IaYb3nqvpUDjkbW
	 KkwWqTUKjEFN2Hmit1h0LocxMUS9hyD+yI+EaRrWy4p8YxvnANVhoNsbUKOoHXhnee
	 np92o7k0AHUjoVtmM0DmyocYamAAOmIDLbXP6SHMDnKWbr2kMDcDmnFAvD0AIjQUKV
	 hCPSA8I7f4WSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D884360DB7;
	Fri, 18 Sep 2026 18:31:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AB7A6237
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 18:31:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 90C9881346
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 18:31:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8gdUBOYU2PJJ for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 18:31:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F2BD581339
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789756261;
 b=ki23ig4IDoofu3TZJZZUjmVjkvEonaQHLS42BgWMTueZQGovrNpGCsZyP5kBx/EqYWLA
 uYAXAl7Pou5PotbXuo/rKSOCaKydNJXXx7pdY7HjOPHXv7w2iZMT1hGtiVD1ygdGVn66z
 kleGT80chWlqJR76Z4u8NSZB2/stYGH7D0vi1uQ8TumySwr2yT0t3r3Y/PWZEJW7SsNoT
 DmTbKYngYvd42bOinjgSAb1upGR+xoNsv8byVtrQ6JE9dcy7oOBTV//L46OsKGgwg2B8b
 GpYVK/LpeFn61+K8AGcYE2GRireXVqeqYQ5Muh/i1u/FNOmkB4tfv1OpmAfZdvRYqwQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789756261;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
 bh=z5nx7+duNrNl1iM8JjiFsBpSfT+8Nf3t/nDI1RpXAw0=;
 b=ra/nY4SCP3coNdoAgxWbovsvagLlEfwSD4klsgW0U8sNIVsTmTXgiJrmWp/mi/Azny9x
 J6mYxwFwUoW55LbmH8a8M5J+OaQppFgmn7tjsSnsOu54XCUFhjB4B3dQMMuklmMLGlgVJ
 nUR1CNp/V71s6NtXbQ7VU3Sc1aZRaZKwBwM0jVjSVXakXF2ihUpEEM/jQIgGU3geZUjBy
 bHIGpihWWSqY/QmZU1rrhRx/f28o6awZDw6+l1G8PSooKlh0OGbBCELTl0ntGeg16xWqo
 kIO29/GlwjanSCUPuWN+Kyf+qcfersFmbpPjsN20MCIKz5gb8DcesRCni2/X09lZ9Gg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="gsz/1BxU"; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=gsz/1BxU
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F2BD581339
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 18:31:00 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49cd4ba9f68so14479325e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 11:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789756258; x=1790361058;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=z5nx7+duNrNl1iM8JjiFsBpSfT+8Nf3t/nDI1RpXAw0=;
 b=gsz/1BxUloWgIRUSkX8CpkqNj/WHA/LTWN73SI/OQ6gTv670MV+aCJLtSmm2jcyqxo
 NB2fUcZbhOV//qW/wvLitq0lacTUIFX94LCjx2BDj+9lv+SltU6t4msOH0Dfh8TsMuar
 7/bkp/VvZt1HXppMm6wWGuUvDDF69Caee7uf26ePbDPkFUmXIkXkPLiRJmw/a1VpYlpP
 +z1h6w3LbancSEs2mIZFCV+xuN0ZBjQh0CTlaTq5g8w3w6AYpy3RyP95k350fnVfV71Z
 vhJPR/lWgzA3bhIzekG0Z2YMkUtt6iWrwnlc+nU0TRXnBom0l1aIN/4bcMtV9sdebDZV
 PfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789756258; x=1790361058;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z5nx7+duNrNl1iM8JjiFsBpSfT+8Nf3t/nDI1RpXAw0=;
 b=fpVKKaSMctR2cxUPxRqmIFz0xyrN3TBX81NP5v5mPHI78mhVEmACKMUmzsXXTdQqHJ
 TQ8v6kWU/djq5LXW7fVpb6K3HYNRmBUHw85mcHEWpltXjhiJt2iTPxBUYrgr/vsZ11eB
 DO/fqWGzvPqMotfy7TZldxSohjsykJLgkLCjpaFDU4320mGqCLHjc8JL0b4Aq1TVJJFr
 iybjtv0a7KjiKGbwViylTG/aB1oN3awwq4muWbUry93MujuqYsFBd8DNyLTBInM/XgHg
 JQ6eJaUDXuYa066co+cgQHQMJIniSLNcyRNqWgils7Djct0Dd9erd3krwPKJ+GEaCX9Q
 QD5w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzUfdNLzooXTpDfXEgOmNCwcxKx8JRcYXTp1tX6MnBXA0MlRIxd4FhL7fHuQO5TjenGdoSbNiU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kh6bLvG2FsR7p8cmdEkdU2UeD0pE44q7BwrWmBMdvIyFfOm5ef
 5FZypeemoaif/V269GTNt0LC2FSnF81Xz+BOFEZBFM3kkQjDBBWllA+Dh8EukwaX7Vo=
X-Gm-Gg: AYBFou1n+0fiP2jE90jYVMZOH797FJF+mptVoX40um1UzpCJKLs6FBavrNvbTrsCzr7
 jxJ7PWCxvZcwqSgqxzXNrPmCvw5T1huzpDSfZiXry5nkp3T8HiZiqZT4BXh5+hlyCXxujgy64D2
 gakTqxfhi7MblWi7/qlS2JdM+xof/s1LVB4S3rctM/0I7SPwQPUTGQuBltglf8niBE9jkGoHRlC
 VhOQR48besHmdyJaOqvRuL1Lo3suuqSPQ+m4GeCATX8RNE60ouijgKXllXyQKx0ukhS9sCQVBr0
 xDEXC0bFfO4tn4M/uDRtUmOneVcFA5G2ZXjShZpdx+QM+kkol/1TY9IUxLMbW+0/KYJ/sjxe9ZK
 anMdYU1kZy9op8Big/KlW9jvaKPUor/jHMuDVqAmytQsnAS9Y8YDDQpAI7NCNgXrxQj99h/3w/S
 81Fa54L+AqqZabjF/1H2O79GIgbH1mnoNTQ40zU4xo1YppdN55nY0/gQrqFRejhJc+j8WVuyffP
 Y6LiOSpDAfMSHcLwKE5WJynHAq1hrPtcrN4pHcCOhVAf0zKwglkMPPb9NGMhyv8LfY/+BlqyR7r
 ZsK1nrnpGXvXUTLMD0vooOCz7a4N4cIJHx6M5cLizu59Pvu3+8MsaFOaifwKUPNOCcUMbamfufY
 cHT9OVSaEo8nevO/7GSzN0OdNXGEqtWRjZon8wBihQ4uVRY/ewEOJFQ7bgLXBozHcu2oIByk5/e
 gfmg/sWNvPlvu85ZDStLi/mtDXtuHaGZbPLDOiSLc2aDLrGWLslikYU5zXnHXagfQ1ui/FXKghQ
 Rx774gA0TG2sjyW4sny2muYvkwwTwJcFDKBfShmpbt23yKm1de0fSpZjhWru7jBhPU3iiHfBdMq
 BkDi
X-Received: by 2002:a05:600d:4453:10b0:49f:cbf1:e77b with SMTP id
 5b1f17b1804b1-49fcbf1e9eamr18827995e9.10.1789756258214; 
 Fri, 18 Sep 2026 11:30:58 -0700 (PDT)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcd068124sm12202825e9.3.2026.09.18.11.30.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 11:30:57 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Sep 2026 21:30:56 +0300
Message-Id: <DLINN5K2BHFZ.19HZZJ3K3T9VR@linaro.org>
Cc: "Abdellatif El Khlifi" <abdellatif.elkhlifi@arm.com>, "Tom Rini"
 <trini@konsulko.com>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>, "Simon
 Glass" <sjg@chromium.org>, "Devaraj Ranganna" <Devaraj.Ranganna@arm.com>
Subject: Re: [PATCH v5 12/22] efi_loader: reserve FF-A shared buffer for
 runtime variables
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Harsimran Singh Tungal" <harsimransingh.tungal@arm.com>,
 <u-boot@lists.u-boot-project.org>
X-Mailer: aerc 0.17.0
References: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
 <20260914110106.1974894-13-harsimransingh.tungal@arm.com>
In-Reply-To: <20260914110106.1974894-13-harsimransingh.tungal@arm.com>
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

Hi Harsimran

>
>  /**
> - * setup_mm_hdr() -	Allocate a buffer for StandAloneMM and initialize th=
e
> - *			header data.
> + * get_comm_buf() - Obtain a communication buffer for MM/FF-A exchange
> + * @payload_size: size of the payload that will be appended to the
> + *                MM communication header
> + *
> + * This helper returns a buffer suitable for constructing an
> + * EFI_MM_COMMUNICATE message. During the boot phase a new buffer is
> + * dynamically allocated. After ExitBootServices(), dynamic
> + * allocation is no longer permitted, and all runtime communication must
> + * use the statically reserved FF-A shared buffer.
> + *
> + * The caller owns the returned buffer only during the boot phase and
> + * must release it with free(). During the runtime phase, the returned
> + * pointer aliases the static FF-A shared buffer and must not be freed.
> + *
> + * Return:
> + *   Pointer to a valid communication buffer on success.
> + *   NULL if no suitable communication buffer is available.
> + */
> +static __efi_runtime u8 *get_comm_buf(efi_uintn_t payload_size)
> +{
> +	efi_uintn_t comm_buf_size;
> +	u8 *comm_buf;
> +
> +	comm_buf_size =3D MM_COMMUNICATE_HEADER_SIZE +
> +			MM_VARIABLE_COMMUNICATE_SIZE +
> +			payload_size;
> +
> +	/*
> +	 * After ExitBootServices(), dynamic allocation is no longer permitted.
> +	 * Use the predefined FF-A shared buffer at runtime; otherwise allocate
> +	 * a fresh buffer during the boot phase.
> +	 */
> +	if (efi_at_runtime()) {
> +#if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT)
> +		if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
> +			if (comm_buf_size > CONFIG_FFA_SHARED_MM_BUF_SIZE)
> +				return NULL;
> +			comm_buf =3D ffa_shared_buf;
> +			if (!comm_buf)
> +				return NULL;
> +			efi_memset_runtime(comm_buf, 0, comm_buf_size);
> +		} else {
> +			return NULL;

This is problematic for the existing use case. With  the changes in the lat=
er patches
that swap all runtime call unconditionally every call to setup_mm_hdr() wil=
l return
EFI_OUT_OF_RESOURCES and none of the runtime services will work without FF-=
A.
There's nothing elegant we can do about this .We either Let the fucntions f=
rom efi_var_common.c
deal with the runtime part (which I think I prefer), or we define a similar=
 runtime
available buffer for comm_buf.

> +		}
> +#else
> +		return NULL;
> +#endif
> +	} else {
> +		comm_buf =3D calloc(1, comm_buf_size);
> +		if (!comm_buf)
> +			return NULL;
> +	}
> +	return comm_buf;
> +}
> +
> +/**
> +static __efi_runtime u8 *setup_mm_hdr(void **dptr, efi_uintn_t payload_s=
ize,
> +				      efi_uintn_t func, efi_status_t *ret)
>  {
> -	const efi_guid_t mm_var_guid =3D EFI_MM_VARIABLE_GUID;
> +	static const __efi_runtime_rodata efi_guid_t mm_var_guid =3D
> +		EFI_MM_VARIABLE_GUID;
>  	struct efi_mm_communicate_header *mm_hdr;
>  	struct smm_variable_communicate_header *var_hdr;
>  	u8 *comm_buf;
> @@ -555,16 +615,15 @@ static u8 *setup_mm_hdr(void **dptr, efi_uintn_t pa=
yload_size,
>  		return NULL;
>  	}
>
> -	comm_buf =3D calloc(1, MM_COMMUNICATE_HEADER_SIZE +
> -			  MM_VARIABLE_COMMUNICATE_SIZE +
> -			  payload_size);
> +	comm_buf =3D get_comm_buf(payload_size);
>  	if (!comm_buf) {
>  		*ret =3D EFI_OUT_OF_RESOURCES;
>  		return NULL;
>  	}
>
>  	mm_hdr =3D (struct efi_mm_communicate_header *)comm_buf;
> -	guidcpy(&mm_hdr->header_guid, &mm_var_guid);
> +	efi_memcpy_runtime(&mm_hdr->header_guid, &mm_var_guid,
> +			   sizeof(mm_hdr->header_guid));
>  	mm_hdr->message_len =3D MM_VARIABLE_COMMUNICATE_SIZE + payload_size;
>
>  	var_hdr =3D (struct smm_variable_communicate_header *)mm_hdr->data;
> @@ -1077,6 +1136,20 @@ void efi_variables_boot_exit_notify(void)
>  	ebs_called =3D true;
>  }
>
> +/**
> + * ffa_shared_buf_notify_virtual_address_map() - SetVirtualAddressMap ca=
llback
> + *
> + * @event:	callback event
> + * @context:	callback context
> + */
> +#if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT) && IS_ENABLED(CONFIG_ARM_FFA_RT=
_MODE)
> +static void EFIAPI __efi_runtime
> +ffa_shared_buf_notify_virtual_address_map(struct efi_event *event, void =
*context)
> +{
> +	efi_convert_pointer(0, (void **)&ffa_shared_buf);
> +}
> +#endif
> +
>  /**
>   * efi_init_variables() - initialize variable services
>   *
> @@ -1085,6 +1158,9 @@ void efi_variables_boot_exit_notify(void)
>  efi_status_t efi_init_variables(void)
>  {
>  	efi_status_t ret;
> +#if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT) && IS_ENABLED(CONFIG_ARM_FFA_RT=
_MODE)
> +	struct efi_event *event;
> +#endif
>
>  	/* Create a cached copy of the variables that will be enabled on ExitBo=
otServices() */
>  	ret =3D efi_var_mem_init();
> @@ -1103,5 +1179,37 @@ efi_status_t efi_init_variables(void)
>  	if (ret !=3D EFI_SUCCESS)
>  		return ret;
>
> +#if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT) && IS_ENABLED(CONFIG_ARM_FFA_RT=
_MODE)
> +	if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
> +		/*
> +		 * The FF-A shared buffer is accessed by EFI runtime services, so
> +		 * keep the resident pointer convertible across
> +		 * SetVirtualAddressMap() and mark the region as runtime memory.
> +		 *
> +		 * CONFIG_FFA_SHARED_MM_BUF_ADDR is expected to be EFI-page aligned.
> +		 */
> +		BUILD_BUG_ON(CONFIG_FFA_SHARED_MM_BUF_ADDR & EFI_PAGE_MASK);
> +		ffa_shared_buf =3D (void *)CONFIG_FFA_SHARED_MM_BUF_ADDR;
> +		ret =3D efi_create_event(EVT_SIGNAL_VIRTUAL_ADDRESS_CHANGE,
> +				       TPL_CALLBACK,
> +				       ffa_shared_buf_notify_virtual_address_map,
> +				       NULL, NULL, &event);
> +		if (ret !=3D EFI_SUCCESS)
> +			return ret;
> +		ret =3D efi_add_memory_map(CONFIG_FFA_SHARED_MM_BUF_ADDR,
> +					 CONFIG_FFA_SHARED_MM_BUF_SIZE,
> +					 EFI_RUNTIME_SERVICES_DATA);
> +		if (ret !=3D EFI_SUCCESS) {
> +			efi_close_event(event);
> +			log_err("EFI: failed to add FF-A shared buffer to runtime map (%lu)\n=
",
> +				ret);
> +			return ret;
> +		}
> +		log_info("EFI: FF-A shared buffer runtime map: addr=3D0x%lx size=3D0x%=
lx\n",
> +			 (ulong)CONFIG_FFA_SHARED_MM_BUF_ADDR,
> +			 (ulong)CONFIG_FFA_SHARED_MM_BUF_SIZE);
> +	}
> +#endif
> +
>  	return EFI_SUCCESS;
>  }

