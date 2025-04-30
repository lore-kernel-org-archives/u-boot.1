Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EC2C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 18:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D196882C03;
	Wed, 30 Apr 2025 20:23:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="UlrB4xi1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB81E82C49; Wed, 30 Apr 2025 20:23:54 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BC0782B9D
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 20:23:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1746037420; x=1746642220; i=xypron.glpk@gmx.de;
 bh=CCDKfueZGY2Z4qRrd2t/T5ajBtaci0NfTSioyCckEeQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=UlrB4xi1kAwyCVgMA8E8qQvuXT6IxlGz5zyG3LoHn7bjFHsdSoBCyOGnX1c+oluw
 zD/rD9orRnOycxReClUjpn94+I1O7G6dhbElfqhCIsmW1AdjammkFEJMdCAttM3zV
 vKsGzE7+zxkV6wQV67qw+xLVc85246Z7jwUmHchdxiXCzBD/1mNaeDxhXm/gIiCxl
 lsHI9Y9GxnBuwrzKXpjXr5EDopu7cPyMFePqp3qHjI+wLT45o5f8+vnP4LwecroW8
 wye96kt9oZWlQQWDJdI+yuk4ue+fL/m0+PCnmZBIVYMT2dg/031z7kaRBlwd4Bfy9
 qaCpKC77VKXxADH4zQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWASY-1uXkJi0LTW-00MhG0; Wed, 30
 Apr 2025 20:23:40 +0200
Message-ID: <0ffea631-2d8a-4f24-abfd-ef4aaeca01c8@gmx.de>
Date: Wed, 30 Apr 2025 20:23:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
To: Tom Rini <trini@konsulko.com>
References: <20250428215930.GI5495@bill-the-cat>
Content-Language: en-US
Cc: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Casey Connolly <casey.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250428215930.GI5495@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LaGae47n7nE5U9Wi+8IDzCERFlccEga7GZhlKOcQJxPiEJBLFdp
 YQ1dyrxzkjQffZnRfbQcIoL0Gc2JR99WRa0m3tBOsq4+Feg5ngl/slChwga27EMfDhu4owZ
 uL0VZ1hqSwwl5EHAf6WVjpOTquK8ZQkBJBVKa/y8YiHGvgOGc2T/6H1ENvw37HRCJ7sLD2i
 f2Tjb+BzdfODOCpYBDQmQ==
UI-OutboundReport: notjunk:1;M01:P0:4ctLaoY6ACY=;QnPlaVJkdFocESlMjGaM/niNcwI
 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
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

On 28.04.25 23:59, Tom Rini wrote:
> Hey all,
>=20
> Here's the latest set of Coverity defects. Please let me know if some of
> these are false positives for example, thanks.

Hello Tom,

I have marked the acpi_update_header() items as "intentional" in Coverity:

550301
550291
550288
550287

We could change the parameter of acpi_update_checksum() to const void *=20
to make Coverity happy but we would loose the type checking.

Best regards

Heinrich

