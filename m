Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA6CC54791
	for <u-boot@archiver.kernel.org>; Sun, 10 Mar 2024 10:12:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6FF187D50;
	Sun, 10 Mar 2024 11:12:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="ZurekpX2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C759C87D84; Sun, 10 Mar 2024 11:12:08 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23B0687D1A
 for <u-boot@lists.denx.de>; Sun, 10 Mar 2024 11:12:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1710065524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EozEzcugZ753/SG2GZhp2CWh/bg9tYET+3Z0S3z97PI=;
 b=ZurekpX2aVa2nUZrFK9EpGsFVhmC1ZkgedCutYaUXC0oPfSJXBvk0j3Lvhu/3XB02sdOzd
 5PXpZyRZ30diTYxYXlQHGN5L4JdnwcYcT506/6r6TgPhowuqyU3mtUdVZv5HVRk+9nxR+b
 L+uqKBSx/O+JuWOVhBUHAVIJH/atS8AMu8gXrBizYM7NHWPAPW3sbAdGMhm7IstTxmM2nm
 3ecCdIJVpIJuf87Y+C5VjrTsqhcIRiuMEn+YXdS2xa9EDE5oGZUR1+8tvHRNp0ChHWaX6y
 +sjdQ21YwT/bbpBuX5VfMo5dWMzMSR+V3bzodfs6N3KrReJbCD7eeTu3i22eog==
Date: Sun, 10 Mar 2024 11:12:03 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: "Leon M. Busch-George" <leon@georgemail.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2] Makefile: use shell to calculate map_size
In-Reply-To: <b594973ddce475d2a2baead6f4028134@manjaro.org>
References: <20240302131728.148251-1-leon@georgemail.de>
 <20240304203909.63796-1-leon@georgemail.de>
 <b594973ddce475d2a2baead6f4028134@manjaro.org>
Message-ID: <dcd979dc882179f0210d7c23f68329a1@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Leon,

On 2024-03-04 21:44, Dragan Simic wrote:
> On 2024-03-04 21:38, Leon M. Busch-George wrote:
>> From: "Leon M. Busch-George" <leon@georgemail.eu>
>> 
>> The error message "bc: command not found" is easily missed since the
>> build continues.
>> bc is not a part of coreutils or base-devel. POSIX sh can also do the
>> calculation.
>> 
>> Signed-off-by: Leon M. Busch-George <leon@georgemail.eu>

The v2 is looking good to me.  I also did some testing of the awk code
by hand, outside of the actual Makefile, and it worked as expected.

See also one small nitpick below, and please feel free to include:

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

>> ---
>>  Makefile | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>> 
>> diff --git a/Makefile b/Makefile
>> index a2bc9d5903..e8e794368e 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1275,10 +1275,15 @@ OBJCOPYFLAGS_u-boot-nodtb.bin := -O binary \
>>  binary_size_check: u-boot-nodtb.bin FORCE
>>  	@file_size=$(shell wc -c u-boot-nodtb.bin | awk '{print $$1}') ; \

Perhaps a couple of spaces could be added around "print $$1" in the
line above, to nicely round off the code cleanups.

>>  	map_size=$(shell cat u-boot.map | \
>> -		awk '/_image_copy_start/ {start = $$1} /_image_binary_end/ {end =
>> $$1} END {if (start != "" && end != "") print "ibase=16; "
>> toupper(end) " - " toupper(start)}' \
>> -		| sed 's/0X//g' \
>> -		| bc); \
>> -	if [ "" != "$$map_size" ]; then \
>> +		awk ' \
>> +			/_image_copy_start/ { start = $$1 } \
>> +			/_image_binary_end/ { end = $$1 } \
>> +			END { \
>> +				if (start != "" && end != "") \
>> +					print end " " start; \
>> +			}' \
>> +		| sh -c 'read end start; [ -n "$$end" ] && echo $$((end - 
>> start))'); \
>> +	if [ -n "$$map_size" ]; then \
>>  		if test $$map_size -ne $$file_size; then \
>>  			echo "u-boot.map shows a binary size of $$map_size" >&2 ; \
>>  			echo "  but u-boot-nodtb.bin shows $$file_size" >&2 ; \
