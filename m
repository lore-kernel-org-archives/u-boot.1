Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077ECC3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 23:48:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42A3F88A9D;
	Wed, 21 Aug 2024 01:48:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dgXh/8jY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D73DE88A74; Wed, 21 Aug 2024 01:48:28 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4964188AFB
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 01:48:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-690ad83d4d7so60771037b3.3
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 16:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724197705; x=1724802505; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HyWa+n9j1Bk3W3wISl0JSEpR7jjC57ASDaVztvLZJRU=;
 b=dgXh/8jYYYJp+nVn98uIpygj71cTSIPT2uwlNzm3eHdaMCfbPuE5eckq00/6tzrPcC
 zz7zXV7fh6yd0zuFybo0OQvx3EVol7K9XxGnIdK5CZPLY83qhyBl8Hd97Cn/xXdnpr+W
 +xoVu7peu+HmTiy8MCHTWkBUiHdSdwj2rswAh0NJaA4/Kk+L3K7z8Kk4zvjbnWNcJuWi
 VH3NrOJTNCWTY+YXuXBrsQ5Zk/VlPozrj+55CTwzD+wV6KVgH0lVSxEPTBSJ0U9uk8BY
 DbFhE/dyaUAlhh1WAYGIUANzRuoQdq9CHCpql+jCd95S3oCLYqtC+SWObzvMhnH/ksyU
 bOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724197705; x=1724802505;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HyWa+n9j1Bk3W3wISl0JSEpR7jjC57ASDaVztvLZJRU=;
 b=JImqF6s/tY5S/lefa3Y7NnY+KHgHQiL6MJnMJsuq1cqyCv0fLfjRZE2qMfiRhjDVFD
 FCVWmhE3OQ+FeE/bABzL3mEyQdklB7jHyKbtPc9i7LusedquiJ6KGrnGz/xp+egMxw+f
 y+fGNrbXS4FC5ccoes8uQFUPl109VUnmskV2IrxFMOgZ+nFUte5MlqwTCdpWSRmvtvcx
 HPIrRn2XRJonYjwtboLtiU5tOwM2joezCwla+gup9RkW3GcKeOSFeyuNt+slvt+JPr7/
 KphdHOf6lcOw8yhcqzuDrSP2oETXwpQ+1KL/rnsBpJGvbmVnD5wMsWiTvhR+5w6XE0E0
 z8Kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT1VIpd2THebEBcDfWj1U9t239FOMmHAFE2QBXqS5zEtJSl2ejmLEEK79Y2wG5UaTE0TRRmuA=@lists.denx.de
X-Gm-Message-State: AOJu0YwX0aSOzu2pE9maGq2YYCokHYcv2TzJ8A9ZUa8vY4JhcYGMuwUy
 ol3ZFLsRuI1jB8Rnkg2qn3IoZzVbHyw5a0nzEsZ0ZotGCHefBnQr1MoZ5wYNs0Mo5TEe7j9PhRs
 iVaIoMEZ6afrF8lcn5HQoazVrgrHOUEPQ0nXlRg==
X-Google-Smtp-Source: AGHT+IHnjOUlAAGDlLZhLXHwZ2qpUm7WxQOFULgVwQ0x53OZuKNID5AxfBmiFEdibeTx+F6/vQj1p4HCsYLexCHyaFw=
X-Received: by 2002:a05:690c:2a44:b0:6b0:407a:e3af with SMTP id
 00721157ae682-6c09fa8b50amr8844717b3.34.1724197704842; Tue, 20 Aug 2024
 16:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240808031444.9619-1-semen.protsenko@linaro.org>
 <CAPLW+4m_rzR-96+4kNfE1a73kiASRAm9m+M56EqqNBZb6V7+5g@mail.gmail.com>
 <CALrBrZ3H_FzVUvCOz59gJCiHEPY3_fG6xH3sQ4nMeMdzugwfBg@mail.gmail.com>
 <CAPLW+4ngCAam8K1atOfVqvhUAvN53oa+t3QQR1YiVeHMpfQp1w@mail.gmail.com>
 <20240820201606.GN1626301@bill-the-cat>
In-Reply-To: <20240820201606.GN1626301@bill-the-cat>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 20 Aug 2024 18:48:14 -0500
Message-ID: <CAPLW+4kN7e9t83LWE0-JoBmXymc3AajyWwCBLLrAfsgoCfa8Fw@mail.gmail.com>
Subject: Re: [PATCH v5 00/38] mmc: dw_mmc: Enable eMMC on E850-96 board
To: Tom Rini <trini@konsulko.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Henrik Grimler <henrik@grimler.se>,
 Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Yang Xiwen <forbidden405@outlook.com>, 
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, 
 uboot-snps-arc@synopsys.com
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

On Tue, Aug 20, 2024 at 3:16=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Tue, Aug 20, 2024 at 02:48:59PM -0500, Sam Protsenko wrote:
> > On Mon, Aug 19, 2024 at 8:45=E2=80=AFPM Minkyu Kang <promsoft@gmail.com=
> wrote:
> > >
> > > Hi,
> > >
> > > 2024=EB=85=84 8=EC=9B=94 14=EC=9D=BC (=EC=88=98) 10:15, Sam Protsenko=
 <semen.protsenko@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > >>
> > >> Hi Minkyu,
> > >>
> > >> What do you think about this series? It's been pending for a while
> > >> now, so may I ask you to take care of it?
> > >>
> > >
> > > applied to u-boot-samsung.
> > >
> >
> > Thank you for handling this, Minkyu! Is there any chance this series
> > can be merged in 2024.10, or is it too late in the cycle?
>
> At this point I would like to see this for -next and not master, sorry.
>

Makes sense, being at -rc3 doesn't leave us much room for testing it.
I'm just glad this series is finally applied :)

I also hope that my clock propagation patch [1] can be taken for
-next, it's been kinda ignored for a long time now. Although MMC
series will be functional on E850-96 in SDR mode as is, applying [1]
would make it work in DDR, which is definitely better.

Thanks!

[1] https://lists.denx.de/pipermail/u-boot/2024-March/547719.html

> --
> Tom