>=20
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Mon, Apr 28, 2025 at 3:52=E2=80=AFPM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
>=20
>=20
> Hi,
>=20
> Please find the latest report on new defect(s) introduced to Das U-Boot
> found with Coverity Scan.
>=20
> 33 new defect(s) introduced to Das U-Boot found with Coverity Scan.
> 15 defect(s), reported by Coverity Scan earlier, were marked fixed in th=
e
> recent build analyzed by Coverity Scan.
>=20
> New defect(s) Reported-by: Coverity Scan
> Showing 20 of 33 defect(s)
>=20
>=20
> ** CID 550306:  Control flow issues  (DEADCODE)
> /fs/exfat/io.c: 547 in exfat_generic_pwrite()
>=20
>=20
> ________________________________________________________________________=
________________________________
> *** CID 550306:  Control flow issues  (DEADCODE)
> /fs/exfat/io.c: 547 in exfat_generic_pwrite()
> 541             int rc;
> 542             cluster_t cluster;
> 543             const char* bufp =3D buffer;
> 544             off_t lsize, loffset, remainder;
> 545
> 546             if (offset < 0)
>>>>      CID 550306:  Control flow issues  (DEADCODE)
>>>>      Execution cannot reach this statement: "return -22L;".
> 547                     return -EINVAL;
> 548             if (uoffset > node->size)
> 549             {
> 550                     rc =3D exfat_truncate(ef, node, uoffset, true);
> 551                     if (rc !=3D 0)
> 552                             return rc;
>=20
> ** CID 550305:  Security best practices violations  (STRING_OVERFLOW)
> /fs/exfat/io.c: 739 in exfat_fs_opendir()
>=20
>=20
> ________________________________________________________________________=
________________________________
> *** CID 550305:  Security best practices violations  (STRING_OVERFLOW)
> /fs/exfat/io.c: 739 in exfat_fs_opendir()
> 733                     return err;
> 734
> 735             dirs =3D calloc(1, sizeof(*dirs));
> 736             if (!dirs)
> 737                     return -ENOMEM;
> 738
>>>>      CID 550305:  Security best practices violations  (STRING_OVERFLO=
W)
>>>>      You might overrun the 1024-character fixed-size string
> "dirs->dirname" by copying "filename" without checking the length.
> 739             strcpy(dirs->dirname, filename);
> 740             dirs->offset =3D -1;
> 741
> 742             *dirsp =3D &dirs->fs_dirs;
> 743
> 744             return 0;
>=20
> ** CID 550304:  Error handling issues  (NEGATIVE_RETURNS)
> /tools/fit_check_sign.c: 98 in main()
>=20
>=20
> ________________________________________________________________________=
________________________________
> *** CID 550304:  Error handling issues  (NEGATIVE_RETURNS)
> /tools/fit_check_sign.c: 98 in main()
> 92      (void) munmap((void *)fit_blob, fsbuf.st_size);
> 93
> 94      if (key_blob)
> 95              (void)munmap((void *)key_blob, ksbuf.st_size);
> 96
> 97      close(ffd);
>>>>      CID 550304:  Error handling issues  (NEGATIVE_RETURNS)
>>>>      "kfd" is passed to a parameter that cannot be negative.
> 98      close(kfd);
> 99      exit(ret);
>=20
> ** CID 550303:  Control flow issues  (NO_EFFECT)
> /tools/preload_check_sign.c: 132 in main()
>=20
>=20
> ________________________________________________________________________=
________________________________
> *** CID 550303:  Control flow issues  (NO_EFFECT)
> /tools/preload_check_sign.c: 132 in main()
> 126
> 127             info.algo_name =3D algo;
> 128             info.padding_name =3D padding;
> 129             info.key =3D (uint8_t *)pkey;
> 130             info.mandatory =3D 1;
> 131             info.sig_size =3D EVP_PKEY_size(pkey);
>>>>      CID 550303:  Control flow issues  (NO_EFFECT)
>>>>      This less-than-zero comparison of an unsigned value is never tru=
e.
> "info.sig_size < 0U".
> 132             if (info.sig_size < 0) {
> 133                     fprintf(stderr, "Fail to retrieve the signature
> size: %s\n",
> 134                             ERR_error_string(ERR_get_error(), NULL))=
;
> 135                     ret =3D EXIT_FAILURE;
> 136                     goto out;
> 137             }
>=20
> ** CID 550302:    (TAINTED_SCALAR)
>=20
>=20
> ________________________________________________________________________=
________________________________
> *** CID 550302:    (TAINTED_SCALAR)
> /cmd/acpi.c: 118 in list_rsdt()
> 112                             entry =3D rsdt->entry[i];
> 113                     if (!entry)
> 114                             break;
> 115                     hdr =3D nomap_sysmem(entry, 0);
> 116                     dump_hdr(hdr, chksums);
> 117                     if (!memcmp(hdr->signature, "FACP", ACPI_NAME_LE=
N))
>>>>      CID 550302:    (TAINTED_SCALAR)
>>>>      Passing tainted expression "((struct acpi_fadt
> *)hdr)->firmware_ctrl" to "list_fadt", which uses it as a loop boundary.
> 118                             list_fadt((struct acpi_fadt *)hdr, chksu=
ms);
> 119             }
> 120     }
> 121
> 122     static void list_rsdp(struct acpi_rsdp *rsdp, bool chksums)
> 123     {
> /cmd/acpi.c: 118 in list_rsdt()
> 112                             entry =3D rsdt->entry[i];
> 113                     if (!entry)
> 114                             break;
> 115                     hdr =3D nomap_sysmem(entry, 0);
> 116                     dump_hdr(hdr, chksums);
> 117                     if (!memcmp(hdr->signature, "FACP", ACPI_NAME_LE=
N))
>>>>      CID 550302:    (TAINTED_SCALAR)
>>>>      Passing tainted expression "((struct acpi_fadt *)hdr)->x_dsdt" t=
o
> "list_fadt", which uses it as a loop boundary.
> 118                             list_fadt((struct acpi_fadt *)hdr, chksu=
ms);
> 119             }
> 120     }
> 121
> 122     static void list_rsdp(struct acpi_rsdp *rsdp, bool chksums)
> 123     {
> /cmd/acpi.c: 118 in list_rsdt()
> 112                             entry =3D rsdt->entry[i];
> 113                     if (!entry)
> 114                             break;
> 115                     hdr =3D nomap_sysmem(entry, 0);
> 116                     dump_hdr(hdr, chksums);
> 117                     if (!memcmp(hdr->signature, "FACP", ACPI_NAME_LE=
N))
>>>>      CID 550302:    (TAINTED_SCALAR)
>>>>      Passing tainted expression "((struct acpi_fadt *)hdr)->dsdt" to
> "list_fadt", which uses it as a loop boundary.
> 118                             list_fadt((struct acpi_fadt *)hdr, chksu=
ms);
> 119             }
> 120     }
> 121
> 122     static void list_rsdp(struct acpi_rsdp *rsdp, bool chksums)
> 123     {
> /cmd/acpi.c: 116 in list_rsdt()
> 110                             entry =3D xsdt->entry[i];
> 111                     else
> 112                             entry =3D rsdt->entry[i];
> 113                     if (!entry)
> 114                             break;
> 115                     hdr =3D nomap_sysmem(entry, 0);
>>>>      CID 550302:    (TAINTED_SCALAR)
>>>>      Passing tainted expression "hdr->length" to "dump_hdr", which us=
es
> it as a loop boundary.
> 116                     dump_hdr(hdr, chksums);
> 117                     if (!memcmp(hdr->signature, "FACP", ACPI_NAME_LE=
N))
> 118                             list_fadt((struct acpi_fadt *)hdr, chksu=
ms);
> 119             }
> 120     }
> 121
> /cmd/acpi.c: 95 in list_rsdt()
> 89      if (rsdp->rsdt_address) {
> 90              rsdt =3D nomap_sysmem(rsdp->rsdt_address, 0);
> 91              dump_hdr(&rsdt->header, chksums);
> 92      }
> 93      if (rsdp->xsdt_address) {
> 94              xsdt =3D nomap_sysmem(rsdp->xsdt_address, 0);
>>>>      CID 550302:    (TAINTED_SCALAR)
>>>>      Passing tainted expression "xsdt->header.length" to "dump_hdr",
> which uses it as a loop boundary.
> 95              dump_hdr(&xsdt->header, chksums);
> 96              len =3D xsdt->header.length - sizeof(xsdt->header);
> 97              count =3D len / sizeof(u64);
> 98      } else if (rsdp->rsdt_address) {
> 99              len =3D rsdt->header.length - sizeof(rsdt->header);
> 100                     count =3D len / sizeof(u32);
> /cmd/acpi.c: 118 in list_rsdt()
> 112                             entry =3D rsdt->entry[i];
> 113                     if (!entry)
> 114                             break;
> 115                     hdr =3D nomap_sysmem(entry, 0);
> 116                     dump_hdr(hdr, chksums);
> 117                     if (!memcmp(hdr->signature, "FACP", ACPI_NAME_LE=
N))
>>>>      CID 550302:    (TAINTED_SCALAR)
>>>>      Passing tainted expression "((struct acpi_fadt
> *)hdr)->x_firmware_ctrl" to "list_fadt", which uses it as a loop boundar=
y.
> 118                             list_fadt((struct acpi_fadt *)hdr, chksu=
ms);
> 119             }
> 120     }
> 121
> 122     static void list_rsdp(struct acpi_rsdp *rsdp, bool chksums)
> 123     {
>=20
> ** CID 550301:    (OVERRUN)
>=20
>=20
> ________________________________________________________________________=
________________________________
> *** CID 550301:    (OVERRUN)
> /lib/acpi/acpi_table.c: 199 in acpi_add_table()
> 193
> 194                     /* Fix RSDT length or the kernel will assume
> invalid entries */
> 195                     rsdt->header.length =3D sizeof(struct
> acpi_table_header) +
> 196                                             (sizeof(u32) * (i + 1));
> 197
> 198                     /* Re-calculate checksum */
>>>>      CID 550301:    (OVERRUN)
>>>>      Overrunning struct type acpi_table_header of 36 bytes by passing=
 it
> to a function which accesses it at byte offset 39 using argument
> "rsdt->header.length" (which evaluates to 40).
> 199                     acpi_update_checksum(&rsdt->header);
> 200             }
> 201
> 202             if (ctx->xsdt) {
> 203                     /*
> 204                      * And now the same thing for the XSDT. We use t=
he
> same index as for
> /lib/acpi/acpi_table.c: 230 in acpi_add_table()
> 224
> 225                     /* Fix XSDT length */
> 226                     xsdt->header.length =3D sizeof(struct
> acpi_table_header) +
> 227                                             (sizeof(u64) * (i + 1));
> 228
> 229                     /* Re-calculate checksum */
>>>>      CID 550301:    (OVERRUN)
>>>>      Overrunning struct type acpi_table_header of 36 bytes by passing=
 it
> to a function which accesses it at byte offset 43 using argument
> "xsdt->header.length" (which evaluates to 44).
> 230                     acpi_update_checksum(&xsdt->header);
> 231             }
> 232
> 233             return 0;
> 234     }
> 235
>=20
> ** CID 550300:  Integer handling issues  (INTEGER_OVERFLOW)
> /fs/exfat/utils.c: 146 in exfat_humanize_bytes()
>=20
>=20
> ________________________________________________________________________=
________________________________
> *** CID 550300:  Integer handling issues  (INTEGER_OVERFLOW)
> /fs/exfat/utils.c: 146 in exfat_humanize_bytes()
> 140             /* 16 EB (minus 1 byte) is the largest size that can be
> represented by
> 141                uint64_t */
> 142             const char* units[] =3D {"bytes", "KB", "MB", "GB", "TB"=
,
> "PB", "EB"};
> 143             uint64_t divisor =3D 1;
> 144             uint64_t temp =3D 0;
> 145
>>>>      CID 550300:  Integer handling issues  (INTEGER_OVERFLOW)
>>>>      Expression "divisor", overflows the type of "divisor", which is
> type "uint64_t".
> 146             for (i =3D 0; ; i++, divisor *=3D 1024)
> 147             {
> 148                     temp =3D (value + divisor / 2) / divisor;
> 149
> 150                     if (temp =3D=3D 0)
> 151                             break;
>=20
> ** CID 550299:  Null pointer dereferences  (FORWARD_NULL)
> /lib/efi_loader/efi_file.c: 251 in file_open()
>=20
>=20
> ________________________________________________________________________=
________________________________
> *** CID 550299:  Null pointer dereferences  (FORWARD_NULL)
> /lib/efi_loader/efi_file.c: 251 in file_open()
> 245                     strcpy(fh->path, "");
> 246             }
> 247
> 248             return &fh->base;
> 249
> 250     error:
>>>>      CID 550299:  Null pointer dereferences  (FORWARD_NULL)
>>>>      Dereferencing null pointer "fh".
> 251             free(fh->path);
> 252             free(fh);
> 253             return NULL;
> 254     }
> 255
> 256     efi_status_t efi_file_open_int(struct efi_file_handle *this,
>=20
> ** CID 550298:  Error handling issues  (CHECKED_RETURN)
> /lib/efi_loader/efi_net.c: 1054 in efi_netobj_get_dp()
>=20
>=20
> ________________________________________________________________________=
________________________________
> *** CID 550298:  Error handling issues  (CHECKED_RETURN)
> /lib/efi_loader/efi_net.c: 1054 in efi_netobj_get_dp()
> 1048            struct efi_handler *phandler;
> 1049
> 1050            if (!efi_netobj_is_active(netobj))
> 1051                    return NULL;
> 1052
> 1053            phandler =3D NULL;
>>>>      CID 550298:  Error handling issues  (CHECKED_RETURN)
>>>>      Calling "efi_search_protocol" without checking return value (as =
is
> done elsewhere 37 out of 42 times).
> 1054            efi_search_protocol(&netobj->header, &efi_guid_device_pa=
th,
> &phandler);
> 1055
> 1056            if (phandler && phandler->protocol_interface)
> 1057                    return efi_dp_dup(phandler->protocol_interface);
> 1058
> 1059            return NULL;
>=20
> ** CID 550297:  Integer handling issues  (INTEGER_OVERFLOW)
> /cmd/spawn.c: 174 in do_wait()
>=20
>=20
> ________________________________________________________________________=
________________________________
> *** CID 550297:  Integer handling issues  (INTEGER_OVERFLOW)
> /cmd/spawn.c: 174 in do_wait()
> 168                                     ret =3D wait_job(i);
> 169             } else {
> 170                     for (i =3D 1; i < argc; i++) {
> 171                             id =3D dectoul(argv[i], NULL);
> 172                             if (id < 0 || id >
> CONFIG_CMD_SPAWN_NUM_JOBS)
> 173                                     return CMD_RET_USAGE;
>>>>      CID 550297:  Integer handling issues  (INTEGER_OVERFLOW)
>>>>      Expression "idx", where "(int)id - 1" is known to be equal to -1=
,
> overflows the type of "idx", which is type "unsigned int".
> 174                             idx =3D (int)id - 1;
> 175                             ret =3D wait_job(idx);
> 176                     }
> 177             }
> 178
> 179             return ret;
>=20
> ** CID 550296:  Control flow issues  (NO_EFFECT)
> /cmd/spawn.c: 172 in do_wait()
>=20
>=20
> ________________________________________________________________________=
________________________________
> *** CID 550296:  Control flow issues  (NO_EFFECT)
> /cmd/spawn.c: 172 in do_wait()
> 166                     for (i =3D 0; i < CONFIG_CMD_SPAWN_NUM_JOBS; i++=
)
> 167                             if (job[i])
> 168                                     ret =3D wait_job(i);
> 169             } else {
> 170                     for (i =3D 1; i < argc; i++) {
> 171                             id =3D dectoul(argv[i], NULL);
>>>>      CID 550296:  Control flow issues  (NO_EFFECT)
>>>>      This less-than-zero comparison of an unsigned value is never tru=
e.
> "id < 0UL".
> 172                             if (id < 0 || id >
> CONFIG_CMD_SPAWN_NUM_JOBS)
> 173                                     return CMD_RET_USAGE;
> 174                             idx =3D (int)id - 1;
> 175                             ret =3D wait_job(idx);
> 176                     }
> 177             }
>=20
> ** CID 550295:  Insecure data handling  (TAINTED_SCALAR)
>=20
>=20
> ________________________________________________________________________=
________________________________
> *** CID 550295:  Insecure data handling  (TAINTED_SCALAR)
> /test/lib/membuf.c: 235 in lib_test_membuf_readline()
> 229                             *ptr =3D '\n';
> 230                     } else {
> 231                             ut_assert(membuf_free(&mb));
> 232                     }
> 233             }
> 234             membuf_dispose(&mb);
>>>>      CID 550295:  Insecure data handling  (TAINTED_SCALAR)
>>>>      Passing tainted expression "*buf" to "os_free", which uses it as=
 an
