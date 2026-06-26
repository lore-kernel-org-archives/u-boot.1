Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11FFCDE008
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 10:39:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D46E8460E;
	Fri, 26 Jun 2026 12:39:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f3lIgYTU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 031288497A; Fri, 26 Jun 2026 12:39:13 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAF578404D
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 12:39:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-697df404e32so1609528a12.0
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 03:39:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782470350; cv=none;
 d=google.com; s=arc-20260327;
 b=sV70ngQPUccCKCAFuc/XHh5QdHrk2ibY1kdXgMXW1P0aoJV9yxd3JNgSMH5boKNye3
 6WcSwzt2YRy6X81GXlbqRKDZAysyyqPsBkHAU6fEcE8M3nioal93ScIoVybucgoARaRf
 3lK6NJdzirjnzS+2HmvnagaFtZ+qdmKQbSK6sIpaCA+E2TdfC86O0hWylUqa8XEKxCCO
 W8Iv7IOg/bXwwWTNGFegBIxmbSS3lm+BWd/e+6Wxe1L1CGzrtE3LQq+0ibokwgNmhCBl
 684+Ad1pi1joeE7sKPPOvuiOd3Jo05lX//NvKcteJB4gXLOo51AnNM5wQAHMlsJshGud
 3meA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BsZ3FnXnZ+fSRm8UMppx9GRcciQGI57TX7ezkogyd/I=;
 fh=nyKLZbC5pO9EO6FCB5YQSf7kr334RAPXhBSMuZ9b11E=;
 b=jrYfhkTOVZl7Lg8hvcCU83BYes0EQTP04VMhV8NsWGUGOT0RLOLdEfM1OgtX4bWlpB
 Oa0rpvxaLTbtaSqgleNJolKJ3A70NoNg3D8Tvk2FGjCOFTlQryh1O7pPdfO9uAR9JXUi
 1gCAjUL3NnZl1x9fqgWwJteD3iPjVsoEMKw8nhviA+fG1oErlPNyZ7e1C3v0iOhbRaQY
 YYfeACHIehxKDZz0xa3CmURcQ/EJAUOcT284yrGiat3bhJC+L3K/ZR2uEarITNpmWp0P
 Yw6oRKIuyCZEgojR0JbOkjryivhuL0vwwx7jXYrxS/C2J4/nZxayjnZIJSod/JalTdHx
 abUg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782470350; x=1783075150; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BsZ3FnXnZ+fSRm8UMppx9GRcciQGI57TX7ezkogyd/I=;
 b=f3lIgYTUtXRIFlqPhS3Tj4szynwV5tu0y3ds4crouOdr6HqBgAy8YulItGyB/tDOOb
 K38GmE7gojmGWOGRFLPQM2o4b7tzSAhYNri10ogLhqiXSIv+JaSoodFWaDAuMQ01AJvO
 e2v8YyIgOOW9nJeblBH72tcJOdaAhhaXfUIQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782470350; x=1783075150;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BsZ3FnXnZ+fSRm8UMppx9GRcciQGI57TX7ezkogyd/I=;
 b=W+rCQFiX6VYsmGWZ4yB0I87w5VYVhn/4Zla+SPN+2EMYvOo9eWgFrARsUpzql+4ejo
 aw+gAlXwiLWRo/ullUG9vqbZ0963N3ZkRbqS7iAD6EGV4zM8OG1NXZkXFQNIwCeP++Kf
 sUd53VrTQMZIC09EUWimKdkHyItZ1sCKP8Gw/NopeHo7yVF5gAKcfot6tjShetEvN5uK
 xrSi7nhVB1UGIw7EuHU1oDKIjsP0x66FyTh6BfhpKLijz5X1nmfxTy3UzBoJSWRqeuwD
 6P/xFgBHoR46oROYU798Gxf/eqk+n/E4dZFe4wOTsox54tMz+ya+70ZZgoYiEX3614ty
 FePg==
X-Gm-Message-State: AOJu0YzVg2f2C2dcRL+zen3s+PedFpBKMkrUdH93NQtNUVXHOM2fu3gM
 8wifwi6n31od+oEwCdnIjAIRxwCc/BH92wv0Wc6AzHTiL1eICuCaGdU1X8/rIqzfi/AWeFZ+Pq/
 pAToyCZYiVKO8N2Wlf8PYSIVNP7VH8AaUXLGpqzor
X-Gm-Gg: AfdE7ck00X8RoN5bnDot2ISlW4lP2umRy2VgI8TdSqyXhGtsBRtdJrO2bUS3zOTr3JL
 93xeyt+cMlgXlRcc6Q85XDbMvsmX7a4iiL+VJhyAdZarP0JWu0wfbAkTi8IoF6mWBG4279X5vob
 NhkfUM7siFN6d+W/O6oN5W5glA6KohrVWqG/KMG2GUCwjBYg1QApRoqbVnROfNS2hzTRcMaDzvc
 NwVCb+TsFkA9pXhbOYqu0mYgzBXSjbIaNnw9ZN7Cn1cq4tawh2fQ/k/pbdXKilKZFdl0CAtenPH
 YN3UFnMP
