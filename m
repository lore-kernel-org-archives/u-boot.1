Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E69C001B0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 13:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4561980DF7;
	Wed, 16 Aug 2023 15:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DrhGHcIJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZuckxXRF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3CEB869D8; Wed, 16 Aug 2023 15:36:23 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96BD080842
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 15:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RQq0h2TWHz9sSZ;
 Wed, 16 Aug 2023 15:36:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692192980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QnkXk0YqpNldok9WLZq3ZjJVV0vPDSrneV80B5SQTQk=;
 b=DrhGHcIJt4et3qxn1K0A8RefRC9PjkcH2S5DUL02cFdAh2BN8N0P2AwqQlsO3m6myhfoo0
 TDWaj2yJNFKN732Tc8uQEOq6KEeYRaC9kf7BtGbfpsbgvuEX1LlNe8jRJJzncU0TKXywUq
 92nw3qdYytA5ljkRvkcVQR9yhMeoXxc+PAyqOxLqzC8f4oiZrlV0FguwX218gVGxE9iRPo
 KYLfnHO/2kmIe1p74MY+VO9cynnorUncq3PAdlU7Np4OZ88/ToJeO3iFnXP9u71DBxqHb3
 +ijSwFiyQG2lTO+oI7qKgaZb0L3GFouhLG1m+tYXBEHi+7Sa2Ca7ucRk0NHHBQ==
Message-ID: <c73ca9bd-26ec-0cbb-064e-f8a91c6b43ec@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692192977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QnkXk0YqpNldok9WLZq3ZjJVV0vPDSrneV80B5SQTQk=;
 b=ZuckxXRFtRKhiKOsF64IKW2HmtisYje98hvV7SfJkzQ9HZaGR8DgLYdJqMJsQApo1/5xUe
 1YfIMk6A4gkaI6SD7uv9BCgvzvFCvyWZnL36UwhPXH3Xkw3UnxvpROGmT6ztkQdJUhF9wI
 3OJh+05kXwtk0qqPwVl7nwCn7id5vzyjpIjoXBfwsHU85AVHzQrDLBMzRo9ayC6br/aTJx
 3pSa/cRUT+7Bssbj7zijUOYpFLAn664qBHTJrrc/HEFgI5NDtbFPfGfo1DFInhabPGhFiC
 sZouUQT36y93dJkjvHr/MhktZP0PRtt7PkB2Oa+rLktjiV0O93bxudPAyIOfEA==
Date: Wed, 16 Aug 2023 15:36:16 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/6] ufs: Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS
Content-Language: en-US
To: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20230813235231.591454-1-marek.vasut+renesas@mailbox.org>
 <0dc7875e-ecdb-27e3-4234-1e09a9e27a20@linaro.org>
 <460cb258-12fc-380e-1b14-65f41763764d@mailbox.org>
 <CAH=2NtxvFMPtyTQtguJwSok9--Ta+CbGQ0aHctxX_+u7JWHcNA@mail.gmail.com>
 <5b6fbc58-0d0a-becf-f713-4424efd4a1a0@mailbox.org>
 <CAH=2NtwE6zdqjrOHmPFiY6760_hhsFgLsvRfSoO-41V2tAE9mA@mail.gmail.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAH=2NtwE6zdqjrOHmPFiY6760_hhsFgLsvRfSoO-41V2tAE9mA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 7775890c4152fef2720
X-MBO-RS-META: njiysd4cmx7qsbenhk87omuwwwk68mco
X-Rspamd-Queue-Id: 4RQq0h2TWHz9sSZ
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

