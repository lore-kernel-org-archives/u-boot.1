Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B2F7C4167B
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 11:19:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A51E87030;
	Tue,  7 Nov 2023 12:19:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PEZSVD5w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7996487073; Tue,  7 Nov 2023 12:18:58 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 326B087016
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 12:18:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-507a98517f3so6866319e87.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 03:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699355935; x=1699960735; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1A1Cap4+zv6fXoI26xsOZQYf/uSeclpgmf9leT1eDZQ=;
 b=PEZSVD5wL9glqR8pGW6ik/fmNxD6pYgiJPdoctPipg3Ui7cZKemgVsm3KidoABDK8Q
 ZSr9SB6KNOOilXgWrNJBWZKEidZWq+oWEffhdeOHyONpZO+nqjK4sAfpOiDa10puXfpx
 MOUMrG4AZyFkO+CWNefTAyIbRmajidO05UAIZ90qTlTrDKV50nngmratWFRaJ5mt2TQb
 HmeIqABPGXbLt6tTzbKz2d8CJ0eOcfSLTbYrm0xdX7QeZm58vf5CeigNAN5JB3XO7RIg
 Qw4n+p3uUMNXuxda/XcvqB97X2hyY8uJg+ZUs6XRoZhiSgVl4cp8wNCmFd0jWzNc4y4h
 4myA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699355935; x=1699960735;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1A1Cap4+zv6fXoI26xsOZQYf/uSeclpgmf9leT1eDZQ=;
 b=UNYmM2wIVtX54mbtY/0Iu15gT2DU9EICCifkuWcDXo2WGE4GLgOOXscbCZzoBnlR4Q
 QvPmtmj7VyvZ27aHnOWCqKFAp1MPN7sQJzKO/qGA1xdwiJ0Ets7G3MX0KRe+3wMHA9rR
 raA2pFTcLXtJ5sqtchc4IJ7f9wktCQZqEsOIsFG+dvAdk7QiuWMiiNP1FV5S2yB0Pnhp
 K8NivDmslP38C1GXISP176mql/35Qw8gxMomSmFBO2g/49D4A3il4HLRQoMjVzampezJ
 jffFvFBEEhwgI4RQO+qZHkuRtvCuKK/2GEnl4Wem4MJXI8moKUnIT/MyyLvzlrqCsXbJ
 2oYw==
X-Gm-Message-State: AOJu0YzvFnV2HaxbE1f7ycFOXQaVilsFtqQUXtCtHk2VU9AmC6WAkrhk
 /uFraIKVK/RPiF+8p32Qt0vsICanPY9dehlmjF5nCg==
X-Google-Smtp-Source: AGHT+IGgXnRjnKghetYxV+v9xsf1GUE9sj+QLTwYfpsMKIUIeIyZCegaMgP0XBdLN2shQFKFX3QFGfFfm4BXtMMoR08=
X-Received: by 2002:a05:6512:118d:b0:503:3816:c42c with SMTP id
 g13-20020a056512118d00b005033816c42cmr27900696lfr.41.1699355935255; Tue, 07
 Nov 2023 03:18:55 -0800 (PST)
MIME-Version: 1.0
References: <20231106202752.GH496310@bill-the-cat>
In-Reply-To: <20231106202752.GH496310@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 7 Nov 2023 13:18:19 +0200
Message-ID: <CAC_iWjJ7hNTK0HorWvoGKYKXaz+ipK+8SKwyAOY+0kbTfZ3i=g@mail.gmail.com>
Subject: Re: [tom.rini@gmail.com: Fwd: New Defects reported by Coverity Scan
 for Das U-Boot]
To: Tom Rini <trini@konsulko.com>, Eddie James <eajames@linux.ibm.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Alexander Gendin <agendin@matrox.com>
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

Hi Tom,

Thanks for the report.
Eddie, can you please check the TCG related ones?

Thanks
/Ilias

