Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9E7C71133
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 06:31:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16FB386A09;
	Fri, 25 Aug 2023 08:31:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zDRXUAyk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 366FC869AF; Fri, 25 Aug 2023 08:31:49 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6B5C86A09
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 08:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-26d0d376ec7so377871a91.2
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 23:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692945104; x=1693549904;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jq73jw/MZQREQZSt2CFbqvu0QuiMreZMTO7JAjV41M0=;
 b=zDRXUAykEEJIW5CpzQdpLl6jbtgkYRJnICcjJoy23Vq6gdj7J2zl8OMe4IJc5xf4UU
 /VSWJtNJK1b/ck2KIOmdkGiHEqmYlmNKgjW7YhH05/uPiZvhBlkUiYV/HxWMxe8MbDPv
 BlhAWflFaxGRq4HEmHPoXW1aFDNAEezmTgROnWKb76vcybVc6HSkIOOYLPOQDONhwaXo
 V8C9DH+9HjdtD8BUhXmPAPtOO6y3WHGCBYrKipuBj4V90u7qnlUOCpdgVXb9wU1M8JMk
 C7Fm4gvXPXMI5qTWlrx7k/NU27KNcefGmpROBdfEcqXJ5QK8RY+3BvQnL8ObmB3KIZsh
 07ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692945104; x=1693549904;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jq73jw/MZQREQZSt2CFbqvu0QuiMreZMTO7JAjV41M0=;
 b=QwSGArqZVZ0cqmN869pMS6CoxiPjqKICO0/sw8A8HmO/CsJm8qQ7dt65xovoi24wRz
 x6FACC6Qw5Ih9GYeAAEGM8JNpOKrPRbP8EnQXC768cE6qzAvTediHnNmhSwfAFKJq8w1
 DT04UNHibAoB8TQyqJlVnMeG7uR7MxvTcVL09GK8ZkRr0mdNcf++o6HUmBVmsYhlpwGI
 VMAGkfX2BdHCQq/QGTTFjUHhvygA1PBosXTW8xc5KcHYOfSm5LeRolehpypp31ManT7S
 vEFmYeArxf1Mi7rHg4/7KMc5g1WXMqb639bYhJAsuQ8VXcktyZVWdlPukQdmt7hy68ha
 uqlg==
X-Gm-Message-State: AOJu0YzN/X+qmNpT5pbnAhcnP+qs712D6BXPasi0k7qa5aU5Uk/FuTU1
 OAKjEdaJWjEbjqGAA4rmVrTrftZZSCNHOXnZE65rgAh4QdE+q73S
X-Google-Smtp-Source: AGHT+IGFO6pz9mM6qUCY7ZNSdY5pEN7x51xNsQsXxZkRnnEDOB/pmNBZqlMHwxWtVWW4FeZRLOzKI4HjkealpO1cvB0=
X-Received: by 2002:a17:90b:1b49:b0:267:f66a:f25f with SMTP id
 nv9-20020a17090b1b4900b00267f66af25fmr16344841pjb.11.1692945103865; Thu, 24
 Aug 2023 23:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230823083721.1318097-1-masahisa.kojima@linaro.org>
 <20230823083721.1318097-3-masahisa.kojima@linaro.org>
 <CAPnjgZ1Lkw8Y5g9txvp3JffAB9VrODghN=2K_PrZ3xhw44SsRw@mail.gmail.com>
