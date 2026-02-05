Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FBDECD9AA
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 22:08:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0191383B86;
	Thu,  5 Feb 2026 23:07:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iyT1ILRN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 042CD83B5E; Thu,  5 Feb 2026 18:32:48 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C497838FA
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 18:32:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ernestvanhoecke@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-435903c4040so909141f8f.3
 for <u-boot@lists.denx.de>; Thu, 05 Feb 2026 09:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770312754; x=1770917554; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=p152Wbf5cJjdgA30iTz/vC9fsXwzIPL2D5QmhbSas+U=;
 b=iyT1ILRNMkDCczpdHOvmb0Q/rtwd+WO08gWVguZJsgecwMCT3mPmIEx6j9kn7jDcZH
 eeo3r3wCf46vpGZauHU1V4N8p64nMcT2RX2Wp36GKEjY1LgCj/WfJknkRPXQKLAddHxn
 vYX/Eknnt+TblWQFwRaLoHc9JMeULg0GvDVfcHz5JG6TkD3dfbsP+cENVbw39zibzsYa
 Qf0NRe0OuvUvVTacH0GU9NI0ynWbn5L3KwmiIfwnE+pWxbUE+Q88HWUXWZ6mDPg5U7bH
 dweOyWYpwVeGUaXeWa1Zv2a2/g5YW0ROge+LfGP+ecJh7YDdVPT1c8E176/p1VTkB6be
 w9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770312754; x=1770917554;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p152Wbf5cJjdgA30iTz/vC9fsXwzIPL2D5QmhbSas+U=;
 b=Ck+wt6rbSuqUv9Ki2CbKobXf0POp3fH6gWP29Nq/mdTBh7VTWoeBhNPeDLBpLBfHAN
 VfZmjxHw9mXLmZA/qQWQ8EHBKvbkyj1SA0QEEqudyJQ0Q336g9hq6Yaso18WwY02Gobg
 0rvjNWUUjl9AX+K4/l/tYGVx43iC4cxA888vQAJoAGTTdM7aVAKsFpyOHvajX6hwQp12
 HVJTvacR+Z7ymh8D0Y17Ss+yqFKvixTE0W8YhL6+2oa/cZAy969vAahaULeuuWLxd7X9
 FcZckjKMEQMkLpxCDobe05SrKhlRzWzTXooMNpE/6c7rn2ZR/uefEueDpCGJlVBgRamr
 Q78g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbbMJZbmiJz1TmFsqHMfMsg3tu1v62/baIi8wRPamhOck7Oy2QoB6pO8stJ2rf1dGRgjjAX6w=@lists.denx.de
X-Gm-Message-State: AOJu0YxTx2p2GDduW+iGbJtCqeyOaRQYPXvhSvmvKw8tTzYODOGT65jM
 SeY286aswF1TsQ1drg9G1+tLvPRhrGePxhq6FCq09F2pVV/in2But5jI
X-Gm-Gg: AZuq6aLwNPaScJHms1LmC8Kbc//YQX7BeURzEB6oXvfUuNypZepnx94e+jF7tzomzMF
 gC6ZnQCdxC4Mvy3KiLbMG9dO0IyoY/GvEKlB9Wuy9orGs1X2uA/rvLewtUPqxtS7RjEgQVrJ5o9
 0X31dGEZrIifIrEs6l5HFISaqS4WNI/qBfxs2L7q0QsUpfZQoAxeqttrFw8FOwG3k71vPu0AhxD
 us8xVZ9n5IK5+d+H5uq27mLta0iBuzstPkywMpfNOGJ6GGEXUD9/OSZ1uK0oPGolzLespvnfrlL
 xTy5HzT/3AQagsp0Cp+OF8DqJEVzmpokEjk6dlK+zRKoiScSgDm2wMuI5qqdk4Nay8Wv7LQhaVC
 IZcKAWmqAcv/aWb73F0bSPz3Y4iqri/GT7CDXgqcXvPVzMxuK0KJzwRFv0s5qtN/FGqSrIFeltN
 hFyK8oVsOHldnlMQpt3W3jx3CHQBmcIlFQCIWOghOOZ8VrslVn0cnZcaW/zI0SJPmv2pKMS8UxS
 Ug8M39Pgq+ukA==
X-Received: by 2002:a05:6000:26c3:b0:432:4c01:db00 with SMTP id
 ffacd0b85a97d-436293448b2mr37392f8f.27.1770312753672; 
 Thu, 05 Feb 2026 09:32:33 -0800 (PST)
