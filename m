Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84143C369A4
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 14:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E788E8171B;
	Tue,  8 Apr 2025 16:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744123889;
	bh=aHh2ybfehZpA/derdG8e8rCbHWgSBqEgjLxkbNLa03Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gHKO2uWCoc9inWCALiwnmwT949OEtFgr5X+zDge2Z5dg8hd+bhh7SaV/Wz8gL+tB1
	 K8byhbhV69q8V6Z5EnNxHP2YAaXm2TtOM9AJ3nxTJY6bhxJ3rB+D+1I/y+z9+MISP1
	 Se/0GCQvLNdcOO/9IU65qzrI8kfbt6A8v4uV0xlIJRnbzhHI6lU4Y3S54x+rQULSkQ
	 PL/eRzepaVMKF4E0hfNfVo+kGfmRFJXSnsrqSpUf0rB1Js/mCxMbOXi7KsBDqaB6bs
	 fCNZxdGbageA8PunUTJuKO10KbgOhP1ni/ixmXHAZj4KdNTGphgb21UJ530fXJYTl0
	 os+tx/NWfb+HQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6F7D82102; Tue,  8 Apr 2025 16:51:29 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93F1780107
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 16:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="JdFxFuPr"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7B88E1038191E; 
 Tue,  8 Apr 2025 16:51:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744123886; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=aHh2ybfehZpA/derdG8e8rCbHWgSBqEgjLxkbNLa03Y=;
 b=JdFxFuPrOs+W0aLil2wC5jESHPuaUxFNafWj8gYfkofd4V9J1gC45746aWOXcP1T5ZoLb2
 WXk7h7e7hZs1jcHUZpccAq/FHQ0C+PayebMglnZeRp7sIMbH/ZIgKYdRiftaga5qYBet6o
 FgEsHXAVVCen0xj4yUr/h0SLLlrK4hYqtFyPca/tOGVP4P7Zm6TC2VNOSN/gdLrw2li3Y2
 6T6yIMOoTrP6+Lrv+ms4nnPu2rxNkSoahLJe8INq2lb6+AnFYl7Gxpba/jP6hIfMtxEpvo
 iBUMjRDD82r9X1az9jIG2tuZ/+ucVVetnZEQVCmAJwgr10XUgXUPMZmn9hzoDg==
Message-ID: <bf955296-b4fe-443a-8bf9-ead7afe57661@denx.de>
Date: Tue, 8 Apr 2025 16:51:22 +0200
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
 <48e57653-d86a-4650-859e-1e77a6c29f4a@denx.de>
 <Z_TnLsKHod_fvDsK@gaggiata.pivistrello.it>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <Z_TnLsKHod_fvDsK@gaggiata.pivistrello.it>
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

On 4/8/25 11:06 AM, Francesco Dolcini wrote:
> On Mon, Mar 24, 2025 at 03:36:52PM +0100, Marek Vasut wrote:
>> On 3/24/25 3:16 PM, Francesco Dolcini wrote:
>>> On Mon, Mar 24, 2025 at 02:53:23PM +0100, Marek Vasut wrote:
>>>> On 3/24/25 1:30 PM, Francesco Dolcini wrote:
>>>>> On Mon, Mar 24, 2025 at 09:26:03AM +0100, Mattijs Korpershoek wrote:
>>>>>> Hi Francesco,
>>>>>>
>>>>>> On lun., mars 24, 2025 at 09:03, Francesco Dolcini <francesco@dolcini.it> wrote:
>>>>>>
>>>>>>> Hello Mattijs, Marek
>>>>>>>
>>>>>>> On Thu, Mar 20, 2025 at 10:47:02AM +0100, Mattijs Korpershoek wrote:
>>>>>>>> On mer., mars 19, 2025 at 23:07, Marek Vasut <marex@denx.de> wrote:
>>>>>>>>
>>>>>>>>> The UUU tool excepts the interrupt-in endpoint to be ep1in, otherwise
>>>>>>>>> it crashes. This is a result of the previous hard-coded EP setup in
>>>>>>>>> drivers/usb/gadget/epautoconf.c which did special-case EP allocation
>>>>>>>>> for SPL builds, and which was since converted to this callback, but
>>>>>>>>> without the special-case EP allocation in SPL part.
>>>>>>>>>
>>>>>>>>> This reinstates the SPL part in an isolated manner, only for NXP iMX
>>>>>>>>> SoCs, only for SPL builds, and only for the ep1in interrupt-in endpoint.
>>>>>>>
>>>>>>> UUU can (and in our case is) used also on non-NXP i.MX platforms.
>>>>>>> What should we do?
>>>>>>
>>>>>> Do reproduce the problem (UUU tool crashes) on those platforms with
>>>>>> recent U-Boot versions (v2024.10+) ?
>>>>>
>>>>> Not tested, my comment is purely based on the code and the commit message.
>>>>> Older U-Boot versions (up to v2024.04, included) are working fine, with UUU used
>>>>> with TI K3 SoCs (AM69, AM62, AM62P).
>>>> Are you talking about the NXP UUU ?
>>>
>>> yes, it works just fine on not-NXP SoC.
>> Then please test if it still works, and if not, this patch needs to be
>> expanded to cover TI ... or apply unconditionally in SPL (sigh).
> 
> I just found the time to check some logs from our CI in which we execute such a
> workflow.  We do use UUU only from U-Boot proper, so we are not going to be
> affected by this SPL specific change.
> 
> However I found this error in the logs, on both a TI AM62 and an i.MX8MP
> 
> ```
> Starting download of 40524455 bytes
> dwc3-generic-peripheral usb@31000000: request 0000000099f219c0 was not queued to ep1in-bulk
> ..........................................................................
> ..........................................................................
> ..........................................................................
> ..........................................................................
> .............
> downloading of 40524455 bytes finished
> dwc3-generic-peripheral usb@31000000: request 0000000099f219c0 was not queued to ep1in-bulk
> dwc3-generic-peripheral usb@31000000: request 0000000099f219c0 was not queued to ep1in-bulk
> Starting download of 1675 bytes
> dwc3-generic-peripheral usb@31000000: request 0000000099f219c0 was not queued to ep1in-bulk
> downloading of 1675 bytes finished
> dwc3-generic-peripheral usb@31000000: request 0000000099f219c0 was not queued to ep1in-bulk
> dwc3-generic-peripheral usb@31000000: request 0000000099f219c0 was not queued to ep1in-bulk
> Starting download of 82 bytes
> dwc3-generic-peripheral usb@31000000: request 0000000099f219c0 was not queued to ep1in-bulk
> downloading of 82 bytes finished
> dwc3-generic-peripheral usb@31000000: request 0000000099f219c0 was not queued to ep1in-bulk
> dwc3-generic-peripheral usb@31000000: request 0000000099f219c0 was not queued to ep1in-bulk
> ```
> 
> the download is successful however, despite those error messages. Any idea? Is
> this related to this topic?
I have a feeling it is the UUU which should be fixed to not depend on 
the ep1-in , really.

You could however quickly try and apply the change in this patch not 
only to SPL, but to U-Boot on your board as well, and see if those 
warnings disappear.
