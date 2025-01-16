Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D97C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 12:20:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8194680214;
	Thu, 16 Jan 2025 13:20:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="On5qVmQj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6B7A8022B; Thu, 16 Jan 2025 13:20:48 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BEE1801B0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 13:20:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e461015fbd4so1261149276.2
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 04:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737030045; x=1737634845; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LJWrEPEwn+3bGZVL5QfsBfoyJvGf4teZbR8oyeHC/N4=;
 b=On5qVmQjMWz0Xo4HXUWpHHuOLMofpEeWGDK7GYL5Td0f/F9RSCZmOOmbbP+2y6PkLY
 qnud5Dqjv+Kd3buNwFKMAJuz7qfaLrjUi5b1bDSEz2H9WgYkmocwHRu4qfE+5qLx5d1W
 rDNTt6X8r+vOdTKH92Ux7/2gEOPIsVS8iiYXmkIUIr5x35Rm0b9DFyZaVQ+NJa4+F9Mq
 gHvHn+DT/Q7MdYIis4X1rrb7/XcbhI8/kcRfavinlQ4PdIa7wHmmweSF8P+SpJPkMLNy
 als+Tj4wvOPxi7mjWXKIl7qydgAw0N/J79VwvDUZN2dAk0DO9r3yzKly2Na+q6SJuz6r
 942A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737030045; x=1737634845;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LJWrEPEwn+3bGZVL5QfsBfoyJvGf4teZbR8oyeHC/N4=;
 b=u2fb/JHSYLbq5FpDhVYhWW9rmxhA7prRRIUNyEN+/v44jzA3+hGN9jMlOJzkboB5Ix
 Zaq0XQENroZQ4Opy9I7zfqSwTMFzlx7Nz53lKD/EpSHcP8uR3q1iD8MGaAIcvi1X4uOk
 +VxUd5iE1EgaHQu5Hbs3lR6PWegr6Tht9c+UwsK97dj7CZAt66OSbrBwzR3gMVyAvSI4
 LBujAm4dhDPMCQKakaboBpPfzHP5CItv+gJXCXLrZ+Lb2qw6YUSsbSD4FxbOrbO30KS4
 hSjUD9+Mj/P/+IdFI3o8JXY9slxGmJJeJGUwP2so0OvJYGI0BK8dg6Jdd/nv6990+xBS
 oDxw==
X-Gm-Message-State: AOJu0YztT7VZTTBpjiYDQlittd6d40q2PmLOEJDfXJc1n60S3B9wtGKF
 HDvfJizdcXgKhwOQDc7Cr4JrqsAeij34KkyLgBi72s4noBy87mtDtwkm0wDSSAS95WjRmrZN62x
 1911jLYCdHPajrUMucYQHg1utOqKtBEF9WoU+8p5t/GuRQU48CXY=
X-Gm-Gg: ASbGnctp2OtDRrwqgDc5Ir4RKGi/CvYU40rtGqLANB2snueLUl5Vb4tQB6KC0vFNdns
 MEpiahHVDpMfvT9vYLuJxCiKanU+WLvZCStUhYA==
X-Google-Smtp-Source: AGHT+IF13YfpzAdvTxDTVExVbK4vlO68AUoTqYx1AUw0DZms/z4XjdsmvgesKjbR8BFOZwCuXBlo34zU4C5Lq1aO98Q=
X-Received: by 2002:a05:690c:7447:b0:6ef:a187:f377 with SMTP id
 00721157ae682-6f5312d696bmr285601297b3.34.1737030044855; Thu, 16 Jan 2025
 04:20:44 -0800 (PST)
MIME-Version: 1.0
References: <20250115200144.951530-1-raymond.mao@linaro.org>
 <20250115200144.951530-2-raymond.mao@linaro.org>
In-Reply-To: <20250115200144.951530-2-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 16 Jan 2025 14:20:08 +0200
X-Gm-Features: AbW1kvYVCQZ-qLb7DZSXlhTQtRqofVv6bgO4TUVYoXPuJgu-IY3QK-56odpxC94
Message-ID: <CAC_iWjKXWNJ0cOCxikG4cDNiARsJEYLhATLN5jDmvG=iPiNn7w@mail.gmail.com>
Subject: Re: [PATCH 1/6] tpm: add TPM2_Shutdown command
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Tim Harvey <tharvey@gateworks.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Michal Simek <michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Wed, 15 Jan 2025 at 22:02, Raymond Mao <raymond.mao@linaro.org> wrote:

