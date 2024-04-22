Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3137CC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 02:55:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AA4088556;
	Tue, 23 Apr 2024 04:55:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713840954;
	bh=frXElwhURuuiY8n5JM5T4/kZWU8NxVqyJWP+GWOJsSo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NpxUo5vldtM+lXVvWbvZ/bWX9UM/Bj9lRF10jd8hQ9QrMihty/dfArMN5ZOEPAlSz
	 WvZ6FEireMU3lBqqpPk3Z9FCNHqdxK8zV2ka2xzGb/BXZ/axDaTQvywijLFu3V5dBi
	 X4MzYvbIsOqkM9aJ/ebHsy0XDRZ67g3HC5uLmYvxb8nXqgQUtcbApMTrbDA5TEvEqY
	 +bpdKuGl8Py4MhsVFsXQQaza70ceZrX0v7mPWvJPbaULE+3PC59fQ911a3bIVcooWz
	 96iMYXjuF8rIvqEk8l4A5oSJqQNhfiiRyIzdJjyP+MFXrp2VRueysidpoqvfcA2ICg
	 jR+5HpaaUShZA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D92CB88533;
 Tue, 23 Apr 2024 04:55:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713840952;
 bh=frXElwhURuuiY8n5JM5T4/kZWU8NxVqyJWP+GWOJsSo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=0SfgKxFWwopL8mGgfHqxrTJDP7DFcN6AlskTDe4lXzGMGehPEKxXRRT3QSeHw8SIT
 QeM4V7peF4M5w6C3sCmd1gW0pUlpIj9ZGLJEU2D2xyUk6uw2G8OFffBf5J7IOXwtUb
 zEmqKZIqULnK56xFgU9vgPxWBCdJ9DsYoHzmSygF/vEDmUb91bX5zzitD+I28YrJGA
 sxKTUvYS/WRzzN55QjeB8KHyvZU5PmaXjyn8/0uigYdm0/HGNMy2oO/Aspk338tKeY
 YeUUHRUtUEKGxIjyP5UTm/NVC/GR4OkN89v1g7N+n7rtRlmEPuCHfsZ2cSsa1E0hwo
 SmKWC72t+lRaw==
Message-ID: <c7cbb661-3837-4872-b3c2-d860c0a88f27@denx.de>
Date: Tue, 23 Apr 2024 01:11:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc2: update reset method for host and device mode
To: Kongyang Liu <seashell11234455@gmail.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Teik Heng Chong <teik.heng.chong@intel.com>,
 Tom Rini <trini@konsulko.com>
References: <20240328131811.94559-1-seashell11234455@gmail.com>
 <7e3063b5-cb03-436d-b780-c05edbd95010@denx.de>
 <CAOKwTdp0DA2APPeAfB0OduWiYv+YLED+mRvJm0jEe1VsqJ7kVA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAOKwTdp0DA2APPeAfB0OduWiYv+YLED+mRvJm0jEe1VsqJ7kVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 4/22/24 7:31 AM, Kongyang Liu wrote:

[...]

>>> @@ -167,9 +168,20 @@ static void dwc_otg_core_reset(struct udevice *dev,
>>>                dev_info(dev, "%s: Timeout!\n", __func__);
>>>
>>>        /* Core Soft Reset */
>>> +     snpsid = readl(&regs->gsnpsid);
>>>        writel(DWC2_GRSTCTL_CSFTRST, &regs->grstctl);
>>> -     ret = wait_for_bit_le32(&regs->grstctl, DWC2_GRSTCTL_CSFTRST,
>>> -                             false, 1000, false);
>>> +     if ((snpsid & DWC2_SNPSID_VER_MASK) < (DWC2_SNPSID_DEVID_VER_420a & DWC2_SNPSID_VER_MASK)) {
>>> +             ret = wait_for_bit_le32(&regs->grstctl, DWC2_GRSTCTL_CSFTRST,
>>> +                                     false, 1000, false);
>>> +     } else {
>>> +             ret = wait_for_bit_le32(&regs->grstctl, DWC2_GRSTCTL_GSFTRST_DONE,
>>> +                                     true, 1000, false);
>>> +             greset = readl(&regs->grstctl);
>>> +             greset &= ~DWC2_GRSTCTL_CSFTRST;
>>> +             greset |= DWC2_GRSTCTL_GSFTRST_DONE;
>>> +             writel(greset, &regs->grstctl);
>>
>> Same comments as above.
>>
>> Maybe this should be pulled into dedicated function to avoid duplication?
>>
> 
> For U-Boot, the dwc2 USB driver is split into two modules: host and gadget.
> Each has its own register definitions and definitions for register bits,
> which makes it difficult to extract a single function. Moreover, deciding
> where to place this function is also an issue.

There is drivers/usb/common/ for such code. The register macros can 
probably be unified into a single header too.
