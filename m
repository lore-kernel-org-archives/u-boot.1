Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C2BD74EDB
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 15:16:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB7FE83B21;
	Fri, 23 Jan 2026 16:16:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JClKYYUO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1B5F83B27; Fri, 23 Jan 2026 15:12:46 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC90383B0B
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 15:12:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ernestvanhoecke@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so25814505e9.2
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 06:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769177563; x=1769782363; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=a2ydshm/wlIEUpX4G6TBfcO8DQrxfH5QLjvli1Xdsew=;
 b=JClKYYUOw0EY2NOTdIiRH9tW2zWP4UGMEe8EdHRM8oRO/q6Ai91tvzgZaLkXe1fE3w
 AwsMkZBuqO4+7MAJwATlAmfFTSWr0XP50WQlTYjvD50hwmREfuIxWVl517Y50KjufXku
 s/dhQyHY+jhU3eDHRslf5z1W5QtU1iyEDeWPNgcODqs4gJ6LWVvAZGGJsbP7SA7fINEg
 H1TpCbnie25DWSNYZL6tz5xMmOlCaM7K5bzQdg9JOTBOdD2ainUcNOqFvWQlWAJjIRcH
 fvsyf9CuY315WfiuL2NioN02xWOW9I4s+BtGbhQGbWgmghH5tszAotr/MZP421sJDRY8
 RX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769177563; x=1769782363;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a2ydshm/wlIEUpX4G6TBfcO8DQrxfH5QLjvli1Xdsew=;
 b=hSqqTWiKcwPZsF2ZqCplak0L0ZozgYZcIhPjwYWGVWwEYDdq7QvHsstdwyzKUGycdX
 A0Xmwu7M43c9Mk/tFEZ80vZaHmgZMmwMaKD1+nuHgj+v8sseOCcj0ujPRiPYRmIH/Jxh
 nCF9V9oaf3WSl5uJG85LTYZT6C+uE8F2oAYQmw8F2ZJC98mb28gNnucaVDOJ68tNMxPE
 VvxWGkuIIDZUiuiTicW7gdXjF3hIE3Q4+Etp8ygNUcigRa/xiHCdYZW/kZuDqqCm+2Mc
 LooRcIMuAmDgXlbq/tLsaBFP4EX3qkv8moNvzYV4XzDQMbhZtSdm4+zK8U9l6YIc7JKs
 VAkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk2rJQ2bnEwI1+UqTcALxMS8ATHgpVERFf09hTawIWDJWzktF/HOb7f204ckhkIW959U3T/is=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0wKrO4FesI7Be9u6dU2fGu9miSTfjP/YjknAFG6EU6hYAdVZ3
 fnVSvS22tWHq6QtrysrucqsSOZsApmmnoKvL1T97lTSjb1XBYvKy6Yey
X-Gm-Gg: AZuq6aIJjsPAczq91EuUSweX+WqG/NgWk9g+lfqhi5LIBngy/tYFXLZUJ6+X7lkVpTQ
 0OBZDBD2a6BqrseEI1XU7HgskqiC7rYf9+FBbTy4RHRapWGrkIhgJYrL07dmBZRw4G8d6Cf85U+
 O6sXehKiJ3XVg32C7a6rhNY8z32xwMF6Qs3lSreQ+i6MfOl/SMFSz01ebSF2P5i93Q+tNogzRA6
 0pcd/mSpfi1XErPTsY2BstsZaLKDWif2dsNC8hye0GhL9x+2H196phX2S4Tjl9vtkPP+fNRBzBj
 uQcQ/n2glyKAvXfSJUBj0g35e/DYbX74fZPNyEnMlRPMJFH6meegPr7gtzrKOvDFyKg49sXD9QM
 sxngBgf/kIqvaQ/wWzU43BSIZQ/jo/9p9vyLNoadpaje5HEKFt2s6T7WdFCheqCIKiVR0ZiaPdc
 0Plb+5ESk45Amk8kQM2Vb/kQ2BKVTBEhfY8UGEwdiEsFqY30bMiEidiPE4In6sFq/A3vtooTRyv
 oDGMFAGZjwmkQ==
X-Received: by 2002:a05:600c:310b:b0:47d:73a4:45a7 with SMTP id
 5b1f17b1804b1-4804c9b4d0dmr54564905e9.24.1769177563125; 
 Fri, 23 Jan 2026 06:12:43 -0800 (PST)
Received: from ernest.hoecke-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d85206fsm59812705e9.6.2026.01.23.06.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 06:12:42 -0800 (PST)
Date: Fri, 23 Jan 2026 15:12:41 +0100
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
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH V2 4/4] usb: dwc3:
 core: improve reset sequence
Message-ID: <ngl2z4qam7wv4mh5gxrqpz2bcwl7atdywox26mzm5okozdy5jy@plkmlvh7kvxs>
References: <20260115230135.183158-1-macroalpha82@gmail.com>
 <20260115230135.183158-5-macroalpha82@gmail.com>
 <z2hh7mpyjljlvgjw53lggxuqundl3y4xcb4mdbczlgouwhygz6@phktqzuxxjs2>
 <d3dd54e3-d20f-4aa0-9da1-3c0e821d6aa7@mailbox.org>
 <PAXPR04MB96444D82A8CC6D3DABD42159E294A@PAXPR04MB9644.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR04MB96444D82A8CC6D3DABD42159E294A@PAXPR04MB9644.eurprd04.prod.outlook.com>
