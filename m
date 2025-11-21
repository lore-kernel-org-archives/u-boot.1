Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB472CFC269
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 12:08:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12EA18051F;
	Fri, 21 Nov 2025 13:08:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JE4A+cZt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F271D8312A; Fri, 21 Nov 2025 13:08:47 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E0B7802C1
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 13:08:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-7895017c722so18720457b3.2
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 04:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763726924; x=1764331724; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CPl78a9w7wgP4x69ljFnfodHU73rzbVmpw+WCjPkQaY=;
 b=JE4A+cZt0qtdO6ewtJhWR9WFQ0ffSf0WWH7WnvLXPUPz6VEnBZ5/HLMEH4M6b9ow7m
 /9dZeMTRixTK83CA5nNaq5j3Ok5oitngVylU2XvErXr5SrNcraY2vPLVzsPB/10Di/ep
 GKFQrZ4TBohYXm+m4njGIJ4MUYgOhSiknbfBH6C/ktxePd3mufkf6Z17F3Sv1Nw0UbDF
 6XMx7euhxC4G36YUC6agfbtrSfifuJHxLUtO15O6cjB/0Owbn4i1MWL8tGUie8mMEe11
 1gt+qzeZLDTWqMO6wW2U1kQiIKPNWU4p37lOZvF10R9gFXcEY2NSDfebN3Q5LJkRcvtG
 ezQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763726924; x=1764331724;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CPl78a9w7wgP4x69ljFnfodHU73rzbVmpw+WCjPkQaY=;
 b=ZFuwCrsut9QKS25tvwEAnuUnfVlVXNKeundK+i8xJh75TzgYvP64rCtnRf4ACt7fny
 /Zq1xAFV47PUHq8ISjtvbgStk56w41ycxn+uO0WuM1RORyO2q+vmZKVbhfFBB9FaW+O7
 vEF8aJwHQmtQcTX3v4+8Z/M3+MB/gN1FOVQ8YdjCQVPtUpozRzy40Gx5r+yITyP3tnVO
 /k1xEk748/4zcrju5yceRTujqk2Zs7WjpR4jCMB+9eM9/5/101Upuoedwq4215Vg2Q4k
 l3oAl7ITCQZTOqEtuMAPpGPXEDUY/Bwi2HBW39SNrJWKdD0GirPvyn7gw8u6Wq6aqkdv
 2K0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUajRKdiCs4y1ZeJH6phts4QKO4b9PmLGlqyv0HA4bXZlH1C9xhGy2oORmXUtD/mG6UyISRITM=@lists.denx.de
X-Gm-Message-State: AOJu0YxYEET+5ZAtD4FQGVRS26kpZUj4a0H8Dye0F/ihqgfFMS8uVBdj
 2KJFCnnsCnKKNeCx8q8FcJeHy6viWzwRqHvx6QflizHKDXJMwlSuOc2grhMudngcTiiWE+P1BAY
 DhUITugoLRDa4gFmdU00aATOp8XZRaEuMveoW8HUaJg==
X-Gm-Gg: ASbGncssK1YlRJrFgEhF6n9Kir02wNirRjkXREwtSL4W7u7NX6ELCpuinTiFRD3Gblj
 RlkxAYykStaHPAIEVJ3uQZSSIOPyDYawbeMswSqtXhPk+smrIe4ngVskR0t0VRgn/0tRlyazWhI
 oIyvUkHLDIEN5qd96PqhW0ue+MuEck8R7ZZmZK63b4QA6OKESkwE4oOcRnbkMm/kVqXEmV3TzhK
 ftnccxOmEPWmoY8VI8nxNJ1priOYRBu+2h57I9QZ4zX+9DL/2rxLGjP4K7y14slUWkWkJTopHtY
 QuuyYPfmLwCfbc4AXQaVJf9kAigFQQmDhwv4iJUSxmgMzC3h9tqM/zaKplK+cA==
X-Google-Smtp-Source: AGHT+IHsfBZFsQ2KX9UFY4gq01etd+0m670hoQmOIpJsHuqeQdebx2rrdrPIvE/Hj/cVqsVMYWcdU9cgc04CYVlneIg=
X-Received: by 2002:a05:690c:6282:b0:788:763:17bd with SMTP id
 00721157ae682-78a8b575439mr16712847b3.60.1763726923854; Fri, 21 Nov 2025
 04:08:43 -0800 (PST)
MIME-Version: 1.0
References: <20250724090009.569341-1-balaji.selvanathan@oss.qualcomm.com>
 <20250724090009.569341-2-balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20250724090009.569341-2-balaji.selvanathan@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 21 Nov 2025 14:08:06 +0200
X-Gm-Features: AWmQ_bmkp5i2R6coSCh2OneOPC5690GzUmMhBAb05Q7MiahlRYt-VI9eltyIxtE
Message-ID: <CAC_iWj+_W+be_nXTWXiGkBJ3q01MpDUDzk6+Hr_QRtWwD9Eyhg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] efi_loader: improve device path matching for
 partition lookup
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, xypron.glpk@gmx.de, adrianox@gmail.com, 
 moritzf@google.com, sjg@chromium.org, maks.mishinfz@gmail.com, 
 javierm@redhat.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
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

