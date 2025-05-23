Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB0BC54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 16:47:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8680A831C2;
	Fri, 23 May 2025 18:47:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="soh9SvJw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC914832D8; Fri, 23 May 2025 18:47:23 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBDC982D2B
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 18:47:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2dfe2913a4bso53452fac.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 09:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748018840; x=1748623640; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GbTJUidmD/s+aEzFktGLLpUKvqGZH64JCdl5TErtj94=;
 b=soh9SvJw3P431FljY9H4CGqShugylcypdVyUOlSb8jIFKpY4sRffrT30xlLtwMOcxV
 QkjT6tZmS1Tohyq77LD92GUahIu93Luwb7nfK4Z95QUmVZktQ96Eu+uceki8UMkDA93W
 F8Qs/qcqeN1oRg11bHxMdhqSPvZApT6qFqcpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748018840; x=1748623640;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GbTJUidmD/s+aEzFktGLLpUKvqGZH64JCdl5TErtj94=;
 b=rXmaoUxPYKbvRPls5reRrBYeuhyFci8BQ/HOU6trN4HmPLZCsyiecWGT2JZewTPNeZ
 lBgxA9486wf/lDNHla38F8U6XR+34jUYmYx1uVY7xa+dHu6LKMKeDYm5GHu41nqdaChs
 9BSmYOuC1H2KJcDgiJswd317Fr/0FEAbyw78YNx7ao4yQi01y3UaUdYYQXjqVKlYC2LW
 NMuEXpwdyn+ktZJn0TcBeN2eh+xU2vRzC1a4/on8qJlTyvwnLN8gyM1+iqhxniup5/+j
 cQuL2zK0JV19j8Vv1mEFnWeRDSNc3dJel7v44VUi3fjFHhMISGiEHC8LKJB3aI+OVDJz
 PFiw==
X-Gm-Message-State: AOJu0YzwSQekz1q8VIn3Kn9Q3w1FySN3N+eA9TDs36vE34llfkOyW5Bo
 l1Qiq1Kvy/4OZ/HZntduraPA9q1xpg4C2Z4E0S+XGxbl+BqhIJYO1dIN3dQcN/NvBnU=
X-Gm-Gg: ASbGncuKJXuXMioqA8tRNIcXWi9lKqoTAxLQyDw1wAERPNtPtTOJ9fqkKkP2XBTJp4w
 XbP8+NbaceStye2C2EdLH/CeY0+/E8sXD/AXLRMaeYSMFrLL3PKOrw1WzPe6wuP6m9W5kKwAAB4
 D8b6A4nXAQah7mhQkuHHaYvj7ERWqjBDhou5VrB5GVLTUOM0OymZhRNPFuFZj+yqEvfAxdmQYiI
 8Vfm0UJrJZU39h18Gx6UhlnKchKi+CcA0bC4fsRvY7AQnQx+E9w+kIXsrOFvL39vVxdxGbHt0Qc
 TkvMKMBvHjEHl2ld7U3pWng9qpEVBXd/gAgIeVfDNc3ipeLvJbV0/aaXC4r/V6mglzU7+n0FnkS
 p+/H/sLgPu+zO
X-Google-Smtp-Source: AGHT+IFBcMhB12xB96AwWP2KzI440kuArASbZh0GK1OTKPqgs8e5Pd3K6RVJAQGdp/JXJAgm7dSlyw==
X-Received: by 2002:a05:6871:2201:b0:2c2:5270:f182 with SMTP id
 586e51a60fabf-2e3c85ed542mr17321768fac.39.1748018840317; 
 Fri, 23 May 2025 09:47:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c0a9bed5sm3631285fac.34.2025.05.23.09.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 09:47:19 -0700 (PDT)
Date: Fri, 23 May 2025 10:47:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 01/30] patman: Move all non-test logic into control
 module
Message-ID: <20250523164717.GU100073@bill-the-cat>
References: <20250504132356.2317305-2-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
 <CAFLszTi6LwvSoNtThF5DzKjJNFzJxB5rk5DjYi9wzsfkiwwjcg@mail.gmail.com>
 <20250523140455.GP100073@bill-the-cat>
 <CAFLszTj1v7dhvdj9vM70OP=Bb8j3FArYHS3SGcpnJO31z3Ns1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FEXtxWHcYsWE9CdY"
Content-Disposition: inline
In-Reply-To: <CAFLszTj1v7dhvdj9vM70OP=Bb8j3FArYHS3SGcpnJO31z3Ns1g@mail.gmail.com>
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


--FEXtxWHcYsWE9CdY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 05:32:36PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 23 May 2025 at 15:04, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, May 23, 2025 at 08:19:30AM -0500, Simon Glass wrote:
> > > It is easier for tests if the top-level control logic is all in one
> > > module. Create a new do_patman() function to handle this. Move the
> > > existing code into it.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  tools/patman/__main__.py | 49 ++----------------------------------
> > >  tools/patman/control.py  | 54 ++++++++++++++++++++++++++++++++++++++=
--
> > >  2 files changed, 54 insertions(+), 49 deletions(-)
> > >
> > > Applied to sjg/master, thanks!
> >
> > Odd. I thought you had posted this against master or next, intending it
> > for mainline, which is why I assigned it to you in patchwork. I see the
> > cover letter is missing what commit it's against. And instead here you
> > are once again spamming the list and with messages about your personal
> > tree. Why?
>=20
> I'm applying it to my tree and intend to send you a PR at some point,
> with collected tools/ patches. So I believe I need to send emails
> about applying things and update it in patchwork. Let's discuss this
> in a future call.

I don't see what there is to discuss. Please follow the normal process
for mainline and stop spamming the list with notices for your personal
tree. You're also diverging your own tree further from mainline by doing
this and making it less likely (multiple people have told you they don't
want to review things not against mainline) any follow-up work will get
comments other than that it's not applicable to mainline.

--=20
Tom

--FEXtxWHcYsWE9CdY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgwpo0ACgkQFHw5/5Y0
tywr6wwAujDh+qHTJdircWhBKmx3cpUw4LS8WasOh/PMfN4SnXkQkrQx1rWsgmnR
//Kv+ubLspDvXwyZUwHfOIMS+eeFwdP2lNz4s4zL6wiGk/PN0/eyjF3KfI98x+Hy
2BcHIzgV1qtcVFh0B5x+HFi8BtHzwl7pABa/dv5297nZrZo7hbONhpkR7Aq/ev4A
0S8b3OqZUpmvg8K8LRvYCuf/2POZM+ySbJ+k/R659hIazxqh7OXCm90K2x0sjUaj
NFlsImrMNriPd2Sfe7naW4xCnz3QtQQUJX+U0Nbo2BS6QERFSZuSR0CZW7R2DKiX
cN4mHykGIBPHL2fKNS7E0ADIQ1aOFulractXwGSANGQzijwJcmIfnKHfTanifmgG
MqhGcDHcOMvtbcmqTVWY/Lbqv5kN/RY2V8E3cE62csOmaJ5aXG0Mc5pjzJDtYush
br48j5Dy7N2jGyhNjgVuMRsHoYRYgyTVBl1M5WpgLHVfHGSA2hPpaXGwn07Ac6wo
zYCcjjVK
=+Hv1
-----END PGP SIGNATURE-----

--FEXtxWHcYsWE9CdY--
