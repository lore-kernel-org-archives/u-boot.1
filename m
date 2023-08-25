Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5958AC3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 07:57:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A92AE86A1C;
	Fri, 25 Aug 2023 09:57:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KTaDNwqY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43C1D869AF; Fri, 25 Aug 2023 09:57:08 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4BE686A40
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 09:57:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6bb07d274feso508711a34.0
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 00:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692950223; x=1693555023;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9QOU+fDU0uuB6lDHfcRqO/lwZWGuWohHPRxHYPx3o4A=;
 b=KTaDNwqYfTbWPSONg9mMq7TEtFAflFD8sXMggmPWJk7/7LF9D1Zd+Y4MRKWSAgfbhX
 aU/o1g3s24TlzFGcJncDf2WxKzC9WfUv07j0gw94FOXoH8uNfPztmfxrxH17SvDnSMjL
 JD0Y1lKlJGDtWim7oi51qoBULJ02tPUVnNKv0Hu4atfeWLKXG/JTuKWee1y5pkLZ05sQ
 Ee74OWZS3qZj5CbgWydMCFJNeooXPILIL48teTqM4/arEX9eP82P4Z9hr2/5A3a7hQMd
 VIZKyUWDnAgwfSvF3Nu9wQ0dymMvuX8mbQ+Td0P8hYju8ETVmnlm84QnQ4YLKjvY4D3L
 ED1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692950223; x=1693555023;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9QOU+fDU0uuB6lDHfcRqO/lwZWGuWohHPRxHYPx3o4A=;
 b=TZxP1/pjGN4GrzB1JEP2eYGKpUGiGDd1B/sEQUh8jh1kNj9i67S9W50KTp6doi7t4g
 O3rOZ35F1J53binFyLLrw+Ah1nhE5O1NhcIGZPk8Rpv+hKjw3SQwX//5IzgbcGRU2jBN
 sTHG36ZtZDG89SsikhhD9btzNrEuoOhFg+4t8yxPSdcGRKYk29Nhl6FBqifx8TxUtl4p
 krmhtCKPB8gy9N9/yOW/98p3rRX/N6utIIBSOKcqIWhZZ7zyjFDNX717SJWXFClEFmjk
 O2szvNlJCPnEN3bLkVF7Y7nvtXgic6pycYS9FHy9kGOOXN4Yg6zaot+hoQ4+o8GuFwJO
 Fz4w==
X-Gm-Message-State: AOJu0YxQCBZ8o50WFAMgqJLME4Od6OTPb5IzjlVX1zDb7YL8ON4Xw/g7
 9LwdhEmzv9U9aH05rx0vawAUORl8oELdbARE7rv5+Q==
X-Google-Smtp-Source: AGHT+IGjjXE6v3MQ/GHbjFMwOmWJnakgZ67+Y77dMLNticCgtZvte4aW2BfekXJ/vKCeg3OlKrgE3QQiUGj/VUfJdnU=
X-Received: by 2002:a05:6870:4153:b0:1b0:897d:1817 with SMTP id
 r19-20020a056870415300b001b0897d1817mr2386067oad.14.1692950223282; Fri, 25
 Aug 2023 00:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230823083721.1318097-1-masahisa.kojima@linaro.org>
 <20230823083721.1318097-3-masahisa.kojima@linaro.org>
 <90d33dfc-1085-f402-e428-63b323db152b@gmx.de>
