Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75FAC369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 21:59:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1625982153;
	Mon, 28 Apr 2025 23:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Vb4hueF2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BDFF82161; Mon, 28 Apr 2025 23:59:39 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76E5F82145
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 23:59:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2c769da02b0so4564710fac.3
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 14:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745877575; x=1746482375; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fosybnc8LRwRikyUlT7SV0ltc7dZPnM1Fgoz0iTLXCI=;
 b=Vb4hueF2QEPEZtgkwstbIrovpym96y4pSKUwUp6xa9iyCXiiZLwxL5StPpYy1xmI1c
 rfah8FfkC4F5Ohhih0nF5gJ0ec0rKLBs/LUh+iZIhB2R238J9fu7dQbTdocn5WiOzI/L
 mW8Mb1T7yxqhnMdMS+G7JgHt2YHy427C8/aXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745877575; x=1746482375;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fosybnc8LRwRikyUlT7SV0ltc7dZPnM1Fgoz0iTLXCI=;
 b=R52HGQ8EoIhtvuRJdMt4HQZakJMXaPpoqbAMzhhHs1ACEIwE9g5KpGvvlLydDD6CQi
 gpk6jYkNvtp+IlKWqp+oe5DQvjeD9Xn6qtFZlOWdcVRht6jF/VnA2lpCHupyFq8E69iZ
 OEheco6GKnDuhHpO3tRsuR9aLc3bTqXfEAGg/sR22UTuUKFtJTQnb7U0TpxgBdZVhfiv
 BJBMGBjn1w3QrS3l97cGMpon39LJHZEmqBU3exJBTPoCu6E7X3Tj69DVPoNinjArt3LR
 fqfullAxQ8IwxdP+YrhLrmjjZs/ux10W5FwvIuM3tn3jx6KpRGvxC7hTL1MdkPQTv7mx
 pPxg==
X-Gm-Message-State: AOJu0YylGNBKN3H5dsLieSSLrHZVXDT3Cp/r02ECQmC3KjmdknChVPsQ
 0ok40Nk3AECpAGXCY+ZPSgXwc0NYYfcWQLif1eg2PR7iyzq5e9bKtN3f72sNfPdC4iqYufPCrXU
 D
X-Gm-Gg: ASbGncuYKA6PViDQiknctDgdiuPrxNk3zFNL3eFjuAcc96QniINZ/wzqXbWbwQgfEnZ
 xF5JjpAtW6QlHdxdkHUCbnQQZ6SazgJk8IIQPimMGzj024XSK18ux9BjXr2pQUqdVDwNGp2sJRl
 PFHNuwSAYxy3vCSXMTvBGuUky4HwAS3J51V/mGEio6oOSwABhFwRCAHKk767lLcp3AkER4uXDHK
 Hrvqq0sCxPAHjn4y2ulp74Uo7n7vJaLa2p8rKmlNY0BNwbDzwrunwRFr7ap/YF1+kEnNI4FDCuj
 XoATXverUKRN6emThV6UmZ9fI3K0PklNmAKxiKQBGb/sxI757FiImCvekZQo+pnPiMrOonZU3Xk
 fCw==
X-Google-Smtp-Source: AGHT+IGEZa7KpNpJg0kOQk5BKmlaI8mh6jhwHXK8GuPqqaX3xksS3nCIppjjdjsaXoc57E4TjcEmHw==
X-Received: by 2002:a05:6871:2b17:b0:2b8:f595:2374 with SMTP id
 586e51a60fabf-2da4028ee0dmr840127fac.36.1745877575053; 
 Mon, 28 Apr 2025 14:59:35 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d973b7d828sm2518907fac.38.2025.04.28.14.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 14:59:33 -0700 (PDT)
Date: Mon, 28 Apr 2025 15:59:30 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Casey Connolly <casey.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20250428215930.GI5495@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M0wRaDSR0C64hdsh"
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


--M0wRaDSR0C64hdsh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

Here's the latest set of Coverity defects. Please let me know if some of
these are false positives for example, thanks.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Mon, Apr 28, 2025 at 3:52=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to Das U-Boot
found with Coverity Scan.

33 new defect(s) introduced to Das U-Boot found with Coverity Scan.
15 defect(s), reported by Coverity Scan earlier, were marked fixed in the
recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 33 defect(s)


