Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BD5C02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 21:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BED380326;
	Tue, 21 Jan 2025 22:32:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=rwahl@gmx.de header.b="lptMpQeU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C29D80214; Tue, 21 Jan 2025 19:56:21 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24341801F5
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 19:56:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rwahl@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1737485775; x=1738090575; i=rwahl@gmx.de;
 bh=xHGK9rx0VqsVStNBTE9DU79FspODRe5aytnoDvOEBkk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=lptMpQeUI1RLKuUFgugcPhxnZp5nKqnBS4VvOM1sNjalEfeWWJu8T1Km8RSHjaQU
 MJrWppS/6su9Ky0ljE/0UoP2JkAkh2t9wjM7OhwzG03g96HsKVAk8e8F+LbaAQBPW
 +8VLaACMNCnrReSqdumhkE2B9q5eXvTwqCz+s+V6xNSGl0wbLhCp/xij/B1OhGD21
 adSMFRbfXuOh9g1n6/IqoAEcJAcKoe9Cis6Pk27/t95cWhChqo6FxETmzAuwlQsH4
 gdA2XotBtdtqAeFrkP2Puy6WbU95mTv+K/MGtVm2hBd0ec8zaiNXnj12ApOncodkP
 KPD3K0mYkKxsEByllA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.24] ([84.156.157.89]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6KYb-1tTChq2hxJ-00tIq0; Tue, 21
 Jan 2025 19:56:15 +0100
Message-ID: <46be5054-40db-473e-a80a-773828373d45@gmx.de>
Date: Tue, 21 Jan 2025 19:56:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: cadence-quadspi: fix potential malfunction after ~49
 days uptime
Content-Language: en-US
To: Vignesh Raghavendra <vigneshr@ti.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>
Cc: Ronald Wahl <ronald.wahl@legrand.com>, Pratyush Yadav <p.yadav@ti.com>
References: <20241211205104.16099-1-rwahl@gmx.de>
 <4fb19397-0e3c-4717-9562-1befdf3b52cb@ti.com>
From: Ronald Wahl <rwahl@gmx.de>
In-Reply-To: <4fb19397-0e3c-4717-9562-1befdf3b52cb@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jD4VxgebXAgSoyuuXH9Fnvte3sJX4l0X651T2s1ihg5Y5HXTCXh
 pngQgsvNBVvb1SUggpYYTEMc5VTOtZzFFt4iUmtNI7DlyYybqxP+rdD7Eqe4sYyc3rTvPWp
 81ThIOloOp7p66L23FjpKD5PwM6B+kEmWxWPKYSkPzdiZKHg4uqg7BAfwqIMxxmLKLGo184
 LDkxZLXODN32hvZPVqTIQ==
UI-OutboundReport: notjunk:1;M01:P0:IZ+vyOO0Y/4=;5IjjqKGsEzVrUncrI3UccLO62im
 OzdiVQdsD3phUdCZGDLUI1Ck4pI9lLuVtJ3kzs8F3sXu4KWiirjmIO5O2r5dfg5sRy4AfeERY
 +QYcCZF3ClwAXwZZarHC9rZJ8moJruK8QmAokIzPHITYyjyorJ33fx5UNNO346gacObBAHL5q
 c5XbeBhBpBLiBmHSJGdUtYrcdB18wZ1majlwLDhkyEUMiOVa1YQSKzv2MWZR2xnUD9v23EPWv
 hjURspug+BskpFIZRRNm4+k6JWWx7ndbEH28bSORaJ9fUy6tPCzDXWFzlrZPzkZTQr054X8bj
 a9AeeigZAZYOcW6HDL2CP32IU7SOG6wX5UOoNc5o5sICxqdfYA0y5bHm0P0mXzR1AILoUhZK4
 tHKFBz31UGVg5jLNWhBIQ1UWW4qO8SBMZkEfXCqC8fTAWPye6EtgXfQSvPcJOANV7zw8zikJT
 eT+kWoJ9zjJlXcI8WriVjrdrr7Rl+VoCbhVxbn2SkLBhJ9rqipuJsKwtHSKoDaG0piShA/3zb
 CCpFGmRGgB6UsPZIE/HkyTU/wUENcCC5PMIyV8cGvAZYCuR6hapiZDle6QXcyUd+F2L4qhZ5S
 WFbj+x0enU5NT2DCwY75wzyVz2fV0tkmFDQXmmQ2RlJiSOHpXIayopMttmhFM8n7hXb24JiH2
 0Y5gD8WZXi1IIy7vfIIc/j+ecChsEoQ/CbhlWoUvJ9f81LKOC1wfABn4yqZTgBIbWnqMV1BsF
 9x6TxVX0+Ra2UO7YC0pHbSrXNqgFgaj4J62EgAMF/PNDPyIp17BE2AsPSV47xi7oUoKWypQc4
 RUY+E+idc0iQtq5yWLXJ+mqEPNv7zBl/+CppQJqRCpajcBvn2nIkd8f+YV89U+gipOfR5L6j6
 WBW74zMaK36rbFj30nuiN4vrkZXqRcNw7D1fycgb9FQ/T+N91ZzkngAu9MgfEEB/9sSTxnd9L
 a7oO5OlWaCsbplgTQSA4PtI58B2S0kNIwWjci3BwIsH/nHnPpArYAXbWNgO545mPxaJROWczr
 8xkilXVZoBVKL9/c6yaAt8kpi9xnDPLT8zOOae7g4RZvrJb/84Fysq0OLPEuCE6YhKQx90yiJ
 l+gKyXdalA8zKxH9frm+6pvh4gee1cJ2rudpXjJ27mvHYSvE7qm7kooldAs+e9QsEgZY7YNDa
 fZMD48MW95K5WxfkH1fz3rJ8XbHiZ5KXH9I7vPZQCExViCRLfLv/glq8Zfk52PZEvqxI8y0PP
 UJMyDdsJ3/d4yqeQpgPVy4F4v5wCT6vx9+uuqnN90n+e/U2PAaCQMt4SxMnCA8bQWxl6P9EN2
 djWVHUsJr75VGNcAvSj9Z8n+w==
X-Mailman-Approved-At: Tue, 21 Jan 2025 22:32:49 +0100
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

On 13.12.24 07:04, Vignesh Raghavendra wrote:
> + tom and jagan

Jagan seems to be missing. Does anyone know something?
There are a number of patches on patchwork waiting for approval or review.

> On 12/12/24 02:21, Ronald Wahl wrote:
>> From: Ronald Wahl <ronald.wahl@legrand.com>
>>
>> The get_timer function returns an unsigned long which may be calculated
>> from the ARM system counter. This counter is reset only on a cold reset=
.
>> U-boot divides this counter down to a 1000 Hz counter that will cross
>> the 32bit barrier after a bit more than 49 days. Assigning the value to
>> an unsigned int will truncate it on 64bit systems.
>> Passing this truncated value back to the get_timer function will return
>> a very large value that is certainly larger than the timeout and so wil=
l
>> go down the error path and besides stopping U-Boot will lead to message=
s
>> like
>>
>>      "SPI: QSPI is still busy after poll for 5000 ms."
>
> Thanks a lot for fixing this!
>
> Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
>
>
>>
>> Signed-off-by: Ronald Wahl <ronald.wahl@legrand.com>
>> Cc: Vignesh R <vigneshr@ti.com>
>> Cc: Pratyush Yadav <p.yadav@ti.com>
>> ---
>>   drivers/spi/cadence_qspi_apb.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_=
apb.c
>> index 93ab2b5635..f2f69cf9f1 100644
>> --- a/drivers/spi/cadence_qspi_apb.c
>> +++ b/drivers/spi/cadence_qspi_apb.c
>> @@ -151,9 +151,9 @@ static int cadence_qspi_set_protocol(struct cadence=
_spi_priv *priv,
>>   /* Return 1 if idle, otherwise return 0 (busy). */
>>   static unsigned int cadence_qspi_wait_idle(void *reg_base)
>>   {
>> -	unsigned int start, count =3D 0;
>> +	unsigned long start, count =3D 0;
>>   	/* timeout in unit of ms */
>> -	unsigned int timeout =3D 5000;
>> +	unsigned long timeout =3D 5000;
>>
>>   	start =3D get_timer(0);
>>   	for ( ; get_timer(start) < timeout ; ) {
>> @@ -170,7 +170,7 @@ static unsigned int cadence_qspi_wait_idle(void *re=
g_base)
>>   	}
>>
>>   	/* Timeout, still in busy mode. */
>> -	printf("QSPI: QSPI is still busy after poll for %d ms.\n", timeout);
>> +	printf("QSPI: QSPI is still busy after poll for %lu ms.\n", timeout);
>>   	return 0;
>>   }
>>
>> --
>> 2.47.1
>>
>

