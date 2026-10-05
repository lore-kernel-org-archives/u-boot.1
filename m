Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C1DCA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 08:31:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BEAAD4062D;
	Mon,  5 Oct 2026 08:31:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eYIiGJjqfpmP; Mon,  5 Oct 2026 08:31:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 038C340623
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791189101;
	b=N1wuDrRK05u4p4bZ+YcbebwcOE4PZsRMoEwMqL4oQQBiadUfQWxfkZoW35L2OT5E5aUR
	 QILr+CItaB8ZROlnlxfg/lLcfNbtMLDqAvf0e8L5gS29ykekOJ5IKk9SjPwDYlz4RSe+j
	 Jf/QKbt+suuuVzuOg2RhEldGHsq64EwB/fT5HQEr61U4+/hyS3Eo6gNEJKMCV3oCSohQW
	 kwfUh1oOTkpviGXBCkfPWK5ENcfAlqFi6D9QY6R9IPLXpmlYhjcdBKSjgxv1KyGEiceSH
	 rnJEFqYTPz19PIJSSx2n+jMW2H4ITIJdnwjh+bpJQgeBBpyGn/2wOWvafxVLdRRGpEw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791189101;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:To:Cc:Subject:
	 From:X-Mailer:References:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sTznfg1c9DH2+SZ/LK26snpjg4Eyd2zDzj+8WWvLBIo=;
	b=d4hcUvSINAc6UaDlJ1Cklm9n7VpFl+oLdWmOscacnc3NaXP/J2HNYmWc1j7XmeT+mrx2
	 ObfN6S7CLsKb+Qs5Ka6dntPNvn9PsvEryIvPmDLoDwtBJRXoOqxBBmPtJMsOHdIhtqbd0
	 n7+q2+VP595JVZWwClThLcZ0l/BOuEi0cRXCn9g/ZsH4GGVqgp29s8HkwClLgKYedTRQs
	 mnpcQC8ZQz2Y61SLLio7FUdr+LfFUVyf33Z9d06O/yyN9psguz3+aQ7fDRV36ucDcLr+w
	 LUvMj3/g7uS+0TT7PKKp10ZbdqrM8uOHdKOqx5yl3yZ9TiZzOKjkDTw6Xrbt6A0Jbvw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791189101;
	bh=sTznfg1c9DH2+SZ/LK26snpjg4Eyd2zDzj+8WWvLBIo=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i9NLd0CbrR2k9xIEbWca72LIaIw3fTEQd2U3qMVurRbUUO717fkqbqfWW4wRG4pGg
	 ICIsd/JWArnQzhu5nq9xmQFzkAOYck4bBAaM168yLhAD2DyV0agMQECJv/qD/nbsTg
	 7EtvcZdDYPzTH/QtqBxgoRbmpJ56is36zQ2OoPi6pIE3hiLSw5RShZhrNZ8fWd5iuv
	 Bxe2BTi4XK58PZ2iayqIP56SppnYv4lKXKgMNkhcsEwQzgIFBO8kfHS0BtVX+Ea4ka
	 s6d4tAxBcTxikx/3o9zxkuwKpbktwUkgCpC58GkgJcsd+bwpqPX6eSgcJrTgTHXhdN
	 CU/spuyRThhdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 038C340623;
	Mon,  5 Oct 2026 08:31:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C99ED335
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 08:30:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AF1E0605F3
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 08:30:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sOl4Qd0wphoK for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 08:30:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8AF95605EB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791189036;
 b=aGPdsmBgb+azYSMNBA+NFN1sI638++CGbDkt+L0L4uluxzSGw3PIp6lMVWnaXHp5FzB5
 fWAB2sYc/yFQdKN6qPJoiUQhpTM5U0l7tDvA7x9AFilQRk5lGEj9UKjdRmwNfqkmsVnx8
 WaADDZeRUtAQJqh2R6PSGDobCbbDmV+Nx4bAD4K4YMrrKrx1jq2363xTGDdmqugx112S/
 7VuFk1Row5PyOmX8cuw/vezYoNzeHTu7TaOGwoiDbR6u4iaskC+qGbmRe/qKIG6Vpn1hA
 ozTEv83Gx+lQcwcoKE7gcJtWmkuP7G02Do8O14dw5/7wwakx4oiZuGd67H6J9tRkXew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791189036;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
 To:Cc:Subject:From:X-Mailer:References:In-Reply-To;
 bh=sTznfg1c9DH2+SZ/LK26snpjg4Eyd2zDzj+8WWvLBIo=;
 b=cgUjdke9HcVTMb88mipnjvANFJTOaj969cTb1ZJuWrytLlZpM8W/siZqz7/SHbWLZTGd
 w7ltI6+2VPxZZimfHU0YxHZVtFFYu0lv59FKGnGU3Bj58B2QM3/LR8cBPz+JoXqiDKTYv
 gAqaG919m3T6m+s3qBQXen/r+BEq5HKO/wWPb1uiICV1mtaRNXu6ecLERW00DKbisruB4
 QM9fZ/uW+WxWlSyV97+DpVgauqrxyvwNqF574v5F2lF5BtwRxo9M3UHHbDQeEUzkhCxMQ
 6aaDPGnjN813Hf+pSiRdBsBrEoQv/l9Y3IiT3oA0zJ93YphE8fwKBfX2+nyy0Y/1gfQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="K2rVq/U3"; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=K2rVq/U3
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8AF95605EB
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 08:30:34 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-4a0280d4f56so8735605e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 01:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791189033; x=1791793833;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sTznfg1c9DH2+SZ/LK26snpjg4Eyd2zDzj+8WWvLBIo=;
 b=K2rVq/U3NVGXHdE8xNB80xSX0oYd87OPXGeGlG3wYH2ewKLD/eCHMKMZJ7Za4LqcQw
 SeuDWED8Fc8O7TepFblWt8DZ1aquAys0F4FKAA4nwnSgcnD8pUWkOlYmXlSzcfAs2iYk
 jEXH2ZZPLZC3SXW5pX6hPuGi/sXLd+3tocWzGq59yjPP5emC+CSZ+GZAeDkSzBh+x9p6
 9tBaAbtPghm42QKr24A7Pj8/+kGrSnNaxr3xI0rUN12gfw789g7Oh241F6Gzxpm9w+rk
 QgHUmu2ixMyRmENorzJ19TL+SLRCIseZbiGV9BiV7V0BkM0aXuT30eKto5/8P/UcOwjf
 uL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791189033; x=1791793833;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sTznfg1c9DH2+SZ/LK26snpjg4Eyd2zDzj+8WWvLBIo=;
 b=1qt/LCzm29yveeir8pIrFdeZ75zFmAfECLq/4QaM20ubjggSB1apvzhJzCxKQ9Yp8q
 XmHF2qxhyZQo5xKyZu5Goi/CflBDODUEXYoWAsGgPDgwmjbBiiMzRYM3VdyA1M52mdBn
 vmz8pVW2c42kEic0+6kfMw5c0NjDI/MZr7zNjJ40l1uppZxjmh9mTFEfyIVfy58es/LO
 yffrN+KVK+vQFoA466E5VwMOaEVxAVvwByjLOkJPgvRnp07yQYtGE9kMItQgfb2HY0dM
 U8wo5BtQisp1d0E/KqRc6zPy7EPSOMUMMx/MKRQJjUENdyh92BQhnRP4HkyAb5QOEKQ9
 zIRg==
