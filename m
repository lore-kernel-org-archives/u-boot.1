Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1297DCCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 09:35:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57B1E83A79;
	Tue, 11 Nov 2025 10:35:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DympctAR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC98A83A83; Tue, 11 Nov 2025 10:35:33 +0100 (CET)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A792839D6
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 10:35:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-640d4f2f13dso2592000d50.1
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 01:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762853730; x=1763458530; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wIIN+QksbpSLdXJlUqAGfDOFcBomoY1T+IiDH2Ajvds=;
 b=DympctARkfcjFJ512D46eiGoqx9VYbUhRq8AJ5XV38cl5/4hHxADc6t/eyg+FDt6Xu
 4X/Vc8s3sy6dEP3o570tnkIREb+jzlei4JkoQXunCxZzyCiXljq4WtXU743j2bHRRWYa
 g0Qywd2sfY/C7nufz1prgcpbu7cGSq8c7vg/HFe41cZDyAJAzt4KndbrJNxPcNt3VM3h
 2bXvgAHPqd9Ji1G/pscAmgJg8xEAN/L7W/LU2PJxpaRMAYYVBN/F9VVVF/CjUsmFRSTZ
 v3Hxi6mAfmsjg0g/zE3AhJnn+0ay3iZb5Pwdb89Lhjk3z1KPh9uDfVvVb1mVpq5uROQs
 VvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762853730; x=1763458530;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wIIN+QksbpSLdXJlUqAGfDOFcBomoY1T+IiDH2Ajvds=;
 b=AxIcNWwRPy3mKIgIirTssMSuamlvu5pc9dBnIzf3NksDoY/i0xxbr3Rr954/l6109J
 6D7yoMd9JTaBvC4cconjdsOJvncM4S8Gs1ZwwjLH8KkSJHq5UOl7Tw9oxk1pamjv2n6g
 BCtHD12xXsiqUFa4vVV5rXH1i9Fjz6bj5+KRPwtnsf6yNj/MJeHlXy/kjqfoNf4Gp+XF
 ydxu5PP9Ue+wEDEeKuIOLBfJqGWqGJ0ICsYMAH/AfwlLEWcdvrHUf1zAZjinXD8Mgl4l
 NyYmIdfPO6SExP1g7xJ/gw3nSi+CZkOUfWxjAsqrE1I0tuVNQwhxOYMMP30USZRmruii
 bTBQ==
X-Gm-Message-State: AOJu0YzfwRJNsSPPkoFcXQFtN2yT/TpkphE3xOYLAMwuGDNB46dl6AVV
 fOFxqNEvtRTSMLJemW2/rp2h+VJjnJRtQsMKPdCyRMJWLq7LB+htHiW7V94GFxhXrlc07tCUCeC
 3CbiWeVrWUtnhunRiIwIc/NgJErcZc7oYVIGTMIedRQ==
X-Gm-Gg: ASbGnctyp6XYUpgVmerQuMBMNd/vo+Kq7VX+J/zfFnB4QOdOx/EgK3SQ58h84almJbB
 BfPsO1ed932yeheyVFgPekliMdo3OU6ODg7ZoFCYZlGMevpnjH1wrKbKSW4FZhJ/ibObH6k4iG/
 PAX5Uw+5VguVNlq8JsukR5zMiCg8sJv6LIJFltNo5B/YvGXooDy1m334ljz8Y13FAchSovvhYJv
 6mDZhXd4ThC5mPM8uqKQ+f/agAAEtsN2llukuA2YDu46MGsQLrmc1/akxoR3PPlowIqSaIrUV7Y
 5wBxERxoMm2HLK8PbargW0PdLY7DEPrlCefcod2DKDdYKB1Lq90=
X-Google-Smtp-Source: AGHT+IGI3xJprrk5z/ZFnKrVwxb9Kubfd/KouEwjOkcfgqGAb+gbfcfiNOLXpXnRyC6N7CPzEhElELJTvmkytSkldQ4=
X-Received: by 2002:a05:690e:4294:20b0:63c:f349:cb97 with SMTP id
 956f58d0204a3-640d45c6930mr7425991d50.41.1762853730301; Tue, 11 Nov 2025
 01:35:30 -0800 (PST)
MIME-Version: 1.0
References: <20251111054813.1966-1-hs@nabladev.com>
 <20251111054813.1966-5-hs@nabladev.com>
In-Reply-To: <20251111054813.1966-5-hs@nabladev.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Nov 2025 11:34:54 +0200
X-Gm-Features: AWmQ_bmJPGDaJbxqEzQIg5Zyde3mT3fmy1RZw3qmr-AuA2GO17PY6P2mYnOoOpA
Message-ID: <CAC_iWjLjxtPV0SF0XHmB3WJ_4EOzPRLC-YvLXt0QpUUrZDnmtg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] tpm2: add sm3 256 hash support
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Heiko,

This all looks reasonable.
There's one place I forgot to mention though.   tcg2_hash_pe_image()
also needs SM3 support.

The easier way to test that SM3 is working is boot your device and
look at the PCR measurements
- 'tpm2_pcrread' -- The SM3 bank should be != 0
- tpm2_eventlog /sys/kernel/security/tpm0/binary_bios_measurements
should also include SM3

