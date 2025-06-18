Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30F3C7115A
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 14:07:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E6EA82B0F;
	Wed, 18 Jun 2025 16:07:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Fmt5jh5l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 794D582B0F; Wed, 18 Jun 2025 16:07:36 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBF4F80E9A
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 16:07:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-72c40235c34so1784241a34.3
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 07:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750255652; x=1750860452; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kivEGkpLvg20/zzEpxVxJslK7z2V0+siN6APOk3AiJs=;
 b=Fmt5jh5laF/hAVuoMvlWMuxCJIOFnz5urazghBen6j8anLWEdAaAvBlq3sic0B6EOr
 GQfCO0FhiSB2nQwFqbDN9ZL26v7p8KtWSr2uZOh5S4xAQTAU4xtuF2rMZZRRUOE0vN/4
 4uy4I0xleXGx+eyzYQotMDP4i8RYZ/UPt+S7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750255652; x=1750860452;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kivEGkpLvg20/zzEpxVxJslK7z2V0+siN6APOk3AiJs=;
 b=WhWPTPYwtIXlO+h+6XSCiYLCxBm1+lqU6/GV7qFK6N+zD7zFk9u8iZG/q//YWjv+jK
 Du6TXij925nr+rnSqWuug/BP/5fsqXjO8MxPKlS9xLTkyTfL82RYeymXzZgNJVR+Q1Fs
 DheD3j/6CgINIAzy5UlkZ/ph38t6rd67B5D2Fj+7LMssi80a3W4b6/jDI0MAFZw4+ibn
 SVeg+umogHVE0ly+5eHjJghFz9tGFinKrCrPeZelhDzE9zQ43xzXHDvivH6snzLQm3wR
 /NgI8P3VqTKwTCjT8SwXfbJ9EUqgGRd8fmChaZH0yZHSuS4AZGq9KQr4JonD6RK3f2MN
 5TKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh9Qnttw8EFaCYGw0AHysyULy/G24ZkM4fOZfwsxyI+YHXO+GC6kBEY7eLeMpgX2Q/x3Cd97o=@lists.denx.de
X-Gm-Message-State: AOJu0YznffjF6l3A/aefIc+b327qVsS/jRtKJp/cBKGmC1ROExGL58K4
 BunpHUpCmQdh1ht5h5CLyoP0uqxLo1142fzSlduRL64V6KbfSyBb4ASCNlyZxSCYGs0=
X-Gm-Gg: ASbGncs+B/DXJNYyML7vSKo+ipbXJZQ/6Rw2UTUEfiu2NQcSAPOqDZzwBdt/FNUEoqX
 lXX5VW4a/XAyHJRnSo/aGY/ZJY7FJB1uMt7IT5t42ioramH3rOa30kVYiIHcsoakfLttZzEJjC5
 STTrBtGdiVKx50ich/l93yi5kuTC2TlwpWtYRc0mF0zxNyP16l2HP5eLZOIXPSnEWCtoHTnkPu6
 VjAeXqgibzAsaHldmxPVMacPBf1lfJjvq2pbGDRhdPO3LJ38UUOHj5N01O94jU9NKsEutRjaq61
 WB1uvTEJSy22qNgHB1GRlw25ppbIgMEv3t54hhxjOcM50SdiQMb4Nez5CB89702fH0N+IajOql1
 x2TYxXRxdgBr9r3U0vyFedEI=
X-Google-Smtp-Source: AGHT+IFaQKazLgVOUY8Eg6lFjQFepKvwdGfj/WWewRL7R2Ix4K1MHwhUPq7xzMSkTxZWGQhl2LfExg==
X-Received: by 2002:a05:6830:418b:b0:72c:320b:f76b with SMTP id
 46e09a7af769-73a36270c14mr11323186a34.1.1750255652581; 
 Wed, 18 Jun 2025 07:07:32 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a517c6e26sm1041043a34.56.2025.06.18.07.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 07:07:32 -0700 (PDT)
Date: Wed, 18 Jun 2025 08:07:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: jerome.forissier@linaro.org, mikko.rapeli@linaro.org,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Boyan Karatotev <boyan.karatotev@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Liya Huang <1425075683@qq.com>, Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/3] nxp: Prepare macros for KVM changes
Message-ID: <20250618140729.GD6521@bill-the-cat>
References: <20250618065828.1312146-1-ilias.apalodimas@linaro.org>
 <20250618065828.1312146-2-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="71lICAbKafYbgN2/"
Content-Disposition: inline
In-Reply-To: <20250618065828.1312146-2-ilias.apalodimas@linaro.org>
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


--71lICAbKafYbgN2/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 09:58:12AM +0300, Ilias Apalodimas wrote:

> A following patch is replacing our IO accessors with
> do { ... } while(0) ones in order to make them usable with KVM.
>=20
> That leads to an error eventually looking like this:
> arch/arm/include/asm/io.h:62:9: error: expected expression before 'do'
>    62 |         do {                                            \
>       |         ^~
> arch/arm/include/asm/io.h:211:41: note: in expansion of macro '__raw_writ=
el'
>   211 | #define out_arch(type,endian,a,v)       __raw_write##type(cpu_to_=
##endian(v),a)
>       |                                         ^~~~~~~~~~~
> arch/arm/include/asm/io.h:223:25: note: in expansion of macro 'out_arch'
>   223 | #define out_be32(a,v)   out_arch(l,be32,a,v)
>       |                         ^~~~~~~~
> drivers/spi/fsl_dspi.c:127:17: note: in expansion of macro 'out_be32'
>   127 |                 out_be32(addr, val) : out_le32(addr, val);
>       |                 ^~~~~~~~
>=20
> So adjust the current macros and code to be compatible with the upcoming
> change.
>=20
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--71lICAbKafYbgN2/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhSyCEACgkQFHw5/5Y0
tywp3wwAgh7wy523EWnouVd4H/DFP6Xhet0cmNctgTHZKw4j69Y3QOEAjcZ1vXMD
Pl8VRphlMMwV5TCJSJfjPwuRZvH+ExVKvTkIAskoXafvgDgQ8c7hDBi6M75O2lM3
k1CG+iSJ3xXG6u6MyZMvgYHu7E56Ymx8Akb20wt4vnAycwmWLCzZaCHT4PxSC5Fj
mD2ZJ652rEgc/2clVkFJ/rtp/IcA8AdKQwpARs8/wcB4iXlsq8n2zm0FIPxsFe9F
ShEB88Hz7ydQ1HbvmHizuayNoPC/NdC0Gh8D8XG9dMjkte/4Atr5pkUZglldBf6F
nYtqw9HadL4VzvGtKLqUjLrQR913XvunlWSycOYFBjN652zLNtLfl0uaGhAYgMlj
/S3LwoaaclLyiICyr/LO/pLlLXzVcQnSlfKz1IHTkSk+jwbOiQXKhy3d3T6jmicC
TDhgHmoG4wMJBP0gjddTzsdM5kseD+beK2IYQFng+RY2vD6A0No0RIutxMTdY/69
vWDQJ3jM
=KOko
-----END PGP SIGNATURE-----

--71lICAbKafYbgN2/--
