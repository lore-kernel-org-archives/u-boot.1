Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F205C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 21:25:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 500C187775;
	Wed, 31 Jan 2024 22:25:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="SfJPppeQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DDE387776; Wed, 31 Jan 2024 22:25:41 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1217486E96
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 22:25:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from [192.168.123.161] (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 4A26C3F289; 
 Wed, 31 Jan 2024 21:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706736337;
 bh=1mSwQBH7Lnv4csrQup0EscvwbDSlMMR7CN9E/L/q/tM=;
 h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
 In-Reply-To:Content-Type;
 b=SfJPppeQ1XXSAKAOnqO4RE+rWDTLJNJJ1AEzgHeXj3lGvrO+TeAUPL++XZxyBz748
 0lEEHXvLVakIs5zS4ysmCnTwKQxB7x/QKUQgT0XqhvfTm6jSgMmezz9HPKSi7QZNnu
 42wDBJmsGqw0CKqdnhUcV1kKOhXiY8JayQMpBUqpmMNn6ymBpen/xOvYCesFKE9SiL
 QkquvJU0dZKXQbSU0xiiolZPnwi+KC3dJRX6Y5bWotr/eHjqqxpZUJkj4c0nba5HGw
 Y0oc7g7DTFS3XDqhgB+b9yozR1evNO7ymmGOfOGO0tjF8S/LRQS97r3xoz69KLMXkJ
 vuUJHo2QpoedQ==
Message-ID: <37443c99-3cb2-4473-ae94-0284a49d7acf@canonical.com>
Date: Wed, 31 Jan 2024 22:25:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] smbios: Fix table when no string is present
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
References: <20210406090435.19357-1-matthias.bgg@kernel.org>
 <CAPnjgZ2Cw2GiH4D195N9Socg84paB9G7oZumr1xrESgoNcby5Q@mail.gmail.com>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAPnjgZ2Cw2GiH4D195N9Socg84paB9G7oZumr1xrESgoNcby5Q@mail.gmail.com>
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

On 4/7/21 18:14, Simon Glass wrote:
> Hi Matthias,
> 
> On Tue, 6 Apr 2021 at 21:04, <matthias.bgg@kernel.org> wrote:
>>
>> From: Matthias Brugger <mbrugger@suse.com>
>>
>> When no string is present in a table, next_ptr points to the same
>> location as eos. When calculating the string table length, we would only
>> reserve one \0. By spec a SMBIOS table has to end with two \0\0 when no
>> strings a present.
>>
>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>>
>> ---
>>
>> Changes in v2:
>> - check in smbios_string_table_len if no string present and return value
>>    accordingly
> 
> This looks like a better idea to me. But where are the \0 bytes
> actually written? Perhaps that should be in smbios_set_eos()?

We have defined SMBIOS_STRUCT_EOS_BYTES as 2 and we have an array
char eos[SMBIOS_STRUCT_EOS_BYTES];
at the end of each SMBIOS structure.

We call memset(t, 0, sizeof(struct smbios_typeX)); for each table.
This is enough to ensure two zero bytes exist if there are no strings.

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> 
>>
>>   lib/smbios.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/lib/smbios.c b/lib/smbios.c
>> index 9eb226ec9f..fd57d8694f 100644
>> --- a/lib/smbios.c
>> +++ b/lib/smbios.c
>> @@ -191,6 +191,10 @@ int smbios_update_version(const char *version)
>>    */
>>   static int smbios_string_table_len(const struct smbios_ctx *ctx)
>>   {
>> +       /* In case no string is defined we have to return two \0 */
>> +       if (ctx->next_ptr == ctx->eos)
>> +               return 2;
>> +
>>          /* Allow for the final \0 after all strings */
>>          return (ctx->next_ptr + 1) - ctx->eos;
>>   }
>> --
>> 2.30.2
>>
> 
> Regards,
> Simon
> 

