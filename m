Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3452C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 18:16:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 393D987759;
	Mon, 27 Nov 2023 19:16:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l+6KpYaO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EDA18772C; Mon, 27 Nov 2023 19:16:14 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 097EF8761B
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 19:16:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-db40b699d2bso4037026276.1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 10:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701108970; x=1701713770; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WMng9guuZTG0JFuDOb44+6PlvI14ajUDnrADO26BME0=;
 b=l+6KpYaOBM562m+ucGdQVklqWwBKbMzxVhoGxPd10z2GuesAnAsK9W0WakiGGyZE6T
 LJ1KL4jSOmDwPoY5j5yn0ENoD/e1oYXiomv8AgGpCBNyKJ9HSuTEBWoZrZSvBI6DdaDc
 EVSVCAG8MkAiXRoBvtfbVIbsc4dAHVOmvn2Vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701108970; x=1701713770;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WMng9guuZTG0JFuDOb44+6PlvI14ajUDnrADO26BME0=;
 b=rVH7MQGVTGwgJOBJpOOSIK17QdmIwvG9A4qB0tzYbO5QWNayMePgglkp0uYVN+LFRg
 yJM5IpqJEb94w/gzEN2kMDTJWO1Ocd00JwguK/vdFmEhkc1oqyRGb/4ZieTMj9K0+IRY
 meDagTUzPv72cq7JeHGaq0TPxAh0qldba8IMLVeGpEqDR6+OLqTNLTNihsNoG7T7+581
 kIRXlN10NL4fPdktpMcs1eAs0JEK+pQ7xEPanP32Y1ASQZda/YyZTFIsk+8k/QndNKCi
 RwjVemYVSyd0fqUCXJbyneQVaseJl0vDS2a3znxSCdbk9ZmRphNhWunxCekiUtWsIfL3
 d86g==
X-Gm-Message-State: AOJu0YzelT4uS5yTssHBF+6zixT5TsCnihKV7cIRBGN3ncv4XzpiLCDS
 uk7//kwyTaprC1EmxPOHiH1OBA==
X-Google-Smtp-Source: AGHT+IFHZ0rgRheWAoJdLHsiLu63ZAuquGdZhBuqkWe7duk2RLVur82BtjmyubTWxkEiE2bXBn1iCw==
X-Received: by 2002:a25:9703:0:b0:da3:ab41:31f3 with SMTP id
 d3-20020a259703000000b00da3ab4131f3mr11439746ybo.8.1701108969564; 
 Mon, 27 Nov 2023 10:16:09 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-add3-c5a6-8002-bb49.res6.spectrum.com.
 [2603:6081:7b00:6400:add3:c5a6:8002:bb49])
 by smtp.gmail.com with ESMTPSA id
 y10-20020a25320a000000b00d9ca7c2c8e2sm3213263yby.11.2023.11.27.10.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 10:16:09 -0800 (PST)
Date: Mon, 27 Nov 2023 13:16:07 -0500
From: Tom Rini <trini@konsulko.com>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 goldsimon@gmx.de
Subject: Re: [PATHv11 01/43] submodule: add lwIP as git submodule
Message-ID: <20231127181607.GL2513409@bill-the-cat>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-2-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lhWGOhp45NyzL1qL"
Content-Disposition: inline
In-Reply-To: <20231127125726.3735-2-maxim.uvarov@linaro.org>
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


--lhWGOhp45NyzL1qL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 06:56:44PM +0600, Maxim Uvarov wrote:

> add external lwIP library as a git submodule.
> Use STABLE-2_2_0_RELEASE tag.
>=20
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>

And just for the record, we'll re-visit submodule/subtree/whatever later
on, this (and the final parts for CI to be happy about it) are a means
to an end.

--=20
Tom

--lhWGOhp45NyzL1qL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVk3OcACgkQFHw5/5Y0
tyxtawv/cCj8G5Js3gJzK8FXgL3wvNaSdpf2aIfUTg+AhAKanY5LVl+Ri0xVfsdf
4rFlaVoJC/ycX0FDwFw+147plJLgYiGqSfTNQROp9Y/btFEmI286J0iqFd5O7wdi
qKbs+6uCa2vhHZilgGW/EhmmIwASFyUGQ1ze7kudAtHVl7OSluEnYr7xGBLmDig8
rNEmZVj2KTTgSchN/eTBkKxoEe4Va7yt17LFAPSuPT6CFJ8QlnOYNdx2NIs2NTBB
tI4+OPzxfetxoCVNhhaZyJXTT3d9SdDwKba+9XwxoQllVGYuVXW8/9MSMTHZrNTl
5Gol0VnIlafBucrPxxhlJD9ct5UNPbFohqL0zO77mww69FKsXw+hNPxguetyuHFo
+hZCMRY5mdL8fkOZwxJuLWaNmzONoXdfH9kpztanpbYlsKFxe7sVDlUHKAd035z0
OsdT95FJnzY1aBHQoz5IEcTu7XN9tEo7PqMyf1TFlyL6D8DY2tacaSngC+ZfFaA1
RHfcRhm4
=QgOM
-----END PGP SIGNATURE-----

--lhWGOhp45NyzL1qL--
