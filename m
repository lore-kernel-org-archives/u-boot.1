Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C16B606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 18:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ktu3E0zw;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=lePZn7Hq
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8C1C60661;
	Mon, 26 Oct 2026 18:05:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JZ2KQBoqqsq6; Mon, 26 Oct 2026 18:05:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E97DC60635
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793037941;
	b=QyGtIu3TpTs55yxt5dLge4YpJtTsuGpNRghynYLxzvKeT8TAEuozGVsoSPLva2D9oo2I
	 aOPPpYVNFtKYdh4Dug6rsU0nmPicIBV9baZ11hYWC/b1UtlBeXIwzsLDtTUoRDtN8c6LW
	 qTmOfaen1pv+mB1h+tFl2gjXj8L+S5D1dsYzyPNce0Jz6OFCDoRg/mt91uM/gbqufrF8v
	 ZQZXKNrY98CmdtrJKR5mPTxJRNvWpDNugkND/BJFbIJ1bYb+NjrvlHr2Ys3oEC6zgD88J
	 LQj6lf0yQXwnix8OXXRXU9IpjEKKcoTJu5Bil4JkDRt5/H3CMUkiRI1RPGssIHfUgww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793037941;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=e9QBufrmZGBsq96kBZkuVZRWGrdh3qgUijP1McID1HU=;
	b=Hegk2OeYW/LAIVmMzmVrhtp+3NYu/p3n4WcQN+27GiZ8KrRKZpeGCsNFUz0j5P+qrJV+
	 k6Wf91nOuzaw9D4i4RiYD8TiJsFfkondK5Tytle8K5sLu4j/ViE2dwmn5D26l9sTiuQf4
	 lL5DmABJu02W62+x8RuzJEYyFwgg08SrnAH1QxeL4X+mvcdc74TBTBzStKIoDz5leQZe5
	 PAuqcwjPplhc4t0FcXDBbgLg0DVdam0mBnLITmxNyOOnwLCELPk6K6Mqyb5ZJAn4LL1aw
	 A+TqiBzrHOr+x3DVHY/u/XQW+9beKawHtz9YhBvImzX5MGAcQi1cLIQmbTbKhQ0gg1Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=lePZn7Hq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793037941;
	bh=e9QBufrmZGBsq96kBZkuVZRWGrdh3qgUijP1McID1HU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ktu3E0zwI/SqwuhUg+epkSp+6DL5na2hSCIXrxRVZOB3MksF+QOyjnQBiShSxhB4J
	 7GQ649cFW7UBcWewxltFGqCFJpsTkSaeMDEzC9b76+YhldxCaL/3SmScNrzD8yFdqt
	 urJ9l7o+hhy7IGmmllUMO8RdDUQoVEfXgaOhD9ZGryC4PcI01UO9VE0BI922QBntp/
	 JNbnPqJ4Xh3REJVJFGq0Cv7R1w+o6quPAKB0J7PJcM8nee3WiyKQqCVh/0RiW4I9iO
	 FcWT7AiNokRoEIby+cTRIKDHtwWnU0y4jSxRNqh72qCG17MNzqeE9WK49dRvJo6ZGU
	 TVwqenvNhDguw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E97DC60635;
	Mon, 26 Oct 2026 18:05:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B1AC1356
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 18:05:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A2ED560635
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 18:05:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QOVqQsRlxUvA for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 18:05:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C62C0605EE
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793037939;
 b=iXjkwAWE4N+GNW7b0jsa0hhSsgkyYikz3qCi7M22YJdF3jBLeAgtKDzZUhBqU21Sfuut
 yMCxaxcFDcKEGi/3SKydcwNdhWHtnKa6SD7PQA7AdoQk48TLpN7+JmrYsN0KdTNSh9pFR
 21mr0Uhgc4tzAfhOsu4BQeiw6JA7LUkGbSKy4vUXXvzWQeGuwDk6EQDH1sDh2zfytfq5v
 VoapAHAuJM+p2nrJCNrTh+C80bTuNfKnhhKhilK9qvFhB5mOJwPMPpapuet6LZKlMnSo0
 Kbqx9MwbFCjXAMRNolxQnnfi+rDiIJBRVu5eWMLd0RPw92yDgg9XOauvWI7A37/PQzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793037939;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=e9QBufrmZGBsq96kBZkuVZRWGrdh3qgUijP1McID1HU=;
 b=cP0HREWBluVyQo4LF4bDWSixG+nLNjldmV96NL+G8/CX3mkLsLJshaJQokDpBlp7gmVM
 zX2Hcv7+yWa++xqVmnZc+0zw3YavB5L9YSHqrWGE8w9TrHMJstdeUs2bBP7ayOkc6ZShd
 4jxc4nFrZUGcFasJyGLTVFLP1qvrkJ4Ypxd7OtpTIarWH5j+wOeMAQZ4CdtjPQArZHpJL
 0uUZOV8yf2rMG5WhM/ksM2kFT9CewOpEDlAKQW6k9Cc1ktIteM/9R0FKnmjCZ27A8Sjkx
 TYmHe5e5tdbo7iaUe8SOESQRk6j6on/+wVTfIYfNrXAmoY36Oec30a0JqIx7+ZhduJg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=lePZn7Hq; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=lePZn7Hq
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C62C0605EE
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 18:05:38 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-845788309b4so1578003a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 11:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793037937; x=1793642737;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e9QBufrmZGBsq96kBZkuVZRWGrdh3qgUijP1McID1HU=;
 b=lePZn7Hq44fSpw8AQuKGbuBWFy6xTG+lH2W9Sxh/9gm2IZeFYzLK6C+ln5HfPfXKXe
 1uynbUIRtKP0kS4ToJ1MeFCq1eqkFzhcOL3BqVQDc6eYHXV0n+il553V0EJH+LAvcBm1
 TIiSrdbTnhFelBrI0Nch5d0+mHBNM2/mJQXPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793037937; x=1793642737;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e9QBufrmZGBsq96kBZkuVZRWGrdh3qgUijP1McID1HU=;
 b=fhMB90s5iKjxbeLEgJl4MeWpNKVL1o/tdMdZdm6QwP8wJN3l5UUq7E5AjB3tdyHCa8
 mkrkMV/aU4LBZvhdbKjAsR5Aa82AfMrmUzNVja0r+Zn4ug9qn7gw3YI/S7+kybfB90Jo
 BJycUPMCTH4gRsZVR8VbkRFpHKcbGpUFYn1mqjYMJFe7VCC8C3EyWwC7Mu/Lem6A0O72
 vYFZiEuEt4FqcSLhBqVk1Scsv01taDDtKlTNQxHEBmR5T6JHuD8Y4BDUbLt8SC5+beMS
 uyK4PFvVCtkPMh7WBaVZtQ31qmMu7w0j44Lnp1S5lbca5x3AJdsuUjvEdTi9Gjncf0ek
 XXEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZhnFTx0yhwnTpanyUzCHfNtMavB5MHkzCH57jb/SunqcU0/k7dVBmO9BxWqogTw/tLx5glRg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJwDXPY0z8V4I0H3j+1IvCmt5Xh3Kzh/1ihLhpzvsuPLFa+txma
 QynU37t84jW9aI7T0sB0PxfBWKrpRaIX1L7cTm7eo3cjtH7vqH4eVRMfIlNnbYlq2+4=
