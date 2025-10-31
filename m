Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFD0CCF9FA
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 11:00:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CFB3838CE;
	Fri, 31 Oct 2025 12:00:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ht0lFCs/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED7C1838DD; Fri, 31 Oct 2025 12:00:48 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0470838AE
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 12:00:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-63bdfd73e6eso6100138a12.0
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 04:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761908446; x=1762513246; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W6c2FwerkeNHsVprIg5sOhh/7lMoFOLUxLN/0yRxPc0=;
 b=Ht0lFCs/2ItwOuEfN5g2LZXoOjlumweU4D9w80+UA8ZnpbcdZVGkMlVtNeS8qA4sYG
 SAczm/LLId3XUore2gtdqqAIUtmYupp/z0RQYXRJkeXTMHuAN5wY927srXnex8FB9gCw
 moDET6ncV/UgpiR4mN52RZiTlkxLoHJGZqeNBKzPdfRx6wR568pyMOUVVBsknEuu2ndx
 aLj4aDHoaRwuhpcoTp1wj2myIVPey+rl0LRRo6KZkj+ae1HmLvtvIMHjXc1eKRInHtBa
 ltRsuqvRDspXLhdpXhCVnLZVqJmm6kt2Nopd8eVQE25ll7zsaNxmRXzRa/zEzEmUydjl
 Wwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761908446; x=1762513246;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W6c2FwerkeNHsVprIg5sOhh/7lMoFOLUxLN/0yRxPc0=;
 b=AVEzSOC1Oq6aSax+JbD06qxnHZFX6dihrXY0OKLuCTVE74MN4T9JqgoAKswI2ASfTU
 yCGCnGm//G9WsgwO6AFkNHPh1GQzcI3deZATsjwjOFxcXDDlly06adSRbZBXd3k4Oibu
 Ahl92juJC54SeP2YIRwC2TMvGFGPA8JZqF+2UGiX+B+4ajJpJrmKx5xTPNX2+Ek3LlRK
 BCDC4AK6JeLrpM+FOttR8Z4jyKFASjbhEAwzy4BwMAcbR3vwKijro7SBn5g7DNf5ELkB
 Zyg+rYKP8JeDF7LanLyfgmkEZAgAo9M8/Omi/2NjFQLK0LNZHCw/ameGISoIye38evXe
 tiLg==
X-Gm-Message-State: AOJu0YwTk1p+DvW1n1btiOgxgzh3d5eWsZQX7f7vJIVNaekakU6CffC2
 8vSG8h//8e2JQEPbubvAYWNQotyVx3AzFwByCfd2xO9FrC2yGWumeq5M
X-Gm-Gg: ASbGncuvkZdlRi+M4pwBc2GLrpVrYKriCCbNORadC/K8yfJJv8f3x2/fSnB+Wf64oc7
 b4gVl0QWP7hkH8ra8qUhmce8krTFEsE0dttWvGMNGEVpmEZ0se17hASyoPJna6PMe19bzWLZWIw
 +BhJGxKIyl6XThaMWn1CIfb0cb/bR7CIPbTXqq1xpqN/3DeHTmDUbqVdRZp+yeWVAp3cuCwnh1w
 YszlnRLGAOf0cbh0XtBimqV2KsiQnlcZemth3VcLnWtl6ZSZa2CDF1dGuhcJ8kUuMQvXJuHKd1z
 I7Z7tNCKCqorzNBh1YH5fX3aBR4OlVUASmm7YUWmvo0LT6OPl+Y09mT1X39e8LPYpdIRgAjfntL
 BWu0ViVBx6oCriMbR0aWqgC3WVf034UuC/Yu7jhtcwxB5PYE17UKOK/hu1YfR1jOmegnAIvHtrG
 OKjGVOzQNhjk7LOWJVGzXIlnwI96zgfToHszKIht3nIOGGFcs3IkEy
