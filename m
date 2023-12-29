Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB46C46CD4
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 07:06:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A92C887A39;
	Fri, 29 Dec 2023 08:06:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Hcjz26Ct";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3A2587A17; Fri, 29 Dec 2023 08:06:54 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60EBB87A17
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 08:06:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a2772011f8dso96855766b.2
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 23:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703833611; x=1704438411; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dvxRb9XWW0ysgstHfBjVq4MXCxz4RBHeI7Lqis2V00Q=;
 b=Hcjz26CttzR3R92hHLdvCBbnBbacbW9AQHcDQDeCjKejtD+Pd0ZpmAY16UMuWiP58s
 FpjsNG5wTdm8OF/boRTycoSirkW4yz3imccjdNbw5fGZBk/+HnTi8j3cThBhPk69moMq
 T9ON9kv1CqQePLV+s958b0bB33CJuiYKlliogL+rwj3w8IAU/xszAXd4TxvHZV1kedc6
 4uKMEPTj6hTNLKYOm0l7ZVgVB0a7xhXT8DJaui3EwtUhLE4MXSRPbqjYLQb/U4K7wPqt
 rBazJLQpqkWlqp7kzLBsjUDAMWhq4ISsdsRTfM644Ez7AwhkqlZTpL5v4Yp3AYfNC1wL
 TmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703833611; x=1704438411;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dvxRb9XWW0ysgstHfBjVq4MXCxz4RBHeI7Lqis2V00Q=;
 b=SiDfv0GhxLIN/SS3XKh6j/ZA9BI3wMTWYQM4CA2TUr/U6Acv3YBShyU7l+I/oxWHZw
 lPtIeGOv4BVNmexa+KTzyu/A/gsuZtrVbISgEJ3yduv21Hmtq700+//bo2VD6ZbxDxLa
 pan0edMLMOlT5Fs8X9rtjn1kiP69KzfqLpnIldKpyWw7Ac10MfCi4sgQf+/QAEqBjLK2
 liXoFNDJHKnR5e8kaT9D7lkHOmslpYYFr2VIAkiBhyn8eoLtNugY2E9PT1n/JcsKdbp5
 xqJFFgpz66wVJrqwF9GIyRFp35feZG3kUbxJpKoiYDuQCzcJiDSuqACfO6AYIbDZReIb
 OVWg==
X-Gm-Message-State: AOJu0YzUudmii9wYpfYMfAFqPR3qGo+JdatMoYzcfCnVtOE8b4akv1Gs
 HcaZ9LHFFS/KszfUc+41/GiscOXM7md0FaIVjAJA9Bc5zNg=
X-Google-Smtp-Source: AGHT+IFGI1QnQb5Nnv/nsx3HTWtw2Oo9n/ffEOBtsLc8NBqQ3CX6A7xBtdfvaQKPJptleP8PJONcaw==
X-Received: by 2002:a17:906:1099:b0:a27:462e:e356 with SMTP id
 u25-20020a170906109900b00a27462ee356mr1612989eju.72.1703833610562; 
 Thu, 28 Dec 2023 23:06:50 -0800 (PST)
Received: from hades (ppp089210121239.access.hol.gr. [89.210.121.239])
 by smtp.gmail.com with ESMTPSA id
 le19-20020a170906ae1300b00a2798d33c31sm217043ejb.77.2023.12.28.23.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 23:06:50 -0800 (PST)
Date: Fri, 29 Dec 2023 09:06:48 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: "niek.nooijens@omron.com" <niek.nooijens@omron.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: New TPM commands.
Message-ID: <ZY5wCBjzLGVZYuxS@hades>
References: <OS3P286MB1495287ECFAC54B7800E3FCEF696A@OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM>
 <CAC_iWjK=Goo-7AyQsuVoZhSZ2zPmfQLwp_+vS5GqSmFruTshBA@mail.gmail.com>
 <OS3P286MB1495981410A3E10D8E69CE23F695A@OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS3P286MB1495981410A3E10D8E69CE23F695A@OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM>
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

Hi Niek,

On Thu, Dec 21, 2023 at 02:12:49AM +0000, niek.nooijens@omron.com wrote:
> Hi Ilias
> 
> I implemented the feedback and checked the htmldocs build target. no error there.
> I also applied the patch to the latest github version (was using an older one, but no compatibility issues) and used git format-patch instead of git-diff. The checkpatch script now shows no errors.
> There's no real reson to "want" this to be merged, but as our company benefits greatly from projects like u-boot, I figured that the least we could do was contribute back to the project. We use the TPM's non-volatile memory to lock away keys and other secrets and I don't think we're the only one needing this.
> 
> anyhow here's the new revision. if I can help with more things I would gladly hear from you.

This doesn't apply cleanly on -master or -next trees. 
Can you rebase it on top of either or them and resend it?
When you do, please send a new email with the topic set like this:
'tpm:  NV memory accesses v2'

