Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F46C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 22:12:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15D07877D3;
	Mon,  8 Jan 2024 23:12:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="QqNp9S+0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65C0D877BB; Mon,  8 Jan 2024 23:12:07 +0100 (CET)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com
 [IPv6:2607:f8b0:4864:20::a33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D87F986611
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 23:12:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-4b77c844087so1378470e0c.1
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 14:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1704751923; x=1705356723;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bg5QWWW8N3tksvYJro2HD9GqhtGvFApBcC6qEN5zl2U=;
 b=QqNp9S+0xtyystLEgRUUOU19sLMJ1ixtRaYqcE4iTCZTT7coJfW+uoZfUY47KoQS9/
 UvubKoY8mnGS+cJKkuWeORCeI1CDXETBU+YwtMl2zgbpV2iqs5MdNSNFZQM1QPtJXjAh
 RhCwUJRjWW8Tng2xq0vESGVTFlH7r/esBoBHZleRQlXKKpJiK8If5juP0REOmxoyGmBR
 N1+jp3Z7pl1bcrlrEriHjMQ9a810IoOSyqsxt6ryuDXsHLnTijtvp8nEkBktDTp38SOh
 jxgVr+0X2xhX5WSZAGj1TjwyWfiAbsvUPwHv+yE9gkuLV+vg+i/IfMjSSTESi0ZrYILw
 GFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704751923; x=1705356723;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bg5QWWW8N3tksvYJro2HD9GqhtGvFApBcC6qEN5zl2U=;
 b=DaTk2fDKUM0qFow5sfDjAYonNX/fcLhTBvz9QUg2oiJalhKlEkFB/B+bLWLkVO0nqJ
 jcHm6e4ks0GrvmeZhbUMSTLlojyGitlXy9XPJ71aqZozgShxCq+C44/MUYcPjlYR31ni
 V7hRT6uhOa2tLd6loX75cNk0lMO+vHzlxEyoWK9y+4h0lpbRtlijvR5KgQQvMLBlh2GK
 vb5Ovd4mrBMm9BD+0GgNsmDZqxSxJnOQapvcUD9Ov1hgoc6Msbgcj2XAs2j+vcB4PqiH
 hgBbjObQ8afP3uV4wnwl9AIJUK7tOaBCm9X32chmocHvfrisZ3s0R9jCu1SfOrjQ6Oaa
 3Lkw==
X-Gm-Message-State: AOJu0YwTaL2vIk/L8xTvfiQAfwFrvx9sh/wrvHWvH9UfUSRxgmSmh2MK
 wSQUDz1vHpFx68XaBnel3LgfxFJvhnuqdmvBe/MhcsUmMUpn8w==
X-Google-Smtp-Source: AGHT+IFXH4KskM0btFxm+dSmg/doUnDwlO0ikDSJ3gR9m0Je25/DtPa3r5a0nAt0CkqB4tawW5DQDtXpEPPt/qntoas=
X-Received: by 2002:a05:6122:238e:b0:4b6:be22:cfc3 with SMTP id
 bu14-20020a056122238e00b004b6be22cfc3mr340535vkb.8.1704751923571; Mon, 08 Jan
 2024 14:12:03 -0800 (PST)
MIME-Version: 1.0
References: <20231209181057.331815-1-i@shantur.com>
In-Reply-To: <20231209181057.331815-1-i@shantur.com>
From: Shantur Rathore <i@shantur.com>
Date: Mon, 8 Jan 2024 22:11:52 +0000
Message-ID: <CABEcMwWzt=z=3XNWq5iAKmmnB+UsjTzp4_OUs3V8bNuc_i5zMw@mail.gmail.com>
Subject: Re: [PATCH v3] common: usb-hub: Reset hub port before scanning
To: marex@denx.de
Cc: bmeng.cn@gmail.com, clamor95@gmail.com, Hector Martin <marcan@marcan.st>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

Hi Marex,

On Sat, Dec 9, 2023 at 6:12=E2=80=AFPM Shantur Rathore <i@shantur.com> wrot=
e:
>
> Currently when a hub is turned on, all the ports are powered on.
> This works well for hubs which have individual power control.
>
> For the hubs without individual power control this has no effect.
> Mostly in these scenarios the hub port is powered before the USB
> controller is enabled, this can lead to some devices in unexpected
> state.
>
> With this patch, we explicitly reset the port while powering up hub
> This resets the port for hubs without port power control and has
> no effect on hubs with port power control as the port is still off.
>
> Before this patch AMicro AM8180 based NVME to USB adapter won't be
> detected as a USB3.0 Mass Storage device but with this it works as
> expected.
>
> Tested working after this patch:
> 1. AMicro AM8180 based NVME to USB Adapter
> 2. Kingston DataTraveler 3.0
> 3. GenesysLogic USB3.0 Hub
>
> The drives were tested while connected directly and via the hub.
>
> Signed-off-by: Shantur Rathore <i@shantur.com>
>
> ---
>
> Changes in v3:
> - Split up patches as seperate series
>
> Changes in v2:
> - As requested, added fix for regulator-always-on in RockPro64
>
>  common/usb_hub.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/common/usb_hub.c b/common/usb_hub.c
> index 70279f301d..3fb7e14d10 100644
> --- a/common/usb_hub.c
> +++ b/common/usb_hub.c
> @@ -174,8 +174,10 @@ static void usb_hub_power_on(struct usb_hub_device *=
hub)
>
>         debug("enabling power on all ports\n");
>         for (i =3D 0; i < dev->maxchild; i++) {
> +               usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_RESET);
> +               debug("Reset : port %d returns %lX\n", i + 1, dev->status=
);
>                 usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_POWER);
> -               debug("port %d returns %lX\n", i + 1, dev->status);
> +               debug("PowerOn : port %d returns %lX\n", i + 1, dev->stat=
us);
>         }
>
>  #ifdef CONFIG_SANDBOX
> --
> 2.40.1
>

Do you think it is the right time to get this in early so it can be
tested for a longer time before the next release ?

Kind regards,
Shantur
