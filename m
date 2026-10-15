Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5240FCC6B38
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 23:47:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0DFFF607D8;
	Thu, 15 Oct 2026 23:47:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GDOj912BD1_R; Thu, 15 Oct 2026 23:47:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6397760AC5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792108075;
	b=XL3ZxiR+NQ9Bv8Bj/HYQh8+jtkfvyv5I4wMzP5vY2c1rByxb024j5DRT378et9gRvKIm
	 COzARUl5bRah3vN9gtD9cMyo/CiqcLgJ0vH1+d121l1h8zHWk84y95YF76eKKX9667c95
	 749mUjFm6pNKXzgHXe4dChFbGUhLtcU8/YVntf8cRHK8/iL5RuZ1cbzRUOVGrhF2i+5x2
	 wZzzI6IO0vd0KtjDu3f7VU6E8ahbrWZl/EWQWfs2vu7j5u1Aiffp4Y7uwsHXKxuRamz+q
	 ro0GEYqPOkA7ohxlH5j/zYJz40XJEUPicXNGU9BKUCg1Kxlb3dnZ2brJuyPofwWfuVQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792108075;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Z3GPiSZuvtCY7Jfag6rozyl1po5HHjrolxWLL9Dv4WQ=;
	b=gV1hx+aI6TlXstJxHbqI71eJbSfy90degmWeDibmWUFt64QXLDpYhgNzrg/GGLEEB+qU
	 OSJSPC2P6sgQXSgHOdltOXFvbLuw/qQM91itM68YhRuTkwHenhBkunBnyeHzT1aogUViL
	 I9ql8qQOVJTxxgA2NX+dr+jk1nLInUoXpYvsx0oAwYBSS9aU7RLYZgDw6OeJ99crRb/5b
	 9pvuHlEvVU3uviEJCvbMj6KUUuLtKd7jxzmiNErmTK1eJoI+i/NCp/jwlA2j+tlEtEEIc
	 a/531ImuhkDjr1G3SxV3R1Jp/PL5doYXOuWQDymas1KSc222ckyCkhnHR4ssBf5S6Lg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=ZsOvEugV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792108075;
	bh=Z3GPiSZuvtCY7Jfag6rozyl1po5HHjrolxWLL9Dv4WQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KL9Ib0zV4/VGBGYj+JoV4BL8Sd3AWt2gPIklJ0TIaHp3sK/17TKaD8izV2BGBtcjP
	 FYzvrIgzxyj1FvPJxDQ9+K3i6s/Nh1BsVOmiL5iFNP5jXopds+CyeHzYjGlzI4ywxo
	 R12ivqIINY4/UJLjDmx1YLC4xpLKTkUpJQHUpdgz+/801qzVw3Y/YW6lOLxyb8klBx
	 mBt2rG++yzUZNeSQVn2TRusrGouIkqf82TlixHgXKTN6OLAFaCyeDyNDyesv36S3ff
	 aXcW4HOBRAGb8oAEjRFi/hHIIcdFLg9iLHFJC78yY8ZeqZbpMw44OpJvGt6hJw/PUI
	 Mt/fkk9e7Tdpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6397760AC5;
	Thu, 15 Oct 2026 23:47:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EFE59362
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 23:47:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E208A60ACA
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 23:47:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AiJPNo8_1MzB for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 23:47:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 07BC660AC5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792108073;
 b=nnK5RJVfI25XF0LKq1nHeZ5wjO6zNEs83x2E1rZajvC3F1yqmD6zLn9S2VA/a7BZfDaL
 +VNoWBLFVGbuvEaaRgzrhAO/l60PUpxGvtFtSRi8rDJIHyu3iWUOCBa75EHooSoi73lok
 3uBt5q4JE2u/LNsl0CT+3eLEL7ev3ugFoELsDrNQl3jqUjrQAUsZhfYpXBXKsWnL9XTpb
 uDXQqo1XR9qzZVaoSigtvCqxNJN6n6Mm0FA58XpaNxAWNevLjtW9JN6Io5gd07xwnFEdn
 /Dl8PcNqM+oQ/ai3KFskhZJ/crtbuQf426F92YOGJn1hHa8SfhxvVSjHfpxRxN/3rYw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792108073;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=Z3GPiSZuvtCY7Jfag6rozyl1po5HHjrolxWLL9Dv4WQ=;
 b=ODYlhaoZb+i0EzFC9B1pknKyfLQallGFqks5TrAYCeyxpoBFr1aok7eMt1R/DhKoP2z2
 xzW3rCFhAXzBXU4TszcvV5K7pxdxFCKOi1M3zo3miJ8Q1D5A6u1tDFBJtl6rx1MKIJWd9
 fEo3VwjPr5xcGdGcrZr00t5ki3x6F4fypNWbulvwO8IwemSroGlAASf2YXGL7HlBEP/j1
 hTCQISkQeN6n3mCcOXDgPuKKLbuk/+COvLmcooEFojuTi2ZQ5e2/zoIQj3jb0MAu3LgaC
 umXwbxD1Og5pYlDZ9QLAVdSJvwKRftK0HfrI999Scbs9j1MwW0rx04lWFGyTeaR1ReQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=ZsOvEugV; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=ZsOvEugV
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 07BC660AC5
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 23:47:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B57D2108121; Fri, 16 Oct 2026 01:47:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1792108066;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Z3GPiSZuvtCY7Jfag6rozyl1po5HHjrolxWLL9Dv4WQ=;
 b=ZsOvEugV7cM+/ZEhTd86UR7MlcJsSHHkO58aGeXUnTu9svroHq+I6AEzIvHI2rBrDBo6H6
 fqIrCcgDNEqS2c+zRud0mFLDV+RfquVNOG5Nntr51wnKeXIDmH6xqHN8EqgCm0EZniG6Bo
 V3DgOgg0TNseUp9PwYbBLI5LtXll8BqZMyeAG5/UrsOQgqx7VyiYGP9NXxPIhIIhPYv11M
 9L38zUQYmNURk1kqlnfYXSOmlpi8XfszqN0we7+JThbPQS91hkdPbGHAltKIl5eDvMVvO4
 hEJIlLwf6SGZcKDw0n6vlTC4u70mb3Cha0bfiWBK2jFLyLZoJPcb9DzQV4smJQ==
