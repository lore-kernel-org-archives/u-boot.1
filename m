Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE729CDE008
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 10:38:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41A448460E;
	Fri, 26 Jun 2026 12:38:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UoYXnwxX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 997098495E; Fri, 26 Jun 2026 12:38:43 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5D788404D
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 12:38:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6976b0b2c79so784682a12.2
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 03:38:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782470321; cv=none;
 d=google.com; s=arc-20260327;
 b=TziteQOkWxMPbyMQyYtAiaR6dzhL0vAm+Gtd5Na3sTAnFOeYfOOQ0BVPY3937gWBim
 VKOE1BKj/Am2i8wE7op/cgkWmax1h5UJODib5n9uJcRk+m5gU1UZyB4+r/uLEMFRdAzU
 BkhDpkhMNoPGJXOw/3L2puJ5FtdtiiqrjYcl5mE6rG5Tlbv2nNkht9Y85gOgGHJIVvvX
 7PKgM1mMgDVSolw8b1QwPewOV4jmS+AxsJ8aSphwZpz0FIBKYyc6Q/C9a77m47cGNgdX
 bI2EU1lHyLgcjNDLEIiurijNVwM6yD+2MmhCWWINz4+Jw9gG6AbAmKRHYJ1ihHc4vMye
 fbmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kYFMfIMEI1Daab+rZcPaJjWIz9TW9kQ4BHfRQNtZLZE=;
 fh=nyKLZbC5pO9EO6FCB5YQSf7kr334RAPXhBSMuZ9b11E=;
 b=WyG0Mc2pR9rrFOSc8u+7DkXhwgHJ+vopDstII3km70t/W03HFshr2wOgiXTmw34bnJ
 R9YcrEEznKvmx7lTLkBmHQHLseMaZsGFwY0EPmrbjiUvL1GstWxKpOcsRzZtJsMtPxm5
 wWXO0mr5HqOC1AiaT5iiTAifnIjshabr/+mPOsz1Uk2AsNELx7XwHHvG/twbD9JIhYxS
 PUPITuF4QtwgtXGwoMsaV5GUt2aw9H4tKKRjhIbHHniS2++9Oj7dxSweAvaJcU9ELd44
 zIonhcs2OvVH10mVbClRihIIc6R80o+A6dMbIdl5NH1vDnSv45iDa9ukoZNsFq7Vm3Pt
 pZGw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782470321; x=1783075121; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kYFMfIMEI1Daab+rZcPaJjWIz9TW9kQ4BHfRQNtZLZE=;
 b=UoYXnwxXGJ04sxH9twmylBqr9D3zKjgG38cxaJQ3Acig0s1HKYRGHFSILlPuzE3lSB
 wseaf3/pieusTA94VejMSeoQEmfPgMSQ4dT2cx+jzz0jxvps5Tsk46lr+1xYfx0+5qGi
 C3KXQUDK32mQJ/NrEsVoMhPwFonMp9u45JC5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782470321; x=1783075121;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kYFMfIMEI1Daab+rZcPaJjWIz9TW9kQ4BHfRQNtZLZE=;
 b=mVkzBrrIo3BmRun2p7CTB7qbmb8W9x+yfjAAb8cOwu8Vo8hwbyF295yR4iOfrKGKzz
 dG+tro5CrM7NnUxqfptYxjFbq33bqT0eH7h3gbB87BE/6QTjJWcgo79N8ih12Zbqq8JX
 b85O0TZN8SVYMT8EBpbo0ftq8MI4s2J9RjuRG9H9/497lZ+U8IQxpPXYX5vY9viG8ffm
 tHamDXajAJOwteaKNblhGG3dfVrU+VM1Hyyx+L2qIslaPM+AuLUQOsi2ebeQcEaGoTa1
 3W/vCXNXi/tBGSA5UUWFz5Yqzat5r9vmY4R/OcpUYrVEvNG2dUTkWD9YZ0W4mArwIv70
 18zw==
X-Gm-Message-State: AOJu0YwtZuv3Rh2cy3NbRQ4qf+7LYt2r8lCaQy/YroFememJBQOo1X4l
 uNMv+8VTK/MQLkYYE/dJsO/12v8WueFokIw7bL1sTU9EzkVJ1mXOGB9zYuGov6nQWPa+y9EBIia
 NQhfwSA6vD+beqplzS+30J7yZZS+qQwBhzQEeCarv