X-Gm-Gg: AYBFou19uvj7TowQ2zFuw11zwu74S/IdXWAAimJZqO+gsNi+TVLOrJpew6lG2Y/X8Yc
 HlYnbMhwohdyXkrUenw7F29i5mnsaU0HjhnVmHvuY+3SXDYsun1i88EXhuGsxnHjs6GSs6WJXGx
 LzhbxTPZTniPIF6OAFKwPtuaq0mzkvFrDbgfI132hzfltabA2sGRkc0QSkqpHmpyRDSv5GXUGq1
 72Z8k/Jan/5wKIeZgKiSLE4fO3TEQJ3O/+gAu2huHa8YOFCPBUK4/LplxrAl0N8XyeFSa2uB6E4
 d+LCxP8w4vraGyKLAh5ISUMBonxk0VPd57zF4Es4xtMroipw/+UoRze+CHa30aDeCmOUeCxi3CN
 4WavQQUuaL3BAAXMDHC38PyI/npsZbbXTzcSRWHnTK4uhGDY5xV1QShmujuytaIDdgVmSOagoke
 J5FTx7NNXEFi09zY5ud0eNrSHd+Va05La0kbgtRrmGSZtBRlnfVg2/hZVQG9ROE1Ewqzp8E6Owd
 G6huWRn2rWx2+PcSpLSAzY1+LvnY8aWCTTXgSMbmNE1VkUvCQJP8JYP1xMzQQg+JtSXUiJEnUkB
 XPzLGO9OJfwlpu5O3aGJILKSWU4ddz3RAAPbR6+gHAvJ87I/EQoDvXpZ6+GbNPnMzKP66KZBxgr
 +Soqy8l4SIPuf8RVTmLs7mxdk+jJPwK1v/DCMVQwgFC/oujlgESO3d7ZD3Q==
