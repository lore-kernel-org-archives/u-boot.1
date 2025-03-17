Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F149CC282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 14:06:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B377810F4;
	Mon, 17 Mar 2025 15:06:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VUkorvwV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D17F2810F5; Mon, 17 Mar 2025 15:06:48 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B52080F70
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 15:06:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6ff1e375a47so38276997b3.1
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 07:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742220405; x=1742825205; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dSrDfb2VgS9DftruOgPjxjMekMpPCavXjsch9ANmVVI=;
 b=VUkorvwVU9VlnLf4ZRx4gwK5iLyFhEAcg2CC4Qe8qqFySwAPYgTD7u31dQ0zm7c/iW
 EdtXuOIM3oU+j1YpjO21Y1JkrjOtFG1FdKUkU5Tr/Y3ZvkuPyT04fsNFjD6LTr+IWAoN
 Pl6U3L5z/h2rLymQnVqf4flD1OXP10n6vpky4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742220405; x=1742825205;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dSrDfb2VgS9DftruOgPjxjMekMpPCavXjsch9ANmVVI=;
 b=prJOd6JFlwIkFBWqHkfCfpLEmAM3j3dEZnEpJsVkbTFeh5ZcB4F5VGXbP7pKeBgZls
 T6X09+MP7TbbZhymnxvhw3xJuv+sNdEIWoPwARGYrnNf6WmLzkdIvsL3WLCM5jweHWp4
 e+hgfT3fz0CMp9YOaeMXQKd7IQSe2V2oNFhJYkj634/v2v2VhO0yzAbU239OTsskElGC
 HKl07d7Ca7C0VOlw+htQQOEWLklfSmYQOs4HILQzPDer87d7sMdLAocKom6zxUfsHxGt
 i+8rLEcHrzbB7Uyk3MWZiokB+w6aNNFh3/ndT/YTdJHlNarmphQ2+FqDBdu8N5NJ8slX
 UHWA==
X-Gm-Message-State: AOJu0YypmlHo7q9+GMINiJqwNoolqq8A/hYkTgpaPINgZw08rGzbq9HO
 3AERWbpuwoieaax74Nyh9MTbJJUXdQmOtOdht2JQhPgIlLIBtHzZO5cZqpqPKHo=
X-Gm-Gg: ASbGncvmX+fAAyFbDcdRM6FJxybRB1k7COqkxuyjMTTU4u3Yp6FfeomaSbraFa+eCpc
 bVUcj4TO/Zh3GnFnvrDC2QKF5mr3VLu1uSvH3RHIDkWUpb4ruoBs3eUAxntaBhrZl7TBBldVPDX
 rx7VdVkpKmhpwDPBmJZbz0wG5MGNhC8YUkdJ1vbk6w4hJ8C0Uuq2AuhahQqN1ubJzJRYenJ0e85
 TKl/tD8edjnbanjhKZTPLpGo+WbY2CtBflm1iCUdsI65Tv7k6QQLtrJFyxj+sO2y8MIg0Lur//g
 ncACYjIaUTFLph5L+GKoGCEips7a2qocwjNT2u6vek9mDw==
X-Google-Smtp-Source: AGHT+IFXJ+bkhqCmgkyvBHh+LpedeJgdsMatB+WLs1TWz8UL2tV20nuQpAvNXikObg0ER9EuQb3vRg==
X-Received: by 2002:a05:690c:4d02:b0:6fe:bf9d:f6de with SMTP id
 00721157ae682-6ff45be03dfmr154777847b3.0.1742220405015; 
 Mon, 17 Mar 2025 07:06:45 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6ff32cb5971sm21633087b3.108.2025.03.17.07.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 07:06:44 -0700 (PDT)
