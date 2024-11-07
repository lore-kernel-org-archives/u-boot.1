Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54B0D43341
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 11:22:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 477308925C;
	Thu,  7 Nov 2024 12:22:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730978564;
	bh=2hF7EeD9CDT1TwCXHOBHJ3x0pOBa4HglaZ/fHMCriSQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gt4ZsG6UL/uWThCmE4s4P/Nok+0V1Nk/ytiraWWVvGJ1meVcBc4jOoErIG9YpfS8x
	 iZPuOHezGwJgZxtdExKAyLQ2cfV4RmkYDEy8epxkez/axADIjBHA7tH8u7WUN48L0D
	 OJs6ivpYr+A0PLroD6fGhamrvNVjiQTpRU/gI3SMXkRQO2qFFqtTWM1zClPu6wzyWW
	 fR4njaap3GrammrPOm3w0w0mXuHwmOyoj8JUzRKy9MnsBoF8CEHFkEDAQeyYBwyxDD
	 OidgtrKrsCe7jRluszjmC6iNTnpC3wXlC1/d2eXkM/RGU2bgDA0k306BWUgi/FZn7o
	 +lamMrV9SUhIQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A514989235;
 Thu,  7 Nov 2024 12:22:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1730978563;
 bh=2hF7EeD9CDT1TwCXHOBHJ3x0pOBa4HglaZ/fHMCriSQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=AzWzZbLkXE+Txh+7sCzaubX8c4ghbk5ZErPmVo8hqSJLcDx+QA+Vf/UA3FHLdNAyG
 e3JcVfUm3QXjXe8dr8AzSBv9UliYdbTP/pgD98FoGWMphdYtkjaypXDqazkt9G1aTs
 060iFKyOSKl4g5n0ZFiFrwbQBukkSbBsEERe+AEjPDvz2bFQRenV1H71ZlgphKivZX
 hFKxvq9WneqjxJ91SptcIWCuzlRLp31TVR6r2QfSQ0deSWDW/X5SRE8c2FxBFllod3
 3BMFK6/5XL9FnEacY7NgkdfrQVd1Od0kYfiVB3osrT5vYZk63cF8GSLt1H/lx4HEuZ
 xdF2Vorv722EA==
Message-ID: <bbe6d1c9-c0a8-4339-8b6a-183af5df64d5@denx.de>
Date: Thu, 7 Nov 2024 11:51:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] lib: provide function hextoull()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen
 <tuomas.tynkkynen@iki.fi>, Raymond Mao <raymond.mao@linaro.org>,
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 u-boot@lists.denx.de
References: <20241103224223.195255-1-heinrich.schuchardt@canonical.com>
 <20241103224223.195255-2-heinrich.schuchardt@canonical.com>
 <CAC_iWjLdYM-TaLUa8pJiv-8FCjw3mr+cB_8L3NrepTKKcqcPsA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAC_iWjLdYM-TaLUa8pJiv-8FCjw3mr+cB_8L3NrepTKKcqcPsA@mail.gmail.com>
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

On 11/7/24 10:45 AM, Ilias Apalodimas wrote:
> On Sun, 3 Nov 2024 at 22:42, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> We often convert hexadecimal strings to hextoull(). Provide a wrapper
>> function to simple_strtoull() that does not require specifying the radix.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> v2:
>>          no change
>> ---
>>   include/vsprintf.h | 13 +++++++++++++
>>   lib/strto.c        |  5 +++++
>>   2 files changed, 18 insertions(+)
>>
>> diff --git a/include/vsprintf.h b/include/vsprintf.h
>> index fe951471426..9da6ce7cc4d 100644
>> --- a/include/vsprintf.h
>> +++ b/include/vsprintf.h
>> @@ -44,6 +44,19 @@ ulong simple_strtoul(const char *cp, char **endp, unsigned int base);
>>    */
>>   unsigned long hextoul(const char *cp, char **endp);
>>
>> +/**
>> + * hex_strtoull - convert a string in hex to an unsigned long long
>> + *
>> + * @cp: The string to be converted
>> + * @endp: Updated to point to the first character not converted
>> + * Return: value decoded from string (0 if invalid)
>> + *
>> + * Converts a hex string to an unsigned long long. If there are invalid
>> + * characters at the end these are ignored. In the worst case, if all characters
>> + * are invalid, 0 is returned
>> + */
>> +unsigned long long hextoull(const char *cp, char **endp);
>> +
>>   /**
>>    * dec_strtoul - convert a string in decimal to an unsigned long
>>    *
>> diff --git a/lib/strto.c b/lib/strto.c
>> index f83ac67c666..206d1e91847 100644
>> --- a/lib/strto.c
>> +++ b/lib/strto.c
>> @@ -78,6 +78,11 @@ ulong hextoul(const char *cp, char **endp)
>>          return simple_strtoul(cp, endp, 16);
>>   }
>>
>> +unsigned long long hextoull(const char *cp, char **endp)
>> +{
>> +       return simple_strtoull(cp, endp, 16);
>> +}
>> +
>>   ulong dectoul(const char *cp, char **endp)
>>   {
>>          return simple_strtoul(cp, endp, 10);
>> --
>> 2.45.2
>>
> 
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

+CC Jaehoon