On Thu, 24 Jul 2025 at 12:00, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
>
> - Refactor find_handle() to improve device path comparison logic.
> - Original logic only compared paths when len_current <= len.
> - This fails when searching for ESP inside a larger boot device.
> - ESP partition path is longer than boot device path by design.
> - New logic allows matching when dp is a prefix of dp_current.
> - Without this change, it was not able to find ESP and capsule
>   update fails to start.
>
> - Also update efi_fs_from_path() to use system partition GUID.
> - Above ensures ESP's EFI handle is returned which contains
>   file system protocol.
> - Without this change, it was returning a wrong EFI handle
>   that was not ESP handle.
>
> - These changes improves reliability for capsule updates.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  lib/efi_loader/efi_device_path.c | 62 ++++++++++++++++++++++----------
>  lib/efi_loader/efi_disk.c        |  2 +-
>  2 files changed, 45 insertions(+), 19 deletions(-)
>
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
> index b3fb20b2501..3716165e963 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -107,54 +107,80 @@ struct efi_device_path *efi_dp_shorten(struct efi_device_path *dp)
>   * @rem:       pointer to receive remaining device path
>   * Return:     matching handle
>   */
> +
>  static efi_handle_t find_handle(struct efi_device_path *dp,
>                                 const efi_guid_t *guid, bool short_path,
>                                 struct efi_device_path **rem)
>  {

I am not entirely convinced if the change should go via find_handle() yet.
Is what eventually fails device_is_present_and_system_part()?


>         efi_handle_t handle, best_handle = NULL;
> -       efi_uintn_t len, best_len = 0;
> +       efi_uintn_t len, len_current, best_len = 0;
> +       efi_status_t ret;
> +       struct efi_device_path *dp_current;
> +       struct efi_handler *handler;
>
>         len = efi_dp_instance_size(dp);
>
>         list_for_each_entry(handle, &efi_obj_list, link) {
> -               struct efi_handler *handler;
> -               struct efi_device_path *dp_current;
> -               efi_uintn_t len_current;
> -               efi_status_t ret;
> -
>                 if (guid) {
>                         ret = efi_search_protocol(handle, guid, &handler);
>                         if (ret != EFI_SUCCESS)
>                                 continue;
>                 }
> -               ret = efi_search_protocol(handle, &efi_guid_device_path,
> -                                         &handler);
> +
> +               ret = efi_search_protocol(handle, &efi_guid_device_path, &handler);
>                 if (ret != EFI_SUCCESS)
>                         continue;
> +
>                 dp_current = handler->protocol_interface;
>                 if (short_path) {
>                         dp_current = efi_dp_shorten(dp_current);
>                         if (!dp_current)
>                                 continue;
>                 }
> +
>                 len_current = efi_dp_instance_size(dp_current);
> +
>                 if (rem) {
> -                       if (len_current > len)
> +                       /* If current path is shorter than or equal to input path */
> +                       if (len_current <= len) {
> +                               if (memcmp(dp_current, dp, len_current))
> +                                       continue;
> +                               if (!rem)
> +                                       return handle;
> +                               if (len_current > best_len) {
> +                                       best_len = len_current;
> +                                       best_handle = handle;
> +                                       *rem = (void *)((u8 *)dp + len_current);
> +                               }
> +                       }
> +                       /* If current path is greater than input path */
> +                       else if (len_current > len) {
> +                               if (memcmp(dp, dp_current, len))
> +                                       continue;
> +                               if (len > best_len) {
> +                                       best_len = len;
> +                                       best_handle = handle;
> +                                       *rem = (struct efi_device_path *)((u8 *)dp_current + len);
> +                               }
> +                       } else {
>                                 continue;
> +                       }
>                 } else {
> -                       if (len_current != len)
> +                       if (len_current == len) {
> +                               if (memcmp(dp_current, dp, len_current))
> +                                       continue;
> +                       }
> +                       /* If current path is greater than input path */
> +                       else if (len_current > len) {
> +                               if (memcmp(dp, dp_current, len))
> +                                       continue;
> +                       } else {
>                                 continue;
> -               }
> -               if (memcmp(dp_current, dp, len_current))
> -                       continue;
> -               if (!rem)
> +                       }
>                         return handle;
> -               if (len_current > best_len) {
> -                       best_len = len_current;
> -                       best_handle = handle;
> -                       *rem = (void*)((u8 *)dp + len_current);
>                 }
>         }
> +
>         return best_handle;
>  }
>
> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> index 130c4db9606..49f8b5935f4 100644
> --- a/lib/efi_loader/efi_disk.c
> +++ b/lib/efi_loader/efi_disk.c
> @@ -339,7 +339,7 @@ efi_fs_from_path(struct efi_device_path *full_path)
>         efi_free_pool(file_path);
>
>         /* Get the EFI object for the partition */
> -       efiobj = efi_dp_find_obj(device_path, NULL, NULL);
> +       efiobj = efi_dp_find_obj(device_path, &efi_system_partition_guid, NULL);

This function is not only used in capsule updates. Requiring to have
an ESP GUID installed to search for the file will break other use
cases.

Regards
/Ilias
>         efi_free_pool(device_path);
>         if (!efiobj)
>                 return NULL;
> --
> 2.34.1
>
