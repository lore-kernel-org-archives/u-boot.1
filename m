Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B03AC3DA41
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 13:46:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF70888657;
	Wed, 10 Jul 2024 15:46:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BIqt9+mM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F17A88710; Wed, 10 Jul 2024 15:46:08 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C513588025
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 15:46:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2c9e37bdd6fso2844489a91.3
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 06:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720619164; x=1721223964; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5d4e0OGrzPYWHbz3YTulsuEby9AlfEPDJ21hsmhv4Kk=;
 b=BIqt9+mM76b9pVs/+ZMH8r6m1l1KtdHXwdSh2Utt8bpgTpi5E40I9Qa6Mo2yxTLvJT
 Qsg9W4BSyzZmSenTy3b1hT5H7k4Ci/1XWuFzj8UVDxJkYYsKyHl1YB08BRby6uBH+HVE
 iU7CCqhsgP5dYGVgRshTuTnYHpFvIistk/zagB740pIh4Qfz407KirafDE/EqjpgkCIL
 LuXhDuw7SuvT2vkVs78Uq+f9777ScaXDDyb79+axpZx+3i3+qWV0ekUw2Jgqd55NiEeX
 jSkCinXWJRnBhVKIR8KL+cAP25yRaTdvxx7M0os6tcYCs2PMZod0UBdodkhon6kaiHT4
 eftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720619164; x=1721223964;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5d4e0OGrzPYWHbz3YTulsuEby9AlfEPDJ21hsmhv4Kk=;
 b=StQeELvVrUZYS+tM6C94G+owLcy5th51ahTJmdtYdDvcucYzoQQH0LkaH5n2iaCnMG
 hM9iVdtx5NRdhLfp8KenqwiOUxSbWtBQ2lWYPEWw8OaWUXArYi2JJKCfbclzpzxtO2y9
 VxnYLiwD992+7GShK8OrTamflV1+lddTKapA8Vi5hTiYNOf1enJrFoIWP/abbyiWcJal
 pkytKeR3MAb+Uyu28WOYLwX2Z1SdW5pUf7g+3j33ci+wCPAueTLq4Sih53hcF+Het/GM
 N3D61rC1zyl10OxILpSsOKbXIe/z70F4X6apx24xKDl3mwIIndWLsSkA7VqMhgyZus2G
 JQvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1+Jx+wQWvI/9iJSapr1HqA7SfhBDrhf9jjO72sGNQnWDESczCfDEWrzCh2K8+0Lu3TV4sik9R+pQmyDEVM52Qg8yDZA==
X-Gm-Message-State: AOJu0YxjBMOgMozpJJyXDzEkW+qbYLd/Uds5AjsdOf5fvjXp5FpXPbRP
 3vex5Rm/juLZo9QDKsYHfmfddxSVw/cJ6NGkx4Q7PSUK+dhEdx1hrsm5MBVe36+OaUTeZ102nnU
 JzSJjn1BVXZEUjwtgQazweyQ7++IaB0gwIUWf1g==
X-Google-Smtp-Source: AGHT+IH6e2NnYbnX5ZyA80A9D7kGnhdPkxA9U3wAGFSniq3Ht9nvBik7EtaB9IIPGy+ZJlTzDHiTT6r287NnI0MrK1c=
X-Received: by 2002:a17:90a:7807:b0:2c8:ac1:d8c3 with SMTP id
 98e67ed59e1d1-2ca35c770b2mr4931793a91.29.1720619164073; Wed, 10 Jul 2024
 06:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240709202057.2538776-1-yeoreum.yun@arm.com>
In-Reply-To: <20240709202057.2538776-1-yeoreum.yun@arm.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 10 Jul 2024 09:45:51 -0400
Message-ID: <CAEfUkULX1Ez=L0p7rZbweTA+V8NRuyiduaPrTaMqkhKW+aTOHw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] bloblist: Fix bloblist convention checking.
To: Levi Yun <yeoreum.yun@arm.com>
Cc: trini@konsulko.com, sjg@chromium.org, ilias.apalodimas@linaro.org, 
 bmeng.cn@gmail.com, nd@arm.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Levi,

