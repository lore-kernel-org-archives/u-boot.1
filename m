Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E979EF48ED
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 08:47:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A282883015;
	Fri, 13 Feb 2026 09:47:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="djg/Yvrk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A0BC83CBD; Fri, 13 Feb 2026 09:47:39 +0100 (CET)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 970A480FA1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:47:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-64ae2ce2fe1so654534d50.1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 00:47:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770972454; cv=none;
 d=google.com; s=arc-20240605;
 b=UMCDb6OhWnQjw8VgKDi7khVJuOpiBtjXErh7cVkomZMfkJn1iwWiChCrzlxgnpWJIP
 E4K+MF2G6+ACeCy8ou42C4DQaXIWCY/Vfn3ZCGG+rN+TjCVnZ1CG+d9ZSTvuaenwytac
 +4lEWtJINea/xkYA2OKM5u4mmvDkmRtO+zGjDyalYNtjeDMjZvEtCM61ueE/Cwzlytsc
 jrNPdpt2skXei2eRUFmvPlmzcC69zqXpKO7FyObVfk4oTYnB7+Uutubtj9U0Ovq8Konw
 kIC2PvUdwNoX5ELbdDQEddNuhACurH7E0o4oU5rHqD43zB9REyvMB1ui5wIuIRvv1TuU
 Nq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VNAFFuYNbvBdPaamzYkweJCeZ+K8EymdLhC3pQl7JB8=;
 fh=vyfbts51IeL9YqiXEXChvJnWUKQFbZdi8gERlNYTnqw=;
 b=ZdCqh+6r1MW77x7lFrpAXrujU0om7Un6+s5UB8khqFaqf5B0lpfuY3Nc/w16vki4mB
 tD3dDMSUBHYNeF4Sevs49U/ggYjgvnyctihkRYcKDGUkCWvFVwhlc9VpEhKcckKE0kzt
 QmyTWGKW6s9LEN5K4O6ax7hvOTxZE7wXC/0MUNi7uU+j9Dt5MT8N9euIYK8qvohqsNcY
 bZZXjSPmxTQ5OR8X8Q7DyOvSsj6y4vvlUUQyG3nHcHMzsTwmjmvvi1wOs28QtAIZMNDb
 VTA3Wfb2CUsXJ/8UHRo/bjxfAttMgy4CcDEJo1fKeiP9vJpqq17ePREJtlrZIhpAmMQp
 ddew==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770972454; x=1771577254; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VNAFFuYNbvBdPaamzYkweJCeZ+K8EymdLhC3pQl7JB8=;
 b=djg/YvrkH1NZ0xf+7R9UDw/jpwGTL74Qzb4uAAxhLjGlcvzYOo1N8OVp8KKrS1EmN8
 wxYWQ1pZ3DSyZ/wzQ2yiuYODPozZP5QL3flRs2dTnRPQP3sTzXhGR04ILwBs8bcTUvxs
 iBG7+begbIIz4bs5YKFiFKB3SPmcHx639XgjLKz3Qi9eHfg5FIVQyE0cwjf65ZMum8lf
 SrX7ymQq/5J9so6eOcDvIkeusLcCGZbztUGBoqtEW1JZotD+ljmDtEu4tFVH1wYXqN/7
 bSu00+x4kT+fnrl8T3xgQ6U2ZSrpeWBR37gsk6duv/oN86DfPrsJSCCIOJkXhXeoGVSR
 GUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770972454; x=1771577254;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VNAFFuYNbvBdPaamzYkweJCeZ+K8EymdLhC3pQl7JB8=;
 b=gNDNwKQkrANX3PrLKEt8hiH4fWI/dx9BZDgunvYCLrZlFyFBVa1CcCpv9pprrQQM/9
 63xnYxYSa7LYoptSnb4N2h2wGhU1RgmOeg2Y2jtrbyGnf8AGqIsEwX/NdCnOhbF8MgYt
 Lq91/CEYnyJ6xdKceuXEb0jOjfQfQ6Yl6xp4KdF4bRAF2kqPX+evN/SMS4P4X/i7NbBL
 loIWBNglb220c09VhWNujhmFk1HYTN2CnC0QlLU2wDZE9vwQ1EuAOOf80ZtLuhe2eUSk
 iPwzh1135mgPayPI6PW5c9XFDICI7N55ne0bFiW4tx26k2ruvbY102fC/fzlRJJhkyP3
 ZLAw==
X-Gm-Message-State: AOJu0YzK9iuDtP0uodNSKWjIZxCUQhD+Rr3QsokWuiM/mXahRdCeAaj1
 usLIfpXVksCT2+CaS0chkLwzXAkR8czBi0qEomsDXQm0ZWU7oe84Zji4lSUgLSwx5VESBEb4No9
 Vl+92+GJwsEJEshoamv8h+KNgvCjCq889tn9mJG639A==
