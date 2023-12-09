Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4A8C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 17:57:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F72F807A7;
	Sat,  9 Dec 2023 18:57:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="UwOdNqbs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40D6B87479; Sat,  9 Dec 2023 18:57:15 +0100 (CET)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com
 [IPv6:2607:f8b0:4864:20::a33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 174AB86E05
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 18:57:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-4b328087918so563196e0c.0
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 09:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1702144631; x=1702749431;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=57WxtJiABNXOWnniOr2HoPA7qpWViCXbvP7/OkpN2ts=;
 b=UwOdNqbs1Or3xd+wEpKEgMQ8wU9cEuF8096aj9mTkMvapBrCtCy7sdx3mKNymdo5py
 bq/pMKUx10Iv7wZGyWtaSCQh+mpyh9omXOXK9A2tg0MZR4UOrOMACqVzVx/YMs1BH48N
 vnhFsMnEiFLk59SfgYhW/ONVOP92bY8jKpJo5w9Ua5yybGELuNcX7lUWE5V1MPDnZN9v
 RaO5EUOEiGhNQ7ErFLhGsoPGqK0LOe1Xugl/e77IMnSDWQ5muq3TBXKhYSVjA9pKV//C
 2uhNdQ8SCmdGK8QBHWsmymE9zXUisjiAOQOQlyHAzB/rcFiUi4HS6gUZIjJagr6O0ThM
 7hzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702144631; x=1702749431;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=57WxtJiABNXOWnniOr2HoPA7qpWViCXbvP7/OkpN2ts=;
 b=FMkuH/P8HNyLzG3OddsZoItYfqeK0LIIdrjgyiw75bch98c8VKIWDRk5CF+kj8TwoX
 3R/LdSylsVLKkNgw8QL7IVbjvh/2RnUQitjXoH/0eznbEbqsLtzEPg9Vi4qJ7VW3gXF6
 jLm1xAcuFPOpHSyP/HRjq1xT8fhFEI3+oiYDBnCQKTRpLcyzanBlqy2fdX4a5/iiuBqk
 5iKFyrQLmJFVGuUVmx9Tcn70ec6+nIe1mbSL+hskEzCeBGY4vANeEuEBVGnszdvwl3ZA
 bJ6XG9drPk8unNXhz5c6icYRFFWZ4W08T/fDqdbP3CaTm6uoT94xBJR05FtqpSdRvh9P
 46tQ==
X-Gm-Message-State: AOJu0YyKkwvMeIDjUaC39BIan0sgNJ9NmJDS8IvPXMOz8aFXGhDcZgDg
 gItrgdOqRlNlLppMIqVR99sKLqlzuITCmgKf2bp5JQ==
X-Google-Smtp-Source: AGHT+IHHziEai1fVqFWO+VqR5ORJz00O+2dhAi1cC9ARSTpCPhz6e957hy6g8WDOMEdPGTptpGfu65nkosyGaNDGHfo=
X-Received: by 2002:a1f:fc8f:0:b0:4ab:f1f8:3171 with SMTP id
 a137-20020a1ffc8f000000b004abf1f83171mr1258293vki.6.1702144631721; Sat, 09
 Dec 2023 09:57:11 -0800 (PST)
MIME-Version: 1.0
References: <20231208000947.248849-1-i@shantur.com>
 <20231208000947.248849-3-i@shantur.com>
 <edd57912-f38f-4589-bb21-c638db8535e1@denx.de>
In-Reply-To: <edd57912-f38f-4589-bb21-c638db8535e1@denx.de>
From: Shantur Rathore <i@shantur.com>
Date: Sat, 9 Dec 2023 17:57:00 +0000
Message-ID: <CABEcMwWA1FzdPtvRBwk_9KaXC12R1OCDMoOtuFSvuG8XhphQdQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dts: rockpro64: Disable usb regulators-always-on
To: Marek Vasut <marex@denx.de>
Cc: bmeng.cn@gmail.com, clamor95@gmail.com, 
 Jagan Teki <jagan@amarulasolutions.com>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
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

Hi Marek,

On Sat, Dec 9, 2023 at 5:31=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 12/8/23 01:09, Shantur Rathore wrote:
> > USB port regulators should be controlled by phys
>
> PHYs
>
> > so we remove always-on property and let phy manage the
> > regulator.
> >
> > Typec port has misconfugred
>
> misconfigured (typo)

Thanks will fix both typos in v3

>
> > phy-supply in upstream and
> > now that we are removing always-on, we need to fix the
> > phy-supply until its fixed upstream.
>
> Where is the upstream Linux kernel patch ?
> Was it submitted already ?
>

No, there is no patch yet for this in Linux upstream.

> You should send this patch separately, it doesn't depend on the USB Hub
> 1/2 patch and will go in through different (rockchip) tree.

Sure, I will split and send v3 for these now.
