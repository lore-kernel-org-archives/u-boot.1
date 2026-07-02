Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE441C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 09:21:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CCDF84D16;
	Thu,  2 Jul 2026 11:20:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mpGw2wfI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 070B384CCF; Thu,  2 Jul 2026 11:02:58 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A66DA84CA3
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 11:02:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 802E060120;
 Thu,  2 Jul 2026 09:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AC91F000E9;
 Thu,  2 Jul 2026 09:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782982974;
 bh=+DAg5bVR1eIhYL33D7vra4RBtZ7J4SSVXnQhRtJfIoA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=mpGw2wfIRgw7Wwfgh5Lya9z2evTNgyxH5yp2f22T7G5jDyel7WtxEE9fW4Ajd7W9Q
 sVRJnpI6IjpNaMy5vvc0ERkDMMJ+VWiQfk9OTxVUUiq9ngR0Enwni5++sUyRAUGHFB
 HSzoRNmxkOEXhzNWTzHhRSaLCWBttpKTHrXrDM7ZzGBOnBTMN4ptTgQtYB4Hb72DX+
 8mkHde4HVrMZTEXvDgj1g8/8S77xQzb0MU8Vjf/3zLKjc9xIA2qfIxmhOIv1P+VnPA
 i3+Grm3QVoUWM9yyQ+xRfNnouwo8ywF7ktsWEs/WwbpjIjN+VGJqabomeO/iR21Bkg
 CAeSxuBOym9eQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut
 <marex@nabladev.com>, Jens Wiklander <jens.wiklander@linaro.org>,
 u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>, Andrew
 Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>, Bin
 Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Eddie Cai
 <eddie.cai.linux@gmail.com>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, Ion Agorria <ion@agorria.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Kongyang Liu
 <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>, Neil
 Armstrong <neil.armstrong@linaro.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Ryder Lee <ryder.lee@mediatek.com>,
 Simon Glass <sjg@chromium.org>, Stephan Gerhold
 <stephan.gerhold@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>, Weijie Gao
 <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>, Jerome
 Forissier <jerome.forissier@arm.com>, Jerome Forissier
 <jerome.forissier@linaro.org>, Alexey Charkov <alchark@flipper.net>
Subject: Re: [PATCH v4 64/64] usb: fix build after resync of DWC3 with
 kernel v6.16
In-Reply-To: <20260701173004.GM749385@bill-the-cat>
References: <20260629084507.3254232-1-jens.wiklander@linaro.org>
 <20260629084507.3254232-65-jens.wiklander@linaro.org>
 <81d73d59-c56f-45a2-8db6-8741ea6ab1a5@nabladev.com>
 <87se636kyg.fsf@kernel.org>
 <CAC_iWjJ88yXAopCqVGOW=Q2i_XX7Ojrkq4e8cfP8tmPz9+jr-g@mail.gmail.com>
 <20260701173004.GM749385@bill-the-cat>
Date: Thu, 02 Jul 2026 11:02:51 +0200
Message-ID: <87pl157ohw.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 02 Jul 2026 11:20:23 +0200
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

On Wed, Jul 01, 2026 at 11:30, Tom Rini <trini@konsulko.com> wrote:

