Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0821FC6FD1F
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 20:11:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 988588800F;
	Wed, 20 Mar 2024 21:11:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710965490;
	bh=j/pRJwJ0Kgp4F3qgGFdAWKNOObO/UJM9VV8w0oguT5Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BwFDKfeBFnCeJMvNkRTSOvV9dPmhs9lFKqN71OKdLxYxntAYXVC/Eg3gvCITLKMcm
	 7Po3jW0uAVL/v3gjsccVkBuJbGf7lbzDMGStf9P8DxgwrbIf3aJ7nxKbkTb5bO9KC+
	 RHrSSWQUIn4wwNtzymXwi/NKd94Sc+XqeEUJQ/OMhKTT2T+aU0izAs5KIlc4Fmv2F6
	 0tWsXbOvd6Z8Vas8bpmdGhl4Zc3Fu7ryzRQMz5e9zCXN6UwmcZPM3JKd2BeFSx/nFP
	 uUFOEeqydUgTvQ3pHZq5XjxaSPqswpNfDhHWSzT4GcKvgvpOjrOeH5MPwMYdJpGScn
	 TtnfPAZ3GX9tA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1E71387CFC;
 Wed, 20 Mar 2024 21:11:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1710965489;
 bh=j/pRJwJ0Kgp4F3qgGFdAWKNOObO/UJM9VV8w0oguT5Y=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=b6XkKPvTiI+hxnrJsw9mPKJUJlxxqGUEKaeuys6+dpgAxNDUmGJgboyTjRZFRfVsY
 7rU/0BML4NKaZZ+FW7SauI0HQmsiFNOYJcxgzlq1R0T729vWoDGuho7ldQVDoI47d6
 t62Ku1HfaIDusxme/QzJEHeXABbcnycI2ia6e6futZ4P9Sg3ZEB1d+OpvIzwkDWfal
 fyFeKKncdkb6GBYKPvARCftS4J4dekLuikB2jCA83uEhws0wqLyRUGu/yvps1gKG+X
 HkotzeSp5M1JmM/ymgPnJt6kwhVGo5BngoDAaQW3NCP93u37BqIkT/6HC39WCFm3nP
 H9grtCgBZLLkw==
Message-ID: <eae25ae3-1b3c-486f-bf08-1f8aa1461360@denx.de>
Date: Wed, 20 Mar 2024 21:01:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] Qualcomm DWC3 USB support
Content-Language: en-US
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20240320-b4-qcom-usb-v4-0-41be480172e1@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240320-b4-qcom-usb-v4-0-41be480172e1@linaro.org>
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

On 3/20/24 3:30 PM, Caleb Connolly wrote:
> This series enables support for Qualcomm platforms in the DWC3 driver,
> adds support for arbitrary sector sizes to the USB mass storage gadget,
> and fixes an issue with the CDC ACM driver where it wouldn't initialise
> the USB device.
> 
> Additionally, it fixes a syntax bug in the Qualcomm SMMU driver, and
> makes USB_DWC3_GADGET select DM_USB_GADGET to fix compilation with
> gadget mode.
> 
> This is part of a larger series enabling DWC3 USB support on Qualcomm
> platforms, a feature branch with all patches can be found at [1].
> 
> [1]: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/tree/b4/qcom-livetree

Since this is mostly gadget and RB'd now, I think this should go through 
Mattijs / dfu tree.

Thanks
