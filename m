Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E615FD3E783
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 02:32:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A03389035;
	Wed,  6 Nov 2024 03:32:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E60B89035; Wed,  6 Nov 2024 02:55:04 +0100 (CET)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07A3388E61
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 02:54:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=hal.feng@linux.starfivetech.com
X-QQ-mid: bizesmtp80t1730858030t480j645
X-QQ-Originating-IP: ABMH4p86u2y6wk7SF55mCDwPvCBC+TD+Ih7LyhYs66U=
Received: from [192.168.125.182] ( [183.27.96.2])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 06 Nov 2024 09:53:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17127929888059590232
Message-ID: <D2C5F4328791C564+9a1aca07-371e-4951-9f51-4e6a96f8ea10@linux.starfivetech.com>
Date: Wed, 6 Nov 2024 09:53:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/13] board: starfive: spl: Support multiple DTBs for
 JH7110 based boards
Content-Language: en-US
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de,
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 H Bell <dmoo_dv@protonmail.com>, E Shattow <lucent@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
References: <20241105034328.56439-1-hal.feng@starfivetech.com>
 <20241105034328.56439-14-hal.feng@starfivetech.com>
 <e0ee937c-5e73-4055-affb-2a6314608c87@gmx.de>
From: Hal Feng <hal.feng@linux.starfivetech.com>
In-Reply-To: <e0ee937c-5e73-4055-affb-2a6314608c87@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: OS13ZwQ+ChhZuPokF6J4JSFspsTi0ePLNnd1pep8DkiUhIXYR+3XrAzS
 LJ69LvoHVILqKTk/YhEeehRRpwnpb1V+1vmg01JKuVidLNhgkE3WaaJTZDcYynOXwGUWdGy
 gV80idAtUUED5mVyGQ8fBA+lbf3Jfgxbl+3cjZSQCJZHKLN0aeXPtgJH09CnHMmhPaD5ecs
 rXKj9GM1iq635AN3M5G8A3O8N45bDkHRKOjFGvebu1xjIa759FqG5B7yikekdR3MbF/vTz5
 Yq0A5NMnkDB/NKA2FgZ4l0VtYmtSP8JB7Pf8VfS9cu5oNXNYT+R5moaBl6UEmeSuvPyrrv2
 kl6I0eZ6ajhWsLpps4Z8F1rIeIsZIE09jIGn4zgJj45tPWeHj2RGzdWJUIN2b+EjvWYLZeJ
 FX64TO/bhWsdMz5aWPaCbQf6SrEpM5e/eL1WrwAkacnLHixLkJ1Pt7eGp9fHUENMgLsvqKF
 TVFKHNNoCs7NKM+LByuSgjT+O/QeALQINZ3HKCTLTbSjlbpooHawmQqF2ee1ieqDMmDhVBk
 K6t2I7Ax5FOrjibqr00A930bXSQQ2xqik3CnxFoCSDmMuR/Kl9xVX8dIxvYuNBvlNoMiDvW
 8wN8cG8KppgHVj8jHuWK8GzJRmn6giFdQNWxqSwapnpEAzsrOnlnvRPOulvEa2UWPGiSQTG
 UkRmTj7eemokCn9WrcMwear92e6IaPcmfZqHKeTChmKozUJ1V33TvCsNmOKUIg0+R5MkY0u
 dIR2mRFnlkYIXcDVw+barMZEYB3U+FmQcYWigeAvd248x5gxKMHo4zK7KbrjWXaJUqPZHM2
 AwrKCy+16SVkK+g+fqwEykwK2SFrnHlyvzjpCu0x0AWQJLqcrwtVhZgODiK6+XeLslO/dJ3
 fq8NiwN4a0xWzDWPp7EI4EAJ0o8VSBRE35UXcBKbJ2wMeLhc7J2nUqFqh9LmEy1hkLYFDRY
 5ExdkkgtxAJTOSpFv/rCULjDM
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Wed, 06 Nov 2024 03:32:02 +0100
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

On 11/5/2024 2:47 PM, Heinrich Schuchardt wrote:
> On 11/5/24 04:43, Hal Feng wrote:
>> Get product ID and PCB version from EEPROM, use them to select
>> the correct DTB.
>>
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>   board/starfive/visionfive2/spl.c | 25 +++++++++++++++++++++++--
>>   1 file changed, 23 insertions(+), 2 deletions(-)
>>
>> diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
>> index cf7f39d5c5..4396583026 100644
>> --- a/board/starfive/visionfive2/spl.c
>> +++ b/board/starfive/visionfive2/spl.c
>> @@ -113,7 +113,28 @@ void board_init_f(ulong dummy)
>>   #if CONFIG_IS_ENABLED(LOAD_FIT)
>>   int board_fit_config_name_match(const char *name)
>>   {
>> -    /* boot using first FIT config */
>> -    return 0;
>> +    const char *product_id;
>> +    u8 version;
>> +
>> +    product_id = get_product_id_from_eeprom();
>> +
>> +    if (!strncmp(product_id, "VF7110", 6)) {
>> +        version = get_pcb_revision_from_eeprom();
>> +        if ((version == 'b' || version == 'B') &&
>> +            !strcmp(name, "jh7110-starfive-visionfive-2-v1.3b"))
>> +            return 0;
>> +
>> +        if ((version == 'a' || version == 'A') &&
>> +            !strcmp(name, "jh7110-starfive-visionfive-2-v1.2a"))
>> +            return 0;
>> +    } else if (!strncmp(product_id, "MARS", 4) &&
>> +           !strcmp(name, "jh7110-milkv-mars")) {
>> +        return 0;
> 
> Hello Hal,
> 
> I have seen
> 
> Milk-V Mars CM:      MARC-V10-2340-D004E016-xxxxxxxx
> Milk-V Mars CM lite: MARC-V10-2340-D002E016-xxxxxxxx
> 
> Obviously here they got the eMMC size wrong. Milk-V should have used
> E000 for the lite version. But at least they provide a correction
> procedure in
> https://milkv.io/docs/mars/compute-module/update-eeprom
> and confirm the usage of the values MARC and E###.
> 
> So here we should be able to detect these two boards, too.
> 
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

OK, will add detection for these two boards.
Thanks for your review.

Best regards,
Hal

> 
>> +    }  else if (!strncmp(product_id, "STAR64", 6) &&
>> +            !strcmp(name, "jh7110-pine64-star64")) {
>> +        return 0;
>> +    }
>> +
>> +    return -EINVAL;
>>   }
>>   #endif
> 
> 


