Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C61BC36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 14:37:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90E5080548;
	Mon, 24 Mar 2025 15:37:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742827020;
	bh=yOYPv54YyITSDydGwJxS98w0Z8IJzKmTRLd1C3wJUCU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CVAlCKmIZx4TjiyljE3MbOo3rvDUUtdxzvQYHEKg1MWhSK+qb5ukOGCMcSdV5OC+O
	 GilV9s0S6OZ15k/3cRE4RMDqqv+hBr7/u9/NgCtZFs/gzhig4NwGYRx8GkeLmiza/j
	 aZGYmJ3zvQja/IhKXdb4v2FMCpuKT1I6uzysacI9vXCnB8LBdJ8ikZ+8UYOm6pg3oc
	 mkoop8fF0rnfdqIgV1ER6rE16gzGHlF7bGZKU34gEatKX8Y27haJisFB7XR64Mx8Mf
	 jkmiyjRodaPDoEaHawnLLIFUMactqavRnFEljeFkLGwFmKQCqBgaTncqxUVs0NDjKx
	 kVBPxNFaV6xaw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3685E805C3; Mon, 24 Mar 2025 15:37:00 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C80380107
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 15:36:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="ECmkXDQM"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C5E2110290263; Mon, 24 Mar 2025 15:36:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742827016; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=yOYPv54YyITSDydGwJxS98w0Z8IJzKmTRLd1C3wJUCU=;
 b=ECmkXDQMlicw8MCZ/OPrpigcosWoVQRqrt32as17crH9S+x86jFDLKTlVvZhJc5tYT5IOH
 PY1k72akOOFQKBplCev8xyS+exZ6MUEFiadiRwBo/5DGzqcbdtuKExu41/flm2T/N9m3LX
 mpkzsDeKDysBuGlRI9K8AcfJXfl3v1uRqsM9rdTQ5XnY4zKDRVxKo+pxsRWqXfDh6q2ZrC
 RwKDj7sWTNVfjaSmJ663ABlS/CMHPfDLSIMtfm7+D1unJYNG2cPxo1FS+AJXJSIAIe6I+Z
 8AMpKWxe2xj6hx25R32TdVtbnWWYlUP9dOvm+oLP13sJovNdj2zpMkkW05LS6Q==
Message-ID: <48e57653-d86a-4650-859e-1e77a6c29f4a@denx.de>
Date: Mon, 24 Mar 2025 15:36:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: gadget: Fix match_ep callback for NXP UUU tool
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>, Lukasz Majewski
 <lukma@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
References: <20250319220805.219001-1-marex@denx.de>
 <87a59gdofd.fsf@baylibre.com> <20250324080315.GA6932@francesco-nb>
 <87pli6esx0.fsf@baylibre.com> <Z-FQeVtIImeHsfXs@gaggiata.pivistrello.it>
 <42f53c19-de12-45c3-9091-2e6c23d1fcd4@denx.de>
 <Z-FpUV-fwGvch4-W@gaggiata.pivistrello.it>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <Z-FpUV-fwGvch4-W@gaggiata.pivistrello.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 3/24/25 3:16 PM, Francesco Dolcini wrote:
> On Mon, Mar 24, 2025 at 02:53:23PM +0100, Marek Vasut wrote:
>> On 3/24/25 1:30 PM, Francesco Dolcini wrote:
>>> On Mon, Mar 24, 2025 at 09:26:03AM +0100, Mattijs Korpershoek wrote:
>>>> Hi Francesco,
>>>>
>>>> On lun., mars 24, 2025 at 09:03, Francesco Dolcini <francesco@dolcini.it> wrote:
>>>>
>>>>> Hello Mattijs, Marek
>>>>>
>>>>> On Thu, Mar 20, 2025 at 10:47:02AM +0100, Mattijs Korpershoek wrote:
>>>>>> On mer., mars 19, 2025 at 23:07, Marek Vasut <marex@denx.de> wrote:
>>>>>>
>>>>>>> The UUU tool excepts the interrupt-in endpoint to be ep1in, otherwise
>>>>>>> it crashes. This is a result of the previous hard-coded EP setup in
>>>>>>> drivers/usb/gadget/epautoconf.c which did special-case EP allocation
>>>>>>> for SPL builds, and which was since converted to this callback, but
>>>>>>> without the special-case EP allocation in SPL part.
>>>>>>>
>>>>>>> This reinstates the SPL part in an isolated manner, only for NXP iMX
>>>>>>> SoCs, only for SPL builds, and only for the ep1in interrupt-in endpoint.
>>>>>
>>>>> UUU can (and in our case is) used also on non-NXP i.MX platforms.
>>>>> What should we do?
>>>>
>>>> Do reproduce the problem (UUU tool crashes) on those platforms with
>>>> recent U-Boot versions (v2024.10+) ?
>>>
>>> Not tested, my comment is purely based on the code and the commit message.
>>> Older U-Boot versions (up to v2024.04, included) are working fine, with UUU used
>>> with TI K3 SoCs (AM69, AM62, AM62P).
>> Are you talking about the NXP UUU ?
> 
> yes, it works just fine on not-NXP SoC.
Then please test if it still works, and if not, this patch needs to be 
expanded to cover TI ... or apply unconditionally in SPL (sigh).
