Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4884FC3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 09:45:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD8768883E;
	Wed, 24 Jul 2024 11:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="kpejvegS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D115588800; Wed, 24 Jul 2024 11:45:44 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8543E888A5
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 11:45:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1721814336; x=1722419136; i=xypron.glpk@gmx.de;
 bh=Hl3gTZO8Dh0mNyYU+pUigZ6Q06RUegWRkL02Z+cgxfQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=kpejvegS8dr6y3/fe1gusYsSvJoYobW1XjyDWkpiQRW4bLEJgFphnH5ZnRIVqO2W
 hd9U1J1N+dirJVWSx+57sxoVw8xdwER8zOF3QudLZCpp98AK/YQwdWWOVkiFLNwvP
 iiKLh90BJfPGmEj9QXyda2Q0gPq9UtfqJVhkmQ20QVsM8jYh0abkSoPIv+QQcjBK9
 TiAfdBpCq2nJ3WiU3bM0BE6llCTS7VfYyLHGURl/Dr7LVfolHP2VmW4xnd3GIMYfu
 wK/6PCe4R9CzZnUEk/VfPPiSloHEYLwxUIRxCo/aZZ7hwp15xhVh/pUtGEtzc9t9f
 d05+AV1cn9nhHdkvGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.93.80]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7zBb-1sBEIt1jPv-00vKLh; Wed, 24
 Jul 2024 11:45:36 +0200
Message-ID: <5329b5b4-b54d-4c4d-aedc-c21c3da5f9ee@gmx.de>
Date: Wed, 24 Jul 2024 11:45:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
References: <20240723141844.GF989285@bill-the-cat>
 <87ttgf5emw.fsf@baylibre.com>
Content-Language: en-US
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dmitrii Merkurev <dimorinny@google.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <87ttgf5emw.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WrlVNRGPNUi91HVXFm4yxBj1kO2twRQY/0qqVs/QoyNFS3KPpIR
 PiACRF3s15m9+IFlopArZ5c/vhUC6x3qbCsKBM27HlPnWzJpXuwIFjqorM9f48dVEicgoQ/
 ocAnsNltwS5reJ0kYFlEk+mu18Q3UGzDpMqgG4OVyF5HQRISS6px/g6OoczD1lOOi672CpJ
 rP2h1O2vhbVTF7bcCZxFw==
UI-OutboundReport: notjunk:1;M01:P0:czQXmadlhRA=;0NtziB24WxGw0+lgeWkaMn60yDk
 yFmOsmjiXTa16srNZIvduxTwd3+mzzt2CTnG3E8Xq++9EWSVOOl+ze2Wv8c6jrwmWDVDi+R2S
 9PTz8HzZ/HcNXfNy2V1PqYOBjy5BWqiENLMYCH/FtcD7tHN6uwmOEXK+31xF2YSaqrUjyldsk
 BqJDYzpK9nfb3izkbwcLUWkGjI9iVrm2kSvYj1k2GpJ2HD4YUloZ5aCDYOvQNnKpbcHb6akH9
 DLzTMrHLQZG7V5wz5pQMgxqSQMoUlLXWBjC/o+BqP0/64tGQLLhfarE7XbxcMediM67Juee5x
 WFJ7Stuovdefdff4p60x70qcW67hoI0RyijdeO+tBrkqqa2ridCEmV+8+9Y1mrhnwlsbYHmZ8
 DyDqHgBdwhN2txo+46Fm956u3T+IVxYcDARh9IUcN6iKx/ylJ39bWHUsK+3IFDPyBjXRRVsOD
 CKk3ny2SypxUz+k+4RCAyyo1pbRnfo+yorC045QoutwJcQBlJW0n9SMRFR2DxqETEyE/vco3j
 FMLESFU/HojBrqxZVasBgSWfWplEHdTRNqSeh2EWXIb3aSj6pjZxhEpDElC8VNbdi8cDsebEG
 0WpyXQJ7UvHPgB4Jva0zojpGDarEIi4xl6Vh5ccnSQ+gsJrNqrPFSFUFDaTKqyHbOTcRwR684
 GGB64DNubHXppnHHRVmFfzX7CCLI6JWhp3GVKFeyUi+uLxMjJjoCrK0rvaofQk6XgMYtRQhPl
 aDm+MfAAJN0jNNtGbZX12AO01YXs9/96o8Lncqtd2Tx0uf+baouadKt4whf0meWKSLuJKgc1R
 AT8Mu/Vb92ReZSX+JpVKV9Nw==
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