Received: from ernest.hoecke-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436234781fbsm5798321f8f.15.2026.02.05.09.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:32:33 -0800 (PST)
Date: Thu, 5 Feb 2026 18:32:32 +0100
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, 
 Chris Morgan <macroalpha82@gmail.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Alice Guo <alice.guo@nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "thinhn@synopsys.com" <thinhn@synopsys.com>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, 
 "quic_varada@quicinc.com" <quic_varada@quicinc.com>,
 "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>, 
 "mkorpershoek@kernel.org" <mkorpershoek@kernel.org>,
 "lukma@denx.de" <lukma@denx.de>, 
 "trini@konsulko.com" <trini@konsulko.com>,
 "macromorgan@hotmail.com" <macromorgan@hotmail.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Mian Yousaf Kaukab <yousaf.kaukab@intel.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI0=?= =?utf-8?Q?=3A?= [PATCH V2 4/4]
 usb: dwc3: core: improve reset sequence
Message-ID: <4yv2p2j5xur6qupjslytilxyrv27awmzciun5fluqrvjz5flmd@jjva4wqhhe37>
References: <20260115230135.183158-1-macroalpha82@gmail.com>
 <20260115230135.183158-5-macroalpha82@gmail.com>
 <z2hh7mpyjljlvgjw53lggxuqundl3y4xcb4mdbczlgouwhygz6@phktqzuxxjs2>
 <d3dd54e3-d20f-4aa0-9da1-3c0e821d6aa7@mailbox.org>
 <PAXPR04MB96444D82A8CC6D3DABD42159E294A@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <ngl2z4qam7wv4mh5gxrqpz2bcwl7atdywox26mzm5okozdy5jy@plkmlvh7kvxs>
 <PAXPR04MB9644CC074890135F23E44799E290A@PAXPR04MB9644.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR04MB9644CC074890135F23E44799E290A@PAXPR04MB9644.eurprd04.prod.outlook.com>
X-Mailman-Approved-At: Thu, 05 Feb 2026 23:07:20 +0100
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

