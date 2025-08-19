Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CE4CA0EF5
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 08:28:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BE2C80FA1;
	Tue, 19 Aug 2025 10:28:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="TyEUt4Om";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01D1B81FEE; Tue, 19 Aug 2025 10:28:35 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 552E0802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 10:28:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-24458317464so55735545ad.3
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 01:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1755592111; x=1756196911;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fGV+P5q0X8hB6QbrJ5GxF+NWS7aJmtgEVvzmPpTAeZk=;
 b=TyEUt4Omi28LAyyhspokP7VdXNeXdwaz6fF0Bnujw3ycL7ALqluU6opKuBF2047/8m
 MAtQLHyruISQJzlxBMCmrCR13MOV5MX1LIoHo3pLmiaLJc/YFgKZs5OxMQn065AvTrLj
 cTxa7bLW2+/3TDBCP9grLstTr7/tPeP4CW9dU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755592111; x=1756196911;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fGV+P5q0X8hB6QbrJ5GxF+NWS7aJmtgEVvzmPpTAeZk=;
 b=cJq8xqXQTlNZLAdQXRP0dy8eEBnD3nut+xUbFTdZMoiMjztqQpQSdz0uVs1yCQkyZs
 EuwdOCLtZhxp690GT1F4PgKEqEXhgHSwEU0DMM5nWfxZOGq1JcEGy4vmbWZMdPC0cuIx
 3gxHlK5reWmgkCxMYENY+ZncQXUYJHZmnKMGMIBCWCaVVXIqDWHjWjpunT54R7g0009o
 swUSeZLEficbuUfHnlTG8g9fx4wQrnYJ6QisqZyyiact6Su6ky0cf/OS4rj9GFboTjNc
 59Oq2s9dkRe0B4EI6nowbxjUvtSwzVREiNPAdwbP2fsduk74L8NeTzhdqxfQRU+3z75G
 mcaQ==
X-Gm-Message-State: AOJu0YydB/1QJcuiGlScUrJyqbtZCN3dOb1CrmFznluPtK+zKWXO9ekl
 aYMFLUM2ddbyoRQTeQf+vg4eLvdMS4dPK+hF02yB62+AOWYfhqX3CR4hDzKFJPlDpFXA3uj/NnG
 fp63zfSWu5LPEZbL8jNJ7S0hsspZG9+VrAovRdpQvNw==
X-Gm-Gg: ASbGncuMmq1jGjV7Yuxrtw2d3rq27OmucE0EM+i0gvnSwiGaVk20EE7TSNH3qQNm2Iq
 bKKq2tULX2ShKaXfC72NiUb5vBt2oA5Qa3Y7P0LeVaLYojDg3WuZPfiWOP0jj8bmJVTmwfl0Phe
 hq3MHvYzmkSTQ0tergOEu4FH+RQOzjJFblQBUIGD2SBHZBUmsMXmlhJ6v5ZtEkNP4/43Y22DUYS
 Vtb5cs4
X-Google-Smtp-Source: AGHT+IEPAGwb6LzSP3EzjtSUSEL6vo6gBwtC00WM8ZCME8+D+s/Tx4/0zLdIc1TLxziOgen1O0Kb5ugYrfWecgkzZEs=
X-Received: by 2002:a17:903:230d:b0:242:8a45:a95e with SMTP id
 d9443c01a7336-245e0465bcamr23270435ad.15.1755592110563; Tue, 19 Aug 2025
 01:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250819071636.25197-1-dinesh.maniyam@altera.com>
 <CAOf5uwn_ne64ydAOCvYe-=-FJgk+mXxMF1+m=J65=C_ByHN6YA@mail.gmail.com>
In-Reply-To: <CAOf5uwn_ne64ydAOCvYe-=-FJgk+mXxMF1+m=J65=C_ByHN6YA@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 19 Aug 2025 10:28:19 +0200
X-Gm-Features: Ac12FXxbvz7Haafoic2rQ3VZlH9XdHuk3WYcxFhcJA8r9x6hs6H-B5ind-vRDFE
Message-ID: <CAOf5uwmu+0_qeYV=40-SObiFshhp5K7OVzQv5=uPSmAG_R76kg@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: nand: cadence: Fix device assignment to avoid
 warm reset issue
To: dinesh.maniyam@altera.com
Cc: u-boot@lists.denx.de, Marek <marex@denx.de>, 
 Simon <simon.k.r.goldschmidt@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Tien Fong <tien.fong.chee@altera.com>, Kok Kiang <kok.kiang.hea@altera.com>, 
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>, 
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>
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

Hi Dinesh

Please adjust your signature seems that intel.com domain is not valid

MIchael

On Tue, Aug 19, 2025 at 10:23=E2=80=AFAM Michael Nazzareno Trimarchi <
michael@amarulasolutions.com> wrote:

>
>
> On Tue, Aug 19, 2025 at 9:16=E2=80=AFAM <dinesh.maniyam@altera.com> wrote=
:
>
>> From: Dinesh Maniyam <dinesh.maniyam@intel.com>
>>
>> The driver currently does:
>>     mtd->dev->parent =3D cadence->dev;
>>
>> This works in Linux because `struct mtd_info` embeds a `struct device`,
>> so `mtd->dev` is always valid and its `.parent` can be set.
>>
>> In U-Boot, however, `mtd->dev` is only a pointer to a `struct udevice`.
>> Dereferencing it before assignment is invalid, which breaks the device
>> hierarchy. As a result, consumers relying on `mtd->dev` (e.g. partition
>> parser, reset and re-init paths) operate on a dangling pointer. This
>> leads to failures during warm reset when the NAND device is accessed
>> again.
>>
>> Fix by assigning the device pointer directly:
>>     mtd->dev =3D cadence->dev;
>>
>> This matches U-Boot=E2=80=99s device model, preserves a valid hierarchy,=
 and
>> resolves the warm reset issue on Cadence NAND.
>>
>> Fixes: ebc41cad ("drivers: mtd: nand: Add driver for Cadence Nand")
>> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
>> ---
>>
>
> Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
>
>
>>  drivers/mtd/nand/raw/cadence_nand.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/nand/raw/cadence_nand.c
>> b/drivers/mtd/nand/raw/cadence_nand.c
>> index 27aa7f97a45..4771440d1de 100644
>> --- a/drivers/mtd/nand/raw/cadence_nand.c
>> +++ b/drivers/mtd/nand/raw/cadence_nand.c
>> @@ -2196,7 +2196,7 @@ static int cadence_nand_chip_init(struct
>> cadence_nand_info *cadence, ofnode node
>>         chip->controller =3D &cadence->controller;
>>         nand_set_flash_node(chip, node);
>>         mtd =3D nand_to_mtd(chip);
>> -       mtd->dev->parent =3D cadence->dev;
>> +       mtd->dev =3D cadence->dev;
>>
>>         chip->options |=3D NAND_BUSWIDTH_AUTO;
>>         chip->select_chip =3D cadence_nand_select_chip;
>> --
>> 2.35.3
>>
>>
>
> --
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com
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