> offset.
> 235             os_free(buf);
> 236
> 237             return 0;
> 238     }
>=20
> ** CID 550294:  Code maintainability issues  (UNUSED_VALUE)
> /test/lib/membuf.c: 68 in lib_test_membuf_one()
>=20
>=20
> ________________________________________________________________________=
________________________________
> *** CID 550294:  Code maintainability issues  (UNUSED_VALUE)
> /test/lib/membuf.c: 68 in lib_test_membuf_one()
> 62              ut_assertok(membuf_check(uts, &mb, i));
> 63
> 64              ret =3D membuf_get(&mb, out, 0);
> 65              ret =3D membuf_get(&mb, out, size);
> 66              ut_asserteq(size, ret);
> 67
>>>>      CID 550294:  Code maintainability issues  (UNUSED_VALUE)
>>>>      Assigning value from "membuf_get(&mb, out, 0)" to "ret" here, bu=
t
> that stored value is overwritten before it can be used.
> 68              ret =3D membuf_get(&mb, out, 0);
> 69              ut_assertok(membuf_check(uts, &mb, i));
> 70
> 71              ut_asserteq_mem(in, out, size);
> 72      }
> 73
>=20
> ** CID 550293:  Memory - illegal accesses  (STRING_NULL)
> /test/lib/membuf.c: 224 in lib_test_membuf_readline()
>=20
>=20
> ________________________________________________________________________=
________________________________
> *** CID 550293:  Memory - illegal accesses  (STRING_NULL)
> /test/lib/membuf.c: 224 in lib_test_membuf_readline()
> 218                     ret =3D membuf_readline(&mb, str, 256, 0, true);
> 219                     ut_assertok(membuf_check(uts, &mb, i));
> 220                     if (ret) {
> 221                             char *ptr;
> 222
> 223                             s =3D &buf[cmpptr];
>>>>      CID 550293:  Memory - illegal accesses  (STRING_NULL)
>>>>      Passing unterminated string "s" to "strchr", which expects a
> null-terminated string. [Note: The source code implementation of the
> function has been overridden by a builtin model.]
> 224                             ptr =3D strchr(s, '\n');
> 225                             *ptr =3D '\0';
> 226
> 227                             ut_asserteq_str(s, str);
> 228                             cmpptr +=3D strlen(s) + 1;
> 229                             *ptr =3D '\n';
>=20
> ** CID 550292:    (BAD_SHIFT)
> /drivers/scsi/scsi.c: 165 in scsi_setup_erase_ext()
> /drivers/scsi/scsi.c: 166 in scsi_setup_erase_ext()
>=20
>=20
> ________________________________________________________________________=
________________________________
> *** CID 550292:    (BAD_SHIFT)
> /drivers/scsi/scsi.c: 165 in scsi_setup_erase_ext()
> 159             param[10] =3D 0x0;
> 160             param[11] =3D 0x0;
> 161             param[12] =3D (start >> 24) & 0xff;
> 162             param[13] =3D (start >> 16) & 0xff;
> 163             param[14] =3D (start >> 8) & 0xff;
> 164             param[15] =3D (start) & 0xff;
>>>>      CID 550292:    (BAD_SHIFT)
>>>>      In expression "blocks >> 24", right shifting "blocks" by more th=
an
> 15 bits always yields zero.  The shift amount is 24.
> 165             param[16] =3D (blocks >> 24) & 0xff;
> 166             param[17] =3D (blocks >> 16) & 0xff;
> 167             param[18] =3D (blocks >> 8) & 0xff;
> 168             param[19] =3D (blocks) & 0xff;
> 169
> 170             memset(pccb->cmd, 0, sizeof(pccb->cmd));
> /drivers/scsi/scsi.c: 166 in scsi_setup_erase_ext()
> 160             param[11] =3D 0x0;
> 161             param[12] =3D (start >> 24) & 0xff;
> 162             param[13] =3D (start >> 16) & 0xff;
> 163             param[14] =3D (start >> 8) & 0xff;
> 164             param[15] =3D (start) & 0xff;
> 165             param[16] =3D (blocks >> 24) & 0xff;
>>>>      CID 550292:    (BAD_SHIFT)
>>>>      In expression "blocks >> 16", right shifting "blocks" by more th=
an
> 15 bits always yields zero.  The shift amount is 16.
> 166             param[17] =3D (blocks >> 16) & 0xff;
> 167             param[18] =3D (blocks >> 8) & 0xff;
> 168             param[19] =3D (blocks) & 0xff;
> 169
> 170             memset(pccb->cmd, 0, sizeof(pccb->cmd));
> 171             pccb->cmd[0] =3D SCSI_UNMAP;
>=20
> ** CID 550291:  Memory - corruptions  (OVERRUN)
>=20
>=20
> ________________________________________________________________________=
________________________________
> *** CID 550291:  Memory - corruptions  (OVERRUN)
> /lib/acpi/acpi_table.c: 549 in acpi_write_spcr()
> 543              * to touch the configuration of the serial device.
> 544              */
> 545             if (serial_info.clock !=3D SERIAL_DEFAULT_CLOCK)
> 546                     spcr->baud_rate =3D 0;
> 547
> 548             /* Fix checksum */
>>>>      CID 550291:  Memory - corruptions  (OVERRUN)
>>>>      Overrunning struct type acpi_table_header of 36 bytes by passing=
 it
> to a function which accesses it at byte offset 79 using argument
> "header->length" (which evaluates to 80).
> 549             acpi_update_checksum(header);
> 550
> 551             acpi_add_table(ctx, spcr);
> 552             acpi_inc(ctx, spcr->header.length);
> 553
> 554             return 0;
>=20
> ** CID 550290:  Security best practices violations  (DC.WEAK_CRYPTO)
> /test/lib/membuf.c: 54 in lib_test_membuf_one()
>=20
>=20
> ________________________________________________________________________=
________________________________
> *** CID 550290:  Security best practices violations  (DC.WEAK_CRYPTO)
> /test/lib/membuf.c: 54 in lib_test_membuf_one()
> 48      }
> 49
> 50      test_size =3D TEST_SIZE;
> 51
> 52      for (i =3D 1; i < TEST_COUNT; i++) {
> 53              membuf_zero(&mb);
>>>>      CID 550290:  Security best practices violations  (DC.WEAK_CRYPTO=
)
>>>>      "rand" should not be used for security-related applications,
> because linear congruential algorithms are too easy to break.
> 54              size =3D rand() % test_size;
> 55
> 56              // now write patterns and check they come back OK
> 57              ret =3D membuf_put(&mb, in, 0);
> 58              ret =3D membuf_put(&mb, in, size);
> 59              ut_asserteq(size, ret);
>=20
> ** CID 550289:    (CONSTANT_EXPRESSION_RESULT)
> /drivers/scsi/scsi.c: 166 in scsi_setup_erase_ext()
> /drivers/scsi/scsi.c: 165 in scsi_setup_erase_ext()
>=20
>=20
> ________________________________________________________________________=
________________________________
> *** CID 550289:    (CONSTANT_EXPRESSION_RESULT)
> /drivers/scsi/scsi.c: 166 in scsi_setup_erase_ext()
> 160             param[11] =3D 0x0;
> 161             param[12] =3D (start >> 24) & 0xff;
> 162             param[13] =3D (start >> 16) & 0xff;
> 163             param[14] =3D (start >> 8) & 0xff;
> 164             param[15] =3D (start) & 0xff;
> 165             param[16] =3D (blocks >> 24) & 0xff;
>>>>      CID 550289:    (CONSTANT_EXPRESSION_RESULT)
>>>>      "blocks >> 16" is 0 regardless of the values of its operands. Th=
is
> occurs as the bitwise first operand of "&".
> 166             param[17] =3D (blocks >> 16) & 0xff;
> 167             param[18] =3D (blocks >> 8) & 0xff;
> 168             param[19] =3D (blocks) & 0xff;
> 169
> 170             memset(pccb->cmd, 0, sizeof(pccb->cmd));
> 171             pccb->cmd[0] =3D SCSI_UNMAP;
> /drivers/scsi/scsi.c: 165 in scsi_setup_erase_ext()
> 159             param[10] =3D 0x0;
> 160             param[11] =3D 0x0;
> 161             param[12] =3D (start >> 24) & 0xff;
> 162             param[13] =3D (start >> 16) & 0xff;
> 163             param[14] =3D (start >> 8) & 0xff;
> 164             param[15] =3D (start) & 0xff;
>>>>      CID 550289:    (CONSTANT_EXPRESSION_RESULT)
>>>>      "blocks >> 24" is 0 regardless of the values of its operands. Th=
is
> occurs as the bitwise first operand of "&".
> 165             param[16] =3D (blocks >> 24) & 0xff;
> 166             param[17] =3D (blocks >> 16) & 0xff;
> 167             param[18] =3D (blocks >> 8) & 0xff;
> 168             param[19] =3D (blocks) & 0xff;
> 169
> 170             memset(pccb->cmd, 0, sizeof(pccb->cmd));
>=20
> ** CID 550288:  Memory - corruptions  (OVERRUN)
>=20
>=20
> ________________________________________________________________________=
________________________________
> *** CID 550288:  Memory - corruptions  (OVERRUN)
> /lib/acpi/base.c: 53 in acpi_write_rsdt()
> 47      header->length =3D sizeof(struct acpi_rsdt);
> 48      header->revision =3D 1;
> 49
> 50      /* Entries are filled in later, we come with an empty set */
> 51
> 52      /* Fix checksum */
>>>>      CID 550288:  Memory - corruptions  (OVERRUN)
>>>>      Overrunning struct type acpi_table_header of 36 bytes by passing=
 it
> to a function which accesses it at byte offset 163 using argument
> "header->length" (which evaluates to 164).
> 53      acpi_update_checksum(header);
> 54     }
> 55
> 56     static void acpi_write_xsdt(struct acpi_xsdt *xsdt)
> 57     {
> 58      struct acpi_table_header *header =3D &xsdt->header;
>=20
> ** CID 550287:  Memory - corruptions  (OVERRUN)
>=20
>=20
> ________________________________________________________________________=
________________________________
> *** CID 550287:  Memory - corruptions  (OVERRUN)
> /lib/acpi/acpi_table.c: 268 in acpi_write_fadt()
> 262                     fadt->dsdt =3D fadt->x_dsdt;
> 263
> 264             fadt->preferred_pm_profile =3D ACPI_PM_UNSPECIFIED;
> 265
> 266             acpi_fill_fadt(fadt);
> 267
>>>>      CID 550287:  Memory - corruptions  (OVERRUN)
>>>>      Overrunning struct type acpi_table_header of 36 bytes by passing=
 it
> to a function which accesses it at byte offset 275 using argument
> "header->length" (which evaluates to 276).
> 268             acpi_update_checksum(header);
> 269
> 270             return acpi_add_fadt(ctx, fadt);
> 271     }
> 272
> 273     #ifndef CONFIG_QFW_ACPI
>=20
>=20
> ----- End forwarded message -----
>=20

