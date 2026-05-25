Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A21CD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:13:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81FA284879;
	Mon, 25 May 2026 17:12:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IUqw7n1F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CE5D848A2; Mon, 25 May 2026 17:12:58 +0200 (CEST)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1314C84862
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:12:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-95cd8b71105so6116000241.1
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:12:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779721974; cv=none;
 d=google.com; s=arc-20240605;
 b=XbrKVMa9AzMjSB4yt6iRlZLOzXSHmSDZyRCMn+dDRpNMdwSqU46sBW9imrSG8aUjD0
 xmMPVm05fkRXRc8JqyJf1sUmL3Nbp+NcUf7cvmCkpQ8VQGbA1AMYizZzNt/WPdRoNrhu
 uSTSMOOWYz9Mn7X8DECVvAM92X2SydV+qTTtVbKZI47vPE38jxgfHggJ5Ba2nSyoCd1b
 gz1bhsdnCINnJAnpr2utkY1jdzsM13BxHrcp3nfSRtDH+GySYJHw/uV0jPmltH2su8z9
 IcQQzptlC53Hpa5AgSVp1/YDktkSYUunL/2EMAScm1QE4CDtIlMD1XGg49pXayEJNwZ3
 ZDLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2trrmjS1cIYMmIPq3QHkp2uNtwEUZKG2REmALxnRm/Q=;
 fh=cMjBqNDAanqUfwtE1ZWGsUxxEaljfabMJLcrXhrQqQk=;
 b=izaHwwQ0fgC2x4wU5UXrKqHh5R48K5BSNNAuzJYKau1QaUOJB+5whQ6wLwrkd2VThF
 X5ObweTG//vJ8ZlpqdLimhuMw/w9W/SNAPuH3SieVIPTFEiLN6/IspIh5Oh4BdSKVd4g
 fqDzdYvV4ktdVMpN2YBM+MAPuyLZ7WPKcNCUM1TZKoi2Jsa6b0AeSE297pYW2oRx8iar
 xoCzvEY8wtjsU0DLrdZdvjEzIcIeL9PyDvyWEXXu2JKWebf+d6xG5636NiPvt5C64plN
 EFmbN7rDYSj7zKeAlNRemOX1EcjrNa4ESqAtUkCXk4EH0OVXHDmnMuhdEoRpFaKYMfOR
 HnnA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779721974; x=1780326774; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2trrmjS1cIYMmIPq3QHkp2uNtwEUZKG2REmALxnRm/Q=;
 b=IUqw7n1FqV3QhXlwXXWnOObT96gOUFLPH4x/8CcEDar3W5JXtXCQOzrrYqTaQ3P3eh
 kACtzf3TVRgWtZQchMbEPR7+sY5gHJvNobd9Wj2MB0Gav165nIMJAIkTD3AYSehF0Oyx
 kkipjujeTYWuzbsH3ycAs23f7PeDhjOD5FLOXRs2cL9snSMm1zNVTpkQBJ0QihdyOnub
 /TmnJKfYWsaBSqnabpzce8suGOSe4GoHWDeaAopAg8af1mrZ+oTXlY1hS+p6R9W+94dW
 PeqYxXOHkwJk0ZKRuOCmOe+Y+MF4HNuqNSs+p6U1Pam4vn7BTcNN+lkXCK5Zmceoppe1
 jijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779721974; x=1780326774;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2trrmjS1cIYMmIPq3QHkp2uNtwEUZKG2REmALxnRm/Q=;
 b=MYhgOGsA8Kj7k+v8LO5MJExry7johO9bx/V1vNLdygm0Lz1kjqJYyYFJXbER2szHv8
 uvLP71y0e99WwEfMf59BeQ4WQYOyuCQ3hGzQB7zs4Wk4D4hO2Nfb3Av6C4G8SBeFHJxo
 gkZSRUbKZpiX9mlQfie+X1CqBAL3Fd4yaZrVKN4cHXEU8Clzu6LoNolI5U/zV3BewEOw
 bGjkUKmbJIYzr78cxZePmeb+18rwHonM9TvJFj1JvVir/PlmLP+jXuzCetXrwSc9pp9r
 7YwiGWba8GQtIk4P99ohxRgyFNYRU99ekoX7HnDjZYNtMv4g5CDN20Zv0Fk5fkp+I/74
 KYwg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Xvs+UYKOm+Zt1HpMslOJVVDSDHho9N4LBvecDPEOXgyNJwFUq/Xi8yoPVSRHKTTspGihWQcM=@lists.denx.de
