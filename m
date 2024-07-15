Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F31CC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 21:42:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AD25887E4;
	Mon, 15 Jul 2024 23:42:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dp73Bywf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FECC888E5; Mon, 15 Jul 2024 23:42:27 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C0CB887D3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 23:42:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-59a47d5c22aso5208848a12.1
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 14:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721079744; x=1721684544; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=taEpicir+yGUCTbV5kyxNcqcAlT5xGaxp+j9sLIS5JE=;
 b=dp73Bywfg5blKtmhUgYN2OWLXWfvzbeTnvnBFlhMOxdqSqu6RzpKR4WMcWarc5Jn0b
 8FMPpUUvbk7Pc+q6GJFpUxsNX4uiTFfdKcs1VWmrJ0wCGqjGtjplU6ByPsYjzZn/4tjW
 rHTMv/gDvF3Ga+j++J+fPtYegYlT1ZeeraMlNimVnJmph1tke+aw9JWXHTfgjctfZRo3
 I+c17tvoqbiUiWLg74l1Dfja7R0zkquweOpFAii98cKqJvgsdx4YYuwhdmDcWE4fnVit
 oZ18gjLmGFc1fQmkvOFakDM8i0vBiY+ArEZ8IsRV5MLg+kKRulnsmQ2oX1VDeqZrKZQI
 l3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721079744; x=1721684544;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=taEpicir+yGUCTbV5kyxNcqcAlT5xGaxp+j9sLIS5JE=;
 b=jgF2Tx5kEhCFbICIsOWJfAmFxj77j+s6QmtNtEOzcZOlZ9D1hcY03/BPNGV4oX29eS
 TnjkBc32MrjQV84PsTnPuWKnCps/TTCWx+WOJpmGoHuLKJ51PCCgkSlifBIGCW8VG5HP
 FhVejcMO1SkdHu11N1B2eCZCEDOeIvLxtwgj42SkOBJLH6bhOIcRCLfwX+7qnCVibmjh
 woF7foKIGDfeorwEmKJ9JLAxFI8KBGoirojYa0a7XFIqtCe5xSq5df242GWjxmA0I0TK
 tgyMeSiq5tWEnUPbm0b2n5rb3UannyoXRkNb3DubtarwT+FD5pBJoqyZ9BlfNwAb3Tvd
 KVFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/bEMXSPWC9PIrswGoivlVQq2P2hwk966zLGk3qQ+qauGnlbTky7/PMfGo1pZs5yfUmCZdFrPBDw9igFba9ZzsDNPDNA==
X-Gm-Message-State: AOJu0YyVjto1RkCp1kSGmgFgLZQVnpjZnUOBF2fpj6yTo+injs2vQ9Sy
 naYinEDdB9YBr+dBjF4R4Gw/1j09dOrZfs+ZckmQj0c1Kg+EVkQ8CWtUpQ33Zas=
X-Google-Smtp-Source: AGHT+IFDptprjwEPMa8AP/+un25taB6GMmcLCzNpX6DGh8QffC69ncXEPM/Usiho5kngdibi/khAIA==
X-Received: by 2002:a17:906:418:b0:a77:af39:752d with SMTP id
 a640c23a62f3a-a79ea491465mr11758366b.21.1721079744375; 
 Mon, 15 Jul 2024 14:42:24 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::7424? ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc7ffa06sm239871966b.156.2024.07.15.14.42.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 14:42:23 -0700 (PDT)
Message-ID: <c1f036a4-a080-428f-84fd-c44f968d44bf@linaro.org>
Date: Mon, 15 Jul 2024 23:42:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/24] soc: qcom: cmd-db: adjust probe for U-Boot
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
 <20240715-b4-qcom-rpmh-v6-6-0c948a25d018@linaro.org>
 <CAFLszTgz-SOFR+aV7f45+pfByLztAYU1kvFPZof665=QwjjoPQ@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszTgz-SOFR+aV7f45+pfByLztAYU1kvFPZof665=QwjjoPQ@mail.gmail.com>
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



On 15/07/2024 13:39, Simon Glass wrote:
> On Mon, 15 Jul 2024 at 11:08, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Integrate cmd-db into the U-Boot driver model.
>>
>> This is just a wrapper around an in-memory database, so we just need to
>> get the address and validate that cmd-db is there.
>>
>> Since cmd_db_header will be stored in the .data section we can skip
>> bind if it's already set.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>> To: Simon Glass <sjg@chromium.org>
>> ---
>>   drivers/soc/qcom/cmd-db.c | 72 +++++++++++++++--------------------------------
>>   include/soc/qcom/cmd-db.h |  3 --
>>   2 files changed, 23 insertions(+), 52 deletions(-)
>>
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks
> 
> BTW, this is a MISC driver. Does it implement the read() operation?

No, the API (as defined in the header file) takes a string and returns a 
database entry. cmd-db users don't have an easily available handle to 
the node / udevice regardless.

-- 
// Caleb (they/them)
