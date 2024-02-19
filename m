Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40696C48BC4
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 02:12:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1705387F1E;
	Mon, 19 Feb 2024 03:12:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gYk/a4KI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B33487F22; Mon, 19 Feb 2024 03:12:32 +0100 (CET)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B66B87F24
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 03:12:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5cfb8126375so1170556a12.1
 for <u-boot@lists.denx.de>; Sun, 18 Feb 2024 18:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708308744; x=1708913544; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ljYjAPElwjayq099hXdFCVJTp/jnQEpIN50fgahPZhQ=;
 b=gYk/a4KIGeTFMqfDAuYdVUts+rwY4HayPd3mlVYQo+585a39Zp02LbuNrWZOlyPpqI
 tNb+M5IMKS9rvaXfyHtkBsf/Ye21DuS2lt0Az7VusE9V0FD2kqlbjCGWYZwwJ9D0NaRQ
 LQaoyuKMRKeHonqsuPI71TW48EvrC4GLYESeQZlxP9et6NCrXOuMOlVEmdLLnD84FrEE
 MHKFf3RlM7pk9ND1ZfNGJ2ShFzEU0DP75PJHHzL3cr8etcbCtvitxpnU+fCbyrvn+HxU
 8l5QmXdHP/uXj/jYj5S0lL52Mn0+vdmx/2794U2LiWkHx0vsmHcYmfO3D6YT4FQZBpE4
 Sd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708308744; x=1708913544;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ljYjAPElwjayq099hXdFCVJTp/jnQEpIN50fgahPZhQ=;
 b=PjCMk9SntBFV/qUy63nHhdrY+cArt93PPyxTFit588oPn3S17I+9NqC0Te+2OItGSO
 0O7Zhq2GSxia+XD5mjh5wR5ZfFeldIe7CBSzC5qJkPX+mTuPquVI0g16X+Ea1D2OwdeO
 RSTxUxoayGK+tAEenkiH9T6vvTWHPe2cgkUpWgSl3mdVGKT6xyy8T0CxEj6dSBKlZR/u
 bPVHkMlPbuAH68smbx3gPo7oLGOnL7WxyqlwCVSi6pMkgdT3i9afv9d94Y8pJPeAMaun
 T+K84JpAACfaMkG1/2xQbQfqLtJVXwP++Z6diEYdd4Plusb7yG6ijgJc2g00RZrT4rBe
 d3sA==
X-Gm-Message-State: AOJu0YyQDkVNV/EAkZA8TBUsorhu3BYSPXy4597/sV3FGrf9BivbNjDg
 fjeozmJ8eQle22UMdZVBFpWqRslA/4LLKxu32QWD1t47nAOdyiBlzuHx6FS0iKwyUwxgs4CbKZC
 jMwZ5ruzBe1vV3Msuq5fLNWAEq1Y=
X-Google-Smtp-Source: AGHT+IEIPL3D6vaP36RN2LT1qfJLykR7+5DO58LEuTF5xXogAKtuoLuScus9omvojnA9GYxKOLH41Edp9kOzfGXk0K4=
X-Received: by 2002:a05:6a21:1a9:b0:19e:8293:f362 with SMTP id
 le41-20020a056a2101a900b0019e8293f362mr14248807pzb.2.1708308744427; Sun, 18
 Feb 2024 18:12:24 -0800 (PST)
MIME-Version: 1.0
References: <20240218211958.2849847-1-Mr.Bossman075@gmail.com>
 <CAOMZO5DQruTiaWMj4zv8gKyUJqtYqb5bmf7Z-Upc7k2+6yCffg@mail.gmail.com>
In-Reply-To: <CAOMZO5DQruTiaWMj4zv8gKyUJqtYqb5bmf7Z-Upc7k2+6yCffg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 18 Feb 2024 23:12:13 -0300
Message-ID: <CAOMZO5AgYn1i1U6b85b3-6GXigY3UoCJ=1Zy4PsREGD88B-uEw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] arm: dts: imxrt: Add binman support
To: Jesse Taube <mr.bossman075@gmail.com>
Cc: u-boot@lists.denx.de, 
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
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

On Sun, Feb 18, 2024 at 10:39=E2=80=AFPM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> Hi Jesse,
>
> On Sun, Feb 18, 2024 at 6:20=E2=80=AFPM Jesse Taube <mr.bossman075@gmail.=
com> wrote:
> >
> > Enable binman in Kconfig and in device tree.
>
> Please explain the rationale for doing this.

Also, it seems that this patch alone does not do anything useful.

Shouldn't this patch be squashed with the next one?

Then you could explain in the commit log that you are using binman to
generate the binary that is suited for booting from SPI NOR flash.

Do you agree?
