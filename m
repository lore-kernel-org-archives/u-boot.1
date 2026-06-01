Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9018FCD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 14:57:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 243FC848D7;
	Mon,  1 Jun 2026 16:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BNaCXkW3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44034848D8; Mon,  1 Jun 2026 16:57:23 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68721848BB
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 16:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-bdce61897ebso1109543166b.2
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 07:57:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780325841; cv=none;
 d=google.com; s=arc-20240605;
 b=Ddj2lrfmSMKSUoqtsEbARqNhmoZ/MppUV7IDwOKSpfCJAvud++pBNmSKVvjIddXGq8
 794bF/4uAbqndMyzmxiAK2i3/SyWR4zoQJ4sWEYdQUlhQvuBQE/vlOVpSSPBPhkYNK7E
 SL7jF70DTGy/PrJ6FHtaNJ8CKglp55gxGIjj1TxI0QN0wMvKsFsd1rs5lYKQ+9VRXSYp
 u3YS2GXlelduqyi0gc5H0k3Opar2fTOWp7zR0TvsIwAbuKGnyZnGfYFna3lzq77PkWRA
 UrSSYPtr5+RHCdclSnaqjuxhBRzusKdXcye6+7Kbazv9NKSNHGDdM7fFZZCkPGWpS4Hx
 8USQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zsGzaxhtUnH8CDVE0nl1csV2uiEGElsWv/sDTRHwZEA=;
 fh=aCaOJZgkkxSl3kG1DMjk4JErljQ5rHgaDbhrsapChVo=;
 b=dPXUySKkr5CJldvmnkvV37JEn/eAETOK4FCKFj6EY1hInc9hBJgwEiGCT3W/i7tq3R
 KI13yP9xHwNZ/puEYaMktDqUTi6/Onj1KJadXpZl7BIU2OhaJS+TC88Zf/lRkb4M2paH
 glQ319E334q9Z7/C9+Ov+bTl3YzbuSkTRFh5zMTcMj5yZLy21OJPjrSbKVqoKx1eo9YH
 Hf4IIWPm9KmG6T3GBU9tiLhQXXHRtrXiM21rd5yDErs59a8Oo76mlE/7t2An2s33YKOJ
 WAZ5uX/m2N2gqqNT9DBLZGZOVgpn6ohHLVhwfmWz7xu13CxK+L9VFvDqmf401J/SxIMC
 o6dA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780325841; x=1780930641; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zsGzaxhtUnH8CDVE0nl1csV2uiEGElsWv/sDTRHwZEA=;
 b=BNaCXkW3eop4BDTyEK1CE2vJz5KLW2AHBAIgD2LtXoZ9l3grB6v2hxuYficTc4W9f3
 HwD5FbAHpZYFsyJGgjCTZm6peJOWhOnb3yrwUKJjHh8BLu8Zo9puUnrajy0aCTTRS5+x
 CsP91CvN/n/OBrpal423zhXd0iAgoA1giR/vA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780325841; x=1780930641;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zsGzaxhtUnH8CDVE0nl1csV2uiEGElsWv/sDTRHwZEA=;
 b=SEp6JUkp6AFe1/0ZMorm0bONfqmQCFH/+DDt5E3pEmrVenbACB28P1tzmwh0pk5gIO
 OgaLoyaByiqABWCKjZ1yAMwZB92KBuKVzoRpKEckgFEaGvyMcwWYNdcL2XFItixQjfao
 uczpNND/FG/6emsTOZ83qCKa0NcM6WZXgavFazQSPsSIhfmd442KLBJOvBpLTnZo2yNK
 r7zJ0BLWDOYaqf0v18NIn3RSjW1bgEgXUXZE1SHyLRA6fM1MvpA39yw0DADzCV2Etalc
 6pwfkGSN22jFeO478BxXVG5iIFajrbUsPHxOa6o2LI/Th0sSlg1eKqXllLdo3aIF4Sf3
 J5bw==
X-Gm-Message-State: AOJu0YwhAWS6hfK5gRURl+LkFQoa0G7bKQSqs4fdUfC64orxQh/PSltV
 h34kYxrGNF2VuSZxIotfBidqQrxTZE3QZRa8jVEvB5zRHEV+NH+qEQGb0/9yrZhyD0q4HYkRS6R
 1dXsu+PxUghHyDFVci63VPSJJw5T+wBIBGUPjqjG9
X-Gm-Gg: Acq92OHSdRmUu74qbjuEcGxMl2/GidHNn0ekuikcHw0PftZebcdaYC1kBNLGTlORISn
 288sR6z9kLYssjhDhtzz8YUWKBfDrMQn3WwGqpAbABQHN7nRqI1ZsY7FrvIAE9Nn7LWoC0L1vl1
 GtIvWxnohzEWbes9wONbRUvlU94h9ybGqLtdvMrAKC5giAPkWZy/5SaSujrSIrkxfAJ9A16hFvp
 zsDm7wHZd8SssufqN+BoS5P9IHRLzxqBJQQWPHzhC34CPrV9uQbc6gELXdCkjsNHv7x62yzZ18a
 IeD/DI5heAuUbx4G
X-Received: by 2002:a17:907:7743:b0:beb:f459:718d with SMTP id
 a640c23a62f3a-bebf468b6cfmr355836466b.34.1780325840817; Mon, 01 Jun 2026
 07:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260526-devfdt-usb-v1-0-a4e22b23bfae@nxp.com>
 <20260526-devfdt-usb-v1-1-a4e22b23bfae@nxp.com>
In-Reply-To: <20260526-devfdt-usb-v1-1-a4e22b23bfae@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jun 2026 08:57:07 -0600
X-Gm-Features: AVHnY4Izr4kWKexes3FLJyFaaltAkphsfztTLjblB9AmQPZtmr01EjeOoRZgRg8
Message-ID: <CAFLszThEk96u1AsNHT0-c7L=CDpP-EAamhrGF2nu2sC1RUjCqg@mail.gmail.com>
Subject: Re: [PATCH 1/6] usb: musb-new: Drop unused variables
To: peng.fan@oss.nxp.com
Cc: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Kory Maincent <kory.maincent@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Stephan <jstephan@baylibre.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Peng Fan <peng.fan@nxp.com>
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

On 2026-05-26T09:09:56, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> usb: musb-new: Drop unused variables
>
> 'node' and 'fdt' are not used, remove them.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>
> drivers/usb/musb-new/ti-musb.c | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
