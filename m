Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D4DC072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 17:18:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3EDD86FB8;
	Fri, 17 Nov 2023 18:17:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rrv0imK7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD01D86FB8; Fri, 17 Nov 2023 18:17:56 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE05E86DEE
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 18:17:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-42135f8e08fso12669221cf.1
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 09:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700241469; x=1700846269; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DWz1xUPShg0Z8poMN37FNFFtfk3489BzdXUEiCtOFuA=;
 b=rrv0imK7zMJmCwMNpo4eS+A8TaJhyxcB+PB7cPrwnUrnUty6+LETcOjRz5DcWH/jCB
 Ck2JztcG7DH0hMvEe3Zrg8ZmbcEW0fWo4Fvg9E5I57WzYUhfcs7fbxZn6DWxPZCqwo6z
 l3KNPdn0VOZQqCc9qYk7cLkjXcwpXHHjabe20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700241469; x=1700846269;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DWz1xUPShg0Z8poMN37FNFFtfk3489BzdXUEiCtOFuA=;
 b=pz53r6JA9+k6Mo9Vz/nhX3pS0Elz2LKEhgR9q1dMfUJtO6sWjyvGGn+ho12VZsHNPf
 xdCKuH6yRNbl5tayXLfDQal/XNKH5bQLfa5W/ew1x8N9VNnlHKN4sDtdPR9esw3RDAJ0
 BhlPMJbxp6n8WMmr/wZEKiLTak3NBWmKKHOMz9zzceYOxI7PtfMaNlOfEpHyFaohF48A
 yaBjNz3FzcY+3R+B0RjldBxtodiaph49mlomyiQMowCYosKzexVUVJhe/GoRKb1J3N6V
 XGFHJUVwBIkZ2/GMWJGj2FVXMdEpeDEkjVl6q8UlbV4jTsspdVHpJkgFEPk7D4xeMkRv
 yMDw==
X-Gm-Message-State: AOJu0YyQnA5FlN+bn5+vhQy/eLtI/0Gef908MJAC0IvRphFjtH54SbP/
 IpNtFmj39r4VXaQG3sPsR3PvDw==
X-Google-Smtp-Source: AGHT+IGVR2oX2pPwA0l/CslMFo+ZFk4+Ekw1mEoBnj6bX1FvTRQqOoEa9qM64JRYngHMNgntUWMt8Q==
X-Received: by 2002:a05:622a:118c:b0:41c:c8f2:58ce with SMTP id
 m12-20020a05622a118c00b0041cc8f258cemr309551qtk.27.1700241469468; 
 Fri, 17 Nov 2023 09:17:49 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 t20-20020ac86a14000000b004179e79069asm710158qtr.21.2023.11.17.09.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 09:17:48 -0800 (PST)
Date: Fri, 17 Nov 2023 12:17:46 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>
Subject: Re: [PATCH v2 06/32] bootstd: Introduce programmable boot
Message-ID: <20231117171746.GO170968@bill-the-cat>
References: <20231116041043.362055-1-sjg@chromium.org>
 <20231116041043.362055-7-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6OMrGGsJD5+VM5mq"
Content-Disposition: inline
In-Reply-To: <20231116041043.362055-7-sjg@chromium.org>
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


--6OMrGGsJD5+VM5mq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 09:10:06PM -0700, Simon Glass wrote:

> At present bootstd requires CONFIG_CMDLINE to operate. Add a new
> 'programmable' boot which can be used when no command line is available.
> For now it does almost nothing, since most bootmeths require the
> command line.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
[snip]
> @@ -67,6 +68,14 @@ void main_loop(void)
> =20
>  	autoboot_command(s);
> =20
> +	if (IS_ENABLED(CONFIG_BOOTSTD_PROG)) {
> +		int ret;
> +
> +		ret =3D bootstd_prog_boot();
> +		printf("Standard boot failed (err=3D%dE)\n", ret);
> +	}
> +
>  	cli_loop();
> +
>  	panic("No CLI available");

I think this this brings in at least a 3rd option now, we should try and
condense things a little or clean it up maybe. We have common/autoboot.c
which is what will fire off menu_show() and drop things in to that menu
instead of the cmdline (but that does have cmdline as an option to run,
and I suspect that just exits gracefully from the cmd). With CMDLINE=3Dn,
cli_loop prints we can't do anything and then panics, so we should also
maybe panic() in the case it bootstd_prog_boot fails rather than
continue?

--=20
Tom

--6OMrGGsJD5+VM5mq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXoDcACgkQFHw5/5Y0
tyy1VQwAmtcaXjCfEfQlGWrXykoWuRRcf5WVyIASBhQJNYQhjOqZmXgNiDgsBgrS
4ga9DEAF0aSYD5CnKhpSQUZjdblgoYQPpRTn1RNlPVN+EA8qDvsRhmQy/1f+K4GQ
vXbeKHlkewtQHZMYacn5TUPIZ66DnJnTA3DoecsrclwcS/QcDREkyWqdUTjXHgSA
hbbz+Ml5b/eEm/xL/0Fo1bqUMe/2Sk3ouymbvxpK56WGHBVFK/WRYzmDaeMe+DFl
YPMeMc/X2qaXt+LMhzrwlxrXOptt7usRW5yW31IIjdTDE0alHfd1UoaErZzxhEKG
0zEwRFh8tO9ws2O+UdHcDwb263LiwXKw2M3RRWMBSFRGaJHCJF1wLnBqSAxxkDLF
7nlJlFFg2fpgebtesmOnlPdbMUe1xU7FyjeEI3gC//s+GHeZlzGV730+VuObpQua
MtSVAQPqWyi+1yo/YmRoEpBCB/O2GBXyc0JqpkbJGeb1iCWyQrzj/w9c5mbG8eXB
HheITnPn
=srv8
-----END PGP SIGNATURE-----

--6OMrGGsJD5+VM5mq--
