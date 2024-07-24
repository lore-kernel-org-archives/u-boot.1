Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389FBC3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 09:53:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A84688883E;
	Wed, 24 Jul 2024 11:53:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Z9TPfezr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49BA388800; Wed, 24 Jul 2024 11:53:40 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C989888C2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 11:53:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-368313809a4so433211f8f.0
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 02:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721814817; x=1722419617;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:to:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XGMVN2eXP7CIlhk7NuNHdbVG6YohttrQ81Os9kn9YLo=;
 b=Z9TPfezrv8vQltTlwBUZMhPEuGOrf+TrNEmU2u3a3war7jpn344wVT5/kiAcqDWMWf
 +Vv+bUlDg9+nahTFTYQ1sQccDX1+nC9E0H2FIjUMiApCmiehCw/VymWLmF5wqmkqO3aR
 a+pneTJ/MeZWK8DygL+nQ6dnRuG1UxEsgeOwkfhwSZsS+jjtL2bdIYLY24UWOSqRVirq
 d9XJgPRyTIngNlc2RzUrVrygeNg0Wzv+nHpZcEH0ebUQLf2R9BxYOBIbbg9pJkPswxqY
 Pp5RZn0WndNwZs8OXH0Gpw5B39yE1OMOYZbxWkmpVi3Ld8ygdSdxMpp4lFtxe1+l8JZ/
 R4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721814817; x=1722419617;
 h=mime-version:message-id:date:references:in-reply-to:subject:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XGMVN2eXP7CIlhk7NuNHdbVG6YohttrQ81Os9kn9YLo=;
 b=DZZP9hHGhi3YdGvShK86qJUUtUNR+HfSoIaaI95CtX65kSRb/wr/Uo7gKxoBO6fMpk
 wnj0//n9Dy+IEz/vJADn7StW5nduNV52kZxxKrtMqgCzqyWQ5fLnFtDjAMX4Y2LxFZnP
 PAUI5Cb1vLtPlEEbtONLTdjkKQJiR4mxn7wcS59EDO8qN9B28+xHgRodSij792Gtpi0a
 TVqj/lD/3V22jTkvNnR8P5xHBKhAQcxUWIUwBlsyyrlc+I3PGklxTRcfb1Eq11sqEQM8
 Hb+DXNxrusoC/fuCW2ufF76wN+/Mww6brnSA1B1X8KdlomfTNCLDLVHdeOytEQYw7GWw
 yMkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjwB7G9oGD4LdO+EF4DkI2IhHP3Gtwd0X0gAgUrs0dPvQ0Nh9roMnqsxXtDmrXwfhrUToZKsINOv7PjszyVr1xRme8EQ==
X-Gm-Message-State: AOJu0YyF5yXlx5nqMpYt3dywA10SQqGsI98PkNo7JCJDvu/RIVDAoAsd
 fz4wvg9CPv+x4E99PTgey41+m+dyFp9yJXOWi6VYSi2p6fYjrKAtWTw1rYKKDl8=
X-Google-Smtp-Source: AGHT+IGTghTXg9eQQnWFoPUYIyifpFVsBe4uJsfhunUfMeuNhFh/K1VZ5wxX99wTGRtXc2qfoN/yGQ==
X-Received: by 2002:adf:fe0c:0:b0:361:94d9:1e9f with SMTP id
 ffacd0b85a97d-369f6681185mr974010f8f.7.1721814816404; 
 Wed, 24 Jul 2024 02:53:36 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868477fsm13851850f8f.12.2024.07.24.02.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 02:53:35 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Dmitrii Merkurev
 <dimorinny@google.com>
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
In-Reply-To: <87ttgf5emw.fsf@baylibre.com>
References: <20240723141844.GF989285@bill-the-cat>
 <87ttgf5emw.fsf@baylibre.com>
Date: Wed, 24 Jul 2024 11:53:34 +0200
Message-ID: <87r0bj5d5t.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On mer., juil. 24, 2024 at 11:21, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:

