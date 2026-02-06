Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E9BEE6B48
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 19:11:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA763838FA;
	Fri,  6 Feb 2026 20:11:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dPHk6l1v";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PJiK1rGx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0614683AA9; Fri,  6 Feb 2026 20:11:36 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5947836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 20:11:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4f73bn4cW1z9tfs;
 Fri,  6 Feb 2026 20:11:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770405093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HrxMha96P7jM1r9nzukbUGj5kHORzPelH5Svk5al4n0=;
 b=dPHk6l1vSHi3FSzlvS84o5NLtNgndaPu345YVirqAD9qEp8oQPI/xcwDINtwvNS/ePBaRa
 +1fzhUn8l82D8Zfrx0NFZMie50p1PogB6CrHUYvjcTOPdRfRbpRwOoEIxTE8UUkca8SBrB
 OOboOI6jmTt5Q8oIcju6vkl2v4m3BWIATX+n6Z8Tp8WFOyBZIyi8Blb07AAivwMs6EM1NS
 gguK1ps4AARA6Wf5abG7/bNoZedMM15UWzqLnN3dvQ6K5t8y/QTbahDY1RX657wGKCkEZK
 b0xRHIWGtT8ZQ9tknn8jUj8v0jV7nG/Zw5S0XQqJphamPXRFYj0aelaVCdukJA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=PJiK1rGx;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <b314c6b2-376c-4c55-9a7c-e7ddb8a22a8d@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770405091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HrxMha96P7jM1r9nzukbUGj5kHORzPelH5Svk5al4n0=;
 b=PJiK1rGxdwMco8AN8wRLR1//JgInXjC2EW0pZ7wW2EHlOoyJPK9QFDUcD6ASLoGdwl+DoD
 aRm6i/YjbCu4gSgI+dQotTqTch+gKrh86zdQHZeEZ+dqjQkToDUlaGyy6frQ6yRPV2i/cf
 umpIeAOndAp9bYO+J7vIGDIdmGUQY3TOJGqVKHF+XKriQLtO0yHJTI/RgbM6zZLCqAUr52
 AbY8zV6HPVJ1gj8ZiqGHn7VFvgf4N1k3Nr12EaKmuWj5EYidKbsoGPAfstl8MqS6cDjrNx
 4ol46qTBWxbGyg/dWGsO5kJf82mN0Jm6hP5cAkc6/dZLztZWEjtZIj7ZTALqug==
Date: Fri, 6 Feb 2026 20:11:25 +0100
MIME-Version: 1.0
Subject: Re: [REGRESSION] scripts/dtc: Update to upstream version
 v1.7.2-35-g52f07dcca47c
To: Ye Li <ye.li@oss.nxp.com>, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>,
 vigneshr@ti.com, b-padhi@ti.com, n-francis@ti.com, nm@ti.com, afd@ti.com,
 u-kumar1@ti.com, i-sihag@ti.com, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>
References: <20251202193310.149861-1-marek.vasut+renesas@mailbox.org>
 <DFJ950O0QM0D.380U0N16ZO19E@ti.com> <DFJ9947VLHEL.PCDIJCRU24BS@ti.com>
 <20260108141233.GQ3416603@bill-the-cat>
 <939a9696-27fa-45a1-b428-feffe21ac6d5@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <939a9696-27fa-45a1-b428-feffe21ac6d5@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: az8xn4cyjd5sndtk4s4ca49tyikikqwt
X-MBO-RS-ID: ab8c6e32ad6f7115cd8
X-Rspamd-Queue-Id: 4f73bn4cW1z9tfs
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

