Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84119C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 08:46:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01FE186F40;
	Mon, 13 Nov 2023 09:46:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Khcugj3E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE66D86CB1; Mon, 13 Nov 2023 09:46:48 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D13F386CB1
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 09:46:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-50797cf5b69so5609298e87.2
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 00:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1699865206; x=1700470006;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jaP3rblFii2U0bB797BxvH9K0l3Q6CfgOFFzslWuyYE=;
 b=Khcugj3E97yW/XEJ2oSW3MQN8ErpHvladHDx+4Er6P/7hn3EGg7oRLkF4wsLedxSsO
 dZEsKATJk5mYMbKw+jlwnyzbv8SMBFWc8pVCh28ya7t3ks2h60DlV/evoaXKgfbhCHuV
 uEgQDlnpwJrZaXjUu8YzT+ELqYC61fFb/uDjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699865206; x=1700470006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jaP3rblFii2U0bB797BxvH9K0l3Q6CfgOFFzslWuyYE=;
 b=RR7uV4gtq0p8/n5hTR/mcafZ5YPgJ5sf+9EReJbvIyw3Ro2t0f2TewtGC4nMHeTncs
 cOSJ6TeNxAT/OkN1JoDUwwtNTQN3WrW5NLTvcK9CKGmWkPGg9lCOvaZAxNdTnTCS7VzW
 qNw6liWiQXxdAxgV8GdTBQSNfbtExgyod4Sv0Ze7noPfHaWZr5vTZ/2/v/buwQ3hzwNa
 9xL/19YvISULxAc0vSqPhNRBPPzi6c9XhJkw7B6eZ0EodwAmqko6J9mKZ8MCUK1KHOUn
 OwfeO+VjpVa+Uy/AGIeMsIRpL/8sPO4B26dSoCOaQ/sWLgxhDkDt5aZKy0r4mxeubBhe
 RHRA==
X-Gm-Message-State: AOJu0Yw5ltkw3Jntn725ERA9jpDyQtQmysFH4F3kWfmOgh20uF1xGeRg
 DQ0kvv/vSqeTW0TLgyZeP2J87njH/vz5zYzns2jWFw==
X-Google-Smtp-Source: AGHT+IFi1uv627wdeu4vWGwyfEoNOPxJOFCf/B6g4oltYObmwk9sv2CtJSSw3hw9sYGgjzpyebtMMlw8P4n+DKBxWoY=
X-Received: by 2002:a19:8c5c:0:b0:507:9693:12aa with SMTP id
 i28-20020a198c5c000000b00507969312aamr3856008lfj.15.1699865205837; Mon, 13
 Nov 2023 00:46:45 -0800 (PST)
MIME-Version: 1.0
References: <20231102113829.58852-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20231102113829.58852-1-dario.binacchi@amarulasolutions.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 13 Nov 2023 09:46:35 +0100
Message-ID: <CAOf5uwniHKWrnVTNsc2yX5tDodqYOu9rFak7mfEVrGK5k75n8A@mail.gmail.com>
Subject: Re: [PATCH] mtd: nand: check nand_mtd_to_devnum() argument
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

On Thu, Nov 2, 2023 at 12:38=E2=80=AFPM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> If the "mtd" parameter is NULL, the search will definitely yield a
> negative result. In that case, it's better to exit immediately.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>
> ---
>
>  drivers/mtd/nand/raw/nand.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/nand/raw/nand.c b/drivers/mtd/nand/raw/nand.c
> index eacd99c4e275..55c00ac815dd 100644
> --- a/drivers/mtd/nand/raw/nand.c
> +++ b/drivers/mtd/nand/raw/nand.c
> @@ -41,8 +41,11 @@ int nand_mtd_to_devnum(struct mtd_info *mtd)
>  {
>         int i;
>
> +       if (!mtd)
> +               return -ENODEV;
> +
>         for (i =3D 0; i < CONFIG_SYS_MAX_NAND_DEVICE; i++) {
> -               if (mtd && get_nand_dev_by_index(i) =3D=3D mtd)
> +               if (get_nand_dev_by_index(i) =3D=3D mtd)
>                         return i;
>         }
>
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
