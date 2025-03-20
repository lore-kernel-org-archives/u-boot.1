Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FABC28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 14:14:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA6F180540;
	Thu, 20 Mar 2025 15:14:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742480049;
	bh=R2s7cD1QygNZxHXG26AOa0TNTkLG/VHPchhKUc9EBd4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jke1YUpseIWoKojHS/TC6bEjKRMXnyZ2Tlt+HcAK6J6bWFUJdkv8mZfAj6Dz09lVq
	 MZUAdSRGS5O0ukwMPph0eWctQEosqGXEVMzbyDLBS8kkBpHGwZjGqsN0J+PIGnSZYV
	 LLdDSeRYjFsZf6hUdjgap/wuA5lV/Ti+VWGpk7Bf8va4QdO3zTsqduU98Hy1zxkLbf
	 SUfl+cB2lUO5eOWu6NQ7CmYNAJj+JQ8bN8mDn9hwph/Glwi1w4igbnd1tPdruQD7XV
	 KH7Jr1LMIEG7QFFuf+aByMkgQH06aoerBdkiZoOapPBSlVCnPlX4f5wksixi1SciCj
	 lfDkwVewghJYQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E373806FC; Thu, 20 Mar 2025 15:14:09 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B0488003E
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 15:14:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="aV755Z33"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2DDE010204043; Thu, 20 Mar 2025 15:14:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742480045; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=R2s7cD1QygNZxHXG26AOa0TNTkLG/VHPchhKUc9EBd4=;
 b=aV755Z33I5NqhMo7TCTSU287DjF57oXDBeKxPOtsA1S4PpDT+eTtk9I23YOTxa01/PhOoJ
 lHWBPttEc9JTyTdpPvUaaUBMDZ4NRXUIgNCAbHn+rATFD+Ij4fc/oBloV72enQd5q/oDxo
 bmO0e5N6Eso/+IVlDcfY//94kJrM/Xn2LtrN7tN94ecW3Uxw+DxPhMCqwqdb/da5/ZzEnG
 vGLQRaREXxkSisui92OtEKyPmApjPjfoIFmUbz6Jcya4YZx9WXCJztfVgPZKe9yIH/kYD5
 xPmBflfDFFag3WoXC2yfzsNQ4+EEgBs2h2QEiRlZuVzutftYH8R4x/xf6OyPRg==
Message-ID: <513b3e03-72d6-4997-8fb7-ca5d8a530097@denx.de>
Date: Thu, 20 Mar 2025 15:14:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tiny-printf: Add support for upper case hex values
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Benedikt Spranger <b.spranger@linutronix.de>, Simon Glass
 <sjg@chromium.org>, John Ogness <john.ogness@linutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20250320102346.13564-1-cniedermaier@dh-electronics.com>
 <a6ab86ac-4404-4081-8529-b8d11b37b5d2@denx.de>
 <ab32ace5-efc0-41b9-8d13-292f6f87835d@cherry.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ab32ace5-efc0-41b9-8d13-292f6f87835d@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 3/20/25 3:00 PM, Quentin Schulz wrote:
> Hi Marek,
> 
> On 3/20/25 12:49 PM, Marek Vasut wrote:
>> On 3/20/25 11:23 AM, Christoph Niedermaier wrote:
>>> If tiny printf is used with 0x%08X (upper case X) the output is
>>> always 0x00000000. It could be confusing if upper case instead
>>> of lower case is used intentionally or accidentally because the
>>> actual value is not output. To avoid this confusion, tiny printf
>>> is extended to support also the formatting with %X.
>>>
>>> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
>> TINY_PRINTF is meant to be tiny, i.e. not consume a lot of space, at 
>> the expense of functionality. This is meant to be used in size 
>> constrained environments, like the SPL. If you need full vsprintf() 
>> formatting support, disable TINY_PRINTF in your config and use the 
>> regular vsprintf() implementation.
> 
> The issue is that disabling TINY_PRINTF may not be possible (size 
> constraints) and some code is compiled for different stages and people 
> typically don't check whether the format used in printf is valid with 
> tiny_printf. I've had this issue already in the past, I vaguely recall 
> "complaining" about it on IRC.
> 
> Maybe there's something we can do to verify that the code is working how 
> we expect it to work, regardless of tiny_printf/full printf selection? 
> checkpatch or a compile-time check for the formats maybe?
> 
> But yeah, essentially the whole thing is... if we continue like this, 
> we'll just end up getting closer and closer to the full printf which is 
> not something we want :)
Shall we maybe patch tiny printf to print '?' on unsupported formatting 
characters, or outright complain that users should fix their code ?

For the %x/%X thing, we could technically fall back from %X to %x , 
which would do the printing with minimum footprint increase, albeit 
slightly malformed:

diff --git a/lib/tiny-printf.c b/lib/tiny-printf.c
index 0503c17341f..48db7b1f78f 100644
--- a/lib/tiny-printf.c
+++ b/lib/tiny-printf.c
@@ -284,6 +284,7 @@ static int _vprintf(struct printf_info *info, const 
char *fmt, va_list va)
                                 islong = true;
                                 /* no break */
                         case 'x':
+                       case 'X':
                                 if (islong) {
                                         num = va_arg(va, unsigned long);
                                         div = 1UL << (sizeof(long) * 8 
- 4);

