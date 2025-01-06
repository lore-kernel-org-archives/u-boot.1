Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169F8E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 21:41:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E650805F4;
	Mon,  6 Jan 2025 22:41:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GwTElRup";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31B6E805FD; Mon,  6 Jan 2025 22:41:38 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2049801DB
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 22:41:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-467a8d2d7f1so121632041cf.1
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 13:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736199695; x=1736804495; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wacIlyhWQjg9hOZ0BKX8AGqxKbCT+AehZHaX/+XnPzM=;
 b=GwTElRupz3mUj3kUWzmP5wqdrzLVnyD2WlBvFGgtxHtTwA1Uz4aMLXY8Ik2zPevBPA
 9eqozYPTn90qF35YSSVQ4b7IL+8P2Urh66STtFr+TqFi4Llhi/WRUWgKtOaVVMgKMaS3
 I83GS8Z+fAuGj/aKlhYXBPLgfxfUfkCm8Shj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736199695; x=1736804495;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wacIlyhWQjg9hOZ0BKX8AGqxKbCT+AehZHaX/+XnPzM=;
 b=Ae7euvoMAnRg0604TSYhf+TNB1lPxxYSMD3bz05NEJB4epkBZLSpjbXd13WCENrGeq
 kdGWUhH+ccKzdSleVCB0M8h5GlnUci0G+MwMzSW4ViSSJZOC5BFypYT9/DP/aGoEZ9oB
 /yHREkXj5W+3qGuNWjDIT2Y0YvzlUvPkoBUoAIVspI7J86PvheHyjGxapjV2mU8c/z/g
 tCXx3oFnSmarO7c7JFon92Ll1KURcrMpjO0mtpsbPMzQt79jjjh7nWon6AYavHMPfM4k
 NS1Xm9NafYP6bs3jzcYlrrpcXuOGS87pPnIWGKcO5fhSbbRbl0gMSUxBWv0R4fE4MI5J
 Dgcw==
X-Gm-Message-State: AOJu0YxHFqFnaN1xrIZCfo0wsmCIUfvfvcyoehW0wkLOlyL0/6vAA9i0
 XRIRNUI9Zi+L2f7dOlp7lijq/qL0u4J2SbTotif4QHtdHtfNbJFwYc3HxZMCiF4=
X-Gm-Gg: ASbGncuJp4knMhqzL16ZqBAXEQ5oRu6cI98pa1zoL2w8MXZFA6+vlJOJzRDEWWttjKX
 V5J6+M2GTL64lDfCQtzBZMR0KxajTB+rugOOugXvEuObQWR/gQuG89/FYByOX1TFF4ByNCz8icW
 fHzHmKddRSuSRONtwvt9joPAWL9YKMv9b2zZ+CfppBf4BZyBnjaf1+9tX7+D2iiZS7ToCvGzPXg
 t2+GUrD9+86/OZg8t552F3nLUmIDpPL5S1lyTlmwnwHbfUhe4ZdEzs=
X-Google-Smtp-Source: AGHT+IHnAYnG/uOJJHkwRmXb1TM8KyGgPppie7nvabs1kgTUYn4HjngE5hVq1YQg/wVsUaXt+VvMwQ==
X-Received: by 2002:ac8:59c5:0:b0:467:5e71:73f5 with SMTP id
 d75a77b69052e-46a4a96b48bmr887083611cf.34.1736199694794; 
 Mon, 06 Jan 2025 13:41:34 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e6a7eecsm179920071cf.39.2025.01.06.13.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 13:41:34 -0800 (PST)
Date: Mon, 6 Jan 2025 15:41:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alex Shumsky <alexthreed@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Dragan Simic <dsimic@manjaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Jonas Karlman <jonas@kwiboo.se>, Joshua Watt <jpewhacker@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v2 03/33] bloblist: Make BLOBLIST_ALLOC the default
Message-ID: <20250106214130.GC3476@bill-the-cat>
References: <20250106143229.3023771-1-sjg@chromium.org>
 <20250106143229.3023771-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="g22O+pxTdbUqAP+J"
Content-Disposition: inline
In-Reply-To: <20250106143229.3023771-4-sjg@chromium.org>
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


--g22O+pxTdbUqAP+J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2025 at 07:31:59AM -0700, Simon Glass wrote:

> We want to encourage people to use an allocated bloblist since it is
> more flexible than a fixed one. Make this the default, being sure not to
> change existing users.
>=20
> The unit tests require BLOBLIST_FIXED so add a dependency in the
> Makefile to avoid build errors.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
[snip]
> diff --git a/common/Kconfig b/common/Kconfig
> index e8d89bf6eb9..a00387a4609 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -1039,16 +1039,10 @@ if BLOBLIST
> =20
>  choice
>  	prompt "Bloblist location"
> +	default BLOBLIST_FIXED if SANDBOX
>  	help
>  	  Select the location of the bloblist, via various means.

This should just be "default BLOBLIST_ALLOC" and sandbox platforms that
are using the bloblist can be like the other platforms using a fixed
address.

--=20
Tom

--g22O+pxTdbUqAP+J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd8TgoACgkQFHw5/5Y0
tyxBegwAqRmh+elfvN2esBvJslVKnvlpsX/D8DbO/hyZtFSqbDBeAghQTtdjktR7
vIY2dyk0kgjPyEuiZt2ul810rqWfGou3Z/DtZUIU1KVRirOT2xHU7w3iYDswBEKq
SRW8603CgOkSTbed9pQko5Ps+ZXYaSVt7VMG1EeVfT0RzAkclKjnl5QW7cuhUy36
Q+oz6+E5zTg6pE07v8W/lX3hdEM2l5+MgceiQse0oVf82HWJ/B5bGK4Kkq61prd5
yegJ+bvTMPqwPvSBPGURTy0ZdJ5vLUKIFBbvTRxIxMYFzp28UOCbpmeW2XPEw7a7
xwdQZb9a8tvvZ+iOudlb3znXvXIxUQeEhx4wrmSJBbV2p9qA0VHdn+IFVvNWeHb1
ZjaIkIc9iNETNJed7Pi2pEz8nH6+oVqhfHQHf59VF6oOqEpxEzNoTswUE/q71FBA
6LsQm3kHYTgYQktEf84m0wsaMj4eGJKkcTE5WOq3oQf1Ng+nkHFL/PmZmZtvBIPw
BGwj7X4h
=O9Z6
-----END PGP SIGNATURE-----

--g22O+pxTdbUqAP+J--
