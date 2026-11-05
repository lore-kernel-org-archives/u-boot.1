Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5262606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=enpi19V/;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=lr7fPtZT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 840264080B;
	Thu,  5 Nov 2026 19:10:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xO1UmG3_X0Sx; Thu,  5 Nov 2026 19:10:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C87324081D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793905837;
	b=m0EvMA/cAK2ZwZnTY/hNmtBKyae3cA2TCD8eAZkDMXogRrFl8bBNdixsPt+iq7S9Ykbe
	 UpRJbUlwxh6psqur8UTWHKnpoKNWDea3Oxx5MlkxOv0ihoU2hJ+w+jNBnLK3N4z3U3VIH
	 q4fKBWquoRree5Jt9Y2Ub64OLltTYqga20/O+SU0zU/CU0Fts0HolzyF5vEJlGA/M7zEw
	 8e6EtQiljCYOHxSx5sF2I18wO3RI2+VZatUzIH0/CcrbYYrOpNJ3RUZUC7TiEYLhta/6u
	 BLdt0OENnvAPiJMUXT3upOnrtm7fI/zbQyXv8bUjjw5BI4LOoUZUwvNSSb+moZtwODQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793905837;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lxDSoiAFn25+mmuZHkcazL6VBZgkY3esNVJzzlkSWpE=;
	b=C5O3K9G5yOUd/Fp6gb3/P0ExGEJdxazoZqyz942kqtG4qYod8w6Bz/ujfRksOqvvJOiX
	 wQvhqU/QchEkLvR39Z908H9ENSvfoLRqNrr96it9lBoHRIncmweRFoCybh8xAEjeW7SAu
	 +5W/ch+4Nsb0bfEijhJAP9Pznr5+u+aqa7eC4nmAo0jARqdGUZKcqQjGaFSecIXdyuP0o
	 LYemmcKpG4PCziInYNSli1ZBhGUk/GFKE/nyp2BbU9df+ai7vpiVciZ9wBvmBI9N0vyMO
	 5g5Y7HN/CDFjajFRFw4KQbcbNJFFKRDVfTsvDW6yUWJPYSXeVR1I7Bh7Tvf+/uPL8ew==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793905836;
	bh=lxDSoiAFn25+mmuZHkcazL6VBZgkY3esNVJzzlkSWpE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=enpi19V/lG9Jd5ve6nirSHugepGMmoncyog0xw+aex9Y174o0mFf4xwplpz38jhTN
	 ey2oNy0oM0s9y0MvgDx+Soe3SPwc5qO+QuNEFcb9veVSxAdUbb4o7SygAcALQ6YDwI
	 OcC+x7I0T2JecJAzdbrbKK/BNSJR/HF+h/b5S9OZrG5zKOnltNTLeS8gdoohb3hzXD
	 qMFbaWRaICZfXvMnciFXeQJDi0yeSFwdtwdb7wI+G3GQGv0VQJVMdYdcauwRnNEbq/
	 Uix82pqU3lw/J3wwxGOfLaWbu42/3wLqtg3lUfsipz6MxFdApcUCEccN3Icl/osAZA
	 OWiv+y6VZg7DA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C87324081D;
	Thu,  5 Nov 2026 19:10:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9657FB00
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 19:10:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 87D0D81138
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 19:10:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IUEQHP--e2Ky for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 19:10:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D74DE81135
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=lr7fPtZT
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D74DE81135
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 19:10:32 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jLBj00tMRzMlXf;
 Thu, 05 Nov 2026 20:10:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793905828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lxDSoiAFn25+mmuZHkcazL6VBZgkY3esNVJzzlkSWpE=;
 b=lr7fPtZT2POEL4HdqgiuB7nw9F7wZIsXT1MIjAktlGFLbRR6L4+nI5edwHDLzBYM98ndxF
 TS1xaHr1mvJRlTF2lp1alvjTvj22pPiCbzsn1p0YuBmvgNE8M5zJu3utQYPWsL2wGy/1SZ
 Nu1IDN2C3lcz9BJ0ldAWPfdcNwHUeH2bRBKFGBNdP5LfpeyrmCPDn3T2Deceo+RLRLQr/4
 IGIdWcfpimqxugfEZ9FmfwqhH5nBnuI5Fz9G//76PuG8wd4MhxeT/hNNKKnW/6d8Z/X1ZE
 ZppBKulgrAh5sjl7yhcC5ouxqkPQiFXuFHT+07ownd8nM9fJ8hMd5p/a9wV7ng==