> TPM2_shutdown command is sharing same structure and logics with
> TPM2_startup, thus this patch extends the existing startup APIs and
> cmd functions to support shutdown instead of created new ones.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  cmd/tpm-v2.c     | 14 +++++++++++---
>  include/tpm-v2.h |  3 ++-
>  lib/tpm-v2.c     |  9 +++++----
>  lib/tpm_api.c    |  4 ++--
>  4 files changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
> index 8517833f86..a6d57ee7c4 100644
> --- a/cmd/tpm-v2.c
> +++ b/cmd/tpm-v2.c
> @@ -18,11 +18,14 @@ static int do_tpm2_startup(struct cmd_tbl *cmdtp, int
> flag, int argc,
>         enum tpm2_startup_types mode;
>         struct udevice *dev;
>         int ret;
> +       bool bon = true;
>
>         ret = get_tpm(&dev);
>         if (ret)
>                 return ret;
> -       if (argc != 2)
> +
> +       /* argv[2] is optional to perform a TPM2_CC_SHUTDOWN */
> +       if (argc > 3 || (argc == 3 && strcasecmp("off", argv[2])))
>                 return CMD_RET_USAGE;
>
>         if (!strcasecmp("TPM2_SU_CLEAR", argv[1])) {
> @@ -34,7 +37,10 @@ static int do_tpm2_startup(struct cmd_tbl *cmdtp, int
> flag, int argc,
>                 return CMD_RET_FAILURE;
>         }
>
> -       return report_return_code(tpm2_startup(dev, mode));
> +       if (argv[2])
> +               bon = false;
> +
> +       return report_return_code(tpm2_startup(dev, bon, mode));
>  }
>
>  static int do_tpm2_self_test(struct cmd_tbl *cmdtp, int flag, int argc,
> @@ -420,11 +426,13 @@ U_BOOT_CMD(tpm2, CONFIG_SYS_MAXARGS, 1, do_tpm,
> "Issue a TPMv2.x command",
>  "    Initialize the software stack. Always the first command to issue.\n"
>  "    'tpm startup' is the only acceptable command after a 'tpm init' has
> been\n"
>  "    issued\n"
> -"startup <mode>\n"
> +"startup <mode> [<op>]\n"
>  "    Issue a TPM2_Startup command.\n"
>  "    <mode> is one of:\n"
>  "        * TPM2_SU_CLEAR (reset state)\n"
>  "        * TPM2_SU_STATE (preserved state)\n"
> +"    <op>:\n"
> +"        * off - To shutdown the TPM\n"
>  "self_test <type>\n"
>  "    Test the TPM capabilities.\n"
>  "    <type> is one of:\n"
> diff --git a/include/tpm-v2.h b/include/tpm-v2.h
> index 65681464b3..f66a8e1bf4 100644
> --- a/include/tpm-v2.h
> +++ b/include/tpm-v2.h
> @@ -230,6 +230,7 @@ enum tpm2_command_codes {
>         TPM2_CC_PCR_READ        = 0x017E,
>         TPM2_CC_PCR_EXTEND      = 0x0182,
>         TPM2_CC_PCR_SETAUTHVAL  = 0x0183,
> +       TPM2_CC_SHUTDOWN        = 0x0145,
>  };
>
>  /**
> @@ -430,7 +431,7 @@ enum {
>   *
>   * Return: code of the operation
>   */
> -u32 tpm2_startup(struct udevice *dev, enum tpm2_startup_types mode);
> +u32 tpm2_startup(struct udevice *dev, bool onoff, enum tpm2_startup_types
> mode);
>
>  /**
>   * Issue a TPM2_SelfTest command.
> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> index bc750b7ca1..3946ac2dbb 100644
> --- a/lib/tpm-v2.c
> +++ b/lib/tpm-v2.c
> @@ -44,12 +44,13 @@ static int tpm2_update_active_banks(struct udevice
> *dev)
>         return 0;
>  }
>
> -u32 tpm2_startup(struct udevice *dev, enum tpm2_startup_types mode)
> +u32 tpm2_startup(struct udevice *dev, bool bon, enum tpm2_startup_types
> mode)
>  {
> +       int op = bon ? TPM2_CC_STARTUP : TPM2_CC_SHUTDOWN;
>         const u8 command_v2[12] = {
>                 tpm_u16(TPM2_ST_NO_SESSIONS),
>                 tpm_u32(12),
> -               tpm_u32(TPM2_CC_STARTUP),
> +               tpm_u32(op),
>                 tpm_u16(mode),
>         };
>         int ret;
> @@ -59,7 +60,7 @@ u32 tpm2_startup(struct udevice *dev, enum
> tpm2_startup_types mode)
>          * but will return RC_INITIALIZE otherwise.
>          */
>         ret = tpm_sendrecv_command(dev, command_v2, NULL, NULL);
> -       if (ret && ret != TPM2_RC_INITIALIZE)
> +       if ((ret && ret != TPM2_RC_INITIALIZE) || !bon)
>                 return ret;
>
>         return tpm2_update_active_banks(dev);
> @@ -84,7 +85,7 @@ u32 tpm2_auto_start(struct udevice *dev)
>         rc = tpm2_self_test(dev, TPMI_YES);
>
>         if (rc == TPM2_RC_INITIALIZE) {
> -               rc = tpm2_startup(dev, TPM2_SU_CLEAR);
> +               rc = tpm2_startup(dev, true, TPM2_SU_CLEAR);
>                 if (rc)
>                         return rc;
>
> diff --git a/lib/tpm_api.c b/lib/tpm_api.c
> index 39a5121e30..576d601e5f 100644
> --- a/lib/tpm_api.c
> +++ b/lib/tpm_api.c
> @@ -28,7 +28,7 @@ u32 tpm_startup(struct udevice *dev, enum
> tpm_startup_type mode)
>                 case TPM_ST_DEACTIVATED:
>                         return -EINVAL;
>                 }
> -               return tpm2_startup(dev, type);
> +               return tpm2_startup(dev, true, type);
>         } else {
>                 return -ENOSYS;
>         }
> @@ -60,7 +60,7 @@ u32 tpm_resume(struct udevice *dev)
>         if (tpm_is_v1(dev))
>                 return tpm1_startup(dev, TPM_ST_STATE);
>         else if (tpm_is_v2(dev))
> -               return tpm2_startup(dev, TPM2_SU_STATE);
> +               return tpm2_startup(dev, true, TPM2_SU_STATE);
>         else
>                 return -ENOSYS;
>  }
> --
> 2.25.1
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
