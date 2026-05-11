Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907C9CD37B5
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 09:05:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18C0F846BD;
	Mon, 11 May 2026 11:05:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PYHcMRBX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5709284836; Mon, 11 May 2026 11:05:49 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60EEF846AA
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 11:05:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 585586001A;
 Mon, 11 May 2026 09:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908A0C2BCB0;
 Mon, 11 May 2026 09:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778490344;
 bh=xNeNPDgnZH+kpA2sfwWew2GB4DZIZan64l6xxO1LexI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=PYHcMRBXld7HqicJDbpFcJFilvDCQ28LUsFmwlaP7aS0WrbNw0HkSR7RdqSxwUhuv
 sNVDzJD0H/cunoTCBXZbDlU7/u6VcKu0xuDpmPOz/zKtCzQ89PxbWO69S9FWsnRAiT
 tbirdXzkLVrrq/aTfKvNyzHVUhaeTop65sqy00SRIe1wk+V5qMMOaehJ7/n7WxG2aW
 dIAe2ljUpZxZaZdoSiTFPkSKf0bCsmj6EOKD44ZVB1H7pMNISAK1+UEiA+RRrSWppI
 5ud92311Tczbuqpuo4kw+yhFmHhD7nr3la2P0gcP7Qir/ExJkV4/nGZP3ZA3RBUGx1
 U4h9xDibCiErw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marex@nabladev.com>, Alexey Charkov <alchark@flipper.net>,
 Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
Cc: marex@denx.de, trini@konsulko.com, mkorpershoek@kernel.org,
 macromorgan@hotmail.com, casey.connolly@linaro.org,
 quic_varada@quicinc.com, felipe.balbi@linux.intel.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2] usb: dwc3: core: fix memory leaks in event buffer
 cleanup
In-Reply-To: <81e67a70-d4f0-4cd3-9dac-824e418599cb@nabladev.com>
References: <20260416055501.494002-1-gurumoorthy.santhakumar@oss.qualcomm.com>
 <CAKTNdwHA_3eJ4D7maBmAAr1DyrvT_meMsJ7_Naux1dKTzOu3OQ@mail.gmail.com>
 <81e67a70-d4f0-4cd3-9dac-824e418599cb@nabladev.com>
Date: Mon, 11 May 2026 11:05:41 +0200
Message-ID: <871pfiwc2i.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Alexey,

Thank you for reporting this issue.

On Fri, May 08, 2026 at 13:26, Marek Vasut <marex@nabladev.com> wrote:

> On 5/8/26 1:01 PM, Alexey Charkov wrote:
>> On Fri, May 8, 2026 at 2:45=E2=80=AFPM Gurumoorthy Santhakumar
>> <gurumoorthy.santhakumar@oss.qualcomm.com> wrote:
>>>
>>> In dwc3_free_one_event_buffer(), only the DMA buffer (evt->buf) was
>>> being freed via dma_free_coherent(), but the evt structure itself was
>>> never explicitly freed, causing a memory leak.
>>>
>>> In dwc3_free_event_buffers(), the ev_buffs pointer array allocated
>>> with memalign() was never freed after iterating and releasing all
>>> individual event buffers, causing another memory leak.
>>>
>>> Fix both leaks by freeing the evt struct in
>>> dwc3_free_one_event_buffer() and freeing dwc->ev_buffs in
>>> dwc3_free_event_buffers() after all entries have been released.
>>>
>>> Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qua=
lcomm.com>
>>> ---
>>> Changes in V2:
>>> - Removed redundant NULL check before free
>>> - Removed NULL assignment to the pointer after free
>>> - Link to V1:
>>> https://lore.kernel.org/u-boot/20260414055013.2978223-1-gurumoorthy.san=
thakumar@oss.qualcomm.com/
>>> ---
>>> ---
>>>   drivers/usb/dwc3/core.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>> index 6f22b9232ba..65c4d1a4e6f 100644
>>> --- a/drivers/usb/dwc3/core.c
>>> +++ b/drivers/usb/dwc3/core.c
>>> @@ -206,6 +206,7 @@ static void dwc3_free_one_event_buffer(struct dwc3 =
*dwc,
>>>                  struct dwc3_event_buffer *evt)
>>>   {
>>>          dma_free_coherent(evt->buf);
>>> +       free(evt);
>>=20
>> Hi Gurumoorthy,
>>=20
>> evt is allocated using devm_kzalloc, so this change introduces a
>> double-free causing a crash when tearing down a USB gadget mode
>> session on my Rockchip RK3576 board:
> Can you please also provide a Tested-by: for this fix ?

As mentioned by Marek, we already have a fix in review for the problem
you have reported.

It's available here:
https://lore.kernel.org/u-boot/20260507-usb-v3-1-402b37fc2154@oss.qualcomm.=
com/

Can you please test the above patch and reply with a Tested-by: if it
fixes your problem?
