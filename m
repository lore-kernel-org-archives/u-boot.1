Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF9BCF9C59
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 16:04:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49FEA88D54;
	Fri, 20 Sep 2024 18:02:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FI4GInMQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C81FC88902; Fri, 20 Sep 2024 18:02:07 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BA5188D50
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 18:02:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-718e285544fso1633486b3a.1
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726848118; x=1727452918; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MXFCZSozvj2QvCofrLvV5YqoHEFFVK1gmfigceDH+ew=;
 b=FI4GInMQHyAHVLUnktvZGr9xzRZxlL78hXatsqbsoa25tmzD3JoH5DRKMdkjZjTIGf
 BRULKGCWUmHgfXDRVHGHRX8AeMDrgv0m7qiW3u9Bss0+CCDJWqMBWC7828EHK6+0eP9d
 QGE7DE8f6NJ64/jBgZqycOd8zaTq09Tg/YZsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726848118; x=1727452918;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MXFCZSozvj2QvCofrLvV5YqoHEFFVK1gmfigceDH+ew=;
 b=ecQfSKHysb8nKWD7xCmwN1CH8PHxNbtaNy29XEfDFvvhSM779V0ZIf+CNisTTuhQFs
 s5Rd1dYlLHd5+7L3PjJq/7KGQJhOnLpFBSFgdz2pkPpU1j5NWF8M0c3NlfErRxN3eYHx
 5jv+0crihnN9Qw/bV2d7jD4WHBogIHGcjsyDWCxW1X1EbcMTYEGS/jgvszaqn+pVjnmh
 QnGXDFoXNlab7LyaiGs0OvMBg1rac3sUKjc97A5FzimmHat4NoCCpXMF+HfLrFqSYN/0
 Zo+01kHjI/jVgMp3+DFSNvliJmhWaa5vU+7FRg96codmymxzy+/cDlugM1Sjt+Y06Jo/
 ySwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8b0a8pflOSdx/kshgSu8O2iimI3xNau8h+vQgGxDCY/Dj5SkyCElPcl+fEX47tQtJ7jXnB98=@lists.denx.de
X-Gm-Message-State: AOJu0Yz08mAWzlkvvSg/0MOfFaA0jxd1uEULs3rUuvmRKPaI6RtbicfH
 nV+2e/7YWs3J0QmY3CBqXe2A6pBYy5qX8z8BKNndOJaYJRKxVPSnpp6CAfdvim6SK7JqsfF0isB
 TyQBKUS1DdaHGWtuMlh33PWpK6AFTO64ZIN2h
X-Google-Smtp-Source: AGHT+IGCm7sMD35cODxS5eciu+yi2DKVGKlN1WQ13aTXw8BDVzR0Kz0C9JSil2LleZyBUC6qLMQ3R6WaRCYqX9H3988=
X-Received: by 2002:a05:6a00:218a:b0:717:9120:35f with SMTP id
 d2e1a72fcca58-7199ca384f6mr4791533b3a.27.1726848116594; Fri, 20 Sep 2024
 09:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240902053326.3273410-1-chiawei_wang@aspeedtech.com>
 <20240902053326.3273410-5-chiawei_wang@aspeedtech.com>
In-Reply-To: <20240902053326.3273410-5-chiawei_wang@aspeedtech.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 18:01:44 +0200
Message-ID: <CAFLszTibYO==h-ehoOsKpp8aSH49F2fxoVjn2=2AR1+3jBv0Kw@mail.gmail.com>
Subject: Re: [PATCH 4/4] drivers/crypto: aspeed: Add Caliptra ECDSA384 support
To: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: trini@konsulko.com, bob.wolff68@gmail.com, u-boot@lists.denx.de
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

