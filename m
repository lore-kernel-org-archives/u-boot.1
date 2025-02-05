Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E781C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 06:51:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD59680562;
	Wed,  5 Feb 2025 07:51:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="KA4J3AMk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA7DB805D7; Wed,  5 Feb 2025 07:51:30 +0100 (CET)
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 954B2801F5
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 07:51:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexeymin@postmarketos.org
Message-ID: <51d04a86-02db-490e-a0c1-cec386924e51@postmarketos.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1738738282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sOPiDUjBx1tMeoOcI0JvVBPQV6mTKDw/cBKbM7qmCww=;
 b=KA4J3AMkkSL0xiAa0roOefRRmQ5BtgZbCiBAbWER6NAKEaqpY8lXoP4Dv38RXAiOgfldUc
 Tcjy83HhLBGA3vwrn5j1kWjeOePaWQwjHRU2Ja1WKYNbzFOw7Ag/Blrxt7vQF/JrK2XyAi
 8lDhLwTsaJqWBkUagDMn3N4xWkMhlqqCQ2BxVOvILkd9c2ha5mqiFxpjBZX0n4iXgWGxRX
 Q503pFi/NFf9aeeLArnywHxXeQ5PRPuGlGXPUA02di5E0VuipbhV09LTc2H9kOcHjXvhWM
 xfzg/FM7YhjdFiQ0mQ/TzbnhVZBSFc7WSs7PMTnjVa+G3+6uj0NHmI/6BUDbOA==
Date: Wed, 5 Feb 2025 09:51:16 +0300
MIME-Version: 1.0
Subject: Re: [PATCH 2/4] clk/qcom: Treat different GDSCs didderently
To: u-boot-qcom@groups.io, u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
References: <20250108115911.4163437-1-alexeymin@postmarketos.org>
 <20250108115911.4163437-2-alexeymin@postmarketos.org>
 <6dcaf2a0-3c08-4bcc-9e7d-8cf7a77cd54c@linaro.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Alexey Minnekhanov <alexeymin@postmarketos.org>
In-Reply-To: <6dcaf2a0-3c08-4bcc-9e7d-8cf7a77cd54c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
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

On 1/8/25 5:40 PM, Caleb Connolly via groups.io wrote:
> Hi Alexey,
> 
> Thanks for the patch! Really happy to see support for this new platform.
> 
> On 08/01/2025 12:59, Alexey Minnekhanov wrote:
>> Apparently not all GDSCs are the same. In Linux driver, depending on which
>> GDSC flags are set, different status register is checked when powering it
>> on/off. And on top of that, different bit inside that register is tested.
>>
>> Port missing parts from Linux driver to U-Boot:
>>   - add GDSC flags;
>>   - adjust logic when checking GDSC status to match one in Linux driver.
> 
> Sorry it's a bit of a pain, but could you split this into two patch and
> adjust the ordering so we don't risk breaking someones bisect if they
> land here. I'd propose:
> 
> Patch 1: as-is
> Patch 2: add the flags enum and adjust struct qcom_power_map
> Patch 3: would be the "port to new flags" patch
> Patch 4: adjust qcom_power_set() (the bulk of this patch)
> Patch 5: add sdm660 clock driver
> 
> does this make sense?

Yes, I think I understand what you mean, will try to rework in  next 
version.

