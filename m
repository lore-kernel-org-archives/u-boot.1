Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5AAC41513
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 08:12:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 811C988485;
	Tue, 21 May 2024 10:12:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="KXZ0J/Ju";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="PYEA2URP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 081B288702; Tue, 21 May 2024 10:12:22 +0200 (CEST)
Received: from fhigh4-smtp.messagingengine.com
 (fhigh4-smtp.messagingengine.com [103.168.172.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7256888477
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 10:12:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 7942311400E0;
 Tue, 21 May 2024 04:12:18 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Tue, 21 May 2024 04:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716279138;
 x=1716365538; bh=f3oC/zx0syXsDjBDfOVvTk0TGfpGtG3aQ67l7oZeR3I=; b=
 KXZ0J/JuCucZnToBLdA3YhH+Gw7YMIGJ3gZHtlB08YCF+JBH0XIb9UyAbeml/iHp
 CRyEPLwNczl9sDqpGZtG6sdxfwxfhtNmaiHEvteBY+pUiACRyNg3BfJlawxflEDD
 oG5uYPoM9LxIPdzEWcsYPBOdEkh0UYX3DFV/+SNVo32gG0Hj2QeVrNI4xZdJk+L7
 3f70su4vdBlT88JQyeuoHE8RMcenV4dgOaU8ay+tEDLwzsj9Sfdja6I5j5Us7N4s
 GqsgDHUtob4kjT2mbSSY1OJY3E8Sd8PQlmNR5rpmHpLM9hgKk0Rm/Ox0CbuG+01O
 lQTMccLspa7bjorbyVmA6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716279138; x=
 1716365538; bh=f3oC/zx0syXsDjBDfOVvTk0TGfpGtG3aQ67l7oZeR3I=; b=P
 YEA2URPdXoUBIbl4rL9FPIGtMlkmLQZkYQYZ6G6BwuCNZ1WHSzVX/YiD6kPe/gI+
 WkGjv58+1bpkxYlKp5ZqA/lGLgz82rhKyJmoE3GChs7QPp7Sb4vW5yTlAYygfFlV
 9DO0xjm+5TuFmXh0qCqtsvY/wucdpwjYVjCPyDFv3k+0lIV20BBfEmuMlgLxE6No
 MS8pOqu8SzAuHiH6ZXH62Rk+0ZCgJ/oI0TsPJ/Nmgw8DZvkDq1p6PtsWOEfgmXxP
 dOAWa3SQBYoVWCXZOp5CLPTdBWTPbEVXJjOVOFf/FaCOEzVSLLNpNKk23kzyJ2WQ
 e2Y0It0rScFEK0b7z/nJw==
X-ME-Sender: <xms:YldMZlQEjLXQSrkPwkasXOvhye9K6o2Y7CexdgkJjCSRY0oxcxuJ0w>
 <xme:YldMZuxr5zUUB9gI4MAL6OlBedxRPynAUTQI4fTgXcGtPkdKtVogjTF29yPMjCX0O
 3MRUqc1sv5ENVSAuLM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeivdcutefuodetggdotefrodftvfcurf
 hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhirgig
 uhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefhjeeugeev
 tefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:YldMZq1Tb_u2BWQDDO-MtJujr64LfU7_s4VhOB3mwlqhVXzHlWMTjQ>
 <xmx:YldMZtB684HkLGBrAVw1lUcHRvezLdWm9pYYCCJm5m0xt3xqaEa8Aw>
 <xmx:YldMZujuBemCAS0Lk88aALu4Ss7qd3MFOUkg3-S6zuLLcJH2Egh5OQ>
 <xmx:YldMZhrF8XpxGmZWvGEJEig_7gGNeTqHa0xzPNXrkyo5_5pkaKJFmA>
 <xmx:YldMZmcDJpLapR7Pn8BGZ3Bq-BGnoTcfgOVtkG9m7HbzNRNqI8Q7Hazf>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 1117E36A0074; Tue, 21 May 2024 04:12:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-480-g515a2f54a-fm-20240515.001-g515a2f54
MIME-Version: 1.0
Message-Id: <b23506b1-7309-4cb2-bb6c-b7027c9deb90@app.fastmail.com>
In-Reply-To: <CAMo8Bf+HoyoDiKBVDkWeB=NLVO2zuYWbquk+2rp3znsUEor6pw@mail.gmail.com>
References: <20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com>
 <20240519-qemu-xtensa-v1-6-8fff0cb11c19@flygoat.com>
 <CAMo8Bf+HoyoDiKBVDkWeB=NLVO2zuYWbquk+2rp3znsUEor6pw@mail.gmail.com>
Date: Tue, 21 May 2024 09:11:58 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Max Filippov" <jcmvbkbc@gmail.com>
Cc: u-boot@lists.denx.de, "Sean Anderson" <sean.anderson@seco.com>,
 "Tom Rini" <trini@konsulko.com>, "Sumit Garg" <sumit.garg@linaro.org>
Subject: Re: [PATCH 06/10] drivers: serial: Add xtensa semihosting driver
Content-Type: text/plain;charset=utf-8
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



=E5=9C=A82024=E5=B9=B45=E6=9C=8821=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8A=E5=
=8D=883:31=EF=BC=8CMax Filippov=E5=86=99=E9=81=93=EF=BC=9A
> On Sun, May 19, 2024 at 1:53=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygo=
at.com> wrote:
>>
>> Add xtensa semihosting driver.
>>
>> It can't use regular semihosting driver as Xtensa's has it's own
>> semihosting ABI.
>>
>> Note that semihosting supports puts in serial but I never managed to
>> get it work, so it's putc only for now.
>
> I wonder, what were the issues that you experienced?

Never mind, I got it work, it was an off-by-one error in length calculat=
ion.
>
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>>  drivers/serial/Kconfig                     | 18 ++++++-
>>  drivers/serial/Makefile                    |  1 +
>>  drivers/serial/serial_xtensa_semihosting.c | 79 ++++++++++++++++++++=
++++++++++
>>  3 files changed, 97 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
>> index 1fe4607598eb..3a1e5a6f2877 100644
>> --- a/drivers/serial/Kconfig
>> +++ b/drivers/serial/Kconfig
>> @@ -501,6 +501,15 @@ config DEBUG_UART_MT7620
>>           driver will be available until the real driver model serial=
 is
>>           running.
>>
>> +config DEBUG_UART_XTENSA_SEMIHOSTING
>> +       bool "Xtensa semihosting"
>> +       depends on XTENSA_SEMIHOSTING_SERIAL
>> +       help
>> +         Select this to enable the debug UART using the Xtensa semih=
osting driver.
>> +         This provides basic serial output from the console without =
needing to
>> +         start up driver model. The driver will be available until t=
he real
>> +         driver model serial is running.
>> +
>>  endchoice
>>
>>  config DEBUG_UART_BASE
>> @@ -936,7 +945,6 @@ config SH_SCIF_CLK_FREQ
>>  config SEMIHOSTING_SERIAL
>>         bool "Semihosting UART support"
>>         depends on SEMIHOSTING && !SERIAL_RX_BUFFER
>> -       imply SERIAL_PUTS
>>         help
>>           Select this to enable a serial UART using semihosting. Spec=
ial halt
>>           instructions will be issued which an external debugger (suc=
h as a
>> @@ -1115,6 +1123,14 @@ config XEN_SERIAL
>>           If built without DM support, then requires Xen
>>           to be built with CONFIG_VERBOSE_DEBUG.
>>
>> +config XTENSA_SEMIHOSTING_SERIAL
>> +       bool "Xtensa Semihosting UART support"
>> +       depends on DM_SERIAL
>> +       depends on XTENSA_SEMIHOSTING
>> +       imply SERIAL_PUTS
>> +       help
>> +         Select this to enable a serial UART using Xtensa semihostin=
g.
>> +
>>  choice
>>         prompt "Console port"
>>         default 8xx_CONS_SMC1
>> diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
>> index dbe598b74064..78810f98367c 100644
>> --- a/drivers/serial/Makefile
>> +++ b/drivers/serial/Makefile
>> @@ -60,6 +60,7 @@ obj-$(CONFIG_MT7620_SERIAL) +=3D serial_mt7620.o
>>  obj-$(CONFIG_HTIF_CONSOLE) +=3D serial_htif.o
>>  obj-$(CONFIG_SIFIVE_SERIAL) +=3D serial_sifive.o
>>  obj-$(CONFIG_XEN_SERIAL) +=3D serial_xen.o
>> +obj-$(CONFIG_XTENSA_SEMIHOSTING_SERIAL) +=3D serial_xtensa_semihosti=
ng.o
>>  obj-$(CONFIG_S5P4418_PL011_SERIAL) +=3D serial_s5p4418_pl011.o
>>
>>  ifndef CONFIG_SPL_BUILD
>> diff --git a/drivers/serial/serial_xtensa_semihosting.c b/drivers/ser=
ial/serial_xtensa_semihosting.c
>> new file mode 100644
>> index 000000000000..1bf3c18537e7
>> --- /dev/null
>> +++ b/drivers/serial/serial_xtensa_semihosting.c
>> @@ -0,0 +1,79 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
>> + */
>> +
>> +#include <dm.h>
>> +#include <malloc.h>
>> +#include <serial.h>
>> +
>> +#include <asm/platform/simcall.h>
>> +
>> +/**
>> + * struct simc_serial_priv - Semihosting serial private data
>> + * @counter: Counter used to fake pending every other call
>> + */
>> +struct simc_serial_priv {
>> +       unsigned int counter;
>> +};
>> +
>> +static int simc_serial_getc(struct udevice *dev)
>> +{
>> +       char ch =3D 0;
>> +
>> +       simc_read(0, &ch, sizeof(ch));
>> +
>> +       return ch;
>> +}
>> +
>> +static int simc_serial_putc(struct udevice *dev, const char ch)
>> +{
>> +       char str[2] =3D {0};
>
> Why does it need to be an array if only the first element is ever used?

I want to ensure it's null terminated but it turns out to be unnecessay,=
 will
drop in next version.

>
>> +
>> +       str[0] =3D ch;
>> +       simc_write(1, str, 1);
>> +
>> +       return 0;
>> +}
>> +
>> +static int simc_serial_pending(struct udevice *dev, bool input)
>> +{
>> +       struct simc_serial_priv *priv =3D dev_get_priv(dev);
>> +
>> +       if (input)
>> +               return priv->counter++ & 1;
>
> This can result in blocking the whole CPU thread of the emulator when
> used with simcall-based semihosting and there's no input actually avai=
lable.
> Not sure how it would behave with the gdbio. I think something like
> the following:
>
> if (input) {
>     int res =3D simc_poll(0);
>     return res < 0 ? priv->counter++ & 1 : res;
> }
>
> could be used here to avoid that.

That worked out, thanks.

>
>> +       return false;
>> +}
>> +
>> +static const struct dm_serial_ops simc_serial_ops =3D {
>> +       .putc =3D simc_serial_putc,
>> +       .getc =3D simc_serial_getc,
>> +       .pending =3D simc_serial_pending,
>> +};
>> +
>> +U_BOOT_DRIVER(simc_serial) =3D {
>> +       .name   =3D "serial_xtensa_semihosting",
>> +       .id     =3D UCLASS_SERIAL,
>> +       .priv_auto =3D sizeof(struct simc_serial_priv),
>> +       .ops    =3D &simc_serial_ops,
>> +       .flags  =3D DM_FLAG_PRE_RELOC,
>> +};
>> +
>> +U_BOOT_DRVINFO(simc_serial) =3D {
>> +       .name =3D "serial_xtensa_semihosting",
>> +};
>> +
>> +#if CONFIG_IS_ENABLED(DEBUG_UART_XTENSA_SEMIHOSTING)
>> +#include <debug_uart.h>
>> +
>> +static inline void _debug_uart_init(void)
>> +{
>> +}
>> +
>> +static inline void _debug_uart_putc(int c)
>> +{
>> +       simc_serial_putc(NULL, c);
>> +}
>> +
>> +DEBUG_UART_FUNCS
>> +#endif
>>
>> --
>> 2.43.0
>>
>
>
> --=20
> Thanks.
> -- Max

--=20
- Jiaxun
