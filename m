Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBE1C282EC
	for <u-boot@archiver.kernel.org>; Sat,  8 Mar 2025 19:07:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8329A8043C;
	Sat,  8 Mar 2025 20:07:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PpoACD88";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 271878058A; Sat,  8 Mar 2025 20:07:25 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D592C803CC
 for <u-boot@lists.denx.de>; Sat,  8 Mar 2025 20:07:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2fea47bcb51so6296669a91.2
 for <u-boot@lists.denx.de>; Sat, 08 Mar 2025 11:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741460841; x=1742065641; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sU/HAVoykUlXcy081nFSkOgPDhRmrNamxw1MwDi7q3c=;
 b=PpoACD88OdTOAM0St1fAJ789V3NKVPFfUh1NFuXflwxRW/2tDydg3oZvCDPkJaSFV6
 KNtxrYmouBmg/ZRfhCdVehKmBG2YSSnmwqP/6kD5plin8tzqdkz7BR7UggaVcNvr8vMg
 fEDD/vVVc7dwY2A5QK0OHTwO2Wvqncy7XLNYsbub0t4wUgTwtzZSbXXlyNwXjpv60okO
 IRu6JkosXc/YBkOyNEMhZOnFKfrbumvjIFAzWclGQ4KgfEmlgTXtQ1crKkEahAd+Oomx
 9RgeFkKzz9OMJka7TQ9a5z+mNZbcb6qX+pU262m7977CfSP219GH1X2JLTKP91q/jWno
 TwQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741460841; x=1742065641;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sU/HAVoykUlXcy081nFSkOgPDhRmrNamxw1MwDi7q3c=;
 b=Y3dh+JhZ9hLSCC7B7oV1UvLs1gQQOKvwRDKEbshU9CDH4ZboLUnfqPC+xkzgz2SEeX
 YpG0GC+jUAJd/4S29XzAE92l01UXZkfi0JmTcDslLAkIL2vhwejGiEWs2AmzkzPw/iyL
 WRQn9JgDJqNB9iAxB84oRUI48DVypliOR1c2xQeceAkOAcB5uo6bupTXG+7QQXVTO113
 349MfedA23N5kbHsX8GOjTR9OdxL7KNl0ZDFzlhLu8Zi3k7eMAwrlN9URk7dDZGk8lJB
 /MIQYpGvSQA5becex2/LMlRAKJKMkByDi3PdhjqUY9mTImlpZDepbiwxX3W1spFYMBqi
 Fc2g==
X-Gm-Message-State: AOJu0YyigMkbGnZ1IscYXSUMpe2abcyd8QMq6kgwINqn/t6BZvrOmHpQ
 L1qhv8mFYC/H/0ZtKl7E5Aw8Pguv++k+0kYFl3uwurlDlUjqLI4pKFUigEUYMa+vHya5VL2zRvN
 cANwXad89jJZ9ox/eXkkAbKm9vRA=
X-Gm-Gg: ASbGnctp+w67TLt6xGtpwpIEm4D3HVmhur/H9p84BbYXuCF/zNgEkxk8g9k0XwBze+r
 amDVsBwqequwZYuKluANoVHCNYyy89KCJvyRcwCh0cxyEpd0CFZ/+KTZ6IwGo6tTqiuyKpWeDZ4
 C0SOLq+cqYpR7URKoUHOEQi/HN1g==
X-Google-Smtp-Source: AGHT+IFkT9q6Uq3Xs3BlwYZszwyj+8Qo2+Ql60iy12brikeCOABi6KiNHEQQONYZ7zW3tVI7yLbHkZsCUIcoAQMu4M4=
X-Received: by 2002:a17:90b:3f04:b0:2ff:53ad:a0ec with SMTP id
 98e67ed59e1d1-2ff7ceaa31dmr11818362a91.21.1741460841137; Sat, 08 Mar 2025
 11:07:21 -0800 (PST)
MIME-Version: 1.0
References: <20250302165249.267992-1-aford173@gmail.com>
 <20250302165249.267992-2-aford173@gmail.com>
 <CAOMZO5Ay+Msrj7tMBm8noLKHe5iPAN4=nOgX9tu7wKbWjeSPNA@mail.gmail.com>
In-Reply-To: <CAOMZO5Ay+Msrj7tMBm8noLKHe5iPAN4=nOgX9tu7wKbWjeSPNA@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Sat, 8 Mar 2025 13:07:10 -0600
X-Gm-Features: AQ5f1JpTp0Die1UPj8PlYrVlotVkzS40qoZDM3Yqnf8IRuSuQlo88Pn6IeSg4iU
Message-ID: <CAHCN7xLMMH_BN-nVzSh3iQV=h-OPHEBY-=4OuBpHOBcYktaiCg@mail.gmail.com>
Subject: Re: [PATCH 01/10] clk: imx6q: Properly handle imx6qp ESPI clk_sels
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Emil Kronborg <emil.kronborg@protonmail.com>, 
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tim Harvey <tharvey@gateworks.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>
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

On Thu, Mar 6, 2025 at 9:57=E2=80=AFAM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> On Sun, Mar 2, 2025 at 1:53=E2=80=AFPM Adam Ford <aford173@gmail.com> wro=
te:
> >
> > The ECSPI clock has the ability to select between pll3_60m and
> > osc on the imx6qp, where it's fixed on other variants.  Fix this
> > by adding using a helper function to determine SoC variant and
> > register the clock accordingly.
>

Fabio,

Thanks for the review.  I will make the updates to the two patches you
requested.  Is there anything else you want changed before I submit
V2?

adam
> s/ESPI/ECSPI in the Subject.
>
> > +       if (clk_on_imx6qp()) {
> > +               clk_dm(IMX6QDL_CLK_ECSPI_SEL,
> > +                      imx_clk_mux("ecspi_sel", base + 0x38, 18, 1, ecs=
pi_sels,
> > +                                  ARRAY_SIZE(ecspi_sels)));
> > +       }
>
> No need for { }.
>
> > +
> >         clk_dm(IMX6QDL_CLK_USDHC1_PODF,
> >                imx_clk_divider("usdhc1_podf", "usdhc1_sel",
> >                                base + 0x24, 11, 3));
> > @@ -91,9 +103,13 @@ static int imx6q_clk_probe(struct udevice *dev)
> >                imx_clk_divider("usdhc4_podf", "usdhc4_sel",
> >                                base + 0x24, 22, 3));
> >
> > -       clk_dm(IMX6QDL_CLK_ECSPI_ROOT,
> > -              imx_clk_divider("ecspi_root", "pll3_60m", base + 0x38, 1=
9, 6));
> > -
> > +       if (clk_on_imx6qp()) {
> > +               clk_dm(IMX6QDL_CLK_ECSPI_ROOT,
> > +                      imx_clk_divider("ecspi_root", "ecspi_sel", base =
+ 0x38, 19, 6));
> > +       } else {
> > +               clk_dm(IMX6QDL_CLK_ECSPI_ROOT,
> > +                      imx_clk_divider("ecspi_root", "pll3_60m", base +=
 0x38, 19, 6));
> > +       }
>
> Same here.