On 8/16/23 00:05, Bhupesh Sharma wrote:
> On Wed, 16 Aug 2023 at 03:10, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 8/15/23 23:08, Bhupesh Sharma wrote:
>>> On Wed, 16 Aug 2023 at 02:31, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>>>
>>>> On 8/15/23 22:04, Bhupesh Sharma wrote:
>>>>> Hi Marek,
>>>>>
>>>>> On 8/14/23 5:22 AM, Marek Vasut wrote:
>>>>>> Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS for host controllers which do not
>>>>>> support 64-bit addressing.
>>>>>>
>>>>>> Ported from Linux kernel commit
>>>>>> 6554400d6f66 ("scsi: ufs: core: Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS")
>>>>>> with ufs_scsi_buffer_aligned() based on U-Boot generic bounce buffer.
>>>>>>
>>>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>>>> ---
>>>>>> Cc: Faiz Abbas <faiz_abbas@ti.com>
>>>>>> ---
>>>>>>     drivers/ufs/ufs.c | 26 ++++++++++++++++++++++++++
>>>>>>     drivers/ufs/ufs.h |  6 ++++++
>>>>>>     2 files changed, 32 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
>>>>>> index 3bf1a95e7f2..da0550d98c6 100644
>>>>>> --- a/drivers/ufs/ufs.c
>>>>>> +++ b/drivers/ufs/ufs.c
>>>>>> @@ -8,6 +8,7 @@
>>>>>>      * Copyright (C) 2019 Texas Instruments Incorporated -
>>>>>> http://www.ti.com
>>>>>>      */
>>>>>> +#include <bouncebuf.h>
>>>>>>     #include <charset.h>
>>>>>>     #include <common.h>
>>>>>>     #include <dm.h>
>>>>>> @@ -1889,6 +1890,8 @@ int ufshcd_probe(struct udevice *ufs_dev, struct
>>>>>> ufs_hba_ops *hba_ops)
>>>>>>         /* Read capabilties registers */
>>>>>>         hba->capabilities = ufshcd_readl(hba, REG_CONTROLLER_CAPABILITIES);
>>>>>> +    if (hba->quirks & UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS)
>>>>>> +        hba->capabilities &= ~MASK_64_ADDRESSING_SUPPORT;
>>>>>>         /* Get UFS version supported by the controller */
>>>>>>         hba->version = ufshcd_get_ufs_version(hba);
>>>>>> @@ -1942,8 +1945,31 @@ int ufs_scsi_bind(struct udevice *ufs_dev,
>>>>>> struct udevice **scsi_devp)
>>>>>>         return ret;
>>>>>>     }
>>>>>> +#if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
>>>>>> +static int ufs_scsi_buffer_aligned(struct udevice *scsi_dev, struct
>>>>>> bounce_buffer *state)
>>>>>> +{
>>>>>> +#ifdef CONFIG_PHYS_64BIT
>>>>>> +    struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
>>>>>> +    uintptr_t ubuf = (uintptr_t)state->user_buffer;
>>>>>> +    size_t len = state->len_aligned;
>>>>>> +
>>>>>> +    /* Check if below 32bit boundary */
>>>>>> +    if ((hba->quirks & UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS) &&
>>>>>> +        ((ubuf >> 32) || (ubuf + len) >> 32)) {
>>>>>> +        dev_dbg(scsi_dev, "Buffer above 32bit boundary %lx-%lx\n",
>>>>>> +            ubuf, ubuf + len);
>>>>>> +        return 0;
>>>>>> +    }
>>>>>> +#endif
>>>>>> +    return 1;
>>>>>> +}
>>>>>> +#endif    /* CONFIG_BOUNCE_BUFFER */
>>>>>> +
>>>>>>     static struct scsi_ops ufs_ops = {
>>>>>>         .exec        = ufs_scsi_exec,
>>>>>> +#if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
>>>>>> +    .buffer_aligned    = ufs_scsi_buffer_aligned,
>>>>>> +#endif    /* CONFIG_BOUNCE_BUFFER */
>>>>>>     };
>>>>>>     int ufs_probe_dev(int index)
>>>>>> diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
>>>>>> index 8a38832b05f..070db0dce68 100644
>>>>>> --- a/drivers/ufs/ufs.h
>>>>>> +++ b/drivers/ufs/ufs.h
>>>>>> @@ -719,6 +719,12 @@ struct ufs_hba {
>>>>>>      */
>>>>>>     #define UFSHCD_QUIRK_BROKEN_LCC                0x1
>>>>>> +/*
>>>>>> + * This quirk needs to be enabled if the host controller has
>>>>>> + * 64-bit addressing supported capability but it doesn't work.
>>>>>> + */
>>>>>> +#define UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS        0x2
>>>>>> +
>>>>>>         /* Virtual memory reference */
>>>>>>         struct utp_transfer_cmd_desc *ucdl;
>>>>>>         struct utp_transfer_req_desc *utrdl;
>>>>>
>>>>> For this and the follow-up patch, I think implementing or at least
>>>>> supporting all the quirks currently supported by the Linux UFS driver
>>>>> makes sense as newer controllers do support these quirks.
>>>>
>>>> I disagree. There is no point in implementing quirks which cannot be
>>>> tested or may not even be relevant to U-Boot. Quirks which are needed
>>>> should be added one by one.
>>
>> I assume you agree we should not add all quirks at once ?
>>
>>> But the format you use for adding new quiks in u-boot is still in sync
>>> with Linux version 3.10. Can we atleast use the newer ( 1<< 7) kind of
>>> format for consistency.
>>
>> Feel free to update quirks to BIT() macro.
>>
>> We should enumerate the quirks in order instead of starting with BIT(7)
>> however.
> 
> Qualcomm UFS controllers support a few quirks from the list so the
> numbering can be taken care of in my patch.
> 
> But since 'include/ufs/ufs_quirks.h' in Linux already uses the (1 <<7)
> kind of format we can use the same as it would make future backporting
> from Linux easier.

Better use BIT() macro , can you fix that in Linux ? I'll fix it in V2 here.
