Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121AEC87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 12:14:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33EF583C30;
	Thu,  7 Aug 2025 14:14:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pbarker.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=pbarker.dev header.i=@pbarker.dev header.b="W9LFQu2O";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="AJ9G3mPU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76A6684522; Thu,  7 Aug 2025 14:14:14 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C790683BEF
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 14:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pbarker.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=paul@pbarker.dev
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 42C447A00D4;
 Thu,  7 Aug 2025 08:14:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 07 Aug 2025 08:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm1; t=1754568850; x=1754655250; bh=4JwK8A1mv7
 WwqtZZp5K26M4EHGV0PjI+0QftZ4Lyk2c=; b=W9LFQu2OKIj+Nd9EVWMTVC2TWM
 /worzwWL0bdfKlOc+DEWglJfWn4HBf3xeTNkHmQ0KsllflF1uRS6JaB1/d/tJKfk
 RUWeCpTQDorHNZuPvsom/uD4yxpNvzZQMvKigxbJ1Cz6ahYUir0UIquEfgcSmf+T
 wsTtpBC0PSa5Vf5W+GevgMJhpx1aKh5S/LMc++DFJbrOCXALsAl+kbrjWDVhrhUD
 Vewriy0IbBhgoaYPRGGjPBR6sGcyglC6yvHLTj7kFgTE2O/qPD24VXhii5U4zrfC
 fXmBWRPlskIZY8lNd4iErgvAKYpXRHIi5R7EjSRgCIO3d+iV7I5B+FSDQlzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1754568850; x=1754655250; bh=4JwK8A1mv7WwqtZZp5K26M4EHGV0PjI+0Qf
 tZ4Lyk2c=; b=AJ9G3mPUaAGewzTjqV+7lY6NGLMfi2XCfnT0BJHv3ybpbu4S3cS
 uUAwzoMz47pWb0ZxIeUW31X1Mxzx2KnvvXzk+rX3HDYtE2jgwZnrpefAGXerZzPT
 RnA+3/1cvraQs2ra+9JukZXqexh/UbT69XlBILcU1FikafkWVLS6PbeyR5xX2PN5
 I1qlQA5ZprDv57W8vNcl+CssAgEdzIe4XF5gdf7biKCt5Iy1oVMb3Ow70Z9L4g8K
 Ixny57ONnsf+Wmvp7Q+SPj/9bY8Guvjpf1QiovkMSsJxiTBv28sbj6Fdu7zcONFS
 EIAO2tbzCfhOQPFJ0qpIL6rHjfJaSJ2/BKA==
X-ME-Sender: <xms:kZiUaEVngVAXfv9tSNgyo6Bz9uLub1IVlW6jLirQjT5YjaSA5P5kwg>
 <xme:kZiUaEGJjzayCby-rUw-JLhnkugvGwkdCmVY2krLPYOtP-lwctPnJNXu47t9ikz_F
 pCAz6MVdoeuA5R4wXM>
X-ME-Received: <xmr:kZiUaO0A-5u8E1Y8qNa2kYVEQUI53t1OrTTehVJKptH5WqECni4aQ3HiPAXAdaP4e9UhFfo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtledtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepkffuhffvveffjghftggfggesghdtreertderjeenucfhrhhomheprfgruhhluceu
 rghrkhgvrhcuoehprghulhesphgsrghrkhgvrhdruggvvheqnecuggftrfgrthhtvghrnh
 epfeffvdefgeevkeduhfetueehhfeikedvieeufeevieffueektdeluddtgfegveehnecu
 vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphgruhhlse
 hpsggrrhhkvghrrdguvghvpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopegrnhgurhgvfidrghhoohgusghougihsehlihhnrghrohdrohhrgh
 dprhgtphhtthhopehifigrmhgrthhsuhesnhhighgruhhrihdrohhrghdprhgtphhtthho
 pehmrghrvghkrdhvrghsuhhtodhrvghnvghsrghssehmrghilhgsohigrdhorhhgpdhrtg
 hpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepuhdqsgho
 ohhtsehlihhsthhsrdguvghngidruggv
