Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEB8606A331
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 23:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QLMLG3Nu;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=RBmLuiV/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7EDB34071F;
	Mon, 23 Nov 2026 23:37:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zv2y__DpDIcZ; Mon, 23 Nov 2026 23:37:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 76F7240703
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795477039;
	b=KP+A5CG/XFf+fmvMl58lJrJQEiGTbjZM7jIGPo5qnkLBcZiHIDLqMinOS3t4DzMSWR8j
	 5cz1sZ4tv/7uq+QBr8bgKaBxgNq2gdNDfbTktP/ajqOuKs7ci38qQzZ9izC9gorKTJoZa
	 ja2vCP/f7225DXjhUJCdcve6Ce3sj+xUZ34rPA4B3NtnQsgNhCJqmBF584ML77Yu3lEMQ
	 3H88hWyMPXtI0vTJ/WuJUy21Y6M4zKtI1Z2YJFgZHJJODl1mpWoP2+tHqhbQgwX6dfbEI
	 FIJBH48mRUILPnJKX6JgrmLlMRqHRsNcfOdTL/UOrS+EFiTGsce0+j5h5LaTmcyf4nw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795477039;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:From:Subject:
	 To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lB4yz5g4uhLZD+h12cHDSi6TGTV3CFCXVy6BfLJ3wqg=;
	b=FHkTp2aFsr3Cl5KXs/F9SmoP0Iy5mNcgZ8+nxukXdryvXwWPTYF9VGCaK3FTY9j5Q0nO
	 1Nynmg7Fs5FG8G0CntFrTIva8AY5zPN6XJs5/3gOJTmN310h9u8LPK/DSIyitdxIRpbTz
	 Tnzy30XOv5An2agEnxw9++R/1Wk6TxDpeku0CA1BsYnVW2rbIrMfoxJq7uOCbnhhzUJ79
	 CRTa2nOqb4SfiXh0WwYt3YtYnGOpnGBzIbycu3+LiUSVDMAUzuRBR+yKtqddPIlJzYJPB
	 AYO9iW5awNUrefelOA/IDXD/UipzGSiI0hXysJedNnb8Wh/j0MSf3cEg5nxG7tveZFQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795477039;
	bh=lB4yz5g4uhLZD+h12cHDSi6TGTV3CFCXVy6BfLJ3wqg=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QLMLG3Nu5ja3nUBlxrOPXrLacL3NT1CEp3l5Df/W+s2BbXKbvjl+ACW1qDbMVmpwM
	 Lr3b6487c/TooIxxSQHKLQowk5z2J5ejxWOlhi732o6e5fRIDWU4SaFw2J5xEQXzEq
	 XLimih/6yff6Kh/dJ2jDwp4WLzEFtl98rnezFKxQ2J6oS+ByPOOucV1KDeTud6kyfs
	 J1wuN/4AED1ijyYIVPFSWTyMLAUPinjMEbi/hVSWdb5gVjIykyxjdnQcmLqC5V1dmX
	 sBKWEId7N/qxStlSWSDnxOPAGirKLfIb2cdnVca1EGqQ/hdN4ZrJa1he1bjYcRkV17
	 vOjxe0fnrWeNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 76F7240703;
	Mon, 23 Nov 2026 23:37:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CD5AE1AB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:37:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B1A5F60684
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:37:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Pwb4_MwihwF for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 23:37:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6CFFF605F0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=RBmLuiV/
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6CFFF605F0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:37:15 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jYMmS0xLpzKqVc;
 Tue, 24 Nov 2026 00:37:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1795477032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lB4yz5g4uhLZD+h12cHDSi6TGTV3CFCXVy6BfLJ3wqg=;
 b=RBmLuiV/BJy4hK/PT1zy7jrfumMkZ1jMRT9zn7cFWL/bvoKQgqwpoPqgsiba5Nw+fjM4tO
 i+m06JK2wfGB+J+5Lsn7iGgk5m2yi82XGQUAepjQYL+QlXdAQ9x3xKUzxu8HQeGA/q5DLM
 o6mn0cGmMzJT9g7BRK3f44unp9sik1skZKrzYtMNAdw3b1V3zWkFDqFq+opALdGKeX5cGP
 8ksGs0fDHiXYkmFncffvxagEknMTesW7h38AYxftKbIoffERWQAS+W/u6EKHNhDLVjwUTx
 QrRAIW0mc0YyKmGaB0vzFMH+H5v0B5orjEAiDMqr6QNCNEtqmkrYz4lZ1VNnMg==
