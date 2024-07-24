Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D832C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 09:21:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01E5188886;
	Wed, 24 Jul 2024 11:21:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Cd9YpX/r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCB0988881; Wed, 24 Jul 2024 11:21:52 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38CF888886
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 11:21:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4266f3e0df8so47218965e9.2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 02:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721812905; x=1722417705;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:to:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cEpIq1dFDodHFZ3CR8nNl9CNDnPWVWqBCR9Y7u8JCs0=;
 b=Cd9YpX/rk3hMySxBE+Sf3ZjSQz/4bVAILr9kDAjqCv2aUZ2PeDKxjmks1suj3YD4Ix
 X3fq1o2OoDs3/rb3OoOKeSG5tXu5Smb8biHbnNXmVDRaNQYSdxh+TH/ZIKC6+LVfffAe
 4MWbW4iUE9qAS8RtKLZ5rkulRwLIYVeNm8BfKFM8ORHateCiKFEUegLk42x9n/qZAvAW
 4UY/0nIVe2jhSRSFhi4DdNRuXQvD0EycDT294QLgZRzDjucihisMa7DK1tEUJRTad9hE
 vaj4odn0ZNWUTtnbT6FNj2WSBXSulbiZEGQb5uvFZ6QSc1ojmbBzoIIsuzKJmqMVacn4
 IPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721812905; x=1722417705;
 h=mime-version:message-id:date:references:in-reply-to:subject:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cEpIq1dFDodHFZ3CR8nNl9CNDnPWVWqBCR9Y7u8JCs0=;
 b=xEtfnPdhOfQeVP53cy5tseR1/urUWN6kNYCgInF51EPCGin3ufD5kWDjypI0c9i5nj
 /qYjypvg41poi5LNlBgUnk7FG1PqmaQKXTVMpHC9mycHdEWaPjwK6Xz6ycvrZQGZ79pC
 2zHzej2secxaPVHSLBVrZEMOqpfnEQ6c71UPAGdtex7iBWvzlmUp/ny0COha6ENYhNYh
 MDGXYx2YePgTniCW80DpAtWfSWhSocLpovn/ML+HWD6wq2juCmOfynq4TD9pWrCDU8M4
 PFG8PNHEyQ8G/MaWK9s+Z94zwgtyl91hk3jQe0sDyTXkp8MnehU6qoB8InsgmQjJgp6/
 8TFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCR/1gAHPzZHdGdaq7HLus9QPdiOqFSKuITOC6atp+q8XuMLCdeDtzBHb7msnXIgMhJDmtSG5lEsubH6Z2ysYWbbL7Bg==
X-Gm-Message-State: AOJu0YyBRqtvE03OIz7xAGGVQr2s/GrPS0m94tS3+AKo5zN0BjifGeS9
 NMzczbW/YW6Fzc3yUOZvZsMHvDQcr4CGNnXaIKfgusFeFj3aFnrJRezIcjsvVpE=
X-Google-Smtp-Source: AGHT+IFZ+C+hPwxoohUWsxga9yTji5aRDyiHs659BgwglEitnu4w8ArrFzD1eD+ESFv1NRfISosFzg==
X-Received: by 2002:a05:600c:45d2:b0:426:6945:75b8 with SMTP id
 5b1f17b1804b1-427f95c1df2mr10642955e9.31.1721812905186; 
 Wed, 24 Jul 2024 02:21:45 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f9397285sm19677825e9.27.2024.07.24.02.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 02:21:44 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Dmitrii Merkurev
 <dimorinny@google.com>
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
In-Reply-To: <20240723141844.GF989285@bill-the-cat>
References: <20240723141844.GF989285@bill-the-cat>
Date: Wed, 24 Jul 2024 11:21:43 +0200
Message-ID: <87ttgf5emw.fsf@baylibre.com>
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

Hi Tom,

Thank you for the report.

On mar., juil. 23, 2024 at 08:18, Tom Rini <trini@konsulko.com> wrote:

