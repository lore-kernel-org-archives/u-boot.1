Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24B0CAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 20:00:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCCCE832AD;
	Mon, 29 Sep 2025 22:00:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W5CubW2A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48B28832DA; Mon, 29 Sep 2025 22:00:05 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0938A82A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 22:00:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-43f4fca2f43so1359672b6e.3
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 13:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759176000; x=1759780800; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=t+41KB4KA7yXKs4UXWnfdwu2d0Cv9iN3c8lYPD5FbKA=;
 b=W5CubW2AkvFlaDWULzcy5oU3AffiUsbRdidb8LUYNYuZ5WxnPkqZAFDHid4Ykw/1Kg
 ZK1H158v6ZvjxIC/AprMKNUTYY3oHkPZFodmEc+THTEzdbjsuiCE1c4oxs/zX94Df6Eo
 bX3rc2VKuwcWmwdQpKnGJcPrLdzbsYarL+GDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759176000; x=1759780800;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t+41KB4KA7yXKs4UXWnfdwu2d0Cv9iN3c8lYPD5FbKA=;
 b=fjcgFE/aCoWK8JVWfcuMER4+DVltPXOyQUhSjP3RMW1R7jlsxC2yoo+NO7Tli22D5u
 4rV4I3NmRlP0Z6zL6ZjtHYrsurRNNy6MsRcFpSdvScJ6QSTSDwlnGkT+3tsSQcQsxmwM
 Cm6Y5cGu+PLFIXZfgWAlTWpHjffRmULSS5GZAAgqE8nRK5FJ2mnuTIOGoeW9k5d+NbS2
 VE5zGnFbMyMFG6DCr+2snJLSzgo2e7jZIZwpTt0cbSnUdANr0aeIf6+8H83ukHbVC3aQ
 ctkg8Dme8Z3z5+tOONW9L6ZjmiFlkWJGLP8bgnlxTjhBii1zb19qryIFcamHuAbe+sQe
 Qucw==
X-Gm-Message-State: AOJu0YwQDEanoAEGXOtEwLDgOvW4he9AzS+iEz1L4iMVM3uberZQD41V
 IU37he3IEmBM9luf9g1KOkXMqVkLqwpSd7fMbcZZKdx6u93gfbWIq0iWLreyKnB3VCo=
X-Gm-Gg: ASbGncurca5j+l4Qtlg16iZ0zofx4uWphAaIZ1iMUP0k/y0Vm6MGReE/Wbv9kngr/Q2
 gGzTbaJ70cEEgwCtL/90bQgVO4qzcozZjJx6sWp1aEr0lMnqDYO1NbrAkdfnVlaGzNz8ewJnVgH
 2gCuRRpz3CeNCWd+ZpaH4ci1Cw4Bj0n8E5sXLV8hyRo5sFIARogKsngrwMn4wfYc4/6MOvV/8fa
 ign91xzWHGs2/f+xDQepEw6x/o3z/8iCX7JBVyVBysy4714j1SpM9Onwma+8w4+jHwqvCdXxzO7
 8VPqVI6heADTn1p+XxXn1T4eT8PS04inJAnDGC5Om/9NXWBfISFIMAwdg4H2eoQ0TKDla+JnINc
 eqEubjC78gsrMHNxgLGnoPBivd7mDMmc3YQroB3oaypHwpqQ2LB1u+v9yfkrOXQFam10wE3KL6k
 OqVQ==
X-Google-Smtp-Source: AGHT+IEFkuOXbiT5nqV0I7kWK6vCI2o0OnxzxtdIhzqKNzko1Si/mGt5GNAIcknZrXWnrkJA6iFzWw==
X-Received: by 2002:a05:6808:5090:b0:43f:29ec:a210 with SMTP id
 5614622812f47-43f4cf294a6mr6048515b6e.47.1759176000459; 
 Mon, 29 Sep 2025 13:00:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-43f510f4b2esm2357836b6e.5.2025.09.29.12.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 12:59:59 -0700 (PDT)
Date: Mon, 29 Sep 2025 13:59:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Mark Kettenis <kettenis@openbsd.org>
Cc: u-boot@lists.denx.de, marex@denx.de
Subject: Re: [PATCH v2 3/3] usb: xhci-pci: Load ASMedia XHCI controller
 firmware
Message-ID: <20250929195957.GN6093@bill-the-cat>
References: <20250929195241.70351-1-kettenis@openbsd.org>
 <20250929195241.70351-4-kettenis@openbsd.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tR7W/1vzyCqYdTvN"
Content-Disposition: inline
In-Reply-To: <20250929195241.70351-4-kettenis@openbsd.org>
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


--tR7W/1vzyCqYdTvN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 09:52:41PM +0200, Mark Kettenis wrote:

> The ASMedia XHCI controller found on some of the Apple Silicon
> machines needs firmware to operate.  Use the file system
> firmware loader interface to read the firmware and load it
> onto the controller.  This allows keyboards connected to the
> type-A ports on these machines to function in U-Boot.
>=20
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
[snip]
> +config USB_XHCI_PCI_ASMEDIA
> +	bool "Support for ASMedia xHCI USB controller"
> +	depends on USB_XHCI_PCI
> +	default y if ARCH_APPLE
> +	imply FS_LOADER

The code reads like the loader is non-optional so this should be select
not imply.

--=20
Tom

--tR7W/1vzyCqYdTvN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNrlOQAKCRAr4qD1Cr/k
CrcjAP0Xw4hSUn5xzHVesi4VkskCpo2jexf1l6yDysBFvKdCZwEAiYT4yrUIPbt6
0r0/Bkq7dXZYSKfHcGhx6GBzz3x/PAg=
=Tf4F
-----END PGP SIGNATURE-----

--tR7W/1vzyCqYdTvN--
