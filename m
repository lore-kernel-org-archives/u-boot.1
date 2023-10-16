Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3879CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 12:31:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04F198667B;
	Mon, 16 Oct 2023 14:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ggao9dBz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AA2186958; Mon, 16 Oct 2023 14:31:45 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52C18863CF
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 14:31:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-507a772ed97so2045726e87.3
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 05:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697459501; x=1698064301; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D4prcgOrL6LV4Vpwg2g69A1f6g5w94nU0HFIcD+czso=;
 b=Ggao9dBz5aSB9/yaMBVCkjd88kCjmxlf54o4T2lAIlg0EKA0LZlk5lEWBOcODBuLFr
 ymJLGOUQjbfX/hgmGTOrDmRYqulx7isXjaVN9Oy9USBzh3c6zfqn8IKr3C9s4EArSuUX
 zbYELpLDACfNhQWNCSeqt5bxcICUwEbqaPYixQUzCAqbjfZR8vOKoRDmvyUkn8IJg+pN
 Q/zR5nEIeNIznNTtqvwUfvkwFy3rW5bapKzfx4MPCMXrz7kgY3IPhjnsYg90PsC8fgcY
 39aE+XWbBuPUPLJ8qhEFQi4BpRMld6caxcIYm6QwNjMUnIxxpLsk7ZSzGG+/EhqObI33
 2s5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697459501; x=1698064301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D4prcgOrL6LV4Vpwg2g69A1f6g5w94nU0HFIcD+czso=;
 b=sLYDqeLi04CJ3DQMWp7L1T3uFWxNEXcqo/leXGrqHXFxvDWhw0eHeL7ilznIKrmYUF
 DFodEgLmlwWqu5o4U4kTFi4QvkF+O7KIPH3ClT/+LQuCwDEb+TY0rXHQ6ek0jZ4zvgOq
 O7lNMG+vgja8M6Lq9rtYae5HflWrOLvd9iY1+S7cW5fFaCwQqucrrPo1gSy90Uw3oAiF
 Dia6r8JQ8zmAkTD91jeLpD3v9SpAe93Pa9E5DNzogn7jc6eXhyRKw3aWJjTaI47cQinn
 0zr3bH/lzlRoC7kcqgDd13Zw7HnHp85SsQvDJDPpEynuyM4CGIn6UmrchfAPyZWZsclM
 BVDg==
X-Gm-Message-State: AOJu0YwMeB+keK9xSEb77phJo1Psqo859Q1XwswyWsEblhFDgHyeqd4s
 YVBGYh4DuwxdHciblPOh1UUbAWbMkaZHHrIIJMzlzA==
X-Google-Smtp-Source: AGHT+IFCT09BGDxNyEKK31xzzuma38bQTeKkbNioVb4eVTxjNUa0GcaVL2D24TValw+asmJQGAwwkBI3cdIopdmZO7c=
X-Received: by 2002:ac2:4949:0:b0:507:aa44:28fc with SMTP id
 o9-20020ac24949000000b00507aa4428fcmr2926210lfi.53.1697459501563; Mon, 16 Oct
 2023 05:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231016064526.2410856-1-masahisa.kojima@linaro.org>
 <20231016064526.2410856-5-masahisa.kojima@linaro.org>
 <A2082A91-A1CC-43E8-B151-968D7746B906@gmx.de>
In-Reply-To: <A2082A91-A1CC-43E8-B151-968D7746B906@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 16 Oct 2023 15:31:05 +0300
Message-ID: <CAC_iWj+koNjVBR7TCJH_u_PvY5xDHgtBGRTHBRRgAx_aDeC8-A@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] efi_loader: create default file boot option
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Takahiro Akashi <takahiro.akashi@linaro.org>, 
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

Hi Heinrich,

