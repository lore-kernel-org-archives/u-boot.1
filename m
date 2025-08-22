Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DD6CA0EEB
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 18:02:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B91080422;
	Fri, 22 Aug 2025 20:02:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TXf9n92O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7A4380548; Fri, 22 Aug 2025 20:02:52 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD70C8006D
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 20:02:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e95011504d4so2426600276.3
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 11:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755885767; x=1756490567; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIv7oUH4s/c26WwPUWrjcwYNtZRcdy9v8mJIOdjw+RQ=;
 b=TXf9n92OqCEKe133Ee3LQiQn3LSI0S+BXXQCEk+yvPEuBDXImlNghOI7CA4imt3bkH
 lJJVjH37Nf3Zzn5CSXmg3yLSYFrmVBClzXbTloYfVkiPDdyWwBXqRGWSqIrwlr4ILdYB
 LiPqF2vtvWWu5ORU6Wu1g6q3opmXRfUg23gboPK8jBviXBxIUhXEHm2VzdU/+Tj2m3yq
 dVVksc3JcHXoO4HBHi85+cJTtlu406j2SvujujdUl7YDPOPKM4ir0zvsfgIc9q1vFWHP
 mZKh6T6rpx2sWII28p3HyUDKf3HLDRRqUp39YqaGz43i8ah3yD12sC+g3YAXjiSGji/9
 wsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755885767; x=1756490567;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nIv7oUH4s/c26WwPUWrjcwYNtZRcdy9v8mJIOdjw+RQ=;
 b=oRmb4hHEAJkWqYGLUH69hLn1zSkcX0LqSmQBrE2K80+0+Ii9xxyt265Go0WXPXG0Wk
 6gblfqOIVfL94dpFYnMYGqMGl1CxkAQprdoSzZMXw+IiCjUtx9C/NYwUT544YaoRyVQ+
 Mq3qz+HHoWPnIUP51vVpv7dF5P25/ma1wFdnfQyIFUw9Qb5PJrSP0sz3++8c6L8SzF4Q
 4YAhDHIB0rizNtWS2+7pEav3lf+tTKFkRkkG3Zy3l0nmXlsy0NskfZnTbbhRtK02L5E4
 fEdn/5HfpYKbowYh0DXUb8A6sFL5w2sDlZ22cSz9Vx6kimVFTbmjIoUallHVRq8zq/4f
 fmow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkXLceWSsI800j3WAZMP/eQFe82fSkUAe83NesPdsRUldeOxuuz7F45YpinPdwcNjvekLrB/4=@lists.denx.de
X-Gm-Message-State: AOJu0YzNJTFAq5tPvIXsl7gvS2f9PAsbq6lqdfZ5wZnKfc3YSktKfH/+
 KGgXHS6NDm0twUWI57Gq0qHRTJutVuKSZKTeVLHnjOdoS7BKzeJc9G49Cf8g1N+ZJxAORISBIZi
 7gmQd7to3hVaSrvy1RsQhwLLzedymkAwmqr/gykMqIQ==
X-Gm-Gg: ASbGncuTr3PRTpxLFhzKJchynxMZj8/6Vv1uBk12nFXzuy/dkb7IhitrjPv5ifdiQqv
 DzCtIgvr/7kq35LZmCoZFZuVnvs41fs1W51HJB8cVh2IfyYo0IyFfwoVMg6zt9RAaVt1WaHyQ7F
 PKsCh2Rwom22W8hdSU0Of/BCRylwz/if9IKcdt2bVlGg2JAO+bD36ZinryxS9oUbU05PbzxVxzZ
 np6q5ajJCcuZuCk
X-Google-Smtp-Source: AGHT+IEkQRWqpesiPQQFYDnadocl2LQhSgXV96SI1BVhM03C77TGrw+dTxmNXNY3TVBwk+32lZozGnc4fk1C4FJjz4c=
X-Received: by 2002:a05:6902:4111:b0:e93:437c:c6c2 with SMTP id
 3f1490d57ef6-e951c32b6eemr3419010276.17.1755885767467; Fri, 22 Aug 2025
 11:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250806222710.23773-1-semen.protsenko@linaro.org>
In-Reply-To: <20250806222710.23773-1-semen.protsenko@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 22 Aug 2025 13:02:35 -0500
X-Gm-Features: Ac12FXxo5dM5Tzhnf8CwqYOfAFM7njiUj_1TgWnZfuegxHGZ3NFc04Cxi-ZcT9Q
Message-ID: <CAPLW+4n5m6XmsL2j1V76C+YdMxh89zpfZQft9tPEzDQt=2csrg@mail.gmail.com>
Subject: Re: [PATCH 00/10] samsung: e850-96: Enable USB host and Ethernet
To: Minkyu Kang <mk7.kang@samsung.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de, 
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
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

On Wed, Aug 6, 2025 at 5:27=E2=80=AFPM Sam Protsenko <semen.protsenko@linar=
o.org> wrote:
>
> The E850-96 board has a LAN9514 chip which acts as a USB hub and
> Ethernet controller. It's connected to the SoC via USB lines. In order
> to make this chip functional the USB controller in Exynos850 SoC has to
> be configured in the host role, and the corresponding power regulator
> has to be enabled as well.
>
> This patch series enables USB host and network support on the E850-96 by
> making use of the LAN9514 chip. While at it, enable all power regulators
> (LDO) in the PMIC chip which can be useful in the bootloader and kernel,
> including the regulator used for LAN9514.
>
> Sam Protsenko (10):
>   usb: host: dwc3-of-simple: Add exynos850 compatible
>   board: samsung: e850-96: Set ethaddr
>   board: samsung: e850-96: Add ACPM code
>   board: samsung: e850-96: Add PMIC code
>   board: samsung: e850-96: Configure PMIC regulators
>   board: samsung: e850-96: Extract device info from fw loading code
>   board: samsung: e850-96: Add bootdev var to choose boot device
>   configs: e850-96: Disable CONFIG_DEFAULT_FDT_FILE
>   configs: e850-96: Enable USB host support
>   configs: e850-96: Enable Ethernet
>
>  board/samsung/e850-96/Makefile    |   2 +-
>  board/samsung/e850-96/acpm.c      | 169 ++++++++++++++++++++++++++++++
>  board/samsung/e850-96/acpm.h      |  27 +++++
>  board/samsung/e850-96/e850-96.c   |  97 +++++++++++++++--
>  board/samsung/e850-96/e850-96.env |   2 +-
>  board/samsung/e850-96/fw.c        |  45 ++++----
>  board/samsung/e850-96/fw.h        |   4 +-
>  board/samsung/e850-96/pmic.c      | 144 +++++++++++++++++++++++++
>  board/samsung/e850-96/pmic.h      |  14 +++
>  configs/e850-96_defconfig         |  10 +-
>  drivers/usb/host/dwc3-of-simple.c |   1 +
>  11 files changed, 482 insertions(+), 33 deletions(-)
>  create mode 100644 board/samsung/e850-96/acpm.c
>  create mode 100644 board/samsung/e850-96/acpm.h
>  create mode 100644 board/samsung/e850-96/pmic.c
>  create mode 100644 board/samsung/e850-96/pmic.h
>

Hi Minkyu,

If there are no objections, can you please apply this series?

Thanks!

> --
> 2.39.5
>
