Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA86FFF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:09:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6658B8464E;
	Mon,  4 May 2026 14:09:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LLOOAzaV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ACCF8464E; Mon,  4 May 2026 14:09:19 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 820DC8465C
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bc264a50e7fso118914366b.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:09:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777896554; cv=none;
 d=google.com; s=arc-20240605;
 b=P2dwIG2XDuRPGGxcUAoO0PhOoKrmvbysfAwPzdpuCeiES7dbgwLfaMwA5ItzOaQZnk
 UC4ZusitF1ocSaOUmFWiIMWpBN09gN+9/5dpQoNmzsOynRckKljk9J2d9X+zE978rlz4
 nXZyOeu0zCHah14MzqlybrSZcbOQs+ysxVE+bgFrJNXBmt654gfQe7+/Nmz2XW+k0E9/
 0grcZ2aQZdtzLw6ZprG2GG5U3tmv7QhNBVkYBB9hwnxF7Z0kIHcwo6YOvCEojxUjx6du
 Zfy49VInQmS13BPY4Ov1Wi2kxa3uzHpW58qUMOZcY/159m+1fQi3ccqQldO0aXVlaERd
 Xjpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Sqv8fkfGnBqzCJUoRAX/aqbO7BQAWNhr4ORyi1CvZhU=;
 fh=PvMd4X2mdXT08JWfisjv9stH8Lx5t+gM5zKif/Je664=;
 b=L7HJCDDka81un4+2mX4wxK8DnJTILfSs8bIVQIBuraHrSopqvHoNJOwcaWUb2S4dX/
 SIJV6OAprd0MN7txYaopPSV2RBg9qOEgLKW04S3zuci6uoww2Jl7wuL0P64OkYoytLHc
 1GreVsOJQ6BDXZasbmlgJlo1mS7+Dnjf0UllxOIjpXBVPI2/2HAOJPs+48mEFVlHeU0z
 cMRYOGn85dcO0bKUuh+Ii+gQS6C0oYQXB5666PNT9bREGEnbwsy6YPRb5tkGLQOsQFDT
 FMK2MhnSGF6DA8BpB04K4wSxF0x93nptgt7fXqgkyJnSc1D9NJ00VejVlRcS/pbnwWMP
 8/9Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777896554; x=1778501354; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Sqv8fkfGnBqzCJUoRAX/aqbO7BQAWNhr4ORyi1CvZhU=;
 b=LLOOAzaVD1wfTTPf086EsYmBg8j6A12kadUKsYBacf0oy0j7I22yxX/+huyTlOruCc
 J++4Po7SDSSEveCujltgNmGeOPsEUpnpnIbVDp/jaZ+0rmFg1RitI/V8Va+k8sLPUeS1
 s6h61GUpla0USf9ivwB0wcx9j7QGRLHHl4cQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777896554; x=1778501354;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sqv8fkfGnBqzCJUoRAX/aqbO7BQAWNhr4ORyi1CvZhU=;
 b=G81vdZezRVJRyFo//fcAQHzghFVC8uCxiCgQ1KiGBTPbdj2OClvUCsVEaMkS+43lLo
 R8a2bKnqvJv2UDMDPnR8bBATsV0+BPIMQ3nuIurGyfV6gtyZAGhhwdrCXabOkJS5XuPo
 oK+mqR2jfCbp8d01x4k0M1epwlCg81ygL1MT1jdEvOIY2ykhIosnzUfQb3yl8TuPb+6c
 XvJRP9P42Ofw2YiV1fQYH1zQDO1kS1Gb1hqMuOyfyxsuUi2k6VJ57ZxfL5eO7ymbpnut
 HJBNRluE7z4vV2TRpeJQeRbSY3ix1iUKcbnntIOdiDg4QHPC2Tr9tcueS+E7fU34z3Il
 6F4Q==
X-Gm-Message-State: AOJu0YyboGnTN5MBs3E/OZ7R4Ri7EdRb+y83qnOdjp3ZTH13rdVCDtb1
 3GQzHgdn5O4xP9dqEfnEzq2VaFxuVGT4uKjr72f5IWHDlI4q8zM4r0cBFV7fSF2/yNySsax4Ioh
 44UUIzyr2jVvdnCrKChE0MWUby4CaX4vAa3TBaT3V
