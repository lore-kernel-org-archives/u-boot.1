Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF898CA0FF6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 21:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC97B8669D;
	Fri,  1 Sep 2023 23:01:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nGIMFFy1";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="R84bAzJd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A37628657B; Fri,  1 Sep 2023 23:01:11 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CB38866DC
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 23:01:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Rcr6X1qHmz9skw;
 Fri,  1 Sep 2023 23:01:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1693602068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3jhKvcPw5rI27KD6TUCWK1GLjRYduSvkD9lUCOJ36/w=;
 b=nGIMFFy15XL77IYHt83pie4VSmRMtjtzkC5j6cgSDOxA3bSqfcxOM/0XU8SjngckXR2psf
 4XDFrLVUqtK/oCZ+0LV0nOru/UA2aBGud2VRXq5HJgyjs9fx/SUgIu3BkevSWleAQNZBRU
 8d7MKhakMym5JTviRl/pDuntm7Xm+kBVWQnlYVJgScn6J1D88CNChlygIsOKBywp0U/Cot
 ylyOk1ME6UGGEUWvE4e8j+IvLNQOZXATaFMNyDENanXEP+VdT5SMnR6gKmG4wwQ1Nupdmt
 WHwBUFbli+KPQYWJVD/zyoddlElR0zx/1886fwcsEcN2tn8RdNrW+ruksL4FMA==
Message-ID: <9f03487a-ae6a-6e17-5051-a0a575c2d517@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1693602065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3jhKvcPw5rI27KD6TUCWK1GLjRYduSvkD9lUCOJ36/w=;
 b=R84bAzJdDJydf/SFMKnWvNAF3IKWTTGNOiD3aQZiXzEDA/ytPb93zKZ0Hmht9jYc1qzosy
 BN22r9QURxbgqQbv8tzAcCN18iFNmWNwkIfDtTXFwVIgZ1e4SBzRUcY43fcWHHwpGsIJXl
 v+Bc0w+y0xr0lHIA8lP2ikk4izmD/MBN01IG3A12s1HcQB3zjtPPJcv7veOTHyC11mCKAx
 MrBbeWsRIDvzVvmY3zi2tZBCNm0uuEF1TKufSLrB1ryVXvVNdTZQ9rWeIY+GMCLIWNNTGY
 nf5Ecztve6ASDqMfQ+wg7adnm0I8VmUqPmaS7UzKJK0uUi07N8gdM7hobGFYaw==
Date: Fri, 1 Sep 2023 23:01:03 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] .gitlab-ci: Test sandbox64 board in addition to sandbox
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>
References: <20230901084810.238594-1-marek.vasut+renesas@mailbox.org>
 <20230901181123.GT3101304@bill-the-cat>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20230901181123.GT3101304@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 31dac9d77e0450f47f1
X-MBO-RS-META: 8ar55yjj974g46h84jqfwy1kipjmc3nh
X-Rspamd-Queue-Id: 4Rcr6X1qHmz9skw
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

On 9/1/23 20:11, Tom Rini wrote:
> On Fri, Sep 01, 2023 at 10:48:10AM +0200, Marek Vasut wrote:
>> Test both 32bit and 64bit sandbox boards in CI.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> ---
>> DEPENDS:
>> - [v2] test: print: Fix hexdump test on 64bit systems
>> - test: dm: test-fdt: Use fdtdec_get_int() in dm_check_devices()
>> - configs: sandbox64: Enable legacy image format support
>> ---
>>   .gitlab-ci.yml | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index 6d7ffdd1bbc..a7282be3181 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -291,6 +291,23 @@ sandbox without LTO test.py:
>>       BUILD_ENV: "NO_LTO=1"
>>     <<: *buildman_and_testpy_dfn
>>   
>> +sandbox64 test.py:
>> +  variables:
>> +    TEST_PY_BD: "sandbox64"
>> +  <<: *buildman_and_testpy_dfn
>> +
>> +sandbox64 with clang test.py:
>> +  variables:
>> +    TEST_PY_BD: "sandbox64"
>> +    OVERRIDE: "-O clang-16"
>> +  <<: *buildman_and_testpy_dfn
>> +
>> +sandbox64 without LTO test.py:
>> +  variables:
>> +    TEST_PY_BD: "sandbox64"
>> +    BUILD_ENV: "NO_LTO=1"
>> +  <<: *buildman_and_testpy_dfn
> 
> I'm not sure it's worth building and testing sandbox64 without LTO as
> well. The primary reason we do this here is to ensure that the NO_LTO
> flag keeps working, rather than specific outputs from the tests, and we
> should _probably_ change the current one to be a case where we just test
> that the version test runs and passes.

It is faster to finish building if nothing else.
