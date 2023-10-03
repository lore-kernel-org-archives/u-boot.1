Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D96E75433
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 08:36:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B34A86DA7;
	Tue,  3 Oct 2023 10:36:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cvnund9S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 154A487137; Tue,  3 Oct 2023 10:36:54 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 259E586C96
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 10:36:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5046bf37ec1so770341e87.1
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 01:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696322210; x=1696927010; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+kU6Ph+iAEyEB2VshoVf67KfBtyNs1dCPD1HGUdsEE=;
 b=Cvnund9SSA3F8Ka977VeXwQKoBSKYxIlpnVxCDf7IOwunUmAfB31HQIegg4wsgyfhS
 By/hQZzHrx+8A8Ouf/WzpgkkvIbGdJdWdw7eEk8m/tklyKkmWO3YYZLCzZJB8razLOxN
 lcNkXYkyfs179fReGTXsGcCtLx3hnEyc+hYZELcCxc6qu6gNWWc9IOcTCngpweEbhh5V
 fQyix/CN8zwYYUTXRXsoxYeV0rCxGfg68+ygfDmHCKHUtNp9i+yirG0xKafEchhqioDU
 Yjgaax8ompuQVGx02Fx8uOz4OoclqutbmXWvtzMWuqEde3FGDgXH7odDPYg/hWZ9sNZJ
 YmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696322210; x=1696927010;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x+kU6Ph+iAEyEB2VshoVf67KfBtyNs1dCPD1HGUdsEE=;
 b=FqNscUg4Y/y0zxgHVC1jjiWzcuqmp0HLzq/SmQPf6jF0O+GJHRJK7iCN2xMFu6KZLL
 MEFqUWUOJB8kMwsK/VRFo47geV4ugKroRcJxCMgpG1ci8xfEFjWPP7fkaF/78bEm/rPx
 MSmj1sQnDigUIFWU6grwy/VIVORWWK5gE8kDosB+Rf8XRGxK8TIixsDr41gwqsh+B7DG
 auFH3JLBXeluFOBxE3v/knP81nykENcpjl+REmP6bILBvwoo6uGHdlYKz2r5fRRuDLuv
 /oIwI19pf7ordFccFpXnwYHe+wX1yBJ9NqdNHjf0nXdhQHXZQjaZVMo1ABJ2sPbogXjF
 gmsA==
X-Gm-Message-State: AOJu0YxPVH/yWtwjmySUVUop3WJBUquXCIPrJqJo+vwZY2YWDhIqQJid
 xZWu9bzQNj69lT6yjX3cMLvYZZqWn4xUKh6hoTy4k7fTXkjXWQ==
X-Google-Smtp-Source: AGHT+IEVhM/KLG517wDTZ/wt7RMyixHr90uU6bg66cszfgKYzJBiHkx2Rk+CMJKu7peTP5WL/3mB2BSf1itFM7DxejA=
X-Received: by 2002:a05:6512:5ce:b0:500:ac0b:8d58 with SMTP id
 o14-20020a05651205ce00b00500ac0b8d58mr10859712lfo.18.1696322209993; Tue, 03
 Oct 2023 01:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230926090808.408095-1-JJLIU0@nuvoton.com>
 <ec256874-0fca-83fe-d207-67e4048b461c@denx.de>
In-Reply-To: <ec256874-0fca-83fe-d207-67e4048b461c@denx.de>
From: Jim Liu <jim.t90615@gmail.com>
Date: Tue, 3 Oct 2023 01:36:38 -0700
Message-ID: <CAKUZ0+Exu_F2tjY9q8QqQz83PEZQKYZY_bdAFwdPGKQdpKTr3w@mail.gmail.com>
Subject: Re: [PATCH v1] i2c: nuvoton: add support fast mode
To: hs@denx.de
Cc: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, trini@konsulko.com, 
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

Hi  Heiko

Thanks for your review.
Our bmc HW can support standard / fast / fast plus mode
but our first uboot version 2019 is only run on standard mode.
so the first upstream version is the same as before.

Now, some customer need to test other mode on uboot.
So remove this judgment to support other mode.

I will add a commit message in the next version.

Best regards,
Jim

On Mon, Oct 2, 2023 at 9:37=E2=80=AFPM Heiko Schocher <hs@denx.de> wrote:
>
> Hello Jim,
>
> On 26.09.23 11:08, Jim Liu wrote:
> > Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> > ---
> >  drivers/i2c/npcm_i2c.c | 5 -----
> >  1 file changed, 5 deletions(-)
> >
> > diff --git a/drivers/i2c/npcm_i2c.c b/drivers/i2c/npcm_i2c.c
> > index ea4ef53256..b867b6c8e9 100644
> > --- a/drivers/i2c/npcm_i2c.c
> > +++ b/drivers/i2c/npcm_i2c.c
> > @@ -517,11 +517,6 @@ static int npcm_i2c_init_clk(struct npcm_i2c_bus *=
bus, u32 bus_freq)
> >       u32 sclfrq;
> >       u8 hldt, val;
> >
> > -     if (bus_freq > I2C_FREQ_100K) {
> > -             printf("Support standard mode only\n");
> > -             return -EINVAL;
> > -     }
> > -
>
> Is it so easy to enable fast mode? As original code explicitely
> says "Support standard mode only" and returns -EINVAL?
>
> And please add some text into commit message, may you can explain
> why current driver supports fast mode?
>
> Thanks!
>
> bye,
> Heiko
> --
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
