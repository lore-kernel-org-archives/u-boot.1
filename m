Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5079C606A321
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 17:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=k7D3nZIB;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vNXonETe
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2272D4081B;
	Wed, 25 Nov 2026 17:08:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pPCFNJDFx5KR; Wed, 25 Nov 2026 17:08:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6B2B4405A1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795626507;
	b=aGnbmDpBAnLv5TcNuH1QadCdGMPbL7JzOv0D2BGM6AyJNkywR5bvM8QD9dQ/mj0wh0C9
	 VLGlXyPhJrI0kIbOfnG2wymIZ7jvFII+AjM6gvI/5b17oje3qsB9RP3A2fmMc9Cft1g4m
	 SDKkBbPVRoNlKmvuh3+Ne9GghFRfG5BiIGYuDi+5hzdbfxZH72R9GKeWlUhD9CF0up2MZ
	 IGgw4DAFmju2JOgj5d7/t/0f500jw3cUSgbDFEqSrbjnAE251ZWPzeKeZH8CAPRLY/fa/
	 xtppPVW5L3GVZJqgTu9AB08tyIj0dYeyUTdkINllXbE5tQRUsmo2WF+ljE2NdOi1SSA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795626507;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=y7TFkFTw9xXG50cbl3Ljs0bAdGQEdBiC1LpCM6PllnY=;
	b=R2kJVSKe6zOBHS18i9zeJLTuk0mpbkXHJnx4o0khjDx3kfGFAeVq2T/uUj+ATv2ZSQBS
	 ZBaQksQOygtzH5x2L14nDiiL3lD55Y04+o9Xso+J87MYK5F9Vok3nlkRy/fE/uGZpfrhP
	 qiMcv57bb2xKsXSTJMqJOVZnSQvGZnJFtcq6eYg31ORfQH5mbdLpfLaXHUL+MswNgQBaF
	 VezOjAh3DGcbpnfIQ64pNyc/zuZpKy8D+MRoi2bTo0auZ1C5JxIQyZeYsS7NXsMq6PBnq
	 UQY4jZPm45iDGciDs7XsjpFciBdYLlzsjBgm2TRa3E6xQBWBSymA+ljPKt2Ssl5rfVQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795626507;
	bh=y7TFkFTw9xXG50cbl3Ljs0bAdGQEdBiC1LpCM6PllnY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k7D3nZIB04fd3ndVtOdbOGz8xcqQqTFGbWywnnpJb2Zt/jpzYdkuZU+580ZpGd3RA
	 ed8t9XewSnO57iXJOKYxG6CZdsk3evPvMo9usdkxV35vDv5NcTK0h5MJ2bVgtRvbs6
	 d4FgUX+PN/5n405qThrWEkb1+vof3ItDg5ev5UDRB9NfJ0u1G9+7K0AqrMSCke/pQc
	 tPT/c1brWoVuyWAT7GMd9ntpvwfuDvMgs8Kuapj7Dd+4UDk/S6XpNtyeBhSiCGxCnN
	 NGpCf01JElbygRRjHW5OEmAKGaNNUBE2w1LqVdEAT6r2v6HdXmaw4TY1/qv2haDhTL
	 nO2gL6VQvgQrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B2B4405A1;
	Wed, 25 Nov 2026 17:08:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CE80D1C9
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:08:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B551380892
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:08:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tsRoCFvDRHNL for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 17:08:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 99B598082F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=vNXonETe
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 99B598082F
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:08:24 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c50ac25cdd4so784614066b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 09:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795626502; x=1796231302;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=y7TFkFTw9xXG50cbl3Ljs0bAdGQEdBiC1LpCM6PllnY=;
 b=vNXonETe6PzIWKCB67X7YGkwhCLqH18ol3AlAKQSbC/IUq9dQRDcpoNi4Efy/TMN7q
 E3mZVq4dBS41kkGbm6EufGkwtz15b/NkO1uwM22mkUTYdQiWTMS+xkiYSU1ZzAdNG5gr
 JMDpamlJFiV5YoBAPBEZ1JNdEj7Lpjf99mJKn5drdhVd7UA6elp9efE4czcxJKJ/RHWy
 WsScYOl7F1khLGTywJASRFPpcKQ9fcmnobkTvbgyAZnRo4Z57K8rTvyWKEMw/EBItiLU
 q7uGVarFHmlh7a0CpZYrnmw1oxdZTim1XkYcv/VRntqyNE+kl0z9Di26Zi+mra2bvMCG
 4rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795626502; x=1796231302;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y7TFkFTw9xXG50cbl3Ljs0bAdGQEdBiC1LpCM6PllnY=;
 b=jVqizzn+ZizO0gXBkro+C7kHaynfMS8/SnhxUNAfsrr15V9cyGuTlfdZgKBODSbds8
 vwkQ2OkCbhxM072Zt7i6HTQ48IRLfiUvmKZFCDnUkKLM2ZYRRfADEFdonjSymeqDykmK
 yK06Faw2puW5fitat3vKI3bHX9Jx+VLu1LMeKrqdo609ZepsiuGFE42C4BjuUJMRZEEO
 uvT8nUT1pgZ8ivfCJ8genA+0RZa98t5KrhNQCjQlWik6XIqcM7B7RiiA7R4RrsNN3fr/
 aLv2Hj3C1ppY17Pkm1Gs+3Bbb//DP3QjuUgzcLuORKLnGp29hoIbk8O9fM9ACZeR+qmR
 1auQ==
