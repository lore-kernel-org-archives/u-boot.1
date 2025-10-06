Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A99BCAC5B8
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 18:00:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD71483CCA;
	Mon,  6 Oct 2025 20:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lII0MysN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C52C483CCA; Mon,  6 Oct 2025 20:00:05 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88DBE83BC4
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 20:00:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-42f74b8edd8so5032105ab.2
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 11:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759773599; x=1760378399; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Oz/L+lf9vGjbp6He/vqgAsSFeUdP2mJgVVmx2lZZ2Qo=;
 b=lII0MysND9ZhXAk3DBVIGJ5Ntnqr1zJ5bPuxlHA6QDENnlF3a+eUqHLoPp6YYqtnXn
 vAs1Pv6jhdKSLKkGs/bKLO5ABgvgHv2dD7h2KeDokUzJX2SXYflFyzq9pNLCiz/MYYNE
 F2qHeM1l6WgpzVcuIbFzBqgh9ElDdeGZQE9Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759773599; x=1760378399;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oz/L+lf9vGjbp6He/vqgAsSFeUdP2mJgVVmx2lZZ2Qo=;
 b=uEHN4l7z172CQ4LlH3Ai5b5sCN8JNKoZbkGTAkAiu4sXqXHdRe9W4Auh6TvpPqslcD
 q8KuXdvE+jqE8fND5VwnAyrHNbANfqbSrVTaUUZcBeKKrAsASI6ZEV/xqlL8SizPbNYu
 l4oGHwEbNLoPZt6UrUkmet4g3gIj9tDYvGgkNZR1+v5+6af6kyLpxaRzdrz1ybXQ+Qp9
 ufl0ZTvyK8hL/qNoQcS6dcJogIOxmXTdlwrD97QIH2TWnZaHCYjwPcOxKyUwov5Gcnvc
 PneDu5JDYqBgBjylT3YMQYjKX81lqZ2h85RLbp6+Q78+bmxbbWkuKwqyhWSdYpmb9t+U
 zK6A==
X-Gm-Message-State: AOJu0Yxx/y+i2fdy4Z6BzvWhIafa1w9FlBOwGVWuhjOvg3mHxNfh45Cc
 F1rdcnuueUiklesPwFbv8yKfTw7j7XQM4uf+RqHNkV2M9wWs5bqFVU0YZ0V3/PsH3uQ=
X-Gm-Gg: ASbGncsg58mpVvRsRYm4WLHdaY3qsuP91wvRjk6rwHdAhIogZKH6iX6CydugjbI4bgh
 Q3iDsErOqRSI9WYz/I9brBSqhAonoCpkZsc3/JBoUy9o1F2gZykVjEPPaWYGtwkFxWyiCXOCr0L
 mtFLGK9eGq0kIL+1LX/LIolNhxmSYK5jBlXpjdX91AdSfU7Ai7WIDtIC4ib/eboFDkPIAIR96bQ
 rQEbQAzxBQx9gfAggrF7rJWx4sg8O2FyaVfwufrsfpkB8jH9A4NMsbtDTGzLiQ9HDh/zHXcfZg5
 cFLq7KlgTuPfZbexDdu8nttTfoncsbpS7oo2SoISbGFRlIDqrYHX1sOdxogRLvs8sEdOrhZf1Me
 6tS+uV7SYAH5rArPbGLf/6dkpdBqA8Gc5LmaouX/Uf4u/KYsDD6Mfs5MTkRNxTBxm7X18zfA8qQ
 5UHRaKCL+Baw==
X-Google-Smtp-Source: AGHT+IEO22ECtHVP97Fb8/7hVL4sOqau5FGRn2Rz4NZwl1uTXiF10eqw4ADsLqsK5xoOwdYxy8Q+rw==
X-Received: by 2002:a05:6e02:12e9:b0:42d:8bc6:d163 with SMTP id
 e9e14a558f8ab-42e7ad18efbmr189530045ab.9.1759773599076; 
 Mon, 06 Oct 2025 10:59:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ec097absm4883746173.56.2025.10.06.10.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 10:59:58 -0700 (PDT)
