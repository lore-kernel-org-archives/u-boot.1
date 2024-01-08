Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71AEC3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 17:36:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5807E87ABA;
	Mon,  8 Jan 2024 18:36:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JTZoWsFJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF65E87AC7; Mon,  8 Jan 2024 18:36:19 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1EB987AB4
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 18:36:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6dc83674972so1445768a34.1
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 09:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704735375; x=1705340175; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8jFZmOXiqqb7DwGpU9sZAi0SCmEqpos2k5c8pAkDMfM=;
 b=JTZoWsFJTA4lNUMNv/ZYhrYcrNnCtxZVgl0CVuWPpd/Oq4yootJrwX047enuhQVKA0
 X9WZ7rhhBAwQHKAM5PDPw67RELDvNmHjC2mXOaOQUlVdKey3GMZz0EXuYIY+pU90ObJg
 5UJenlwEVoIRgAzO6mjKMcqG47FRdhEn6EgbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704735375; x=1705340175;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8jFZmOXiqqb7DwGpU9sZAi0SCmEqpos2k5c8pAkDMfM=;
 b=iTlmPLgt1w9hO61ZTKiiINz1epUc0rNdhZ40cdSy0abqTW/peArHXz1ZIwjTVv+bi/
 YaoFx0EOr7u3JZXHYGXryN8bmQoSYE5EoCCGREuTbj1X0pheJjw5cTlFekA43L3bTk3b
 aaC3h0ek2fP1UyI8em3y5ntcJmaTouJ/q/Ug9CiGFosfHURydcYiBCuxrDI6VLSzdUyw
 kA6ItuY8a08J/Vn7gwXe1+AdLKfInuJhKOZv56Dk769r5PaZHHX1BYgSRjkP6EVTfo/T
 Ra/wMfkqAgZyNaXtjzL59I6ML0juOfePtVmAXSqCytpAMuT+zkU/o9aKHWC9tYyNNDuI
 OUhw==
X-Gm-Message-State: AOJu0YzyDXadrlTPA16bVy4KX9MGbMS14pcz6INHJnYNqKywZqahMLWb
 nP9tAW/9IM7blWeHdbu4Z5tNtX3+bK5Ltg==
X-Google-Smtp-Source: AGHT+IEGKtAAp/ce7povKsX4vl3Mahva+nuKxATE5EHCZlD2ONd/qPxdmWbylpOiSYEbPmE/x9yPNA==
X-Received: by 2002:a9d:6c90:0:b0:6dd:da1a:fdb1 with SMTP id
 c16-20020a9d6c90000000b006ddda1afdb1mr821585otr.12.1704735375287; 
 Mon, 08 Jan 2024 09:36:15 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 o7-20020a05620a228700b0078322dc4f97sm63146qkh.26.2024.01.08.09.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 09:36:14 -0800 (PST)
Date: Mon, 8 Jan 2024 12:36:12 -0500
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] boot: add support for button commands
Message-ID: <20240108173612.GK1610741@bill-the-cat>
References: <20240105160359.634310-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Oal9ESuxblzfs5kC"
Content-Disposition: inline
In-Reply-To: <20240105160359.634310-1-caleb.connolly@linaro.org>
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


--Oal9ESuxblzfs5kC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 05, 2024 at 04:03:58PM +0000, Caleb Connolly wrote:

> With the relatively new button API in U-Boot, it's now much easier to
> model the common usecase of mapping arbitrary actions to different
> buttons during boot - for example entering fastboot mode, setting some
> additional kernel cmdline arguments, or booting with a custom recovery
> ramdisk, to name a few.
[snip]
> diff --git a/boot/Kconfig b/boot/Kconfig
> index fbc49c5bca47..9580ef1cfca4 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -20,6 +20,20 @@ config TIMESTAMP
>  	  loaded that does not, the message 'Wrong FIT format: no timestamp'
>  	  is shown.
> =20
> +config BUTTON_CMD
> +	bool "Support for running a command if a button is held during boot"
> +	default n

Generally fine, only problem I see is here. "default n" is redundant,
and this should also depend on CMDLINE.

--=20
Tom

--Oal9ESuxblzfs5kC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWcMowACgkQFHw5/5Y0
tyy5swv/aAgszCOVYeouZQNayCtoG/Th0dmI7tNzCX1LUyfTUjVHSDdLzDqtdQbO
HUBb13AebLd1Xgpg8lmY/MO+KxNN5AvHVRBF6s4RutzIcBj7xo1vULRPwyLmOzXM
i9LCqtzPafKMEBA5NBDyreanChbSyGD+zW0TwQtcnp5vUioeeqF2TzQUqM88Gt2n
D2JEOadase34Ia1mD8q79AaAzzsE+LajU22oIaDrCfPbfn8q3jY9rchENghqx+fN
rifr4UNFoUBb9hPCNtxnacgEt4RzkilkWiJJPLg3aBf8ECuQesJQbazX9T1NrYhw
rKgDollxS295BrkQJXtvbHqWrL4cWnzBccTk/B6A1LxGeuvDQAbGjRHUjBIiATVz
oPv+OD9TFVmHBT92CsZVSXs9igvymoW2UmC5VlqsSpXgZfbFN0y8RdnK01QOk6iG
a6+JFRTwQlXgeZOvUit1ddqeYa/5zFYeJhiJBOA/Fm6coOhVmQzaMMf8lyILobHS
DrcBhQ2P
=lxQH
-----END PGP SIGNATURE-----

--Oal9ESuxblzfs5kC--