** CID 550306:  Control flow issues  (DEADCODE)
/fs/exfat/io.c: 547 in exfat_generic_pwrite()


___________________________________________________________________________=
_____________________________
*** CID 550306:  Control flow issues  (DEADCODE)
/fs/exfat/io.c: 547 in exfat_generic_pwrite()
541             int rc;
542             cluster_t cluster;
543             const char* bufp =3D buffer;
544             off_t lsize, loffset, remainder;
545
546             if (offset < 0)
>>>     CID 550306:  Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "return -22L;".
547                     return -EINVAL;
548             if (uoffset > node->size)
549             {
550                     rc =3D exfat_truncate(ef, node, uoffset, true);
551                     if (rc !=3D 0)
552                             return rc;

** CID 550305:  Security best practices violations  (STRING_OVERFLOW)
/fs/exfat/io.c: 739 in exfat_fs_opendir()


___________________________________________________________________________=
_____________________________
*** CID 550305:  Security best practices violations  (STRING_OVERFLOW)
/fs/exfat/io.c: 739 in exfat_fs_opendir()
733                     return err;
734
735             dirs =3D calloc(1, sizeof(*dirs));
736             if (!dirs)
737                     return -ENOMEM;
738
>>>     CID 550305:  Security best practices violations  (STRING_OVERFLOW)
>>>     You might overrun the 1024-character fixed-size string
"dirs->dirname" by copying "filename" without checking the length.
739             strcpy(dirs->dirname, filename);
740             dirs->offset =3D -1;
741
742             *dirsp =3D &dirs->fs_dirs;
743
744             return 0;

** CID 550304:  Error handling issues  (NEGATIVE_RETURNS)
/tools/fit_check_sign.c: 98 in main()


___________________________________________________________________________=
_____________________________
*** CID 550304:  Error handling issues  (NEGATIVE_RETURNS)
/tools/fit_check_sign.c: 98 in main()
92      (void) munmap((void *)fit_blob, fsbuf.st_size);
93
94      if (key_blob)
95              (void)munmap((void *)key_blob, ksbuf.st_size);
96
97      close(ffd);
>>>     CID 550304:  Error handling issues  (NEGATIVE_RETURNS)
>>>     "kfd" is passed to a parameter that cannot be negative.
98      close(kfd);
99      exit(ret);

** CID 550303:  Control flow issues  (NO_EFFECT)
/tools/preload_check_sign.c: 132 in main()


___________________________________________________________________________=
_____________________________
*** CID 550303:  Control flow issues  (NO_EFFECT)
/tools/preload_check_sign.c: 132 in main()
126
127             info.algo_name =3D algo;
128             info.padding_name =3D padding;
129             info.key =3D (uint8_t *)pkey;
130             info.mandatory =3D 1;
131             info.sig_size =3D EVP_PKEY_size(pkey);
>>>     CID 550303:  Control flow issues  (NO_EFFECT)
>>>     This less-than-zero comparison of an unsigned value is never true.
"info.sig_size < 0U".
132             if (info.sig_size < 0) {
133                     fprintf(stderr, "Fail to retrieve the signature
size: %s\n",
134                             ERR_error_string(ERR_get_error(), NULL));
135                     ret =3D EXIT_FAILURE;
136                     goto out;
137             }

** CID 550302:    (TAINTED_SCALAR)


___________________________________________________________________________=
_____________________________
*** CID 550302:    (TAINTED_SCALAR)
/cmd/acpi.c: 118 in list_rsdt()
112                             entry =3D rsdt->entry[i];
113                     if (!entry)
114                             break;
115                     hdr =3D nomap_sysmem(entry, 0);
116                     dump_hdr(hdr, chksums);
117                     if (!memcmp(hdr->signature, "FACP", ACPI_NAME_LEN))
>>>     CID 550302:    (TAINTED_SCALAR)
>>>     Passing tainted expression "((struct acpi_fadt
*)hdr)->firmware_ctrl" to "list_fadt", which uses it as a loop boundary.
118                             list_fadt((struct acpi_fadt *)hdr, chksums);
119             }
120     }
121
122     static void list_rsdp(struct acpi_rsdp *rsdp, bool chksums)
123     {
/cmd/acpi.c: 118 in list_rsdt()
112                             entry =3D rsdt->entry[i];
113                     if (!entry)
114                             break;
115                     hdr =3D nomap_sysmem(entry, 0);
116                     dump_hdr(hdr, chksums);
117                     if (!memcmp(hdr->signature, "FACP", ACPI_NAME_LEN))
>>>     CID 550302:    (TAINTED_SCALAR)
>>>     Passing tainted expression "((struct acpi_fadt *)hdr)->x_dsdt" to
"list_fadt", which uses it as a loop boundary.
118                             list_fadt((struct acpi_fadt *)hdr, chksums);
119             }
120     }
121
122     static void list_rsdp(struct acpi_rsdp *rsdp, bool chksums)
123     {
/cmd/acpi.c: 118 in list_rsdt()
112                             entry =3D rsdt->entry[i];
113                     if (!entry)
114                             break;
115                     hdr =3D nomap_sysmem(entry, 0);
116                     dump_hdr(hdr, chksums);
117                     if (!memcmp(hdr->signature, "FACP", ACPI_NAME_LEN))
>>>     CID 550302:    (TAINTED_SCALAR)
>>>     Passing tainted expression "((struct acpi_fadt *)hdr)->dsdt" to
"list_fadt", which uses it as a loop boundary.
118                             list_fadt((struct acpi_fadt *)hdr, chksums);
119             }
120     }
121
122     static void list_rsdp(struct acpi_rsdp *rsdp, bool chksums)
123     {
/cmd/acpi.c: 116 in list_rsdt()
110                             entry =3D xsdt->entry[i];
111                     else
112                             entry =3D rsdt->entry[i];
113                     if (!entry)
114                             break;
115                     hdr =3D nomap_sysmem(entry, 0);
>>>     CID 550302:    (TAINTED_SCALAR)
>>>     Passing tainted expression "hdr->length" to "dump_hdr", which uses
it as a loop boundary.
116                     dump_hdr(hdr, chksums);
117                     if (!memcmp(hdr->signature, "FACP", ACPI_NAME_LEN))
118                             list_fadt((struct acpi_fadt *)hdr, chksums);
119             }
120     }
121
/cmd/acpi.c: 95 in list_rsdt()
89      if (rsdp->rsdt_address) {
90              rsdt =3D nomap_sysmem(rsdp->rsdt_address, 0);
91              dump_hdr(&rsdt->header, chksums);
92      }
93      if (rsdp->xsdt_address) {
94              xsdt =3D nomap_sysmem(rsdp->xsdt_address, 0);
>>>     CID 550302:    (TAINTED_SCALAR)
>>>     Passing tainted expression "xsdt->header.length" to "dump_hdr",
which uses it as a loop boundary.
95              dump_hdr(&xsdt->header, chksums);
96              len =3D xsdt->header.length - sizeof(xsdt->header);
97              count =3D len / sizeof(u64);
98      } else if (rsdp->rsdt_address) {
99              len =3D rsdt->header.length - sizeof(rsdt->header);
100                     count =3D len / sizeof(u32);
/cmd/acpi.c: 118 in list_rsdt()
112                             entry =3D rsdt->entry[i];
113                     if (!entry)
114                             break;
115                     hdr =3D nomap_sysmem(entry, 0);
116                     dump_hdr(hdr, chksums);
117                     if (!memcmp(hdr->signature, "FACP", ACPI_NAME_LEN))
>>>     CID 550302:    (TAINTED_SCALAR)
>>>     Passing tainted expression "((struct acpi_fadt
*)hdr)->x_firmware_ctrl" to "list_fadt", which uses it as a loop boundary.
118                             list_fadt((struct acpi_fadt *)hdr, chksums);
119             }
120     }
121
122     static void list_rsdp(struct acpi_rsdp *rsdp, bool chksums)
123     {

** CID 550301:    (OVERRUN)


___________________________________________________________________________=
_____________________________
*** CID 550301:    (OVERRUN)
/lib/acpi/acpi_table.c: 199 in acpi_add_table()
193
194                     /* Fix RSDT length or the kernel will assume
invalid entries */
195                     rsdt->header.length =3D sizeof(struct
acpi_table_header) +
196                                             (sizeof(u32) * (i + 1));
197
198                     /* Re-calculate checksum */
>>>     CID 550301:    (OVERRUN)
>>>     Overrunning struct type acpi_table_header of 36 bytes by passing it
to a function which accesses it at byte offset 39 using argument
"rsdt->header.length" (which evaluates to 40).
199                     acpi_update_checksum(&rsdt->header);
200             }
201
202             if (ctx->xsdt) {
203                     /*
204                      * And now the same thing for the XSDT. We use the
same index as for
/lib/acpi/acpi_table.c: 230 in acpi_add_table()
224
225                     /* Fix XSDT length */
226                     xsdt->header.length =3D sizeof(struct
acpi_table_header) +
227                                             (sizeof(u64) * (i + 1));
228
229                     /* Re-calculate checksum */
>>>     CID 550301:    (OVERRUN)
>>>     Overrunning struct type acpi_table_header of 36 bytes by passing it
to a function which accesses it at byte offset 43 using argument
"xsdt->header.length" (which evaluates to 44).
230                     acpi_update_checksum(&xsdt->header);
231             }
232
233             return 0;
234     }
235