Message-ID: <c532672f-8ff7-4e80-8f78-0140bdcbd434@nabladev.com>
Date: Thu, 15 Oct 2026 23:17:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: stop generic OHCI and EHCI at OS handoff
To: Tom Rini <trini@konsulko.com>
Cc: khaliforce <kforce@gmail.com>, Romain Beauxis <romain.beauxis@gmail.com>, 
 u-boot@lists.u-boot-project.org, Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <179128521948.5.12131679420803093421.uboot-usb@gmail.com>
 <3ae0a18e-0fa5-477d-bf5e-89072b9634ba@linaro.org>
 <20261006155833.68374-1-kforce@gmail.com>
 <20261006161015.GB1356209@bill-the-cat>
 <e4661500-74e4-4bed-b09a-a54d24eb6062@nabladev.com>
 <20261011220316.GJ769217@bill-the-cat>
 <489e6811-cb25-4085-8077-427100154182@nabladev.com>
 <20261011223137.GK769217@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20261011223137.GK769217@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 10/12/26 12:31 AM, Tom Rini wrote:

[...]

>>> I believe the answer there is that we have flags to handle this problem
>>> generically rather than hard-coding a call in every arch's
>>> boot_prep_linux or similar like we had to with the old USB gadget stack.
>> This is shutting down host, not gadget. And I believe usb_stop() is
>> necessary to correctly shut down the devices on the USB bus, while the
>> DM_FLAG_ACTIVE_DMA flag is necessary to shut down the controller, so both
>> are needed.
> 
> Host or gadget isn't the point here, it's that we used to hard-code the
> stop function call for the non-DM driver and now we have driver model
> and flags. Everything should be able to properly unwind with flags being
> set.
So what needs to be tested is whether the flags are enough to properly 
stop devices downstream of the controller, or whether we need something 
more, possibly equivalent of "usb stop" in the USB uclass pre_remove 
callback or some such thing.
