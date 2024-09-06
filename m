Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39E6CE7AF9
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 09:31:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01E09885A5;
	Fri,  6 Sep 2024 11:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jc6iXCVV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FC1482BA7; Fri,  6 Sep 2024 11:31:46 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D6528870D
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 11:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-53438aa64a4so1881850e87.3
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 02:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725615103; x=1726219903; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d9d7lqb6Uz96vRJ/iOZV5zjDMJczuPPztzXEG42ksVM=;
 b=jc6iXCVVBS2phOalC2fQZcypX1di6gEmvnpueAX0BROMDO60n+NiuiLTZIQX89qna5
 auYBzBJTlrsWxn8gwfTmOc/AMpp76ZQICDlVC8bEifQW/sUPuspQ4H4Uwg6DBuqmMnVi
 AceFkvbq1aOAGGBUrSgxJeYmcOfdzKjTqgTpn+efIamNzg8MVd0kF+Fbzao4ryyY2Pgi
 zazIjg2AHNtfnVsY5Zj72HW83SP6gkH9Np9FGNtq2z8pOOCuGJto6rFSiErfk7YzvRKc
 IGkvfCJoTvV7fzWY6dIwobG4p0WLR7YakdvjSRPcRHfedhDokL6mc+GU84gYrXbvM8fm
 wzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725615103; x=1726219903;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d9d7lqb6Uz96vRJ/iOZV5zjDMJczuPPztzXEG42ksVM=;
 b=eEA+FDomkVI7TITxKBWfITNxQKBVuogmcC0wzx4VuQS85qXOHIx0BKJ/ZmoyRVQVXi
 3J9385g2//nIPvlZSRKwGL7IPUViAaeWQOApKkBeiJ3cSFAcO0kzQeYkwBbpILFKJAQI
 oT9JXfgbrwnOHy8KTINQrV8PiOTuUGExriTPjb7jWNr+QaZkZfEIyUKlrQJtBpUBSj88
 qkKHztVhk9NlRHKOhNDz41gad9KUq9VEbweww5bcZ/lx0uQ7+TbUEy2KjOF7aVmhnbLh
 ep5Pw9QZ5kf83xmTCOdaW2ib/L1jkfmYWYFdWsDQQgUGmDzsKiFfOPiAo+0roJQ4h1Qe
 +sbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqt4/t1eHdX1o33/6vdFWBCp70ryvHuDRAZDLlEbTowvP68Y1xyb3avH/+cVHbF2Zvxsp2RVU=@lists.denx.de
X-Gm-Message-State: AOJu0YwQRMWlGsMIjxuL+5dqWzrFR26iPQIBZKgokt0BRPagO5nirJ0Q
 KCalnVBco1WJMeMvvGlDvIi5Co/oZ1LB4QgDhiTD/srOehosFlsQviiBtFeblsu+pJThj4TU1qS
 0
X-Google-Smtp-Source: AGHT+IHfd9hdQZh2DZjZKpXLKFm5TNQHqEhAaGtPE75TylSBNLmCb0gMhZDMO2HgqVhSZ4dQkv4dgg==
X-Received: by 2002:a05:6512:694:b0:52e:9b2f:c313 with SMTP id
 2adb3069b0e04-536587ae740mr1131062e87.22.1725615103280; 
 Fri, 06 Sep 2024 02:31:43 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::1450? ([2a02:8109:aa0d:be00::1450])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a623a45a5sm249696366b.153.2024.09.06.02.31.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 02:31:42 -0700 (PDT)
Message-ID: <722e2465-bd96-4fe5-a154-d48fbe78a975@linaro.org>
Date: Fri, 6 Sep 2024 11:31:41 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] cmd: fdt: use U-Boot's FDT by default
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20240831164639.2298097-1-caleb.connolly@linaro.org>
 <20240903191422.GM2479150@bill-the-cat>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240903191422.GM2479150@bill-the-cat>
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



On 03/09/2024 20:14, Tom Rini wrote:
> On Sat, Aug 31, 2024 at 05:46:19PM +0100, Caleb Connolly wrote:
> 
>> When using the FDT command to inspect an arbitrary FDT in memory, it
>> will always be necessary to explicitly set the FDT address. However it
>> is also quite likely that the command is being used to inspect U-Boot's
>> own FDT. Simplify that common workflow of running "fdt addr -c" to get
>> the control address and set it by just making $fdtcontroladdr the
>> default FDT if there isn't one.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>   cmd/fdt.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/cmd/fdt.c b/cmd/fdt.c
>> index d16b141ce32d..8909706e2483 100644
>> --- a/cmd/fdt.c
>> +++ b/cmd/fdt.c
>> @@ -276,8 +276,17 @@ static int do_fdt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>   
>>   		return CMD_RET_SUCCESS;
>>   	}
>>   
>> +	/* Try using U-Boot's FDT by default */
>> +	if (!working_fdt) {
>> +		struct fdt_header *addr;
>> +
>> +		addr = (void *)env_get_hex("fdtcontroladdr", 0);
>> +		if (addr && fdt_check_header(&addr))
>> +			set_working_fdt_addr((phys_addr_t)addr);
>> +	}
>> +
>>   	if (!working_fdt) {
>>   		puts("No FDT memory address configured. Please configure\n"
>>   		     "the FDT address via \"fdt addr <address>\" command.\n"
>>   		     "Aborting!\n");
> 
> Setting aside the behavior change (which I am thinking about), this
> makes the next check of !working_fdt dead code which should be removed.

I wasn't sure if we could safely assume that fdtcontroladdr always 
points to a valid FDT, if that's true then yes this can be dropped.
> 

-- 
// Caleb (they/them)
