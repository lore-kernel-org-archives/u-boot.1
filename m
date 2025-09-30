Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DE1CCA468
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 12:35:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7696D83045;
	Tue, 30 Sep 2025 14:35:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="HQxf4zOd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3F6583071; Tue, 30 Sep 2025 14:35:27 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC400828A2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 14:35:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yegorslists@googlemail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-366ce79fbeeso52468341fa.0
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 05:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1759235724; x=1759840524; darn=lists.denx.de; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0n43T3tIr/FIAgtt+HoXoSnQS8tZVBfzPacjlPniLAY=;
 b=HQxf4zOdjmGI8OlGO5QqvVzDxJtojc9gb1Lao+ooXk9bQOblxfRr9BeFmIOl0sKkVQ
 MS9n5/IEKsRDbEwv3pDyVn7ofvHhlkxsNRjPQgNiQXqe0BEFJs9tsams28XlnNXrF6to
 RveWN+yH9GjVZuzMDX42zodylBpoUhIFj/QuMDGSIcwjcT/hq2sBEJM9kL2+b2AH9oIO
 epy7KWwgLUPEBkYphyr9CemcAEUGQZtxfX/bO0/0Rheww6MZD8IQzUbpLdBLQm2zWWOr
 QTfHE6ff8gu0C2h0mSn0l0hwIWvNAxbLESaVmN/CN7CE6im/ENKYb6pBUtMn6N3cWlsU
 5vzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759235724; x=1759840524;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0n43T3tIr/FIAgtt+HoXoSnQS8tZVBfzPacjlPniLAY=;
 b=gaHxv8wyglOYQGWP3sqjyXysA64EPsIa8qX/3XIKjqy/xLJk1X8j6MDrOGapix7KVC
 VUCNEXid2fHX5mIzG8C3dlK6xL+L8RINUUwXaw5CsWS6qOGXYEfRiQtFzXYm19pneb+a
 8tHfE5+fp82SXnFBW1H0Zl1m8kVnQQtzMvYG0XpG/BAH3t+e5/IR2h9mF8smUg2/WsBP
 uk2/s/KVDqoq9ryP3PhndG57JbePCsOUw68UP7LZqjp0jtGKDdoyfL9t65bAs2Z4fYdV
 e47kilp22qxjJ30qwF10Mkchfm20XeqpgWiq6U1MVpl02WhF0FTS4J7PrFMp/XOKvtxD
 iBpA==
X-Gm-Message-State: AOJu0YxBuf8miT2Vfg996pubeRrL+8cOxAKDiGpllZvba8hLlJXoq8Jr
 xjtd9dT5u3fatsYAakXfaI+y+191VHRrDY34npyySO8duKRigWiGOCpKQqqFJ72ZHBOZRHO2RCt
 BzfcRvhFH9zgnrHuuvwRqHHn8zyUPMEn0ChBi
X-Gm-Gg: ASbGncsrU23IAqH2cQTtG21kZz15GuThX/v3gphcerG3AwLniIC5W/2fV99u1LxS2cn
 +HGmmmbpY8AUigJtH1BjYZYqQKbBjrp4L8PqG41DD11INa4wSzfpcHPm4xCLkdwwt6gxv82UR0P
 JphgPldLS1vQv3l26n05TPrWCuCBK6d+Fb0b2HvaHhN5mWbNMWExZjvznY03diTR3INJf7CbF8h
 WeviQMxXAe5w5kWPCzFZ/ICsyYTfNbQiC/cT15rQn6VzjXdNM/K9Q==
X-Google-Smtp-Source: AGHT+IFUcisjhCU7ajzuBalPCIz4OF6wRfF6hUoGqNPXdR84NTnrHayXQ07OovPjkk0Nf34I8Gz8WPKAqAbOf9RZi8c=
X-Received: by 2002:a2e:a584:0:b0:36c:c5d0:715 with SMTP id
 38308e7fff4ca-36f7ec75688mr72537901fa.29.1759235724191; Tue, 30 Sep 2025
 05:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAGm1_ktFBBuogJjpO4mXZSv3ZvJxmgpVqgV=A8uRhc5RcALpJw@mail.gmail.com>
In-Reply-To: <CAGm1_ktFBBuogJjpO4mXZSv3ZvJxmgpVqgV=A8uRhc5RcALpJw@mail.gmail.com>
From: Yegor Yefremov <yegorslists@googlemail.com>
Date: Tue, 30 Sep 2025 14:35:12 +0200
X-Gm-Features: AS18NWDJEGy4ZyJruKBfxzLzF9UcwvSKEvECjjWSOsq2C6XpmVmGlg8bVnS2B5A
Message-ID: <CAGm1_kvvPKfD_vwu6QAzqxS4L7xVBSfw+Xzmw5O8cN3axEYrAg@mail.gmail.com>
Subject: Re: activity-led usage
To: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Tue, Sep 30, 2025 at 12:29=E2=80=AFPM Yegor Yefremov
<yegorslists@googlemail.com> wrote:
>
> Hi all,
>
> I added the following LED definition to the am335x-baltos.dts:
>
>         leds {
>                 pinctrl-names =3D "default";
>                 pinctrl-0 =3D <&user_leds>;
>
>                 compatible =3D "gpio-leds";
>
>                 led-power {
>                         label =3D "led-red";
>                         gpios =3D <&gpio3 0 GPIO_ACTIVE_LOW>;
>                         default-state =3D "on";
>                 };
>         };
>         user_leds: user-leds-pins {
>                 pinctrl-single,pins =3D <
>                         AM33XX_PADCONF(AM335X_PIN_MII1_COL,
> PIN_OUTPUT_PULLDOWN, MUX_MODE7)     /* mii1_col.gpio3_0 PWR LED */
>                 >;
>         };
>
> The gpio-leds driver is working and I can toggle the led-red via the
> led command.
>
> Then, I created an am335x-baltos-u-boot.dtsi file with the following cont=
ent:
>
> / {
>     config {
>         u-boot,activity-led =3D "led-red";
>     };
> };
>
> I have also tried "led-power" instead of "led-red".
>
> In my final DTS files I have the following nodes:
>
>         leds {
>                 pinctrl-names =3D "default";
>                 pinctrl-0 =3D <0x56>;
>                 compatible =3D "gpio-leds";
>
>                 led-power {
>                         label =3D "led-red";
>                         gpios =3D <0x57 0x00 0x01>;
>                         default-state =3D "on";
>                 };
>         };
>
>         config {
>                 u-boot,activity-led =3D "led-red";
>         };
>
> U-Boot cannot find the activity-led node.
> ofnode_options_get_by_phandle("activity-led", &led_node); returns -22,
> because ofnode_path("/options/u-boot") fails.
>
> When driver debug is enabled, I also see the following messages:
>
> bind node config
> Device 'config' has no compatible string
>
> My am335x-baltos-u-boot.dtsi code is similar to what I could find in
> arch/arm/dts for the boot-led usage.
>
> Where should I debug further?

Should activity-led be also mentioned in doc/device-tree-bindings/config.tx=
t?
