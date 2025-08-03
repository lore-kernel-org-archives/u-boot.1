Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491EDC87FCA
	for <u-boot@archiver.kernel.org>; Sun,  3 Aug 2025 08:18:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8B3C83D28;
	Sun,  3 Aug 2025 10:18:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="hmOBuqON";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EC0C83D28; Sun,  3 Aug 2025 10:18:03 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BAF283B5F
 for <u-boot@lists.denx.de>; Sun,  3 Aug 2025 10:18:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2403ca0313aso26288265ad.0
 for <u-boot@lists.denx.de>; Sun, 03 Aug 2025 01:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1754209079; x=1754813879;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nqZJm5/+xY6P/KZPKIj2Kg3f3UVIQ93aHheucjO0DyA=;
 b=hmOBuqONR4UWeShz6j96Bahl3ORLIjmqRa67CzjQvd78Uu/UWmXomRh3Ts2Lo88cey
 2RWZclD17fA1A3+gSHBxhzGpaEdncstxYO6iozjZb7SBEprPoyT9QX097InhVNaghxzd
 KWIgg2jNwhusGv7bo2GJFV4Oks2or1BvqrfOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754209079; x=1754813879;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nqZJm5/+xY6P/KZPKIj2Kg3f3UVIQ93aHheucjO0DyA=;
 b=dZpux0qSf5LPpOukyARf1ERsPBQES2b1YMalHws0d6dTkm/AM8Az98JdKgf2r8lJTG
 zMbiDlza43wWS/LMlIZmue7QvH57e6T63r845U2VT3Tdh1irVQoZfD8lS52M6eDrZlB1
 D1JmfGMQGS1mDVsC9XbqiaYhKdOmoNUp94fozriFTIF0ypTR1R1Wtn3Hu07aQttjIw15
 Qmnim+pK5RW5tyVBUAJ6SLClZQ31Qlz/4MGBaPVJZR2AEhlAPiac8BsdWww5sFAFCIWS
 12lPkT3hSinkuM1DWQ2L/Oc/5MpLmiZIU73FpDsDPY9jdV7kp4jgsTFxjfCN8yeVw5tg
 sAGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqfNvGI35nnz0TRtioxDkO/whdQIXO3BGUKOQ0zYEYXKUD80xMNlt4uY/DGCoZf+WRCQ6HGcs=@lists.denx.de
X-Gm-Message-State: AOJu0YwcIXvDVmKCOZw53QejFY2Rt03qTJ3LWzG9ModM9dTMj0FmCc4H
 2STbXizHPiowvMknySBSPVbvJCEdipObsuAUtNP9HOOqRUz7x5LcqYT5L19t0ySwoeH5er7G5BA
 rPufvJfnMFC/MhXu2EMi8SrG8lve/AM3qY9wlVK5cFA==
X-Gm-Gg: ASbGncvLq77ZV0LVKWr7BJrW8G6LJ1+0+M3DxEPXiD0HOb1AwTtGzTiZ1rZ0gho3CA7
 cHAgK9gPogP9tirmtDuKZnnLGus/B1WpgqSsT7Ynsk67qPS7H5USZZT16+bXTnECdWLy3padbAA
 N5OSSkaGTVItyCjoUOL8gBXdDvNlcJuc3iv8NdbuydVkJeBdoUSiw1Itk7ZQXleN7P9IRc44RKB
 ernWJBKep96FbRt
X-Google-Smtp-Source: AGHT+IG+STrTyhl92Vf2RLwaJqYusC+AP29TxV7ruyLXl9ORiMZyoYaLCqjcc4gOSW/kzfjY9+YjTU2GLepqsmewN9o=
X-Received: by 2002:a17:902:c94c:b0:242:1b:7f05 with SMTP id
 d9443c01a7336-24246ff1f80mr81605025ad.24.1754209078819; Sun, 03 Aug 2025
 01:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250801-mtd_nand_raw2-v1-0-bdabdeb35b46@linaro.org>
 <20250801-mtd_nand_raw2-v1-1-bdabdeb35b46@linaro.org>
In-Reply-To: <20250801-mtd_nand_raw2-v1-1-bdabdeb35b46@linaro.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 3 Aug 2025 10:17:43 +0200
X-Gm-Features: Ac12FXzRtoUi4QPJ7rC-HfKsiZoC8_JBTlZYa8lWlbkoPYgiItX-mDxPMcGcKb4
Message-ID: <CAOf5uwmhNsXSZFaC_fqL2FFFHJ1CmEz4Xj0D4=7cu6nKPMaNfg@mail.gmail.com>
Subject: Re: [PATCH 1/3] mtd: nand: pxa3xx: Free memory on error
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de, 
 uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi

On Fri, Aug 1, 2025 at 12:39=E2=80=AFPM Andrew Goodbody <andrew.goodbody@li=
naro.org>
wrote:

> In pxa3xx_nand_probe_dt if the function detects an error after
> allocating memory that memory is not freed before exit. Add the
> appropriate free.
>
> This issue was found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/mtd/nand/raw/pxa3xx_nand.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mtd/nand/raw/pxa3xx_nand.c
> b/drivers/mtd/nand/raw/pxa3xx_nand.c
> index b78b4e60238..7bf54fa4654 100644
> --- a/drivers/mtd/nand/raw/pxa3xx_nand.c
> +++ b/drivers/mtd/nand/raw/pxa3xx_nand.c
> @@ -1765,6 +1765,7 @@ static int pxa3xx_nand_probe_dt(struct udevice *dev=
,
> struct pxa3xx_nand_info *in
>         pdata->num_cs =3D dev_read_u32_default(dev, "num-cs", 1);
>         if (pdata->num_cs !=3D 1) {
>                 pr_err("pxa3xx driver supports single CS only\n");
> +               kfree(pdata);
>                 return -EINVAL;
>         }
>

Reviewed-by: MIchael Trimarchi <michael@amarulasolutions.com>


>
>
> --
> 2.39.5
>
>

--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
