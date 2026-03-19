Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B66109192A
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 22:09:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2820383FDE;
	Thu, 19 Mar 2026 23:09:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BwivFXJr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5213883FE1; Thu, 19 Mar 2026 23:09:17 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAC3C83FD9
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 23:09:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b97f9587e6eso168284766b.3
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 15:09:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773958154; cv=none;
 d=google.com; s=arc-20240605;
 b=TNyU05cjCw3aQqF4/3p76bH5rzXiS5BihCiIr4/ERRwlYpGb8fYjFs6cYWJvbSM2/W
 qFcdUhOwZ5x1P8xwDdkzhyjBTn1KI1bS9mw2+YrBiXYJlkRVaeSc07u+8Iu70Vw/PNTo
 bG7/GHJXvb2vRuQ9/PmOL8wVT2YbPWKtJKlvVowaGFSiFvM0s/pbJqDE51ccnWnWmzH4
 VTuS+wxQrt7kmidCaWDOXs+1DxtO51AG7QOTBD4t27Q/xAh/rInmXFV1Ff4GoueeXUlX
 WFEKtnsSZmCrSy5sM6TfqekS1ipO0QJocN+dFkhhx9vj0gv1ZKTlvdX4jmXrlpfMiv/J
 QO+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TW2be1FCHCTaf4M0uj1ULUdtjj+XnPi78+/apcfXSJk=;
 fh=ouzfjbKpnG0Ece5Ipm6O35Zwg/8RWpznJgqNQWh9d8A=;
 b=Gi2UlovUiKnTdd8FXdGJ7rmfQZ7O4E6fC6SfNjkdnRrqmq4XUE4l/PEzylrMNeuyLj
 zpGORoJpP3ANqD+ZNdCVyb0ceMIxMYyWYSp9vKTR+N1oPXCoXtvrX3f8H5EL9uLT4KtO
 su08fDk0ic4z1zaaCV7mpbXyoul73qu49PJLCXMP9jMv4R+yQxZaP0m1IuUIWsgma2zC
 i4DQp18lK/v5zIitfhqq6Vf7xL3noo9tp1qQqGRTRGbdI/4ta6ld6C1MV4SF4lM7bOyx
 tDKo2QLbfNxeHREY9UFVu+lfTKBgXgu6X1/5lJsRfDHaqlCNZW3t1XJ4b9jha6fGxqMy
 6d6Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773958154; x=1774562954; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TW2be1FCHCTaf4M0uj1ULUdtjj+XnPi78+/apcfXSJk=;
 b=BwivFXJrJudK8Hrt8RatfgOkAoqE9DcZDAX8KrM5akXxSKHob6YhHNjfbtnfChqAfg
 FDTJc0u3Ri+yFUl7WAdwzHTAaXc5VL1ehsP78l7U2DfiGrDVl8+uDdg0Mm3lWLwuKqrC
 loupe+40Pc2MkE1msGr5B7F/AU598PptsTrs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773958154; x=1774562954;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TW2be1FCHCTaf4M0uj1ULUdtjj+XnPi78+/apcfXSJk=;
 b=VHVII1q0J7svvtIOR8k66wRGzzKyskwTmZvO06tI9mN/5BRRSu1x8hQJ4uqyn4mQj1
 kRTFWJRiGMbnwgb3bUtSphWQNWav2+82Owhn49k/EaMSgDgXQOyxd28dMYxzpLKJvOkX
 6i/OKtNREFbF0Z5Ci2IaGgLtZyswnx8izN8TU01vxTebb+tQhSFzPb9KpCThtjVprfwP
 UyIBLWpkiB8LsPW/C/OU43wgyAR9Vv89lM2Nt5C/dMNmlY8ZY5EjJHKk1gNWpwoW1chU
 p2Kl7X8tS7nl5dWEVW1DbBYRsfwVmpjQ2YKsZfhoqSJU1xdwDk5mf2+1Z2t4zNzYuTt7
 eqJw==