X-Gm-Gg: AfdE7cllCuOb1bJziqD9S/fAIDSNAyn8ulJiKqiVDbeX1TWIN4YEirDnUcCyPWbcmVj
 zhigKT5XciIaxQtS2gaM+CHgKjZ6AsYvPwU1pJp+vcqcCSyizERB2Xi0PAlHavyhkUT7MvS2S3v
 JLJKe/BsD8E//4yHewVlWyxvCZQVy0cqOBSLlpdfZCKJ7zdHBHym3ZGXsn7uf7QqjJ/iwYy1m5X
 TzFda+kJSHW8ST6yGvNXDdH8FHOUyTZHSv22rsDTT4mOe+eAKZvIzksPrSZPpx4Un44qvlnWUji
 fi5sgEB0
X-Received: by 2002:a05:6402:321b:b0:697:f6bf:ba85 with SMTP id
 4fb4d7f45d1cf-69810aedd9dmr1792374a12.20.1782470321176; Fri, 26 Jun 2026
 03:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260606-pm8916-pon-v1-0-170c9cbe5099@samcday.com>
 <20260606-pm8916-pon-v1-2-170c9cbe5099@samcday.com>
In-Reply-To: <20260606-pm8916-pon-v1-2-170c9cbe5099@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 26 Jun 2026 11:38:27 +0100
X-Gm-Features: AVVi8Cc4XkIPwWmoFJ8X1Cfq8QfhtNRWK3LixxDFZnKUYgmhTOfvhdZ_qV9vCXw
Message-ID: <CAFLszThqHnWh=oOzDH_1sxSf45L=udFN6Me+EfujUV4mQDiVvQ@mail.gmail.com>
Subject: Re: [PATCH 02/11] drivers: misc: pm8916_pon: add glue driver
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
> drivers: misc: pm8916_pon: add glue driver
>
> Initially, this driver binds the existing qcom_pwrkey driver to continue
> supporting pwrkey/resin buttons. In follow-up commits it will be further
> extended to bind a reboot-mode driver.
>
> The 'qcom,pm8916-pon' compatible is removed from qcom_pwrkey, since
> pm8916_pon owns it and handles binding qcom_pwrkey.
>
> Signed-off-by: Sam Day <me@samcday.com>
>
> drivers/button/button-qcom-pmic.c |  1 -
>  drivers/misc/Kconfig              |  7 ++++
>  drivers/misc/Makefile             |  1 +
>  drivers/misc/pm8916_pon.c         | 78 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 86 insertions(+), 1 deletion(-)

> diff --git a/drivers/misc/pm8916_pon.c b/drivers/misc/pm8916_pon.c
> @@ -0,0 +1,78 @@
> +struct pm8916_pon_priv {
> +     struct udevice *pmic;
> +     phys_addr_t base;
> +     u32 revision;
> +};

In addition to Casey's comments...

base here is an SPMI register offset within the parent PMIC, not a CPU
physical address - phys_addr_t is misleading. Please use u32 (or at
most fdt_addr_t, matching the dev_read_addr() return).

> diff --git a/drivers/misc/pm8916_pon.c b/drivers/misc/pm8916_pon.c
> @@ -0,0 +1,78 @@
> +static int pm8916_pon_bind(struct udevice *dev)
> +{
> +     int ret;
> +
> +     if (CONFIG_IS_ENABLED(BUTTON_QCOM_PMIC)) {
> +             ret = button_qcom_pmic_setup(dev);
> +             if (ret)
> +                     dev_warn(dev, "failed to bind qcom_pwrkey: %d\n", ret);
> +     }
> +
> +     return 0;
> +}

Two things. The CONFIG_IS_ENABLED() guard is redundant - the stub in
<button/qcom-pmic.h> already returns -ENOSYS when the option is off,
which is the whole point of the stub. Second, swallowing the error and
returning 0 means a real binding failure is invisible to the caller;
please log via dev_err() or propagate it. As written, -ENOSYS from the
stub would also trigger the warning on every probe when
BUTTON_QCOM_PMIC=n, which I suspect is not what you want.

> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> @@ -439,6 +439,13 @@ config SPL_PWRSEQ
> +config PM8916_PON
> +     bool "Enable PM8916 PON driver"
> +     depends on PMIC_QCOM && MISC
> +     help
> +       The PM8916 PMIC is a multifunction device that handles pwr/resin buttons,
> +       reboot type (soft/hard/poweroff) and reboot mode (recovery/bootloader).

The help text describes functionality this patch does not yet provide
- reboot type and reboot mode come in later patches. Please describe
what this driver does at this point (binds the pwrkey/resin buttons)
and expand the text in the patches that add the further functionality,
so bisection points at a coherent description.

Regards,
Simon
