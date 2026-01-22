Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62330CA5FB6
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 12:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEA4E8397D;
	Thu, 22 Jan 2026 13:34:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="B3ZCJe7k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 480D383A1E; Thu, 22 Jan 2026 13:34:12 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0463B80077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 13:34:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dxgV72FJyz9vFb;
 Thu, 22 Jan 2026 13:34:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769085247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WYF9Jb2VazobEiZJM93xcCFOKjzF3qE7nIBVexIkLb4=;
 b=B3ZCJe7kxzFf/q+4Zzs29eRHg92CH4BMCeGre5nKMQSIJ72cDfbN25cS99NOD4Hp8JHAqs
 AsgquIrVu1RS2k9C7RM6rvFv/xiXhnZ5qSZs0dAEaxT1iDHHIneUh5thdcGVr6Hm4pww3t
 RAqdJd5k3/6+d1mEwZhcDMXcuPHhqGP1RPi7WR4Iq33HAANxWQvGdL6BQaKlwrvl9QOGXS
 jiH0x+KkfeMfn9u/k6M8TF2XrOr73holQbgHWylOXfz592ig3uWduHn+B1b6+DBhzZS1Tb
 8Cj5gSK7h2G4Ew0k9FhdRK9CC84euRaxTe6MlCX3pNClcrw3yZ8HogsoqpooNA==
Message-ID: <d3dd54e3-d20f-4aa0-9da1-3c0e821d6aa7@mailbox.org>
Date: Thu, 22 Jan 2026 13:34:01 +0100
MIME-Version: 1.0
Subject: Re: [PATCH V2 4/4] usb: dwc3: core: improve reset sequence
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>,
 Chris Morgan <macroalpha82@gmail.com>, Peng Fan <peng.fan@oss.nxp.com>,
 Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, thinhn@synopsys.com, neil.armstrong@linaro.org,
 quic_varada@quicinc.com, felipe.balbi@linux.intel.com,
 mkorpershoek@kernel.org, lukma@denx.de, trini@konsulko.com,
 macromorgan@hotmail.com, Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Mian Yousaf Kaukab <yousaf.kaukab@intel.com>
References: <20260115230135.183158-1-macroalpha82@gmail.com>
 <20260115230135.183158-5-macroalpha82@gmail.com>
 <z2hh7mpyjljlvgjw53lggxuqundl3y4xcb4mdbczlgouwhygz6@phktqzuxxjs2>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <z2hh7mpyjljlvgjw53lggxuqundl3y4xcb4mdbczlgouwhygz6@phktqzuxxjs2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 4sec7afdaerr3toosbzmzxiynu43ktef
X-MBO-RS-ID: a7cdff3340127f81e24
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

On 1/22/26 1:15 PM, Ernest Van Hoecke wrote:
> On Thu, Jan 15, 2026 at 05:01:35PM -0600, Chris Morgan wrote:
>> From: Chris Morgan <macromorgan@hotmail.com>
>>
>> According to Synopsys Databook, we shouldn't be
>> relying on GCTL.CORESOFTRESET bit as that's only for
>> debugging purposes. Instead, let's use DCTL.CSFTRST
>> if we're OTG or PERIPHERAL mode.
>>
>> Host side block will be reset by XHCI driver if
>> necessary. Note that this reduces amount of time
>> spent on dwc3_probe() by a long margin.
>>
>> We're still gonna wait for reset to finish for a
>> long time (default to 1ms max), but tests show that
>> the reset polling loop executed at most 19 times
>> (modprobe dwc3 && modprobe -r dwc3 executed 1000
>> times in a row).
>>
>> Note that this patch was submitted to Linux in 2016 [1], however I can
>> confirm it is needed to support gadget mode in U-Boot on my device.
>> While I am referencing this patch from Linux I am in fact taking the
>> full existing dwc3_core_soft_reset() function from Linux as it exists
>> in v6.19-rc5, so it may differ slightly from the information in the
>> 2016 patch.
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/patch/drivers/usb/dwc3?id=f59dcab176293b646e1358144c93c58c3cda2813
>>
> 
> Hi Chris,
> 
> Thanks for your work here. We also have issues with gadget mode on the
> iMX95 DWC3 IP, noticed on our Aquila iMX95 SoM. This patch series fixes
> our issues, but only with a small change:
> 
>> -	mdelay(100);
>> +	dev_warn(dwc->dev, "DWC3 controller soft reset failed.\n");
>> +	return -ETIMEDOUT;
>>   
>> -	/* After PHYs are stable we can take Core out of reset state */
>> -	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
>> -	reg &= ~DWC3_GCTL_CORESOFTRESET;
>> -	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
>> +done:
>> +	/*
>> +	 * For DWC_usb31 controller 1.80a and prior, once DCTL.CSFRST bit
>> +	 * is cleared, we must wait at least 50ms before accessing the PHY
>> +	 * domain (synchronization delay).
>> +	 */
>> +	if (DWC3_VER_IS_WITHIN(DWC31, ANY, 180A))
>> +		mdelay(50);
> 
> On the iMX95 I also need this delay to get everything functional. If I
> remove the conditional version check here, it works well.
> 'dwc->revision' is 0x5533330B.
> 
> Is anyone aware of the DWC3 requirements on the iMX95?
Likely Alice or Peng.
