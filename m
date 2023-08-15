Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179AAC0015E
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 22:05:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80C0B868CB;
	Wed, 16 Aug 2023 00:05:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ftMRd3Nu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2246586901; Wed, 16 Aug 2023 00:05:30 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC88386852
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 00:05:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-317b31203c7so5382170f8f.2
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 15:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692137126; x=1692741926;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S5XS5FdSWhWm1ohWDw5uEO6vbQZQmKbsdS0lFKwP0qk=;
 b=ftMRd3Nuqk79EAs0fPVhNEX2tNLeG6X9HDCswj4+MKKGqaz+1iaSjxgbWCDQGDyIfF
 mlQWfEauCFSq1xptUWyV0gct/EfIYBBqyF2csgW9Ap218E3q55mmIczH/b/rGjoXPiBH
 KG+keV7DzQ6+rF9CRRnZE7LD27CH7cl4SuyHTRPtERdOYzmJlQIl3qZrIrCuhgFk4kdS
 FeJ+q9l+LVw+cG9slshn1Y+CkkaoZ0KTQjmg5g8X7ajdLk0K+Mteo3jbcoit5onMxUwN
 OqT7Acbdx0i9r40LemfIuvcqalFj/VlD/Af+XBUVnA1JJ3iOpj9lQ7t0lERT18t5Uy1E
 MmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692137126; x=1692741926;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S5XS5FdSWhWm1ohWDw5uEO6vbQZQmKbsdS0lFKwP0qk=;
 b=ZGVwnpOiWqZaitlOF9OHHasbOwowIYkTkhV4A2/4vPZY9gVxQW0r6Hqtx7bSqGtnFG
 ng8KrVFiACMRJA7qe+xq/FeDzI72niUtTWqZJqBpP8Xf5wVRaxlDUX20zjG5Ue5ZAeju
 XrWhshfhIcmi7PP/8jBHdd3PpkGgqbWixsywYGyCe6cFf6h8IvPkFV/chfugm4u1qrQB
 +YaCREKGvNO3k2PF7ilrY4Suos+jJCRW1ZhRvCGaoUbSjYc3e8N24DC0gy0GDnLk4vzE
 I0CJbLPoLkPn5KDT6udZ3r17AEgoBnmGnk2okxQ4Jvpp729LxZ33fq/sQ3eaYn0hTNsW
 1l6Q==
X-Gm-Message-State: AOJu0YyX8vgFG5g8wEx18kUd3e+dgG1wCK/Sm3a3bBefqInSQSojwesx
 TSobCLtMLefJz9Tgt2DUp/rtxHWtZkaKAM5lJWKlBPHifsRCxqyPcm4=
X-Google-Smtp-Source: AGHT+IFMShnInsN2FB6E4EKxf8kFrVUB5mj4oPq0gED6YkKY0AbewdayVAmpTOUbwPbTiTtLg+Me4cbtY9Jsei+lnV4=
X-Received: by 2002:a5d:68c2:0:b0:317:7062:32d2 with SMTP id
 p2-20020a5d68c2000000b00317706232d2mr21001wrw.54.1692137126307; Tue, 15 Aug
 2023 15:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230813235231.591454-1-marek.vasut+renesas@mailbox.org>
 <0dc7875e-ecdb-27e3-4234-1e09a9e27a20@linaro.org>
 <460cb258-12fc-380e-1b14-65f41763764d@mailbox.org>
 <CAH=2NtxvFMPtyTQtguJwSok9--Ta+CbGQ0aHctxX_+u7JWHcNA@mail.gmail.com>
 <5b6fbc58-0d0a-becf-f713-4424efd4a1a0@mailbox.org>
