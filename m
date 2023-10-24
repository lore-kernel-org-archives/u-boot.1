Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6379DC00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 01:18:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D65C876CC;
	Tue, 24 Oct 2023 03:18:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ebG7+ODo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B20D8770C; Tue, 24 Oct 2023 03:18:35 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 170BC86FED
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 03:18:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5a7af45084eso38059987b3.0
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 18:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698110311; x=1698715111; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BKogar2pMYmigmwpicwp5WFzd6E/ViiaJAB7ZvJcqvk=;
 b=ebG7+ODoW/94PO1muyoCporjv8r0Ls7/sI2kUr14v3gfe+kvXcaZtPlH3Zvo+nylqz
 9ssItvwaudK9huINpslYExplB6h9JuFwlOZFbwjja/2CteRc+i8GHq5uvK6n5954mwME
 8Lom0PPhtXQRn13m1E+gNI8G6BVzclGGvBn2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698110311; x=1698715111;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BKogar2pMYmigmwpicwp5WFzd6E/ViiaJAB7ZvJcqvk=;
 b=cY1L96qajQjZZkn1OEAc3XjaPK6VtMejzRMcCy6ICCzMDDlTGQced+Ay0Cg0OcpkAp
 fSDADCjYqJeOq5j7dNehWa3r0OJT5ZoIaXqCzSaO7HvLTsbZGiTvkIJAiQ7j161a9I+i
 Dy/CCTt/2kztEfYueasf8f9EeE0U5ezL4TPuZzvpRoo47B5xnXNCO3zu4z//KA1IVRD9
 cfCGK4tDzYfxgt+TqbMb3R0OPSF5+HsO4YKz0inxolq+wA7ZgGPtI00CgBpG+iq9cMpG
 MrVsnvR5DeV52evuIvvaTZsQ8c93f/7caQYDlQKaAldcamSq2C6Qpv905gytYuQQwp7c
 ncOg==
X-Gm-Message-State: AOJu0Yws+3cT3LysFYvuKGoJlEFfM2VCqN0Wj4h7Mzav84iEYQKIaVRr
 SpWGdQV36Ip+fQd3Yr8rrTHKFnidgMP9MJgieSqHBg==
X-Google-Smtp-Source: AGHT+IF8489O+9xeBA3VMh1H818Oj8hLC00IdH2MlmKZ5yZycnu6Ev/IeTH6CHR4C3IXRhyE9Pxpsw==
X-Received: by 2002:a81:a091:0:b0:5a7:d9ce:363c with SMTP id
 x139-20020a81a091000000b005a7d9ce363cmr10258044ywg.6.1698110311285; 
 Mon, 23 Oct 2023 18:18:31 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-c6de-498a-c903-1c13.res6.spectrum.com.
 [2603:6081:7b00:6400:c6de:498a:c903:1c13])
 by smtp.gmail.com with ESMTPSA id
 p130-20020a815b88000000b0059b20231f1dsm3617882ywb.121.2023.10.23.18.18.30
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 18:18:30 -0700 (PDT)
Date: Mon, 23 Oct 2023 21:18:28 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [tom.rini@gmail.com: Fwd: New Defects reported by Coverity Scan for
 Das U-Boot]
Message-ID: <20231024011828.GY496310@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GyPsfJMBoDBAI3Vx"
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


--GyPsfJMBoDBAI3Vx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's the latest report

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Mon, Oct 23, 2023 at 4:40=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to Das
U-Boot found with Coverity Scan.

16 new defect(s) introduced to Das U-Boot found with Coverity Scan.
6 defect(s), reported by Coverity Scan earlier, were marked fixed in
the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 16 of 16 defect(s)


** CID 467060:    (TAINTED_SCALAR)


