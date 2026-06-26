Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BBFCD4F26
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 10:41:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6E76849BA;
	Fri, 26 Jun 2026 12:41:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FBqRdJK7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85E308460E; Fri, 26 Jun 2026 12:41:46 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 097E3849C5
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 12:41:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-697edb1bf6eso1172457a12.1
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 03:41:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782470503; cv=none;
 d=google.com; s=arc-20260327;
 b=F+ti9Ssk8PZJgFiIWqJENfth4KjkylywpZJ8lwwsaLkLbX+zx4bhPT/rwsRmQYqvKI
 THM3CzWbUXvZxMdGCy9Xo89VvXNYd896fnuWB3DTU48DIgJXJBdIzjNI3dESDClzu55A
 0z/Nxoj1ud7FCyYlKzFdKx+mW5hHWtPIjf7BnkEauTPOC2TInwx0NMvByL7emynUlz1c
 6Kx8tZAgFFnrvucQBJxB3x4ASxWz8Oo+BS8iHa69QSYPl/+Yqw+GQsZ95zdsRFVL0I85
 n0cpUSH19BIjTN4XANJblwh3a7YjKKcKXgZYBz03Tr7rShmtiP/KEx/ncnXs/qhLmmS/
 UdCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kayFKz5/Mfzo2sMA6UV5m4LcOrRaTKRS9hrOUMNoPfg=;
 fh=nyKLZbC5pO9EO6FCB5YQSf7kr334RAPXhBSMuZ9b11E=;
 b=TfCfOohRCcjiWjO4+VLT3O1EW4s8dJh255KBQn6M7L7XxShJQJMba8XvQ78X/69FGn
 w2/b0QZ8spM0/+cXC45KdziHj/nopjKmnIyu+h0nnP4PSaLNX8sth/giME37cPQLvOzW
 u9RQRNDfdTNzSMHF1Ntd4B4whnxWGXOESCilvEjqPCEVacwfaqR0SknDsJlH1Hgfb811
 IB0y8VI0Ql1vQWAak9atuOvnqN8XLEwD1UNSJourB8xOR0yNQ/R0GEs4xEpWqgnm1Esz
 bQfpbX0I7LZuH0TcBlPF7WlX4dh6gza90s360c8BusKJaob47gBwgSuL5YLh748c/wkR
 0mpw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782470503; x=1783075303; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kayFKz5/Mfzo2sMA6UV5m4LcOrRaTKRS9hrOUMNoPfg=;
 b=FBqRdJK7RFWHBEVmTDBy68FZsd2zNRuUxzeqHDqskCmG0hHfG8G/kh4s6EAh96E2hg
 jNcRiqMaRZ3H6EOXoVqSA/oFfaTaBUGBZEmJ/3TCfsMIvQoje6p8f0gqTwNSHfdJY3i/
 X6UDC7mQnRJVubWOkECnXrCmkF0xBFcMHjj5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782470503; x=1783075303;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kayFKz5/Mfzo2sMA6UV5m4LcOrRaTKRS9hrOUMNoPfg=;
 b=ctuJj9/TUZnxcm2szjup5d4YM9rre30WtgAG7L6VTPSWEpK5Kp5DTHGKl/dqDQay2l
 s/xm8RW7DpZQjL1vbvfXgfuZT6ub3kz8QvgPhMDSo5aJgzGovjaqyu5pG5MgUabe3/N/
 aZAVDWOlyD3s83qPkUhPTq4l9/kMkGfgDiqe3g37yTfXlxD2jRwjUjY9PpasudoJ3AGI
 8C1M/NLrSxwcQ4Pqbs6JN5d+DASSIS6UE1kPpv6ECJTkbcGLwtLiKgPfX7PkOJy5VqW3
 RNZlR10uAjbsJBi3bz+SqToKupRC4ubnz4hDgqu5Eyhxb3Ra0MaTAz/Msv8Nw5jYpcxl
 4dlg==
X-Gm-Message-State: AOJu0YwYm1QvTVjkZ0NhdW3xIQmv42V6zLBJR5gOKdIyee+W89DEd4Lb
 xexOMAnZ4xM/bspRGLOHjK8d40PFWOpS8yDa99SYmfJzcVpTsR4BqcqYGLKPWInmmfgaLAKl6+6
 Fn931xl2O/Wc65nXz/eLRrzxjXYXgkrKCLVvknIrS
X-Gm-Gg: AfdE7clgaFFAmY0hqA3mOHUl1KRxZz0jIJt2VQMYhkWm7poWEzc241FmfAOLKmYWT9c
 R9+HCvAa5/oIG4GncUT37IfMxfI3sbJsRhdLvGwZkpk4lQq0YfP7GFEpeJ3iwwWlxECSBx/90bR
 1TObLdmEDKJp+hGxOQa62WlGYa15FgY/AUy2Q1sHv/VwalQyqjaNMCuP8A+15Tvc8vjLMCs4HAp
 VbZkKCUUixytg0DH2rz4HTi1lgwNVZ/FrIDzRdVEpcc2E0tQ7pYhDEHk0lbpd6kF0ZlE12FzQ==
X-Received: by 2002:a05:6402:2547:b0:697:b158:6d5f with SMTP id
 4fb4d7f45d1cf-69810aea752mr1805964a12.15.1782470503409; Fri, 26 Jun 2026
 03:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260606-pm8916-pon-v1-0-170c9cbe5099@samcday.com>
 <20260606-pm8916-pon-v1-7-170c9cbe5099@samcday.com>
