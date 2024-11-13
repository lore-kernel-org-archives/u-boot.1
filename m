Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A52D462AA
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 14:24:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F7F588C0F;
	Wed, 13 Nov 2024 15:24:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YVLRLK7Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 826D68862E; Wed, 13 Nov 2024 15:24:45 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B37B894D1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 15:24:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7b1601e853eso447363085a.2
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 06:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731507881; x=1732112681; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/4O1Vu4CZjltl6UdIRxfcN1jj2NumeDzyraMh689xSM=;
 b=YVLRLK7YDTiwyI1qcgYqPjDNXNn8OBBEWpd2oPZaWV2OP9VpSbCIegKVZWoMV/D2lq
 AKAiuZyfcFWQqYksFT1RfbH7kx689FklpAdbR3HRXPtNh10mjubVXNxPeLaGN1uu93Fm
 Ee53wOv4O/L/9pa1jnbcq5bc6uxOqSaZdZ/Oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731507881; x=1732112681;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/4O1Vu4CZjltl6UdIRxfcN1jj2NumeDzyraMh689xSM=;
 b=DZzC3auXMmD8MLe89d75zqRN67OPZj8QgxqyBoJSgUlTCjNyAIR0GdCGyEDzjEB/WG
 VAnDxdHJYQt7y3ZB0m0klQwbQV0z+ybT92UudsxVZVd6EB5DNJ672e/PwSVVssMWYr0A
 IZUzdAzAyDsHPEwiKeyjtHKY6eywjwXKCBd8gae+UdjyVT/R6T2YJ7KT2NDeH60usX5/
 /ANtrjrrXKpSY5jp3/4ShBdmWo6+RVmqRzP75qJdUBYy5Mo9mDloJjBysI/2pc92Kxzm
 LEW8sHqS7gPcO7nLWe4WL4L59DaW8XhtLQeZJJ2nDpXDIS814ElW5++eh/I5HmYyJPnu
 l6sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU20K+2p8U/zNWXc41ZnF+9J/oD6jL8gaVXcVHOo/P7oz07Nk65SX3hI/d7lOOS2XJqiX9GRDw=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4XyxHDAhsCONoTEHNQMfnjYXdezH06imORjt4DEn+Ma3yOFuB
 EAwAtFLPU4rkom5Wzf3X/Hn6XXSTnlUHCqo6nJF7IwidTXo8qFwb6IAxJvfNqEQ=
X-Google-Smtp-Source: AGHT+IG767smkf75gObQjQGRwyzINtVUKjWjYnsKSw0b7rM7uQJT3ZeVhlGfPthVlgOFLOr7T9Jk1A==
X-Received: by 2002:a05:620a:25cc:b0:7ae:5c50:37ab with SMTP id
 af79cd13be357-7b331f210b3mr3099850185a.49.1731507881207; 
 Wed, 13 Nov 2024 06:24:41 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b32ac2e180sm693989685a.23.2024.11.13.06.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 06:24:40 -0800 (PST)
Date: Wed, 13 Nov 2024 08:24:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] mmc: don't print 'MMC:' if there are no MMC devices
Message-ID: <20241113142437.GM3600562@bill-the-cat>
References: <20241113053023.1870736-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7aWVmqvkfCiWXO7m"
Content-Disposition: inline
In-Reply-To: <20241113053023.1870736-1-caleb.connolly@linaro.org>
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


--7aWVmqvkfCiWXO7m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 06:30:08AM +0100, Caleb Connolly wrote:

> It may be the case that MMC support is enabled even though the board
> we're booting on doesn't have any MMC devices. Move the print over to
> the print_mmc_devices() function where we can only print it if we
> actually have MMC devices.
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

I'm not sure I like this. What we do / don't find on startup is part of
the not-exactly-API. It's true that if we don't print an MMC line at
all, and we should have MMC, the user (and any scripts that parse
console output) but now we're also increasing the code size a little bit
too. I can be convinced this is a good idea, but I'm not there yet.

--=20
Tom

--7aWVmqvkfCiWXO7m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc0tqEACgkQFHw5/5Y0
tyxvVgv9FVWadsmMGilIAm+KR5GGt6L9+OCzXAsjyCHsajNGC4qfyJx7Ry637IhM
bYQybEa26bcCfOrrWYQpPPvnRA+f9XxtyN9PDLZtNhC/doPTwoCn6lVQrmbrFU0B
LqsgTJEpR1NtVqRlgaAD+UxSIXhfaQ2j2hm/xV3UAcWQh0zZVxQGUHH+g1oyOJRS
Mw0W0h59zuvuq2gM5FyQivz3u6173/n7+vle9EZ23OrpE1WCCE8eyMHXbcP6Y22O
B+U5IoB1lvpTZX90pL57Wjn8fGN043BPwgOlFRbemI4T0Bz8xE6gycQz2aVtgZXe
HDZgXh5/KpPgC2tc5SHBYIbPXn3rQ/GaWt/3IIakOcQ0g5Jsl8pyQ7MoeR11LTo0
SNXSO0TUrI/f+l9TCIHtN3ONesKJ9dQzh1v5EjihopczBFWfPfMJeGmuG2l86Cvh
HOFu6ulBAjGjaEcpBqeeNrqYJ0pwhuYwBlL+w6cnCVG6mHfqonGdN0CncXbxsinq
IoMrow5U
=M4LO
-----END PGP SIGNATURE-----

--7aWVmqvkfCiWXO7m--
