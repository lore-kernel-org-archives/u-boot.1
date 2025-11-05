Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DD6CCF9F8
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 13:25:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84A7383A32;
	Wed,  5 Nov 2025 14:25:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RIFPjRu3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A855B83A43; Wed,  5 Nov 2025 14:25:34 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD41E83A1B
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 14:25:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5942b58ac81so2718671e87.2
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 05:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762349132; x=1762953932; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3gGuiMg4K6F7Cv5xjGXJlqVEM9PnhTX/l5WjTyOl6R8=;
 b=RIFPjRu3LqmnlIaQ01P9RYHsEUVhUnsJ4XOz41H5GuIZtSfX1r4lWygkzNA4N+By7n
 AvVpqOmF1WA/wqfxnb0r1jrG5LjRRofVRiwpwZzUxdDZVMBQ3TPRUSwzlCDgcihxrVTQ
 RdGc3wjE0XPQVOn2DEjx7RdUY+uaTsJkiXS7zw1/1fqsPUzBXe/iYlpTPwU0HF4AkWkJ
 SIierAdN2G+aTggRsbZG+pmMUI/RxQMuV0xyD7nfOh/hcMn0N/CoEuCqOdyx5t+E9TZp
 e6vcK6A+gHQ6dkkpX6VvtVyieqkvnffEQAbIWFSlpib/ovBDui2A3CBoc+dt/qke3y8F
 zXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762349132; x=1762953932;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3gGuiMg4K6F7Cv5xjGXJlqVEM9PnhTX/l5WjTyOl6R8=;
 b=g0WRJl5QApBZlTI40sIkUBs3wJL6wJCF4nznWXG1K8wZAAyhs0xofJ1qzUY3m91IBQ
 WXmLQeutxPi2sTilbF4zZuJQf/Z5yBbq/VIsDgjPrFcW3jKbgipao9f4SgWSvfTcsZDG
 +FVzoUeWN6HrNF05FMMCCSctkcavS8pe94iqtGnhu1nWrp+UWbuxpA9ek2mh5+N6Lqw8
 mHV+IlARIMoWAAQdVEs4IDFMHz0gDskChllnhcZorjywpycXbFHsXqtSSX6zUtpkJLLE
 DbfQqKS2dz+tnRnIofBvArqc8jnYlOccBrwedpl55y+nB7R6Cc7joXg+9wKaEJ+jM5Cg
 YMYA==
X-Gm-Message-State: AOJu0YySBI6++PNBD7qwJFQgniHBGJl3VEX4sSQCik96NMTVweFcFml0
 21HfLwDhNvAWaCVB9je6TF827d6gl9REo8SX2T7Pc9zSnI9wcBMbidnUbPRlzjsIJQp5QmxV9jF
 igzPlrpCA/36dnN6OXjxQ7ubUDbtERgTYEWMNx8E=
X-Gm-Gg: ASbGncsIyR/eqX6nCUQQtsv9WAFc6p7hecbEjyVlVKK9QKzrMuBZTMESVW6rJyJbtdY
 J1/P11PeAZS6al5YgV6abiEGcGd7e8+w6UgFEWHW8zv4BZqsxl8QbpctsAXljDeCF/fKh6anhOE
 FSckvQw/22XUc10QfxwaZxEgvCUKHz+UginQCdKg2CKQmNuiwQTg0HCI76vnGf2Gbgfj780ZTkl
 EPKu3vJkSw5raD6MABmMQ8WmEmt8pLax7QsYFdEubKbgQXG3rqn+Ugs0bdOWzilGYJZoBRDyUfo
 Erm8UwSNrj2p9Hb5
X-Google-Smtp-Source: AGHT+IHbbmegliUS+rTi4B0RE8cisPJq82/EgfTXjP3dDsNjEF6Z5rvSQVajNTKPGbz6QglVrj89YD4x/vDqzU7QRRo=
X-Received: by 2002:a05:6512:3e10:b0:590:656c:d106 with SMTP id
 2adb3069b0e04-5943d7ee7f9mr1083502e87.53.1762349131500; Wed, 05 Nov 2025
 05:25:31 -0800 (PST)
MIME-Version: 1.0
References: <20251105071308.228223-1-andrea.calabrese@amarulasolutions.com>
In-Reply-To: <20251105071308.228223-1-andrea.calabrese@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 5 Nov 2025 10:25:19 -0300
X-Gm-Features: AWmQ_bmo0htlF6-4A3l_9tSWyBR_DRdteHfl69jNrR49TcRxwR4obgk3y7zYiKI
Message-ID: <CAOMZO5AR1+yo+yeUKAhHm73DxdWH4XpdRdD5YgO_Fd2MdnbA7Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] bsh: imx6ulz_smm_m2: Add imx6ulz BSH SMM M2D board
To: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
Cc: u-boot@lists.denx.de, michael@amarulasolutions.com, 
 dario.binacchi@amarulasolutions.com, trini@konsulko.com
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

Hi Andrea,

On Wed, Nov 5, 2025 at 4:13=E2=80=AFAM Andrea Calabrese
<andrea.calabrese@amarulasolutions.com> wrote:
> diff --git a/configs/imx6ulz_smm_m2.config b/configs/imx6ulz_smm_m2.confi=
g
> new file mode 100644
> index 00000000000..50dafd887f2
> --- /dev/null
> +++ b/configs/imx6ulz_smm_m2.config
> @@ -0,0 +1 @@
> +#include <configs/imx6ulz_smm_m2.config>

A file that includes itself?

You have not tested this, as this does not even build.

Here is my suggestion:

1. Make a patch that introduces configs/imx6ulz_smm_m2.config with the
standard defconfig options and convert the existing imx6ulz_smm
defconfig to make use of it.

2. Make another patch that introduces the m2d board.

3. Make sure it builds and boots.
