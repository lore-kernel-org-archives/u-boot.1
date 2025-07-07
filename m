Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90910C83F0A
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 10:03:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC33B8304D;
	Mon,  7 Jul 2025 12:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O6k15dwq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD4AC8305C; Mon,  7 Jul 2025 12:03:13 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C906883046
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 12:03:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-453066fad06so19694415e9.2
 for <u-boot@lists.denx.de>; Mon, 07 Jul 2025 03:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751882591; x=1752487391; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q0gLJsvSRkrtAZtkoNtwENqeSO9nWq2C98UwJb9r8cQ=;
 b=O6k15dwquWQS9qurJNIVml2RojrZmElZt+ArHwuszMdVsuovM1p/PR/MYCiNpj1B9L
 hWvLCcTpqyqeLG+9DlPTM5AWs3Cuv71OIhLzzJK2XG1WpA1IH1zlsTOw7uzVRHTTv6eM
 LO0HFa7nhmLPEDnNsBtWC9KQl6fvoJYpiTkki01mZX0uXoUdhg1MlWIUEVMTACZbP5oR
 rpKGLzRJanFuFU1un1JzXDopH+BfoNqiiiYz+eFszJ2b6L0a2uCFqLQnIotywKb+RAYs
 bn3dnAIEHJ/cmdvpvwhJ/z6ds+Aspfp+lj30pCQsfW5BCzonYP7frkh1jDEcJjmKF2l1
 sSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751882591; x=1752487391;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q0gLJsvSRkrtAZtkoNtwENqeSO9nWq2C98UwJb9r8cQ=;
 b=IB0Zn4WaxHjZF3Rb/IVx77OvnuI8b276aBvIy862JrVrZ3PpwchVgNZjiDf4GAfcad
 tQcDJx9qZoRXlp1KN02wxLE40HbERbGO7JhfIazWPKY2ToTdsg8cODf6tqvZfYJZtPgk
 yPKV2bnMcyTp2HdLy0aYREQcg5nC9RFKy7f8HsIgkc0d/49Q8sAJzgcE2N6i1+DFwu2H
 DdOhW75DC6Gs8lsAIWep+zFGXPPkZ2DhcKdDf3Pd2YWnsrE5OgzYG4C1r2VuK8MTzalX
 4SKUZ283eZCV3o4vYL2f1KTw3bcN4KBQs8rCy+ySww+tc3X+uqO6eQ+y8fMF557kx9//
 ssdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwtK2uSJBtpDXqYi0WfEaGmvTHbsM3nr6E4ecAM3eP9G2f4jTyPYeXglLwRD8lo+Pq+RFEshg=@lists.denx.de
X-Gm-Message-State: AOJu0YztniN9zboz4IFIJFBsF9sAA5Ag2+6Wq+wXkukEH2YUvtzj2MYK
 wxC4VgtTpyF6JsZuipM7CCCL8l5yfpGMceQ6SahqWbomAZr9ZqpEqw7Ux2Ou+pqjOu8=
X-Gm-Gg: ASbGncshRLFQkVGGTLO9G4GiMGRnETJUPsqTmuRCo9gB1LILUcqZIKosxPUeBASpzk7
 Lr19Eo+sDQQkiUYTp7VNmHY3gehVTVREHpPwGyu2Ws4FPBUV8UiHK4Qpu6aDkwbdFHCPzq1Qfiw
 VPPwG7vmwjfRXducnTRkrB7kOBsix3OVBWT9hZPyNM0UM9D3Uq6xRE4kgd4aD9EhPA64CJb789t
 rskG6SSu8mjx8EQM2owZeI2v0U3ljJEMoM9XWCYelGyiFChP72yxbFWGBBJ/KbD/MbLbQgJrc4e
 Xi5/TPV5EDGM0Q5uE/9qEy2J+0wkBlmpiJqDeySz96G+07+vYQoP6Ntv0mUesaOoEJqZImgaIQr
 DieaTy0/vdDwh7hMN1jX649CBFagkwS0JCgRHWF1tVdS0Qlgr1g==
X-Google-Smtp-Source: AGHT+IFi3yF3yN7an0Lcj150FDIhAQBTgbGYP+IhrxAZPBhKSGEhGGPE9a177epwwNtkvubfPTu/9g==
X-Received: by 2002:a05:600c:8509:b0:43b:cc42:c54f with SMTP id
 5b1f17b1804b1-454bb801406mr68056805e9.14.1751882590986; 
 Mon, 07 Jul 2025 03:03:10 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:e07:801:7bf5:4bcd:8bca:5bc3?
 ([2a0a:ef40:e07:801:7bf5:4bcd:8bca:5bc3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454b16a3799sm106238565e9.35.2025.07.07.03.03.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 03:03:10 -0700 (PDT)
Message-ID: <c578799b-a2e1-482d-b349-0693c102791e@linaro.org>
Date: Mon, 7 Jul 2025 11:03:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ofnode: NULL check bootscr_flash_size before dereference
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20250703-ofnode_fix-v1-1-c739233efb58@linaro.org>
 <20250704210116.GM6424@bill-the-cat>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250704210116.GM6424@bill-the-cat>
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

On 04/07/2025 22:01, Tom Rini wrote:
> On Thu, Jul 03, 2025 at 05:05:31PM +0100, Andrew Goodbody wrote:
> 
>> Move the NULL check of bootscr_flash_size to before the first time it is
>> dereferenced to avoid any possible segment violations.
>>
>> This issue found by Smatch.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   drivers/core/ofnode.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
>> index 26e014d5c53..1c285a867b3 100644
>> --- a/drivers/core/ofnode.c
>> +++ b/drivers/core/ofnode.c
>> @@ -1960,6 +1960,12 @@ int ofnode_read_bootscript_flash(u64 *bootscr_flash_offset,
>>   	int ret;
>>   	ofnode uboot;
>>   
>> +	if (!bootscr_flash_size) {
>> +		dm_warn("bootscr-flash-size is zero. Ignoring properties!\n");
>> +		*bootscr_flash_offset = 0;
>> +		return -EINVAL;
>> +	}
>> +
>>   	*bootscr_flash_offset = 0;
>>   	*bootscr_flash_size = 0;
> 
> Is the compiler likely to optimize this to:
> *bootscr_flash_offset = 0;
> if (!bootscr_flash_size) {
>    ...dm_warn(...)
>    return -EINVAL;
> }
> *bootscr_flash_size = 0;
> 
> Otherwise we should re-organize it like that. And yes, the two patches
> today for "fix platform ... because it grew too much" reminded me to be
> picky like this.
> 

Thanks, yes.

Andrew