___________________________________________________________________________=
_____________________________
*** CID 467060:    (TAINTED_SCALAR)
/boot/bootmeth_cros.c: 184 in scan_part()
178             if (ret !=3D num_blks) {
179                     free(hdr);
180                     return log_msg_ret("inf", -EIO);
181             }
182
183             if (memcmp(VB2_KEYBLOCK_MAGIC, hdr->magic,
VB2_KEYBLOCK_MAGIC_SIZE)) {
>>>     CID 467060:    (TAINTED_SCALAR)
>>>     Passing tainted expression "*hdr" to "dlfree", which uses it as an =
offset.
184                     free(hdr);
185                     log_debug("no magic\n");
186                     return -ENOENT;
187             }
188
189             *hdrp =3D hdr;
/boot/bootmeth_cros.c: 179 in scan_part()
173                       blk->name, (ulong)info->start, num_blks);
174             hdr =3D memalign(SZ_1K, PROBE_SIZE);
175             if (!hdr)
176                     return log_msg_ret("hdr", -ENOMEM);
177             ret =3D blk_read(blk, info->start, num_blks, hdr);
178             if (ret !=3D num_blks) {
>>>     CID 467060:    (TAINTED_SCALAR)
>>>     Passing tainted expression "*hdr" to "dlfree", which uses it as an =
offset.
179                     free(hdr);
180                     return log_msg_ret("inf", -EIO);
181             }
182
183             if (memcmp(VB2_KEYBLOCK_MAGIC, hdr->magic,
VB2_KEYBLOCK_MAGIC_SIZE)) {
184                     free(hdr);

** CID 467059:  Integer handling issues  (INCOMPATIBLE_CAST)


___________________________________________________________________________=
_____________________________
*** CID 467059:  Integer handling issues  (INCOMPATIBLE_CAST)
/drivers/mtd/nvmxip/nvmxip_qspi.c: 47 in nvmxip_qspi_of_to_plat()
41      ret =3D dev_read_u32(dev, "lba_shift", &plat->lba_shift);
42      if (ret) {
43              log_err("[%s]: can not get lba_shift from device
tree\n", dev->name);
44              return -EINVAL;
45      }
46
>>>     CID 467059:  Integer handling issues  (INCOMPATIBLE_CAST)
>>>     Pointer "&plat->lba" points to an object whose effective type is "u=
nsigned long" (64 bits, unsigned) but is dereferenced as a narrower "unsign=
ed int" (32 bits, unsigned). This may lead to unexpected results depending =
on machine endianness.
47      ret =3D dev_read_u32(dev, "lba", (u32 *)&plat->lba);
48      if (ret) {
49              log_err("[%s]: can not get lba from device tree\n", dev->na=
me);
50              return -EINVAL;
51      }
52

** CID 467058:  Insecure data handling  (TAINTED_SCALAR)


___________________________________________________________________________=
_____________________________
*** CID 467058:  Insecure data handling  (TAINTED_SCALAR)
/drivers/core/ofnode.c: 1629 in ofnode_write_u32()
1623            log_debug("%s =3D %x", propname, value);
1624            val =3D malloc(sizeof(*val));
1625            if (!val)
1626                    return -ENOMEM;
1627            *val =3D cpu_to_fdt32(value);
1628
>>>     CID 467058:  Insecure data handling  (TAINTED_SCALAR)
>>>     Passing tainted expression "*val" to "ofnode_write_prop", which use=
s it as an offset.
1629            return ofnode_write_prop(node, propname, val,
sizeof(value), true);
1630     }
1631
1632     int ofnode_write_u64(ofnode node, const char *propname, u64 value)
1633     {
1634            fdt64_t *val;

** CID 467057:  Uninitialized variables  (UNINIT)


___________________________________________________________________________=
_____________________________
*** CID 467057:  Uninitialized variables  (UNINIT)
/boot/bootflow.c: 320 in iter_incr()
314                              * Probe the bootdev. This does not
probe any attached
315                              * block device, since they are siblings
316                              */
317                             ret =3D device_probe(dev);
318                             log_debug("probe %s %d\n", dev->name, ret);
319                             if (!log_msg_ret("probe", ret))
>>>     CID 467057:  Uninitialized variables  (UNINIT)
>>>     Using uninitialized value "method_flags" when calling "bootflow_ite=
r_set_dev".
320                                     bootflow_iter_set_dev(iter,
dev, method_flags);
321                     }
322             }
323
324             /* if there are no more bootdevs, give up */
325             if (ret)

** CID 467056:  Control flow issues  (NO_EFFECT)
/common/cli_readline.c: 321 in cread_line_process_ch()