Date: Mon, 6 Oct 2025 11:59:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH v2 0/5] Enable Firmware Handoff CI test on qemu_arm64
Message-ID: <20251006175955.GA298503@bill-the-cat>
References: <20251003192222.767882-1-raymond.mao@linaro.org>
 <20251003201331.GS6093@bill-the-cat>
 <CAEfUkUJa=eTq4MkjosnN1SxA2Aq3ySTZrSiHj3474otN8VLjfw@mail.gmail.com>
 <CAEfUkUJhYuLzRE5-UkmFY9P+RG5N0sgATzHf+2X-HAF1657_+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hRanq1r8mNmkVYfO"
Content-Disposition: inline
In-Reply-To: <CAEfUkUJhYuLzRE5-UkmFY9P+RG5N0sgATzHf+2X-HAF1657_+Q@mail.gmail.com>
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


--hRanq1r8mNmkVYfO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2025 at 01:42:50PM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Fri, 3 Oct 2025 at 22:04, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Tom,
> >
> > On Fri, 3 Oct 2025 at 16:13, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Oct 03, 2025 at 12:22:14PM -0700, Raymond Mao wrote:
> > >
> > > > This patch series enable Firmware Handoff [1] CI tests on qemu_arm6=
4 by:
> > > > 1. fetch MbedTLS (v3.6), OP-TEE (v4.7.0) and TF-A (v2.13.0);
> > > > 2. build bl1 and fip with both Firmware Handoff and Measured Boot
> > > >    enabled;
> > > > 3. pytest to validate the Firmware Handoff feature via bloblist by
> > > >    checking the existence of expected FDT nodes and TPM events gene=
rated
> > > >    and handed over from TF-A/OP-TEE.
> > > >
> > > > Pre-requisite u-boot-test-hooks patches [2] are required.
> > > >
> > > > [1] https://github.com/FirmwareHandoff/firmware_handoff
> > > > [2] https://lore.kernel.org/u-boot/20251003191918.767698-1-raymond.=
mao@linaro.org/T/#t
> > >
> > > Generally, the changes look good, thanks! Specifically, did you trigg=
er
> > > a CI run where you pointed Azure at a fork of u-boot-test-hooks with
> > > your changes? I'm a little concerned about the fiptool change and I
> > > don't see a CI run where qemu_arm64_optee.. was triggered, only:
> > > https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D12044&vi=
ew=3Dresults
> > > where it's not. Thanks!
> > >
> >
> > That PR is missing the last commit (adding the CI jobs) and still
> > pointing to the original test hooks.
> > I have tested with my local docker container (has a test.sh that
> > simulates the one from azure.yml, and points to my test hooks working
> > branch) and all works.
> > But when I triggered it this afternoon at:
> > https://github.com/u-boot/u-boot/pull/818, I did see the failures...
> >
> > Hmmm, I will compare the log with the one I got from the local docker
> > container to find the cause.
> >
>=20
> The github CI seems to not build from the dockerfile, it always runs with:
> ```
> 2025-10-03T22:30:41.8339632Z Digest:
> sha256:0d2cd4abea187f396a7e77041a6d9ce877314446a154cdcbfbbf546b09a58d09
> 2025-10-03T22:30:41.8352926Z Status: Downloaded newer image for
> trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025
> ```
> That is the reason of failure.
> Is there a way to hack the CI to build the container from the
> dockerfile of the PR branch?

Yes, you need to change:
  ci_runner_image: trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025

In the .azure-pipelines.yml to point to where you've pushed your
container changes to.

--=20
Tom

--hRanq1r8mNmkVYfO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOQDmAAKCRAr4qD1Cr/k
Cl3DAP4oAVfZsMIrr041av8jLz55mMt2W+WRXbAQa3K14rRo4QEA+LC8ADLuotps
wVtFig5+hXCdxR7024VYVhmtmitNqQg=
=AkqL
-----END PGP SIGNATURE-----

--hRanq1r8mNmkVYfO--
