Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7839FC44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 18:39:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD0C284C7E;
	Wed, 15 Jul 2026 20:39:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RrAbFd2X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 518B884C83; Wed, 15 Jul 2026 20:39:09 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B0CD84C42
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 20:39:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-698e5859a3cso1767045a12.0
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 11:39:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784140747; cv=none;
 d=google.com; s=arc-20260327;
 b=kgQ/26l+zy0px90+WN0W4i0c0L7fs5GLuHMM+z3ZnL9GceN6lpEFexYqEEepOmosV7
 BzHeuvyij5CEHpFeZDVUJpR03HZSHogWiO01mF0MjNit6IE57caNNx4SVMSz+7JCfJWA
 udrWfCRiblwvNjhWQ+ae/0VMzUAkeUrsC1o3EUY8tJygoGfQDqRH9Ha5cgnVhEhHjKGl
 jf8R/R0YYiRWUxAh3AdNuaQd0U+QYBzSg8SqaQ+YqJP76ialDwFA3EgftjVKs87Y4TTL
 RReYPIGcF0GYmwOJcNzihmrPFDHJyhKZ9AlkpFadMZwv+vOFOPu1FhQ81uqquXi7qqhw
 UWCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3SYK+p0ul/BITm9myxMKVDRABv3ivOC7mRe3DJ8bm5o=;
 fh=iJRW8VB93FX08DrH3y1pKDG0/UVKiIyyGubq8HI//Y8=;
 b=OD+T4ZaPHBOgITOlXw7VhMyO2cJuQKyXb5yG+ONLaaSgkJfX9eLcFVbP2e75I8/Tap
 iJEk7sa6SmwWmxYrYukrfxIfkeRbTm/hkCqTO928B8wKGJde5UNL2zK5MHMJYJ8V235k
 SJpyeg4bhzikKn+1YFWfHDrtVpHp0Owwed3MwzpgbU7eCFM7ghzw0FlSCW3D0ncgnoA6
 +O79YziExU3Wlk54XjKDfwSslwmXwdQ6h9A9ygqXqB/D6At5G7ar3EuDAqVl4RVNLxT5
 fmUTjTx8XzHNbRyFtq4Mdi0MhvKSM7uF2Vu0DW617+HwAN9gGkEPsblJEP2HQpLcdqGp
 z2sg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784140747; x=1784745547; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3SYK+p0ul/BITm9myxMKVDRABv3ivOC7mRe3DJ8bm5o=;
 b=RrAbFd2Xc4uqDsffB3xj4AoWlrEHAuUk8a8TZma2lBtMtjnrjOTwSvGqr8dU6IHk6v
 GrXaL7T3eviCLfTUJwMoYRqGRVd+437eHjGPmoJCAutFH4pmSFAKJhmetnuEBSOwZzkO
 +MWVuYIKt4NtnjOuqTlBHey12f7tP8CtJSEgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784140747; x=1784745547;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3SYK+p0ul/BITm9myxMKVDRABv3ivOC7mRe3DJ8bm5o=;
 b=rzZulFtcs5hp3Ss6AAA2PfjHmO1gg+w+A4g78hTSe0hkm8IlPeWBzA/vBXEask10Ff
 HTYK6HkV2/UfMYKJUqcELttu7Q3AHddazHV7x4Igext6HKpLhhKTiRSFy4236cKjaipM
 klZQgFr/gN/I6NVOKZ1QDJ8JKXj5efw6rk8v6KH6nm4uW39UAyJDFRjKmPD5qhYbKyLS
 o255rxTOfAeW6q2N2XafTa0+Ek1AwPnGMpSYZTybiN0WcuvtDnT24vdiZxmJb+Wmo1pO
 KDQwoiZBTfXDCqhgU1M20jfBVbNhJt0y0dlDK8KbLneR9Xc26n43PIAfeJSl+EuMOFnt
 Uftw==
X-Gm-Message-State: AOJu0Yy2WQ7XPrJMSnXZYtV/Fd20zmCYCyyLbKMRk9JAiuyqaSsm9GHC
 BmtznwzGWoBxaoIcMGi0491gcx1pNVwvVe25f8xrH1m2ZFg75llKKdgvfYOjLKDVScWZo9xQyE/
 fZtiIRLZFoCDvTXbLyiin8h94k1/5mOVbK6dCleqF
