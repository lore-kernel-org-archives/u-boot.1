Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39E4CF9C69
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 20:00:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B47B88AA7;
	Tue, 24 Sep 2024 22:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727208057;
	bh=h1pDbgEEYPVl5o7mW/Ejn6GyStV5sW7o6Ah6ZkXtoRI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tAV2GoCsBprunYHU7JTft6+sQeQmxO7ZQO/lP7RXrMQZA8tjwPmq/CmoKVHtKL5+A
	 5lHqMnx5dccHYhmZ4uyyiQUE81glVSF7IUx/7HaHcSvwAnBmqEq4SQr/62WIbAerzh
	 tWM/2fdkTO8fKocdHkhG3uV9r7kNq5z+yDldQWYVK403rEgsKRJCSrxDizLhlMS8ab
	 xOid9PZ6j1pXFGT5pg7lBkQiu7VFkQTrZpB9FaKG4MKf3teXu0ZI6IvTp3t40S9ZHh
	 ueB9qLbcNl4eFAEwc6VVrU3BCepfaAXaZQDDNpdip+K93TglYxT1sV+a1tpFK8wMGb
	 iCaseppnLF0AQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C447788995;
 Tue, 24 Sep 2024 22:00:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727208056;
 bh=h1pDbgEEYPVl5o7mW/Ejn6GyStV5sW7o6Ah6ZkXtoRI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=xQhBIV1e4JOwV+9hkkx/9BirIV0LSM8dC608DsYnN4v6iq9Izna2jFXyXGYX3duCl
 imMtNVJj1hLXMdl48X3ETx3IInEGHAYDDShqU3uCNRjyO/6RrufoaZWU5SJcyO4cIP
 im689zbEBKmzNW2RqZlthuLCH5VxsxuxFL56pX98nQN4ivrake28G2vz3Q1BJ7iFur
 egzCj66ubAG3etgTlM/sCX2LPOfsFzHtCFVAvcv/NBDZHVtAfXMwd1lAC1YS6PM0si
 n3kHZH252nTPUJ5Bs6ebU4PbZ3uhsfWEeYtz4gvE4IBP0uAEwFFyREwzIythPhtGaJ
 OYyN+1QXkP9gA==
Message-ID: <19445387-1b9a-45e9-84f2-c6de0487ce34@denx.de>
Date: Tue, 24 Sep 2024 20:32:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/20] arm: socfpga: agilex5: Add low level
 initialization
To: "Chee, Tien Fong" <tien.fong.chee@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 "Meng, Tingting" <tingting.meng@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@intel.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <20240920070242.20884-5-tien.fong.chee@intel.com>
 <9cc437c8-59dc-4e78-82d4-8ef479ca9ba1@denx.de>
 <DM8PR11MB55924FDB9E2C081EE97216CCD2682@DM8PR11MB5592.namprd11.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <DM8PR11MB55924FDB9E2C081EE97216CCD2682@DM8PR11MB5592.namprd11.prod.outlook.com>
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

On 9/24/24 5:14 AM, Chee, Tien Fong wrote:

Hi,

>>> diff --git a/arch/arm/mach-socfpga/Makefile
>>> b/arch/arm/mach-socfpga/Makefile index 67c6a8dfec5..53c91d1d2a5
>> 100644
>>> --- a/arch/arm/mach-socfpga/Makefile
>>> +++ b/arch/arm/mach-socfpga/Makefile
>>> @@ -58,6 +58,7 @@ endif
>>>
>>>    ifdef CONFIG_TARGET_SOCFPGA_AGILEX5
>>>    obj-y	+= clock_manager_agilex5.o
>>> +obj-y	+= lowlevel_init_agilex5.o
>>>    obj-y	+= mailbox_s10.o
>>>    obj-y	+= misc_soc64.o
>>>    obj-y	+= mmu-arm64_s10.o
>> Can this be wired into existing early hook function, like s_init or so ?
> 
> I cannot find the caller for s_init, wonder where is the s_init is called?

arch/arm/cpu/armv7/lowlevel_init.S:.pushsection .text.s_init, "ax"
arch/arm/cpu/armv7/lowlevel_init.S:WEAK(s_init)
arch/arm/cpu/armv7/lowlevel_init.S:ENDPROC(s_init)
arch/arm/cpu/armv7/lowlevel_init.S:     bl      s_init

Maybe such a default lowlevel_init for armv8 could also have an s_init ?

> What's concern with lowlevel_init()? It's also wired into existing early hook function which's located inside start.S
I would like to avoid duplicating lowlevel_init functionality as much as 
possible , common lowlevel_init would be very welcome .
