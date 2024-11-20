Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D465ED63936
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 13:05:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F1A689684;
	Wed, 20 Nov 2024 14:05:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="DBm8j2Ii";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EBC48967C; Wed, 20 Nov 2024 14:05:12 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C29308969E
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 14:05:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 20C463F5BA
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 13:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732107909;
 bh=8sa1y7Or50aK2MTe3K6fpfHm43L5m39bUllMluWz3xc=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=DBm8j2Ii1ndSdG1JxgwFB4cqo81HHViULymg/FnQs+/ZW5BYC1t7SQq3BPFDWG9Wg
 qGosRSVTqH3/8NGreRJFRYUF9dPPAQ88TC1nRl1Bj69nwTzTGuOOa2cNjlR8a6G9B+
 vtNKlTALWw4CGFstfbCRFBXpKAiUszzHvlbFHjoEG4g5tXtof5o4N1MvbVBZI+5+Y7
 F+UP7uRf5w94Ma7WdEPKhd7aQst3k6UoB5g3O80ubR6gsPyN6dl0zrVupPio94nhAa
 Cw87XNfmHmQeCFyFmc+S/sosBinOszA5aVmySeNPdvJwPFGTSvSM+DHsvqAEUiV6fI
 b5OsVYFe05+gw==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4314f023f55so13604025e9.2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 05:05:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732107909; x=1732712709;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8sa1y7Or50aK2MTe3K6fpfHm43L5m39bUllMluWz3xc=;
 b=hF8VEZUhgDN/vnIq27beDw4KCSenev3crxYFK8jz5ERv0tGcU3gJ967LRU25fMw2Yv
 B8XnE+W7yAKceLcIKtQeTbsFK+bJ+GbSK5PVFqbRlcFJHtooCSFjqkYGyuydOoaCr2Vy
 tw6WhjkPTjt+fLN283Xwb5VAqzAIrE17DrmglvEIdCQY0dBD3hH/BmXccvaW+2sPaPjx
 iERaxjcop5dT7ibegcbTs8cxdZtBXohUxz1eAfhY4inZTkzVsrOzQCPpcVdee8lsbFS3
 qag5mhGkOziGud1C3PAAIjR77APjnosjRxjXmUXzR5zP9BakzbYiutqndjCxLpSH/OhK
 yapw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr2Gpay2x8m+ZtZXKP64iAJRGXyFJeyHROP7RdTYHpAjPMlCb427yJJIQqSri66SneEmrlG9s=@lists.denx.de
X-Gm-Message-State: AOJu0YyLhWJffVo8Q/M0MaaQIxMJjNn217jzGuhaqv5TkLh8Mf8HIfvh
 L4YpVs9+7VZKYK2Iueaw6REGhmWE/Be9LFZr8eUsyLKsMEQkU6aR/PySzyKkEbC0NFn9HAcg5sp
 TDjvyO7cbssAql3DkieDS4YdM8dWDbLO0G3NgwUvs6NXvt7v9A81Uz911ha+BiQ9iWsZrHFCx82
 w=
X-Received: by 2002:a5d:64af:0:b0:382:d7a:315b with SMTP id
 ffacd0b85a97d-38254ade9aemr2385119f8f.11.1732107908715; 
 Wed, 20 Nov 2024 05:05:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiEUiMbuH3OQbEddyuDKGNOSLz9DGM7bxpAl2HANQHRKOzyE1hwaAOKXdW2uyQSJiYm7OqrA==
X-Received: by 2002:a5d:64af:0:b0:382:d7a:315b with SMTP id
 ffacd0b85a97d-38254ade9aemr2385068f8f.11.1732107908085; 
 Wed, 20 Nov 2024 05:05:08 -0800 (PST)
Received: from [192.168.103.101]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b463af68sm18386705e9.40.2024.11.20.05.05.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2024 05:05:07 -0800 (PST)
Message-ID: <5c9f67bd-8c09-440d-820e-524d4fff4240@canonical.com>
Date: Wed, 20 Nov 2024 14:05:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] test: cmd/hash: check return value of
 ut_check_console_line
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20241116200822.27160-1-heinrich.schuchardt@canonical.com>
 <CAFLszTg=E5ScwSQm6Msm7+AUic5GL+rNCq1Cy4_3wnRWgsJPPA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTg=E5ScwSQm6Msm7+AUic5GL+rNCq1Cy4_3wnRWgsJPPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 20.11.24 13:40, Simon Glass wrote:
> Hi Heinrich,
> 
> On Sat, 16 Nov 2024 at 13:09, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> ut_check_console_line() does include an assert.
>> Pass the result to ut_assertok().
>>
>> Addresses-Coverity-ID:  514958 Error handling issues
>> Fixes: 7dfafcd65ef3 ("test: unit test for hash command")
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   test/cmd/hash.c | 13 ++++++++-----
>>   1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/test/cmd/hash.c b/test/cmd/hash.c
>> index 2fcec9cadcd..296dd762b31 100644
>> --- a/test/cmd/hash.c
>> +++ b/test/cmd/hash.c
>> @@ -33,11 +33,13 @@ static int dm_test_cmd_hash_md5(struct unit_test_state *uts)
>>                          strstr(uts->actual_str, "md5 for "));
>>          ut_assert(strstr(uts->actual_str,
>>                           "d41d8cd98f00b204e9800998ecf8427e"));
>> -       ut_check_console_line(uts, "d41d8cd98f00b204e9800998ecf8427e");
>> +       ut_assertok(ut_check_console_line(uts,
>> +                                         "d41d8cd98f00b204e9800998ecf8427e"));
>>
>>          if (!CONFIG_IS_ENABLED(HASH_VERIFY)) {
>>                  ut_assert(run_command("hash -v sha256 $loadaddr 0 foo", 0));
>> -               ut_check_console_line(uts, "hash - compute hash message digest");
>> +               ut_assertok(ut_check_console_line(
>> +                               uts, "hash - compute hash message digest"));
> 
> ut_assert_nextline("hash - compute hash message digest")

Unfortunately your review comes too late. Tom already merged the patch.

There a number of usages of the function combination.

test/cmd/hash.c:36:     ut_assertok(ut_check_console_line(uts,
test/cmd/hash.c:41:             ut_assertok(ut_check_console_line(
test/cmd/hash.c:82:     ut_assertok(ut_check_console_line(
test/cmd/hash.c:87:             ut_assertok(ut_check_console_line(
test/log/cont_test.c:33:        ut_assertok(ut_check_console_line(uts, 
"ERR.arch, ea1"));
test/log/cont_test.c:34:        ut_assertok(ut_check_console_line(uts, 
"ERR.arch, cc2"));
test/log/cont_test.c:45:        ut_assertok(ut_check_console_line(uts, 
"INFO.efi, ie3"));
test/log/cont_test.c:57:        ut_assertok(ut_check_console_line(uts, 
"ERR.arch, ea1 cc2"));
test/log/nolog_ndebug.c:32: 
ut_assertok(ut_check_console_line(uts, "testing level %d", i));
test/log/nolog_test.c:30:       ut_assertok(ut_check_console_line(uts, 
"testing log_err"));
test/log/nolog_test.c:43:       ut_assertok(ut_check_console_line(uts, 
"testing log_warning"));
test/log/nolog_test.c:56:       ut_assertok(ut_check_console_line(uts, 
"testing log_notice"));
test/log/nolog_test.c:69:       ut_assertok(ut_check_console_line(uts, 
"testing log_info"));
test/log/nolog_test.c:111:      ut_assertok(ut_check_console_line(uts, 
"testing debug"));
test/log/nolog_test.c:125:      ut_assertok(ut_check_console_line(uts, 
"testing log_debug"));
test/log/nolog_test.c:126:      ut_assertok(ut_check_console_line(uts, 
"more log_debug"));
test/log/pr_cont_test.c:36:     ut_assertok(ut_check_console_line(uts, 
"ea1 cc2"));

Looking at the macro definitions your suggestion would add "console" to 
the error output but not lead to a functional change.

If we change it, we should do so for all occurrences.

Best regards

Heinrich

> 
>>
>>                  return 0;
>>          }
>> @@ -77,12 +79,13 @@ static int dm_test_cmd_hash_sha256(struct unit_test_state *uts)
>>                          strstr(uts->actual_str, "sha256 for "));
>>          ut_assert(strstr(uts->actual_str,
>>                           "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"));
>> -       ut_check_console_line(uts,
>> -                             "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855");
>> +       ut_assertok(ut_check_console_line(
>> +                       uts, "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"));
>>
>>          if (!CONFIG_IS_ENABLED(HASH_VERIFY)) {
>>                  ut_assert(run_command("hash -v sha256 $loadaddr 0 foo", 0));
>> -               ut_check_console_line(uts, "hash - compute hash message digest");
>> +               ut_assertok(ut_check_console_line(
>> +                               uts, "hash - compute hash message digest"));
>>
>>                  return 0;
>>          }
>> --
>> 2.45.2
>>
> 
> Regards,
> Simon

