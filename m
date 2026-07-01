Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD82C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 10:58:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D958784BB4;
	Wed,  1 Jul 2026 12:58:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gQ4UxGbC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF34D84B9B; Wed,  1 Jul 2026 12:52:28 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6BB684A7C
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 12:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 845BE60138;
 Wed,  1 Jul 2026 10:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A521F000E9;
 Wed,  1 Jul 2026 10:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782903145;
 bh=vruXHb7w+Sm8g9KDBu51YHdnoSrMDSPnHf7tLiPv9uM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=gQ4UxGbCT8X5ldQPKsYQ5zUXMV6SJuF2bmnl1AwJH4pyv4AjfjyLxFRAkzAR1HZL7
 xWX6U40KK8T9b/hy3QjOOpA7HT8/F91OyeKSm4OTiS1GkWDw45oCJUUk+2U8gNi68h
 oLSv/vbpx2cLWLm+RY0I//KEEEBR06vVsFjDS9hNPQxlxRUX4KssNV5pMIoF9BoYiC
 Nif6iRKOmIDopPTcu1lVoG54Lz5Vu/n7Yx6S5dEGQVjVUmjYpKfpMphsLpDPeMtBEK
 ECGIAOE6TJmLnA+1hohoVJC47gITM8V0B0ltk1BbSQOBgnU3qEli4Ms2cd2EJfLpBU
 0pnb/yOi9nuSQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marex@nabladev.com>, Jens Wiklander
 <jens.wiklander@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andre Przywara
 <andre.przywara@arm.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Bin Meng <bmeng.cn@gmail.com>, Casey
 Connolly <casey.connolly@linaro.org>, Chunfeng Yun
 <chunfeng.yun@mediatek.com>, Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Ion Agorria
 <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>, Kongyang Liu
 <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Ryder Lee <ryder.lee@mediatek.com>,
 Simon Glass <sjg@chromium.org>, Stephan Gerhold
 <stephan.gerhold@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, Tom
 Rini <trini@konsulko.com>, Varadarajan Narayanan
 <quic_varada@quicinc.com>, Weijie Gao <weijie.gao@mediatek.com>, Zixun LI
 <admin@hifiphile.com>, Jerome Forissier <jerome.forissier@arm.com>, Jerome
 Forissier <jerome.forissier@linaro.org>, Alexey Charkov
 <alchark@flipper.net>
Subject: Re: [PATCH v4 64/64] usb: fix build after resync of DWC3 with
 kernel v6.16
In-Reply-To: <81d73d59-c56f-45a2-8db6-8741ea6ab1a5@nabladev.com>
References: <20260629084507.3254232-1-jens.wiklander@linaro.org>
 <20260629084507.3254232-65-jens.wiklander@linaro.org>
 <81d73d59-c56f-45a2-8db6-8741ea6ab1a5@nabladev.com>
Date: Wed, 01 Jul 2026 12:52:23 +0200
Message-ID: <87se636kyg.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Wed, 01 Jul 2026 12:58:07 +0200
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

On Tue, Jun 30, 2026 at 12:38, Marek Vasut <marex@nabladev.com> wrote:

> On 6/29/26 10:44 AM, Jens Wiklander wrote:
>> From: Jerome Forissier <jerome.forissier@linaro.org>
>> 
>> Fix build errors after the re-sync of the DWC3 driver with the kernel.
>> U-Boot has different needs than the kernel: buses, interrupts, internal
>> APIs (DMA, traces, DT...) so many adaptations are required. This commit
>> re-introduces many of the changes that were done locally after the
>> initial import of the DWC3 code from kernel 3.19-rc1 11 years ago, as
>> well as other fixes. This is compile-tested only.
>> 
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>> Tested-by: Alexey Charkov <alchark@flipper.net>
>> ---
>>   drivers/usb/cdns3/ep0.c                |    8 +-
>>   drivers/usb/common/common.c            |   23 +
>>   drivers/usb/dwc3/Makefile              |   57 +-
>>   drivers/usb/dwc3/core.c                | 1761 ++++++------------------
>>   drivers/usb/dwc3/core.h                |   39 +-
>>   drivers/usb/dwc3/dwc3-am62.c           |  424 +-----
>>   drivers/usb/dwc3/dwc3-omap.c           |    2 -
>>   drivers/usb/dwc3/ep0.c                 |  110 +-
>>   drivers/usb/dwc3/gadget.c              |  786 +++--------
>>   drivers/usb/dwc3/gadget.h              |    4 +-
>>   drivers/usb/dwc3/io.h                  |   28 +-
>>   drivers/usb/dwc3/ti_usb_phy.c          |    2 -
>>   drivers/usb/gadget/at91_udc.c          |   46 -
>>   drivers/usb/gadget/atmel_usba_udc.c    |  102 +-
>>   drivers/usb/gadget/ci_udc.c            |  470 -------
>>   drivers/usb/gadget/composite.c         |    2 +-
>>   drivers/usb/gadget/dwc2_udc_otg.c      |  174 +--
>>   drivers/usb/gadget/epautoconf.c        |    2 -
>>   drivers/usb/gadget/ether.c             |   21 +-
>>   drivers/usb/gadget/f_acm.c             |   20 +-
>>   drivers/usb/gadget/f_fastboot.c        |   10 +-
>>   drivers/usb/gadget/f_mass_storage.c    |    5 +-
>>   drivers/usb/gadget/f_rockusb.c         |   11 +-
>>   drivers/usb/gadget/f_sdp.c             |   12 +-
>>   drivers/usb/gadget/f_thor.c            |   19 +-
>>   drivers/usb/gadget/udc/Makefile        |    1 +
>>   drivers/usb/gadget/udc/udc-core.c      | 1026 +++-----------
>>   drivers/usb/host/xhci-dwc3.c           |    4 +-
>>   drivers/usb/host/xhci-exynos5.c        |    2 +-
>>   drivers/usb/mtu3/mtu3_gadget_ep0.c     |   16 +-
>>   drivers/usb/musb-new/musb_gadget_ep0.c |   24 +-
>>   drivers/usb/musb-new/musb_uboot.c      |   39 -
>>   include/dm/device_compat.h             |   13 +
>>   include/dm/read.h                      |   46 +
>>   include/linux/compat.h                 |   15 +
>>   include/linux/usb/ch9.h                |   25 +-
>>   include/linux/usb/gadget.h             |  520 ++-----
>>   include/linux/usb/otg.h                |   10 +
>>   include/linux/usb/phy.h                |   56 +
>>   39 files changed, 1351 insertions(+), 4584 deletions(-)
> This patch needs to be split up, this is unreviewable, sorry.

I agree with Marek, this is quite difficult to review. Can we split it,
please?

