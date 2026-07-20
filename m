Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D6BC44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:59:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC0B54035C;
	Mon, 20 Jul 2026 18:59:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KMuLZ-bGee0X; Mon, 20 Jul 2026 18:59:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E5A364056E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784573986;
	bh=uRMCWM1nkNYV1tC5a0IhXbVC6dICkMhSJCUaP1d/IwQ=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=iDAvol7zmmXbsvo0puZe9Qdp50xngQKTZpDw+mNMe0SJuipXqrVByq8lTC6yz55St
	 2/A5Kw4DE3A1C8Pr40erdsDg86l2PDkfbI78cx8/8VsHpZ7ExbbBe42IYy6VOVa4eZ
	 fNT1xMghKfV9RIB5ncTGCr+DWblsdiCwkMXxbFSMIWlo9glcoaS94ELnW/1JMxqBD4
	 Uqc2X1iLY6Ungk4XI2ZsTL4lIpgOXzG47NbJgyLkpO08oJ5aAKpnP6iu1XAsiA73VA
	 GHM1gvN0ixGlhUG7uRuMo20U3EMYgwiPtB54g/EpXmaKheTFBckedMq08SLi61iljm
	 hH5mtBEBj7KJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E5A364056E;
	Mon, 20 Jul 2026 18:59:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E9321142
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:59:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5BF54606E5
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:59:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bpiO8hROHBKu for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 18:59:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0D165605E4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0D165605E4
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0D165605E4
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:59:41 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7e6b554044fso8235823a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 11:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784573981; x=1785178781;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uRMCWM1nkNYV1tC5a0IhXbVC6dICkMhSJCUaP1d/IwQ=;
 b=eHi2wT0yakh6zlUhzv+S7zHWu070v3ZlRGKQz1/kCHXCBpGEKMkGuq2w6Urn/nOUw5
 EBMZga0umGUYpT6PX6yh172lh3xUaDItdaY4HKs4U2H6uAPKpXh2/brueiKfzzKF898+
 x0GCoc6Hl/6zI8yeYdjIs1OGutmYK5HMNQCwuTY4F7NoTglCLUsNgulhAx3ZV99xT97F
 8FbqLhxYFL5Koo7MGjC+uNdgsfqQ256TnxF+DvKnI353tif7uEb59FQgzKpckmBSamM/
 NhRsFVvvjIdKDMdrlN62znHoH8Vj2LdcSRCgDGUomy/GNGmPQD31nK1X5h9LXZptVJ35
 9S3A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqLncSRl+0246ehPqXoEU1eW49VMXDPUbSmubwwSTFySPX5SGTD2vuLN7PE9YQ5hPVCZ15Q25E=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzYTnUpwC54fhYvoYlm/E5cgQ28zaNrENZPqSqgE3dHrFR/2+i9
 fb24jZiAFAy2xjBRN81gUHq5sd6ggJRA06AKDMifHFdo906a4rNjN2ruBMoCGm7ZUs0=
X-Gm-Gg: AfdE7clRWPj3fFh+9KzranIRu1Zj2rYT2NDV70Jb/zQC0z70mB9HVuw1EfPsw3IOwbp
 1XEfSMrLaioDV0ZLLDp6DY3sRhEZcdtxhyHYBUMoFN5gGn4csViG/fi3Hmteas4D1kbKDV245Zt
 nS10Qoi25tP0SQKBowyt2aQ2WJjVqsmgC/NYam2G+24LYMYijcjiQuR707csMe0YVuzVn2cjCK3
 TuVRtflaTJroG5hxr5JerHhTqTgPEWq5Da6lOimxAbZZ9wB8nVbnuuR7Y3BNdGXVADBdKcZi+bk
 zvCmCaFokSc69cCfwdKneFjMTD8MfWTMm5oiHq+7m1qmCcHKiP9pWd1QBgtKnGUzx5wAmXxWJEg
 FFgwJJtqEqOZRjgKEOO8IjdEKnApe88PRLPmJ8Zxd7xpmMiJRbF3OykHqoitRLSTABrDW+pNSeS
 tqzcISQCC2XqSi1TlytreERNf6oLvSH78yNgRcPpuGWV+pL7Unau/+m3+qtkWNZEnUuNt7Ry3eC
 Bk/MojEATVR73TK+3M18dAI5bY=
