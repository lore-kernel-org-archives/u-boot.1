Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2E6C36010
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 01:46:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A985C82849;
	Wed,  9 Apr 2025 03:46:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UHfNTVsQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3124582D2A; Wed,  9 Apr 2025 03:46:56 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF56D82836
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 03:46:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-72bbead793dso4173087a34.1
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 18:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744163212; x=1744768012; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BXoOkp/X63UzA5oB7LYhYAwGKkQEAUhgDgaGtGeCGIg=;
 b=UHfNTVsQAih5uRBIzwFNaGhLZybV98cUeOzPaJX1C0EMRYzil4NeEk8Ib6vStGz72F
 1qOVrJ9Cl6LDUdiNc1bGiVthW0pYjC0k3zB4KdWBkIRZw3EYhr/c1Tz6cNOKZfrJRga9
 eJMf897LGdqmLiF9e4JNko6icGWBMW9uWKuug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744163212; x=1744768012;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BXoOkp/X63UzA5oB7LYhYAwGKkQEAUhgDgaGtGeCGIg=;
 b=cHZNue8IrwGBS4ltZEX7KZ0ZKREQ/CnBzYiRHnsU0zwPeHVUVMOeN/lAyMJtCHwjP1
 YSBrhAYxT2CzCwNkKWaiSukND81U0UpFF/hk9d5uwL2q1lhdv+UMSu8Kqbp/YEYupkl2
 QipMRpzz02AL1JxyILmaTL/vBjseEP4dZpUaRt/V6crLX8xeVV7EE8gA+DH6aMfQsPG1
 mIueB/CpBtSRA+8FTTSA9LCzbTEdF870ssBwGhFpv01HCRTBxXAJQJy10nOoBu6BxGsB
 JHm+uAg9JLLBftUNc8/kTd9/E8EeDgf+zA6uWQpfp8PGBSfGYm6IzhbxDroG06cxnu5s
 YcNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ2S7gXUfuYm4EDfJJSy1375p5YkVSfr/On+TmDpA5g5n/cMSBb7kMVsZ3hsKYp/RMu+2R9Qs=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0FCEn0F+MShw2E5NltgqlDfBhgiDkj+Jpbd4Ejd8d53raRUBG
 wfQfEwTKVbW0hmhn7XCJFN4s0krHOd5mnD7CV2elkQus9Bb/LfRavl8e81oupH8=
X-Gm-Gg: ASbGncswIMW4ZMmbiMblbd0nieZnbzJLEtROBwLHzfoIbCnRV24hOzJopC2toMcO3rQ
 Ry18P8CXsIUui9EKTo1UN2V4AhdOAssKUZ36l/E4G02iNUT1s3ye3sbD/WLsC2FJodONaQEAd0a
 2MA2rRr978yMrFUPvGzfAqA/j8oltAV2Zun1E/Kvpaho7eVR/ISmv1JKqJ92Krx3Vc4mCtHYLZx
 i4VmZzKQRYkx97rxR4ye5NpQAoopTJh8gLqnZUujxvLcoMdQG44pWLgGJ+n31UQyxXC1ygv4AIs
 ybu7kT0tBMY7Ib4CEsuFv/bNOrnyPzzmjU2bHtiUYMriY1Jr7xHKGWSiYNDjuJeKM9DM5jwEY2U
 oZiE/2g==
X-Google-Smtp-Source: AGHT+IEdViya1b0AOdJjI4HOOqF3KxuTZjnG4iysNAjeOkr/oBbbqi18ljhttKGnLPS7+z37gybteA==
X-Received: by 2002:a05:6830:6719:b0:72b:a712:4b72 with SMTP id
 46e09a7af769-72e709a47afmr833553a34.9.1744163212623; 
 Tue, 08 Apr 2025 18:46:52 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e73e677f1sm6542a34.65.2025.04.08.18.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 18:46:51 -0700 (PDT)
Date: Tue, 8 Apr 2025 19:46:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 05/18] net/net: fix switch/case fallthrough annotations
Message-ID: <20250409014646.GB5495@bill-the-cat>
References: <20250327153313.2105227-1-andre.przywara@arm.com>
 <20250327153313.2105227-6-andre.przywara@arm.com>
 <20250408222918.GA1475540@bill-the-cat>
 <20250409005347.04003b4b@minigeek.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TSxQ7rAjD6eJ/ZLB"
Content-Disposition: inline
In-Reply-To: <20250409005347.04003b4b@minigeek.lan>
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