Message-ID: <e6f06550-772f-426f-8b43-da13b58b0202@mailbox.org>
Date: Thu, 5 Nov 2026 20:10:26 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remoteproc: Hide REMOTEPROC options in REMOTEPROC
 conditional
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
References: <20261026221147.483695-1-marek.vasut+renesas@mailbox.org>
 <20261104142958.GA1112376@bill-the-cat>
 <ca84f075-5f13-4275-98df-5521b14b9c15@mailbox.org>
 <20261105144209.GL1164024@bill-the-cat>
 <CAC928HbGeoLQuHjiDN+qBU7A=wLa=EgM7xQMppv9LvFh5kV_xg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAC928HbGeoLQuHjiDN+qBU7A=wLa=EgM7xQMppv9LvFh5kV_xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: de54f6a4b7c15309f03
X-MBO-RS-META: 6rwzumxuxq57hmdnug3u3qe91q91nnxy
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/26 7:51 PM, Massimo Pegorer wrote:
> Hi,
> 
> Il giorno gio 5 nov 2026 alle ore 15:42 Tom Rini <trini@konsulko.com>
> ha scritto:
>>
>> On Wed, Nov 04, 2026 at 06:33:21PM +0100, Marek Vasut wrote:
>>> On 11/4/26 3:29 PM, Tom Rini wrote:
>>>> On Mon, Oct 26, 2026 at 11:11:32PM +0100, Marek Vasut wrote:
>>>>
>>>>> Add conditional around REMOTEPROC menu entries, turn REMOTEPROC into
>>>>> configurable boolean, and update all defconfigs and Kconfigs which
>>>>> previously only selected REMOTEPROC driver to also select REMOTEPROC
>>>>> itself.
>>>>>
>>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>>> ---
>>>>> Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
>>>>> Cc: MD Danish Anwar <danishanwar@ti.com>
>>>>> Cc: Tom Rini <trini@konsulko.com>
>>>>> Cc: u-boot@lists.u-boot-project.org
>>>>
>>>> Unfortunately this misses some handful of at least TI K3 platforms. I
>>>> think using qconfig.py to confirm which configs have REMOTEPROC set
>>>> before / after, and that they match would make sorting that part of the
>>>> problem out easier. Do you have time to do that, or should I pick it up
>>>> and do a v2? Thanks.
>>> I can respin this, but do you know which platforms got missed ?
>>
>> I lost the list, sorry. It was a number of the r5 builds. Perhaps some
>> fragment got missed? But qconfig.py -f REMOTEPROC, with a db built with
>> and without the patch will quickly show which oens it is.
> 
> This is the result of comparing the two qoconfig.py outputs:

u-boot$ git log --oneline HEAD~4..
1e29311663e (HEAD -> master) Revert "remoteproc: Hide REMOTEPROC options 
in REMOTEPROC conditional"
97162e533ca remoteproc: Hide REMOTEPROC options in REMOTEPROC conditional
df3b8e16e6d remoteproc: Make REMOTEPROC_MAX_FW_SIZE depend on REMOTEPROC
d1d45c926a5 (origin/main) Merge branch 'main' of 
https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv

