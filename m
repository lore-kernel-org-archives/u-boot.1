Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63E7C2FC27
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 13:42:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D01286B64;
	Thu, 17 Aug 2023 15:42:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="STnBNbRg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B4E286B65; Thu, 17 Aug 2023 15:42:11 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC1D686B63
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 15:42:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-99c353a395cso1041593866b.2
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 06:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692279728; x=1692884528;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jERCba0q55cC43P+6a11T/7z3n9z/4NPvutr6InlFsc=;
 b=STnBNbRgE7vNZfMtfNgLtI7e835bxi97V47lC0UKc+r/NwVG7NFrqrEo2jqvAsXxPQ
 0XNvesqd1WNVm/huE7ZXhcIm3fBTQcIN4R9RZ730bVtY0QCtIDe++vnHJXjlJ4Sv4Slv
 Ew7OLaksfUNaVnFFxm/cXMEkWPdtoohx/tGQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692279728; x=1692884528;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jERCba0q55cC43P+6a11T/7z3n9z/4NPvutr6InlFsc=;
 b=P4NfWEZomyMz+lOly+fQS2TpOweSbsdcwYP7g41rMI2+QrhNxMKxb+4/aU/5LkpSJh
 WdB0PUmYKpLFqpRRobeVaeVyB4xMB8/E8NhbOrM7zi632iP6USvaL3R1G4Ov9PEoMDel
 l+2sN1A9g3mTxf22hFAdyokpk/ZDV1CSqDPy5D6M+Q9ComJA0XPI/JWoxMBg3QPJXdB7
 ow4IR+8A+siRVPDphDbiXyPrMQi+k1g/2ENlsvgLt+MbD9fUyEMHrfHL4W1ujwFUNLG9
 F+VsXlhwc/9S7zCKmACDU9DsxPJ7Xu+qh9VjuVl2GZ9RI3R3piChMqcn4SG4VhLGqWA3
 uZPw==
X-Gm-Message-State: AOJu0Yxny3ZXOJ7R+Uci+GquArX+SrPq0Jywf+kI3ddLeEBZlGOMZwht
 8gVjn347D4jIsBX0wSupuvLASgyhjXSQvfaIPfYQhqojB+XTYw/uRqQ=
X-Google-Smtp-Source: AGHT+IFX5SFySVirdwiubNOpQj5cj8htqCHA8sh0L37/z0pfg9fTCo5lCPqC8NCQfWI1h8RGyz3cE3aGpM1+fY2hCK4=
X-Received: by 2002:a17:907:709:b0:99c:6518:ce77 with SMTP id
 xb9-20020a170907070900b0099c6518ce77mr4605684ejb.54.1692279728209; Thu, 17
 Aug 2023 06:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230812002823.82576-1-seanedmond@linux.microsoft.com>
 <20230812002823.82576-3-seanedmond@linux.microsoft.com>
In-Reply-To: <20230812002823.82576-3-seanedmond@linux.microsoft.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Aug 2023 07:41:43 -0600
Message-ID: <CAPnjgZ0FoQeKi4BSE=5v8ur+Ybe1V6v5QiyQ7dwuSRMTG3nRiQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] drivers: security: Add TPM2 implementation of
 security devices
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, stcarlso@linux.microsoft.com, 
 ilias.apalodimas@linaro.org, abdellatif.elkhlifi@arm.com
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

Hi Sean,

On Fri, 11 Aug 2023 at 18:28, <seanedmond@linux.microsoft.com> wrote:
>
> From: Stephen Carlson <stcarlso@linux.microsoft.com>
>
> This implementation of the security uclass driver allows existing TPM2
> devices declared in the device tree to be referenced for storing the OS
> anti-rollback counter, using the TPM2 non-volatile storage API.
>
> Signed-off-by: Stephen Carlson <stcarlso@linux.microsoft.com>
> ---
>  MAINTAINERS                     |   1 +
>  drivers/security/Makefile       |   1 +
>  drivers/security/security-tpm.c | 173 ++++++++++++++++++++++++++++++++
>  include/tpm-v2.h                |   1 +
>  4 files changed, 176 insertions(+)
>  create mode 100644 drivers/security/security-tpm.c

This is a bit wonky w.r.t driver model. The TPM itself should
implement this API, perhaps ina separate file shared with all v2 TPMs.
You should not be opening the device, etc. in here.

