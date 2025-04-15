Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6736C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 14:19:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E42B082AAF;
	Tue, 15 Apr 2025 16:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D8LLnMQm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89B2082ABB; Tue, 15 Apr 2025 16:19:48 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D28E88294C
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 16:19:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2c76a1b574cso2156500fac.2
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 07:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744726784; x=1745331584; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ygoJgnvmaSFTnIS14UmhKeoWrz8bFAXxPCKWo1qx6iU=;
 b=D8LLnMQmFOGk8/4ms1CWeBK5YJcOIPVr5PB9ZBq0gPzfgS3aMEUvutl4X3TOYiQZMe
 AbjSxYFR6qrkAmyVO1EuFZwP3EAXflZpCjq58Q0kXWeHFuA//3ncTT6U4Zw8JJvQb+OE
 SKALo1Ha15+EaeTB6ajciMtN3b9M7cjkP+3xA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744726784; x=1745331584;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ygoJgnvmaSFTnIS14UmhKeoWrz8bFAXxPCKWo1qx6iU=;
 b=PymLPewpY5vOB0kvrJ9UUB/o5lr7DBg8rO1BWNd9vXXqJmPflp6IZ1Fvj9iZTX9pfi
 98zNJ+VAR9XdC9he7mu7nTtpFzyZyxigx1+EFQW0dnX5CL3au4vKnjlgTTFsoEurK6TT
 0Gx6/sVT8QV+uMfIiEhp7htP4w3n1k5/PSlvBvzw8of0LzG0sBxeKYy7Lpms0mZOIyQY
 S9+DXXCpcSkAS7zg0E+QdWtRUH677AH53PZxWSOm+AdaFOYCpy2zeE/Mb6MSzpIq6oLm
 cawikdthzHZZqT3JpCFviWAK/JKW3FugMlLsOmfd/+qKUPblPUHdAGPVklHLOlyz4YFV
 JCIw==
X-Gm-Message-State: AOJu0YxYwivpL7OG/kiVsOEGN1W9r+ZCUqzY+qhUgCIqyMjl5zvzUKXC
 IU78JJToIKUX1i5xkOqC+eFA+Yy9CsIazIMvuJu7vFs9bfb0fkbsO0JZTSSIKJE=
X-Gm-Gg: ASbGncvZPAKYieT5tVDDPDpHuzw8X8R8W9V4WL5AlyMMv+KWOgaFYfcH/CSk6mPF1qE
 yWN+AmtfN6T6Ae8UMwdglNRGZLav2ViKFc7iuhEYEGQ92RqFgHswN2EGrUW1V2WQ8ST3Q+5eYJL
 mDaSuolVTpvY+cdOR/6+zhy++umZtZkLdCPoDSSXlgLjt78PKdEwvtu5oKCJKRkfGz66Txps64v
 hJstaOYFjefC51t/CcUqwLCYnAHFbcxo4m3ugHRGCE9/hE4g1G6Np+3eVuWUVyjd0e+1hvL1343
 S++GjS9MmlBg3VBUUqAJmOaPrgBJsNU+a7U6M0AoVPVK2BaEPod+QXfLp19E2JHENUZjZk2lOOQ
 /wA==
X-Google-Smtp-Source: AGHT+IFmff9e+wDWs1F9iniycLvnb3CMmUmzmqzPZTqAayQliv9VBKte5tcOJXN5SlryRMSuVgBO0w==
X-Received: by 2002:a05:6870:ce46:b0:29e:69d9:8834 with SMTP id
 586e51a60fabf-2d0d57dd009mr9284909fac.0.1744726784438; 
 Tue, 15 Apr 2025 07:19:44 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e73e677f1sm2376937a34.65.2025.04.15.07.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 07:19:43 -0700 (PDT)
Date: Tue, 15 Apr 2025 08:19:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v5 00/16] Uthreads
Message-ID: <20250415141941.GK5495@bill-the-cat>
References: <20250331123120.2025062-1-jerome.forissier@linaro.org>
 <20250411202910.GA141451@bill-the-cat>
 <8f1d8b98-6eff-4986-acad-f4eb7da87446@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EA0s2itjt1j28Lyx"
Content-Disposition: inline
In-Reply-To: <8f1d8b98-6eff-4986-acad-f4eb7da87446@linaro.org>
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