u-boot$ ./tools/qconfig.py -f REMOTEPROC
126 matches
am6254atl_evm_a53 am6254atl_evm_r5 am62_pocketbeagle2_a53 
am62_pocketbeagle2_r5 am62ax_evm_a53 am62ax_evm_a53_ethboot 
am62ax_evm_r5 am62ax_evm_r5_ethboot am62dx_evm_a53 am62dx_evm_r5 
am62px_evm_a53 am62px_evm_a53_ethboot am62px_evm_r5 
am62px_evm_r5_ethboot am62x_beagleplay_a53 am62x_beagleplay_r5 
am62x_evm_a53 am62x_evm_a53_ethboot am62x_evm_r5 am62x_evm_r5_ethboot 
am62x_lpsk_a53 am62x_lpsk_r5 am64x_evm_a53 am64x_evm_r5 am65x_evm_a53 
am65x_evm_r5 am65x_evm_r5_usbdfu am65x_evm_r5_usbmsc 
am67a_beagley_ai_a53 am67a_beagley_ai_r5 am68_sk_a72 am68_sk_a72_ethboot 
am68_sk_r5 am68_sk_r5_ethboot am69_sk_a72 am69_sk_a72_ethboot am69_sk_r5 
am69_sk_r5_ethboot aquila-am69_a72 aquila-am69_r5 aquila-imx95 
imx8mm_evk imx8mm_evk_fspi imx8mn_ddr4_evk imx8mn_evk imx8mp_evk 
imx8mq_evk imx93_11x11_evk imx93_9x9_qsb imx93_9x9_qsb_inline_ecc 
imx93_frdm imx93w_evk imx93w_evk_inline_ecc imx95_15x15_evk 
imx95_15x15_frdm imx95_19x19_evk imx95_19x19_frdm_pro imx95_a0_19x19_evk 
imx95_navq iot2050 j7200_evm_r5 j721e_beagleboneai64_a72 
j721e_beagleboneai64_r5 j721e_evm_a72 j721e_evm_r5 j721e_sk_a72 
j721e_sk_r5 j721s2_evm_a72 j721s2_evm_r5 j722s_evm_a53 
j722s_evm_a53_ethboot j722s_evm_r5 j722s_evm_r5_ethboot j742s2_evm_a72 
j742s2_evm_r5 j784s4_evm_a72 j784s4_evm_r5 k2g_evm k2g_hs_evm 
phycore_am62ax_a53 phycore_am62ax_r5 phycore_am62ax_r5_ethboot 
phycore_am62ax_r5_usbdfu phycore_am62x_a53 phycore_am62x_r5 
phycore_am62x_r5_ethboot phycore_am62x_r5_usbdfu phycore_am64x_a53 
phycore_am64x_r5 phycore_am68x_a72 phycore_am68x_r5 r8a779g0_whitehawk 
r8a779g3_sparrowhawk r8a78000_ironhide_cm33 sandbox64 sandbox64_lwip 
sandbox sandbox_flattree sandbox_nocmdline sandbox_noinst sandbox_spl 
sandbox_vpl sc598-som-ezkit-spl sc598-som-ezlite-spl 
stm32mp15-icore-stm32mp1-ctouch2 stm32mp15-icore-stm32mp1-edimm2.2 
stm32mp15-microgea-stm32mp1-microdev2-of7 
stm32mp15-microgea-stm32mp1-microdev2 stm32mp15-odyssey stm32mp15_basic 
stm32mp15 stm32mp15_dhcom_basic stm32mp15_dhcom_drc02_basic 
stm32mp15_dhcom_pdk2_basic stm32mp15_dhcom_picoitx_basic 
stm32mp15_dhcor_avenger96_basic stm32mp15_dhcor_basic 
stm32mp15_dhcor_drc_compact_basic stm32mp15_dhcor_testbench_basic 
stm32mp15_trusted toradex-smarc-imx95 verdin-am62_a53 verdin-am62_r5 
verdin-am62p_a53 verdin-am62p_r5 verdin-imx95

u-boot$ git reset --hard HEAD~1
HEAD is now at 97162e533ca remoteproc: Hide REMOTEPROC options in 
REMOTEPROC conditional

