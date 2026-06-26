Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDB2CD4F26
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 10:44:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A3A78460E;
	Fri, 26 Jun 2026 12:44:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OIskMIPS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7EFA8496E; Fri, 26 Jun 2026 12:44:54 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 596D480398
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 12:44:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-691c5776f95so1371537a12.3
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 03:44:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782470692; cv=none;
 d=google.com; s=arc-20260327;
 b=ah/P3UUDrfkGSjEV9/DlhT1s8jvESAQ/q+QlpM6PBmegFwcIP1BZylSbS6j0w1Pzeo
 2uIbSd1F0kgIMXRBswtfgnVG3cHtTHB4xgB6VG5atj17prtiPPKO0DFode1DpZ5uYP/9
 s4CUid9/vdmQ4HpzWU/SnFPnPgDjPpkxrT7kqAoJ2WaiYcxa4KPqcc76F25ts1CoEBOX
 DrHD5NVgSwVsnfbFTdOEcle1KRVZjw+gAk0nj4xiGHfxHtQuUXUR4kBR+X4LKd0xcvb/
 JU4Zinmb3sICqTeXgKKRaS2z2VwirevKJr/3nUcMVQA6/J5fjBzJTc5YxIs4UthKyMMP
 fG3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZyhyRGgDjW0R3UKBTa6oNjNP8L8mzK1svih2xZphHsM=;
 fh=nyKLZbC5pO9EO6FCB5YQSf7kr334RAPXhBSMuZ9b11E=;
 b=hU+hfzVnBUjGMUzPJlvw9/qHPqct2LuVEhB2D4nWQBgw2EVdg1mpLPa5nDA9nLZehv
 ojiGwgZ4KIqWpRelrR4eKnFbS6pd3aKqajGahk9FfjwMPqPUApWxBvbHEad4kgX9HQSU
 ZAIEbsioHh5mYdD2sus0KmmL9VXp3y5iKCJLPVJ5LMvJSk6Thq3vVZEJvE8zJROlJTw0
 qxLt4P6F8Aaq9LETBZuMWpjMpst4KXtNn9Szk3snfXEv8+oN6okCvG1OeTN4cfu7xiuB
 N8vqODXILc6mQPUx2qgRsFgmdNLT7NNiMPk3Zyg/MZDDBhcq7APUsog4ghaqxlF8USnb
 4MPw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782470692; x=1783075492; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZyhyRGgDjW0R3UKBTa6oNjNP8L8mzK1svih2xZphHsM=;
 b=OIskMIPSE6JpLlalJFFCv/e+DBRqDH0etqwo4fr2X3GErgk5puTbuibkqBuarE8F62
 DgCbSGkwknx4b8ZixTi4XW4Jt0GQeanwnfcIdd/tJrtUkAr+P6pzKdrBM3OFp13Oy+x5
 NxgdlQkOV8fTp/PEFMGPoDwlZJWZUlIAWin9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782470692; x=1783075492;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZyhyRGgDjW0R3UKBTa6oNjNP8L8mzK1svih2xZphHsM=;
 b=QZ3nkIEaD47rL45BL6tb38Q3RtFeY7NTR79k5aEBFc9MInT2uNDq/FSRouhraWKpIQ
 0HNJKkfDQmu1iPzyDraYyxRYj1XdI8aliBu9mLQFkBgg7CxdymSJKTGVP7pz1ZXyS+/C
 009M6IJH3gzBN25ckl2j7IFKrN9Lb5dS3e6TdX2AZ8oeqPqubznfEqR//DJoddbAi3Ui
 6TDZp8n+bsfmKkZoorbSee8v3qlpMqse/+yiXO5Pz7xp1cirGgJP/i7mb00pvl67XGpm
 5C0PRpoDR7+3If6hL0tOrMh8QLKOP/0RJec9ncHaLO4TL3j6cCo4OHL7ZGEkpGzpvtnc
 x/fw==
X-Gm-Message-State: AOJu0YxSsalpzp86xSwZTW00NNObtU98fbM3gEWxaB6XwIpbmf2KOFBT
 SGWIgGkZueCasD9l8uigH8Apt/DM0ySKEXg9/dspujokNUIT5p84N6/oEqS4VH5Zm8gS1LwLk3j
 SDHNjkZK4zPxN/2PYSKpAfFabAQYOsWE/HYZx/ETy