On Tue, 9 Jul 2024 at 16:21, Levi Yun <yeoreum.yun@arm.com> wrote:

> According to recently firmware handsoff spec [1]'s "Register usage at
> handoff
> boundary", Transfer List's signature value was changed from 0x40_b10b
> (3 bytes) to 4a0f_b10b (4 bytes).
>
> As updating of TL's signature, register value of x1/r1 should be:
>
> In aarch32's r1 value should be
>     R1[23:0]: set to the TL signature (4a0f_b10b -> masked range value:
> 0f_b10b)
>     R1[31:24]: version of the register convention ==  1
>
> and
>
> In aarch64's x1 value should be
>     X1[31:0]: set to the TL signature (4a0f_b10b)
>     X1[39:32]: version of the register convention ==  1
>     X1[63:40]: MBZ
> (See the [2] and [3]).
>
> This patch fix problems:
>    1. breaking X1 value with updated specification in aarch64
>         - change of length of signature field.
>
>    2. previous error value set in R1 in arm32.
>         - length of signature should be 24, but it uses 32bit signature.
>
> [1] https://github.com/FirmwareHandoff/firmware_handoff
> [2] https://github.com/FirmwareHandoff/firmware_handoff/issues/32
> [3]
> https://github.com/FirmwareHandoff/firmware_handoff/commit/5aa7aa1d3a1db75213e458d392b751f0707de027
>
> Signed-off-by: Levi Yun <yeoreum.yun@arm.com>
> ---
> v3:
>   - Restore arch/arm/lib/xferlist.c.
>
> v2:
>   - Modify commit message.
>   - Remove wrong swaping check in xferlist_from_boot_arg().
>
>  common/bloblist.c  | 11 ++++++++++-
>  include/bloblist.h |  5 ++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index 11d6422b69..2008ab4d25 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -576,7 +576,16 @@ int bloblist_maybe_init(void)
>
>  int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig)
>  {
> -       if (rzero || rsig != (BLOBLIST_MAGIC | BLOBLIST_REGCONV_VER) ||
> +       ulong version = BLOBLIST_REGCONV_VER;
> +       ulong sigval;
> +
> +       sigval = (IS_ENABLED(CONFIG_64BIT)) ?
> +                       ((BLOBLIST_MAGIC & ((1UL <<
> BLOBLIST_REGCONV_SHIFT_64) - 1)) |
> +                        ((version  & BLOBLIST_REGCONV_MASK) <<
> BLOBLIST_REGCONV_SHIFT_64)) :
> +                       ((BLOBLIST_MAGIC & ((1UL <<
> BLOBLIST_REGCONV_SHIFT_32) - 1)) |
> +                        ((version  & BLOBLIST_REGCONV_MASK) <<
> BLOBLIST_REGCONV_SHIFT_32));
> +
> +       if (rzero || rsig != sigval ||
>             rfdt != (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0)) {
>                 gd->bloblist = NULL;  /* Reset the gd bloblist pointer */
>                 return -EIO;
> diff --git a/include/bloblist.h b/include/bloblist.h
> index 7fbdd622bc..f4849f22a0 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -83,7 +83,10 @@ enum {
>          * Register convention version should be placed into a higher byte
>          * https://github.com/FirmwareHandoff/firmware_handoff/issues/32
>          */
> -       BLOBLIST_REGCONV_VER    = 1 << 24,
> +       BLOBLIST_REGCONV_SHIFT_64 = 32,
> +       BLOBLIST_REGCONV_SHIFT_32 = 24,
> +       BLOBLIST_REGCONV_MASK = 0xff,
> +       BLOBLIST_REGCONV_VER = 1,
>
> Please remove the "FIXME" on top of your changes.
It was a reminder for the bug of the FW handoff spec.
We don't need it anymore once your patch is merged.

BTW, you might need to resend the patch with a new
subject "[PATCH v2 ....]" instead of following the original
topic when you send a new version.

Regards,
Raymond