X-Gm-Message-State: AOJu0YxOZE8PQ+fstKT8hpkhUdUIwOOhI9AYmu3lrqZFzzG3xATZv1iV
 J9tUJgT/JaGdxAKY4VefAKNnxbY2qJqvNniu+wrcCOyDfs6BgwnMujzOSR8MIDnLIDb7taNTWt1
 PlKoUObWj9QDlCZifHuKYp93el4bDFMlorzbNM2Xm
X-Gm-Gg: ATEYQzx7V72pgXpLGC+Pp7QnvMb5JaPGT1LcG2eNSLnzqsl9y95F09FWGCi501uA0DN
 HomNe6NUjw9mw5mze0OER7hDZJK3lvGDPdaJZwfzJb79KvqTLEropD4tU/sf3ZHokz18WQugXsY
 Icp1bGpZXZjFsc786I3dqY+CzYc2mQYvp63SC/q8lhxBLKHhrhkYyCTFrKUobW10lIZuoR7tmNs
 HLqvUCPJ08WBXWrVRd1slKoDVRK1SBvFMr4gGn1HUwZXrtb9MKg+QjwW8VK+NNX0XkZuz7K0ryr
 4IS9E/o8
X-Received: by 2002:a17:907:7638:b0:b87:1eaf:377c with SMTP id
 a640c23a62f3a-b982f35e715mr45637766b.38.1773958154287; Thu, 19 Mar 2026
 15:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1773840306.git.michal.simek@amd.com>
 <44aa0bf04c8e2517b51c37cce5069cbc24c69f16.1773840306.git.michal.simek@amd.com>
In-Reply-To: <44aa0bf04c8e2517b51c37cce5069cbc24c69f16.1773840306.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Mar 2026 16:09:02 -0600
X-Gm-Features: AaiRm50FxfmI0pUfUnnwovDEZnMZ5304pStTcyDiNE9ju9cKdBB1uT0N0oFrC50
Message-ID: <CAFLszTitBnkcWRTyLc=4x+=CJQO4+==Na1UVtdN6Y3CNknYqug@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] event: Introduce EVT_POST_PREBOOT event
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, xypron.glpk@gmx.de, 
 ilias.apalodimas@linaro.org, Casey Connolly <casey.connolly@linaro.org>, 
 Tom Rini <trini@konsulko.com>
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

On Wed, 18 Mar 2026 at 07:25, Michal Simek <michal.simek@amd.com> wrote:
>
> Add a new EVT_POST_PREBOOT event type which is fired in main_loop()
> after the preboot command has been executed.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
> Changes in v2:
> - check return value
>
>  common/main.c   | 4 ++++
>  include/event.h | 9 +++++++++
>  2 files changed, 13 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/common/main.c b/common/main.c
> index b0b6e74f5d3d..4b4504557f6e 100644
> --- a/common/main.c
> +++ b/common/main.c
> @@ -19,6 +19,7 @@
>  #include <net.h>
>  #include <version_string.h>
>  #include <efi_loader.h>
> +#include <event.h>
>
>  static void run_preboot_environment_command(void)
>  {
> @@ -53,6 +54,9 @@ void main_loop(void)
>         if (IS_ENABLED(CONFIG_USE_PREBOOT))
>                 run_preboot_environment_command();
>
> +       if (event_notify_null(EVT_POST_PREBOOT))
> +               return;
> +
>         if (IS_ENABLED(CONFIG_UPDATE_TFTP))
>                 update_tftp(0UL, NULL, NULL);
>
> diff --git a/include/event.h b/include/event.h
> index 1d267f1d1054..3ce5f992b04e 100644
> --- a/include/event.h
> +++ b/include/event.h
> @@ -153,6 +153,15 @@ enum event_t {
>          */
>         EVT_MAIN_LOOP,
>
> +       /**
> +        * @EVT_POST_PREBOOT:
> +        * This event is triggered in main_loop() after the preboot command
> +        * has run, so that devices initialised by preboot (e.g. USB, UFS)
> +        * are available to event handlers. Its parameter is NULL.
> +        * A non-zero return value causes the boot to fail.
> +        */
> +       EVT_POST_PREBOOT,
> +
>         /**
>          * @EVT_OF_LIVE_BUILT:
>          * This event is triggered immediately after the live device tree has been
> --
> 2.43.0
>