X-Forwarded-Encrypted: i=1;
 AKwUvByddW1fQn1egqFX4xu928oht/17YjP+L72P8YqvAy05uYCL7UOEZpx/7ePjpzMMNy/dWMCTl0g=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m9GAOLlPDxlF/ENWF0n0/2mXW1pE+ersUHuftoatWVrPco76Vx
 lijVNCBX6v8HviLGGxvV8aMLmZTenjSrqSmhqanriN+n00PYPj63LyrWv+33iBzCs2k=
X-Gm-Gg: AYBFou0aYhAhSZ/vhUQVFj0v5z6gcgyQOoqHauV6i9QjdxhEoFTU4cR8uo+eQPU00OW
 YzAxT3CscpeEJ5iRYBvZjvZR+fPsMZo5Jp4A5TDl7bK8dAGZ4pk8iy5RiL+wcP6KNI/puw7wbU0
 ChcY5eBLZPJj8C6f+3RiG4trPBEGqCa0aZAKLmzJVLkHc6NtL541JB3iDiW4857w2n3AbSjCngk
 dp0zTxluw7fXWwj+ZrHc0aqF+ON5iwrz2I4grepwPRvp54rm5uBurliKIN0CSIOl8Ehx/XwbiZB
 I5HaXo6F+QqLpEIYZCNeVL3AZOzgBKuW/zPr8ljkrYZABQ35T4rf1VFNfp51RirRo66lbbv3YVD
 itndOpZfCKXOhMsCtxZsxjJE/IA7sHw77rz+Wy4jxsfWrM3gLzzqSMeZ+xJRHWPPZt6YqAYrhhB
 hkiyKQN/aMg0fwr21c1c2LQ+guCxv+mcvYYeD2py6kOMYNI3/AmaZC+FiIDOoNH5hjqfVBb3GME
 ZxO8I8NLpHEIZxUFL2k7ASa4b0S37yu+MU+pj3A8pPKB/9BU1UllBHlh00CbgrfytH9fohNHL6Y
 Fq+0fUIl30TIP8XHKONIt/BNasDTwpEiCbahcrBvaIC7rHyEFsmKuq4sOHqx4wh3tRbV/QlL/9h
 TQyZgvrWhcrdy1zPyOUZLZWeYc9NrK+2aUmKqkeMIeTs7XyzYoMBH0iA5rlGU3+1Nx2W+EPiYQP
 6+12gn4zNFNGhKvUaYJU9DouAgIxDziuvfn/pdVnPOinkVK+qAuVeQ+Pjk4xmAj3R23uiYs4W44
 pf1P4hG9fT6sQJNOC+IshepF1BtnZqZcGid3Hm5hggW+qtUzk4uniW12mGsgf6LG4XNIzTnLVKy
 vg==
