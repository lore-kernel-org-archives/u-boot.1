Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB05BE9E2EB
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 11:50:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45FEA83D9C;
	Wed, 11 Feb 2026 12:50:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Ctuvso1y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBEDD83D9F; Wed, 11 Feb 2026 12:50:43 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF78883D77
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 12:50:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5D0DD3F2C9
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 11:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1770810641;
 bh=vVNCIXdo+OHheJ3h4Y+f/plbRxrOHjRHVT2m0ReN120=;
 h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
 In-Reply-To:Content-Type;
 b=Ctuvso1yXstxmSE+KR5ellkpw4nvSWW4zquvJBx+atZs2UxROztqJe01JVrCqgyct
 mzU2brL9o5fVi1ayeQp82ll/Eq/0oBBsMk1tBQcZ0imzdG4AAbpYXCGNR0njx837yz
 r8g6OGSv+8SB1pHpjnHCCGHEFufju83ZhLtpnv8oBXyBH6cgXvCvYtIKkTAo9qXwf6
 36crkrQewjJyR4LBY/SSQzMeA8DdmGhM2ojZavtM8XAu1Lg83uKrg2DD1ZTu5t4oLB
 dLo+IGT7S6ENASgmC4Z9odIAxhUQCBo8GpIy6klmdz90FxEg8Uq3TUaGLmFeD+WPOx
 /Jq28EZemMfhsIKZYu+yNZXAciov7XEi+nj75ciu3SKjM8lhaAfCfBPrVZAKwA+d4R
 TVlNlNwT/yy8IiDUvoYcbz8fjIsPszeC/Q3Bb7eTcdCGiT7cvaF8m2QiEsfResFRO8
 8c6BGyQJ86YWPTHuEwq4P7Jyk92qVXIFGaxRiiRUfp6amJR2xoF3r2ykCv5BbFUCTU
 2S2k7wFDuHtChcXaWrq+qFmT1rzvaDPkkFheTR6oxHhGfOLPxYOl1EnsY+vmi66vai
 9rAZFCW5wNnZTo0o6EMKfeLKdLE1cSJFqitAAu4CqI/SysWNVdV1+8r9x9JkC/qdfE
 zGfSFoMwHWA/52gzFvwk7HUw=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4801c1056c7so11522235e9.2
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 03:50:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770810641; x=1771415441;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vVNCIXdo+OHheJ3h4Y+f/plbRxrOHjRHVT2m0ReN120=;
 b=hoG3uiyOBOCV/+co5ZFkUja3vnbbLYczWafHEM92jG4Lll4P6ocAJ/F1+H5KQY1+Nz
 CUvSWJHc4oGYj+tCzUT+ZOdMZ5MrOiGcZjSNfct1UFRlgicfsEkHc8pN8U/HtSvkoE1Y
 Qooc8lBftZcqM0lWQD+PIGmZkVXyqbEnXiSJkoYIFNnYfNn3JNsUWItcc09nahyNRe9H
 gjGF+693zv/CFFGJRfQZFm3Sz5lvWMoq9QlhsjeiKeotksZfUflZZbF8rUxW6NlAUoKT
 RObhSzGn2GDRfx4/pUsEY5OiZ2F4ghaAE1Kd5RXkPD+TqeVQ78pL/o1iXMtzUfoZakpn
 Fq3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc2/W6H961wfLK6xeh+qpUGW79LiTpl9wnCLMPAi40uHZQENLumh/wbLttjBVjhepKzO7+B44=@lists.denx.de
X-Gm-Message-State: AOJu0Yw31yImmMt2eDZ1CMOpBA7qECukJxE74nYf/snpcuRMUhTezMSj
 W6ssloCYxZj31qeujj1ROCuSqtGczMY3+eQKD+xej5yOZPQxc4D8DA15I4h2lY79CqQokxYCH//
 xW+Uw9spsM6Pt8TcUfo+op0pxVkZ4u0MyBt96QZCemaQgzo5hi0Rz78tOByGKaQuQ4LLmuFi/G8
 ckHNs=
