Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7CAE784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:45:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AE1F86D40;
	Mon,  2 Oct 2023 03:23:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gfFRnk+U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FF2585423; Mon,  2 Oct 2023 03:23:57 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CE0886D40
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:23:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-32488a22810so3346981f8f.3
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209833; x=1696814633; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tuLld0O1QJllXALCp77SzND9Sch3aKr2kICh/EnUwrs=;
 b=gfFRnk+UKtcqUR2FxeDeu3Vt8baCIsWnAFKeD/jm7YRrh6/88+VpoxNAwK5s9vyvWH
 aGOm4cvMxTawrWokqAwZP1R948kQt7e78fg2WM1G/f5k4u/YHQ+0z29EmT2dnMwSKkPE
 lY5xtMpHHYHz4JvXs+BRC53C43mJuLGZ7xphQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209833; x=1696814633;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tuLld0O1QJllXALCp77SzND9Sch3aKr2kICh/EnUwrs=;
 b=gJZaIILUQfW4yGvKwYeOfHuwU0EIVFoMGJwONXdsbp7oMQMyfkAcv5IyiFV/iyjq9c
 ZtxJevLxt61xLhrnLCWOU4aWTsZRP3L3le4udTYvKNOm7x7D9qhpzAA/6PC0UnyscER8
 dqlD6e9ERyf0T/u8OV1fgHMKhu50ZCNJOnVpI5cTWIjT5gMn9O1s4yKP2k8du1XJAclt
 L4YK7DCWInENHGvsTATKTAcaE61i9GkAuQTASqqkxsNLRSQiBJW/oLQxDdv3sghiBScB
 GZHZWPhH17FnhIpYc4m2lihqu7taJJ+TY+mXDkYyUkejBmiYckojK9H8+oNUp5KTRLwC
 g0jA==
X-Gm-Message-State: AOJu0YzWMr9XgHISVYj6OjkqcScBiaAuI7QCkPadBg4ZdpKS204opb2H
 PCoWh5SOBy+yq548t2Et87wkeg/Jwc3dDlpyIU4A0w==
X-Google-Smtp-Source: AGHT+IGshcVYDz7l7FG/FaKzPEUOcel3dlzzgsG9bqAzx4JDn/YQnFTVRT8yKPxXFLoqXeLAYZtzQeY+fdyoRmFk3eo=
X-Received: by 2002:a5d:4c42:0:b0:324:8362:138c with SMTP id
 n2-20020a5d4c42000000b003248362138cmr8643471wrt.40.1696209833360; Sun, 01 Oct
 2023 18:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230926-binman-firewalling-v2-0-b1a084ec634d@ti.com>
 <20230926-binman-firewalling-v2-4-b1a084ec634d@ti.com>
In-Reply-To: <20230926-binman-firewalling-v2-4-b1a084ec634d@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:17:11 -0600
Message-ID: <CAPnjgZ1siOjfeKtQQgTWjvCV0LvE-R1KOBfwiaZL6pdadwtxmA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/8] binman: k3: add k3-security.h and include it
 in k3-binman.dtsi
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 u-boot@lists.denx.de, 
 Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon <nm@ti.com>
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

Hi Manorit,

On Tue, 26 Sept 2023 at 01:59, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
>
> For readability during configuring firewalls, adding k3-security.h file
> and including it in k3-binman.dtsi to be accessible across K3 SoCs
>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>  arch/arm/dts/k3-binman.dtsi |  2 ++
>  arch/arm/dts/k3-security.h  | 58 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

nits below

> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
> index 2ea2dd18a12b..71ffa998a59f 100644
> --- a/arch/arm/dts/k3-binman.dtsi
> +++ b/arch/arm/dts/k3-binman.dtsi
> @@ -3,6 +3,8 @@
>   * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
>   */
>
> +#include "k3-security.h"
> +
>  / {
>         binman: binman {
>                 multiple-images;
> diff --git a/arch/arm/dts/k3-security.h b/arch/arm/dts/k3-security.h
> new file mode 100644
> index 000000000000..e012b7afaf94
> --- /dev/null
> +++ b/arch/arm/dts/k3-security.h
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +#ifndef DTS_ARM64_TI_K3_FIREWALL_H
> +#define DTS_ARM64_TI_K3_FIREWALL_H
> +
> +#define FWPRIVID_ALL    (0xc3)
> +#define FWPRIVID_ARMV8  (1)
> +#define FWPRIVID_SHIFT  (16)

drop () on those three and the next one

> +
> +#define FWCTRL_EN     (0xA)
> +#define FWCTRL_LOCK   (1 << 4)
> +#define FWCTRL_BG     (1 << 8)
> +#define FWCTRL_CACHE  (1 << 9)
> +
> +#define FWPERM_SECURE_PRIV_WRITE      (1 << 0)
> +#define FWPERM_SECURE_PRIV_READ       (1 << 1)
> +#define FWPERM_SECURE_PRIV_CACHEABLE  (1 << 2)
> +#define FWPERM_SECURE_PRIV_DEBUG      (1 << 3)
> +
> +#define FWPERM_SECURE_PRIV_RWCD       (FWPERM_SECURE_PRIV_READ | \
> +                                       FWPERM_SECURE_PRIV_WRITE | \
> +                                       FWPERM_SECURE_PRIV_CACHEABLE | \
> +                                       FWPERM_SECURE_PRIV_DEBUG)
> +
> +#define FWPERM_SECURE_USER_WRITE      (1 << 4)
> +#define FWPERM_SECURE_USER_READ       (1 << 5)
> +#define FWPERM_SECURE_USER_CACHEABLE  (1 << 6)
> +#define FWPERM_SECURE_USER_DEBUG      (1 << 7)
> +
> +#define FWPERM_SECURE_USER_RWCD       (FWPERM_SECURE_USER_READ | \
> +                                       FWPERM_SECURE_USER_WRITE | \
> +                                       FWPERM_SECURE_USER_CACHEABLE | \
> +                                       FWPERM_SECURE_USER_DEBUG)
> +
> +#define FWPERM_NON_SECURE_PRIV_WRITE      (1 << 8)
> +#define FWPERM_NON_SECURE_PRIV_READ       (1 << 9)
> +#define FWPERM_NON_SECURE_PRIV_CACHEABLE  (1 << 10)
> +#define FWPERM_NON_SECURE_PRIV_DEBUG      (1 << 11)
> +
> +#define FWPERM_NON_SECURE_PRIV_RWCD       (FWPERM_NON_SECURE_PRIV_READ | \
> +                                           FWPERM_NON_SECURE_PRIV_WRITE | \
> +                                           FWPERM_NON_SECURE_PRIV_CACHEABLE | \
> +                                           FWPERM_NON_SECURE_PRIV_DEBUG)
> +
> +#define FWPERM_NON_SECURE_USER_WRITE      (1 << 12)
> +#define FWPERM_NON_SECURE_USER_READ       (1 << 13)
> +#define FWPERM_NON_SECURE_USER_CACHEABLE  (1 << 14)
> +#define FWPERM_NON_SECURE_USER_DEBUG      (1 << 15)
> +
> +#define FWPERM_NON_SECURE_USER_RWCD       (FWPERM_NON_SECURE_USER_READ | \
> +                                           FWPERM_NON_SECURE_USER_WRITE | \
> +                                           FWPERM_NON_SECURE_USER_CACHEABLE | \
> +                                           FWPERM_NON_SECURE_USER_DEBUG)
> +
> +#endif
>
> --
> 2.41.0
>

Regards,
Simon
