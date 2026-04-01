Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60CB1112242
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 23:26:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A84CB840B5;
	Thu,  2 Apr 2026 01:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TmrRgo35";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EB59840D8; Thu,  2 Apr 2026 01:26:14 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7372084011
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 01:26:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b9c280322e0so31720966b.0
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 16:26:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775085972; cv=none;
 d=google.com; s=arc-20240605;
 b=Bo4OpYz6BUoBXS45Spq7aJQ0LZVCnJGkOnH7dEoLHCEZk3n6ZU0bIvZ5mSUrEHBWlU
 A3NgdYSS6t7e5FFLQypql/iCSe9oGqIjZrq2Jz9hzU/TQ7scTtfwgSXt1v8n0b+SH5XZ
 R+tgdugdjTFlwDFaTmshTlPQQ7I79PToGpWVRoZrBdslDXQAAzoMy9dwAshIraTuwd5c
 fcUeOgX3RBKlOg4RZGCmip3xAOYjf/C8qJxhaZggBGao3Klqjruqs/8erSqTTqFAE7e3
 IpLKs765SdFgcNKOA6j6gDRRopOxmVI7wA766TkqgQelj24+EquhHE8ph3TxcokoK6RY
 fKqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hxgnO6Dv3tS30Eh7HD6EKG85w2sxU4XGws38OkejTRQ=;
 fh=HVmHfPU8OUTemAMD/Npo9veCu7wyD02P2C5lSzN9HI0=;
 b=dBw6mLg3fwCGMzZ5CjXoRwdiB3q2b0a8MEGQTFD9DPcACkZfSW1VYAZD2eir6sny7A
 4o/oBze9ZAILRq6M8g+Bzl4EQgt8S3dfnKai6/vAn9q+Aav2+rHJ/tL2PkQMP5l55b3Q
 k78UeAIQ5B7bSXqJZnLQ1+G48taNBLpy6Av1QnJ6I437MYz4i+Qx2AMom8M+igLdb9D5
 eoGpuTb8cC11GLP8Zh6ms+fB3LT3ItnYZXtVJHg+86L/zHyovWuMbeT8AWqxlAnTlUqC
 WvVEh0OUNxExtdDfmYlw5go0uivkIU9cuwhMXzLhCchS7tA6m/MRjoU3JRheocCAy2u2
 p4TQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775085972; x=1775690772; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hxgnO6Dv3tS30Eh7HD6EKG85w2sxU4XGws38OkejTRQ=;
 b=TmrRgo35M+MfE0N5UeADLyXIxAQptSEuXGkYL/CIfTlaKekMu47to1UJK0vD5IxnjL
 VUvJsXXR9RyQQs7iI4A33W6aPWWOml2Jbdf3dhbk61fplv3E4Q1/u/N83mkm2D7pZIEJ
 OJdWthiSFDW9+Ikm1UAjbET0aY/mk3yGAbTXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775085972; x=1775690772;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hxgnO6Dv3tS30Eh7HD6EKG85w2sxU4XGws38OkejTRQ=;
 b=Zk3O4PQlR/ZWFDDi+jLcgkF5i/yWIwl4aQAdPTgPNV0Glt71HPp7n/ZbV0lB2/Rlo6
 qR1McgecCdzukGWqTMXIeNW15SR/fU9iFpAfhiWPBCJlv4dvSeFTMPljP4UZxqhf36Wy
 7J2dyshwvD8Enr80s8oTXNmeqADfoysc0L3LsUfz2Xdysn0B8DHZhCiZWWTX5hvflf/V
 yARiWcwlN3WpuMKOEeha2BpSFiaHHK6nI44eHHQO+8hq5vNJVKlXc8hB/GwZdWY5ccEU
 Y1ROyNBj/ZTRWLrhwFcBw3daOyPiOubXDlDJjklQRlvfHj8H7EZv67AuWsu0Tff8m6PE
 5qEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9LT62fq9MLbXtb0UTuAu16OQqEv6rsqgPri+NvAks83rYmQPv0hYweb5J/Cb4I4OM8N5i4hI=@lists.denx.de
X-Gm-Message-State: AOJu0YwGEOglW5q8nXwTgxpFFvHgs+y3efQdSB5+JwBa88Zhkdk6jUeS
 G3wD+2iIFOveVX5HoWiS6vQY5hPZszljMyzX5ZpaEcGU0D5y8/74PncEg18fXowlWfZjCTNa5dG
 qfwb0IkjigQMoWnfwhavD6VD0Kx+W8kDUzOwP7GNm
