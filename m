Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F029ECD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 04:39:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70664846F8;
	Wed, 27 May 2026 06:39:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AgpnFSDm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87131846F8; Wed, 27 May 2026 06:39:21 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93D9D80433
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 06:39:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-bd9a71b565aso1323738066b.0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 21:39:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779856758; cv=none;
 d=google.com; s=arc-20240605;
 b=NM0yEhbvMory/eIL/iDrng0MjA8NKbcuw+1hTTuq4w6bqOUQp66LKaUenqBZayupKa
 DgKoQricp78Q9IUCSR6arqV2eTesPDCSAzv5LZrd3SmrgMyXNlamruLDOrPS/bMe/TuI
 nyfVT1CG4NKELVEpgdvTmGjsJrmxUZqLP6KWs0DkwgX5GFuYB1u/1Em5GQjY5SyO5FZG
 83YcdtpWTqMDU3CnTq6td6IJhR3IjQZntufrQViLKao/cZfZc5CKupLYzUoIvZ0NwPpK
 ONKKoQKa0cggjWfwKfsmZ4R7SBgPpk25CgIlMEUx8XfP8KZM2o1l9I0ZTvMVb/GFbNmo
 EfqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VNyA1d9+r6xt9Qa9Zajc3I+hoxDDw/oGYQz9C34wa8s=;
 fh=nqXbri/t605KwzaYj6FnepUyH8OpYdQ47z347Vj1Qjo=;
 b=XahFAZz9q8LUeydYR6RyFRD6uDeHDjchi/QHjBveHnx52PRgOAjnaD3kbPBlpILOI5
 PapjHes536Hkos5XENxi1yhV7jCOzzYptIF91n0bRsePxm4Yq5i4z2zeD/SWpLHt30oo
 AvlJoAP7vAJcIQVEoRohfK1szKBoao2LIgqQ+hgmbiRKBFdEnSfjck3xMhWU8M9LvEm4
 +orjNFhRVBm+0KHRiA7hEhUPTt9EyBmUokNw601Du8Kqha19dm86ka/aao9L6B/qwiJ/
 vH4YflWBSqKkcDg2X/KbS2ZQ4zhRDW1r9aRZXBdSsL7wG4J4l564Unz9Bcb8J35kyoR3
 LCdw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779856758; x=1780461558; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VNyA1d9+r6xt9Qa9Zajc3I+hoxDDw/oGYQz9C34wa8s=;
 b=AgpnFSDmHM/TH0XKrcYff15ssnmX59btZHy24zpmg5AP+ujLNB5bRHYLFOrT7a+PfW
 bDxToTqqhFFEo1Z8rNXlhpqhlbR2XYe2TLnM0SiEtVmP68kUsuSmR9J1OFIQXguT3guy
 uhorUZV8coQSGuJyI/LC3WoRrdLNoPi/7R6xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779856758; x=1780461558;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VNyA1d9+r6xt9Qa9Zajc3I+hoxDDw/oGYQz9C34wa8s=;
 b=Cs3wwU1JmKhP6OYSRqpsfoFWbAUo3tL8qOuq/ZS8k67L+YVgnrCXRzQeYWqZO51rkJ
 R0ZW4ts1pne74xU+yfZoWt/Kqk06AkL1ujrjfjoP3Lbps+o3oPsa3q9aEBajG2zdMfy0
 Xm8juN6o2Mc1ncpR/EfdmvsTgFlBXFzqMfzPjxLirnm8zq0akugwPxOVMS/pPBgLbgor
 QhrWCPKX1/Nl9pL8BFUv1L+vE0J4wfakMtLWYRELPySBEgi1Cd8Zn2wvow5GlO4ri7Rc
 y2TBxvdBFii6LaywHT/LpehgLhyYfR7tw7AVNiu0o2qgiGtzSCnboUTej2d44bgXYhEN
 aDOA==
X-Gm-Message-State: AOJu0YwjCepADVc0h0IOnL2z2m7Uinvb4G9m6rQu1vaXQ2biMFyZoup/
 Ibt413YqH/OrtJ3jh59TuxkoS1eaWItJo1J/5QfDGpD8sZzEXRluqFO6vb6MSnAOqzEVQoLLggG
 G+BdbhmdHXxai8YmTcvB/Mg745qh00JuaIj1x5+hM
X-Gm-Gg: Acq92OE+B70/mU9RmajdACa/c6hN6bZmiuLY/l5eR+NHjaHi/b5Zwl14gmFtPxnDiCo
 /UxXe87MXs0z6BPwpxGKjGpL9U9Zx14ezuBBcoMGKmQw8xmJ56QOax7VtSZVCFTpKFZPNJE0RbT
 DyYH319R3xHlzqSyjXsGg9cz/hoDqEDNjeCgDB0/m6rg3tX+D8ICoVPq+uFeV7/UGR/BAd+LW6K
 SS7hH4mATWHNIqZxyzfBr3taNxWU+ZrDeR50woeFkVPThLE436E9Dr1mA5GenFrMUBP34Yf0qs1
 5OwBiGFmSiG+gao+aeXl4WshuSc=
X-Received: by 2002:a17:906:7316:b0:bd8:f4e0:35f2 with SMTP id
 a640c23a62f3a-bdd2580c4d4mr1154066266b.25.1779856757931; Tue, 26 May 2026
 21:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260213112717.1256823-1-aswin.murugan@oss.qualcomm.com>
 <20260213112717.1256823-4-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260213112717.1256823-4-aswin.murugan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 May 2026 23:39:05 -0500