** CID 550300:  Integer handling issues  (INTEGER_OVERFLOW)
/fs/exfat/utils.c: 146 in exfat_humanize_bytes()


___________________________________________________________________________=
_____________________________
*** CID 550300:  Integer handling issues  (INTEGER_OVERFLOW)
/fs/exfat/utils.c: 146 in exfat_humanize_bytes()
140             /* 16 EB (minus 1 byte) is the largest size that can be
represented by
141                uint64_t */
142             const char* units[] =3D {"bytes", "KB", "MB", "GB", "TB",
"PB", "EB"};
143             uint64_t divisor =3D 1;
144             uint64_t temp =3D 0;
145
>>>     CID 550300:  Integer handling issues  (INTEGER_OVERFLOW)
>>>     Expression "divisor", overflows the type of "divisor", which is
type "uint64_t".
146             for (i =3D 0; ; i++, divisor *=3D 1024)
147             {
148                     temp =3D (value + divisor / 2) / divisor;
149
150                     if (temp =3D=3D 0)
151                             break;

** CID 550299:  Null pointer dereferences  (FORWARD_NULL)
/lib/efi_loader/efi_file.c: 251 in file_open()


___________________________________________________________________________=
_____________________________
*** CID 550299:  Null pointer dereferences  (FORWARD_NULL)
/lib/efi_loader/efi_file.c: 251 in file_open()
245                     strcpy(fh->path, "");
246             }
247
248             return &fh->base;
249
250     error:
>>>     CID 550299:  Null pointer dereferences  (FORWARD_NULL)
>>>     Dereferencing null pointer "fh".
251             free(fh->path);
252             free(fh);
253             return NULL;
254     }
255
256     efi_status_t efi_file_open_int(struct efi_file_handle *this,

** CID 550298:  Error handling issues  (CHECKED_RETURN)
/lib/efi_loader/efi_net.c: 1054 in efi_netobj_get_dp()


___________________________________________________________________________=
_____________________________
*** CID 550298:  Error handling issues  (CHECKED_RETURN)
/lib/efi_loader/efi_net.c: 1054 in efi_netobj_get_dp()
1048            struct efi_handler *phandler;
1049
1050            if (!efi_netobj_is_active(netobj))
1051                    return NULL;
1052
1053            phandler =3D NULL;
>>>     CID 550298:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "efi_search_protocol" without checking return value (as is
done elsewhere 37 out of 42 times).
1054            efi_search_protocol(&netobj->header, &efi_guid_device_path,
&phandler);
1055
1056            if (phandler && phandler->protocol_interface)
1057                    return efi_dp_dup(phandler->protocol_interface);
1058
1059            return NULL;

** CID 550297:  Integer handling issues  (INTEGER_OVERFLOW)
/cmd/spawn.c: 174 in do_wait()


___________________________________________________________________________=
_____________________________
*** CID 550297:  Integer handling issues  (INTEGER_OVERFLOW)
/cmd/spawn.c: 174 in do_wait()
168                                     ret =3D wait_job(i);
169             } else {
170                     for (i =3D 1; i < argc; i++) {
171                             id =3D dectoul(argv[i], NULL);
172                             if (id < 0 || id >
CONFIG_CMD_SPAWN_NUM_JOBS)
173                                     return CMD_RET_USAGE;
>>>     CID 550297:  Integer handling issues  (INTEGER_OVERFLOW)
>>>     Expression "idx", where "(int)id - 1" is known to be equal to -1,
overflows the type of "idx", which is type "unsigned int".
174                             idx =3D (int)id - 1;
175                             ret =3D wait_job(idx);
176                     }
177             }
178
179             return ret;