X-Gm-Gg: AZuq6aInQWJMYDv3khMmJZcOLCDuz1H1uaKb4bZtrMnVmzgu1YzsLYf2XelXtMkMlYZ
 xwNrFT3C8JAjSQQXBY8SokmwRoB+cJgWBeASVLj44sLifkgwCI+sHzzH4EoBqfmxj231ElImWmh
 ejxQvq3+C3wijSXvGaYfgOVpDsmmxH/UvL5xp0fL0qm3odoZWzobZh4aerK9zHAYT6eriUflZTC
 hoQWIGNQiW3+KFFQxYRmG/UfKilRJ2hZ16pj5nT9UjphMGf1l6BujX/KOaeU/OySnLz7cvVtvBc
 Coi7SBefajgrBc8R+XeoUaiCjXDnRxopI+UIvGcOhjEMI2+lSBqIkl5ROZvW4JJCy0uzROVbepd
 4KuOzDaNtdKeFjYHyTo7oWMWi+QRastaf+Bgb4RByoUp19jvuNrtNCp9LdQ/mae7TRk25Y43aaF
 I5X4ypNEUhQHFLb3FoVRQ=
X-Received: by 2002:a05:600c:470c:b0:477:b734:8c22 with SMTP id
 5b1f17b1804b1-483201dab23mr266027915e9.8.1770810640761; 
 Wed, 11 Feb 2026 03:50:40 -0800 (PST)
X-Received: by 2002:a05:600c:470c:b0:477:b734:8c22 with SMTP id
 5b1f17b1804b1-483201dab23mr266027515e9.8.1770810640318; 
 Wed, 11 Feb 2026 03:50:40 -0800 (PST)
Received: from [192.168.103.128]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d82a1c2sm185208985e9.9.2026.02.11.03.50.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Feb 2026 03:50:39 -0800 (PST)
Message-ID: <b236ac3f-493e-452e-93ce-03c0fc73baf3@canonical.com>
Date: Wed, 11 Feb 2026 12:50:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: fix ecpt size computation
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20260211093308.3265022-1-vincent.stehle@arm.com>
 <a386de9e-1dc9-4b50-a86c-bb8dfd845eef@gmx.de> <aYxsaXdISybHOQTq@debian>
Content-Language: en-US
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Jose Marinho <jose.marinho@arm.com>,
 u-boot@lists.denx.de
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <aYxsaXdISybHOQTq@debian>
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