X-Gm-Gg: AfdE7ckZsnHDsS00gG/LDGi9p37BbhieO+qgNr7Sw90SlTXgiwPGywH29ycX0ePBZYR
 JDhuoCaSBmrKXYoAUUr7ksEmRbWMahcsOx3SmUKSEzqjWPPXMdQ9J3iLWZwH7sKV2X1ZO3kztuS
 qaorSxw5A5WbzwgVs+BxiNAGG8S+NUNwUnOEhqbEGea5XaYCrYbbwXYLsBY2sOitcnrTB08VSAK
 6VvVi3gipfklT3r1g6quQvqHdlVhJl/I4CWCVScFT7g7MApkokdPRZnlmII7PQoWGKeiG19tA==
X-Received: by 2002:a05:6402:a299:10b0:698:1504:e3d9 with SMTP id
 4fb4d7f45d1cf-6981504e477mr1235552a12.29.1782470691817; Fri, 26 Jun 2026
 03:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260606-pm8916-pon-v1-0-170c9cbe5099@samcday.com>
 <20260606-pm8916-pon-v1-10-170c9cbe5099@samcday.com>
In-Reply-To: <20260606-pm8916-pon-v1-10-170c9cbe5099@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 26 Jun 2026 11:44:37 +0100
X-Gm-Features: AVVi8CfqM1nby0TfueABzgdpfCla6be8qERFZhySDYbWJ-EmcrVhW4-CLMRsGr4
Message-ID: <CAFLszThbsvHJU0itxD_CwmFHF4o27-+hUEm4TsANVmi9CUo=Qg@mail.gmail.com>
Subject: Re: [PATCH 10/11] fastboot: DM_REBOOT_MODE reset support
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
> fastboot: DM_REBOOT_MODE reset support
>
> The weak symbol currently implements `fastboot reboot` support using the
> BCB. Nowadays, there's robust reboot-mode driver support which is ideal
> for this use-case.
>
> Signed-off-by: Sam Day <me@samcday.com>
>
> drivers/fastboot/Kconfig          |  7 ++++
>  drivers/fastboot/Makefile         |  1 +
>  drivers/fastboot/fb_reboot_mode.c | 51 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 59 insertions(+)

Two things on the commit message: please use single quotes rather than
backticks for 'fastboot reboot', and spell out that this provides a
non-weak override of fastboot_set_reboot_flag() - i.e. a board which
currently supplies its own override will hit a duplicate-symbol link
error if it also enables FASTBOOT_REBOOT_MODE. Either call that out,
or make the new definition __weak so existing boards keep working.

> diff --git a/drivers/fastboot/fb_reboot_mode.c b/drivers/fastboot/fb_reboot_mode.c
> @@ -0,0 +1,51 @@
> +static int fastboot_set_reboot_mode(const char *mode)
> +{
> +     struct udevice *dev;
> +     int ret = -ENOENT;
> +
> +     uclass_foreach_dev_probe(UCLASS_REBOOT_MODE, dev)
> +     {
> +             ret = dm_reboot_mode_activate(dev, mode);
> +             if (!ret || (ret != -ENOENT && ret != -ENOSYS))
> +                     return ret;
> +     }

The opening brace for the foreach loop should be on the same line as
the macro invocation - kernel style treats this as a for statement.
Please reformat.

> diff --git a/drivers/fastboot/fb_reboot_mode.c b/drivers/fastboot/fb_reboot_mode.c
> @@ -0,0 +1,51 @@
> +int fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
> +{
> +     static const char *const
> +             reboot_modes[FASTBOOT_REBOOT_REASONS_COUNT][2] = {
> +                     [FASTBOOT_REBOOT_REASON_BOOTLOADER] = { 'bootloader',
> +                                                             NULL },
> +                     [FASTBOOT_REBOOT_REASON_FASTBOOTD] = { 'fastboot',
> +                                                            'bootloader' },
> +                     [FASTBOOT_REBOOT_REASON_RECOVERY] = { 'recovery',
> +                                                           NULL },
> +             };

The hard-coded second dimension of [2] is brittle - if a future reason
needs a third fallback the table silently truncates. A NULL-terminated
list per reason (or a struct with a count) would scale better, lets
you drop the explicit NULL entries plus the continue check, and moving
the table to file scope would avoid the awkward type-on-its-own-line
split. What do you think?

> diff --git a/drivers/fastboot/fb_reboot_mode.c b/drivers/fastboot/fb_reboot_mode.c
> @@ -0,0 +1,51 @@
> +int fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)

A short kerneldoc here (and on fastboot_set_reboot_mode() above) would
help - in particular, documenting the FASTBOOTD fallback to bootloader
is non-obvious behaviour that a reader of include/fastboot.h would not
expect.

Regards,
Simon
