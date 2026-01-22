Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CFFD3EE67
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 13:42:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D9C283B7E;
	Thu, 22 Jan 2026 14:41:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U/QO0mTx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C987D839DF; Thu, 22 Jan 2026 13:15:39 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EC4B80077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 13:15:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ernestvanhoecke@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47d6a1f08bbso4344365e9.2
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 04:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769084137; x=1769688937; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n5giVSJI9va/+q4BITFuS0fBRMxAeo4kBs4/8ZUxhGY=;
 b=U/QO0mTxcYM9wMPqKe3xWxI4dTpnWQr96iEBf5Jy7nbhDaGIRmGSOydmNvDTu0V21k
 U3doXpRphXsksUxGxAaeasTSUQAo7VZZifE5hekM2a1YFsMh5GENa+o64wVlYT7VcL20
 0WetQo6dEAG9ovNrspCQhxrlLTzaYeb/GWeCUgPg8aIa0XNHr8qL3oaHuor/3qcRo03v
 t3R1OopkgFrazX6FMzXQUj/g+6JxZAibsZO2KvnPuhABrcsufREHfErEUz0yBdLwBgV8
 fPMemaRwwnrF8Wq6u/2kuWvANti0LyRuJ5KZ1Cj5NgwNwHKupjY6H3Dx8Wb7YCl8Da8X
 I+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769084137; x=1769688937;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n5giVSJI9va/+q4BITFuS0fBRMxAeo4kBs4/8ZUxhGY=;
 b=IQqnfRzzZ4xQhYNyBVj/FMrj2ET1V2ORMsooxSuKresx83o63QC15FEuooDJp/SJZx
 7WDmzW1Uzf9LaPq0Ez/5lSf2oElYhDEXvfvLYcHhR7JSvjmm/bwNLNIWSBCOxUjYsr2v
 se8gV7cZyDAqvbBr9YYs97uwWJqdE+1a/2X4AL60jW9B8KFavK2IHJn6RItTzi2R1F74
 3sfWEL8yrPlJJDpvCp7XOw6qqIaopLxH2Ofu7e3t+v39vToL0kh7PIUP0vhtIKKeIfnx
 j8uAyMw/+CeR2RzC6V1jFWLp1npV+r+ZDOSdHt2GG0FdtTRVPTxqqdtN7m3i9BwusFLd
 eEaw==
X-Gm-Message-State: AOJu0YzNdyRsIyaXhAFz9oDmDlIS+Kw+M1dR9IftkY8vSXMzsDd5YTjr
 Skdzv8LXMxBbGi2X5HT5OgTc2X9dKDlBYVpmxFag/133HFpqkX8uhzOw
X-Gm-Gg: AZuq6aJM/VU3Oy6V1dDiECaUmNpm3ZErTSrxHzKAZSSNTfPuy9PyIv9TRHGhXaKgCYu
 tfJIoV6F84Dxa6+TzgHI+A9OoljQ47y1rjeMymc0XRzWHuYNBcBkkc+7He14/8P1MMyClsy86+n
 6+/D4IKSTQrZkKcHDB+2Nb/ZlRHoznRsfFvHHthkJtBEJQrlAFsH3RwIbtoWBI5F68ehsuHVkBo
 QNmSkNb+QEYXGhqAMBTB/zgisNKeY9R1EZ/NF4hXK2JKT4R/YYXgKRPK6sZhYXF25B/p3B8oL+0
 pP8LOuC6FP3sGoZmFqBKdQeBlyzCj5X80q1haUfGp8QYJuytir4r+KmhdW5Z8G8ZQyVzoNsVkcF
 S7C8NFt9mYc77v69A1BO3e34ow+vZENnsJytjaPpdorHCAEYWyaj6V8oDvwDGffUJSTSpoyvMJa
 2sflvUIt0tnXyeI8Crb3Vm1p/m4Tkb9ZcAv9hqs36WhOf7j0w/0980aTo3LT2Ab2z+2h5Eglo8A
 +pcpITkgNSPKw==