On 24.07.24 11:21, Mattijs Korpershoek wrote:
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
>> 3 defect(s), reported by Coverity Scan earlier, were marked fixed in th=
e
>> recent build analyzed by Coverity Scan.
>>
>> New defect(s) Reported-by: Coverity Scan
>> Showing 8 of 8 defect(s)
>>
>>
>> ** CID 501795:  Insecure data handling  (TAINTED_SCALAR)
>>
>>
>> _______________________________________________________________________=
_________________________________
>> *** CID 501795:  Insecure data handling  (TAINTED_SCALAR)
>> /boot/bootmeth_android.c: 96 in scan_boot_part()
>> 90      if (!is_android_boot_image_header(buf)) {
>> 91              free(buf);
>> 92              return log_msg_ret("header", -ENOENT);
>> 93      }
>> 94
>> 95      priv->header_version =3D ((struct andr_boot_img_hdr_v0
>> *)buf)->header_version;
>>>>>      CID 501795:  Insecure data handling  (TAINTED_SCALAR)
>>>>>      Passing tainted expression "*buf" to "dlfree", which uses it as=
 an
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

The warning is specifically about invoking free for the buffer that we
have allocated via malloc(). Our implementation of malloc() and free()
stores some meta-information about allocated buffers at a negative
offset and we don't overwrite this area via blk_read().

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
>> _______________________________________________________________________=
_________________________________
>> *** CID 501794:  Memory - corruptions  (OVERRUN)
>> /lib/tpm_tcg2.c: 640 in tcg2_measurement_init()
>> 634             rc =3D tcg2_log_prepare_buffer(*dev, elog,
>> ignore_existing_log);
>> 635             if (rc) {
>> 636                     tcg2_measurement_term(*dev, elog, true);
>> 637                     return rc;
>> 638             }
>> 639
>>>>>      CID 501794:  Memory - corruptions  (OVERRUN)
>>>>>      Overrunning array "version_string" of 50 bytes by passing it to=
 a
