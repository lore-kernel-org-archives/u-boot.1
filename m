Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A01FC5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 04:37:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34E5A82B07;
	Tue, 10 Jun 2025 06:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aSrAvT75";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E95082B18; Tue, 10 Jun 2025 06:37:15 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4A0782AA7
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 06:37:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55A4b0oV971153;
 Mon, 9 Jun 2025 23:37:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749530220;
 bh=JBrduGWHLmnTu8Rqkj1yknSfjhYtH27PYYzyYBO8JGQ=;
 h=Date:To:Subject:From:References:In-Reply-To;
 b=aSrAvT75yUni8+KLJPHcb5XbqAsjeceBqn/PryZYJ80bYbJq24xifylHETLv1Go/0
 zMq9PBpU82pUe97UzLhpOZNZw+N3DJXXpdjoLE8t4vVP/tCkARwpa32vt0XrFj+FqP
 l8/R8xieHp/u6pJ397+m0qD9D8aDoYK63jBSJUr0=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55A4axLx109775
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 9 Jun 2025 23:37:00 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Jun 2025 23:36:59 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Jun 2025 23:36:59 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55A4awLB2481178;
 Mon, 9 Jun 2025 23:36:59 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 10 Jun 2025 10:06:24 +0530
Message-ID: <DAIKOVEG1GGS.2LH5IT55T3CGW@ti.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, "Heinrich Schuchardt"
 <xypron.glpk@gmx.de>,
 Sam Edwards <cfsworks@gmail.com>, <u-boot@lists.denx.de>,
 Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v3 3/3] common/spl: improve error handling in spl_fit
From: Anshul Dalal <anshuld@ti.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250609164841.GU1382132@bill-the-cat>
 <20250609194601.987979-1-mikhail.kshevetskiy@iopsys.eu>
 <20250609194601.987979-4-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20250609194601.987979-4-mikhail.kshevetskiy@iopsys.eu>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On Tue Jun 10, 2025 at 1:16 AM IST, Mikhail Kshevetskiy wrote:
> This fix a possible NULL pointer dereference.
>
> There is also a risk of memory leaking within the same portion of code.
> The leak will happen if loaded image is bad or damaged. In this case
> u-boot-spl will try booting from the other available media. Unfortunately
> resources allocated for previous boot media will NOT be freed.
>
> We can't fix that issue as the memory allocation mechanism used here
> is unknown. It can be different kinds of malloc() or something else.
>
> To somewhat reduce memory consumption, one can try to reuse previously
> allocated memory as it's done in board_spl_fit_buffer_addr() from
> test/image/spl_load.c.
>
> The corresponding comment was put to the code as well.
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  common/spl/spl_fit.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index 321954a1547..3a7d753edcf 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -703,13 +703,46 @@ static int spl_simple_fit_read(struct spl_fit_info =
*ctx,
>  	 */
>  	size =3D get_aligned_image_size(info, size, 0);
>  	buf =3D board_spl_fit_buffer_addr(size, size, 1);
> +	if (!buf) {
> +		/*
> +		 * We assume that non of the board will ever use 0x0 as a

s/non/none

Everything else looks good to me, thanks for the patch Mikhail.
Reviewed-by: Anshul Dalal <anshuld@ti.com>

> +		 * valid load address. Theoretically some board could use it,
> +		 * but this is extremely unlikely.
> +		 */
> +		return -EIO;
> +	}
> =20
>  	count =3D info->read(info, offset, size, buf);
> +	if (!count) {
> +		/*
> +		 * FIT could not be read. This means we should free the
> +		 * memory allocated by board_spl_fit_buffer_addr().
> +		 * Unfortunately, we don't know what memory allocation
> +		 * mechanism was used:
> +		 *   - For the SPL_SYS_MALLOC_SIMPLE case nothing could
> +		 *     be done. The memory just could not be freed.
> +		 *   - For statically allocated memory buffer we can try
> +		 *     to reuse previously allocated memory (example:
> +		 *     board_spl_fit_buffer_addr() function from the
> +		 *     file test/image/spl_load.c).
> +		 *   - For normall malloc() -- the memory will be lost!
> +		 *
> +		 * Please note:
> +		 *   - FIT images with data placed outside of the FIT
> +		 *     structure will cause small memory leak (several
> +		 *     kilobytes),
> +		 *   - FIT images with data placed inside to the FIT
> +		 *     structure may cause huge memory leak (up to
> +		 *     several megabytes). Do NOT use such images!
> +		 */
> +		return -EIO;
> +	}
> +
>  	ctx->fit =3D buf;
>  	debug("fit read offset %lx, size=3D%lu, dst=3D%p, count=3D%lu\n",
>  	      offset, size, buf, count);
> =20
> -	return (count =3D=3D 0) ? -EIO : 0;
> +	return 0;
>  }
> =20
>  static int spl_simple_fit_parse(struct spl_fit_info *ctx)

