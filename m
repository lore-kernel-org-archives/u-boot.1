Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D4EC021A4
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 09:49:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54D3A80F62;
	Mon, 17 Feb 2025 10:49:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZdTVeADu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2033380F64; Mon, 17 Feb 2025 10:49:28 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2502F80F56
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 10:49:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-439714a799aso16120255e9.2
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 01:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739785765; x=1740390565; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SPNmyy4RF9qTAgndKMgBR/IOGfwi01WFCxFYZFXt/zc=;
 b=ZdTVeADuGsHdly/N8z42tUW46b7HW0aB83Yi/axXn0XyUtFblAmHSemErApeSkKb+2
 ONSg7u4ZmwrXnxjNHrLHC6JAHw12CnbYJkrbFwMC+w+o/FahH0/OTHJhB4RYZRaNGKy2
 ybdzziopdFlg4Bw/Yzj+aQHC277vFtrMW/mw4YprJthofp62iTr+wJgubzHBHjShgGRN
 DbX7dMe/cFvJgujb7PhoM2ClY4BjG23myTdF46n0bzKhzB+xbyEZuuiND8/sdjA+izvi
 4N+48hVCsikxl++xvxWqNI9yRXy/oJSTSf7hQ7Agf57g/rzyiRZdRpiDkzicL70VfffQ
 ewYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739785765; x=1740390565;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SPNmyy4RF9qTAgndKMgBR/IOGfwi01WFCxFYZFXt/zc=;
 b=RnSrofVQ0O0e97pDMVJsS6EMgaCYaQgixdLapZMFbipD8TKp28jxNJDrxe/ZINaHGO
 MRKCt7TKdw5nS4WZJPu9o7nOondV9H+2UkKzZjz0/BoguWyPZ5ZzOBZs13DJuXGHiRpF
 WJAI8T4ZdljBeZCF9d2k6a9GWV5gct4O7u+D3POtR7fqQU8B2ma4XaCcrtHGrUG8K4xO
 +veGJcSdpgl4AikDT7cyFNadAxJQ0R/94DjQGNQ0Tbrj7lcQuivF+WM8LH25rZ2TWX7g
 OIDv9HkysHSNgYiq1+edbYZWz6Dqvv1YFsmrhYtr5EDHbjINhTDRpMMXt++BsQdSqR17
 OYOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRWhkE8auAgcTSe4Qg0NAmjbo2n4SKdJ2JOIYJj2M3O/bJPFhmhliJ6gVfZ8Vb9Z2Lmtlf5sg=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2YtjTsZopWZMv6ccGYmNEnx+ewe8cL3l09Z/AR/2GzJcJc1S8
 Fgx2osJc2WDTdItPEOkksSmkT+AHMWGxHO+o2/24brk7ISTw5fXKUEXY/GBKwjU=
X-Gm-Gg: ASbGncs58gVxbeRxjnoUKAOCvDbcH6mNUZInPYHP3mRrT8FCQI5RkEVvimnQgM74yaO
 oIuMyDecmEzjr3fUzol4h1K6Ou0PV9HlWeKzqCqdtwO8QOZgtq5ZPwPGKvregVHViZRTQKgHwkF
 QRO3YtnHCVL3QHex/WVpe9stipu6gjB8G4Kx2pEYZr4CdcJQdtlDwhfLl7cW0alLiB2mb4Q5NLn
 Mhr0NJqJWXxi1oIENn8a1VmmQ4iKiiXADwBivdZsyfHLn2xTGY79mcmuq71LVqiPMREx9b2yhjt
 BGAwPYkJD6PibtEmur/Qui47+7JY386fnzTgYi805eIdrvYfj7lB6Z5CtlFbi95TMJKeZXo=
X-Google-Smtp-Source: AGHT+IF7u5B9wwpb1mVXYOOymJ4aRC58YhPR0Z4ACTSWqAfsieN5wt6HFR5kGEu79Gl7DWiHcsCoCA==
X-Received: by 2002:a05:600c:1ca8:b0:439:8a44:1e68 with SMTP id
 5b1f17b1804b1-4398a442044mr10795735e9.28.1739785765629; 
 Mon, 17 Feb 2025 01:49:25 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:d3ab:98e5:89c8:6d18?
 ([2a01:e0a:3cb:7bb0:d3ab:98e5:89c8:6d18])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1b8471sm148704355e9.37.2025.02.17.01.49.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 01:49:25 -0800 (PST)
Message-ID: <e840cada-0e8d-4b51-acf0-e0f82496b6d7@linaro.org>
Date: Mon, 17 Feb 2025 10:49:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/10] test: lib: add uthread test
To: Yao Zi <ziyao@disroot.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>
References: <20250214140031.484344-1-jerome.forissier@linaro.org>
 <20250214140031.484344-11-jerome.forissier@linaro.org>
 <Z6-OXlI53Mt0q1Gy@pie.lan>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <Z6-OXlI53Mt0q1Gy@pie.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 2/14/25 19:41, Yao Zi wrote:
> On Fri, Feb 14, 2025 at 03:00:25PM +0100, Jerome Forissier wrote:
>> Test uthread scheduling.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  lib/uthread.c      |  3 ++-
>>  test/lib/Makefile  |  1 +
>>  test/lib/uthread.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 61 insertions(+), 1 deletion(-)
>>  create mode 100644 test/lib/uthread.c
>>
>> diff --git a/lib/uthread.c b/lib/uthread.c
>> index bb132001fb6..1f8e6d0fa80 100644
>> --- a/lib/uthread.c
>> +++ b/lib/uthread.c
>> @@ -76,10 +76,11 @@ err:
>>  
>>  void uthread_free_all(void)
>>  {
>> +	struct uthread *main = &main_thread;
>>  	struct uthread *next;
>>  	struct uthread *tmp;
>>  
>> -	list_for_each_entry_safe(next, tmp, &current->list, list) {
>> +	list_for_each_entry_safe(next, tmp, &main->list, list) {
>>  		list_del(&next->list);
>>  		uthread_free(next);
>>  	}
> 
> I think this should belong to the sixth patch.

Absolutely. I'll fix in v2.

> 
>> diff --git a/test/lib/Makefile b/test/lib/Makefile
>> index bf04685dae1..c991dff1c63 100644
>> --- a/test/lib/Makefile
>> +++ b/test/lib/Makefile
>> ...
> 
> Best regards,
> Yao Zi

Thanks,
-- 
Jerome
