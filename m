Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C486C36008
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 06:49:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B88A81E14;
	Mon, 24 Mar 2025 07:49:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z5/c+wWS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD23081E14; Mon, 24 Mar 2025 07:49:00 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6583181DE3
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 07:48:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anarsoul@gmail.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-60009c5dd51so1053327eaf.1
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 23:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742798937; x=1743403737; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jZa7UNBgtmvh2tlxJ+GDOybo4jVEafBkRALuY/shYjo=;
 b=Z5/c+wWSNXKs+CKdei/GT0ZELwO+rPMF2WaK2Sqfr2iHFFUnHWhn2zRPkeXMUKVXDH
 AOukYPVCkO7bLEb9nrLYse7O1JoJ5RdkgHgOE/asO+kKeMPqeHV6tHb9eoSlyEDvqMr0
 klwBXaKHxVH8GAzLI6PGw7fPw+uxBzOHE0hB3sw1D+cFvBSG9xK8HzSuwXJc42+sLUMo
 scLDAneaGFzsFi86z6jSJ2u9UjKgwalTtBh0j8wPWaiktVab+S2kWhetRrxtcaAuKZyA
 B0xkLol4+TwNm6+CTASgkeaPWwHoIRr8ClwLvUDqINZ3IVldItMkWHGq+8dd0gIlr/2o
 ydrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742798937; x=1743403737;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jZa7UNBgtmvh2tlxJ+GDOybo4jVEafBkRALuY/shYjo=;
 b=bA3ZLKu4NBcRdLVkWl78IG2JUOZT4q1IXRtmDRxGby9Kc9R7nUxRt26/EeTnAgLRne
 39ItlgW+chkp7gwt5m3grYVJTkL28MzehoH7H8nAtBCsxy6D+gA1bxsUMrlUCLEv4Vht
 bUmXNNR8cX4wKX8zCoHVo68fmNMC8m15WCAEhAZKeKN07ndfFgPoNfgZhUP24HtgUc0X
 dnytM5TUxahNfY7lUERomYrNPL/25exxDhdNY9uCcmFal8SdsOK7dbpWlPqgZSjpfb/M
 GrOOEv75WiM0NHyDM+6YFq40pQfYyA0xIZv7B7Ru/VgZ82QnEoYBxKUKgs3YpdhRnMBL
 m71A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNgXeDaKLs8C9xVeTPf8wfs33WBI2aVoJGcx66ldEgbx5p6g9BcCLyJSuW0RkMMyLhaFpHPIA=@lists.denx.de
X-Gm-Message-State: AOJu0YwQu0vrjmU12AxJy+iqtVQg0GdZlRVZ7CWD7MgsgeSn5HSa2my/
 IO2yd06p7ZNIvx5D4Hyw67SkteUxs3HNZH2+kvp3wl8ntLnwK/Y/49s1BHpcGBWWJrbpRQiIwN0
 756VkfrMdZ1Og7LjNMFVt77x35a4=
X-Gm-Gg: ASbGncvNTfS+oVnwRyr0vHzvL8yYQ+I2JZwX03yMT7OJsdvdBdmSRRL2eCsRV5PXW/2
 YlKjAOD00DSYgTeA22r0pKW1z+auuE3nGl8u6pVxte4usLrE/EFdUJXma97F66xNNRjwMdovmnK
 3SEqD8h77NTUjEE3qCE69+4ZG4Wlp6igVjDNQYg/e0E9GSkTIh0MaQrbaSs+k=
X-Google-Smtp-Source: AGHT+IFksSEWkTwvCdaW5cA49+eLH1hxmC+QH4Nk+vyNsOyIcASg4hjqzU2rIem/v5D5yd8sIBD9m9UfBYlphjUcmh8=
X-Received: by 2002:a05:6820:4517:b0:5fe:9edb:eafe with SMTP id
 006d021491bc7-602345fddf1mr5181612eaf.5.1742798936963; Sun, 23 Mar 2025
 23:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250323225134.2369473-1-anarsoul@gmail.com>
 <20250323225134.2369473-2-anarsoul@gmail.com>
 <CAJs94EbLgAZ5hnrzDLF1eovmvY-M_qtmhNbBcDCATCX=Ht_YWQ@mail.gmail.com>
In-Reply-To: <CAJs94EbLgAZ5hnrzDLF1eovmvY-M_qtmhNbBcDCATCX=Ht_YWQ@mail.gmail.com>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Sun, 23 Mar 2025 23:48:48 -0700
X-Gm-Features: AQ5f1JqAWc5HhCqGd_XbPxBJzf6nw6keIFzeMaRyWFeRsv0G83xzo08UPZQW4XU
Message-ID: <CA+E=qVfWLNRia2Nr_0MhhBpCrxbJ9u8FBpbcMbO7xVymr_JWVg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] video: rockchip: rk3328: filter unsupported modes
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Anatolij Gustschin <agust@denx.de>, Jagan Teki <jagan@edgeble.ai>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Sun, Mar 23, 2025, 22:36 Matwey V. Kornilov <matwey.kornilov@gmail.com>
wrote:

> You say that the 4K works in Linux. Wouldn't it be better to fix the 4K
> support in u-boot?
>

Hey Matwey,

A proper fix would certainly be better, however I don't really have neither
time nor motivation to debug it further.

We can either leave it broken as it is now and wait for someone else to fix
it or plug it with a workaround for a time being.

I'd be happy to test the fix if you volunteer to debug it.

Regards,
Vasily

=D0=BF=D0=BD, 24 =D0=BC=D0=B0=D1=80. 2025 =D0=B3., 01:51 Vasily Khoruzhick =
<anarsoul@gmail.com>:
>
>> While RK3328 is capable of 4K resolutions, dw-hdmi driver in u-boot
>> seems to have some issue with 4K. 1440p or lower works fine.
>>
>> Limit max resolutions to 2560x1440x60Hz, by filtering the modes with
>> pixel clock > 297MHz
>>
>> Fixes: f3ea872970d603 ("video: rockchip: Add rk3328 hdmi support")
>> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
>> ---
>> v2: add a comment that max pixel clock limit is a workaround
>>
>> drivers/video/rockchip/rk3328_hdmi.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/video/rockchip/rk3328_hdmi.c
>> b/drivers/video/rockchip/rk3328_hdmi.c
>> index 763669c09be..ff351aaac7c 100644
>> --- a/drivers/video/rockchip/rk3328_hdmi.c
>> +++ b/drivers/video/rockchip/rk3328_hdmi.c
>> @@ -105,9 +105,20 @@ static int rk3328_hdmi_probe(struct udevice *dev)
>>         return 0;
>>  }
>>
>> +static bool rk3328_hdmi_mode_valid(struct udevice *dev,
>> +                                  const struct display_timing *timing)
>> +{
>> +       /* Limit pixel clock to 297MHz. While RK3328 support higher rate=
s
>> and it
>> +        * works in Linux, it doesn't seem to work in u-boot. That limit=
s
>> max
>> +        * resolution to 1440p
>> +        */
>> +       return timing->pixelclock.typ <=3D 297000000;
>> +}
>> +
>>  static const struct dm_display_ops rk3328_hdmi_ops =3D {
>>         .read_edid =3D rk_hdmi_read_edid,
>>         .enable =3D rk3328_hdmi_enable,
>> +       .mode_valid =3D rk3328_hdmi_mode_valid,
>>  };
>>
>>  static const struct udevice_id rk3328_hdmi_ids[] =3D {
>> --
>> 2.49.0
>>
>>
