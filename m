Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EAE9E7108E
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 15:30:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA45D865D0;
	Thu, 21 Sep 2023 17:30:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c6p7X9Ca";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EBEB86661; Thu, 21 Sep 2023 17:30:34 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B230864EE
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 17:30:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-59e7fb87f1cso13959857b3.2
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 08:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695310231; x=1695915031; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SJCG34xxanBYzzLG8IK8C8eXrMX17H8yQRH86k6ghH0=;
 b=c6p7X9CadiStFPeIaW0bzJWcxQhLn5IAZS4ZPH5Geb9tWed9FRZDqGxkPq4hqAzEgI
 XyiaNHxxpCvusmB+xg94YNJ40i34OYyJ36sUhIh7Sn6Cwu5fxZ/iVPXvXGmssXNHQ0Cb
 YV0KfdeAdurD5fvweuMEniQtl0F8tR1UgodlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695310231; x=1695915031;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SJCG34xxanBYzzLG8IK8C8eXrMX17H8yQRH86k6ghH0=;
 b=YUHyDHrfzuq5aosLDfxyyyWGmYZrdIqeTbzRYcnGEYZ+TbfgW0NRlWwqCuJCZbn66R
 r6/70+q6BA88UnNYPYhx1g4WGQH/TexWx7TsPpIOZzuMEU8zvMnSaeS7fvhRkfznGH+l
 uIuSm+/IkFlgIFRHAw/6OwOazfIa4hCrQF/gG6xEtXRDEHDkW5OoQj3N/Kzh4mQbh9ZZ
 Dp4SGJkiurO8j0+9fl51/x8tJjZ80Dh3Cw8EnTt1GW9nfZL3rdi7jo1Ug5AZE/hFTM4F
 /YsDvtfGxLJzYzvd45NZmb394HhwfVfVy6m6woHxxtqJkSrZ58wyNwyyPn10/K0oYiEi
 BJhQ==
X-Gm-Message-State: AOJu0YyaQBq6LKzU6BNKgDcov34F0juPdgSNUc6BPwRoqbAJjjRBLHxp
 wUAXM2ZMq7hKaVN7hYuUE9IIMw==
X-Google-Smtp-Source: AGHT+IFlyQM8d11hGuNYO03tZN1DrnZ0B2A0NkPvsr6JYbhyRPB0DZ0ctKZkBP/rXGXwpcBo0q+xTw==
X-Received: by 2002:a0d:db0f:0:b0:59c:786:f58f with SMTP id
 d15-20020a0ddb0f000000b0059c0786f58fmr5774329ywe.6.1695310230991; 
 Thu, 21 Sep 2023 08:30:30 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-46ac-83a0-07b5-e9a6.res6.spectrum.com.
 [2603:6081:7b00:6400:46ac:83a0:7b5:e9a6])
 by smtp.gmail.com with ESMTPSA id
 p142-20020a0de694000000b005773afca47bsm384493ywe.27.2023.09.21.08.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 08:30:30 -0700 (PDT)
Date: Thu, 21 Sep 2023 11:30:27 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] common: Drop linux/printk.h from common header
Message-ID: <20230921153027.GQ305624@bill-the-cat>
References: <20230915002147.797352-1-sjg@chromium.org>
 <20230915194832.GF305624@bill-the-cat>
 <CAPnjgZ2Xo2+wNkH+hrKL_FetmD7vpB8dHi7mtSRNPMWHkqQLcw@mail.gmail.com>
 <20230915215449.GG305624@bill-the-cat>
 <CAPnjgZ1KWxNiZ7=dnQry=Shw-Q=791Bo44RLvf2DTaekdu6ebQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="o4LI/G8Ft5o6r5Qt"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1KWxNiZ7=dnQry=Shw-Q=791Bo44RLvf2DTaekdu6ebQ@mail.gmail.com>
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


--o4LI/G8Ft5o6r5Qt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 07:03:25PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 15 Sept 2023 at 15:54, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Sep 15, 2023 at 02:01:33PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 15 Sept 2023 at 13:48, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Sep 14, 2023 at 06:21:46PM -0600, Simon Glass wrote:
> > > >
> > > > > This old patch was marked as deferred. Bring it back to life, to =
continue
> > > > > towards the removal of common.h
> > > > >
> > > > > Move this out of the common header and include it only where need=
ed.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > [snip]
> > > > >  317 files changed, 322 insertions(+), 3 deletions(-)
> > > >
> > > > So, going back to the original series here, how did you determine t=
hat
> > > > the files changed here need <linux/printk.h> ? I can see how to get
> > > > there with some grep'ing but I think my original complaint was that=
 we
> > > > added the new header too widely.
> > >
> > > Basically I used ctags to get the symbols from the header file, then
> > > grepped files for them. For that one, it is:
> > >
> > > KERN_ALERT,KERN_CONT,KERN_CRIT,KERN_DEBUG,KERN_EMERG,KERN_ERR,KERN_IN=
FO,KERN_NOTICE,KERN_WARNING,__KERNEL_PRINTK__,__printk,no_printk,pr_alert,p=
r_cont,pr_crit,pr_debug,pr_debug,pr_devel,pr_devel,pr_emerg,pr_err,pr_fmt,p=
r_info,pr_notice,pr_warn,pr_warning,printk,printk_once
> >
> > OK, good.
> >
> > > I was a little miffed that a comment along these lines from Heinrich,
> > > with no actual evidence, and no response to my follow-up questions,
> > > caused the series to be dropped. It isn't easy to do these sorts of
> > > clean-ups.
> >
> > Well, I know earlier on I had concerns and spotted specific cases where
> > it was off.
> >
> > > A lot of files include things like net.h and image.h which bring in
> > > many headers...but we should clean up those header files up too
> > > (particularly image.h). So I think the standard should be: "include
> > > what you use".
> >
> > Yes, we should first get rid of common.h and then see what we can
> > remove next.
>=20
> Are you OK with this patch? If so I could send another, but should
> perhaps wait until this is in -next ?

I'll pick this up for next soon, yes.  And then we can do another.

--=20
Tom

--o4LI/G8Ft5o6r5Qt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUMYZAACgkQFHw5/5Y0
tyyRCQv/SwsW8nA6U0Je/VA8ZCYrHYeZR4lhNkIa7S59zlsnMiynHS66Da2PetzC
i3Vb+Ie15pjceJet3uytzBemoxkl+1BPyx5GxrArzyuBB1NmgyyQUAKk/qPZGfIj
m+hxvD/3FlMTTUpNwfPPcI8aXyWQJmR/Ofdb5Tb57CAsAfWmOZuR3cq5RurekKfy
h0iQknZ9aQGXjUaE1JtGDf8jC/Q6AIM7/rOTqN2VRwJyUDP1JJK9PomEJ6qtWO0Y
zqc2Ta9xqKLCeL2sjIwmnLzcKNHi20g876zO/X/KHamLtUDhM4iuxWqqccNtEt+/
YIGnRUKN9APSlpHqEs8oIIBhEOt7wKn2TLYCnvnfHzma0dJ9V7tyPd3KLmd1A1/d
91eb2OmY0DHESa64bETqkES2RCgATGxvWi00CRtT5gnBwZ7EI+E8fFRKDu3oRHRC
ntDZU2lShQq9HHG+jvE/IOLLWhN7kBzrsIPP2qfTL+AfLfK9D1kPBb1bxABJHH4u
4HDBdbCl
=Ng6f
-----END PGP SIGNATURE-----

--o4LI/G8Ft5o6r5Qt--
