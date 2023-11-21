Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D92C5ACB3
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 08:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB8FE87582;
	Tue, 21 Nov 2023 09:58:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r2Sf4kZG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64E6387581; Tue, 21 Nov 2023 09:58:24 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1358487585
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 09:58:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-507be298d2aso6913150e87.1
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 00:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700557097; x=1701161897; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dQNqB0r2XXAbSqJAKo+11lwYMzeNyag/yv4UbUpd5ig=;
 b=r2Sf4kZGWLQMrUQXaw56Q5WS5j7y4zYns1b+U089oqxbWV+xbrysx5r+DSCX2Ce+Q4
 wW9nb4H5qL6XxRvuYLDPNHj1cPqo11PIrDxO8LU46SnvOxuFjYT8CPkxf9TIvxpTjW3K
 1sR8mLRJAzQkyw1vFy6WGRzednhgg13utb9LHlVF7m56N4tyGjbo8J3Fn9f+4uVDdwKP
 IWFTEaxjtri2vm0ly24LMKB8Ukv4Mn0ize+fxxEAc3YG0EF84dshbumblSLEGtbfP4yM
 xNQPpgbLpMYY7b1AMk3EEE1ys50olLEXiBP3H9zeA22XFGHGsmLNajFLcgOgJN0xotpJ
 uT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700557097; x=1701161897;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dQNqB0r2XXAbSqJAKo+11lwYMzeNyag/yv4UbUpd5ig=;
 b=p3EYH57b8NCg9Wqg5sPCaF2wMoHDW3i4Cgrwpacrt31RyLPOlc9/pfwem6pRFZsQg0
 FrgOj1evAnZ0hLsDkdGyybS+vVMAFXfDolwYTvRfXQTj9o5EedmmbBV+miMz4zqHUMFM
 /FlRq/+ypCxLI+RpvMKfmMd7AdbAikxZjv4MwQ3gBJfJfhRvFmmOMOXZCMtMfUr8Nylt
 mlUYCBMiUfNZ6MeBC9YVlnFtyPzg202l1J2qPk3bH6UTLjZM4LQXlNK7zxuPTxzPzzdw
 xdFEfcr66+4Bb3wbBRLSRJvOROzOkFD6v3DyUpSyFey2xX4J8yZST+uI8/3SAVrmrkEZ
 YzeA==
X-Gm-Message-State: AOJu0YynpDpCivCvXESbRNdO5+WHpRM7wmJzAZokKauTBbxS8blvJ5aZ
 gA9rtP/iFkfGsghCBbbwBfZc3KRPmAbMLrkeAfBY+UbuieAWmQ1mTV4=
X-Google-Smtp-Source: AGHT+IHVFL8MX8xHzbbxwmS6LcVOul9FSYfxGtpZ7O7mox8StE0CCrdv5rnEjv9VWfI/UHCoWN7tii+S2pM4AVo0wyA=
X-Received: by 2002:a05:6512:b92:b0:50a:4b96:5d09 with SMTP id
 b18-20020a0565120b9200b0050a4b965d09mr9035831lfv.66.1700557097268; Tue, 21
 Nov 2023 00:58:17 -0800 (PST)
MIME-Version: 1.0
References: <20231118215727.95086-1-heinrich.schuchardt@canonical.com>
 <20231118215727.95086-2-heinrich.schuchardt@canonical.com>
 <CAPnjgZ3f+emLPjdhSSLBnGrGbqnHe1a5cajyL0csdVz1KTDfqw@mail.gmail.com>
In-Reply-To: <CAPnjgZ3f+emLPjdhSSLBnGrGbqnHe1a5cajyL0csdVz1KTDfqw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 21 Nov 2023 10:57:41 +0200
Message-ID: <CAC_iWj+z31=9e1N0XOkRBWrmfTwxWXLhMWpOGpSbr_wK+r8rvQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] acpi: consider XSDT in acpi_find_table()
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Sun, 19 Nov 2023 at 02:45, Simon Glass <sjg@chromium.org> wrote:
>
> On Sat, 18 Nov 2023 at 14:57, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > The RSDT table is deprecated and does not exist on all systems.
> >
> > By preference scan XSDT for the table to find. If no XSDT table exists, try
> > to use the RSDT table.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> > v2:
> >         consider that map_sysmem(0, 0) != NULL
> > ---
> >  lib/acpi/acpi.c | 20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
