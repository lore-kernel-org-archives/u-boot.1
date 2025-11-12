Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BE4CCFA1A
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 04:44:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CFA783AB4;
	Wed, 12 Nov 2025 05:44:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="BOEZUnDL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0CFB83B81; Wed, 12 Nov 2025 05:44:53 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F32D583AAD
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 05:44:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3734410A706; Wed, 12 Nov 2025 05:44:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1762922691;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=pX0DsBrgGA0DR1EHT4PDDTa6bC2XPj+J48yo8zZuN/M=;
 b=BOEZUnDLYuxh+5e46UlQj36ZTpH33EP8rlG5Piv+CmmJfaCXgL7FK/JfeBwChRGRD7p+aG
 zHC5k7CKkzlmlDoUxqJVsJVPzJkcxKaJPHeQxzozHL2Ql98nlTVBhpT1XIOYw2GwmrvYni
 Y2PZMs0dfcL7Wvm2ljxvNntfJ5S6i+Qi8jsiaa+KUpu6kcz2klIT9+SETmODAiOSOHha3/
 U6qiYMRZr0VM+IMuqGWBlTZ+Ivm+5qY/2JXy3dHaVeDGvcurCQZeirCTD8Mv4wisSb3f5n
 EudiraFs/7SftgKjTVJAGGZeVBBvFzGOXaqvrV0v2Guo0SYEwEoURZMMweCE3g==
Message-ID: <d50ea803-18fc-f928-8d2e-56eb20f8ead4@nabladev.com>
Date: Wed, 12 Nov 2025 05:44:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
From: Heiko Schocher <hs@nabladev.com>
Subject: Re: [PATCH v2 3/5] test: cmd: hash: add unit test for sm3_256
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>
References: <20251111054813.1966-1-hs@nabladev.com>
 <20251111054813.1966-4-hs@nabladev.com>
 <AF767FFD-6798-455F-A1C8-F433C509680A@gmx.de>
Content-Language: en-US
In-Reply-To: <AF767FFD-6798-455F-A1C8-F433C509680A@gmx.de>
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

Hello Heinrich,

On 11.11.25 07:39, Heinrich Schuchardt wrote:
> Am 11. November 2025 06:48:10 MEZ schrieb Heiko Schocher <hs@nabladev.com>:
>> add simple test for sm3 256 hash
>>
>> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>> ---
>> I wonder why this tests are under DM and not under CMD
>> Should we move them to CMD ?
> 
> We should use CMD_TEST() in the test/cmd/  directory.

I aggree... candidates would be:

$ grep -lr DM_TEST test/cmd
test/cmd/temperature.c
test/cmd/pwm.c
test/cmd/hash.c
test/cmd/pinmux.c
test/cmd/rw.c
test/cmd/armffa.c
test/cmd/loadm.c
test/cmd/i3c.c

but that change should be done in seperate series...

I can make such a series, if this one is acceppted?

Thanks!

bye,
Heiko

> 
> Best regards
> 
> Heinrich
> 
>>
>> Ignored checkpatch warnings for too long lines.
>>
>> (no changes since v1)
>>
>> test/cmd/hash.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 46 insertions(+)
>>
>> diff --git a/test/cmd/hash.c b/test/cmd/hash.c
>> index bb96380c351..3f7f64d27d3 100644
>> --- a/test/cmd/hash.c
>> +++ b/test/cmd/hash.c
>> @@ -103,3 +103,49 @@ static int dm_test_cmd_hash_sha256(struct unit_test_state *uts)
>> 	return 0;
>> }
>> DM_TEST(dm_test_cmd_hash_sha256, UTF_CONSOLE);
>> +
>> +static int dm_test_cmd_hash_sm3_256(struct unit_test_state *uts)
>> +{
>> +	const char *sum = "1ab21d8355cfa17f8e61194831e81a8f22bec8c728fefb747ed035eb5082aa2b";
>> +
>> +	if (!CONFIG_IS_ENABLED(SM3)) {
>> +		ut_assert(run_command("hash sm3_256 $loadaddr 0", 0));
>> +
>> +		return 0;
>> +	}
>> +
>> +	ut_assertok(run_command("hash sm3_256 $loadaddr 0", 0));
>> +	console_record_readline(uts->actual_str, sizeof(uts->actual_str));
>> +	ut_asserteq_ptr(uts->actual_str,
>> +			strstr(uts->actual_str, "sm3_256 for "));
>> +	ut_assert(strstr(uts->actual_str, sum));
>> +	ut_assert_console_end();
>> +
>> +	ut_assertok(run_command("hash sm3_256 $loadaddr 0 foo; echo $foo", 0));
>> +	console_record_readline(uts->actual_str, sizeof(uts->actual_str));
>> +	ut_asserteq_ptr(uts->actual_str,
>> +			strstr(uts->actual_str, "sm3_256 for "));
>> +	ut_assert(strstr(uts->actual_str, sum));
>> +	ut_assertok(ut_check_console_line(uts, sum));
>> +
>> +	if (!CONFIG_IS_ENABLED(HASH_VERIFY)) {
>> +		ut_assert(run_command("hash -v sm3_256 $loadaddr 0 foo", 0));
>> +		ut_assertok(ut_check_console_line(uts,
>> +						  "hash - compute hash message digest"));
>> +
>> +		return 0;
>> +	}
>> +
>> +	ut_assertok(run_command("hash -v sm3_256 $loadaddr 0 foo", 0));
>> +	ut_assert_console_end();
>> +
>> +	env_set("foo",
>> +		"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff");
>> +	ut_assert(run_command("hash -v sm3_256 $loadaddr 0 foo", 0));
>> +	console_record_readline(uts->actual_str, sizeof(uts->actual_str));
>> +	ut_assert(strstr(uts->actual_str, "!="));
>> +	ut_assert_console_end();
>> +
>> +	return 0;
>> +}
>> +DM_TEST(dm_test_cmd_hash_sm3_256, UTF_CONSOLE);
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
