Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610AAD29C28
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 13:15:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B03918389A;
	Mon, 19 Jan 2026 14:15:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="q00l88SA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87CB48397D; Mon, 19 Jan 2026 14:15:17 +0100 (CET)
Received: from mail-dy1-x132d.google.com (mail-dy1-x132d.google.com
 [IPv6:2607:f8b0:4864:20::132d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69F9380B98
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 14:15:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-dy1-x132d.google.com with SMTP id
 5a478bee46e88-2ae38f81be1so4827390eec.0
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 05:15:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768828513; cv=none;
 d=google.com; s=arc-20240605;
 b=WTCAhRngsEnV9dsLV9tQR6635/s7e9ZPNbQ7+Ph/e2+9ujmPVXVmpwmEz2tg8Gqz6n
 FQALz+VCSygqFQLnKDVrzYINfq1UrtMKNs5fnIL9RxaXSFBzS3pEsGXAYcZJLfJhkDUT
 VAwuFv4uEKNPBuly+sxFoKi9wut34WKl12r0XwXR9fYnxn7C0tmNT87Fm7s22RKUhXEa
 DhqOmPDy44LKQva+VvsWcxytglkvkjpabDchAwmQhx/sA2pcU2+sShEj6mPrZgK3MnKj
 e2HisIVdSSfejaUGmu66If2vVwzzoNU4bzki2ngtff0f7o1ZoGmvUEFa9GqbYJDeeQnk
 sSPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=T+1N5mpHTwzdq7jUimQLuy42jtqUeERH+BCKrvN7SLE=;
 fh=McDWvzrSvZxvhSOpZ435/Ypq/ssIVb6gl73G4cialZI=;
 b=I27QKfHq+yYAxMMoiYAAkx3bj89bc1B+MzWC/Jv121VCzVqdQ/i6r7eZE9YFEA5Kqg
 2pumI7rsghCnWXjvJUNqcMYHCpB1+614C92x+otNwJHZNmHQPA95M78aaA0bqVgOgP1m
 PvjsGpGzTkjAYLrF38kqYSpJ/G5zKdHQDK/h8MRZviTmiMPxEcHjfAhP4lP5vxvpX50t
 ET3YaA5FqzosTOqw0hgzw+Hp0sepHsSDR99C8ENCorLKViAHJzMYbjJ4Qle5wUYHiZXK
 ZlfdM3CbCgrXMEIS4dAdwDByk5wbzb2VibKJ7fWKOZeBstMVBoRzPkbHbS/cwY57/tL1
 ZtBQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1768828513; x=1769433313;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T+1N5mpHTwzdq7jUimQLuy42jtqUeERH+BCKrvN7SLE=;
 b=q00l88SA9adrGKaqIvt2K82JnGXTgjs1LSbEu2SBiaZTHumh3dk5su3puCQdpkDhsb
 4F4UIglk1Pzkd+ShmcvW2nIFByIKf5NwT7IFhJFC4izzzp3sbcuT7d/F9IULOqEHI/6y
 tAzI1EMsvhU5f6ksS4xr0pIWjUxlW2ciOQB2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768828513; x=1769433313;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T+1N5mpHTwzdq7jUimQLuy42jtqUeERH+BCKrvN7SLE=;
 b=acv9kLG/hpwOvueH3emAwsqnvSk8H6Ty4QRztMBJiADDCOAed7TDvpTTTg1NKb7fEY
 oe7l0qyOiok3lxLITjW31ZcE61DM8Avkm3t9BV+gdPQ9FyDTJv35zIDKb+nhrKAaOZU6
 rOpc+3v3C8FoqJ2EvYV91yoWvm6xu3tOJfCtJ2j7N693YcCJQwBYjN5ZCF8WdoGRJ1oK
 wJf8yEZD1/BMEDNJp/F7d/Nz+bQ2shvmxWB4r9HldCc8EA2FJKq3q9Tgxw88uJjBQazP
 35sbcgOBQIkLVeFp+M6BYlao2fwxJElqN/CrfgM1lHgPH43+BXoM2mZI7+/K1UM4oBQU
 JG8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq2W+suT8EwLxQpmcE61LttzlMUJTASqk0y0/zNns5uzBTVL9UDACKnt4fTje3u33uT177ME8=@lists.denx.de
X-Gm-Message-State: AOJu0YxTZyXDhT2ocn2xC6rfqMNc+uKCYLtBz+MzzTssYHTKBaEPrOvN
 G0BfGwcpHMnVrqKNIXi3PH+esuH5o/Qimwjw2Dr2RWJ0ozVB0Sf66zqrqCbQ4TOFYd9wKxyozdY
 QHRhaNOOO8pkdjwnjreqQZqoKd/lxnASJi4Sn2DBWGw==
X-Gm-Gg: AZuq6aIxlBdwxvXuaclHuMqi1/sOLxMj/bttQ2spbQwSXfJgfo4p/fTK7lX6Ltaarf3
 SjzFVFA3X/OuT1ZRgDf7d+utJ7JiXZSo/UsJdiB/XGDkNFGbrP92H3g9vSbLYEKdKXg2H0yulM6
 CzFLhm6/5658q22PvvbPuyOWQMiUtLHhZd5DpyW/h/tCaUpWyW0FJRoSakscpB6iuKpJq+N35BX
 5m8qrZC0mfWcRomRJ3Hp97RAXWjhYPe9cGIMGX2AEu1EBZW6sUZNBYLiqE9GCnrT2+7ZfByN8nu
 GDvZIgJ1mJ9+zNL0i7Qo28HyJrA=
X-Received: by 2002:a05:7300:1908:b0:2af:fbb:97d6 with SMTP id
 5a478bee46e88-2b6b4ebf3c1mr8948543eec.42.1768828512064; Mon, 19 Jan 2026
 05:15:12 -0800 (PST)
MIME-Version: 1.0
References: <20251028091256.600992-1-richard.genoud@bootlin.com>
 <20251028091256.600992-3-richard.genoud@bootlin.com>
 <2aa84436-8a19-48d0-b2a3-c4b40102a81a@arm.com>
 <2a1824b5-e514-4eb0-8e08-2d4307f86c44@bootlin.com>
In-Reply-To: <2a1824b5-e514-4eb0-8e08-2d4307f86c44@bootlin.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 19 Jan 2026 14:14:59 +0100
X-Gm-Features: AZwV_Qiip_VnBfr6jG3OOwr3azijEK8EBExvihwo0I7vbXAglWe7voW5ZH8q2aM
Message-ID: <CAOf5uwkHyKJ_x74v4uXaexWMvM0e=0UXtxhCwaLOa5p7NxLLMw@mail.gmail.com>
Subject: Re: [PATCH v2 02/24] mtd: rawnand: sunxi_spl: fix pointer from
 integer without a cast
To: Richard GENOUD <richard.genoud@bootlin.com>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Tom Rini <trini@konsulko.com>, Hans de Goede <hdegoede@redhat.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
 Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Dinesh Maniyam <dinesh.maniyam@intel.com>, Anand Gore <anand.gore@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>, david regan <dregan@broadcom.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
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

Hi

On Mon, Jan 19, 2026 at 2:13=E2=80=AFPM Richard GENOUD
<richard.genoud@bootlin.com> wrote:
>
> Hi,
> Le 19/01/2026 =C3=A0 12:12, Andre Przywara a =C3=A9crit :
> > Hi,
> >
> > On 28/10/2025 09:12, Richard Genoud wrote:
> >> Fix pointer from interget warning when compiling for ARM64
> >>
> >> When compiling for arm64, we get this error:
> >> error: passing argument 2 of =E2=80=98__memcpy_fromio=E2=80=99 makes p=
ointer from
> >>             integer without a cast [-Wint-conversion]
> >>
> >> Moreover the copy should be made with dedicated readl(), like for any
> >> register access on this peripheral, since they are 32bit wide.
> >>
> >> So, instead of memcpy_fromio(), just use a readl() loop.
> >> Introduce nand_readlcpy() to implement this loop.
> >>
> >> Fixes: 6ddbb1e936c7 ("spl: nand: sunxi: use PIO instead of DMA")
> >> Suggested-by: Andre Przywara <andre.przywara@arm.com>
> >> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> >> ---
> >>   drivers/mtd/nand/raw/sunxi_nand_spl.c | 14 +++++++++++++-
> >>   1 file changed, 13 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/
> >> raw/sunxi_nand_spl.c
> >> index 4f1e2d9a5775..a15f54573df2 100644
> >> --- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
> >> +++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
> >> @@ -251,6 +251,17 @@ static int nand_change_column(u16 column)
> >>   static const int ecc_bytes[] =3D {32, 46, 54, 60, 74, 88, 102, 110, =
116};
> >> +static void nand_readlcpy(u32 *dest, u32 * __iomem src, size_t len)
> >> +{
> >> +    if (len & 0x3)
> >> +        printf("length should be multiple of 4 (32bits access), data
> >> will be incomplete.\n");
> >
> > This should not be a message printed on the console. There is only
> > one(?) internal user, and the argument is a multiple of 512, if I see
> > that correctly. So it's an internal error that wouldn't happen at all i=
n
> > the moment. It just blows up the code size, and isn't even very
> > descriptive.
> >
> > If you *really* want to check that, you could try to use something like
> > builtin_constant_p, to create a compile-time error, or maybe use
> > debug(). But I would suggest to drop it completely, as it would be
> > pointless with the current code anyway.
> >
> > The rest looks fine, thanks for adding that function.
> Indeed, I can drop it and add a comment to warn future users in this driv=
er.
>
> @Michael, do you want me to do a v3, or just apply this v2 and I'll send
> a fix? (or you just remove those lines when you apply the patch?)
>

No, I will do by myself, I will send a new pull request by today

Michael

> Thanks !
>
> Regards,
> Richard
> >
> > Cheers,
> > Andre
> >
> >> +    len >>=3D 2;
> >> +
> >> +    while (len--)
> >> +        *dest++ =3D readl(src++);
> >> +}
> >> +
> >>   static int nand_read_page(const struct nfc_config *conf, u32 offs,
> >>                 void *dest, int len)
> >>   {
> >> @@ -310,7 +321,8 @@ static int nand_read_page(const struct nfc_config
> >> *conf, u32 offs,
> >>               return 1;
> >>           /* Retrieve the data from SRAM */
> >> -        memcpy_fromio(data, SUNXI_NFC_BASE + NFC_RAM0_BASE,
> >> +        nand_readlcpy((u32 *)data,
> >> +                  (void *)(uintptr_t)SUNXI_NFC_BASE + NFC_RAM0_BASE,
> >>                     conf->ecc_size);
> >>           /* Stop the ECC engine */
> >
>
>
> --
> Richard Genoud, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com



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
