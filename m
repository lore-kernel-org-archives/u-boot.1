Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF7B0C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 07:48:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 350E684C85;
	Thu,  2 Jul 2026 09:48:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="KXYSdP6j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B67E84CAD; Thu,  2 Jul 2026 09:48:12 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F60C84B88
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 09:48:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=romain.gantois@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id F191FC4FED2;
 Thu,  2 Jul 2026 07:48:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A89AD5FF03;
 Thu,  2 Jul 2026 07:48:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2EE5A104C8351; 
 Thu,  2 Jul 2026 09:47:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782978488; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=fTsDaPlvXf5N5IWOdvqa+m6UTJ4a+nAfLJIQnStB5TM=;
 b=KXYSdP6jvWZPduKAWeSGsEvs4DemFpraR9PpSBoivmFLzbfxBmcKf/enb9XPdNu2I086lH
 TMv0UGgVubVOWpK+lWNPc04tmBGuSIMlB1FcDcOAEpCCAofxkHdOqwIFGc5//Vp/boi1XD
 /VfHCmQe9+ldC343nhjWL7WNoRtbakU6hw0dD9jOyf6TyocxYDlVlUkgsLfZJi4Jeyi6yS
 dkqQhxZh8QGAzRVNgJWwJKwYCf43dhJ/CGNpNZIh2UVERcfl77PUz62Dp1a5iQEoWb2cL8
 hZvkBrznP8I4D9T0qBicd1LFJr3IxDDnEM6adqtqxoykoGn3C/OdcG1AZ3Zhkg==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan <jstephan@baylibre.com>
Subject: Re: [PATCH 1/2] linux/list.h: Add list_is_first()
Date: Thu, 02 Jul 2026 09:47:53 +0200
Message-ID: <TDII8JhEQ_G9JY8zPJCZaA@bootlin.com>
In-Reply-To: <CAFLszTizFJ=fNewsWA56_rpcNSZXkcMuP1z6jiXmd4mMS0YeWw@mail.gmail.com>
References: <20260625-rzn1-usbf-v1-0-0e1a38f7b82c@bootlin.com>
 <20260625-rzn1-usbf-v1-1-0e1a38f7b82c@bootlin.com>
 <CAFLszTizFJ=fNewsWA56_rpcNSZXkcMuP1z6jiXmd4mMS0YeWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPartw08FzNjLQz2Fj34MZ9OiQw";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3
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

--nextPartw08FzNjLQz2Fj34MZ9OiQw
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/2] linux/list.h: Add list_is_first()
Date: Thu, 02 Jul 2026 09:47:53 +0200
Message-ID: <TDII8JhEQ_G9JY8zPJCZaA@bootlin.com>
In-Reply-To:  <CAFLszTizFJ=fNewsWA56_rpcNSZXkcMuP1z6jiXmd4mMS0YeWw@mail.gmail.com>
MIME-Version: 1.0

Hello Simon,

On Thursday, 25 June 2026 18:25:44 CEST Simon Glass wrote:
> On 2026-06-25T09:05:24, Romain Gantois <romain.gantois@bootlin.com> wrote:
> > linux/list.h: Add list_is_first()
> > 
> > Include the list_is_first() kernel function, which will be used by the
> > Renesas USBF driver.
> > 
> > Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> > Reviewed-by: Herve Codina <herve.codina@bootlin.com>
> > 
> > include/linux/list.h | 10 ++++++++++
> > 
> >  1 file changed, 10 insertions(+)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> (I don't suppose Linux has any tests for lists that we could copy?)

I don't think so, at least I didn't find any.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPartw08FzNjLQz2Fj34MZ9OiQw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmpGF6kACgkQKCYAIARz
eA4hJw//fPehjAUgWNNlKN3Zy1vHbVMePYCxXLBEKrMUhq+QaYICJAriYKpL7JU/
Ln5S9MsHiOROCoxtf7ke+Op6Qkeb0zKlEmhCfnUSfE6ByN1DzAptBWGf1JlDuFfF
jQEh4e9FkUeor+YLUcYiq2E7TnGsPYxwQj970AKF2qMPPfNBVcwRKBPWgc0kSrTb
uYwwNqe+eOrLFmDXzy3rxs2wlySMnXRpBuuloCFqwEIhdBrYaFOIpmihhb9ajZRv
uG3HY2rjTcR59TOilzoO4hlze4QuwQZodwA6srcnuyYwbqKEBpHkB3IzbiBrO3Iv
6EXP/cVOWz51rEPruaO+ZwkhpTIsJlTFX3l515JZxn+09iB1jk1fo9a0+WwDrImH
KtKvRRDPunB8GerS1kDadKAK9FRY7miBVGFk9/JoENWrFNuOcgS5/+cPPWxU3E3o
8PyCUCxnVFcMaz9Do60Cpkcv/m2TE56EqpZdF/WQqcnAzUgAxyICDsVRlV8Xmv4U
oW6A9ECkVezSoaD+yTySk1Pp/KFFpawAfRFIWoGY+Hxo9GF9jg7ivqZMXcTsHUUF
p57l8Y9/ga+dA1ZZjzyijrtOk433yWc6MSxGicotHk315Mu1oeJ7MHvjrZZGjOtb
F+55yfS1PtoTOsPlViadYQAZ/ufQhFNTRVv8XQW+h61sjRgA4YM=
=4Rdl
-----END PGP SIGNATURE-----

--nextPartw08FzNjLQz2Fj34MZ9OiQw--



