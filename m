Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212E6EF99DC
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 20:39:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8591B83AA9;
	Fri, 13 Feb 2026 21:39:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="h6wSmiHH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42B0E83C4B; Fri, 13 Feb 2026 20:27:48 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F9D680FA1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 20:27:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F119310EC8A; Fri, 13 Feb 2026 20:27:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1771010864;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=MCV2MIjAQrRKNn8c9cYvUMgtR8LSOD/H6UMi4DEaoxk=;
 b=h6wSmiHHXglNR7k9uaT9gAS6VnDo8wQVIF80gvncLgA1AwZ6Cd6RsTGCETfT+rM9e+BvUS
 30v/RJ96lKzfh26SWR5cvJDJfjTzPxr/AG3NYjRPkUlKmNre74NBgR7eejDPE1N1CxdKrh
 PNev19n7FO2rkh4PzpLpjYVkJm//I3LZN+b+Or6V0DyAQQqep6oMjpURYeTr2y+PCwdana
 iiWaUhcZqxeVAnBugpcMDpJ2qCQ237yDHCgR+k1g6RADXF/zffcg78Mt3TCCFaly578fsr
 RB6PnLft7c2KsPJa93jiApjlhx7G8yROUhfU41elqUay+HX9sO7iEWMxXgPStA==
Message-ID: <481a2418-4a4c-411c-8028-db7c5c4c243f@nabladev.com>
Date: Fri, 13 Feb 2026 20:27:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binman: add CST backend selection for i.MX8M signing
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <20260213001212.157033-1-marex@nabladev.com>
 <CAFLszTi1M=J6+R1CcAJRY4gnQa87ScFkQ-YOK+NWzsB02VKnwA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <CAFLszTi1M=J6+R1CcAJRY4gnQa87ScFkQ-YOK+NWzsB02VKnwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 13 Feb 2026 21:39:18 +0100
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

On 2/13/26 6:53 PM, Simon Glass wrote:

Hello Simon,

>> @@ -161,8 +165,14 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
>>           with open(cfg_fname, 'w') as cfgf:
>>               config.write(cfgf)
>>
>> +        # SSL is the default backend, PKCS11 backend is optional
>> +        if self.backend == "pkcs11":
>> +            cst_backend = "pkcs11"
>> +        else:
>> +            cst_backend = "ssl"
>> +
>>           output_fname = tools.get_output_filename(f'nxp.csf-output-blob.{uniq}')
>> -        args = ['-i', cfg_fname, '-o', output_fname]
>> +        args = ['-i', cfg_fname, '-o', output_fname, '-b', cst_backend]
>>           if self.cst.run_cmd(*args) is not None:
>>               outdata = tools.read_file(output_fname)
>>               # fixme: 0x2000 should be CONFIG_CSF_SIZE
>> --
>> 2.51.0
>>
> 
> This should be documented somewhere, likely in the comment for this
> entry type, so it ends up visible in the docs.

I will send a V2 with documentation.

> Also, this code path will need a test, please.
How do you propose to test this ?
