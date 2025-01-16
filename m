Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F513C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 12:37:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A1558022B;
	Thu, 16 Jan 2025 13:37:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LJffBl63";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9CFB80283; Thu, 16 Jan 2025 13:37:39 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70F01801B0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 13:37:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e54bd61e793so1624858276.2
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 04:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737031056; x=1737635856; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mJPMobiAMXOQPpOQp7l4sRsVUR6IHKff0bR37X8CoZM=;
 b=LJffBl63qO/JhJI41rBinXruH/3kFybgvixbe7hDQPUECaYCylaRIRho4TuDLGBPim
 8YSrWw9m+GthGsB0bfqsbmQFCoS61+Svmp6lEeCbjpeN4qTu/vBCDUAhPy5kFLDes9By
 fQaQkpNx7iUpuLFCqIuXqEfvOcTAraBap/M5szbvJsveUL/OB8+V3JBiQYNMhXvOSCHz
 hxNOrocLA7PrpQSYz3INd06M/1LCA8jXtO386oTZ2i3pTk2kVTYZUWgPQNVRpun9XTVe
 5fJq1OUpg5qyGwxqb7ME4s9Pl2xnHKYJg5vLULlbxdWI8C1tCnd3mr/7L+LTG6aR5Qvd
 2TtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737031056; x=1737635856;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mJPMobiAMXOQPpOQp7l4sRsVUR6IHKff0bR37X8CoZM=;
 b=h1Zdbcb+rfq9aw1n/aTWWWeXeZo9yGkSwfd5uBjeztojJqJiIgUAmpqiaVsI5DU2vG
 zzoP/DX+Hiz6qdTEA2f4PC/v8FpMQ+ldwxKTzmEaP8snJMqU6BojV0ZAW/3M6rbZg6u1
 U1zU8LFzgvPEUhMPYlMOdQmb2n+WP2x8Td0BHqGmapGcknkDsJuFK1xhkLmsHNyu9Z1y
 yTcapvrDaKQxwq1Lg4L3uSmIC3O0j2VQALSdGM5LFYbSq7w/mfwKNGCkjwfLuvprJrhQ
 NsXNgQ50nXTB/6be132zggIv+dUG7j1uMpSp+l4HpzlKz58F153HbH9D2w8hkpylqSWw
 SRTg==
X-Gm-Message-State: AOJu0Yw/4OUpN4q9j9+FoJ7MrhJ2s/m+Pe4m2mLbtl94i11Oc5FBJe3Y
 DVIL+Ad/OhwOamurnaoqJejSAF0+ZjwYs82V47PicdmckekXe7HySTyePliaLH+YzdHfs/vKESj
 cym5jh6JfMZmmkn62NVttCFBoZ4Bv724byEdAKg==
X-Gm-Gg: ASbGncuPUnwVy24R2N4g4F7xN8QCaCQYQbFopMXxKPBAbk1v9a69PSw286b8DVFijoI
 msfQ6cHl5aJbo/fi+lSryNJ7LXa5889KYq60BRA==
X-Google-Smtp-Source: AGHT+IHyprmB4miMqO/VxzRcJnHuHgBGRgR2ypUPqJpqoPZWIsFYAZT9lN9Snxy69bcaH91A44/g5G3toNRf/wTREME=
X-Received: by 2002:a05:690c:3804:b0:6ef:4a1f:36d6 with SMTP id
 00721157ae682-6f531249a60mr257980957b3.23.1737031056284; Thu, 16 Jan 2025
 04:37:36 -0800 (PST)
MIME-Version: 1.0
References: <20250115200144.951530-1-raymond.mao@linaro.org>
 <20250115200144.951530-3-raymond.mao@linaro.org>
In-Reply-To: <20250115200144.951530-3-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 16 Jan 2025 14:36:59 +0200
X-Gm-Features: AbW1kvYcavxZjVtaDvZZUqWPHg19K-4rm9l4iaPSemmswtg4AbukbKjSobPQ43A
Message-ID: <CAC_iWjKgoNdON5u2GHjKT+HPwt9hd+JkD6k48VeMWoWoFLbmpQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] tmp: add TPM2_PCR_Allocate command
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Tim Harvey <tharvey@gateworks.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Michal Simek <michal.simek@amd.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>
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

