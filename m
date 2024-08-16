Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25264C531DC
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 10:50:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B1E888AC0;
	Fri, 16 Aug 2024 12:50:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cBLmSzb5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E065A88AC2; Fri, 16 Aug 2024 12:50:15 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD26088A54
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 12:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ef260c4467so3995661fa.0
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 03:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723805411; x=1724410211; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=td1pwSQNuzMFEagvH1HHNMKZBsmstRk4wPvvV9h0Scw=;
 b=cBLmSzb5Z8DuxOzCw8XaCLcDT+3QDgfN/Gkbj3LZYHmyCjYzTfhC6at4c6h9XyZ3Yj
 7drJ+XjIZHIkfSYDLdGr2XMhLsti1rF58ygmQON4HG9wXyA1T74t8JhvyL23MLQJKc7l
 7BDzu8zaOyxp1pIK9FVgDEydI/gvOKrOKPY+KS4yRcyYotCHar/JcpHucdw8f+fTeOwr
 Vhd3EopqKL7/dpHo0K/SD5Wj4iCrXwDcU4J9TVE/GFmwCo8oNVFbCLoJSNL/0nf3yYYi
 xGL1EV4wqVQPdHdTXqfh99Lnm4iuCYuS22mvw3B4UEvREovkWi0dLlfaGyJrp1l/N/vE
 dPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723805411; x=1724410211;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=td1pwSQNuzMFEagvH1HHNMKZBsmstRk4wPvvV9h0Scw=;
 b=o+o3kAiozLdOhOEWsAFRyIPebgJ0tJOo5bb3ifIsh4YQUSXPFnsDoWdv7hnRzFmrsN
 LQgtVuSohuqwY7l0a3Fv9C5Z1jaOQKmA/HlHWZleRV9bYzW4UYuIk3PcfMC1XvhDIzsQ
 nDM1+db7QZhCaGdOVBBqdmvxBXR/LmfBpERiYvK05AUdHXwCsV1WQjwwrfFItcEw7lQi
 NneLnK32FWajMR2B9P2AZg1MOoRgRPqNX0mpL+LVJZwl4DwP1f0lF/OqIg0/JjU2BG2a
 i+si1lM5q1jO/9rQs1vaOQYR8YxWSn2D4yu8YFoJ7Ayqj0N6QBcvd3qRpFJvF5L2dYJo
 7bvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjkJSMhBwuDCA/2OmASPB9w6l1qHqwnZ5ueWPFwiXmzPLoxNvdBCcZtPoDM16QiFym+MOq3fY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2XmQ24++TsP+5mXGPYIj0tC4l3OHGGMdeiIuIe0brMq+CbrW/
 ewOAgwL46fhh7rYyjJF27Hjk68Schu0kCS12v5ixu/K2jcXcTI7eJf/Y6YFEDK/SfHQqLNz9pzV
 Utqyts4j9gJreXqk+LArU+1h46Es=
X-Google-Smtp-Source: AGHT+IHcpuhjROzzVyyDSbSqxV4BUeSRAouC2QcoG6alFlaRMdK3tM281M95rfLsAOTJQHAXO0Z8TrMrMu4o7RO4N00=
X-Received: by 2002:a05:6512:ba7:b0:52e:ccf5:7c3e with SMTP id
 2adb3069b0e04-5331c6e43a2mr786128e87.7.1723805410306; Fri, 16 Aug 2024
 03:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240813063243.24249-1-othacehe@gnu.org>
In-Reply-To: <20240813063243.24249-1-othacehe@gnu.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 16 Aug 2024 07:49:59 -0300
Message-ID: <CAOMZO5DaU81Xn+nzuUgf1icznQn5RLrWzbw=i0B-XBfB23fthg@mail.gmail.com>
Subject: Re: [PATCH] imx: ele_ahab: Add HUK derivation support
To: Mathieu Othacehe <othacehe@gnu.org>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>
Cc: Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>, 
 Sean Anderson <seanga2@gmail.com>, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Peng and Ye Li,

Please help review the patch below. Thanks.

On Tue, Aug 13, 2024 at 3:32=E2=80=AFAM Mathieu Othacehe <othacehe@gnu.org>=
 wrote:
>
> Add a new ahab_derive command that derives the hardware unique key (HUK)
> into a 16 or 32 bytes key and stores it at the given address.
>
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
> ---
>  arch/arm/include/asm/mach-imx/ele_api.h |  2 +
>  arch/arm/mach-imx/ele_ahab.c            | 31 +++++++++++
>  drivers/misc/imx_ele/ele_api.c          | 73 +++++++++++++++++++++++++
>  3 files changed, 106 insertions(+)
>
> diff --git a/arch/arm/include/asm/mach-imx/ele_api.h b/arch/arm/include/a=
sm/mach-imx/ele_api.h
> index a29b849d903..490292ab023 100644
> --- a/arch/arm/include/asm/mach-imx/ele_api.h
> +++ b/arch/arm/include/asm/mach-imx/ele_api.h
> @@ -26,6 +26,7 @@
>  #define ELE_GET_EVENTS_REQ (0xA2)
>  #define ELE_COMMIT_REQ (0xA8)
>  #define ELE_START_RNG (0xA3)
> +#define ELE_CMD_DERIVE_KEY (0xA9)
>  #define ELE_GENERATE_DEK_BLOB (0xAF)
>  #define ELE_ENABLE_PATCH_REQ (0xC3)
>  #define ELE_RELEASE_RDC_REQ (0xC4)
> @@ -143,6 +144,7 @@ int ele_read_common_fuse(u16 fuse_id, u32 *fuse_words=
, u32 fuse_num, u32 *respon
>  int ele_release_caam(u32 core_did, u32 *response);
>  int ele_get_fw_version(u32 *fw_version, u32 *sha1, u32 *response);
>  int ele_get_events(u32 *events, u32 *events_cnt, u32 *response);
> +int ele_derive_huk(u8 *key, size_t key_size, u8 *ctx);
>  int ele_commit(u16 fuse_id, u32 *response, u32 *info_type);
>  int ele_generate_dek_blob(u32 key_id, u32 src_paddr, u32 dst_paddr, u32 =
max_output_size);
>  int ele_dump_buffer(u32 *buffer, u32 buffer_length);
> diff --git a/arch/arm/mach-imx/ele_ahab.c b/arch/arm/mach-imx/ele_ahab.c
> index d02316ed6cb..e1946467468 100644
> --- a/arch/arm/mach-imx/ele_ahab.c
> +++ b/arch/arm/mach-imx/ele_ahab.c
> @@ -625,6 +625,31 @@ static int do_ahab_return_lifecycle(struct cmd_tbl *=
cmdtp, int flag, int argc, c
>         return CMD_RET_SUCCESS;
>  }
>
> +static int do_ahab_derive(struct cmd_tbl *cmdtp, int flag, int argc,
> +                         char *const argv[])
> +{
> +       ulong key;
> +       size_t key_size;
> +       char *seed =3D "_ELE_AHAB_SEED_";
> +
> +       if (argc !=3D 3)
> +               return CMD_RET_USAGE;
> +
> +       key =3D hextoul(argv[1], NULL);
> +       key_size =3D simple_strtoul(argv[2], NULL, 10);
> +       if (key_size !=3D 16 && key_size !=3D 32) {
> +               printf("key size can only be 16 or 32\n");
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       if (ele_derive_huk((u8 *)key, key_size, seed)) {
> +               printf("Error in AHAB derive\n");
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       return CMD_RET_SUCCESS;
> +}
> +
>  static int do_ahab_commit(struct cmd_tbl *cmdtp, int flag, int argc,
>                           char *const argv[])
>  {
> @@ -681,6 +706,12 @@ U_BOOT_CMD(ahab_return_lifecycle, CONFIG_SYS_MAXARGS=
, 1, do_ahab_return_lifecycl
>            "addr - Return lifecycle message block signed by OEM SRK\n"
>  );
>
> +U_BOOT_CMD(ahab_derive, CONFIG_SYS_MAXARGS, 3, do_ahab_derive,
> +          "Derive the hardware unique key",
> +          "addr [16|32]\n"
> +          "Store at addr the derivation of the HUK on 16 or 32 bytes.\n"
> +);
> +
>  U_BOOT_CMD(ahab_commit, CONFIG_SYS_MAXARGS, 1, do_ahab_commit,
>            "commit into the fuses any new SRK revocation and FW version i=
nformation\n"
>            "that have been found into the NXP (ELE FW) and OEM containers=
",
> diff --git a/drivers/misc/imx_ele/ele_api.c b/drivers/misc/imx_ele/ele_ap=
i.c
> index e0ec22c7abf..0eaf51e31c8 100644
> --- a/drivers/misc/imx_ele/ele_api.c
> +++ b/drivers/misc/imx_ele/ele_api.c
> @@ -1,12 +1,14 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright 2020, 2023 NXP
> + * Copyright 2024 Mathieu Othacehe <othacehe@gnu.org>
>   *
>   */
>
>  #include <common.h>
>  #include <hang.h>
>  #include <malloc.h>
> +#include <memalign.h>
>  #include <asm/io.h>
>  #include <dm.h>
>  #include <asm/mach-imx/ele_api.h>
> @@ -528,6 +530,77 @@ int ele_start_rng(void)
>         return ret;
>  }
>
> +int ele_derive_huk(u8 *key, size_t key_size, u8 *seed)
> +{
> +       struct udevice *dev =3D gd->arch.ele_dev;
> +       struct ele_msg msg;
> +       int msg_size =3D sizeof(struct ele_msg);
> +       const size_t seed_size =3D 16;
> +       u8 *seed_aligned, *key_aligned;
> +       int ret, size;
> +
> +       if (!dev) {
> +               printf("ele dev is not initialized\n");
> +               return -ENODEV;
> +       }
> +
> +       if (key_size !=3D 16 && key_size !=3D 32) {
> +               printf("key size can only be 16 or 32\n");
> +               return -EINVAL;
> +       }
> +
> +       seed_aligned =3D memalign(ARCH_DMA_MINALIGN, seed_size);
> +       if (!seed_aligned) {
> +               printf("failed to alloc memory\n");
> +               return -EINVAL;
> +       }
> +       memcpy(seed_aligned, seed, seed_size);
> +
> +       key_aligned =3D memalign(ARCH_DMA_MINALIGN, key_size);
> +       if (!key_aligned) {
> +               printf("failed to alloc memory\n");
> +               ret =3D -EINVAL;
> +               goto ret_seed;
> +       }
> +
> +       size =3D ALIGN(seed_size, ARCH_DMA_MINALIGN);
> +       flush_dcache_range((ulong)seed_aligned,
> +                          (ulong)seed_aligned + size);
> +
> +       size =3D ALIGN(key_size, ARCH_DMA_MINALIGN);
> +       invalidate_dcache_range((ulong)key_aligned,
> +                               (ulong)key_aligned + size);
> +
> +       msg.version =3D ELE_VERSION;
> +       msg.tag =3D ELE_CMD_TAG;
> +       msg.size =3D 7;
> +       msg.command =3D ELE_CMD_DERIVE_KEY;
> +       msg.data[0] =3D upper_32_bits((ulong)key_aligned);
> +       msg.data[1] =3D lower_32_bits((ulong)key_aligned);
> +       msg.data[2] =3D upper_32_bits((ulong)seed_aligned);
> +       msg.data[3] =3D lower_32_bits((ulong)seed_aligned);
> +       msg.data[4] =3D seed_size << 16 | key_size;
> +       msg.data[5] =3D compute_crc(&msg);
> +
> +       ret =3D misc_call(dev, false, &msg, msg_size, &msg, msg_size);
> +       if (ret) {
> +               printf("Error: %s: ret %d, response 0x%x\n",
> +                      __func__, ret, msg.data[0]);
> +               goto ret_key;
> +       }
> +
> +       invalidate_dcache_range((ulong)key_aligned,
> +                               (ulong)key_aligned + size);
> +       memcpy(key, key_aligned, key_size);
> +
> +ret_key:
> +       free(key_aligned);
> +ret_seed:
> +       free(seed_aligned);
> +
> +       return ret;
> +}
> +
>  int ele_commit(u16 fuse_id, u32 *response, u32 *info_type)
>  {
>         struct udevice *dev =3D gd->arch.ele_dev;
> --
> 2.45.2
>
