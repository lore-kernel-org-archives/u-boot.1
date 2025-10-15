Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19537CCD18E
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 09:01:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 523AA8313B;
	Wed, 15 Oct 2025 11:01:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Y4da1ckE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 773A08323A; Wed, 15 Oct 2025 11:01:56 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DDA880107
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 11:01:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59F91qab1718010;
 Wed, 15 Oct 2025 04:01:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760518912;
 bh=vFjHstzFqpmcAUhIjm26dcGoZOnFXNhHtEcploDpRZE=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=Y4da1ckESjhvIYiqL3hasROBA0yjLmFbA1P/vpXUZXHCDrBkLqsiLGeH2VzAPf6VC
 uVvgXNON+wkYUCf8K/NTU3Ec653h4e9sm1MA98Gnv/j+II3eRmHap2LQ29PRPy+J6l
 o+2AodVlF9e4+h3DRhxVGnW/D4X/T28eEAFkX65s=
Received: from DFLE207.ent.ti.com (dfle207.ent.ti.com [10.64.6.65])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59F91pCb696797
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 15 Oct 2025 04:01:51 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Oct
 2025 04:01:51 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 04:01:51 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59F91o4I1658890;
 Wed, 15 Oct 2025 04:01:51 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 15 Oct 2025 14:31:49 +0530
Message-ID: <DDIRVA05GD7I.PRFJAWPND0PE@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <afd@ti.com>,
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>, <nm@ti.com>,
 <bb@ti.com>
Subject: Re: [PATCH v1 3/5] arm: mach-k3: enable support for falcon mode
From: Anshul Dalal <anshuld@ti.com>
To: Anshul Dalal <anshuld@ti.com>, Tom Rini <trini@konsulko.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251010131829.3737258-1-anshuld@ti.com>
 <20251010131829.3737258-4-anshuld@ti.com>
 <20251010160512.GE298503@bill-the-cat> <DDFEIZ4KAA9A.3IE2L0TRWHNXQ@ti.com>
In-Reply-To: <DDFEIZ4KAA9A.3IE2L0TRWHNXQ@ti.com>
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

On Sat Oct 11, 2025 at 3:26 PM IST, Anshul Dalal wrote:
> Hi Tom,
>
> On Fri Oct 10, 2025 at 9:35 PM IST, Tom Rini wrote:
>> On Fri, Oct 10, 2025 at 06:48:25PM +0530, Anshul Dalal wrote:
>>
>>> With CONFIG_SPL_OS_BOOT enabled, U-Boot checks for the return value of
>>> spl_start_uboot to select between falcon or the regular boot flow. With
>>> a return value of 0 implying falcon mode.
>>>=20
>>> This patch overrides the weak definition form common/spl/spl.c to allow
>>> K3 devices to use falcon mode with SPL_OS_BOOT enabled.
>>>=20
>>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>>> ---
>>>  arch/arm/mach-k3/common.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>=20
>>> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
>>> index 5483ac9906c..41c96cbd4c5 100644
>>> --- a/arch/arm/mach-k3/common.c
>>> +++ b/arch/arm/mach-k3/common.c
>>> @@ -425,3 +425,10 @@ release_proc_ctrl:
>>>  	proc_ops->proc_release(ti_sci, PROC_ID_MCU_R5FSS0_CORE1);
>>>  	return ret;
>>>  }
>>> +
>>> +#if CONFIG_IS_ENABLED(OS_BOOT)
>>> +int spl_start_uboot(void)
>>> +{
>>> +	return 0;
>>> +}
>>> +#endif
>>
>> I've seen this in other parts of the series too, sorry.
>> CONFIG_IS_ENABLED(OS_BOOT) doesn't make sense, it should be
>
> Is that because OS_BOOT by itself is meaningless and
> CONFIG_IS_ENABLED(OS_BOOT) would always fall to checking for
> CONFIG_SPL_OS_BOOT? I mostly stuck with CONFIG_IS_ENABLED to avoid the
> extra three characters when using IS_ENABLED instead.
>

Apparently there are quite a few instances of CONFIG_IS_ENABLED(OS_BOOT)
in the source even before this patch series. I'll change it to
IS_ENABLED for this series in a v2 but for the existing instances, I
think it's better to follow up with a clean up patch once all other
remaining falcon series are merged.

>> IS_ENABLED(CONFIG_SPL_OS_BOOT) or just a regular #ifdef. Also for this
>> example please add a comment to the function explaining why it's always
>> enabling falcon mode.
>
> Will add an explantory comment in the next revision.
>
> Regards,
> Anshul

