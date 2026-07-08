Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4270C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 16:26:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 479B48496E;
	Wed,  8 Jul 2026 18:26:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bHUHuVpt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F352849D2; Wed,  8 Jul 2026 18:26:20 +0200 (CEST)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0120B843B6
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 18:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-7383cdb7800so774258137.1
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 09:26:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783527975; cv=none;
 d=google.com; s=arc-20260327;
 b=nbl2Rd3Y0v71VsGurnrcvnRAdRLDnuahXB1IAiO3a9643P+bK4VzCLxnnYtwRMOoof
 BoqloQtc7xrbSTIVbvqABRFLQruFIvzEoNx7L6SceJaCf5sSkgAcS32mcCajagp4CZPA
 jAk2/dkURp2ILZhjCSZw16Re2W5VdAdEu/hvRqvN947POwmUf1PWjj2BgvySncGjmKBw
 BCB/YXWVcaozTdfnnubd2BYAXHnUpb1UZ0ruZ/jC4KxLpvudU5ofY6a9zkVqy0DBjV78
 uIP2yZ13a0wkAfxZYdMHY8hBypzLIEkeYT2sj9PZg3n++v0jO3CJTYtJKHrKb71xnRuS
 7Oeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3kV1hJjkzlyMsCS+aSeRRGyV8PfTZC3VbFahj/zpw/w=;
 fh=SocK4OiObrDE01rf4A/mD/sAU8tp2xGapfK+9vDyWYA=;
 b=ByFAstvROAMTiQbelwht3Ix+kh8Dkk3O1//5ebnTLdQDAVqt5q/C0IfuoLx5kodF30
 TAvXN+p6+7Zln1aTobZpLUu9EBySclUtC5YEEdGIYPbYpUudjXtR0kNat61SUlxHkFZg
 DLErnzJpFLCLQR/rTTnxA2wbO0Tnup4YM9x5X86dou369QOMaOKlvqE67nZEevUittT3
 JDWfvrmFV1gYfgo4PkGQG4Gndw4c6GZu0BeR4N2xkXVLzSnEiV/mR1VzrsyiXHhlp2Db
 5yUtX3B26Y+aVhGi2acwBQy2MNoSScGn4Ff76uOBbZPjv4ePVPjT6HKVosbtmpycZR0x
 cHBg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783527975; x=1784132775; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3kV1hJjkzlyMsCS+aSeRRGyV8PfTZC3VbFahj/zpw/w=;
 b=bHUHuVptlAemjHoHf84MDl3HB6ri+7NLoK3ZthdhhL3UuCR/eoRzgUuGEMFzgWzZWc
 UizDu8lumAfqhdRGNfxNtPuKf9/iN7jZXCr+xuQGdXIg/rqMseGnoPAAdALeqlV22V9Y
 qYrkg+FdfDrbf5suWgo6SVagkVoybCtxxCoQzgJLEFFWEVYFcSbzUhfRqlfE+81qW8GC
 NAsiZs3270+04v7biU316XN7IXxYfb2SEqA3wsBOBwaAcNUCiapLQn8Y98uItUTbf9b1
 gDGEQY0BRNj+sddKGN3m1+T1sZGHBXSNNdWp2BWiyFZVz+Fhv3qA6RvIHD4ykF6aQDMs
 hYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783527975; x=1784132775;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3kV1hJjkzlyMsCS+aSeRRGyV8PfTZC3VbFahj/zpw/w=;
 b=WZpNuWFTjXva1xgQQyYTz4Mwc6tJwYQa4e1M4MR1ItQhg/JHS4X96zySXqnsEUl5+q
 vilwaUh3y2redOomNW5NpeUu60FBD0pxjsTjmsMfgdBCUQp4PVs0eOE6RjqPoLrZY63G
 ctN/7NuIVM6HqsgvwH38uFxnEqgIBbrcWE1FiRFsUxdEfBD0yeqLrSRfp8TxUaXnTJ4I
 tNlfRE/BT18pTR1Hgi0b6mRUWUb//AtdARreTwtuz9A4I/xqaCJolchbuvWb9zOAjya9
 wT2niF7h4chttJCcy1F7lWmMUGaN2PMGOnR1drBFLXmhfvqeB1qoUxBV4yPoAGcSfLHA
 +TUA==
X-Gm-Message-State: AOJu0Yw/jOQKGDFI2FhgDOO6gRS8XuFePa041Q8usxcayH9oNW414xbj
 yYdxVoIOOUGZ9l97oD+ogj7G6mKQWChbzK6n+K8Cuo5tJg7R/t/aYFrn/asMZKFxN0Y7uuD+L2W
 ZgCCjj9n2brO+53NraDz+6LwAY253r3pmv6WbsFc=
X-Gm-Gg: AfdE7cmQu7jSlp18j38elWzEJ+i1Q0dGShr+lqpfJkfacPWH3v7wg6FstztDMSIJ/fm
 xglUe5rmRaPbIE4hrRoVpiyeOXzfy38czI923Gb4k1HqlWNcYU9DeslB40gwIXVyGWTvloJR22H
 DBE+LzePHCFEK8C8uP51+R7nipWyBIXuPbwshDsobAFmg6HK3AMBODLU8UIcw9/2/RQWiUMYM/J
 6MHgvYCG5SjJsBt0FsOHki28e64c73qLDOUV4EajvntQO+gndtsPTh+iuPdnAVR8VonSjne
X-Received: by 2002:a05:6102:688b:b0:631:ff40:22b5 with SMTP id
 ada2fe7eead31-744e0333f94mr1736582137.21.1783527975294; Wed, 08 Jul 2026
 09:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260708013019.288985-1-trini@konsulko.com>
 <20260708013019.288985-2-trini@konsulko.com>
In-Reply-To: <20260708013019.288985-2-trini@konsulko.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Wed, 8 Jul 2026 12:26:04 -0400
X-Gm-Features: AUfX_mwTZKx2q2l2tCH_CvtWXVxIFkzSh690XoQ7ohlDfqznnlTi6pu8lg7XCa4
Message-ID: <CAMDkj5xfkpW4eRi-ZMC-SNG8-af5gr96Jv0-Jj4QwFNH5jwp7w@mail.gmail.com>
Subject: Re: [PATCH 1/7] lib/fdtdec.c: Disallow overriding the fdt address
 with mandatory passage
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Tom,

On Tue, Jul 7, 2026 at 9:30=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> When we have CONFIG_BLOBLIST_PASSAGE_MANDATORY don't allow the device
> tree address to be overridden. The device tree we're given is the one
> that must be used.
>

The commit message does not explicitly mention this is only for
OF_BOARD. So I think we need to add
"!IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY)" to the next check as
well:

         /* Allow the early environment to override the fdt address */
 -       if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
 +       if (!IS_ENABLED(CONFIG_XPL_BUILD) &&
 +           !IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY)) {
                 ulong addr;

Or, state in the commit message that it is for OF_BOARD only.

Regards,
Raymond


> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Raymond Mao <raymondmaoca@gmail.com>
> ---
>  lib/fdtdec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> index b91e067106dd..ecb22a58b964 100644
> --- a/lib/fdtdec.c
> +++ b/lib/fdtdec.c
> @@ -1856,7 +1856,8 @@ int fdtdec_setup(void)
>         }
>
>         /* Allow the board to override the fdt address. */
> -       if (IS_ENABLED(CONFIG_OF_BOARD)) {
> +       if (IS_ENABLED(CONFIG_OF_BOARD) &&
> +           !IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY)) {
>                 void *blob;
>
>                 blob =3D (void *)gd->fdt_blob;
> --
> 2.43.0
>
