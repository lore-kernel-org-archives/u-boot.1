Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6544DC4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 09:31:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7F3B87075;
	Tue,  5 Dec 2023 10:31:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GF7ZX589";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17FA88778B; Tue,  5 Dec 2023 10:31:23 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 226A887032
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 10:31:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-54c77e0832cso3799904a12.0
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 01:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701768680; x=1702373480; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1/PMkemd1N51W6tKzqlySXP6pLPpGpitlPsRrwQTalw=;
 b=GF7ZX589tcMnihPkphNi3qRiTSU3OtNrRQsdJF45lDUTJlplnlMIzeHjR1csWsyIrk
 Iek2NxdJqWbt97K0wFGwbeOzkFwQJK0roGrcwcKg6yXz09n6p4hC1TgXZJfzqLrf/Ury
 ZFdO3ZKJQ3M2zuaObrZ/FYtnrfthR7Xr/L3myK+fBXFw/RV0BRpK+basu2np+MwB4adJ
 4qZEhzbO+s1bx4OZNnY9AT20izxFdVcEoXkD9+T0qPjFqlGkOIbqYK5GSdaK1htvGrJO
 8yVN8OXF28TjXqECSZmBd7NFqNHB3fYCmuu55XiydZQYcg98LPwBXctwkB1+FleMrC/q
 uGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701768680; x=1702373480;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1/PMkemd1N51W6tKzqlySXP6pLPpGpitlPsRrwQTalw=;
 b=N7OKVh8spW0h+VrHw6lbtxy0qFWlupoqXiqV5NFzWd6uK/LDCZX205lvXra7ImcPxv
 cVcT025U7pnZxQJabCiDQoDPAgrPvVPV0F5yZ7Ec5iz2Iie6G6eFkuTliK1v5d1gTkxp
 u18B+LrBsVeIxT01r7oGELY5ZM4gOn7XiJBB8d5vuwWd0sY5yX2/cmTY7cRGO/+w/x12
 d2fLWYuZOh4M0g6Q2lPLMUMwiqjiHkpYdNZTaXX5Qo55ITo7rVjKxfKta7wiApqYfbkJ
 VKaqsb5khG9RBeMunlNS+ezy8ztPfL+YXQhcZsTJ/ol9x6TV5/ciuMpy6yFd0+8K+VMH
 u2JQ==
X-Gm-Message-State: AOJu0YydJaI+gVVHRoRpOopyYMTo9tCgUphw3wXyyL6peyx9INKdI1ic
 gprm1sIYnq/phWAz0Db5hgZddPUYeYPxoImMO5M=
X-Google-Smtp-Source: AGHT+IEn4HfjZt1Gh8B6/V4kb0GaSwwGTaVB3jk1YgT2eb2aGrKoEvS0C2akVP6QiPr2q2VFxSq7DZpNcURwknRzxqQ=
X-Received: by 2002:a50:a41a:0:b0:54c:6814:3f2f with SMTP id
 u26-20020a50a41a000000b0054c68143f2fmr3609204edb.14.1701768680516; Tue, 05
 Dec 2023 01:31:20 -0800 (PST)
MIME-Version: 1.0
References: <20231126194647.2238775-1-jonas@kwiboo.se>
 <DU2PR04MB85360F97227B1019F60BE231C2BDA@DU2PR04MB8536.eurprd04.prod.outlook.com>
 <e37902b2-0d0e-4b3b-864e-8450239ad1ef@kwiboo.se>
In-Reply-To: <e37902b2-0d0e-4b3b-864e-8450239ad1ef@kwiboo.se>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 5 Dec 2023 09:31:08 +0000
Message-ID: <CALeDE9MY74ndtWQB=R0erXGdpUHvdFdj-g+-TLg6hyChh+-icw@mail.gmail.com>
Subject: Re: [PATCH] rockchip: rk3328: Set efuse auto mode and timing control
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, u-boot@lists.denx.de
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

