Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35256C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:36:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0F3681ECD;
	Wed, 19 Mar 2025 16:36:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RmlB6PLM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E348C81ED8; Wed, 19 Mar 2025 16:36:28 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F86181E02
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 16:36:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22423adf751so127181455ad.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 08:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742398585; x=1743003385; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ti9vDCqCE561mveENwyafyIEKKWaMRCUa6joOTwHrl4=;
 b=RmlB6PLMBe3IAfbEfdKAg31jrnx2ZxowT3GuPjOsS2J9YFP02Twxov0ZC99Hbnx1Bo
 movic/EAIk/Z/+7mKxW2ef6avt1SQZas7U4+1RlOMxp2FPdOL0Gtwc4uJyuJOlGiv3p4
 iUr7l29rHW10Anh9Td/6Bz/c11bdzOLJCjBHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742398585; x=1743003385;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ti9vDCqCE561mveENwyafyIEKKWaMRCUa6joOTwHrl4=;
 b=Kxk2EePxhyCof+4KZRRBvh5D/vemgOHwv26yQV/gGmIMIpsIfwwz4VEzR5VIk+4P8d
 60XAxnRfskPcOMpiwaYMQf4dPINAJ6fZVVHfGzgQLqLmB4HwIM8xTeTUTh4/S0aD0cLV
 1YDPmZJAqij2/J/OBqaLx2pUOFTD/voLZAw88m1DJmA0SInAG9LDfkR+v/5gQvhXCAu5
 zVK9ZD9WU+FzVNBWhBEy8EsseN+DdFYSyGg05856sumTkT+ikS+cMoY0BzvmFd61yv9F
 xkwpjjqzMhvfKfoNdSF2rLZf2Yv6/z8bu/WS1/FwWLL427i+Od706+OiRos53Q9cpyAq
 nYmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqDZy/m/7qgokn6uRTEA0I2XUgxI0TPjF3uHubdvJziq+YNIVnveaP8bK2IPK/mQShMnbPpk8=@lists.denx.de
X-Gm-Message-State: AOJu0YxZc82/pGqYzJLL8LWHGCNYqiNsxg36pd1JM5RuBnE77Et1NWeU
 JscyDvCRMntcWQFMuV2jlO/iTMkWORImNDuRi3DgvsbXJZfRMhsmBZ0h/av8hxQ=
X-Gm-Gg: ASbGnctO63mBfE4dqlK6ys8psIBJgW96Opd0v2NXb3Xaaal/fciyNYhrikPBiT2z+vI
 JLI22bmFMSrUvBbWYcYuq4Oo+VOJg4VMBkYPVuxsJbB4B7d8CjlrNA4kMuR2PcV+RVoddfa4lZU
 kmTLbAFWzxNV3W2hj9pkEAJ3T5gU2tx+TXZ0GMyWjY7T7uygGicC4xrJNQIL3prcUSOzmAAXu7q
 5YNkFSgPgxru3t+Aks/iCb9bw+ESQKD0zSBQM+8IAB8u8ahNPm/IWCiq0dMPPaTeqYBl4pYoxak
 D3ORqfHlEMiPfPdOH+mhTgwkg1hFfGYmVCXw5qcXLfKmoA==
X-Google-Smtp-Source: AGHT+IGbYgiOqRq/f7/Re0uhkF3KARrepUf2c101v+hJ/o8oR25IqaBwxvkjQHqH/AVuSLrUaVCgNA==
X-Received: by 2002:a17:903:178b:b0:21a:8300:b9ce with SMTP id
 d9443c01a7336-22649c9580dmr47533955ad.49.1742398585140; 
 Wed, 19 Mar 2025 08:36:25 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c68a6865sm116007345ad.75.2025.03.19.08.36.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 08:36:24 -0700 (PDT)
Date: Wed, 19 Mar 2025 09:36:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH 6/6] lib: Provide a signed version of simple_itoa()
Message-ID: <20250319153621.GK2640854@bill-the-cat>
References: <20250319115911.2204045-1-sjg@chromium.org>
 <20250319115911.2204045-7-sjg@chromium.org>
 <ABCF9413-6C51-4EBA-9907-95C5097A8D86@gmx.de>
 <20250319142038.GE2640854@bill-the-cat>
 <CAFLszTg17Q+ovvc2MeHLadsSdK+LJuHsXhf=fFybkbf=zLy36A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iZmVS1WsajRuhq9X"
Content-Disposition: inline
In-Reply-To: <CAFLszTg17Q+ovvc2MeHLadsSdK+LJuHsXhf=fFybkbf=zLy36A@mail.gmail.com>
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


--iZmVS1WsajRuhq9X
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 03:04:00PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 19 Mar 2025 at 15:20, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Mar 19, 2025 at 01:12:30PM +0100, Heinrich Schuchardt wrote:
> > > Am 19. M=E4rz 2025 12:59:08 MEZ schrieb Simon Glass <sjg@chromium.org=
>:
> > > >In some cases we want to show a signed value to the user without nee=
ding
> > > >to use the full printf() implementation. Add a new version of the
> > > >simple_itoa() function to handle this.
> > >
> > > Where will this be used?
> > > Why can't printf be used?
> > > Why would this fit into this series which is about test improvements =
and not about functional changes?
> >
> > It would be more fair to say that only one patch in this series is about
> > testing and 5 are adding otherwise unused changes to functions that
> > presumably are used in some later as yet to be posted series.
>=20
> Sure, would you like me to change the cover letter?

No, I'd like to see the test by itself and defer the unused additions
until there's something to review it alongside of.

--=20
Tom

--iZmVS1WsajRuhq9X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfa5HUACgkQFHw5/5Y0
tyyvyAv8DuWZFYW+gPtEhWXkUxR0/FoSI/o2gceeH7jcAWEqfbq2G3y4WdP8glP8
Qt8pqB+3eB/CCVJtxmxVP4pfw1+YH2CHWVXK0uCCqJVjq2drh13OT2zRZxvBL3OW
ZjPf30IiFSuU/pIkyVsMhcvRybJ+d/yszUdzxxk1/BZNo/n1/c+0o29Mz+RPqJBG
99rZnGNKAJEzsA62P850mBnVsWe6ZP6lWcLqO4mGp+YCEqtGjbn8c7CCBchGSkyR
AgQPxAWoUjcqv+P4aE78Kzy5hNiMrmGrWMPKZGAVtE/iSgKCkpDrac6ohEQIt8T8
6kTCPXZ7VaHaVs4W/nC+IjorptOi59HpJEQiqD+uORtWbhBtEsXQ1A9n9SEZH6Nk
DL9CUchY+OkDIJW083Gvz91ViaTKq3B6r0a6cDgO+ckoRxjN4la9WfxQqSm69T7K
4Idi6mMUa8ACZ6LCIECCjckd+mcO1gyYiKxDLTCtHZk8amdRzcIXNNARqmGhawWx
uS07LzNV
=z1OL
-----END PGP SIGNATURE-----

--iZmVS1WsajRuhq9X--
