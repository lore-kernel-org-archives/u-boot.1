Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E7CCD37AA
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 21:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8826184BD5;
	Thu,  7 May 2026 23:11:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Yk3/ghaP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2868C84BE5; Thu,  7 May 2026 23:11:36 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3912484B8D
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 23:11:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ba6838e76f2so165357266b.2
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 14:11:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778188294; cv=none;
 d=google.com; s=arc-20240605;
 b=Uq9uYo7iZxysUr76wLvuGki5nRfR8q0h1eXWSBmVmOmnARs2kK1h4F+SwD3mi+54Rb
 UZIkaag0Ty4eItvE9wwWgKu9xG4gCNhYezl/gzT1uwagjFhUArr+xKosMjte2jwzv758
 W+TNVPMoRhvCEEn71SSDYUmf6eUsSBO09qZu0E6cqNXfLSNZjQFp0rnZtQyT/QRdWorU
 jlI9CBaWNyk5mzLWPr+p/Y7HTDLa2Jcrg8Z4cvsn6MAMAbIrSWSjb+Rd1Fg/HZmjg6lh
 Gfw2DuOxhilh27kgIia6/fasQI17Dps76Sz8Iu5oOVx8BBxXjRhMOZrvmgfu5CK2BczT
 Qvjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EGdQWYkruDyzqczNadnr0VQftqUkg5QRMqWQ/ByyMmw=;
 fh=qmb99AbYrxQTqbU8c3YoikZ37BstHm/br0rQHEGk45c=;
 b=IeFUvAfxWq1RYOiGAgMH++QeainauF1pzigjgxMsOCwk5E3LDz0j8lBOdtnkR4irrj
 7b/LQUYiVDRD+Xxwxx9Ru0RQHcgt+5ZBiH49fC1iEn4JpJAApftsb7AN6kiNJ3OeUbhk
 mvO/FuiNmr/SnBFxmNki3n1lAvtdyymF9qD414woPIC0+3f65FzPrawTu9LbrvWkplGq
 l3zTx7U6QkPawIqWovqSz7DLaB52peqwzgoHY8dWpG7Doa2kDhAzu263YmwVXjkjYTD6
 cYcXS8x9lu5SP2m2Ay5YUw6twJfmvRiBeGy6hSTJDFshU0DjCsWnfH77AOyyBHmu077c
 rUjg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778188294; x=1778793094; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EGdQWYkruDyzqczNadnr0VQftqUkg5QRMqWQ/ByyMmw=;
 b=Yk3/ghaPH9b+YY0v5d7HT2KQIA4jwnkh5Ptg850IPHSvUM53jg4GaOaS4hNuABzVEX
 +cvbcSnVjx4ETd5/F//NNN32KA26Pev6WPKP0c3zT5I5FVaKZvJZ2J4ktsmNd5W0RIBP
 gpxiTmCjeE/r+DEo/cKDrcLwGV2gHJ9/vUpvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778188294; x=1778793094;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EGdQWYkruDyzqczNadnr0VQftqUkg5QRMqWQ/ByyMmw=;
 b=AmbPcDOuGBSWDZ3sgOOqUwTwcbCeohgLQfKcNPY8daEr8DKqm7gK13vLEmz7a5JZOo
 gcZc2rGUKKFWYLtpg36DjzYorbg2s1XRe+CjvUvNCUPrXf0xEl2cSJ2JctKLlDMWDNJv
 MqKeaZP7J9P5K9JlTBJBsvTeE8Mi7CIJkmNjk/SGwAegndRH3tbX1MQSPR19kDgiygDe
 CbZmRv9wU56K2OcxMS3ZtBEslA9iFXf89pDJBfU4RweIheS74u/sS3j9dMATmlE/wHbL
 ewow45Ee/V8NJ7J77L7zSLqPfNsKwGcs6ibeHN50nsX2ykhdaxU89dGN9zm4GeUGRIB/
 txUw==
X-Gm-Message-State: AOJu0YxDyDE3qEWggHj0mUN4cUvitYbHENJonSWtsEKkfX7QqyQ+KgfY
 obbmxbuuKiAtRKfjDMulUiuIydM6gcDLbo1qgppkmepSPcgMOn9k6aKH1tZ07mgF12isd7YyZXA
 ezsaQQNUaiYdBw+DOAACQbaypuO6bdgGhPeAFgLW7