> Here's the latest report.
>
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Mon, Jul 22, 2024, 8:07 PM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
>
>
> Hi,
>
> Please find the latest report on new defect(s) introduced to Das U-Boot
> found with Coverity Scan.
>
> 8 new defect(s) introduced to Das U-Boot found with Coverity Scan.
> 3 defect(s), reported by Coverity Scan earlier, were marked fixed in the
> recent build analyzed by Coverity Scan.
>
> New defect(s) Reported-by: Coverity Scan
> Showing 8 of 8 defect(s)
>
>
> ** CID 501795:  Insecure data handling  (TAINTED_SCALAR)
>
>
> ________________________________________________________________________________________________________
> *** CID 501795:  Insecure data handling  (TAINTED_SCALAR)
> /boot/bootmeth_android.c: 96 in scan_boot_part()
> 90      if (!is_android_boot_image_header(buf)) {
> 91              free(buf);
> 92              return log_msg_ret("header", -ENOENT);
> 93      }
> 94
> 95      priv->header_version = ((struct andr_boot_img_hdr_v0
> *)buf)->header_version;
>>>>     CID 501795:  Insecure data handling  (TAINTED_SCALAR)
>>>>     Passing tainted expression "*buf" to "dlfree", which uses it as an
> offset.

scan_boot_part() generates this warning, but scan_vendor_boot_part()
does not.
Both functions follow a similar code flow.

The only reason scan_boot_part() generates this warning, is because of
the downcast into struct andr_boot_img_hdr_v0.

We can't change char* buf into struct andr_boot_img_hdr_v0 because we
need to be block aligned when calling blk_dread().

