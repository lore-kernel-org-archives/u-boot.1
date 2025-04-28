Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFE1C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 22:20:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDDC58219D;
	Tue, 29 Apr 2025 00:20:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sCrARIRY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F55E826AA; Tue, 29 Apr 2025 00:20:54 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 113D280FDE
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 00:20:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-72b0626c785so4597982a34.2
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 15:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745878851; x=1746483651; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7xdhg0Xuo6/ZDBcyZC6aJ2VnIn8U9syt06+4Id4w42w=;
 b=sCrARIRYxSu6qORM14eadvFdGjktK2sr2XSRpqDFidAE3aeT4XlYjeZ1KDL8riyw1Z
 z4Zz2BRMMzeK5OVwyeDOCtfra26AuHvxUQRWANV4ITRZ4RAmq+Jhiy5iMTJScfs6+tBr
 qMvIMUKeh3YGKgqVpXEGwovAFPahEWW3nd8Pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745878851; x=1746483651;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7xdhg0Xuo6/ZDBcyZC6aJ2VnIn8U9syt06+4Id4w42w=;
 b=m4puf0bUGQujMnQL5/qLGPZtGhXa6yOxxE0HF3I7ihiHkE8n7//gh+okcggCVeLLNi
 4z8CfCX+wVMi14Md5pzQGpblSFxeTojBSR3xsSZWfmEVuv+97qtdumwFSH+VjWHbOL3O
 xmG9aRDhp7klz97G2QKjinuAMzCOAvl+HMBn8+JHPv2aeErCa7CyfJm1zlj1M4SGM5bZ
 l0zgfCMaat9DqQQNlsBBnCCDs5IqDzmNe9STW6npvCdGsn2cxjftDHVLqHkCt6rQmNjQ
 qd80A0FlsQxQee33CqER2s7s7fWZ8f4reqSj8FFe2e2IV5klo7qqfxm3tuDP3fqFWk5G
 Q54g==
X-Gm-Message-State: AOJu0YxLUqP4vP8aXHFYTJ0mvbXqWBxZFBseLo9NUTGmDF9i8ynxWt7p
 zO/z+AUKXx10kn7h4W3LkA4q8E6GMQGLmhd3mmDOc6d89X55hWuGSWZ8B8bIS8o=
X-Gm-Gg: ASbGncvxZxVDt5XMY3Z8BsK2GShCWCIvyg3zy9pY1dRpIgslIeAQZT7KBUNg3Ec4g8r
 eJ1RLlFh4hdAI0o8tMCbBpaoRHHwz424OJHbOl8fcTu2v5P/JR/95BZi7mcq1y/I1IqHxQdzMqM
 kNBdRc7CwjFAgevFKs6/8nee3ulNlqo5FNcJRYA46OwjfUBh7hQTi8fNRT9GYuDS0E4oY3ISlqW
 pGZAIF3xyw6aGUNklHIc1WyKmFAcb2gtfekT6ANnT3PO5030xEwMEXIBChkilJfkEdyNv+9YCbg
 4Qim6AO9KFUox5vWqWsPqz/J4bDeanaMTWJuvcg5uAf8ZT2WNRiL8z2NPLTUhVwBCTm9e88N0G/
 1yg==
X-Google-Smtp-Source: AGHT+IELJEEVGQ8bxSAAooARip+Ubnb5Auc/qnbWViSeReH8Ve7L9TRgei38lxLmbcolgnFyVNFzEA==
X-Received: by 2002:a05:6830:a92:b0:727:4a6:5b31 with SMTP id
 46e09a7af769-73088c54f19mr965988a34.22.1745878850729; 
 Mon, 28 Apr 2025 15:20:50 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b312eeesm17755a34.66.2025.04.28.15.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 15:20:49 -0700 (PDT)
Date: Mon, 28 Apr 2025 16:20:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Stephen Boyd <swboyd@chromium.org>
Cc: u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: Re: [PATCH v3 06/17] coreboot: Move coreboot logic out of x86 to a
 generic place
