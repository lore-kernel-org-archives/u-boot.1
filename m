Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984A0CA0FF2
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 05:02:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D539831B4;
	Thu, 28 Aug 2025 07:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="n/EtT06r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2606B831C2; Thu, 28 Aug 2025 07:02:36 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7963983106
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 07:02:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57S52VT51904854;
 Thu, 28 Aug 2025 00:02:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756357351;
 bh=JziJoHWwafHzh9M5Ang/Higy5FyrJ0z4X7rwTCqPOE0=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=n/EtT06ree62AOElk/mTx/ey3DQyLKFq/N1nvriajtNdWNFlCG84tAg156WVrxXOW
 bNx9CIOHquoANDSrC34sazbFGoTkGbrZ+55BGHFOdkVCBJefY5uyYJ+RasrhV5rx4c
 bKPlBzDvinz0waKE5LphdSknZeCiphAyzaB3IezI=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57S52VJj3692302
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 28 Aug 2025 00:02:31 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 28
 Aug 2025 00:02:30 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 28 Aug 2025 00:02:30 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57S52Tke3954380;
 Thu, 28 Aug 2025 00:02:30 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 28 Aug 2025 10:31:15 +0530
Message-ID: <DCDSOXGFIACA.15WKCWCLLFAEL@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <u-kumar1@ti.com>
Subject: Re: [PATCH v1 1/2] dma: ti: k3-udma: fix dma_addr_t typecasts
From: Anshul Dalal <anshuld@ti.com>
To: Prasanth Mantena <p-mantena@ti.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250825133233.2475300-1-anshuld@ti.com>
 <20250825133233.2475300-2-anshuld@ti.com>
 <20250827161411.whvffhrbx4k7axnv@prasanth-server>
In-Reply-To: <20250827161411.whvffhrbx4k7axnv@prasanth-server>
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

Hi Prasanth,

On Wed Aug 27, 2025 at 9:44 PM IST, Prasanth Mantena wrote:
> Hi Anshul,
> On 19:02, Anshul Dalal wrote:
>> With the change to dma_addr_t from u32 to u64 for the R5 SPL, the
>
> From above line, Does this patch meant to after patch 2/2 ?
>
>> existing typecasts from void* to int or vice-versa cause the compiler to
>> throw a "cast from pointer to integer of different size".
>>=20
>> Therefore this patch changes the casts to a uintptr_t which is
>> guaranteed to hold any pointer value, thus supressing the compiler
>> warning.
>>=20
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> ---
>>  drivers/dma/ti/k3-udma.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
>> index 723265ab2e5..01824310995 100644
>> --- a/drivers/dma/ti/k3-udma.c
>> +++ b/drivers/dma/ti/k3-udma.c
>> @@ -2327,7 +2327,7 @@ static int udma_send(struct dma *dma, void *src, s=
ize_t len, void *metadata)
>>  {
>>  	struct udma_dev *ud =3D dev_get_priv(dma->dev);
>>  	struct cppi5_host_desc_t *desc_tx;
>> -	dma_addr_t dma_src =3D (dma_addr_t)src;
>> +	dma_addr_t dma_src =3D (uintptr_t)src;
>
> Considering after the dma_addr_t changed to u64, please help me understan=
d what
> warning does the above change fix.
>

This patch was meant to prevent warnings from the last patch of the
series, though I understand the confusion here. I will reword the commit
description to be more clear in v2.

Thanks,
Anshul
