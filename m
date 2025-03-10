Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5314FC28B30
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 23:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34E9B814B6;
	Tue, 11 Mar 2025 00:33:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741649633;
	bh=CkV1QbGeY69/b5eP384WEhhFfkwtvWpurz2JfkQ/fL8=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=faVl+RSTFNE5dDXNzmGfwS/oMgw0bSPcGRzYkLEZhRRbJosKd+o2ivMf8hgjwXJ/d
	 W6w0t/Ub/VD+HZipXBgKbWTQ3PYhDSWwkQLV16ld8ALcLgCxNao6nSJxJKzhdBqlHN
	 sfeAUQbxI9r725P9dagYNmVccx2X+oh/dlxRn11eAtKJwcT0dy0B6TeR2TjqRJaEeW
	 JYva3Cw4HJnzd2JxDcTVN+70DiblB0fiJY1R3IAleDuoFlIiMTldrdWuk4XAogps+7
	 WEGAnlkAQUKJ7otqbq5TdcfbDKQtPGkAUFeScZSMgJfzujyCajw11BAZIXoc58S5KA
	 Pqx0jP/0BUwQA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B9778083E; Tue, 11 Mar 2025 00:33:50 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A7C581335
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 00:33:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="NhMVCjn1"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 76D991020CAC9; Tue, 11 Mar 2025 00:33:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741649627; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=CkV1QbGeY69/b5eP384WEhhFfkwtvWpurz2JfkQ/fL8=;
 b=NhMVCjn1yx5oJjAPjck53JUQnMzIe+weaqv09+ND/nqKwgEgHYsfK9hWWGI5V8W1edI+TE
 8e38Fq3S4dfVmcISBEoYJKbIS6PTvOVUcr0SD0BhQnHH9arYLcwissAWM8jh+6xwPRAjia
 Ixa5YlxYgOJHw2xYnL2wFaoeptKRO3oe7E9k6VsRGRh4Im7VVbfjmzC6UnKphpMw78zND2
 ojdCTwMT0Y2JS5bPkWLC3qxP1LV1/aOojIYn/iYFERPh/AsgZy0qCmHPi7yiclhk9bJgSk
 qdJiX43L6TfT8iKoPZkPECujnKorhdBu4rvUXXVTdeT2Yyc3pE94FJQD40jKXg==
Message-ID: <e8cba3ce-d9a8-4bf0-8a98-dc1b8f8f49a3@denx.de>
Date: Tue, 11 Mar 2025 00:33:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 08/12] fs: exfat: Fix conversion overflow errors
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20250308201533.1315951-1-marex@denx.de>
 <20250308201533.1315951-9-marex@denx.de>
 <393a7b06-402a-48b0-8ed4-5dcaa7ab9383@cherry.de>
 <a7b192b6-48b8-4878-a6dd-563dbb9bdb06@denx.de>
 <20250310214904.GO2640854@bill-the-cat>
Content-Language: en-US
In-Reply-To: <20250310214904.GO2640854@bill-the-cat>
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

On 3/10/25 10:49 PM, Tom Rini wrote:
> On Mon, Mar 10, 2025 at 10:03:37PM +0100, Marek Vasut wrote:
>> On 3/10/25 12:17 PM, Quentin Schulz wrote:
>>> Hi Marek,
>>
>> Hi,
>>
>>> On 3/8/25 9:12 PM, Marek Vasut wrote:
>>>> Fix the following conversion overflow errors. The input field is already
>>>> limited to 3/2/1 bits using the bitwise and, move the parenthesis around
>>>> to avoid the bogus warning:
>>>>
>>>> "
>>>> fs/exfat/utf.c: In function ‘utf8_to_wchar’:
>>>> fs/exfat/utf.c:165:23: warning: overflow in conversion from ‘int’ to
>>>> ‘wchar_t’ {aka ‘short unsigned int’} changes value from ‘(int)(short
>>>> unsigned int)*input << 18 & 1835008’ to ‘0’ [-Woverflow]
>>>>     165 |                 *wc = ((wchar_t) input[0] & 0x07) << 18;
>>>>         |                       ^
>>>> fs/exfat/utf.c:170:23: warning: overflow in conversion from ‘int’ to
>>>> ‘wchar_t’ {aka ‘short unsigned int’} changes value from ‘(int)(short
>>>> unsigned int)*input << 24 & 50331648’ to ‘0’ [-Woverflow]
>>>>     170 |                 *wc = ((wchar_t) input[0] & 0x03) << 24;
>>>>         |                       ^
>>>> fs/exfat/utf.c:175:23: warning: overflow in conversion from ‘int’ to
>>>> ‘wchar_t’ {aka ‘short unsigned int’} changes value from ‘(int)(short
>>>> unsigned int)*input << 30 & 1073741824’ to ‘0’ [-Woverflow]
>>>>     175 |                 *wc = ((wchar_t) input[0] & 0x01) << 30;
>>>>         |                       ^
>>>> "
>>>>
>>>
>>> Since this doesn't seem to be U-Boot-specific, any chance to open a Pull
>>> Request on the project so we may be able to not carry this patch when
>>> upgrading (yes, the last commit in the branch was two years ago, but it
>>> seems the maintainer is still active on issues).
>>>
>>> Considering that wchar_t is an unsigned short int and that USHRT_MAX is
>>> 0xffff (so 2B or 16b)...
>> In fact, this error does not even appear in upstream , because upstream does
>> not use -fshort-wchar compiler flag . U-Boot does use this compiler flags
>> since 4a85663ec7ed ("kbuild: Enable -fshort-wchar") .
>>
>> So I wonder if this might be the right fix here instead:
>>
>> diff --git a/fs/exfat/Makefile b/fs/exfat/Makefile
>> index 550c0683d65..8ca112cf0e9 100644
>> --- a/fs/exfat/Makefile
>> +++ b/fs/exfat/Makefile
>> @@ -1,6 +1,9 @@
>>   # SPDX-License-Identifier: GPL-2.0+
>>   #
>>
>> +# The utf.o does really need 32bit wchar_t
>> +CFLAGS_REMOVE_utf.o := -fshort-wchar
>> +
>>   obj-$(CONFIG_FS_EXFAT) += \
>>   	cluster.o \
>>   	io.o \
> 
> Your initial approach is right I think, I'm not sure it's a good idea
> to mix and match that flag throughout the codebase.

The -fshort-wchar is needed only because of EFI , so I wonder if we 
should somehow isolate the EFI code which needs this stuff instead, and 
drop the flag throughout the codebase instead ? Heinrich ?

Or maybe EFI should switch to something else that is not wchar_t , so 
other users can use wchar_t unrestricted ?
