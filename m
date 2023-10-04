Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98681E7C4F0
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 19:42:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D18F1875B2;
	Wed,  4 Oct 2023 21:42:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Upv3akti";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEDD2875B3; Wed,  4 Oct 2023 21:42:54 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 119BC875B0
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 21:42:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4S14py2LMyz9sdM;
 Wed,  4 Oct 2023 21:42:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696448570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P62Lada7ZO620zUTdbLZUYmblIP3p+jBHQ6msgdPYbQ=;
 b=Upv3akti5GbqNdkI0cYIu/vzFrPlCeES+owdtp+AOo1vz32UT55nWb5PoYJ43ZDjgZWRqi
 iCBk3DmNhELCOsnm5nodl1TgYxOVJWE9R5ERDWihOukLjKm5G1Pqg3SjZIpAJcONIqhnG6
 r8F8qhbkiDUIoVXA1TeM13l3wZLBIEsxU2V1/YttjDr4aOGzdBNo3tGR9uBtxJLSANKahM
 WQIzcuYHGQDgL11XeO22LGY1GZjmg1Wp4xpXxTMyqo69+ERKkzM3s9vek9glI66s4QKdNi
 65jVW1F+Jcohomzd2Tahh0N39n7CNO/C4/VL/WkfrAHOPPQU3gyCL6FjETzmOA==
Message-ID: <069d8489-7dda-4610-bbf1-9ef69417b58d@mailbox.org>
Date: Wed, 4 Oct 2023 21:42:48 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 12/16] arm: rmobile: Include <asm/types.h> in header
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: u-boot@lists.denx.de, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-13-paul.barker.ct@bp.renesas.com>
 <c163f447-ae15-2a85-a120-d821848e3e24@mailbox.org>
 <fe6c6582-6155-81d4-0c7f-19c545a4acf7@bp.renesas.com>
 <c2d3799b-634e-4279-a762-8d0d5bd29d23@mailbox.org>
 <20231004134819.4ajesdoiktyejnt6@GBR-5CG2373LKG.adwin.renesas.com>
 <e0e13fe4-8bf9-4f26-8758-773dd0f9f40e@mailbox.org>
 <20231004164118.pxyfpt43odqgbohh@GBR-5CG2373LKG.adwin.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231004164118.pxyfpt43odqgbohh@GBR-5CG2373LKG.adwin.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ac4e552842334484884
X-MBO-RS-META: phmmieimc33gw4ezwi1kzuryfn5ogab5
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

On 10/4/23 18:41, Paul Barker wrote:
> On Wed, Oct 04, 2023 at 05:19:43PM +0200, Marek Vasut wrote:
>> On 10/4/23 15:48, Paul Barker wrote:
>>> On Wed, Oct 04, 2023 at 02:27:50PM +0200, Marek Vasut wrote:
>>>> On 10/4/23 10:57, Paul Barker wrote:
>>>>> On 03/10/2023 14:27, Marek Vasut wrote:
>>>>>> On 9/20/23 14:42, Paul Barker wrote:
>>>>>>> We don't want to rely on source files including <asm/types.h> before
>>>>>>> <asm/arch/rmobile.h>.
>>>>>>
>>>>>> What kind of error does this solve ?
>>>>>
>>>>> Without this, <asm/types.h> must be included before
>>>>> <asm/arch/rmobile.h>, for example in include/configs/rzg2l-smarc.h added
>>>>> in patch 16, to avoid the following error:
>>>>>
>>>>>      CC      arch/arm/lib/asm-offsets.s
>>>>> In file included from include/configs/rzg2l-smarc.h:9,
>>>>>                     from include/config.h:3,
>>>>>                     from include/common.h:16,
>>>>>                     from lib/asm-offsets.c:14:
>>>>> ./arch/arm/include/asm/arch/rmobile.h:49:7: error: unknown type name ‘u8’
>>>>>       49 | const u8 *rzg_get_cpu_name(void);
>>>>
>>>> Hmmm, that's weird, why am I not hitting it with the rcar CPU name function
>>>> too ?
>>>
>>> arch/arm/mach-rmobile/include/mach/rcar-gen3-base.h includes
>>> <asm/types.h> as it uses the `u32` type.
>>>
>>> However, arch/arm/mach-rmobile/include/mach/rzg2l.h doesn't use anything
>>> from <asm/types.h> so doesn't include it.
>>
>> Shouldn't arch/arm/mach-rmobile/include/mach/rmobile.h include the types.h
>> then ?
> 
> That's what this patch adds.

Then this patch is

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Sorry for the noise.
