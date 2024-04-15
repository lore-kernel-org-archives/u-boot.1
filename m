Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFB3C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 08:15:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65D0D8799C;
	Mon, 15 Apr 2024 10:15:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=walle.cc header.i=@walle.cc header.b="i55jhS50";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D6E2879AF; Mon, 15 Apr 2024 10:15:08 +0200 (CEST)
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC8D387916
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 10:15:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=michael@walle.cc
Received: from localhost (unknown [213.135.10.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by mail.3ffe.de (Postfix) with ESMTPSA id EFFE38FA;
 Mon, 15 Apr 2024 10:15:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2022082101; t=1713168905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=CLD8MC1FqTXlzQ8G8Yg+g0aufraWDXCQY57rqs126VI=;
 b=i55jhS50QwxabAGxFFaVoehzhw7tO58gBPWfGMRLmqbDBphcvSUaCJOGS//36Irit21E0C
 AiU5TzH9MmVNvmNHX20Uz7xowRXjE5hmGFtWJ05Vs546hsIA7/rwDFeNO10k3ed8ltxUkS
 maRS5DZMy6q2x0pejtAr+E+U7zoPGMm2w2LEvafy5MpkL6EwxRlnlc+pq1Go54cMtC0XBQ
 FA6mV3pNelQ86VM52lnIj40QEg4ZNU1OU3pyR55O1fgK2/YQjyKvjhuW5swPUCWg5p9dEB
 Eq+chU6/yhte1Y57ysjIJOf65ytaCHjBmsLq64d6n4FrL1fevBaNt6Uozys+fg==
Content-Type: multipart/signed;
 boundary=ba24822c8a90cb8264c9a89a344f3f8cc15865ed1a93bef11ea70405380d;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 15 Apr 2024 10:14:56 +0200
Message-Id: <D0KJOU4QE6JZ.3CBVKKJQT71U4@walle.cc>
Cc: <u-boot@lists.denx.de>
From: "Michael Walle" <michael@walle.cc>
To: "Michael Walle" <michael@walle.cc>, "Priyanka Jain"
 <priyanka.jain@nxp.com>, "Tom Rini" <trini@konsulko.com>
Subject: Re: [PATCH] board: sl28: move to OF_UPSTREAM
X-Mailer: aerc 0.16.0
References: <20240306161911.1598529-1-michael@walle.cc>
In-Reply-To: <20240306161911.1598529-1-michael@walle.cc>
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

--ba24822c8a90cb8264c9a89a344f3f8cc15865ed1a93bef11ea70405380d
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Mar 6, 2024 at 5:19 PM CET, Michael Walle wrote:
> Use the new device devicetree files in dts/upstream/ and delete the old
> ones. Still keep the -u-boot.dtsi with all u-boot specifics around.
>
> There is one catch and that is fsl-ls1028a-kontron-sl28-var3.dts which
> is not available upstream (yet!). For now, the base dts is used for this
> variant as this only differ in the compatible and the (human readable)
> model name.
>
> Signed-off-by: Michael Walle <michael@walle.cc>

Ping. Any news here?

-michael

--ba24822c8a90cb8264c9a89a344f3f8cc15865ed1a93bef11ea70405380d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKcEABMJAC8WIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZhziAhEcbWljaGFlbEB3
YWxsZS5jYwAKCRASJzzuPgIf+PUYAYDNFq8hkcjd2x3Ufk7THGoq6BZ0YyRWBnbG
WqGDvPJ4Ub5d3vVXs7WtuYSUUYi9J0MBgM9qsShze/zVXlIIxO9sk0IkGVI8wCgJ
WC2hnxTOEE1W3sOFl9mLlrKDTQoX3YZ1YQ==
=2Dm5
-----END PGP SIGNATURE-----

--ba24822c8a90cb8264c9a89a344f3f8cc15865ed1a93bef11ea70405380d--