Thanks
/Ilias
> 
> ===================BEGIN PATCH=================
> From afd377e2aba6df46bc991c0f250bf67d4ad036e0 Mon Sep 17 00:00:00 2001
> From: Niek Nooijens <niek.nooijens@omron.com>
> Date: Thu, 21 Dec 2023 10:56:14 +0900
> Subject: [PATCH] add tpm nv_commands
> 
> Needed to read and write to the TPM's NV memory, in which you can store
>     keys and other secret information, which can be locked behind PCR
>     policies.
> 
> Signed-off-by: Niek Nooijens <niek.nooijens@omron.com>
> ---
>  cmd/tpm-v2.c     | 152 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/tpm-v2.h |  15 +++++
>  lib/tpm-v2.c     |  67 ++++++++++++++++-----
>  3 files changed, 219 insertions(+), 15 deletions(-)
> 
> diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
> index 7e479b9dfe..0d1e9e8e5c 100644
> --- a/cmd/tpm-v2.c
> +++ b/cmd/tpm-v2.c
> @@ -356,6 +356,136 @@ static int do_tpm_pcr_setauthvalue(struct cmd_tbl *cmdtp, int flag,
>                                           key, key_sz));
>  }
> 
> +static int do_tpm_nv_define(struct cmd_tbl *cmdtp, int flag,
> +                       int argc, char *const argv[])
> +{
> +     struct udevice *dev;
> +     struct tpm_chip_priv *priv;
> +     u32 nv_addr, nv_size, nv_attributes, rc;
> +     void *policy_addr = NULL;
> +     size_t policy_size = 0;
> +     int ret;
> +
> +     nv_attributes = 0;
> +
> +     if ((argc < 3 && argc > 6) || argc == 4)
> +           return CMD_RET_USAGE;
> +
> +     ret = get_tpm(&dev);
> +     if (ret)
> +           return ret;
> +
> +     priv = dev_get_uclass_priv(dev);
> +     if (!priv)
> +           return -EINVAL;
> +
> +     nv_addr = simple_strtoul(argv[1], NULL, 0);
> +
> +     nv_size = simple_strtoul(argv[2], NULL, 0);
> +
> +     if (argc > 3)
> +           nv_attributes = simple_strtoul(argv[3], NULL, 0);
> +     else
> +           nv_attributes = TPMA_NV_PLATFORMCREATE | TPMA_NV_OWNERWRITE | TPMA_NV_OWNERREAD | TPMA_NV_PPWRITE | TPMA_NV_PPREAD;
> +
> +     if (argc > 4) {
> +           policy_addr = map_sysmem(simple_strtoul(argv[4], NULL, 0), 0);
> +           if ((nv_attributes & (TPMA_NV_POLICYREAD | TPMA_NV_POLICYWRITE)) == 0) {
> +                 printf("ERROR: policy provided, but TPMA_NV_POLICYREAD or TPMA_NV_POLICYWRITE are NOT set!\n");
> +                 return CMD_RET_FAILURE;
> +           }
> +           policy_size = simple_strtoul(argv[5], NULL, 0);
> +     }
> +
> +     rc = tpm2_nv_define_space(dev, nv_addr, nv_size, nv_attributes, policy_addr, policy_size);
> +
> +     if (rc)
> +           printf("ERROR: nv_define #%u returns: 0x%x\n", nv_addr, rc);
> +
> +     if (policy_addr)
> +           unmap_sysmem(policy_addr);
> +
> +     return report_return_code(rc);
> +}
> +
> +static int do_tpm_nv_undefine(struct cmd_tbl *cmdtp, int flag,
> +                       int argc, char *const argv[])
> +{
> +     struct udevice *dev;
> +     u32 nv_addr, ret, rc;
> +
> +     ret = get_tpm(&dev);
> +     if (ret)
> +           return ret;
> +
> +     if (argc != 2)
> +           return CMD_RET_USAGE;
> +
> +     nv_addr = simple_strtoul(argv[1], NULL, 0);
> +     rc = tpm2_nv_undefine_space(dev, nv_addr);
> +
> +     return report_return_code(rc);
> +}
> +
> +static int do_tpm_nv_read_value(struct cmd_tbl *cmdtp, int flag,
> +                       int argc, char *const argv[])
> +{
> +     struct udevice *dev;
> +     u32 nv_addr, nv_size, rc;
> +     int ret;
> +     void *out_data;
> +
> +     ret = get_tpm(&dev);
> +     if (ret)
> +           return ret;
> +
> +     if (argc != 4)
> +           return CMD_RET_USAGE;
> +
> +     nv_addr = simple_strtoul(argv[1], NULL, 0);
> +
> +     nv_size = simple_strtoul(argv[2], NULL, 0);
> +
> +     out_data = map_sysmem(simple_strtoul(argv[3], NULL, 0), 0);
> +
> +     rc = tpm2_nv_read_value(dev, nv_addr, out_data, nv_size);
> +
> +     if (rc)
> +           printf("ERROR: nv_read #%u returns: #%u\n", nv_addr, rc);
> +
> +     unmap_sysmem(out_data);
> +     return report_return_code(rc);
> +}
> +
> +static int do_tpm_nv_write_value(struct cmd_tbl *cmdtp, int flag,
> +                       int argc, char *const argv[])
> +{
> +     struct udevice *dev;
> +     u32 nv_addr, nv_size, rc;
> +     int ret;
> +
> +     ret = get_tpm(&dev);
> +           if (ret)
> +                 return ret;
> +
> +           if (argc != 4)
> +                 return CMD_RET_USAGE;
> +
> +     nv_addr = simple_strtoul(argv[1], NULL, 0); //tpm_addr
> +
> +     nv_size = simple_strtoul(argv[2], NULL, 0); //size
> +
> +     void *data_to_write = map_sysmem(simple_strtoul(argv[3], NULL, 0), 0);
> +
> +     rc = tpm2_nv_write_value(dev, nv_addr, data_to_write, nv_size);
> +
> +     if (rc)
> +           printf("ERROR: nv_read #%u returns: #%u\n", nv_addr, rc);
> +
> +     unmap_sysmem(data_to_write);
> +     return report_return_code(rc);
> +}
> +
>  static struct cmd_tbl tpm2_commands[] = {
>       U_BOOT_CMD_MKENT(device, 0, 1, do_tpm_device, "", ""),
>       U_BOOT_CMD_MKENT(info, 0, 1, do_tpm_info, "", ""),
> @@ -375,6 +505,10 @@ static struct cmd_tbl tpm2_commands[] = {
>                    do_tpm_pcr_setauthpolicy, "", ""),
>       U_BOOT_CMD_MKENT(pcr_setauthvalue, 0, 1,
>                    do_tpm_pcr_setauthvalue, "", ""),
> +     U_BOOT_CMD_MKENT(nv_define, 0, 1, do_tpm_nv_define, "", ""),
> +     U_BOOT_CMD_MKENT(nv_undefine, 0, 1, do_tpm_nv_undefine, "", ""),
> +     U_BOOT_CMD_MKENT(nv_read, 0, 1, do_tpm_nv_read_value, "", ""),
> +     U_BOOT_CMD_MKENT(nv_write, 0, 1, do_tpm_nv_write_value, "", ""),
>  };
> 
>  struct cmd_tbl *get_tpm2_commands(unsigned int *size)
> @@ -453,4 +587,22 @@ U_BOOT_CMD(tpm2, CONFIG_SYS_MAXARGS, 1, do_tpm, "Issue a TPMv2.x command",
>  "    <pcr>: index of the PCR\n"
>  "    <key>: secret to protect the access of PCR #<pcr>\n"
>  "    <password>: optional password of the PLATFORM hierarchy\n"
> +"\n"
> +"nv_define <tpm_addr> <size> [<attributes>, <policy_digest_addr> <policy_size>]\n"
> +"    Define new nv index in the TPM at <tpm_addr> with size <size>\n"
> +"    <tpm_addr>: the internal address used within the TPM for the NV-index\n"
> +"    <attributes>: is described in tpp-v2.h enum tpm_index_attrs. Note; Always use TPMA_NV_PLATFORMCREATE!\n"
> +"                  will default to: TPMA_NV_PLATFORMCREATE|TPMA_NV_OWNERWRITE|TPMA_NV_OWNERREAD|TPMA_NV_PPWRITE|TPMA_NV_PPREAD\n"
> +"nv_undefine <tpm_addr>\n"
> +"    delete nv index\n"
> +"nv_read <tpm_addr> <size> <data_addr>\n"
> +"    Read data stored in TPM nv_memory at <tpm_addr> with size <size>\n"
> +"    <tpm_addr>: the internal address used within the TPM for the NV-index\n"
> +"    <size>: datasize in bytes\n"
> +"    <data_addr>: memory address where to store the data read from the TPM\n"
> +"nv_write <tpm_addr> <size> <data_addr> [<policy_digest_addr> <policy_size>]\n"
> +"    Write data to the TPM's nv_memory at <tpm_addr> with size <size>\n"
> +"    <tpm_addr>: the internal address used within the TPM for the NV-index\n"
> +"    <size>: datasize in bytes\n"
> +"    <data_addr>: memory address of the data to be written to the TPM's NV-index\n"
>  );
> diff --git a/include/tpm-v2.h b/include/tpm-v2.h
> index 33dd103767..fd136d6a2a 100644
> --- a/include/tpm-v2.h
> +++ b/include/tpm-v2.h
> @@ -332,6 +332,7 @@ enum tpm2_command_codes {
>       TPM2_CC_CLEARCONTROL    = 0x0127,
>       TPM2_CC_HIERCHANGEAUTH  = 0x0129,
>       TPM2_CC_NV_DEFINE_SPACE = 0x012a,
> +     TPM2_CC_NV_UNDEFINE_SPACE = 0x0122,
>       TPM2_CC_PCR_SETAUTHPOL  = 0x012C,
>       TPM2_CC_NV_WRITE  = 0x0137,
>       TPM2_CC_NV_WRITELOCK    = 0x0138,
> @@ -717,6 +718,20 @@ u32 tpm2_nv_define_space(struct udevice *dev, u32 space_index,
>                    size_t space_size, u32 nv_attributes,
>                    const u8 *nv_policy, size_t nv_policy_size);
> 
> +
> +
> +
> +/**
> + * Issue a TPM_NV_UnDefineSpace command
> + *
> + * This allows a space to be removed. Needed because TPM_clear doesn't clear platform entries
> + *
> + * @dev                TPM device
> + * @space_index        index of the area
> + * Return: return code of the operation
> + */
> +u32 tpm2_nv_undefine_space(struct udevice *dev, u32 space_index);
> +
>  /**
>   * Issue a TPM2_PCR_Extend command.
>   *
> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> index bd0fb078dc..9b1460b0ad 100644
> --- a/lib/tpm-v2.c
> +++ b/lib/tpm-v2.c
> @@ -788,15 +788,15 @@ u32 tpm2_clear(struct udevice *dev, u32 handle, const char *pw,
>  }
> 
>  u32 tpm2_nv_define_space(struct udevice *dev, u32 space_index,
> -                  size_t space_size, u32 nv_attributes,
> -                  const u8 *nv_policy, size_t nv_policy_size)
> +                 size_t space_size, u32 nv_attributes,
> +                 const u8 *nv_policy, size_t nv_policy_size)
>  {
>       /*
>        * Calculate the offset of the nv_policy piece by adding each of the
>        * chunks below.
>        */
>       const int platform_len = sizeof(u32);
> -     const int session_hdr_len = 13;
> +     const int session_hdr_len = 15;
>       const int message_len = 14;
>       uint offset = TPM2_HDR_LEN + platform_len + session_hdr_len +
>             message_len;
> @@ -809,11 +809,15 @@ u32 tpm2_nv_define_space(struct udevice *dev, u32 space_index,
>             /* handles 4 bytes */
>             tpm_u32(TPM2_RH_PLATFORM),    /* Primary platform seed */
> 
> -           /* session header 13 bytes */
> +
> +           /* session header 15 bytes */
> +           /*null auth session*/
>             tpm_u32(9),             /* Header size */
>             tpm_u32(TPM2_RS_PW),          /* Password authorisation */
>             tpm_u16(0),             /* nonce_size */
>             0,                      /* session_attrs */
> +           tpm_u16(0),             /* HMAC size */
> +           /*end auth area*/
>             tpm_u16(0),             /* auth_size */
> 
>             /* message 14 bytes + policy */
> @@ -842,6 +846,35 @@ u32 tpm2_nv_define_space(struct udevice *dev, u32 space_index,
>       return tpm_sendrecv_command(dev, command_v2, NULL, NULL);
>  }
> 
> +u32 tpm2_nv_undefine_space(struct udevice *dev, u32 space_index)
> +{
> +     const int platform_len = sizeof(u32);
> +     const int session_hdr_len = 13;
> +     const int message_len = 4;
> +     u8 command_v2[COMMAND_BUFFER_SIZE] = {
> +           /* header 10 bytes */
> +           tpm_u16(TPM2_ST_SESSIONS),    /* TAG */
> +           tpm_u32(TPM2_HDR_LEN + platform_len + session_hdr_len +
> +                       message_len),/* Length - header + provision + index + auth area*/
> +           tpm_u32(TPM2_CC_NV_UNDEFINE_SPACE),/* Command code */
> +
> +           /* handles 4 bytes */
> +           tpm_u32(TPM2_RH_PLATFORM),    /* Primary platform seed */
> +           /* nv_index */
> +           tpm_u32(space_index),
> +
> +           /*null auth session*/
> +           tpm_u32(9),             /* Header size */
> +           tpm_u32(TPM2_RS_PW),          /* Password authorisation FIXME: allow PCR authorization */
> +           tpm_u16(0),             /* nonce_size */
> +           0,                      /* session_attrs */
> +           tpm_u16(0),             /* HMAC size */
> +           /*end auth area*/
> +
> +     };
> +     return tpm_sendrecv_command(dev, command_v2, NULL, NULL);
> +}
> +
>  u32 tpm2_pcr_extend(struct udevice *dev, u32 index, u32 algorithm,
>                 const u8 *digest, u32 digest_len)
>  {
> @@ -890,22 +923,23 @@ u32 tpm2_nv_read_value(struct udevice *dev, u32 index, void *data, u32 count)
>       u8 command_v2[COMMAND_BUFFER_SIZE] = {
>             /* header 10 bytes */
>             tpm_u16(TPM2_ST_SESSIONS),    /* TAG */
> -           tpm_u32(10 + 8 + 4 + 9 + 4),  /* Length */
> +           tpm_u32(TPM2_HDR_LEN + 8 + 4 + 9 + 4),    /* Length */
>             tpm_u32(TPM2_CC_NV_READ),     /* Command code */
> 
>             /* handles 8 bytes */
>             tpm_u32(TPM2_RH_PLATFORM),    /* Primary platform seed */
> -           tpm_u32(HR_NV_INDEX + index), /* Password authorisation */
> +           tpm_u32(index),               /*nv index*/
> 
>             /* AUTH_SESSION */
> -           tpm_u32(9),             /* Authorization size */
> -           tpm_u32(TPM2_RS_PW),          /* Session handle */
> +           tpm_u32(9),             /* Authorization size - 4 bytes*/
> +           /*auth handle - 9 bytes */
> +           tpm_u32(TPM2_RS_PW),          /* Password authorisation */
>             tpm_u16(0),             /* Size of <nonce> */
>                                     /* <nonce> (if any) */
>             0,                      /* Attributes: Cont/Excl/Rst */
>             tpm_u16(0),             /* Size of <hmac/password> */
>                                     /* <hmac/password> (if any) */
> -
> +           /*end auth handle */
>             tpm_u16(count),               /* Number of bytes */
>             tpm_u16(0),             /* Offset */
>       };
> @@ -930,7 +964,7 @@ u32 tpm2_nv_write_value(struct udevice *dev, u32 index, const void *data,
>                   u32 count)
>  {
>       struct tpm_chip_priv *priv = dev_get_uclass_priv(dev);
> -     uint offset = 10 + 8 + 4 + 9 + 2;
> +     uint offset = TPM2_HDR_LEN + 8 + 4 + 9 + 2;
>       uint len = offset + count + 2;
>       /* Use empty password auth if platform hierarchy is disabled */
>       u32 auth = priv->plat_hier_disabled ? HR_NV_INDEX + index :
> @@ -943,18 +977,21 @@ u32 tpm2_nv_write_value(struct udevice *dev, u32 index, const void *data,
> 
>             /* handles 8 bytes */
>             tpm_u32(auth),                /* Primary platform seed */
> -           tpm_u32(HR_NV_INDEX + index), /* Password authorisation */
> +           tpm_u32(index),               /*nv index*/
> 
>             /* AUTH_SESSION */
> -           tpm_u32(9),             /* Authorization size */
> -           tpm_u32(TPM2_RS_PW),          /* Session handle */
> +           tpm_u32(9),             /* Authorization size - 4 bytes */
> +           /*auth handle - 9 bytes */
> +           tpm_u32(TPM2_RS_PW),    /* Password authorisation */  /* Session handle */
>             tpm_u16(0),             /* Size of <nonce> */
>                                     /* <nonce> (if any) */
>             0,                      /* Attributes: Cont/Excl/Rst */
>             tpm_u16(0),             /* Size of <hmac/password> */
>                                     /* <hmac/password> (if any) */
> -
> -           tpm_u16(count),
> +           /*end auth handle */
> +           tpm_u16(count),/*size of buffer - 2 bytes*/
> +           /*data (buffer)*/
> +           /*offset -> the octet offset into the NV Area*/
>       };
>       size_t response_len = COMMAND_BUFFER_SIZE;
>       u8 response[COMMAND_BUFFER_SIZE];
> --
> 2.34.1
> =======================END PATCH===================
> 
> 
> ________________________________
> 差出人: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> 送信日時: 2023年12月20日 17:17
> 宛先: Niek Nooijens / OC-IAB PBD-C DEVEL 1-1 <niek.nooijens@omron.com>
> CC: u-boot@lists.denx.de <u-boot@lists.denx.de>
> 件名: Re: New TPM commands.
> 
> [ilias.apalodimas@linaro.org からのメールを受け取る頻度は高くありません。これが問題である可能性の理由については、https://aka.ms/LearnAboutSenderIdentification をご覧ください。]
> 
> Hi Niek
> 
> On Wed, 20 Dec 2023 at 09:11, niek.nooijens@omron.com
> <niek.nooijens@omron.com> wrote:
> >
> > Hi There
> >
> > I added some new commands to the TPM2 command to allow read/writes to nv_memory. I also implemented the nv_define and nv_undefine commands so spaces can be created/deleted.
> > Still need to test with PCR policies, but at least for now we can store values in the TPM.
> 
> Thanks for the patch. There's a standard process for sending patches
> [0]. Try to follow the guidelines on your next revision, it makes
> things substantially easier for me. Also, spend some time writing a
> clear patch description on *why* you need this merged.
> 
> >
> > Here's the patch:
> >
> > Signed-off-by: Niek Nooijens <niek.nooijens@omron.com>
> > ================BEGIN OF PATCH==============
> > diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
> > index d93b83ada9..d2a06b9f65 100644
> > --- a/cmd/tpm-v2.c
> > +++ b/cmd/tpm-v2.c
> > @@ -356,6 +356,133 @@ static int do_tpm_pcr_setauthvalue(struct cmd_tbl *cmdtp, int flag,
> >                                           key, key_sz));
> >  }
> >
> > +static int do_tpm_nv_define(struct cmd_tbl *cmdtp, int flag,
> > +              int argc, char *const argv[])
> > +{
> > +     struct udevice *dev;
> > +     struct tpm_chip_priv *priv;
> > +     u32 nv_addr, nv_size,nv_attributes, rc;
> > +     void *policy_addr = NULL;
> > +     size_t policy_size = 0;
> > +     int ret;
> > +
> > +     nv_attributes = 0;
> > +
> > +     if ((argc < 3 && argc > 6) || argc == 4)
> > +           return CMD_RET_USAGE;
> > +
> > +     ret = get_tpm(&dev);
> > +     if (ret)
> > +           return ret;
> > +
> > +     priv = dev_get_uclass_priv(dev);
> > +     if (!priv)
> > +           return -EINVAL;
> > +
> > +     nv_addr = simple_strtoul(argv[1], NULL, 0); //tpm_addr
> 
> Ditch the '//' comments throughout the patch. It's pretty clear what's happening
> 
> > +
> > +     nv_size = simple_strtoul(argv[2], NULL, 0); //size
> 
> ditto
> 
> > +
> > +     if(argc > 3) { //attributes
> > +           nv_attributes = simple_strtoul(argv[3], NULL, 0);
> > +     } else {
> > +           nv_attributes = TPMA_NV_PLATFORMCREATE|TPMA_NV_OWNERWRITE|TPMA_NV_OWNERREAD|TPMA_NV_PPWRITE|TPMA_NV_PPREAD;
> > +     }
> 
> You don't need {}
> 
> > +
> > +     if(argc > 4) {//policy
> > +           policy_addr = map_sysmem(simple_strtoul(argv[4], NULL, 0), 0);
> > +           if((nv_attributes & (TPMA_NV_POLICYREAD|TPMA_NV_POLICYWRITE)) == 0) { //not sure if I should enforce this or just warn the user?
> > +                 printf("Warning: policy provided, but TPMA_NV_POLICYREAD and TPMA_NV_POLICYWRITE are NOT set!\n");
> 
> Just return an error here.
> 
> > +           }
> > +           policy_size = simple_strtoul(argv[5], NULL, 0);
> > +     }
> > +
> > +     rc = tpm2_nv_define_space(dev, nv_addr, nv_size, nv_attributes,policy_addr, policy_size);
> > +
> > +     if (rc) {
> > +           printf("ERROR: nv_define #%u returns: 0x%x\n", nv_addr, rc);
> > +     }
> > +     if(argc > 4) {
> 
> policy_addr is initialized to NULL, just look at the ptr here instead of argc
> 
> > +           unmap_sysmem(policy_addr);
> > +     }
> 
> You don't need {} in any of the above
> 
> > +     return report_return_code(rc);
> > +}
> > +
> > +static int do_tpm_nv_undefine(struct cmd_tbl *cmdtp, int flag,
> > +              int argc, char *const argv[])
> > +{
> > +     struct udevice *dev;
> > +     u32 nv_addr,ret, rc;
> > +
> > +     ret = get_tpm(&dev);
> > +     if (ret)
> > +           return ret;
> > +
> > +     if (argc !=2)
> > +                 return CMD_RET_USAGE;
> > +     nv_addr = simple_strtoul(argv[1], NULL, 0); //tpm_addr
> > +     rc = tpm2_nv_undefine_space(dev, nv_addr);
> > +
> > +     return report_return_code(rc);
> > +}
> > +
> > +static int do_tpm_nv_read_value(struct cmd_tbl *cmdtp, int flag,
> > +              int argc, char *const argv[])
> > +{
> > +     struct udevice *dev;
> > +     u32 nv_addr, nv_size, rc;
> > +     int ret;
> > +     void *out_data;
> > +     ret = get_tpm(&dev);
> > +           if (ret)
> > +                 return ret;
> > +
> > +           if (argc != 4)
> > +                 return CMD_RET_USAGE;
> 
> Indentation is off
> 
> > +
> > +     nv_addr = simple_strtoul(argv[1], NULL, 0); //tpm_addr
> > +
> > +     nv_size = simple_strtoul(argv[2], NULL, 0); //size
> > +
> > +     out_data = map_sysmem(simple_strtoul(argv[3], NULL, 0), 0);
> > +
> > +     rc = tpm2_nv_read_value(dev,nv_addr, out_data, nv_size);
> > +
> > +     if (rc) {
> > +           printf("ERROR: nv_read #%u returns: #%u\n", nv_addr, rc);
> > +     }
> > +     unmap_sysmem(out_data);
> > +     return report_return_code(rc);
> > +}
> > +
> > +static int do_tpm_nv_write_value(struct cmd_tbl *cmdtp, int flag,
> > +              int argc, char *const argv[])
> > +{
> > +     struct udevice *dev;
> > +     u32 nv_addr, nv_size, rc;
> > +     int ret;
> > +     ret = get_tpm(&dev);
> > +           if (ret)
> > +                 return ret;
> > +
> > +           if (argc != 4)
> > +                 return CMD_RET_USAGE;
> > +
> > +     nv_addr = simple_strtoul(argv[1], NULL, 0); //tpm_addr
> > +
> > +     nv_size = simple_strtoul(argv[2], NULL, 0); //size
> > +
> > +     void *data_to_write = map_sysmem(simple_strtoul(argv[3], NULL, 0), 0);
> > +
> > +     rc = tpm2_nv_write_value(dev,nv_addr, data_to_write, nv_size);
> > +
> > +     if (rc) {
> > +           printf("ERROR: nv_read #%u returns: #%u\n", nv_addr, rc);
> > +     }
> 
> Get rid of {}
> 
> [...]
> 
> > diff --git a/include/tpm-v2.h b/include/tpm-v2.h
> > index 737e57551d..b9801e91eb 100644
> > --- a/include/tpm-v2.h
> > +++ b/include/tpm-v2.h
> > @@ -214,6 +214,7 @@ struct tcg_pcr_event2 {
> >       u8 event[];
> >  } __packed;
> >
> > +
> >  /**
> >   * TPM2 Structure Tags for command/response buffers.
> >   *
> > @@ -286,6 +287,7 @@ enum tpm2_command_codes {
> >       TPM2_CC_CLEARCONTROL    = 0x0127,
> >       TPM2_CC_HIERCHANGEAUTH  = 0x0129,
> >       TPM2_CC_NV_DEFINE_SPACE = 0x012a,
> > +     TPM2_CC_NV_UNDEFINE_SPACE = 0x0122,
> >       TPM2_CC_PCR_SETAUTHPOL  = 0x012C,
> >       TPM2_CC_NV_WRITE  = 0x0137,
> >       TPM2_CC_NV_WRITELOCK    = 0x0138,
> > @@ -469,6 +471,20 @@ u32 tpm2_nv_define_space(struct udevice *dev, u32 space_index,
> >                    size_t space_size, u32 nv_attributes,
> >                    const u8 *nv_policy, size_t nv_policy_size);
> >
> > +
> > +
> > +
> > +/**
> > + * Issue a TPM_NV_UnDefineSpace command
> 
> run make htmldocs before the next revision and make sure you get no
> errors. We usually start with the function name here
> 
> > + *
> > + * This allows a space to be removed. Needed because TPM_clear doesn't clear platform entries
> > + *
> > + * @dev                TPM device
> > + * @space_index        index of the area
> > + * Return: return code of the operation
> > + */
> > +u32 tpm2_nv_undefine_space(struct udevice *dev, u32 space_index);
> > +
> >  /**
> >   * Issue a TPM2_PCR_Extend command.
> >   *
> > @@ -494,6 +510,7 @@ u32 tpm2_pcr_extend(struct udevice *dev, u32 index, u32 algorithm,
> >   */
> >  u32 tpm2_nv_read_value(struct udevice *dev, u32 index, void *data, u32 count);
> >
> > +
> >  /**
> >   * Write data to the secure storage
> >   *
> > diff --git a/lib/tpm-common.c b/lib/tpm-common.c
> > index 82ffdc5341..fbb78a941f 100644
> > --- a/lib/tpm-common.c
> > +++ b/lib/tpm-common.c
> > @@ -3,7 +3,7 @@
> >   * Copyright (c) 2013 The Chromium OS Authors.
> >   * Coypright (c) 2013 Guntermann & Drunck GmbH
> >   */
> > -
> > +#define LOG_DEBUG
> >  #define LOG_CATEGORY UCLASS_TPM
> >
> >  #include <common.h>
> > @@ -13,6 +13,8 @@
> >  #include <tpm-common.h>
> >  #include "tpm-utils.h"
> >
> > +
> > +
> >  enum tpm_version tpm_get_version(struct udevice *dev)
> >  {
> >       struct tpm_chip_priv *priv = dev_get_uclass_priv(dev);
> > diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> > index 697b982e07..9df3968033 100644
> > --- a/lib/tpm-v2.c
> > +++ b/lib/tpm-v2.c
> > @@ -90,7 +90,7 @@ u32 tpm2_nv_define_space(struct udevice *dev, u32 space_index,
> >        * chunks below.
> >        */
> >       const int platform_len = sizeof(u32);
> > -     const int session_hdr_len = 13;
> > +     const int session_hdr_len = 15;
> >       const int message_len = 14;
> >       uint offset = TPM2_HDR_LEN + platform_len + session_hdr_len +
> >             message_len;
> > @@ -103,11 +103,15 @@ u32 tpm2_nv_define_space(struct udevice *dev, u32 space_index,
> >             /* handles 4 bytes */
> >             tpm_u32(TPM2_RH_PLATFORM),    /* Primary platform seed */
> >
> > -           /* session header 13 bytes */
> > +
> > +           /* session header 15 bytes */
> > +           /*null auth session*/
> >             tpm_u32(9),             /* Header size */
> >             tpm_u32(TPM2_RS_PW),          /* Password authorisation */
> >             tpm_u16(0),             /* nonce_size */
> >             0,                      /* session_attrs */
> > +           tpm_u16(0),       /* HMAC size */
> > +           /*end auth area*/
> >             tpm_u16(0),             /* auth_size */
> >
> >             /* message 14 bytes + policy */
> > @@ -136,6 +140,35 @@ u32 tpm2_nv_define_space(struct udevice *dev, u32 space_index,
> >       return tpm_sendrecv_command(dev, command_v2, NULL, NULL);
> >  }
> >
> > +u32 tpm2_nv_undefine_space(struct udevice *dev, u32 space_index) {
> > +
> > +     const int platform_len = sizeof(u32);
> > +     const int session_hdr_len = 13;
> > +     const int message_len = 4;
> > +     u8 command_v2[COMMAND_BUFFER_SIZE] = {
> > +           /* header 10 bytes */
> > +           tpm_u16(TPM2_ST_SESSIONS),    /* TAG */
> > +           tpm_u32(TPM2_HDR_LEN + platform_len + session_hdr_len +
> > +                       message_len),/* Length - header + provision + index + auth area*/
> > +           tpm_u32(TPM2_CC_NV_UNDEFINE_SPACE),/* Command code */
> > +
> > +           /* handles 4 bytes */
> > +           tpm_u32(TPM2_RH_PLATFORM),    /* Primary platform seed */
> > +           /* nv_index */
> > +           tpm_u32(space_index),
> > +
> > +           /*null auth session*/
> > +           tpm_u32(9),             /* Header size */
> > +           tpm_u32(TPM2_RS_PW),          /* Password authorisation FIXME: allow PCR authorization */
> > +           tpm_u16(0),             /* nonce_size */
> > +           0,                      /* session_attrs */
> > +           tpm_u16(0),       /* HMAC size */
> > +           /*end auth area*/
> > +
> > +     };
> > +     return tpm_sendrecv_command(dev, command_v2, NULL, NULL);
> > +}
> > +
> >  u32 tpm2_pcr_extend(struct udevice *dev, u32 index, u32 algorithm,
> >                 const u8 *digest, u32 digest_len)
> >  {
> > @@ -184,22 +217,23 @@ u32 tpm2_nv_read_value(struct udevice *dev, u32 index, void *data, u32 count)
> >       u8 command_v2[COMMAND_BUFFER_SIZE] = {
> >             /* header 10 bytes */
> >             tpm_u16(TPM2_ST_SESSIONS),    /* TAG */
> > -           tpm_u32(10 + 8 + 4 + 9 + 4),  /* Length */
> > +           tpm_u32(TPM2_HDR_LEN + 8 + 4 + 9 + 4),    /* Length */
> 
> I would *really* love to get rid of the magic values (8, 4 etc) and
> define them to something readable. But this is not a problem of your
> patch, we can fix it later.
> 
> >             tpm_u32(TPM2_CC_NV_READ),     /* Command code */
> >
> >             /* handles 8 bytes */
> >             tpm_u32(TPM2_RH_PLATFORM),    /* Primary platform seed */
> 
> [...]
> 
> [0] https://jpn01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs.u-boot.org%2Fen%2Flatest%2Fdevelop%2Fsending_patches.html&data=05%7C02%7Cniek.nooijens%40omron.com%7Cc9be4329540d486efd6008dc01343ed2%7C0ecff5a94bef4a7b96eca96579b4ac37%7C0%7C0%7C638386571853513174%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000%7C%7C%7C&sdata=XAJI1xoXZTNiQD%2B12Jyk3HX8cN%2FcNxC7%2F6gcTfrPUi8%3D&reserved=0<https://docs.u-boot.org/en/latest/develop/sending_patches.html>
> 
> /Ilias