X-ME-Proxy: <xmx:kZiUaOMPRoL2WLn43ebZ2N-0ZJBhZnuitFwkZ1rFngnFERQJDU9isQ>
 <xmx:kZiUaF4PW-1xGnemAR0xEToXe1JOE5nZUbUipa5prcJXLGTY1xo1bA>
 <xmx:kZiUaA1HdeR5hBeWgOWjb5AmpbjPAoVj52P9JsLeVRz966ZTyNgcvw>
 <xmx:kZiUaOwvMmHNiAkT3dXf4Phqn1r68nEKwUhFPtkPCSi9LA7zNOrosg>
 <xmx:kpiUaPBjVEFXRYMsf-fVEW2UILxXPKaD637tLW7F0DQB84mjCBxvd--P>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 08:14:07 -0400 (EDT)
Message-ID: <e5d3792ba757b955f30a1a99b0628d8894b7befc.camel@pbarker.dev>
Subject: Re: [PATCH] pinctrl: rzg2l: Variable may not have been assigned to
From: Paul Barker <paul@pbarker.dev>
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Nobuhiro Iwamatsu	
 <iwamatsu@nigauri.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom
 Rini	 <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Date: Thu, 07 Aug 2025 13:13:58 +0100
In-Reply-To: <20250807-pinctrl_renesas-v1-1-055ace62c1dc@linaro.org>
References: <20250807-pinctrl_renesas-v1-1-055ace62c1dc@linaro.org>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 ep0k17xg==
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-TDtMQQB5LnsKNMhYcFhW"
User-Agent: Evolution 3.56.1-1 
MIME-Version: 1.0
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


--=-TDtMQQB5LnsKNMhYcFhW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-08-07 at 12:30 +0100, Andrew Goodbody wrote:
> In rzg2l_pinconf_set and rzg2l_get_pin_muxing if the call to
> rzg2l_selector_decode fails then the variable pin may not have been
> assigned to. Remove the use of pin from the error message.
>=20
> This issue was found by Smatch.
>=20
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/pinctrl/renesas/rzg2l-pfc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pinctrl/renesas/rzg2l-pfc.c b/drivers/pinctrl/renesa=
s/rzg2l-pfc.c
> index 3c751e9473a..3bdba5e365c 100644
> --- a/drivers/pinctrl/renesas/rzg2l-pfc.c
> +++ b/drivers/pinctrl/renesas/rzg2l-pfc.c
> @@ -353,7 +353,7 @@ static int rzg2l_pinconf_set(struct udevice *dev, uns=
igned int pin_selector,
>  		/* The pin selector refers to a multiplexed pin */
>  		int port =3D rzg2l_selector_decode(data, pin_selector, &pin);
>  		if (port < 0) {
> -			dev_err(dev, "Invalid pin selector %u:%u\n", port, pin);
> +			dev_err(dev, "Invalid pin selector %u\n", port);

Thanks for catching this and sending a patch!

The proposed change is actually still invalid - port is a signed value so %=
u is
wrong, and port will just be a negative error number here.

What I should have done is printed the invalid selector, which is an unsign=
ed
int:

    dev_err(dev, "Invalid pin selector %u\n", pin_selector);

>  			return port;
>  		}
> =20
> @@ -550,7 +550,7 @@ static int rzg2l_get_pin_muxing(struct udevice *dev, =
unsigned int selector,
> =20
>  	port =3D rzg2l_selector_decode(data, selector, &pin);
>  	if (port < 0) {
> -		dev_err(dev, "Invalid pin selector %u:%u\n", port, pin);
> +		dev_err(dev, "Invalid pin selector %u\n", port);

Ditto here:

    dev_err(dev, "Invalid pin selector %u\n", selector);

Do you want to send a v2?

Thanks,

--=20
Paul Barker

--=-TDtMQQB5LnsKNMhYcFhW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaJSYhhEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bqHmAQDACtZNSt04MVH/qCdKmshIiUiW+PldGbHI
xlo5Nc/AXgD+NylBQz0XDZj7JdwHeWA1UBT0py4LkwLCnSq7Mltf4QA=
=qPca
-----END PGP SIGNATURE-----

--=-TDtMQQB5LnsKNMhYcFhW--
