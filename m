Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3653C7EE39
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 09:51:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C499C81D6A;
	Mon, 30 Jun 2025 11:51:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cpnRRne/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 819AB81FEE; Mon, 30 Jun 2025 11:51:53 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D065800C1
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 11:51:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a531fcaa05so1001849f8f.3
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 02:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751277107; x=1751881907; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D3SLaCPnJKzeMGKKuQ5g/ZG9g8zAoK9ZXOkK0Z4oYdY=;
 b=cpnRRne/nrgx0A+2To2YePB+mieNeACJIWmhDWEKUg0r2JzJEb3mS+9FAPOArEWFHj
 plfFB1OOckzm95AJWfesvsbLTXQ2fHfyOtvgo66GtRxdpFa/D7jeOLy0UyhV395QFCZo
 uZc9z35Fd27h27K80wkjb/USncytnnUHFYNMpz6sx2TZV8BeuBFOQtS2tFsWishbd85w
 DuNx94rzymzZ2mEGIiMmW6muOOKV+sW4KeF0KqZk82jUm4NFTSDW6oiH/OdLYerpxGW4
 xqY4qdQmWOP9b5OxHBrDLa0r5GjhET4ixqaHLGkWYDBHwVxv4eGYuPFQ0QwdI1L+8pWn
 5Y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751277107; x=1751881907;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D3SLaCPnJKzeMGKKuQ5g/ZG9g8zAoK9ZXOkK0Z4oYdY=;
 b=ZGKcnDcLEH/hgAcnnrakeWDDijzLvDyTk4Nta3uJnOvdTZGK6V+hKtKWf7wpRoAK7I
 ztuPHiDLQSz+rZ8QyrXaywmr5DpYSbyOaxmZV9+H3u1vn2S9gptFNsNEd+BY0/Klf/PU
 9AHSlZUTb8bQEhGmV3hvtJlX1H9wrUaw8IJLYJtneAODnceC5x0dQ+Whj7f49Ojf8n9p
 3HSJzQ8d4qSlTMGCcaKxHeo66lsHQ6Lv2IsU7K2omun9CF6nnPUKePPXV3Xpvp0Le2dh
 KDgNpDcJ9YG1xj2eARAeANrlitp4Xi3xP4tmLaICr70JA+u1j/+teroMmLgNNLVOlMix
 sLdw==
X-Gm-Message-State: AOJu0YysGJME+KedgVvNbHcmyMUq1YcFEswJa/qH73nPBX4Qoo/YeEPU
 3N0Wna0WoTpx1yMdOvEqNfAX8G3M86E/Bp2NhAdSBvflmHVAhmxBdMd9rwshrXU6jHT4IzzQMAi
 +Jn87qxY=
X-Gm-Gg: ASbGncvFOJT8wpVN40tKeZ0CnUAKHl1D6Wcx93Gr6h/HDw7lGLRqMyswU8AJaScVYpr
 6NhzD2sIL4Y9JvmEpqoizEHjXT+j3axzw4RQ4WdcG7KYiTIR/9L2jvSQUdmPOBSBrRv0Kp7ZwJ3
 hAy85jmrrd07q25pAOdCc+QjxDHb2sr052bTm7CLtkuIbsyURsOYOfSdB2zhecGXMASDMYFM8qt
 j2WIQBrQoVlojxNTykZPKH/2NaO101PMlJEYXCpO1pcsEyesuBcw1HKp/irKidFECDd7chXloqM
 KN7UOCgn5uFBp+dHE6mr+MdYOUFlgQ+6QNR6Wiw4aEnaepc3n7HoSN703KQX72QHmJVHvGL1igI
 hBnxK6V9ZbMvwLm+XrVdSzA4vmdUXIq3RER514B/yPg==
X-Google-Smtp-Source: AGHT+IFrAEgEKDJ4n50tAjH5hQ8RxLuQNPfvKCX9bG1R1P/Ha0Ps5/sXe0YCBRHlLFswvgGR1KuyVg==
X-Received: by 2002:a05:6000:250f:b0:3a4:f936:7882 with SMTP id
 ffacd0b85a97d-3a8ffcca8b2mr11933260f8f.55.1751277107442; 
 Mon, 30 Jun 2025 02:51:47 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:ee3:2301:10fb:ba4d:cfb6:8c75?
 ([2a0a:ef40:ee3:2301:10fb:ba4d:cfb6:8c75])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e61f48sm10053176f8f.93.2025.06.30.02.51.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 02:51:46 -0700 (PDT)
Message-ID: <f886767a-0b36-4027-a83c-6a967d532126@linaro.org>
Date: Mon, 30 Jun 2025 10:51:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boot: Ensure that ranges is not used uninitialised
To: Yao Zi <ziyao@disroot.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250627-boot_fdt_fix-v1-1-d2e0c4b13762@linaro.org>
 <aF6NQ2zt5qKS0UsD@pie>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <aF6NQ2zt5qKS0UsD@pie>
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

On 27/06/2025 13:23, Yao Zi wrote:
> On Fri, Jun 27, 2025 at 12:51:02PM +0100, Andrew Goodbody wrote:
>> The local variable ranges may be used uninitialised if the function
>> fdt_get_dma_range is called with node < 0. Ensure this does not
>> happen by initialising ranges when declared.
> 
> It doesn't harm. When node < 0, parent is less than zero as well, and
> the first while loop is skipped. The control flow just fails into the
> error path where parent < 0 stays true.

OK, I will withdraw the patch. It just does not seem a great idea to 
have an uninitialised variable evaluated even if the result of that 
evaluation is irrelevant due to the second term in the logical OR being 
true.

> Furthermore, it doesn't seem valid to call fdt_get_dma_range() with a
> negative node parameter, does it?

No it does not, but that is a different issue. Just because it is not 
valid does not mean it will never happen.

Andrew

>> /**
>>   * fdt_get_dma_range() - get DMA ranges to perform bus/cpu translations
>>   *
>>   * @blob: pointer to device tree blob
>>   * @node_offset: node DT offset
>>   * @cpu: pointer to variable storing the range's cpu address
>>   * @bus: pointer to variable storing the range's bus address
>>   * @size: pointer to variable storing the range's size
>>   *
>>   * Get DMA ranges for a specifc node, this is useful to perform bus->cpu and
>>   * cpu->bus address translations
>>   *
>>   * Return: translated DMA address or OF_BAD_ADDR on error
>>   */
>> int fdt_get_dma_range(const void *blob, int node_offset, phys_addr_t *cpu,
>>                        dma_addr_t *bus, u64 *size);
> 
> Regards,
> Yao Zi
> 
>> This issue was found with Smatch.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   boot/fdt_support.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
>> index 92f2f534ee0..4f63ce9a763 100644
>> --- a/boot/fdt_support.c
>> +++ b/boot/fdt_support.c
>> @@ -1547,7 +1547,7 @@ int fdt_get_dma_range(const void *blob, int node, phys_addr_t *cpu,
>>   {
>>   	bool found_dma_ranges = false;
>>   	struct of_bus *bus_node;
>> -	const fdt32_t *ranges;
>> +	const fdt32_t *ranges = NULL;
>>   	int na, ns, pna, pns;
>>   	int parent = node;
>>   	int ret = 0;
>>
>> ---
>> base-commit: 359e3012921f2fc2d43f3c4e320a752173f82b82
>> change-id: 20250627-boot_fdt_fix-e4e56d956c8a
>>
>> Best regards,
>> -- 
>> Andrew Goodbody <andrew.goodbody@linaro.org>
>>