X-Mailman-Approved-At: Fri, 23 Jan 2026 16:16:20 +0100
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

On Fri, Jan 23, 2026 at 07:24:04AM +0000, Alice Guo (OSS) wrote:
> > -----邮件原件-----
> > 发件人: U-Boot <u-boot-bounces@lists.denx.de> 代表 Marek Vasut
> > 发送时间: 2026年1月22日 20:34
> > 收件人: Ernest Van Hoecke <ernestvanhoecke@gmail.com>; Chris Morgan
> > <macroalpha82@gmail.com>; Peng Fan (OSS) <peng.fan@oss.nxp.com>; Alice
> > Guo <alice.guo@nxp.com>
> > 抄送: u-boot@lists.denx.de; thinhn@synopsys.com;
> > neil.armstrong@linaro.org; quic_varada@quicinc.com;
> > felipe.balbi@linux.intel.com; mkorpershoek@kernel.org; lukma@denx.de;
> > trini@konsulko.com; macromorgan@hotmail.com; Thinh Nguyen
> > <Thinh.Nguyen@synopsys.com>; Mian Yousaf Kaukab
> > <yousaf.kaukab@intel.com>
> > 主题: Re: [PATCH V2 4/4] usb: dwc3: core: improve reset sequence
> > 
> > On 1/22/26 1:15 PM, Ernest Van Hoecke wrote:
> > > On Thu, Jan 15, 2026 at 05:01:35PM -0600, Chris Morgan wrote:
> > >> From: Chris Morgan <macromorgan@hotmail.com>
> > >>
> > >> According to Synopsys Databook, we shouldn't be relying on
> > >> GCTL.CORESOFTRESET bit as that's only for debugging purposes.
> > >> Instead, let's use DCTL.CSFTRST if we're OTG or PERIPHERAL mode.
> > >>
> > >> Host side block will be reset by XHCI driver if necessary. Note that
> > >> this reduces amount of time spent on dwc3_probe() by a long margin.
> > >>
> > >> We're still gonna wait for reset to finish for a long time (default
> > >> to 1ms max), but tests show that the reset polling loop executed at
> > >> most 19 times (modprobe dwc3 && modprobe -r dwc3 executed 1000
> > times
> > >> in a row).
> > >>
> > >> Note that this patch was submitted to Linux in 2016 [1], however I
> > >> can confirm it is needed to support gadget mode in U-Boot on my device.
> > >> While I am referencing this patch from Linux I am in fact taking the
> > >> full existing dwc3_core_soft_reset() function from Linux as it exists
> > >> in v6.19-rc5, so it may differ slightly from the information in the
> > >> 2016 patch.
> > >>
> > >> [1]
> > >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/pa
> > >> tch/drivers/usb/dwc3?id=f59dcab176293b646e1358144c93c58c3cda2813
> > >>
> > >
> > > Hi Chris,
> > >
> > > Thanks for your work here. We also have issues with gadget mode on the
> > > iMX95 DWC3 IP, noticed on our Aquila iMX95 SoM. This patch series
> > > fixes our issues, but only with a small change:
> > >
> > >> -	mdelay(100);
> > >> +	dev_warn(dwc->dev, "DWC3 controller soft reset failed.\n");
> > >> +	return -ETIMEDOUT;
> > >>
> > >> -	/* After PHYs are stable we can take Core out of reset state */
> > >> -	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
> > >> -	reg &= ~DWC3_GCTL_CORESOFTRESET;
> > >> -	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> > >> +done:
> > >> +	/*
> > >> +	 * For DWC_usb31 controller 1.80a and prior, once DCTL.CSFRST bit
> > >> +	 * is cleared, we must wait at least 50ms before accessing the PHY
> > >> +	 * domain (synchronization delay).
> > >> +	 */
> > >> +	if (DWC3_VER_IS_WITHIN(DWC31, ANY, 180A))
> > >> +		mdelay(50);
> > >
> > > On the iMX95 I also need this delay to get everything functional. If I
> > > remove the conditional version check here, it works well.
> > > 'dwc->revision' is 0x5533330B.
> > >
> > > Is anyone aware of the DWC3 requirements on the iMX95?
> > Likely Alice or Peng.
> 
> Hi Ernest,
> 
> Thank you for your feedback on i.MX95.
> 
> I tested this patch series on the i.MX95 19x19 EVK board with USB SDP boot over the USB3 interface, and it works correctly without the additional delay.
> 
> The Universal Serial Bus 3.0 Controller on i.MX95 does not need this delay in my testing. Could you please verify that the Universal Serial Bus 3.0 PHY is configured correctly in your setup?
> 
> Best regards,
> Alice Guo

Hi Alice,

I spent some time testing again and comparing the differences between
19x19 EVK and our Aquila iMX95 device trees to make sure the DWC3 and
DWC3 PHY configs were the same, and I cannot get the USB gadget to
function without this delay in U-Boot proper. It works in the U-Boot
SPL, does it also work in U-Boot proper for the EVK, or just the SPL?

If there really is some difference here I can dig up an EVK and continue
my testing. Thank you for your help.

Kind regards,
Ernest
