Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A043ACA0FF6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 21:01:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E22B86725;
	Fri,  1 Sep 2023 23:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="M6N9kv7O";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aRYraJxa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DDF38657B; Fri,  1 Sep 2023 23:01:25 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C17128657B
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 23:01:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Rcr6p4gPvz9sWQ;
 Fri,  1 Sep 2023 23:01:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1693602082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LAYluwsa5qlIy/2Aia+jk4nLzNKWtLLXsk5zUO1gsLQ=;
 b=M6N9kv7OsrLAJGeCRL6Ulsq3o35Zc13RXqVFKOoujIrAevSAzpQmm+9UuW8Oz64+tj9agO
 coZv/cuCrHTMgFDWr0Y8g0g9SX6bAnMvD8htI7N9GCpYog7sT6kQ4BcdC25LxsISveA53A
 Wg3vcNkO8Bu7L/SZHgbILvgyPu1UnL/Ab/uYPUlrleRDEw5psU2L2581KI8x/XYJ+OHg6n
 0PQEDQn7rChx1UStDzvE7eaC1e5RVlJLyhXlCVp85VFQn4SXgSmzo8Jnwj9/SEhXGwpk7l
 eSzwcAKkIr4Pv85LP3moFF2jGq6Jwmd2p2cGHp6AoKFPnzYIcFhPaid/AeFHtw==
Message-ID: <90536404-b36d-c267-0c44-cb23ae26f5f5@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1693602080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LAYluwsa5qlIy/2Aia+jk4nLzNKWtLLXsk5zUO1gsLQ=;
 b=aRYraJxaqnR5tHvRwooTzfp8SnmivtxGRcexb/gb4GvKM0DMw1ENKbcRKbMl33HBmEN3QD
 LXjN/WbH8+qwjwd1KumSDtZ9lRruzsPBPDRNHCYyvhX9uRsc+4uEGkVmSZfzYwPTOMgG5B
 h3M8FtoO9kfLiutZRSbeBs+MdAjDDVUTMpp7qZcZiI9u4TZDMJ6XoKM17aPFtG9FbGO3qj
 pm5f7ION2fG2fbt3iWKXcX5uWaIn1WXb7himlCh8+XqbUtGAawdi4w9qG5j4P9C9abA77I
 yD0JQQHtCjF2wIXdyN7eFsI8W9YNX63BYDRRrwhTOX38bqvix/+6I1CWyvZGmw==
Date: Fri, 1 Sep 2023 23:01:19 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] .gitlab-ci: Test sandbox64 board in addition to sandbox
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>
References: <20230901084810.238594-1-marek.vasut+renesas@mailbox.org>
 <20230901132405.GR3101304@bill-the-cat>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20230901132405.GR3101304@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 4f388b1323d794eedf0
X-MBO-RS-META: ofcegramcadtfqea4kmhszyz5tbwphdo
X-Rspamd-Queue-Id: 4Rcr6p4gPvz9sWQ
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

On 9/1/23 15:24, Tom Rini wrote:
> On Fri, Sep 01, 2023 at 10:48:10AM +0200, Marek Vasut wrote:
> 
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
> 
> Nice work.
> 
> Reviewed-by: Tom Rini <trini@konsulko.com>
> 
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
> I think this means it'll be time to split sandbox out in to its own
> stage on Azure as we can get 10 meaningful-but-long runs there and so
> it's best for overall job time to make that a stage. I'll go give that a
> spin shortly unless you want to.

Sure