X-Google-Smtp-Source: AGHT+IE79RaB/u0ZS06+I9Env0p2/wPIC2PM2cxZN+12I9RemjvekSbDA94VHYa8VXL7lmiMM0372Q==
X-Received: by 2002:a17:907:2dab:b0:b6d:5f15:2d02 with SMTP id
 a640c23a62f3a-b706e5835d9mr376649466b.26.1761908445442; 
 Fri, 31 Oct 2025 04:00:45 -0700 (PDT)
Received: from ?IPV6:2001:b07:aac:705d:d121:6c76:14f1:d3f0?
 ([2001:b07:aac:705d:d121:6c76:14f1:d3f0])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7077c8e323sm148780466b.54.2025.10.31.04.00.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 04:00:44 -0700 (PDT)
Message-ID: <071bbf2d-0cbd-4359-abfa-b020b5d32ef5@gmail.com>
Date: Fri, 31 Oct 2025 12:00:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: [PATCH v11 00/11] Add support for dynamic MMU
 configuration
To: Anshul Dalal <anshuld@ti.com>, Francesco Dolcini <francesco@dolcini.it>,
 trini@konsulko.com, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Cc: u-boot@lists.denx.de, d-gole@ti.com, b-padhi@ti.com, vigneshr@ti.com,
 nm@ti.com, robertcnelson@gmail.com, w.egorov@phytec.de,
 francesco.dolcini@toradex.com, ggiordano@phytec.com, m-chawdhry@ti.com,
 afd@ti.com, bb@ti.com, u-kumar1@ti.com, devarsht@ti.com,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de
References: <20251017131540.3636067-1-anshuld@ti.com>
 <20251027165225.GA71553@francesco-nb> <DDTOEZHOH4OK.1ZQ850D6UHD0Z@ti.com>
 <7401dee0-7ac6-4280-a934-0881dfbb1b6c@gmail.com>
 <DDUOKBSB2Q29.17CMLWGWUOD48@ti.com>
Content-Language: en-US
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <DDUOKBSB2Q29.17CMLWGWUOD48@ti.com>
Content-Type: text/plain; charset=UTF-8
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



