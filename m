Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A708606A33E
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 08:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VBWYhqys;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=ryraK+RM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2AE4B405B7;
	Tue,  3 Nov 2026 08:39:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yu6EZ7NT-urD; Tue,  3 Nov 2026 08:39:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 530454055A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793695192;
	b=StepXTQ+sDMR5ngI5WzsYob0R/k+Mhz5wVlKO/6D+P4DQhqUZYhW+Nm71/dy6YgAolYx
	 fF/5eLWfwvHmiJCLnMKL4n1DdIPsjuwgmQNHHGaEnBl8EwJIyYq2BgKqeZfOl3CP6M/Xd
	 WpADMdQnRWMfYNBj3wEcy3RuwazdtshQvj+lDE/rT7tNcVwCMM/n/Jwq6ao5kG1xG8Fq4
	 xeaiqCmP9gjN4ymKmOwo+WeSzLVOV+s0PvKfZFIc3QSY9EdCQwL/obobFvxuQIOQQf/18
	 +jHwuvfsiDPip9PLC1NYm0ej8M53tYhVYo057Pk44QiMEm2hefOB9Z1i/dtLOsZG6OQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793695192;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Provags-ID:
	 UI-OutboundReport:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=m9FOXI11GTfmOR96f9RElq3Q1Rzmugu366alw8x4xFA=;
	b=Liwbl9noq8OHot0MpQITOelD/s35RxiqERuwDsR4khbcmmUoWW1NeG1OWM0FHpAha5k9
	 +MqUlmUzW8d2Kht7HRFRtdSBOVvfYH++MoYd7nlqrkOlyjBD4rMSAjVsvHh711CgT6xdL
	 9VFseffROQAP/T7HW5dAfjG/maOokoy/YG+rI5IxCjuuAVs7qPVHOmUcJdWqlIhK/LIaq
	 G3NWKbJCX1netyXCKJMsnIytXaQH1zK0Y/F7VOE93jTfFyANCOYxdwxN6/k3X8jqoAHKn
	 wr64qfenZ9wWQvHRidU64MadrNodmxn1JF2qic5MOj6/13aoNjfO8EBpVD9Bi6MFWaA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793695192;
	bh=m9FOXI11GTfmOR96f9RElq3Q1Rzmugu366alw8x4xFA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VBWYhqysi2Eho/ZDGM0lhgrWVKXdqq4K9kZePWboN0Zmo8jfvTams7EohnO1zgJcG
	 R1wE0E1yoHePBPDtpoBeEle3vLW068UYCsqpvALIw2XqK6KoIHSGOYJUJS4hf9uNdY
	 AGud6ogg9+cKWdra+mjoAehFO/GU5zY7XWhAzkyDRk1nczy5USIOMO2W5+NkDLm3v7
	 HRa08sCGEHQo/anW+9uW1vNZlYsUdPBL7iofkpGEN1XBcY+j+OxflvjFJSuo1W7mdx
	 SZm/jmrx8LTp4UnCeTzwqZPN2qr9IiAJD/3cwkrUY57Zcxv9+oy7+EucHtYm8aO/h9
	 dZYu1bUc8qXiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 530454055A;
	Tue,  3 Nov 2026 08:39:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BBE9A2A8
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 08:39:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A1A6880C7E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 08:39:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pOCj5hIZslME for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 08:39:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 69C5480C97
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793695190;
 b=WJ+sFwPTgdyhQIgJGXeaHTQlwhcL5KZHRFzQNmNiTV3rQHVhvFn2saIXzAOAodArH16z
 UJil90ktT8a/XsCKDqfUBJLrOW2KJlF9o5A/zcfNPV2ShXwGXVS8lZMOPyEEPrhJfMIBd
 bNsjvkyJ5/yFuucLMLhO96L1B3NDzdT8VbYE6E8xMh27hDDMlBUwetREN28MsZgC9gy3+
 Sm5/BeUknP/hdgjRCSrvuBF++IE+x+vRljOA+22cFWe/UvAzaFjBb2wszp9uy7bSYmFMJ
 7x59lbmyspLtpAVtshCdD7QgoSRpi7HSy0X/h9WJ7cbz4Sf1lWlI8KzjdW1anN2Bzpw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793695190;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
 bh=m9FOXI11GTfmOR96f9RElq3Q1Rzmugu366alw8x4xFA=;
 b=sF07iitETO/p+Lvw3StOg97QAqypyPLXh4CY8pjmYMvM0LL9IEHTK+XbaF9+MfxhNrCY
 g6pIIYRxwOZbcW+/9bQF4CzgCM74upgoNpXj11KQuNDJ7c1cEo/Q0RYTNmQfMls7ZlmjK
 mrqCeimXGimgsPyjkMKDzS186HDOsTjm1s88KfREwvTfrZ281hy3VTcgxHbN8M1URQtze
 6QO8V0v7f2vrOxIRHbYPkXRmz4L7iAAEyoj7GdqzB7Xb+KCI91+E4RkjYPOOPWzR5YGjs
 ZLgJugeQ61WxmdlStVFgijuZoEvwiRKE7VVT6WPBGP5zlZxDvVBU92ihzlirF0k9n+Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmx.de;
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=ryraK+RM; 
 arc=none smtp.remote-ip=212.227.15.19
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.19;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=ryraK+RM
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 69C5480C97
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 08:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793695184; x=1794299984; i=xypron.glpk@gmx.de;
 bh=m9FOXI11GTfmOR96f9RElq3Q1Rzmugu366alw8x4xFA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ryraK+RMgy4Gek2rVXRQ35KCrbWj+ZW3K/E+et01A9P1+KcPT3AdgRO8oDjsnVb1
 IP2b5U5xpbALhkpY/H0aqYelttXXaxwDXXiWdCIq2vB9m8WFZEDKtHIsit19j4bV8
 8WV0rjFT5RsTZu6nyyFjmrc8qGMPFtNRf+JsDFs8yBLGbZKWeIZAy08cyK/m7KwGg
 2PnUQWI35JrIdTS7cpKeqdxcupARRv2lSbN9B8x7CZKf7f7Z20PT3WXH79TIGRMrK
 MMGCzqhx+iEI2yrqPlaz+UWNv4dXf0zAIUhojCjkBauaMVW0Nrq5knmpNReGOQqfg
 fWzF/5z9DwCGCqr/0w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUowV-1wxad71mqH-00QGP8; Tue, 03
 Nov 2026 09:39:44 +0100
