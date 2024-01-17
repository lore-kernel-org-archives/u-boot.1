Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21101C47DA2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 14:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D91D987B9E;
	Wed, 17 Jan 2024 15:26:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nm9iCsZi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C76987B50; Wed, 17 Jan 2024 15:26:52 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B9A387B9B
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 15:26:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5ff7dd8d7ceso436317b3.0
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 06:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705501609; x=1706106409; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CjIaljm+bLOFMUhc2c46AsyrzMkjdOdVDqdburTx+Tg=;
 b=nm9iCsZiEzE7OS5Ko5MeTG2zxFY2XeeC2j4hqbvU7Y5/dIEsaxbKIt6OklkmrIg41g
 eRMmJVovRyDWpHMnOcprlAshINj4fO6ews4Sg+9DkDbWu7uflnRgcbv6igb9eKL7Sics
 jDnxayMExUPxszXeSQ2F+dKP3baPQk5VHOhsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705501609; x=1706106409;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CjIaljm+bLOFMUhc2c46AsyrzMkjdOdVDqdburTx+Tg=;
 b=exXhdZ60CN1mV44LmNTLTcCrrF/a6hb5424ONHB7AgqCHCKX+caHsslG+fpB+scVge
 +0EXDQztLkeuYB4BXwENQK2fn4F6KtV81QOblW5OblioCHu+d/vMxcs/SSj0lmunuymp
 kO2rNfrw6zruK/qdEdXAhJ241SAGzJHnAztB9xU7uzlD/HZbRBtHax83EK0J6VAxscLB
 qDZhSjrO6ZRHw/MP1iMALmub/hAd8R63nn3II1dR1rSLRxAhLlelJh4wlZCe580cKwmz
 In9wtS4t5QewdK5YhT6sbLbWLrchjuP26r0+4yB24EJErw5rM/aV2IY26kZbaQjkIkb2
 3yhQ==
X-Gm-Message-State: AOJu0YwEKuw9J1BkCwWy1EFOX+3dqhZ7cAzNTEoXU50d+ISboX3vs3SL
 6rO/uYV/ZOHiu8dUethH/SSamRea2IvJPQ==
X-Google-Smtp-Source: AGHT+IGm47qtQ7MskGeEdpugm44+fgn66VeJUIiCWRBMgrh+/xJxkvul+e1IOslzApPXAFORbsynDg==
X-Received: by 2002:a81:b606:0:b0:5ff:5fd9:a43f with SMTP id
 u6-20020a81b606000000b005ff5fd9a43fmr1685840ywh.39.1705501608725; 
 Wed, 17 Jan 2024 06:26:48 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 w196-20020a0dd4cd000000b005ff7e023754sm19811ywd.55.2024.01.17.06.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 06:26:48 -0800 (PST)
Date: Wed, 17 Jan 2024 09:26:46 -0500
From: Tom Rini <trini@konsulko.com>
To: TracyMg_Li@outlook.com
Cc: jagan@amarulasolutions.com, andre.przywara@arm.com, festevam@gmail.com,
 patrick.delaunay@foss.st.com, tharvey@gateworks.com,
 pbrobinson@gmail.com, weichangzheng@phytium.com.cn, hs@denx.de,
 d-gerlach@ti.com, u-boot@lists.denx.de, robh+dt@kernel.org
Subject: Re: [PATCH V4] ARM add initial support for the Phytium Pe2201 Board.
Message-ID: <20240117142646.GQ12635@bill-the-cat>
References: <TYSPR01MB58854E5328ACD3462C60E612F199A@TYSPR01MB5885.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sE/tH6E2q1t6UJjg"
Content-Disposition: inline
In-Reply-To: <TYSPR01MB58854E5328ACD3462C60E612F199A@TYSPR01MB5885.apcprd01.prod.exchangelabs.com>
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


--sE/tH6E2q1t6UJjg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 25, 2023 at 11:21:34AM +0800, TracyMg_Li@outlook.com wrote:

> From: TracyMg_Li <TracyMg_Li@outlook.com>
>=20
> Add pe2201 platform code and the device tree of pe2201 platform board.
> The initial support comprises the UART and PCIe.
>=20
> Signed-off-by: TracyMg_Li <TracyMg_Li@outlook.com>
> Changes since v1:
>         fix space corrupt.
> Changes since v2:
>         switch to bootstd and text environment.
> Changes since v3:
>         add environment variables.

Applied to u-boot/master, thanks!

--=20
Tom

--sE/tH6E2q1t6UJjg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWn46YACgkQFHw5/5Y0
tyx9ogv+MoRSqdGJauL3OeGbB3Qe6Ixw/Qnrj5VbHAYbp9dgnz3q69jIA/cl4Ion
T9Wq0MaCiao06RS+GOOuElQb/dMcivv+nG1IkYcuKXlc5oRa46LFPB0Tx4luB2HI
0lXpchDs3IWwepRSVHnJTY6FkGSQyKKVe5SqKqCsYs+ZjL82aq9bPgr0hvn66T8R
yQxa/ZFkPn+gawF/pkxhHfEHUIJNmeBJCB+MwfxbAkAZ+7W7w+Y5ug+XjRnnmqzo
wxxJsmHcxMWlscKMdLkKs8h8J0y6IOqY8SgXtuyh35FzGaNW5QllX4e4VSZGs4bu
XlcpbpKPNPEEgOUUw+AcYczIhfgH1mQYz1iQF7deMpDKikS/EKR8wNDQ6YXqDm3k
oTdYwqsz/HVLVw/0ijndLoUErAvJF5bXKVh8l+Wa4bZ+ddWwkkIYWdXEoeXnxc/v
m/Crn9gllNHBTMguEUY+519YPx5ge/az+9GI3flzSJOk/pxMe4GKY+LvAOlGlZVH
FfnZJF7o
=QNde
-----END PGP SIGNATURE-----

--sE/tH6E2q1t6UJjg--
