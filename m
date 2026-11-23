Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B7B606A31F
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 05:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EI+mr67C;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=FSVRbY9E
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA8F880BCA;
	Mon, 23 Nov 2026 05:08:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rno8doVS2PfQ; Mon, 23 Nov 2026 05:08:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DAA4180AEF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795410498;
	b=ePW6mpwIlG25eKYHnuqSh4MVJxW25RAKD6s4aezi2+jbe/P/Jnm4xIWm6OEc2KPd7q+h
	 gG/RKsJeTPl2i09zhxZj99XGaL7i/VbnzXHfQTMBih2R24tTnpofKNWQZ5AOxKoaw4u53
	 /3ZbfIE38CI+eOYmqpsFIES/w4Oqa2nMu/vv+SaeP85VIkleKHC2kc+vf7LggJamIP23Y
	 sSkDqkaXxRrJbsLc5rnAYOwzn80xkS33BpIlFVS8i/tI+GHD3UMUtE9Iq2FcqfPzsGa6t
	 qX4CUEMeHxrkGR+hfpQzaH0O5xs3KB10M4fBneHO6kKNOGyF7mrwS2k9HCvEX4pUwXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795410498;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pPvWqRxwesnyHzUaa6b2ZE7fkhgt/oDZcp60UeKX6O4=;
	b=Un5d379/c0cCm5bl4DXXbvBRIgGaeLTZoeosR+oG9WlPJKyYqjzU7mxBtnk3ME6u2o6a
	 NFGJ25njJEyOZbMNEwdetNujkyNeYuhmSDDAqSukrhr5BmWmO33Ihy9v3Q4AX3CXvGqzW
	 upfivJo/prOJaZBPz2LOE2fb+mYyAIYwUQuipX1hjFSNkwNz5kGvFEOtU3ngEw/56kEjW
	 mOsAP6hQDke0OD7G5HuDNBs9rXNByXq7SVq6jfWdbAKQqSz66lfA4sz53X5EBKGDjGBCz
	 WvRveAjO/bXOxfD4OgeXqpWP2eEAiXZSvOwrb2Sqkt0A84UYky/HdR0r06eI3+ieyUA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795410498;
	bh=pPvWqRxwesnyHzUaa6b2ZE7fkhgt/oDZcp60UeKX6O4=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EI+mr67CN/gMK2mvdiADBDDbyNs0n7r/955uoTiqmQEeN6sYFL4Slo3RWYoCneyqP
	 nDooG3eXMFQoI5d8OgB0OFTyhyw5Bv4fyc+yk0Y/6YrWpLtKTJRSCQv2HSVaLZAHgO
	 WN3cCuWwaadvpz5u1dAD4+cW7qvawLGSW/r8+njc5rYFSBDVe2/+XdqFE/nmuQhOdp
	 ADR/BYvqLclUGDoLSBLUqCYCMRmzL+huW03YvyE5sMfm8kvFcmZGZWgxuzk7cLr9w8
	 VAyauBY5LaopydgjDMnyjp8On0xw2OdytF1wDy8wfv4JsVTTeJYkKHiiAZijXrreHb
	 RYAKXdRM5Ip5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DAA4180AEF;
	Mon, 23 Nov 2026 05:08:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 037F2392
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 05:08:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E9616401AE
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 05:08:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t_czlIqid0QQ for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 05:08:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8B1A0400FF
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=FSVRbY9E
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8B1A0400FF
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 05:08:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C32D510FD26; Mon, 23 Nov 2026 06:08:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1795410489;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=pPvWqRxwesnyHzUaa6b2ZE7fkhgt/oDZcp60UeKX6O4=;
 b=FSVRbY9Ecxz7V/F86m5zXOu8G/z8M9WjfAqMNT5C+MWGAyZ8D45POE3y96YoPnW1Eqzxrw
 ONtn+N4ECZHXrEGSgS/HEhfzltp7F6KGcJa/R0VXWkbsDmATsUsqR2Hsko9rcyxQPgwFUq
 wByapHjm7JO1V4s+ycGEkNYa9CtDt3OYWsMkOcPqsfb4oCrTD0a06QlXQznoQVqgxtPyCM
 DuATWxv/pAb4blI/m5dg78cPpw+zBV2qriHb4O4IXlCI9FaUW0FuOtq7di9Z4PaAR4sJ3P
 g3GDD+6qIRLf/6//HC4m/P22qeMosT45Hm1NPXze3iWCgM69g9kRuLqS+0sRYw==
