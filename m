Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A42FF60D5
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 19:52:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06B1F83E7A;
	Tue, 31 Mar 2026 21:52:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A3LqAZy/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C72D983F5B; Tue, 31 Mar 2026 21:52:11 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6BB183AA9
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 21:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b97bca3797dso949009766b.0
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 12:52:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774986728; cv=none;
 d=google.com; s=arc-20240605;
 b=Yko7p03pAJXO4eZYUXofktcon1xpqLZKjQ2WQGtUXt4HtudgRgXdL9a3iy09VZW9vq
 zTjnlHasxPRiukxri4CNSCpbdl3LdZyPfioZ1Nq0Hg8bXxb4QZUww85QtGPAqpO1wGe+
 la5/hGGpjQLFJ0wKyWjO46T2dfI5wKKGKCJTWiyWy9AugHLxjFsPpKEb7TZVXjfeL0Xw
 HDTjMWHmaIGWJOCkpEef3fpEc7gKqZ+g1mtHN27fufs8sT9TfXPVX22wy1j/T/eWEHH8
 oLodgnu4HXvbbLSKwNLJerKmN17cSytdn8VMVsWuC0COqKGbbF4Uqr4x3mbuNz0QxcI1
 vBsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=x2JqikGxilWk5zNn3hT1+Ll/KloR8V6Iml1y4AlhWWU=;
 fh=B7piA5/CKffe2xSFGh/jkVV4hFjZTT9WwjW0AtGMo5I=;
 b=eyf8lna4CsznGocQsDvTWvVjXqYXqT8zJha3xZM33+OFzDmJBlWF/lFBLMzb11rCjw
 qpef+85hohOXmRvvemdV1S9+Yf5TSx8Rt4fDTqNRXy3bJqI5WXExJQp5GqlEeuqlH2yF
 oIckANe3PVWpRglR9I9iy1bLDhK4/JYlmubkwRK8U5uakZstyhj10uMR3IWw0bF2/n7U
 ioa7lfNHIv9Ssy9QxB5mbz1CeIhrZq0p4ZmqiPP2ZXurhpqkdxIwrQyx+ocbzTjQqAhU
 rag9V+pAMPokyiQAowoshmMxGjVVRldBhI2SoN/S9kpL8zNNWZwI2UyQ6BYjthBR0+q6
 /AFg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774986728; x=1775591528; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x2JqikGxilWk5zNn3hT1+Ll/KloR8V6Iml1y4AlhWWU=;
 b=A3LqAZy/8a5COhxYy1zJUUB/uBIURyKxrVZLhj4RFB4QIU8DKMatvh6S8iP5mW9g7S
 csJr2dH6wCJIxjBGqxSAphrvrA3FnnowZHFbe1P5jk0ATwS1jkuriEgoXOunt3FFKv9F
 GenE8j1jiWhGG2hDJ795PlVy4/PU7+El5MOLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774986728; x=1775591528;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x2JqikGxilWk5zNn3hT1+Ll/KloR8V6Iml1y4AlhWWU=;
 b=mjr4XcvIo1XSZ+HB3D3twirmZ9SW2Tvb8uc2C12WTg/IOxg/nwwuR0Pst1uNTfkmyk
 Jw0MmEC1TmQUIQlP7eb2UyuaT4GmKteeq2riNeLRBbfvuORMHkMDPd5e+6SIZhHGsLZJ
 wt4qPEMSPxOOXCwLwRVDPSfkdW1ZncJTOSRkQPs9qChDRegygR1CMQkNoi/GfTstmQEg
 +OZCFnqaFxH9GSIQGPiQjTb8pMHHz4mCMVNekm0ICmSr+4SbjaFF1LoSx/AL4ySX1TUe
 B064IhZujx6na0xi3twcS+N2Aw+ZaXIyU+O0ASojXfldupTmuXcrrU4Whlw9QjdzGYiN
 jDqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUU8CPXZGHyCpqihF7KVS7EaL2GTVYaLC+Uwduiv+gj+Ly8BhNUXFbyU86C+6KXZToXxrbOSg8=@lists.denx.de
X-Gm-Message-State: AOJu0Yw5sXDLwtDepJn3f3uLf7pyQX+JEZtoF/L84tHg6FM/psJc1tZz
 baOenFRV57GcHkJyw05cBznDn7TESqHGirQTp/7T0ptceoOG3xghmVNWvm+dISF9R/5PEEyhpxW
 T+GHUr8YU0tb1V0MIk2BztuoFZedfpweciAIdzH37