On Mon, Nov 27, 2023 at 7:31=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wro=
te:
>
> Hi Quentin,
>
> On 2023-11-27 19:42, Quentin Schulz wrote:
> > Hi Jonas,
> >
> > ________________________________________
> > From: U-Boot <u-boot-bounces@lists.denx.de> on behalf of Jonas Karlman =
<jonas@kwiboo.se>
> > Sent: 26 November 2023 20:46
> > To: Kever Yang; Simon Glass; Philipp Tomsich
> > Cc: Jonas Karlman; u-boot@lists.denx.de
> > Subject: [PATCH] rockchip: rk3328: Set efuse auto mode and timing contr=
ol
> >
> > Reading from efuse return zero when mainline TF-A is used.
> >
> >   =3D> dump_efuse
> >   00000000: 00 00 00 00  ....
> >   00000004: 00 00 00 00  ....
> >   00000008: 00 00 00 00  ....
> >   0000000c: 00 00 00 00  ....
> >   00000010: 00 00 00 00  ....
> >   00000014: 00 00 00 00  ....
> >   00000018: 00 00 00 00  ....
> >   0000001c: 00 00 00 00  ....
> >
> > However, when vendor TF-A blobs is used reading from efuse works.
> >
> > Change to use auto mode, enable finish and auto access err interrupts
> > and set timing control using same values that vendor TF-A blob use to
> > fix this.
> >
> > With this efuse can be read when either of mainline TF-A or vendor blob
> > is used.
> >
> >   =3D> dump_efuse
> >   00000000: 52 4b 33 82  RK3.
> >   00000004: 00 fe 21 55  ..!U
> >   00000008: 52 4b 57 34  RKW4
> >   0000000c: 35 30 32 39  5029
> >   00000010: 00 00 00 00  ....
> >   00000014: 08 25 0c 0f  .%..
> >   00000018: 02 0d 08 00  ....
> >   0000001c: 00 00 f0 00  ....
> >
> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > ---
> >  arch/arm/mach-rockchip/rk3328/rk3328.c | 34 ++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >
> > diff --git a/arch/arm/mach-rockchip/rk3328/rk3328.c b/arch/arm/mach-roc=
kchip/rk3328/rk3328.c
> > index de17b8868273..edb22a58fc67 100644
> > --- a/arch/arm/mach-rockchip/rk3328/rk3328.c
> > +++ b/arch/arm/mach-rockchip/rk3328/rk3328.c
> > @@ -19,6 +19,22 @@ DECLARE_GLOBAL_DATA_PTR;
> >  #define GRF_BASE               0xFF100000
> >  #define UART2_BASE             0xFF130000
> >  #define FW_DDR_CON_REG         0xFF7C0040
> > +#define EFUSE_NS_BASE          0xFF260000
> > +
> > +#define EFUSE_MOD              0x0000
> > +#define EFUSE_INT_CON          0x0014
> > +#define EFUSE_T_CSB_P          0x0028
> > +#define EFUSE_T_PGENB_P                0x002C
> > +#define EFUSE_T_LOAD_P         0x0030
> > +#define EFUSE_T_ADDR_P         0x0034
> > +#define EFUSE_T_STROBE_P       0x0038
> > +#define EFUSE_T_CSB_R          0x003C
> > +#define EFUSE_T_PGENB_R                0x0040
> > +#define EFUSE_T_LOAD_R         0x0044
> > +#define EFUSE_T_ADDR_R         0x0048
> > +#define EFUSE_T_STROBE_R       0x004C
> > +
> > +#define EFUSE_TIMING(s, l)     (((s) << 16) | (l))
> >
> >  const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] =3D {
> >         [BROM_BOOTSOURCE_EMMC] =3D "/mmc@ff520000",
> > @@ -54,6 +70,24 @@ int arch_cpu_init(void)
> >
> >         /* Disable the ddr secure region setting to make it non-secure =
*/
> >         rk_setreg(FW_DDR_CON_REG, 0x200);
> > +
> > +       /* Use efuse auto mode */
> > +       writel(0x46, EFUSE_NS_BASE + EFUSE_MOD);
> > +
> > +       /* Enable efuse finish and auto access err interrupt */
> > +       writel(0x07, EFUSE_NS_BASE + EFUSE_INT_CON);
> > +
> > +       /* Set efuse timing control */
> > +       writel(EFUSE_TIMING(1, 241), EFUSE_NS_BASE + EFUSE_T_CSB_P);
> > +       writel(EFUSE_TIMING(1, 241), EFUSE_NS_BASE + EFUSE_T_PGENB_P);
> > +       writel(EFUSE_TIMING(1, 241), EFUSE_NS_BASE + EFUSE_T_LOAD_P);
> > +       writel(EFUSE_TIMING(1, 241), EFUSE_NS_BASE + EFUSE_T_ADDR_P);
> > +       writel(EFUSE_TIMING(2, 240), EFUSE_NS_BASE + EFUSE_T_STROBE_P);
> > +       writel(EFUSE_TIMING(1, 4), EFUSE_NS_BASE + EFUSE_T_CSB_R);
> > +       writel(EFUSE_TIMING(1, 4), EFUSE_NS_BASE + EFUSE_T_PGENB_R);
> > +       writel(EFUSE_TIMING(1, 4), EFUSE_NS_BASE + EFUSE_T_LOAD_R);
> > +       writel(EFUSE_TIMING(1, 4), EFUSE_NS_BASE + EFUSE_T_ADDR_R);
> > +       writel(EFUSE_TIMING(2, 3), EFUSE_NS_BASE + EFUSE_T_STROBE_R);
> >
> > Shouldn't this be done in the efuse driver instead?
>
> I was considering the same and was unsure if these values would need to
> be initialized at EL3 in SPL or could be initialized at EL1 in U-Boot
> proper (in the efuse driver).
>
> Did not have time to investigate further and decided to just do it at
> EL3 same as vendor TF-A, so code ended up here.

Is there a reason not to do it in the upstream TF-A like the vendor
one does? I'm sure I've seen patches around that do this when I've dug
into it in the past. Is there reasons where TF-A would need access to
the information the efuses provide, I'm guessing things like serial
numbers etc, given the vendor TF-A does this I suspect that's where
the patch should go rather than U-Boot.

Peter
