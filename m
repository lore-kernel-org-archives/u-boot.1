Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0000DC48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 10:41:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70AEB87ED2;
	Mon, 26 Feb 2024 11:41:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708944109;
	bh=V0x3IybnQbbPdMePueV+OUr0Bme0/qHjPDvKi7hGyUU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sgVdRovFNvisEy1ByCQj41AvztvD/DpuPViihppVI91kfn5gfprI4Nud36MSKaguj
	 He/oHbaeuyAkH+5bmS2WxfkGfvxyAk6bonMUgo1Ogao48+AGJkcZgGQ4p84oKcCHnz
	 XFs7hMQFZVZL7BcCEvm+6BkFZPIDvt9XGublr28C8V9ll7/D4nENq1pVtaoKjZxL1l
	 dTSAnazxHz7e8k5AZopNHoni56go502TXZcz5NNvm8yEdJ3+jDtTPa7Seyd0zM9vTw
	 eoxuLaLQvyRbi6X04zNwMF5I92R23fPQAAbi++FtKJBwGdZ4s7T7/PKE36GAGU6/Sc
	 6m4I4HkKi+pSg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2C56E87E52;
 Mon, 26 Feb 2024 11:41:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708944108;
 bh=V0x3IybnQbbPdMePueV+OUr0Bme0/qHjPDvKi7hGyUU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Jnhf3eL8Lvv6hMqzO6LsTGzuKJwiqnQAwnhrqgN1bRWE4LBdb9E39hcFxQZklXSFh
 h2/fvYuhbhP5wn0oABDxWGuHlr/HGcK3RqcDORkknhd66nSKkk+8GUuZ2h+D1gv6LY
 hn4UmuvD3KcSI/hvk1dIRyoQrgbUnrNWVr1L2kLfMkAovHW0RSab9MsP1XZWuRE6Ww
 PqDLOt4uWzYEXgjj5RZWEB/YNreu200Sj4SwW6a9Lgo47UiiQdJCa9AJwn/Eo/fu/k
 qV/74x1fNz4vmUTo6k9STk8buSdjv/cpqIy7B2Pvgx5BcTb6kJvl8tMRHOS7MnAl9o
 lbP8XSJNYOiPQ==
Message-ID: <04b243f4-c89d-4ddc-80b9-4ff83e9076aa@denx.de>
Date: Mon, 26 Feb 2024 11:41:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] reset: imx: Add support for i.MX8MP reset
 controller
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, francesco@dolcini.it,
 trini@konsulko.com, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, festevam@denx.de, andrejs.cainikovs@toradex.com,
 sjg@chromium.org, peng.fan@nxp.com, aford173@gmail.com,
 ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-3-sumit.garg@linaro.org>
 <a5862ce9-8977-47cb-87af-e8da1839867d@denx.de>
 <CAFA6WYNEpg_zgRo_gD3ab3QR1e1j1xZCOb8ui-ZSV27U_Yv4EQ@mail.gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFA6WYNEpg_zgRo_gD3ab3QR1e1j1xZCOb8ui-ZSV27U_Yv4EQ@mail.gmail.com>
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

On 2/26/24 11:33 AM, Sumit Garg wrote:
> On Mon, 26 Feb 2024 at 14:24, Marek Vasut <marex@denx.de> wrote:
>>
>> On 2/26/24 9:04 AM, Sumit Garg wrote:
>>> Add support for i.MX8MP reset controller, it has same reset IP
>>
>> Same as what ?
> 
> I can expand it.

This does not answer the question .

>>> inside
>>> but with different module layout.
>>>
>>> Inspired from counterpart Linux kernel v6.8-rc3 driver:
>>> drivers/reset/reset-imx7.c.
>>
>> Use commit ID of the last change in that driver:
>>
>> bad8a8afe19f ("reset: Explicitly include correct DT includes")
>>
>> I guess
> 
> Why isn't the Linux kernel tag sufficient here? I don't see the value
> of cross referencing commits across different git projects.

The commit ID is a unique identifier, tag can be rewritten .