>> function which accesses it at byte offset 63.
>> 640             rc =3D tcg2_measure_event(*dev, elog, 0, EV_S_CRTM_VERS=
ION,
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
>> _______________________________________________________________________=
_________________________________
>> *** CID 501793:  Insecure data handling  (TAINTED_SCALAR)
>> /lib/tpm-v2.c: 909 in tpm2_allow_extend()
>> 903             int rc;
>> 904
>> 905             rc =3D tpm2_get_pcr_info(dev, &pcrs);
>> 906             if (rc)
>> 907                     return false;
>> 908
>>>>>      CID 501793:  Insecure data handling  (TAINTED_SCALAR)
>>>>>      Using tainted variable "pcrs.count" as a loop boundary.
>> 909             for (i =3D 0; i < pcrs.count; i++) {
>> 910                     if (tpm2_is_active_pcr(&pcrs.selection[i]) &&
>> 911                         !tpm2_algorithm_to_len(pcrs.selection[i].ha=
sh))
>> 912                             return false;
>> 913             }
>> 914
>> 915             return true;
>>
>> ** CID 501792:  Control flow issues  (DEADCODE)
>> /lib/efi_loader/efi_helper.c: 137 in efi_load_option_dp_join()
>>
>>
>> _______________________________________________________________________=
_________________________________
>> *** CID 501792:  Control flow issues  (DEADCODE)
>> /lib/efi_loader/efi_helper.c: 137 in efi_load_option_dp_join()
>> 131             if (fdt_dp) {
>> 132                     struct efi_device_path *tmp_dp =3D *dp;
>> 133
>> 134                     *dp =3D efi_dp_concat(tmp_dp, fdt_dp, *dp_size)=
;
>> 135                     efi_free_pool(tmp_dp);
>> 136                     if (!dp)
>>>>>      CID 501792:  Control flow issues  (DEADCODE)
>>>>>      Execution cannot reach this statement: "return
>> 9223372036854775817UL;".
>> 137                             return EFI_OUT_OF_RESOURCES;
>> 138                     *dp_size +=3D efi_dp_size(fdt_dp) + sizeof(END)=
;
>> 139             }
>> 140
>> 141             *dp_size +=3D sizeof(END);
>> 142
>>
>> ** CID 501791:    (DEADCODE)
>> /drivers/usb/gadget/ether.c: 2219 in eth_bind()
>> /drivers/usb/gadget/ether.c: 2110 in eth_bind()
>> /drivers/usb/gadget/ether.c: 2071 in eth_bind()
>> /drivers/usb/gadget/ether.c: 2089 in eth_bind()
>>
>>
>> _______________________________________________________________________=
_________________________________
>> *** CID 501791:    (DEADCODE)
>> /drivers/usb/gadget/ether.c: 2219 in eth_bind()
>> 2213                    out_ep->name, in_ep->name,
>> 2214                    status_ep ? " STATUS " : "",
>> 2215                    status_ep ? status_ep->name : ""
>> 2216                    );
>> 2217            printf("MAC %pM\n", pdata->enetaddr);
>> 2218
>>>>>      CID 501791:    (DEADCODE)
>>>>>      Execution cannot reach the expression "rndis" inside this
>> statement: "if (cdc || rndis)
>>    printf(...".
>> 2219            if (cdc || rndis)
>> 2220                    printf("HOST MAC %02x:%02x:%02x:%02x:%02x:%02x\=
n",
>> 2221                            dev->host_mac[0], dev->host_mac[1],
>> 2222                            dev->host_mac[2], dev->host_mac[3],
>> 2223                            dev->host_mac[4], dev->host_mac[5]);
>> 2224
>> /drivers/usb/gadget/ether.c: 2110 in eth_bind()
>> 2104                    device_desc.bNumConfigurations =3D 2;
>> 2105
>> 2106            if (gadget_is_dualspeed(gadget)) {
>> 2107                    if (rndis)
>> 2108                            dev_qualifier.bNumConfigurations =3D 2;
>> 2109                    else if (!cdc)
>>>>>      CID 501791:    (DEADCODE)
>>>>>      Execution cannot reach this statement: "dev_qualifier.bDeviceCl=
ass
>> ...".
>> 2110                            dev_qualifier.bDeviceClass =3D
>> USB_CLASS_VENDOR_SPEC;
>> 2111
>> 2112                    /* assumes ep0 uses the same value for both spe=
eds
>> ... */
>> 2113                    dev_qualifier.bMaxPacketSize0 =3D
>> device_desc.bMaxPacketSize0;
>> 2114
>> 2115                    /* and that all endpoints are dual-speed */
>> /drivers/usb/gadget/ether.c: 2071 in eth_bind()
>> 2065
>> 2066     #if defined(CONFIG_USB_ETH_CDC) || defined(CONFIG_USB_ETH_RNDI=
S)
>> 2067            /*
>> 2068             * CDC Ethernet control interface doesn't require a sta=
tus
>> endpoint.
>> 2069             * Since some hosts expect one, try to allocate one any=
way.
>> 2070             */
>>>>>      CID 501791:    (DEADCODE)
>>>>>      Execution cannot reach the expression "rndis" inside this
>> statement: "if (cdc || rndis) {
>>    statu...".
>> 2071            if (cdc || rndis) {
>> 2072                    status_ep =3D usb_ep_autoconfig(gadget,
>> &fs_status_desc);
>> 2073                    if (status_ep) {
>> 2074                            status_ep->driver_data =3D status_ep;  =
   /*
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
>>>>>      CID 501791:    (DEADCODE)
>>>>>      Execution cannot reach this statement: "eth_config.bNumInterfac=
es =3D
>> 1;".
>> 2089                    eth_config.bNumInterfaces =3D 1;
>> 2090                    eth_config.iConfiguration =3D STRING_SUBSET;
>> 2091
>> 2092                    /*
>> 2093                     * use functions to set these up, in case we're
>> built to work
>> 2094                     * with multiple controllers and must override =
CDC
>> Ethernet.
>>
>> ** CID 501790:  Null pointer dereferences  (FORWARD_NULL)
>> /cmd/bcb.c: 175 in __bcb_initialize()
>>
>>
>> _______________________________________________________________________=
_________________________________
>> *** CID 501790:  Null pointer dereferences  (FORWARD_NULL)
>> /cmd/bcb.c: 175 in __bcb_initialize()
>> 169                     }
>> 170             }
>> 171
>> 172             return CMD_RET_SUCCESS;
>> 173
>> 174     err_read_fail:
>>>>>      CID 501790:  Null pointer dereferences  (FORWARD_NULL)
>>>>>      Dereferencing null pointer "block".
>> 175             printf("Error: %d %d:%s read failed (%d)\n",
>> block->uclass_id,
>> 176                    block->devnum, partition->name, ret);
>> 177             __bcb_reset();
>> 178             return CMD_RET_FAILURE;
>> 179     }
>> 180
>
> This probably deserves to be addressed. I don't know if Dmitrii is activ=
ely
> watching the list so I'll study this in more detail and send a fix if ap=
propriate.

If blk_get_dev() returns NULL, we should write a message like "No such
device" and return CMD_RET_FAILURE immediately.

Please, use log_err() for writing error messages. We don't need "Error:"
at the beginning of error messages.

Best regards

Heinrich

>
>>
>> ** CID 501789:  Insecure data handling  (TAINTED_SCALAR)
>> /lib/tpm_tcg2.c: 41 in tcg2_get_pcr_info()
>>
>>
>> _______________________________________________________________________=
_________________________________
>> *** CID 501789:  Insecure data handling  (TAINTED_SCALAR)
>> /lib/tpm_tcg2.c: 41 in tcg2_get_pcr_info()
>> 35      memset(response, 0, sizeof(response));
>> 36
>> 37      ret =3D tpm2_get_pcr_info(dev, &pcrs);
>> 38      if (ret)
>> 39              return ret;
>> 40
>>>>>      CID 501789:  Insecure data handling  (TAINTED_SCALAR)
>>>>>      Using tainted variable "pcrs.count" as a loop boundary.
>> 41      for (i =3D 0; i < pcrs.count; i++) {
>> 42              u32 hash_mask =3D
>> tcg2_algorithm_to_mask(pcrs.selection[i].hash);
>> 43
>> 44              if (hash_mask) {
>> 45                      *supported_pcr |=3D hash_mask;
>> 46                      if (tpm2_is_active_pcr(&pcrs.selection[i]))
>>
>> ** CID 501788:  Memory - corruptions  (OVERRUN)
>>
>>
>> _______________________________________________________________________=
_________________________________
>> *** CID 501788:  Memory - corruptions  (OVERRUN)
>> /lib/tpm_tcg2.c: 658 in tcg2_measurement_term()
>> 652                                bool error)
>> 653     {
>> 654             u32 event =3D error ? 0x1 : 0xffffffff;
>> 655             int i;
>> 656
>> 657             for (i =3D 0; i < 8; ++i)
>>>>>      CID 501788:  Memory - corruptions  (OVERRUN)
>>>>>      Overrunning buffer pointed to by "(u8 const *)&event" of 4 byte=
s by
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

