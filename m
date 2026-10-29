Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3AF606A31E
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 08:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uGeb/DOi;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NAmpuovN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2B7B606C2;
	Thu, 29 Oct 2026 08:04:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C4GpnAaJDCfx; Thu, 29 Oct 2026 08:04:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 084636069F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793261047;
	b=mgeLiez4xo9T4+M+w8Cw8gTQZPP/PhYJXG2PR/F1mv26y2O50VIhiOi0yEibIqArG3k3
	 f/UZOLpgUfBS7oTpVlUK0DPB5j/y5JgqiUHw1KlrFwYqLOO/0bntyqdd/IcFGBwBLvTFQ
	 uL49LgI3eVE5jsHtNI8yoCi31ukFeZLyh0M8iKOeoJPls0B07MR6i1f8nI8GjbqXHPNN5
	 oaME3mhd2j2BtRE9YIeUbwmNom0qSgufS56MvmeH+lLlL51DqSqU3PLDCw4OayPuj7Ltc
	 LhzL9Lssf7aR8sJ0Cpnuxcw1yEyShUDGmT85GpZgfN/4WISxP6zywkxL1JI4En4G6hA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793261047;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gEa+8WhhllhBVNAszCoeyBtxn2+pi2IlpxufshX+HiU=;
	b=Dxu76TW65sPxGvHNwCcOnk1NEJXycQ2TPLcZYf6f0n7WGjOR7Tdm39AchFnRMG8K+tNL
	 5fDozDPntiLMeBsnWWKRwaO2LljW5iUdQhUa2+l44k5MMYh0LG48Ay8ZcSSekdvEFc436
	 Q1SwmSoBxzpEOb3jaxwTqFS+R4RUBXq9wje3aCX0XUW7/hLSPEJ++m0iIYvhL3CIhxri4
	 qbcMaQhdQvJhFa0560e9auAV2A5k/szEpkGqNbcZD2N1JJTqBllwOMTbGLb1+u2f1M+Px
	 gL1BjMU6YZ99Nw4BOzWAP0ovplyXGvCqPDmU6kBV0LfxiY6y+yaWSobYXvUwwA8TsrQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NAmpuovN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793261047;
	bh=gEa+8WhhllhBVNAszCoeyBtxn2+pi2IlpxufshX+HiU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uGeb/DOikHsWeOdMaAeLuIhl0BjuLhUTs44FYVDnvjFm+rnsmModsfXq1MeKA1hkq
	 2/nxC1bK6aUWi/DTXc7YWUCEGU8IZaYYhn2jyiRExVHtlbde5+951FNVV6c/P4gWGR
	 EQJREdzrlmcH5tXSaNC7x83hfi8QEK8hPkae+c2k1geTJPLq4xpcgK8k9DY+X1qNrz
	 zgdrL3hpg9odv1aha/3DEKLIniWT6QFinX2ISGJGE6BqdBkHozFvcIcVUaFaLq5lRv
	 GnGZACRXuKB8t4G8Bgp+xMABNrJXZFnqCjnQWypwe1+p3VTupHsbqe5oswvBpzWzrC
	 O5gt2N1maXIRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 084636069F;
	Thu, 29 Oct 2026 08:04:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F7B72FE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 08:04:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 554236069F
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 08:04:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FauQNTUbtdpY for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 08:04:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4D56F6066C
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793261045;
 b=h0F2sdrSlkBxG782svyYvY3fFgY1+yfnyeFHEyrLJvQBEiMIyvelhhoyPGOQA9RO6ehU
 WcALI3wAj+/buUkXnAYkHiJZ4lSIdqZYHyfjmG0M4ddsXdEoGAOOLjefOeyymNB1fYm00
 mN7dYCIJKQUjw/g61nm78vm7/z7znaAvr+ZgXYnu75S2ra7ddBNbLolb835abhQF0MMU4
 dr9HlMnWTALBPxTRXkzdz0JBufJ5J0YVUN7Gym5yb/1MJKMH4zDPr+N3AGboaEdJkl4O4
 7tnICugc2uG4XTpu27DAbwXDPkAtxbpbgVyBExMhsCDHH9yztUcBs0wluiuwuf8eyQQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793261045;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=gEa+8WhhllhBVNAszCoeyBtxn2+pi2IlpxufshX+HiU=;
 b=g1ooQr3kKoNoY6LIECbP2Y4dcQnPxn139HFEUL5IYOMvFhTEfqVaIkhcB8f6cm04OU8E
 a3SvQ4nezRcfLAMGT7sDdTfz30g+QGa4gtXAO7beTj5bOOE+wkaSo/luiwCMlNU1XwWfX
 zy/X7PXHSvePNiicnhxmnQi7NswyzQT09QFvTLhHCKlVsnm+iblf8wb5WRfU5oMskoD7L
 65jKIpMKlOdAc6SzI1LF2pZWlZ/LZ80pdkmZjRKI/TSZfkwLqg2MkDFLVlnedjD82P2kK
 EhVQVToJbJ9DnBUnLe1LX6CDFuarQOnGq3YXC4cjek/swzyHYaeXo4g9+tSTs8Q+QHQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=NAmpuovN; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=NAmpuovN
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4D56F6066C
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 08:04:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0058E600DA;
 Thu, 29 Oct 2026 08:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387BD1F01825;
 Thu, 29 Oct 2026 08:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793261042;
 bh=gEa+8WhhllhBVNAszCoeyBtxn2+pi2IlpxufshX+HiU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=NAmpuovN2Sf/73LLfBJtaXnAmJ5UMk1ucb1TvPzBbS1Mwy8to9YGbUAE3G5HFC/44
 N7Aekn87+TtJCF3uI+C0sJlopH+EAmmjww95jtfEKrL8hBkDAqp1bULF603NrhUKNL
 IwIMYqc70voaFk38YWvAmjz8rzvcVOCp9RTPsQAftziMyLXidB+k8CHHtqayGxn7Xu
 ukQt9xrH+VoIdHfnaxEm771toAQPZl1mOkkkMVM//E88ieNw6g765LQwIF5BZRJ3l+
 W2F6+kPR8i8kR8Lx207vxfX8T5xj+cc2SC+0ym7RIYGqEtuJ7F2Hp3fyGxLR9l4b+p
 6rvQNVOv8tmwA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Chris Morgan
 <macromorgan@hotmail.com>