** CID 550296:  Control flow issues  (NO_EFFECT)
/cmd/spawn.c: 172 in do_wait()


___________________________________________________________________________=
_____________________________
*** CID 550296:  Control flow issues  (NO_EFFECT)
/cmd/spawn.c: 172 in do_wait()
166                     for (i =3D 0; i < CONFIG_CMD_SPAWN_NUM_JOBS; i++)
167                             if (job[i])
168                                     ret =3D wait_job(i);
169             } else {
170                     for (i =3D 1; i < argc; i++) {
171                             id =3D dectoul(argv[i], NULL);
>>>     CID 550296:  Control flow issues  (NO_EFFECT)
>>>     This less-than-zero comparison of an unsigned value is never true.
"id < 0UL".
172                             if (id < 0 || id >
CONFIG_CMD_SPAWN_NUM_JOBS)
173                                     return CMD_RET_USAGE;
174                             idx =3D (int)id - 1;
175                             ret =3D wait_job(idx);
176                     }
177             }

** CID 550295:  Insecure data handling  (TAINTED_SCALAR)


___________________________________________________________________________=
_____________________________
*** CID 550295:  Insecure data handling  (TAINTED_SCALAR)
/test/lib/membuf.c: 235 in lib_test_membuf_readline()
229                             *ptr =3D '\n';
230                     } else {
231                             ut_assert(membuf_free(&mb));
232                     }
233             }
234             membuf_dispose(&mb);
>>>     CID 550295:  Insecure data handling  (TAINTED_SCALAR)
>>>     Passing tainted expression "*buf" to "os_free", which uses it as an
offset.
235             os_free(buf);
236
237             return 0;
238     }

