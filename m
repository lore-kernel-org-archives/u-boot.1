Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D94C43458
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 13:23:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CAA584D08;
	Tue, 14 Jul 2026 15:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I5YTr9kl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E5F884B51; Tue, 14 Jul 2026 15:23:09 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 111BA84D1D
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 15:23:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-384c94c9414so819873a91.3
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 06:23:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784035385; cv=none;
 d=google.com; s=arc-20260327;
 b=jRFXA3oFYjbm+yhhmWzHcOu/DwiSn4jzKGz1NES8T7FjVPnFa5jCR5f5BkE9mtvdhE
 ufs25wQUpGYc/ioqhuZRIkSONcx4ggWwPbE92AHLJ2Rp/Yq2iK0fACRns1P3VWSqOeBq
 QSpHzaqNs1Z+B/vbTlPavBqAVQjKqS3d51iytaBPRKBVl6vRpvkUZodTvMrUzBD648Wh
 qvzpOJtARJlqouwGx0dwP0iE9tmYhHzQCIdlLT86XuzEb+i05DXrNuvngdyfZZYKXQBF
 V9ae1DPVA3BwgOXYNPr5ekovofawot9vaD7xuKpJhlS7W53f1SVdHMIxmUnbt4KbeKVL
 gJ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uu9/j8/XazlKJkcSLj6Zj8Qnghwq3PE4SqZoOqQFyLw=;
 fh=czSSP/LUr8ZZbp/8thY4FtDQo7KtY703J0qadFIGkmM=;
 b=F094erUAB5nQe1hzb4FQWQVT4RBnycbjOjggNCfjQPQhPRkXW2q2SxKREEI9KIsOPW
 C8UIU2ZCZoEhcrTyE/CyBvMiejdX9hKXYzaaUQ4zL8DouGGYdV3N6OJxfgtHOr2C///W
 9DQL+ebl+Q0IA0hJElhkbYYUmHqVHv1RuYZOfF4+OiimrZYYwidMOSbez7loDClaiG57
 DRZwWIyE7eNShPrrJbTlsV13ogu+dLY1ZhsXmI0Swq+ur6rWx11vZf2HRqo0+eOmMS1t
 2qI6QneCCEX/LyAveavVHA286mYaDF2mMyexZEGGm749GHl7LFaPMA6Ax8xexAWNra7p
 6UOw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784035385; x=1784640185; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uu9/j8/XazlKJkcSLj6Zj8Qnghwq3PE4SqZoOqQFyLw=;
 b=I5YTr9kl0qE7ukeS+hq/7t/mnx8rGUdGSRVh+WLbNwRxpYi+4z9wjDvuhuVjs1tajE
 w5b44eGuTAJWdi0yV0VWTAThqSKNckqYTDRVkjDGar+UoYnsOxatyHL9XGFfe3NWClOl
 FQ4BaHhu5JYwPtUIDWR7q6sGP4uvxtyDwgSgafeKoVA3AFCRrCM6TkzBYHE75XgwVvlj
 sNYVRgTO+O0dmq98COXTZx5gweI1OXO//asVYIPi4setyfpn7jU3Lq7jBGq0Oah/IGaQ
 b0JLKhFVQ8Q1fsd/xUuFaWPvKqaTZf9xf2UYnoQcJCOpXeNpQ0YZUUlDH8gNxWGD8Oa2
 hA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784035385; x=1784640185;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uu9/j8/XazlKJkcSLj6Zj8Qnghwq3PE4SqZoOqQFyLw=;
 b=olJrAmqVMoQzs9Y3KpqR/VEPJQCMxN22cHxPCX8AHi4F0nfVd71KYyuD9ZSr5jDSka
 u9Av6thKYo1SmvLLdn7Rax8u0xpBo+ym6MypqXaa5EVtgV/n9lvd7GqAEZPVfxBLifC0
 yZ+BLnmK4vGZlvQmvqFyaJes1fQKqW/zflc716LzCnmYJ1q5wKJWdkglLdRDHtpluYQf
 dKaB9irhBIN88VU5QthEL0xxeBXZY2sKRU/n06m5BqpGeYSlqWi2Q3AP3zNSq2IqEI+Y
 q6ZORlkJszXq+aTwaBrMeYDV+Euehtk/8baKQC0b0OrXRgY+cQDDXot+FMP/1uiJng6N
 Z/9g==
X-Gm-Message-State: AOJu0Yx7jY43f+uoBe32lVX0woBhKpCyoMNewgDTdpgqNjbX1a0YXEmu
 nF9TmtBld9sTZVdmi56eMhHhiW3MlmLy8oZdtWCZcFLJbSEwNfDY1vYnOH2b3vYPwBuWvoQX0Zj
 EetqJgOhZAXbMHunoUMBh7syTOKWdVOM=
