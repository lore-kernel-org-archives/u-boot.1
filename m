Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F865CFA46B
	for <u-boot@archiver.kernel.org>; Sun, 23 Nov 2025 14:22:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75B6683B95;
	Sun, 23 Nov 2025 15:22:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P74OY9oI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B905E83BB1; Sun, 23 Nov 2025 15:22:36 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EE2783B91
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 15:22:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c6da5e3353so2573445a34.3
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 06:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763907743; x=1764512543; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8TErBqhVnSoZlyh+ACYwrdAaYq1JW2YTpdC8lL213zQ=;
 b=P74OY9oIAQQst1TKLMlmjce4AJ2enskJm4Cq3juGvXgQx8DBkruhxOfWydoU8s4PB3
 jjqML/1S4MYTY0iN9xuun8ups4niJq23jZVFI6LZyHeGvZk17tics0rNmbg3IaepeHtx
 HmMoQ3ugV7C8KicA8E1NfIeoGsFi08zQpWXq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763907743; x=1764512543;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8TErBqhVnSoZlyh+ACYwrdAaYq1JW2YTpdC8lL213zQ=;
 b=k4o4hbxcZ7zaCxfYJOihBfyPg5vPnriM58hbkwS2JWdQ5aLxFSY9ye5y9BHcvp77a+
 cIJjnKW1QVo80va/F8ca6O0UWS7uTyg92Xj3FyoLbe6g2cQYOJr3NMTzuNs3cRfK96d/
 9XidulIEg0CRfslfy688Ny4nTDrr//ASKgqs+ok8Up+ZmZ4UcFV8tyCc8ADtvYuVls5T
 VlcQlFunWfgWH/a8oM8o+abuxUS9kNmvQFx2hoM4FoZa4IGxNzPg+xGDdDlYj734Ypv5
 VNDqPJgIq7sAj/gT2LzhB+g7G/mREMBOL+j9wv5bZZUmFRh8uqVA5FAXpQpRwcOgS2Rh
 A0AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL7zPqoYfM/ccqPOV3egQViYZy2EUo/cE+lLBBazzLlwRTbeD5VZJcCfdN9uAI+vGPPdQ1FMo=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2u+Ahjhkc0tefs2i0iYr39b8AgsrcSP05KX/hzjv4jk8kKfa4
 m925L1g0lC3MRvMYPu72agcMcfEGpm6RAKiogcHu3DR5uxgBoigzMcNoZJRKkb0jfMo=
X-Gm-Gg: ASbGncvwltHgyQDRbUJXYJZ/FrIyA8HcffGfukMO5Iwy6Z/yJrWvytWCXyitv5zOGZY
 qGUhjbOs8oWUu4SSiAwmYOXOzXKYVUdeu8hSibvTTrp4mtyoQcGvzc7zR+bI5eNIMrKa0dA0LjR
 UOh/tjKbWA/RTZRhra+/Zwc/Ybn76sJfMnJ2KvAWyQ7Uh6Ms3DvsK3dY1Vuh7gZ7hwUgTbQUE9K
 shhqcArVyQpW8fycG5O3YucbEebKc48dn+FgoEdVHAgxYLKSfzACeBZvN8nyh4vIh4DiDOnaZIH
 2SZVhVMKYny/DgqgDfdscVY24UQVqG91D1/niYhpMfTa2ap/iRP6up3anePqVChXWcoS0gWOuw3
 FhqpbuqynQACTRjEW2fNkQDS73CscodT3wfdrxEcJ65sYmMmUSk70KkdKrMg92cInmBbeIRuO1m
 FKHX7tpp0oRjTGNRG5KAae+8jvFA7BId2LUWcmumyX4nxDBUTbgA==
X-Google-Smtp-Source: AGHT+IGtyc6zcRr5PN/WKPrMUbrOm0ixPyoQlFDUNnIbi5+v3AIbrjwkwvTPt3NafS0AgeW7DDB9EQ==
X-Received: by 2002:a05:6830:6da2:b0:7c7:69c8:2d2 with SMTP id
 46e09a7af769-7c798bc4cdcmr3746928a34.13.1763907743208; 
 Sun, 23 Nov 2025 06:22:23 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c78d428edfsm4456106a34.31.2025.11.23.06.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Nov 2025 06:22:22 -0800 (PST)
Date: Sun, 23 Nov 2025 08:22:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/3] board: qemu-arm: enable CONFIG_CONSOLE_RECORD
Message-ID: <20251123142219.GH2125796@bill-the-cat>
References: <20251123011900.91233-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oujjV6Qzl6gA/zW+"
Content-Disposition: inline
In-Reply-To: <20251123011900.91233-1-heinrich.schuchardt@canonical.com>
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


--oujjV6Qzl6gA/zW+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 23, 2025 at 02:18:57AM +0100, Heinrich Schuchardt wrote:

> Many C unit tests are skipped without CONFIG_CONSOLE_RECORD=3Dy.
> Enable it for all QEMU ARM boards.
>=20
> As a prerequisite existing tests need to be fixed:
>=20
> Consider the ARM architecture specific fields when testing the bdinfo
> command.
>=20
> In the print_display_buffer test consider if the system is 64-bit.
>=20
> Heinrich Schuchardt (3):
>   test: cmd/bdinfo: consider ARM architecture specific info
>   test: print_display_buffer must consider 64bit support
>   board: qemu-arm: enable CONFIG_CONSOLE_RECORD
>=20
>  board/emulation/qemu-arm/Kconfig |  1 +
>  test/cmd/bdinfo.c                | 28 ++++++++++++++++++++++++++++
>  test/common/print.c              | 11 +++++++----
>  3 files changed, 36 insertions(+), 4 deletions(-)

Looking over test/ stuff quickly this morning, I think we might want to
look at having UNIT_TEST imply CONSOLE_RECORD because there's a number
of tests using console and if you're enabling the tests you probably
want them to run. We should also maybe cleanup test/Makefile as it's a
bit confusing as we only descend on $(PHASE_)UNIT_TEST being set. And if
you just want to file issues for these and I'll take care of them at
some point that's fine, thanks!

--=20
Tom

--oujjV6Qzl6gA/zW+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSMYlQAKCRAr4qD1Cr/k
Cm2GAQDPX0p3GJUkNLlI4CJG65w000J9k885OZJe1W+vQ4RsuAD/ReQpgbig30xn
b1XIvCjlestEmAzov30+BD8xck1fVAY=
=qk7W
-----END PGP SIGNATURE-----

--oujjV6Qzl6gA/zW+--