X-Gm-Message-State: AOJu0YyFqTCki1jB2Bk+bIDOadKrfmJE+8Jbzv1oCuuL7yPfsfLRcxn8
 0H6v2v3Xwl/RkIU2UpD3vFZ40jfGBs2S1CX0QxJlWPsoKqqJ16BCl77K3GITe0EzA4gbZh5nTjy
 rX17srmv+Lxov2cKkAVh/mLBDJrV1YJU=
X-Gm-Gg: Acq92OFadL7jRdknBi+pJgmy0HpKoW9m2ud/EYKWsNO5ERHIAKtliry6dRQsjHC2zRL
 wT3Hla1AO2eXyqhAdIbeikwC2Ts5o7+kp/aU16BFAJLPmWrSSJoRTryUWJP1hsEa0HraxMmJQtY
 uMMEsN8IwbXXdVqGtjHtwV3N6LnWYkL4NUTFZNHLao4IfFwDRWKNPCeoLaqxboqr3ucjrXLQ0+z
 +yYed/7GEmN4YUcghPyKV5+rN5busqEyMOcWGRT5YJpp22sAQx5mPRROXTegFIwQqyc1MAzAUBn
 klrSI0Ke
X-Received: by 2002:a05:6102:3ed5:b0:631:2624:e5ec with SMTP id
 ada2fe7eead31-67c7c07917fmr8143114137.16.1779721974662; Mon, 25 May 2026
 08:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260525135241.88348-1-philippe.reynes@softathome.com>
 <20260525135241.88348-10-philippe.reynes@softathome.com>
In-Reply-To: <20260525135241.88348-10-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 25 May 2026 11:12:41 -0400
X-Gm-Features: AVHnY4LWc3Ij_hiAeSFqvI5E9ePA3aUwnlSNXRCaU42yOsHbgolau6-CHD3BejY
Message-ID: <CAMDkj5wnta=dfGj11Sp46gK9jW4xC3awy7BgSMwqhOU+YtKE7g@mail.gmail.com>
Subject: Re: [PATCH v6 09/15] tools: fit_image_setup_sig: set required_keynode
 to -1
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, trini@konsulko.com, 
 simon.glass@canonical.com, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Philippe,

On Mon, May 25, 2026 at 9:52=E2=80=AFAM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> When initializing info about a signature, set required_keynode
> to -1 instead of 0, as 0 is a valid keynode offset.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v5:
> - initial version
> v6:
> - no change
>
>  tools/image-host.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/image-host.c b/tools/image-host.c
> index 8b550af0dc1..f5681d6c1f9 100644
> --- a/tools/image-host.c
> +++ b/tools/image-host.c
> @@ -198,6 +198,7 @@ static int fit_image_setup_sig(struct image_sign_info=
 *info,
>         info->checksum =3D image_get_checksum_algo(algo_name);
>         info->crypto =3D image_get_crypto_algo(algo_name);
>         info->padding =3D image_get_padding_algo(padding_name);
> +       info->required_keynode =3D -1;

If 0 is regarded as valid, please update the function ecdsa_verify_hash().
Replace 'if (info->required_keynode > 0)' with 'if
(info->required_keynode >=3D 0)'.

Regards,
Raymond

>         info->require_keys =3D require_keys;
>         info->engine_id =3D engine_id;
>         if (!info->checksum || !info->crypto) {
> --
> 2.43.0
>