X-Received: by 2002:a05:6808:4fe6:b0:4a1:296:adec with SMTP id
 5614622812f47-55c0026d313mr6658349b6e.15.1793037937114; 
 Mon, 26 Oct 2026 11:05:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-55c04248804sm5759800b6e.3.2026.10.26.11.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 11:05:36 -0700 (PDT)
Date: Mon, 26 Oct 2026 12:05:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: dlechner@baylibre.com, Macpaul Lin <macpaul.lin@mediatek.com>,
 u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
Subject: Re: [PATCH 1/2] fdtdec: apply bloblist DT overlays to the built-in
 devicetree
Message-ID: <20261026180534.GH646438@bill-the-cat>
References: <20261023-mtk-mt8189-tfa-fdt-v1-0-f86616860bcb@baylibre.com>
 <20261023-mtk-mt8189-tfa-fdt-v1-1-f86616860bcb@baylibre.com>
 <CAFLszTh8aCgwOdA6v0O7k4-B_7pSBS1HYs6vBqCvwCtDXGn80A@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tIdNoo2brRCUc9/b"
Content-Disposition: inline
In-Reply-To: <CAFLszTh8aCgwOdA6v0O7k4-B_7pSBS1HYs6vBqCvwCtDXGn80A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--tIdNoo2brRCUc9/b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 09:34:11AM -0700, Simon Glass wrote:
> Hi David,
>=20
> On 2026-10-23T22:32:44, David Lechner <dlechner@baylibre.com> wrote:
> > fdtdec: apply bloblist DT overlays to the built-in devicetree
> >
> > Apply the devicetree overlays passed in a bloblist in the case when the
> > bloblist does not contain the devicetree itself. To do so, copy the
> > devicetree that U-Boot found by other means, e.g. the one appended to
> > U-Boot, into the bloblist and apply the overlays to the copy. This runs
> > early in the boot sequence so the bloblist is the only memory with room
> > for the devicetree to grow. And we can reuse the existing code that
> > already applies overlays to a devicetree in the bloblist that way.
> >
> > This lets a previous stage describe what only it knows, such as the
> > size of the DRAM it has initialized and the memory reserved for the
> > hardware, without having to provide the whole devicetree of U-Boot.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> >
> >  doc/develop/devicetree/control.rst |  5 ++++-
> >  lib/fdtdec.c                       | 32 ++++++++++++++++++++++++++++++=
++
> >  2 files changed, 36 insertions(+), 1 deletion(-)
[snip]
> > diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > @@ -1818,6 +1818,36 @@ static int fdtdec_apply_bloblist_dtos(void)
> > +	if (!CONFIG_IS_ENABLED(OF_LIBFDT_OVERLAY) ||
> > +	    !CONFIG_IS_ENABLED(BLOBLIST) ||
> > +	    !(gd->flags & GD_FLG_BLOBLIST_HANDOFF) ||
> > +	    !bloblist_find(BLOBLISTT_FDT_OVERLAY, 0) ||
> > +	    bloblist_find(BLOBLISTT_CONTROL_FDT, 0))
> > +		return 0;
>=20
> One thing I'd like to check is xPL. If SPL receives a bloblist with
> overlays but no devicetree, it adds its own devicetree, which is
> pruned to the bootph nodes. U-Boot proper then finds
> BLOBLISTT_CONTROL_FDT and uses SPL's cut-down DT instead of its own,
> and applies the overlays a second time. This doesn't affect MT8189
> since it has no SPL, but this is generic code. Perhaps restrict this
> to U-Boot proper, e.g. with a check on xpl_phase()? What do you think?

We don't support overlays in SPL at this time (and per the other
mediatek thread, I have some questions about what handoff we do support
today), and there's some level of complexity and use-case-understanding
to do before we could. Lets not start digging in to that just yet. That
said, I'm not happy with all the conditionals there, but lets make sure
we have the problem statement fully understood before we get down to the
implementation details.

--=20
Tom

--tIdNoo2brRCUc9/b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCat+WagAKCRAr4qD1Cr/k
ClWiAP42dVHFbuOQAOTdxOgsA351PHBbeEeofZbIkGc4cyuLWwD/YZuY53b8Gjn3
YP7H7xt/3SI8NklEaWQbBebYch4cYQY=
=jiBl
-----END PGP SIGNATURE-----

--tIdNoo2brRCUc9/b--
