Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7436ED1D484
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 17:42:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE5CD8425F;
	Thu,  8 Jan 2026 18:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JjWL1fAF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B0B38421C; Thu,  8 Jan 2026 18:42:38 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17A968426C
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 18:42:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-29efd139227so26707755ad.1
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 09:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767894153; x=1768498953; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QjgYcOd/45PFfaTGAVSHrTZBsfeBnApzFqOlNl6Rx9Q=;
 b=JjWL1fAFUq2uM8qsoeUvtZArUlTDqZ1nS02ZfF/hUuuNa4ml/ONHrwraYYOUYyn/2F
 rPJRSJw1ValYQ+mdWZYNFmISZK0bdBQUVCmRVuLXbykeTwkE/n6cJaynXYUsDUSOIUZT
 AE0NW/G6x5KzMo5Fu+IJM3jSeXZNHvWk+Qjak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767894153; x=1768498953;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QjgYcOd/45PFfaTGAVSHrTZBsfeBnApzFqOlNl6Rx9Q=;
 b=uz/eROF07lVsX9jozebQnFyL72pkAnTl9MD0iLifjNrYCGjjTo0FzZ1MHZlmIN9aKW
 undv5XqtTpJWhrZokVLt2dOyvfa2QfHxMDIbX0aCkxBZ3LGGJqv4zEtA0WGf9ekkM1OX
 pO0VeXDt3Yx+At0mgvz5XFtl7PN5yJI9mJNeWL+1mkll+R1yMxM+UCARThR/M+wBzm8H
 CYmk11TXHIlEZMkf9/lqeVro6sjgMyVTEz7u4gIzLmeCDgxhpQeKOPoXDx3Y1+KH8N4A
 5Uj6OUj4L6+pZwX4oYYXdy6qdryOJO0eSDviXjIzJ7Ix31+7MLBYqFfabqwLrQZoR5rK
 y8Wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP5flD+rWzyeMnTUqOeTVyEReWgepKZnQV8ifXzBd72/165FqkJffKfSiUgIDwDQ5NvufAoaw=@lists.denx.de
X-Gm-Message-State: AOJu0YzROXdDEoXvhjU+WZ/z3shsACgBXyNlx+gONgkNfX3dlunccbK2
 w2Mi5FXrW6RRWyX7MZTlZ/pdSpm12IMSErixD/gNBmV0RHA9HQdpcIq/GE/cilQWAw0Ww7eXtAW
 gDe5lCpbrjtN/bWkmQxbPE2CkSkeUKp8ky4C+Q37x
X-Gm-Gg: AY/fxX4kgAoIut/KDIdYOA3uWNLjKLfMGdRoHm4/0z8X2gQ5M8oML/DoQ3o8VNLD8VY
 uAGrYZXSBrCZCY/jdAt2CR3rIdZPJw9/FYdwuv3ktD/QTB1b+/QwADyAMPn1kWL3eNZmnpyQstv
 uSpNBs4D3O5+wMZ1p96+UP+HMPNTju8pNh3AWGnyMA9JravcU5RVrjLkZN92CP3gWgnLJMnf2B1
 DP58zgbsDUGRhZxMMGCpHhaP4FX4KlDMDqu00R9nI2wft2euPpeH0MEcfIRYOnSR0Ky36HGgP4C
 z7fv
X-Google-Smtp-Source: AGHT+IFuonYo0h4+FM++HaaBLTs4tCRLgp1Hd/nPpWsIbDzLSMhRQIMCH0naqHQCbtjO37OmX2pyli+TL8QlovNRPXk=
X-Received: by 2002:a17:903:13ce:b0:295:560a:e499 with SMTP id
 d9443c01a7336-2a3ee43316amr63748935ad.5.1767894153543; Thu, 08 Jan 2026
 09:42:33 -0800 (PST)
MIME-Version: 1.0
References: <20260108101721.3411854-1-balaji.selvanathan@oss.qualcomm.com>
 <20260108101721.3411854-2-balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260108101721.3411854-2-balaji.selvanathan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 8 Jan 2026 10:42:01 -0700
X-Gm-Features: AQt7F2rJy0JATTTaSrnb7KK7OQYHCCp6nnPOZh7tGdVG1TGlvYBj8fCQbDSZqvk
Message-ID: <CAFLszThHG=mwX4gpC5b-2c+jagLb1NmXKCP-U-dPMoROk3+93g@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] soc: qcom: rpmh-rsc: Clear TCS state before kernel
 boot
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, me@samcday.com, sughosh.ganu@linaro.org, 
 gchan9527@gmail.com, aswin.murugan@oss.qualcomm.com, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
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

Hi Balaji,

