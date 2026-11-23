Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2E7606A32A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TVbjklF9;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=PEN3/MiW
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 213B1406ED;
	Mon, 23 Nov 2026 14:43:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kdRwE005Gpeo; Mon, 23 Nov 2026 14:43:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 74058406EF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795445001;
	b=BA0XSAADJZ3SKrSw1ZRmmsWo9Jm4A8nju4iM0uxJKz6SkjbfckP1i1kdZV7l8ti9cRvZ
	 cBKI2t/gYRo2Z3gBX//m3V5sUdvJTskOKSbJfmNtkaavQilizFilE7k8hNBAtJfEYZ7vU
	 aW6P/4xbvnheEHrYmRFJVstlDQTBEdgCza2Yee0F3eusFFdIHVuOfoRmjXXo26MQZE8FS
	 faNJjJUzc6zssGUsYJ/On8onGv8KRJ921LIfMXgd8fztcKJDJJ5HdLaIVgFc4lXScA+ga
	 1Moaz1RDNlXfkRgurxtlu3xMR6yduXEdMQqavgpjyrTinjZdk6/x0Cz2SQii9m890mg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795445001;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=x3irKmRZxyQER6zftxGg3LGzthyhu5nDWScyofQ6L7M=;
	b=eqbcTkCnYq8IW/PLLhDWuBCPhE38o4YWNQ+I26tWRZpHiGTePDvXckgZ2A/+IVd4rC+E
	 V9mvoRXReF465YaZvLaBRjFR85Z41y3lwrU9y5dtoLgEW/kr+zbyGIwGjopLOqnNTiBb9
	 dJ0aMkp/9r69jZPuk22XXamYYijU1AbUWuBLdpTCbj58oWd4bWjHx37hmN6W2EWC9JLuU
	 Gvcl9YkpZ9yudx+TLCm7Duxy4O887LpsvrV6uszdU9ZJ4vrrvUVIVWPAtIHYv3l9wzCdQ
	 WZB6HLoPuBmkLwh0zXdrYk9d61Wb2uFtFX12abm/WclYy7t8z0KffirV+v9P2rFzBAw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795445001;
	bh=x3irKmRZxyQER6zftxGg3LGzthyhu5nDWScyofQ6L7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TVbjklF9l/gCwOh0H94/3epuh42cBEcw0pTy9dAUl/A2mTvtN1wX12V87ih9HWEU2
	 nywnNjgbF9AH7MEKGM8wEQF6ZMwpXMjy1yQmb5SgfXqy0wwwA3UVhNxKt63VeTJx0P
	 B8sGdtsaRP0bur4LywNTzP6rwxcq1e7d4Ir19BSod4w4BqjxlU3VzlJHywAt3epudk
	 XzdI4eAa6xWFcXP46D76nMQk7dIXav9Dl6jewrv96hRqOYY5yklDM3A53P2AjpT6T5
	 AJi3Ng6xZgrFHzk4+bFSJlIaYAbf85CjwQc6Hw7+Mwx+uZt0FC1q5cRCULg62rjjHS
	 m7MXXcl7MNTCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74058406EF;
	Mon, 23 Nov 2026 14:43:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AFC61499
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:43:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A170B605E3
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:43:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dCD6a77AkJ5f for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 14:43:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DF25360603
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=PEN3/MiW
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DF25360603
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:43:19 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-84a248254f4so2124539a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 06:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795444998; x=1796049798;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x3irKmRZxyQER6zftxGg3LGzthyhu5nDWScyofQ6L7M=;
 b=PEN3/MiW80J8aC9FXHI4pt0pPSuljIyYgsJ+nS9k4SIhlg7wEl4jU5hAqO3wXp3i+e
 Dnvyt+2+5cMU3qOSZ9zqBKs6QAyXzh9vLSmujcZSuadv0oF5aYJUGqiSHhUHCOw6Cd8p
 35qoLvX1avKhXl8HudW7pBW83lMGvp9sfxFpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795444998; x=1796049798;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x3irKmRZxyQER6zftxGg3LGzthyhu5nDWScyofQ6L7M=;
 b=1QokN1+pyLU4jIeZxeMzHqJ041//JG9bVdX0WD75QPb/NXIkrFJO6bxJS3iwyE+b7j
 hNuak6+MPz4SAqkc0PcI/tfoqoL9TdcizbHMJKMQWWGTKwYlspWWykvVAxkBOYU8RU1a
 tnMHMw67wAfF7e46bEqHUGwLPPaZEp8q9Nhx+zIUYE72Inp6iQ9BTWSDPq5bZWcGqKdy
 Al/AKGfKPnROv2qohf3XdhmPcnRXRG4tUSMWLsWZ3IqGF7E8gLWxmVuYpJX8bpWh9f02
 jfUL9MmwKJyPAgwHbH7+Yfd0dis1GzGMwpM/HbXyNJe9s+BJR/RFD+/1eiqR4BmUldWm
 Qqcw==
