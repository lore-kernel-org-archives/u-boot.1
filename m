Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E91C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 06:20:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 647D680214;
	Thu, 23 Jan 2025 07:20:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U+Um68Vx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E355F80243; Thu, 23 Jan 2025 07:20:51 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7000680137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 07:20:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e549be93d5eso937638276.1
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 22:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737613248; x=1738218048; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vgJP/VNPRLChhchCIgEWCSHLkqwWvcEyheM7Mj09VaU=;
 b=U+Um68VxRsywSrlvrpwf1irnRDGyGiH3vFXy7ue1OPyr/IZdUkM3RLR7QWVtW7AAOi
 nnMt72rngzgybsFCjwAAZJ4bx+hZqUYOVLtIyehfMnwF1gKjAuZlIq1JRSuaI0hRxOf6
 /kYSlLQ7aXZ64re25NpJPm4bSmtKrPJrleNbbFqTQBpg2S9YgfdZYQuVij+w0nnCvZaP
 gZUQB/0WpOoxUmNVJB5Jk6d0OkMAjNJFEKqV6tUMJcZA8jLjtr8UEYtjerB4bFbPtzEF
 Ne89e2nhOBVdRVZji1SRR7Uhl1qMm6vDkOP/kko64d44ps7rlDklrvvSMp4QMjGmFcL9
 ysSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737613248; x=1738218048;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vgJP/VNPRLChhchCIgEWCSHLkqwWvcEyheM7Mj09VaU=;
 b=nksMqPzXr7e/NMuzNSs0ZXH0LkRlfPK2zqGDO2w9diPpOzgCnf9pAIlvQKB8mZb10B
 kamdaxUr80i3yalsOjD1BP2S5JBaHBpyMIyuCybUY334mrRtVIelq1uGrylxeoIgUEDx
 miPJFZnXqQfKNFTtnZoY70vLxUi84XF60Jf+Kwedwe9loHyhOkYtEhAwd+2y7wxnmNDD
 VEwIxuxG/9g2qI0xhDQ5HwBUjRe6o/PPRbzy7pI221YM/5dGo/R+MCNqocz2IqJezWI/
 NORBx+reHyb7MX8GUGbtEHvmmUNUKWEwLW2krIoh7aU21JHzMY+p0u1J1F6bl4FL3bJP
 MGhA==
X-Gm-Message-State: AOJu0YwH/P9fHuLq4O15iLf+4pUbfqit0nijmiqi9ao5nd+7qjgABGrI
 p6NajaLH9OOx2NyI5VpV7viatYxzS45ePl6aqhUg1iz4a/r7tt4+dAYZFzorRJjvBTtJCwL2Kb+
 /yNuHluJ795cHBe6mVxRMfLsRguKEY1JhN7mH+A==
X-Gm-Gg: ASbGncs+a5WC0nDAkOmeArC0qpO+Q/hD5ZraOf/5TDJ4/s59tDZRjNEups0QKJTBh4O
 ItXxTlKup9cUQQgqc1tIrZWlA0k31McyTdOLAAAQw8Mpp6UyqiOKYMQLaDtl9aQ==
X-Google-Smtp-Source: AGHT+IH2RV1v6b/5uSZjEGv+jKVcHGvGZnJDNDwMF5F/2Gh0wJdZzBL+KfMnqHuaTInl4U42L04gregVQGYNtbGnKaU=
X-Received: by 2002:a25:c7cd:0:b0:e58:2a5:2427 with SMTP id
 3f1490d57ef6-e5802a524eemr5784383276.27.1737613248155; Wed, 22 Jan 2025
 22:20:48 -0800 (PST)
MIME-Version: 1.0
References: <20250117164032.88942-1-raymond.mao@linaro.org>
 <20250117164032.88942-3-raymond.mao@linaro.org>
