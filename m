Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06211C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 20:02:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6999C84A3C;
	Thu,  2 Jul 2026 22:02:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NH4kymQ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D719B84A3C; Thu,  2 Jul 2026 22:02:20 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9023784409
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 22:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c95d0a54ea5so1390501a12.0
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 13:02:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783022537; cv=none;
 d=google.com; s=arc-20260327;
 b=D0mQUdPwsMN+8gz99SyMCrUogce8X+YxIPy6370qKxGNxhYvrMxj7++LETcJ5y8Zq9
 MHQR3YQ1C2I9oeSy8R52lMAx1Ramh5Fw/+kGvO5+tLeJTCd3AR6s1bvln+VyOk4GQP84
 CqNYtZzQX3x6ZX6PE0DCObOOaWKloVIbenkNSIjg15fIESTeXFCs2JJy/fr8BEyAaxGL
 YixUS85inJFpcxwgqRTtoa4LWDCqifMUAuX5FmbEBoGJZ4ZdyCM/GEB8LA88Nb2mgIdZ
 dB5Wk8CY7HVWMSZlOdcBxBsAgaj28akT6FPhg4O4PB8nyT05O2gnhoGutHm7w44BclI+
 XLaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DABMKh7qA/sO29Ys4fU92JVberClj1bPZpBBcJm9lFw=;
 fh=gzxwzQ0JdeWxpB5nlXnrO7/MJSnfsgmmfdar8xI5nnQ=;
 b=XWQaYJB6CwsoHLf5xAUmLQdDWuGgzVMMHF/EWQjjD3/OLrVeB+9mNaCz/on0NZ+ls1
 W94WVBjr43FDDdWGCZSJW4Yi0fgfB8d2Vd86jgjFKY8J0COVweHScqnpj8GLgXXi/AQC
 eX4JMxrnSEDBmjbKpxRIia/OzfVygDu7bctt0lI6ui34fUKDqQR+1POreuV9EQhfyPwM
 PooxWR14FH/kKhFFRAsNi+dByYIzNVB+5/9UVfShAf/uesuEkCQ+fcipy94edLA4BwzO
 1Ji3eYZSdMWW+JEVHjAYeNFFyaoUhHQ6Py20jrOnV+JSfK7p1z6KXnQ79nkxMiUUNld1
 RvXw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783022537; x=1783627337; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DABMKh7qA/sO29Ys4fU92JVberClj1bPZpBBcJm9lFw=;
 b=NH4kymQ7wsHsrFrP/C4sDvFbJTeE/3n8j9DtCK7E5bd3INQE77kLBCEpGI/UNYkCDH
 NBNr9NynL+vgs/tIe/9TA1MRRMv+FEVL+m6NDmnZyUS+d7r3HxHemRdNZpPSRRL4z3Lg
 44CWBTSYsrxhldlQhYPcbTRpUXMy+Mke9nBas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783022537; x=1783627337;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DABMKh7qA/sO29Ys4fU92JVberClj1bPZpBBcJm9lFw=;
 b=MxThltbecRWtuxD0bdP3sqVs41eMXWycqp0WarFzEnxf6CqYzo9LG/HTVF7KtK1q4t
 BlgSLQUnkdle/W8b/Alad5bUi78vZqBcwuCZL+ANWPMXh4Bpkfyd1ao879RJpWaWbDJO
 32bkacY6qcHDo8pKmtKuzfczZUySIGpwVgL9VBNd+bJZxbCIydhLfiWSgvmStGl1wCs1
 A0c9zsPB7dV45FeiDCft4XSYv6paxXUN6nOp3XCTBjo22M9uHTZgE3Xs2edqJ/ipu3CD
 PKfXX/8Ocv4cp5C0ce73s3thTlO6ausvwMpLyGk1poJxTAVHffMsU3ioJAVDAuKvZje1
 1rOQ==
X-Gm-Message-State: AOJu0YyCVJNQhWLDl+wnBTlyEQQ/lduoh8/NJbA2C3J359eSrZVS+sjQ
 +4CMewG6mj48NpfhNh4rs/KuZhlgjs1RbrD8RVjVc3IVvK8l6a/wrag6cjJ8y4NlGc5kvUOZdYV
 ROxPS26Kl59zTWCUnlSkohlaTMuo+JHIV988Gd8u/
X-Gm-Gg: AfdE7cnt8UT4hjx4hKp/WlaLnkR0XWTDpVQ6Uh1WZdWyBasa4t01UwnCWQhi8Ipo4jO
 xMcZOvJ08/BdtQA/iAWaoWT2Wy+iJ7p2e1d2kgNQC9NQQAZ2AiUewmz06k+VdqWJdP3h26avIkk
 DPDbTaO7BG3PvWPKkyKT4nRz86rz7d6uccqa0TQ47nEop4k41og4oDnIuEoAZiOsoTMh2Ihuyu7
 9fCbPKQwHYauaB4NzU24/FtgKC7f0wN83zQg1yZY7vzZP1S9Wea/KxhYZVdCGbG0cHCRzeyCA==
