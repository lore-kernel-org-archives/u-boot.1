Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91868C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 09:33:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0AE087955;
	Mon,  8 Jan 2024 10:33:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="qNxEZqex";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2173487A30; Mon,  8 Jan 2024 10:33:11 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 130778793A
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 10:33:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1704706388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6CikwUTAdDZHHMZcxflMkZZ1O9Sun8unN/Bw4sAiDGg=;
 b=qNxEZqexeYhpXSYr+fRhzMI319ZrKHQuGCTB39cdtBdenHPdG3gzJIg9C0gJYPlpi7eOMj
 4xkEqtAu7b/NGbFXmxbmk90zbI11wb1ZCCbRDQhgh/yJE0B1jcFd3BOBZOJFPrM7KG3xy3
 wgRW2Vd3+JM7X1QF7X9i/l8Dawx1Eha/nFvE/yPnvYyu19dS5HUAYn77oBs1lyTqzECbLX
 YLjEIETsxEJkOqXnByvLZOG+PtZ2vXaF7cV+D1k1jIs9nhE9MPFYkXme3kA1+UGeP33qtE
 bjq1SnjP3SzR5hDu8IHbXWRwwRsUT5ScmVJTeD2feGO41O4kralfLC+7GFJCuw==
Date: Mon, 08 Jan 2024 10:33:07 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, bmeng.cn@gmail.com
Subject: Re: [PATCH 2/2] coreboot: Switch to a monospaced font
In-Reply-To: <874jfouq9e.fsf@bloch.sibelius.xs4all.nl>
References: <20240108001455.35638-1-sjg@chromium.org>
 <20240108001455.35638-2-sjg@chromium.org>
 <874jfouq9e.fsf@bloch.sibelius.xs4all.nl>
Message-ID: <6beec0824542ac0608a5dfad9b88d32a@manjaro.org>
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

On 2024-01-08 10:29, Mark Kettenis wrote:
>> From: Simon Glass <sjg@chromium.org>
>> Date: Sun,  7 Jan 2024 17:14:55 -0700
>> 
>> The default font is proportional, with different character widths.
>> Select a monospace font for coreboot so that the 'dm tree' output 
>> lines
>> up correctly.
>> 
>> Update the coreboot tests to match.
> 
> To be honest, I think defaulting to a proportional font is wrong as a
> default for something like U-Boot.

I agree, it makes very little sense to default to a proportional font.

>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> ---
>> 
>>  configs/coreboot64_defconfig |  3 +++
>>  configs/coreboot_defconfig   |  3 +++
>>  test/cmd/font.c              | 12 +++++++++---
>>  3 files changed, 15 insertions(+), 3 deletions(-)
>> 
>> diff --git a/configs/coreboot64_defconfig 
>> b/configs/coreboot64_defconfig
>> index 49c982ef756..c4571090859 100644
>> --- a/configs/coreboot64_defconfig
>> +++ b/configs/coreboot64_defconfig
>> @@ -64,6 +64,9 @@ CONFIG_SOUND=y
>>  CONFIG_SOUND_I8254=y
>>  CONFIG_VIDEO_COPY=y
>>  CONFIG_CONSOLE_TRUETYPE=y
>> +CONFIG_CONSOLE_TRUETYPE_SIZE=20
>> +# CONFIG_CONSOLE_TRUETYPE_NIMBUS is not set
>> +CONFIG_CONSOLE_TRUETYPE_ANKACODER=y
>>  CONFIG_CONSOLE_SCROLL_LINES=5
>>  CONFIG_SPL_ACPI=y
>>  CONFIG_CMD_DHRYSTONE=y
>> diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
>> index d4e44e00dca..7aa841bb54b 100644
>> --- a/configs/coreboot_defconfig
>> +++ b/configs/coreboot_defconfig
>> @@ -61,6 +61,9 @@ CONFIG_SOUND=y
>>  CONFIG_SOUND_I8254=y
>>  CONFIG_VIDEO_COPY=y
>>  CONFIG_CONSOLE_TRUETYPE=y
>> +CONFIG_CONSOLE_TRUETYPE_SIZE=20
>> +# CONFIG_CONSOLE_TRUETYPE_NIMBUS is not set
>> +CONFIG_CONSOLE_TRUETYPE_ANKACODER=y
>>  CONFIG_CONSOLE_SCROLL_LINES=5
>>  CONFIG_CMD_DHRYSTONE=y
>>  # CONFIG_GZIP is not set
>> diff --git a/test/cmd/font.c b/test/cmd/font.c
>> index 9c1eebf799e..ee1c610106d 100644
>> --- a/test/cmd/font.c
>> +++ b/test/cmd/font.c
>> @@ -29,14 +29,20 @@ static int font_test_base(struct unit_test_state 
>> *uts)
>> 
>>  	ut_assertok(console_record_reset_enable());
>>  	ut_assertok(run_command("font list", 0));
>> -	ut_assert_nextline("nimbus_sans_l_regular");
>> +	if (IS_ENABLED(CONFIG_CONSOLE_TRUETYPE_NIMBUS))
>> +		ut_assert_nextline("nimbus_sans_l_regular");
>> +	if (IS_ENABLED(CONFIG_CONSOLE_TRUETYPE_ANKACODER))
>> +		ut_assert_nextline("ankacoder_c75_r");
>>  	if (IS_ENABLED(CONFIG_CONSOLE_TRUETYPE_CANTORAONE))
>>  		ut_assert_nextline("cantoraone_regular");
>>  	ut_assertok(ut_check_console_end(uts));
>> 
>>  	ut_assertok(vidconsole_get_font_size(dev, &name, &size));
>> -	ut_asserteq_str("nimbus_sans_l_regular", name);
>> -	ut_asserteq(18, size);
>> +	if (IS_ENABLED(CONFIG_CONSOLE_TRUETYPE_ANKACODER))
>> +		ut_asserteq_str("ankacoder_c75_r", name);
>> +	else
>> +		ut_asserteq_str("nimbus_sans_l_regular", name);
>> +	ut_asserteq(CONFIG_CONSOLE_TRUETYPE_SIZE, size);
>> 
>>  	if (!IS_ENABLED(CONFIG_CONSOLE_TRUETYPE_CANTORAONE))
>>  		return 0;
>> --
>> 2.34.1
>> 
>> 