X-Gm-Message-State: APuU4Z/jFG5YYlhwj5mFeNKqtdsp52pu3mUD/mDWuSk20bOQxrx9DC6+
 8GmLI7qVHGo75gcjiwLCJJ96hvov7t4RquUPZ9psaIsQ/puVpbHKJfgC2eJdCnmOEcVmAZgxHAG
 3sGtnGG0=
X-Gm-Gg: AZFdTZeKgTr4Z0P7F7P3dqTlnrFAlGfDdI5+JbLx/OAZAsON2LZ+i2PaXrMd0LD4CWF
 r0gnb/ZVi0vDZIcBBmL/WE87Dv2QWKGWZsV6DsH5l1/Q4HghDOfHDxmINiHmAfSGqBfp5oY97jV
 ISNyZ5m1bgqeLw5FgvkleSYA8Fh250iNO2AomDHJqYDn6hvO1M7mzJxxjZyTvrfbzUYb0WmeJr2
 ExRUVbC9tt+MFJ0r0LKP28JewXuaZHj/QGXaUiZqu1b9+XSyYoA+Og8rPVd+a0ASx/frvwms+mk
 leVc+lV26oTI10IRHiApH7lsKdt5fSXyeuhF5sdsm45ikhXdOXXOUrCHnptViQqeUfvP0smKZ1u
 LEEuGL+/WstA5JbCiYExReeTADrWLbbzkdwAOkHpW7F5XRLWUlOr8potJ31EHRfMWBfeE1PVbqK
 b79hfZRcxn5KobYQBdrxTzQxZqXDU7LCMbMweQ2aLTiHF1zL7jCrue0hJ18TLeHWd6WGeDKdXO0
 zcbRqTL999jPWN69A1oubZmstFcHE3VCzTQJfKQQp1BsRhLy/XI0zpuT5gn64ad4u6X2bbPFRzR
 lAFfMkwKbKCJPNgYLMScBik+OLC6C4Ejvtse6LongDPXaG4FZi9lDh60jmgh6+4+1Pr7gng8PiK
 Xa/sBfXXiDW8=
X-Received: by 2002:a17:906:eb15:b0:c31:8cfe:9a25 with SMTP id
 a640c23a62f3a-c513a5eaa00mr1175495266b.9.1795626502435; 
 Wed, 25 Nov 2026 09:08:22 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:13a6:7601:2808:8f27:8754:47ab?
 ([2a0a:ef40:13a6:7601:2808:8f27:8754:47ab])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ad01b0bsm664605766b.10.2026.11.25.09.08.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 09:08:21 -0800 (PST)
Message-ID: <4d418e7f-3c1e-4749-ba5d-e372c247f132@linaro.org>
Date: Wed, 25 Nov 2026 17:08:20 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: relocate: convert relocate_code to C
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com,
 richard.henderson@linaro.org
Cc: u-boot@lists.u-boot-project.org
References: <20261125074122.1965495-1-ilias.apalodimas@linaro.org>
 <ddbf51b3-7b66-490f-ba99-88209bced490@cherry.de>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <ddbf51b3-7b66-490f-ba99-88209bced490@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/25/26 17:07, Quentin Schulz wrote:
> Hi Ilias,
> 
> On 11/25/26 8:41 AM, Ilias Apalodimas wrote:
>> relocate_code() on arm64 is called from _main with sp and gd already
>> pointing at the relocated area and lr pointing to the relocated copy of
>> relocation_return. By that time pie_fixup has already run, if
>> POSITION_INDEPENDENT is enabled, the image is fixed up and plain C works
>> fine, like the rest of board_init_f(). So let's convert it to C which is
>> much easier to read and maintain.
>>
>> While at it change the behaviour and order of cache maintenance.
>> Invalidate the I-cache after the D-cache clean instead of before
>> and add a 'dsb' between 'ic iallu' and the 'isb', which is the
>> architecturally required sequence.
>>
> 
> suggestion: can you please make those separate commits?
> 
> That should help us if we ever need to bisect this change. If it was 
> only in the conversion from ASM to C, or if it's related to the cache 
> changes?

+1

Tested-by: Casey Connolly <casey.connolly@linaro.org>

> 
> Thanks!
> Quentin

