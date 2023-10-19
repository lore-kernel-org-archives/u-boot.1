Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F25CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 14:57:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E8EE8724A;
	Thu, 19 Oct 2023 16:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GSgaB31F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1C3A86FFD; Thu, 19 Oct 2023 16:57:08 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC3BB87250
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 16:57:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d9ac9573274so8964397276.0
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 07:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697727424; x=1698332224; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=an8w5icR1Jj90foJkbPsts42TsxReY4tWKBRoHbI2fI=;
 b=GSgaB31F55MMNmjsbXzdzhEh/l9Wbdjk0xpYgslHPSPLsdihlPpLcR3J8WkOijmOsA
 QOOeU4IfgccHbOxE/Her2zedVPcxUGYpiIQXL7bs8U2AMeNQU+fc64QHzd/nvQeOgv/+
 e8Z8CgP+/oKV3Xpudd2oA2FiKhdzjz9VUj63o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727424; x=1698332224;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=an8w5icR1Jj90foJkbPsts42TsxReY4tWKBRoHbI2fI=;
 b=PDdFBFiuotzCY0c+ozUBhHnQjvEot6shY680eSnCuxJjbdPnKI9HMMUWiQkTLPLpZE
 8EV1nsf21CCdj94ockhkKdS5v+EZyMG3IN7JkIkGJz+Q40WGGb7UBovY3XmG0k/Zv76H
 x4/QTysToZZu9ZCpV1Q05iNd//GY+gTDdSDMEHI6tUdZCFmpFOwhoWD+3T7HhrpiM8Zr
 FvY+9nk5RKnIDXJ+tm89Jre56PmYNYn/2D16USGfa83w4/ndkl+PIo92r/1CRJkAmAz2
 QBiZNvSP7GHvDadkwfN4L+M8/Yh+UaMpuMg+yrSVA2xXNFZwUPcWZxXOY6Q5vmmVaI57
 +vjw==
X-Gm-Message-State: AOJu0YyZo+ADGpLbTGYd2lAZLQJD1+Ge+flNNjh3wA9qrgw1KXJ1OWFS
 BysV2koT6fL+xETut8W/xWG9SQ==
X-Google-Smtp-Source: AGHT+IHkzrjF5aboT7RSase7yPo07KZOT06ykrk3uRFK5aIgQq2rA30i7yXYRZ1Q/As9iohTDZlUTQ==
X-Received: by 2002:a25:d30a:0:b0:c4b:ada8:8b86 with SMTP id
 e10-20020a25d30a000000b00c4bada88b86mr2544155ybf.64.1697727424643; 
 Thu, 19 Oct 2023 07:57:04 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 o128-20020a25d786000000b00d9cb47932a0sm489840ybg.25.2023.10.19.07.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 07:57:04 -0700 (PDT)
Date: Thu, 19 Oct 2023 10:57:02 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 32/32] sandbox: Add a test for disabling CONFIG_CMDLINE
Message-ID: <20231019145702.GZ3119521@bill-the-cat>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-33-sjg@chromium.org>
 <20231019023253.GA1856856@bill-the-cat>
 <CAPnjgZ1xFkn806tSJzM2_wKhKz_GbJvA9bCALiaRV+wGaXz6_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FeWPD4qAaoUxuWnM"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1xFkn806tSJzM2_wKhKz_GbJvA9bCALiaRV+wGaXz6_g@mail.gmail.com>
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


--FeWPD4qAaoUxuWnM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 08:00:00AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 18 Oct 2023 at 20:32, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 16, 2023 at 04:28:23PM -0600, Simon Glass wrote:
> >
> > > Now that everything is working, add a test to make sure that this
> > > builds correctly.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > ---
> > >
> > > Changes in v3:
> > > - Rebase on Tom's LONGHELP series
> > > - Correct 'of' typo
> > >
> > >  test/py/tests/test_sandbox_opts.py | 20 ++++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > >  create mode 100644 test/py/tests/test_sandbox_opts.py
> >
> > This is not doing the equivalent of:
> > make sandbox_config
> > sed -i -e 's/CONFIG_CMDLINE=3Dy/CONFIG_CMDLINE=3Dn/' .config
> > make oldconfig
> > make all
>=20
> Buildman should do that automatically...is something failing?

Yes. https://source.denx.de/u-boot/u-boot/-/jobs/716843 fails, but
shouldn't, and it's only the no LTO job, so maybe there's some conflict
there?

--=20
Tom

--FeWPD4qAaoUxuWnM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUxQ74ACgkQFHw5/5Y0
tyynrwv/YXAcPHsib3WdEt+5f7pk+6Zvc0uR+Ykn/jVUngS8MxNKTfWmj1t9ao9W
/b3hA5FszjZ2iGCDY3CeR1IU/lu/lvhQ4uXAadGUYX0RA+WSgHdR3pHetIIhx+DD
S7ig1/1p81hlUmSI36bzQ9XeNoDbMxZ00QtJG8LdtfMLvQgLb1K1CGwpEQ9HU9FX
Nkc0agS9n2jegdPQNEvkh2tfZjJKEzTeZIVXAWZD/ZbuPgODhjH6dyiBZX/w6c0c
DC+hcHMsCMtPtbebL7faRvjVxjzdYnjDT9SjNsKQGm3f4cd6nqImJELnNagXdtDv
wxU0zeEsrb3YZlXjrqQGqyxN+cw1e8PqhW466BQTokH7SWYhOv0xRPXk1onA6pWp
1nOj4cfodGQ9bqZpSzC80XS7SUhuDMaiDZKEZP3JodsX8shmg3xd6ITWlYmycB4M
w0DVbnFQ2HVr6zLKMozx61ZxxVZijerqdnUl49zNABCZ2iX5iRMFT8PTbFtNkpQT
aohfDj47
=5AL+
-----END PGP SIGNATURE-----

--FeWPD4qAaoUxuWnM--