Message-ID: <74452141-55e8-4cde-9e0d-0a3128ad48c6@mailbox.org>
Date: Mon, 23 Nov 2026 17:17:03 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [PATCH 2/2] usb: onboard-hub: add vdda support for Microchip
 USB2514
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>
Cc: Tom Rini <trini@konsulko.com>, Alexey Charkov <alchark@flipper.net>
References: <20261119-usb-onboard-hub-v1-0-22aa6ef1d9c8@foss.st.com>
 <20261119-usb-onboard-hub-v1-2-22aa6ef1d9c8@foss.st.com>
 <6aeb57ac-6b63-4593-ab3f-c927fb3c51f8@mailbox.org>
 <562c2c54-d943-477f-b9ab-2cbe6f1b34b3@foss.st.com>
 <afce74bd-8bdb-457a-b2a8-31f5211b0a7e@mailbox.org>
 <913b5977-84e8-47a6-96a5-1508b47bd393@foss.st.com>
Content-Language: en-US
In-Reply-To: <913b5977-84e8-47a6-96a5-1508b47bd393@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b1ab804b1c8d539ecf7
X-MBO-RS-META: gpi1usf69urjmpkwuqbpoepw4p5jo87j
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/26 10:23 AM, Fabrice Gasnier wrote:
> On 11/20/26 12:02, Marek Vasut wrote:
>> On 11/20/26 9:24 AM, Fabrice Gasnier wrote:
>>> On 11/19/26 13:14, Marek Vasut wrote:
>>>> On 11/19/26 11:59 AM, Fabrice Gasnier wrote:
>>>>> This hub is powered by digital and analog 3V3 power rails, so provide
>>>>> the possibility to use different regulators for digital (vdd) and analog
>>>>> (vdda) power rails.
>>>>> This is inspired by the Linux driver [1]
>>>>>
>>>>> [1] https://lore.kernel.org/r/20250213094338.1611389-3-catalin.popescu@leica-geosystems.com
>>>>>
>>>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>>>>> ---
>>>>>     drivers/usb/common/usb_onboard_hub.c | 4 ++--
>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/usb/common/usb_onboard_hub.c b/drivers/usb/common/usb_onboard_hub.c
>>>>> index 0c84c1fede03..4b96defc2d93 100644
>>>>> --- a/drivers/usb/common/usb_onboard_hub.c
>>>>> +++ b/drivers/usb/common/usb_onboard_hub.c
>>>>> @@ -278,8 +278,8 @@ static const struct onboard_hub_data usb424_data = {
>>>>>     static const struct onboard_hub_data usb2514_data = {
>>>>>         .power_on_delay_us = 500,
>>>>>         .reset_us = 1,
>>>>> -    .num_supplies = 1,
>>>>> -    .supply_names = { "vdd-supply" },
>>>>> +    .num_supplies = 2,
>>>>> +    .supply_names = { "vdd-supply", "vdda-supply" },
>>>> Is this an ABI change and does this break existing users ?
>>>
>>> Hi Marek,
>>>
>>> I've tested with and without on stm32mp157c-ev1. There's no breakage on exiting DT.
>> What about other DTs that are in U-Boot and possibly not OF_UPSTREAM ?
> 
> Hi Marek,
> 
> It looks like there are no users in U-Boot DTs that aren't OF_UPSTREAM, e.g. users seems to be in
> dts/upstream. Some of the dts don't use supplies at all, some just define just vdd, some define both
> vdd and vdda.
> 
> 'vdda' regulator has been added to the dt-bindings, as optional. U-Boot usb_onboard_hub driver get
> regulators as optional (e.g. check for ret != -ENOENT). So there should be no breakage here. Please
> clarify if you see some case I could have missed here ?

All right. Can you please make sure this applies to usb/main ?

+CC Xilinx in case they want to chime in, else I'll pick this up.
