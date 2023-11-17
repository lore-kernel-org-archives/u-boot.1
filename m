Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219A6C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 05:52:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F2C686F67;
	Fri, 17 Nov 2023 06:52:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T4aUzXGx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FA9386F73; Fri, 17 Nov 2023 06:52:27 +0100 (CET)
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com
 [IPv6:2607:f8b0:4864:20::a31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E188686E37
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 06:52:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4af5ea40b7bso623868e0c.2
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 21:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700200343; x=1700805143; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UK0D/zMfr3lQXfUgNjlzo1Mm3N9ujP8ye5kdH2Q2NqU=;
 b=T4aUzXGxwTVhnG0DZ9i5EFMqFI5+OUURM+511gusXopxxBSP++l/0wMeuTAIxQlTkb
 PX2b6IO3zWaIxKP40IiHCuAx3cjfUPcFK9KjND1cNr0x90i5/b4HV2IgcnZbDJfhY9RZ
 GumHDjl8m1ozcq7s1as6a5zhxVElGcvRYW51OEwKunVa9CFq9qEl0qUBw7kP6PPpJXc7
 PKdO9kN6/Sh3cVEFBnm8op2BEsUM3tUuzDXKQBGn/dlHigRuWE8dO7auxO9jsDCZaEUr
 6/6k80d15EZEdygRGNF0xyTi/LH8mQplHhFXvzrtToAG8o9835mDfDpWcQ+rK6pwQYxK
 51SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700200343; x=1700805143;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UK0D/zMfr3lQXfUgNjlzo1Mm3N9ujP8ye5kdH2Q2NqU=;
 b=IwhFQuRHdRMfeUOl0sMreoWR+7AA+2u9UkUJ99BxCBiRXysob20IiuNhsld94ywK1G
 Mlvh5AY2MplPp5vUeeWn4+R9jmaomoBeBDItuU7fBXpN3eIFGvdor0gOewADrdgZJNtn
 8DasvhI4pcDSW94UpnIM5zhq5P5i/LXj2RYZw4wXYAEU1T4npFa/L9BmRAAKN5q6IhDk
 Io5GqIrLNtg1G1wfTqIn/8Kok8xQq0GetFXFtsD14fiTXdcgCoTIPJtU2MdppUizoSHZ
 WX6Fl+mI4PfNixuhD9omPFPUjhvi7OrHdmURYwYbnDiR/aoEHoMgTEdK5bQ71GHIniqN
 KTLA==
X-Gm-Message-State: AOJu0YxgGhJrXDkn+oF8g2pW2qyNlk5heKa8bH7LYLOScqgArHc13XEr
 U6UuYAqdHVeBYjXY4gNZmy7f4nrZ12kK1uxIaXNxDg==
X-Google-Smtp-Source: AGHT+IGMB7eJ2kVY2BQ47kzMydbPXHSFRYZ6/pXhsonk/45H/sHh9CZYZDXjJm0GSCO7RnkklNsqJi//WaxGUEl2eyo=
X-Received: by 2002:a05:6122:922:b0:4ac:462b:7417 with SMTP id
 j34-20020a056122092200b004ac462b7417mr20523689vka.8.1700200343622; Thu, 16
 Nov 2023 21:52:23 -0800 (PST)
MIME-Version: 1.0
References: <20231114-b4-qcom-dt-compat-v3-0-88a92f8f00ba@linaro.org>
 <20231114-b4-qcom-dt-compat-v3-4-88a92f8f00ba@linaro.org>
In-Reply-To: <20231114-b4-qcom-dt-compat-v3-4-88a92f8f00ba@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 17 Nov 2023 11:22:12 +0530
Message-ID: <CAFA6WYP=y+u6si8zo-atTcrFA4SrPXeYBYL3N8RaQW=Dn7AN5Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] spmi: msm: fix register range names
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Stephan Gerhold <stephan@gerhold.net>,
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

On Tue, 14 Nov 2023 at 19:18, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> The core and chnl register ranges were swapped on SDM845. Fix it, and
> fetch the register ranges by name instead of by index.
>

You haven't updated qcs404-evb.dts to provide register names, so this
change alone will break that platform.

> Drop the cosmetic "version" variable and clean up the debug logging.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/dts/sdm845.dtsi |  2 +-
>  drivers/spmi/spmi-msm.c  | 46 ++++++++++++++++++----------------------------
>  2 files changed, 19 insertions(+), 29 deletions(-)
>
> diff --git a/arch/arm/dts/sdm845.dtsi b/arch/arm/dts/sdm845.dtsi
> index a26e9f411ee0..96c9749a52c0 100644
> --- a/arch/arm/dts/sdm845.dtsi
> +++ b/arch/arm/dts/sdm845.dtsi
> @@ -63,7 +63,7 @@
>                         reg = <0xc440000 0x1100>,
>                               <0xc600000 0x2000000>,
>                               <0xe600000 0x100000>;
> -                       reg-names = "cnfg", "core", "obsrvr";
> +                       reg-names = "core", "chnls", "obsrvr";
>                         #address-cells = <0x1>;
>                         #size-cells = <0x1>;

You should again drop custom u-boot bindings now:
doc/device-tree-bindings/spmi/spmi-msm.txt