X-Gm-Gg: ATEYQzwbojv7JWDOR4JLI9Bvbt6igA/UfUobFnJruJaZUpsCc5GYMSuosO2QVTCNUBa
 Pi55pLunr0Jidam21v0lArdAQIPGv0AdCMMaFIvemLUE6DWoEtjRVEUeoKgi6/fDYwSlgA3AUz9
 BLTXBWzhFyFkQYK6nzRFpTihyMdyRnuQN/rVSglyByP6y8/VZVXv2d3Q5+hn1N9WXghDyUDtYfP
 6RZzFQyHCfIlryJY+pwRcgPdRb0p988PHEI4WzIXOz/XoZcl5OQg/hmoDCQN4U0dFgzdj2LIdLd
 LK/7DaE21a2ERkDQ
X-Received: by 2002:a17:907:6c10:b0:b97:554:f12e with SMTP id
 a640c23a62f3a-b9c138f5103mr63767966b.14.1774986727673; Tue, 31 Mar 2026
 12:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260330171419.1117817-1-aswin.murugan@oss.qualcomm.com>
 <20260330171419.1117817-3-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260330171419.1117817-3-aswin.murugan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 31 Mar 2026 15:51:56 -0400
X-Gm-Features: AQROBzDn5ytXNCBARagEIxj7whzYdDUG27neRo62c35ej5RP5ftsPmlurNnn4rE
Message-ID: <CAFLszTjdH8MEJftFzPPjgxnyK6Cb227mGWH_mfL36e44=+QA7g@mail.gmail.com>
Subject: Re: [v3,2/7] misc: qcom: Add Qualcomm SPMI SDAM NVMEM driver
To: aswin.murugan@oss.qualcomm.com
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, sjg@chromium.org, seanga2@gmail.com, 
 sughosh.ganu@arm.com, ilias.apalodimas@linaro.org, gchan9527@gmail.com, 
 mkorpershoek@kernel.org, hs@nabladev.com, marek.vasut+renesas@mailbox.org, 
 msp@baylibre.com, dinesh.maniyam@altera.com, peng.fan@nxp.com, 
 quentin.schulz@cherry.de, kever.yang@rock-chips.com, 
 jamie.gibbons@microchip.com, justin@tidylabs.net, xypron.glpk@gmx.de, 
 n-francis@ti.com, h-vm@ti.com, ycliang@andestech.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
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

On 2026-03-30T17:14:12, Aswin Murugan <aswin.murugan@oss.qualcomm.com> wrote:
> diff --git a/drivers/misc/qcom-spmi-sdam.c b/drivers/misc/qcom-spmi-sdam.c
> @@ -0,0 +1,200 @@
> +static int qcom_sdam_probe(struct udevice *dev)
> +{
> +     struct qcom_sdam_priv *priv = dev_get_priv(dev);
> +     int ret;
> +
> +     priv->base = dev_read_addr(dev);
> +     if (priv->base == FDT_ADDR_T_NONE) {

priv->base is u32 but dev_read_addr() returns fdt_addr_t, which is u64
on 64-bit platforms. When FDT_ADDR_T_NONE is truncated into a u32 and
then promoted back for the comparison, the check silently passes. I
suggest storing the result in a local fdt_addr_t, check it against
FDT_ADDR_T_NONE, and only then assign to priv->base

> diff --git a/drivers/misc/qcom-spmi-sdam.c b/drivers/misc/qcom-spmi-sdam.c
> @@ -0,0 +1,200 @@
> +     priv->size = dev_read_u32_default(dev, "qcom,sdam-size", SDAM_SIZE);

The upstream DT binding (qcom,spmi-sdam.yaml) does not define a
'qcom,sdam-size' property - the size is implied by 'ranges'. Is that
coming later? I suspect this should either parse the 'ranges' property
or just hardcode 0x100

> diff --git a/drivers/misc/qcom-spmi-sdam.c b/drivers/misc/qcom-spmi-sdam.c
> @@ -0,0 +1,200 @@
> +     dev_info(dev, "SDAM base=0x%x size=0x%x PMIC_USID=%d\n",
> +              priv->base, priv->size, priv->pmic_usid);

This is rather noisy for every boot. Please can you make this dev_dbg() instead.

Regards,
Simon
