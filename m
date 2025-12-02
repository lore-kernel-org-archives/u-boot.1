Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36498D12672
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 20:53:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 898F083F0A;
	Tue,  2 Dec 2025 21:53:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cRD3D79/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0B0583F15; Tue,  2 Dec 2025 21:53:05 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DA7483E48
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 21:53:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dLXzJ0zgvz9ssQ;
 Tue,  2 Dec 2025 21:53:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764708780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xXyySg8OsCtxNTm//lr1Rs4knbgMlTWY+xcKHeGm7Ow=;
 b=cRD3D79/MuBcZW9ArqqvB+vxG7TB6OGKaW653Qtc6a/DXpDX4fwumb2q/z+kjZRJT2jPgI
 Eu7Y2YFg7EtkRuoE3lfCal//Q1+pAkIZHNY1drHXS/cf7P142Q6fBrPEwXiPovScCgvoE0
 Vh8udPrBcXJTedOcHzLd4z3zDCq/fxfgoHoXtjqha/Leo898QpoMjAoT0LdVc6PVbcMFfS
 3iMfdB2/cTSz6/UX9yitexa8a5rQzSpTm3b4OIlVtq9PAIuxoCMnUWWyAqq0BR0DTvmeOY
 VzIbiI4tocWwpQnFmazD51rxOEGxEmEfHdrcV3khlhGzCUsinf6Z6G0/FO3Vzg==
Message-ID: <a1c1f9b4-859a-4939-b37a-e9d81923dbd2@mailbox.org>
Date: Tue, 2 Dec 2025 21:52:57 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] imx: container: Eliminate IMX_PQC_SUPPORT
To: Ye Li <ye.li@oss.nxp.com>, u-boot@lists.denx.de
Cc: fedor.ross@ifm.com, =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <joao.goncalves@toradex.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, nitin.garg_3@nxp.com
References: <20251127192633.79935-1-marek.vasut@mailbox.org>
 <3da2565f-523d-47df-8202-0624bf0a445c@oss.nxp.com>
 <b44cb7cd-1c07-477c-8233-03d029266b7e@mailbox.org>
 <541c6616-224f-4b92-a980-a43ca159804d@oss.nxp.com>
 <34e3984c-f39c-4955-b6ae-045ce6cf38f2@mailbox.org>
 <dfb31725-489a-40f9-b75e-785eedb67dd8@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <dfb31725-489a-40f9-b75e-785eedb67dd8@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0834d2e90a960fb10b8
X-MBO-RS-META: xigg3y6tgq7snhxyo9ptw6xacty45u4c
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

On 11/28/25 5:20 PM, Ye Li wrote:

>> Adding another Kconfig symbol and ifdeffery seems easy, but it also 
>> had additional implications -- more code paths because of the 
>> ifdeffery, more Kconfig symbols which the user has to understand, and 
>> another machine config has to be built in the CI to cover this 
>> configuration.
>>
>> The auto-detection avoids all these problems.
>>
> I agree to remove IMX95_A0, but I don't suggest removing 
> IMX_PQC_SUPPORT. For each SOC, supporting PQC container or not is 
> definite. Adding runtime detect is just for iMX95. But iMX95 A1 is EOL, 
> everyone must use B0. And A1 codes should be removed.

I don't really see why the MX95 A0/A1 should be removed, it doesn't seem 
to take any maintenance effort or extra overhead. Maybe lets revisit 
that A0/A1 removal part at some later date.

> You said you have A1 board, could you share the board name?

The one I can share is the Toradex Verdin MX95 (the old one, I had it 
for a while).

>>>>> Eliminate IMX_PQC_SUPPORT config is not a good way. When adding new 
>>>>> SOC, developer has to update the container_hdr_alignment, then it 
>>>>> will be a long list in this function. Actually only iMX95 is the 
>>>>> exception. If you insist keeping A0, I prefer change like below and 
>>>>> retain IMX_PQC_SUPPORT.
>>>>>
>>>>> #if IS_ENABLED(CONFIG_IMX95)
>>>>> static inline u32 container_hdr_alignment(void)
>>>>> {
>>>>>      if (is_imx95() && (soc_rev() >= CHIP_REV_2_0))
>>>>>          return 0x4000;
>>>>>      else
>>>>>          return 0x400;
>>>>> }
>>>>> #else
>>>>> static inline u32 container_hdr_alignment(void)
>>>>> {
>>>>> #if IS_ENABLED(CONFIG_IMX_PQC_SUPPORT)
>>>>>      return 0x4000;
>>>>> #else
>>>>>      return 0x400;
>>>>> #endif
>>>>> }
>>>>> #endif
>>>> This adds even more ifdeffery and makes the code even worse, so no.
>>>>
>>>> But if you are sure that every new SoC will have the PQC alignment, 
>>>> then the condition in this patch can be inverted this way:
>>>>
>>>> static inline int container_hdr_alignment(void)
>>>> {
>>>>      if (is_imx95() && (soc_rev() < CHIP_REV_2_0))
>>>>          return 0x400;    /* PQC on i.MX95 A1 and older */
>>>>
>>>>      return 0x4000;    /* PQC is the default */
>>>> }
>>>>
>>>> Are you sure every new SoC (at least in the foreseeable future) will 
>>>> be like that ?
>>> No, it can't be guaranteed. And we have legacy SOC like 
>>> 8QM/8QXP/8ULP/93/91 using this container without PQC support, above 
>>> new change will break them. Please consider keeping the 
>>> IMX_PQC_SUPPORT, so every soc can select it to work.
>> See above why adding more and more Kconfig options is not a good 
>> solution.
>>
>> I believe the original implementation in this patch does not break the 
>> legacy SoCs ?
> Your original implementation does not break legacy SoCs. I mean the new 
> change break them.

OK

>> If you are concerned about growing list of SoCs in this function, then 
>> this function can list the five legacy SoCs + imx95a0 SoC with non-PQC 
>> alignment and by default return PQC alignment ?
> 
> I can't ensure no new SoC with legacy container. From roadmap, there is 
> still some iMX93 derivations planned. This way is just better than 
> original implementation in this patch.
Good, let's keep the original change.