--EA0s2itjt1j28Lyx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 03:36:53PM +0200, Jerome Forissier wrote:
> Hi Tom,
>=20
> On 4/11/25 22:29, Tom Rini wrote:
> > On Mon, Mar 31, 2025 at 02:30:54PM +0200, Jerome Forissier wrote:
> >=20
> >> This series introduces threads and uses them for two things:
> >> - Improve the performance of the USB bus scanning code (scan multiple
> >> busses simultaneously),
> >> - Implement background jobs in the shell via two new commands: 'spawn'
> >> and 'wait'.
> >>
> >> The threading framework is called 'uthread' and is inspired from the
> >> barebox threads [2]. setjmp() and longjmp() are used to save and
> >> restore contexts, as well as a non-standard extension called initjmp().
> >> This new function is added in several patches, one for each
> >> architecture that supports HAVE_SETJMP. A new symbol is defined:
> >> HAVE_INITJMP. Two tests, one for initjmp() and one for the uthread
> >> scheduling, are added to the lib suite.
> >>
> >> The schedule() and udelay() function are updated to become thread
> >> re-scheduling points, and mutex objects are introduced. With that the
> >> USB stack initialization is modified to benefit from concurrency when
> >> UTHREAD is enabled, where uthreads are used in usb_init() to initialize
> >> and scan multiple busses at the same time. The code was tested on arm64
> >> and arm QEMU with 4 simulated XHCI buses and some devices. On this
> >> platform the USB scan takes 2.2 s instead of 5.6 s. Tested on i.MX93 E=
VK
> >> with two USB hubs, one ethernet adapter and one webcam on each, "usb
> >> start" takes 2.4 s instead of 4.6 s.
> >>
> >> Finally, the spawn and wait commands are introduced, allowing the use =
of
> >> threads from the shell. Tested on the i.MX93 EVK with a spinning HDD
> >> connected to USB1 and the network connected to ENET1. The USB plus DHCP
> >> init sequence "spawn usb start; spawn dhcp; wait" takes 4.5 seconds
> >> instead of 8 seconds for "usb start; dhcp".
> >>
> >> [1] https://patchwork.ozlabs.org/project/uboot/list/?series=3D446674
> >> [2] https://github.com/barebox/barebox/blob/master/common/bthread.c
> >=20
> > So, we're nearly there. But there's some CI problems. First, CI isn't
> > testing this because nothing enables UTHREADS.
>=20
> Thanks for looking into this.
>=20
> I do have a TESTING patch [0] that enables this for various QEMU plaforms
> (arm, arm64, riscv32, riscv64) and for sandbox64. Please refer to the
> following CI pipeline [1].
>=20
> [0] https://source.denx.de/u-boot/custodians/u-boot-net/-/commit/8460f6ab=
efff
> [1] https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/25706

Oh good, thanks.

> > I don't know if we should
> > enable it by default on qemu_arm64 for example or not.
>=20
> Good question. Perhaps we could have a separate defconfig for the somewhat
> experimental stuff?

Well, personally, I'd like to see the literal qemu targets (ie
qemu_arm64 but not sifive_unleashed) enable UNIT_TEST and a few other
things so that those features are tested somewhere, and I don't know the
use case for U-Boot for QEMU virtual machine target for production,
where the final use case isn't "... for testing $X". Happy to be
informed otherwise of course. And then yes, we could just enable UTHREAD
for at least some if not all qemu targets that support it, and test it
there. Especially since it's not just a single flag to enable.

> > But for testing,
> > I added this to .gitlab-ci.yml (and something similar would work for
> > Azure):
> > qemu_arm64_uthread test.py:
> >   variables:
> >     TEST_PY_BD: "qemu_arm64"
> >     TEST_PY_TEST_SPEC: "not sleep"
> >     OVERRIDE: "-a CONFIG_UTHREAD=3Dy -a CONFIG_CMD_SPAWN=3Dy -a CONFIG_=
UNIT_TEST=3Dy"
> >   <<: *buildman_and_testpy_dfn
> >=20
> > This however leads first to unrelated tests failing:
> > https://source.denx.de/u-boot/u-boot/-/jobs/1099921
>=20
> Unrelated indeed. It turns out UNIT_TEST=3Dy on qemu_arm64 is broken in m=
aster.
> I just posted a fix [2].
>=20
> [2] https://lists.denx.de/pipermail/u-boot/2025-April/586897.html

Ah thanks, nice.

> > And I didn't see if the new tests ran either.
>=20
> It seems you need to enable CMD_TIME too. In my testing patch I added -v
> (verbose) to the test.py command so that we can clearly see that
> lib_initjmp [3], lib_uthread [4] and lib_uthread_mutex [5] are run in CI.
>=20
> [3] https://source.denx.de/u-boot/custodians/u-boot-net/-/jobs/1103031#L4=
57
> [4] https://source.denx.de/u-boot/custodians/u-boot-net/-/jobs/1103031#L5=
04
> [5] https://source.denx.de/u-boot/custodians/u-boot-net/-/jobs/1103031#L5=
05

Ah very good, I was worried about hitting further issues.

So I think in sum for v6, we just need to respin v5 such that some
representative sets of qemu enable UTHREAD, and then a stand alone
series (v2 of your series in [2]) to enable UNIT_TEST more widely in
qemu. Thanks!

--=20
Tom

--EA0s2itjt1j28Lyx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf+av0ACgkQFHw5/5Y0
tyyCuQv+JzfiA5+cAb+ikVR5KCKtJ58i0V60fiRci6Ik9ZYR513ql+jVwGHTD9wQ
NMHl6RcMaTcG64DZgjT+zUxKTSdvvwBGN/SEEy2vqKLrgYsSiDa6UVw4Y9+EWPDc
vS45WNGTmbDLtU4N05yiTo8AyszCcYBCXxXQy+k0yFx/nvuH2cEHuOvush6VF7vJ
tax1TxZpA8F8CK4y1kamkMZXXauCS/Sv/nMSPE7gINJL0T1VzLLfG3scM+y/I1G2
+b7n9FL86v7vxYkwoA7d2BlCoYsGYua8EQIg8SOI7+Vn3D3Zwdg5zrmjH330DhSG
XEfY52qvc0PbYR10kJ5oYGE9ATakHYuqbn0lqVafrnD4rWEIdUrOUaXNXzLrRUt3
8EIa6wOnEiBi/y0YKPyRIK4KtySnb2qCcy5zPUFgzz4x3uvKj+JNwzyPm3zJKn6p
04kJJk7FugwD3tKFtI1NPzL3MSyQPI8aakCE2y5OXShVQS9PQdStYb0RXs2Xlz3o
phmuDUyM
=+yK3
-----END PGP SIGNATURE-----

--EA0s2itjt1j28Lyx--
