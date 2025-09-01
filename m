Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCACCA0FF0
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 19:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 367B683A13;
	Mon,  1 Sep 2025 21:15:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pbarker.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=pbarker.dev header.i=@pbarker.dev header.b="h9+1DRkC";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="BVvNUWLc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 304C383A1A; Mon,  1 Sep 2025 21:15:43 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C16583990
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 21:15:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pbarker.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=paul@pbarker.dev
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id B8C97EC064F;
 Mon,  1 Sep 2025 15:15:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Mon, 01 Sep 2025 15:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1756754139; x=1756840539; bh=3qsQBXcxoQ
 uQ1VEUKeWi3OUOWUuEHtuHKM0jITt8xz8=; b=h9+1DRkCNSdD5tqUZ4USZGgVnD
 Hr8NhQ5rp3908okkv7BGM5dC91E2wbH7fvNDUSSG0pZtoWMP0ILYG7QfAiWYKbmp
 jaMWESF+4mOB0Bb8yDG1mmP34g8aipdxo12jQx+fR/tKG+SAzI9DhBgtCJKXWcT5
 H3CA69WCmBwrXqareRXrUlKobVusSJ67O8s7lQohmmpD5xI0FzlU51zF/W7+cUiw
 fdl+I+NF3wtuOtf8WsiFX855AGWeqOmEcjd3qD5rYueQLpllVy2wtQ9/8BrSG55W
 u2jYtR1+a4cYCLc44l/zjTtXmLCYuRtIaIAn4TtgoN8DGmDRJ5sh+dR7OY/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1756754139; x=1756840539; bh=3qsQBXcxoQuQ1VEUKeWi3OUOWUuEHtuHKM0
 jITt8xz8=; b=BVvNUWLc7fuZJh4cgMSALtpZThCP86eWELMg3sCdpt3U3pKjmIW
 XWvwZOzkLOqkTz9nUo/0hFowoNQ5+xvUlC0JViiCDMCMv+GfRfZKjGxRD3NbyMA2
 9EZFqRz0/b5CAj5TdUa/3PHrPPvXCyyJIdITuCX9FgbgYQJfvOtzA0q77kAaPYXe
 GjyOHyBbfy3gDeu600U7XsFu8cdNxw/hwwdG5w5S98tcQUfqBXs1swG0f9pHSNVX
 y8D8ImLLiyqaowNyHnOExonkS0yc6yhUAnAIAegLsTT4N2+1ynB7bAKpQ+xJM7Nj
 u9mvpjk+EdzcIp4PgekH3somwmFW11G+qYA==
X-ME-Sender: <xms:2vC1aCnSdctPFVXW_pHov14PZEmXsYaB6PGVDXDu-4Z-l6cMcxWJVg>
 <xme:2vC1aFXk2WrYmWITpoJ4sHMvzL0MGlmYyBpUOg5heZUSCdKh5bwzxCYqhdIg7Twbh
 -8aqOc01-jYog8qntU>
X-ME-Received: <xmr:2vC1aHHA5_uj-AJGo9Ouk33rfcdSuzCPcsIdJqvM-H1geCGrqCj0HUSuajFnU2Cf1s4At1-Jwt9yJSwc0NjbbYyq0bf6Iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduledvleejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:2_C1aBcz1BPd11Dt4Rk-bCWxuy6Xb9OyIO6sA_gb9vcItFNHJ0zXJg>
 <xmx:2_C1aILEcCZHxBZpQWFXCBf0RF15seykx1DKqSLZlZrS3qNeOApX1w>
 <xmx:2_C1aGG_oejVnk5GY-XS_fLGhjmDjNUlaefKRyXl1CyvWO-STpye7g>
 <xmx:2_C1aLDjrOHdKYrjq5T0QH0fMvvlEJDEyDIk-D6_nrWthe5B_4T3fw>
 <xmx:2_C1aKTi1Bf4hBjvHV2rKdcC8LFtfEknQvEzcI7UL49YA3opTr1fd9X->
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Sep 2025 15:15:38 -0400 (EDT)
Message-ID: <ecde7d398f0ff89cc8fb20a7e3473afe38f215bd.camel@pbarker.dev>
Subject: Re: [PATCH v2] pinctrl: rzg2l: Variable may not have been assigned to
From: Paul Barker <paul@pbarker.dev>
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Nobuhiro Iwamatsu	
 <iwamatsu@nigauri.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom
 Rini	 <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Date: Mon, 01 Sep 2025 20:15:28 +0100
In-Reply-To: <20250807-pinctrl_renesas-v2-1-5453d989573e@linaro.org>
References: <20250807-pinctrl_renesas-v2-1-5453d989573e@linaro.org>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 ep0k17xg==
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-NI8Mpki8B33E9t0HSYU3"
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


--=-NI8Mpki8B33E9t0HSYU3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-08-07 at 15:41 +0100, Andrew Goodbody wrote:
> In rzg2l_pinconf_set and rzg2l_get_pin_muxing if the call to
> rzg2l_selector_decode fails then the variable pin may not have been
> assigned to. Remove the use of pin from the error message. Also update
> the error message to show the invalid selector used instead of port
> which will be the error code returned.
>=20
> This issue was found by Smatch.
>=20
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

This fell off my radar, sorry!

Reviewed-by: Paul Barker <paul@pbarker.dev>

--=20
Paul Barker

--=-NI8Mpki8B33E9t0HSYU3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaLXw0BEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0boOCAQD0xdDnpp6bWgj8ysRruHDYU3vbkCSfct39
GqP6udVQJAEAhwSPi57IHKU56NxlNRp4OTgURMSwM2jQQpX0trZe3wI=
=O/mZ
-----END PGP SIGNATURE-----

--=-NI8Mpki8B33E9t0HSYU3--
