Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE56C47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 16:55:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6850D876EA;
	Thu, 25 Jan 2024 17:55:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KntQOxdI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C46F18785A; Thu, 25 Jan 2024 17:55:47 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39D1C875FC
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 17:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40PGtgpb092232;
 Thu, 25 Jan 2024 10:55:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706201742;
 bh=YgJw5m6RQzV12Sh1dTjhLQiQTR+n+GRdiVeFliBPBvM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=KntQOxdIihkOVahL56B3+cMLAfaR1AsDMKmYgKq4GWqzEKYJyg1j9a0cObLpZ5UaI
 v1oaH1vrNBud21UsBr5Yb6DfWbAVqqjJ6KCx+/kAvz2/XTzb+e97vu1JpeGAu+D1Y9
 SNMEVwkE33rFF+CGpAY8zrA5uoy5yRXRuUgb1Xoc=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40PGtgWW028152
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 25 Jan 2024 10:55:42 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Jan 2024 10:55:41 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Jan 2024 10:55:41 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40PGtfLu091362;
 Thu, 25 Jan 2024 10:55:41 -0600
Message-ID: <948db6de-8150-493e-9a15-62aeac9aea6f@ti.com>
Date: Thu, 25 Jan 2024 10:55:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: ti_sci: fix the secure_hdr in do_xfer
Content-Language: en-US
To: Dhruva Gole <d-gole@ti.com>, Nishanth Menon <nm@ti.com>
CC: Kamlesh Gurudasani <kamlesh@ti.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>, Neha Francis <n-francis@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20240124101558.184411-1-d-gole@ti.com>
 <87fryn7zoz.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
 <20240124130859.sdldy4jafknoa23q@dhruva>
 <20240124163910.sp7gt56lihoujm7k@etching>
 <20240124173723.3wfiwfgf6rhwgwaa@dhruva>
 <20240124180813.azl3ldrrg7a5iosz@spoils>
 <20240125054334.zjll7j4fpv66ciyn@dhruva>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240125054334.zjll7j4fpv66ciyn@dhruva>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 1/24/24 11:43 PM, Dhruva Gole wrote:
> On Jan 24, 2024 at 12:08:13 -0600, Nishanth Menon wrote:
>> On 23:07-20240124, Dhruva Gole wrote:
>>> On Jan 24, 2024 at 10:39:10 -0600, Nishanth Menon wrote:
>>>> On 18:38-20240124, Dhruva Gole wrote:
>>>>> On Jan 24, 2024 at 16:42:12 +0530, Kamlesh Gurudasani wrote:
>>>>>> Dhruva Gole <d-gole@ti.com> writes:
>>>>>>
>>>>>>> The secure_hdr needs to be 0 init-ed however this was never being put
>>>>>>> into the secure_buf, leading to possibility of the first 4 bytes of
>>>>>>> secure_buf being possibly garbage.
>>>>>>>
>>>>>>> Fix this by initialising the secure_hdr itself to the secure_buf
>>>>>>> location, thus when we make it 0, it automatically ensures the first 4
>>>>>>> bytes are 0.
>>>>>>>
>>>>>>> Fixes: 32cd25128bd849 ("firmware: Add basic support for TI System Control Interface (TI SCI)")
>>>>>>> Signed-off-by: Dhruva Gole <d-gole@ti.com>
>>>>>>> ---
>>>>>>>
>>>>>>> Boot tested for sanity on AM62x SK
>>>>>>> https://gist.github.com/DhruvaG2000/724ceba3a0db03f4b0bff47de1160074
>>>>>>>
>>>>>>> Cc: Nishanth Menon <nm@ti.com>
>>>>>>> Cc: Tom Rini <trini@konsulko.com>
>>>>>>>
>>>>>>>   drivers/firmware/ti_sci.c | 6 +++---
>>>>>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
>>>>>>> index f5f659c11274..83ee8401a731 100644
>>>>>>> --- a/drivers/firmware/ti_sci.c
>>>>>>> +++ b/drivers/firmware/ti_sci.c
>>>>>>> @@ -236,13 +236,13 @@ static int ti_sci_do_xfer(struct ti_sci_info *info,
>>>>>>>   {
>>>>>>>   	struct k3_sec_proxy_msg *msg = &xfer->tx_message;
>>>>>>>   	u8 secure_buf[info->desc->max_msg_size];
>>>>>>> -	struct ti_sci_secure_msg_hdr secure_hdr;
>>>>>>> +	struct ti_sci_secure_msg_hdr *secure_hdr = (struct ti_sci_secure_msg_hdr *)secure_buf;
>>>>>>>   	int ret;
>>>>>>>   
>>>>>>>   	if (info->is_secure) {
>>>>>>>   		/* ToDo: get checksum of the entire message */
>>>>>>> -		secure_hdr.checksum = 0;
>>>>>>> -		secure_hdr.reserved = 0;
>>>>>>> +		secure_hdr->checksum = 0;
>>>>>>> +		secure_hdr->reserved = 0;
>>>>>>>   		memcpy(&secure_buf[sizeof(secure_hdr)],xfer->tx_message.buf,
>>>>>> secure_hdr is pointer now, the value may be same but (struct
>>>>>> ti_sci_secure_msg_hdr) would make more sense
>>>>>
>>>>> Good catch Kamlesh! I have sent a new revision addressing this.
>>>>>
>>>>
>>>> Makes no sense why we have secure API support in U-Boot. what is using
>>>> this?
>>>
>>> In my understanding of generic K3 boot flow, things like proc_boot and
>>> even applying or removing of firewalls will need a secure channel to
>>> talk to TIFS right? From my understanding secure host can only talk to
>>> TIFS and make such requests hence secure API.
>>
>> U-boot runs in NS world, you cant even talk to the Trustzone Sec proxy
>> without triggering a firewall violation.
> 
> I am not going to debate on whether U-Boot is or isn't a secure entity.
> The original code base was making secure_hdr.checksum = 0;
> 
> But this wasn't really being used anywhere. I am just making sure what the
> original code base intended to do is being actually done.
> 
>>
>>
>> https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/general/TISCI_header.html?highlight=header#secure-messaging-header
>> "The Secure Messaging Header is only required when sending messages over
>> secure transport. Messages sent over non-secure transport must not
>> contain the secure messaging header."
> 
> Yes, understood. I do not have the context behind the commit
> 32cd25128bd849 ("firmware: Add basic support for TI System Control
> Interface (TI SCI)") but perhaps you do. So please help me understand
> why there's this code:

A little background, this checksum was envisioned to help protect
messages from glitches in-flight for security/safety reasons. For
whatever reason it was only ever added for messages sent over
"secure" channels. Which means the message sent changes based
on what channel you use to send the message (which is a bit of a
layering violation IMHO but anyway..).

In TFA/OP-TEE which *can* send messages over secure channels we
append this header in the transport layer (secure proxy driver),
not here in the message protocol driver. If we decide to keep this
secure header code then it should be moved into the transport driver
(mailbox/k3-sec-proxy.c) as only it would know what channel the
message will be sent on (and so if it should have the header).

I'd say since U-Boot today cannot send over secure channels anyway,
lets just drop this code and if we ever need it then we add it back
over in the right spot at that time.

Andrew

> memcpy(&secure_buf[sizeof(secure_hdr)], xfer->tx_message.buf, xfer->tx_message.len);
> 
> which is basically trying to create a 4 byte offset (trying to abide by the secure
> msg format?)
> If UBoot as you say is non secure let's just send regular TISCI messages. Are you
> suggesting that we trim all of if (info->is_secure) and related "secure"
> code from uboot? Then that's a separate cleanup we need to have.
> 
> 
>>
>> btw, that checksum field should be renamed integ_check, but anyways..
>>
>> So, I do not see a reason to even have that if condition in the first
>> place and what real bug was getting fixed in this patch.
> 
> "Real" bug or "potential" bug, the code did not seem to be doing what it should have
> been doing, that's all. For anyone reading the checksum = 0 that is
> there in today's code it's super confusing.
> 
> Either get rid of it completely, or else make it do what it was trying
> to do. Let me know how we should proceed.
> 
> 
