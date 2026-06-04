Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A164CCD6E6D
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 15:27:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0D158484F;
	Thu,  4 Jun 2026 17:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tl4xq+BS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A69D848A1; Thu,  4 Jun 2026 17:01:50 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D086F844CF
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 17:01:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-45fd461e4a5so636301f8f.0
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 08:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780585307; x=1781190107; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uxAMgve0Bc/FdnaiNfVIaAPUXr7vj1Y/wps0+hYKC9U=;
 b=tl4xq+BSqsFg/+dPhMYIwLwRHGiRnpDNbFhGltBldPTAUkuwyZ4c6rIC8hVf+XRsdW
 jfLB+poGwRixfYDSfihLMfhAm3w1fjAgIBU3BG0sFrLhLLtfiD9CNIf/sk8t4iQV8I/+
 eiHBWdtVfRplTzEUnV8CJlFb5EPjcamlSYHePM6g/bTPHhQYyRQctmGZJmvuqwyj/agF
 716IQvzA1TpiGx09yt4r5VFXa6uATtYqW06D5xX35E/w70Kxb2O27j8GPhuayP59Q0sW
 2pJm7wJlfFr8ntJeXMw5yPXWulrZSn7555kChyZ/DD4zT6T9c2IgHTuv/Y2epJGRmMFu
 bXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780585307; x=1781190107;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uxAMgve0Bc/FdnaiNfVIaAPUXr7vj1Y/wps0+hYKC9U=;
 b=NDsNeHchNDUcTZe5Z3sQnQDpy8zt3gmhG4cMMVIV91CAKm4wygIQuf3fhXuPqo41pH
 VcT3nmg0ZITTMSoaorEwEltqDS/xyFHOR9ZyqnQqU2GZJIGTwUm49YNRNf2f8/NqV60Q
 mJ5Bw7+iVwcUntnd3MQ6rtetf6ypYUaG/mH/BMRpHV8bewucLe6RaeSHe3fMsBluq9gy
 +XPXutdNNqTiBhU5r3dJqMyhesMtZfhdrs9J9p6ShZnlooc5NsbYnGnY4yy+KNqyTeDU
 jMwYxLIVpNoV0EtOTjgidBpiSJ//K9RT+BjUCanZNKW8s9QcfEeAn4BM5PFLneDZOrHh
 VC+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+cXooyVsb8QrX/ZfI1xeBa1IVsKyc8EBXPqYCJLA+eJ9vc4zgqPwov0HDm8SHVVB5QRSyEIro=@lists.denx.de
X-Gm-Message-State: AOJu0YzTcQ1e+4+HJC3BZEdsWWkDGieqhCIIXaOFrfGHzHgVBqUI1FsO
 altXU8BdwBf9k9RzdjOxFt3RWlOcx8evyJaVYejnpWaNywaJjvDkdhnGabAmVLQlczs=
X-Gm-Gg: Acq92OHJzrkaKSTGagv0rqmXjbBsappTox1OOg0kuWOufLaH/XPRZWEocgbMtSLfs+3
 gYCoOoddqEBcdspdnBfL2EL77r7bPGLfjSBcYUXgfLNWhr1gHX/FvTgk7+7NIMD/UGkf2AVdNbS
 41PujlF3ZTtIK8vMXzY7C3zsW9Pe3Ej7KLx0f30kcYBToU3O3UF0Oo8ZlbV3HYjejaN99ZNYYjW
 gtSPn3zoB5t46tnnP3ZS1Jr0XtgtYLamK89qnR84bY9xm1lczLwC85uSfn+7NlGuHfri+tHXMgo
 475l0LbOJiJCjCIV3heEo/eTbP1xNKZr0DNQRZ1wmAtI9fxN0pEy+VyHEJLfyzVClYnY4JmGJi9
 wwgWeOicaOJ11bBpKTOoSAjROhRdtDp32s91xgh5Qz12Q5c7+wBgeCKHvuX57tYDvSIZCGzMX2i
 GZFAUgnPDtZsc1i3IrBS6rV7aONBfP3nYLOaQvvByKk7QDhTDOeC+vL95aInkBSPeup84=