Message-ID: <20250428222047.GK5495@bill-the-cat>
References: <20250428192427.3877612-1-swboyd@chromium.org>
 <20250428192427.3877612-7-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="67lbZ2z95Bo2jVV+"
Content-Disposition: inline
In-Reply-To: <20250428192427.3877612-7-swboyd@chromium.org>
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


--67lbZ2z95Bo2jVV+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 12:24:13PM -0700, Stephen Boyd wrote:

> Lay the groundwork to run U-Boot as a payload on ARM coreboot based
> devices. Move the coreboot table parsing code out of arch/x86 into
> lib/coreboot. The headers like cb_sysinfo.h and coreboot_tables.h need
> to be globally accessible, so move them into the top level include
> directory. Introduce helper functions like
> board_get_usable_ram_top_from_coreboot(), dram_init_from_coreboot(), and
> dram_init_banksize_from_coreboot() so that boards can still override
> these common functions while also supporting booting as a coreboot
> payload.
>=20
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---

If there's no other feedback, this is fine. But otherwise, I think the
Makefile logic is a tad odd.
[snip]
> diff --git a/lib/Makefile b/lib/Makefile
> index 18ae0cd87bfc..ff3d8cacc0fc 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -136,6 +136,8 @@ obj-$(CONFIG_LIB_UUID) +=3D uuid.o
>  obj-$(CONFIG_LIB_RAND) +=3D rand.o
>  obj-y +=3D panic.o
> =20
> +obj-$(CONFIG_$(XPL_)COREBOOT_SYSINFO)	+=3D coreboot/

I think here we should always traverse the directory on
CONFIG_VENDOR_COREBOOT (and later SYS_COREBOOT?).

[snip]
> diff --git a/lib/coreboot/Makefile b/lib/coreboot/Makefile
> new file mode 100644
> index 000000000000..0f5cb90a056e
> --- /dev/null
> +++ b/lib/coreboot/Makefile
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (c) 2011 The Chromium OS Authors.
> +#
> +# (C) Copyright 2008
> +# Graeme Russ, graeme.russ@gmail.com.
> +#
> +# (C) Copyright 2006
> +# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
> +#
> +# (C) Copyright 2002
> +# Daniel Engstr=F6m, Omicron Ceti AB, daniel@omicron.se.
> +
> +obj-y +=3D cb_sysinfo.o

Then here obj-$(CONFIG_$(XPL_)COREBOOT_SYSINFO) +=3D cb_sysinfo.o
and similar changes in later patches I suspect.

--=20
Tom

--67lbZ2z95Bo2jVV+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgP/z8ACgkQFHw5/5Y0
tyywWAwAm59FvXBnyS9bYEQ25eEdEY0BlJkRQ8wMwTpCGX6HUu1jiaBrIriYDx6/
uLrvFV9mlaSK3FHexxtKHJUymKMqnqOH6MV/r58jNsgIfrT392Ct9h+1IevCi4/O
Cq6Zlq0lnvJFP82ZJBe8u+EJ5rDCmL2nnLhtoVWcQejShj85ATwdSjZxKSdoF2YM
qpsz+z6zumpIK3VK0Eg7RsNJoSJqd9BPCEhxXD3KtBcCjjAafo50p9wwF0skJAU9
S8ohl3EZBZ64hY9QIS41IemPsDaPMy/VSrjDCTUI77Ch44BMD3wCMq/38Ej0rzdv
AZv5z79Oh2bGf1RuonaylUS+GzcVEcibL/dIwA5CArPctv7mOkj6BVoekV1hcyb5
940ueuHVs/KV0c+vUZ9aJwTSWz6x5PQyVH1OrX0J7ZIxKvZhowHzCNseOG53L9tx
1kCMZTH7hs6/qfGpvqdfgBAhF98GNh8HUEv3PKi+LsNBWi2JdMUljAKHsWfBuyRg
ny+uNcHi
=SAUI
-----END PGP SIGNATURE-----

--67lbZ2z95Bo2jVV+--