On Tue, Jan 27, 2026 at 01:58:28AM +0000, Alice Guo (OSS) wrote:
> > -----邮件原件-----
> > 发件人: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
> > 发送时间: 2026年1月23日 22:13
> > 收件人: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > 抄送: Marek Vasut <marek.vasut@mailbox.org>; Chris Morgan
> > <macroalpha82@gmail.com>; Peng Fan (OSS) <peng.fan@oss.nxp.com>; Alice
> > Guo <alice.guo@nxp.com>; u-boot@lists.denx.de; thinhn@synopsys.com;
> > neil.armstrong@linaro.org; quic_varada@quicinc.com;
> > felipe.balbi@linux.intel.com; mkorpershoek@kernel.org; lukma@denx.de;
> > trini@konsulko.com; macromorgan@hotmail.com; Thinh Nguyen
> > <Thinh.Nguyen@synopsys.com>; Mian Yousaf Kaukab
> > <yousaf.kaukab@intel.com>
> > 主题: Re: 回复: [PATCH V2 4/4] usb: dwc3: core: improve reset sequence
> > 
> > On Fri, Jan 23, 2026 at 07:24:04AM +0000, Alice Guo (OSS) wrote:
> > > > -----邮件原件-----
> > > > 发件人: U-Boot <u-boot-bounces@lists.denx.de> 代表 Marek Vasut
> > > > 发送时间: 2026年1月22日 20:34
> > > > 收件人: Ernest Van Hoecke <ernestvanhoecke@gmail.com>; Chris Morgan
> > > > <macroalpha82@gmail.com>; Peng Fan (OSS) <peng.fan@oss.nxp.com>;
> > > > Alice Guo <alice.guo@nxp.com>
> > > > 抄送: u-boot@lists.denx.de; thinhn@synopsys.com;
> > > > neil.armstrong@linaro.org; quic_varada@quicinc.com;
> > > > felipe.balbi@linux.intel.com; mkorpershoek@kernel.org;
> > > > lukma@denx.de; trini@konsulko.com; macromorgan@hotmail.com; Thinh
> > > > Nguyen <Thinh.Nguyen@synopsys.com>; Mian Yousaf Kaukab
> > > > <yousaf.kaukab@intel.com>
> > > > 主题: Re: [PATCH V2 4/4] usb: dwc3: core: improve reset sequence
> > > >
> > > > On 1/22/26 1:15 PM, Ernest Van Hoecke wrote:
> > > > > On Thu, Jan 15, 2026 at 05:01:35PM -0600, Chris Morgan wrote:
> > > > >> From: Chris Morgan <macromorgan@hotmail.com>
> > > > >>
> > > > >> According to Synopsys Databook, we shouldn't be relying on
> > > > >> GCTL.CORESOFTRESET bit as that's only for debugging purposes.
> > > > >> Instead, let's use DCTL.CSFTRST if we're OTG or PERIPHERAL mode.
> > > > >>
> > > > >> Host side block will be reset by XHCI driver if necessary. Note
> > > > >> that this reduces amount of time spent on dwc3_probe() by a long
> > margin.
> > > > >>
> > > > >> We're still gonna wait for reset to finish for a long time
> > > > >> (default to 1ms max), but tests show that the reset polling loop
> > > > >> executed at most 19 times (modprobe dwc3 && modprobe -r dwc3
> > > > >> executed 1000
> > > > times
> > > > >> in a row).
> > > > >>
> > > > >> Note that this patch was submitted to Linux in 2016 [1], however
> > > > >> I can confirm it is needed to support gadget mode in U-Boot on my
> > device.
> > > > >> While I am referencing this patch from Linux I am in fact taking
> > > > >> the full existing dwc3_core_soft_reset() function from Linux as
> > > > >> it exists in v6.19-rc5, so it may differ slightly from the
> > > > >> information in the
> > > > >> 2016 patch.
> > > > >>
> > > > >> [1]
> > > > >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi
> > > > >> t/pa
> > > > >>
> > tch/drivers/usb/dwc3?id=f59dcab176293b646e1358144c93c58c3cda2813
> > > > >>
> > > > >
> > > > > Hi Chris,
> > > > >
> > > > > Thanks for your work here. We also have issues with gadget mode on
> > > > > the
> > > > > iMX95 DWC3 IP, noticed on our Aquila iMX95 SoM. This patch series
> > > > > fixes our issues, but only with a small change:
> > > > >
> > > > >> -	mdelay(100);
> > > > >> +	dev_warn(dwc->dev, "DWC3 controller soft reset failed.\n");
> > > > >> +	return -ETIMEDOUT;
> > > > >>
> > > > >> -	/* After PHYs are stable we can take Core out of reset state */
> > > > >> -	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
> > > > >> -	reg &= ~DWC3_GCTL_CORESOFTRESET;
> > > > >> -	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> > > > >> +done:
> > > > >> +	/*
> > > > >> +	 * For DWC_usb31 controller 1.80a and prior, once DCTL.CSFRST bit
> > > > >> +	 * is cleared, we must wait at least 50ms before accessing the PHY
> > > > >> +	 * domain (synchronization delay).
> > > > >> +	 */
> > > > >> +	if (DWC3_VER_IS_WITHIN(DWC31, ANY, 180A))
> > > > >> +		mdelay(50);
> > > > >
> > > > > On the iMX95 I also need this delay to get everything functional.
> > > > > If I remove the conditional version check here, it works well.
> > > > > 'dwc->revision' is 0x5533330B.
> > > > >
> > > > > Is anyone aware of the DWC3 requirements on the iMX95?
> > > > Likely Alice or Peng.
> > >
> > > Hi Ernest,
> > >
> > > Thank you for your feedback on i.MX95.
> > >
> > > I tested this patch series on the i.MX95 19x19 EVK board with USB SDP boot
> > over the USB3 interface, and it works correctly without the additional delay.
> > >
> > > The Universal Serial Bus 3.0 Controller on i.MX95 does not need this delay in
> > my testing. Could you please verify that the Universal Serial Bus 3.0 PHY is
> > configured correctly in your setup?
> > >
> > > Best regards,
> > > Alice Guo
> > 
> > Hi Alice,
> > 
> > I spent some time testing again and comparing the differences between
> > 19x19 EVK and our Aquila iMX95 device trees to make sure the DWC3 and
> > DWC3 PHY configs were the same, and I cannot get the USB gadget to function
> > without this delay in U-Boot proper. It works in the U-Boot SPL, does it also work
> > in U-Boot proper for the EVK, or just the SPL?
> > 
> > If there really is some difference here I can dig up an EVK and continue my
> > testing. Thank you for your help.
> > 
> > Kind regards,
> > Ernest
> 
> Hi Ernest,
> 
> I tested the UMS feature in U-Boot proper, and it works correctly without this delay.
> 
> Best regards,
> Alice Guo

Hi Alice,

Thanks for testing. I can confirm that UMS works. I also tested DFU, and
that also works fine.

The issue turned out to be that we are using fastboot. Fastboot only
works with this additional delay. And even then, it does not work every
time when using the fastboot command after U-Boot proper has started.

I figured out that this is because all functions of the fastboot gadget
config are SuperSpeed capable, while DFU or UMS fall back to a maximum
of high speed in 'drivers/usb/gadget/composite.c:usb_add_config()'.

The following hack, for example, fixes fastboot consistently:

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 04b85419931e..314143321546 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -539,7 +539,7 @@ int usb_add_config(struct usb_composite_dev *cdev,
 	 */
 	if (gadget_is_superspeed(cdev->gadget)) {
 		list_for_each_entry(f, &config->functions, list) {
-			if (!f->ss_descriptors)
+			if (true)
 				cdev->gadget->max_speed =
 					USB_SPEED_HIGH;
 		}

Note that I have 'phy-imx8mq-usb.c' enabled in my config and device
tree. I tried various quirks as well, to me the PHY seems fine, but
something is still strange with DWC3 on iMX95 when using SuperSpeed.

Thanks and kind regards,
Ernest
