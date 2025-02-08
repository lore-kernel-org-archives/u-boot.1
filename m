Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CB7C0219B
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 21:27:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20FF480A35;
	Sat,  8 Feb 2025 22:27:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1739050030;
	bh=Ko4e2jkull4FVGcV0arQeTroHB3zvMgiz5S68dYSdaA=;
	h=Date:From:Subject:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pgxYNJO8zSfgwLgi3flwVM/uMzQMnW8vfFe6gbNz6RG93yDsSNQSGsbgDfwYsy0/h
	 D4opjr+YuVACaZQcO9wuf2sKWNekg2+fX2xXnVjF5YFt0XLiuGqwkNq0x/tU996KCV
	 Opd64yCx5kTdvOS53I7WbWxDOpnjD3u8iRNBJtglIpBMz6lEHeUUex04SqNl7FSDe1
	 dgO7BgDHYqa1j6BxnBZjGikeudbG24a5HJ9w4YschP5G2zSuwa0ppUQbyRwFP3hvGm
	 MwGuf6ssu7tTCKdqM42A0MlbM5v/kfsQegLPpTMY8/z+N5WKAH3lA+0LXpp0wLwc34
	 nKUMuLn/9jCEw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFBBA8091A; Sat,  8 Feb 2025 22:27:06 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0183680836
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 22:27:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="gYHfrWPO"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 27405101FF374; Sat,  8 Feb 2025 22:27:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1739050024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ko4e2jkull4FVGcV0arQeTroHB3zvMgiz5S68dYSdaA=;
 b=gYHfrWPOp5FwDiWSkOi8/dCioQ2N1/lFPlgHPsc1nzboKiN1meu8Lf1H0p0F07TLYPmk1l
 k3cz4sPkTo8noATtb9RgChkSHEYRKhBuJXYOMD0KV3t9pZbY+albc8CufYc4AX0p7oiQf+
 gdiwPlaCva/8k0bzWRLjH7EtyBFTuW1WD9366k4aff2ND/ukHf3BxdlzF5Sy/RUO4/+FgE
 XU9P224RnRI4Y0NEJG6TBlZvRr+G7JCczX85Yl1r09mu6DHgzxMlU+1eOpfA/4IjE69/L3
 rOyNH08/PLGWck4XgN1ASCDbAPbZUvFEJjPr7vDr9Dck8QngQPqfY82jYg+Q1g==
Message-ID: <fb9fdc1f-d333-4f09-8c05-220a7cdd0ffc@denx.de>
Date: Sat, 8 Feb 2025 22:26:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] tools: mkenvimage: Add pure shell implementation of
 mkenvimage
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>
References: <20250205143641.65430-1-marex@denx.de>
 <CAFLszTjshfJMxZoj=aZdCmDzTNRz1rRdphHb4UT9uBwKf5vS9g@mail.gmail.com>
 <b492494b-15a0-4b62-9600-40d9525b8a00@denx.de>
 <20250207-universal-eatery-44004ec073fc@thorsis.com>
Content-Language: en-US
In-Reply-To: <20250207-universal-eatery-44004ec073fc@thorsis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2/7/25 8:40 AM, Alexander Dahl wrote:
> Hi Marek,
> 
> had a short look on your script yesterday.  Looks clean and well
> designed, nice job.
> 
> Am Thu, Feb 06, 2025 at 09:38:58PM +0100 schrieb Marek Vasut:
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
> I thought about testing yesterday, but had no good idea on top, but
> now it's discussed anyways …  How about throwing the same input
> at the c and the sh version and assert the output is the same?  For
> more sophisticated tests it should be tested with both variants.

I do have local shell script which does exactly that -- feed inputs into 
both mkenvimage C and SH variants and compare the checksum of results.