X-Received: by 2002:a05:600c:34c2:b0:4a1:7093:40c7 with SMTP id
 5b1f17b1804b1-4a17093424fmr56512975e9.8.1791189032628; 
 Mon, 05 Oct 2026 01:30:32 -0700 (PDT)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1698f7910sm116315285e9.3.2026.10.05.01.30.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 01:30:32 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Oct 2026 11:30:30 +0300
Message-Id: <DLWRIOQDA4NX.O3EE7MZM41ZL@linaro.org>
To: "Shahriyar Jalayeri" <shahriyar@byteray.co.uk>,
 <u-boot@lists.u-boot-project.org>, "Simon Glass" <sjg@chromium.org>,
 <u-boot@lists.denx.de>
Cc: "Miquel Raynal" <miquel.raynal@bootlin.com>, "Reinhard Pfau"
 <pfau@gdsys.de>, "Tom Rini" <trini@konsulko.com>, "Argus"
 <argus@byteray.co.uk>
Subject: Re: [PATCH v5 1/2] tpm: bounds-check the device-reported response
 length
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
X-Mailer: aerc 0.17.0
References: <20260813-tpm-trunc-resp-v5-0-153b492a3256@byteray.co.uk>
 <20260813-tpm-trunc-resp-v5-1-153b492a3256@byteray.co.uk>
In-Reply-To: <20260813-tpm-trunc-resp-v5-1-153b492a3256@byteray.co.uk>
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


Hello Shahriyar,