___________________________________________________________________________=
_____________________________
*** CID 467056:  Control flow issues  (NO_EFFECT)
/common/cli_readline.c: 321 in cread_line_process_ch()
315                     break;
316             case CTL_CH('w'):
317                     if (cls->num) {
318                             uint base, wlen;
319
320                             for (base =3D cls->num - 1;
>>>     CID 467056:  Control flow issues  (NO_EFFECT)
>>>     This greater-than-or-equal-to-zero comparison of an unsigned value =
is always true. "base >=3D 0U".
321                                  base >=3D 0 && buf[base] =3D=3D ' ';)
322                                     base--;
323                             for (; base > 0 && buf[base - 1] !=3D ' ';)
324                                     base--;
325
326                             /* now delete chars from base to cls->num */

** CID 467055:    (TAINTED_SCALAR)


___________________________________________________________________________=
_____________________________
*** CID 467055:    (TAINTED_SCALAR)
/boot/bootmeth_cros.c: 372 in cros_read_bootflow()
366                     log_debug("- scan failed: err=3D%d\n", ret);
367                     return log_msg_ret("scan", ret);
368             }
369
370             priv =3D malloc(sizeof(struct cros_priv));
371             if (!priv) {
>>>     CID 467055:    (TAINTED_SCALAR)
>>>     Passing tainted expression "*hdr" to "dlfree", which uses it as an =
offset.
372                     free(hdr);
373                     return log_msg_ret("buf", -ENOMEM);
374             }
375             bflow->bootmeth_priv =3D priv;
376
377             log_debug("Selected partition %d, header at %lx\n", bflow->=
part,
/boot/bootmeth_cros.c: 391 in cros_read_bootflow()
385             /* Now read everything we can learn about kernel */
386     #if CONFIG_IS_ENABLED(PARTITION_UUIDS)
387             uuid =3D info.uuid;
388     #endif
389             ret =3D cros_read_info(bflow, uuid, preamble);
390             preamble =3D NULL;
>>>     CID 467055:    (TAINTED_SCALAR)
>>>     Passing tainted expression "*hdr" to "dlfree", which uses it as an =
offset.
391             free(hdr);
392             if (ret) {
393                     free(priv->info_buf);
394                     free(priv);
395                     return log_msg_ret("inf", ret);
396             }

** CID 467054:  Resource leaks  (RESOURCE_LEAK)
/tools/sfspl.c: 118 in sfspl_image_extract_subimage()


___________________________________________________________________________=
_____________________________
*** CID 467054:  Resource leaks  (RESOURCE_LEAK)
/tools/sfspl.c: 118 in sfspl_image_extract_subimage()
112             if (fd =3D=3D -1) {
113                     perror("Can write file");
114                     return EXIT_FAILURE;
115             }
116             if (write(fd, &buf[hdr_size], file_size) !=3D file_size) {
117                     perror("Cannot write file");
>>>     CID 467054:  Resource leaks  (RESOURCE_LEAK)
>>>     Handle variable "fd" going out of scope leaks the handle.
118                     return EXIT_FAILURE;
119             }
120             close(fd);
121
122             return EXIT_SUCCESS;
123     }

** CID 467053:    (RESOURCE_LEAK)
/tools/mkeficapsule.c: 859 in dump_capsule_contents()
/tools/mkeficapsule.c: 859 in dump_capsule_contents()