On Mon, 2 Sept 2024 at 07:33, Chia-Wei Wang <chiawei_wang@aspeedtech.com> wrote:
>
> Aspeed AST27xx SoCs integrate the CPTRA 1.0 secure IP, which export
> an ECDSA384_SIGNATURE_VERIFY mailbox command service for SoC to use.
>
> This patch is verified by the FIT signature verification using the
> "sha384,ecdsa384" algorithm.
>
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  drivers/crypto/aspeed/Kconfig       |  10 ++
>  drivers/crypto/aspeed/Makefile      |   1 +
>  drivers/crypto/aspeed/cptra_ecdsa.c | 187 ++++++++++++++++++++++++++++
>  3 files changed, 198 insertions(+)
>  create mode 100644 drivers/crypto/aspeed/cptra_ecdsa.c

Reviewed-by: Simon Glass <sjg@chromium.org>

Qs below

>
> diff --git a/drivers/crypto/aspeed/Kconfig b/drivers/crypto/aspeed/Kconfig
> index 9bf317177aa..19fbe983888 100644
> --- a/drivers/crypto/aspeed/Kconfig
> +++ b/drivers/crypto/aspeed/Kconfig
> @@ -18,3 +18,13 @@ config ASPEED_ACRY
>
>          Enabling this allows the use of RSA/ECC operations in hardware without requiring the
>          software implementations. It also improves performance and saves code size.
> +
> +config ASPEED_CPTRA_ECDSA
> +       bool "Caliptra ECDSA384 signature verifier for Aspeed SoCs"
> +       depends on ECDSA_VERIFY || SPL_ECDSA_VERIFY
> +       help
> +         Select this option to enable a driver for using the ECDSA384_SIGNATURE_VERIFY
> +         feature of Caliptra, which is integrated in AST27xx BMC SoCs.
> +
> +         Enabling this allows the use of ECDSA384 signature verification in hardware.
> +         Note that only ECDSA384 is supported by Caliptra.
> diff --git a/drivers/crypto/aspeed/Makefile b/drivers/crypto/aspeed/Makefile
> index 58b55fc46e4..3ca5e829412 100644
> --- a/drivers/crypto/aspeed/Makefile
> +++ b/drivers/crypto/aspeed/Makefile
> @@ -1,2 +1,3 @@
>  obj-$(CONFIG_ASPEED_HACE) += aspeed_hace.o
>  obj-$(CONFIG_ASPEED_ACRY) += aspeed_acry.o
> +obj-$(CONFIG_ASPEED_CPTRA_ECDSA) += cptra_ecdsa.o
> diff --git a/drivers/crypto/aspeed/cptra_ecdsa.c b/drivers/crypto/aspeed/cptra_ecdsa.c
> new file mode 100644
> index 00000000000..aae14ca55aa
> --- /dev/null
> +++ b/drivers/crypto/aspeed/cptra_ecdsa.c
> @@ -0,0 +1,187 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2024 ASPEED Technology Inc.
> + */
> +#include <asm/io.h>
> +#include <config.h>
> +#include <crypto/ecdsa-uclass.h>
> +#include <dm.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/iopoll.h>
> +#include <malloc.h>
> +#include <u-boot/ecdsa.h>
> +
> +/* SCU register offsets */
> +#define SCU1_CPTRA                             0x130
> +#define   SCU1_CPTRA_RDY_FOR_RT        BIT(18)
> +
> +/* CPTRA MBOX register offsets */
> +#define CPTRA_MBOX_LOCK                        0x00
> +#define CPTRA_MBOX_USER                        0x04
> +#define CPTRA_MBOX_CMD                 0x08
> +#define CPTRA_MBOX_DLEN                        0x0c
> +#define CPTRA_MBOX_DATAIN              0x10
> +#define CPTRA_MBOX_DATAOUT             0x14
> +#define CPTRA_MBOX_EXEC                        0x18
> +#define CPTRA_MBOX_STS                 0x1c
> +#define   CPTRA_MBOX_STS_SOC_LOCK      BIT(9)
> +#define   CPTRA_MBOX_STS_FSM_PS                GENMASK(8, 6)
> +#define   CPTRA_MBOX_STS_PS            GENMASK(3, 0)
> +#define CPTRA_MBOX_UNLOCK              0x20
> +
> +#define CPTRA_ECDSA_SIG_LEN    96      /* ECDSA384 */
> +#define CPTRA_ECDSA_SHA_LEN    48      /* SHA384 */
> +
> +#define CPTRA_MBCMD_ECDSA384_SIGNATURE_VERIFY  0x53494756
> +
> +enum cptra_mbox_sts {
> +       CPTRA_MBSTS_CMD_BUSY,
> +       CPTRA_MBSTS_DATA_READY,
> +       CPTRA_MBSTS_CMD_COMPLETE,
> +       CPTRA_MBSTS_CMD_FAILURE,
> +};
> +
> +enum cptra_mbox_fsm {
> +       CPTRA_MBFSM_IDLE,
> +       CPTRA_MBFSM_RDY_FOR_CMD,
> +       CPTRA_MBFSM_RDY_FOR_DLEN,
> +       CPTRA_MBFSM_RDY_FOR_DATA,
> +       CPTRA_MBFSM_EXEC_UC,
> +       CPTRA_MBFSM_EXEC_SOC,
> +       CPTRA_MBFSM_ERROR,
> +};
> +
> +struct cptra_ecdsa {
> +       void *regs;
> +};
> +
> +static uint32_t mbox_csum(uint32_t csum, uint8_t *data, uint32_t dlen)
> +{
> +       uint32_t i;
> +
> +       if (!data)
> +               return csum;

do we need those two lines?

> +
> +       for (i = 0; i < dlen; ++i)
> +               csum -= data[i];
> +
> +       return csum;
> +}
> +
> +static int cptra_ecdsa_verify(struct udevice *dev, const struct ecdsa_public_key *pubkey,
> +                             const void *hash, size_t hash_len,
> +                             const void *signature, size_t sig_len)
> +{
> +       struct cptra_ecdsa *ce;
> +       uint8_t *x, *y, *r, *s;
> +       uint32_t cmd, csum;
> +       uint32_t reg, sts;
> +       uint32_t *p32;
> +       int i;
> +
> +       if (hash_len != CPTRA_ECDSA_SHA_LEN || sig_len != CPTRA_ECDSA_SIG_LEN)
> +               return -EINVAL;
> +
> +       if ((strcmp(pubkey->curve_name, "secp384r1") && strcmp(pubkey->curve_name, "prime384v1")) ||
> +           pubkey->size_bits != ((CPTRA_ECDSA_SIG_LEN / 2) << 3))
> +               return -EINVAL;
> +
> +       ce = dev_get_priv(dev);
> +
> +       /* get CPTRA MBOX lock */
> +       if (readl_poll_timeout(ce->regs + CPTRA_MBOX_LOCK, reg, reg == 0, 1000000))
> +               return -EBUSY;
> +
> +       /* check MBOX is ready for command */
> +       sts = readl(ce->regs + CPTRA_MBOX_STS);
> +       if (FIELD_GET(CPTRA_MBOX_STS_FSM_PS, sts) != CPTRA_MBFSM_RDY_FOR_CMD)
> +               return -EACCES;
> +
> +       /* init mbox parameters */
> +       cmd = CPTRA_MBCMD_ECDSA384_SIGNATURE_VERIFY;
> +       csum = 0;
> +       x = (uint8_t *)pubkey->x;
> +       y = (uint8_t *)pubkey->y;
> +       r = (uint8_t *)signature;
> +       s = (uint8_t *)signature + (CPTRA_ECDSA_SIG_LEN / 2);
> +
> +       /* calculate checksum */
> +       csum = mbox_csum(csum, (uint8_t *)&cmd, sizeof(cmd));
> +       csum = mbox_csum(csum, x, CPTRA_ECDSA_SIG_LEN / 2);
> +       csum = mbox_csum(csum, y, CPTRA_ECDSA_SIG_LEN / 2);
> +       csum = mbox_csum(csum, r, CPTRA_ECDSA_SIG_LEN / 2);
> +       csum = mbox_csum(csum, s, CPTRA_ECDSA_SIG_LEN / 2);
> +
> +       /* write command, data length */
> +       writel(cmd, ce->regs + CPTRA_MBOX_CMD);
> +       writel(sizeof(csum) + (CPTRA_ECDSA_SIG_LEN << 1), ce->regs + CPTRA_MBOX_DLEN);
> +
> +       /* write ECDSA384_SIGNATURE_VERIFY command parameters */
> +       writel(csum, ce->regs + CPTRA_MBOX_DATAIN);
> +
> +       for (i = 0, p32 = (uint32_t *)x; i < ((CPTRA_ECDSA_SIG_LEN / 2) / sizeof(*p32)); ++i)
> +               writel(p32[i], ce->regs + CPTRA_MBOX_DATAIN);
> +
> +       for (i = 0, p32 = (uint32_t *)y; i < ((CPTRA_ECDSA_SIG_LEN / 2) / sizeof(*p32)); ++i)
> +               writel(p32[i], ce->regs + CPTRA_MBOX_DATAIN);
> +
> +       for (i = 0, p32 = (uint32_t *)r; i < ((CPTRA_ECDSA_SIG_LEN / 2) / sizeof(*p32)); ++i)
> +               writel(p32[i], ce->regs + CPTRA_MBOX_DATAIN);
> +
> +       for (i = 0, p32 = (uint32_t *)s; i < ((CPTRA_ECDSA_SIG_LEN / 2) / sizeof(*p32)); ++i)
> +               writel(p32[i], ce->regs + CPTRA_MBOX_DATAIN);
> +
> +       /* trigger mbox command */
> +       writel(0x1, ce->regs + CPTRA_MBOX_EXEC);
> +
> +       /* poll for result */
> +       while (1) {
> +               sts = FIELD_GET(CPTRA_MBOX_STS_PS, readl(ce->regs + CPTRA_MBOX_STS));
> +               if (sts != CPTRA_MBSTS_CMD_BUSY)
> +                       break;
> +       }
> +
> +       /* unlock mbox */
> +       writel(0x0, ce->regs + CPTRA_MBOX_EXEC);
> +
> +       return (sts == CPTRA_MBSTS_CMD_FAILURE) ? sts : 0;
> +}
> +
> +static int cptra_ecdsa_probe(struct udevice *dev)
> +{
> +       struct cptra_ecdsa *ce = dev_get_priv(dev);
> +
> +       ce->regs = (void *)devfdt_get_addr(dev);
> +       if (ce->regs == (void *)FDT_ADDR_T_NONE) {
> +               debug("cannot map Caliptra mailbox registers\n");
> +               return -ENODEV;

-EINVAL for devicetree issues. -ENODEV means there is no device

> +       }
> +
> +       return 0;
> +}
> +
> +static int cptra_ecdsa_remove(struct udevice *dev)
> +{
> +       return 0;
> +}
> +
> +static const struct ecdsa_ops cptra_ecdsa_ops = {
> +       .verify = cptra_ecdsa_verify,
> +};
> +
> +static const struct udevice_id cptra_ecdsa_ids[] = {
> +       { .compatible = "aspeed,ast2700-cptra-ecdsa" },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(aspeed_cptra_ecdsa) = {
> +       .name = "aspeed_cptra_ecdsa",
> +       .id = UCLASS_ECDSA,
> +       .of_match = cptra_ecdsa_ids,
> +       .ops = &cptra_ecdsa_ops,
> +       .probe = cptra_ecdsa_probe,
> +       .remove = cptra_ecdsa_remove,
> +       .priv_auto = sizeof(struct cptra_ecdsa),
> +       .flags = DM_FLAG_PRE_RELOC,

Do you actually need this before relocation?

> +};
> --
> 2.25.1
>

Regards,
Simon
