Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC03C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 13:43:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59EBA87FC8;
	Tue, 20 Feb 2024 14:43:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w4//74wY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B233187FBF; Tue, 20 Feb 2024 14:43:13 +0100 (CET)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B615C87FC7
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 14:43:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-47043ace534so249192137.2
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 05:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708436577; x=1709041377; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2hNazjC/9yHeGIJ/pbfgDKPL/MnhFdxlN7G+smsdd9I=;
 b=w4//74wYuCc7WnhQ+RHYl/z+GXKpq7uIGg8jQRnnJIPEOQMfS8HNNouAHZE/ALKZ1a
 kU4Z32R9dFvLpAmGEGuzrlsKGdlktJsnB0mBefFUTjyWXZFu8XuJZqQpZxn/kuPwluqG
 8aO8TgQBiGIhvcZqKq0IDl0bvqD9eKww5gHhUpIG19Yj7+bXjru7q+OuvSyi+TwWiUwZ
 CA9oPLfJF4joyqW0SlXRlEWHXBt2CoAitOHln/vnmeMJgemiBrnDX4vZtceMHYFI426K
 pb+T3mSVSW4MSxPl+Rgg33Ctb1I21rUKqt1D8KzdqrnlkBermKyX+yppkFzqHZPgJoM2
 iotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708436577; x=1709041377;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2hNazjC/9yHeGIJ/pbfgDKPL/MnhFdxlN7G+smsdd9I=;
 b=GJECM8PPVPGY9L3vNH8V4Pq3galtcRQoAA0ToskQeJNNzbziBjyHjEWgBSft7E8GbL
 ifeBn2fNde5QjcQ4b41Ud7bOi+SZBK/RWKpRD6VofyMe7OeCNjUB9FrFwJuwaoUxwpuS
 jtrDBWyMkTKwF/J565pNEcbyKE4d2lu821cd0QPOHW/iVaesRnefCjNKN9k/nLricvaU
 kYh9e5fktW2+F3YcUIQEmGUwLbVdQnso8Zru/rrbJGw7DVC8xhMx5tcWy4JXDucaxVRZ
 2A6rfjqvf0t1XwEJpxvsffMSwEUc8NOhYDabnBK38zKtiX4trTt2gD6WRayR8ejer+oM
 JMrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR9j9w7NGJ1zIjhDAjXBoGDp8y8uUXVvFmv+kiYZlrXcmxN4S5+DgxmZvazJbX9F7hzyxwxFr0bMcDR4qV70YYGfoOcw==
X-Gm-Message-State: AOJu0Yw6Whi+vEhvqZkvM5fQmyFljHHd1ZK6kdJ9KpRU9qrie2tjHnYm
 nrqV1yJowH4BCZNC3HQozeUWCRHLz4acUjoaaXSVIIdUQeZdlI6cOdWhXFURgSqVTuEDkTOguC6
 2QYwro/e5BuLlFLKqYHmUSYAAHx2HRcLhWiNjjw==
X-Google-Smtp-Source: AGHT+IFgwYZUj7zyNw0wHgzjqUI0bgRFEY0mmPy5lpJbKCgTgOt+AqAiofs6fZjpvrKwIU2W/7vnquNuViuTH+ejbtc=
X-Received: by 2002:a05:6102:5f8:b0:470:3f14:b86 with SMTP id
 w24-20020a05610205f800b004703f140b86mr6098547vsf.11.1708436576844; Tue, 20
 Feb 2024 05:42:56 -0800 (PST)
MIME-Version: 1.0
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-22-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-22-ed06355c634a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 20 Feb 2024 19:12:45 +0530
Message-ID: <CAFA6WYMutt7cGSX10AHisdqhv09xEx2XVLSOv8sWtntP4D2OCA@mail.gmail.com>
Subject: Re: [PATCH v4 22/39] mach-snapdragon: generate fdtfile automatically
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
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

