Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DDCC54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 12:29:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C73182E17;
	Mon, 26 May 2025 14:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pbarker.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=pbarker.dev header.i=@pbarker.dev header.b="OVwdjpSk";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="gApeoto2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C165782B27; Mon, 26 May 2025 12:51:43 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A07782B18
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 12:51:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pbarker.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=paul@pbarker.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal
 [10.202.2.48])
 by mailfhigh.stl.internal (Postfix) with ESMTP id DB7292540154;
 Mon, 26 May 2025 06:51:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-08.internal (MEProxy); Mon, 26 May 2025 06:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1748256699; x=1748343099; bh=5bTkepQ2AI
 9lLF9gS2B4KxVhKOjXlhciXP5ehC7a9OE=; b=OVwdjpSkOLBw8mXH9+knfkNxw1
 hXhsnlqWZT6LwCNBq8uFznIpLrqp0+SHBkoEBAghI9sWg0PU4y94D4za9bwHMIKe
 1ip5O48uU7Yaby1tNjIZ56iX/LgwTXjNK0dD2UxSC+3xCzvydW9g4cSlYZLNP9rT
 zisXh2XPrAxHUsceYk6HuMhToi5SNWWZHYkyuLShON05zvWu9REyfhfV47AyXq3x
 HYcjb2bjSW13RWJK2LOx26eoM2agD3mXAmWpPBoUa6eBCjeDnLcTn6ieNt5TcMnO
 YtnRbtvi+RcxkPRWY+SD8vppHg241m35mPErd6TwUDUpqBQSJt4GvOQor+EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1748256699; x=1748343099; bh=5bTkepQ2AI9lLF9gS2B4KxVhKOjXlhciXP5
 ehC7a9OE=; b=gApeoto2jM5aRQmdn58nfd38UEk2q7vL7Rz/VmXmVkbFCmcptjV
 xUidb3UPv21LEUYKWwluVmrtcj8cqKOwbPdMMmq3rjWhYeZzzPOI55274S//hDXI
 YZYFuH7y6IJB2gJiGhIAoMXVZUfjImFX2W60BqCwnqPNnnYI5JfckkvkMJT5WWbY
 gXZYADUE5rKJHFsTtDQhus2jNM3yW65HHM6BYmi/LUkQ86IM3F9N4NTU8Zz1+r//
 YWzhBBfmDtR3STfvg4CsGMZQH7fnuPt+FFsSaggX0u9dhNsC+vVhLK1xWgu4xFU4
 IRMRsJ5YVR0ubGaj6nOSAqVq62whSIuSrkg==
X-ME-Sender: <xms:u0c0aM0_1kQdnodsc_l1JoK11fnuH9bGsbJgGJTyrOPFZLbvugKHfQ>
 <xme:u0c0aHF0fasoJ6jWzubX8gWT_xbmyZS8_UWGXZtNWL8QyYgS1p4e7fs-K8AOp632x
 Ma_MxO1AS5s-xnk8Js>
X-ME-Received: <xmr:u0c0aE5ylAiG1OOjyOI8TNSbia1ya_rYgRklLn0vbBqVRHhBIE2-I3aMUQe_10FNd8cWDFEuKk8ICsm4r8c59mD_6XYRrEz8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddujeeffeculddtuddrgeefvddrtd
 dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
 fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
 dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgj
 fhgtfgggsehgtderredtreejnecuhfhrohhmpefrrghulhcuuegrrhhkvghruceophgruh
 hlsehpsggrrhhkvghrrdguvghvqeenucggtffrrghtthgvrhhnpeefffdvfeegveekudfh
 teeuhefhieekvdeiueefveeiffeukedtledutdfggeevheenucevlhhushhtvghrufhiii
 gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghulhesphgsrghrkhgvrhdruggv
 vhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmh
 grrhgvkhdrvhgrshhuthdorhgvnhgvshgrshesmhgrihhlsghogidrohhrghdprhgtphht
 thhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdprhgtphhtthhopehifigrmh
 grthhsuhesnhhighgruhhrihdrohhrghdprhgtphhtthhopehtrhhinhhisehkohhnshhu
 lhhkohdrtghomh
X-ME-Proxy: <xmx:u0c0aF0rsk5GDkS7ng44Z5cxVvhRd-K0Q06dHeRyn8ip6jOSO-0qXg>
 <xmx:u0c0aPHI0XDGLaoaAG4h9yHT1Q_cSraSnCwFgRg7MN9wDGJt6Gx3uw>
 <xmx:u0c0aO-w7UDWxDmEPK7RMQ_WnAy_cQA3Jmu-SCeW85WCuHgghTenRA>
 <xmx:u0c0aEmhHAMcOgNOPni-TJNw63vghtjiT_dIjDTkJQfGtwJsgRerVA>
 <xmx:u0c0aJdtoMSZpI5oqSYx45nHdsKY9aczSGMRxkjKBOAs_OgOafEjI7Eg>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 May 2025 06:51:38 -0400 (EDT)
Message-ID: <ab6febb52fa8d5599774d76cd185a824d3ebf19f.camel@pbarker.dev>
Subject: Re: [PATCH] board: rzg2l: Update MAINTAINERS file
From: Paul Barker <paul@pbarker.dev>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Date: Mon, 26 May 2025 11:51:36 +0100
In-Reply-To: <20250525134301.35091-1-marek.vasut+renesas@mailbox.org>
References: <20250525134301.35091-1-marek.vasut+renesas@mailbox.org>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 ep0k17xg==
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-NSnePzJWH3IqG3+cWLFi"
User-Agent: Evolution 3.56.1-1 
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 26 May 2025 14:29:36 +0200
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


--=-NSnePzJWH3IqG3+cWLFi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2025-05-25 at 15:42 +0200, Marek Vasut wrote:
> Un-orphan the RZ/G2L , keep the RZ/G2L maintained.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Paul Barker <paul@pbarker.dev>

--=20
Paul Barker

--=-NSnePzJWH3IqG3+cWLFi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaDRHuBEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bgc+AQDpCo1IG1LNWAUaK52e5L0uWwT9mFEiUDrk
EfV63c9DPAD+I4KfH4FJtyZH7QSFM66hMixM7nLimya1SLWQpx61EwY=
=ryGi
-----END PGP SIGNATURE-----

--=-NSnePzJWH3IqG3+cWLFi--