** CID 550294:  Code maintainability issues  (UNUSED_VALUE)
/test/lib/membuf.c: 68 in lib_test_membuf_one()


___________________________________________________________________________=
_____________________________
*** CID 550294:  Code maintainability issues  (UNUSED_VALUE)
/test/lib/membuf.c: 68 in lib_test_membuf_one()
62              ut_assertok(membuf_check(uts, &mb, i));
63
64              ret =3D membuf_get(&mb, out, 0);
65              ret =3D membuf_get(&mb, out, size);
66              ut_asserteq(size, ret);
67
>>>     CID 550294:  Code maintainability issues  (UNUSED_VALUE)
>>>     Assigning value from "membuf_get(&mb, out, 0)" to "ret" here, but
that stored value is overwritten before it can be used.
68              ret =3D membuf_get(&mb, out, 0);
69              ut_assertok(membuf_check(uts, &mb, i));
70
71              ut_asserteq_mem(in, out, size);
72      }
73

** CID 550293:  Memory - illegal accesses  (STRING_NULL)
/test/lib/membuf.c: 224 in lib_test_membuf_readline()


___________________________________________________________________________=
_____________________________
*** CID 550293:  Memory - illegal accesses  (STRING_NULL)
/test/lib/membuf.c: 224 in lib_test_membuf_readline()
218                     ret =3D membuf_readline(&mb, str, 256, 0, true);
219                     ut_assertok(membuf_check(uts, &mb, i));
220                     if (ret) {
221                             char *ptr;
222
223                             s =3D &buf[cmpptr];
>>>     CID 550293:  Memory - illegal accesses  (STRING_NULL)
>>>     Passing unterminated string "s" to "strchr", which expects a
null-terminated string. [Note: The source code implementation of the
function has been overridden by a builtin model.]
224                             ptr =3D strchr(s, '\n');
225                             *ptr =3D '\0';
226
227                             ut_asserteq_str(s, str);
228                             cmpptr +=3D strlen(s) + 1;
229                             *ptr =3D '\n';

** CID 550292:    (BAD_SHIFT)
/drivers/scsi/scsi.c: 165 in scsi_setup_erase_ext()
/drivers/scsi/scsi.c: 166 in scsi_setup_erase_ext()


___________________________________________________________________________=
_____________________________
*** CID 550292:    (BAD_SHIFT)
/drivers/scsi/scsi.c: 165 in scsi_setup_erase_ext()
159             param[10] =3D 0x0;
160             param[11] =3D 0x0;
161             param[12] =3D (start >> 24) & 0xff;
162             param[13] =3D (start >> 16) & 0xff;
163             param[14] =3D (start >> 8) & 0xff;
164             param[15] =3D (start) & 0xff;
>>>     CID 550292:    (BAD_SHIFT)
>>>     In expression "blocks >> 24", right shifting "blocks" by more than
15 bits always yields zero.  The shift amount is 24.
165             param[16] =3D (blocks >> 24) & 0xff;
166             param[17] =3D (blocks >> 16) & 0xff;
167             param[18] =3D (blocks >> 8) & 0xff;
168             param[19] =3D (blocks) & 0xff;
169
170             memset(pccb->cmd, 0, sizeof(pccb->cmd));
/drivers/scsi/scsi.c: 166 in scsi_setup_erase_ext()
160             param[11] =3D 0x0;
161             param[12] =3D (start >> 24) & 0xff;
162             param[13] =3D (start >> 16) & 0xff;
163             param[14] =3D (start >> 8) & 0xff;
164             param[15] =3D (start) & 0xff;
165             param[16] =3D (blocks >> 24) & 0xff;
>>>     CID 550292:    (BAD_SHIFT)
>>>     In expression "blocks >> 16", right shifting "blocks" by more than
15 bits always yields zero.  The shift amount is 16.
166             param[17] =3D (blocks >> 16) & 0xff;
167             param[18] =3D (blocks >> 8) & 0xff;
168             param[19] =3D (blocks) & 0xff;
169
170             memset(pccb->cmd, 0, sizeof(pccb->cmd));
171             pccb->cmd[0] =3D SCSI_UNMAP;

** CID 550291:  Memory - corruptions  (OVERRUN)


___________________________________________________________________________=
_____________________________
*** CID 550291:  Memory - corruptions  (OVERRUN)
/lib/acpi/acpi_table.c: 549 in acpi_write_spcr()
543              * to touch the configuration of the serial device.
544              */
545             if (serial_info.clock !=3D SERIAL_DEFAULT_CLOCK)
546                     spcr->baud_rate =3D 0;
547
548             /* Fix checksum */
>>>     CID 550291:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type acpi_table_header of 36 bytes by passing it
to a function which accesses it at byte offset 79 using argument
"header->length" (which evaluates to 80).
549             acpi_update_checksum(header);
550
551             acpi_add_table(ctx, spcr);
552             acpi_inc(ctx, spcr->header.length);
553
554             return 0;

** CID 550290:  Security best practices violations  (DC.WEAK_CRYPTO)
/test/lib/membuf.c: 54 in lib_test_membuf_one()


___________________________________________________________________________=
_____________________________
*** CID 550290:  Security best practices violations  (DC.WEAK_CRYPTO)
/test/lib/membuf.c: 54 in lib_test_membuf_one()
48      }
49
50      test_size =3D TEST_SIZE;
51
52      for (i =3D 1; i < TEST_COUNT; i++) {
53              membuf_zero(&mb);
>>>     CID 550290:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security-related applications,
because linear congruential algorithms are too easy to break.
54              size =3D rand() % test_size;
55
56              // now write patterns and check they come back OK
57              ret =3D membuf_put(&mb, in, 0);
58              ret =3D membuf_put(&mb, in, size);
59              ut_asserteq(size, ret);

** CID 550289:    (CONSTANT_EXPRESSION_RESULT)
/drivers/scsi/scsi.c: 166 in scsi_setup_erase_ext()
/drivers/scsi/scsi.c: 165 in scsi_setup_erase_ext()


___________________________________________________________________________=
_____________________________
*** CID 550289:    (CONSTANT_EXPRESSION_RESULT)
/drivers/scsi/scsi.c: 166 in scsi_setup_erase_ext()
160             param[11] =3D 0x0;
161             param[12] =3D (start >> 24) & 0xff;
162             param[13] =3D (start >> 16) & 0xff;
163             param[14] =3D (start >> 8) & 0xff;
164             param[15] =3D (start) & 0xff;
165             param[16] =3D (blocks >> 24) & 0xff;
>>>     CID 550289:    (CONSTANT_EXPRESSION_RESULT)
>>>     "blocks >> 16" is 0 regardless of the values of its operands. This
occurs as the bitwise first operand of "&".
166             param[17] =3D (blocks >> 16) & 0xff;
167             param[18] =3D (blocks >> 8) & 0xff;
168             param[19] =3D (blocks) & 0xff;
169
170             memset(pccb->cmd, 0, sizeof(pccb->cmd));
171             pccb->cmd[0] =3D SCSI_UNMAP;
/drivers/scsi/scsi.c: 165 in scsi_setup_erase_ext()
159             param[10] =3D 0x0;
160             param[11] =3D 0x0;
161             param[12] =3D (start >> 24) & 0xff;
162             param[13] =3D (start >> 16) & 0xff;
163             param[14] =3D (start >> 8) & 0xff;
164             param[15] =3D (start) & 0xff;
>>>     CID 550289:    (CONSTANT_EXPRESSION_RESULT)
>>>     "blocks >> 24" is 0 regardless of the values of its operands. This
occurs as the bitwise first operand of "&".
165             param[16] =3D (blocks >> 24) & 0xff;
166             param[17] =3D (blocks >> 16) & 0xff;
167             param[18] =3D (blocks >> 8) & 0xff;
168             param[19] =3D (blocks) & 0xff;
169
170             memset(pccb->cmd, 0, sizeof(pccb->cmd));

** CID 550288:  Memory - corruptions  (OVERRUN)


___________________________________________________________________________=
_____________________________
*** CID 550288:  Memory - corruptions  (OVERRUN)
/lib/acpi/base.c: 53 in acpi_write_rsdt()
47      header->length =3D sizeof(struct acpi_rsdt);
48      header->revision =3D 1;
49
50      /* Entries are filled in later, we come with an empty set */
51
52      /* Fix checksum */
>>>     CID 550288:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type acpi_table_header of 36 bytes by passing it
to a function which accesses it at byte offset 163 using argument
"header->length" (which evaluates to 164).
53      acpi_update_checksum(header);
54     }
55
56     static void acpi_write_xsdt(struct acpi_xsdt *xsdt)
57     {
58      struct acpi_table_header *header =3D &xsdt->header;

** CID 550287:  Memory - corruptions  (OVERRUN)


___________________________________________________________________________=
_____________________________
*** CID 550287:  Memory - corruptions  (OVERRUN)
/lib/acpi/acpi_table.c: 268 in acpi_write_fadt()
262                     fadt->dsdt =3D fadt->x_dsdt;
263
264             fadt->preferred_pm_profile =3D ACPI_PM_UNSPECIFIED;
265
266             acpi_fill_fadt(fadt);
267
>>>     CID 550287:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type acpi_table_header of 36 bytes by passing it
to a function which accesses it at byte offset 275 using argument
"header->length" (which evaluates to 276).
268             acpi_update_checksum(header);
269
270             return acpi_add_fadt(ctx, fadt);
271     }
272
273     #ifndef CONFIG_QFW_ACPI


