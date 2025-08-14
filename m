Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C3ACA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 14:52:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51A8A83980;
	Thu, 14 Aug 2025 16:52:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="zKTWou5R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4DA283981; Thu, 14 Aug 2025 16:52:14 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 426A08393F
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 16:52:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57EEq8Ar2406258;
 Thu, 14 Aug 2025 09:52:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1755183129;
 bh=5M/1Igy1PmuMe99Mkj6aEP9+ZmejlCAtEorrTagB6Sw=;
 h=Date:Subject:From:To:CC:References:In-Reply-To;
 b=zKTWou5RuGu7B+yycHVWS7PGPl52AgRf3m74MOlrwOnxXxKK/xpimh6i1ddStbYE0
 NsOgfdfxJzRvWF2Vky215LlxFbMJMQ3dC8Divrz2SCEQOEotxsRftuxS06uY36LCZd
 dWbxCOIpFXeHWypvYCJF9z0K06K+rCZ+sO5Vfvko=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57EEq8r41906451
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 14 Aug 2025 09:52:08 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 14
 Aug 2025 09:52:08 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 14 Aug 2025 09:52:08 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57EEq6Pr4076947;
 Thu, 14 Aug 2025 09:52:07 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 14 Aug 2025 20:21:04 +0530
Message-ID: <DC28GWHJ2HQM.2OO7QTNTJ2UMT@ti.com>
Subject: Re: [PATCH v5 3/4] mach-k3: add dynamic mmu fixups for SPL stage
From: Anshul Dalal <anshuld@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <a-nandan@ti.com>, <afd@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>, <devarsht@ti.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250703133533.104758-1-anshuld@ti.com>
 <20250703133533.104758-4-anshuld@ti.com>
 <DB63G6T323QW.2AQUT656TKCGJ@linaro.org>
In-Reply-To: <DB63G6T323QW.2AQUT656TKCGJ@linaro.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hello Ilias,

On Tue Jul 8, 2025 at 1:39 AM IST, Ilias Apalodimas wrote:
> Hi Anshul,
>
> On Thu Jul 3, 2025 at 4:35 PM EEST, Anshul Dalal wrote:
>> On platforms with spl splash support such as 62p and 62x
>> (CONFIG_VIDEO=3Dy), the top of DDR is reserved for the framebuffer.
>>
>> The size of the framebuffer is computed at runtime by video_reserve.
>> During the MMU configuration an entry corresponding to the framebuffer
>> should be dynamically created to properly allocate the required space
>> for the framebuffer.
>>
>> Therefore this patch adds k3_spl_mem_map_init which adds the required
>> MMU entry by querying the gd after the framebuffer size has been
>> computed in spl_reserve_video_from_ram_top.
>>
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> ---
>>  arch/arm/mach-k3/arm64/arm64-mmu.c | 13 ++++++++++++-
>>  arch/arm/mach-k3/common.c          | 17 ++++++++++++++---
>>  2 files changed, 26 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-k3/arm64/arm64-mmu.c b/arch/arm/mach-k3/arm64=
/arm64-mmu.c
>> index 49dd6fcb23b..b1b287f2114 100644
>> --- a/arch/arm/mach-k3/arm64/arm64-mmu.c
>> +++ b/arch/arm/mach-k3/arm64/arm64-mmu.c
>> @@ -131,6 +131,13 @@ static int k3_setup_extra_mem_banks(unsigned int *m=
ap_idx)
>>  	return 0;
>>  }
>>
>> +static void k3_spl_mem_map_init(unsigned int *map_idx)
>> +{
>> +	if (CONFIG_IS_ENABLED(VIDEO))
>> +		k3_mmu_add_cachable_entry(gd_video_bottom(), gd_video_top(),
>> +					  map_idx);
>> +}
>> +
>
> I don't know wnough details for this board, but generally speaking we sho=
uld be doing
> this commonly for all arm64 platforms. There's mmu code for that. Can you=
 explain why
> this is only useful to k3?
>

Could you point me to the relevant mmu code for it, from what I know
U-Boot doesn't map the framebuffer region at SPL stage by itself. Though
I'll replace k3_mmu_add_cachable_entry with something like
mmu_map_region in the next revision.

Regards,
Anshul
