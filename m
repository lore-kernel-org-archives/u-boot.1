Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E546C79FB7
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 16:52:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29978406A3;
	Wed,  9 Sep 2026 16:52:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M8qQbAsrATPa; Wed,  9 Sep 2026 16:52:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7493E407A8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788972759;
	b=Qf7yiYuEiMSFAnoRTdETDnujTl6PHdCbHtgcDB4fm4yJDPHjBjotBqnZRNPpjLVRGRO0
	 SQxv8k7pTZVKCU6ixP+B71ol5LPO+tVPOQVS4RMxDDhQDV4mRQYWfUwxjljVIzVcjrtE7
	 szzVXB2a7+Miudw/y/9YsUyRvD+sElROvh/QyH4M4xBaXOWBITZ+d2oE9+1ShsgImIaAf
	 agWcR6rnKU5HkyYwMFl9gk/WevoWMrOGwTlG71vICxgUjbwAtsFcMOphjWEGmi7neqlSu
	 IHRd1tQPwhyDCMHITtIGMOTFjsEXZ9KwnnNcwZwSv5iXu2RjMHHrATSR5JnnArdiiSA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788972759;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MukWavmNV9GCEOM0JQiMdvtokOSQGj2gJRAbD0WOJBU=;
	b=UsC4dTN8nZrCnb5xBJYchcHdubRPDWUDpt+pXVRsgtLLLJukiZI/tLMuy6xWR4CIWDAo
	 eqh9QN/EE08ZdEMfdedOEKihLj6bQ3l7zSg/X5EyeZyizf2uDjqUTriPIdcJ1YzBT1+en
	 4znOMeepezRkPM1dyZSCtL5lrhvMjs2STKhJ9l7EZCwAWPzehaRopNwTKoJOyd1ekSwxs
	 tb5ieYk1gE+Gm7OV2wioqOBiR+sRh9yEIK5ewtgIM9CcYiJGy0aH9z/r89jNnFTi6wc2M
	 kEzcvehPOJ8nIa1LqtZSuKyopVUwB8+68AqFdv1NDsaRGCz73fXkXLr4b31970Te3Uw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=hnaQWeNQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788972759;
	bh=MukWavmNV9GCEOM0JQiMdvtokOSQGj2gJRAbD0WOJBU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KxUNaaFUpqhxWNGZ07fKCHZ6inTWls3es1heoCtiHVi+W0yeXRXm2Sixd6gf0QIg3
	 9mWMHABrtkBdXeLvHqqs2Ks/YozyA1vbEBKGkUuKi0/rDkFofmNcf44JbyFLPRhs5H
	 FA0Aqz/+AFBsK8/b+fosu9qjtK31wig62sBX1VEY0dr4Vvw0LTXJYhsWdjsqB9cMuJ
	 w9A597L//IQFyftK9OLy0Gen4ue+F83dtQGt//zpSSd1T4Ah9xBYDUXpMhTRPmzw+1
	 l6kU+bt5YJYov7mqcq3dRSMJgHRBZe84hCC9uX7yekPoVGNDzT1FVLrNr/v+bKYoZI
	 v1bW+0SWeabKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7493E407A8;
	Wed,  9 Sep 2026 16:52:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DB8A32D2
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 16:52:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CCC10407A8
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 16:52:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jsxe3ZT1vtYc for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 16:52:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5FBCE406A3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788972757;
 b=XjiC1VuyvTC8GVul9eBktxXW46mjVueUKJ+3J8Eb0I5P2MeqSwOrpjfjKtf3tCNY4kli
 pq6eVrtnbXGGvabvFRG82NOe35pouZANZ5WoyzVYTY6/chTQdcgfusk+dg+X8rpyrb4f6
 lUh4eYx0FhCMcpwQ1R5nyE+haznq8mESFskyL4JIegfgxN6YFEchHyvCwmX1H1Wuj5Nq8
 +2kzLjzH3jKx3eCOW1tdfTM8+1NDDAbfit5JN/x970rMn0U7uYEjwieaTjwYloJnKIJI8
 R2xjPqlfHTS+2J3qFerJs9BU2ipOwEQJfiaebsxxyNDSD96O4k7mpoI+d7p+2OdrEKg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788972757;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=MukWavmNV9GCEOM0JQiMdvtokOSQGj2gJRAbD0WOJBU=;
 b=dbQ+xf0mXyTaVuwmjydyBusMN9oBvT49N5UBN3ZpAsPnPB3+VzcxSfE52j/bmFx9QAGU
 31v/bd+Om5DlwuontfU3N/kIKzigw0ZYlJWr1CEXlVWZ/j+mSyjujq7pEoiVQAgOqHZ6j
 +B3WET2jSa2Kuw0Eift1SfzA3d69TK0voFBjNzXEOVOiz1c71vAbxS140e4SvWba9HySn
 VdhwfVlxbQ3/siQ8tlokgJ/xbAFIsSntTPG7oRs0R6iHu990wAte++MUqf/1I3nxYu57v
 ws/1eJbdLClZkHYWTZniAjhfsBQrrpIdnFH9f/PUXA8MOFwr5ennYqowTQ/IZHhzuQQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=hnaQWeNQ; 
 arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=hnaQWeNQ
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5FBCE406A3
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 16:52:36 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hg6L951Mqz8sYX;
 Wed, 09 Sep 2026 18:52:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788972753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MukWavmNV9GCEOM0JQiMdvtokOSQGj2gJRAbD0WOJBU=;
 b=hnaQWeNQEctpCBhzQjE2piXLAdOOqtAhM8MccS1SVEuhjRy+WWCxr3ZBi/9ZmVR4ND6K2H
 LeALmyOY3q/k4w/4ASodYMy+Q1cc+/8MfnKpBLlnwnaACi3oWy6qFcKbj7yyvKmhrFbC9E
 HVxTDLC5lihMrQ7o2AJXb7UVbJoWkU/PrAL8ZR9LXpZvv3hSeacQxuTCbQLmwFogT5/NOa
 YOIzLilkLN4LSc/Wj/rp3qZHB4YkygGQhqOzyu07+zGpMXPayF98bRfm64FdXny9sxEPlT
 HvMiDjazfSR300l/AjG4pv9WBqTEqsUwgjbQbOr8ihEDGuOQF14lgtwt5U6/sw==