On 29/10/2025 09:58, Anshul Dalal wrote:
> On Tue Oct 28, 2025 at 10:26 PM IST, Emanuele Ghidoli wrote:
>> On 28/10/2025 05:38, Anshul Dalal wrote:
>>> Hi Francesco,
>>>
>>> On Mon Oct 27, 2025 at 10:22 PM IST, Francesco Dolcini wrote:
>>>> Hello Anshul,
>>>>
>>>> On Fri, Oct 17, 2025 at 06:45:22PM +0530, Anshul Dalal wrote:
>>>>> Hi all,
>>>>>
>>>>> In U-Boot, TI only provides a single memory map for all k3 platforms, this
>>>>> does not scale for devices where atf and optee lie outside the range 0x80000000
>>>>> - 0x80080000 and 0x9e780000 - 0xa0000000 respectively.
>>>>>
>>>>> There are also issues for devices with < 2GiB of memory (eg am62SiP with 512MiB
>>>>> of RAM) as the maximum size for the first DRAM bank is hardcoded to 2GiB in the
>>>>> current memory map. Furthermore the second DRAM bank is mapped even for devices
>>>>> that only have a single bank.
>>>>>
>>>>> Therefore this patch set adds the required functionality to create the MMU table
>>>>> at runtime based on the device-tree.
>>>>>
>>>>> The patch set has been build tested on all effected platforms but boot-tested
>>>>> only on TI's K3 EVMs, the beagleplay and phytec's phycore-am6* platforms.
>>>>>
>>>>> The following effected boards have not been boot tested:
>>>>>  - verdin-am62
>>>>
>>>> it seems that this series introduce a regression on verdin-am62, I have
>>>> not done a bi-sect yet, but we run daily build of U-Boot master and the
>>>> regressions seems to have started when this patch series was
>>>> merged.
>>>>
>>>> On verdin-am62 we detect the RAM size at run-time, see
>>>> board/toradex/verdin-am62/verdin-am62.c:dram_init(), and now we always
>>>> get 2GiB even for modules with only 512MB or 1024MB of memory.
>>>>
>>>
>>> This patch series modified the behavior of enable_caches to configure the
>>> memory map of the device as per the device-tree instead of using a
>>> static map for all of K3.
>>>
>>> The issue with verdin-am62 seems to be that while you do properly
>>> configure gd->ram_size in your dram_init, the '/memory' node of the
>>> device-tree remains unchanged with the outdated 2GiB size.
>>>
>>> You could try updating the fdt's memory size to the correct value in
>>> dram_init and see if that fixes the problem.
>>>
>>> Regards,
>>> Anshul
>> Hello Anshul,
>>
>> I was bisecting the series, and I can confirm that the commit "mach-k3: map
>> all banks using mem_map_from_dram_banks" introduces the regression.
>>
>> Given that initcall_run_f() calls dram_init_banksize(), and after relocation
>> board_init_r() calls enable_caches() (call stack: board_init_r() ->
>> initcall_run_r() -> initr_caches() -> enable_caches()), I would expect that
>> enable_caches() should not override the bank sizes previously configured.
>> Currently, however, enable_caches() introduces this side effect.
>>
>> Wouldn’t it make more sense to call fdtdec_setup_memory_banksize() in the
>> default dram_init_banksize() (in arch/arm/mach-k3/k3-ddr.c) and avoid calling
>> it again in mem_map_from_dram_banks()?
>>
> 
> We could follow that order too but that would makes a call to
> mem_map_from_dram_banks dependent on gd->bd->di_dram being correctly
> populated. I had assumed whoever calls mem_map_from_dram_banks had made
> sure to properly fixup the memory node of the fdt.
> 
> Given that it seems like the root cause of the problem is with the
> U-Boot's device-tree not having the correct memory node, we could add a
> call to fixup_memory_node (arch/arm/mach-k3/k3-ddr.c) from A53 SPL to
> ensure the memory can be queried stright from the device-tree once we do
> get to U-Boot proper.
> 
> 	--- a/board/toradex/verdin-am62/verdin-am62.c
> 	+++ b/board/toradex/verdin-am62/verdin-am62.c
> 	@@ -46,6 +46,13 @@ int dram_init_banksize(void)
> 		return ret;
> 	 }
> 
> 	+#ifdef CONFIG_XPL_BUILD
> 	+void spl_perform_board_fiups(struct spl_image_info *spl_image)
> 	+{
> 	+       fixup_memory_node(spl_image);
> 	+}
> 	+#endif
> 	+
> 	 /*
> 	  * Avoid relocated U-Boot clash with Linux reserved-memory on 512 MB SoM
> 	  */
> 
> 
> If you could get to U-Boot prompt with the above diff, could you
> share the output of the 'meminfo' command with the following configs
> added:
> 	CONFIG_CMD_MEMINFO=y
> 	CONFIG_CMD_MEMINFO_MAP=y
> 
> Though so far, I have been unsuccessful in my attempts to reproduce a
> boot failure on our own 512MiB platforms (AM62x SiP). Could you share
> the boot logs with '#define DEBUG' in common/board_r.c, common/board_f.c
> and mach-k3/common.c to help further narrow down the issue.
> 
> Regards,
> Anshul

Hello Anshul,
let me try to rephrase.

The enable_caches() function is not only enabling caches, but also updating
the memory map.
It is not expected from the point of view of the caller and this side effect
introduces a regression on our U-Boot, since the memory banks are already
configured in dram_init().

I understand that updating the device tree, as you proposed, could work around
the issue, but that does not really fix the root cause.
Having a function perform unexpected operations is the best way to introduce
regressions now and bugs in the future.

We should either revert the patch or properly fix the issue.

Regards,
Emanuele