X-Gm-Gg: ATEYQzx0Fpb64G+9JNx1Zrg2XzC1vSZ/nUYKN2+kUlxbn4Euu5DTZzbu2fIWREn31ZC
 KngfqxM16ti/vKyNSTRTejmK15OH+5WBQWLWXrl2c3TpQg2kgCEywiEfR8GgcCmZQ+tsCf1HeNg
 KNeJ2DFDQq/4fGnguu1s+bUXsZB3T0Wui7WvknCfDpZnX7vxu5tiHts/NTdLQrniBghpnq9rTVM
 kjUa1u7m8e1AsWA8xuRf1Pckx5uH5zXAKfcS0Z8R11GyFaZl5pLIF6Dinl6MSFtRKpegIMISveb
 XZ+6mrAC+ZxjTdfu
X-Received: by 2002:a17:906:48da:b0:b98:411a:116f with SMTP id
 a640c23a62f3a-b9c137a7fa5mr300160866b.2.1775085971883; Wed, 01 Apr 2026
 16:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260331075338.2391-1-ansuelsmth@gmail.com>
 <20260331075338.2391-5-ansuelsmth@gmail.com>
In-Reply-To: <20260331075338.2391-5-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 19:25:52 -0400
X-Gm-Features: AQROBzAQ6-_YRKfA7L1pI4U-QePLeFQRgVDUKSbCljcLL60gpg2tFD-TlCanvdU
Message-ID: <CAFLszThM+ijAVQxF73-qGnHQ8gzyh9NpCvBZJ12hseFa3_rQhA@mail.gmail.com>
Subject: Re: [v4,4/5] misc: fw_loader: introduce FIP loader driver
To: ansuelsmth@gmail.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peng Fan <peng.fan@nxp.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Justin Klaassen <justin@tidylabs.net>,
 Harsha Vardhan V M <h-vm@ti.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
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

Hi Christian,

On 2026-03-31T07:53:19, Christian Marangi <ansuelsmth@gmail.com> wrote:
> misc: fw_loader: introduce FIP loader driver
> misc: fw_loader: introduce FIP loader driver
>
> Introduce a variant of the FS loader driver to extract images from FIP
> image. These image can contain additional binary used to init Network
> accellerator or PHY firmware blob.
>
> The way FIP handle image type is with the usage of UUID.
>
> This FIP loader driver implement a simple FIP image parser that check
> every entry for a matching UUID.
>
> Similar to FS loader, this driver also support both UBI and Block
> devices.
>
> Also an additional property is added to handle special case with eMMC
> that doesn't have a GPT partition and require a global offset to
> reference the FIP partition.
>
> An example usage of this driver is the following:
> [...]

> diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
> @@ -0,0 +1,547 @@
> +#define MIN(a, b) ((a) < (b) ? (a) : (b))

Please can you use the existing min() macro from linux/kernel.h rather
than defining your own?

> diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
> @@ -0,0 +1,547 @@
> +static int blk_parse_fip_firmware(struct firmware *firmwarep,
> +                               struct blk_desc *desc,
> +                               struct disk_partition *part_info,
> +                               unsigned int part_offset,
> +                               struct fip_toc_entry *dent)
> +{
> +     unsigned int offset = part_info->start + part_offset;
> +     struct fip_toc_header hdr;
> +     struct fip_toc_entry ent;
> +     struct uuid uuid;
> +     unsigned int pos;
> +     char *read_buf;
> +     int ret;
> +
> +     /* Allocate a Scratch Buffer for FIP parsing */
> +     read_buf = malloc(desc->blksz);
> +     if (!read_buf)
> +             return -ENOMEM;
> +
> +     pos = blk_read_fip_toc_header(desc, offset, read_buf, &hdr);
> +     if (pos < 0) {

This check will never be true since pos is unsigned but
blk_read_fip_toc_header() returns int. Either change pos to int or use
a separate variable to capture the return value and check for errors
before assigning to pos.

> diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
> @@ -0,0 +1,547 @@
> +#include <fs_loader.h>

I suspect this include is not needed - the driver uses fw_loader.h
which is already pulled in via internal.h ?

> misc: fw_loader: introduce FIP loader driver

>
> These image can contain additional binary used to init Network
> accellerator or PHY firmware blob.

Typo: "accellerator" should be "accelerator".

Regards,
Simon