X-Received: by 2002:a05:6000:4b11:b0:45e:ec27:b4b0 with SMTP id
 ffacd0b85a97d-460217264a4mr12976872f8f.18.1780585307088; 
 Thu, 04 Jun 2026 08:01:47 -0700 (PDT)
Received: from ?IPV6:2a0e:c5c1:0:100:34f5:5b48:6fc0:9fd1?
 ([2a0e:c5c1:0:100:34f5:5b48:6fc0:9fd1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dc412sm17566353f8f.4.2026.06.04.08.01.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 08:01:46 -0700 (PDT)
Message-ID: <a03c30b1-0458-4a04-9419-965bf398e5bc@linaro.org>
Date: Thu, 4 Jun 2026 17:01:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 12/16] mach-snapdragon: parse incoming ARM32 ATAGS
To: Sam Day <me@samcday.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stephan Gerhold <stephan.gerhold@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Eugen Hristev <ehristev@kernel.org>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, George Chan <gchan9527@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tingting Meng <tingting.meng@altera.com>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Lukasz Majewski <lukma@denx.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Jens Reidel <adrian@mainlining.org>
References: <20260601-qcom-armv7-v1-0-05a08d87e476@samcday.com>
 <20260601-qcom-armv7-v1-12-05a08d87e476@samcday.com>
 <4ee71802-c673-4044-9f82-b2222d9527ef@linaro.org>
 <je7E3q3sgc4pOc_A_4j_Hw-sVSHWDLknrylYkqPPklCkXjXjQUM-Mb0g0l92c9cmtudVj39hbeXBKeoYy60N0wqB4Wi4W774gSru4dlrwyo=@samcday.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <je7E3q3sgc4pOc_A_4j_Hw-sVSHWDLknrylYkqPPklCkXjXjQUM-Mb0g0l92c9cmtudVj39hbeXBKeoYy60N0wqB4Wi4W774gSru4dlrwyo=@samcday.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 04 Jun 2026 17:27:44 +0200
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



On 6/4/26 00:27, Sam Day wrote:
> Heya Casey,
> 
> On Wednesday, 3 June 2026 at 11:47 PM, Casey Connolly <casey.connolly@linaro.org> wrote:
> 
>> Hi Sam,
>>
>> (CC list definitely needs some tuning on the next revision XD)
> 
> Hmm? Is it incorrect to use `b4 prep --auto-to-cc` nowadays?

Urgh yeah I think this is a U-Boot issue with MAINTAINERS, needs some 
improvement but not your fault.
> 
>>
>> On 6/1/26 10:12, Sam Day via B4 Relay wrote:
>>> From: Sam Day <me@samcday.com>
>>>
>>> Many (often fused) bootloaders on older ARMv7 qcom SoCs do not support
>>> FDTs at all, and instead pass along ATAGS in r2.
>>>
>>> Minimal support for parsing memory info out of these tags is introduced,
>>> so that we can support mainline devicetrees, which expect the bootloader
>>> to populate /memory nodes.
>>
>> I think this should go its own armv7-specific file. It would probably
>> also make sense to just have a separate implementation of
>> board_fdt_blob_setup() since it's already really quite complicated.
> 
> I was considering that as well but decided against it, since sprinkling #ifdef
> everywhere is quite ugly, and the ATAGS handling code is quite minimal. Are you
> sure it really needs to be split out?

I would have the two implementations in different files
> 
>>
>> The SMEM series will do a bit of rework, in the next spin I'll probably
>> move the caching stuff out as well, maybe I should also take
>> board_fdt_blob_setup() then the file can be arm64 specific?
> 
> I'm not sure how we can have a separate version of board_fdt_blob_setup. On
> ARMv7, sometimes you'll br receiving ATAGS in r2, sometimes it'll be FDT. It
> depends on which bootloader you're chaining from.

I see, can we impose any limitations on this in practise? If not then I 
guess this is fine. I'd like to see all this logic cleaned up a bit as 
I'm just worried about introducing bugs

At the very least I'd like it if the atags parsing was moved to a 
different file then here we can do if 
(CONFIG_IS_ENABLED(...SNAPDRAGON_ARM32)
	qcom_parse_atags()

the compiler will optimise out the function call so there's no need for 
a stub version

> 
> e.g my nokia-fame can run U-Boot directly chained from SBL3 since the bootchain
> on this device has been broken enough, in which case U-Boot gets ATAGS. My
> samsung-expressltexx chains from lk2nd, in which case U-Boot gets an FDT.
> 
> Cheers,
> -Sam
> 
>>
>>>
>>> Signed-off-by: Sam Day <me@samcday.com>
>>> ---
>>>    arch/arm/mach-snapdragon/board.c | 119 ++++++++++++++++++++++++++++++---------
>>>    1 file changed, 91 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
>>> index 627b566d178..753983467a0 100644
>>> --- a/arch/arm/mach-snapdragon/board.c
>>> +++ b/arch/arm/mach-snapdragon/board.c
>>> @@ -11,6 +11,7 @@
>>>
>>>    #include <asm/gpio.h>
>>>    #include <asm/io.h>
>>> +#include <asm/setup.h>
>>>    #include <asm/system.h>
>>>    #include <dm/device.h>
>>>    #include <dm/pinctrl.h>
>>> @@ -175,6 +176,67 @@ static int qcom_parse_memory(const void *fdt)
>>>    	return 0;
>>>    }
>>>
>>> +static bool qcom_atags_valid(const phys_addr_t p)
>>> +{
>>> +	const struct tag *tags = (const struct tag *)p;
>>> +
>>> +	return tags && tags->hdr.tag == ATAG_CORE &&
>>> +	       tags->hdr.size >= sizeof(struct tag_header) / sizeof(u32);
>>> +}
>>> +
>>> +static int qcom_parse_atags(const struct tag *tags)
>>> +{
>>> +	phys_addr_t ram_end = 0;
>>> +	const struct tag *t;
>>> +	bool atags_end = false;
>>> +	u32 words = 0;
>>> +	int j = 0;
>>> +
>>> +	memset(prevbl_ddr_banks, 0, sizeof(prevbl_ddr_banks));
>>> +
>>> +	for (t = tags; words < SZ_16K / sizeof(u32); t = tag_next(t)) {
>>> +		if (t->hdr.tag == ATAG_NONE) {
>>> +			atags_end = true;
>>> +			break;
>>> +		}
>>> +		if (t->hdr.size < sizeof(struct tag_header) / sizeof(u32))
>>> +			return -EINVAL;
>>> +		if (t->hdr.size > SZ_16K / sizeof(u32) - words)
>>> +			return -EINVAL;
>>> +
>>> +		words += t->hdr.size;
>>> +
>>> +		if (t->hdr.tag != ATAG_MEM)
>>> +			continue;
>>> +		if (t->hdr.size < tag_size(tag_mem32))
>>> +			return -EINVAL;
>>> +		if (!t->u.mem.size)
>>> +			continue;
>>> +
>>> +		prevbl_ddr_banks[j].start = t->u.mem.start;
>>> +		prevbl_ddr_banks[j].size = t->u.mem.size;
>>> +		ram_end = max(ram_end, (phys_addr_t)t->u.mem.start + t->u.mem.size);
>>> +		j++;
>>> +
>>> +		if (j == CONFIG_NR_DRAM_BANKS)
>>> +			break;
>>> +	}
>>> +
>>> +	if (!atags_end && j < CONFIG_NR_DRAM_BANKS) {
>>> +		log_err("Provided more memory banks than we can handle\n");
>>> +		return -EINVAL;
>>> +	}
>>> +	if (!j)
>>> +		return -ENODATA;
>>> +
>>> +	qsort(prevbl_ddr_banks, j, sizeof(prevbl_ddr_banks[0]), ddr_bank_cmp);
>>> +
>>> +	gd->ram_base = prevbl_ddr_banks[0].start;
>>> +	gd->ram_size = ram_end - gd->ram_base;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>    static void show_psci_version(void)
>>>    {
>>>    #ifdef CONFIG_ARM64
>>> @@ -227,42 +289,52 @@ static void qcom_psci_fixup(void *fdt)
>>>     */
>>>    int board_fdt_blob_setup(void **fdtp)
>>>    {
>>> -	struct fdt_header *external_fdt, *internal_fdt;
>>> -	bool internal_valid, external_valid;
>>> -	int ret = -ENODATA;
>>> -
>>> -	internal_fdt = (struct fdt_header *)*fdtp;
>>> -	external_fdt = (struct fdt_header *)get_prev_bl_fdt_addr();
>>> -	external_valid = external_fdt && !fdt_check_header(external_fdt);
>>> -	internal_valid = !fdt_check_header(internal_fdt);
>>> +	int ret = -ENODATA, setup_ret = -EEXIST;
>>> +	struct fdt_header *internal_fdt = *fdtp;
>>> +	phys_addr_t prev_bl_arg = get_prev_bl_fdt_addr();
>>> +	bool internal_valid = internal_fdt && !fdt_check_header(internal_fdt);
>>> +	bool external_is_fdt = prev_bl_arg &&
>>> +			       !fdt_check_header((const void *)prev_bl_arg);
>>>
>>> -	/*
>>> -	 * There is no point returning an error here, U-Boot can't do anything useful in this situation.
>>> -	 * Bail out while we can still print a useful error message.
>>> -	 */
>>> -	if (!internal_valid && !external_valid)
>>> +	if (internal_valid) {
>>> +		debug("Using built in FDT\n");
>>> +	} else if (external_is_fdt) {
>>> +		debug("Using external FDT\n");
>>> +		*fdtp = (void *)prev_bl_arg;
>>> +		setup_ret = 0;
>>> +	} else {
>>> +		/*
>>> +		 * There is no point returning an error here, U-Boot can't do
>>> +		 * anything useful in this situation. Bail out while we can
>>> +		 * still print a useful error message.
>>> +		 */
>>>    		panic("Internal FDT is invalid and no external FDT was provided! (fdt=%p)\n",
>>> -		      external_fdt);
>>> +		      (void *)prev_bl_arg);
>>> +	}
>>>
>>>    	/* Prefer memory information from internal DT if it's present */
>>>    	if (internal_valid)
>>>    		ret = qcom_parse_memory(internal_fdt);
>>>
>>> -	if (ret < 0 && external_valid) {
>>> +	if (ret < 0 && prev_bl_arg) {
>>>    		/* No internal FDT or it lacks a proper /memory node.
>>>    		 * The previous bootloader handed us something, let's try that.
>>>    		 */
>>>    		if (internal_valid)
>>>    			debug("No memory info in internal FDT, falling back to external\n");
>>>
>>> -		ret = qcom_parse_memory(external_fdt);
>>> +		/* the prev BL arg is either an FDT or ATAGS */
>>> +		if (external_is_fdt)
>>> +			ret = qcom_parse_memory((const void *)prev_bl_arg);
>>> +		if (ret < 0 && qcom_atags_valid(prev_bl_arg))
>>> +			ret = qcom_parse_atags((const struct tag *)prev_bl_arg);
>>>    	}
>>>
>>>    	if (ret < 0)
>>>    		panic("No valid memory ranges found!\n");
>>>
>>> -	/* If we have an external FDT, it can only have come from the Android bootloader. */
>>> -	if (external_valid)
>>> +	/* If we have a prev BL arg, we assume it came from ABL */
>>> +	if (prev_bl_arg)
>>>    		qcom_boot_source = QCOM_BOOT_SOURCE_ANDROID;
>>>    	else
>>>    		qcom_boot_source = QCOM_BOOT_SOURCE_XBL;
>>> @@ -270,18 +342,9 @@ int board_fdt_blob_setup(void **fdtp)
>>>    	debug("ram_base = %#011lx, ram_size = %#011llx\n",
>>>    	      gd->ram_base, (unsigned long long)gd->ram_size);
>>>
>>> -	if (internal_valid) {
>>> -		debug("Using built in FDT\n");
>>> -		ret = -EEXIST;
>>> -	} else {
>>> -		debug("Using external FDT\n");
>>> -		*fdtp = external_fdt;
>>> -		ret = 0;
>>> -	}
>>> -
>>>    	qcom_psci_fixup(*fdtp);
>>>
>>> -	return ret;
>>> +	return setup_ret;
>>>    }
>>>
>>>    /*
>>>
>>
>>

