Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225A7C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 20:08:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72016801DE;
	Mon,  3 Feb 2025 21:08:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aYLK6Tqb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13DC780214; Mon,  3 Feb 2025 21:08:02 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 533EA80285
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 21:07:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-467a37a2a53so56841231cf.2
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 12:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738613278; x=1739218078; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3fiSFEXbVRDaSYwPPZDKn0F1xFRDuTTnvpDxX3uD1zc=;
 b=aYLK6TqbD3HXxovU2W7sMKAt8urKyfH4I66dMdCbiHkQXw+MOMmuS2k9z6vjwJl/fO
 n3WMntSFz1fI9kXS8pUrVaD74lrO5z0+awAYiTTPIIg8nNYDSRs3kFuBdQfEgfdf0EOV
 aRF7vlAdCzRMNnNZQ60MnAAATWYzk1QbiJvtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738613278; x=1739218078;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3fiSFEXbVRDaSYwPPZDKn0F1xFRDuTTnvpDxX3uD1zc=;
 b=IUCheSa6a7aRlNcO9P29SBmDbyrObeZ7N/JiHLm/LN3MTZMOZjT/u4Wp9Tn1jGhi7J
 CloaWcyaR1zg4qUKkMhgE8++JE0apuGKD8AkD8NdRJiqOiZxsNisb314agT5EUikh8lk
 j3zBhIDQvV1TiVrzFWWWv3/QCshm2cHJv62Oc62A3vzb/0ovzxPt65z+BUBiNG+Z0y64
 JcLKq1RabfZ99BdqbUJgm6IfQqXnPQ+KP/4hO6Z3RWxKmo+C6YF523spEiuM2WQ78/HA
 fmiHUPZZe0g6ZRJOIbH+uFXoXrGZTYa75DHTaJb+xV68vXDFqd8Ah/3aoAbKHdqmTJFf
 eFBg==
X-Gm-Message-State: AOJu0YwQMNGCS9FNCFRQfoBU7NzAY+uUXAGbwyNT0wVu7TIVkdDgw5O1
 jTYEXBWfjJSquPdxzr4GEILXs6zZwrTb3nFraLSrrWz6tD8GkVMfFMKQyTJ9Rag=
X-Gm-Gg: ASbGncvyltLjRfva4Id0mOpPhnEaAusglP88PQFcbemLMNWcnH1jixRvBJfVlfAfp33
 JaRag6ItiVaFocXtvVCwvhGMNR0Y5+m+F96fzY25Ys24YhJmnyNAfy563bpnC94emmOc/OlX7E2
 T4UDk5PH9/vdHlia2GHWA1SXKkegCDbeNnzE2h3Bb/EWBTup/aJTkq2cEc8dFbWWbn1iIdA+yOf
 RW8XF2wLHrsYqOEzf85HkNpIIoytE/MIotkjaHx3yvbzrScWSqfg/We1Uosm7NBYeGu5po+T21t
 380Xe5AnaEr/DVk=
X-Google-Smtp-Source: AGHT+IGwyzngm8H0lBDcbnQ7tiv+3bIm4gDCp9+Bb1VFEEcCUuVzmEP3HCsJXeucpTZJ2S3IAY0oRw==
X-Received: by 2002:ac8:5d53:0:b0:467:7295:b75f with SMTP id
 d75a77b69052e-46fd0b87e74mr333794461cf.38.1738613278164; 
 Mon, 03 Feb 2025 12:07:58 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf172bc4sm52181171cf.58.2025.02.03.12.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 12:07:57 -0800 (PST)
Date: Mon, 3 Feb 2025 14:07:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marex@denx.de>, Masahiro Yamada <masahiroy@kernel.org>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH 02/32] Makefile: Avoid using TEXT_BASE if not present
Message-ID: <20250203200754.GA1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YYq5hgkpRRCEnoFq"
Content-Disposition: inline
In-Reply-To: <20250203174245.1331464-3-sjg@chromium.org>
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