Message-ID: <0d53d685-d790-4f46-90e1-6acd673a73f7@mailbox.org>
Date: Wed, 9 Sep 2026 15:25:10 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/2] usb: gadget: mass_storage: add SuperSpeed
 descriptor support
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini
 <trini@konsulko.com>, =?UTF-8?Q?=C5=81ukasz_Majewski?= <lukma@nabladev.com>,
 Dan Tran <Dan.Tran1@synopsys.com>
References: <cover.1788488867.git.Thinh.Nguyen@synopsys.com>
 <0103125b2e7e1a942202eea2c7222ab00d6857ff.1788488867.git.Thinh.Nguyen@synopsys.com>
 <8d741110-05eb-4861-94b9-19ef27c9ce2b@mailbox.org> <aqC8hnAHrQ8Cv3iR@vbox>
 <f5107afa-7202-4116-b02d-29accb4d7617@mailbox.org>
 <87zexq6bc0.fsf@kernel.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <87zexq6bc0.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 8cj4nor5w6nozjtb79hxkupr1hro6eca
X-MBO-RS-ID: 8f907b3dd8da6cb7995
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 9/9/26 11:08 AM, Mattijs Korpershoek wrote:
> On Wed, Sep 09, 2026 at 04:20, Marek Vasut <marek.vasut@mailbox.org> wrote:
> 
>> Hello Thinh,
>>
>> On 9/9/26 3:58 AM, Thinh Nguyen wrote:
>>> On Fri, Sep 04, 2026, Marek Vasut wrote:
>>>> On 9/4/26 4:29 AM, Thinh Nguyen wrote:
>>>>
>>>> Hello Thinh,
>>>>
>>>>> @@ -2709,6 +2712,27 @@ static int fsg_bind(struct usb_configuration *c, struct usb_function *f)
>>>>>     			return -ENOMEM;
>>>>>     		}
>>>>>     	}
>>>>> +
>>>>> +	if (gadget_is_superspeed(gadget)) {
>>>>
>>>> Nitpick -- you could invert the conditional here and reduce indent:
>>>>
>>>> if (!gadget_is_superspeed(gadget))
>>>> 	return 0;
>>>>
>>>> ...
>>>>
>>>
>>> But wouldn't that deviate further from the original Linux
>>> change? See:
>>>
>>> 4bb99b7c82ba ("usb: gadget: storage: add superspeed support")
>>
>> I think we are past that point and the U-Boot code did already diverge
>> quite a bit, but if this is pulled from some specific Linux commit and
>> you want to retain the code similarity, then please at least include the
>> aforementioned Linux commit reference in the commit message.
> 
> I've been (over-)zealous with keeping the code similar to the Linux
> commit.
> 
> Sorry if that was a problem.
> 
> To me it looks good this way.
> 
>>
>> 'From Linux 4bb99b7c82ba ("usb: gadget: storage: add superspeed
>> support").' or something along these lines.
> 
> I can add that to the commit message when applying.
Please do and apply, thanks !