___________________________________________________________________________=
_____________________________
*** CID 467053:    (RESOURCE_LEAK)
/tools/mkeficapsule.c: 859 in dump_capsule_contents()
853                     empty_capsule_dump(ptr);
854             } else {
855                     fprintf(stderr, "Unable to decode the capsule
file: %s\n",
856                             capsule_file);
857                     exit(EXIT_FAILURE);
858             }
>>>     CID 467053:    (RESOURCE_LEAK)
>>>     Variable "ptr" going out of scope leaks the storage it points to.
859     }
860
861     /**
862      * main - main entry function of mkeficapsule
863      * @argc:       Number of arguments
864      * @argv:       Array of pointers to arguments
/tools/mkeficapsule.c: 859 in dump_capsule_contents()
853                     empty_capsule_dump(ptr);
854             } else {
855                     fprintf(stderr, "Unable to decode the capsule
file: %s\n",
856                             capsule_file);
857                     exit(EXIT_FAILURE);
858             }
>>>     CID 467053:    (RESOURCE_LEAK)
>>>     Variable "ptr" going out of scope leaks the storage it points to.
859     }
860
861     /**
862      * main - main entry function of mkeficapsule
863      * @argc:       Number of arguments
864      * @argv:       Array of pointers to arguments

** CID 467052:  Insecure data handling  (TAINTED_SCALAR)


___________________________________________________________________________=
_____________________________
*** CID 467052:  Insecure data handling  (TAINTED_SCALAR)
/drivers/core/ofnode.c: 1644 in ofnode_write_u64()
1638            log_debug("%s =3D %llx", propname, (unsigned long long)valu=
e);
1639            val =3D malloc(sizeof(*val));
1640            if (!val)
1641                    return -ENOMEM;
1642            *val =3D cpu_to_fdt64(value);
1643
>>>     CID 467052:  Insecure data handling  (TAINTED_SCALAR)
>>>     Passing tainted expression "*val" to "ofnode_write_prop", which use=
s it as an offset.
1644            return ofnode_write_prop(node, propname, val,
sizeof(value), true);
1645     }
1646
1647     int ofnode_write_bool(ofnode node, const char *propname, bool valu=
e)
1648     {
1649            if (value)

** CID 467051:  API usage errors  (CHAR_IO)
/common/cli_readline.c: 550 in cread_line_simple()


___________________________________________________________________________=
_____________________________
*** CID 467051:  API usage errors  (CHAR_IO)
/common/cli_readline.c: 550 in cread_line_simple()
544
545             for (;;) {
546                     if (bootretry_tstc_timeout())
547                             return -2;      /* timed out */
548                     schedule();     /* Trigger watchdog, if needed */
549
>>>     CID 467051:  API usage errors  (CHAR_IO)
>>>     Assigning the return value of "getchar" to char "c" truncates its v=
alue.
550                     c =3D getchar();
551
552                     /*
553                      * Special character handling
554                      */
555                     switch (c) {

** CID 467050:  Control flow issues  (NO_EFFECT)
/drivers/firmware/scmi/sandbox-scmi_agent.c: 220 in
sandbox_scmi_base_message_attrs()


___________________________________________________________________________=
_____________________________
*** CID 467050:  Control flow issues  (NO_EFFECT)
/drivers/firmware/scmi/sandbox-scmi_agent.c: 220 in
sandbox_scmi_base_message_attrs()
214                 !msg->out_msg || msg->out_msg_sz < sizeof(*out))
215                     return -EINVAL;
216
217             message_id =3D *(u32 *)msg->in_msg;
218             out =3D (struct scmi_protocol_msg_attrs_out *)msg->out_msg;
219
>>>     CID 467050:  Control flow issues  (NO_EFFECT)
>>>     This greater-than-or-equal-to-zero comparison of an unsigned value =
is always true. "message_id >=3D SCMI_PROTOCOL_VERSION".
220             if (message_id >=3D SCMI_PROTOCOL_VERSION &&
221                 message_id <=3D SCMI_BASE_RESET_AGENT_CONFIGURATION &&
222                 message_id !=3D SCMI_BASE_NOTIFY_ERRORS) {
223                     out->attributes =3D 0;
224                     out->status =3D SCMI_SUCCESS;
225             } else {

** CID 467049:  Null pointer dereferences  (REVERSE_INULL)
/drivers/core/ofnode.c: 1764 in ofnode_read_bootscript_flash()


___________________________________________________________________________=
_____________________________
*** CID 467049:  Null pointer dereferences  (REVERSE_INULL)
/drivers/core/ofnode.c: 1764 in ofnode_read_bootscript_flash()
1758
1759            ret =3D ofnode_read_u64(uboot, "bootscr-flash-size",
1760                                  bootscr_flash_size);
1761            if (ret)
1762                    return -EINVAL;
1763
>>>     CID 467049:  Null pointer dereferences  (REVERSE_INULL)
>>>     Null-checking "bootscr_flash_size" suggests that it may be null, bu=
t it has already been dereferenced on all paths leading to the check.
1764            if (!bootscr_flash_size) {
1765                    debug("bootscr-flash-size is zero. Ignoring
properties!\n");
1766                    *bootscr_flash_offset =3D 0;
1767                    return -EINVAL;
1768            }
1769

** CID 467048:  Null pointer dereferences  (FORWARD_NULL)


___________________________________________________________________________=
_____________________________
*** CID 467048:  Null pointer dereferences  (FORWARD_NULL)
/common/cli_readline.c: 602 in cread_line_simple()
596                                     if (IS_ENABLED(CONFIG_AUTO_COMPLETE=
)) {
597                                             /*
598                                              * if auto-completion
triggered just
599                                              * continue
600                                              */
601                                             *p =3D '\0';
>>>     CID 467048:  Null pointer dereferences  (FORWARD_NULL)
>>>     Passing null pointer "prompt" to "cmd_auto_complete", which derefer=
ences it.
602                                             if (cmd_auto_complete(promp=
t,
603
console_buffer,
604
&n, &col)) {
605                                                     p =3D p_buf + n;
 /* reset */
606                                                     continue;
607                                             }

** CID 467047:  Error handling issues  (CHECKED_RETURN)
/boot/image-fit.c: 2477 in boot_get_fdt_fit()


___________________________________________________________________________=
_____________________________
*** CID 467047:  Error handling issues  (CHECKED_RETURN)
/boot/image-fit.c: 2477 in boot_get_fdt_fit()
2471                    /* the verbose method prints out messages on error =
*/
2472                    err =3D fdt_overlay_apply_verbose(base, ovcopy);
2473                    if (err < 0) {
2474                            fdt_noffset =3D err;
2475                            goto out;
2476                    }
>>>     CID 467047:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "fdt_pack" without checking return value (as is done elsewh=
ere 4 out of 5 times).
2477                    fdt_pack(base);
2478                    len =3D fdt_totalsize(base);
2479            }
2480     #else
2481            printf("config with overlays but
CONFIG_OF_LIBFDT_OVERLAY not set\n");
2482            fdt_noffset =3D -EBADF;

** CID 467046:  Error handling issues  (CHECKED_RETURN)
/drivers/phy/phy-uclass.c: 331 in generic_phy_power_on()


___________________________________________________________________________=
_____________________________
*** CID 467046:  Error handling issues  (CHECKED_RETURN)
/drivers/phy/phy-uclass.c: 331 in generic_phy_power_on()
325             ops =3D phy_dev_ops(phy->dev);
326             if (ops->power_on) {
327                     ret =3D ops->power_on(phy);
328                     if (ret) {
329                             dev_err(phy->dev, "PHY: Failed to
power on %s: %d.\n",
330                                     phy->dev->name, ret);
>>>     CID 467046:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "regulator_set_enable_if_allowed" without checking return v=
alue (as is done elsewhere 9 out of 11 times).
331
regulator_set_enable_if_allowed(counts->supply, false);
332                             return ret;
333                     }
334             }
335             counts->power_on_count =3D 1;
336

** CID 467045:  Resource leaks  (RESOURCE_LEAK)
/tools/mkeficapsule.c: 859 in dump_capsule_contents()


___________________________________________________________________________=
_____________________________
*** CID 467045:  Resource leaks  (RESOURCE_LEAK)
/tools/mkeficapsule.c: 859 in dump_capsule_contents()
853                     empty_capsule_dump(ptr);
854             } else {
855                     fprintf(stderr, "Unable to decode the capsule
file: %s\n",
856                             capsule_file);
857                     exit(EXIT_FAILURE);
858             }
>>>     CID 467045:  Resource leaks  (RESOURCE_LEAK)
>>>     Handle variable "fd" going out of scope leaks the handle.
859     }
860
861     /**
862      * main - main entry function of mkeficapsule
863      * @argc:       Number of arguments
864      * @argv:       Array of pointers to arguments



--GyPsfJMBoDBAI3Vx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU3G14ACgkQFHw5/5Y0
tyw48gv/VyYCkOCFDB0jaSZFte37H2uV4PWQZnd42McL9yHBvcK5/Nm7144dLtZ6
khcP+joDm2Q840aEU/6EyOtC7rwUaUNjNwgFxC+nsB9t88x3Geg9WgpY5YS17PVc
h27X6zFuTZ8EpTvhYJENmqQOObRnLrFSfkdWRCy9/oqyqwUrwJcxDFacRa7DSyEI
ToyNsf4pBECGTWtq2zzBTAzSAcuSMlL2chYxdzPqB0+9tbe5Y9yY9x2iJu2GXHO0
7hpZ4FV41YqIAQN5pnWdMagUHaifClRnpoWwucKQ/2RHDrC9ZCQq4ft7GAizk5ht
Wm4IsrAhI2HmxKRHPrXYwMUAC/ZaUePtpuUV/INofW7vCwvX21JyQ3Bp0rOoBCCq
3j+Ckwb4ZFLs82xs/UPmhmwszRikUT9IxGL6tqBZBRoGUORXZXaBA2lc3HrCmWfD
JvzrUtqMdDY/gjzq+FO7G+BqPqKok61rS8S1Rwq3jMpyWBeeP3bJeJ8+pxbSwHna
m4dWwxcJ
=l4Bq
-----END PGP SIGNATURE-----

--GyPsfJMBoDBAI3Vx--
