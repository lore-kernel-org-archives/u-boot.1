Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D873CC54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 01:35:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D44E87F4F;
	Thu, 28 Mar 2024 02:34:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QGnuAERS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 001AE88076; Thu, 28 Mar 2024 02:34:57 +0100 (CET)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA5A987DA7
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 02:34:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-58962bf3f89so82447a12.0
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 18:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711589694; x=1712194494; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iN3w1WkmxNPOXHxRKACUGFQHA5M5Oz8IEhhRuGWY/MA=;
 b=QGnuAERS0BDRT66pdrapQ74slPTrUn1ENCI4tGIFnKiMtCL4xyUGz7NVtHgyMW+FEd
 sFjvBLsgieUq+nnxhEFVjZP1adMGL4WOfZWja285wcbBkClugUOmomm4gX/o9pvs5Iqm
 HRo3x7vs8J7NWe70tteQ24c0ykj+cciHlDx0ik1+l4jOASvIrNwR6yQirDCd42ErEtFU
 PkdngDOZF931DD5EjjpM3SM0pWqDwlHesFWmdEGj6WhdeB0GSqr3Fcq58SOnpsJ+UP0D
 MCQUFgTK9uK74yM/7BotlZyk9SpNXIaLmob7V2uSVYfqWM/hSYyRmNJXk5+3LxvhBMgr
 H0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711589694; x=1712194494;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iN3w1WkmxNPOXHxRKACUGFQHA5M5Oz8IEhhRuGWY/MA=;
 b=pqPzpIBXzRf3xgvcww0686qDkJsLCqZYrU08/TygAszGhFVU4Zz9FJpRKD97bE0YR7
 ZeY/vFkDb2147Xm2/NH1cm4AERdWNH783gOtrFaY2+ki3b8HwVnnRFo96z6L1lVWbTl+
 H7D7nggWi6QzFqgBZm/kYdd2lkls9M2PA5tEZzV42yPLGdN5hoQ6szc9m9RhZX6Vxp5Z
 MA0d2uCkk7M4Z7gkKRBiDh17e4shXaZEXhj/Nq/PzoW43y2Mdmq/yMhQi1hVRvancfGA
 xTMIjnnsN99gu60ZyWnJI8nj8iTIqapCBWkzTI/aADxN/roOmvbOcx/jnuQcbeWD9ky9
 xLQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzkiz5qu5An4Oj4zpEfaylQn5TVLTP+6/ugb+MNhNrpnidvqzAXV5jL26ZjhzGj04WgMjCzHNZxV5lqPyh+ibt7FVxXg==
X-Gm-Message-State: AOJu0YzOCTSU3Avqv68gt4mNL7KibIPebyG4Ljf7LppJxBAsO1OTJMVn
 japze23pATcc3WupXNXo6ltzcZCtAB3K6iI91a4aIG1U3hRBI6MNspoJf1I7DYuWGVGKgy0Z7y8
 po1HAzrqrQYCmtso+Io52WYg54W/0mIWRVus=
X-Google-Smtp-Source: AGHT+IH5fbX155MQkT2iJPgFg+omvZgM1ECn1Sjl/AOWxC9BEgkPLiLwWwnNg0EBUtwFQWmPpy82tZH78y/5FtezZps=
X-Received: by 2002:a05:6a20:3ca1:b0:1a3:b0a8:fbe9 with SMTP id
 b33-20020a056a203ca100b001a3b0a8fbe9mr1881914pzj.1.1711589694358; Wed, 27 Mar
 2024 18:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240328-imx8m-v1-0-2be5e6657a88@nxp.com>
 <20240328-imx8m-v1-4-2be5e6657a88@nxp.com>
In-Reply-To: <20240328-imx8m-v1-4-2be5e6657a88@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 27 Mar 2024 22:34:42 -0300
Message-ID: <CAOMZO5B3Bhv4wEH-fmG-z7hz+Dq1RTAtdsk7cLyZPsAKh-B5wQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] imx: imx8mp_evk: convert to OF_UPSTREAM
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
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

Hi Peng,

On Wed, Mar 27, 2024 at 10:27=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:

> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -1105,7 +1105,6 @@ dtb-$(CONFIG_ARCH_IMX8M) +=3D \
>         imx8mp-dhcom-pdk2.dtb \
>         imx8mp-dhcom-pdk3.dtb \
>         imx8mp-dhcom-pdk3-overlay-rev100.dtbo \
> -       imx8mp-evk.dtb \

Here you removed imx8mp-evk.dtb from the Makefile, which is correct.

You should do the same on the other patches.

Have you boot-tested all these boards?
