Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC78C27C47
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 13:27:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC00D87BD1;
	Sat, 28 Oct 2023 15:27:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WiKqg2mJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8123F87BCC; Sat, 28 Oct 2023 15:27:25 +0200 (CEST)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65E3A87790
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 15:27:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-7ab8696d047so1252984241.1
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 06:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698499642; x=1699104442; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XHVyQ25dpBaQt8D7XgK0PUQSPVCIchzElzLhvTFRy6E=;
 b=WiKqg2mJKv+XqrrgbfCmdpv1KifkdNl5E7UoIqCzUrkapleSygPVJKOSx/d7xKfIQX
 pT0lyesFjH+igbW/hggdkaqMa1RW3ho+u4wRyc4s32RM3uBC/z4we97kqcJctwgp8sQb
 tCkjRdC8IuWQHcm661d3Qk0DyBYZqW/nql6DA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698499642; x=1699104442;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHVyQ25dpBaQt8D7XgK0PUQSPVCIchzElzLhvTFRy6E=;
 b=glEzfbhLVFpaEddqLA5GDvSQL7uclocYeDhyvvkAUGniE+a55S7WkPZ1nAjM3XSlzC
 0oLnZzPEXLWBMLhdeCoacVPyt7BwVa5nyV9MDoClDnVz8spMGceae2Fu4pAGmNutif+u
 9t+sJu3JB50HtqYt54nF8OINzQBfO0J9Xm9h9FReLilukM1ubzuiEJsNbLE0yXxPnybv
 J3O6cmrlfSl69SNwp29zr4PIM5IC4slHYrOJAQjZKcKFeV5Kud2Hq1V/how0mcRzVwMw
 SkrqxqFAppG+JOfklxuxlPal0bsRkDKim47RTnEuMxckXwE2ISCVITp22BIfWAB3OjnS
 K9BA==
X-Gm-Message-State: AOJu0YyjAqIWiUBD/TYzw8a/nUpalF5NHRTalECSgb1uhI0+fq+cO6n0
 463Ai2YBsTfsTCirEocngzfnDg==
X-Google-Smtp-Source: AGHT+IEsa+C7AE918GvbDfOHZmXvNLNejnAWkIgQ0rCvd5RS0roW3jLTyw67ZCSTqnKpLJPL48nUVQ==
X-Received: by 2002:a05:6102:2041:b0:457:d3ff:54dc with SMTP id
 q1-20020a056102204100b00457d3ff54dcmr5673587vsr.19.1698499642071; 
 Sat, 28 Oct 2023 06:27:22 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6f2b-3a78-9e8e-d344.res6.spectrum.com.
 [2603:6081:7b00:6400:6f2b:3a78:9e8e:d344])
 by smtp.gmail.com with ESMTPSA id
 j7-20020ac84c87000000b003f6ac526568sm1597063qtv.39.2023.10.28.06.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 06:27:21 -0700 (PDT)
Date: Sat, 28 Oct 2023 09:27:19 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] config: qemu: relax print and console buffer size
Message-ID: <20231028132719.GM496310@bill-the-cat>
References: <20231016215445.5970-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="39Tn2mgjgcCxHSoJ"
Content-Disposition: inline
In-Reply-To: <20231016215445.5970-1-heinrich.schuchardt@canonical.com>
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


--39Tn2mgjgcCxHSoJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 11:54:45PM +0200, Heinrich Schuchardt wrote:

> QEMU print and console buffer sizes have been restricted on QEMU below
> their default values.
>=20
> One of the side effects of the print buffer size restriction is output
> truncation of the 'efidebug dh' command.
>=20
> As QEMU does not have special memory size restrictions remove the settings
> from the defconfig files and go with the generic defaults.
>=20
> Fixes: d0ee7f295d74 ("Convert CONFIG_SYS_PBSIZE to Kconfig")
> Fixes: d31466b382dd ("Convert CONFIG_SYS_CBSIZE to Kconfig")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--39Tn2mgjgcCxHSoJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU9DDcACgkQFHw5/5Y0
tywuSwv+M//Mhu55IaA6odBISr+Qil5smtp13SHYa5/M7sCiNUzBz40IfZ8ftUVw
XnuBbVe+8tgdWHv0CRswqcnBKkzjXRRG9uyD41/3PqikdXkFGMGpDQn72c+lDJx1
V4Q0p1T49sjoVTdnAepsdMUE8BjVU8FhRGbybVsMeLCLRXz/aJyqtkHfCfFHllDC
2itM1ukwTemiJYs7O1Nm/hxlL8XRjg4t28GNXz9cKlD16J63nnjCKnvy7BUVFYiT
GQ7n4TtOlTtNDY8gVmewlaIJT1Lwb4P/HDe5nszns3Az4MWJRBsjIevXNlphMuOg
AspMKXAmmbBulw54TkUm2ExCdSzAgoGYyf+3ofFhwGEQaB2a9Ti8blQLAoO+kQ57
8UMnHBmUy+Qau3wupqyyfa/YNaC5tOzXkgi/sjunqZiYE2Pkwy6bpoNHS3crx+Jj
W+s8D2+0pAB37aR6Jx6wQVVYwymJiIQ13gI40jsrfxXNue3qxFUJsVjrIme9zo2O
PN70Kf5f
=djr+
-----END PGP SIGNATURE-----

--39Tn2mgjgcCxHSoJ--
