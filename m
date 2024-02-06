Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2598FC48297
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 13:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 980B687CBA;
	Tue,  6 Feb 2024 14:56:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="EmxsBnX8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1059387BB5; Tue,  6 Feb 2024 14:05:48 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by phobos.denx.de (Postfix) with ESMTP id A67A68646E
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 14:05:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jhb_ee@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Content-Type:Message-ID:Date:MIME-Version:Subject:
 From; bh=C//NB5ISYdeeCTG1+i32eVCXx6q+4IBciszUOf/aTBg=; b=EmxsBnX
 8/fMK3i8Y19wyS35zjoNBr0jXGhhNkZqL4XgDvJ54UsQiSXGZ66ikMHangW2VPyM
 eRaN/HpN512aiUJ5WlXGLAZ+I+uTFbA7CBymm6KU5XA7v3RLyEAIeyWJ+WUaM+LG
 dTzLEA2AiT6D8ihxvbBjVGd1HKpfHpfZlmto=
Received: from [172.20.10.7] (unknown [106.125.109.142])
 by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wDXv3udLsJlYJpOBA--.41958S2;
 Tue, 06 Feb 2024 21:05:34 +0800 (CST)
Message-ID: <5cd09ba8-49a1-4ed7-8610-c62097caa45e@163.com>
Date: Tue, 6 Feb 2024 21:05:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xyzModem: Correct xmodem blk verification conditions
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com
References: <20240205065850.7556-1-jhb_ee@163.com>
 <bd80e95c-b2bb-4ff2-8943-7a185a310546@moroto.mountain>
From: jihongbin <jhb_ee@163.com>
In-Reply-To: <bd80e95c-b2bb-4ff2-8943-7a185a310546@moroto.mountain>
X-CM-TRANSID: _____wDXv3udLsJlYJpOBA--.41958S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFWxWrWftrykXw1UWrWUXFb_yoW8Ar13pa
 yfK34xXFn8u3W3Wa18Cws7CF1Yyr93t398Ww12yryfZ398W3WvgF47KwsY93yxK3y8uF10
 vwn0g3ZIkF1jva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zMSoG9UUUUU=
X-Originating-IP: [106.125.109.142]
X-CM-SenderInfo: 5mkesvrh6rljoofrz/1tbiYR98fGV4G7zqiwAAsl
X-Mailman-Approved-At: Tue, 06 Feb 2024 14:56:52 +0100
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

It may be that there are relatively few people using this function, or 
the length of the transmitted data is less than 128byte * 255 byte, so 
the triggering conditions for the above problems are not encountered;

I actually discovered this problem during testing. Continuous 
transmission always fails at block 255.

The following is the protocol's definition of blk cblk, cblk = 255 - blk
The original content of the agreement 
(https://www.menie.org/georges/embedded/xmodem_specification.html) is as 
follows:
-------- 3. MESSAGE BLOCK LEVEL PROTOCOL
Each block of the transfer looks like:
<SOH><blk #><255-blk #><--128 data bytes--><cksum>
in which:
<SOH> = 01 hex
<blk #> = binary number, starts at 01 increments by 1, and
wraps 0FFH to 00H (not to 01)
<255-blk #> = blk # after going thru 8080 "CMA" instr, i.e.
each bit complemented in the 8-bit block number.
Formally, this is the "ones complement".

<cksum> = the sum of the data bytes only. Toss any carry.



在 2024/2/5 22:25, Dan Carpenter 写道:
> On Mon, Feb 05, 2024 at 02:58:50PM +0800, Hongbin Ji wrote:
>> When the blk sequence number is 255 and cblk is 0, the original XOR condition
>> produces a result of 0,and the judgment condition will be unsuccessful.
>>
> This code is 18 years old so it's surprising that it's causing an issue
> now.  This was added in commit f2841d377060 ("Add support for ymodem
> protocol (loady command). Patch by Stefano Babic, 29 Mar 2006").
>
> Not just 255 and zero but any time "blk == 255 - cblk" then your new
> condition will be true where the original condition was false.  Is that
> really intentional?  Is this from reviewing documentation or something?
> What documents?  Or is it from testing?
>
> regards,
> dan carpenter
