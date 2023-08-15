Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B67EC001E0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 21:08:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B80A1869B0;
	Tue, 15 Aug 2023 23:08:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="avs+hC76";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0240C8698F; Tue, 15 Aug 2023 23:08:50 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCE06867E2
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 23:08:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fe4cdb727cso59271865e9.0
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 14:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692133726; x=1692738526;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PFhKwhzuDlrv5mylOECioDy7wyzWE9vgbTZykRKDrMA=;
 b=avs+hC76Or2dDOwqf8xjbD0i5r1JVPM8/FA7IKlpGfYVUHoV/Y8c6IJCRd6Afj6Qc9
 KGT5sbCMCVyIQ7Vbk5/i5RzDJ1Vwlep30zbpGJP3wsUHJjrMa0S3vLaeN9o2rixjZ3yC
 CvBJlLm4L+9tA2AhBSexOX0IOs4TaB3l1iMwUG8BCWAppveXn4MGCiSD1xfJ658gF/Dj
 oYdsoCCjORMvpcwvphQrqoU+FnKAJTt+TJZyAFowS0PMNE9vsY5qjUZAw1d50rJW8cyB
 MJYYxIdvq8SmPti+PgeN6fCLthqtP6hdElPs/lk3b/V/Z76bvMoepWUO/iRB8QpdN9On
 b/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692133726; x=1692738526;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PFhKwhzuDlrv5mylOECioDy7wyzWE9vgbTZykRKDrMA=;
 b=k39b4Pkn4kUlS1THpUkjs4Kx1qaRZNJrz1f6sYrhCugvYTAAh1PzfsxWuEiPZ1D28G
 KHGf5DvOtx2gioIy+DeoOiLM2XX5RmCoDBnZT/dh/VpIp87ObjTIFDLSA0T6K5PdRsIt
 wkeumVh7YRw9IvILvxgcX/QeZt05ELF1ppV4i9bS8lunftVCuvEGZe4PYPQlK/7kH2QY
 tjNoJaHBmC40dp7YHlaeBAfpi7rEzE+Mo4dEbmCmcKqgTZ4d6XQEd7Hizb84NTZHMUom
 eDt5a+5ZGzo499C6Q/JIxEUM7Y0rw2YXp944CLxJ2ZISqCgo2Lw3XfS0+Lf8LEfcn9Ix
 SMlQ==
X-Gm-Message-State: AOJu0Yw+PfERsvWDgFLOVER5WxfrF3CGDx0ZXZR5v2O423dZrWhkvKk3
 oxS9EJSHnRyhBP4WcAIROWL+wNYNmdj0+yB7OEdkng==
X-Google-Smtp-Source: AGHT+IFJEmp6WuSf/bXcUDw4eftOPELUwXmGh3+j8fVvjuRhZFvfZpaHtjbqnIp+ru/waLHtUDBRZb4VoUHCrAGxuZc=
X-Received: by 2002:a5d:5088:0:b0:319:6ea5:72db with SMTP id
 a8-20020a5d5088000000b003196ea572dbmr7093130wrt.67.1692133726196; Tue, 15 Aug
 2023 14:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230813235231.591454-1-marek.vasut+renesas@mailbox.org>
 <0dc7875e-ecdb-27e3-4234-1e09a9e27a20@linaro.org>
 <460cb258-12fc-380e-1b14-65f41763764d@mailbox.org>
In-Reply-To: <460cb258-12fc-380e-1b14-65f41763764d@mailbox.org>
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date: Wed, 16 Aug 2023 02:38:34 +0530
Message-ID: <CAH=2NtxvFMPtyTQtguJwSok9--Ta+CbGQ0aHctxX_+u7JWHcNA@mail.gmail.com>
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

