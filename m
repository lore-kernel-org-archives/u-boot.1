Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4BDD0E6F9
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 15:03:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7246E840A9;
	Tue, 25 Nov 2025 16:03:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="AXAXApO3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3A80840AC; Tue, 25 Nov 2025 16:03:33 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95B028404D
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 16:03:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dG5Y52gQSz9twb;
 Tue, 25 Nov 2025 16:03:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764083001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n9LLBfjqw/xgRhhI3s3yVcIaCkWIYat4s86lvTL0iqM=;
 b=AXAXApO3SgRvs60gskZBWifGfEuDh1W1SVVZ+F/1ehhaceaABGgdaOwpBJiDlbaUSsuegT
 /NSEjJeWTGUPLSMkWDPoRx8xkqQxVE9ppRiACFZu1WiV/+SGDPFGGlWrz6GccnGiTv6C73
 G7iidqGviSNrh7s8LItDztK9AswTeRlZVL2NirjEr81sJUHSMVhtzRH1+J0Ig6VUJ5zElN
 FJ+7pyuez8lR8wmTJz/2DYmHZfXy3vQg6xJLqGjVs0uok92xIFvYJN4wgrhUfsgryOcAy1
 brzFt7VNGNaMKz/aBlHHI2KVrAD9Xa9hVFSQyoDofbAqiJuV66mcGDG+zW64PA==
Message-ID: <4ce8899c-ae1a-4256-9a2b-76a3fbe7d533@mailbox.org>
Date: Tue, 25 Nov 2025 16:03:11 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] mkimage: Add support for bundling TEE in mkimage
 -f auto
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: =?UTF-8?Q?Carlos_L=C3=B3pez?= <carlos.lopezr4096@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 u-boot@dh-electronics.com
References: <20251124194201.83326-1-marek.vasut@mailbox.org>
 <20251124194201.83326-2-marek.vasut@mailbox.org>
 <006441da-83c5-4970-9e9a-93348126d43f@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <006441da-83c5-4970-9e9a-93348126d43f@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: nu89j6pi14crs5k7ut9rkgt6tsoc3m8i
X-MBO-RS-ID: b32618086914d75ffa5
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

On 11/25/25 12:37 PM, Quentin Schulz wrote:

Hello Quentin,

>> +++ b/doc/mkimage.1
>> @@ -251,6 +251,18 @@ Append TFA BL31 file to the image.
>>   .B \-\-tfa-bl31-addr
>>   Set TFA BL31 file load and entry point address.
>>   .
>> +.TP
>> +.B \-z
>> +.TQ
>> +.B \-\-tee-file
>> +Append TEE file to the image.
> 
> Please specify which format is supported here if only select ones are.
> 
>> +.
>> +.TP
>> +.B \-Z
>> +.TQ
>> +.B \-\-tee-addr
>> +Set TEE file load and entry point address, in hexadecimal.
> 
> s/address/addresses/ ?

This is a single address here, so no plural.

> [...]
>> @@ -239,3 +251,42 @@ def test_fit_auto_signed(ubman):
>>       generate_and_check_fit_image(' -fauto-conf' + b_args + s_args + 
>> " " + fit_file,
>>                                    scfgs=True, bl31present=True,
>>                                    key_name=key_name, 
>> sign_algo=sign_algo)
>> +
>> +    # Run the same tests as 1/2/3 above, but this time with TEE
>> +    # options -z tee.bin -Z 0x56780000 to cover both mkimage with
>> +    # and without TEE use cases.
>> +    b_args = " -d" + kernel_file + " -b" + dt1_file + " -b" + 
>> dt2_file + " -z" + tee_file + " -Z 0x56780000"
>> +
> 
> General remark but using f-string may improve readability:
> 
> b_args = f'-d {kernel_file} -b {dt1_file} -b {dt2_file} -z {tee_file} -Z 
> 0x56780000'
> 
> [...]
> 
>> @@ -473,10 +504,20 @@ static void fit_write_configs(struct 
>> image_tool_params *params, char *fdt)
>>           len = strlen(str);
>>           fdt_property_string(fdt, typename, str);
>> -        if (params->fit_tfa_bl31) {
>> +        if (params->fit_tfa_bl31 && params->fit_tee) {
>> +            snprintf(str, sizeof(str), "%s-1." FIT_TFA_BL31_PROP 
>> "-1." FIT_TEE_PROP "-1", typename);
>> +            str[len] = 0;
>> +            len += strlen(FIT_TFA_BL31_PROP "-1") + 1;
>> +            str[len] = 0;
>> +            len += strlen(FIT_TEE_PROP "-1") + 1;
>> +        } else if (params->fit_tfa_bl31) {
>>               snprintf(str, sizeof(str), "%s-1." FIT_TFA_BL31_PROP 
>> "-1", typename);
>>               str[len] = 0;
>>               len += strlen(FIT_TFA_BL31_PROP "-1") + 1;
>> +        } else if (params->fit_tee) {
>> +            snprintf(str, sizeof(str), "%s-1." FIT_TEE_PROP "-1", 
>> typename);
>> +            str[len] = 0;
>> +            len += strlen(FIT_TEE_PROP "-1") + 1;
> 
> It actually took me a while to figure out that we are reusing len from 
> outside of the if block because the loadables property starts with 
> kernel-1.
> 
> I'm wondering if it would make it more readable to do the following
> 
> if (params->fit_tfa_bl31) {
>      snprintf(&str[len + 1], sizeof(str) - (len + 1), FIT_TFA_BL31_PROP 
> "-1");
>      len += strlen(&str[len + 1]) + 1;
> }
> 
> if (params->fit_tee) {
>      snprintf(&str[len + 1], sizeof(str) - (len + 1), FIT_TEE_PROP "-1");
>      len += strlen(&str[len + 1]) + 1;
> }
> 
> (NOT TESTED!)

Works. and this is much better than the current code, thanks !
