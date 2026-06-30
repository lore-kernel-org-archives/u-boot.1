Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A335FC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 22:26:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ED6E84B1B;
	Wed,  1 Jul 2026 00:25:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="ObcD8wZ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3FF684A1D; Wed,  1 Jul 2026 00:25:48 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E197884A1D
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 00:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 42FB5118725; Wed,  1 Jul 2026 00:25:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1782858346;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=sktK8IJwCgTkHPzD2cAoR7Q9KHbPXWR+K1HRyUYYInM=;
 b=ObcD8wZ3YY/kjqigI2nGbeuTTLMyy59MDr4AZB6FJ1ScJFEvJyxnSV65JrMG0qRgBy/3OI
 Q6nzH9nCQsgMjohW2jE4cmOAzchwdQBpyti4BVr0t4p4WXwBcdfr+ASawRpa/O6xjAeOwq
 pZk/6Xs02oRpQnM/Iy1F7iFWV/xn4SLYVX8hU00yC1MbnWAhvEGuhJlBz7/oBfdOMn/gfF
 oCrRNY7Sq6bBB0I9QRFlW+OzKhnRmFxe35BJthsrLufkFC9XuCLg4polU/qutwpKmz3mav
 BF3OJGL4G4/ruXUBH2zGUfE06bOFugEGSluD3ubGs0UrMjCgXDpBBuvoabsISA==
Message-ID: <df8a9508-b070-4e95-ae6f-23fdc17d0b4c@nabladev.com>
Date: Tue, 30 Jun 2026 11:23:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/64] usb: dwc3: import from kernel v4.16
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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
 Alexey Charkov <alchark@flipper.net>
References: <20260629084507.3254232-1-jens.wiklander@linaro.org>
 <20260629084507.3254232-20-jens.wiklander@linaro.org>
 <7dd650b5-2d08-45cc-8d7f-c9bee56de4a8@nabladev.com>
 <CAHUa44FQ6b4siyBnOdEz2cBs9rrRNCgGC=-s0h2gkGG79dLADA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <CAHUa44FQ6b4siyBnOdEz2cBs9rrRNCgGC=-s0h2gkGG79dLADA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 6/30/26 11:11 AM, Jens Wiklander wrote:
> On Tue, Jun 30, 2026 at 11:04 AM Marek Vasut <marex@nabladev.com> wrote:
>>
>> On 6/29/26 10:43 AM, Jens Wiklander wrote:
>>> Sync Linux kernel dwc3 changes from v4.15 to v4.16.
>>>
>>> The following files are preserved accross the import:
>>> Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
>>> dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
>>> dwc3-layerscape.c ti_usb_phy.c
>>>
>>> Skipping unused files:
>>> debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
>>> dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
>>> dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c
>>>
>>> Note that this is a raw import and doesn't build.
>>> A fixup commit at the end of the series fixes that.
>>>
>>> List of commits: git log --oneline v4.15..v4.16
>>> Commits imported:
>>> 084a804e0120 usb: dwc3: Fix lock-up on ID change during system suspend/resume
>>> 98112041bcca usb: dwc3: core: Fix ULPI PHYs and prevent phy_get/ulpi_init during suspend/resume
>>> b16ea8b9492e usb: dwc3: Fix GDBGFIFOSPACE_TYPE values
>>> c49f63055e25 usb: dwc3: omap: don't miss events during suspend/resume
>>> c4a5153e87fd usb: dwc3: core: Power-off core/PHYs on system_suspend in host mode
>>> 00b42170c86f usb: dwc3: Undo PHY init if soft reset fails
>>> f035d139ffec usb: dwc3: ep0: Reset TRB counter for ep0 IN
>>> 6180026341e8 usb: dwc3: gadget: Set maxpacket size for ep0 IN
>>> bff52352e0cc usb: dwc3: of-simple: fix oops by unbalanced clk disable call
>>> f1faf88c137b Merge tag 'phy-for-4.16' of git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy into usb-next
>>> 958e052c5448 Merge tag 'usb-for-v4.16' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next
>>> d8c80bb3b55b phy: exynos5-usbdrd: Calibrate LOS levels for exynos5420/5800
>>> d9e3d899bc7a Merge 4.15-rc4 into usb-next
>>> 42bf02ec6e42 usb: dwc3: Allow disabling of metastability workaround
>>> 204ec1af6257 usb: dwc3: Make sparse a bit happier
>>> 19e0b203bfbd usb: dwc3: ep0: use gadget->isoch_delay for isoch_delay value
>>> 0c5d2954f690 usb: dwc3: debug: decode a few more features
>>>
>>> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>>> Tested-by: Alexey Charkov <alchark@flipper.net>
>>> ---
>>>    drivers/usb/dwc3/core.c   | 93 ++++++++++++++++++++++++++++-----------
>>>    drivers/usb/dwc3/core.h   | 26 +++++++----
>>>    drivers/usb/dwc3/debug.h  |  9 ++++
>>>    drivers/usb/dwc3/ep0.c    | 13 +++---
>>>    drivers/usb/dwc3/gadget.c |  8 +++-
>>>    5 files changed, 106 insertions(+), 43 deletions(-)
>>>
>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>> index 07832509584f..e94bf91cc58a 100644
>>> --- a/drivers/usb/dwc3/core.c
>>> +++ b/drivers/usb/dwc3/core.c
>>> @@ -100,6 +100,8 @@ static void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
>>>        reg &= ~(DWC3_GCTL_PRTCAPDIR(DWC3_GCTL_PRTCAP_OTG));
>>>        reg |= DWC3_GCTL_PRTCAPDIR(mode);
>>>        dwc3_writel(dwc->regs, DWC3_GCTL, reg);
>>> +
>>> +     dwc->current_dr_role = mode;
>>>    }
>>>
>>>    static void __dwc3_set_mode(struct work_struct *work)
>>> @@ -133,8 +135,6 @@ static void __dwc3_set_mode(struct work_struct *work)
>>>
>>>        dwc3_set_prtcap(dwc, dwc->desired_dr_role);
>>>
>>> -     dwc->current_dr_role = dwc->desired_dr_role;
>>> -
>>>        spin_unlock_irqrestore(&dwc->lock, flags);
>>>
>>>        switch (dwc->desired_dr_role) {
>>> @@ -147,6 +147,7 @@ static void __dwc3_set_mode(struct work_struct *work)
>>>                                otg_set_vbus(dwc->usb2_phy->otg, true);
>>>                        phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
>>>                        phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
>>> +                     phy_calibrate(dwc->usb2_generic_phy);
>>
>> Does this actually compile ? I don't think U-Boot code base contains
>> phy_calibrate() function ?
> 
> No, I don't expect it does. By the way, it's mentioned in the commit message.
Can this be made bisectable ?
