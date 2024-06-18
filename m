Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE50BC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 09:59:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6397D88524;
	Tue, 18 Jun 2024 11:59:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="WniduebO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBAD688527; Tue, 18 Jun 2024 11:59:44 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0D38884A4
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 11:59:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1718704782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6CG+iReNLX4TfnrikHKrxboaQoGFQW+7KcMP+Xw4SqM=;
 b=WniduebOiM+zD3nqi3Jzc5r48pax8sUieBAA58rp1MEJ2OSbY2vSkoBMdL32bO82+4atPJ
 Kc3eH2h6028RlRInlSfKe9BYmzHcEKAXfODCHSrceqdo8COfOAxEigYfXxDsJSOcQMKlh4
 B+BAbtObvDeEFMU9jCJLtcK5K9+3wi9DxRLalTKvmh+aDen6ajnGEPCVOwOdacbr4qyaIz
 KbMayvE1h+Oh4kvTV7rpUIN0GcrhA85p87etAwqFIhug5vWgrpo+UdbO99EM6cs8h5pA0f
 TH7dWmB2v/DBGfVB5DYYXsfFD7bmInsEIy/K71Y6X+s4Dt9xr2PxzbYLJUPZWw==
Date: Tue, 18 Jun 2024 11:59:41 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Quentin Schulz <foss+uboot@0leil.net>, Jaehoon Chung
 <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, Kever Yang
 <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Subject: Re: [PATCH next] power: rk8xx: fix display name for RK808
In-Reply-To: <bded3033-bf2a-4130-a002-f73f6569998a@cherry.de>
References: <20240617-rk808-show-variant-v1-1-62143a89bafb@cherry.de>
 <9134de0e83da76ac2ceb047074e69155@manjaro.org>
 <bded3033-bf2a-4130-a002-f73f6569998a@cherry.de>
Message-ID: <734f30ccd55fbf5b35b4eb958e8aacdc@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Quentin,

On 2024-06-18 11:46, Quentin Schulz wrote:
> On 6/17/24 7:57 PM, Dragan Simic wrote:
>> On 2024-06-17 18:48, Quentin Schulz wrote:
>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>> 
>>> Commit 2ce40542e0eb ("power: rk8xx: properly print all supported 
>>> PMICs
>>> name") fixed all PMICs name that were broken but broke the only one 
>>> that
>>> was not broken already: RK808. This one is a special case because the 
>>> ID
>>> registers are marked as reserved and always return 0, so the variant
>>> cannot be derived the same way it is done for other PMICs from 
>>> Rockchip.
>>> 
>>> Fixes: 2ce40542e0eb ("power: rk8xx: properly print all supported 
>>> PMICs name")
>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> 
>> Looking good to me, but I'd still suggest [1] that reading the MSB/LSB 
>> ID
>> registers (i.e. 0x17 and 0x18) is skipped on the RK808 altogether, 
>> because
>> the RK808 datasheet lists those two registers as reserved and provides 
>> no
>> methods for determining the chip name.
> 
> Rockchip themselves do this, c.f.:
> 
> https://github.com/rockchip-linux/u-boot/blob/next-dev/drivers/power/pmic/rk8xx.c#L587

I see, thanks for the reference.

> I won't send a patch for this, but feel free to send one if you feel
> like this is really important.

I'll make a note to implement and send a patch later, after the dust
settles on this.  I think that the additional correctness warrants
such a patch.
