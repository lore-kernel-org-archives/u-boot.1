Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA7AC25B67
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 14:22:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D94AC87B72;
	Thu, 26 Oct 2023 16:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J5Q7UVgK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E27887B79; Thu, 26 Oct 2023 16:22:51 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7371087B72
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 16:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6bb744262caso221299b3a.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 07:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698330167; x=1698934967; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uP25pQezdHu1TKIhjmw57ZlQGUpVtbN/opzYWo9bnNM=;
 b=J5Q7UVgK/XWLE2MqbEtMXpKiMTxdioIRdWDg4dEF6HAGMOV2CAObEPjc9xG0AuuoBM
 WxvxWVrxxRrAU26ie0L3tCshX7zeMYG11GeaWGyBHUc3Zmi0g4bqjcm7Vm7XLFsgHDGy
 /6irOEATe8J0mO6sUbrDZQ6QRu4CojCht9zdLacmjvHl4ALnmFMhcpLRvqYozlZwh+Ft
 1++vNnEQ1eJdCEbEFhz2PVTXw27etO/3+1wrEtTKfnNilPjMcl6zyWkjRMvupIBEBBdh
 2y5rMJe+wOhxPnFvl024t/UfNm/pd8S98Mzc9WgXLIGDBbopU7/65m0j8xR8XKsEVdf/
 ctLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698330167; x=1698934967;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uP25pQezdHu1TKIhjmw57ZlQGUpVtbN/opzYWo9bnNM=;
 b=RCmUZ8ijKZvc1xTsZj43JrCaJMRS3SMwOPnh0pQAXO6E6v1M6Tcr4CiZoU4Gn0Q8+l
 /wQcQ89Zp5T8ILgWCscR39lnjNgdN1OaeS6+fjxzmUsTqLRMDjZnL7pk4S02juQ/jpTk
 DDb/AznyfbuW2E1B0UkjlpKrNyAtFzK29IAyPbAFzvnG9mptYp2O7rfA4US75gKyTibz
 iYw10clCN1JnA9wn+Cf0Mdi0VeLBq7VsQmDuGGih86EFA/2GUV36wC4wmhT9i/Y9O4s+
 e1GtFMzn+LtBeQpUN+YDZKUGE0xumv7DasJk33YhML6UfnH8VbyvgZ0OW4hVL2U1/iRQ
 l4zw==
X-Gm-Message-State: AOJu0Yx8G75G1Fh6rYesiY525p9babAlVHnpSvu6T2GUsbUlCyZXTA8J
 9wdRDML7Z5VlIb0gTXzjFgpjCTamEs4qJVdh8Wk=
X-Google-Smtp-Source: AGHT+IH8BZNYNkE5b6rDf2koM9MhdfpfVye2+nF87YWjUJr3WiOEgMC1TCFMnODXSuwKYTztqwtfExqN0XFWGolSXrE=
X-Received: by 2002:a05:6a00:26ce:b0:6be:a1e:952 with SMTP id
 p14-20020a056a0026ce00b006be0a1e0952mr18059094pfw.2.1698330167212; Thu, 26
 Oct 2023 07:22:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231020152516.57338-1-andrejs.cainikovs@gmail.com>
In-Reply-To: <20231020152516.57338-1-andrejs.cainikovs@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 26 Oct 2023 11:22:35 -0300
Message-ID: <CAOMZO5ASK6biMEy71XoTFn_qTd=+4R8HyAH4mGU4XTu10knvrw@mail.gmail.com>
Subject: Re: [PATCH v1] apalis-imx8: add USBH_EN gpio hog
To: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
Cc: u-boot@lists.denx.de, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Stefano Babic <sbabic@denx.de>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
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

On Fri, Oct 20, 2023 at 12:25=E2=80=AFPM Andrejs Cainikovs
<andrejs.cainikovs@gmail.com> wrote:
>
> From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
>
> USB host interface is not working on some Apalis Toradex carrier
> boards with Apalis iMX8 SoM. This is due to USBH_EN pin, which
> powers USB peripherals, having a strong pull-down on some boards,
> and a weak pull-down on the others. This USBH_EN pin is left
> unconfigured, which means it is in its default state at cold boot:
> input with a strong pull-up. As a result, carrier boards with a
> weak pull-down have this signal high enough to trigger power
> delivery to USB peripherals, and opposite - boards with strong
> pull-down on USBH_EN have this signal below the threshold needed
> to trigger USB power delivery.
> This change configures the USBH_EN pin as gpio hog, fixing this
> issue for all Apalis carrier boards regardless of pull-down
> resistor value.
>
> Also, update apalis-imx8_defconfig via savedefconfig.
>
> Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
