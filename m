Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81FC6C27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 15:20:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C8D18843F;
	Wed, 19 Jun 2024 17:20:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YfMBQXIH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D83B88843F; Wed, 19 Jun 2024 17:20:50 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F071D87F5C
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 17:20:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6f9b213ebf9so417164a34.1
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 08:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718810446; x=1719415246; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uCd8eu72qp/A8KP5LzHtqwy9FDxdz/oYC/lBm7wZy58=;
 b=YfMBQXIHJd5M8Joto3s7P77Sjh81zU/VN3A5SLKorHiYtewgNZhUCLkt505Nv07MDq
 uBgTEUyaR6isx6MwST4QNoPwk1kWrPYlpCo8lIpUQ4qMalSXzWzj/W8VmB4KvFchyX3f
 YsIY0Nt16Qygk9ehVM7mBav4aB2YCK8oTjOVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718810446; x=1719415246;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uCd8eu72qp/A8KP5LzHtqwy9FDxdz/oYC/lBm7wZy58=;
 b=VVlMaPybbvePhFS31XrNr/MmiGq8v+rkA5m7rGMdC1PDS6gj6mmddcZtMiNe3P8wnR
 lKXdZ8PsYBbwh0+42dqIf99/lh5J/9Dckx6DlDYPqRv67y29eUaWA027l35GYUdBK8Mq
 JhQDzcR7lxY5N0R8ajuqgKb7weBQfIWNPy9fPsPiA4elKo2Ue96w3qV2fdr6nS3oIVNb
 XR8ETFfABepcVHQ9AdRYJ/P8Fx47dAgo34AJe1aUay27Kt8KtcIo//Zh5vLV2JiAtE4A
 Vg5KBlbzTHBn3A/LqaMx8+q5huUB92FHEIklMlJXRYkafYfTn5cndYVyxm8wOEQcE7UZ
 ny5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNIPyBbDZqD3RmodB3nbP8l2xW7VDuTLZtSNu0zfBrXeV5kIBexOZ2dlZCus9Bz7zy6Mpxn8hgb/MDogXrKQtj1DTGtQ==
X-Gm-Message-State: AOJu0YygUdmjc8s3g+zfR0Falm0P5AewSzfZfQy5Ool5nx3kN66BLyJt
 JfbcAYUpe4yv9DKy9whZ7JNGYFOvAnPLD6qKo3ihbTicJrT196q9k2rAdtomJvA=
X-Google-Smtp-Source: AGHT+IFP+qMBZ4rDwmzG6X/O2JAwmBeYYjiBl8ZDew8aLat2OL4EWiPkM1NHoBT4FcXiyii+UiBZFQ==
X-Received: by 2002:a05:6830:310f:b0:6fb:7d78:e36e with SMTP id
 46e09a7af769-6ff1658509cmr3207734a34.2.1718810446582; 
 Wed, 19 Jun 2024 08:20:46 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6fb90da5515sm1983084a34.32.2024.06.19.08.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 08:20:45 -0700 (PDT)
Date: Wed, 19 Jun 2024 09:20:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Tim Harvey <tharvey@gateworks.com>, Stefan Roese <sr@denx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aaron Williams <awilliams@marvell.com>
Subject: Re: [PATCH 12/20] cyclic: Rise default CYCLIC_MAX_CPU_TIME_US to 5000
Message-ID: <20240619152042.GB68077@bill-the-cat>
References: <20240611-docker-image-v1-12-51472eb70357@flygoat.com>
 <20240612160053.GS68077@bill-the-cat>
 <49522625-8663-4102-82aa-cabc0f239afa@app.fastmail.com>
 <20240612165048.GD68077@bill-the-cat>
 <e94995af-f9dd-4262-8dfb-2c47ab817e61@denx.de>
 <20240617232904.GL68077@bill-the-cat>
 <c50b3dc0-0385-4548-80ed-ffdc8623bfcc@app.fastmail.com>
 <20240618143159.GR68077@bill-the-cat>
 <CAJ+vNU1fifv8gi3MLV+qBk2-Q4aiZNG4Vwr=MgbfjZzMOAbvHA@mail.gmail.com>
 <8eed077e-5855-4b32-8198-62b4f13c376a@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aZEpOROshgle0nYF"
Content-Disposition: inline
In-Reply-To: <8eed077e-5855-4b32-8198-62b4f13c376a@prevas.dk>
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


