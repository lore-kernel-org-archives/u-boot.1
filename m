Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAEFCA0FF2
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 08:15:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F13E831BB;
	Thu, 28 Aug 2025 10:15:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="I7A59U/x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 884FC831D5; Thu, 28 Aug 2025 10:15:09 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3DDB83106
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 10:15:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57S8F3QM1939336;
 Thu, 28 Aug 2025 03:15:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756368903;
 bh=DU6nu7ofU+SpBH2sPLUnytQXRpMRHanBOTT4Fo9GnwM=;
 h=Date:Subject:From:To:CC:References:In-Reply-To;
 b=I7A59U/xR6JqJCYyjzP6mRcHvG84XdXS8+imOed+QGANfy4+pd75vrfA7oCdf6npR
 JLBZkipAQ4i4txnqV/NOzkKyP+aMxYMbzQYbxfcQZ2lZxq/A+EpgQL0YcHLQkfyQS7
 2+PxztOP/03gTixzptS7tgqpTr1H32I6882fbzZk=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57S8F3TA3091071
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 28 Aug 2025 03:15:03 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 28
 Aug 2025 03:15:02 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 28 Aug 2025 03:15:02 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57S8F16P299238;
 Thu, 28 Aug 2025 03:15:02 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 28 Aug 2025 13:43:47 +0530
Message-ID: <DCDWSCFS5P5X.4UFZF82CB2NG@ti.com>
Subject: Re: [PATCH v1 1/2] dma: ti: k3-udma: fix dma_addr_t typecasts
From: Anshul Dalal <anshuld@ti.com>
To: Anshul Dalal <anshuld@ti.com>, Prasanth Mantena <p-mantena@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <u-kumar1@ti.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250825133233.2475300-1-anshuld@ti.com>
 <20250825133233.2475300-2-anshuld@ti.com>
 <20250827161411.whvffhrbx4k7axnv@prasanth-server>
 <DCDSOXGFIACA.15WKCWCLLFAEL@ti.com>
In-Reply-To: <DCDSOXGFIACA.15WKCWCLLFAEL@ti.com>
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

On Thu Aug 28, 2025 at 10:31 AM IST, Anshul Dalal wrote:
> Hi Prasanth,
>
> On Wed Aug 27, 2025 at 9:44 PM IST, Prasanth Mantena wrote:
>> Hi Anshul,
>> On 19:02, Anshul Dalal wrote:
>>> With the change to dma_addr_t from u32 to u64 for the R5 SPL, the
>>
>> From above line, Does this patch meant to after patch 2/2 ?
>>
>>> existing typecasts from void* to int or vice-versa cause the compiler t=
o
>>> throw a "cast from pointer to integer of different size".
>>>=20
>>> Therefore this patch changes the casts to a uintptr_t which is
>>> guaranteed to hold any pointer value, thus supressing the compiler
>>> warning.
>>>=20
>>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>>> ---
>>>  drivers/dma/ti/k3-udma.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
>>> index 723265ab2e5..01824310995 100644
>>> --- a/drivers/dma/ti/k3-udma.c
>>> +++ b/drivers/dma/ti/k3-udma.c
>>> @@ -2327,7 +2327,7 @@ static int udma_send(struct dma *dma, void *src, =
size_t len, void *metadata)
>>>  {
>>>  	struct udma_dev *ud =3D dev_get_priv(dma->dev);
>>>  	struct cppi5_host_desc_t *desc_tx;
>>> -	dma_addr_t dma_src =3D (dma_addr_t)src;
>>> +	dma_addr_t dma_src =3D (uintptr_t)src;
>>
>> Considering after the dma_addr_t changed to u64, please help me understa=
nd what
>> warning does the above change fix.
>>
>
> This patch was meant to prevent warnings from the last patch of the
> series, though I understand the confusion here. I will reword the commit
> description to be more clear in v2.
>

To give further context:

The fix would ideally be to use dma_addr_t for all dma-uclass
APIs similar to how the linux kernel handles it. Though given what we
have (using void* instead), a direct typecast to dma_addr_t with the
second patch would essentially amount to casting a 32-bit pointer to u64
hence the warning "cast from pointer to integer of different size".

uintptr_t is u32 for the R5 SPL so the 32-bit pointer is casted to a u32
first and then to dma_addr_t which is u64. Thus keeping the compiler
happy :)

And since K3's R5 SPL is the only case where dma_addr_t isn't the same
size as void* but with the dma addresses guaranteed to fit in a 32-bit
address space, I think a few typecasts are the easier solution than
refactoring the dma APIs to use dma_addr_t.

Regards,
Anshul
