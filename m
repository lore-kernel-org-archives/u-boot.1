Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1483CD6B6B3
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 17:20:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6FD589247;
	Wed, 30 Oct 2024 18:20:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jKgHn3as";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBCA188FEE; Wed, 30 Oct 2024 15:17:55 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65D5B88F27
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 15:17:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e292926104bso6384893276.0
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 07:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1730297872; x=1730902672;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4HYzZgfoh0GaQkDprol1pWrqKS0v+HpEiGeQ9Nb7j2M=;
 b=jKgHn3asrZPGspEYBKIhWq61Z91gOhRZs5FP8i8QNM07PQb01NNOZrGOI1ub8zhXEe
 20Za3yswT8ITxxyQi5CBW2BydYmtUQFZEehNBpmPLeNpbx+Rn+ZQMAgjMDBa4ih2bOlP
 aBXL4W6tOF+IUNQGLScBKm4VBgXcD2jrPfDpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730297872; x=1730902672;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4HYzZgfoh0GaQkDprol1pWrqKS0v+HpEiGeQ9Nb7j2M=;
 b=RpVi/qyVwcpxHNhx892GOKm7BIQYwJa/3IoUWWZ/o2mqzfrf6WfB1GFzIgD4lHG5os
 YzwQlAVMlU8j4V+1abbS+RZ8AC0THsR6BnYhXN8uP6fl2RG9b6tCsFAt+Vaa5j28hQfA
 dbsR+j7AGIzq4KMCHIfrV/Sa+Xim47WXvIV30iFayIi92l5HGeNkC98ynWvEKtCkeK0X
 tKLsW51an/VH241YAi584/afxNrjriCDLo9m9K4G+nO3MqgDlHW02csBtnBeBuKrvZxo
 97dXidBNynCDBqqTZH0UbjJhKVflQlxl6aOaEhrqNRExRmgwuYKbx/1KrKgBoDx2E/DH
 pdnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3D1k0ezuHAKHicQ1fAo56dWlcM2OZAm2IBtMsViCXDjiY66E4UzyTteZtZbWmrA39HYCiD10=@lists.denx.de
X-Gm-Message-State: AOJu0YxD8Kz99GD1+mPla0vbKJZ7bSq7wXCvq4Bpl/TG7qt5tqpxiYTP
 excZyF7AyoLhpJwGs+Ym90FY5i4zGSGL0O/Po/+HTVlsecIMX4ecE0cAC2CTAWWFU1IlcWiME15
 MMPSuXSpbIkCD0Hc9MV6sZDC5mcvgQ7kS8jbRvA==
X-Google-Smtp-Source: AGHT+IEHsfGMaPfeQMp4X35GtXF5eGsT1dxDLvpG/oK8cox7xgqmoEcGfy0jLRQmC3LZTquimmQt+W+LZJ6fnBaEr+o=
X-Received: by 2002:a05:690c:45c4:b0:6e3:23df:cc25 with SMTP id
 00721157ae682-6e9d8a76a3emr183562557b3.26.1730297872240; Wed, 30 Oct 2024
 07:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20241026201741.171073-1-marek.vasut+renesas@mailbox.org>
 <CAMty3ZB3ngMezv9S2XrNjXL69q+z9x-=qnQGga51FgTfA4fanQ@mail.gmail.com>
 <19fc4486-f8fe-4286-8941-76ff2a81b7d9@linaro.org>
In-Reply-To: <19fc4486-f8fe-4286-8941-76ff2a81b7d9@linaro.org>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Wed, 30 Oct 2024 19:47:41 +0530
Message-ID: <CAMty3ZAJrKvUAxWg9CfKtyrjw+WnHOgwkfAJb+N-7d3NyXUrxA@mail.gmail.com>
Subject: Re: [PATCH 1/9] mtd: spi-nor: Remove recently added nor->addr_width
 == 3 test
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 Andre Przywara <andre.przywara@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Pratyush Yadav <p.yadav@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 30 Oct 2024 18:20:04 +0100
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

On Wed, Oct 30, 2024 at 4:15=E2=80=AFPM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
>
>
> On 10/30/24 10:33 AM, Jagan Teki wrote:
> > Hi Marek,
> >
> > On Sun, Oct 27, 2024 at 1:48=E2=80=AFAM Marek Vasut
> > <marek.vasut+renesas@mailbox.org> wrote:
> >>
> >> Remove undocumented nor->addr_width =3D=3D 3 test. This was added in c=
ommit
> >> 5d40b3d384dc ("mtd: spi-nor: Add parallel and stacked memories support=
")
> >> without any explanation in the commit message. Remove it.
> >>
> >> This also has a bad side-effect which breaks READ operation of every S=
PI NOR
> >> which does not use addr_width =3D=3D 3, e.g. s25fs512s does not work a=
t all. This
> >> is because if addr_width !=3D 3, rem_bank_len is always 0, and if rem_=
bank_len
> >> is 0, then read_len is 0 and if read_len is 0, then the spi_nor_read()=
 returns
> >> -EIO.
> >>
> >> Basic reproducer is as follows:
> >> "
> >> =3D> sf probe ; sf read 0x50000000 0 0x10000
> >> SF: Detected s25fs512s with page size 256 Bytes, erase size 256 KiB, t=
otal 64 MiB
> >> device 0 offset 0x0, size 0x10000
> >> SF: 65536 bytes @ 0x0 Read: ERROR -5
> >> "
> >>
> >> Fixes: 5d40b3d384dc ("mtd: spi-nor: Add parallel and stacked memories =
support")
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >> ---
> >> Cc: Andre Przywara <andre.przywara@arm.com>
> >> Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> >> Cc: Jagan Teki <jagan@amarulasolutions.com>
> >> Cc: Michael Walle <mwalle@kernel.org>
> >> Cc: Michal Simek <michal.simek@amd.com>
> >> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> >> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> >> Cc: Pratyush Yadav <p.yadav@ti.com>
> >> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> >> Cc: Sean Anderson <seanga2@gmail.com>
> >> Cc: Simon Glass <sjg@chromium.org>
> >> Cc: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> >> Cc: Tom Rini <trini@konsulko.com>
> >> Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
> >> Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> >> Cc: u-boot@lists.denx.de
> >> Cc: uboot-stm32@st-md-mailman.stormreply.com
> >> ---
> >
> > Is this patch-set next version for 'previous' reverted series?
> >
>
> my 2c: I think I lean towards reverting the stacked/parallel support.
> The only one that benefits of is AMD, while affecting the core code
> quality. It also slows down further contributions and I assume it
> hardens maintainer's job.

I did try this before and it is hard to separate from the core. and at
the same time it is hard to maintain the core too.

>
> Even if I (we?) haven't made my mind on how to best implement this, it's
> clear that it shall be above SPI NOR without affecting current devices.
>
> Not sure if it's fine to revert everything, haven't followed u-boot
> lately, your choice to make.

If we find a way (not sure if it's possible) separate like a wrapper
or fix the things without revert - these are two points I can see as
of now.

Jagan.
