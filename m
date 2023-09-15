Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442E0CD37AD
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 21:54:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71A2C8634D;
	Fri, 15 Sep 2023 23:54:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XPjrFxXf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 524BF863A8; Fri, 15 Sep 2023 23:54:55 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4041386308
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 23:54:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-d7b79a4899bso2496993276.2
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 14:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694814892; x=1695419692; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+KSJhU1QI8zQgdZ30JxXmwuV7pJXP58IROQXHdHZUik=;
 b=XPjrFxXfPyMynnvW5/4mKUezgy6u9YT/olxqUYNCJJaDdlRUwp5+E07dKxjkFbFhez
 qekjZuZsPk8/R/T5tMcDtW7MeUmW9nd5WJ7RvSUQ7MqRsovXaAw3jPVHUZKX1ZZbTs4+
 2QVY/IPbH5eX12RWvcs3Uo7kjhOwUbtgJoeMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694814892; x=1695419692;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+KSJhU1QI8zQgdZ30JxXmwuV7pJXP58IROQXHdHZUik=;
 b=L014ZfHakSSIETNn48HhQ+dmoufRFvD/stSwKRHnrjcM5IlrdBt9YWd3k7r8IvoGhy
 tEM9U+fqx/4MNCrhL6JLLy6rjADR4OGNB4AX+VJC4pH4K3EEOGBPD/cy38/RdR5KgeWR
 J52F7DMBAZmdVZsps0wIIWOzSC8aPlYT/e9cf63Lm0yzENMoYN71eCHKrPwgJ3uGQZru
 PCQeMYZwTxkNNZz5grbA6+XzIeum7IQSEYorz91x24OskZ9nGHYDBBwoz28k/u6RQ9fg
 fwm7Jvu7IwOXiMAeyGaBYabGleunibzCtsAxAS39NDEmNT1JYqizkk83v8vb3nD8uSn0
 vZAA==
X-Gm-Message-State: AOJu0YzQCRWG0syXypv5/zOtSrpMDPBCx9bs+dXLz2YhcWM+FaTmcg9Q
 yamQHAx9/kqr/MquB3PhNlLJ5AesIlDncO5SK8+L1w==
X-Google-Smtp-Source: AGHT+IGs04ZPfUbBesJ9K9dMA87PhoJGW0/5mcwIvYIWl6mmVIKnjoTKUOUxtkhUoRopWU3ORZDCqw==
X-Received: by 2002:a25:da88:0:b0:d7a:c6f6:69b with SMTP id
 n130-20020a25da88000000b00d7ac6f6069bmr2969636ybf.5.1694814891950; 
 Fri, 15 Sep 2023 14:54:51 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-59f7-1921-febf-045a.res6.spectrum.com.
 [2603:6081:7b00:6400:59f7:1921:febf:45a])
 by smtp.gmail.com with ESMTPSA id
 x2-20020a056902102200b00d7ba7de90casm970581ybt.51.2023.09.15.14.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 14:54:51 -0700 (PDT)
Date: Fri, 15 Sep 2023 17:54:49 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] common: Drop linux/printk.h from common header
Message-ID: <20230915215449.GG305624@bill-the-cat>
References: <20230915002147.797352-1-sjg@chromium.org>
 <20230915194832.GF305624@bill-the-cat>
 <CAPnjgZ2Xo2+wNkH+hrKL_FetmD7vpB8dHi7mtSRNPMWHkqQLcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v8EPvQRWYTpJuscP"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2Xo2+wNkH+hrKL_FetmD7vpB8dHi7mtSRNPMWHkqQLcw@mail.gmail.com>
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


--v8EPvQRWYTpJuscP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 02:01:33PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 15 Sept 2023 at 13:48, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Sep 14, 2023 at 06:21:46PM -0600, Simon Glass wrote:
> >
> > > This old patch was marked as deferred. Bring it back to life, to cont=
inue
> > > towards the removal of common.h
> > >
> > > Move this out of the common header and include it only where needed.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > [snip]
> > >  317 files changed, 322 insertions(+), 3 deletions(-)
> >
> > So, going back to the original series here, how did you determine that
> > the files changed here need <linux/printk.h> ? I can see how to get
> > there with some grep'ing but I think my original complaint was that we
> > added the new header too widely.
>=20
> Basically I used ctags to get the symbols from the header file, then
> grepped files for them. For that one, it is:
>=20
> KERN_ALERT,KERN_CONT,KERN_CRIT,KERN_DEBUG,KERN_EMERG,KERN_ERR,KERN_INFO,K=
ERN_NOTICE,KERN_WARNING,__KERNEL_PRINTK__,__printk,no_printk,pr_alert,pr_co=
nt,pr_crit,pr_debug,pr_debug,pr_devel,pr_devel,pr_emerg,pr_err,pr_fmt,pr_in=
fo,pr_notice,pr_warn,pr_warning,printk,printk_once

OK, good.

> I was a little miffed that a comment along these lines from Heinrich,
> with no actual evidence, and no response to my follow-up questions,
> caused the series to be dropped. It isn't easy to do these sorts of
> clean-ups.

Well, I know earlier on I had concerns and spotted specific cases where
it was off.

> A lot of files include things like net.h and image.h which bring in
> many headers...but we should clean up those header files up too
> (particularly image.h). So I think the standard should be: "include
> what you use".

Yes, we should first get rid of common.h and then see what we can
remove next.

--=20
Tom

--v8EPvQRWYTpJuscP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUE0qYACgkQFHw5/5Y0
tyxzXAwAlVgGcn6FWDqAjn7uj/CEQMHddr+5HiQ95UXm9UdNWlgmsl5eJh4XSPzi
xiKvVfC7drpcDp9kRJ4CndHdLa8U9ruhtGsAFx49zcC6TeanI/3s4WYgWyft0ujW
mOxIHU+LIIQxxJ+SLakNPZsh/hycOLu4lSaChF04drU2qD4decNn4fxpNH0EgdG1
QLSKhHN+6/g2ndBqaRz98UlZjaLgZPpowFOFbTLYAvUMGjNW1h0yFuFTkesKblos
p8z+PWQBGF1CkhC9li/ayxV//EBA2sTd4y/u0BxjPheHhHsFOefeRGQOd2brOykg
d46v947zUx0mSfFXxze6hLGAR0VzQn5rz+xWj1dNoUCzyA6yg4I4k0wJuP78NeL5
4k9KixV9IHMXC9IaCFK4Sz46q3IAF2qfhzpxW+xehq6NX3qVs952Zkr82q3tLYZ2
IEmmhiz0fQLS3/lxtpjnofLk1Whlj936KSbKjq+nNJIHpqqkq+eZkGbTZ+8+5wUR
nFRk/oT8
=8NPa
-----END PGP SIGNATURE-----

--v8EPvQRWYTpJuscP--