X-Received: by 2002:a17:90b:384a:b0:37f:9cdf:f0b0 with SMTP id
 98e67ed59e1d1-380aa26670fmr7785420a91.31.1783022536866; Thu, 02 Jul 2026
 13:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260702014724.1534351-1-james.hilliard1@gmail.com>
 <20260702014724.1534351-3-james.hilliard1@gmail.com>
In-Reply-To: <20260702014724.1534351-3-james.hilliard1@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 21:02:03 +0100
X-Gm-Features: AVVi8Cfe2gj6NbHIEI1vfb-6QLlcySEInJL0awyIH8UfhkvZKIOnghTh5KLXBjc
Message-ID: <CAFLszTgQDBL+aQP725JD17nRpEJhrE1C2D26M4G5xvHyDW=dUA@mail.gmail.com>
Subject: Re: [PATCH 3/9] boot: image: add FIT decrypt-to-buffer helper
To: james.hilliard1@gmail.com
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Randolph Sapp <rs@ti.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, Heiko Schocher <hs@nabladev.com>, 
 Alexey Charkov <alchark@gmail.com>
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

Hi James,

On 2026-07-02T01:46:51, James Hilliard <james.hilliard1@gmail.com> wrote:
> boot: image: add FIT decrypt-to-buffer helper
>
> FIT cipher support currently allocates the output buffer inside the AES
> helper. SPL often needs to decrypt directly into a caller-selected buffer,
> for example a load buffer or a scratch buffer used before decompression.
>
> Add a decrypt_to callback to the FIT cipher algorithm and wire it up for
> AES. The existing allocating decrypt path becomes a wrapper around the new
> helper.
>
> When DM_AES is enabled, try the first UCLASS_AES provider before using the
> software AES fallback in U-Boot proper. Return AES device errors to the
> caller instead of hiding them with a software fallback after the device has
> accepted the operation.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> boot/image-cipher.c   | 38 ++++++++++++++++++--
>  boot/image-fit.c      |  7 ++--
>  include/image.h       | 39 ++++++++++++++++++--
>  include/u-boot/aes.h  | 10 ++++++
>  lib/Makefile          |  2 +-
>  lib/aes/aes-decrypt.c | 98 +++++++++++++++++++++++++++++++++++++++++++--------
>  6 files changed, 170 insertions(+), 24 deletions(-)

> Add a decrypt_to callback to the FIT cipher algorithm and wire it up for
> AES. The existing allocating decrypt path becomes a wrapper around the new
> helper.

This patch also adds key/IV length validation in
fit_image_setup_decrypt(), a length check on 'data-size-unciphered' in
fit_image_get_data_size_unciphered() and makes the lib/aes/ build rule
phase-keyed, none of which is mentioned in the commit message. Please
can you split the validation hardening into its own patch, or at least
explain it here? The lib/Makefile change looks like preparation for
SPL support, so it might sit better in patch 4 which adds
SPL_FIT_CIPHER

> diff --git a/lib/aes/aes-decrypt.c b/lib/aes/aes-decrypt.c
> @@ -4,37 +4,105 @@
> +     unsigned int aes_blocks, key_len = info->cipher->key_len;
> +     int ret = -ENOSYS;
> +
> +     ret = image_aes_validate_lengths(info, cipher_len);

The -ENOSYS initialiser is dead, since ret is immediately overwritten
by the validate call. So in an XPL build with DM_AES disabled the
function falls past both the DM and software paths and returns 0
without decrypting anything. Kconfig prevents that combination once
patch 4 makes SPL_FIT_CIPHER depend on SPL_DM_AES, but silent success
here would be nasty to debug. Please return -ENOSYS explicitly when no
implementation is available

> diff --git a/lib/aes/aes-decrypt.c b/lib/aes/aes-decrypt.c
> @@ -4,37 +4,105 @@
> +                     ret = dm_aes_set_key_for_key_slot(dev, key_len * 8,
> +                                                       (u8 *)info->key, 0);
> +                     if (ret)
> +                             return ret;
> +
> +                     ret = dm_aes_select_key_slot(dev, key_len * 8, 0);

Just to check, is it safe to assume key slot 0 is free on all
UCLASS_AES providers? On Tegra, slot 0 is TEGRA_AES_SLOT_SBK, holding
the secure boot key loaded by the bootrom, so writing the FIT key
there would clobber it (see arch/arm/include/asm/arch-tegra/crypto.h
and tegra_aes.c). It might be safer to pick the last slot reported by
dm_aes_available_key_slots(), or make the slot a parameter. What do
you think?

Regards,
Simon
