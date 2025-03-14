Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE19EC282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 16:07:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57F5F81DE9;
	Fri, 14 Mar 2025 17:07:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AoWxV8Am";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E1B081DF6; Fri, 14 Mar 2025 17:07:02 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 119C281D25
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 17:07:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6dd15d03eacso23643736d6.0
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 09:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741968419; x=1742573219; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3bXIWMAxZplKw7lGSDS09UCMaChdlmyHIWbWcmiQFak=;
 b=AoWxV8AmG3SSOf9OIUJbtTOQEhJVXfmgptgR12JO9UEWcYIvQZGpF3CIsymXMSTxss
 bh9h5Nhr+eyYnd9SL0RHQHKSQQ+F6F0nLeCszcdLP8NmbCeyJMNkzxAXyg2YhwBFp397
 beE6vXbbe6K32NImovQJeVhjMYc6z18hHvDNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741968419; x=1742573219;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3bXIWMAxZplKw7lGSDS09UCMaChdlmyHIWbWcmiQFak=;
 b=DcgHGmoQH6VNiV3NT/0crGzObv9LzVKzvzMUpiuIT/47zT6DCgdXNftjwsdNI1AgOG
 zmbt1DVCjw8Fe62tJSwOiCX4DaGeRwrBFNrlgvptghTQR5hNQaGFXEDp4RhcvI9AHG3U
 jQEQjVq8arsS9G0+iU9nmxVXurPmDuQjziwaZBoFC+rU6BUchxT2yk+0RDzP+4mNA2t1
 3mfjTJvASyWNHPNchmTZe4gfBdlCVXhEcqMGVYY/nTHnk61EerL6I4osyJGUPRgqY5lX
 MS60JuzM2+uoaurwTKdRVvbBMdaFbctGj521u1aHbJ481mZ9lqPEgPqhnoRj59ZVL6TQ
 eWow==
X-Gm-Message-State: AOJu0YwQdL/bw6hCISemorxdK0uclUrZQIZY7LUNWg8fuAeNwMw40pBQ
 5zIsISlI2bdPo8tMR2H0JbQ1mMeL7e2jVm5+Z7pAaAndJSD1jkCQhaTWC36tdyw=
X-Gm-Gg: ASbGncuJJ7z3lCxdgpK1nvNL4TutyC/1QS8aZ3smW/kqnyU2DOq6RfvVqJQ7Z0xqo8l
 m+qzawyWSAwXsfPJWmcmdxliHE5MAj3WYUSvh/rcYZoXUIaDlEEU1yjGcOFvoUwvXKGzDqFfsQc
 0KzKhjgUpk0NMo/AUxAFN5g/s15WobLgB4HTtKSJiBxRS4Lmm7IXL0CDY6wvjEFfSuGAspT88JD
 pWuVQnFO9IWkU76gJKdWg6lVv8OLpVi2qqgdEL22uI6En9NRRVTSBOaw72V8ao9uOsp1eIPFgr6
 gpdhQ2SoxaNd84vVc7D6ZcNQIyG3T78lgQamxTXX9xF/Tw==
X-Google-Smtp-Source: AGHT+IEbpvWe/ihnPP3FJ6z5MtB8KQGI/IcDvYGpot8IoY4f1XtuxkSamlrz0+YAUmBlL7n/gOZsvw==
X-Received: by 2002:a05:6214:ac9:b0:6e2:3761:71b0 with SMTP id
 6a1803df08f44-6eaeabde063mr39558596d6.5.1741968418866; 
 Fri, 14 Mar 2025 09:06:58 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade3501ebsm25537636d6.116.2025.03.14.09.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 09:06:57 -0700 (PDT)
Date: Fri, 14 Mar 2025 10:06:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Julius Lehmann <lehmanju@devpi.de>, Love Kumar <love.kumar@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Philip Oberfichtner <pro@denx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Weinberger <richard@nod.at>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 00/47] x86: Improve operation under QEMU
Message-ID: <20250314160652.GS2640854@bill-the-cat>
References: <20250306160428.3041057-1-sjg@chromium.org>
 <20250307142255.GL2640854@bill-the-cat>
 <CAFLszTgtYsVQW-kETzUAdvJvAT6fN_53TeoN7o8wu52Ze3u56Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M0o1PJS62GQK348u"
