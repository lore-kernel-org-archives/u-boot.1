Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717BDC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 14:18:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E850E8881B;
	Tue, 23 Jul 2024 16:18:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BFy59miA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69A4E88850; Tue, 23 Jul 2024 16:18:52 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C5C18811C
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 16:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7044bda722fso3210925a34.2
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 07:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721744327; x=1722349127; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sBzdTJzK19WHwNIH0fRjm46Q5Ks4Eq1oWTBmXhK0010=;
 b=BFy59miAG8gevX1WPXkNy9dDmqtWjVtd58CojPmAJYCV9A1NRkVlkRXngV+nisPfuE
 a2obLYDxjkedCu6f+9+uNpoiGfmz2s/UDfDElVrPvs6XybVOYvL5esKturaTRoSMV1lo
 JLj4J3x+Iz8zGTGmHM6QkBQn7eQK30YKHZYsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721744327; x=1722349127;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sBzdTJzK19WHwNIH0fRjm46Q5Ks4Eq1oWTBmXhK0010=;
 b=nHxI6miOOvpnWSRLW5CD20W4FntkREs7XwJ4M/JE+//XMp4DTqtbYyGorfp/wsxPNu
 ELIzp0sghiltV1sKzxJ2cjz8InMICYEzKmb4ObSbtaNORoxCpdOPRf4ySIfDnuYT8khh
 yfwEk5w/ZY5iYMDGtPGUovCqBfOLlpw10raU4FWDRUcnSIOQHKDWwryfDgf6FmTWm3Ke
 HhL8StxEf5AJskAgwIgdT9pSTs4mbOdqZlq/d2uGy3WzcLJlng6erTYXBQ4IZlGuyAoX
 xjk21iSPlsb9S78lyZMVfMD8j9homgdnPAs8zIxnNVJFNI9Sw+g8GEeg0mm6ygl7PpR6
 Xn4g==
X-Gm-Message-State: AOJu0YxoDd2Aug5V0bAcICLezeYjQ7psxGo6XlLpSwmUxgg+Y90QIcxR
 PzKY5TfoGBrZIEapbgjCLpVQfvKHxWL0xTKlGVIaUQYtitqi+w3bEEuMdzqBZ0t+Jm72mA1yFUE
 74fk=
X-Google-Smtp-Source: AGHT+IFFN62Uo8hEThBQsAngWjGYUSqkK4n07s5SPAgqjCcKSST4mPqJsxQDobKXYQ2XAbn2Jat4Ng==
X-Received: by 2002:a05:6830:7306:b0:703:6ab8:1fe3 with SMTP id
 46e09a7af769-709008d0990mr12196459a34.15.1721744327059; 
 Tue, 23 Jul 2024 07:18:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f6189c61sm2005346a34.67.2024.07.23.07.18.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 07:18:46 -0700 (PDT)
Date: Tue, 23 Jul 2024 08:18:44 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dmitrii Merkurev <dimorinny@google.com>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20240723141844.GF989285@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c0dnA0Zui/vYa8Pf"
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
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


--c0dnA0Zui/vYa8Pf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's the latest report.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Mon, Jul 22, 2024, 8:07 PM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to Das U-Boot
found with Coverity Scan.

8 new defect(s) introduced to Das U-Boot found with Coverity Scan.
3 defect(s), reported by Coverity Scan earlier, were marked fixed in the
recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 8 of 8 defect(s)


** CID 501795:  Insecure data handling  (TAINTED_SCALAR)


___________________________________________________________________________=
_____________________________
*** CID 501795:  Insecure data handling  (TAINTED_SCALAR)
/boot/bootmeth_android.c: 96 in scan_boot_part()
90      if (!is_android_boot_image_header(buf)) {
91              free(buf);
92              return log_msg_ret("header", -ENOENT);
93      }
94
95      priv->header_version =3D ((struct andr_boot_img_hdr_v0
*)buf)->header_version;
>>>     CID 501795:  Insecure data handling  (TAINTED_SCALAR)
>>>     Passing tainted expression "*buf" to "dlfree", which uses it as an
offset.
96      free(buf);
97
98      return 0;
99     }
100
101     static int scan_vendor_boot_part(struct udevice *blk, struct
android_priv *priv)

** CID 501794:  Memory - corruptions  (OVERRUN)