> Hi Tom,
>
> Thank you for the report.
>
> On mar., juil. 23, 2024 at 08:18, Tom Rini <trini@konsulko.com> wrote:
>
>> Here's the latest report.
>>
>> ---------- Forwarded message ---------
>> From: <scan-admin@coverity.com>
>> Date: Mon, Jul 22, 2024, 8:07 PM
>> Subject: New Defects reported by Coverity Scan for Das U-Boot
>> To: <tom.rini@gmail.com>
>>
>>
>> Hi,
>>
>> Please find the latest report on new defect(s) introduced to Das U-Boot
>> found with Coverity Scan.
>>
>> 8 new defect(s) introduced to Das U-Boot found with Coverity Scan.
>> 3 defect(s), reported by Coverity Scan earlier, were marked fixed in the
>> recent build analyzed by Coverity Scan.
>>
>> New defect(s) Reported-by: Coverity Scan
>> Showing 8 of 8 defect(s)
>>
>>
>> ** CID 501795:  Insecure data handling  (TAINTED_SCALAR)
>>
>>
>> ________________________________________________________________________________________________________
>> *** CID 501795:  Insecure data handling  (TAINTED_SCALAR)
>> /boot/bootmeth_android.c: 96 in scan_boot_part()
>> 90      if (!is_android_boot_image_header(buf)) {
>> 91              free(buf);
>> 92              return log_msg_ret("header", -ENOENT);
>> 93      }
>> 94
>> 95      priv->header_version = ((struct andr_boot_img_hdr_v0
>> *)buf)->header_version;
>>>>>     CID 501795:  Insecure data handling  (TAINTED_SCALAR)
>>>>>     Passing tainted expression "*buf" to "dlfree", which uses it as an
>> offset.
>
> scan_boot_part() generates this warning, but scan_vendor_boot_part()
> does not.
> Both functions follow a similar code flow.
>
> The only reason scan_boot_part() generates this warning, is because of
> the downcast into struct andr_boot_img_hdr_v0.
>
> We can't change char* buf into struct andr_boot_img_hdr_v0 because we
> need to be block aligned when calling blk_dread().
>
> Per my understanding tainted data means it comes from user input (which
> is true for both scan_boot_part() and scan_vendor_boot_part() because
> both read from eMMC, which can be consider "user input".
>
> Since I don't see any particular problem with this code I propose that
> we ignore this warning.
>
>
>> 96      free(buf);
>> 97
>> 98      return 0;
>> 99     }
>> 100
>> 101     static int scan_vendor_boot_part(struct udevice *blk, struct
>> android_priv *priv)
>>
>> ** CID 501794:  Memory - corruptions  (OVERRUN)
>>
>>
>> ________________________________________________________________________________________________________
>> *** CID 501794:  Memory - corruptions  (OVERRUN)
>> /lib/tpm_tcg2.c: 640 in tcg2_measurement_init()
>> 634             rc = tcg2_log_prepare_buffer(*dev, elog,
>> ignore_existing_log);
>> 635             if (rc) {
>> 636                     tcg2_measurement_term(*dev, elog, true);
>> 637                     return rc;
>> 638             }
>> 639
>>>>>     CID 501794:  Memory - corruptions  (OVERRUN)
>>>>>     Overrunning array "version_string" of 50 bytes by passing it to a
>> function which accesses it at byte offset 63.
>> 640             rc = tcg2_measure_event(*dev, elog, 0, EV_S_CRTM_VERSION,
>> 641                                     strlen(version_string) + 1,
>> 642                                     (u8 *)version_string);
>> 643             if (rc) {
>> 644                     tcg2_measurement_term(*dev, elog, true);
>> 645                     return rc;
>>
>> ** CID 501793:  Insecure data handling  (TAINTED_SCALAR)
>> /lib/tpm-v2.c: 909 in tpm2_allow_extend()
>>
>>
>> ________________________________________________________________________________________________________
>> *** CID 501793:  Insecure data handling  (TAINTED_SCALAR)
>> /lib/tpm-v2.c: 909 in tpm2_allow_extend()
>> 903             int rc;
>> 904
>> 905             rc = tpm2_get_pcr_info(dev, &pcrs);
>> 906             if (rc)
>> 907                     return false;
>> 908
>>>>>     CID 501793:  Insecure data handling  (TAINTED_SCALAR)
>>>>>     Using tainted variable "pcrs.count" as a loop boundary.
>> 909             for (i = 0; i < pcrs.count; i++) {
>> 910                     if (tpm2_is_active_pcr(&pcrs.selection[i]) &&
>> 911                         !tpm2_algorithm_to_len(pcrs.selection[i].hash))
>> 912                             return false;
>> 913             }
>> 914
>> 915             return true;
>>
>> ** CID 501792:  Control flow issues  (DEADCODE)
>> /lib/efi_loader/efi_helper.c: 137 in efi_load_option_dp_join()
>>
>>
>> ________________________________________________________________________________________________________
>> *** CID 501792:  Control flow issues  (DEADCODE)
>> /lib/efi_loader/efi_helper.c: 137 in efi_load_option_dp_join()
>> 131             if (fdt_dp) {
>> 132                     struct efi_device_path *tmp_dp = *dp;
>> 133
>> 134                     *dp = efi_dp_concat(tmp_dp, fdt_dp, *dp_size);
>> 135                     efi_free_pool(tmp_dp);
>> 136                     if (!dp)
>>>>>     CID 501792:  Control flow issues  (DEADCODE)
>>>>>     Execution cannot reach this statement: "return
>> 9223372036854775817UL;".
>> 137                             return EFI_OUT_OF_RESOURCES;
>> 138                     *dp_size += efi_dp_size(fdt_dp) + sizeof(END);
>> 139             }
>> 140
>> 141             *dp_size += sizeof(END);
>> 142
>>
>> ** CID 501791:    (DEADCODE)
>> /drivers/usb/gadget/ether.c: 2219 in eth_bind()
>> /drivers/usb/gadget/ether.c: 2110 in eth_bind()
>> /drivers/usb/gadget/ether.c: 2071 in eth_bind()
>> /drivers/usb/gadget/ether.c: 2089 in eth_bind()
>>
>>
>> ________________________________________________________________________________________________________
>> *** CID 501791:    (DEADCODE)
>> /drivers/usb/gadget/ether.c: 2219 in eth_bind()
>> 2213                    out_ep->name, in_ep->name,
>> 2214                    status_ep ? " STATUS " : "",
>> 2215                    status_ep ? status_ep->name : ""
>> 2216                    );
>> 2217            printf("MAC %pM\n", pdata->enetaddr);
>> 2218
>>>>>     CID 501791:    (DEADCODE)
>>>>>     Execution cannot reach the expression "rndis" inside this
>> statement: "if (cdc || rndis)
>>   printf(...".
>> 2219            if (cdc || rndis)
>> 2220                    printf("HOST MAC %02x:%02x:%02x:%02x:%02x:%02x\n",
>> 2221                            dev->host_mac[0], dev->host_mac[1],
>> 2222                            dev->host_mac[2], dev->host_mac[3],
>> 2223                            dev->host_mac[4], dev->host_mac[5]);
>> 2224
>> /drivers/usb/gadget/ether.c: 2110 in eth_bind()
>> 2104                    device_desc.bNumConfigurations = 2;
>> 2105
>> 2106            if (gadget_is_dualspeed(gadget)) {
>> 2107                    if (rndis)
>> 2108                            dev_qualifier.bNumConfigurations = 2;
>> 2109                    else if (!cdc)
>>>>>     CID 501791:    (DEADCODE)
>>>>>     Execution cannot reach this statement: "dev_qualifier.bDeviceClass
>> ...".
>> 2110                            dev_qualifier.bDeviceClass =
>> USB_CLASS_VENDOR_SPEC;
>> 2111
>> 2112                    /* assumes ep0 uses the same value for both speeds
>> ... */
>> 2113                    dev_qualifier.bMaxPacketSize0 =
>> device_desc.bMaxPacketSize0;
>> 2114
>> 2115                    /* and that all endpoints are dual-speed */
>> /drivers/usb/gadget/ether.c: 2071 in eth_bind()
>> 2065
>> 2066     #if defined(CONFIG_USB_ETH_CDC) || defined(CONFIG_USB_ETH_RNDIS)
>> 2067            /*
>> 2068             * CDC Ethernet control interface doesn't require a status
>> endpoint.
>> 2069             * Since some hosts expect one, try to allocate one anyway.
>> 2070             */
>>>>>     CID 501791:    (DEADCODE)
>>>>>     Execution cannot reach the expression "rndis" inside this
>> statement: "if (cdc || rndis) {
>>   statu...".
>> 2071            if (cdc || rndis) {
>> 2072                    status_ep = usb_ep_autoconfig(gadget,
>> &fs_status_desc);
>> 2073                    if (status_ep) {
>> 2074                            status_ep->driver_data = status_ep;     /*
>> claim */
>> 2075                    } else if (rndis) {
>> 2076                            pr_err("can't run RNDIS on %s",
>> gadget->name);
>> /drivers/usb/gadget/ether.c: 2089 in eth_bind()
>> 2083                    }
>> 2084            }
>> 2085     #endif
>> 2086
>> 2087            /* one config:  cdc, else minimal subset */
>> 2088            if (!cdc) {
>>>>>     CID 501791:    (DEADCODE)
>>>>>     Execution cannot reach this statement: "eth_config.bNumInterfaces =
>> 1;".
>> 2089                    eth_config.bNumInterfaces = 1;
>> 2090                    eth_config.iConfiguration = STRING_SUBSET;
>> 2091
>> 2092                    /*
>> 2093                     * use functions to set these up, in case we're
>> built to work
>> 2094                     * with multiple controllers and must override CDC
>> Ethernet.
>>
>> ** CID 501790:  Null pointer dereferences  (FORWARD_NULL)
>> /cmd/bcb.c: 175 in __bcb_initialize()
>>
>>
>> ________________________________________________________________________________________________________
>> *** CID 501790:  Null pointer dereferences  (FORWARD_NULL)
>> /cmd/bcb.c: 175 in __bcb_initialize()
>> 169                     }
>> 170             }
>> 171
>> 172             return CMD_RET_SUCCESS;
>> 173
>> 174     err_read_fail:
>>>>>     CID 501790:  Null pointer dereferences  (FORWARD_NULL)
>>>>>     Dereferencing null pointer "block".
>> 175             printf("Error: %d %d:%s read failed (%d)\n",
>> block->uclass_id,
>> 176                    block->devnum, partition->name, ret);
>> 177             __bcb_reset();
>> 178             return CMD_RET_FAILURE;
>> 179     }
>> 180
>
> This probably deserves to be addressed. I don't know if Dmitrii is actively
> watching the list so I'll study this in more detail and send a fix if appropriate.

Fix submitted here:

https://lore.kernel.org/all/20240724-bcb-crash-v1-1-44caff15bce4@baylibre.com/

>
>>
>> ** CID 501789:  Insecure data handling  (TAINTED_SCALAR)
>> /lib/tpm_tcg2.c: 41 in tcg2_get_pcr_info()
>>
>>
>> ________________________________________________________________________________________________________
>> *** CID 501789:  Insecure data handling  (TAINTED_SCALAR)
>> /lib/tpm_tcg2.c: 41 in tcg2_get_pcr_info()
>> 35      memset(response, 0, sizeof(response));
>> 36
>> 37      ret = tpm2_get_pcr_info(dev, &pcrs);
>> 38      if (ret)
>> 39              return ret;
>> 40
>>>>>     CID 501789:  Insecure data handling  (TAINTED_SCALAR)
>>>>>     Using tainted variable "pcrs.count" as a loop boundary.
>> 41      for (i = 0; i < pcrs.count; i++) {
>> 42              u32 hash_mask =
>> tcg2_algorithm_to_mask(pcrs.selection[i].hash);
>> 43
>> 44              if (hash_mask) {
>> 45                      *supported_pcr |= hash_mask;
>> 46                      if (tpm2_is_active_pcr(&pcrs.selection[i]))
>>
>> ** CID 501788:  Memory - corruptions  (OVERRUN)
>>
>>
>> ________________________________________________________________________________________________________
>> *** CID 501788:  Memory - corruptions  (OVERRUN)
>> /lib/tpm_tcg2.c: 658 in tcg2_measurement_term()
>> 652                                bool error)
>> 653     {
>> 654             u32 event = error ? 0x1 : 0xffffffff;
>> 655             int i;
>> 656
>> 657             for (i = 0; i < 8; ++i)
>>>>>     CID 501788:  Memory - corruptions  (OVERRUN)
>>>>>     Overrunning buffer pointed to by "(u8 const *)&event" of 4 bytes by
>> passing it to a function which accesses it at byte offset 63.
>> 658                     tcg2_measure_event(dev, elog, i, EV_SEPARATOR,
>> sizeof(event),
>> 659                                        (const u8 *)&event);
>> 660
>> 661             if (elog->log)
>> 662                     unmap_physmem(elog->log, MAP_NOCACHE);
>> 663     }
>>
>>
>>
>> ----- End forwarded message -----
>>
>> -- 
>> Tom