X-Received: by 2002:a05:6402:1473:b0:697:ea41:9799 with SMTP id
 4fb4d7f45d1cf-69810a4597emr1914091a12.4.1782470350240; Fri, 26 Jun 2026
 03:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260606-pm8916-pon-v1-0-170c9cbe5099@samcday.com>
 <20260606-pm8916-pon-v1-4-170c9cbe5099@samcday.com>
In-Reply-To: <20260606-pm8916-pon-v1-4-170c9cbe5099@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 26 Jun 2026 11:38:56 +0100
X-Gm-Features: AVVi8CdI7ky1qJTRzxfnSubPyI24Z2iIwWx_S06LIdPFOG4CDAdgxgSIdH-QXi8
Message-ID: <CAFLszThEHyCaV7wgta6vUOF6gDTkiPDEMX9tywus0n2W8KLFrA@mail.gmail.com>
Subject: Re: [PATCH 04/11] drivers: misc: pm8916_pon: support setting reboot
 type
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
> drivers: misc: pm8916_pon: support setting reboot type
>
> This is to be used in conjunction with PSHOLD sysreset driver.
>
> This code manages the RST_CTL register block, which PM8916 uses to
> decide what action to take when PS_HOLD is de-asserted.
>
> Signed-off-by: Sam Day <me@samcday.com>
>
> drivers/misc/pm8916_pon.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/pm8916_pon.h      | 18 +++++++++++
>  2 files changed, 100 insertions(+)

> diff --git a/drivers/misc/pm8916_pon.c b/drivers/misc/pm8916_pon.c
> @@ -10,16 +10,98 @@
> +     ret = uclass_get_device_by_driver(UCLASS_MISC,
> +                                       DM_DRIVER_GET(pm8916_pon), &dev);
> +     if (ret) {
> +             pr_warn("couldn't find pm8916_pon device: %d\n", ret);
> +             return ret;
> +     }
> +     if (!dev) {
> +             dev_warn(dev, "couldn't find pm8916_pon device\n");
> +             return -ENODEV;
> +     }

As Casey mentions, uclass_get_device_by_driver() either returns an
error or a valid dev - the second check is dead code, and dev_warn()
with a NULL dev would dereference it. Please drop the !dev block.

> diff --git a/drivers/misc/pm8916_pon.c b/drivers/misc/pm8916_pon.c
> @@ -10,16 +10,98 @@
> +     ret = pmic_clrsetbits(priv->pmic, priv->base + enable_reg,
> +                           PON_PS_HOLD_ENABLE, 0);
> +     if (ret) {
> +             dev_warn(dev, "clear PON_PS_HOLD_ENABLE failed: %d\n", ret);
> +             return ret;
> +     }
> +
> +     /* Delay needed for disable to kick in. */
> +     /* Kernel uses usleep_range(100, 1000), lk2nd waits 300usec */
> +     udelay(300);
> +
> +     ret = pmic_clrsetbits(priv->pmic, priv->base + PON_PS_HOLD_RST_CTL,
> +                           PON_PS_HOLD_TYPE_MASK, pmic_reset_type);
> +     if (ret) {
> +             dev_warn(dev, "RST_CTL set failed: %d\n", ret);
> +             return ret;
> +     }

If the type write fails after the enable has been cleared, the PON is
left disabled and the next PS_HOLD de-assertion will do something
undefined. Please attempt to restore PON_PS_HOLD_ENABLE on the error
path, or at least log loudly that the device has been left
half-configured.

> diff --git a/drivers/misc/pm8916_pon.c b/drivers/misc/pm8916_pon.c
> @@ -10,16 +10,98 @@
> +     switch (reset_type) {
> +     case SYSRESET_POWER_OFF:
> +             pmic_reset_type = PON_PS_HOLD_TYPE_SHUTDOWN;
> +             break;
> +     case SYSRESET_COLD:
> +     case SYSRESET_POWER:
> +             pmic_reset_type = PON_PS_HOLD_TYPE_HARD_RESET;
> +             break;
> +     default:
> +             pmic_reset_type = PON_PS_HOLD_TYPE_WARM_RESET;
> +     }

Silently mapping every unknown reset_type to a warm reset feels risky
- SYSRESET_POWER_OFF_WAIT or future additions would unexpectedly
reboot instead of erroring out. Please either return -ENOTSUPP for
unhandled values, or list each explicitly so adding a new enumerator
forces a compile-time review.

> diff --git a/drivers/misc/pm8916_pon.c b/drivers/misc/pm8916_pon.c
> @@ -10,16 +10,98 @@
>     This is to be used in conjunction with PSHOLD sysreset driver.
>
>     This code manages the RST_CTL register block, which PM8916 uses to
>     decide what action to take when PS_HOLD is de-asserted.

Please expand the commit message - mention that this function is
called from the sysreset driver (patch 5) and briefly describe the
rev-0 vs rev-1 register layout difference that the code handles, since
that is the main subtlety here.

Regards,
Simon
