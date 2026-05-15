Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A50CD4F25
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 14:54:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D0B7846CC;
	Fri, 15 May 2026 16:54:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UDerr/LC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52D8F846D0; Fri, 15 May 2026 16:54:07 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E1FB846B5
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 16:54:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4824176bbbeso2915190b6e.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 07:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778856844; x=1779461644; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=p74DNbyxK5VJQvWp+nejwqK+RKRmkDgYgOkU5uFjQNA=;
 b=UDerr/LCoDEWxG7VzfH8WebFdoJBB/AczrFBg7ew/CbMmqJJESSuIxHPecnTtYB/Y1
 paGTAyCjTQMFb0BU/tNCftODaKJ2aAlHjB73un04DlhvRhm/83FZp1rN1nf6N2fmmqgQ
 Nrl5rhB/02qDs4KiuRyh6tcinJiFVA9NfRpbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778856844; x=1779461644;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p74DNbyxK5VJQvWp+nejwqK+RKRmkDgYgOkU5uFjQNA=;
 b=E+vjEKb5EDNWMTb/hq8K/SNaJFA0IV8Q9SrLRnBb7w3bAL7e3EBBEpBQd33JJS+kFD
 cwRhuzl89ExwKjgt5D3e6/mVuP8Wch2WbkixOdOn8qCLzNwu1dmGiItO+D6/GazgH3Vc
 P5yHdmjei8YKfkwsPdCeVUyOwo6lMV7NeeoWp45mkWUBh3LsTJDwhtCFbhgLoo5KKR+0
 WD3FW1/vZp6bKhLCITjgVSyzJbStOhsys0IAT28IrrE4Iuqp8HEmniHCf5TNIz1jaubV
 W/FejaY16WilQHP1n9D5AZoD4OvyMEKXNpXs/lAntwYPgf9icHzdODbaoLmSrzCTBbqU
 KKtA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+MgB+Ft59UUjVkFDFDlizQbVHpxcpeJd5VZ3tHJKApC1POKUrd9ygjPNokuHF1zPZ8iVAlCB4=@lists.denx.de
X-Gm-Message-State: AOJu0YxYwfvlSyFIHDSzBUVXZF9GpaQdbnQXAm6cUYBspzYplDR4TLI8
 YyK12UUS8+NABnbcmVdUAajZDxlrEGQoWeDhu05r6XU1hi9RDNpKhV/9TeiAzcLbPW4=
X-Gm-Gg: Acq92OGMLrH5rvIYh4x3zzLR39BC147hyjrUBktuewJapdIsLb8N5MoZLX4d2n8ahBK
 Ra7k20hjWF3k5TmErdO6S+2JGTUh5DGfm4c4shAZpIfle5QBTe4xrp8lF+sxUlJoMr/f9XAJy6J
 RTADvcth03SDvQkKmD6Rlyk3n1pHgUOuXQ3LSgijqUhXK4CQpgQaSnTC4a7ZWJhv3XDK7mqBW/9
 5buUhsRPATuvSqD1eQW+mQGXSv15fOcZ6xmLNxwWimq8uEltS9bhaK2ls0dTeDwSS3wsrvUWo6D
 jkRzeW4/RCfAh9MVSjNscMT/tIX1l48jTkUkATJpEOxvb5pXUsJ9u2AC6Zv6JxIKPU96W/MpOu+
 T88vyxoumV5wnh0LlejcJr/I+3NXTjbnuhxC4CwBhNvzOUTeTjPK/unAzpLK/F6LmWqz9fBQyLf
 mfZPHqTEfzpSBcxbtdtuDJ2s+zFbgYxlvZvOV32dQeGDHccr5of1ynF8EVN7survRHUyeVy3J9G
 ZBk7GRfgPAxZdBRIQBnBWrYBW00smE5im6t32/SnAnZwvc+wZA=
X-Received: by 2002:a05:6820:220e:b0:689:dfc8:5e3c with SMTP id
 006d021491bc7-69c942aede9mr2490861eaf.3.1778856843782; 
 Fri, 15 May 2026 07:54:03 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d0462e85esm1043964eaf.6.2026.05.15.07.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 07:54:03 -0700 (PDT)
Date: Fri, 15 May 2026 08:54:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org,
 marek.vasut+renesas@mailbox.org, sughosh.ganu@arm.com,
 u-boot@lists.denx.de, upstream@lists.phytec.de
Subject: Re: [PATCH] Makefile: binman: Search board directory before srctree
Message-ID: <20260515145400.GB1858239@bill-the-cat>
References: <20260515054327.1033466-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pV0GmShs+BE3cAn9"
Content-Disposition: inline
In-Reply-To: <20260515054327.1033466-1-w.egorov@phytec.de>
X-Clacks-Overhead: GNU Terry Pratchett
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


--pV0GmShs+BE3cAn9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 07:43:27AM +0200, Wadim Egorov wrote:

> A file like rm-cfg.yaml accidentally left in the source tree root
> shadows the board-specific copy. binman builds the wrong YAML, the
> resulting rm-cfg.bin may match a different SoC, and we end up with
> the following error:
>=20
>   k3_system_controller sysctrler: k3_sysctrler_start:
>       Boot Notification response failed. ret =3D -110
>=20
> Move the board directory ahead of the srctree root so that the
> most-specific match wins.
>=20
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Makefile b/Makefile
> index 552328f9f2c..1ec29dfe0be 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1682,7 +1682,7 @@ cmd_binman =3D $(srctree)/tools/binman/binman $(if =
$(BINMAN_DEBUG),-D) \
>  		build -u -d $(binman_dtb) -O . -m \
>  		--allow-missing --fake-ext-blobs \
>  		$(if $(BINMAN_ALLOW_MISSING),--ignore-missing) \
> -		-I . -I $(srctree) -I $(srctree)/board/$(BOARDDIR) \
> +		-I . -I $(srctree)/board/$(BOARDDIR) -I $(srctree) \
>  		$(foreach f,$(of_list_dirs),-I $(f)) -a of-list=3D$(of_list) \
>  		$(foreach f,$(BINMAN_INDIRS),-I $(f)) \
>  		-a atf-bl1-path=3D${BL1} \

Why do we need to look in $(srctree) itself?

--=20
Tom

--pV0GmShs+BE3cAn9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagcziAAKCRAr4qD1Cr/k
Cg46AQDA9cvecEsWRkv+9s+ntTzYtzyMdP8d2DmcCjcvP2PsvAEAsyg0wffDoUN2
SRN6ka4eeVug4rKiKUYgDdKmCFF3uAQ=
=ZTkt
-----END PGP SIGNATURE-----

--pV0GmShs+BE3cAn9--