X-Gm-Gg: AZuq6aL1BLiW9EzadsNZlKoRVNzK/vsOwQKcrEf+JJbmcPP7uoWtNo2s3iaUNktP6GJ
 0rBx695B1pK1Uy0QaBtkA3iJtbMJn4EeJDHzPjNWIx+KDPxm0v2krol9UrsObuuWA+Xv8QIjy4v
 ekJ5bb07AyHapFLjx/wsHGarUL2FvmsfSzdCSm3+/LJEnWR2N9DyFPj6/H9NvPazuA+9d/l8KQh
 67n1oMaOc1OPUT1tTuB/OrNIjiSdO85WLl4szylJKSAgv02YyqxeTMQckOoskKaRDH4Hym2CTl2
 YTtMyCWbVI057gpstriCl44ZtFVziQPKJe5BkbP1HvxeFcE9zNuf2axZZP5c26IXFkrusJkbEf6
 tZOv/w6UniMH7h6ztvwhPpKwBvEYhVRx8a4MFiajtH7NnewvGYKaRSldJy0KEMTnIQ2LAijLPG5
 mYaNopFQ1ij0r+x+h18j5TLJZmXdgeM+pto+6wweejmhMppHs1SQY79MdZaGGsPdOYmbrKP2IEm
 8IOd5XEvhIzubWqCzNReKZ2Dw6k0SEktQR+ytiZZWmcbXpF+/R7bP4XVss4ULO4/4/U939dQI1B
 NmOeMqyf35187pYE09ZfdLSWEk3cql875Bs+K+2CDrQXvliLCKA4pXM=
X-Received: by 2002:a05:690e:d83:b0:649:d5ca:7988 with SMTP id
 956f58d0204a3-64c19b15cffmr712603d50.48.1770972454390; Fri, 13 Feb 2026
 00:47:34 -0800 (PST)
MIME-Version: 1.0
References: <20260212204511.619392-1-javierm@redhat.com>
 <20260212204511.619392-8-javierm@redhat.com>
In-Reply-To: <20260212204511.619392-8-javierm@redhat.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Feb 2026 10:46:58 +0200
X-Gm-Features: AZwV_QgMn0_tOUjJYYpSn6EhOJVHaHdSagcy_vc2kvO_407aJMdSeq90KFAL02Y
Message-ID: <CAC_iWjL9M6AHdSn-76moLVkzWLk3gSqtz+CuKw5dxbayznzFCg@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] efi_selftest: Enhance MBR test for
 PARTITION_INFO_PROTOCOL
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 eballetb@redhat.com, Tom Rini <trini@konsulko.com>
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

On Thu, 12 Feb 2026 at 22:45, Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> The EFI_PARTITION_INFO_PROTOCOL test was added before the protocol fully
> supported MBR partitions. As a result, it lacked specific checks for the
> content of the raw MBR partition record.
>
> Now that MBR support has been implemented, enhance the selftest to provide
> coverage for the MBR entries too.
>
> This verifies that the protocol correctly reads and exposes MBR partition
> records and prevents this functionality to regress due future changes.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> (no changes since v1)
>
>  lib/efi_selftest/efi_selftest_block_device.c | 26 ++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/lib/efi_selftest/efi_selftest_block_device.c b/lib/efi_selftest/efi_selftest_block_device.c
> index f145e58a267a..9c4be834eebb 100644
> --- a/lib/efi_selftest/efi_selftest_block_device.c
> +++ b/lib/efi_selftest/efi_selftest_block_device.c
> @@ -19,6 +19,7 @@
>  #include "efi_selftest_disk_image.h"
>  #include <asm/cache.h>
>  #include <part_efi.h>
> +#include <part.h>
>
>  /* Block size of compressed disk image */
>  #define COMPRESSED_DISK_IMAGE_BLOCK_SIZE 8
> @@ -319,6 +320,25 @@ static int execute(void)
>         u64 pos;
>         char block_io_aligned[1 << LB_BLOCK_SIZE] __aligned(1 << LB_BLOCK_SIZE);
>
> +       /*
> +        * The test disk image is defined in efi_selftest_disk_image.h,
> +        * it contains a single FAT12 partition of 127 sectors size.
> +        */
> +       static const dos_partition_t mbr_expected = {
> +               .boot_ind = 0x00,
> +               .head = 0x00,
> +               .sector = 0x02,
> +               .cyl = 0x00,
> +               .sys_ind = 0x01, /* FAT12 */
> +               .end_head = 0x02,
> +               .end_sector = 0x02,
> +               .end_cyl = 0x00,
> +               /* LBA 1 */
> +               .start_sect = cpu_to_le32(1),
> +               /* Size 127 sectors (0x7f) */
> +               .nr_sects = cpu_to_le32(127),
> +       };
> +
>         /* Connect controller to virtual disk */
>         ret = boottime->connect_controller(disk_handle, NULL, NULL, 1);
>         if (ret != EFI_SUCCESS) {
> @@ -405,6 +425,12 @@ static int execute(void)
>                 return EFI_ST_FAILURE;
>         }
>
> +       /* Compare the obtained MBR with the expected one for the test partition */
> +       if (memcmp(&part_info->info.mbr, &mbr_expected, sizeof(mbr_expected))) {
> +               efi_st_error("MBR partition record mismatch\n");
> +               return EFI_ST_FAILURE;
> +       }
> +
>         /* Open the simple file system protocol */
>         ret = boottime->open_protocol(handle_partition,
>                                       &guid_simple_file_system_protocol,
> --
> 2.53.0
>