Date: Mon, 17 Mar 2025 08:06:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com
Subject: Re: [PATCH] cmd: version: Get information about GCC and LD back
Message-ID: <20250317140641.GN2640854@bill-the-cat>
References: <59827eccb8a90957e3d4f09059e43cc7fe6c92dc.1741255948.git.michal.simek@amd.com>
 <20250306140250.GX2640854@bill-the-cat>
 <41f1ec1b-2c36-4ab1-9e99-77459deff366@amd.com>
 <fb24a61e-0fb5-4430-b5e1-1c2b25ca8159@amd.com>
 <20250310135605.GX2640854@bill-the-cat>
 <1704f391-e76c-49b9-83d9-e1a738da971c@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8QDC3FvTahTxiBI2"
Content-Disposition: inline
In-Reply-To: <1704f391-e76c-49b9-83d9-e1a738da971c@amd.com>
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


--8QDC3FvTahTxiBI2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 10:48:57AM +0100, Michal Simek wrote:
> Hi Tom,
>=20
> On 3/10/25 14:56, Tom Rini wrote:
> > On Mon, Mar 10, 2025 at 08:49:32AM +0100, Michal Simek wrote:
> > >=20
> > >=20
> > > On 3/6/25 15:12, Michal Simek wrote:
> > > >=20
> > > >=20
> > > > On 3/6/25 15:02, Tom Rini wrote:
> > > > > On Thu, Mar 06, 2025 at 11:12:30AM +0100, Michal Simek wrote:
> > > > > > U-Boot version command is no longer showing information about G=
CC and LD.
> > > > > > The reason is that version.h has been removed that's why CC_VER=
SION_STRING
> > > > > > and LD_VERSION_STRING are not pass.
> > > > > > Values are generated to generated/version_autogenerated.h which=
 is sourced
> > > > > > in version.h.
> > > > > >=20
> > > > > > Fixes: 54ecce2cbf90 ("version: Separate our version string from
> > > > > > the version command")
> > > > > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > > > > ---
> > > > > >=20
> > > > > > Tom: Not sure if this has been done on purpose or not but this =
issue has
> > > > > > been reported by our regression team.
> > > > >=20
> > > > > It wasn't on purpose, no. Did you put this through CI / confirm
> > > > > sandbox_nocmdline still builds?
> > > >=20
> > > > Nope I did not.
> > >=20
> > > CI is not reporting any issue.
> > >=20
> > > https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/pipeline=
s/25029
>=20
> Are you going to take this to 2025.04?
> Or to next?
>=20
> I don't mind. I can also take it via my tree just let me know.

Ah good question. I suppose I should pick this up for master.

--=20
Tom

--8QDC3FvTahTxiBI2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfYLG0ACgkQFHw5/5Y0
tyxWOAv/bUUo/EnJ2BDLV40o9Rq0ebAGGxTrm8Rw/p9oUzb6oeTA7RFgj8QFQ4IH
7o7ew1658VJgOvmBz/xnkht6JDb2ro6Tn8RqdNHitnP3/nXM1EDEx4sfXvm+DTVN
R8i3SM/xiwmJoGKDbXFVWQpjk/y7tmXN7ydzX1ndD/AnlxbvvPNf0B/FEV1vKbpu
CqLbiPXlL9pST1ByVQAzTw4a+VyHCWmowr7iMCViUzL+l0j+hB00tlo4uugtsiPD
SPKWiwdxBwjqqI/Ouo4bf7HwsUlgqSrL2dmJQag5lrpj+rNUEORekdnnROsORACD
qImj9BAgcMSKY/ga/4zBQt9X5PMwiu8jIGVBMQPsTHpwFoXYSLO+xlxThJDB1sGc
iA/6e0mzY67Hjz7DuwCWde6TOytsSqhv7gng5/8AdRWw7SXG+L/JuFiAofFCaX+s
rxKEHRodKcUjL+nE80ZykckdHR0QRLEZJ+Q1DL+B9/J+rdOKmRublAuUJ3vN/dqr
kJy2N3H5
=V9Jr
-----END PGP SIGNATURE-----

--8QDC3FvTahTxiBI2--
