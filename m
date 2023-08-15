Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD0EC0015E
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 21:01:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FA688699F;
	Tue, 15 Aug 2023 23:01:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rL/TClPl";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="amg4ORQF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11C718692F; Tue, 15 Aug 2023 23:01:48 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 161C48692F
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 23:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RQNx465cMz9sSv;
 Tue, 15 Aug 2023 23:01:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692133304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1GIDji2qHwRUiREyUImoR96skCNQR9EMxGknEmAkvC0=;
 b=rL/TClPlKRsMyXc3WCsS0w51kIkYobzigND47nHchydgnLYQG4rvNxzskB/g3U6fB5dghT
 s4NxlR7aCnYWxYSvSR2bpHYLRNBAGR2hGDsYIcDzvi8OxOHfeLS+edZNJ1xfFeWLagT6ZD
 2MAYmrV3J9Q2fpCsiNothbClwPaFEt/i2Z7CQQLX/5nl6O4SQqvKG7Pcl66ELLNSPFc2zC
 ilnhWNkGdrs9rW3o8/Uq43CfUcfhxjRx3XeRC5vPD94Tn2RJb8i+Zjqx8RF+vpHX/wqq2c
 5M15RUV2AFKtuRs3S5GHJobxUzepybuLUqHj5Q0zQvhKIvUNs92HyYu5Td33sw==
Message-ID: <460cb258-12fc-380e-1b14-65f41763764d@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692133302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1GIDji2qHwRUiREyUImoR96skCNQR9EMxGknEmAkvC0=;
 b=amg4ORQFooEd+iiZ10SVPcr3Ohpf+1FLB6rwUALzLdCq/hQqsqMArW7Atrx3EiVqNQq6CU
 1guh2Wz7jZHIR7n6s+F6exY7dk7fzNQz8tQTxTvxgrri5h1yMCmZHk0Ct58VnDvFjll5h5
 a7ZevXDDWg9hr+yjVXC100Xi4J9Y9CPClgE5hHNxlwqRSm5SNAB4HvqAo+g2Et2SIcD4gv
 CvJe8SRU83t5KamKf5up+9LWhZHU9rHuLwXvEHVBKEJBEOIwcXpuXV3NgL0oX1uENAAgIh
 qj2Mm2IiQCEnMz6aQZ7OyVJaDHw6tBgOZwgQJk3pfJzjErsYZ7TBre91pyYM4Q==
Date: Tue, 15 Aug 2023 22:47:08 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/6] ufs: Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS
Content-Language: en-US
To: Bhupesh Sharma <bhupesh.sharma@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20230813235231.591454-1-marek.vasut+renesas@mailbox.org>
 <0dc7875e-ecdb-27e3-4234-1e09a9e27a20@linaro.org>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <0dc7875e-ecdb-27e3-4234-1e09a9e27a20@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0bad7c2fa80ecbc098b
X-MBO-RS-META: 1zyi4zxpk351tibhch3pz64ddcxq38pm
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

On 8/15/23 22:04, Bhupesh Sharma wrote:
> Hi Marek,
> 
> On 8/14/23 5:22 AM, Marek Vasut wrote:
>> Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS for host controllers which do not
>> support 64-bit addressing.
>>
>> Ported from Linux kernel commit
>> 6554400d6f66 ("scsi: ufs: core: Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS")
>> with ufs_scsi_buffer_aligned() based on U-Boot generic bounce buffer.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>>   drivers/ufs/ufs.c | 26 ++++++++++++++++++++++++++
>>   drivers/ufs/ufs.h |  6 ++++++
>>   2 files changed, 32 insertions(+)
>>
>> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
>> index 3bf1a95e7f2..da0550d98c6 100644
>> --- a/drivers/ufs/ufs.c
>> +++ b/drivers/ufs/ufs.c
>> @@ -8,6 +8,7 @@
>>    * Copyright (C) 2019 Texas Instruments Incorporated - 
>> http://www.ti.com
>>    */
>> +#include <bouncebuf.h>
>>   #include <charset.h>
>>   #include <common.h>
>>   #include <dm.h>
>> @@ -1889,6 +1890,8 @@ int ufshcd_probe(struct udevice *ufs_dev, struct 
>> ufs_hba_ops *hba_ops)
>>       /* Read capabilties registers */
>>       hba->capabilities = ufshcd_readl(hba, REG_CONTROLLER_CAPABILITIES);
>> +    if (hba->quirks & UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS)
>> +        hba->capabilities &= ~MASK_64_ADDRESSING_SUPPORT;
>>       /* Get UFS version supported by the controller */
>>       hba->version = ufshcd_get_ufs_version(hba);
>> @@ -1942,8 +1945,31 @@ int ufs_scsi_bind(struct udevice *ufs_dev, 
>> struct udevice **scsi_devp)
>>       return ret;
>>   }
>> +#if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
>> +static int ufs_scsi_buffer_aligned(struct udevice *scsi_dev, struct 
>> bounce_buffer *state)
>> +{
>> +#ifdef CONFIG_PHYS_64BIT
>> +    struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
>> +    uintptr_t ubuf = (uintptr_t)state->user_buffer;
>> +    size_t len = state->len_aligned;
>> +
>> +    /* Check if below 32bit boundary */
>> +    if ((hba->quirks & UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS) &&
>> +        ((ubuf >> 32) || (ubuf + len) >> 32)) {
>> +        dev_dbg(scsi_dev, "Buffer above 32bit boundary %lx-%lx\n",
>> +            ubuf, ubuf + len);
>> +        return 0;
>> +    }
>> +#endif
>> +    return 1;
>> +}
>> +#endif    /* CONFIG_BOUNCE_BUFFER */
>> +
>>   static struct scsi_ops ufs_ops = {
>>       .exec        = ufs_scsi_exec,
>> +#if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
>> +    .buffer_aligned    = ufs_scsi_buffer_aligned,
>> +#endif    /* CONFIG_BOUNCE_BUFFER */
>>   };
>>   int ufs_probe_dev(int index)
>> diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
>> index 8a38832b05f..070db0dce68 100644
>> --- a/drivers/ufs/ufs.h
>> +++ b/drivers/ufs/ufs.h
>> @@ -719,6 +719,12 @@ struct ufs_hba {
>>    */
>>   #define UFSHCD_QUIRK_BROKEN_LCC                0x1
>> +/*
>> + * This quirk needs to be enabled if the host controller has
>> + * 64-bit addressing supported capability but it doesn't work.
>> + */
>> +#define UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS        0x2
>> +
>>       /* Virtual memory reference */
>>       struct utp_transfer_cmd_desc *ucdl;
>>       struct utp_transfer_req_desc *utrdl;
> 
> For this and the follow-up patch, I think implementing or at least 
> supporting all the quirks currently supported by the Linux UFS driver 
> makes sense as newer controllers do support these quirks.

I disagree. There is no point in implementing quirks which cannot be 
tested or may not even be relevant to U-Boot. Quirks which are needed 
should be added one by one.

> Accordingly I had sent: 
> https://lists.denx.de/pipermail/u-boot/2023-August/527217.html
> 
> So, I would suggest that we pick these two patches and then I can send 
> my patches rebased on the same, but change the .h to support all the
> possible UFS quirks currently supported in Linux so that subsequent 
> patches can utilize them in u-boot - which I plan to post next.

See above.