Hi Raymond,

On Wed, 15 Jan 2025 at 22:02, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> TPM2_PCR_Allocate command is required to re-configurate


reconfigure

> a TPM device
> to enable or disable algorithms in run-time, thus this patch introduces
> the implementation of PCR allocate APIs and adds related cmd functions
> for testing.
>
> To test the feature, ensure that TPM is started up.
> Run pcr_allocate command to turn on/off an algorithm, multiple calls
> are supported and all changes will be cached:
> `tpm2 pcr_allocate <algorithm_name> <on|off>`
> Run startup command with argument 'off' to shutdown the TPM.
> `tpm2 startup TPM2_SU_CLEAR off`
> Reboot the board via `reset` to activate the changes.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  cmd/tpm-v2.c     |  94 +++++++++++++++++++++++++++++++++++
>  include/tpm-v2.h |  29 +++++++++++
>  lib/tpm-v2.c     | 124 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 247 insertions(+)
>
> diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
> index a6d57ee7c4..2302e8e94c 100644
> --- a/cmd/tpm-v2.c
> +++ b/cmd/tpm-v2.c
> @@ -232,6 +232,86 @@ unmap_data:
>         return report_return_code(rc);
>  }
>
> +static u32 select_mask(u32 mask, enum tpm2_algorithms algo, bool select)
> +{
> +       size_t i;
> +
> +       for (i = 0; i < ARRAY_SIZE(hash_algo_list); i++) {
> +               if (hash_algo_list[i].hash_alg != algo)
> +                       continue;
> +
> +               if (select)
> +                       mask |= hash_algo_list[i].hash_mask;
> +               else
> +                       mask &= ~hash_algo_list[i].hash_mask;
> +
> +               break;
> +       }
> +
> +       return mask;
> +}
> +
> +static int do_tpm2_pcrallocate(struct cmd_tbl *cmdtp, int flag, int argc,
> +                              char *const argv[])
> +{
> +       struct udevice *dev;
> +       int ret;
> +       enum tpm2_algorithms algo;
> +       const char *pw = (argc < 4) ? NULL : argv[3];
> +       const ssize_t pw_sz = pw ? strlen(pw) : 0;
> +       static struct tpml_pcr_selection pcr = { 0 };
> +       u32 pcr_len = 0;
> +       bool bon = false;
> +       static u32 mask;
> +       int i;
> +
> +       /* argv[1]: algorithm (bank), argv[2]: on/off */
> +       if (argc < 3 || argc > 4)
> +               return CMD_RET_USAGE;
> +
> +       if (!strcasecmp("on", argv[2]))
> +               bon = true;
> +       else if (strcasecmp("off", argv[2]))
> +               return CMD_RET_USAGE;
> +
> +       algo = tpm2_name_to_algorithm(argv[1]);
> +       if (algo == -EINVAL)
> +               return CMD_RET_USAGE;
> +
> +       ret = get_tpm(&dev);
> +       if (ret)
> +               return ret;
> +
> +       if (!pcr.count) {


Ins't this always true?

> +               /*
> +                * Get current in-use algorithms (banks), PCRs and mask via the
> +                * first call
> +                */


in-use translates to active PCR banks. Isn't that function returning
the hardware-supported banks?


> +               ret = tpm2_get_pcr_info(dev, &pcr);
> +               if (ret)
> +                       return ret;


So we have the TPM banks the hardware supports here. Does it make
sense to check if the requested algorithm is supported and exit early?
In theory, it doesn't matter because the hardware will reject the
configuration later, but I'd like to have a comment about this.

> +
> +               for (i = 0; i < pcr.count; i++) {
> +                       struct tpms_pcr_selection *sel = &pcr.selection[i];
> +
> +                       if (!tpm2_is_active_bank(sel))
> +                               continue;
> +
> +                       mask = select_mask(mask, sel->hash, true);
> +                       printf("Active bank[%d] with algo[%#x]\n", i,
> +                              sel->hash);
> +               }
> +       }
> +
> +       mask = select_mask(mask, algo, bon);
> +       ret = tpm2_pcr_config_algo(dev, mask, &pcr, &pcr_len);
> +
[...]

Other than that this looks good to me

Thanks
/Ilias
