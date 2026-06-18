Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262FBCD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 15:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A31718499C;
	Thu, 18 Jun 2026 17:09:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FekwUHoH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6640B8063E; Thu, 18 Jun 2026 17:09:10 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D82BA849AC
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 17:09:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-440df1c768bso664637fac.1
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 08:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781795346; x=1782400146; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XHZ4dyWh/M4+anr5RK0ceDTGQ7rZfrS7kqGr4DwYY/M=;
 b=FekwUHoHT5TD1bIxSIwUOWt+r2v7G7sK/n1p6QLTRAFVCEnNKg7URHMMu9H7J5wv+J
 iuLiP0monZggYBitO6nblcRLq34SBl+kF5/VgcGc2nyM8xxe4QVX8CCC0sduOqw1xN16
 wqzAral79ya1Jk6cBq5I0odesXZ25eUb2gTe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781795346; x=1782400146;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XHZ4dyWh/M4+anr5RK0ceDTGQ7rZfrS7kqGr4DwYY/M=;
 b=bwO+T0hfGvMmioxWU5XwWN3ZO/xjfpW43vPCmreeZjJ0JWhqYSdAuW9gmIk0Re+Efb
 4pvV6+0j7rH/hBD1CCBss/XCABLJx/QQJ3UK7KSOnNoSCwMyPo7xfyCoBNqOlM+pxj6D
 LuIlnCMC0RLew5FGY8WctetkEQ7ltkxTF/LSM1m0Sgx5SNtDOFNswRxHW48u9gSAqOk8
 fNu8HapAhmaRNz925mjhCgIIiVUuOXv7DVxhQx4GTZxHtB2ZNRCCfRgnCZHS8kBg7NQ3
 GOJqiZSUUCqP9ZGMxQdohZgcNxXtYSQnA8LeTQ+NvkwbGlyn/5W3fddJb6XphmpMce55
 56/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8RL/CAGZXizr0fTHYS4HUL63qfSvIORMCGu8xAcjwODwzWpL2OOVxD0k5QQJ7je6jRqSdgDxk=@lists.denx.de
X-Gm-Message-State: AOJu0YwCDpLL1lc97x+HAEUgavqIAdUDUSy9Ll/KvfsMcuzNdCfW0Yxi
 A4UXJCedbaG7EM8Fmn0wWspxuK9+VP4vOJCiQs1OeI0ZdqoZHiBIVpeLiTepJanGFJ8=
X-Gm-Gg: AfdE7cmGSDTZA59VpcAQ7SNhN5G+V4MB1xU5alNHxP7KAIum2WCHLO7CGYM9aqmuXWn
 qmy5BaCM33JMtYJNPYHZJvFEnupkm83f7vCzsfEVQGUrLYzHqYG9GAEruPG12x99XIP+zrtqjG3
 fUfJK6TU+GcgNPSHXre73rD/93rtdAUv25vZgOZ7GnPlWqQK+lfYIXJnzQGznY0QIgaYAx9VHAZ
 t+8M9UCAQ190Gz7ykdf81VAHdxkgEP7IpwxAzQyUeqQ5rqr0J6bBBxL64P2X3vzwxcfyrduqg5h
 KQB+fwrT4kMmNNlschqg48GxwJZkR142FpuUJ518SYucSRTCueqrWqutvPDjSHXCKLjPMVr9bBk
 soY4Z81uVHiWDYQptlDq4zN4tGak+xc6wTdejwCrOpyLA/i9vRBcqXn3PylHEtEm8xE47nawWx+
 wZ72P9N1XEwliDY/5wk3I6QMUiLgfDKYRFyDjfcDBKlsQbwb2lryyYoQohBwOhIXSfIe6do2A3D
 etVUH0mk194zbBnZPA+RkAzdzcDaQc4+N/0y/5R
