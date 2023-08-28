Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCE7C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 11:46:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9909E80702;
	Mon, 28 Aug 2023 13:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="nur9/V6K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0360F86453; Mon, 28 Aug 2023 13:46:54 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 008958056A
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 13:46:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
Received: from [192.168.0.115] (unknown [176.236.51.75])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 00F286607181;
 Mon, 28 Aug 2023 12:46:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1693223210;
 bh=8t4Sp6AbRZvJbee5l9sSHpJVowhey6lcAb2ZXIJ8ouU=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=nur9/V6KF7aAuCBRK+nEiYvQQLaSAyJKNz/4MC/GZ/8p7oNafNwADce/uXxC0wy+b
 TEjRLpelBFM2eq1n4t0sNkHGT8SscBlCnyjEqa/pBUXAIWZ4BWb6AkDkUCgfecGK5z
 RvsV9qkVDzA9KbdiM1HhKJy6PwDmJ/BW17osf/hFNeZGytVkTDdAcpP1+qKNbnTrtI
 dHePQlSNz29GVCE0J0x4/1W5IUVUQGkfYaH1s7NRSn7T39fhlmQAitpoZE6M20lSHB
 fEnBI6z2ambHxLieloedOHZB/ZeC26sDX3MHklE2R4KIMyY0CdGl76zWRkj/idSOSV
 YI2nf320WnUzg==
Message-ID: <d9986db9-0b75-3532-6eca-25c0a21aaab2@collabora.com>
Date: Mon, 28 Aug 2023 14:46:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND v3] fpga: add inline stub for fpga_load
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de,
 sjg@chromium.org, Chanho Park <chanho61.park@samsung.com>
References: <20230808102227.34233-1-eugen.hristev@collabora.com>
 <f7c04c73-c2f9-5ce4-5953-270e907d89f8@amd.com>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <f7c04c73-c2f9-5ce4-5953-270e907d89f8@amd.com>
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

On 8/28/23 13:53, Michal Simek wrote:
> Hi Eugen, + Chanho,
> 
> On 8/8/23 12:22, Eugen Hristev wrote:
>> In case CC_OPTIMIZE_FOR_DEBUG is set, unused code will not be 
>> optimized out,
>> hence the reference to fpga_load will be compiled.
>> if DM_FPGA and SPL_FPGA are not set, the build will fail with :
> 
> this is not correct. It is not DM_FPGA but only FPGA.
> 
> 
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
> 
> And when you enable CONFIG_CC_OPTIMIZE_FOR_DEBUG and FPGA you get 
> compilation warnings.
> 
> drivers/fpga/fpga.c:265:5: error: redefinition of 'fpga_load'
>    265 | int fpga_load(int devnum, const void *buf, size_t bsize, 
> bitstream_type bstype,
>        |     ^~~~~~~~~
> In file included from include/xilinx.h:7,
>                   from drivers/fpga/fpga.c:11:
> include/fpga.h:64:19: note: previous definition of 'fpga_load' with type 
> 'int(int,  const void *, size_t,  bitstream_type,  int)' {aka 'int(int,  
> const void *, long unsigned int,  bitstream_type,  int)'}
>     64 | static inline int fpga_load(int devnum, const void *buf, size_t 
> bsize,
>        |                   ^~~~~~~~~
> make[2]: *** [scripts/Makefile.build:257: drivers/fpga/fpga.o] Error 1
> 
> I means please tune that condition properly not to create additional 
> compilation warnings for other combinations.
> 
> Thanks,
> Michal
> 

Hello Michal,

Thanks for reviewing .

Chanho, I cannot try this at the moment, if you are in a hurry you can 
send a v4 or v2 to your patch addressing this (or maybe your patch does 
not have this problem)

Thanks,
Eugen
> 
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

