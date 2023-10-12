Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434FECDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 04:11:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBF8386DED;
	Thu, 12 Oct 2023 06:11:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E6PFk/sT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 064D686E07; Thu, 12 Oct 2023 06:11:28 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C52B86D80
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 06:11:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7740aa4b545so34804685a.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 21:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697083882; x=1697688682; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r9yblc26hiqLFsMQ+iktDIb2UjgqQ1e+Jvp6BprNCNs=;
 b=E6PFk/sTxyyicZMd3R8s7pXEy0o5WCnzMZnHwMTk0p3vvNmkEurMZ53uZ/HcTimGUq
 PzQTJB/7QPyXsmcY0AdW83CkLE4q92FaoJJqj9Zi4a24rCstuUXa6D+dcBiPVGkGXDyf
 y23pTDF4ajsR3MmoGmrGdlYoXY80oj4AdhO5kI+RbBsY4BWYIl548U14mfstBx1euqpK
 8oL0Ty208GUy6XMkLF7Vcph2cl3UraqEXO4zQcaHGYouym0b9svn4dB0eCDw12FTNQF/
 YdOtcUkw0ksGA8HtYv8dg5iggZGZVd/lD+JGWeV+BM3bVliB+RIuQkKQFipGhZ/wcCc4
 K3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083882; x=1697688682;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r9yblc26hiqLFsMQ+iktDIb2UjgqQ1e+Jvp6BprNCNs=;
 b=hieBa0B3GovJkDLBNXJJgDZ7SDaAdUOJk4syzRKNQ5xrEzleIn879XmnhjBFhvQP29
 DRVU55ZKbdry3K+/kf+sgWGm2PVxg2ASl/AasHKS98GM3RjQwkRjUQQckHFsaXN+KT3m
 2WD3iIzwRo51bkhJytPK7e239Ekfnk3M2gyeXde1RNL5ftGfFHJD6QWDnlQCjYpFEM+I
 xEtqPwMHfiKB0Q79jfFdyTCCpPmFO14g3X/N2mMiPTxudk41sMo0lno4cKU8WNSHFvH8
 vdahhEwPbV8nDfTd1fTv5L4JTGtdL7pakBN1c6DxvAOZUrWOqOI+/gqJbHgPUmqmYG5Z
 H4YQ==
X-Gm-Message-State: AOJu0Ywj100zd6yJpWFFSMcpWoN8FF2E6V59WaL+V3LC7HDkZu9InE3n
 F1IFuFV5VvUGVBW65cd4DZw=
X-Google-Smtp-Source: AGHT+IE5IcbnCLRFosJg+WOoLEe0DwqWYpQJQb91mF2a0255yrZh1O11QRgAWiEn3kLggT294v3prg==
X-Received: by 2002:a05:620a:4251:b0:76f:167a:cc4a with SMTP id
 w17-20020a05620a425100b0076f167acc4amr27353732qko.47.1697083882107; 
 Wed, 11 Oct 2023 21:11:22 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 bi3-20020a05620a318300b0077706084c32sm4022682qkb.105.2023.10.11.21.11.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 21:11:21 -0700 (PDT)
Message-ID: <223bf258-7674-5f21-1931-78e39d839783@gmail.com>
Date: Thu, 12 Oct 2023 00:11:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 24/26] test: spl: Add a test for the NET load method
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-25-seanga2@gmail.com>
 <CAPnjgZ2F-F=45-NEpzd36nyqYJ33JZsw5Vk3Thq2qxHDqHUe3w@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAPnjgZ2F-F=45-NEpzd36nyqYJ33JZsw5Vk3Thq2qxHDqHUe3w@mail.gmail.com>
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

On 10/11/23 23:41, Simon Glass wrote:
> On Wed, 11 Oct 2023 at 18:56, Sean Anderson <seanga2@gmail.com> wrote:
>>
>> Add a test for loading U-Boot over TFTP. As with other sandbox net
>> routines, we need to initialize our packets manually since things like
>> net_set_ether and net_set_udp_header always use "our" addresses. We use
>> BOOTP instead of DHCP, since DHCP has a tag/length-based format which is
>> harder to parse. Our TFTP implementation doesn't define as many constants
>> as I'd like, so I create some here. Note that the TFTP block size is
>> one-based, but offsets are zero-based.
>>
>> In order to avoid address errors, we need to set up/define some additional
>> address information settings. dram_init_banksize would be a good candidate
>> for settig up bi_dram, but it gets called too late in board_init_r.
>>
>> Signed-off-by: Sean Anderson <seanga2@gmail.com>
>> ---
>>
>>   arch/sandbox/cpu/spl.c           |   3 +
>>   arch/sandbox/include/asm/spl.h   |   1 +
>>   configs/sandbox_noinst_defconfig |   6 +-
>>   test/image/Kconfig               |   9 ++
>>   test/image/Makefile              |   1 +
>>   test/image/spl_load_net.c        | 252 +++++++++++++++++++++++++++++++
>>   6 files changed, 271 insertions(+), 1 deletion(-)
>>   create mode 100644 test/image/spl_load_net.c
>>
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
>> diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
>> index 09e3d10d6a5..8153df18d68 100644
>> --- a/arch/sandbox/cpu/spl.c
>> +++ b/arch/sandbox/cpu/spl.c
>> @@ -126,6 +126,9 @@ void spl_board_init(void)
>>   {
>>          struct sandbox_state *state = state_get_current();
>>
>> +       gd->bd->bi_dram[0].start = gd->ram_base;
>> +       gd->bd->bi_dram[0].size = get_effective_memsize();
> 
> These could use a common as to why they are needed here.

OK.

--Sean
