Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A18C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 10:07:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 108D788881;
	Wed, 24 Jul 2024 12:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="jMMHYtR2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A238A88886; Wed, 24 Jul 2024 12:06:58 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 287478883E
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 12:06:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1721815610; x=1722420410; i=xypron.glpk@gmx.de;
 bh=cznXpbkHkSfY1C59pH9JzzeyQnm/9b79+N0rs8FPpsM=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=jMMHYtR25AEs8sSXDdMluVbl6QNLIH+45gnUWZCFkjOL+YWVt/ymSAc/Np60cUaB
 wien4JPAHfn9kXXPb/1TEgZdJJEVL9wXEOOkClfc7J2XnCfsYPBjdcCC8KEUimBAC
 8TzS5ickLeA93H0uXjMenT0lvOK3MdbFSaqII0SQ8jR1UKweZ8vs5cCWpHc0ws+lV
 zYhjX20AnMNNi1P8wsotgG4bwWKK/soiLfdtbbpu8nmEQBNgppNcor4RIy/2RmQoO
 Qi0q1efo9ENdB0iSOAfwBQKDYOu8DHXVd1DQn6rUuL4ZxC/LkoM2HKkHP6BoXmwxm
 9nkc/w/FZYnXeVovEw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([109.42.177.119]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVvPJ-1sghum3a7x-00O8MR; Wed, 24
 Jul 2024 12:06:50 +0200
Date: Wed, 24 Jul 2024 12:06:46 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
CC: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dmitrii Merkurev <dimorinny@google.com>
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
User-Agent: K-9 Mail for Android
In-Reply-To: <87o76n5d1a.fsf@baylibre.com>
References: <20240723141844.GF989285@bill-the-cat>
 <87ttgf5emw.fsf@baylibre.com> <5329b5b4-b54d-4c4d-aedc-c21c3da5f9ee@gmx.de>
 <87o76n5d1a.fsf@baylibre.com>
Message-ID: <A6FA1C43-24E9-4738-9AE0-E0E67E71CA65@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GRdbxYl4WZzdNlxPapmrYWq69E/c+6T38wVXKTIgcl0mD4XwKnv
 JuL7CgOof545MkUFBn6ud//t+LsxofT4/xLo8govzX0hffpmlhxa0bp7bycnwcGxMzn74qz
 AIwTeClvMJrZeUww9/JnV30A0SkNFW4l9XPubG4tS6cXjBGMHI3yL0SOsLwRDXEz3iwr5g/
 Jay23wZusZtQtjC9OoOMw==
UI-OutboundReport: notjunk:1;M01:P0:P2NJCUhpSpA=;aca5M227IYVP6qLcGbjGOrLTqi9
 ojM5bbswDmDozoezg9dSWHewdeVEyHdA5JHCiza2QLh2nXpzKzd6qIgUN/W7q9K50bI9+o7rn
 4OquVvNj/7p46ZCBkM0peN8shQaY2AfWxS0wOswMBQnrQ2baWIAoo0b4F4kr3XVeuQukfeevg
 VOlvOkX1oACV9Ajwba36ADWvMg8PXon5TopQ7ksbzH1+hACPdO3hg1bM60iTxpMbbMsmb4VGO
 j5iACur9acEk6doPr4eH9oE1XDtociGPBesoNRNKm1cg0v/NOA3LA9KdXOIDpwlz/5Ok4Wz2V
 Mu/ymlRHgwuG7k3wu61U6pn1noIG8EZS/1IkPaR+b6DkLCUFcDeKT2P7uybKeFmACkUUk/XDx
 tREyatSJ0qBuoS//csETvFFM2Bg5JbrDglda7S74boxcP2EZ6dsE/rNtrzQ1Mu5/NV+WVxYzy
 F/9OsOnKDVNj4jnpMMvfduIDz/2dwFDRjsVpsbZX2F6V3qtSKJ0H7jdMSUNA6q9Wln8HE348h
 Vpz6hfqY3KP92jVuCH+IfhNsk8W2GMort1w3oWxLYINIKKmfOgzP94RP27WknhjrZCDdE3ikJ
 Co9IZU+iitd8IgvvvMeVRgM0kntqGC6BvkvVcpAF94JUphcgHRqPgEl8jY4jpzbJR87nRdD+5
 yg8MqGdOvv3xpicKaPP3xxWfCihhXuwevvVma/QE23FHQYE+0WuB3HUB8G3eA3BU5FKqx14Al
 VOEp8vkUShXzUhOrengPktVRg5YfEg6F+b8FzpAJkzlGcnNYVESt3Y7kxYZcQzy8iF9acGBKS
 rQejasAeSxaYJbkOVRP6wyE7ZriX2eD8kjNvsuAnUB2ck=
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



Am 24=2E Juli 2024 11:56:17 MESZ schrieb Mattijs Korpershoek <mkorpershoek=
@baylibre=2Ecom>:
>Hi Heinrich,
>
>On mer=2E, juil=2E 24, 2024 at 11:45, Heinrich Schuchardt <xypron=2Eglpk@=
gmx=2Ede> wrote:
>
>> On 24=2E07=2E24 11:21, Mattijs Korpershoek wrote:
>>> Hi Tom,
>>>
>>> Thank you for the report=2E
>>>
>>> On mar=2E, juil=2E 23, 2024 at 08:18, Tom Rini <trini@konsulko=2Ecom> =
wrote:
>>>
>>>> Here's the latest report=2E
>>>>
>>>> ---------- Forwarded message ---------
>>>> From: <scan-admin@coverity=2Ecom>
>>>> Date: Mon, Jul 22, 2024, 8:07 PM
>>>> Subject: New Defects reported by Coverity Scan for Das U-Boot
>>>> To: <tom=2Erini@gmail=2Ecom>
>>>>
>>>>
>>>> Hi,
>>>>
>>>> Please find the latest report on new defect(s) introduced to Das U-Bo=
ot
>>>> found with Coverity Scan=2E
>>>>
>>>> 8 new defect(s) introduced to Das U-Boot found with Coverity Scan=2E
>>>> 3 defect(s), reported by Coverity Scan earlier, were marked fixed in =
the
>>>> recent build analyzed by Coverity Scan=2E
>>>>
>>>> New defect(s) Reported-by: Coverity Scan
>>>> Showing 8 of 8 defect(s)
>>>>
>>>>
>>>> ** CID 501795:  Insecure data handling  (TAINTED_SCALAR)
>>>>
>>>>
>>>> _____________________________________________________________________=
___________________________________
>>>> *** CID 501795:  Insecure data handling  (TAINTED_SCALAR)
>>>> /boot/bootmeth_android=2Ec: 96 in scan_boot_part()
>>>> 90      if (!is_android_boot_image_header(buf)) {
>>>> 91              free(buf);
>>>> 92              return log_msg_ret("header", -ENOENT);
>>>> 93      }
>>>> 94
>>>> 95      priv->header_version =3D ((struct andr_boot_img_hdr_v0
>>>> *)buf)->header_version;
>>>>>>>      CID 501795:  Insecure data handling  (TAINTED_SCALAR)
>>>>>>>      Passing tainted expression "*buf" to "dlfree", which uses it =
as an
>>>> offset=2E
>>>
>>> scan_boot_part() generates this warning, but scan_vendor_boot_part()
>>> does not=2E
>>> Both functions follow a similar code flow=2E
>>>
>>> The only reason scan_boot_part() generates this warning, is because of
>>> the downcast into struct andr_boot_img_hdr_v0=2E
>>>
>>> We can't change char* buf into struct andr_boot_img_hdr_v0 because we
>>> need to be block aligned when calling blk_dread()=2E
>>>
>>> Per my understanding tainted data means it comes from user input (whic=
h
>>> is true for both scan_boot_part() and scan_vendor_boot_part() because
>>> both read from eMMC, which can be consider "user input"=2E
>>>
>>> Since I don't see any particular problem with this code I propose that
>>> we ignore this warning=2E
>>
>> The warning is specifically about invoking free for the buffer that we
>> have allocated via malloc()=2E Our implementation of malloc() and free(=
)
>> stores some meta-information about allocated buffers at a negative
>> offset and we don't overwrite this area via blk_read()=2E
>
>Ok, so does that mean that you agree that this code is safe and we don't
>need any further action to fix it?

No fix needed=2E

Tom just needs to nark it in Coverity as "intended"=2E

>
>>
>>>
>>>
>>>> 96      free(buf);
>>>> 97
>>>> 98      return 0;
>>>> 99     }
>>>> 100
>>>> 101     static int scan_vendor_boot_part(struct udevice *blk, struct
>>>> android_priv *priv)
>>>>
>>>> ** CID 501794:  Memory - corruptions  (OVERRUN)
>>>>
>>>>
>>>> _____________________________________________________________________=
___________________________________
>>>> *** CID 501794:  Memory - corruptions  (OVERRUN)
>>>> /lib/tpm_tcg2=2Ec: 640 in tcg2_measurement_init()
>>>> 634             rc =3D tcg2_log_prepare_buffer(*dev, elog,
>>>> ignore_existing_log);
>>>> 635             if (rc) {
>>>> 636                     tcg2_measurement_term(*dev, elog, true);
>>>> 637                     return rc;
>>>> 638             }
>>>> 639
>>>>>>>      CID 501794:  Memory - corruptions  (OVERRUN)
>>>>>>>      Overrunning array "version_string" of 50 bytes by passing it =
to a
>>>> function which accesses it at byte offset 63=2E
>>>> 640             rc =3D tcg2_measure_event(*dev, elog, 0, EV_S_CRTM_VE=
RSION,
>>>> 641                                     strlen(version_string) + 1,
>>>> 642                                     (u8 *)version_string);
>>>> 643             if (rc) {
>>>> 644                     tcg2_measurement_term(*dev, elog, true);
>>>> 645                     return rc;
>>>>
>>>> ** CID 501793:  Insecure data handling  (TAINTED_SCALAR)
>>>> /lib/tpm-v2=2Ec: 909 in tpm2_allow_extend()
>>>>
>>>>
>>>> _____________________________________________________________________=
___________________________________
>>>> *** CID 501793:  Insecure data handling  (TAINTED_SCALAR)
>>>> /lib/tpm-v2=2Ec: 909 in tpm2_allow_extend()
>>>> 903             int rc;
>>>> 904
>>>> 905             rc =3D tpm2_get_pcr_info(dev, &pcrs);
>>>> 906             if (rc)
>>>> 907                     return false;
>>>> 908
>>>>>>>      CID 501793:  Insecure data handling  (TAINTED_SCALAR)
>>>>>>>      Using tainted variable "pcrs=2Ecount" as a loop boundary=2E
>>>> 909             for (i =3D 0; i < pcrs=2Ecount; i++) {
>>>> 910                     if (tpm2_is_active_pcr(&pcrs=2Eselection[i]) =
&&
>>>> 911                         !tpm2_algorithm_to_len(pcrs=2Eselection[i=
]=2Ehash))
>>>> 912                             return false;
>>>> 913             }
>>>> 914
>>>> 915             return true;
>>>>
>>>> ** CID 501792:  Control flow issues  (DEADCODE)
>>>> /lib/efi_loader/efi_helper=2Ec: 137 in efi_load_option_dp_join()
>>>>
>>>>
>>>> _____________________________________________________________________=
___________________________________
>>>> *** CID 501792:  Control flow issues  (DEADCODE)
>>>> /lib/efi_loader/efi_helper=2Ec: 137 in efi_load_option_dp_join()
>>>> 131             if (fdt_dp) {
>>>> 132                     struct efi_device_path *tmp_dp =3D *dp;
>>>> 133
>>>> 134                     *dp =3D efi_dp_concat(tmp_dp, fdt_dp, *dp_siz=
e);
>>>> 135                     efi_free_pool(tmp_dp);
>>>> 136                     if (!dp)
>>>>>>>      CID 501792:  Control flow issues  (DEADCODE)
>>>>>>>      Execution cannot reach this statement: "return
>>>> 9223372036854775817UL;"=2E
>>>> 137                             return EFI_OUT_OF_RESOURCES;
>>>> 138                     *dp_size +=3D efi_dp_size(fdt_dp) + sizeof(EN=
D);
>>>> 139             }
>>>> 140
>>>> 141             *dp_size +=3D sizeof(END);
>>>> 142
>>>>
>>>> ** CID 501791:    (DEADCODE)
>>>> /drivers/usb/gadget/ether=2Ec: 2219 in eth_bind()
>>>> /drivers/usb/gadget/ether=2Ec: 2110 in eth_bind()
>>>> /drivers/usb/gadget/ether=2Ec: 2071 in eth_bind()
>>>> /drivers/usb/gadget/ether=2Ec: 2089 in eth_bind()
>>>>
>>>>
>>>> _____________________________________________________________________=
___________________________________
>>>> *** CID 501791:    (DEADCODE)
>>>> /drivers/usb/gadget/ether=2Ec: 2219 in eth_bind()
>>>> 2213                    out_ep->name, in_ep->name,
>>>> 2214                    status_ep ? " STATUS " : "",
>>>> 2215                    status_ep ? status_ep->name : ""
>>>> 2216                    );
>>>> 2217            printf("MAC %pM\n", pdata->enetaddr);
>>>> 2218
>>>>>>>      CID 501791:    (DEADCODE)
>>>>>>>      Execution cannot reach the expression "rndis" inside this
>>>> statement: "if (cdc || rndis)
>>>>    printf(=2E=2E=2E"=2E
>>>> 2219            if (cdc || rndis)
>>>> 2220                    printf("HOST MAC %02x:%02x:%02x:%02x:%02x:%02=
x\n",
>>>> 2221                            dev->host_mac[0], dev->host_mac[1],
>>>> 2222                            dev->host_mac[2], dev->host_mac[3],
>>>> 2223                            dev->host_mac[4], dev->host_mac[5]);
>>>> 2224
>>>> /drivers/usb/gadget/ether=2Ec: 2110 in eth_bind()
>>>> 2104                    device_desc=2EbNumConfigurations =3D 2;
>>>> 2105
>>>> 2106            if (gadget_is_dualspeed(gadget)) {
>>>> 2107                    if (rndis)
>>>> 2108                            dev_qualifier=2EbNumConfigurations =
=3D 2;
>>>> 2109                    else if (!cdc)
>>>>>>>      CID 501791:    (DEADCODE)
>>>>>>>      Execution cannot reach this statement: "dev_qualifier=2EbDevi=
ceClass
>>>> =2E=2E=2E"=2E
>>>> 2110                            dev_qualifier=2EbDeviceClass =3D
>>>> USB_CLASS_VENDOR_SPEC;
>>>> 2111
>>>> 2112                    /* assumes ep0 uses the same value for both s=
peeds
>>>> =2E=2E=2E */
>>>> 2113                    dev_qualifier=2EbMaxPacketSize0 =3D
>>>> device_desc=2EbMaxPacketSize0;
>>>> 2114
>>>> 2115                    /* and that all endpoints are dual-speed */
>>>> /drivers/usb/gadget/ether=2Ec: 2071 in eth_bind()
>>>> 2065
>>>> 2066     #if defined(CONFIG_USB_ETH_CDC) || defined(CONFIG_USB_ETH_RN=
DIS)
>>>> 2067            /*
>>>> 2068             * CDC Ethernet control interface doesn't require a s=
tatus
>>>> endpoint=2E
>>>> 2069             * Since some hosts expect one, try to allocate one a=
nyway=2E
>>>> 2070             */
>>>>>>>      CID 501791:    (DEADCODE)
>>>>>>>      Execution cannot reach the expression "rndis" inside this
>>>> statement: "if (cdc || rndis) {
>>>>    statu=2E=2E=2E"=2E
>>>> 2071            if (cdc || rndis) {
>>>> 2072                    status_ep =3D usb_ep_autoconfig(gadget,
>>>> &fs_status_desc);
>>>> 2073                    if (status_ep) {
>>>> 2074                            status_ep->driver_data =3D status_ep;=
     /*
>>>> claim */
>>>> 2075                    } else if (rndis) {
>>>> 2076                            pr_err("can't run RNDIS on %s",
>>>> gadget->name);
>>>> /drivers/usb/gadget/ether=2Ec: 2089 in eth_bind()
>>>> 2083                    }
>>>> 2084            }
>>>> 2085     #endif
>>>> 2086
>>>> 2087            /* one config:  cdc, else minimal subset */
>>>> 2088            if (!cdc) {
>>>>>>>      CID 501791:    (DEADCODE)
>>>>>>>      Execution cannot reach this statement: "eth_config=2EbNumInte=
rfaces =3D
>>>> 1;"=2E
>>>> 2089                    eth_config=2EbNumInterfaces =3D 1;
>>>> 2090                    eth_config=2EiConfiguration =3D STRING_SUBSET=
;
>>>> 2091
>>>> 2092                    /*
>>>> 2093                     * use functions to set these up, in case we'=
re
>>>> built to work
>>>> 2094                     * with multiple controllers and must overrid=
e CDC
>>>> Ethernet=2E
>>>>
>>>> ** CID 501790:  Null pointer dereferences  (FORWARD_NULL)
>>>> /cmd/bcb=2Ec: 175 in __bcb_initialize()
>>>>
>>>>
>>>> _____________________________________________________________________=
___________________________________
>>>> *** CID 501790:  Null pointer dereferences  (FORWARD_NULL)
>>>> /cmd/bcb=2Ec: 175 in __bcb_initialize()
>>>> 169                     }
>>>> 170             }
>>>> 171
>>>> 172             return CMD_RET_SUCCESS;
>>>> 173
>>>> 174     err_read_fail:
>>>>>>>      CID 501790:  Null pointer dereferences  (FORWARD_NULL)
>>>>>>>      Dereferencing null pointer "block"=2E
>>>> 175             printf("Error: %d %d:%s read failed (%d)\n",
>>>> block->uclass_id,
>>>> 176                    block->devnum, partition->name, ret);
>>>> 177             __bcb_reset();
>>>> 178             return CMD_RET_FAILURE;
>>>> 179     }
>>>> 180
>>>
>>> This probably deserves to be addressed=2E I don't know if Dmitrii is a=
ctively
>>> watching the list so I'll study this in more detail and send a fix if =
appropriate=2E
>>
>> If blk_get_dev() returns NULL, we should write a message like "No such
>> device" and return CMD_RET_FAILURE immediately=2E
>
>Yes, thank you, I've submitted a fix:
>
>https://lore=2Ekernel=2Eorg/all/20240724-bcb-crash-v1-1-44caff15bce4@bayl=
ibre=2Ecom/
>
>
>>
>> Please, use log_err() for writing error messages=2E We don't need "Erro=
r:"
>> at the beginning of error messages=2E
>
>Is log_err() also the preferred way for commands? Since they are
>interactive, it seems odd to have an "optional" message=2E
>
>If it is, I'll convert the whole file in a separate, future patch=2E

Messages written with the log functions can be written to a syslog server=
=2E Remote message logging  may be of interest for commands executed in scr=
ipts=2E

Best regards

Heinrich



>
>>
>> Best regards
>>
>> Heinrich
>>
>>>
>>>>
>>>> ** CID 501789:  Insecure data handling  (TAINTED_SCALAR)
>>>> /lib/tpm_tcg2=2Ec: 41 in tcg2_get_pcr_info()
>>>>
>>>>
>>>> _____________________________________________________________________=
___________________________________
>>>> *** CID 501789:  Insecure data handling  (TAINTED_SCALAR)
>>>> /lib/tpm_tcg2=2Ec: 41 in tcg2_get_pcr_info()
>>>> 35      memset(response, 0, sizeof(response));
>>>> 36
>>>> 37      ret =3D tpm2_get_pcr_info(dev, &pcrs);
>>>> 38      if (ret)
>>>> 39              return ret;
>>>> 40
>>>>>>>      CID 501789:  Insecure data handling  (TAINTED_SCALAR)
>>>>>>>      Using tainted variable "pcrs=2Ecount" as a loop boundary=2E
>>>> 41      for (i =3D 0; i < pcrs=2Ecount; i++) {
>>>> 42              u32 hash_mask =3D
>>>> tcg2_algorithm_to_mask(pcrs=2Eselection[i]=2Ehash);
>>>> 43
>>>> 44              if (hash_mask) {
>>>> 45                      *supported_pcr |=3D hash_mask;
>>>> 46                      if (tpm2_is_active_pcr(&pcrs=2Eselection[i]))
>>>>
>>>> ** CID 501788:  Memory - corruptions  (OVERRUN)
>>>>
>>>>
>>>> _____________________________________________________________________=
___________________________________
>>>> *** CID 501788:  Memory - corruptions  (OVERRUN)
>>>> /lib/tpm_tcg2=2Ec: 658 in tcg2_measurement_term()
>>>> 652                                bool error)
>>>> 653     {
>>>> 654             u32 event =3D error ? 0x1 : 0xffffffff;
>>>> 655             int i;
>>>> 656
>>>> 657             for (i =3D 0; i < 8; ++i)
>>>>>>>      CID 501788:  Memory - corruptions  (OVERRUN)
>>>>>>>      Overrunning buffer pointed to by "(u8 const *)&event" of 4 by=
tes by
>>>> passing it to a function which accesses it at byte offset 63=2E
>>>> 658                     tcg2_measure_event(dev, elog, i, EV_SEPARATOR=
,
>>>> sizeof(event),
>>>> 659                                        (const u8 *)&event);
>>>> 660
>>>> 661             if (elog->log)
>>>> 662                     unmap_physmem(elog->log, MAP_NOCACHE);
>>>> 663     }
>>>>
>>>>
>>>>
>>>> ----- End forwarded message -----
>>>>
>>>> --
>>>> Tom
