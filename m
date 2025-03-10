Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D659C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 21:08:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AABB18168B;
	Mon, 10 Mar 2025 22:08:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741640915;
	bh=brtsYQ6jIma9E0WRe1tUjnUW4dEJQZWTDHC39rqmV54=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=scdpk8qAn9iA485LJo3ccf8sz6XvKX6/3PShi9hDYEengIAtTIgf3KWTXbnbT5NMl
	 +TqXliHxKEvx62UQEGd/JzfkZqiTxLQVzfZr/iWfmqVHDx6xHHfqgTp24pI4BBva66
	 w2SHIatl5rYVnzql3TuYtI8c2pqlivyS6KR1zN1SnBUGrDKvwygZpQqy5ABlX6NEFz
	 baYYKn1snm/6mLx54KDpw3bqkb2qpeCrH1/dBA6MLtXzORh8It4+Q3JkL52375l2Jw
	 W8u5Xc5Zl/bIyL3Pv9+Asz0+zBigRwHHzv3mZFOQjBY+wyWoI1ERdh+c+tXUhsPYYB
	 V2grJk7sxeXQA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 575BC800D7; Mon, 10 Mar 2025 22:08:33 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4860D800D7
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 22:08:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Z6nRkz4T"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7EC311020CACC; Mon, 10 Mar 2025 22:08:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741640910; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=brtsYQ6jIma9E0WRe1tUjnUW4dEJQZWTDHC39rqmV54=;
 b=Z6nRkz4TeNq8GQpuRGgptH6QNiyQr1IS7laTikumKUM/UVLTACd7bZzPGEFUXmdqyV7Loz
 GLcoaroDZa7gPZ4Z6MAex+gHcfTQ6aTCCVcxcY3PZyhqFPqv6GDS+mlZucdtJIvF9Zq8/p
 0/iER0aNeXzY1C//fNg4LJ6D+3TNqjllHemHZJuFgrWXXo3We4AbJhCRL40282+B+p6pAB
 FyLzWB1fMOyTCLnL5E32fH4agiOirsoTV2M1ufXetQ+5XsX/1ptaN91Zdehg+Pv6opHXyY
 t5Cmx9BIVCNsaxdu26chkHmNRGCr4J1if91DbtAKLWmxiOQBrZbBMvX5bqWl1A==
Message-ID: <a7b192b6-48b8-4878-a6dd-563dbb9bdb06@denx.de>
Date: Mon, 10 Mar 2025 22:03:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] fs: exfat: Fix conversion overflow errors
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250308201533.1315951-1-marex@denx.de>
 <20250308201533.1315951-9-marex@denx.de>
 <393a7b06-402a-48b0-8ed4-5dcaa7ab9383@cherry.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <393a7b06-402a-48b0-8ed4-5dcaa7ab9383@cherry.de>
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

On 3/10/25 12:17 PM, Quentin Schulz wrote:
> Hi Marek,

Hi,

> On 3/8/25 9:12 PM, Marek Vasut wrote:
>> Fix the following conversion overflow errors. The input field is already
>> limited to 3/2/1 bits using the bitwise and, move the parenthesis around
>> to avoid the bogus warning:
>>
>> "
>> fs/exfat/utf.c: In function ‘utf8_to_wchar’:
>> fs/exfat/utf.c:165:23: warning: overflow in conversion from ‘int’ to 
>> ‘wchar_t’ {aka ‘short unsigned int’} changes value from ‘(int)(short 
>> unsigned int)*input << 18 & 1835008’ to ‘0’ [-Woverflow]
>>    165 |                 *wc = ((wchar_t) input[0] & 0x07) << 18;
>>        |                       ^
>> fs/exfat/utf.c:170:23: warning: overflow in conversion from ‘int’ to 
>> ‘wchar_t’ {aka ‘short unsigned int’} changes value from ‘(int)(short 
>> unsigned int)*input << 24 & 50331648’ to ‘0’ [-Woverflow]
>>    170 |                 *wc = ((wchar_t) input[0] & 0x03) << 24;
>>        |                       ^
>> fs/exfat/utf.c:175:23: warning: overflow in conversion from ‘int’ to 
>> ‘wchar_t’ {aka ‘short unsigned int’} changes value from ‘(int)(short 
>> unsigned int)*input << 30 & 1073741824’ to ‘0’ [-Woverflow]
>>    175 |                 *wc = ((wchar_t) input[0] & 0x01) << 30;
>>        |                       ^
>> "
>>
> 
> Since this doesn't seem to be U-Boot-specific, any chance to open a Pull 
> Request on the project so we may be able to not carry this patch when 
> upgrading (yes, the last commit in the branch was two years ago, but it 
> seems the maintainer is still active on issues).
> 
> Considering that wchar_t is an unsigned short int and that USHRT_MAX is 
> 0xffff (so 2B or 16b)...
In fact, this error does not even appear in upstream , because upstream 
does not use -fshort-wchar compiler flag . U-Boot does use this compiler 
flags since 4a85663ec7ed ("kbuild: Enable -fshort-wchar") .

So I wonder if this might be the right fix here instead:

diff --git a/fs/exfat/Makefile b/fs/exfat/Makefile
index 550c0683d65..8ca112cf0e9 100644
--- a/fs/exfat/Makefile
+++ b/fs/exfat/Makefile
@@ -1,6 +1,9 @@
  # SPDX-License-Identifier: GPL-2.0+
  #

+# The utf.o does really need 32bit wchar_t
+CFLAGS_REMOVE_utf.o := -fshort-wchar
+
  obj-$(CONFIG_FS_EXFAT) += \
  	cluster.o \
  	io.o \