u-boot$ ./tools/qconfig.py -f REMOTEPROC
126 matches
am6254atl_evm_a53 am6254atl_evm_r5 am62_pocketbeagle2_a53 
am62_pocketbeagle2_r5 am62ax_evm_a53 am62ax_evm_a53_ethboot 
am62ax_evm_r5 am62ax_evm_r5_ethboot am62dx_evm_a53 am62dx_evm_r5 
am62px_evm_a53 am62px_evm_a53_ethboot am62px_evm_r5 
am62px_evm_r5_ethboot am62x_beagleplay_a53 am62x_beagleplay_r5 
am62x_evm_a53 am62x_evm_a53_ethboot am62x_evm_r5 am62x_evm_r5_ethboot 
am62x_lpsk_a53 am62x_lpsk_r5 am64x_evm_a53 am64x_evm_r5 am65x_evm_a53 
am65x_evm_r5 am65x_evm_r5_usbdfu am65x_evm_r5_usbmsc 
am67a_beagley_ai_a53 am67a_beagley_ai_r5 am68_sk_a72 am68_sk_a72_ethboot 
am68_sk_r5 am68_sk_r5_ethboot am69_sk_a72 am69_sk_a72_ethboot am69_sk_r5 
am69_sk_r5_ethboot aquila-am69_a72 aquila-am69_r5 aquila-imx95 
imx8mm_evk imx8mm_evk_fspi imx8mn_ddr4_evk imx8mn_evk imx8mp_evk 
imx8mq_evk imx93_11x11_evk imx93_9x9_qsb imx93_9x9_qsb_inline_ecc 
imx93_frdm imx93w_evk imx93w_evk_inline_ecc imx95_15x15_evk 
imx95_15x15_frdm imx95_19x19_evk imx95_19x19_frdm_pro imx95_a0_19x19_evk 
imx95_navq iot2050 j7200_evm_r5 j721e_beagleboneai64_a72 
j721e_beagleboneai64_r5 j721e_evm_a72 j721e_evm_r5 j721e_sk_a72 
j721e_sk_r5 j721s2_evm_a72 j721s2_evm_r5 j722s_evm_a53 
j722s_evm_a53_ethboot j722s_evm_r5 j722s_evm_r5_ethboot j742s2_evm_a72 
j742s2_evm_r5 j784s4_evm_a72 j784s4_evm_r5 k2g_evm k2g_hs_evm 
phycore_am62ax_a53 phycore_am62ax_r5 phycore_am62ax_r5_ethboot 
phycore_am62ax_r5_usbdfu phycore_am62x_a53 phycore_am62x_r5 
phycore_am62x_r5_ethboot phycore_am62x_r5_usbdfu phycore_am64x_a53 
phycore_am64x_r5 phycore_am68x_a72 phycore_am68x_r5 r8a779g0_whitehawk 
r8a779g3_sparrowhawk r8a78000_ironhide_cm33 sandbox64 sandbox64_lwip 
sandbox sandbox_flattree sandbox_nocmdline sandbox_noinst sandbox_spl 
sandbox_vpl sc598-som-ezkit-spl sc598-som-ezlite-spl 
stm32mp15-icore-stm32mp1-ctouch2 stm32mp15-icore-stm32mp1-edimm2.2 
stm32mp15-microgea-stm32mp1-microdev2-of7 
stm32mp15-microgea-stm32mp1-microdev2 stm32mp15-odyssey stm32mp15_basic 
stm32mp15 stm32mp15_dhcom_basic stm32mp15_dhcom_drc02_basic 
stm32mp15_dhcom_pdk2_basic stm32mp15_dhcom_picoitx_basic 
stm32mp15_dhcor_avenger96_basic stm32mp15_dhcor_basic 
stm32mp15_dhcor_drc_compact_basic stm32mp15_dhcor_testbench_basic 
stm32mp15_trusted toradex-smarc-imx95 verdin-am62_a53 verdin-am62_r5 
verdin-am62p_a53 verdin-am62p_r5 verdin-imx95

> (I had to drop also the select REMOTEPROC for the new REMOTEPROC_TI_K3_HSM_M4F
> which landed into main but not yet included in the patch)
> 
> Could adding an "imply REMOTEPROC" in arch/arm/mach-k3/Kconfig, where other
> REMOTEPROC sub-options are implied, help to simplify? Avoid need to add it
> to defconfigs.
No, imply keyword is not recommended.
