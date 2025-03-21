Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5DDC36000
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 12:31:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2A2A805C8;
	Fri, 21 Mar 2025 13:31:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YcfCGnBt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED98E806D8; Fri, 21 Mar 2025 13:31:21 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF4AB803DF
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 13:31:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5495c1e1b63so2357540e87.0
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 05:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742560279; x=1743165079; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dzs883+pFRcUERp7sj/RD09VBnnYPOUc3qNn3/g6tI8=;
 b=YcfCGnBtT9zzL7q8FxkKa0nf4Xr24YxCUh+SVKzks10eutBI9Z4C+rXzfvfP1T68+O
 sjNKL0SizccFJSx+Gs9MN7pPJFZh6taY7gbtL9/KekhXQlAJj9EHIefR/8INST+zu5rc
 4xm8tmhhS0Hs5Ey2zIlCWsc3PXdWrx5hEMu6NnvuITwuB0nHvmKy1IkGHI0Jt+lgzqGA
 Cl8wkLtrfYmtKyjaGSJ7x7mhB37kblIPhynbEHgmzW9x+riXJzzIzQrT9POSFpLfOMst
 FtevZ3BLJZanVYUH1Pbrlh+9J8OL3Nxd5c+rXbXgDTH547fSWbRb7lPjvbhSzewURmJ2
 EVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742560279; x=1743165079;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dzs883+pFRcUERp7sj/RD09VBnnYPOUc3qNn3/g6tI8=;
 b=iKdUtUR4n7YMY2XwWo6o3LGvdkJyC96VJkhIVqGv5ur3smrC9QcaLXWkY8vpgzijnW
 uVjUuO0aLRlJvkQ5qVunDNXzrF8rjaUOqwvCBXP0WoUutG4hDH0UGTD4ceC1sV78pbDT
 RNB3kkrCGNqNiLmu6YiiKqePK5pS89E3vhuPXyhfJMmS52lXwiHum5f4ztHba0FTIxAt
 n/S25Y73Rtp+xqP7ClRwB2DmcGH/GV2TPkydJ+7c0V7GXnjtf0ANFl2a37EVX2VoLlRP
 e6w3QeQ3Cx4hupVoYESbtbSqAHlK0QO5IsNGmoDIQ+a4yF33hS6um9K9CtHthxJpquF3
 uQww==
X-Gm-Message-State: AOJu0YwSX12rcL9Rt0qmKYGG1GB5H2N1TljUk/16S71mnWeT83NZKrMa
 hdYSbH06+uI1H4Hq26NsjEgdo+hTiYLoUl1MwfRvNQEKvsfJDPyYD+RVCoQc1dgRwkOh1y1MHJT
 eIjGjDhU+Jm+7lmXOF06MltdEoAs=
X-Gm-Gg: ASbGncvXGek1czMkZS0eGKfI2GXHfQL+dsnCAbDlGZQAATHpTi9A6M3w77nBFvzS1pm
 XmjtkMVJYGEkqSBbSmNmvYCeDGp8m4L+B0EqRrEPrVe8g2pJbH+XVG5b5fm9Cy2+E96Vzn3KEPA
 LnnrJgDj6tWL17k7t7GWogT2oIX8qO3v9UL/UZgcVehJ6fEa2z0HqpW2wpWj+gYuGKN6bk
X-Google-Smtp-Source: AGHT+IH1BhIkDCERlTZoQiIGC7GDt2WJZMm8PIUsnXQlyyPIgCwWFOQg4/fhfQT0YEM3a9PcewovKXNCn2QQMEoP7qE=
X-Received: by 2002:a05:6512:3e1f:b0:545:bb6:8e41 with SMTP id
 2adb3069b0e04-54ad650cc86mr1178016e87.52.1742560278812; Fri, 21 Mar 2025
 05:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250318233849.587520-1-aford173@gmail.com>
 <20250318233849.587520-2-aford173@gmail.com>
 <CAOMZO5Ah3zG50Do_kGx=63RmX16hFrrgzsBk6Zgm6tQoB-VTLg@mail.gmail.com>
 <CAHCN7xKd2geEkK77kYBp1jQJpiM_NNpTPP43ONNYsUNgEtaVrA@mail.gmail.com>
 <CAOMZO5C2dnenrhcUgRaKYuYPtDbKgvXQO4JQT34GPXfek1Mh8Q@mail.gmail.com>
In-Reply-To: <CAOMZO5C2dnenrhcUgRaKYuYPtDbKgvXQO4JQT34GPXfek1Mh8Q@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 21 Mar 2025 09:31:07 -0300
X-Gm-Features: AQ5f1JrVzBKaO03ag7PZFUjDSDR4Ze6B4Kjv8B5gSJCAIVy67aHVovZxXIrRLxc
Message-ID: <CAOMZO5DvcfD67MnGHYrt4hYv+y05=QfUt412c8Cnb3ShoU7HbA@mail.gmail.com>
Subject: Re: [PATCH V3 01/10] clk: imx6q: Properly handle imx6qp ECSPI clk_sels
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, 
 Michael Trimarchi <michael@amarulasolutions.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Tim Harvey <tharvey@gateworks.com>, 
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Peter Robinson <pbrobinson@gmail.com>
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

On Wed, Mar 19, 2025 at 2:27=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:

> I have manually fixed patches 1 and 2 and now CI is happy with the series=
.
>
> No need to resend it.

Applied the series to u-boot-imx/next, thanks.