___________________________________________________________________________=
_____________________________
*** CID 501794:  Memory - corruptions  (OVERRUN)
/lib/tpm_tcg2.c: 640 in tcg2_measurement_init()
634             rc =3D tcg2_log_prepare_buffer(*dev, elog,
ignore_existing_log);
635             if (rc) {
636                     tcg2_measurement_term(*dev, elog, true);
637                     return rc;
638             }
639
>>>     CID 501794:  Memory - corruptions  (OVERRUN)
>>>     Overrunning array "version_string" of 50 bytes by passing it to a
function which accesses it at byte offset 63.
640             rc =3D tcg2_measure_event(*dev, elog, 0, EV_S_CRTM_VERSION,
641                                     strlen(version_string) + 1,
642                                     (u8 *)version_string);
643             if (rc) {
644                     tcg2_measurement_term(*dev, elog, true);
645                     return rc;

** CID 501793:  Insecure data handling  (TAINTED_SCALAR)
/lib/tpm-v2.c: 909 in tpm2_allow_extend()


___________________________________________________________________________=
_____________________________
*** CID 501793:  Insecure data handling  (TAINTED_SCALAR)
/lib/tpm-v2.c: 909 in tpm2_allow_extend()
903             int rc;
904
905             rc =3D tpm2_get_pcr_info(dev, &pcrs);
906             if (rc)
907                     return false;
908
>>>     CID 501793:  Insecure data handling  (TAINTED_SCALAR)
>>>     Using tainted variable "pcrs.count" as a loop boundary.
909             for (i =3D 0; i < pcrs.count; i++) {
910                     if (tpm2_is_active_pcr(&pcrs.selection[i]) &&
911                         !tpm2_algorithm_to_len(pcrs.selection[i].hash))
912                             return false;
913             }
914
915             return true;

** CID 501792:  Control flow issues  (DEADCODE)
/lib/efi_loader/efi_helper.c: 137 in efi_load_option_dp_join()


___________________________________________________________________________=
_____________________________
*** CID 501792:  Control flow issues  (DEADCODE)
/lib/efi_loader/efi_helper.c: 137 in efi_load_option_dp_join()
131             if (fdt_dp) {
132                     struct efi_device_path *tmp_dp =3D *dp;
133
134                     *dp =3D efi_dp_concat(tmp_dp, fdt_dp, *dp_size);
135                     efi_free_pool(tmp_dp);
136                     if (!dp)
>>>     CID 501792:  Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "return
9223372036854775817UL;".
137                             return EFI_OUT_OF_RESOURCES;
138                     *dp_size +=3D efi_dp_size(fdt_dp) + sizeof(END);
139             }
140
141             *dp_size +=3D sizeof(END);
142

** CID 501791:    (DEADCODE)
/drivers/usb/gadget/ether.c: 2219 in eth_bind()
/drivers/usb/gadget/ether.c: 2110 in eth_bind()
/drivers/usb/gadget/ether.c: 2071 in eth_bind()
/drivers/usb/gadget/ether.c: 2089 in eth_bind()


___________________________________________________________________________=
_____________________________
*** CID 501791:    (DEADCODE)
/drivers/usb/gadget/ether.c: 2219 in eth_bind()
2213                    out_ep->name, in_ep->name,
2214                    status_ep ? " STATUS " : "",
2215                    status_ep ? status_ep->name : ""
2216                    );
2217            printf("MAC %pM\n", pdata->enetaddr);
2218
>>>     CID 501791:    (DEADCODE)
>>>     Execution cannot reach the expression "rndis" inside this
statement: "if (cdc || rndis)
  printf(...".
2219            if (cdc || rndis)
2220                    printf("HOST MAC %02x:%02x:%02x:%02x:%02x:%02x\n",
2221                            dev->host_mac[0], dev->host_mac[1],
2222                            dev->host_mac[2], dev->host_mac[3],
2223                            dev->host_mac[4], dev->host_mac[5]);
2224
/drivers/usb/gadget/ether.c: 2110 in eth_bind()
2104                    device_desc.bNumConfigurations =3D 2;
2105
2106            if (gadget_is_dualspeed(gadget)) {
2107                    if (rndis)
2108                            dev_qualifier.bNumConfigurations =3D 2;
2109                    else if (!cdc)
>>>     CID 501791:    (DEADCODE)
>>>     Execution cannot reach this statement: "dev_qualifier.bDeviceClass
=2E..".
2110                            dev_qualifier.bDeviceClass =3D
USB_CLASS_VENDOR_SPEC;
2111
2112                    /* assumes ep0 uses the same value for both speeds
=2E.. */
2113                    dev_qualifier.bMaxPacketSize0 =3D
device_desc.bMaxPacketSize0;
2114
2115                    /* and that all endpoints are dual-speed */
/drivers/usb/gadget/ether.c: 2071 in eth_bind()
2065
2066     #if defined(CONFIG_USB_ETH_CDC) || defined(CONFIG_USB_ETH_RNDIS)
2067            /*
2068             * CDC Ethernet control interface doesn't require a status
endpoint.
2069             * Since some hosts expect one, try to allocate one anyway.
2070             */
>>>     CID 501791:    (DEADCODE)
>>>     Execution cannot reach the expression "rndis" inside this
statement: "if (cdc || rndis) {
  statu...".
2071            if (cdc || rndis) {
2072                    status_ep =3D usb_ep_autoconfig(gadget,
&fs_status_desc);
2073                    if (status_ep) {
2074                            status_ep->driver_data =3D status_ep;     /*
claim */
2075                    } else if (rndis) {
2076                            pr_err("can't run RNDIS on %s",
gadget->name);
/drivers/usb/gadget/ether.c: 2089 in eth_bind()
2083                    }
2084            }
2085     #endif
2086
2087            /* one config:  cdc, else minimal subset */
2088            if (!cdc) {
>>>     CID 501791:    (DEADCODE)
>>>     Execution cannot reach this statement: "eth_config.bNumInterfaces =
=3D
1;".
2089                    eth_config.bNumInterfaces =3D 1;
2090                    eth_config.iConfiguration =3D STRING_SUBSET;
2091
2092                    /*
2093                     * use functions to set these up, in case we're
built to work
2094                     * with multiple controllers and must override CDC
Ethernet.

** CID 501790:  Null pointer dereferences  (FORWARD_NULL)
/cmd/bcb.c: 175 in __bcb_initialize()


___________________________________________________________________________=
_____________________________
*** CID 501790:  Null pointer dereferences  (FORWARD_NULL)
/cmd/bcb.c: 175 in __bcb_initialize()
169                     }
170             }
171
172             return CMD_RET_SUCCESS;
173
174     err_read_fail:
>>>     CID 501790:  Null pointer dereferences  (FORWARD_NULL)
>>>     Dereferencing null pointer "block".
175             printf("Error: %d %d:%s read failed (%d)\n",
block->uclass_id,
176                    block->devnum, partition->name, ret);
177             __bcb_reset();
178             return CMD_RET_FAILURE;
179     }
180

** CID 501789:  Insecure data handling  (TAINTED_SCALAR)
/lib/tpm_tcg2.c: 41 in tcg2_get_pcr_info()


___________________________________________________________________________=
_____________________________
*** CID 501789:  Insecure data handling  (TAINTED_SCALAR)
/lib/tpm_tcg2.c: 41 in tcg2_get_pcr_info()
35      memset(response, 0, sizeof(response));
36
37      ret =3D tpm2_get_pcr_info(dev, &pcrs);
38      if (ret)
39              return ret;
40
>>>     CID 501789:  Insecure data handling  (TAINTED_SCALAR)
>>>     Using tainted variable "pcrs.count" as a loop boundary.
41      for (i =3D 0; i < pcrs.count; i++) {
42              u32 hash_mask =3D
tcg2_algorithm_to_mask(pcrs.selection[i].hash);
43
44              if (hash_mask) {
45                      *supported_pcr |=3D hash_mask;
46                      if (tpm2_is_active_pcr(&pcrs.selection[i]))

** CID 501788:  Memory - corruptions  (OVERRUN)


___________________________________________________________________________=
_____________________________
*** CID 501788:  Memory - corruptions  (OVERRUN)
/lib/tpm_tcg2.c: 658 in tcg2_measurement_term()
652                                bool error)
653     {
654             u32 event =3D error ? 0x1 : 0xffffffff;
655             int i;
656
657             for (i =3D 0; i < 8; ++i)
>>>     CID 501788:  Memory - corruptions  (OVERRUN)
>>>     Overrunning buffer pointed to by "(u8 const *)&event" of 4 bytes by
passing it to a function which accesses it at byte offset 63.
658                     tcg2_measure_event(dev, elog, i, EV_SEPARATOR,
sizeof(event),
659                                        (const u8 *)&event);
660
661             if (elog->log)
662                     unmap_physmem(elog->log, MAP_NOCACHE);
663     }



----- End forwarded message -----

--=20
Tom

--c0dnA0Zui/vYa8Pf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmafu7wACgkQFHw5/5Y0
tyzfdAwAoBZBZRpadybkUkT0LOIQXaacywXI0Ma5isE8OPU5T0qgT55Ppc5N3FMG
EsojOplcvnyrePROCVFl1g8gHhOTem8NOjdo0c37+xv/QA4FwEe3M7BOkKpiKOYK
18D1FWd23tnspoPuQDrWrsKD1vbDX3O+dMMzCdYpMS25Fj9POyoOE5ewEfe7so3T
I01ES0r0dneGYxFDnkGVf6YlG/PJbldaCAt4KQpa7X8qgAU086yskS6ifk9gM2/j
3BlAEzQ5ZA0utfVOlTaVIRlToGgRJxna0dTP1u8uZ7+Nvwm50A9ikILa/iRIqLp7
/CVGn4MVi6JjWj1d0gLCUOiFN2fqisyh+8xdxoAdouZsV8mMapL3/kBVdKPuu+Tm
+T0N9A2V3wWFIZcehwKrz/OcskCWKUgmmOWLGKJKmQ4gjRlyoTG1A5eAq2NlHt3N
jW8FP9e/tPCXL+/guPsa9uiuz93FuuNczXRg8MRdomYfk+Fn3KNgJ5RJvR4T9bLt
Sh5FnBs3
=mz7t
-----END PGP SIGNATURE-----

--c0dnA0Zui/vYa8Pf--