Message-ID: <8880f413-76df-42e2-8630-acc456e7f55c@gmx.de>
Date: Tue, 3 Nov 2026 09:39:38 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: unload image on security violation in
 efi_run_image()
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20261102041038.369162-1-oss.patchbox@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20261102041038.369162-1-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f59jEYtwAj64EcymsyGt7jsVv6tJ2FiPe9Gydir1FhQAZbEq2GL
 i+pdF3SBRsUddZQQFnohhl98GCKcKJkWhm/A+bpr5FhBuOU8wv9Au0G34VtyXxO1b6u49E9
 69iXrdr7TPQW8qo9VVz/lbYiF3aNpsmVLhmm3ZGgWsZh/JpjYrpcQNUhKaTcFYzTvOmrYsI
 dT/RvU3VGjtAe3nfe7ScQ==
UI-OutboundReport: notjunk:1;M01:P0:O/5WMdJxTmE=;9sXIy2dB2rh9+fAnr1JpfPx9Bjb
 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
 shTTUm
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 05:10, Yuho Choi wrote:
> efi_load_image() returns EFI_SECURITY_VIOLATION when an image fails
> Secure Boot authentication. In that case the image has still been
> loaded and a valid image handle is returned, and it is up to the caller
> to unload it.
>=20
> efi_run_image() treats this like any other load failure and returns
> without calling efi_unload_image(). With CONFIG_EFI_SECURE_BOOT=3Dy and
> Secure Boot enforced, each attempt to run an image that is not
> authorized through 'bootefi', 'bootm' or an EFI bootflow therefore
> leaves the relocated image pages, the image handle and its loaded image
> protocol behind.
>=20
> Unload the image on EFI_SECURITY_VIOLATION, as try_load_entry() already
> does for boot options.
>=20
> Fixes: 4540dabdcaca ("efi_loader: image_loader: support image authentica=
tion")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
> Tested on sandbox only. With LTO disabled, gdb set efi_secure_boot to
> true at the start of efi_load_image(), so that the unsigned
> 'bootefi hello' image failed authentication. Without this patch each
> attempt left one more handle with a Loaded Image protocol in
> 'efidebug dh' (5, 6, 7 handles); with it the count stays at 5. A normal
> 'bootefi hello' still runs. Not tested with enrolled keys or on
> hardware.
>=20
>   lib/efi_loader/efi_bootbin.c | 4 ++++
>   1 file changed, 4 insertions(+)
>=20
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index 12db8f517c7..752400c0eea 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -184,6 +184,10 @@ static efi_status_t efi_run_image(void *source_buff=
er, efi_uintn_t source_size,
>   				      source_size, &handle));
>   	if (ret !=3D EFI_SUCCESS) {
>   		log_err("Loading image failed\n");
> +		/* On a security violation the image is loaded but not started */
> +		if (ret =3D=3D EFI_SECURITY_VIOLATION &&

Hello Yuho,

Thank you for looking into this resource leak.

Why would you only unload the image on a security violation and not on=20
other errors inhibiting launching an image?

Best regards

Heinrich

> +		    EFI_CALL(efi_unload_image(handle)) !=3D EFI_SUCCESS)
> +			log_err("Unloading image failed\n");
>   		goto out;
>   	}
>  =20

