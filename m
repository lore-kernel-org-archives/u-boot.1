Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3837EC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:23:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BEEA84BAA;
	Mon, 13 Jul 2026 15:21:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Bn9xf9kA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB07984B48; Mon, 13 Jul 2026 15:08:55 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4A0884B3B
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 15:08:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-69531108f25so5108366a12.2
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 06:08:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783948133; cv=none;
 d=google.com; s=arc-20260327;
 b=jOcixZvix+d6WbD9P0CUC5+bSWCGLpE4GZxiJDydcggfXoGj5/d4egTNuR26lrmTLg
 w0NSWpcqTsEb987QCQNQdNbg8eTsp2jq4I4IpjJvRmATEz8ael+78Pj2K4DqpvDRcCyR
 KTL2oqnzOD3szBIZlNLG6j4zn8KMt4/nhihfw7G8bAcNCaZeHI7rsdmRWHoJjV15PA1Q
 JB6OLMbQfIvCI0VF6ljYRHKjUfK+2fMWZLmjQzD6DSxSNSEoI6zkXpWkusrrcT/plG/d
 ICWa78Qmc4KDp6Op++U7v7/lKggjN376GEmXJJqoWOInAHKQcZycwbP16vpx1km0Djrx
 tPIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zTreEzNmnp6rZRjNzbtthpeVnW48wKlZ3gcayTf2eVY=;
 fh=Dh6iP1Q0eahL8uvxd9s3ZXBAp/l6OgJ58DNPUsLhKz4=;
 b=OUAp4kormADhgQva7anFDOBbqMpzi+3ztWPXCCryFnkFm+XJfV8boCg33d9gOfAek6
 RIBsOhmrgsZEV94TJ0Wbdy1r6hiMSspPzbi0DgGYtKRMsnKf0gPKmLh/jNj+xAJID7yP
 FhKjNGSbYZu885pnCqMhF9dsMLEVJhH7Oy9jte9dGXASieHOCLjHKzn3l1cFg+a0dX72
 70CIFO+xOjrRAlsx91ykQ2o9SylUuBQLSIFDwUy6N7CmEL/4TNUbbwlrXREW6y1U/xcg
 L5ug9kqrqMBXcqUufXEv6Mg5IRZXkAP6zlyKkHca5EvgQ7C20cEiBXEvZHhZnAEA+XdQ
 xq/Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783948133; x=1784552933; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zTreEzNmnp6rZRjNzbtthpeVnW48wKlZ3gcayTf2eVY=;
 b=Bn9xf9kATdRI6TS7nACN/86lfhMc/V5aiS7kyCEUzDE5zbv5eeV8L5EIAvu98RBYMv
 yKC1vxOxGpVYh/2mhN0NnKC3oAqxVyN54CfDyV437bfTH5Y5k8S9Gd0YDfNiXbHcBRoo
 +EPx0b1Xy7lQ7QKtgP0Ls3Yl2CpzmJyfJ4iTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783948133; x=1784552933;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zTreEzNmnp6rZRjNzbtthpeVnW48wKlZ3gcayTf2eVY=;
 b=DgMxxyP3K0fBTSIno2FCIUJu5Nu5+H82dF64mDGvA7vXXIpjAH4fXyKsEYIOZalBK6
 TYnIa8Rnh5rDnYR6RXFajID5zbIOxrD3+6Pyo/d3BMctTOmqbsyaN6HxV58oX0CwsKlp
 +wob3ELI7UXBLhQoyVzPbRWKIUCSliRyP1+iqpkjAaFM5KCzRa5CErzAIX8pBENS5HM2
 jlbHPRu/fAd2dpu3dvLiDzBmDgiELPW7Wx4DXOX2ecoMF3OrnWBLKGRfWEEqT5akfytE
 rVST/OI8Amq1hDEPBX7pA7J0eOJw/CISIxJrUGIkESvuw/6UqHV2FDOwLgxHqZTjC3Ei
 JtOQ==
X-Gm-Message-State: AOJu0YwNtPTxnH7OxmAJaXgGvI9/2zi9D0W5qoHVUkOBSGVPteSmxD+H
 03VtP/ZxmZrSqEw5v4Wez8u9xwFGbeNTWFl6RrHW/R2iS8D6IvaDaXgVeke1wlr3ORW00bDcZaK
 AhPGHt6ezsIAsW5Cm+sT1WRJiKzEIKM75uKMmGs1p
X-Gm-Gg: AfdE7cn/vSsXP85scr1Uiv+UfQaA4lhxnTBGezY0xMl0v8odeZiF2OiU9UHKSYztLbi
 0yI08BfUut1oBX7So4jwrG34K0ybp/3+qDFI1hldHJjuMXGch5/YHn3VjclpI610YyrvG1DqT+0
 bhlWB+O1L4JG9H43O+iWxkuhteKXATJaejLKz9evnb8X7IgYbt08fGxxmyKxudrxEvZZ8FhhfVT
 x86AZa2wwKeWvWxT4sdM5ZyLlpv1w7E66Z7ekE/e4bmz2XBLwc3gQ4ZgdCyhIWYpaJt3Pj/D0Wz
 4fESoA==
X-Received: by 2002:a05:6402:a28e:20b0:69c:7985:5aa0 with SMTP id
 4fb4d7f45d1cf-69c79855b78mr2026257a12.16.1783948133294; Mon, 13 Jul 2026
 06:08:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260709-mt8188-add-power-domain-v2-0-589ace7d30e2@baylibre.com>
 <20260709-mt8188-add-power-domain-v2-1-589ace7d30e2@baylibre.com>
In-Reply-To: <20260709-mt8188-add-power-domain-v2-1-589ace7d30e2@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 07:08:40 -0600
X-Gm-Features: AUfX_mxW0V3YpMcamXMp-wEd66AfggehI_zRBR1i1cnWV9wnAHO39dwh1D8cSOw
Message-ID: <CAFLszThGUtJjPYEKEXA3NOmVpmC4xoaHZxt_fBuM-j_Q5P4ioQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] power: domain: keep Makefile and Kconfig sorted
To: jstephan@baylibre.com
Cc: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Brian Sune <briansune@gmail.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Sam Shih <sam.shih@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, David Woodhouse <dwmw2@infradead.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Marek Vasut <marex@nabladev.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Johan Jonker <jbx6244@gmail.com>,
 Carlo Caione <ccaione@baylibre.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 13 Jul 2026 15:20:59 +0200
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

On 2026-07-09T12:58:06, Julien Stephan <jstephan@baylibre.com> wrote:
> power: domain: keep Makefile and Kconfig sorted
>
> Sort the Makefile and Kconfig alphabetically.
>
> No functional change.
>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>
> drivers/power/domain/Kconfig  | 62 +++++++++++++++++++++----------------------
>  drivers/power/domain/Makefile | 12 ++++-----
>  2 files changed, 37 insertions(+), 37 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