>
> diff --git a/drivers/spmi/spmi-msm.c b/drivers/spmi/spmi-msm.c
> index 27a035c0a595..f8834e60c266 100644
> --- a/drivers/spmi/spmi-msm.c
> +++ b/drivers/spmi/spmi-msm.c
> @@ -70,7 +70,7 @@ enum pmic_arb_channel {
>
>  struct msm_spmi_priv {
>         phys_addr_t arb_chnl;  /* ARB channel mapping base */
> -       phys_addr_t spmi_core; /* SPMI core */
> +       phys_addr_t spmi_chnls; /* SPMI core */

s/SPMI core/SPMI channels/

-Sumit

>         phys_addr_t spmi_obs;  /* SPMI observer */
>         /* SPMI channel map */
>         uint8_t channel_map[SPMI_MAX_SLAVES][SPMI_MAX_PERIPH];
> @@ -95,10 +95,10 @@ static int msm_spmi_write(struct udevice *dev, int usid, int pid, int off,
>
>         /* Disable IRQ mode for the current channel*/
>         writel(0x0,
> -              priv->spmi_core + SPMI_CH_OFFSET(channel) + SPMI_REG_CONFIG);
> +              priv->spmi_chnls + SPMI_CH_OFFSET(channel) + SPMI_REG_CONFIG);
>
>         /* Write single byte */
> -       writel(val, priv->spmi_core + SPMI_CH_OFFSET(channel) + SPMI_REG_WDATA);
> +       writel(val, priv->spmi_chnls + SPMI_CH_OFFSET(channel) + SPMI_REG_WDATA);
>
>         /* Prepare write command */
>         reg |= SPMI_CMD_EXT_REG_WRITE_LONG << SPMI_CMD_OPCODE_SHIFT;
> @@ -113,12 +113,12 @@ static int msm_spmi_write(struct udevice *dev, int usid, int pid, int off,
>                 ch_offset = SPMI_CH_OFFSET(channel);
>
>         /* Send write command */
> -       writel(reg, priv->spmi_core + SPMI_CH_OFFSET(channel) + SPMI_REG_CMD0);
> +       writel(reg, priv->spmi_chnls + SPMI_CH_OFFSET(channel) + SPMI_REG_CMD0);
>
>         /* Wait till CMD DONE status */
>         reg = 0;
>         while (!reg) {
> -               reg = readl(priv->spmi_core + SPMI_CH_OFFSET(channel) +
> +               reg = readl(priv->spmi_chnls + SPMI_CH_OFFSET(channel) +
>                             SPMI_REG_STATUS);
>         }
>
> @@ -186,47 +186,37 @@ static struct dm_spmi_ops msm_spmi_ops = {
>  static int msm_spmi_probe(struct udevice *dev)
>  {
>         struct msm_spmi_priv *priv = dev_get_priv(dev);
> -       phys_addr_t config_addr;
> +       phys_addr_t core_addr;
>         u32 hw_ver;
> -       u32 version;
>         int i;
> -       int err;
>
> -       config_addr = dev_read_addr_index(dev, 0);
> -       priv->spmi_core = dev_read_addr_index(dev, 1);
> -       priv->spmi_obs = dev_read_addr_index(dev, 2);
> +       core_addr = dev_read_addr_name(dev, "core");
> +       priv->spmi_chnls = dev_read_addr_name(dev, "chnls");
> +       priv->spmi_obs = dev_read_addr_name(dev, "obsrvr");
>
> -       hw_ver = readl(config_addr + PMIC_ARB_VERSION);
> +       hw_ver = readl(core_addr + PMIC_ARB_VERSION);
>
>         if (hw_ver < PMIC_ARB_VERSION_V3_MIN) {
>                 priv->arb_ver = V2;
> -               version = 2;
> -               priv->arb_chnl = config_addr + APID_MAP_OFFSET_V1_V2_V3;
> +               priv->arb_chnl = core_addr + APID_MAP_OFFSET_V1_V2_V3;
>         } else if (hw_ver < PMIC_ARB_VERSION_V5_MIN) {
>                 priv->arb_ver = V3;
> -               version = 3;
> -               priv->arb_chnl = config_addr + APID_MAP_OFFSET_V1_V2_V3;
> +               priv->arb_chnl = core_addr + APID_MAP_OFFSET_V1_V2_V3;
>         } else {
>                 priv->arb_ver = V5;
> -               version = 5;
> -               priv->arb_chnl = config_addr + APID_MAP_OFFSET_V5;
> -
> -               if (err) {
> -                       dev_err(dev, "could not read APID->PPID mapping table, rc= %d\n", err);
> -                       return -1;
> -               }
> +               priv->arb_chnl = core_addr + APID_MAP_OFFSET_V5;
>         }
>
> -       dev_dbg(dev, "PMIC Arb Version-%d (0x%x)\n", version, hw_ver);
> +       dev_dbg(dev, "PMIC Arb Version-%d (%#x)\n", hw_ver >> 28, hw_ver);
>
>         if (priv->arb_chnl == FDT_ADDR_T_NONE ||
> -           priv->spmi_core == FDT_ADDR_T_NONE ||
> +           priv->spmi_chnls == FDT_ADDR_T_NONE ||
>             priv->spmi_obs == FDT_ADDR_T_NONE)
>                 return -EINVAL;
>
> -       dev_dbg(dev, "priv->arb_chnl address (%llu)\n", priv->arb_chnl);
> -       dev_dbg(dev, "priv->spmi_core address (%llu)\n", priv->spmi_core);
> -       dev_dbg(dev, "priv->spmi_obs address (%llu)\n", priv->spmi_obs);
> +       dev_dbg(dev, "priv->arb_chnl address (%#08llx)\n", priv->arb_chnl);
> +       dev_dbg(dev, "priv->spmi_chnls address (%#08llx)\n", priv->spmi_chnls);
> +       dev_dbg(dev, "priv->spmi_obs address (%#08llx)\n", priv->spmi_obs);
>         /* Scan peripherals connected to each SPMI channel */
>         for (i = 0; i < SPMI_MAX_PERIPH; i++) {
>                 uint32_t periph = readl(priv->arb_chnl + ARB_CHANNEL_OFFSET(i));
>
> --
> 2.42.1
>
