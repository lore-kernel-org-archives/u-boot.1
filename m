Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934BD60828AF
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OzmSUUyG;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=BOsi5KLF
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D2D1D4033C;
	Thu,  5 Nov 2026 19:31:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B4pTd-26bWAa; Thu,  5 Nov 2026 19:31:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B9C19408E4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793907063;
	b=GNnQpxFFl7dbIt+wdxDMwl7ccsDQuIDkryeFpXpqxI51h+bap8LKqRXlWZf9nCo8Bxeo
	 1wp3zaaZ84GX2TAIxnOwybuyULRcobPKxTEVjIlWps85axG2w5MzzbJDtlFs58x2mlCnT
	 XzDyLzbHO+beFr2szaaEstsUp9NOiqAKuzG+lLpwTK+DdDbsd+so0R5uaKoOVOTkjWOUi
	 d0wbyBgqjQAwhSsNpDpV0v87ctBNF52XGNxvkeiUKsZvKb/wTJyZJfK5BZe8+cK16v69h
	 zwaQppXuel41oSabHjsX3VSeRnngxJNVZydu2UdOIC6Ta5CWemdgvZfVtQKLF2sadJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793907063;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XQIZJp3fH0JynNW2S2eeJ012oDpSqKHVwc9YswHJKz8=;
	b=AGuGFb6zcmxcLijitCOj3O3B/KEQ1F4KdAKZ7yuxXSzF2uivrRf1shwPSXVyO5TvV7fN
	 h3cKQCRMup6CMrABUcUhgcSV3W+ctdUobVuLGWEFN9uvHV6A1Hj3f/ilrdK8jLxDtQ3gY
	 +zUvZXMgAVi7cYXn0GuRyYQY3zUw3AbMvsVa2um4kQtDl7a5MKDuk0MJb7ZWz6gvbinCT
	 YFI96Kd60K+7OvPJaSs+wL7wgrof3tZCUBb5ygzAyuolY6HIXjqwVqZxQ9YI5ZAd1B5tx
	 It+m6GZsERMegsc8rKz/Wikw6Dyb+w4QHu0C+Ir5DB0WLsouq1vj/b/EfrzxaEqP78A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793907063;
	bh=XQIZJp3fH0JynNW2S2eeJ012oDpSqKHVwc9YswHJKz8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OzmSUUyGmhFD4bo7fE5vsKBkXcSQ/VNlaWJBm6FXyxRIuDYcZ6xBagM6f0Ytd4sE6
	 ayXLxFViIOpT/2+ZEDKu/VKgMLRSVNlTN7cKxXQt0qv95qnvp8DN+6qkBFa70FjjcB
	 Y+iS0m9eSQRDAr2AJpVbPGfAF/B5KHL+cu3N4OQM5hyJ7BI+O1taUVo6sodc53uFlb
	 KITwntj7tLcBXSgE4puX/XFyB5jJmZtnLUG5jep8eqeNaHTvIx0xg0BviL++b8cdok
	 fh8xEOLjbzRma7H34p0WZpIAnhqvmbw4ITNQN+i5AZuzWngQbn/va1LhW2rywDqZTT
	 Sgqy/VwfSiKkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B9C19408E4;
	Thu,  5 Nov 2026 19:31:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 82F83B00
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 19:31:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 748CB60833
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 19:31:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BjiAAjycawMU for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 19:31:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EC2A960697
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=BOsi5KLF
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EC2A960697
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 19:31:00 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jLC8d1XMBzMlph;
 Thu, 05 Nov 2026 20:30:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793907057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XQIZJp3fH0JynNW2S2eeJ012oDpSqKHVwc9YswHJKz8=;
 b=BOsi5KLFRSJz0zuO0S6FshNekF24uxENvDSko6qgv7VZ910YVS1tgsfk+wozEttC1OVL/d
 FWXCnEs5lFys8iQPrKYMURGj5bQS/OKBXOiRmUBxhReopUTOT5kEw58s7mF8F6921U3x55
 dqEgFNViRt9v+ssglQQIbiJG2YK1ojeRk8fSXC/C7T9WIl2DYBhCKOzkTnDTCFW8Hwi5aE
 to7GhEWX63aE33RxXMChg5jdiFsLxFTuwxe9nZ68hKV5DfFwtYHy1xHV528a5hG6/Z9Q83
 VlefYvWb/eMigg1jPPtPtMPgFYIoT7p54oOc401T9T2aZj9iLPdKhazVo3MGPw==
Message-ID: <902a93a7-df59-436b-b959-ad41f7d64f19@mailbox.org>
Date: Thu, 5 Nov 2026 19:25:05 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remoteproc: Hide REMOTEPROC options in REMOTEPROC
 conditional
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
References: <20261026221147.483695-1-marek.vasut+renesas@mailbox.org>
 <20261104142958.GA1112376@bill-the-cat>
 <ca84f075-5f13-4275-98df-5521b14b9c15@mailbox.org>
 <20261105144209.GL1164024@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261105144209.GL1164024@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: c6p1u5d9qs56ofaf1iyyboaggzoyhn88
X-MBO-RS-ID: 3902dbae714c255bc20
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/26 3:42 PM, Tom Rini wrote:
> On Wed, Nov 04, 2026 at 06:33:21PM +0100, Marek Vasut wrote:
>> On 11/4/26 3:29 PM, Tom Rini wrote:
>>> On Mon, Oct 26, 2026 at 11:11:32PM +0100, Marek Vasut wrote:
>>>
>>>> Add conditional around REMOTEPROC menu entries, turn REMOTEPROC into
>>>> configurable boolean, and update all defconfigs and Kconfigs which
>>>> previously only selected REMOTEPROC driver to also select REMOTEPROC
>>>> itself.
>>>>
>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>> ---
>>>> Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
>>>> Cc: MD Danish Anwar <danishanwar@ti.com>
>>>> Cc: Tom Rini <trini@konsulko.com>
>>>> Cc: u-boot@lists.u-boot-project.org
>>>
>>> Unfortunately this misses some handful of at least TI K3 platforms. I
>>> think using qconfig.py to confirm which configs have REMOTEPROC set
>>> before / after, and that they match would make sorting that part of the
>>> problem out easier. Do you have time to do that, or should I pick it up
>>> and do a v2? Thanks.
>> I can respin this, but do you know which platforms got missed ?
> 
> I lost the list, sorry. It was a number of the r5 builds. Perhaps some
> fragment got missed? But qconfig.py -f REMOTEPROC, with a db built with
> and without the patch will quickly show which oens it is.
I have this in either case:

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

Do you also have this patch applied?

[PATCH] remoteproc: Make REMOTEPROC_MAX_FW_SIZE depend on REMOTEPROC
