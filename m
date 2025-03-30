Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DB6C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 14:36:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 959ED8171B;
	Sun, 30 Mar 2025 16:36:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iebFDBXa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1719581879; Sun, 30 Mar 2025 15:34:01 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE97780F9C
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 15:33:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5e61d91a087so5856146a12.0
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 06:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743341638; x=1743946438; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/TKw7MCto7rphBfO+ircOHXJX3BEfwvPaApctHseQIQ=;
 b=iebFDBXa4HmPTXURg5ENum3U32tvC6opNbewBdMb+WsCaNHvft3fahXYa6d9bUN3PL
 Ccuaey7FiWhpBUUVV6sbEeGRt2impZt6XRpDvcppfg+UZNldOOAUUV0iyjAr42YBJ4Dw
 bYhBtVd2gwDIKnXyFbZTCJufdlpDaFl4STXXjs5dqRZB9KfLTxjyC0d4f0068oAFyJ5r
 /x4n9f7cv6oiuX9c+kd80daWOrO4f1wITvJLlBE9CEROmtQOJeTbbY2i6zbE/a5f/iwH
 L0qrS3BgCRLyVKvCK12zAqWLNCQioFFca8C3DftkjUi8ljlonR7OcQ1o0PxlSvvPQerq
 ezHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743341638; x=1743946438;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/TKw7MCto7rphBfO+ircOHXJX3BEfwvPaApctHseQIQ=;
 b=AClx+SmE/e99JScfW222/78tLc6beaoXEt8UiUSL2hnZFXuwfhpvecJdEE1LACtpFZ
 RjqeoaFk9Vw61GCWPuF6n7vZKyIB6bS5kkY0VK4r3azjKzmvnpBW1l1i12AmdhRdz4HI
 g8as6ucTKkTJJ/qgLsOkQbjDwoh33/lqNynNYa1kkk1J2tnQvnax7Wa/w/YpbI/rA4d+
 PuqON8tY+uXIVPuoamOXPu9yOeXf1mViCLdRVNYCUpGvX+STNr4KhdY54yqQRx0m3u/Y
 j4JxxSpbsWWVzReUhRJVbSm8Rz4Sd2of2/aNi5SkoU9rjKLBjtawj3HpkhYG2RF0MKtL
 H5Bw==
X-Gm-Message-State: AOJu0YyG3hl+zTfGEXn6TCq/rUaS6AOO6FPgf1IfGrcIfCI4KiTfexK6
 mHFmFZLLYhWmRhH4AY7jfp9nPMbd6R7HNAfeTzEzjPpcYq3VE7VI2RciTc3572EgsWbwJ9yTkca
 IjaHBuXHpZUbk10LAJcLtW8KKK+U=
X-Gm-Gg: ASbGncvym68oYuGnxDUQi8HMfe95Sb0drMw1h5u2qC+a5TKgU8idMRxiVYzo1IJ0VnP
 tMzUBTYod9BcyOeN32QsNvaTs4gTO77aQ6UFbDdDoTHbXDtJLlGHfgaUaToRYlu29l1G3uGzDeM
 R9BQzxvUkMU8wx1HZU1Ki1MdmK8QxnHTj0mtx0
X-Google-Smtp-Source: AGHT+IHo5epE+wWPdEacWKZpd7JDO/tTTXCHCJce944Zn0xy3qMurQRZbb8jjwATMyGxlpQtSlSOLQSsvWPQRYA5NxA=
X-Received: by 2002:a05:6402:84e:b0:5ec:9e6e:c48f with SMTP id
 4fb4d7f45d1cf-5edfdd21b85mr3636914a12.29.1743341637904; Sun, 30 Mar 2025
 06:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250204172319.3361870-1-wens@kernel.org>
In-Reply-To: <20250204172319.3361870-1-wens@kernel.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 30 Mar 2025 19:03:40 +0530
X-Gm-Features: AQ5f1Jru7coeb9GEJy0cq7EtKl3slS8ZsB9zKT4ed_crJn-caKFjBVYrarUvUtc
Message-ID: <CANAwSgQTMBLW2Y5YHpoAYDtXHyAbD9-s8KpWU1zBTRAB=rsJow@mail.gmail.com>
Subject: Re: [PATCH] rockchip: io-domain: Enable by default for all supported
 SoCs
To: Chen-Yu Tsai <wens@kernel.org>
Cc: u-boot@lists.denx.de, Chen-Yu Tsai <wens@csie.org>, 
 Akash Gajjar <gajjar04akash@gmail.com>, Alexandre Vicenzi <linux@alxd.me>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andy Yan <andy.yan@rock-chips.com>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Deepak Das <deepakdas.linux@gmail.com>, 
 Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
 Heiko Stuebner <heiko@sntech.de>, 
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, Klaus Goger <klaus.goger@cherry.de>, 
 Levin Du <djw@t-chip.com.cn>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Nick Xie <nick@khadas.com>, Paul Kocialkowski <paulk@sys-base.io>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Raymond Mao <raymond.mao@linaro.org>,
 Shantur Rathore <i@shantur.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Suniel Mahesh <sunil@amarulasolutions.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>, 
 Tom Rini <trini@konsulko.com>, Wan Yee Lau <wan.yee.lau@intel.com>, 
 Xiaobo Tian <peterwillcn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 30 Mar 2025 16:36:48 +0200
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

Hi Chen-Yu

On Wed, 5 Feb 2025 at 07:39, Chen-Yu Tsai <wens@kernel.org> wrote:
>
> From: Chen-Yu Tsai <wens@csie.org>
>
> The IO domain driver controls the I/O voltage for various pins,
> MMC included.
>
> Enable it by default for all supported Rockchip SoCs.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Reviewed-by: Anand Moon <linux.amoon@gmail.com>

Can we enable following config default for all the boards

CONFIG_MMC_DW=y
CONFIG_MMC_DW_ROCKCHIP=y
CONFIG_MMC_SDHCI=y

Thanks
-Anand