X-Gm-Gg: AeBDievF00CRm/+01UOccUAZ7aFQixQY3QQqao0wEGyp4gWJxnPPrL6jrA36cG5yVsC
 Ehspk6Fn7NpJeb1GhccYw5J8PcOR1sBi4s9lQ9aaZJhOn2LyWKnxxd5+nhXhrJcwfSYPhd6WKw9
 qxH9830m3UbNP8Tg8ke227R4zsOyi/ktJCh90HS8592VNfHuItNVGj65Dzm2wRptqf+aLB7EBpp
 VRhgh3V6W9Iqym1eVxYqlIM5XnJh+/e7WauhKLjg0mon9EhAmSC1KMxEiT4HzeKl4LInLOYTJeR
 c8vb2svKzNgN+AasyPKZ9+kMrRk=
X-Received: by 2002:a17:907:198c:b0:b9e:8e4:8765 with SMTP id
 a640c23a62f3a-bbffb23fe1amr503557266b.10.1777896553866; Mon, 04 May 2026
 05:09:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260428-spl_fit_full-v1-0-dde63beeaab1@valla.it>
 <20260428-spl_fit_full-v1-4-dde63beeaab1@valla.it>
In-Reply-To: <20260428-spl_fit_full-v1-4-dde63beeaab1@valla.it>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:09:01 -0600
X-Gm-Features: AVHnY4KnXmy_yt6lP5Q7Ca6KdXFlW6yr_UCvN3OfK05FZVd8Cu2zmLZ4QG2HSh8
Message-ID: <CAFLszTiJefn22TX_svrwuj+dP_ytsPCz19Vxgkp_B1f2p5t1VQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] spl: call ft_board_setup() and ft_system_setup() if
 enabled
To: francesco@valla.it
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>, 
 Frank Wunderlich <frank-w@public-files.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Anshul Dalal <anshuld@ti.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Ronald Wahl <ronald.wahl@legrand.com>, Simon Glass <sjg@chromium.org>,
 Dhruva Gole <d-gole@ti.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Michael Walle <mwalle@kernel.org>, Marek Vasut <marek.vasut@mailbox.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 David Lechner <dlechner@baylibre.com>
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

Hi Francesco,

On 2026-04-28T20:24:41, Francesco Valla <francesco@valla.it> wrote:
> spl: call ft_board_setup() and ft_system_setup() if enabled
>
> If board and system FDT setups are enabled by the corresponding
> configuration options, perform them also in SPL. This aligns the
> behavior of FIT loading from SPL and U-Boot proper in this aspect,
> reducing the need for custom code in falcon boot setups.
>
> Signed-off-by: Francesco Valla <francesco@valla.it>
>
> common/spl/spl.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

> diff --git a/common/spl/spl.c b/common/spl/spl.c
> @@ -156,6 +156,22 @@ void spl_fixup_fdt(void *fdt_blob)
> +     if (IS_ENABLED(CONFIG_OF_BOARD_SETUP)) {
> +             err = ft_board_setup(fdt_blob, gd->bd);
> +             if (err) {
> +                     printf(PHASE_PROMPT "ft_board_setup err - %d\n", err);
> +                     return;
> +             }
> +     }
> +
> +     if (IS_ENABLED(CONFIG_OF_SYSTEM_SETUP)) {
> +             err = ft_system_setup(fdt_blob, gd->bd);
> +             if (err) {
> +                     printf(PHASE_PROMPT "ft_system_setup err - %d\n", err);
> +                     return;
> +             }
> +     }

CONFIG_OF_BOARD_SETUP / CONFIG_OF_SYSTEM_SETUP are not SPL-aware, so
any board that has them set today will start call ft_board_setup() /
ft_system_setup() in SPL with this patch. Can you use
CONFIG_IS_ENABLED() and add new SPL_... options for your board to
enable?

If we're aligning with image_setup_libfdt(),
CONFIG_OF_BOARD_SETUP_EXTENDED / ft_board_setup_ex() is also part of
that flow. Is leaving it out deliberate, or should it be handled here
too? A note in the commit message would help.

Regards,
Simon