On 2/6/26 10:11 AM, Ye Li wrote:
> Hi Tom, Marek,
> 
> On 1/8/2026 10:12 PM, Tom Rini wrote:
>> On Thu, Jan 08, 2026 at 07:21:10PM +0530, Anshul Dalal wrote:
>>> CC+: TI folks
>>>
>>> On Thu Jan 8, 2026 at 7:15 PM IST, Anshul Dalal wrote:
>>>> Hi all,
>>>>
>>>> On Wed Dec 3, 2025 at 1:02 AM IST, Marek Vasut wrote:
>>>>> Synchronize local copy of DTC with Linux 6.17 . This includes the
>>>>> following picked and squashed commits from Linux kernel. The squash
>>>>> was necessary, since the DTC here contains changes which were also
>>>>> part of DTC in Linux alraedy, and the squash helped resolve those
>>>>> without going back and forth with the changes.
>>>>>
>>>>> The following commits from Linux are picked:
>>>>>
>>>>> 8f324cd712df7 # scripts/dtc: consolidate include path options in 
>>>>> Makefile
>>>>> b5b3d9b63b0ee # scripts/dtc: Add yamltree.c to dtc sources
>>>>> 7d97a76f226d6 # scripts/dtc: Update to upstream version v1.4.7-14- 
>>>>> gc86da84d30e4
>>>>> ea6f243be74e5 # scripts/dtc: Update to upstream version v1.4.7-57- 
>>>>> gf267e674d145
>>>>> 02d435d4eccd8 # scripts/dtc: Update to upstream version v1.5.0-23- 
>>>>> g87963ee20693
>>>>> 6e321b7637396 # scripts/dtc: Update to upstream version v1.5.0-30- 
>>>>> g702c1b6c0e73
>>>>> 9f19ec91a7a35 # scripts/dtc: dtx_diff - add color output support
>>>>> 8287d642f38d1 # scripts/dtc: Update to upstream version v1.5.1-22- 
>>>>> gc40aeb60b47a
>>>>> 4c52deef9225d # scripts/dtc: Revert "yamltree: Ensure consistent 
>>>>> bracketing of properties with phandles"
>>>>> 5d3827e1452ed # scripts/dtc: Remove unused makefile fragments
>>>>> 40dd266887654 # scripts/dtc: Update to upstream version v1.6.0-2- 
>>>>> g87a656ae5ff9
>>>>> 8d4cf6b6acb59 # scripts/dtc: use pkg-config to include <yaml.h> in 
>>>>> non-standard path
>>>>> b9bf9ace5ae90 # scripts/dtc: Update to upstream version v1.6.0-11- 
>>>>> g9d7888cbf19c
>>>>> 69a883b6f5ac0 # scripts/dtc: dtx_diff - make help text formatting 
>>>>> consistent
>>>>> 8f829108b8aed # scripts/dtc: only append to HOST_EXTRACFLAGS 
>>>>> instead of overwriting
>>>>> b39b4342ac495 # scripts/dtc: Update to upstream version v1.6.0-31- 
>>>>> gcbca977ea121
>>>>> 93c6424c486b3 # scripts: dtc: Fetch fdtoverlay.c from external DTC 
>>>>> project
>>>>> 0dd574a1d75c3 # scripts/dtc: Update to upstream version v1.6.0-51- 
>>>>> g183df9e9c2b9
>>>>> ec38b5df8a231 # scripts: dtc: Build fdtoverlay tool
>>>>> a0c8c431411f5 # scripts: dtc: Remove the unused fdtdump.c file
>>>>> e7dc653d4e890 # scripts/dtc: Add missing fdtoverlay to gitignore
>>>>> d2bf5d2e3f09c # scripts/dtc: Update to upstream version v1.6.1-19- 
>>>>> g0a3a9d3449c8
>>>>> a60878f5532d0 # scripts/dtc: dtx_diff: remove broken example from 
>>>>> help text
>>>>> 8b739d8658a9b # scripts/dtc: Call pkg-config POSIXly correct
>>>>> b6eeafa67df00 # scripts/dtc: Update to upstream version v1.6.1-63- 
>>>>> g55778a03df61
>>>>> f96cc4c787588 # scripts/dtc: Update to upstream version v1.6.1-66- 
>>>>> gabbd523bae6e
>>>>> 09ab9c092ef2b # scripts/dtc: Update to upstream version v1.7.0-93- 
>>>>> g1df7b047fe43
>>>>> ded8a5a498f2d # scripts/dtc: Update to upstream version v1.7.0-95- 
>>>>> gbcd02b523429
>>>>> ee6ff6fca7e71 # scripts/dtc: Update to upstream version v1.7.2-35- 
>>>>> g52f07dcca47c
>>>>>
>>>>> This also includes forward port of U-Boot commit
>>>>> e8c2d25845c7 ("libfdt: Revert 6dcb8ba4 from upstream libfdt")
>>>>> to avoid binary size growth.
>>>>>
>>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>>> ---
>>>>> Cc: Adriano Cordova <adrianox@gmail.com>
>>>>> Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
>>>>> Cc: Christian Marangi <ansuelsmth@gmail.com>
>>>>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>>>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>>>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>>>>> Cc: Sam Edwards <cfsworks@gmail.com>
>>>>> Cc: Simon Glass <sjg@chromium.org>
>>>>> Cc: Tom Rini <trini@konsulko.com>
>>>>> Cc: u-boot@lists.denx.de
>>>>
>>>> We observed several boot failures on K3 platforms since the addition of
>>>> this patch at the R5 SPL stage, the issue seems to be the newly added
>>>> check for alignment in fdt_check_header in scripts/dtc/libfdt/fdt.c:95
>>>> but the binaries generated don't have 8-byte aligned FDTs.
>>>>
>>>> I have been able to reproduce the issue on AM62p EVM with a clean
>>>> working directory (this is important since any minor change to the
>>>> SPL binary size such as by the added "-dirty" tag could make the 
>>>> address
>>>> aligned) and GCC 13.3[1].
>>>>
>>>> Are we ensuring the fdt present in the SPL binary is properly aligned?
>>
>> Yes, the device tree must be 8-byte aligned, this is a requirement of
>> the device tree spec itself that we had been lax over until now.
> We found iMX95/iMX94 EVK boards are broken after this fdt lib update. 
> The root cause is default value of CONFIG_SPL_OF_LIBFDT_ASSUME_MASK is 
> 0xff. In this update, fdt_check_node_offset_ is changed as below to 
> check the CONFIG_SPL_OF_LIBFDT_ASSUME_MASK. When it is 0xff, 
> fdt_check_node_offset_ will skip offset check.
> 
> 
>   int fdt_check_node_offset_(const void *fdt, int offset)
>   {
> -    if ((offset < 0) || (offset % FDT_TAGSIZE)
> -        || (fdt_next_tag(fdt, offset, &offset) != FDT_BEGIN_NODE))
> +    if (!can_assume(VALID_INPUT)
> +        && ((offset < 0) || (offset % FDT_TAGSIZE)))
> +        return -FDT_ERR_BADOFFSET;
> +
> +    if (fdt_next_tag(fdt, offset, &offset) != FDT_BEGIN_NODE)
>           return -FDT_ERR_BADOFFSET;
> 
> This cause a problem to SCMI agent uclass driver. In scmi_bind_protocols 
> function, a ofnode_null() is used when creating scmi-base.0 device to 
> bind with driver. This null node which has offset value -1 can 
> successfully pass the fdt_check_node_offset_, so causes crash in 
> device_probe()->dev_power_domain_on() when finding power-domains phandle.
> 
> I notice the default value of CONFIG_OF_LIBFDT_ASSUME_MASK used by u- 
> boot is 0. So why does SPL have different default value? Should we 
> change the SPL default value to 0 to align with u-boot? Otherwise, any 
> idea for fix.
Could ti be that you need a fix similar to:

3c43ca3025ef ("clk: fixed_rate: Avoid calling dev_read_*() if 
CONFIG_OF_PLATDATA=y")

Maybe there is some node missing and you are trying to look it up and 
use it ?
