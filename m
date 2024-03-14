Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E62C54E66
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 00:41:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BFB787FDC;
	Thu, 14 Mar 2024 01:40:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bYEGE2q3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F5AA87F43; Thu, 14 Mar 2024 01:40:55 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D540387FC0
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 01:40:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-429f53f0b0bso2393521cf.2
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 17:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710376851; x=1710981651; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=f7Zu5lja3OhMOnj3tm+LbChWbGs2izrw1jDvsqDYG7c=;
 b=bYEGE2q3hE9QwqcxtqYjKpiR6yJT/4nzi6l7wjxvqw/n34f/La8zjJl3FOsk/HhOeK
 wCI5KvwPsMvxKsLkVqJTLfRenIb2zxv8WcGv1jG7lK8M+NzvHV94njl/0fI8rgYavZfT
 F6hprgdkeeNqYjndz5EwPUHCzmgmnGdr7ChBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710376851; x=1710981651;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f7Zu5lja3OhMOnj3tm+LbChWbGs2izrw1jDvsqDYG7c=;
 b=Rmum2a3UFpEOQtIrKlsalu6AqKlCXliIEY+oLZ2+cpfct7TSLro8Haky7DTKIxLzFQ
 W5ZRSwbiO9Rfk9+XIdXzJ+Xix2BNq6VhnkTq12mOM+jdp7jZA77tkOEZEzGWS0q4mXzV
 c9sJTfa60Xq/aIWeQnBZFB6ncWMOg0BaoHBdtCvDmcUCbpMJhT1zsWkhcj8HhpetymO2
 3pjNhIiittBz26nFOFqkJ/WOKPEPfmM34J7FzUQqVWie46FWt+JCXhK25BuPY+X110Ny
 ouoReca+FdMZxcN2ZO4XODQNF/upPFs+7PtfB8ZHSntxf6EX5brtV5VW/1DBRh63sR8O
 6cRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVG1/kMTYkCh4qJYCdlOvBst4qHvgViSTbMy/HfowVeUvkRkUfqgN84JHB/BEfx/f6bDdWITBMWf35xjWToih2qn0Cgbw==
X-Gm-Message-State: AOJu0YycgXlHqwFeutnlS0sw5ZMbRKqmj2tCDmGLhN2W3TAkuM/Aufga
 9B44Bappg1u3vtT6IELypKAo9l1kW5GaFj5ppQlFMcClSSu37B46gO1TjJS2rUo=
X-Google-Smtp-Source: AGHT+IHLF2ZYdz3vp2ApOl9yS4wSjtjrLRP8ap1F7pL5lg75VE0oqxqvQcVnpsB7XdErjB9S4+ZHyA==
X-Received: by 2002:a05:622a:5b0e:b0:42e:d5a3:e03e with SMTP id
 ea14-20020a05622a5b0e00b0042ed5a3e03emr336834qtb.53.1710376851667; 
 Wed, 13 Mar 2024 17:40:51 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:7f::1005]) by smtp.gmail.com with ESMTPSA id
 z4-20020ac86b84000000b0042eeddf4e42sm135096qts.70.2024.03.13.17.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 17:40:51 -0700 (PDT)
Date: Wed, 13 Mar 2024 20:40:48 -0400
From: Tom Rini <trini@konsulko.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 caleb.connolly@linaro.org, sumit.garg@linaro.org,
 richard.henderson@linaro.org, Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Joel Stanley <joel@jms.id.au>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Michal Simek <michal.simek@amd.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>, Bin Meng <bmeng@tinylab.org>
Subject: Re: [PATCH v3 2/7] arm: clean up v7 and v8 linker scripts for
 bss_start/end
Message-ID: <20240314004048.GS3442575@bill-the-cat>
References: <20240313162324.2117909-1-ilias.apalodimas@linaro.org>
 <20240313162324.2117909-3-ilias.apalodimas@linaro.org>
 <7a6ebdc1-835b-4527-8885-a650242bf295@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oUv7Qp6uMdQrlTsf"
Content-Disposition: inline
In-Reply-To: <7a6ebdc1-835b-4527-8885-a650242bf295@gmail.com>
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


--oUv7Qp6uMdQrlTsf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 04:57:57PM -0600, Sam Edwards wrote:

[snip]
> Still really excited for this to land! I'm going to have to blow the dust
> off of my Clang/LLD support series here soon. :)

Please tell me that includes updates to the Clang support in general
copied over from the Linux kernel :)

--=20
Tom

--oUv7Qp6uMdQrlTsf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXyR5AACgkQFHw5/5Y0
tyzHWgwApYdmrNGgLQB35rH5K4bW+D0BCPrVqhPE841CY1k+9v/KJ0QcvY0+hQ5j
9IMp+nd1eiWLM+mgB/l6gDgnpddLb+PZG8ebFDxXDXfGPimTkuD4nKqXxfrDb74/
nDXMy0nA7cX3cUfPhqeBfDAK9RRBcXAPEYKIcpv/2l6gX3p/RjCWZQIfhatYpib8
KjZm3g/FUv1yOU6gHa0J/fMpJYMP9VZ0B63Hn2pfVf7fsmmzjWkL/BgyTwq5dV5i
UWX92ga4OXYIOb9VeCLrVZuL87TPLw7Lxmc7YUBP5KgjClf7HB+cZh3+VElQWgCM
oM95papkGwgLNueLIMXztOWswc0sjlaI8VsBwMSnp4MzSwBfu+ez8MHdrkc3sphB
nIyWzGO9D+RQxIHTNDzaDOId0Za12074aQUWvFX2xHhLjcbXcRAvdxDcfqu0aZS1
hCtSoID9Mux1Qj5dZmY9CB/LnX/lx1zrTSdDSEs+wvcvXWcdxO6/soIgjxUZLdVm
fZ8fcWqF
=AXtJ
-----END PGP SIGNATURE-----

--oUv7Qp6uMdQrlTsf--