I hope that makes sense...you effectively need to turn the TPM into a
multi-function device within driver model. Of course TPMs are
multi-function devices anyway, but here you are making their functions
available more explicitly with a nicer API.

Then you can call the TPM API to do what you want, but at least you
know that the TPM has been probed before you start.

Regards,
Simon



>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 73b6943e03..257660a847 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1444,6 +1444,7 @@ S:        Maintained
>  F:     drivers/security/Kconfig
>  F:     drivers/security/Makefile
>  F:     drivers/security/sandbox_security.c
> +F:     drivers/security/security-tpm.c
>  F:     drivers/security/security-uclass.c
>
>  SEMIHOSTING
> diff --git a/drivers/security/Makefile b/drivers/security/Makefile
> index ed10c3f234..e81966bb4a 100644
> --- a/drivers/security/Makefile
> +++ b/drivers/security/Makefile
> @@ -4,3 +4,4 @@
>
>  obj-$(CONFIG_DM_SECURITY) += security-uclass.o
>  obj-$(CONFIG_SECURITY_SANDBOX) += sandbox_security.o
> +obj-$(CONFIG_SECURITY_TPM) += security-tpm.o
> diff --git a/drivers/security/security-tpm.c b/drivers/security/security-tpm.c
> new file mode 100644
> index 0000000000..9070dd49ac
> --- /dev/null
> +++ b/drivers/security/security-tpm.c
> @@ -0,0 +1,173 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2021 Microsoft, Inc
> + * Written by Stephen Carlson <stcarlso@microsoft.com>
> + */
> +
> +#include <common.h>
> +#include <dm.h>
> +#include <fdtdec.h>
> +#include <dm-security.h>
> +#include <tpm-v2.h>
> +
> +struct security_state {
> +       u32 index_arbvn;
> +       struct udevice *tpm_dev;
> +};
> +
> +static int tpm_security_init(struct udevice *tpm_dev)
> +{
> +       int res;
> +
> +       /* Initialize TPM but allow reuse of existing session */
> +       res = tpm_open(tpm_dev);
> +       if (res == -EBUSY) {
> +               log(UCLASS_SECURITY, LOGL_DEBUG,
> +                   "Existing TPM session found, reusing\n");
> +       } else {
> +               if (res) {
> +                       log(UCLASS_SECURITY, LOGL_ERR,
> +                           "TPM initialization failed (ret=%d)\n", res);
> +                       return res;
> +               }
> +
> +               res = tpm2_startup(tpm_dev, TPM2_SU_CLEAR);
> +               if (res) {
> +                       log(UCLASS_SECURITY, LOGL_ERR,
> +                           "TPM startup failed (ret=%d)\n", res);
> +                       return res;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static int tpm_security_arbvn_get(struct udevice *dev, u64 *arbvn)
> +{
> +       struct security_state *priv = dev_get_priv(dev);
> +       int ret;
> +
> +       if (!arbvn)
> +               return -EINVAL;
> +
> +       ret = tpm2_nv_read_value(priv->tpm_dev, priv->index_arbvn, arbvn,
> +                                sizeof(u64));
> +       if (ret == TPM2_RC_NV_UNINITIALIZED) {
> +               /* Expected if no OS image has been loaded before */
> +               log(UCLASS_SECURITY, LOGL_INFO,
> +                   "No previous OS image, defaulting ARBVN to 0\n");
> +               *arbvn = 0ULL;
> +       } else if (ret) {
> +               log(UCLASS_SECURITY, LOGL_ERR,
> +                   "Unable to read ARBVN from TPM (ret=%d)\n", ret);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int tpm_security_arbvn_set(struct udevice *dev, u64 arbvn)
> +{
> +       struct security_state *priv = dev_get_priv(dev);
> +       struct udevice *tpm_dev = priv->tpm_dev;
> +       u64 old_arbvn;
> +       int ret;
> +
> +       ret = tpm_security_arbvn_get(dev, &old_arbvn);
> +       if (ret)
> +               return ret;
> +
> +       if (arbvn < old_arbvn)
> +               return -EPERM;
> +
> +       if (arbvn > old_arbvn) {
> +               ret = tpm2_nv_write_value(tpm_dev, priv->index_arbvn, &arbvn,
> +                                         sizeof(u64));
> +               if (ret) {
> +                       log(UCLASS_SECURITY, LOGL_ERR,
> +                           "Unable to write ARBVN to TPM (ret=%d)\n", ret);
> +                       return ret;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct dm_security_ops tpm_security_ops = {
> +       .arbvn_get              = tpm_security_arbvn_get,
> +       .arbvn_set              = tpm_security_arbvn_set,
> +};
> +
> +static int tpm_security_probe(struct udevice *dev)
> +{
> +       struct security_state *priv = dev_get_priv(dev);
> +       struct udevice *tpm_dev = priv->tpm_dev;
> +       u32 index = priv->index_arbvn;
> +       int ret;
> +
> +       if (!tpm_dev) {
> +               log(UCLASS_SECURITY, LOGL_ERR,
> +                   "TPM device not defined in DTS\n");
> +               return -EINVAL;
> +       }
> +
> +       ret = tpm_security_init(tpm_dev);
> +       if (ret)
> +               return ret;
> +
> +       ret = tpm2_nv_define_space(tpm_dev, index, sizeof(u64), TPMA_NV_PPREAD |
> +                                  TPMA_NV_PPWRITE | TPMA_NV_PLATFORMCREATE,
> +                                  NULL, 0);
> +       /* NV_DEFINED is an expected error if ARBVN already initialized */
> +       if (ret == TPM2_RC_NV_DEFINED)
> +               log(UCLASS_SECURITY, LOGL_DEBUG,
> +                   "ARBVN index %u already defined\n", index);
> +       else if (ret) {
> +               log(UCLASS_SECURITY, LOGL_ERR,
> +                   "Unable to create ARBVN NV index (ret=%d)\n", ret);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int tpm_security_remove(struct udevice *dev)
> +{
> +       struct security_state *priv = dev_get_priv(dev);
> +
> +       return tpm_close(priv->tpm_dev);
> +}
> +
> +static int tpm_security_ofdata_to_platdata(struct udevice *dev)
> +{
> +       const u32 phandle = (u32)dev_read_u32_default(dev, "tpm", 0);
> +       struct security_state *priv = dev_get_priv(dev);
> +       struct udevice *tpm_dev;
> +       int ret;
> +
> +       ret = uclass_get_device_by_phandle_id(UCLASS_TPM, phandle, &tpm_dev);
> +       if (ret) {
> +               log(UCLASS_SECURITY, LOGL_ERR, "TPM node in DTS is invalid\n");
> +               return ret;
> +       }
> +
> +       priv->index_arbvn = (u32)dev_read_u32_default(dev, "arbvn-nv-index", 0);
> +       priv->tpm_dev = tpm_dev;
> +       return 0;
> +}
> +
> +static const struct udevice_id tpm_security_ids[] = {
> +       { .compatible = "tpm,security" },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(security_tpm) = {
> +       .name   = "security_tpm",
> +       .id     = UCLASS_SECURITY,
> +       .priv_auto = sizeof(struct security_state),
> +       .of_match = tpm_security_ids,
> +       .of_to_plat = tpm_security_ofdata_to_platdata,
> +       .probe  = tpm_security_probe,
> +       .remove = tpm_security_remove,
> +       .ops    = &tpm_security_ops,
> +};
> diff --git a/include/tpm-v2.h b/include/tpm-v2.h
> index 2b6980e441..49bf0f0ba4 100644
> --- a/include/tpm-v2.h
> +++ b/include/tpm-v2.h
> @@ -321,6 +321,7 @@ enum tpm2_return_codes {
>         TPM2_RC_COMMAND_CODE    = TPM2_RC_VER1 + 0x0043,
>         TPM2_RC_AUTHSIZE        = TPM2_RC_VER1 + 0x0044,
>         TPM2_RC_AUTH_CONTEXT    = TPM2_RC_VER1 + 0x0045,
> +       TPM2_RC_NV_UNINITIALIZED        = TPM2_RC_VER1 + 0x04a,
>         TPM2_RC_NV_DEFINED      = TPM2_RC_VER1 + 0x004c,
>         TPM2_RC_NEEDS_TEST      = TPM2_RC_VER1 + 0x0053,
>         TPM2_RC_WARN            = 0x0900,
> --
> 2.40.0
>
