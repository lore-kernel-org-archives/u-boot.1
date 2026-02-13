Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBF3EF99E1
	for <u-boot@archiver.kernel.org>; Sat, 14 Feb 2026 04:59:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EAD383E72;
	Sat, 14 Feb 2026 05:59:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="KjVoAGuW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D723983AAB; Sat, 14 Feb 2026 03:51:21 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5435780B98
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 03:51:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CBF0610EB0F; Sat, 14 Feb 2026 03:51:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1771037477;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=YYnlvmAUJVVySSX3IooUPnF7BTdr1q6F8t3/ccjDATI=;
 b=KjVoAGuWCuqZJWngN7ealibPrcrX2vOkyhjZ4KAsFD1bbhFIwfkRk1aAIhXXAg1XxO0ZIa
 bn+9/3ai0ZWD03Hhyo/wTpyxBycelHvhO7w3/ZRk9iRKhFGPcMUIshyXSCzU5FWjLaR+At
 EDGN/pCNTIzrX3FOvHGkUQDx454cBu7nS8yWWMdilQf3yEWAkqhO59uW1ufyD2qrZ6qApJ
 1rm+wGPKKb/fGH3GpR8aYqG10mNcPDjt9ESunNIoDJv1EMHdIzpgGZWMcO/+POLKo9J3kL
 XK/o3KStFsQm8H+kTYadFgfpmxY+TMda8duye+QPUJt9VZ8tOcbyW+M5xh13mg==
Message-ID: <c3d59858-9855-47fd-aa5a-0b861c4e44e8@nabladev.com>
Date: Fri, 13 Feb 2026 22:56:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] binman: add CST backend selection for i.MX8M signing
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <20260213192838.157084-1-marex@nabladev.com>
 <CAFLszTjHZ+a17+bZh17DMOJGny6VaWCe4EftpYRE1Bq+RAty4Q@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <CAFLszTjHZ+a17+bZh17DMOJGny6VaWCe4EftpYRE1Bq+RAty4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Sat, 14 Feb 2026 05:59:31 +0100
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

On 2/13/26 9:20 PM, Simon Glass wrote:

Hello Simon,

>> diff --git a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
>> index 1bea091344d..a3ebd397d82 100644
>> --- a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
>> +++ b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
>> @@ -167,17 +167,25 @@ The nxp-imx8mcst etype is configurable using either DT properties or environment
>>   variables. The following DT properties and environment variables are supported.
>>   Note that environment variables override DT properties.
>>
>> -+--------------------+-----------+------------------------------------------------------------------+
>> -| DT property        | Variable  | Description                                                      |
>> -+====================+===========+==================================================================+
>> -| nxp,loader-address |           | SPL base address                                                 |
>> -+--------------------+-----------+------------------------------------------------------------------+
>> -| nxp,srk-table      | SRK_TABLE | full path to SRK_1_2_3_4_table.bin                               |
>> -+--------------------+-----------+------------------------------------------------------------------+
>> -| nxp,csf-crt        | CSF_KEY   | full path to the CSF Key CSF1_1_sha256_4096_65537_v3_usr_crt.pem |
>> -+--------------------+-----------+------------------------------------------------------------------+
>> -| nxp,img-crt        | IMG_KEY   | full path to the IMG Key IMG1_1_sha256_4096_65537_v3_usr_crt.pem |
>> -+--------------------+-----------+------------------------------------------------------------------+
>> ++--------------------+-------------+------------------------------------------------------------------+
>> +| DT property        | Variable    | Description                                                      |
>> ++====================+=============+==================================================================+
>> +| nxp,loader-address |             | SPL base address                                                 |
>> ++--------------------+-------------+------------------------------------------------------------------+
>> +| nxp,srk-table      | SRK_TABLE   | full path to SRK_1_2_3_4_table.bin                               |
>> ++--------------------+-------------+------------------------------------------------------------------+
>> +| nxp,csf-crt        | CSF_KEY     | full path to the CSF Key CSF1_1_sha256_4096_65537_v3_usr_crt.pem |
>> ++--------------------+-------------+------------------------------------------------------------------+
>> +| nxp,img-crt        | IMG_KEY     | full path to the IMG Key IMG1_1_sha256_4096_65537_v3_usr_crt.pem |
>> ++--------------------+-------------+------------------------------------------------------------------+
>> +| nxp,fast-auth      |             | enable fast authentication method                                |
>> ++--------------------+-------------+------------------------------------------------------------------+
>> +| nxp,srk-crt        | SRK_KEY     | full path to the SRK Key SRK1_sha256_4096_65537_v3_ca_crt.pem    |
>> ++--------------------+-------------+------------------------------------------------------------------+
>> +| nxp,unlock         |             | unlock CAAM in SPL                                               |
>> ++--------------------+-------------+------------------------------------------------------------------+
>> +| nxp,cst-backend    | CST_BACKEND | CST tool backend, default is 'ssl', or selectable 'pkcs11'       |
>> ++--------------------+-------------+------------------------------------------------------------------+
> 
> Perhaps point to an example?

Example of what ? Two lines below, there is an example of using those 
env vars, see the entire file.

>>   Environment variables can be set as follows to point the build process
>>   to external key material:
>> diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
>> index 8922d6cd070..29bc778d0e5 100644
>> --- a/tools/binman/entries.rst
>> +++ b/tools/binman/entries.rst
>> @@ -1664,6 +1664,13 @@ Entry: nxp-imx8mcst: NXP i.MX8M CST .cfg file generator and cst invoker
>>
>>   Properties / Entry arguments:
>>       - nxp,loader-address - loader address (SPL text base)
>> +    - nxp,srk-table - full path to SRK_1_2_3_4_table.bin
>> +    - nxp,csf-crt - full path to the CSF Key CSF1_1_sha256_4096_65537_v3_usr_crt.pem
>> +    - nxp,img-crt - full path to the IMG Key IMG1_1_sha256_4096_65537_v3_usr_crt.pem
>> +    - nxp,fast-auth - enable fast authentication method
>> +    - nxp,srk-crt - full path to the SRK Key SRK1_sha256_4096_65537_v3_ca_crt.pem
>> +    - nxp,unlock - unlock CAAM in SPL
>> +    - nxp,cst-backend - CST tool backend, default is 'ssl', or selectable 'pkcs11'
>>
> 
> The way it works is you add this as a comment in nxp_imx8mcst.py and
> then run 'binman entry-docs' to generate entries.rst - see here:
> 
> https://docs.u-boot.org/en/latest/develop/package/binman.html#entry-documentation
Why is there this entries.rst then ? Should the entries be removed from 
here and moved into the py file or what is this inconsistency ?