On Fri, 16 Feb 2024 at 02:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> With just a few basic rules, we can generate the $fdtfile environment
> variable to match the format used in Linux. This uses the root
> compatible property inside u-boot, with specific handling for the
> Dragonboard845c which is a special case, and for the qrb robotics
> boards.
>
> This is known to work on supported platforms, and lets us avoid having a
> big lookup table.
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/mach-snapdragon/board.c | 101 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index f445bed3af00..5a859aabd5c4 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -160,6 +160,106 @@ int board_init(void)
>         return 0;
>  }
>
> +/* Sets up the "board", and "soc" environment variables as well as constructing the devicetree
> + * path, with a few quirks to handle non-standard dtb filenames. This is not meant to be a
> + * comprehensive solution to automatically picking the DTB, but aims to be correct for the
> + * majority case. For most devices it should be possible to make this algorithm work by
> + * adjusting the root compatible property in the U-Boot DTS. Handling devices with multiple
> + * variants that are all supported by a single U-Boot image will require implementing device-
> + * specific detection.
> + */
> +static void configure_env(void)
> +{
> +       const char *first_compat, *last_compat;
> +       char *tmp;
> +       char buf[32] = { 0 };
> +       /*
> +        * Most DTB filenames follow the scheme: qcom/<soc>-[vendor]-<board>.dtb
> +        * The vendor is skipped when it's a Qualcomm reference board, or the
> +        * db845c.
> +        */
> +       char dt_path[64] = { 0 };
> +       int compat_count, ret;
> +       ofnode root;
> +
> +       root = ofnode_root();
> +       /* This is almost always 2, but be explicit that we want the first and last compatibles
> +        * not the first and second.
> +        */
> +       compat_count = ofnode_read_string_count(root, "compatible");
> +       if (compat_count < 2) {
> +               log_warning("%s: only one root compatible bailing!\n", __func__);
> +               return;
> +       }
> +
> +       /* The most specific device compatible (e.g. "thundercomm,db845c") */
> +       ret = ofnode_read_string_index(root, "compatible", 0, &first_compat);
> +       if (ret < 0) {
> +               log_warning("Can't read first compatible\n");
> +               return;
> +       }
> +
> +       /* The last compatible is always the SoC compatible */
> +       ret = ofnode_read_string_index(root, "compatible", compat_count - 1, &last_compat);
> +       if (ret < 0) {
> +               log_warning("Can't read second compatible\n");
> +               return;
> +       }
> +
> +       /* Copy the second compat (e.g. "qcom,sdm845") into buf */
> +       strlcpy(buf, last_compat, sizeof(buf) - 1);
> +       tmp = buf;
> +
> +       /* strsep() is destructive, it replaces the comma with a \0 */
> +       if (!strsep(&tmp, ",")) {
> +               log_warning("second compatible '%s' has no ','\n", buf);
> +               return;
> +       }
> +
> +       /* tmp now points to just the "sdm845" part of the string */
> +       env_set("soc", tmp);
> +
> +       /* Now figure out the "board" part from the first compatible */
> +       memset(buf, 0, sizeof(buf));
> +       strlcpy(buf, first_compat, sizeof(buf) - 1);
> +       tmp = buf;
> +
> +       /* The Qualcomm reference boards (RBx, HDK, etc)  */
> +       if (!strncmp("qcom", buf, strlen("qcom"))) {
> +               /*
> +                * They all have the first compatible as "qcom,<soc>-<board>"
> +                * (e.g. "qcom,qrb5165-rb5"). We extract just the part after
> +                * the dash.
> +                */
> +               if (!strsep(&tmp, "-")) {
> +                       log_warning("compatible '%s' has no '-'\n", buf);
> +                       return;
> +               }
> +               /* tmp is now "rb5" */
> +               env_set("board", tmp);
> +       } else {
> +               if (!strsep(&tmp, ",")) {
> +                       log_warning("compatible '%s' has no ','\n", buf);
> +                       return;
> +               }
> +               /* for thundercomm we just want the bit after the comma (e.g. "db845c"),
> +                * for all other boards we replace the comma with a '-' and take both
> +                * (e.g. "oneplus-enchilada")
> +                */
> +               if (!strncmp("thundercomm", buf, strlen("thundercomm"))) {
> +                       env_set("board", tmp);
> +               } else {
> +                       *(tmp - 1) = '-';
> +                       env_set("board", buf);
> +               }
> +       }
> +
> +       /* Now build the full path name */
> +       snprintf(dt_path, sizeof(dt_path), "qcom/%s-%s.dtb",
> +                env_get("soc"), env_get("board"));
> +       env_set("fdtfile", dt_path);
> +}
> +
>  void __weak qcom_late_init(void)
>  {
>  }
> @@ -188,6 +288,7 @@ int board_late_init(void)
>         if (status)
>                 log_warning("%s: Failed to set run time variables\n", __func__);
>
> +       configure_env();
>         qcom_late_init();
>
>         return 0;
>
> --
> 2.43.1
>