On Mon, 6 Nov 2023 at 22:27, Tom Rini <trini@konsulko.com> wrote:
>
> Hey all,
>
> Here's the latest report. I _think_ I passed the right options to
> get_maintainer.pl such that it would only look far enough back in git to
> find the likely authors (along with listed maintainers of the files).
>
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Mon, Nov 6, 2023 at 2:58=E2=80=AFPM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
>
>
> Hi,
>
> Please find the latest report on new defect(s) introduced to Das
> U-Boot found with Coverity Scan.
>
> 13 new defect(s) introduced to Das U-Boot found with Coverity Scan.
> 5 defect(s), reported by Coverity Scan earlier, were marked fixed in
> the recent build analyzed by Coverity Scan.
>
> New defect(s) Reported-by: Coverity Scan
> Showing 13 of 13 defect(s)
>
>
> ** CID 467411:  Memory - corruptions  (OVERRUN)
>
>
> _________________________________________________________________________=
_______________________________
> *** CID 467411:  Memory - corruptions  (OVERRUN)
> /lib/efi_loader/efi_tcg2.c: 1395 in efi_tcg2_measure_efi_app_invocation()
> 1389
> 1390            ret =3D tcg2_measure_gpt_data(dev, handle);
> 1391            if (ret !=3D EFI_SUCCESS)
> 1392                    goto out;
> 1393
> 1394            for (pcr_index =3D 0; pcr_index <=3D 7; pcr_index++) {
> >>>     CID 467411:  Memory - corruptions  (OVERRUN)
> >>>     Overrunning buffer pointed to by "(u8 *)&event" of 4 bytes by pas=
sing it to a function which accesses it at byte offset 63.
> 1395                    ret =3D measure_event(dev, pcr_index, EV_SEPARATO=
R,
> 1396                                        sizeof(event), (u8 *)&event);
> 1397                    if (ret !=3D EFI_SUCCESS)
> 1398                            goto out;
> 1399            }
> 1400
>
> ** CID 467410:    (TAINTED_SCALAR)
>
>
> _________________________________________________________________________=
_______________________________
> *** CID 467410:    (TAINTED_SCALAR)
> /lib/efi_loader/efi_tcg2.c: 1385 in efi_tcg2_measure_efi_app_invocation()
> 1379                                (u8 *)EFI_CALLING_EFI_APPLICATION);
> 1380            if (ret !=3D EFI_SUCCESS)
> 1381                    goto out;
> 1382
> 1383            entry =3D (struct smbios_entry *)find_smbios_table();
> 1384            if (entry) {
> >>>     CID 467410:    (TAINTED_SCALAR)
> >>>     Passing tainted expression "entry->struct_table_length" to "tcg2_=
measure_smbios", which uses it as an offset.
> 1385                    ret =3D tcg2_measure_smbios(dev, entry);
> 1386                    if (ret !=3D EFI_SUCCESS)
> 1387                            goto out;
> 1388            }
> 1389
> 1390            ret =3D tcg2_measure_gpt_data(dev, handle);
> /lib/efi_loader/efi_tcg2.c: 1385 in efi_tcg2_measure_efi_app_invocation()
> 1379                                (u8 *)EFI_CALLING_EFI_APPLICATION);
> 1380            if (ret !=3D EFI_SUCCESS)
> 1381                    goto out;
> 1382
> 1383            entry =3D (struct smbios_entry *)find_smbios_table();
> 1384            if (entry) {
> >>>     CID 467410:    (TAINTED_SCALAR)
> >>>     Passing tainted expression "entry->struct_count" to "tcg2_measure=
_smbios", which uses it as a loop boundary.
> 1385                    ret =3D tcg2_measure_smbios(dev, entry);
> 1386                    if (ret !=3D EFI_SUCCESS)
> 1387                            goto out;
> 1388            }
> 1389
> 1390            ret =3D tcg2_measure_gpt_data(dev, handle);
>
> ** CID 467409:  Uninitialized variables  (UNINIT)
>
>
> _________________________________________________________________________=
_______________________________
> *** CID 467409:  Uninitialized variables  (UNINIT)
> /test/boot/measurement.c: 48 in measure()
> 42      for (i =3D 0; i < size; ++i) {
> 43              kernel[i] =3D 0xf0 | (i & 0xf);
> 44              initrd[i] =3D (i & 0xf0) | 0xf;
> 45              images.ft_addr[i] =3D i & 0xff;
> 46      }
> 47
> >>>     CID 467409:  Uninitialized variables  (UNINIT)
> >>>     Using uninitialized value "images.os.os" when calling "bootm_meas=
ure".
> 48      ut_assertok(bootm_measure(&images));
> 49
> 50      free(images.ft_addr);
> 51      free(initrd);
> 52      free(kernel);
> 53
>
> ** CID 467408:  Insecure data handling  (TAINTED_SCALAR)
>
>
> _________________________________________________________________________=
_______________________________
> *** CID 467408:  Insecure data handling  (TAINTED_SCALAR)
> /boot/bootm.c: 826 in do_bootm_states()
> 820                             env_set_hex("initrd_end", images->initrd_=
end);
> 821                     }
> 822             }
> 823     #endif
> 824     #if CONFIG_IS_ENABLED(OF_LIBFDT) && defined(CONFIG_LMB)
> 825             if (!ret && (states & BOOTM_STATE_FDT)) {
> >>>     CID 467408:  Insecure data handling  (TAINTED_SCALAR)
> >>>     Passing tainted expression "*images->ft_addr" to "boot_fdt_add_me=
m_rsv_regions", which uses it as an offset.
> 826                     boot_fdt_add_mem_rsv_regions(&images->lmb,
> images->ft_addr);
> 827                     ret =3D boot_relocate_fdt(&images->lmb, &images->=
ft_addr,
> 828                                             &images->ft_len);
> 829             }
> 830     #endif
> 831
>
> ** CID 467407:  Uninitialized variables  (UNINIT)
> /drivers/scsi/scsi.c: 612 in do_scsi_scan_one()
>
>
> _________________________________________________________________________=
_______________________________
> *** CID 467407:  Uninitialized variables  (UNINIT)
> /drivers/scsi/scsi.c: 612 in do_scsi_scan_one()
> 606
> 607             bdesc =3D dev_get_uclass_plat(bdev);
> 608             bdesc->target =3D id;
> 609             bdesc->lun =3D lun;
> 610             bdesc->removable =3D bd.removable;
> 611             bdesc->type =3D bd.type;
> >>>     CID 467407:  Uninitialized variables  (UNINIT)
> >>>     Using uninitialized value "bd.bb".
> 612             bdesc->bb =3D bd.bb;
> 613             memcpy(&bdesc->vendor, &bd.vendor, sizeof(bd.vendor));
> 614             memcpy(&bdesc->product, &bd.product, sizeof(bd.product));
> 615             memcpy(&bdesc->revision, &bd.revision,  sizeof(bd.revisio=
n));
> 616             if (IS_ENABLED(CONFIG_SYS_BIG_ENDIAN)) {
> 617                     ata_swap_buf_le16((u16 *)&bdesc->vendor,
> sizeof(bd.vendor) / 2);
>
> ** CID 467406:  Memory - corruptions  (OVERRUN)
>
>
> _________________________________________________________________________=
_______________________________
> *** CID 467406:  Memory - corruptions  (OVERRUN)
> /lib/efi_loader/efi_tcg2.c: 885 in efi_append_scrtm_version()
> 879      * @Return:     status code
> 880      */
> 881     static efi_status_t efi_append_scrtm_version(struct udevice *dev)
> 882     {
> 883             efi_status_t ret;
> 884
> >>>     CID 467406:  Memory - corruptions  (OVERRUN)
> >>>     Overrunning array "version_string" of 50 bytes by passing it to a=
 function which accesses it at byte offset 63.
> 885             ret =3D measure_event(dev, 0, EV_S_CRTM_VERSION,
> 886                                 strlen(version_string) + 1, (u8
> *)version_string);
> 887
> 888             return ret;
> 889     }
> 890
>
> ** CID 467405:  Memory - illegal accesses  (OVERRUN)
> /drivers/firmware/scmi/sandbox-scmi_agent.c: 662 in sandbox_scmi_pwd_stat=
e_get()
>
>
> _________________________________________________________________________=
_______________________________
> *** CID 467405:  Memory - illegal accesses  (OVERRUN)
> /drivers/firmware/scmi/sandbox-scmi_agent.c: 662 in sandbox_scmi_pwd_stat=
e_get()
> 656             if (domain_id > ARRAY_SIZE(scmi_pwdom)) {
> 657                     out->status =3D SCMI_NOT_FOUND;
> 658
> 659                     return 0;
> 660             }
> 661
> >>>     CID 467405:  Memory - illegal accesses  (OVERRUN)
> >>>     Overrunning array "scmi_pwdom" of 3 8-byte elements at element in=
dex 3 (byte offset 31) using index "domain_id" (which evaluates to 3).
> 662             out->pstate =3D scmi_pwdom[domain_id].pstate;
> 663             out->status =3D SCMI_SUCCESS;
> 664
> 665             return 0;
> 666     }
> 667
>
> ** CID 467404:  Control flow issues  (DEADCODE)
> /test/cmd/mbr.c: 217 in build_mbr_parts()
>
>
> _________________________________________________________________________=
_______________________________
> *** CID 467404:  Control flow issues  (DEADCODE)
> /test/cmd/mbr.c: 217 in build_mbr_parts()
> 211                                             return 1;
> 212                                     strcat(cur_buf, mbr_parts_p5);
> 213                                     bytes_remaining -=3D cur_str_size=
;
> 214
> 215                             }
> 216                             else if (num_parts > 5)
> >>>     CID 467404:  Control flow issues  (DEADCODE)
> >>>     Execution cannot reach this statement: "return 1U;".
> 217                                     return 1;
> 218                             }
> 219                     }
> 220             }
> 221
> 222             cur_str_size =3D sizeof(mbr_parts_tail);
>
> ** CID 467403:  Error handling issues  (CHECKED_RETURN)
> /test/dm/ofnode.c: 869 in dm_test_ofnode_livetree_writing()
>
>
> _________________________________________________________________________=
_______________________________
> *** CID 467403:  Error handling issues  (CHECKED_RETURN)
> /test/dm/ofnode.c: 869 in dm_test_ofnode_livetree_writing()
> 863             node =3D ofnode_path("/usb@2");
> 864
> 865             ut_assert(!ofnode_is_enabled(node));
> 866             ut_assertok(ofnode_set_enabled(node, true));
> 867             ut_asserteq(true, ofnode_is_enabled(node));
> 868
> >>>     CID 467403:  Error handling issues  (CHECKED_RETURN)
> >>>     Calling "device_bind_driver_to_node" without checking return valu=
e (as is done elsewhere 12 out of 15 times).
> 869             device_bind_driver_to_node(dm_root(), "usb_sandbox",
> "usb@2", node,
> 870                                        &dev);
> 871             ut_assertok(uclass_find_device_by_seq(UCLASS_USB, 2, &dev=
));
> 872
> 873             /* Test string property setting */
> 874             ut_assert(device_is_compatible(dev, "sandbox,usb"));
>
> ** CID 467402:    (CHECKED_RETURN)
> /drivers/block/rkmtd.c: 737 in rkmtd_init_plat()
> /drivers/block/rkmtd.c: 755 in rkmtd_init_plat()
>
>
> _________________________________________________________________________=
_______________________________
> *** CID 467402:    (CHECKED_RETURN)
> /drivers/block/rkmtd.c: 737 in rkmtd_init_plat()
> 731
> 732             debug("starting_lba           : %llu\n",
> le64_to_cpu(plat->gpt_e->starting_lba));
> 733             debug("ending_lba             : %llu\n",
> le64_to_cpu(plat->gpt_e->ending_lba));
> 734
> 735             memcpy(plat->gpt_e->partition_type_guid.b,
> &partition_basic_data_guid, 16);
> 736
> >>>     CID 467402:    (CHECKED_RETURN)
> >>>     Calling "uuid_str_to_bin" without checking return value (as is do=
ne elsewhere 9 out of 11 times).
> 737             uuid_str_to_bin(plat->uuid_part_str,
> plat->gpt_e->unique_partition_guid.b,
> 738                             UUID_STR_FORMAT_GUID);
> 739
> 740             efiname_len =3D sizeof(plat->gpt_e->partition_name) /
> sizeof(efi_char16_t);
> 741             dosname_len =3D sizeof(name);
> 742
> /drivers/block/rkmtd.c: 755 in rkmtd_init_plat()
> 749             plat->gpt_h->header_size =3D cpu_to_le32(sizeof(gpt_heade=
r));
> 750             plat->gpt_h->first_usable_lba =3D cpu_to_le64(64);
> 751             plat->gpt_h->last_usable_lba =3D cpu_to_le64(LBA - 34);
> 752             plat->gpt_h->num_partition_entries =3D cpu_to_le32(1);
> 753             plat->gpt_h->sizeof_partition_entry =3D
> cpu_to_le32(sizeof(gpt_entry));
> 754
> >>>     CID 467402:    (CHECKED_RETURN)
> >>>     Calling "uuid_str_to_bin" without checking return value (as is do=
ne elsewhere 9 out of 11 times).
> 755             uuid_str_to_bin(plat->uuid_disk_str, plat->gpt_h->disk_gu=
id.b,
> 756                             UUID_STR_FORMAT_GUID);
> 757
> 758             plat->gpt_h->partition_entry_array_crc32 =3D 0;
> 759             calc_crc32 =3D efi_crc32((const unsigned char *)plat->gpt=
_e,
> 760
> le32_to_cpu(plat->gpt_h->num_partition_entries) *
>
> ** CID 467401:  Memory - corruptions  (OVERRUN)
> /drivers/firmware/scmi/sandbox-scmi_agent.c: 629 in sandbox_scmi_pwd_stat=
e_set()
>
>
> _________________________________________________________________________=
_______________________________
> *** CID 467401:  Memory - corruptions  (OVERRUN)
> /drivers/firmware/scmi/sandbox-scmi_agent.c: 629 in sandbox_scmi_pwd_stat=
e_set()
> 623                 (in->pstate !=3D SCMI_PWD_PSTATE_TYPE_LOST && in->pst=
ate)) {
> 624                     *status =3D SCMI_INVALID_PARAMETERS;
> 625
> 626                     return 0;
> 627             }
> 628
> >>>     CID 467401:  Memory - corruptions  (OVERRUN)
> >>>     Overrunning array "scmi_pwdom" of 3 8-byte elements at element in=
dex 3 (byte offset 31) using index "in->domain_id" (which evaluates to 3).
> 629             scmi_pwdom[in->domain_id].pstate =3D in->pstate;
> 630             *status =3D SCMI_SUCCESS;
> 631
> 632             return 0;
> 633     }
> 634
>
> ** CID 467400:  Memory - illegal accesses  (OVERRUN)
> /lib/efi_loader/efi_tcg2.c: 998 in tcg2_measure_variable()
>
>
> _________________________________________________________________________=
_______________________________
> *** CID 467400:  Memory - illegal accesses  (OVERRUN)
> /lib/efi_loader/efi_tcg2.c: 998 in tcg2_measure_variable()
> 992             guidcpy(&event->variable_name, guid);
> 993             event->unicode_name_length =3D u16_strlen(var_name);
> 994             event->variable_data_length =3D data_size;
> 995             memcpy(event->unicode_name, var_name,
> 996                    (event->unicode_name_length * sizeof(u16)));
> 997             if (data) {
> >>>     CID 467400:  Memory - illegal accesses  (OVERRUN)
> >>>     Overrunning array of 2 bytes at byte offset 2 by dereferencing po=
inter "(u16 *)event->unicode_name + event->unicode_name_length". [Note: The=
 source code implementation of the function has been overridden by a builti=
n model.]
> 998                     memcpy((u16 *)event->unicode_name +
> event->unicode_name_length,
> 999                            data, data_size);
> 1000            }
> 1001            ret =3D measure_event(dev, pcr_index, event_type, event_s=
ize,
> 1002                                (u8 *)event);
> 1003            free(event);
>
> ** CID 467399:  Code maintainability issues  (UNUSED_VALUE)
> /lib/efi_loader/efi_tcg2.c: 948 in efi_init_event_log()
>
>
> _________________________________________________________________________=
_______________________________
> *** CID 467399:  Code maintainability issues  (UNUSED_VALUE)
> /lib/efi_loader/efi_tcg2.c: 948 in efi_init_event_log()
> 942
> 943             /*
> 944              * Add SCRTM version to the log if previous firmmware
> 945              * doesn't pass an eventlog.
> 946              */
> 947             if (!elog.found)
> >>>     CID 467399:  Code maintainability issues  (UNUSED_VALUE)
> >>>     Assigning value from "efi_append_scrtm_version(dev)" to "ret" her=
e, but that stored value is overwritten before it can be used.
> 948                     ret =3D efi_append_scrtm_version(dev);
> 949
> 950             ret =3D create_final_event();
> 951             if (ret !=3D EFI_SUCCESS)
> 952                     goto free_pool;
> 953
>
>
> --
> Tom
