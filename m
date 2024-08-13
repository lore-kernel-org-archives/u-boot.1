Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E427BC52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 20:12:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B62C8863E;
	Tue, 13 Aug 2024 22:12:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MW1RJ/Qx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1DB18899D; Tue, 13 Aug 2024 22:12:43 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4ACC88387
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 22:12:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52ef9bc3a64so437e87.3
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 13:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723579961; x=1724184761; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LbKvuYxSvjzQjaivBgVoe4yu5C0xLFm/dG7/xdbKU/o=;
 b=MW1RJ/QxAy7K0apMV8wqinlN9pVwaFIX3IJXEf3NaIidx2pnTdW+NGDAhz6mIIcpx5
 s0mwL5DYt+Q4lIG6j2j++MZtiP6VNbJSQS05laIyAdDOYP4wjBtNZcbxjNRrDQikg5+r
 ik5/JrYHWgcAf74PeKXV+X/wb/zptIxkyvEHfLvCmEgdAVeeXGwl15/HXS9soExAZ8J1
 8x5gGGJUHiZXOxKZNExrcUTXqIOn42UPv/MEhcjokU581SrDb5GgVL2Ll8Gah4mfrp8q
 luJNtEiAs8MKyEGU0utOC2Urq3pR+OmFy11apf71Kgdtl4OOomKp0w72JTFRY5hyDqfj
 smiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723579961; x=1724184761;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LbKvuYxSvjzQjaivBgVoe4yu5C0xLFm/dG7/xdbKU/o=;
 b=bf/KMlrgDOrwaxFHFAf/T0vWzQj54Ktk0Don3VI62szEGAgGPbxuUXbA6lCNPQdXbc
 nELUUiXICWOPBSXcK/OhYIaVbfn9rHYtYDpmmroMg/jIWIJwnPnFnOe+svq3bEMIAGQC
 c0zPk7ohVIpZvKCpzpe0gtTEwzM8oy+gzIRqJyD3qREGzbCahLNqcw0MfB2RZTOmsuG0
 X+SBZ0R1O3xZhb8xTuG2RKpibCYPJTgHKxplY5SzdQOWRoaGBnHoY8hQ9TuCCMEY/oAG
 J/xbEGLyd+G8gwPxRft/ExsmSkC907E/+MN7508jfmFtezUJZvAA9VgsN7QUDxC0Mrp4
 1/kQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+2ddvrevOJsDkzQMg6IliL7P0qbDQ+wuucRRxOccn+NUqt0LERw6NeBTUbJLrmTBRmayCkvdo3EeDXdJyzHKhx4V95w==
X-Gm-Message-State: AOJu0YwyOwpbt6O8jdKoEiz26WfBuFopE7DpPjjwD+HU8Vqqb7BrkF5n
 6TIid8C5yuyQ1+nDhGzmvbVOYfHs/U8thMRNbk/Zlp4olctNTjd5mkSzD8ggefkqO0PzE76HjHd
 pMRLcyVoRj6V1X/i22XXteUL5M6of/Kc4
X-Google-Smtp-Source: AGHT+IGn2nz5XLhXkw44MpvbsQkeCAMMnQflY3J5/Dp5a8bJfHu6Ecd6aXYcbvD57Gpvou7E6XaSA+ygllwqCAGzkr4=
X-Received: by 2002:a05:6512:3b1e:b0:530:baec:3975 with SMTP id
 2adb3069b0e04-532eda5b322mr203147e87.1.1723579960362; Tue, 13 Aug 2024
 13:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240807155343.122377-1-hs@denx.de>
 <CAOMZO5A23hR6CbLbvUR-ck111iowq=BKrMz_4PHwL4hQsmyxDQ@mail.gmail.com>
 <36b5a4e3-0848-7275-134b-a0929a1fea27@denx.de>
In-Reply-To: <36b5a4e3-0848-7275-134b-a0929a1fea27@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 13 Aug 2024 17:12:28 -0300
Message-ID: <CAOMZO5AHFdKxNspP1fAzpGmGPABCQeAohepg55Q+YRR-PttbCw@mail.gmail.com>
Subject: Re: [PATCH v2] driver: pwm: pwm-imx: fix probing on imx6
To: hs@denx.de
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Anatolij Gustschin <agust@denx.de>,
 Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
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

Hi Heiko,

On Tue, Aug 13, 2024 at 10:58=E2=80=AFAM Heiko Schocher <hs@denx.de> wrote:

> Should we revert this patch?
>
> I just can say for the aristianetos2 board, that I readded exactly this
> define in my work for the port to currentmainline ... and with my patch,
> pwm and so bootlogo works again ...

What about the change below on top of your patch?

--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -14,6 +14,8 @@
 #include <asm/io.h>
 #include <clk.h>

+#define IMX6_PWM_PER_CLK       66000000
+
 int pwm_config_internal(struct pwm_regs *pwm, unsigned long period_cycles,
                        unsigned long duty_cycles, unsigned long prescale)
 {
@@ -75,7 +77,7 @@ int pwm_imx_get_parms(int period_ns, int duty_ns,
unsigned long *period_c,
         * value here as a define. Replace it when we have the clock
         * framework.
         */
-       c =3D CFG_IMX6_PWM_PER_CLK;
+       c =3D IMX6_PWM_PER_CLK;
        c =3D c * period_ns;
        do_div(c, 1000000000);
        *period_c =3D c;
@@ -162,7 +164,7 @@ int pwm_dm_imx_get_parms(struct imx_pwm_priv
*priv, int period_ns,
        if (CONFIG_IS_ENABLED(CLK))
                c =3D clk_get_rate(&priv->per_clk);
        else
-               c =3D CFG_IMX6_PWM_PER_CLK;
+               c =3D IMX6_PWM_PER_CLK;

        c =3D c * period_ns;
        do_div(c, 1000000000);
