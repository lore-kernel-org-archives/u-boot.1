Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5139DC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 08:45:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16DE486CB1;
	Mon, 13 Nov 2023 09:45:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RCjtiuV4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71F8D86D82; Mon, 13 Nov 2023 09:45:13 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E4D886B0A
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 09:45:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9c3aec5f326so1067640066b.1
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 00:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1699865111; x=1700469911;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mzlia/kCJ1VqwGA8Dz6pMCzYjxBHmZJlLOE6OUyo/Eo=;
 b=RCjtiuV4LMFvOnK2YsGQUXsF+P/ByT0allJuiocwqKJ2zD5pE25Gipr6yOAHCoCs81
 QxIO89Xi45iXlpjoli5dgYq8WoBqmZTGtxzWbAGQ3R+wrdCNsqrmRpL4aqN263rwCPyN
 cb5q/XEEsnRSbUf7tiM6N8wXA+pFBUGTDVmDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699865111; x=1700469911;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mzlia/kCJ1VqwGA8Dz6pMCzYjxBHmZJlLOE6OUyo/Eo=;
 b=kX/FYNUKz2I6raxGy62QRm617VJdD7ashYjOMo+Os3ApeH6HT+snvA31acqag7ihmX
 DwIk0pedXZperZbzkWRl16cqmg8Qsdfawy5MgGZbjQwP/09r3ZnTE3dvefBDL0iWps4j
 Vq4n7ggSTEK+swN8IresfJDT4yRKAY+lIdsCuevxatUrdv/RnlcOfxnK3KuKut0Yw7UO
 Im7Bjb14gKGmtXKLybXPg8F07bmKmVct8nP7Iitt62khZb/3sRd+x4tNofhl3engr9xy
 37Mb9o31vv3KUBPmBiWhaLZetLiInJ02w8tCdlNi9DnfFmHrTt12Dc3ewHqYmC3gk8W/
 XKUw==
X-Gm-Message-State: AOJu0YwcnEErMvLLjfh5DF9Zm4FoJKRjDLoR3WWD2h+COs5NpLNpAY08
 TD1dhGFfMt0P1/6XE6R8WnYUM9s548RXNWQchc06sQ==
X-Google-Smtp-Source: AGHT+IF1Zbde/smZo6ATFqBbgYi6gkfVi4udXE4TzZJ/QLn3lbuJnA6KQPF399iF3x6Sq6ht+Q+KAKqwLXqXd+oA89Y=
X-Received: by 2002:a17:906:f8cc:b0:9ad:e62c:4517 with SMTP id
 lh12-20020a170906f8cc00b009ade62c4517mr8754879ejb.34.1699865110803; Mon, 13
 Nov 2023 00:45:10 -0800 (PST)
MIME-Version: 1.0
References: <20231102112743.57420-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20231102112743.57420-1-dario.binacchi@amarulasolutions.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 13 Nov 2023 09:45:00 +0100
Message-ID: <CAOf5uw=S4=XgjCj3rihQ8zt+Sh-XWj-miT5pcKG56x6cMz+1ug@mail.gmail.com>
Subject: Re: [PATCH] mtd: nand: complete nand_register() arguments check
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Nov 2, 2023 at 12:27=E2=80=AFPM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> The patch checks that the "mtd" parameter is accessible before
> proceeding.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>
> ---
>
>  drivers/mtd/nand/raw/nand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/nand/raw/nand.c b/drivers/mtd/nand/raw/nand.c
> index eacd99c4e275..d31bb580c46a 100644
> --- a/drivers/mtd/nand/raw/nand.c
> +++ b/drivers/mtd/nand/raw/nand.c
> @@ -52,7 +52,7 @@ int nand_mtd_to_devnum(struct mtd_info *mtd)
>  /* Register an initialized NAND mtd device with the U-Boot NAND command.=
 */
>  int nand_register(int devnum, struct mtd_info *mtd)
>  {
> -       if (devnum >=3D CONFIG_SYS_MAX_NAND_DEVICE)
> +       if (!mtd || devnum >=3D CONFIG_SYS_MAX_NAND_DEVICE)
>                 return -EINVAL;
>
>         nand_info[devnum] =3D mtd;
> --
> 2.42.0
>

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>


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