X-Received: by 2002:a05:6820:f003:b0:6a3:a335:1ccd with SMTP id
 006d021491bc7-6a53667fc6fmr7454905eaf.8.1784573980895; 
 Mon, 20 Jul 2026 11:59:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7edad94f0absm8649145a34.8.2026.07.20.11.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 11:59:40 -0700 (PDT)
Date: Mon, 20 Jul 2026 12:59:37 -0600
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tony Dinh <mibodhi@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heiko Schocher <hs@nabladev.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>, Heiko Stuebner <heiko@sntech.de>,
 David Lechner <dlechner@baylibre.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
Subject: Re: [PATCH v4 3/3] MAINTAINERS/README: Migrate mailing-list to
 lists.u-boot-project.org
Message-ID: <20260720185937.GE749385@bill-the-cat>
References: <20260720-osuosl-ml-switch-v4-0-20ec1c334dd2@linaro.org>
 <20260720-osuosl-ml-switch-v4-3-20ec1c334dd2@linaro.org>
 <CALeDE9MdxKmGbkWstnNxnA5jRQ0rkmYjQbsxf_sRXeAL+yHAew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bzKSDDSaBaMrbjDw"
Content-Disposition: inline
In-Reply-To: <CALeDE9MdxKmGbkWstnNxnA5jRQ0rkmYjQbsxf_sRXeAL+yHAew@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784573981; x=1785178781;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uRMCWM1nkNYV1tC5a0IhXbVC6dICkMhSJCUaP1d/IwQ=;
 b=Bh0nY74wzZwPMHz/StF+BHGy+wGZC4XlbJuYH5ni4d8VI86DgfxCRvl5mHgFLP2qdW
 lM6dZddYerVq9rFbBolKtt8CczRBiQDU10QT3QqfWB02wkOKumc/XAXEu6lo6+K1MgZH
 PEKewpu4RjnEiP1kQOHEekmpMY4mzXZsnVDfA=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Bh0nY74w
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Tom Rini via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Tom Rini <trini@konsulko.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--bzKSDDSaBaMrbjDw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 09:35:28AM +0100, Peter Robinson wrote:
> On Mon, 20 Jul 2026 at 09:23, Neil Armstrong <neil.armstrong@linaro.org> =
wrote:
> >
> > The U-Boot Mailing-list is moving to the lists.u-boot-project.org
> > domain, so update all references of list.denx.de to the new
> > domain in the main README and MAINTAINERS files.
> >
> > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> > ---
> >  MAINTAINERS                   | 2 +-
> >  README                        | 4 ++--
> >  tools/u_boot_pylib/gitutil.py | 2 +-
> >  3 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e5b2a2e373c..177bc1fdc07 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2022,7 +2022,7 @@ F:        test/py/tests/test_xxd/
> >
> >  THE REST
> >  M:     Tom Rini <trini@konsulko.com>
> > -L:     u-boot@lists.denx.de
> > +L:     u-boot@lists.u-boot-project.org
> >  Q:     http://patchwork.ozlabs.org/project/uboot/list/
> >  S:     Maintained
> >  T:     git https://source.denx.de/u-boot/u-boot.git
> > diff --git a/README b/README
> > index 472cf37d9cc..51e98d0f4cf 100644
> > --- a/README
> > +++ b/README
> > @@ -45,9 +45,9 @@ Where to get help:
> >
> >  In case you have questions about, problems with or contributions for
> >  U-Boot, you should send a message to the U-Boot mailing list at
> > -<u-boot@lists.denx.de>. There is also an archive of previous traffic
> > +<u-boot@lists.u-boot-project.org>. There is also an archive of previou=
s traffic
> >  on the mailing list - please search the archive before asking FAQ's.
> > -Please see https://lists.denx.de/pipermail/u-boot and
> > +Please see https://lists.u-boot-project.org/pipermail/u-boot and
> >  https://marc.info/?l=3Du-boot
>=20
> Should we also add a reference to https://lore.kernel.org/u-boot/ here?

No, only because it's the top-level README that we need to keep moving
on cleaning out so that we can replace it with if not doc/index.rst then
maybe doc/CONTRIBUTE.rst or similar.

--=20
Tom

--bzKSDDSaBaMrbjDw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCal5wGAAKCRAr4qD1Cr/k
CnM3AP9ABEuQpS/EsrsHj2qr4tNAUNz96c5Za4MAVp0op+1Y3wEAlfyuM6trYLnk
eHh6t5TauoV36P442qAGxSKS1k8rFQM=
=BMPm
-----END PGP SIGNATURE-----

--bzKSDDSaBaMrbjDw--