--YYq5hgkpRRCEnoFq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 10:41:55AM -0700, Simon Glass wrote:

> This value is only available if CONFIG_HAVE_TEXT_BASE is enabled. Add
> conditions to avoid introducing errors in link scripts when it is not.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Makefile b/Makefile
> index 2f7614191a1..3958ea45b9a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1050,8 +1050,10 @@ LDFLAGS_u-boot +=3D -z notext $(call ld-option,--a=
pply-dynamic-relocs)
>  LDFLAGS_u-boot +=3D --build-id=3Dnone
> =20
>  ifeq ($(CONFIG_ARC)$(CONFIG_NIOS2)$(CONFIG_X86)$(CONFIG_XTENSA),)
> +ifdef CONFIG_HAVE_TEXT_BASE
>  LDFLAGS_u-boot +=3D -Ttext $(CONFIG_TEXT_BASE)
>  endif
> +endif

This is for linking of the "u-boot" target, and we can just add EFI_APP
here. Looking at the cases above (arc and x86 at least), it's arguable
that they're abusing CONFIG_TEXT_BASE when they really want some
slightly different symbol to be used, but we can just set that can of
worms aside now instead.

>  # make the checker run with the right architecture
>  CHECKFLAGS +=3D --arch=3D$(ARCH)
> @@ -1741,7 +1743,7 @@ quiet_cmd_u-boot-elf ?=3D LD      $@
>  	cmd_u-boot-elf ?=3D $(LD) u-boot-elf.o -o $@ \
>  	$(if $(CONFIG_SYS_BIG_ENDIAN),-EB,-EL) \
>  	-T u-boot-elf.lds --defsym=3D$(CONFIG_PLATFORM_ELFENTRY)=3D$(CONFIG_TEX=
T_BASE) \
> -	-Ttext=3D$(CONFIG_TEXT_BASE)
> +	$(if $(CONFIG_HAVE_TEXT_BASE),-Ttext=3D$(CONFIG_TEXT_BASE))
>  u-boot.elf: u-boot.bin u-boot-elf.lds
>  	$(Q)$(OBJCOPY) -I binary $(PLATFORM_ELFFLAGS) $< u-boot-elf.o
>  	$(call if_changed,u-boot-elf)

This is for u-boot-elf and I think not defining CONFIG_PLATFORM_ELFENTRY
to CONFIG_TEXT_BASE will be a functional error.

--=20
Tom

--YYq5hgkpRRCEnoFq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehIhoACgkQFHw5/5Y0
tywxzwwAlloqYRzp094hnMjEczi3rzKnHw5CYk3CTjXjdkLMr68DRASVbaY4f+nV
aWSSw98Scc9ivWgojqiS5NA5x3X20SGRsAPogc7XSDBGlULPH2gKdIlW06V8w9Rd
K5bSbvWchhre1A0tNHdgB+SXFufPiTVz0iGvzn10H0Y7aSC5oCzK9W/ZvNpHOA52
EQaqGhoQUgduuhJTJRj4KkpIoYIr7FUJxh0yeXOws0yCBDdUKDXXg8QBO87wg3qE
dT0wOvtdxzUCk1GLLN613EnvixPTcri7wvh+TYh20Xl/VGpU73pmUkaiaZnSUwBb
ooB7bIlGITxOTAh+nE64awCFlVZXEQOCwU13CAx8FG1HtdvR0FGhNVtUSbN96cfj
AFWQDZaleuBf4too4FECfFQ/nFq/lm65yla289ZpHoWg9I8eJznAxQYy23hedRyI
hClI1WEMR0KEWch4eLOzV1vzPP6bq+0h26GRHrULsXq1PDeDcYbCiDD1BKoWhylI
g60xdIJP
=Vi/m
-----END PGP SIGNATURE-----

--YYq5hgkpRRCEnoFq--