In-Reply-To: <5b6fbc58-0d0a-becf-f713-4424efd4a1a0@mailbox.org>
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date: Wed, 16 Aug 2023 03:35:14 +0530
Message-ID: <CAH=2NtwE6zdqjrOHmPFiY6760_hhsFgLsvRfSoO-41V2tAE9mA@mail.gmail.com>
Subject: Re: [PATCH 1/6] ufs: Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 16 Aug 2023 at 03:10, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 8/15/23 23:08, Bhupesh Sharma wrote:
> > On Wed, 16 Aug 2023 at 02:31, Marek Vasut <marek.vasut@mailbox.org> wrote:
> >>
> >> On 8/15/23 22:04, Bhupesh Sharma wrote:
> >>> Hi Marek,
> >>>
> >>> On 8/14/23 5:22 AM, Marek Vasut wrote:
> >>>> Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS for host controllers which do not
> >>>> support 64-bit addressing.
> >>>>
> >>>> Ported from Linux kernel commit
> >>>> 6554400d6f66 ("scsi: ufs: core: Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS")
> >>>> with ufs_scsi_buffer_aligned() based on U-Boot generic bounce buffer.
> >>>>
> >>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >>>> ---
> >>>> Cc: Faiz Abbas <faiz_abbas@ti.com>
> >>>> ---
> >>>>    drivers/ufs/ufs.c | 26 ++++++++++++++++++++++++++
> >>>>    drivers/ufs/ufs.h |  6 ++++++
> >>>>    2 files changed, 32 insertions(+)
> >>>>
> >>>> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> >>>> index 3bf1a95e7f2..da0550d98c6 100644
> >>>> --- a/drivers/ufs/ufs.c
> >>>> +++ b/drivers/ufs/ufs.c
> >>>> @@ -8,6 +8,7 @@
> >>>>     * Copyright (C) 2019 Texas Instruments Incorporated -
> >>>> http://www.ti.com
> >>>>     */
> >>>> +#include <bouncebuf.h>
> >>>>    #include <charset.h>
> >>>>    #include <common.h>
> >>>>    #include <dm.h>
> >>>> @@ -1889,6 +1890,8 @@ int ufshcd_probe(struct udevice *ufs_dev, struct
> >>>> ufs_hba_ops *hba_ops)
> >>>>        /* Read capabilties registers */
> >>>>        hba->capabilities = ufshcd_readl(hba, REG_CONTROLLER_CAPABILITIES);
> >>>> +    if (hba->quirks & UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS)
> >>>> +        hba->capabilities &= ~MASK_64_ADDRESSING_SUPPORT;
> >>>>        /* Get UFS version supported by the controller */
> >>>>        hba->version = ufshcd_get_ufs_version(hba);
> >>>> @@ -1942,8 +1945,31 @@ int ufs_scsi_bind(struct udevice *ufs_dev,
> >>>> struct udevice **scsi_devp)
> >>>>        return ret;
> >>>>    }
> >>>> +#if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
> >>>> +static int ufs_scsi_buffer_aligned(struct udevice *scsi_dev, struct
> >>>> bounce_buffer *state)
> >>>> +{
> >>>> +#ifdef CONFIG_PHYS_64BIT
> >>>> +    struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
> >>>> +    uintptr_t ubuf = (uintptr_t)state->user_buffer;
> >>>> +    size_t len = state->len_aligned;
> >>>> +
> >>>> +    /* Check if below 32bit boundary */
> >>>> +    if ((hba->quirks & UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS) &&
> >>>> +        ((ubuf >> 32) || (ubuf + len) >> 32)) {
> >>>> +        dev_dbg(scsi_dev, "Buffer above 32bit boundary %lx-%lx\n",
> >>>> +            ubuf, ubuf + len);
> >>>> +        return 0;
> >>>> +    }
> >>>> +#endif
> >>>> +    return 1;
> >>>> +}
> >>>> +#endif    /* CONFIG_BOUNCE_BUFFER */
> >>>> +
> >>>>    static struct scsi_ops ufs_ops = {
> >>>>        .exec        = ufs_scsi_exec,
> >>>> +#if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
> >>>> +    .buffer_aligned    = ufs_scsi_buffer_aligned,
> >>>> +#endif    /* CONFIG_BOUNCE_BUFFER */
> >>>>    };
> >>>>    int ufs_probe_dev(int index)
> >>>> diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
> >>>> index 8a38832b05f..070db0dce68 100644
> >>>> --- a/drivers/ufs/ufs.h
> >>>> +++ b/drivers/ufs/ufs.h
> >>>> @@ -719,6 +719,12 @@ struct ufs_hba {
> >>>>     */
> >>>>    #define UFSHCD_QUIRK_BROKEN_LCC                0x1
> >>>> +/*
> >>>> + * This quirk needs to be enabled if the host controller has
> >>>> + * 64-bit addressing supported capability but it doesn't work.
> >>>> + */
> >>>> +#define UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS        0x2
> >>>> +
> >>>>        /* Virtual memory reference */
> >>>>        struct utp_transfer_cmd_desc *ucdl;
> >>>>        struct utp_transfer_req_desc *utrdl;
> >>>
> >>> For this and the follow-up patch, I think implementing or at least
> >>> supporting all the quirks currently supported by the Linux UFS driver
> >>> makes sense as newer controllers do support these quirks.
> >>
> >> I disagree. There is no point in implementing quirks which cannot be
> >> tested or may not even be relevant to U-Boot. Quirks which are needed
> >> should be added one by one.
>
> I assume you agree we should not add all quirks at once ?
>
> > But the format you use for adding new quiks in u-boot is still in sync
> > with Linux version 3.10. Can we atleast use the newer ( 1<< 7) kind of
> > format for consistency.
>
> Feel free to update quirks to BIT() macro.
>
> We should enumerate the quirks in order instead of starting with BIT(7)
> however.

Qualcomm UFS controllers support a few quirks from the list so the
numbering can be taken care of in my patch.

But since 'include/ufs/ufs_quirks.h' in Linux already uses the (1 <<7)
kind of format we can use the same as it would make future backporting
from Linux easier.

Thanks.