X-Gm-Message-State: APuU4Z+2Z0t0Z2/Wu4nB2Ou9Y21zSXDWB1hUTd/shgT9c5MiBS9urEae
 d4gB7DfF5lYLcH6ciUQl/oGKQURqmWnPAkcA5aMyiXr3/EpilntZnisIYdqQWgpB4hUhgUxWImK
 KbiDYOdRKYQ==
X-Gm-Gg: AZFdTZfBggLulUnriPTyoRw180PUU2x09XM8PKrDaOp5OBW50QolHtQ2UdJYB1hgV2L
 ko5t36qGPJpRpdyKUWDVlj/+dqPEGD8F+bGq7o0UjH5QVWS1978giB02w3Q3QX+EM3CaRXVjszr
 I1O5er1JVtYRGBjJ9auWhfR0rWCzevc3gPrKOB/dtruf5y9dYGOIm0124nRSSdTHH4yEKjqRA76
 WWINLOAWp85bdhxbeR9nxKYfuaNpRUSQ1VOoZN39oCwux0jcNHFb90OJ14SOyfDE1JqdOl2eUUQ
 ZNmJ7+uiVvcJXqrkpogGX4pgqWKjAhiY7RhgwZ6QHqaS3hBUKguKvTGb6mxpP+iyjFFvY5Fuqxd
 ZKeXAe8UlJLznvBDJQ1zUiph5shrMaXYIYCP9jiWCzDfROE6dCJ8TUj6IbGRZ6ky0K4dCRUpuzf
 Zko7KMO7pBgQq85SECWGuZiVWDJ8B2GqeToqDu4S/zMrCFriMqTCngFrg43/0udQ20ewxdw5dv5
 LUMDQuFL4SfS5BS2u4nEGjgF1AIZ5C3UtH/YsWZoiqFT+Ql1Q6SxRAQiJiErLnvWms7UMprRCMJ
 W7nZnkJGUvVLrlK1NQF3Fq3cf8VQwQme9cVxo1r8+RE1PKjxc/2pOt2EoN73DHZh8JZmCZ8O5EC
 bAtil08halytrdlOlj2+rDOHcpjixUQ//xq+iu2/sE73HyaM8txeWMxN5fssmxMXD9MQFYx17BR
 iI/L4g5ScGQUDwlQPZpITyVQNEvmbnayjFHC68iBykOp2bLokzdmXy
X-Received: by 2002:a05:6830:440f:b0:862:bbbc:364 with SMTP id
 46e09a7af769-863159f09e0mr11670359a34.25.1795444998424; 
 Mon, 23 Nov 2026 06:43:18 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-863168f3964sm8640842a34.14.2026.11.23.06.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 06:43:17 -0800 (PST)
Date: Mon, 23 Nov 2026 08:43:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Marek Vasut <marex@nabladev.com>, Michal Simek <michal.simek@amd.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v1] Update maintainers and get_maintainer.ignore
Message-ID: <20261123144307.GO3176972@bill-the-cat>
References: <20261123052301.473945-1-hs@nabladev.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YhATOy1f2atr7ZPy"
Content-Disposition: inline
In-Reply-To: <20261123052301.473945-1-hs@nabladev.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--YhATOy1f2atr7ZPy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 06:22:52AM +0100, Heiko Schocher wrote:

> Dinesh has left Altera (Info from Alif Zakuan Yaslami) and
> has not changed yet his email address.
>=20
> Signed-off-by: Heiko Schocher <hs@nabladev.com>
> ---
>=20
>  .get_maintainer.ignore | 1 +
>  MAINTAINERS            | 3 +--
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/.get_maintainer.ignore b/.get_maintainer.ignore
> index 76b816a4d56..ed350dc4d2b 100644
> --- a/.get_maintainer.ignore
> +++ b/.get_maintainer.ignore
> @@ -1,3 +1,4 @@
> +Dinesh <dinesh.maniyam@altera.com>

This isn't what .get_maintainer.ignore is used for. It's for when it's
important to NOT email someone with a valid address, not just avoid a
bounce message.

--=20
Tom

--YhATOy1f2atr7ZPy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawRQ+wAKCRAr4qD1Cr/k
CiUqAP4kebmPtIw3/iC+kjUSOay2OSA89x/ce94MhbbF8u1IpwD/RAThGz7OlW2Q
O+HtNK67qxRAAwvwRya1nW7pAwaCGgs=
=Hnzc
-----END PGP SIGNATURE-----

--YhATOy1f2atr7ZPy--