Per my understanding tainted data means it comes from user input (which
is true for both scan_boot_part() and scan_vendor_boot_part() because
both read from eMMC, which can be consider "user input".

Since I don't see any particular problem with this code I propose that
we ignore this warning.


> 96      free(buf);
> 97
> 98      return 0;
> 99     }
> 100
> 101     static int scan_vendor_boot_part(struct udevice *blk, struct
> android_priv *priv)
>
> ** CID 501794:  Memory - corruptions  (OVERRUN)
>
>
> ________________________________________________________________________________________________________
> *** CID 501794:  Memory - corruptions  (OVERRUN)
> /lib/tpm_tcg2.c: 640 in tcg2_measurement_init()
> 634             rc = tcg2_log_prepare_buffer(*dev, elog,
> ignore_existing_log);
> 635             if (rc) {
> 636                     tcg2_measurement_term(*dev, elog, true);
> 637                     return rc;
> 638             }
> 639
>>>>     CID 501794:  Memory - corruptions  (OVERRUN)
>>>>     Overrunning array "version_string" of 50 bytes by passing it to a
> function which accesses it at byte offset 63.
> 640             rc = tcg2_measure_event(*dev, elog, 0, EV_S_CRTM_VERSION,
> 641                                     strlen(version_string) + 1,
> 642                                     (u8 *)version_string);
> 643             if (rc) {
> 644                     tcg2_measurement_term(*dev, elog, true);
> 645                     return rc;
>
> ** CID 501793:  Insecure data handling  (TAINTED_SCALAR)
> /lib/tpm-v2.c: 909 in tpm2_allow_extend()
>
>
> ________________________________________________________________________________________________________
> *** CID 501793:  Insecure data handling  (TAINTED_SCALAR)
> /lib/tpm-v2.c: 909 in tpm2_allow_extend()
> 903             int rc;
> 904
> 905             rc = tpm2_get_pcr_info(dev, &pcrs);
> 906             if (rc)
> 907                     return false;
> 908
>>>>     CID 501793:  Insecure data handling  (TAINTED_SCALAR)
>>>>     Using tainted variable "pcrs.count" as a loop boundary.
> 909             for (i = 0; i < pcrs.count; i++) {
> 910                     if (tpm2_is_active_pcr(&pcrs.selection[i]) &&
> 911                         !tpm2_algorithm_to_len(pcrs.selection[i].hash))
> 912                             return false;
> 913             }
> 914
> 915             return true;
>
> ** CID 501792:  Control flow issues  (DEADCODE)
> /lib/efi_loader/efi_helper.c: 137 in efi_load_option_dp_join()
>
>
> ________________________________________________________________________________________________________
> *** CID 501792:  Control flow issues  (DEADCODE)
> /lib/efi_loader/efi_helper.c: 137 in efi_load_option_dp_join()
> 131             if (fdt_dp) {
> 132                     struct efi_device_path *tmp_dp = *dp;
> 133
> 134                     *dp = efi_dp_concat(tmp_dp, fdt_dp, *dp_size);
> 135                     efi_free_pool(tmp_dp);
> 136                     if (!dp)
>>>>     CID 501792:  Control flow issues  (DEADCODE)
>>>>     Execution cannot reach this statement: "return
> 9223372036854775817UL;".
> 137                             return EFI_OUT_OF_RESOURCES;
> 138                     *dp_size += efi_dp_size(fdt_dp) + sizeof(END);
> 139             }
> 140
> 141             *dp_size += sizeof(END);
> 142
>
> ** CID 501791:    (DEADCODE)
> /drivers/usb/gadget/ether.c: 2219 in eth_bind()
> /drivers/usb/gadget/ether.c: 2110 in eth_bind()
> /drivers/usb/gadget/ether.c: 2071 in eth_bind()
> /drivers/usb/gadget/ether.c: 2089 in eth_bind()
>
>
> ________________________________________________________________________________________________________
> *** CID 501791:    (DEADCODE)
> /drivers/usb/gadget/ether.c: 2219 in eth_bind()
> 2213                    out_ep->name, in_ep->name,
> 2214                    status_ep ? " STATUS " : "",
> 2215                    status_ep ? status_ep->name : ""
> 2216                    );
> 2217            printf("MAC %pM\n", pdata->enetaddr);
> 2218
>>>>     CID 501791:    (DEADCODE)
>>>>     Execution cannot reach the expression "rndis" inside this
> statement: "if (cdc || rndis)
>   printf(...".
> 2219            if (cdc || rndis)
> 2220                    printf("HOST MAC %02x:%02x:%02x:%02x:%02x:%02x\n",
> 2221                            dev->host_mac[0], dev->host_mac[1],
> 2222                            dev->host_mac[2], dev->host_mac[3],
> 2223                            dev->host_mac[4], dev->host_mac[5]);
> 2224
> /drivers/usb/gadget/ether.c: 2110 in eth_bind()
> 2104                    device_desc.bNumConfigurations = 2;
> 2105
> 2106            if (gadget_is_dualspeed(gadget)) {
> 2107                    if (rndis)
> 2108                            dev_qualifier.bNumConfigurations = 2;
> 2109                    else if (!cdc)
>>>>     CID 501791:    (DEADCODE)
>>>>     Execution cannot reach this statement: "dev_qualifier.bDeviceClass
> ...".
> 2110                            dev_qualifier.bDeviceClass =
> USB_CLASS_VENDOR_SPEC;
> 2111
> 2112                    /* assumes ep0 uses the same value for both speeds
> ... */
> 2113                    dev_qualifier.bMaxPacketSize0 =
> device_desc.bMaxPacketSize0;
> 2114
> 2115                    /* and that all endpoints are dual-speed */
> /drivers/usb/gadget/ether.c: 2071 in eth_bind()
> 2065
> 2066     #if defined(CONFIG_USB_ETH_CDC) || defined(CONFIG_USB_ETH_RNDIS)
> 2067            /*
> 2068             * CDC Ethernet control interface doesn't require a status
> endpoint.
> 2069             * Since some hosts expect one, try to allocate one anyway.
> 2070             */
>>>>     CID 501791:    (DEADCODE)
>>>>     Execution cannot reach the expression "rndis" inside this
> statement: "if (cdc || rndis) {
>   statu...".
> 2071            if (cdc || rndis) {
> 2072                    status_ep = usb_ep_autoconfig(gadget,
> &fs_status_desc);
> 2073                    if (status_ep) {
> 2074                            status_ep->driver_data = status_ep;     /*
> claim */
> 2075                    } else if (rndis) {
> 2076                            pr_err("can't run RNDIS on %s",
> gadget->name);
> /drivers/usb/gadget/ether.c: 2089 in eth_bind()
> 2083                    }
> 2084            }
> 2085     #endif
> 2086
> 2087            /* one config:  cdc, else minimal subset */
> 2088            if (!cdc) {
>>>>     CID 501791:    (DEADCODE)
>>>>     Execution cannot reach this statement: "eth_config.bNumInterfaces =
> 1;".
> 2089                    eth_config.bNumInterfaces = 1;
> 2090                    eth_config.iConfiguration = STRING_SUBSET;
> 2091
> 2092                    /*
> 2093                     * use functions to set these up, in case we're
> built to work
> 2094                     * with multiple controllers and must override CDC
> Ethernet.
>
> ** CID 501790:  Null pointer dereferences  (FORWARD_NULL)
> /cmd/bcb.c: 175 in __bcb_initialize()
>
>
> ________________________________________________________________________________________________________
> *** CID 501790:  Null pointer dereferences  (FORWARD_NULL)
> /cmd/bcb.c: 175 in __bcb_initialize()
> 169                     }
> 170             }
> 171
> 172             return CMD_RET_SUCCESS;
> 173
> 174     err_read_fail:
>>>>     CID 501790:  Null pointer dereferences  (FORWARD_NULL)
>>>>     Dereferencing null pointer "block".
> 175             printf("Error: %d %d:%s read failed (%d)\n",
> block->uclass_id,
> 176                    block->devnum, partition->name, ret);
> 177             __bcb_reset();
> 178             return CMD_RET_FAILURE;
> 179     }
> 180

This probably deserves to be addressed. I don't know if Dmitrii is actively
watching the list so I'll study this in more detail and send a fix if appropriate.

>
> ** CID 501789:  Insecure data handling  (TAINTED_SCALAR)
> /lib/tpm_tcg2.c: 41 in tcg2_get_pcr_info()
>
>
> ________________________________________________________________________________________________________
> *** CID 501789:  Insecure data handling  (TAINTED_SCALAR)
> /lib/tpm_tcg2.c: 41 in tcg2_get_pcr_info()
> 35      memset(response, 0, sizeof(response));
> 36
> 37      ret = tpm2_get_pcr_info(dev, &pcrs);
> 38      if (ret)
> 39              return ret;
> 40
>>>>     CID 501789:  Insecure data handling  (TAINTED_SCALAR)
>>>>     Using tainted variable "pcrs.count" as a loop boundary.
> 41      for (i = 0; i < pcrs.count; i++) {
> 42              u32 hash_mask =
> tcg2_algorithm_to_mask(pcrs.selection[i].hash);
> 43
> 44              if (hash_mask) {
> 45                      *supported_pcr |= hash_mask;
> 46                      if (tpm2_is_active_pcr(&pcrs.selection[i]))
>
> ** CID 501788:  Memory - corruptions  (OVERRUN)
>
>
> ________________________________________________________________________________________________________
> *** CID 501788:  Memory - corruptions  (OVERRUN)
> /lib/tpm_tcg2.c: 658 in tcg2_measurement_term()
> 652                                bool error)
> 653     {
> 654             u32 event = error ? 0x1 : 0xffffffff;
> 655             int i;
> 656
> 657             for (i = 0; i < 8; ++i)
>>>>     CID 501788:  Memory - corruptions  (OVERRUN)
>>>>     Overrunning buffer pointed to by "(u8 const *)&event" of 4 bytes by
> passing it to a function which accesses it at byte offset 63.
> 658                     tcg2_measure_event(dev, elog, i, EV_SEPARATOR,
> sizeof(event),
> 659                                        (const u8 *)&event);
> 660
> 661             if (elog->log)
> 662                     unmap_physmem(elog->log, MAP_NOCACHE);
> 663     }
>
>
>
> ----- End forwarded message -----
>
> -- 
> Tom