On Thu, 8 Jan 2026 at 03:17, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
>
> Add cleanup mechanism to clear RPMH TCS hardware state before
> booting the kernel. Without this cleanup, leftover U-Boot TCS
> configurations cause timeout errors during kernel RPMH driver
> initialization.
>
> The cleanup clears CMD_STATUS, CMD_WAIT_FOR_CMPL, CMD_ENABLE,
> CONTROL, and IRQ_STATUS registers for all TCS.
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/rpmh-rsc.c | 101 ++++++++++++++++++++++++++++++++++++
>  include/soc/qcom/rpmh.h     |   9 ++++
>  2 files changed, 110 insertions(+)
>
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index aee9e55194e..772be401f0d 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -471,6 +471,106 @@ static int rpmh_probe_tcs_config(struct udevice *dev, struct rsc_drv *drv)
>         return 0;
>  }
>
> +/**
> + * rpmh_rsc_clear_tcs() - Clear TCS state before kernel handoff
> + * @drv: The RSC controller
> + *
> + * Clears all TCS hardware state to ensure kernel starts with clean state.
> + * This prevents timeout errors during kernel RPMH initialization by clearing:
> + * - CMD_STATUS: Leftover ISSUED/COMPLETED flags
> + * - CMD_WAIT_FOR_CMPL: Completion wait configuration
> + * - CMD_ENABLE: Command slot enables
> + * - CONTROL: AMC mode bits
> + * - IRQ_STATUS: Pending interrupts
> + */
> +static void rpmh_rsc_clear_tcs(struct rsc_drv *drv)
> +{
> +       int i, j, ncpt, pending_cmds = 0;
> +       u32 status, irq_status;
> +
> +       ncpt = drv->tcs[ACTIVE_TCS].ncpt;
> +
> +       for (i = 0; i < drv->num_tcs; i++) {
> +               for (j = 0; j < ncpt; j++) {
> +                       status = read_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_STATUS], i, j);
> +                       if (status)
> +                               pending_cmds++;
> +               }
> +
> +               /* Clear completion wait, command enable, and control registers */
> +               write_tcs_reg(drv, drv->regs[RSC_DRV_CMD_WAIT_FOR_CMPL], i, 0);
> +               write_tcs_reg(drv, drv->regs[RSC_DRV_CMD_ENABLE], i, 0);
> +               write_tcs_reg(drv, drv->regs[RSC_DRV_CONTROL], i, 0);
> +       }
> +
> +       /* Clear any pending IRQ status */
> +       irq_status = readl(drv->tcs_base + drv->regs[RSC_DRV_IRQ_STATUS]);
> +       if (irq_status)
> +               writel(irq_status, drv->tcs_base + drv->regs[RSC_DRV_IRQ_CLEAR]);
> +
> +       log_debug("RPMH: Cleared %d TCS for %s (pending: %d cmds, IRQ: 0x%x)\n",
> +                 drv->num_tcs, drv->name, pending_cmds, irq_status);
> +}
> +
> +/**
> + * rpmh_rsc_cleanup_all() - Public function to cleanup all RPMH controllers
> + *
> + * This function should be called before booting the kernel to ensure all
> + * RPMH controllers have clean TCS state. Can be called from board_quiesce_devices()
> + * or directly before kernel boot.
> + */
> +void rpmh_rsc_cleanup_all(void)
> +{
> +       struct udevice *dev;
> +       struct uclass *uc;
> +       int ret, count = 0;
> +
> +       ret = uclass_get(UCLASS_MISC, &uc);
> +       if (ret) {
> +               log_err("RPMH: Failed to get MISC uclass: %d\n", ret);
> +               return;
> +       }
> +
> +       uclass_foreach_dev(dev, uc) {
> +               if (device_is_compatible(dev, "qcom,rpmh-rsc")) {
> +                       struct rsc_drv *drv = dev_get_priv(dev);
> +
> +                       if (drv && drv->num_tcs > 0) {
> +                               rpmh_rsc_clear_tcs(drv);
> +                               count++;
> +                       }
> +               }
> +       }
> +
> +       if (count > 0)
> +               log_debug("RPMH: Cleaned up %d controller(s)\n", count);
> +       else
> +               log_warning("RPMH: No controllers found to clean up\n");
> +}
> +
> +/**
> + * rpmh_rsc_remove() - Cleanup before handing off to kernel
> + * @dev: The device
> + *
> + * Called before booting kernel to ensure clean TCS state. This prevents
> + * kernel RPMH driver from encountering busy/configured TCS that could
> + * cause timeout errors during initialization.
> + *
> + * Return: 0 on success
> + */
> +static int rpmh_rsc_remove(struct udevice *dev)
> +{
> +       struct rsc_drv *drv = dev_get_priv(dev);
> +
> +       if (!drv)
> +               return 0;
> +
> +       /* Clear all TCS configurations to provide clean state for kernel */
> +       rpmh_rsc_clear_tcs(drv);
> +
> +       return 0;
> +}
> +
>  static int rpmh_rsc_probe(struct udevice *dev)
>  {
>         ofnode dn = dev_ofnode(dev);
> @@ -539,6 +639,7 @@ U_BOOT_DRIVER(qcom_rpmh_rsc) = {
>         .id             = UCLASS_MISC,
>         .priv_auto      = sizeof(struct rsc_drv),
>         .probe          = rpmh_rsc_probe,
> +       .remove         = rpmh_rsc_remove,
>         .of_match       = qcom_rpmh_ids,
>         /* rpmh is under CLUSTER_PD which we don't support, so skip trying to enable PDs */
>         .flags          = DM_FLAG_DEFAULT_PD_CTRL_OFF,

add DM_REMOVE_OS_PREPARE in there too so it will cleanup

> diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
> index 3421fbf1ee3..da3b1517392 100644
> --- a/include/soc/qcom/rpmh.h
> +++ b/include/soc/qcom/rpmh.h
> @@ -25,4 +25,13 @@ static inline int rpmh_write(const struct device *dev, enum rpmh_state state,
>  /* u-boot: no multithreading */
>  #define rpmh_write_async(dev, state, cmd, n) rpmh_write(dev, state, cmd, n)
>
> +/**
> + * rpmh_rsc_cleanup_all() - Cleanup all RPMH controllers before kernel boot
> + *
> + * This function clears TCS (Trigger Command Set) hardware state for all
> + * RPMH controllers to ensure the kernel starts with clean state. Should
> + * be called from board_quiesce_devices() before booting the kernel.
> + */
> +void rpmh_rsc_cleanup_all(void);

I'm not sure who calls this, but each device will be removed before
booting if you use the DM_REMOVE_OS_PREPARE flag

> +
>  #endif /* __SOC_QCOM_RPMH_H__ */
> --
> 2.34.1
>

Regards,
Simon