Message-ID: <12a1d6ee-09df-0f58-1302-e37b53bd3f7b@nabladev.com>
Date: Mon, 23 Nov 2026 06:07:58 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tom Rini <trini@konsulko.com>
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Pranav Tilak <pranav.vinaytilak@amd.com>,
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>
References: <20261106031830.13625-1-alif.zakuan.yuslaimi@altera.com>
 <20261106031830.13625-2-alif.zakuan.yuslaimi@altera.com>
 <3057eb46-25ff-a3d4-41ed-3a776a9fe117@nabladev.com>
 <PH7PR03MB7063F9CF29F3C42A54895CAAAD452@PH7PR03MB7063.namprd03.prod.outlook.com>
From: Heiko Schocher <hs@nabladev.com>
Subject: Re: [resend 1/2] i3c: dw: validate device index and clear slot on
 detach
In-Reply-To: <PH7PR03MB7063F9CF29F3C42A54895CAAAD452@PH7PR03MB7063.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Alif,

On 23.11.26 03:00, Alif Zakuan Yuslaimi wrote:
> Hi Heiko,
> 
> 
> Altera Confidential
>> -----Original Message-----
>> From: Heiko Schocher <hs@nabladev.com>
>> Sent: Wednesday, November 11, 2026 4:48 PM
>> To: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>; U-Boot Mailing
>> List <u-boot@lists.u-boot-project.org>
>> Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>; Tom Rini
>> <trini@konsulko.com>; Pranav Tilak <pranav.vinaytilak@amd.com>
>> Subject: Re: [resend 1/2] i3c: dw: validate device index and clear slot on
>> detach
>>
>> [CAUTION: This email is from outside your organization. Unless you trust the
>> sender, do not click on links or open attachments as it may be a fraudulent
>> email attempting to steal your information and/or compromise your
>> computer.]
>>
>> Hello Alif,
>>
>> On 06.11.26 04:18, alif.zakuan.yuslaimi@altera.com wrote:
>>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>>
>>> dm_i3c_read/write indexed master->i3cdev[] without checking the device
>>> number or a NULL slot, which can crash on a bad index. Reject out-of-
>>> range and empty slots with -EINVAL.
>>>
>>> On detach, clear the matching i3cdev[] entry so a later transfer
>>> cannot reuse a stale descriptor pointer. Leave num_i3cdevs unchanged
>>> so the existing dense listing path keeps its prior meaning.
>>>
>>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>> ---
>>>    drivers/i3c/master/dw-i3c-master.c | 15 +++++++++++++--
>>>    1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> Reviewed-by: Heiko Schocher <hs@nabladev.com>
>>
>> @Dinesh: The patch is applied to me in patchwork, can I move it to you?
>> (Please send me your patchwork username, thanks!)
>>
>> bye,
>> Heiko
>>
>> --
>> Nabla Software Engineering
>> HRB 40522 Augsburg
>> Phone: +49 821 45592596
>> E-Mail: office@nabladev.com
>> Geschäftsführer : Stefano Babic
> 
> Dinesh has already left Altera and his Altera e-mail is no longer valid. Are you able to help to pull this in?

Oh, thanks for the info, that explains why dinesh does not respond...

I cannot say, if Dinesh is still interested in maintaining I3C in U-Boot...

The 2 patches look good to me.

@Tom: Do you habe some infos about Dinesh?
       I can pick up the patches through my i2c repo for "v2027.01-rc3" and send
       you a PR, or of course, you can pick them up...

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
