Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B92EC02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 12:02:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EE5E80326;
	Tue, 21 Jan 2025 13:02:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737460973;
	bh=c3I4gy6nqAXY9VMAhkhJNvCktl6lWwv+k9smUjhxODY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uyvGoDx3ta2t2/vOSD/0NKMnnvLd7RvodvpbLHYMwuznyfTesy/43XKISWnGyFii3
	 erqGwVipRyuJC9xcMWITLApnt8Kp2BSdBOLu1PGsE2w1P4eEhQUlgGcpRtnthP+JZv
	 tmggTOedrhRvJY26lx6wwLc9eWV7ZsnJcfqisefCd2lJFP8ouWeX+2xsM2zSMnF3Dg
	 4bZPKPLBWIAJIVPmwY06S5ss6p9XzIjFu7au1/S6/Kv6TyecF3F7pqayVdAdbn1STK
	 +AkMfoM7uBiv3qn9JXyLPOJbR8pFLzhzAcd8wfGLolecOOngVDYwSgA7lT5GSbjKNW
	 8GfCrtq6zfsqw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 135F7805C5; Tue, 21 Jan 2025 13:02:52 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED94D801F5
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 13:02:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="aWh3OH5R"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E55F9104811E3; Tue, 21 Jan 2025 13:02:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737460969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c3I4gy6nqAXY9VMAhkhJNvCktl6lWwv+k9smUjhxODY=;
 b=aWh3OH5Rurr1crG0jSfcrXNdBi4zUUc8flp7dlDoILQYwTNSLRIKI0Muw4dnEpyDs24s3W
 m2FOW6rjQrIQdPWL83girydfcrx8m29dmwyd5Qgdkel1BWqiWKthHCoUeicSP3t6FYvpAr
 LFNGO6C6flFe5Sl0k9EUulKolGW4RDzTGiu00flY3mjfHQiXGOO0iwckEAR0iGRb2xZfHF
 qHliQsFdlaTsEP2PCtEzAqAucOyjNQZ6rbEpLFMueHuUYaTRJo+pmgqsVE3YioJvxNSgZr
 G3qmhdZfrxn7VudnCydEqdnQ68RanwHbd1l3v2KRRwNtOBMH8x4kEo59vtL2dg==
Message-ID: <dd236435-ddf6-4638-be7f-25e6a08d37fd@denx.de>
Date: Tue, 21 Jan 2025 10:46:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2] image: apply FDTOs on FDT image node without a
 load property
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>
References: <20250116-extlinux-relocate-dtb-when-dtbo-v2-1-d011582c2b7e@cherry.de>
 <709f0a6b-32d1-4e18-915a-dfb3f87fb9a6@denx.de>
 <64da6cae-2d63-4c8e-99b3-d19870c0cbee@cherry.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <64da6cae-2d63-4c8e-99b3-d19870c0cbee@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 1/21/25 9:25 AM, Quentin Schulz wrote:

[...]

>>> --- a/boot/image-fit.c
>>> +++ b/boot/image-fit.c
>>> @@ -2348,10 +2348,10 @@ int boot_get_fdt_fit(struct bootm_headers 
>>> *images, ulong addr,
>>>       char *next_config = NULL;
>>>       ulong load, len;
>>>   #ifdef CONFIG_OF_LIBFDT_OVERLAY
>>> -    ulong image_start, image_end;
>>>       ulong ovload, ovlen, ovcopylen;
>>>       const char *uconfig;
>>>       const char *uname;
>>> +    char *of_flat_tree;
>>
>> Can this be void * instead ?
>>
> 
> The compiler seems happy with that. FWIW, map_sysmem() returns a void*, 
> and boot_relocate_fdt() expects a char** and we anyway cast it to a 
> ulong later.

Indeed, that's what struck me.

> The question I have is why? What does this bring? Maybe there's 
> something I can learn here :)
Nothing much, except for type opaqueness. The ideal fix would be to 
align the types, but that would be a huge undertaking and I cannot ask 
that of you as a prerequisite for this one fix.