On Wed, 16 Aug 2023 at 02:31, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 8/15/23 22:04, Bhupesh Sharma wrote:
> > Hi Marek,
> >
> > On 8/14/23 5:22 AM, Marek Vasut wrote:
> >> Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS for host controllers which do not
> >> support 64-bit addressing.
> >>
> >> Ported from Linux kernel commit
> >> 6554400d6f66 ("scsi: ufs: core: Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS")
> >> with ufs_scsi_buffer_aligned() based on U-Boot generic bounce buffer.
> >>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >> ---
> >> Cc: Faiz Abbas <faiz_abbas@ti.com>
> >> ---
> >>   drivers/ufs/ufs.c | 26 ++++++++++++++++++++++++++
> >>   drivers/ufs/ufs.h |  6 ++++++
> >>   2 files changed, 32 insertions(+)
> >>
> >> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> >> index 3bf1a95e7f2..da0550d98c6 100644
> >> --- a/drivers/ufs/ufs.c
> >> +++ b/drivers/ufs/ufs.c
> >> @@ -8,6 +8,7 @@
> >>    * Copyright (C) 2019 Texas Instruments Incorporated -
> >> http://www.ti.com
> >>    */
> >> +#include <bouncebuf.h>
> >>   #include <charset.h>
> >>   #include <common.h>
> >>   #include <dm.h>
> >> @@ -1889,6 +1890,8 @@ int ufshcd_probe(struct udevice *ufs_dev, struct
> >> ufs_hba_ops *hba_ops)
> >>       /* Read capabilties registers */
> >>       hba->capabilities = ufshcd_readl(hba, REG_CONTROLLER_CAPABILITIES);
> >> +    if (hba->quirks & UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS)
> >> +        hba->capabilities &= ~MASK_64_ADDRESSING_SUPPORT;
> >>       /* Get UFS version supported by the controller */
> >>       hba->version = ufshcd_get_ufs_version(hba);
> >> @@ -1942,8 +1945,31 @@ int ufs_scsi_bind(struct udevice *ufs_dev,
> >> struct udevice **scsi_devp)
> >>       return ret;
> >>   }
> >> +#if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
> >> +static int ufs_scsi_buffer_aligned(struct udevice *scsi_dev, struct
> >> bounce_buffer *state)
> >> +{
> >> +#ifdef CONFIG_PHYS_64BIT
> >> +    struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
> >> +    uintptr_t ubuf = (uintptr_t)state->user_buffer;
> >> +    size_t len = state->len_aligned;
> >> +
> >> +    /* Check if below 32bit boundary */
> >> +    if ((hba->quirks & UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS) &&
> >> +        ((ubuf >> 32) || (ubuf + len) >> 32)) {
> >> +        dev_dbg(scsi_dev, "Buffer above 32bit boundary %lx-%lx\n",
> >> +            ubuf, ubuf + len);
> >> +        return 0;
> >> +    }
> >> +#endif
> >> +    return 1;
> >> +}
> >> +#endif    /* CONFIG_BOUNCE_BUFFER */
> >> +
> >>   static struct scsi_ops ufs_ops = {
> >>       .exec        = ufs_scsi_exec,
> >> +#if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
> >> +    .buffer_aligned    = ufs_scsi_buffer_aligned,
> >> +#endif    /* CONFIG_BOUNCE_BUFFER */
> >>   };
> >>   int ufs_probe_dev(int index)
> >> diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
> >> index 8a38832b05f..070db0dce68 100644
> >> --- a/drivers/ufs/ufs.h
> >> +++ b/drivers/ufs/ufs.h
> >> @@ -719,6 +719,12 @@ struct ufs_hba {
> >>    */
> >>   #define UFSHCD_QUIRK_BROKEN_LCC                0x1
> >> +/*
> >> + * This quirk needs to be enabled if the host controller has
> >> + * 64-bit addressing supported capability but it doesn't work.
> >> + */
> >> +#define UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS        0x2
> >> +
> >>       /* Virtual memory reference */
> >>       struct utp_transfer_cmd_desc *ucdl;
> >>       struct utp_transfer_req_desc *utrdl;
> >
> > For this and the follow-up patch, I think implementing or at least
> > supporting all the quirks currently supported by the Linux UFS driver
> > makes sense as newer controllers do support these quirks.
>
> I disagree. There is no point in implementing quirks which cannot be
> tested or may not even be relevant to U-Boot. Quirks which are needed
> should be added one by one.

But the format you use for adding new quiks in u-boot is still in sync
with Linux version 3.10. Can we atleast use the newer ( 1<< 7) kind of
format for consistency.

Thanks.

> > Accordingly I had sent:
> > https://lists.denx.de/pipermail/u-boot/2023-August/527217.html
> >
> > So, I would suggest that we pick these two patches and then I can send
> > my patches rebased on the same, but change the .h to support all the
> > possible UFS quirks currently supported in Linux so that subsequent
> > patches can utilize them in u-boot - which I plan to post next.
>
> See above.