X-Received: by 2002:a05:6870:21e1:b0:441:f960:a7d5 with SMTP id
 586e51a60fabf-4469061f0femr6560522fac.28.1781795346492; 
 Thu, 18 Jun 2026 08:09:06 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-245.totalplay.net.
 [187.190.197.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44308a5712fsm6882497fac.4.2026.06.18.08.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 08:09:05 -0700 (PDT)
Date: Thu, 18 Jun 2026 09:09:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Aristo Chen <aristo.chen@canonical.com>
Cc: Nora Schiffer <nora.schiffer@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 2/4] bootm: use CONFIG_SYS_BOOTM_LEN for
 IH_TYPE_KERNEL_NOLOAD decompression buffer
Message-ID: <20260618150903.GV382693@bill-the-cat>
References: <20260610090125.99112-1-nora.schiffer@ew.tq-group.com>
 <20260610090125.99112-2-nora.schiffer@ew.tq-group.com>
 <20260610194840.GH382693@bill-the-cat>
 <be080a107555cdbad6828af2a36be013ec186477.camel@ew.tq-group.com>
 <CAA=k7=na+bmcMj5bw8rZF05eDOV0tfydzpSP_4BbDiEg_LhKjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="x1Tk/zwN4Qv++aXl"
Content-Disposition: inline
In-Reply-To: <CAA=k7=na+bmcMj5bw8rZF05eDOV0tfydzpSP_4BbDiEg_LhKjw@mail.gmail.com>
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


--x1Tk/zwN4Qv++aXl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 06:04:59PM +0800, Aristo Chen wrote:
> Hi Nora
>=20
> On Thu, Jun 18, 2026 at 4:30=E2=80=AFPM Nora Schiffer
> <nora.schiffer@ew.tq-group.com> wrote:
> >
> > On Wed, 2026-06-10 at 13:48 -0600, Tom Rini wrote:
> > > On Wed, Jun 10, 2026 at 11:01:23AM +0200, Nora Schiffer wrote:
> > >
> > > > CONFIG_SYS_BOOTM_LEN is passed to image_decomp(), so the same shoul=
d be
> > > > used for the buffer allocation. Deriving a buffer size from the
> > > > compressed size if not possible, as the compression ratio may be
> > > > arbitrarily high for data with many repititions (for example ranges=
 of
> > > > 0x00 or 0xff).
> > > >
> > > > Fixes: 69544c4fd8b1 ("bootm: Support kernel_noload with compression=
")
> > > > Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
> > >
> > > Reviewed-by: Tom Rini <trini@konsulko.com>
> >
> >
> > Hi Tom,
> >
> > I saw you applied a different fix for the same issue to master. I think=
 using
> > CONFIG_SYS_BOOTM_LEN is a better solution than trying to derive the buf=
fer size
> > from the compressed size at all - isn't that pretty much what
> > CONFIG_SYS_BOOTM_LEN is for?
>=20
> Previously Simon also suggested using the CONFIG_SYS_BOOTM_LEN in this
> thread(https://patchwork.ozlabs.org/project/uboot/patch/20260527150637.28=
50104-2-aristo.chen@canonical.com/).
> It was considered a follow-up at the moment, so maybe rebase (and keep
> the CONFIG_SYS_BOOTM_LEN) your patch on top of mine?

Yes, I took Aristo's series to the next branch (which predated Nora's
series). My only real concern right now is, certainly we must have had a
reason to not be using CONFIG_SYS_BOOTM_LEN here to start with. And
digging more, yes, we have platforms that have CONFIG_SYS_BOOTM_LEN far
larger than the malloc pool. That's why we did an estimate before. I had
missed that when I R-b'd Nora's patch.

--=20
Tom

--x1Tk/zwN4Qv++aXl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCajQKCwAKCRAr4qD1Cr/k
CswbAQCCEv6n9DFAAm57rBFKjVNI3prABc3UJIrtdXdRfZnhmQEA6RiLAQWaUbBt
6mbQVZcotC5wxZwpsC5vTBho2o2OWAw=
=/Ig0
-----END PGP SIGNATURE-----

--x1Tk/zwN4Qv++aXl--