X-Gm-Gg: AfdE7ckmRo6josm5Iv+N5qiadXG10Z6j1kQwm6VsVdw/3ANmMiCr+XRdWHLjcCZbq38
 kWIfuPMsOM8NttpmEVfst+IqF8i1g/vmzGr7Z4/u/Vd2qcDNR7L/p4MQHyPS6HcEHEucg8XA2JV
 A5gGkb2J1BvNsCA1ewDZ9D+Aj6XJv2T5RyGrDUmodpbIU0PS5Q6gl0fnLeU3s3E+us+WWj0aFkW
 jZN7vonSxGBEDzJZLPb4qjS7IhyyrgCiHoQEL/xuq5NbHsSN0O+isa5/0ke1fMhLjTtkmvmHEpD
 rcpTXFBZex9RQ7+yVuRsNePOOwexIQ==
X-Received: by 2002:a17:90b:562c:b0:38d:66:5e6f with SMTP id
 98e67ed59e1d1-38dc74cfabcmr11654566a91.3.1784035385211; Tue, 14 Jul 2026
 06:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260702151325.290749-1-advaitd@mechasystems.com>
 <CAPVz0n1YGYKMWo6fVHF8gXZ8_6BjHCC4WUs-BBL5__+L8Bhi3w@mail.gmail.com>
 <CAAPs2HSH4qz292VEcxT-knTm-CrcVXmypceq2n1XLJX4qcQKxg@mail.gmail.com>
In-Reply-To: <CAAPs2HSH4qz292VEcxT-knTm-CrcVXmypceq2n1XLJX4qcQKxg@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 14 Jul 2026 16:22:53 +0300
X-Gm-Features: AUfX_mxh5SYe9Iw_4mNU4iTsSq94lPDoEA2tUI_Vu5MkFMTk9ZPTOuF0qHXBqi4
Message-ID: <CAPVz0n0zDkprgT1Q8qokMbdR8OHTawx37GxV2iS=Ldwtd5Mw6Q@mail.gmail.com>
Subject: Re: [PATCH v2] video: add ChipWealth CH13726A AMOLED panel driver
To: Advait Dhamorikar <advaitd@mechasystems.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, ag.dev.uboot@gmail.com, 
 ion@agorria.com, dario.binacchi@amarulasolutions.com, 
 michael@amarulasolutions.com, xypron.glpk@gmx.de, ravi@prevas.dk, 
 sjg@chromium.org, patrice.chotard@foss.st.com
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

=D1=81=D1=80, 8 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 16:45 Advai=
t Dhamorikar <advaitd@mechasystems.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> > Hey there! Thanks for your contribution, it is pretty solid but there
> > are a few places that can be improved.
> Hi Svyatoslav, thanks for your inputs!
>
> > > +config VIDEO_AMOLED_CHIPWEALTH_CH13726A
> >
> > May you please rename AMOLED > PANEL
>
> Most of the drivers say `CONFIG_VIDEO_LCD_XXXX`
> Since this driver is an AMOLED I thought of using that.
> There also don't seem to be any existing setups named `CONFG_VIDEO_PANEL_=
XXX`.
> Should I still rename it to VIDEO_PANEL_CHIPWEALTH_CH13726A?
>

Yeah, other configs IMHO should be renamed to PANEL and ideally
separated into a dedicated folder.

> > > +static int ch13726a_dcs_write_buf(struct udevice *dev, const void *d=
ata,
> > > +                                 size_t len)
> > > +{
> > > +       struct mipi_dsi_panel_plat *plat =3D dev_get_plat(dev);
> > > +       int ret;
> > > +
> > > +       ret =3D mipi_dsi_dcs_write_buffer(plat->device, data, len);
> > > +       if (ret < 0)
> > > +               log_err("failed to write dcs sequence: %d\n", ret);
> > > +
> > > +       return ret;
> > > +}
> > > +
> > > +#define dcs_write_seq(dev, cmd, seq...)                             =
   \
> > > +({                                                             \
> > > +       const u8 d[] =3D { cmd, seq };                    \
> > > +                                                               \
> > > +       ch13726a_dcs_write_buf(dev, d, ARRAY_SIZE(d));          \
> > > +})
> > > +
>
> > You can fold this.
>
> I'll fold this into one single #define altogether.
>
> > > +struct ch13726a_panel_priv {
> > > +       struct udevice *reg;
> > > +       struct udevice *backlight;
> > > +       struct gpio_desc reset;
> > > +};
> >
> > You are lacking supplies here: vdd1v2, vddio, vdd and avdd
> >
> > U-Boot can handle them so you should include control over them.
>
> My board has the input rails permanently powered, so the current
> driver doesn't request any regulators
> I'll add support for the vdd, vddio, vdd1v2, and avdd supplies. Should
> these be treated as
> optional (-ENOENT) and guarded with CONFIG_IS_ENABLED(DM_REGULATOR)?

Yes, that would be acceptable.

> I couldn't find other panel drivers that consistently follow one approach=
,
> so I'd like to match the preferred U-Boot style.
>
> Best regards,
> Advait
