Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94985D25B76
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 13:28:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC71183E23;
	Wed, 28 Jan 2026 14:28:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="FiSXAe3F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5775183E23; Wed, 28 Jan 2026 14:28:43 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7280183DDF
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 14:28:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4f1NQH3rVYz9tRx;
 Wed, 28 Jan 2026 14:28:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769606919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ec2Jg9scWiut4KGIyZYSC5Ry1xLlbocbXXNT4PI/h1U=;
 b=FiSXAe3FIqU7YOANZNojAneYbknKdKj1kZ5tMb4Q4NTgEJPg7BDNUucy0r67QnuoMrlmSU
 2+aIoBqkNYeW3AGDtyBc3aQd7SVAJvyZsv6QhwnFyyLjdHHZatkJqATM+3f/p+8JzlI6Y4
 NXQzaBGtzgkICbi4MFsCrXr0ZhMpuOAnaEAjB55VJ4BUiGDj+slKGpt08w0yUAFN4yLZE4
 x38/yhfWQUYtcp4Kabj4ZiRIckM8YahYFzH6t8ytFcEjUg4FJ2OgW7xmqyb6CJWZfnSz08
 fKbxR3yzz7j8YJim/Zeqg+qP2QJXGp6Xd2dYS0gAjJAc5P3M9EuYbi1pHvLZPw==
Message-ID: <1846ef8d-44c4-4c3b-b810-6ad906405e18@mailbox.org>
Date: Wed, 28 Jan 2026 13:01:09 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] gunzip: Fix len parameter in function signature
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Alexander Graf <agraf@csgraf.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
References: <20260127235156.1503207-1-marek.vasut+renesas@mailbox.org>
 <0F151B61-19A0-4F8E-925B-1EDFD7054E1B@gmx.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <0F151B61-19A0-4F8E-925B-1EDFD7054E1B@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 790f4c422adda4b5c4b
X-MBO-RS-META: mg6d4kzbgrs1qnun8fuy1hfqssoshpto
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

On 1/28/26 5:32 AM, Heinrich Schuchardt wrote:

Hello Heinrich,

>> diff --git a/include/gzip.h b/include/gzip.h
>> index 304002ffc42..5396e3ffec7 100644
>> --- a/include/gzip.h
>> +++ b/include/gzip.h
>> @@ -77,8 +77,8 @@ void gzwrite_progress_finish(int retcode, ulong totalwritten, ulong totalsize,
>>   *		for files under 4GiB
>>   * Return: 0 if OK, -1 on error
>> p */
>> -int gzwrite(unsigned char *src, int len, struct blk_desc *dev, ulong szwritebuf,
>> -	    ulong startoffs, ulong szexpected);
>> +int gzwrite(unsigned char *src, unsigned long len, struct blk_desc *dev,
>> +	    ulong szwritebuf, ulong startoffs, ulong szexpected);
> 
> Ulong and unsigned long are essentially the same but using both in one function signature looks weird.
> 
> I would prefer size_t for the size of objects in memory and off_t for file sizes and positions in files.
> 
> Please, consider adjusting startoffs and szexpected, too.

OK

>> /**
>>   * gzip()- Compress data into a buffer using the gzip algorithm
>> diff --git a/lib/gunzip.c b/lib/gunzip.c
>> index a05dcde9a75..040450c0e79 100644
>> --- a/lib/gunzip.c
>> +++ b/lib/gunzip.c
>> @@ -116,11 +116,8 @@ void gzwrite_progress_finish(int returnval,
>> 	}
>> }
>>
>> -int gzwrite(unsigned char *src, int len,
>> -	    struct blk_desc *dev,
>> -	    unsigned long szwritebuf,
>> -	    ulong startoffs,
>> -	    ulong szexpected)
>> +int gzwrite(unsigned char *src, unsigned long len, struct blk_desc *dev,
>> +	    ulong szwritebuf, ulong startoffs, ulong szexpected)
> 
> ditto
> 
>> {
>> 	int i, flags;
>> 	z_stream s;
>> @@ -133,6 +130,12 @@ int gzwrite(unsigned char *src, int len,
>> 	u32 payload_size;
>> 	int iteration = 0;
>>
>> +	if (len > 0xffffffff) {
>> +		printf("%s: input size over 4 GiB in size not supported\n",
>> +		       __func__);
> 
> Please, use log_err() for error output.
I believe log_*() primitives are frowned upon ? Tom ?
