Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C59C48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 12:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E5B4879AF;
	Mon, 26 Feb 2024 13:59:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zf9VziI3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12139879AF; Mon, 26 Feb 2024 13:59:47 +0100 (CET)
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com
 [IPv6:2607:f8b0:4864:20::e35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48D1587CDB
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 13:59:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-4704750edd7so380131137.0
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 04:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708952383; x=1709557183; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LMlYy3V51irdhHvgrZMue0C5NrObO2P3CQL23wHOYoM=;
 b=zf9VziI3umFp2Us++wzr6rIGfRAvgieMNgv04I5HUQ3sl8Zx3PB+gxN+rsjtTov4Qh
 miIk0jXMeEg/kr3HOgpfZAAAGKbMELuOdfNipxpHAag5QpiinekkG8fpsXjBxA3+HiFJ
 iHP3OsQAkgG68MSNDZz6UhO6wJtvk82lVePEyS7QrjRgBZZOp9spzat4RgWXJkfeqnrZ
 yUd+/i6zyvwe7Z7+t7nlGhIxxQpfeZVNHPLYD1I5nFX/xytSU4R260GA0AFF78UFUWWS
 d1rYNw3ugizlDRbtaZ5SG/8MoO5dKqQiKjOheBwshYbJIyVYKs9KxgHgmjo3w4Pe3+pU
 BTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708952383; x=1709557183;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LMlYy3V51irdhHvgrZMue0C5NrObO2P3CQL23wHOYoM=;
 b=q+FIBHPzsvlhfsRyjPePU1dOE1y3XF6n/UWNMSj5Nd9Gx8H0DR+I/3gZeyb0P2nnHz
 OzHxOQ8AKhzuxDBq/JFEYjMSimOu3XiwqML4YKMh7iaA+jDszUQRDIPFGxvk87PkXQAK
 VuHr1cIQUbbTjm6Kp40UMkM8MT8vlAV689oX4HwFp39HW9hveflnlg+Erv350GogIv1k
 7og6bepjQsRx5y/C3SHDS0Jy6V3Waghdk+F41cyJr/z6oPi8BsvDlIGvaPzOpFscMXBQ
 3Ltpp+2PIzNIigaSB8wNSNYli5DBFZ9JRfC/rU113PZWMBtPs86tgXpEm+6mEOgs+3E9
 42VQ==
X-Gm-Message-State: AOJu0YzDYXQVvRAb8ver336/mEGltUHyBpojZFp/vbVvIyw7r3Nwubi7
 4csSGda77D2JGRdH+JDCoAHn68MUQtVm8Dj//buTpGu7O5QAHlXmrl5Pdaqqg/uXD7wl4o4L7ws
 WNTlsZCYkamf46mBso/olS2LQlcmbbUp3fUOmaw==
X-Google-Smtp-Source: AGHT+IGqCFb/uUC3zpCOnqQ7OQU7y7mjvQt+aZbOCmth5qX+CYE3uDF040IGnBVpMLig1c3bBa7HfCAm0wyRtZgQ3aI=
X-Received: by 2002:a67:f313:0:b0:471:e03e:224c with SMTP id
 p19-20020a67f313000000b00471e03e224cmr3068872vsf.1.1708952383023; Mon, 26 Feb
 2024 04:59:43 -0800 (PST)
MIME-Version: 1.0
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-3-sumit.garg@linaro.org>
 <a5862ce9-8977-47cb-87af-e8da1839867d@denx.de>
 <CAFA6WYNEpg_zgRo_gD3ab3QR1e1j1xZCOb8ui-ZSV27U_Yv4EQ@mail.gmail.com>
 <04b243f4-c89d-4ddc-80b9-4ff83e9076aa@denx.de>
In-Reply-To: <04b243f4-c89d-4ddc-80b9-4ff83e9076aa@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 26 Feb 2024 18:29:32 +0530
Message-ID: <CAFA6WYOSPmQwrFC=kqWeYwg8kBETBxBgE2Zp5vmK4gJkUKcPDw@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] reset: imx: Add support for i.MX8MP reset
 controller
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, francesco@dolcini.it, 
 trini@konsulko.com, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, 
 festevam@denx.de, andrejs.cainikovs@toradex.com, sjg@chromium.org, 
 peng.fan@nxp.com, aford173@gmail.com, ilias.apalodimas@linaro.org, 
 sahaj.sarup@linaro.org, fathi.boudra@linaro.org, remi.duraffort@linaro.org, 
 daniel.thompson@linaro.org
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

On Mon, 26 Feb 2024 at 16:11, Marek Vasut <marex@denx.de> wrote:
>
> On 2/26/24 11:33 AM, Sumit Garg wrote:
> > On Mon, 26 Feb 2024 at 14:24, Marek Vasut <marex@denx.de> wrote:
> >>
> >> On 2/26/24 9:04 AM, Sumit Garg wrote:
> >>> Add support for i.MX8MP reset controller, it has same reset IP
> >>
> >> Same as what ?
> >
> > I can expand it.
>
> This does not answer the question .
>

The other iMX7 and iMX8 variants.

> >>> inside
> >>> but with different module layout.
> >>>
> >>> Inspired from counterpart Linux kernel v6.8-rc3 driver:
> >>> drivers/reset/reset-imx7.c.
> >>
> >> Use commit ID of the last change in that driver:
> >>
> >> bad8a8afe19f ("reset: Explicitly include correct DT includes")
> >>
> >> I guess
> >
> > Why isn't the Linux kernel tag sufficient here? I don't see the value
> > of cross referencing commits across different git projects.
>
> The commit ID is a unique identifier, tag can be rewritten .

Similar arguments can be made for git commit history. But the question
is have you come across such instances for Linux kernel where git
release/RC tags have been rewritten?

-Sumit