--aZEpOROshgle0nYF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 10:21:51AM +0200, Rasmus Villemoes wrote:
> On 18/06/2024 23.03, Tim Harvey wrote:
> > On Tue, Jun 18, 2024 at 7:32=E2=80=AFAM Tom Rini <trini@konsulko.com> w=
rote:
> >>
>=20
> > Stefan and Tom,
> >=20
> > I'm seeing CI issues here even with 5000us [1]:
> > host bind 0 /tmp/sandbox/persistent-cyclic function wdt-gpio-level
> > took too long: 5368us vs 5000us max
>=20
> Yes, 5ms is way too little when you're not the only thing running on the
> cpu, which is why I went with 100ms.
>=20
> Random thoughts and questions:
>=20
> (1) Do we have any way to programmatically grab all the logs from azure
> CI, so we can get some kind of objective statistics on the number after
> "took too long:". Clicking through the web interface and randomly
> searching is too painful.
>
> It would also be helpful to know what percentage of CI runs have failed
> due to that, versus due to some genuine error.

I don't think we can easily grab logs via API. And at least for
https://dev.azure.com/u-boot/u-boot/_build?definitionId=3D2&_a=3Dsummary a
lot of the failures have rolled off already because we only get so many
logs and I try and mark full release logs as keep forever. But
anecdotally I can say 75%+ of the Azure runs fail at least once due to
this, and most fail enough to fail the pipeline (we get 2 tries per
job).

> (2) I considered a patch that just added a
>=20
>   default $something big if SANDBOX
>=20
> to config CYCLIC_MAX_CPU_TIME_US, but since the problem also hit qemu, I
> dropped that. But, if my patch is too ugly (and I might tend to think
> that myself...), perhaps at least this would be an added improvement
> over the generic bump to 5000us.

I was fine with your approach really, maybe a bit bigger of a comment
and note under doc/ as well why we do it?

> (3) I also thought that perhaps for sandbox, we should simply measure
> the time using clock_gettime(CLOCK_PROCESS_CPUTIME_ID), instead of
> wallclock time. But it's a little ugly to implement since the "now"
> variable is both used to decide if its time to run the callback, and as
> a starting point for measuring cpu time, and we probably still want the
> "is it time" to be measured on wallclock and not however much cpu-time
> the u-boot process has been given. Or maybe we don't, and
> CLOCK_PROCESS_CPUTIME_ID would simply be a better backend for
> os_get_nsec(). Sure, time in the sandbox would progress slower than on
> the host, but does that actually matter?
>=20
> (4) Btw., what kind of clock tick do we even get when run under qemu? I
> don't have much experience with qemu, but from quick googling it seems
> that -icount would be interesting. Also see
> https://github.com/zephyrproject-rtos/zephyr/issues/14173 . From quick
> reading it seems there were some issues back in 2019, but that today it
> mostly works for them, except some SMP issues (that are certainly not
> relevant to U-Boot).

That could be interesting too, yeah. I do worry it might open its own
set of problems to figure out tho.

--=20
Tom

--aZEpOROshgle0nYF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZy90MACgkQFHw5/5Y0
tyyffQwAowabK8OnORjqZSKy8DiN6I0vXH90nwNN2Sq/Il4tr5LpRMsjr30j4mBo
QKHR+Fqwx6/usElSuZqP8uZBkvxxv9nBeay6eq0bMQMJHaM0f93G5q0GaDsSdowx
mQruHnLOc9tpgHMKVTWxRmt1OGndWOu8CMIfM2rL60BJuYCzVbElC4ZYmk96wJle
/TmcytZU/LaruF2lAX11ieR5OsIAqEJBOKBcJ/jnU0yA01LzoJVeZrMqlx4LnLFP
njlZArsHjFlUaIZYvd8DhNDuImoMoI/3yh0L27S09hEY2tNL0YjA49ZLbT/syIv4
4nyz1HUsRUDekdAKG16zkVWGwACxhsNRXusznhF3M0zA0fITmtmOy7Tg4d9bk55j
jmVOd56dFcFrJIJsUoNHHS1Z4/vfixvdeT9NluBTQ5NDDdLqBYzpuGe3CCW3ad4v
3tOd5iqH+gVCH4pO92y92P8Qayl2WkN4DU8AtmpLJTWuN95ZUEfXm87O5t8kCvEQ
UvIaaa2f
=3EGw
-----END PGP SIGNATURE-----

--aZEpOROshgle0nYF--
