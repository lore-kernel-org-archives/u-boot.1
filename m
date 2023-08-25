Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3C8C71133
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 13:16:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 261A9866BB;
	Fri, 25 Aug 2023 15:16:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Jc6MIsAn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F5AD866BB; Fri, 25 Aug 2023 15:16:25 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51A1C866D4
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 15:16:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
Received: from [192.168.1.109] (unknown [78.178.29.41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 62FCE6607186;
 Fri, 25 Aug 2023 14:16:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1692969381;
 bh=50Xjc3ZRCX9Z0pZT1xmgOjDhVlg9au8IUS1TuxwKCKA=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=Jc6MIsAn+b1iv3iBXtOoDuqdZgl1FerScMvGWIkq+a985w5WIzXeGDZy4FrWNcVSA
 PYkCy8+hkSj5sVaiFXcc/461QOO35Eyibnxrc8DeMrAkvFwkuAU3v5JcRrS4vybIYA
 8uJJrc9lIneZq/sMJglA7OY09YCjCharTi3l7ftpmnDr1BkD31DG+/CpQlL5Tj7yHi
 yI1P76Xc9QCs9tWJqKwOQzutwliCBur3b+wXL+TiW4j880Tyu1dNix+wFBYf1FY0rO
 WurGY0E8zh5Wrs+SCjNLWc5WSZ19apK+2ZGrwMo8w3hi9gSpfWMa3qheaCqfhUDxnq
 SuiA981jfiVag==
Message-ID: <e495a6c1-d625-53e6-6bbc-8f4aafb9ab55@collabora.com>
Date: Fri, 25 Aug 2023 16:16:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND v3] fpga: add inline stub for fpga_load
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, sjg@chromium.org
References: <20230808102227.34233-1-eugen.hristev@collabora.com>
 <027aa995-b8ed-225c-0fa2-7299574cdc33@amd.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <027aa995-b8ed-225c-0fa2-7299574cdc33@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 8/25/23 10:21, Michal Simek wrote:
> Hi,
> 
> On 8/8/23 12:22, Eugen Hristev wrote:
>> In case CC_OPTIMIZE_FOR_DEBUG is set, unused code will not be 
>> optimized out,
>> hence the reference to fpga_load will be compiled.
>> if DM_FPGA and SPL_FPGA are not set, the build will fail with :
>>
>> aarch64-none-linux-gnu-ld.bfd: common/spl/spl_fit.o: in function 
>> `spl_fit_upload_fpga':
>> u-boot/common/spl/spl_fit.c:595: undefined reference to `fpga_load'
>>
>> To solve this, added an inline empty stub in the header if
>> CC_OPTIMIZE_FOR_DEBUG is set such that the build will succeed.
>>
>> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
>> ---
>> Changes in v3:
>> - return -ENOSYS
>> Changes in v2:
>> - this is a rework as suggested by Simon of this previous patch :
>> https://patchwork.ozlabs.org/project/uboot/patch/20230619102839.277902-1-eugen.hristev@collabora.com/
>>
>>   include/fpga.h | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/include/fpga.h b/include/fpga.h
>> index ed688cc0fa3b..33d0dbbe2ba4 100644
>> --- a/include/fpga.h
>> +++ b/include/fpga.h
>> @@ -60,8 +60,17 @@ int fpga_add(fpga_type devtype, void *desc);
>>   int fpga_count(void);
>>   const fpga_desc *const fpga_get_desc(int devnum);
>>   int fpga_is_partial_data(int devnum, size_t img_len);
>> +#if defined(CONFIG_CC_OPTIMIZE_FOR_DEBUG)
>> +static inline int fpga_load(int devnum, const void *buf, size_t bsize,
>> +                bitstream_type bstype, int flags)
>> +{
>> +    return -ENOSYS;
>> +}
>> +#else
>>   int fpga_load(int devnum, const void *buf, size_t bsize,
>>             bitstream_type bstype, int flags);
>> +#endif
>> +
>>   int fpga_fsload(int devnum, const void *buf, size_t size,
>>           fpga_fs_info *fpga_fsinfo);
>>   int fpga_loads(int devnum, const void *buf, size_t size,
> 
> Actually there is another patch targeting the same code.
> Please take a look at
> https://lore.kernel.org/r/20230816065437.836392-1-chanho61.park@samsung.com
> and get Chanho on board and create a patch to cover both cases.
> 
> Thanks,
> Michal

Hello Michal,

Looking at Chanho's patch, it appears that he is solving the same issue. 
These are not two separate cases.
He fixed it the other way around : if CONFIG_FPGA define the right 
prototype, else define the stub, while I did if CONFIG_DEBUG define 
stub, else define the right prototype.

I think you should select the patch that you deem more appropriate to 
fix this, I don't mind which one.

Thanks,
Eugen