--TSxQ7rAjD6eJ/ZLB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 09, 2025 at 12:53:47AM +0100, Andre Przywara wrote:
> On Tue, 8 Apr 2025 16:29:18 -0600
> Tom Rini <trini@konsulko.com> wrote:
>=20
> Hi Tom,
>=20
> thanks for staying on this!
>=20
> > On Thu, Mar 27, 2025 at 03:33:00PM +0000, Andre Przywara wrote:
> >=20
> > > The net_check_prereq() routine in the generic network handling code
> > > mixes case: labels with #ifdef's, which makes predicting fallthrough
> > > situations tricky. We had two "fall through" comments in the code, but
> > > at the wrong places.
> > >=20
> > > Remove one unneeded comment (no annotations necessary between just em=
pty
> > > labels), and move one other instance to the right place (before any
> > > label sequence).
> > > This makes GCC's implicit fallthrough checker happy.
> > >=20
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > ---
> > >  net/net.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >=20
> > > diff --git a/net/net.c b/net/net.c
> > > index 5219367e391..f191f16357c 100644
> > > --- a/net/net.c
> > > +++ b/net/net.c
> > > @@ -1525,7 +1525,6 @@ static int net_check_prereq(enum proto_t protoc=
ol)
> > >  #if defined(CONFIG_CMD_NFS)
> > >  	case NFS:
> > >  #endif
> > > -		/* Fall through */
> > >  	case TFTPGET:
> > >  	case TFTPPUT:
> > >  		if (IS_ENABLED(CONFIG_IPV6) && use_ip6) {
> > > @@ -1539,11 +1538,11 @@ static int net_check_prereq(enum proto_t prot=
ocol)
> > >  			puts("*** ERROR: `serverip' not set\n");
> > >  			return 1;
> > >  		}
> > > +		fallthrough;
> > >  #if	defined(CONFIG_CMD_PING) || \
> > >  	defined(CONFIG_CMD_DNS) || defined(CONFIG_PROT_UDP)
> > >  common:
> > >  #endif
> > > -		/* Fall through */
> > > =20
> > >  	case NETCONS:
> > >  	case FASTBOOT_UDP: =20
> >=20
> > So this one is harder than it looks. With clang, we cannot seemingly
> > have:
> > 	fallthrough;
> > #if defined(CONFIG_CMD_PING) || \
> >     defined(CONFIG_CMD_DNS) || defined(CONFIG_PROT_UDP)
> > common:
> > #endif
> >=20
> > And gcc was failing on:
> > 	}
> > #if defined(CONFIG_CMD_PING) || \
> >     defined(CONFIG_CMD_DNS) || defined(CONFIG_PROT_UDP)
> > common:
> > #endif
> > 	fallthrough;
>=20
> Yes, later stages of the CI told me so already ;-)
>=20
> > Maybe we can move the label to inside the next set of cases, and then
> > also add CONFIG_CMD_PING6 to the checks, as that also has 'goto common;'
>=20
> I found some other solution: dropping the #if's around the common:
> label, then marking this with __maybe_unused instead. Seems to work for
> both GCC and clang, and makes the code even more readable.
>=20
> Will send this among the other gazillion fixes I meanwhile added in a
> v2, to a mailbox near you.
> If you can't wait: sunxi/fallthrough has the bits, though not yet split
> up and without commit messages. Still not passing all checks, but the
> CI builds seem to stop early, before revealing all issues, so this is a
> piecemeal job :-(

I thought I had tried what you suggest but maybe didn't quite get things
aligned right (but I also modified sandbox so it would trigger the
unused warning). That said, I'm applying most of v1 now'ish, and have
only stopped as part of trying to narrow down the seemingly random
evb-ast2600 CI failure.

--=20
Tom

--TSxQ7rAjD6eJ/ZLB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf10YIACgkQFHw5/5Y0
tyz05wv+Mt56oNUv83bpCjhTVZ+lddXUMySJ+19ZFRDzbF5ymOism8WxkEaPyXiS
dF28mnV/1LOHJCg3zmFkoMpQnTwMeGb/WxYccPo6gr6/G1ODjJm6Cmq8kYUcLeEw
Bnq83H4ulhAmK/4A3uCnE7MBaieHRiVOwuUdZeg9wQt092BGFdtpOig0Tqwiwv/4
g2BFvgcNUsangoV2FBVh8y2NkNuUrxmtDnJrxLIEayRt/3kdK0masTFqaLdKfJe6
NjSmHIRRVgr0Qciq3hWRmKkCBy9egapojht3dau+tb+RQ3nxqFyqVG9MN0PW1zK9
j2GeZ5PRwb59skHEhFtDidtNFLC/8Wc1qW1mHcTPvSczaDd/3eF/g3P9x4yUCBKj
QwU+ZMQyu2C5L7U9Lv6pE7NXLK8Xq14t7NkwvxI1AAKmnuBkR2Nulaw9MSzzj0C6
dEqv35hji7mFRX/naAWxj0RQQ5uoIyyw+GcsHhfWksvKtEKis+wGGksXxZe5LIpu
2UFn7OwU
=oV9f
-----END PGP SIGNATURE-----

--TSxQ7rAjD6eJ/ZLB--
