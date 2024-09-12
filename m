Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45772EE6450
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 12:40:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EFCA88FA0;
	Thu, 12 Sep 2024 14:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QZqUYqBI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F423488CFA; Thu, 12 Sep 2024 14:40:48 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40B2F88FA6
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 14:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5365b6bd901so1028790e87.2
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 05:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726144844; x=1726749644; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=05j6ha8PR/wiE3LUpcrmtadaOg6LDKYHwGEy3XUBhus=;
 b=QZqUYqBIUC7lQ6XTDj8LXtqJ/lp0pJRLmu7RncQQK+d3maHaQdgrXbEKGiCU0Jsx1A
 cb/vZRuWQ/hDtEMrT0MRROKx1KxXor5YBk4ms4gT6NdHfxrJYMHDdg3uW1rbk6I1Y2gv
 HMN/t+ripTRBw7qnBr7idx1RXSeKPPwb2cjMq36fhisR0aNSn9V7tGabwz0bYEV/qqbY
 2KsTX7QxrTYsHV4cHWGGwqd2T8onRgozkPEiAdYVEspW89a93gKM2aXPYF1qqEzNcuwm
 Tp8k0BMsXedLQYn8z7Zgq4XgeTEXzUpHD1MRzddqRzECBVWii93r7Ey3kF1OAFYBI+H3
 xFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726144844; x=1726749644;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=05j6ha8PR/wiE3LUpcrmtadaOg6LDKYHwGEy3XUBhus=;
 b=VVKupe6oF6rerFG0jBnUBXtAsdDAxjhUX07o5v1lHv9O4CpuiokMDRfy88QwldsTcx
 H7zZsVEHx5b2nZuy4KJcJ6zpcFR6sk/YxiTdDP55MTSRK6GJnvSbIPpdtjPT050e8kZC
 5VUXoCNzhegDLT+3167cixmqN3263wGB7MA9Pp0q3alabtts47p0iv7jP1oMWK8ZgnEY
 2yVKpvAzIl8EDdz19S+GOrm+dvEffFnOBpKOGiMLBimoOYdMvl0NZIJVOaQtlL8LZ872
 hLgHGMeLx+Mn9O9AnjNeDGUEBJ9nBkWp6caWYg3X3mDkQWoc5VE3kKvRoxR5wCztJref
 PHKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkQ24XDTtavLJvIpMlvBvmFAermdqrpO8Y8fA4q3xDEAgDxt6iIdys+tmMDBa7bNlEifspi7s=@lists.denx.de
X-Gm-Message-State: AOJu0YwlLEoRWXMNgZpNhXkUPf7RBy9TDmJPydM3kCwE/5qfOUu4Bnra
 CwYGgR3G6g0NZ1kRu6ieaUXA3BVAvs8ErkZgt3Z4u15cN8cAowaJlZcC16x6Y/frub3AHMcmR7G
 2qBnNyPe2R7liXqjFiJzoJXKlOEY=
X-Google-Smtp-Source: AGHT+IH6xB/mS3Nl4OmFsldtp7EeN1pSaf40Kkw1u9IZIHArw66AVjvlpKwlGJg6V7jXn8MrbD00uuoScw54zAdnTkk=
X-Received: by 2002:a05:6512:4013:b0:52c:842b:c276 with SMTP id
 2adb3069b0e04-53678ff49cdmr1724271e87.53.1726144844076; Thu, 12 Sep 2024
 05:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240910101344.110633-1-miquel.raynal@bootlin.com>
 <20240910101344.110633-6-miquel.raynal@bootlin.com>
In-Reply-To: <20240910101344.110633-6-miquel.raynal@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 12 Sep 2024 09:40:32 -0300
Message-ID: <CAOMZO5DSjFw3skT=My_R64gAVcRdb5JQ+LHo3vgiOkdCYXXtpw@mail.gmail.com>
Subject: Re: [PATCH 5/8] imx: power-domain: Add support for the MEDIAMIX
 control block
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anatolij Gustschin <agust@denx.de>, u-boot@lists.denx.de, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ian Ray <ian.ray@gehealthcare.com>, Marek Vasut <marek.vasut@gmail.com>
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

On Tue, Sep 10, 2024 at 7:21=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:

> +       /* Make sure bus domain is awake */
> +       ret =3D power_domain_on(&priv->pd_bus);
> +       if (ret)
> +               return ret;
> +
> +       /* Put devices into reset */
> +       clrbits_le32(priv->base + BLK_SFT_RSTN, reset);
> +
> +       /* Enable upstream clocks */
> +       ret =3D clk_enable(&priv->clk_apb);
> +       if (ret)
> +               goto dis_bus_pd;
> +
> +       ret =3D clk_enable(&priv->clk_axi);
> +       if (ret)
> +               goto dis_bus_pd;
> +
> +       /* Enable blk-ctrl clock to allow reset to propagate */
> +       ret =3D clk_enable(clk);
> +       if (ret)
> +               goto dis_bus_pd;
> +       setbits_le32(priv->base + BLK_CLK_EN, reset);
> +
> +       /* Power up upstream GPC domain */
> +       ret =3D power_domain_on(domain);
> +       if (ret)
> +               goto dis_bus_pd;

The previously enabled clocks should be disabled on the error paths.

Could you use clk_enable_bulk()?