In-Reply-To: <20250117164032.88942-3-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 23 Jan 2025 08:20:12 +0200
X-Gm-Features: AbW1kvZtQmrfeyXo_5fmiI5aXUernIQm4cLQu5Q56LBeuFNvo28elDgrU61QbHs
Message-ID: <CAC_iWjJhE=_4MJNbu=hMzjQTtSzuCY5kk8QmCCYZ-WwUaXxzQg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] tpm: add TPM2_PCR_Allocate command
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Tim Harvey <tharvey@gateworks.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Michal Simek <michal.simek@amd.com>
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

On Fri, 17 Jan 2025 at 18:40, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> TPM2_PCR_Allocate command is required to reconfigure a TPM device
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
> changes in v2
> - Fixed typos.
> - Print the algorithm name directly.
> - Check if the algorithm supported by the TPM device before allocate.
>
>  cmd/tpm-v2.c     | 114 +++++++++++++++++++++++++++++++++++++++++++
>  include/tpm-v2.h |  29 +++++++++++
>  lib/tpm-v2.c     | 124 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 267 insertions(+)
>
> diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
> index a6d57ee7c4..a62862e94f 100644
> --- a/cmd/tpm-v2.c
> +++ b/cmd/tpm-v2.c
> @@ -232,6 +232,106 @@ unmap_data:
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
> +static bool
> +is_algo_in_pcrs(enum tpm2_algorithms algo, struct tpml_pcr_selection *pcrs)
> +{
> +       size_t i;
> +
> +       for (i = 0; i < pcrs->count; i++) {
> +               if (algo == pcrs->selection[i].hash)
> +                       return true;
> +       }
> +
> +       return false;
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
> +               /*
> +                * Get current active algorithms (banks), PCRs and mask via the
> +                * first call
> +                */
> +               ret = tpm2_get_pcr_info(dev, &pcr);
> +               if (ret)
> +                       return ret;
> +
> +               for (i = 0; i < pcr.count; i++) {
> +                       struct tpms_pcr_selection *sel = &pcr.selection[i];
> +                       const char *name;
> +
> +                       if (!tpm2_is_active_bank(sel))
> +                               continue;
> +
> +                       mask = select_mask(mask, sel->hash, true);
> +                       name = tpm2_algorithm_name(sel->hash);
> +                       if (name)
> +                               printf("Active bank[%d]: %s\n", i, name);
> +               }
> +       }
> +
> +       if (!is_algo_in_pcrs(algo, &pcr)) {
> +               printf("%s is not supported by the tpm device\n", argv[1]);
> +               return CMD_RET_USAGE;
> +       }
> +
> +       mask = select_mask(mask, algo, bon);
> +       ret = tpm2_pcr_config_algo(dev, mask, &pcr, &pcr_len);
> +       if (ret)
> +               return ret;
> +
> +       return report_return_code(tpm2_send_pcr_allocate(dev, pw, pw_sz, &pcr,
> +                                                        pcr_len));
> +}
> +
>  static int do_tpm_dam_reset(struct cmd_tbl *cmdtp, int flag, int argc,
>                             char *const argv[])
>  {
> @@ -401,6 +501,7 @@ static struct cmd_tbl tpm2_commands[] = {
>                          do_tpm_pcr_setauthpolicy, "", ""),
>         U_BOOT_CMD_MKENT(pcr_setauthvalue, 0, 1,
>                          do_tpm_pcr_setauthvalue, "", ""),
> +       U_BOOT_CMD_MKENT(pcr_allocate, 0, 1, do_tpm2_pcrallocate, "", ""),
>  };
>
>  struct cmd_tbl *get_tpm2_commands(unsigned int *size)
> @@ -481,4 +582,17 @@ U_BOOT_CMD(tpm2, CONFIG_SYS_MAXARGS, 1, do_tpm, "Issue a TPMv2.x command",
>  "    <pcr>: index of the PCR\n"
>  "    <key>: secret to protect the access of PCR #<pcr>\n"
>  "    <password>: optional password of the PLATFORM hierarchy\n"
> +"pcr_allocate <algorithm> <on/off> [<password>]\n"
> +"    Issue a TPM2_PCR_Allocate Command to reconfig PCR bank algorithm.\n"
> +"    <algorithm> is one of:\n"
> +"        * sha1\n"
> +"        * sha256\n"
> +"        * sha384\n"
> +"        * sha512\n"
> +"    <on|off> is one of:\n"
> +"        * on  - Select all available PCRs associated with the specified\n"
> +"                algorithm (bank)\n"
> +"        * off - Clear all available PCRs associated with the specified\n"
> +"                algorithm (bank)\n"
> +"    <password>: optional password\n"
>  );
> diff --git a/include/tpm-v2.h b/include/tpm-v2.h
> index f66a8e1bf4..af3158f6e4 100644
> --- a/include/tpm-v2.h
> +++ b/include/tpm-v2.h
> @@ -230,6 +230,7 @@ enum tpm2_command_codes {
>         TPM2_CC_PCR_READ        = 0x017E,
>         TPM2_CC_PCR_EXTEND      = 0x0182,
>         TPM2_CC_PCR_SETAUTHVAL  = 0x0183,
> +       TPM2_CC_PCR_ALLOCATE    = 0x012B,
>         TPM2_CC_SHUTDOWN        = 0x0145,
>  };
>
> @@ -702,6 +703,34 @@ u32 tpm2_report_state(struct udevice *dev, uint vendor_cmd, uint vendor_subcmd,
>  u32 tpm2_enable_nvcommits(struct udevice *dev, uint vendor_cmd,
>                           uint vendor_subcmd);
>
> +/**
> + * tpm2_pcr_config_algo() - Allocate the active PCRs. Requires reboot
> + *
> + * @dev                TPM device
> + * @algo_mask  Mask of the algorithms
> + * @pcr                PCR structure for allocation
> + * @pcr_len    Actual PCR data length
> + *
> + * Return: code of the operation
> + */
> +u32 tpm2_pcr_config_algo(struct udevice *dev, u32 algo_mask,
> +                        struct tpml_pcr_selection *pcr, u32 *pcr_len);
> +
> +/**
> + * tpm2_send_pcr_allocate() - Send PCR allocate command. Requires reboot
> + *
> + * @dev                TPM device
> + * @pw         Platform password
> + * @pw_sz      Length of the password
> + * @pcr                PCR structure for allocation
> + * @pcr_len    Actual PCR data length
> + *
> + * Return: code of the operation
> + */
> +u32 tpm2_send_pcr_allocate(struct udevice *dev, const char *pw,
> +                          const ssize_t pw_sz, struct tpml_pcr_selection *pcr,
> +                          u32 pcr_len);
> +
>  /**
>   * tpm2_auto_start() - start up the TPM and perform selftests.
>   *                     If a testable function has not been tested and is
> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> index 3946ac2dbb..045b5dd9eb 100644
> --- a/lib/tpm-v2.c
> +++ b/lib/tpm-v2.c
> @@ -400,6 +400,130 @@ u32 tpm2_get_capability(struct udevice *dev, u32 capability, u32 property,
>         return 0;
>  }
>
> +u32 tpm2_pcr_config_algo(struct udevice *dev, u32 algo_mask,
> +                        struct tpml_pcr_selection *pcr, u32 *pcr_len)
> +{
> +       int i;
> +
> +       if (pcr->count > TPM2_NUM_PCR_BANKS)
> +               return TPM_LIB_ERROR;
> +
> +       *pcr_len = sizeof(pcr->count);
> +
> +       for (i = 0; i < pcr->count; i++) {
> +               struct tpms_pcr_selection *sel = &pcr->selection[i];
> +               u8 pad = 0;
> +               int j;
> +
> +               if (sel->size_of_select > TPM2_PCR_SELECT_MAX)
> +                       return TPM_LIB_ERROR;
> +
> +               /*
> +                * Found the algorithm (bank) that matches, and enable all PCR
> +                * bits.
> +                * TODO: only select the bits needed
> +                */
> +               for (j = 0; j < ARRAY_SIZE(hash_algo_list); j++) {
> +                       if (hash_algo_list[j].hash_alg != sel->hash)
> +                               continue;
> +
> +                       if (algo_mask & hash_algo_list[j].hash_mask)
> +                               pad = 0xff;
> +               }
> +
> +               for (j = 0; j < sel->size_of_select; j++)
> +                       sel->pcr_select[j] = pad;
> +
> +               log_info("set bank[%d] %s %s\n", i,
> +                        tpm2_algorithm_name(sel->hash),
> +                        tpm2_is_active_bank(sel) ? "on" : "off");
> +
> +               *pcr_len += sizeof(sel->hash) + sizeof(sel->size_of_select) +
> +                           sel->size_of_select;
> +       }
> +
> +       return 0;
> +}
> +
> +u32 tpm2_send_pcr_allocate(struct udevice *dev, const char *pw,
> +                          const ssize_t pw_sz, struct tpml_pcr_selection *pcr,
> +                          u32 pcr_len)
> +{
> +       /* Length of the message header, up to start of password */
> +       uint offset = 27;
> +       u8 command_v2[COMMAND_BUFFER_SIZE] = {
> +               tpm_u16(TPM2_ST_SESSIONS),   /* TAG */
> +               tpm_u32(offset + pw_sz + pcr_len), /* Length */
> +               tpm_u32(TPM2_CC_PCR_ALLOCATE),  /* Command code */
> +
> +               /* handles 4 bytes */
> +               tpm_u32(TPM2_RH_PLATFORM),      /* Primary platform seed */
> +
> +               /* AUTH_SESSION */
> +               tpm_u32(9 + pw_sz),             /* Authorization size */
> +               tpm_u32(TPM2_RS_PW),            /* Session handle */
> +               tpm_u16(0),                     /* Size of <nonce> */
> +                                               /* <nonce> (if any) */
> +               0,                              /* Attributes: Cont/Excl/Rst */
> +               tpm_u16(pw_sz),                 /* Size of <hmac/password> */
> +               /* STRING(pw)                      <hmac/password> (if any) */
> +
> +               /* TPML_PCR_SELECTION */
> +       };
> +       u8 response[COMMAND_BUFFER_SIZE];
> +       size_t response_len = COMMAND_BUFFER_SIZE;
> +       u32 i;
> +       int ret;
> +
> +       /*
> +        * Fill the command structure starting from the first buffer:
> +        * the password (if any)
> +        */
> +       if (pack_byte_string(command_v2, sizeof(command_v2), "s", offset, pw,
> +                            pw_sz))
> +               return TPM_LIB_ERROR;
> +
> +       offset += pw_sz;
> +
> +       /* Pack the count field */
> +       if (pack_byte_string(command_v2, sizeof(command_v2), "d", offset, pcr->count))
> +               return TPM_LIB_ERROR;
> +
> +       offset += sizeof(pcr->count);
> +
> +       /* Pack each tpms_pcr_selection */
> +       for (i = 0; i < pcr->count; i++) {
> +               struct tpms_pcr_selection *sel = &pcr->selection[i];
> +
> +               /* Pack hash (16-bit) */
> +               if (pack_byte_string(command_v2, sizeof(command_v2), "w", offset,
> +                                    sel->hash))
> +                       return TPM_LIB_ERROR;
> +
> +               offset += sizeof(sel->hash);
> +
> +               /* Pack size_of_select (8-bit) */
> +               if (pack_byte_string(command_v2, sizeof(command_v2), "b", offset,
> +                                    sel->size_of_select))
> +                       return TPM_LIB_ERROR;
> +
> +               offset += sizeof(sel->size_of_select);
> +
> +               /* Pack pcr_select array */
> +               if (pack_byte_string(command_v2, sizeof(command_v2), "s", offset,
> +                                    sel->pcr_select, sel->size_of_select))
> +                       return TPM_LIB_ERROR;
> +
> +               offset += sel->size_of_select;
> +       }
> +
> +       ret = tpm_sendrecv_command(dev, command_v2, response, &response_len);
> +       if (!ret)
> +               tpm_init(dev);
> +
> +       return ret;
> +}
> +
>  static int tpm2_get_num_pcr(struct udevice *dev, u32 *num_pcr)
>  {
>         u8 response[(sizeof(struct tpms_capability_data) -
> --
> 2.25.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