> On Wed, Jul 01, 2026 at 08:03:22PM +0300, Ilias Apalodimas wrote:
>> Hi Mattjis
>> 
>> On Wed, 1 Jul 2026 at 13:52, Mattijs Korpershoek
>> <mkorpershoek@kernel.org> wrote:
>> >
>> > On Tue, Jun 30, 2026 at 12:38, Marek Vasut <marex@nabladev.com> wrote:
>> >
>> > > On 6/29/26 10:44 AM, Jens Wiklander wrote:
>> > >> From: Jerome Forissier <jerome.forissier@linaro.org>
>> > >>
>> > >> Fix build errors after the re-sync of the DWC3 driver with the kernel.
>> > >> U-Boot has different needs than the kernel: buses, interrupts, internal
>> > >> APIs (DMA, traces, DT...) so many adaptations are required. This commit
>> > >> re-introduces many of the changes that were done locally after the
>> > >> initial import of the DWC3 code from kernel 3.19-rc1 11 years ago, as
>> > >> well as other fixes. This is compile-tested only.
>> > >>
>> > >> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> > >> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>> > >> Tested-by: Alexey Charkov <alchark@flipper.net>
>> > >> ---
>> > >>   drivers/usb/cdns3/ep0.c                |    8 +-
>> > >>   drivers/usb/common/common.c            |   23 +
>> > >>   drivers/usb/dwc3/Makefile              |   57 +-
>> > >>   drivers/usb/dwc3/core.c                | 1761 ++++++------------------
>> > >>   drivers/usb/dwc3/core.h                |   39 +-
>> > >>   drivers/usb/dwc3/dwc3-am62.c           |  424 +-----
>> > >>   drivers/usb/dwc3/dwc3-omap.c           |    2 -
>> > >>   drivers/usb/dwc3/ep0.c                 |  110 +-
>> > >>   drivers/usb/dwc3/gadget.c              |  786 +++--------
>> > >>   drivers/usb/dwc3/gadget.h              |    4 +-
>> > >>   drivers/usb/dwc3/io.h                  |   28 +-
>> > >>   drivers/usb/dwc3/ti_usb_phy.c          |    2 -
>> > >>   drivers/usb/gadget/at91_udc.c          |   46 -
>> > >>   drivers/usb/gadget/atmel_usba_udc.c    |  102 +-
>> > >>   drivers/usb/gadget/ci_udc.c            |  470 -------
>> > >>   drivers/usb/gadget/composite.c         |    2 +-
>> > >>   drivers/usb/gadget/dwc2_udc_otg.c      |  174 +--
>> > >>   drivers/usb/gadget/epautoconf.c        |    2 -
>> > >>   drivers/usb/gadget/ether.c             |   21 +-
>> > >>   drivers/usb/gadget/f_acm.c             |   20 +-
>> > >>   drivers/usb/gadget/f_fastboot.c        |   10 +-
>> > >>   drivers/usb/gadget/f_mass_storage.c    |    5 +-
>> > >>   drivers/usb/gadget/f_rockusb.c         |   11 +-
>> > >>   drivers/usb/gadget/f_sdp.c             |   12 +-
>> > >>   drivers/usb/gadget/f_thor.c            |   19 +-
>> > >>   drivers/usb/gadget/udc/Makefile        |    1 +
>> > >>   drivers/usb/gadget/udc/udc-core.c      | 1026 +++-----------
>> > >>   drivers/usb/host/xhci-dwc3.c           |    4 +-
>> > >>   drivers/usb/host/xhci-exynos5.c        |    2 +-
>> > >>   drivers/usb/mtu3/mtu3_gadget_ep0.c     |   16 +-
>> > >>   drivers/usb/musb-new/musb_gadget_ep0.c |   24 +-
>> > >>   drivers/usb/musb-new/musb_uboot.c      |   39 -
>> > >>   include/dm/device_compat.h             |   13 +
>> > >>   include/dm/read.h                      |   46 +
>> > >>   include/linux/compat.h                 |   15 +
>> > >>   include/linux/usb/ch9.h                |   25 +-
>> > >>   include/linux/usb/gadget.h             |  520 ++-----
>> > >>   include/linux/usb/otg.h                |   10 +
>> > >>   include/linux/usb/phy.h                |   56 +
>> > >>   39 files changed, 1351 insertions(+), 4584 deletions(-)
>> > > This patch needs to be split up, this is unreviewable, sorry.
>> >
>> > I agree with Marek, this is quite difficult to review. Can we split it,
>> > please?
>> 
>> Sure this is reasonable. As long as we all agree that the current
>> approach of rebasing is acceptable. This will make the 'breakage'
>> window a little bigger, but as long as it's explicitly mentioned in
>> the commit messages, I personally don't mind
>
> I also think that while not ideal, but especially if we bring this in as
> a merge commit (in other words, b4 shazam -SM it, then include that
> merge commit in the USB PR), we can limit the range of bisectability
> not being possible. Since you can test commits manually when doing a
> bisect, a "git checkout ...tree prior to this merge commit...", test and
> confirm this being where the problem is, or isn't. And then if we can
> commit to keeping in-sync in the future, we'll be more easily able to
> drop in the changes from kernel release N-1 to kernel release N, without
> the whole undo-and-redo-U-Boot-support dance.

I also agree that the "import from kernel vN" patches are not ideal, but
I'm okay with them going in this way (after being reviewed, of course).

The benefits of doing it this way is that we can review easily, since we
can just compare the files with the matching linux release.

>
> -- 
> Tom
