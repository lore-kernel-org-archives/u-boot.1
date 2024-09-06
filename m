Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CB4E6FE3D
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 18:27:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2BD088D31;
	Fri,  6 Sep 2024 20:27:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725647221;
	bh=tqL1o11QM3F5Twsvx06oD7qyRKS2L/5+AxUDfYTH29A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lZJcrGFyOsL6hEWnasBpT7Y3WDANIAJ1zalzcWOZyrfGg9ttDJ34RiZld7pcePNwo
	 dIwkLCggDDhF4OMrC8ie1+m8f4QrG7sG1k2gzdKx1mAo8xDzXKDGwq9L+ZsTqRr8KI
	 ZCWL2Sfd8oXwsXWbQmx8i05DZ/7V9SmuGSO0TMYtNRdS41mBHXMRglZrUbI2zOJoHI
	 L1gA0hwDsyrXE/P9FTTHDU+zUAhSf7JaXy5JlJzbeBpVxhabK3mWAIn1Pswek19BlO
	 O8u2LHpqV2w4wlTzqGIJ33W7nVK9le+xErle/u91WzvysZMay0vhXmPPcQXroFSsLE
	 BvMUzcEktHX0g==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id ED35888D10;
 Fri,  6 Sep 2024 20:26:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1725647219;
 bh=tqL1o11QM3F5Twsvx06oD7qyRKS2L/5+AxUDfYTH29A=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hWHGO26/JXPvlCncFHVYBk4piIC1b314e0LenAxMEjqmwRHzBQu5YrkwGNaBg3rsW
 og15OlXHsLnghQDCCV44kf1XgqVK8SKXy8JK8zZQ5ajNDYli5PZ+G/qpU++0PG4WNz
 OsuZ/P9FOU89KeLIdL+9oUp8N0hOMj7fIoFFZb5q3u97uARfKtJ0127ss+D3PrT8fp
 mvHF0/tuOV8IbteXkBsR6SUFEnCgAZjIFARKlf635uo8/1bUaDFF5HpAy7JetBMhOG
 ErrHvdp0Mqs2R787DwJpLMmPv8SoWD+DGHF5gTmSkbTjk9Xbj1jVrBvjbrMwOeE3Ou
 a0JVn6GhSq9uA==
Message-ID: <f3a60bad-2afd-443b-9e76-f4634193e4f2@denx.de>
Date: Fri, 6 Sep 2024 19:23:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] phy: starfive: Add Starfive JH7110 USB 2.0 PHY
 driver
To: Minda Chen <minda.chen@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 E Shattow <lucent@gmail.com>
References: <20240829013058.6178-1-minda.chen@starfivetech.com>
 <20240829013058.6178-3-minda.chen@starfivetech.com>
 <cf1beaa1-8811-4c33-aad3-febd7ea3c00b@denx.de>
 <SHXPR01MB08632175780A7FBFE0C6B5D6E69E2@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <SHXPR01MB08632175780A7FBFE0C6B5D6E69E2@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
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

On 9/6/24 10:08 AM, Minda Chen wrote:
> 
> 
>>
>> On 8/29/24 3:30 AM, Minda Chen wrote:
>>
>> [...]
>>
>>> +menu "Starfive PHY driver"
>>> +
>>> +config PHY_STARFIVE_JH7110_USB2
>>> +	bool "Starfive JH7110 USB 2.0 PHY driver"
>>> +	select PHY
>>
>> Can this PHY_STARFIVE_JH7110_USB2 symbol be selected if CONFIG_PHY is not
>> set ? I think it cannot, so this 'select PHY' is unnecessary and should be removed.
>>
>> [...]
>>
> Thanks. I will check it.
> Other are format issues. I will modify them.
Thank you
