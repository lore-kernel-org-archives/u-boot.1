Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62B6EE14AA
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 01:59:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4A16866D4;
	Thu,  7 Sep 2023 03:59:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Jq10Iiqz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8D038671C; Thu,  7 Sep 2023 03:59:26 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C133C8608A
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 03:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-58dce1f42d6so22249007b3.0
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 18:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694051962; x=1694656762; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N6dD8zaKZ6g7Khg5yi4clfX4xEy0/i3wDNIjBWoKPaU=;
 b=Jq10Iiqzqun/uRTKg187NqkyLACQGpjUJbV3UIGcX3TI/mGtbRRRWjTzO0CLS7jaPj
 wRGHhpTEA2W3XvjJS5mnxsLBYBbZDkRPCTpQGN4p1M6hBipNtLSOhtTEMhfs1vVQ65GD
 Jp1AKaEgkCp8rGlvT0tgq5G0Yox9SevV8jQDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694051962; x=1694656762;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N6dD8zaKZ6g7Khg5yi4clfX4xEy0/i3wDNIjBWoKPaU=;
 b=ZaPAvwTTQGB2OJVCnPWL22L3s4d/FpyN9tYUTuO+6ijue69gTmsm7eV0qqx6LW1p0d
 xtZionBcDJmBKddNdgwobdky0jJ1prkUhNvEpjWbvpeE5wTcYYAiARvoz2u546cv01TO
 +lnG9dYhJzhPE6YgjJBDve0DKxs9PlF8SSR2oJnfHfx88M8fbJxjSUKKWaAziEiVQTNk
 piRIz3zvtns3jX99WcTNOKF/rHN2QlA0EZpP/9rBhTyBXnPsDv4iuG0JmTibN/zAAH4r
 V//6QjLQ0XPhZNMpjKNqT6TMHkL352ZT94jAg02LzWPSHblL+RanhQ0IzK1BSUZovvag
 osqA==
X-Gm-Message-State: AOJu0YzOFjyseVJ4+AZdL9pkl/PQ/7xw8xEyfNDPx+99v1aoroK7aVEr
 9YymKrcPkoRzEiYP5LjPWGmo1u25DV+JXHdzXzgsxQ==
X-Google-Smtp-Source: AGHT+IFQoHuQNDi5AjEdYNViUnUROT90TEpJOB89bEMoyUBSs4qqgaMdgBuuyvvWjUqxI0usrPNiHg==
X-Received: by 2002:a0d:d451:0:b0:56c:f547:e058 with SMTP id
 w78-20020a0dd451000000b0056cf547e058mr1685545ywd.18.1694051962533; 
 Wed, 06 Sep 2023 18:59:22 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-27f1-c90c-e8ad-e559.res6.spectrum.com.
 [2603:6081:7b00:6400:27f1:c90c:e8ad:e559])
 by smtp.gmail.com with ESMTPSA id
 i199-20020a0ddfd0000000b005869e1d8c41sm4040371ywe.29.2023.09.06.18.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 18:59:21 -0700 (PDT)
Date: Wed, 6 Sep 2023 21:59:19 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
Message-ID: <20230907015919.GV305624@bill-the-cat>
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <CAPnjgZ3HVJ9+-PjmHSKwQRgCMkcNPWAcfMkk5SMMgiHAcY0SsQ@mail.gmail.com>
 <CALeDE9MMiA9HVfbeOV3tGqfAAC9oYf9qvizBW0T=hLmqcYD=qw@mail.gmail.com>
 <CAPnjgZ1pgvxhntJvkuAsxKXUVxcWACNTpuDqgonFCrOLr=934Q@mail.gmail.com>
 <CALeDE9ODEwV0Z9APwb1N8QNZFQSB1dkMTMHPW2p2xTLiUZjQ1A@mail.gmail.com>
 <CAPnjgZ1FiqjjxjL+Ve-s5WEafksOZsSP3XyW4xYdjyP-U_TZzQ@mail.gmail.com>
 <20230906142139.GA1236014-robh@kernel.org>
 <20230906220416.GK305624@bill-the-cat>
 <e7a3a0f4-7cd6-40e3-8c1f-84ad3304d3b7@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LcUXn1C8FImXpRZs"
Content-Disposition: inline
In-Reply-To: <e7a3a0f4-7cd6-40e3-8c1f-84ad3304d3b7@gmx.de>
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


--LcUXn1C8FImXpRZs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2023 at 01:30:01AM +0200, Heinrich Schuchardt wrote:

[snip]
> The missing piece is validation of the U-Boot internal device-trees
> against a schema in the U-Boot CI. This should be possible even if some
> of the schema yaml files are maintained inside the U-Boot repo.

Dropping Rob since I don't think he cares about this part.  Yes, what we
need is some help in re-syncing our Kbuild (and Kconfig, but..) logic
with the kernel as it's stuck at v4.20 still and all of the parts that
make running the validation targets would be much easier (free) if we
were in sync or much closer at least. It would be much appreciated if
Linaro or Canonical or one of the other companies doing U-Boot work
could get someone to focus on this task.  It would help with a number of
things, this included.

--=20
Tom

--LcUXn1C8FImXpRZs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT5LncACgkQFHw5/5Y0
tyzsHAv+PoLNfWSACHAwe8ANcd6PCv1YDDOt71pxjq3zunk9VSK0YPUDpmuP5axU
T0awx4ZL/eUQhrcCigEQd8IML4wbh5+wn9lCDt0EMG1Vw23W9SaqwZzfi+HydnTu
FA9JytJcI/YMVTNpfcqpwJ8Lj9cKvnHvvQhEo3ohPEfNUvyVNtb5knWfmCQ6gkfP
qyhSAD54E5sU02JBFrqEl0brymH9Hfh6NXSABhO3cJcqhjXFkKpW91mzbQA3tc0H
s4IHZQJppwOoiBE4D3QxqwzQyqITXJBi3Sh8QEPhV8AbdeGHEa8ckBr0Nr+xOTLn
KuuZNIh8XEbrN1/GBtyxWPMgdw/wrkLo1rFUN+0MmjOtk1iEaMMr7tdPtwwVXS0G
4YIeNPY5gyLvxhpY1o+/dYah4owH2tamBTwSW6MNIV+S8jDb1vdr0oLiZ7gZTKMo
aHquP/+FVgj7k048cOqg1tvRsiICZQmfaitoIj2WFbr4F1Q22Y4UM9Yc6ELeqPzk
DkCgBkk2
=GH/M
-----END PGP SIGNATURE-----

--LcUXn1C8FImXpRZs--
