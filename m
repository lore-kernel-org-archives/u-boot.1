Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12B8CCD184
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 09:56:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3503483CF5;
	Sat, 11 Oct 2025 11:56:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ekyYEp1B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAAC883E69; Sat, 11 Oct 2025 11:56:37 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E09883C94
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 11:56:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59B9uXX1430131;
 Sat, 11 Oct 2025 04:56:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760176593;
 bh=3oE05m4vASwq6tqe7wrPDLM46GDgdf0hM0XHYpmWblA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=ekyYEp1B5pDeWhSQmQRKIGxLZYLeNW4i4ulJbsNLM4gwmhCFS6DLXkeC7MTSo8Gba
 /8u5uvvgV0Z+xCfBp6f8flKXt57Fk+bZo/23N/hfxllGeLCwRsxLNWf//RhjoDGcP1
 3BryCa4zZiiAz8XTf1ZWFF6H4bXw+d8fYAtAvSpA=
Received: from DFLE205.ent.ti.com (dfle205.ent.ti.com [10.64.6.63])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59B9uXAE1451573
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 11 Oct 2025 04:56:33 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 11 Oct
 2025 04:56:32 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 11 Oct 2025 04:56:33 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59B9uV3w3247276;
 Sat, 11 Oct 2025 04:56:32 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 11 Oct 2025 15:26:31 +0530
Message-ID: <DDFEIZ4KAA9A.3IE2L0TRWHNXQ@ti.com>
From: Anshul Dalal <anshuld@ti.com>
To: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <afd@ti.com>,
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>, <nm@ti.com>,
 <bb@ti.com>
Subject: Re: [PATCH v1 3/5] arm: mach-k3: enable support for falcon mode
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251010131829.3737258-1-anshuld@ti.com>
 <20251010131829.3737258-4-anshuld@ti.com>
 <20251010160512.GE298503@bill-the-cat>
In-Reply-To: <20251010160512.GE298503@bill-the-cat>
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

Hi Tom,

On Fri Oct 10, 2025 at 9:35 PM IST, Tom Rini wrote:
> On Fri, Oct 10, 2025 at 06:48:25PM +0530, Anshul Dalal wrote:
>
>> With CONFIG_SPL_OS_BOOT enabled, U-Boot checks for the return value of
>> spl_start_uboot to select between falcon or the regular boot flow. With
>> a return value of 0 implying falcon mode.
>>=20
>> This patch overrides the weak definition form common/spl/spl.c to allow
>> K3 devices to use falcon mode with SPL_OS_BOOT enabled.
>>=20
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> ---
>>  arch/arm/mach-k3/common.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>=20
>> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
>> index 5483ac9906c..41c96cbd4c5 100644
>> --- a/arch/arm/mach-k3/common.c
>> +++ b/arch/arm/mach-k3/common.c
>> @@ -425,3 +425,10 @@ release_proc_ctrl:
>>  	proc_ops->proc_release(ti_sci, PROC_ID_MCU_R5FSS0_CORE1);
>>  	return ret;
>>  }
>> +
>> +#if CONFIG_IS_ENABLED(OS_BOOT)
>> +int spl_start_uboot(void)
>> +{
>> +	return 0;
>> +}
>> +#endif
>
> I've seen this in other parts of the series too, sorry.
> CONFIG_IS_ENABLED(OS_BOOT) doesn't make sense, it should be

Is that because OS_BOOT by itself is meaningless and
CONFIG_IS_ENABLED(OS_BOOT) would always fall to checking for
CONFIG_SPL_OS_BOOT? I mostly stuck with CONFIG_IS_ENABLED to avoid the
extra three characters when using IS_ENABLED instead.

> IS_ENABLED(CONFIG_SPL_OS_BOOT) or just a regular #ifdef. Also for this
> example please add a comment to the function explaining why it's always
> enabling falcon mode.

Will add an explantory comment in the next revision.

Regards,
Anshul
