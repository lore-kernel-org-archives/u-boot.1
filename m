Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41906C10F1A
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 13:57:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABBCA886AA;
	Wed,  1 May 2024 15:57:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="sQcjXm1j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD1C488690; Wed,  1 May 2024 15:57:03 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0BF288AB4
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 15:57:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martyn.welch@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1714571821;
 bh=BYUVM+K0YLE6Ug066Y1RaK6O1yic504eC3rkbIP/w6Q=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=sQcjXm1j4QJSgqs7gH8sJwXdcyRddbMAkPuvlsaVRmc8wyYldCJMMQOJ5mPX0cZSy
 S1ANgSQTepuVzECj2G1Bma6ASiazdd1ZMhzHehfC8W9tfWSSd7A+dvl57RQne6KNTy
 r/jO/6d+8KEpDut7s+q4WlUwZ7S0du4EdwmdE6M5aizSwkHkCQundmlmDURRcvRw34
 0fZ2nZ6BlJmjVZ7rBJ9wGCb7SadRVv2Rq43mNeW1dsYOB/WjLw2th057JX5BSNvfgf
 EbkFSh4jIimNfXitYbAC9DydIJj35YxOugs4A4x64OeWMqYgGns/kgjwRTkvt/juCZ
 sTpQNZzJdCBMQ==
Received: from [100.117.211.133]
 (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: martyn)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id B40AB378205D;
 Wed,  1 May 2024 13:57:00 +0000 (UTC)
Message-ID: <4fe368c01c937e93d7f634ffd7c02d99964d1f57.camel@collabora.com>
Subject: Re: [PATCH v4 1/7] usb: dwc3: Add dwc3 glue driver for am62
From: Martyn Welch <martyn.welch@collabora.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Sjoerd Simons
 <sjoerd@collabora.com>, u-boot@lists.denx.de
Cc: Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>, Kunihiko
 Hayashi <hayashi.kunihiko@socionext.com>, Marek Vasut <marex@denx.de>
Date: Wed, 01 May 2024 14:56:44 +0100
In-Reply-To: <87ply14lxq.fsf@baylibre.com>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
 <20240112085317.1866449-2-sjoerd@collabora.com>
 <87ply14lxq.fsf@baylibre.com>
Autocrypt: addr=martyn.welch@collabora.com; prefer-encrypt=mutual;
 keydata=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
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
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

On Tue, 2024-01-16 at 11:22 +0100, Mattijs Korpershoek wrote:
> > +	/* Program PHY PLL refclk by reading syscon property */
> > +	ret =3D regmap_update_bits(syscon, args.args[0],
> > PHY_PLL_REFCLK_MASK, rate_code);
> > +	if (ret) {
>=20
> The doc of ofnode_parse_phandle_with_args() states that:
>=20
> =C2=A0* Caller is responsible to call of_node_put() on the returned
> out_args->np
> =C2=A0* pointer.
>=20
> Should we call of_node_put(args->np); before returning here?
>=20

It doesn't seem that this is done in U-Boot as the definition of
of_node_put() here is:

   /* Dummy functions to mirror Linux. These are not used in U-Boot */
   #define of_node_get(x) (x)
   static inline void of_node_put(const struct device_node *np) { }

Martyn

> Should the cleanup be done in case of success as well?
>=20
> With that fixed:
>=20
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>=20

