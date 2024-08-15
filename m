Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB9BC3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 12:23:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8D088863B;
	Thu, 15 Aug 2024 14:23:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iO2ahIFE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D70488A39; Thu, 15 Aug 2024 14:23:32 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B77A88860D
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 14:23:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-530eed61afdso146042e87.3
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 05:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723724610; x=1724329410; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=APSa0CAr27aScKJT1FD09vVPBEzhUq5PuP+JiMl+Qec=;
 b=iO2ahIFEeHwYc/6Wo73djnUScGrK/MU4YzuqpZGWyo4xBMBp5vczxVdJAHHYy4ivx7
 suG9IHq6GqTgiBnN9BT9NExvOWSZeRszPcWg7NypYw8KEsneeDSlUCmGi3oEgM6UUiqr
 5pqgUkiu4Kl4ZMfNfMxlt95jTNZWEmw8BASNceb+WYIyNtvNiK5+0nI4EttJkSB6aJ5t
 vQeVZPZavRo/PXlyddZh3isPgptK8jw5gQyECn/yZu4Os2L5F7CPVoSsDTSAKJvzxfCQ
 Q8uLS88WoUY7Oh5r9YECvZFi54KUJb42B39Nz2rDoeKZvz4HQH3DbxYGqvBj2RHmPMkA
 AFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723724610; x=1724329410;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=APSa0CAr27aScKJT1FD09vVPBEzhUq5PuP+JiMl+Qec=;
 b=hg/FDIdTGCEmNMUhE5S8cdAWHEAJmolPM3CNen9S58bl1crCXPlPECJWTvqH2Ukptu
 Sn7cVi7/SjJ3ajTksD/cGnTw6VrgRDa0BNTf/tLL7EC+AmQ6SYS9cg+kchG4IbkWTSsh
 k5/4/xZ+4vg/U1a7bmaeeOXqXVYYQ4tWPiD2iogIgdS+iCmVu8m2NazPFXeeb6+hdaBC
 j/uSJXp5BURFgXgMx+J030SUmFMRzVvf2TwbXYNEU9z/rZbPEbeUHS+0FzDaFcTCWGjM
 G40nIw+jfkHTYGVuI4Gz88HdpyoDcB+ZMgkV54MwSjimuHzR19n/+JyS72evl3U63KtC
 kA1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYkU5xqSIA4FVx+5gjfpTMHK8wfs2eWY4KITA0T7yp+bZR1aJ6Mb6Kr4RR1S2aaZX3Ge4/Rfo=@lists.denx.de
X-Gm-Message-State: AOJu0Yzw/Ij9qXmq3ZiUfd21h2h4osjgwZBqJsnD8BylabM0mN/FXrfP
 QuIYkunCudmRL6j9fN2WZLWq8fhTy38X6ow0qzqCs4Q/aMjiXKDmYZVU3Af95e4xvM4Ll2ca/o8
 n1wXhAus0cVHMSd2P61iOoZ/Scvq2lA==
X-Google-Smtp-Source: AGHT+IHUh8pqX0jQXuzjmm/3CSJt/Gr6lSU8fDc20Tsn8vrgq0/dKF4f2zBx3pAK9Z9ogn7x8Jf1Diz2VEpKhQgG704=
X-Received: by 2002:a05:6512:3196:b0:52f:413:30de with SMTP id
 2adb3069b0e04-532edbbf1cfmr2474450e87.7.1723724609531; Thu, 15 Aug 2024
 05:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240815080948.457524-1-lukma@denx.de>
In-Reply-To: <20240815080948.457524-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 15 Aug 2024 09:23:18 -0300
Message-ID: <CAOMZO5Az0AGJ=vR=iVMbM8sqCzWevH+Ja2yAnVVNOy9LV7kDdg@mail.gmail.com>
Subject: Re: [PATCH] config: imx: Define CFG_SYS_UBOOT_BASE for Phytec's
 imx8mm SoM QSPI boot
To: Lukasz Majewski <lukma@denx.de>
Cc: Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
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

Hi Lukasz,

On Thu, Aug 15, 2024 at 5:10=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wro=
te:

> +#define UBOOT_ITB_OFFSET                       0x57C00
> +#define FSPI_CONF_BLOCK_SIZE           0x1000
> +#define UBOOT_ITB_OFFSET_FSPI  \
> +       (UBOOT_ITB_OFFSET + FSPI_CONF_BLOCK_SIZE)

Putting it in a single line helps readability.

> +#ifdef CONFIG_FSPI_CONF_HEADER
> +#define CFG_SYS_UBOOT_BASE  \
> +       (QSPI0_AMBA_BASE + UBOOT_ITB_OFFSET_FSPI)

Same here.