Thanks
/Ilias

On Tue, 11 Nov 2025 at 07:48, Heiko Schocher <hs@nabladev.com> wrote:
>
> add sm3 256 hash support, so TPM2 chips which report
> 5 pcrs with sm3 hash do not fail with:
>
>   u-boot=> tpm2 autostart
>   tpm2_get_pcr_info: too many pcrs: 5
>   Error: -90
>
> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>
> ---
>
> Changes in v2:
> add comments from Ilias
> - use ARRAY_SIZE(hash_algo_list) instead of a fix number
>   in tpm2_get_pcr_info() for the count of supported hashes
>   in U-Boot.
> - add SM3 hash in tpm_tcg2
>
>  cmd/tpm-v2.c     |  1 +
>  include/tpm-v2.h | 12 ++++++++++++
>  lib/tpm-v2.c     |  4 ++--
>  lib/tpm_tcg2.c   |  9 +++++++++
>  4 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
> index 346e21d27bb..847b2691581 100644
> --- a/cmd/tpm-v2.c
> +++ b/cmd/tpm-v2.c
> @@ -589,6 +589,7 @@ U_BOOT_CMD(tpm2, CONFIG_SYS_MAXARGS, 1, do_tpm, "Issue a TPMv2.x command",
>  "        * sha256\n"
>  "        * sha384\n"
>  "        * sha512\n"
> +"        * sm3_256\n"
>  "    <on|off> is one of:\n"
>  "        * on  - Select all available PCRs associated with the specified\n"
>  "                algorithm (bank)\n"
> diff --git a/include/tpm-v2.h b/include/tpm-v2.h
> index f3eb2ef5643..a776d24d71f 100644
> --- a/include/tpm-v2.h
> +++ b/include/tpm-v2.h
> @@ -345,6 +345,18 @@ static const struct digest_info hash_algo_list[] = {
>                 false,
>  #endif
>         },
> +       {
> +               "sm3_256",
> +               TPM2_ALG_SM3_256,
> +               TCG2_BOOT_HASH_ALG_SM3_256,
> +               TPM2_SM3_256_DIGEST_SIZE,
> +#if IS_ENABLED(CONFIG_SM3)
> +               true,
> +#else
> +               false,
> +#endif
> +       },
> +
>  };
>
>  /* NV index attributes */
> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> index 5b21c57ae42..f443b738f82 100644
> --- a/lib/tpm-v2.c
> +++ b/lib/tpm-v2.c
> @@ -686,10 +686,10 @@ int tpm2_get_pcr_info(struct udevice *dev, struct tpml_pcr_selection *pcrs)
>
>         pcrs->count = get_unaligned_be32(response);
>         /*
> -        * We only support 4 algorithms for now so check against that
> +        * check against the supported algorithms in hash_algo_list,
>          * instead of TPM2_NUM_PCR_BANKS
>          */
> -       if (pcrs->count > 4 || pcrs->count < 1) {
> +       if (pcrs->count > ARRAY_SIZE(hash_algo_list) || pcrs->count < 1) {
>                 printf("%s: too many pcrs: %u\n", __func__, pcrs->count);
>                 return -EMSGSIZE;
>         }
> diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> index c314b401d0b..d41228f75a9 100644
> --- a/lib/tpm_tcg2.c
> +++ b/lib/tpm_tcg2.c
> @@ -12,6 +12,7 @@
>  #include <u-boot/sha1.h>
>  #include <u-boot/sha256.h>
>  #include <u-boot/sha512.h>
> +#include <u-boot/sm3.h>
>  #include <version_string.h>
>  #include <asm/io.h>
>  #include <linux/bitops.h>
> @@ -143,6 +144,12 @@ int tcg2_create_digest(struct udevice *dev, const u8 *input, u32 length,
>                         sha512_finish(&ctx_512, final);
>                         len = TPM2_SHA512_DIGEST_SIZE;
>                         break;
> +#endif
> +#if IS_ENABLED(CONFIG_SM3)
> +               case TPM2_ALG_SM3_256:
> +                       sm3_hash(input, length, final);
> +                       len = TPM2_SM3_256_DIGEST_SIZE;
> +                       break;
>  #endif
>                 default:
>                         printf("%s: unsupported algorithm %x\n", __func__,
> @@ -319,6 +326,7 @@ static int tcg2_replay_eventlog(struct tcg2_event_log *elog,
>                         case TPM2_ALG_SHA256:
>                         case TPM2_ALG_SHA384:
>                         case TPM2_ALG_SHA512:
> +                       case TPM2_ALG_SM3_256:
>                                 len = tpm2_algorithm_to_len(algo);
>                                 break;
>                         default:
> @@ -431,6 +439,7 @@ static int tcg2_log_parse(struct udevice *dev, struct tcg2_event_log *elog,
>                 case TPM2_ALG_SHA256:
>                 case TPM2_ALG_SHA384:
>                 case TPM2_ALG_SHA512:
> +               case TPM2_ALG_SM3_256:
>                         len = get_unaligned_le16(&event->digest_sizes[i].digest_size);
>                         if (tpm2_algorithm_to_len(algo) != len) {
>                                 log_err("EventLog invalid algorithm length\n");
> --
> 2.20.1
>
