Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C98C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 19:09:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 629D187509;
	Wed,  3 Jan 2024 20:09:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tVyMiVG9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAE1A87509; Wed,  3 Jan 2024 20:09:00 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78A588747A
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 20:08:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4281f6400feso5415341cf.1
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 11:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704308937; x=1704913737; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=y3TZtnKnnfFp09ug1Rfah8dFCbISzdChVvCGrQL2O/w=;
 b=tVyMiVG9TuGdPhhnkcJAfus8RQY4AvkHcheJQIxltvxGhozvQCV9RZWQwAel4ThVW3
 XMcgGzEktFPOLnS+GkdWzLMnesLO8F83kzWS43i3uiSCNbWpSazicgPHmmaQX0cLyIKn
 fKFxqHkqByOpmRfEk9HOBxE8ezhumh1QeiPb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704308937; x=1704913737;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y3TZtnKnnfFp09ug1Rfah8dFCbISzdChVvCGrQL2O/w=;
 b=F1k23yabTGbe06Js6vzunUN6QV+JR2HosNbGdjMe0C0HI4MLBXARPArurfui6rhfdL
 7yLOIiphIvd9ioQm4IFZeGVrQx56wUCatOMPN3klgDKIfSfvxk9hcBCtV7/7lkBPGVzW
 o7tjP81i7JbiK8GsAQ7kzGP6/3HJ/jntd3gNwPLsS8c6j1c7i3Xw1XoZ0jISqwNFLBWp
 bbAnUTt7I6DL7Ax4js4QpazEluJquLP6B2Wim59987ln1BWqWUfBt8n6icT6131RCp+u
 14kzMO6bkLGuAFQDtiAMoaVwgSMzRto0IDJNC9E4f4qXvpLkDI8vwWXskHsnjWwj1M+a
 Perg==
X-Gm-Message-State: AOJu0Yxcxoeztdh5C1zz2KTJL2r89QDCvyoHTBbNzQO5qX5NmFZll3zd
 9bMWYcUGcQNZ3TWQ3qqYvFEinGrOb0xrPw==
X-Google-Smtp-Source: AGHT+IED30IoLxLsC3FhqkOn+l3te2t1pvg2SEemV2XCuwszwRLmCBWY5yKCIN1MQ701Edvp0o1BrA==
X-Received: by 2002:ac8:598a:0:b0:423:780f:593f with SMTP id
 e10-20020ac8598a000000b00423780f593fmr2656244qte.6.1704308937034; 
 Wed, 03 Jan 2024 11:08:57 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 hb3-20020a05622a2b4300b00427774ecbd6sm10830070qtb.32.2024.01.03.11.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 11:08:56 -0800 (PST)
Date: Wed, 3 Jan 2024 14:08:54 -0500
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Nikhil M Jain <n-jain1@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v4 4/9] arm: armv7: save boot arguments
Message-ID: <20240103190854.GN1610741@bill-the-cat>
References: <20240102221237.1007090-1-raymond.mao@linaro.org>
 <20240102221237.1007090-5-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Jmq5OfSFYtKcn05y"
Content-Disposition: inline
In-Reply-To: <20240102221237.1007090-5-raymond.mao@linaro.org>
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


--Jmq5OfSFYtKcn05y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2024 at 02:12:29PM -0800, Raymond Mao wrote:

> Save boot arguments r[0-3] into an array for handover of bloblist from
> previous boot stage.
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - New patch file created for v2.
> Changes in v3
> - Swap value of r0 with r2.
> Changes in v4
> - Fix a bug when saving the boot args.
>=20
>  arch/arm/cpu/armv7/start.S | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

So on platforms with SAVE_PREV_BL_INITRAMFS_START_ADDR /
SAVE_PREV_BL_FDT_ADDR we have this same logic, but in C, and it's
working and fine, given what we do. So could we not follow the example
of arch/arm/lib/save_prev_bl_data.c and have
arch/arm/lib/bloblist.c and have just one implementation for arm32/64?

--=20
Tom

--Jmq5OfSFYtKcn05y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWVsMMACgkQFHw5/5Y0
tyxwQgv/ZV/Cy1lbFptO2Pwt7QMXyW+IyhFOO0f90IAR/4NgfDEeWXxECx70bh+v
ZESH7PBxyTYccCcoCzEoX+JemsPtzB3siijwOYVBVWHcJH/YifbjsIderjcHK4cK
6vSdq0srRFZzimC9RJ3/aYoCqGyesIbN3rh6HZMimHCYzp8Fg6KtZwupN8sQhASd
1dWO8z0dktM6gTF+YjecK4z6nEjWzuusTEvNq4Hxq0JR5aDPCzqPWnMMSvqkIaMz
hnxwcR9sPoQW/awLyGGCgzH6fHgdcJ9+/W7/DmuSpGaGErgn4kRAlkOqkezMlr9D
Rezc5FkNLxS5hhMmH389v2et1nwlp8uBW6NVAynFRgmh/emhPXLZIgfjfHNrr2OF
I06Vi+XjVlMwzDyjjlAKwFPIfGruCV9XzCvI+wE/xU77b/0cPHLtDBOJjQ+Z+As7
/zCOmQzzG0BFTOQ8zqJ7lJNYidm0UOG+6ULlaX+A2RiXSlQylo0SUAnbME4y80u4
If766g4t
=1rQC
-----END PGP SIGNATURE-----

--Jmq5OfSFYtKcn05y--