In-Reply-To: <90d33dfc-1085-f402-e428-63b323db152b@gmx.de>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Fri, 25 Aug 2023 16:56:51 +0900
Message-ID: <CADQ0-X_dArA2CnB+Z6OCk6uM43j=nrkwYgRH44OUXfaCQcrG+g@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi_loader: support boot from URI device path
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Thu, 24 Aug 2023 at 15:57, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 8/23/23 10:37, Masahisa Kojima wrote:
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
> >   lib/efi_loader/efi_bootmgr.c | 213 +++++++++++++++++++++++++++++++++++
> >   1 file changed, 213 insertions(+)
> >
> > diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> > index a40762c74c..8b20f486f2 100644
> > --- a/lib/efi_loader/efi_bootmgr.c
> > +++ b/lib/efi_loader/efi_bootmgr.c
> > @@ -7,10 +7,14 @@
> >
> >   #define LOG_CATEGORY LOGC_EFI
> >
> > +#include <blk.h>
> > +#include <blkmap.h>
> >   #include <common.h>
> >   #include <charset.h>
> > +#include <dm.h>
> >   #include <log.h>
> >   #include <malloc.h>
> > +#include <net.h>
> >   #include <efi_default_filename.h>
> >   #include <efi_loader.h>
> >   #include <efi_variable.h>
> > @@ -168,6 +172,209 @@ out:
> >       return ret;
> >   }
> >
> > +#if (IS_ENABLED(CONFIG_BLKMAP) && IS_ENABLED(CONFIG_CMD_WGET) && IS_ENABLED(CONFIG_CMD_DNS))
> > +/**
> > + * mount_image() - mount the image
> > + *
> > + * @lo_label label of load option
> > + * @file_size        file size
> > + * @handle:  pointer to handle for newly installed image
> > + * Return:   status code
> > + */
> > +static efi_status_t mount_image(u16 *lo_label, int file_size,
> > +                             efi_handle_t *handle)
> > +{
> > +     int err;
> > +     efi_status_t ret;
> > +     char *label = NULL, *p;
> > +     lbaint_t blknum;
> > +     struct udevice *bm_dev;
> > +     efi_handle_t bm_handle;
> > +     struct udevice *blk, *partition;
> > +     struct efi_handler *handler;
> > +     struct efi_device_path *file_path;
> > +     struct efi_device_path *device_path;
> > +
> > +     label = efi_alloc(utf16_utf8_strlen(lo_label) + 1);
> > +     if (!label)
> > +             return EFI_OUT_OF_RESOURCES;
> > +
> > +     p = label;
> > +     utf16_utf8_strcpy(&p, lo_label);
> > +     err = blkmap_create(label, NULL);
> > +     if (err) {
> > +             log_err("failed to create blkmap\n");
> > +             ret = EFI_INVALID_PARAMETER;
> > +             goto out;
> > +     }
> > +     bm_dev = blkmap_from_label(label);
> > +     if (!bm_dev) {
> > +             log_err("\"%s\" is not the name of any known blkmap\n", label);
> > +             ret = EFI_INVALID_PARAMETER;
> > +             goto out;
> > +     }
> > +
> > +     blknum = file_size / 512; /* TODO: don't use literal value. */
>
> Can't you retrieve the block size from the udevice?
I have tried but I can't get block size. Anyway I will check again.

>
> > +     err = blkmap_map_pmem(bm_dev, 0, blknum, image_load_addr);
> > +     if (err) {
> > +             log_err("Unable to map %#llx at block %d : %d\n",
> > +                     (unsigned long long)image_load_addr, 0, err);
> > +             ret = EFI_INVALID_PARAMETER;
> > +             goto out;
> > +     }
> > +     log_info("Block %d+0x" LBAF " mapped to %#llx\n", 0, blknum,
> > +              (unsigned long long)image_load_addr);
> > +
> > +     /* TODO: without calling this, partition devices are not binded. */
>
> %s/binded/bound/
Thank you for correcting the typo.

>
> > +     blk_list_part(UCLASS_BLKMAP);
>
> Why would you want to display all BLKMAP devices?
> Please, avoid unnecessary output.
I will try to probe all the partitions with device_probe() call.

>
> > +
> > +     /*
> > +      * Search the partition having EFI_SIMPLE_FILE_SYSTEM_PROTOCOL,
> > +      * then try to load with the default boot file(e.g. EFI/BOOT/BOOTAA64.EFI).
> > +      */
> > +     device_foreach_child(blk, bm_dev)
> > +     {
>
> You need to check that blk is of type UCLASS_PARTITION.
OK.

>
> What about images that have no partition table but only a file system?
I will check how to handle this case.

>
> > +             device_foreach_child(partition, blk)
> > +             {
> > +                     if (dev_tag_get_ptr(partition, DM_TAG_EFI,
> > +                                         (void **)&bm_handle)) {
> > +                             log_warning("DM_TAG_EFI not found\n");
> > +                             continue;
> > +                     }
> > +
> > +                     ret = efi_search_protocol(
> > +                             bm_handle,
> > +                             &efi_simple_file_system_protocol_guid,
> > +                             &handler);
> > +                     if (ret != EFI_SUCCESS)
> > +                             continue;
> > +
> > +                     ret = efi_search_protocol(
> > +                             bm_handle, &efi_guid_device_path, &handler);
> > +                     if (ret != EFI_SUCCESS)
> > +                             continue;
> > +
> > +                     ret = efi_protocol_open(handler, (void **)&device_path,
> > +                                             efi_root, NULL,
> > +                                             EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> > +                     if (ret != EFI_SUCCESS)
> > +                             continue;
>
> Do you expect multiple ESPs? Why not return the error here?
According to the UEFI spec, the system can boot from the device
having EFI_SIMPLE_FILE_SYSTEM_PROTOCOL.
This loop does not try to find the ESP, try to find the device having
EFI_SIMPLE_FILE_SYSTEM_PROTOCOL and check if there is a
default boot file(e.g. EFI/BOOT/BOOTAA64.EFI).

>
> > +
> > +                     file_path = expand_media_path(device_path);
> > +                     ret = EFI_CALL(efi_load_image(true, efi_root, file_path,
> > +                                                   NULL, 0, handle));
> > +                     efi_free_pool(file_path);
> > +                     if (ret == EFI_SUCCESS)
> > +                             goto out;
>
> ditto
At here, the default boot file is loaded into the memory, we could
exit the loop and
start the image.

>
> > +             }
> > +     }
> > +
>
> ret may not even be initialized at this point!
Thank you, I will fix this, EFI_NOT_FOUND should be returned.

> I would expect EFI_NOT_FOUND to be returned if there is no ESP.
My intention here is that there is no bootable device contains default
boot file(e.g. EFI/BOOT/BOOTAA64.EFI).

>
> > +out:
> > +     efi_free_pool(label);
> > +
> > +     return ret;
> > +}
> > +
> > +/**
> > + * try_load_from_uri_path() - Handle the URI device path
> > + *
> > + * @uridp:   uri device path
> > + * @lo_label label of load option
> > + * @handle:  pointer to handle for newly installed image
> > + * Return:   status code
> > + */
> > +static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
> > +                                        u16 *lo_label,
> > +                                        efi_handle_t *handle)
> > +{
> > +     efi_status_t ret;
> > +     int file_size, file_name_len;
> > +     char *s, *host_name, *file_name, *str_copy;
> > +
> > +     /*
> > +      * Download file using wget.
> > +      *
> > +      * URI device path content is like http://www.example.com/sample/test.iso.
> > +      * U-Boot wget takes the target uri in this format.
> > +      *  "<http server ip>:<file path>"  e.g.) 192.168.1.1:/sample/test.iso
> > +      * Need to resolve the http server ip address before starting wget.
> > +      */
> > +
> > +     /* only support "http://" */
> > +     if (strncmp(uridp->uri, "http://", 7)) {
> > +             log_err("Error: uri must start with http://\n");
> > +             return EFI_INVALID_PARAMETER;
> > +     }
> > +
> > +     str_copy = strdup(uridp->uri);
> > +     if (!str_copy)
> > +             return EFI_OUT_OF_RESOURCES;
> > +     s = str_copy + strlen("http://");
> > +     host_name = strsep(&s, "/");
>
> This could be "user:password@example.com".
Yes, but current wget does not support this format.
Need to be checked when the user input the URI as you suggested.

>
> > +     if (!s) {
> > +             log_err("Error: invalied uri, no file path\n");
> > +             ret = EFI_INVALID_PARAMETER;
> > +             goto out;
> > +     }
> > +     file_name = s;
> > +     net_dns_resolve = host_name;
> > +     net_dns_env_var = "httpserverip";
> > +     if (net_loop(DNS) < 0) {
>
> Why call net_loop(DNS) for an IP address like
> [2a00:1450:4001:812::200e] or 142.250.185.206?
Currently lwip migration is ongoing, and lwip wget correctly handles this.
I plan to rebase on top of the lwip port.

>
> > +             log_err("Error: dns lookup of %s failed, check setup\n", net_dns_resolve);
> > +             ret = EFI_INVALID_PARAMETER;
> > +             goto out;
> > +     }
>
> This logic seems not to be EFI related. There should be a network
> library function that takes a URL and returns a filled buffer.
>
> > +     s = env_get("httpserverip");
>
> Why should this variable be used if host_name is "142.250.185.206"?
OK.

>
> If the host name has no DNS entry and is not a valid IP address we
> should error out here.
OK.

>
> > +     if (!s) {
> > +             ret = EFI_INVALID_PARAMETER;
> > +             goto out;
> > +     }
> > +
> > +     /*
> > +      * WGET requires that "net_boot_file_name" and "image_load_addr" global
> > +      * variables are properly set in advance.
> > +      */
> > +     strlcpy(net_boot_file_name, s, 1024);
> > +     strlcat(net_boot_file_name, ":/", 1024); /* append '/' which is removed by strsep() */
>
> On a single IP address you may find multiple servers. Even if there is
> only one it may not provide the resource if you don't supply the host name.
>
> It would be preferable to adjust wget to comply to RFC 7320 ("Hypertext
> Transfer Protocol (HTTP/1.1): Message Syntax and Routing") and provide a
> HOST: header.

Current wget does not support HOST: header but lwip port does support.
So lwip migration will address this issue.

>
> > +     strlcat(net_boot_file_name, file_name, 1024);
> > +     s = env_get("loadaddr");
> > +     if (!s) {
> > +             log_err("Error: loadaddr is not set\n");
> > +             ret = EFI_INVALID_PARAMETER;
> > +             goto out;
> > +     }
> > +     image_load_addr = hextoul(s, NULL);
> > +
> > +     file_size = net_loop(WGET);
>
> This looks insecure.
>
> You must define a maximum file size before trying to download and use
> lmb_init_and_reserve() to check that the buffer is available. Otherwise
> you might download a large file that overwrites the stack or U-Boot's code.
>
> net_loop() must check that the reserved memory size is not exceeded.

OK, I will add the maximum file size env variable, or try to utilize the
Content-Length response header.

>
> > +     if (file_size < 0) {
> > +             log_err("Error: downloading file failed\n");
> > +             ret = EFI_INVALID_PARAMETER;
> > +             goto out;
> > +     }
> > +
> > +     /*
> > +      * Identify file type by file extension.
> > +      * If the file extension is ".iso" or ".img", mount it and boot with default file.
> > +      * If the file is ".efi", load and start the downloaded file.
>
> Please, don't rely on file extensions.
>
> Inspect the buffer using function efi_check_pe() to discover if it is an
> EFI binary.
OK.

>
> mount_image() should return an error code if the buffer does not contain
> a partition table or a file system.
OK.

Thanks,
Masahisa Kojima

>
> Best regards
>
> Heinrich
>
> > +      */
> > +     file_name_len = strlen(net_boot_file_name);
> > +     if (!strncmp(&net_boot_file_name[file_name_len - 4], ".iso", 4) ||
> > +         !strncmp(&net_boot_file_name[file_name_len - 4], ".img", 4)) {
> > +             ret = mount_image(lo_label, file_size, handle);
> > +     } else if (!strncmp(&net_boot_file_name[file_name_len - 4], ".efi", 4)) {
> > +             ret = efi_run_image((void *)image_load_addr, file_size);
> > +     } else {
> > +             log_err("Error: file type is not supported\n");
> > +             ret = EFI_INVALID_PARAMETER;
> > +     }
> > +
> > +out:
> > +     free(str_copy);
> > +
> > +     return ret;
> > +}
> > +#endif
> > +
> >   /**
> >    * try_load_entry() - try to load image for boot option
> >    *
> > @@ -211,6 +418,12 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
> >               if (EFI_DP_TYPE(lo.file_path, MEDIA_DEVICE, FILE_PATH)) {
> >                       /* file_path doesn't contain a device path */
> >                       ret = try_load_from_short_path(lo.file_path, handle);
> > +#if (IS_ENABLED(CONFIG_BLKMAP) && IS_ENABLED(CONFIG_CMD_WGET) && IS_ENABLED(CONFIG_CMD_DNS))
> > +             } else if (EFI_DP_TYPE(lo.file_path, MESSAGING_DEVICE, MSG_URI)) {
> > +                     ret = try_load_from_uri_path(
> > +                             (struct efi_device_path_uri *)lo.file_path,
> > +                             lo.label, handle);
> > +#endif
> >               } else {
> >                       file_path = expand_media_path(lo.file_path);
> >                       ret = EFI_CALL(efi_load_image(true, efi_root, file_path,
>