Content-Disposition: inline
In-Reply-To: <CAFLszTgtYsVQW-kETzUAdvJvAT6fN_53TeoN7o8wu52Ze3u56Q@mail.gmail.com>
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


--M0o1PJS62GQK348u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 02:44:35PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 7 Mar 2025 at 14:23, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Mar 06, 2025 at 09:03:27AM -0700, Simon Glass wrote:
> >
> > > U-Boot can start and boot an OS in both qemu-x86 and qemu-x86_64 but =
it
> > > is not perfect.
> > >
> > > With both builds, executing the VESA ROM causes an intermittent hang,=
 at
> > > least on some AMD CPUs.
> > >
> > > With qemu-x86_64 kvm cannot be used since the move to long mode (64-b=
it)
> > > is done in a way that works on real hardware but not with QEMU. This
> > > means that performance is 4-5x slower than it could be, at least on my
> > > CPU.
> > >
> > > We can work around the first problem by using Bochs, which is anyway a
> > > better choice than VESA for QEMU. The second can be addressed by using
> > > the same descriptor across the jump to long mode.
> > >
> > > With an MTRR fix this allows booting into Ubuntu on qemu-x86_64
> > >
> > > In v3 some e820 patches are included to make booting reliable and avo=
id
> > > ACPI tables being dropped. Also, several MTTR problems are addressed,=
 to
> > > support memory sizes above 4GB reliably.
> >
> > Do you plan to rebase the prerequisite series' this requires so that it
> > can be merged?
>=20
> Here's my understanding of where things are:
>=20
> 1. You rejected the membuf series and my replies to try to resolve
> that haven't gone anywhere yet. So your tree doesn't have any tests
> for that code and still has the old naming.

https://patchwork.ozlabs.org/comment/3473898/ is a well thought out not
gratuitous summary of why the series as it stands is a step in the wrong
direction. Tests are good. They're not a reason to pull an otherwise bad
series. This series should be rebased to not depend on that series. The
tests from the other series should be split out.

> 2. I sent the first part of the PXE series so you could apply that.

Yes, I should be applying that next week.

> 3. You rejected the second part of this series because it didn't
> include support for lwip without cmdline. I offered to handle that
> case later but I'm pretty sure you rejected that too.

That's not how I would characterize it, no. I said you should probably
focus on sandbox + lwip, since you're the sandbox guru and ask Jerome to
do the net_loop-alike thing, since he's one of the network custodians
and the lwip person. I was trying to direct you to where your efforts
might be most useful but if you insist on instead doing the
net_loop-alike part and Jerome ack's it, that's fine.

> 4. This series is now marked 'changes requested' but the only feedback
> I see is in the RFC patch.

Yes, rebase to something that can be applied is a change I've requested.
Because my feedback was "Do you plan to rebase the prerequisite series'
this requires so that it can be merged?". I would have otherwise merged
it by now.

Patchwork reflects mainline status.

--=20
Tom

--M0o1PJS62GQK348u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfUVBIACgkQFHw5/5Y0
tyxRNQv+JUfeU9XnoR0ccrvsc10nUJvylokveHpsNTWamOc5xnrCCw6zhoweIFCz
ahtPpa0NjX9iMpafqhi41cIOAAbIn0ICN5F2CKZ5HIVT1f7b7esDaanJU+eB5bDM
u06wuYuvUeWtcQpytnBy4qu2m/udKU8i5H9ppqTStrxkASBctHJH6vI86yxUpSwM
eunQ5Wkj/I16YdO/tnAFcLBI0aR3AGB6spF3Qz0opNER7RNh8kw265QOyGfoMqJL
L/PVi5ThwH98xD1yTWtHPDOAjTAjmezGcRezG66WkAooL+Z/iZyImLnkk4vf1wPQ
XSGJxzMjeb25/Ihf91YDs9JyL77/18Gu4oZIWGdEHHfiDMrv0Z97QXJpRU5gAjhI
hTUOs6CoP3p8EuZR2Fx1IC/FkpF+XumtXGLvuN393ZjwFwgqisqoz9cX7E7BPT4u
hF57ykTWLg+0/0+vpcBoXM87UC67IIN4VarJyqj6/eTWDBfENXgaUnsXVuRzTeVx
6+wbpGLs
=n6af
-----END PGP SIGNATURE-----

--M0o1PJS62GQK348u--