In-Reply-To: <CAPnjgZ1Lkw8Y5g9txvp3JffAB9VrODghN=2K_PrZ3xhw44SsRw@mail.gmail.com>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Fri, 25 Aug 2023 15:31:32 +0900
Message-ID: <CADQ0-X9B1RrLi8iKWDVfNuUkhFUaxdva0q+Xec=Zf4qTbzT0zg@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi_loader: support boot from URI device path
To: Simon Glass <sjg@google.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Thu, 24 Aug 2023 at 08:59, Simon Glass <sjg@google.com> wrote:
>
> Hi Masahisa,
>
> On Wed, 23 Aug 2023 at 02:38, Masahisa Kojima
> <masahisa.kojima@linaro.org> wrote:
> >
> > This supports to boot from the URI device path.
> > When user selects the URI device path, bootmgr downloads
> > the file using wget into the address specified by loadaddr
> > env variable.
> > If the file is .iso or .img file, mount the image with blkmap
> > then try to boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
> > If the file is .efi file, load and start the downloaded file.
> >
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > ---
> >  lib/efi_loader/efi_bootmgr.c | 213 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 213 insertions(+)
> >
>
> Much of this code should be factored out into a help which can be
> called from other code. See comments below.
>
> > diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> > index a40762c74c..8b20f486f2 100644
> > --- a/lib/efi_loader/efi_bootmgr.c
> > +++ b/lib/efi_loader/efi_bootmgr.c
> > @@ -7,10 +7,14 @@
> >
> >  #define LOG_CATEGORY LOGC_EFI
> >
> > +#include <blk.h>
> > +#include <blkmap.h>
> >  #include <common.h>
> >  #include <charset.h>
> > +#include <dm.h>
> >  #include <log.h>
> >  #include <malloc.h>
> > +#include <net.h>
> >  #include <efi_default_filename.h>
> >  #include <efi_loader.h>
> >  #include <efi_variable.h>
> > @@ -168,6 +172,209 @@ out:
> >         return ret;
> >  }
> >
> > +#if (IS_ENABLED(CONFIG_BLKMAP) && IS_ENABLED(CONFIG_CMD_WGET) && IS_ENABLED(CONFIG_CMD_DNS))
> > +/**
> > + * mount_image() - mount the image
> > + *
> > + * @lo_label   label of load option
> > + * @file_size  file size
> > + * @handle:    pointer to handle for newly installed image
> > + * Return:     status code
> > + */
> > +static efi_status_t mount_image(u16 *lo_label, int file_size,
> > +                               efi_handle_t *handle)
> > +{
> > +       int err;
> > +       efi_status_t ret;
> > +       char *label = NULL, *p;
> > +       lbaint_t blknum;
> > +       struct udevice *bm_dev;
> > +       efi_handle_t bm_handle;
> > +       struct udevice *blk, *partition;
> > +       struct efi_handler *handler;
> > +       struct efi_device_path *file_path;
> > +       struct efi_device_path *device_path;
> > +
> > +       label = efi_alloc(utf16_utf8_strlen(lo_label) + 1);
> > +       if (!label)
> > +               return EFI_OUT_OF_RESOURCES;
> > +
>
> From here:
>
> > +       p = label;
> > +       utf16_utf8_strcpy(&p, lo_label);
> > +       err = blkmap_create(label, NULL);
> > +       if (err) {
> > +               log_err("failed to create blkmap\n");
> > +               ret = EFI_INVALID_PARAMETER;
> > +               goto out;
> > +       }
> > +       bm_dev = blkmap_from_label(label);
> > +       if (!bm_dev) {
> > +               log_err("\"%s\" is not the name of any known blkmap\n", label);
> > +               ret = EFI_INVALID_PARAMETER;
> > +               goto out;
> > +       }
> > +
> > +       blknum = file_size / 512; /* TODO: don't use literal value. */
> > +       err = blkmap_map_pmem(bm_dev, 0, blknum, image_load_addr);
> > +       if (err) {
> > +               log_err("Unable to map %#llx at block %d : %d\n",
> > +                       (unsigned long long)image_load_addr, 0, err);
> > +               ret = EFI_INVALID_PARAMETER;
> > +               goto out;
> > +       }
> > +       log_info("Block %d+0x" LBAF " mapped to %#llx\n", 0, blknum,
> > +                (unsigned long long)image_load_addr);
> > +
> > +       /* TODO: without calling this, partition devices are not binded. */
> > +       blk_list_part(UCLASS_BLKMAP);
> > +
> > +       /*
> > +        * Search the partition having EFI_SIMPLE_FILE_SYSTEM_PROTOCOL,
> > +        * then try to load with the default boot file(e.g. EFI/BOOT/BOOTAA64.EFI).
> > +        */
> > +       device_foreach_child(blk, bm_dev)
> > +       {
>
> check code style
OK.

>
> > +               device_foreach_child(partition, blk)
> > +               {
>
> to here.
OK, I will factor out the non-EFI code for reuse.

>
> Perhaps have partition_first() and partition_next() iterators?
>
> From here is EFI code:
>
> > +                       if (dev_tag_get_ptr(partition, DM_TAG_EFI,
> > +                                           (void **)&bm_handle)) {
> > +                               log_warning("DM_TAG_EFI not found\n");
> > +                               continue;
> > +                       }
> > +
> > +                       ret = efi_search_protocol(
> > +                               bm_handle,
> > +                               &efi_simple_file_system_protocol_guid,
> > +                               &handler);
> > +                       if (ret != EFI_SUCCESS)
> > +                               continue;
> > +
> > +                       ret = efi_search_protocol(
> > +                               bm_handle, &efi_guid_device_path, &handler);
> > +                       if (ret != EFI_SUCCESS)
> > +                               continue;
> > +
> > +                       ret = efi_protocol_open(handler, (void **)&device_path,
> > +                                               efi_root, NULL,
> > +                                               EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> > +                       if (ret != EFI_SUCCESS)
> > +                               continue;
> > +
> > +                       file_path = expand_media_path(device_path);
> > +                       ret = EFI_CALL(efi_load_image(true, efi_root, file_path,
> > +                                                     NULL, 0, handle));
> > +                       efi_free_pool(file_path);
> > +                       if (ret == EFI_SUCCESS)
> > +                               goto out;
> > +               }
> > +       }
> > +
> > +out:
> > +       efi_free_pool(label);
> > +
> > +       return ret;
> > +}
> > +
> > +/**
> > + * try_load_from_uri_path() - Handle the URI device path
> > + *
> > + * @uridp:     uri device path
> > + * @lo_label   label of load option
> > + * @handle:    pointer to handle for newly installed image
> > + * Return:     status code
> > + */
> > +static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
> > +                                          u16 *lo_label,
> > +                                          efi_handle_t *handle)
> > +{
> > +       efi_status_t ret;
> > +       int file_size, file_name_len;
> > +       char *s, *host_name, *file_name, *str_copy;
> > +
>
> From here should be normal caode:
OK.

>
> > +       /*
> > +        * Download file using wget.
> > +        *
> > +        * URI device path content is like http://www.example.com/sample/test.iso.
> > +        * U-Boot wget takes the target uri in this format.
> > +        *  "<http server ip>:<file path>"  e.g.) 192.168.1.1:/sample/test.iso
> > +        * Need to resolve the http server ip address before starting wget.
> > +        */
> > +
> > +       /* only support "http://" */
> > +       if (strncmp(uridp->uri, "http://", 7)) {
> > +               log_err("Error: uri must start with http://\n");
> > +               return EFI_INVALID_PARAMETER;
> > +       }
> > +
> > +       str_copy = strdup(uridp->uri);
> > +       if (!str_copy)
> > +               return EFI_OUT_OF_RESOURCES;
> > +       s = str_copy + strlen("http://");
> > +       host_name = strsep(&s, "/");
> > +       if (!s) {
> > +               log_err("Error: invalied uri, no file path\n");
> > +               ret = EFI_INVALID_PARAMETER;
> > +               goto out;
> > +       }
> > +       file_name = s;
> > +       net_dns_resolve = host_name;
> > +       net_dns_env_var = "httpserverip";
> > +       if (net_loop(DNS) < 0) {
> > +               log_err("Error: dns lookup of %s failed, check setup\n", net_dns_resolve);
> > +               ret = EFI_INVALID_PARAMETER;
> > +               goto out;
> > +       }
> > +       s = env_get("httpserverip");
> > +       if (!s) {
> > +               ret = EFI_INVALID_PARAMETER;
> > +               goto out;
> > +       }
> > +
> > +       /*
> > +        * WGET requires that "net_boot_file_name" and "image_load_addr" global
> > +        * variables are properly set in advance.
> > +        */
> > +       strlcpy(net_boot_file_name, s, 1024);
> > +       strlcat(net_boot_file_name, ":/", 1024); /* append '/' which is removed by strsep() */
> > +       strlcat(net_boot_file_name, file_name, 1024);
> > +       s = env_get("loadaddr");
> > +       if (!s) {
> > +               log_err("Error: loadaddr is not set\n");
> > +               ret = EFI_INVALID_PARAMETER;
> > +               goto out;
> > +       }
> > +       image_load_addr = hextoul(s, NULL);
> > +
> > +       file_size = net_loop(WGET);
> > +       if (file_size < 0) {
> > +               log_err("Error: downloading file failed\n");
> > +               ret = EFI_INVALID_PARAMETER;
> > +               goto out;
> > +       }
> > +
> > +       /*
> > +        * Identify file type by file extension.
> > +        * If the file extension is ".iso" or ".img", mount it and boot with default file.
> > +        * If the file is ".efi", load and start the downloaded file.
> > +        */
> > +       file_name_len = strlen(net_boot_file_name);
>
> to here.
>
> You could package that up into a function which returns the filename.
> Then the EFI code is this:
OK.

>
> > +       if (!strncmp(&net_boot_file_name[file_name_len - 4], ".iso", 4) ||
> > +           !strncmp(&net_boot_file_name[file_name_len - 4], ".img", 4)) {
> > +               ret = mount_image(lo_label, file_size, handle);
> > +       } else if (!strncmp(&net_boot_file_name[file_name_len - 4], ".efi", 4)) {
> > +               ret = efi_run_image((void *)image_load_addr, file_size);
> > +       } else {
> > +               log_err("Error: file type is not supported\n");
> > +               ret = EFI_INVALID_PARAMETER;
> > +       }
> > +
> > +out:
> > +       free(str_copy);
> > +
> > +       return ret;
> > +}
> > +#endif
> > +
> >  /**
> >   * try_load_entry() - try to load image for boot option
> >   *
> > @@ -211,6 +418,12 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
> >                 if (EFI_DP_TYPE(lo.file_path, MEDIA_DEVICE, FILE_PATH)) {
> >                         /* file_path doesn't contain a device path */
> >                         ret = try_load_from_short_path(lo.file_path, handle);
> > +#if (IS_ENABLED(CONFIG_BLKMAP) && IS_ENABLED(CONFIG_CMD_WGET) && IS_ENABLED(CONFIG_CMD_DNS))
> > +               } else if (EFI_DP_TYPE(lo.file_path, MESSAGING_DEVICE, MSG_URI)) {
> P> +                       ret = try_load_from_uri_path(
> > +                               (struct efi_device_path_uri *)lo.file_path,
> > +                               lo.label, handle);
> > +#endif
> >                 } else {
> >                         file_path = expand_media_path(lo.file_path);
> >                         ret = EFI_CALL(efi_load_image(true, efi_root, file_path,
> > --
> > 2.34.1
> >
>
> Also please consider how to test this. With the changes I mention
> above, you can fairly easily test the partition stuff (we have several
> mmc images for testing).

Yes. I wonder how to test the dns/wget part.

Thanks,
Masahisa Kojima

>
> Regards,
> Simon