X-Received: by 2002:a05:600c:37cc:b0:480:1b65:b741 with SMTP id
 5b1f17b1804b1-4801eac97b9mr315997725e9.15.1769084136426; 
 Thu, 22 Jan 2026 04:15:36 -0800 (PST)
Received: from ernest.hoecke-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-480470c1dc6sm60189895e9.10.2026.01.22.04.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 04:15:35 -0800 (PST)
Date: Thu, 22 Jan 2026 13:15:35 +0100
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: u-boot@lists.denx.de, thinhn@synopsys.com, neil.armstrong@linaro.org, 
 quic_varada@quicinc.com, felipe.balbi@linux.intel.com, mkorpershoek@kernel.org,
 lukma@denx.de, trini@konsulko.com, marex@denx.de, macromorgan@hotmail.com, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Peng Fan <peng.fan@oss.nxp.com>, 
 Mian Yousaf Kaukab <yousaf.kaukab@intel.com>
Subject: Re: [PATCH V2 4/4] usb: dwc3: core: improve reset sequence
Message-ID: <z2hh7mpyjljlvgjw53lggxuqundl3y4xcb4mdbczlgouwhygz6@phktqzuxxjs2>
References: <20260115230135.183158-1-macroalpha82@gmail.com>
 <20260115230135.183158-5-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115230135.183158-5-macroalpha82@gmail.com>
X-Mailman-Approved-At: Thu, 22 Jan 2026 14:41:52 +0100
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

On Thu, Jan 15, 2026 at 05:01:35PM -0600, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> According to Synopsys Databook, we shouldn't be
> relying on GCTL.CORESOFTRESET bit as that's only for
> debugging purposes. Instead, let's use DCTL.CSFTRST
> if we're OTG or PERIPHERAL mode.
> 
> Host side block will be reset by XHCI driver if
> necessary. Note that this reduces amount of time
> spent on dwc3_probe() by a long margin.
> 
> We're still gonna wait for reset to finish for a
> long time (default to 1ms max), but tests show that
> the reset polling loop executed at most 19 times
> (modprobe dwc3 && modprobe -r dwc3 executed 1000
> times in a row).
> 
> Note that this patch was submitted to Linux in 2016 [1], however I can
> confirm it is needed to support gadget mode in U-Boot on my device.
> While I am referencing this patch from Linux I am in fact taking the
> full existing dwc3_core_soft_reset() function from Linux as it exists
> in v6.19-rc5, so it may differ slightly from the information in the
> 2016 patch.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/patch/drivers/usb/dwc3?id=f59dcab176293b646e1358144c93c58c3cda2813
> 

Hi Chris,

Thanks for your work here. We also have issues with gadget mode on the
iMX95 DWC3 IP, noticed on our Aquila iMX95 SoM. This patch series fixes
our issues, but only with a small change:

> -	mdelay(100);
> +	dev_warn(dwc->dev, "DWC3 controller soft reset failed.\n");
> +	return -ETIMEDOUT;
>  
> -	/* After PHYs are stable we can take Core out of reset state */
> -	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
> -	reg &= ~DWC3_GCTL_CORESOFTRESET;
> -	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> +done:
> +	/*
> +	 * For DWC_usb31 controller 1.80a and prior, once DCTL.CSFRST bit
> +	 * is cleared, we must wait at least 50ms before accessing the PHY
> +	 * domain (synchronization delay).
> +	 */
> +	if (DWC3_VER_IS_WITHIN(DWC31, ANY, 180A))
> +		mdelay(50);

On the iMX95 I also need this delay to get everything functional. If I
remove the conditional version check here, it works well.
'dwc->revision' is 0x5533330B.

Is anyone aware of the DWC3 requirements on the iMX95?

Thanks and kind regards,
Ernest
