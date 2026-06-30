Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95482C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 22:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 438DF84B76;
	Wed,  1 Jul 2026 00:26:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="OugNawZt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F30E84B50; Wed,  1 Jul 2026 00:26:09 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40BAE84B2C
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 00:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E372C1186C8; Wed,  1 Jul 2026 00:26:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1782858365;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=fSdGSz7aM9Z4Gxz9PTyBtFqFx88sCknwP5kI87amygk=;
 b=OugNawZtgFYitWoM6NFwkaAtaIdGxiXQL0xjtNu+hXSDGn2LFgHuD4lDYjvP7f3VQjpksB
 3NIdQwgJk6C2U74TacZRNBnQPtMXfDVk8kr6u1EksHLp0qMCyq9R7FoNbG8Q7pK5FpdDnt
 CptgtEU1bOPjmkvy6KOMdqeByK6duaID1OPdly4bv7k+u9pkSIz02G+dvwwdwzJBYIAfZ5
 1FjAmuC/cv7Hg7FbyF+Guyw5AJmQaiK7/k4wA361zJg2jMCpNVW41Qhra3XjS2D84YNxgr
 c7Ao3sw9Ox3JhOITQmC3zGL8KuxR2H6x4vWgFCINzYZVXUBCk1JeFLfM8fk8Tg==
Message-ID: <81d73d59-c56f-45a2-8db6-8741ea6ab1a5@nabladev.com>
Date: Tue, 30 Jun 2026 12:38:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 64/64] usb: fix build after resync of DWC3 with kernel
 v6.16
To: Jens Wiklander <jens.wiklander@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes
 <ravi@prevas.dk>, Ryder Lee <ryder.lee@mediatek.com>,
 Simon Glass <sjg@chromium.org>, Stephan Gerhold
 <stephan.gerhold@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Alexey Charkov <alchark@flipper.net>
References: <20260629084507.3254232-1-jens.wiklander@linaro.org>
 <20260629084507.3254232-65-jens.wiklander@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260629084507.3254232-65-jens.wiklander@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 6/29/26 10:44 AM, Jens Wiklander wrote:
> From: Jerome Forissier <jerome.forissier@linaro.org>
> 
> Fix build errors after the re-sync of the DWC3 driver with the kernel.
> U-Boot has different needs than the kernel: buses, interrupts, internal
> APIs (DMA, traces, DT...) so many adaptations are required. This commit
> re-introduces many of the changes that were done locally after the
> initial import of the DWC3 code from kernel 3.19-rc1 11 years ago, as
> well as other fixes. This is compile-tested only.
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Tested-by: Alexey Charkov <alchark@flipper.net>
> ---
>   drivers/usb/cdns3/ep0.c                |    8 +-
>   drivers/usb/common/common.c            |   23 +
>   drivers/usb/dwc3/Makefile              |   57 +-
>   drivers/usb/dwc3/core.c                | 1761 ++++++------------------
>   drivers/usb/dwc3/core.h                |   39 +-
>   drivers/usb/dwc3/dwc3-am62.c           |  424 +-----
>   drivers/usb/dwc3/dwc3-omap.c           |    2 -
>   drivers/usb/dwc3/ep0.c                 |  110 +-
>   drivers/usb/dwc3/gadget.c              |  786 +++--------
>   drivers/usb/dwc3/gadget.h              |    4 +-
>   drivers/usb/dwc3/io.h                  |   28 +-
>   drivers/usb/dwc3/ti_usb_phy.c          |    2 -
>   drivers/usb/gadget/at91_udc.c          |   46 -
>   drivers/usb/gadget/atmel_usba_udc.c    |  102 +-
>   drivers/usb/gadget/ci_udc.c            |  470 -------
>   drivers/usb/gadget/composite.c         |    2 +-
>   drivers/usb/gadget/dwc2_udc_otg.c      |  174 +--
>   drivers/usb/gadget/epautoconf.c        |    2 -
>   drivers/usb/gadget/ether.c             |   21 +-
>   drivers/usb/gadget/f_acm.c             |   20 +-
>   drivers/usb/gadget/f_fastboot.c        |   10 +-
>   drivers/usb/gadget/f_mass_storage.c    |    5 +-
>   drivers/usb/gadget/f_rockusb.c         |   11 +-
>   drivers/usb/gadget/f_sdp.c             |   12 +-
>   drivers/usb/gadget/f_thor.c            |   19 +-
>   drivers/usb/gadget/udc/Makefile        |    1 +
>   drivers/usb/gadget/udc/udc-core.c      | 1026 +++-----------
>   drivers/usb/host/xhci-dwc3.c           |    4 +-
>   drivers/usb/host/xhci-exynos5.c        |    2 +-
>   drivers/usb/mtu3/mtu3_gadget_ep0.c     |   16 +-
>   drivers/usb/musb-new/musb_gadget_ep0.c |   24 +-
>   drivers/usb/musb-new/musb_uboot.c      |   39 -
>   include/dm/device_compat.h             |   13 +
>   include/dm/read.h                      |   46 +
>   include/linux/compat.h                 |   15 +
>   include/linux/usb/ch9.h                |   25 +-
>   include/linux/usb/gadget.h             |  520 ++-----
>   include/linux/usb/otg.h                |   10 +
>   include/linux/usb/phy.h                |   56 +
>   39 files changed, 1351 insertions(+), 4584 deletions(-)
This patch needs to be split up, this is unreviewable, sorry.
