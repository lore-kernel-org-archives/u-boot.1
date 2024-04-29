Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA6FC4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 16:48:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC2D1887B3;
	Mon, 29 Apr 2024 18:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="NA5X47dA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61E11887C3; Mon, 29 Apr 2024 18:48:26 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E802A887B9
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 18:48:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5726716a006so3336041a12.2
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 09:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1714409303; x=1715014103; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MsGEHH2Pz2PdA+JpBwkjIYoiMmVq+D1c+95A9XSWou0=;
 b=NA5X47dAXNKzeYmPVH/YBIuvQ+UH1qgM7U82X9XxN2waqsvxihyJRH6Ya5rknWQslm
 pg00kkmqeUCzvVDj6oVypxqcD0XiLVRk+iRByP2vj2567DmZvGk2aFIGApwAx7TNwDS6
 bVKidjAebtShvQVBySAxOdPccgn7Q1uwgUaOOk3JQLeYowUjgV72OSKuXZBn8He3kmvW
 1eht9XIsMLvlKznwKzUk7VUVGT+Tk0llkPr9cP1/WbTvCISD4oSd+Dx/G7CPNjnOaWiU
 4CdD9kWFW0h8HgdQJoKCuMxYTwxq35FK4ty3iWiVC3bFFiO9QJ9KM1rC1/fNRTjsZgeg
 yDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714409303; x=1715014103;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MsGEHH2Pz2PdA+JpBwkjIYoiMmVq+D1c+95A9XSWou0=;
 b=nMfdQoZswVougkYa4njSu3JSs+hp2nkbO20LKiN11sH7356MSwW1XKUzVyiUxfvHZv
 YocNiwBXgYIhn2qm+d30EEeEGe0W9G9xr7UsBEufd/vV4brl1s89gbeibVKYx41BSkM/
 pr6mr9+8HsHYMTG/eYH2ZuDsGQ+W0Nsmt7DmWZvt2/qxncpBGzJohI+gZ+zMz8ji28q7
 2de8Sh3ZcQFuL/7O4wISAC/VYaeFD5+jHY3NYTFqudmCqcBDaAn8rDk/1ez283z1Lije
 Ap0kTzCf9hf5Nclad+HnCpb+aoqOZNmnLYof6ZW30hXnhaheoy8hz60wKU18JDx4Zuq1
 nlIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4+0OxOmrkLAHgeDwpVsfyxfuwXSvJBXAt/Nu2ijN9uRm9dBQwxlnpy0LdB+fKWv+D7woq7Ah/e7e2q2Folse0161DYw==
X-Gm-Message-State: AOJu0YwOCsaloO1kpD4YvYd3jYXVS1UHXpAh/thOvO1tJUpXWJySoW7Y
 kN9LP3oSadgzC4NRtKDK3vRkWz4FhMNOLA0EvxS52PqHeJPINVksL0B41ufTbPSyqnrRO2l/rxi
 34Tj1Mvo4g4o8PqUywUmAxA7CjyLUH3C+xGZkFA==
X-Google-Smtp-Source: AGHT+IHcGbK0Hu6Wseao49OQdbpREEsGK6HdOmfLKLCXUHb2ForYaoupJ0IVLo2qrVlkoMIgeSjJRnTOXfCI/VbCYZQ=
X-Received: by 2002:a17:906:2ed3:b0:a52:6bb2:2b15 with SMTP id
 s19-20020a1709062ed300b00a526bb22b15mr7297064eji.38.1714409303180; Mon, 29
 Apr 2024 09:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240427001157.1460302-1-tharvey@gateworks.com>
 <495f60d6-6ff2-4c53-8b2c-867b5ca05993@denx.de>
In-Reply-To: <495f60d6-6ff2-4c53-8b2c-867b5ca05993@denx.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 29 Apr 2024 09:48:11 -0700
Message-ID: <CAJ+vNU0R5iTgS2_C_OV2VYh5fQnyPV-Lw003CTJAkp1Q6Qdedg@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: allow use of hardware partition names for mmc
 partconf
To: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Fabio Estevam <festevam@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de, Dragan Simic <dsimic@manjaro.org>
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

On Sat, Apr 27, 2024 at 4:20=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 4/27/24 2:11 AM, Tim Harvey wrote:
>
> [...]
>
> > diff --git a/include/mmc.h b/include/mmc.h
> > index 4b8327f1f93b..7243bd761202 100644
> > --- a/include/mmc.h
> > +++ b/include/mmc.h
> > @@ -381,6 +381,21 @@ enum mmc_voltage {
> >   #define MMC_TIMING_MMC_HS200        9
> >   #define MMC_TIMING_MMC_HS400        10
> >
> > +/* emmc hardware partition values */
> > +enum emmc_hwpart {
> > +     EMMC_HWPART_DEFAULT =3D 0,
>
> One more thing ... eMMC hardware partition 0 and 7 are both referring to
> USER HW partition. Have a look at the git log, there have been patches
> which handled this case in the MMC subsystem from about a year ago.

Hi Marek,

I can't find what you are referring to. I assume you are talking about
calling the first name something other than 'user' as technically it's
not (but it gets treated as user).

Can you find the commit or discussion you are thinking about?

Best Regards,

Tim
