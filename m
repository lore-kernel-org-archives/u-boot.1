Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E311DC2BA18
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 11:58:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4C73884DC;
	Thu, 20 Jun 2024 13:58:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718884730;
	bh=GBgqSxou2HpB58y/v8BpXzxKa2VPzK/PHtQVPM14yAM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LwLfzP4CEUg9e1+0N08/+m3EdtoOUC5McnAwmd99eCEA9dcpuWJQt4RmR6R3bS5Vp
	 K5EV0s72P+P8tQmH8bB+QPv11t1ElDNEWnY5YlzhkWGvECpN0xJDLOUsBt2xGJhh3k
	 VHq/0k7ZaMhsCmf74JUFbYD/nd1/9FvtnJBxgGMszIkHMB/OhxWgO8eYel4hDcYtpU
	 buUknL7Q4ws2+gZt/cvm/b69Z5+JlKzGl1XJhDCMSf1caRNie9rMrqPiDYOF/fyWv5
	 xPEXAiLrwA+CUDjHc1AEiOUi47ePC3hRtoRnKAb+9SODlp/jShNKv32pVdj18YaSmk
	 pCqPkbN/8oi6A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8352187EBD;
 Thu, 20 Jun 2024 13:58:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1718884728;
 bh=GBgqSxou2HpB58y/v8BpXzxKa2VPzK/PHtQVPM14yAM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KMSmGF2VR54MHvz+7QlWNOTARhU1D9FoDy9a7AehTL867AOyUzzlEGGqVVKi5dXRJ
 6veOoF0zBcRlQqYZQhSTQWvxKMN7iFkZoqjY/p/haPfK9xa93KJpUvEdyhXlIMqtBS
 k8PAiKjjv7PG5OeZ1ule1zD1nAeQcvHxCvw/geb4IJRxEnGQaY/11DYbkvtG812U0I
 slLuznPzlOV0Vv55JMGswblXCPLQnUzZ3LC95CQSF9UdVOhXE2Gb4cKu9QlTOtfCcT
 Eoy8SE8Xitdvupih8+V1Ur44gBG4zhnbHWlV1GX2D+79kmLVQgFqhiyARkAD/dvhwz
 PmGXYmaT3v3wg==
Message-ID: <8ce68679-f518-47c1-a6f8-f13e4cfd4dcc@denx.de>
Date: Thu, 20 Jun 2024 13:52:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] phy: meson-gxl-usb2: remove
 phy_meson_gxl_usb2_set_mode
To: neil.armstrong@linaro.org, Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org>
 <20240618-u-boot-usb-gxl-phy-set-mode-v1-3-6b41efa46e35@linaro.org>
 <54c7dcab-8925-4b20-b455-413a9bee8fda@denx.de>
 <d8e7d2cb-b402-43fa-8c3e-eaebfaf5b0fc@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <d8e7d2cb-b402-43fa-8c3e-eaebfaf5b0fc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 6/20/24 9:39 AM, Neil Armstrong wrote:
> On 18/06/2024 16:56, Marek Vasut wrote:
>> On 6/18/24 9:55 AM, Neil Armstrong wrote:
>>
>> [...]
>>
>>> @@ -205,7 +188,7 @@ static int phy_meson_gxl_usb2_power_off(struct 
>>> phy *phy)
>>>   struct phy_ops meson_gxl_usb2_phy_ops = {
>>>       .power_on = phy_meson_gxl_usb2_power_on,
>>>       .power_off = phy_meson_gxl_usb2_power_off,
>>> -    .set_mode = _phy_meson_gxl_usb2_set_mode,
>>> +    .set_mode = phy_meson_gxl_usb2_set_mode,
>>
>> Oh, I see you did rename it here, so please ignore my comment on 1/5 . 
>> Maybe just mention in the 1/5 commit message that the rename is 
>> happening in follow up patch , if you are doing V2 at all .
> 
> Sure, let me update the commit message,

Thank you