On 2/11/26 12:47, Vincent Stehlé wrote:
> On Wed, Feb 11, 2026 at 10:56:30AM +0100, Heinrich Schuchardt wrote:
>> On 2/11/26 10:33, Vincent Stehlé wrote:
>>> The size of the memory allocated for the EFI Conformance Profiles Table is
>>> computed with `num_entries' always equal to zero, which is incorrect when
>>> CONFIG_EFI_EBBR_2_1_CONFORMANCE is enabled.
>>>
>>> This can be verified by allocating the ECPT memory with malloc() instead of
>>> efi_allocate_pool(), building u-boot with sandbox_defconfig and
>>> CONFIG_VALGRIND=y, and by finally running the following command:
>>>
>>>     valgrind --suppressions=scripts/u-boot.supp \
>>>       ./u-boot -T -c 'efidebug tables'
>>>
>>> Fix this by using an array of the supported profiles GUIDs instead, which
>>> should also be easier to extend in the future.
>>
>> Thank you Vincent for this patch.
> 
> Hi Heinrich,
> 
> Thanks for reviewing.
> 
>> Maybe mention in the commit message that U-Boot should publish all supported
>> EBBR revisions.
> 
> Ok, will do.
> 
>>
>>>
>>> Fixes: 6b92c1735205 ("efi: Create ECPT table")
>>> Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
>>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>> Cc: Tom Rini <trini@konsulko.com>
>>> Cc: Jose Marinho <jose.marinho@arm.com>
>>> ---
>>>    lib/efi_loader/efi_conformance.c | 18 +++++++++---------
>>>    1 file changed, 9 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/lib/efi_loader/efi_conformance.c b/lib/efi_loader/efi_conformance.c
>>> index 2bae93a94bd..9768b5ae824 100644
>>> --- a/lib/efi_loader/efi_conformance.c
>>> +++ b/lib/efi_loader/efi_conformance.c
>>> @@ -13,8 +13,12 @@
>>>    #include <malloc.h>
>>>    static const efi_guid_t efi_ecpt_guid = EFI_CONFORMANCE_PROFILES_TABLE_GUID;
>>> -static const efi_guid_t efi_ebbr_2_1_guid =
>>> -	EFI_CONFORMANCE_PROFILE_EBBR_2_1_GUID;
>>> +
>>> +static const efi_guid_t profiles[] = {
>>
>> As profiles[] is not used outside efi_ecpt_register(), there is no need to
>> make it a static variable.
> 
> I am not sure why a "global" symbol would be better than a static one, but if
> you like this solution we could make the profiles[] array extern.

Sorry to not be clear. I wanted to suggest a local symbol.

Best regards

Heinrich

> 
> Then I guess we should rename it with a much longer name to avoid namespace
> "pollution":
> 
> 	const efi_guid_t efi_conformance_profiles[] = {
> 		...
> 
> All the sizeof() and ARRAY_SIZE() would have to follow, too.
> 
> Alternatively, we could move the array declaration inside the
> efi_ecpt_register() function completely:
> 
> 	efi_status_t efi_ecpt_register(void)
> 	{
> 		struct efi_conformance_profiles_table *ecpt;
> 		efi_status_t ret;
> 		size_t ecpt_size;
> 
> 		static const efi_guid_t profiles[] = {
> 		#if CONFIG_IS_ENABLED(EFI_EBBR_2_1_CONFORMANCE)
> 			EFI_CONFORMANCE_PROFILE_EBBR_2_1_GUID,
> 		#endif
> 		};
> 
> 		...
> 
> This is still static here, but for storage duration not linkage. One advantage
> is that the name would not have to change. I am not a big fan of the #if in
> function scope, but if you prefer this solution this is fine as well.
> 
> Best regards,
> Vincent.
> 
>>
>> Otherwise looks good to me.
>>
>> Best regards
>>
>> Heinrich
>>
>>
>>> +#if CONFIG_IS_ENABLED(EFI_EBBR_2_1_CONFORMANCE)
>>> +	EFI_CONFORMANCE_PROFILE_EBBR_2_1_GUID,
>>> +#endif
>>> +};
>>>    /**
>>>     * efi_ecpt_register() - Install the ECPT system table.
>>> @@ -23,12 +27,11 @@ static const efi_guid_t efi_ebbr_2_1_guid =
>>>     */
>>>    efi_status_t efi_ecpt_register(void)
>>>    {
>>> -	u16 num_entries = 0;
>>>    	struct efi_conformance_profiles_table *ecpt;
>>>    	efi_status_t ret;
>>>    	size_t ecpt_size;
>>> -	ecpt_size = num_entries * sizeof(efi_guid_t)
>>> +	ecpt_size = sizeof(profiles)
>>>    		+ sizeof(struct efi_conformance_profiles_table);
>>>    	ret = efi_allocate_pool(EFI_BOOT_SERVICES_DATA, ecpt_size,
>>>    				(void **)&ecpt);
>>> @@ -39,12 +42,9 @@ efi_status_t efi_ecpt_register(void)
>>>    		return ret;
>>>    	}
>>> -	if (CONFIG_IS_ENABLED(EFI_EBBR_2_1_CONFORMANCE))
>>> -		guidcpy(&ecpt->conformance_profiles[num_entries++],
>>> -			&efi_ebbr_2_1_guid);
>>> -
>>> +	memcpy(ecpt->conformance_profiles, profiles, sizeof(profiles));
>>>    	ecpt->version = EFI_CONFORMANCE_PROFILES_TABLE_VERSION;
>>> -	ecpt->number_of_profiles = num_entries;
>>> +	ecpt->number_of_profiles = ARRAY_SIZE(profiles);
>>>    	/* Install the ECPT in the system configuration table. */
>>>    	ret = efi_install_configuration_table(&efi_ecpt_guid, (void *)ecpt);
>>