----- End forwarded message -----

--=20
Tom

--M0wRaDSR0C64hdsh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgP+j4ACgkQFHw5/5Y0
tyzBEAv9HhtgywzzIxPdCQ6IEfy1+FZmmKwMN+se3SN1x617UuHC/F2eJm/earEj
CUZ74+AX3gAr7WcqfDT6NwPfH/M93RHArmt15gRfwXj/ZCSNcJTpRS0l6ezJLdP4
os9FOeE4I++xk/eyZvepvDXv0Hg/kw/RbLT9cC1pMt/X4Hnls/p6XuDGff4J9KrE
mvf6qQZdPrAYKJwTtgkLBI8XbOxaWQztYfXCp79vk63TQbRKNPObEpBe5qLrdE+6
wKL56AZoqXqvchxxlyiFfoc68zjsOlG0aefFqNNfEK1EdPx7fp5th2asWfOE9RWr
xGeatmgeZZXEDhvAYCNpbXuKlU240O4zrh5/idObo+3N8ntNDEkeIYvK6MFhzKCH
h4I17QV79/l1l09+YjCrBXGfz+XwrUmK6mRN/N9p+8rceTwf5NzgsuIsXAV8+zB1
h7TmKUqbKxT5KlGy4x3NDTf+Sf/J//CUv16IjPvrUtjgYbapXR90a1fvXVpnFbrC
eQExwga0
=pBVn
-----END PGP SIGNATURE-----

--M0wRaDSR0C64hdsh--
