Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E2CC02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 21:27:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1911280805;
	Sat,  8 Feb 2025 22:27:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1739050026;
	bh=RqTLGRbD8c6r6GyRJ5GG0z+hcScY7ONfy1BnlZeA4S0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YqYE2BTUYN7xPG5zpoyjxmkWvajnXDSAbF9w9w1wyd0sRMIkMcDot46jZ6ceM/djM
	 GEP29G/iZHq0uwJdgTsaTxxhdbQlSHWm86MlJZKjUPJmIEODlQxB4ucnuUrPZ8KGrC
	 hnKaah0/w+W6U9YHKtqRk8gS9m7Zo4SsWrI1JcAov+XFKcxWk3Wt+EjQL1hdtAy1kZ
	 V+Y8wffr3U+/Q0oW7ffeoLWWWhq78W4M4zlEsUNP8NVx9Q59Zd8pE/hnJ5+oFFu3ys
	 EFI/oKvJYz1p0M7B4040tQJY4l8+8oEN+/jZd7kma7jw8wHwZTI5/UGxIhxAQphmnF
	 kii4ZdaHBiZMA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 408E780885; Sat,  8 Feb 2025 22:27:04 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9596D8083C
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 22:27:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="dScwQNzt"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CF15F101FF36C; Sat,  8 Feb 2025 22:26:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1739050020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RqTLGRbD8c6r6GyRJ5GG0z+hcScY7ONfy1BnlZeA4S0=;
 b=dScwQNztDojOl+DHJgXAmkPTSWyuOEEFq51vrQPdNWmoLFUO9EdudWoiGDAPA843BnflSL
 A2G2y1yMmQk2jryancBl/zneuQq+uRtlbz3t6mOuLVkAGwHuHAfNeHFZAQdbQZVeGHMmHB
 gEnF0G3QnrmC7SnF1j3FgqSM7DHSo9RgkCA7DTgjbtsGPvAk+rr2qluhpLhemTHv9z0u0q
 zmdshWtxbK1v34JoOcVVaF3co8NmXC/+9+l+S8hIc8KAgMA/4Wan3xnm9cgTCqzCGuUwGs
 8IOyH+gG+txIBOA4WmXWcUX38p7PwoBwrb88KMXPRKzg6Gvb7QLKTQfyMF17gQ==
Message-ID: <d3044f55-732e-4cda-8c54-5ab7c7801501@denx.de>
Date: Sat, 8 Feb 2025 22:16:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: mkenvimage: Add pure shell implementation of
 mkenvimage
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>,
 Tom Rini <trini@konsulko.com>
References: <20250205143641.65430-1-marex@denx.de> <877c62rqqc.fsf@prevas.dk>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <877c62rqqc.fsf@prevas.dk>
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

On 2/7/25 11:31 AM, Rasmus Villemoes wrote:
> On Wed, Feb 05 2025, Marek Vasut <marex@denx.de> wrote:
> 
>> Add implementation of mkenvimage written purely in bourne shell.
>>
>> This is not a replacement for mkenvimage tool, but rather a simple
>> implementation which can be used in environments where mkenvimage
>> itself cannot be deployed due to various constraints, like hardware
>> manufacturing plants, but where bourne shell and basic tool are
>> already available.
>>
>> The external dependencies which are not shell built-ins are gzip
>> and grep.
>>
> 
> Eh, and cat, sort, dd, tr, mktemp, head, tail, mv and rm ?

A lot of which are shell builtins .

>> All mkenvimage parameters are implemented and compatible with the
>> C implementation of mkenvimage.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Joe Hershberger <joe.hershberger@ni.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> ---
>>   tools/mkenvimage.sh | 126 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 126 insertions(+)
>>   create mode 100755 tools/mkenvimage.sh
>>
>> diff --git a/tools/mkenvimage.sh b/tools/mkenvimage.sh
>> new file mode 100755
>> index 00000000000..f83fac92e5d
>> --- /dev/null
>> +++ b/tools/mkenvimage.sh
>> @@ -0,0 +1,126 @@
>> +#!/bin/sh
>> +
>> +print_help() {
>> +	echo "mkenvimage [-h] [-V] [-r] [-b] [-p <byte>] -s <environment partition size> -o <output> <input file>"
> 
> Nit: you included a .sh extension in the filename, probably this output
> should reflect that.

$0 is even better.

>> +
>> +(
>> +# Read input environment file, make sure there is a trailing newline,
>> +# sort the result and remove empty and commented out lines.
>> +( cat "${INFILE}" ; echo ) | sort -u "${INFILE}" | grep -v '^#' | grep -v '^[ \t]*$' | tr '\n' '\0'
> 
> Doesn't sort ignore stdin when given file(s) via argv? Also, the newline
> added by that echo would probably by removed by the grep, and you
> manually insert a \0 right after, so probably the first cat;echo should
> just be removed.

Good point

> I'm also wondering why you even do that sort; AFAIK, mkenvimage doesn't
> do that. And it would make a difference if the input fx had two
> definitions for the same variable
> 
> foo=Y
> foo=X
> 
> because when loaded on target, the last occurring value takes
> precedence.

Indeed

> Are you handling escaping of newlines, in order to allow values to
> contain newline characters?
Uh, no, I don't think so. I don't think I even used something like that 
with plain C mkenvimage either. Do you have an example input env for me?
