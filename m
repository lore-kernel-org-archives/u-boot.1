Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E00C44512
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 07:14:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2ABA40743;
	Wed, 22 Jul 2026 07:14:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5xnm2FodwyIJ; Wed, 22 Jul 2026 07:14:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C115B4070B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784704450;
	bh=6b2HXaz25oz40i4qtCX5cnHkTRGkn0rLHSqaedTe5dE=;
	h=To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=f9NPbrTOj6HXLkohw5MGHcmiF2LkrYelxLpo9OX9oWGejHeNzZH9YXEtYdB7lIXVm
	 0pI2OjV2zEhFFFEuEH/Jw8j1etLGivyD9Bf26D3mMrLarXDbgKW8AZWZhuwpFFfjsa
	 cqtzdI6IYbttIG88KXmXSw4/h9BSzMe65P00KAgYxd08gPIEpeoBVgLYMpzVpRriOU
	 AmXBlxMmsw8wmMtW5v0FpIqH1r0r5Dqc5sHvWkOqv6Yy2erKJykXDlkEJKcCEHNXfV
	 soXvCxhDvD8cWer8q9jTeFFeZlKYaOBzglV2+JsL0e/j4dpqbBT7xQzDU0wnMTBH8I
	 kG5EiWCfUktWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C115B4070B;
	Wed, 22 Jul 2026 07:14:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 98F3E42A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:14:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8A689400F3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:14:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AIUIJ6eNS17k for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 07:14:09 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6B548400D8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6B548400D8
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6B548400D8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:14:08 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69C06848BA; Wed, 22 Jul 2026 09:14:06 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 377F5803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 09:14:04 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 19B0460A67;
 Wed, 22 Jul 2026 07:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522831F000E9;
 Wed, 22 Jul 2026 07:14:02 +0000 (UTC)
To: Ye Li <ye.li@oss.nxp.com>, Ye Li <ye.li@nxp.com>, lukma@denx.de,
 u-boot@lists.denx.de
Cc: festevam@gmail.com, peng.fan@nxp.com, uboot-imx@nxp.com,
 xu.yang_2@nxp.com, jason.he_1@nxp.com
Subject: Re: [PATCH 3/3] usb: ci_udc: verify all dtds are inactive before
 completing request
In-Reply-To: <adfa3625-6870-4bae-919d-f7c9ff6e44fb@oss.nxp.com>
References: <20260522075512.1291485-1-ye.li@nxp.com>
 <20260522075512.1291485-3-ye.li@nxp.com> <87fr2mhlxu.fsf@kernel.org>
 <adfa3625-6870-4bae-919d-f7c9ff6e44fb@oss.nxp.com>
Date: Wed, 22 Jul 2026 09:13:59 +0200
Message-ID: <87h5lrijig.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784704442;
 bh=6b2HXaz25oz40i4qtCX5cnHkTRGkn0rLHSqaedTe5dE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=esItvg3WoK71vUS1RPGhi20I3wkKHJHI7SgAgJKctHcSIRh+4vkhuHp0eXuhBf3Ju
 ZQdfBMx7Jc8aSkO1zekaXUUJ2DSmDi1BQdfATsUwDkr1U6wXSZcoHwaxmnFUPMU/GJ
 f33wFzGiFVldBc28k6F+QCtpAZ47CZ2CaBddKiKcWmQnmrQhYlycRE2bNIbJlPBryG
 MzY7dxCfBRxzgpYWTEti93Nf80xbQnTdO6NyhHoBz6/fKy/6kGfNdo3LKWJdzPxv03
 PA/pBf4KtxVjJhuesdocoeYMSgoRMwx4P8RDqT4G+CI3msIMcR47vfivAy1eVc9l75
 Rx8AMeA3WwE1A==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=esItvg3W
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="esItvg3W"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Mattijs Korpershoek via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Ye,

On Fri, Jul 10, 2026 at 17:28, Ye Li <ye.li@oss.nxp.com> wrote:

> Hi Mattijs,
>
> On 6/16/2026 5:30 PM, Mattijs Korpershoek wrote:
>> Hi Ye,
>> 
>> Thank you for the patch.
>> 
>> On Fri, May 22, 2026 at 15:55, Ye Li <ye.li@nxp.com> wrote:
>> 
>>> From: Jason He <jason.he_1@nxp.com>
>>>
>>> According to device mode spec, the ACTIVE status field of dtds should
>>> be check to determine whether the transfers completed successfully.
>>> However, this is not implemented in handle_ep_complete.
>>> When two EPs are enabled and transferring, EPa requests with multiple dtds
>>> and EPb request with one dtd. Irq is triggred on EPb. The udc_irq handler
>>> finds both EPb's and EPa's ENDPTCOMPLETE=1 while not all of EPa's dtds
>>> have been completed. Because ACTIVE status is not checked, this case
>>> causes crash in ci_udc driver.
>>>
>>> Signed-off-by: Jason He <jason.he_1@nxp.com>
>>> Signed-off-by: Ye Li <ye.li@nxp.com>
>>> ---
>>>   drivers/usb/gadget/ci_udc.c | 11 +++++++++++
>>>   1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
>>> index 0baad83ef90..53796887dac 100644
>>> --- a/drivers/usb/gadget/ci_udc.c
>>> +++ b/drivers/usb/gadget/ci_udc.c
>>> @@ -733,6 +733,17 @@ static void handle_ep_complete(struct ci_ep *ci_ep)
>>>   	ci_invalidate_qtd(num);
>>>   	ci_req = list_first_entry(&ci_ep->queue, struct ci_req, queue);
>>>   
>>> +	/* Check all dtd are completed, otherwise return for next irq process */
>>> +	next_td = item;
>>> +	for (j = 0; j < ci_req->dtd_count; j++) {
>>> +		ci_invalidate_td(next_td);
>>> +		if (next_td->info & INFO_ACTIVE)
>>> +			return;
>>> +		if (j != ci_req->dtd_count - 1)
>>> +			next_td = (struct ept_queue_item *)(unsigned long)
>>> +				next_td->next;
>>> +	}
>> 
>> A very similar loop (that walks all the dtds) is just below:
>> 
>>> +
>>>   	next_td = item;
>>>   	len = 0;
>>>   	for (j = 0; j < ci_req->dtd_count; j++) {
>> 
>> Can't we merge both loops together?
>> 
> This loop will free each dtd. If the ACTIVE flag is set in the middle of 
> loop, previous dtds should NOT be freed since this transfer is not done. 
> That's why we add a loop to check ACTIVE prior this loop.
>
> If merge two loops together, another list to temporally record dtds for 
> free is needed. Then have to traverse the list to free each one when no 
> ACTIVE found. This traversing will add a loop too.
>
> Best regards,
> Ye Li

Ah yeah, you are right. Sorry about that.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

>
>>> -- 
>>> 2.37.1