X-Gm-Gg: AeBDiescGWj5U4BJOH1oJyo0jS3+EXtV4VmPZIKeSPn6Yg9oS9DP0xvkRa/XxzESzOu
 /XUC/ZQ/WH6DZmPbBmHcSvqICG8h8Q26WO2oyfLsBsUd6OxYEdK18rR5IkicEOvXdo8A90gGPqp
 Xj3x132BR5T6bxaScya2sZb3Y98iSMvItqpL4zgl8HYlxYz7PFGBz90t/TfegU1DNa6A9G+6Led
 87xVi8uGbGHR5ffPs7/wDJz9xtY4v4bZ01y8A0IBXm19i/2A681/wCvk3t10ZIbeV/P6fz/hXmV
 yBarRq3tFQKwMWhB
X-Received: by 2002:a17:907:f816:b0:bc7:efc0:9625 with SMTP id
 a640c23a62f3a-bc7efc09808mr269924166b.31.1778188293534; Thu, 07 May 2026
 14:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1777984225.git.michal.simek@amd.com>
 <2a5fee05be84fa1cb333f3ab3db732311da321cf.1777984225.git.michal.simek@amd.com>
In-Reply-To: <2a5fee05be84fa1cb333f3ab3db732311da321cf.1777984225.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 May 2026 15:11:19 -0600
X-Gm-Features: AVHnY4KwC4Ptiov_P7Bk4ZtPtodaElYJ0uAuO1V_i779E-7_2T32R5d7fDbgCto
Message-ID: <CAFLszTgRUg5Dk82Gq9FVJ99cn+15Fw7RkwVsiRgZwH2tqHVS=w@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] reset: Add reset_reset() and reset_reset_bulk() API
To: michal.simek@amd.com
Cc: u-boot@lists.denx.de, git@amd.com, Simon Glass <sjg@chromium.org>
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

Hi Michal,

On 2026-05-05T12:30:28, Michal Simek <michal.simek@amd.com> wrote:
> reset: Add reset_reset() and reset_reset_bulk() API
>
> Add reset_reset() and reset_reset_bulk() functions to the reset
> controller API. These functions assert and then deassert reset signals
> in a single call, providing a convenient way to pulse/toggle a reset
> line.
>
> This mimics the Linux kernel's reset_control_reset() and
> reset_control_bulk_reset() APIs. The new functions are useful for
> drivers that need to cycle a reset line during initialization or
> error recovery but with also passing delay parameter.
>
> If a driver implements the rst_reset op, it will be called directly
> with the delay parameter. Otherwise, the reset core performs
> reset_assert(), optional udelay(), and reset_deassert() as fallback.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
>
> drivers/reset/reset-uclass.c | 34 ++++++++++++++++++++++++++++++++++
>  include/reset-uclass.h       | 12 ++++++++++++
>  include/reset.h              | 41 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 87 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

optional nits / thoughts below

> diff --git a/include/reset-uclass.h b/include/reset-uclass.h
> @@ -76,6 +76,18 @@ struct reset_ops {
> +     /**
> +      * rst_reset - Reset a HW module.
> +      *
> +      * This optional function triggers a reset pulse on the reset line,
> +      * asserting and then deasserting the reset signal. If not implemented,
> +      * the reset core will use rst_assert followed by rst_deassert.
> +      *
> +      * @reset_ctl:  The reset signal to pulse.
> +      * @delay_us:   Delay in microseconds between assert and deassert.
> +      * @return 0 if OK, or a negative error code.
> +      */
> +     int (*rst_reset)(struct reset_ctl *reset_ctl, ulong delay_us);

Please document that the core inserts a udelay(delay_us) between
rst_assert and rst_deassert in the fallback path, and clarify whether
an rst_reset implementation must honour delay_us or may treat it as a
hint. Without that, authors don't really know what to do with the
value.

> diff --git a/drivers/reset/reset-uclass.c b/drivers/reset/reset-uclass.c
> @@ -225,6 +226,39 @@ int reset_deassert_bulk(struct reset_ctl_bulk *bulk)
> +int reset_reset_bulk(struct reset_ctl_bulk *bulk, ulong delay_us)
> +{
> +     int i, ret;
> +
> +     for (i = 0; i < bulk->count; i++) {
> +             ret = reset_reset(&bulk->resets[i], delay_us);
> +             if (ret < 0)
> +                     return ret;
> +     }
> +
> +     return 0;
> +}

Just to check - pulsing each reset sequentially means the first
finishes its full assert/delay/deassert before the next starts
asserting. For the cadence_qspi case in 3/4, where multiple OSPI reset
lines are expected to be asserted together, the previous code did
assert_bulk() / udelay() / deassert_bulk() so all lines were held low
simultaneously. The new behaviour is different. Is that intentional,
and have you confirmed the cadence controller is happy with it?

Regards,
Simon
