Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5D6D3F09D
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 16:53:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62BDD83FFF;
	Thu, 29 Jan 2026 17:53:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W7r/FG+Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47CB58405E; Thu, 29 Jan 2026 17:53:47 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C69283F32
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 17:53:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-45eabce608dso857458b6e.2
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 08:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769705624; x=1770310424; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YWGdxOu0lRmJmLFantiV5n45WgrpJyL5ZtNddxkyzU0=;
 b=W7r/FG+QhGRUzmFs5/dRCNHXg0RqDrOgGC5TJtStAps3p1M6zScozoqRJWF36qYrnU
 jVpgC7ObQnxcvaZBZvnJQqkqnrw19vErzSOxeCZzsiDL7HOfx5EFx/fXT6+xWb0dIw+P
 mMp7+fx2ngsGU8xUnBvQhfadKi8cfaeXEnJ4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769705624; x=1770310424;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YWGdxOu0lRmJmLFantiV5n45WgrpJyL5ZtNddxkyzU0=;
 b=fHIJbJMmpZD34em42WKsKi3pxP6PjC3yUtThvXuGAEpEv9cHoAsIBJoS0wohumTGyC
 5I0u2Q7Yaw96RlWhxKJcpL6x1QNl08hstOixc3er2x6M9F2eWDFA0QwJZTYAA3Ck68Ox
 a1vNmZ+Frz6cK6NVOkcbqTczP2Xo36ioJN07m9KxwJdps9pct3Wustp8oqi6yDs23ZXB
 Y66KGZDdhIFuDnjry6EUDJQ7zegQ65fsx34fDF/pmiut2s6WxwzBe2rC2a7pcnzvriKq
 4YVgOMdDwMksJLdBQNgS4OMSHcKvbraY+21Eq8KVBdHpyDt2VLvnTOVdL7QgzbupJwR2
 iMRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2MrJsaXR98x93Zm+ebkZBx5QZ7jxvL9eW/6FCZb1dkTPTE833vVNm9ialPyOcC2IN04irJ88=@lists.denx.de
X-Gm-Message-State: AOJu0Yz12lJYo+WsrnIhq2r8kDrisL4qoFgpjxdByMLb7TRrDuZ/GIAD
 I37RFFUA0V2DKudNIOFs9sRBMkABHLoM1Bdpjck9ZlaB4Gvr7zP2+xIpsGRcveyX/70=
X-Gm-Gg: AZuq6aLucxmGpZ5yvMjgIcjW4/DoEK1NNknNpN3hqk84BY6zAKg0vsN3nOHDpgeA9rs
 EIaqE3FnSPTrk5buKI9nKaW8kfSH4DL7MqpM9UUudIoCTWQOb95ETzHoQEl8UMdKE5p4mR7qRju
 jdzd+bdDwB1kI/QfVciTJAcGlGANdmrLz56DXwSY3gXEa4A7uoMdryf/Gv91Gf0OfVCUoG6vEoW
 g8ce/YZe+iFGu+bM/Du4Szabf2236RslGsSGudB3lEoTH3QvvkRNIqHhaSbFLYq7cOpdn/PeJ3C
 So+Kl76l/+Agpp1UaithyKg5fd9FO3I6r/nQMPv5vS0yUhJK0RisGTnnHFgDteX7xRQLwH4y0kJ
 0GKj8lVE5+soZqL10vUbMZ2UwdGWS0lc5YBou72MDHAZlkNrVDCCJ+CkU52j3MCzDrK/K/jOXq/
 9Nd3j5sejfi9hGL6R6p12EPAqEiMt7vbWRQxzeYxG/SR/kK+tBMnspekBtrCVzSLl+XF0XsY+3z
 9cj62Cmi2kXm5xlkwld7mvxY5sINHDBrwP/Pks=
X-Received: by 2002:a05:6808:a596:20b0:45a:683b:7442 with SMTP id
 5614622812f47-45f34d97cb3mr80549b6e.65.1769705623913; 
 Thu, 29 Jan 2026 08:53:43 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45f08e23c09sm3323346b6e.9.2026.01.29.08.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:53:43 -0800 (PST)
Date: Thu, 29 Jan 2026 10:53:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Alexander Graf <agraf@csgraf.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Subject: Re: [PATCH 1/3] gunzip: Add ability to disable progress indicator
Message-ID: <20260129165341.GC2044980@bill-the-cat>
References: <20260127235914.1503663-1-marek.vasut+renesas@mailbox.org>
 <87wm10mm0g.fsf@kernel.org>
 <0af7fd1f-7f8b-4ef4-b8ba-9df260fb8f81@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BJNYy0aLnVwU/hwO"
Content-Disposition: inline
In-Reply-To: <0af7fd1f-7f8b-4ef4-b8ba-9df260fb8f81@mailbox.org>
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


--BJNYy0aLnVwU/hwO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 05:33:45PM +0100, Marek Vasut wrote:
> On 1/29/26 5:17 PM, Mattijs Korpershoek wrote:
>=20
> Hi,
>=20
> > +++ b/lib/gunzip.c
> > @@ -8,6 +8,7 @@
> >   #include <command.h>
> >   #include <console.h>
> >   #include <div64.h>
> > +#include <env.h>
> >   #include <gzip.h>
> >   #include <image.h>
> >   #include <malloc.h>
>=20
> This is part of
>=20
> gunzip: Implement chunked decompression
>=20
> so clearly I should move that part here already.
>=20
> > Maybe this should be included conditionally depending on the command
> > being enabled or not?
> Why conditionally ?

A good general question I had is, what's the overall size impact of
these features?

--=20
Tom

--BJNYy0aLnVwU/hwO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXuQlAAKCRAr4qD1Cr/k
CqTDAQDroS/X0s0I1kUrDD29QLF1LLixVR45cHH0jjqddtSW3AEA/9iywoy+uB/G
0mzGweHBkM7/90PXLstCZNGHlvdaVwk=
=QhM5
-----END PGP SIGNATURE-----

--BJNYy0aLnVwU/hwO--