X-Gm-Features: AVHnY4I8DpBtOhBKsxLBh6fWQI-ZzEsuHCJkzB0Y4C2v7QXIUbXPMdnupO4OxD0
Message-ID: <CAFLszTi+o-iTcLu8KqHTL4z=v+8SM2xU5B7SBBjTU4tjOHOdGQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] misc: qcom: Add Qualcomm SPMI SDAM NVMEM driver
To: aswin.murugan@oss.qualcomm.com
Cc: u-boot@lists.denx.de, sumit.garg@kernel.org, casey.connolly@linaro.org, 
 u-boot-qcom@groups.io, seanga2@gmail.com, trini@konsulko.com, 
 marek.vasut+renesas@mailbox.org, neil.armstrong@linaro.org, peng.fan@nxp.com, 
 quentin.schulz@cherry.de, n-francis@ti.com, xypron.glpk@gmx.de, h-vm@ti.com, 
 justin@tidylabs.net, jamie.gibbons@microchip.com, ycliang@andestech.com, 
 me@samcday.com, sughosh.ganu@arm.com, gchan9527@gmail.com, 
 ilias.apalodimas@linaro.org
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

Hi Aswin,

On 2026-02-13T11:27:11, Aswin Murugan <aswin.murugan@oss.qualcomm.com> wrote:
> misc: qcom: Add Qualcomm SPMI SDAM NVMEM driver
>
> Qualcomm PMICs include SDAM (Shared Direct Access Memory) regions which
> are used to store persistent data like reboot reasons that must survive
> across reboots.
>
> Without this driver, U-Boot cannot access PMIC storage, preventing
> reboot-to-bootloader functionality and other features that rely on
> persistent state.
>
> Add qcom-spmi-sdam driver that:
> - Probes SDAM regions from device tree compatible 'qcom,spmi-sdam'
> - Implements NVMEM provider interface for standard cell-based access
> - Uses SPMI register read/write operations for data access
>
> This enables reboot-mode and other subsystems to access PMIC storage
> through standard NVMEM APIs.
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>
> drivers/misc/Kconfig          |   8 ++
>  drivers/misc/Makefile         |   1 +
>  drivers/misc/qcom-spmi-sdam.c | 200 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 209 insertions(+)

> diff --git a/drivers/misc/qcom-spmi-sdam.c b/drivers/misc/qcom-spmi-sdam.c
> @@ -0,0 +1,200 @@
> +struct qcom_sdam_priv {
> +     u32 base;
> +     u32 size;
> +     u32 pmic_usid;
> +     struct udevice *spmi_dev;
> +};

For base can you use ulong or fdt_addr_t ? The u32 will truncate the
FDT_ADDR_T_NONE check below.

> diff --git a/drivers/misc/qcom-spmi-sdam.c b/drivers/misc/qcom-spmi-sdam.c
> @@ -0,0 +1,200 @@
> +     *spmi_dev = pmic_dev->parent;
> +     if (!*spmi_dev || (*spmi_dev)->uclass->uc_drv->id != UCLASS_SPMI) {
> +             dev_err(dev, "Could not find SPMI controller\n");
> +             return -ENODEV;
> +     }

Please use device_get_uclass_id(*spmi_dev) rather than reaching into
uclass/uc_drv internals.

> diff --git a/drivers/misc/qcom-spmi-sdam.c b/drivers/misc/qcom-spmi-sdam.c
> @@ -0,0 +1,200 @@
> +/**
> + * qcom_sdam_probe() - Probe SDAM device and register as NVMEM provider
> + * @dev: SDAM device
> + *
> + * Handles both real SDAM blocks and virtual NVMEM under PON blocks.
> + * For virtual NVMEM, adds the parent PON base address to the offset.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int qcom_sdam_probe(struct udevice *dev)

The kerneldoc is misleading. Nothing here registers an NVMEM provider
- the NVMEM core picks the device up via UCLASS_MISC. And there's no
code that adds the parent PON base address to the offset; priv->base
is whatever dev_read_addr() returns. Please trim to match the code.

> diff --git a/drivers/misc/qcom-spmi-sdam.c b/drivers/misc/qcom-spmi-sdam.c
> @@ -0,0 +1,200 @@
> +     priv->size = dev_read_u32_default(dev, 'qcom,sdam-size', SDAM_SIZE);

Can you check the binding for qcom,spmi-sdam ? I don't see
'qcom,sdam-size' - so instead you should use
dev_read_addr_size_index() so size comes from 'reg'

> diff --git a/drivers/misc/qcom-spmi-sdam.c b/drivers/misc/qcom-spmi-sdam.c
> @@ -0,0 +1,200 @@
> +     for (size_t i = 0; i < size; i++) {
> +             u32 reg = priv->base + offset + i;
> +
> +             ret = spmi_reg_read(priv->spmi_dev, priv->pmic_usid,
> +                                 (reg & PID_MASK) >> PID_SHIFT,
> +                                 reg & REG_MASK);

For later consideration: if reading a lot of bytes, can we use a burst read?

Declarations should be at the top of the function...also best to use
int for the loop var, to match 'size'.

> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> @@ -93,6 +93,14 @@ config QCOM_GENI
> +config QCOM_SPMI_SDAM
> +     bool "Qualcomm SPMI SDAM NVMEM driver"
> +     depends on MISC && NVMEM && SPMI
> +     help
> +       Enable support for Qualcomm SPMI SDAM (Shared Direct Access Memory) blocks
> +       as NVMEM providers. This driver support accessing SDAM blocks in PMICs
> +       for reboot reason functionality and other NVMEM use cases.

'driver support' should be 'driver supports'

Check the help text fits in 80 columns.

With these:
Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