X-Gm-Gg: AfdE7clL7pib0RzN+rONkhe3vOhUYgZOhXdKCm+Yx+CiXoBOKDKpAlcDQN3owQzo//e
 nPNf+Ae/jY2iv0Zqjb5oPZ7sYXjsYiV7RwJAeXbSrFCcA7YEss5aie6BsBJSewtBtfh++jGvKTn
 aHxKspNTWxiISImUbHfldLNCYfzmXpA9d3fm2EeBFPXEE5apk8VM8v5L0uN66eUPwfj4/Ay1zp8
 2epN7/tamlUJQSqKZDAVDwpjzXJULg3k1r0eRc3giNLA8qiDtbVGHjBc9EBOVKdNNPUaEs=
X-Received: by 2002:a05:6402:a29c:20b0:698:3b7c:3b30 with SMTP id
 4fb4d7f45d1cf-69e2d750776mr253800a12.18.1784140746864; Wed, 15 Jul 2026
 11:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260710-rinta-watchdog-gettime-v1-0-9a982fb93f49@nokia.com>
 <20260710-rinta-watchdog-gettime-v1-3-9a982fb93f49@nokia.com>
In-Reply-To: <20260710-rinta-watchdog-gettime-v1-3-9a982fb93f49@nokia.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Jul 2026 12:38:15 -0600
X-Gm-Features: AUfX_myt2XrVF0GNAcTzTQuJqwrxIyiALho04XKM43sSrSw6P0QOzZZ8a0SHjjU
Message-ID: <CAFLszThfsOQozDXqYqj+zq-QFFNf7kf8gbHsm0Rvd+pDt8=d3A@mail.gmail.com>
Subject: Re: [PATCH 3/6] watchdog: sbsa_gwdt: add get_timeout operation
To: juuso.rinta@nokia.com
Cc: u-boot@lists.denx.de, Stefan Roese <stefan.roese@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Yao Zi <me@ziyao.cc>, 
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>
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

Hi Juuso,

On 2026-07-10T04:51:17, Juuso Rinta <juuso.rinta@nokia.com> wrote:
> watchdog: sbsa_gwdt: add get_timeout operation
>
> Implement the get_timeout operation for the SBSA watchdog driver.
>
> Add a timeout_ms field in sbsa_gwdt_priv.
>
> In sbsa_gwdt_start(), store the clamped timeout value
> written to the register to the timeout_ms field.
>
> In sbsa_gwdt_get_timeout(), write the effective timeout
> to *timeout_ms.
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
>
> drivers/watchdog/sbsa_gwdt.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

> diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
> @@ -46,6 +47,14 @@ static int sbsa_gwdt_reset(struct udevice *dev)
> +static int sbsa_gwdt_get_timeout(struct udevice *dev, u64 *timeout_ms)
> +{
> +     struct sbsa_gwdt_priv *priv = dev_get_priv(dev);
> +     *timeout_ms = priv->timeout_ms;
> +
> +     return 0;
> +}

If this is called before the watchdog has been started (now possible
from the shell via 'wdt gettimeout' in patch 2), it returns 0 as if
that were a valid timeout, since priv is zeroed on probe. Please can
you return an error (e.g. -ENODATA) in that case, or better, drop the
cached field and read WOR back from the hardware:

    u32 wor = readl(priv->reg_control + SBSA_GWDT_WOR);

    *timeout_ms = lldiv((u64)wor * 2 * 1000, get_tbclk());

That reports the true hardware state, works even if the watchdog was
set up by an earlier boot stage, and removes the need for the new
'timeout_ms' field and the change in sbsa_gwdt_start(). What do you
think?

> diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
> @@ -65,6 +74,7 @@ static int sbsa_gwdt_start(struct udevice *dev, u64 timeout, ulong flags)
> +     priv->timeout_ms = clk ? (tout_wdog * 2 * 1000) / clk : 0;

This 64-bit division needs lldiv() to build on 32-bit platforms -
plain '/' can pull in libgcc helpers. The same applies if you take the
read-back approach above.

Regards,
Simon