On Mon, 16 Oct 2023 at 10:06, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> Am 16. Oktober 2023 08:45:21 MESZ schrieb Masahisa Kojima <masahisa.kojima@linaro.org>:
> >Current efibootmgr automatically creates the
> >boot options of all disks and partitions installing
> >EFI_SIMPLE_FILE_SYSTEM_PROTOCOL.
> >Some of the automatically created boot options are
> >useless if the disk and partition does not have
> >the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
> >
> >This commit only creates the boot option if the disk and
> >partition have the default file so that system can directly
> >boot from it.
>
> I don't directly see the user benefit.

The user can add an HTTP boot option now and the installer will
automatically start.  That would allow products to ship with a single
boot option provisioned and run an installer on first boot

>
> Reading all file systems will increase the boot time. Shouldn't we avoid this?

Any idea what would be an alternative?  But when we added the
automatic boot options we said we should avoid dynamic scanning and
store results in a file.  This is doing a similar thing.  The only
difference is that it mounts the iso image before adding the boot
option.

>
> What does EDK II do?

No Idea :)

Thanks
/Ilias
>
> Does the UEFI specification warrant this change?
>
> Best regards
>
> Heinrich
>
> >
> >Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> >---
> > lib/efi_loader/efi_bootmgr.c | 86 ++++++++++++++++++++++++++----------
> > 1 file changed, 63 insertions(+), 23 deletions(-)
> >
> >diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> >index a40762c74c..c8cf1c5506 100644
> >--- a/lib/efi_loader/efi_bootmgr.c
> >+++ b/lib/efi_loader/efi_bootmgr.c
> >@@ -355,40 +355,70 @@ error:
> >  */
> > static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boot_option *opt,
> >                                                     efi_handle_t *volume_handles,
> >-                                                    efi_status_t count)
> >+                                                    efi_uintn_t *count)
> > {
> >-      u32 i;
> >+      u32 i, num = 0;
> >       struct efi_handler *handler;
> >       efi_status_t ret = EFI_SUCCESS;
> >
> >-      for (i = 0; i < count; i++) {
> >+      for (i = 0; i < *count; i++) {
> >               u16 *p;
> >               u16 dev_name[BOOTMENU_DEVICE_NAME_MAX];
> >               char *optional_data;
> >               struct efi_load_option lo;
> >               char buf[BOOTMENU_DEVICE_NAME_MAX];
> >-              struct efi_device_path *device_path;
> >+              struct efi_device_path *device_path, *full_path, *dp, *fp;
> >               struct efi_device_path *short_dp;
> >+              struct efi_file_handle *root, *f;
> >+              struct efi_simple_file_system_protocol *file_system;
> >+              u16 *default_file_path = NULL;
> >
> >-              ret = efi_search_protocol(volume_handles[i], &efi_guid_device_path, &handler);
> >+              ret = efi_search_protocol(volume_handles[i],
> >+                                        &efi_guid_device_path, &handler);
> >               if (ret != EFI_SUCCESS)
> >                       continue;
> >-              ret = efi_protocol_open(handler, (void **)&device_path,
> >-                                      efi_root, NULL, EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> >+
> >+              device_path = handler->protocol_interface;
> >+              full_path = efi_dp_from_file(device_path,
> >+                                           "/EFI/BOOT/" BOOTEFI_NAME);
> >+
> >+              /* check whether the partition or disk have the default file */
> >+              ret = efi_dp_split_file_path(full_path, &dp, &fp);
> >+              if (ret != EFI_SUCCESS || !fp)
> >+                      goto next_entry;
> >+
> >+              default_file_path = efi_dp_str(fp);
> >+              if (!default_file_path)
> >+                      goto next_entry;
> >+
> >+              ret = efi_search_protocol(volume_handles[i],
> >+                                        &efi_simple_file_system_protocol_guid,
> >+                                        &handler);
> >               if (ret != EFI_SUCCESS)
> >-                      continue;
> >+                      goto next_entry;
> >+
> >+              file_system = handler->protocol_interface;
> >+              ret = EFI_CALL(file_system->open_volume(file_system, &root));
> >+              if (ret != EFI_SUCCESS)
> >+                      goto next_entry;
> >+
> >+              ret = EFI_CALL(root->open(root, &f, default_file_path,
> >+                                        EFI_FILE_MODE_READ, 0));
> >+              if (ret != EFI_SUCCESS)
> >+                      goto next_entry;
> >+
> >+              EFI_CALL(f->close(f));
> >
> >               ret = efi_disk_get_device_name(volume_handles[i], buf, BOOTMENU_DEVICE_NAME_MAX);
> >               if (ret != EFI_SUCCESS)
> >-                      continue;
> >+                      goto next_entry;
> >
> >               p = dev_name;
> >               utf8_utf16_strncpy(&p, buf, strlen(buf));
> >
> >               /* prefer to short form device path */
> >-              short_dp = efi_dp_shorten(device_path);
> >-              if (short_dp)
> >-                      device_path = short_dp;
> >+              short_dp = efi_dp_shorten(full_path);
> >+              device_path = short_dp ? short_dp : full_path;
> >
> >               lo.label = dev_name;
> >               lo.attributes = LOAD_OPTION_ACTIVE;
> >@@ -396,24 +426,35 @@ static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boo
> >               lo.file_path_length = efi_dp_size(device_path) + sizeof(END);
> >               /*
> >                * Set the dedicated guid to optional_data, it is used to identify
> >-               * the boot option that automatically generated by the bootmenu.
> >+               * the boot option that automatically generated by the efibootmgr.
> >                * efi_serialize_load_option() expects optional_data is null-terminated
> >                * utf8 string, so set the "1234567" string to allocate enough space
> >                * to store guid, instead of realloc the load_option.
> >                */
> >               lo.optional_data = "1234567";
> >-              opt[i].size = efi_serialize_load_option(&lo, (u8 **)&opt[i].lo);
> >-              if (!opt[i].size) {
> >-                      ret = EFI_OUT_OF_RESOURCES;
> >-                      goto out;
> >+              opt[num].size = efi_serialize_load_option(&lo, (u8 **)&opt[num].lo);
> >+              if (!opt[num].size) {
> >+                      efi_free_pool(full_path);
> >+                      efi_free_pool(dp);
> >+                      efi_free_pool(fp);
> >+                      efi_free_pool(default_file_path);
> >+                      return EFI_OUT_OF_RESOURCES;
> >               }
> >               /* set the guid */
> >-              optional_data = (char *)opt[i].lo + (opt[i].size - u16_strsize(u"1234567"));
> >+              optional_data = (char *)opt[num].lo + (opt[num].size - u16_strsize(u"1234567"));
> >               memcpy(optional_data, &efi_guid_bootmenu_auto_generated, sizeof(efi_guid_t));
> >+              num++;
> >+
> >+next_entry:
> >+              efi_free_pool(full_path);
> >+              efi_free_pool(dp);
> >+              efi_free_pool(fp);
> >+              efi_free_pool(default_file_path);
> >       }
> >
> >-out:
> >-      return ret;
> >+      *count = num;
> >+
> >+      return EFI_SUCCESS;
> > }
> >
> > /**
> >@@ -642,7 +683,7 @@ efi_status_t efi_bootmgr_delete_boot_option(u16 boot_index)
> >  * efi_bootmgr_update_media_device_boot_option() - generate the media device boot option
> >  *
> >  * This function enumerates all devices supporting EFI_SIMPLE_FILE_SYSTEM_PROTOCOL
> >- * and generate the bootmenu entries.
> >+ * and create the boot option with default file if the file exists.
> >  * This function also provide the BOOT#### variable maintenance for
> >  * the media device entries.
> >  * - Automatically create the BOOT#### variable for the newly detected device,
> >@@ -674,8 +715,7 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void)
> >               goto out;
> >       }
> >
> >-      /* enumerate all devices supporting EFI_SIMPLE_FILE_SYSTEM_PROTOCOL */
> >-      ret = efi_bootmgr_enumerate_boot_option(opt, volume_handles, count);
> >+      ret = efi_bootmgr_enumerate_boot_option(opt, volume_handles, &count);
> >       if (ret != EFI_SUCCESS)
> >               goto out;
> >
