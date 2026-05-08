Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477AACD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 11:26:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B07884BD1;
	Fri,  8 May 2026 13:26:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="kSGltBLQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E794484BDC; Fri,  8 May 2026 13:26:28 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C942284BBD
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 13:26:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 45D61112511; Fri,  8 May 2026 13:26:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1778239585;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=+Rhap1VS42kVRW7NTpueGXTmcsIo6oZx+EE26ulsS9Y=;
 b=kSGltBLQfRsUio0ZtMw+h5qo8Y+oa6ZFzuKg+C1Up1hYWPOuc2vsrVVF4S/Hfu1O9Pm8bc
 M6QF5Fu2lAWbmH4JRriiSqu+bwSclWToyCGfK3hZQoeAJqGHH5dNXoQFSRpiyUWimQfUV+
 Yuexgq0csqwRHDGLzcH5JHFHikoOB+NFfW1iRTtgSWndSBMK3179e0K0IwTVZPDY+kVrC+
 2qSnZXJ5w9M/+f612cg62nWDB9Vw/a5FZGdLYZnVv14ix/lnJ577CY4k77zAi6i5jrAWt1
 9q1wTsh/0jwLqWP9odMupCTEQhigeUd8kEOSHuCG624F6Z6CCAlPzEXtR2eT2g==
Message-ID: <81e67a70-d4f0-4cd3-9dac-824e418599cb@nabladev.com>
Date: Fri, 8 May 2026 13:26:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc3: core: fix memory leaks in event buffer
 cleanup
To: Alexey Charkov <alchark@flipper.net>,
 Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
Cc: marex@denx.de, trini@konsulko.com, mkorpershoek@kernel.org,
 macromorgan@hotmail.com, casey.connolly@linaro.org, quic_varada@quicinc.com,
 felipe.balbi@linux.intel.com, u-boot@lists.denx.de
References: <20260416055501.494002-1-gurumoorthy.santhakumar@oss.qualcomm.com>
 <CAKTNdwHA_3eJ4D7maBmAAr1DyrvT_meMsJ7_Naux1dKTzOu3OQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <CAKTNdwHA_3eJ4D7maBmAAr1DyrvT_meMsJ7_Naux1dKTzOu3OQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 5/8/26 1:01 PM, Alexey Charkov wrote:
> On Fri, May 8, 2026 at 2:45 PM Gurumoorthy Santhakumar
> <gurumoorthy.santhakumar@oss.qualcomm.com> wrote:
>>
>> In dwc3_free_one_event_buffer(), only the DMA buffer (evt->buf) was
>> being freed via dma_free_coherent(), but the evt structure itself was
>> never explicitly freed, causing a memory leak.
>>
>> In dwc3_free_event_buffers(), the ev_buffs pointer array allocated
>> with memalign() was never freed after iterating and releasing all
>> individual event buffers, causing another memory leak.
>>
>> Fix both leaks by freeing the evt struct in
>> dwc3_free_one_event_buffer() and freeing dwc->ev_buffs in
>> dwc3_free_event_buffers() after all entries have been released.
>>
>> Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
>> ---
>> Changes in V2:
>> - Removed redundant NULL check before free
>> - Removed NULL assignment to the pointer after free
>> - Link to V1:
>> https://lore.kernel.org/u-boot/20260414055013.2978223-1-gurumoorthy.santhakumar@oss.qualcomm.com/
>> ---
>> ---
>>   drivers/usb/dwc3/core.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 6f22b9232ba..65c4d1a4e6f 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -206,6 +206,7 @@ static void dwc3_free_one_event_buffer(struct dwc3 *dwc,
>>                  struct dwc3_event_buffer *evt)
>>   {
>>          dma_free_coherent(evt->buf);
>> +       free(evt);
> 
> Hi Gurumoorthy,
> 
> evt is allocated using devm_kzalloc, so this change introduces a
> double-free causing a crash when tearing down a USB gadget mode
> session on my Rockchip RK3576 board:
Can you please also provide a Tested-by: for this fix ?
