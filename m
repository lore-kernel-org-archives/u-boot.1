Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E389CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 12:50:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 299B086ED0;
	Fri, 13 Oct 2023 14:50:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EhuBz/zd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 909A686ED0; Fri, 13 Oct 2023 14:50:35 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83C9786D62
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 14:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a7b3d33663so27396287b3.3
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 05:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697201428; x=1697806228; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X3ucAAqRE2EtkypifBUx9hHIADKs2vkWzrzGSjy3Opg=;
 b=EhuBz/zdTcgoQ9SSEHjOmw9CRtHlVa5ygSXlHxcaCK2wsaqpgE5ijnFeIm6R1zX3t1
 AUcSwIkMAOSTdPx/N0E4v3JfmtJYku0hOokhlhhZeUTlqSKPiSuGKKB1FxE5qdA0K+AP
 vL5/ZEgPrDBzZDcVPWu2rBmp7Sa7k/E2VuIow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697201428; x=1697806228;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X3ucAAqRE2EtkypifBUx9hHIADKs2vkWzrzGSjy3Opg=;
 b=spFwr9PumRgVf0JTZc4i6L/DrUhoVMI+laEF9DDdg8gI9dA/+I6UcUXqENGQyP0Rop
 Zv4zBwjzkkL/rvB7skySlCwIdHNVlUvAyXfRGzpkEwmB+umARLhzqVunsx9n9na/zHdO
 YIUmerTrCj7IXWWlRbqiMfqLdN93jByfod9Op26Ia5bZQ5piybpzsE1ELe8fV1nqubdS
 hoFde1KUtl5ZYnZmzFZVHzGtVWsJO99uoMIzit7L5/NIlKnkN9GwyLfUW7JOu2PtYIDU
 IDFxsYMhhchtt9/TmE3iSFC48bsdsOXa9iLNvyST1cYi5rRQNi8jYUciaR12PLG0cQFb
 /W8w==
X-Gm-Message-State: AOJu0Ywxmimq/jUEcjES2jve5trFgHOQHmBeUGcIU7Wvp0h/axaCE99S
 6JgfgFBC9hzpKIROA2mCYqJOqCBrg48SRtHpC/VK3g==
X-Google-Smtp-Source: AGHT+IGBTAzLsI+x6sNxlhvcxd319qwQ0RFEOjnNj6Iy2QGiiFIlV9OLTnJp0HEewxOD1+uqmPhdjA==
X-Received: by 2002:a25:6886:0:b0:d9a:ce53:4942 with SMTP id
 d128-20020a256886000000b00d9ace534942mr4151349ybc.0.1697201428258; 
 Fri, 13 Oct 2023 05:50:28 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5647-4a14-f04e-8d8d.res6.spectrum.com.
 [2603:6081:7b00:6400:5647:4a14:f04e:8d8d])
 by smtp.gmail.com with ESMTPSA id
 g8-20020a056902134800b00d911680fd10sm472897ybu.50.2023.10.13.05.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 05:50:27 -0700 (PDT)
Date: Fri, 13 Oct 2023 08:50:25 -0400
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 UBoot Mailing List <u-boot@lists.denx.de>,
 Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 06/11] board: ti: introduce basic board files for the
 am62px family
Message-ID: <20231013125025.GH3119521@bill-the-cat>
References: <20231012230616.2101992-13-bb@ti.com>
 <20231012230616.2101992-19-bb@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vXLI43Z2XusHhhqZ"
Content-Disposition: inline
In-Reply-To: <20231012230616.2101992-19-bb@ti.com>
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


--vXLI43Z2XusHhhqZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 06:06:23PM -0500, Bryan Brattlof wrote:

> Introduce the basic files needed to support the am62px family of SoCs
>=20
> Co-developed-by: Hari Hagalla <hnagalla@ti.com>
> Signed-off-by: Hari Hagalla <hnagalla@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
[snip]
> diff --git a/board/ti/am62px/evm.c b/board/ti/am62px/evm.c
> new file mode 100644
> index 0000000000000..44793cbed6536
> --- /dev/null
> +++ b/board/ti/am62px/evm.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Board specific initialization for AM62Px platforms
> + *
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.co=
m/
> + *
> + */
> +
> +#include <asm/arch/hardware.h>
> +#include <asm/io.h>
> +#include <common.h>
> +#include <dm/uclass.h>
> +#include <env.h>
> +#include <fdt_support.h>
> +#include <spl.h>
> +
> +int board_init(void)
> +{
> +	return 0;
> +}
> +
> +int dram_init(void)
> +{
> +	return fdtdec_setup_mem_size_base();
> +}
> +
> +int dram_init_banksize(void)
> +{
> +	return fdtdec_setup_memory_banksize();
> +}

Similar to what I said about another platform yesterday, lets split this
up in to "base.c" and "evm.c".  The good news is that so far, I think
all of this should just be in base.c instead.  Second, here and
elsewhere don't add common.h but instead add what you need.  And
finally, for all of the new files please audit what headers you're
adding.  7 headers for 5 function prototypes is a bit much.  Thanks.

--=20
Tom

--vXLI43Z2XusHhhqZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUpPQ4ACgkQFHw5/5Y0
tyy8dgv/a0YZUD1+nrD6iD1+7fOhfBGe7GpCSU/zEB07dZKEH+aMD4Q/zKcFFRde
KQ3w943MkneAiX+N1m6yHa4QiswpUuxkEIPG78bPgKVSrQS+Gpf15IYTeKDdUcrW
Lb8vpWvqm2AYUlI0m6nSKKKpr++V107XMdp6MQ3wrAcZz1xxzZ7zr65Zttn1XL0i
tkKtvomVMmvtAPh2u3uLjDBOZBP+qmeIzlPCJ+4aNR2iVRAB1xZrT871SshxYmLe
R12x59YAauE6SbzgAw3JbHaAeXJFYATxUH98VLjS+mlFMq1zP9aHRMoB+1Zpybl7
09p3vt3wPhzeluPwe0zG5M7fq7AB1LWkoLwDhb4K8TjGDp6+v0svn19q3EeBWzvg
nM1pcbMwPMAA8AbFWsZ/Hl+jojtaZMUFaY8Lq0SH48HJTA5+/s/U1WyaD2hyzzBZ
VNFVzakAx98TJRAM54s3Su07OX7QtFamuk4+8ofRw8JDDcOe0sbgFK6dcGdD0R7r
2ugCV6+p
=YuVk
-----END PGP SIGNATURE-----

--vXLI43Z2XusHhhqZ--