> +			void *buf, size_t buf_size, size_t prop_count);
>
>  /**
>   * tpm2_get_pcr_info() - get the supported, active PCRs and number of ba=
nks
> diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
> index 5f9bbe97455..e15a2340e83 100644
> --- a/lib/efi_loader/efi_tcg2.c
> +++ b/lib/efi_loader/efi_tcg2.c
> @@ -154,7 +154,8 @@ static int tpm2_get_max_command_size(struct udevice *=
dev, u16 *max_command_size)
>
>  	memset(response, 0, sizeof(response));
>  	ret =3D tpm2_get_capability(dev, TPM2_CAP_TPM_PROPERTIES,
> -				  TPM2_PT_MAX_COMMAND_SIZE, response, 1);
> +				  TPM2_PT_MAX_COMMAND_SIZE, response,
> +				  sizeof(response), 1);
>  	if (ret)
>  		return -1;
>
> @@ -180,7 +181,8 @@ static int tpm2_get_max_response_size(struct udevice =
*dev,
>
>  	memset(response, 0, sizeof(response));
>  	ret =3D tpm2_get_capability(dev, TPM2_CAP_TPM_PROPERTIES,
> -				  TPM2_PT_MAX_RESPONSE_SIZE, response, 1);
> +				  TPM2_PT_MAX_RESPONSE_SIZE, response,
> +				  sizeof(response), 1);
>  	if (ret)
>  		return -1;
>
> @@ -205,7 +207,8 @@ static int tpm2_get_manufacturer_id(struct udevice *d=
ev, u32 *manufacturer_id)
>
>  	memset(response, 0, sizeof(response));
>  	ret =3D tpm2_get_capability(dev, TPM2_CAP_TPM_PROPERTIES,
> -				  TPM2_PT_MANUFACTURER, response, 1);
> +				  TPM2_PT_MANUFACTURER, response,
> +				  sizeof(response), 1);
>  	if (ret)
>  		return -1;
>
> diff --git a/lib/tpm-common.c b/lib/tpm-common.c
> index b592c22bfc1..e4a620990fa 100644
> --- a/lib/tpm-common.c
> +++ b/lib/tpm-common.c
> @@ -159,7 +159,8 @@ u32 tpm_return_code(const void *response)
>  }
>
>  u32 tpm_sendrecv_command(struct udevice *dev, const void *command,
> -			 void *response, size_t *size_ptr)
> +			 void *response, size_t *size_ptr,
> +			 size_t min_response_len)
>  {
>  	int err, ret;
>  	u8 response_buffer[COMMAND_BUFFER_SIZE];
> @@ -190,11 +191,20 @@ u32 tpm_sendrecv_command(struct udevice *dev, const=
 void *command,
>  	if (err < 0)
>  		return err;
>
> +	ret =3D tpm_return_code(response);
> +
> +	/*
> +	 * The response length is reported by the (untrusted) TPM. Reject a
> +	 * successful reply too short to hold what the caller will parse, so it
> +	 * cannot read past the end of a truncated response. A TPM error reply
> +	 * is a bare header with no body; let its return code reach the caller.
> +	 */
> +	if (!ret && size_ptr && response_length < min_response_len)
> +		return TPM_LIB_ERROR;

The documentation you added says that min_response_len of 0 is ignored. But=
 here we seem to rely
only on size_ptr !=3D NULL.

> -	ret =3D tpm_return_code(response);
> -
>  	log_debug("TPM response [ret:%d]: ", ret);
>  	for (i =3D 0; i < response_length; i++)
>  		log_debug("%02x ", ((u8 *)response)[i]);

[...]

> @@ -519,6 +522,11 @@ u32 tpm2_get_capability(struct udevice *dev, u32 cap=
ability, u32 property,
>  	 */
>  	properties_off =3D sizeof(u16) + sizeof(u32) + sizeof(u32) +
>  			 sizeof(u8) + sizeof(u32);
> +
> +	/* the reply length is set by the TPM; do not overrun the caller's buf =
*/
> +	if (response_len - properties_off > buf_size)
> +		return TPM_LIB_ERROR;
> +

Isn't that covered by tpm_sendrecv_command() now?


>  	memcpy(buf, &response[properties_off], response_len - properties_off);
>
>  	return 0;

[...]

Thanks
/Ilias