In-Reply-To: <20260606-pm8916-pon-v1-7-170c9cbe5099@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 26 Jun 2026 11:41:31 +0100
X-Gm-Features: AVVi8CfVoFVbkL1N2VRaB8Y0djUekXsSP-pWeq2zlggje1N-eV_eMWxeWHH2wag
Message-ID: <CAFLszTg=Qnq=iYMNnTPfzPz=gVnXNppYZWF8JdM10pf--G-r5w@mail.gmail.com>
Subject: Re: [PATCH 07/11] reboot-mode: pm8916-pon: add new driver
To: me@samcday.com
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Neha Malcom Francis <n-francis@ti.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Luca Weiss <luca.weiss@fairphone.com>, 
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 George Chan <gchan9527@gmail.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Peter Robinson <pbrobinson@gmail.com>,
 "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>, 
 Dmitrii Merkurev <dimorinny@google.com>
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

Hi Sam,

On 2026-06-06T08:47:32, Sam Day via B4 Relay
<devnull+me.samcday.com@kernel.org> wrote:
> reboot-mode: pm8916-pon: add new driver
>
> The PM8916 provides a PON_SOFT_RB_SPARE register that survives across
> reboots.
>
> Signed-off-by: Sam Day <me@samcday.com>
>
> drivers/misc/pm8916_pon.c                    |  7 +++
>  drivers/reboot-mode/Makefile                 |  1 +
>  drivers/reboot-mode/reboot-mode-pm8916-pon.c | 88 ++++++++++++++++++++++++++++
>  3 files changed, 96 insertions(+)

> diff --git a/drivers/reboot-mode/reboot-mode-pm8916-pon.c b/drivers/reboot-mode/reboot-mode-pm8916-pon.c
> @@ -0,0 +1,88 @@
> +static int pm8916_pon_reboot_mode_probe(struct udevice *dev)
> +{
> +     struct pm8916_pon_reboot_mode_priv *priv = dev_get_priv(dev);
> +     struct udevice *pon = dev_get_parent(dev);
> +     fdt_addr_t base;
> +
> +     /* this driver only works as a child of pm8916_pon */
> +     if (!pon || !pon->driver || strcmp(pon->driver->name, 'pm8916_pon'))
> +             return -EINVAL;

Matching the parent by driver-name string is brittle - please compare
against DM_DRIVER_GET(pm8916_pon). Or better, since this driver is
only ever bound by the glue, drop the sanity check and trust the
parent.

> diff --git a/drivers/reboot-mode/reboot-mode-pm8916-pon.c b/drivers/reboot-mode/reboot-mode-pm8916-pon.c
> @@ -0,0 +1,88 @@
> +     priv->pmic = dev_get_parent(pon);
> +     if (!priv->pmic) {
> +             dev_err(dev, "PMIC driver not found\n");
> +             return -EINVAL;
> +     }
> +
> +     base = dev_read_addr(pon);
> +     if (base == FDT_ADDR_T_NONE) {
> +             dev_err(dev, "missing PON reg base\n");
> +             return -EINVAL;
> +     }
> +     priv->base = base;

This duplicates work already done by pm8916_pon_probe(), and walks the
parent's internals. Since pm8916_pon_priv already holds pmic and base,
please expose a small accessor (or share the struct via the existing
pm8916_pon.h) and read them from the parent's priv. That also removes
the need for the driver-name check above.

> diff --git a/drivers/reboot-mode/reboot-mode-pm8916-pon.c b/drivers/reboot-mode/reboot-mode-pm8916-pon.c
> @@ -0,0 +1,88 @@
> +static int pm8916_pon_reboot_mode_set(struct udevice *dev, u32 rebootmode)
> +{
> +     struct pm8916_pon_reboot_mode_priv *priv = dev_get_priv(dev);
> +     uint mask = GENMASK(7, GEN1_REASON_SHIFT);
> +     int ret;
> +
> +     ret = pmic_clrsetbits(priv->pmic, priv->base + PON_SOFT_RB_SPARE, mask,
> +                           rebootmode << GEN1_REASON_SHIFT);

pmic_clrsetbits() does (val & ~clr) | set without masking set to clr.
If the caller ever passes a mode_id wider than 6 bits this silently
writes garbage outside the field. Please AND the shifted value with
mask before passing it in.

> diff --git a/drivers/misc/pm8916_pon.c b/drivers/misc/pm8916_pon.c
> @@ -142,6 +142,13 @@ static int pm8916_pon_bind(struct udevice *dev)
> +     if (CONFIG_IS_ENABLED(DM_REBOOT_MODE)) {
> +             ret = device_bind_driver_to_node(dev, 'pm8916_pon_reboot_mode',
> +                                              'reboot_mode', dev_ofnode(dev), NULL);
> +             if (ret)
> +                     dev_warn(dev, "failed to bind reboot_mode: %d\n", ret);
> +     }

Binding the child to the parent's own ofnode means
dm_reboot_mode_pre_probe() iterates the pm8916_pon node looking for
mode-* properties. That works only if the board DT places them
directly on the PON node - please mention this expectation in the
commit message (or a binding doc snippet)...from what I can tell this
is different from the kernel binding where reboot-mode is a separate
subnode.

>     reboot-mode: pm8916-pon: add new driver
>
>     The PM8916 provides a PON_SOFT_RB_SPARE register that survives across
>     reboots.

The commit message is very thin - it states a fact about the hardware
but does not say what the patch does. Please describe that this adds a
reboot-mode uclass driver bound as a child of pm8916_pon, how it
relates to the existing NVMEM-based approach, and the expected DT
layout (mode-* properties on the PON node).

Regards,
Simon