Subject: Re: [PATCH] Revert "drivers: usb: dwc3: Add delay after core soft
 reset"
In-Reply-To: <b03aa068-c69b-427d-a50d-b5b3ad391cf4@oss.qualcomm.com>
References: <20260724-kodiak_delay-v1-1-57b687e6d67c@oss.qualcomm.com>
 <87ldb07bdb.fsf@kernel.org>
 <b03aa068-c69b-427d-a50d-b5b3ad391cf4@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 09:04:00 +0100
Message-ID: <xhkdb5wyl2arz.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Balaji,

On Tue, Oct 13, 2026 at 22:19, Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com> wrote:

> Hi Mattijs,
>
> Sorry for late reply.
>
> On 7/24/2026 7:12 PM, Mattijs Korpershoek wrote:
>> Hi Balaji,
>>
>> Thank you for the patch.
>>
>> On Fri, Jul 24, 2026 at 14:58, Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com> wrote:
>>
>>> This reverts commit 6de333b5caf035c38d7af9fa7596aeffcc49db42.
>>>
>>> The delay is unnecessary. Upstream Linux does not add this delay after
>>> the core soft reset and the USB works fine without it.
>>>
>>> Tested in QCS6490 RB3Gen2 Qualcomm board.
>>>
>>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>>> ---
>>> - This is part of ongoing initiative to reduce boot time across all
>>>    Qualcomm boards. So we can remove this unnecessary delay.
>>> - Actually, this delay was removed in the Kodiak v4 series:
>>>    https://lore.kernel.org/u-boot/20260418-kodiak_ss-v4-0-d381670c9d78@oss.qualcomm.com/
>>>    but v3 series got picked up: https://lore.kernel.org/u-boot/177745255938.126665.16625119085748603933.b4-ty@b4/
>>> ---
>>>   drivers/usb/dwc3/core.c | 2 --
>>>   1 file changed, 2 deletions(-)
>>>
>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>> index be198041f08..ae22e1c792d 100644
>>> --- a/drivers/usb/dwc3/core.c
>>> +++ b/drivers/usb/dwc3/core.c
>>> @@ -106,8 +106,6 @@ done:
>>>   	if (DWC3_VER_IS_WITHIN(DWC31, ANY, 180A))
>>>   		mdelay(50);
>>>   
>>> -	mdelay(100);
>>> -
>> The dwc3 driver is not only used by qualcomm, but many other SoCs.
>>
>> That delay indeed does not exist as is in the Linux driver since the
>> following commit f59dcab17629 ("usb: dwc3: core: improve reset sequence")
>
> Yes, this delay doesn't exist in Linux driver and the delay was added by 
> me in 6de333b5caf035c38d7af9fa7596aeffcc49db42.
>
> But found later that this delay is actually not required and hence would 
> like to revert it. Have tested the revert on QCM6490 and USB inits fine.
>
>>
>> However, that commit is more conservative by adding retries and such.
>>
>> I'd prefer to stick with Linux's approach here.
>>
>> Also note, there is an ongoing effort of updating the dwc3 driver by
>> Linaro here:
>>
>> https://lore.kernel.org/all/20260716134305.614278-1-anders.roxell@linaro.org/
>>
>> Could you maybe give that a try? It should have the
>> "usb: dwc3: core: improve reset sequence" patch in there.
> I agree the Linaro series is the right long-term fix, since it carries 
> the retry-based approach from Linux rather than a flat delay.
> That series touches a fair amount of the reset sequence though, and it 
> may take a while to land upstream.
>
> Given that, would you be open to taking this revert now as an interim 
> fix, since it's tested not to regress the platform it was added for?

No, I'd like that we (as a community) spend time to do the right
long-term fix.

Please consider testing Ander's series (latest is v10 here:
https://lore.kernel.org/all/20261028141554.3073545-1-anders.roxell@linaro.org/)

Testing on hardware is very useful and will help to include the long
term fix from Anders

Thanks
Mattijs

>
> Regards,
>
> Balaji
>
>>
>>>   	return 0;
>>>   }
>>>   
>>>
>>> ---
>>> base-commit: d7ef23c07b8e34f65b3e15e3b4e7f58d074923c8
>>> change-id: 20260724-kodiak_delay-a5f1e8b675cd
>>>
>>> Best regards,
>>> -- 
>>> Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
