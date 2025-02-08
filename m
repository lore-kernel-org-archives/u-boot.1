Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA704C0219B
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 21:27:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C467E80944;
	Sat,  8 Feb 2025 22:27:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1739050027;
	bh=rKi28rZ9klCKdk9uVt6mQ5tPs9SsOuZ/lDMSCsenhUQ=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fq6GPy1y1Z5E03BNbTr3VkdhBs4+GQnm1eMtiDiDrgIsixDbh1JcLOKJV3QTB0B8q
	 vIIweVEbV+HhkDM1SIVuLx23PH3GC9Wnp0qUIo9obyzGOXUfM1ZUAvlCuVf02TABFE
	 WKXojAA7lWerQ0I6UbM4e5Ule9HGOjRdkICdwfPIwaqOcdLLZWXUKMDGrVzxGHDlnb
	 PUu7DxZ52esZUxKY3V+aKd9j9gI++m6zL4XNxj2GFS9SPcqU9FE4feETVfVa4Yy0wp
	 oO11TE2sLhOddsFpg+LaVyy3dwCYGoForBm4D028Z6HoiGWRnT8p2/CWyYPGx2Cs0E
	 2pziPuC2hcfPg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39FF780840; Sat,  8 Feb 2025 22:27:06 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33A1B8083F
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 22:27:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="VibSb1Jw"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 50E2C101FF373; Sat,  8 Feb 2025 22:27:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1739050023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rKi28rZ9klCKdk9uVt6mQ5tPs9SsOuZ/lDMSCsenhUQ=;
 b=VibSb1JwTuxOB/aV44Mi1oRIK8/FDaH7Dbr1FfSj60U8HuKwPA4K0bd26AK8WK+HLOjNfa
 S6DBu3adr3e3Fnv+14hRYjyR6SHXCz96byJNrcIjyBbnR0t7VH1oayuVo9RoDlrEJLpztH
 0gc8ON6D/xDQC7pHqtRhTI2UkFFiJWX1Fuo4o18Nz8ASL/erwJvuOgRbrWq/Ezw0oicXV5
 qmJ82+SLO5wB0loklSnQSn8hDEYIr8h4efG3X9xoyyP68uDCkepib2u2nbujYDgqVPVnVr
 lGJWLwnSkPCFHHEJTGu0YxiY5Ih+Zn/A0tsyS8taDBR6y0pnwcAB80f3Pga1Ww==
Message-ID: <a113ba1b-a154-4fc7-90d9-5d662717d118@denx.de>
Date: Sat, 8 Feb 2025 22:25:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] tools: mkenvimage: Add pure shell implementation of
 mkenvimage
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>,
 Tom Rini <trini@konsulko.com>
References: <20250205143641.65430-1-marex@denx.de>
 <CAFLszTjshfJMxZoj=aZdCmDzTNRz1rRdphHb4UT9uBwKf5vS9g@mail.gmail.com>
 <b492494b-15a0-4b62-9600-40d9525b8a00@denx.de>
 <CAFLszThzW5jqd4685vwpu9KcjKQ=A31zJ1jbXKSkv1-tfoY8Pg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAFLszThzW5jqd4685vwpu9KcjKQ=A31zJ1jbXKSkv1-tfoY8Pg@mail.gmail.com>
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

On 2/7/25 1:49 AM, Simon Glass wrote:
> Hi Marek,
> 
> On Thu, 6 Feb 2025 at 13:52, Marek Vasut <marex@denx.de> wrote:
>>
>> On 2/6/25 1:38 PM, Simon Glass wrote:
>>> Hi Marek,
>>>
>>> On Wed, 5 Feb 2025 at 07:37, Marek Vasut <marex@denx.de> wrote:
>>>>
>>>> Add implementation of mkenvimage written purely in bourne shell.
>>>>
>>>> This is not a replacement for mkenvimage tool, but rather a simple
>>>> implementation which can be used in environments where mkenvimage
>>>> itself cannot be deployed due to various constraints, like hardware
>>>> manufacturing plants, but where bourne shell and basic tool are
>>>> already available.
>>>>
>>>> The external dependencies which are not shell built-ins are gzip
>>>> and grep.
>>>>
>>>> All mkenvimage parameters are implemented and compatible with the
>>>> C implementation of mkenvimage.
>>>>
>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>> ---
>>>> Cc: Joe Hershberger <joe.hershberger@ni.com>
>>>> Cc: Tom Rini <trini@konsulko.com>
>>>> ---
>>>>    tools/mkenvimage.sh | 126 ++++++++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 126 insertions(+)
>>>>    create mode 100755 tools/mkenvimage.sh
>>>
>>> Would it be worth adding a simple test for this?
>> Sure, is there an existing test for similar case I can look at ?
> 
> Well test_env_text is something I did for the env2string.awk script,
> so perhaps something like that?

I found some python file in the codebase which contains this function, 
but I couldn't find any documentation how to use it. I am also not a big 
fan of python. Is there any documentation how to use this test ?
