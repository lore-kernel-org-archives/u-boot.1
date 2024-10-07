Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211B1CFB44F
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 17:15:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B48A888EB;
	Mon,  7 Oct 2024 19:15:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lKJmmPOD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EC3A8899C; Mon,  7 Oct 2024 19:15:14 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F6C5888B2
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 19:15:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cb284c1a37so41128526d6.1
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 10:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728321310; x=1728926110; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uqz1NhOLNeCo2sjiIDhH9il/sj0a5fyx0N4gYEXIqhg=;
 b=lKJmmPODOUjHBZpDlOfUEd0/+xFMrx+9VYY0PArO2bK1fuPd9fE+2MAXyt2lbnpXhC
 lC0FNTg7Kw0EQQRx2r8dOrV+dd+LTf//f1v7D5PkHLgePbYtokKdgoVf3NUPho78As2b
 Sdd8HI7M5D8imu2pmyP8QCAwLkZbAor0arL9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728321310; x=1728926110;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uqz1NhOLNeCo2sjiIDhH9il/sj0a5fyx0N4gYEXIqhg=;
 b=iQAT5LdH4P7gapfmIIK5Sls0J8LFGg1P6PlGfeMpXI4IJ6Um32wYOy4qjM/ESeERoM
 YB0YnBDmmZxF/vYazga2vx+YKgdNCy5N78o62kwO5IaOEzXxpU9YIX2K9KkPxtoG2Ju2
 k2UOZkmLOFWK6DqjxdunmduvWscUd9MlVLRy7+xEsyzmDDu5F7/dXt9ooFRF1pRCAZra
 05274I0NBZwM+cAsRbFIhihA1LR9UcVRbWYFGTizlVKSekSUZh1PiBOq7DOOBZBQbykW
 ReVieKMfJlhO8BYRMfzSe80jqkFYf1lt3h5CrhrVUUaTKAq4VR7+mAc/IrAOIgjIuA8X
 jezQ==
X-Gm-Message-State: AOJu0YxnAcV9c2Q4lnxRkxzk7wj/sb8SMi2N99PWEsK3d/vYpoW7hyoq
 8krx0Gf6rxgPNcR0AtWCtVfkBCbe1jMaqVsi+Yf25xbAzOZAFuOpv4aJH1huRE8QHp6VyaTnQEt
 DBqY=
X-Google-Smtp-Source: AGHT+IGkIkQVM6y7Xv0JVwxvl5MHW6Jv7Y04l0cY8sGVYIbTeDHLA3JfBY1AllZLhQFwr3iWHsmRvg==
X-Received: by 2002:a05:6214:3a03:b0:6cb:2aa7:3e4 with SMTP id
 6a1803df08f44-6cb9a464affmr162920406d6.47.1728321309884; 
 Mon, 07 Oct 2024 10:15:09 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cba46efec2sm27456256d6.74.2024.10.07.10.15.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 10:15:09 -0700 (PDT)
Date: Mon, 7 Oct 2024 11:15:05 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Joao Marcos Costa <jmcosta944@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Richard Weinberger <richard@nod.at>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20241007171505.GC4737@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="f8VodW7NxKWT2bJ1"
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


--f8VodW7NxKWT2bJ1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Now that I've merged next to master, there's a number of issues to
address.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Mon, Oct 7, 2024 at 10:59=E2=80=AFAM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to Das
U-Boot found with Coverity Scan.

24 new defect(s) introduced to Das U-Boot found with Coverity Scan.
9 defect(s), reported by Coverity Scan earlier, were marked fixed in
the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 24 defect(s)


** CID 510469:    (RESOURCE_LEAK)
/tools/mkeficapsule.c: 877 in load_dtb()
/tools/mkeficapsule.c: 862 in load_dtb()
/tools/mkeficapsule.c: 855 in load_dtb()
/tools/mkeficapsule.c: 870 in load_dtb()


___________________________________________________________________________=
_____________________________
*** CID 510469:    (RESOURCE_LEAK)
/tools/mkeficapsule.c: 877 in load_dtb()
871             }
872
873             if (fread(dtb, dtb_size, 1, f) !=3D 1) {
874                     fprintf(stderr, "Can't read %ld bytes from %s\n",
875                             dtb_size, path);
876                     free(dtb);
>>>     CID 510469:    (RESOURCE_LEAK)
>>>     Variable "f" going out of scope leaks the storage it points to.
877                     return NULL;
878             }
879
880             fclose(f);
881
882             return dtb;
/tools/mkeficapsule.c: 862 in load_dtb()
856             }
857
858             dtb_size =3D ftell(f);
859             if (dtb_size < 0) {
860                     fprintf(stderr, "Cannot ftell %s: %s\n",
861                             path, strerror(errno));
>>>     CID 510469:    (RESOURCE_LEAK)
>>>     Variable "f" going out of scope leaks the storage it points to.
862                     return NULL;
863             }
864
865             fseek(f, 0, SEEK_SET);
866
867             dtb =3D malloc(dtb_size);
/tools/mkeficapsule.c: 855 in load_dtb()
849                     return NULL;
850             }
851
852             if (fseek(f, 0, SEEK_END)) {
853                     fprintf(stderr, "Cannot seek to the end of %s: %s\n=
",
854                             path, strerror(errno));
>>>     CID 510469:    (RESOURCE_LEAK)
>>>     Variable "f" going out of scope leaks the storage it points to.
855                     return NULL;
856             }
857
858             dtb_size =3D ftell(f);
859             if (dtb_size < 0) {
860                     fprintf(stderr, "Cannot ftell %s: %s\n",
/tools/mkeficapsule.c: 870 in load_dtb()
864
865             fseek(f, 0, SEEK_SET);
866
867             dtb =3D malloc(dtb_size);
868             if (!dtb) {
869                     fprintf(stderr, "Can't allocated %ld\n", dtb_size);
>>>     CID 510469:    (RESOURCE_LEAK)
>>>     Variable "f" going out of scope leaks the storage it points to.
870                     return NULL;
871             }
872
873             if (fread(dtb, dtb_size, 1, f) !=3D 1) {
874                     fprintf(stderr, "Can't read %ld bytes from %s\n",
875                             dtb_size, path);

** CID 510468:  Integer handling issues  (SIGN_EXTENSION)
/lib/alist.c: 65 in alist_expand_to()


___________________________________________________________________________=
_____________________________
*** CID 510468:  Integer handling issues  (SIGN_EXTENSION)
/lib/alist.c: 65 in alist_expand_to()
59      new_data =3D malloc(lst->obj_size * new_alloc);
60      if (!new_data) {
61              lst->flags |=3D ALISTF_FAIL;
62              return false;
63      }
64
>>>     CID 510468:  Integer handling issues  (SIGN_EXTENSION)
>>>     Suspicious implicit sign extension: "lst->obj_size" with type "u16"=
 (16 bits, unsigned) is promoted in "lst->obj_size * lst->alloc" to type "i=
nt" (32 bits, signed), then sign-extended to type "unsigned long" (64 bits,=
 unsigned).  If "lst->obj_size * lst->alloc" is greater than 0x7FFFFFFF, th=
e upper bits of the result will all be 1.
65      memcpy(new_data, lst->data, lst->obj_size * lst->alloc);
66      free(lst->data);
67
68      memset(new_data + lst->obj_size * lst->alloc, '\0',
69             lst->obj_size * (new_alloc - lst->alloc));
70      lst->alloc =3D new_alloc;

** CID 510467:  Integer handling issues  (CONSTANT_EXPRESSION_RESULT)
/net/tcp.c: 497 in tcp_parse_options()


___________________________________________________________________________=
_____________________________
*** CID 510467:  Integer handling issues  (CONSTANT_EXPRESSION_RESULT)
/net/tcp.c: 497 in tcp_parse_options()
491                             tsopt =3D (struct tcp_t_opt *)p;
492                             rmt_timestamp =3D tsopt->t_snd;
493                             return;
494                     }
495
496                     /* Process optional NOPs */
>>>     CID 510467:  Integer handling issues  (CONSTANT_EXPRESSION_RESULT)
>>>     "p[0] =3D=3D 16843009" is always false regardless of the values of =
its operands. This occurs as the logical operand of "if".
497                     if (p[0] =3D=3D TCP_O_NOP)
498                             p++;
499             }
500     }
501
502     static u8 tcp_state_machine(u8 tcp_flags, u32 tcp_seq_num, int
payload_len)

** CID 510466:  Control flow issues  (NO_EFFECT)
/lib/uuid.c: 256 in uuid_guid_get_bin()


___________________________________________________________________________=
_____________________________
*** CID 510466:  Control flow issues  (NO_EFFECT)
/lib/uuid.c: 256 in uuid_guid_get_bin()
250     };
251
252     int uuid_guid_get_bin(const char *guid_str, unsigned char *guid_bin)
253     {
254             int i;
255
>>>     CID 510466:  Control flow issues  (NO_EFFECT)
>>>     This less-than-zero comparison of an unsigned value is never true. =
"i < 0UL".
256             for (i =3D 0; i < ARRAY_SIZE(list_guid); i++) {
257                     if (!strcmp(list_guid[i].string, guid_str)) {
258                             memcpy(guid_bin, &list_guid[i].guid, 16);
259                             return 0;
260                     }
261             }

** CID 510465:  Uninitialized variables  (UNINIT)


___________________________________________________________________________=
_____________________________
*** CID 510465:  Uninitialized variables  (UNINIT)
/cmd/upl.c: 59 in do_upl_write()
53      struct unit_test_state uts;
54      struct abuf buf;
55      oftree tree;
56      ulong addr;
57      int ret;
58
>>>     CID 510465:  Uninitialized variables  (UNINIT)
>>>     Using uninitialized value "uts.fail_count" when calling "upl_get_te=
st_data".
59      upl_get_test_data(&uts, upl);
60
61      log_debug("Writing UPL\n");
62      ret =3D upl_create_handoff_tree(upl, &tree);
63      if (ret) {
64              log_err("Failed to write (err=3D%dE)\n", ret);

** CID 510464:  Error handling issues  (CHECKED_RETURN)
/net/wget.c: 259 in wget_connected()


___________________________________________________________________________=
_____________________________
*** CID 510464:  Error handling issues  (CHECKED_RETURN)
/net/wget.c: 259 in wget_connected()
253
254                             pos =3D strstr((char *)pkt, content_len);
255                             if (!pos) {
256                                     content_length =3D -1;
257                             } else {
258                                     pos +=3D sizeof(content_len) + 2;
>>>     CID 510464:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "strict_strtoul" without checking return value (as is done =
elsewhere 8 out of 10 times).
259                                     strict_strtoul(pos, 10,
&content_length);
260                                     debug_cond(DEBUG_WGET,
261                                                "wget: Connected Len %lu=
\n",
262                                                content_length);
263                             }
264

** CID 510463:  Memory - illegal accesses  (OVERRUN)
/lib/lmb.c: 37 in lmb_print_region_flags()


___________________________________________________________________________=
_____________________________
*** CID 510463:  Memory - illegal accesses  (OVERRUN)
/lib/lmb.c: 37 in lmb_print_region_flags()
31     {
32      u64 bitpos;
33      const char *flag_str[] =3D { "none", "no-map", "no-overwrite" };
34
35      do {
36              bitpos =3D flags ? fls(flags) - 1 : 0;
>>>     CID 510463:  Memory - illegal accesses  (OVERRUN)
>>>     Overrunning array "flag_str" of 3 8-byte elements at element index =
31 (byte offset 255) using index "bitpos" (which evaluates to 31).
37              printf("%s", flag_str[bitpos]);
38              flags &=3D ~(1ull << bitpos);
39              puts(flags ? ", " : "\n");
40      } while (flags);
41     }
42

** CID 510462:  Security best practices violations  (DC.WEAK_CRYPTO)
/test/dm/nand.c: 67 in run_test_nand()


___________________________________________________________________________=
_____________________________
*** CID 510462:  Security best practices violations  (DC.WEAK_CRYPTO)
/test/dm/nand.c: 67 in run_test_nand()
61      ops.ooblen =3D mtd->oobsize;
62      ut_assertok(mtd_read_oob(mtd, mtd->erasesize, &ops));
63      ut_asserteq(0, oob[mtd_to_nand(mtd)->badblockpos]);
64
65      /* Generate some data and write it */
66      for (i =3D 0; i < size / sizeof(int); i++)
>>>     CID 510462:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security-related applications, becaus=
e linear congruential algorithms are too easy to break.
67              gold[i] =3D rand();
68      ut_assertok(nand_write_skip_bad(mtd, off, &length, NULL, U64_MAX,
69                                      (void *)gold, 0));
70      ut_asserteq(size, length);
71
72      /* Verify */

** CID 510461:  Code maintainability issues  (UNUSED_VALUE)
/boot/upl_write.c: 237 in add_upl_image()


___________________________________________________________________________=
_____________________________
*** CID 510461:  Code maintainability issues  (UNUSED_VALUE)
/boot/upl_write.c: 237 in add_upl_image()
231                             return log_msg_ret("sub", ret);
232
233                     ret =3D write_addr(upl, subnode, UPLP_LOAD, img->lo=
ad);
234                     if (!ret)
235                             ret =3D write_size(upl, subnode,
UPLP_SIZE, img->size);
236                     if (!ret && img->offset)
>>>     CID 510461:  Code maintainability issues  (UNUSED_VALUE)
>>>     Assigning value from "ofnode_write_u32(subnode, "offset", img->offs=
et)" to "ret" here, but that stored value is overwritten before it can be u=
sed.
237                             ret =3D ofnode_write_u32(subnode, UPLP_OFFS=
ET,
238                                                    img->offset);
239                     ret =3D ofnode_write_string(subnode, UPLP_DESCRIPTI=
ON,
240                                               img->description);
241                     if (ret)
242                             return log_msg_ret("sim", ret);

** CID 510460:  Resource leaks  (RESOURCE_LEAK)
/fs/ext4/ext4fs.c: 216 in ext4fs_exists()


___________________________________________________________________________=
_____________________________
*** CID 510460:  Resource leaks  (RESOURCE_LEAK)
/fs/ext4/ext4fs.c: 216 in ext4fs_exists()
210             struct ext2fs_node *dirnode =3D NULL;
211             int filetype;
212
213             if (!filename)
214                     return 0;
215
>>>     CID 510460:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "dirnode" going out of scope leaks the storage it points t=
o.
216             return ext4fs_find_file1(filename,
&ext4fs_root->diropen, &dirnode,
217                                      &filetype);
218     }
219
220     int ext4fs_size(const char *filename, loff_t *size)
221     {

** CID 510459:  Incorrect expression  (SIZEOF_MISMATCH)
/boot/upl_read.c: 523 in decode_upl_graphics()


___________________________________________________________________________=
_____________________________
*** CID 510459:  Incorrect expression  (SIZEOF_MISMATCH)
/boot/upl_read.c: 523 in decode_upl_graphics()
517             if (!buf) {
518                     log_warning("Node '%s': Missing 'reg' property\n",
519                                 ofnode_get_name(node));
520                     return log_msg_ret("reg", -EINVAL);
521             }
522
>>>     CID 510459:  Incorrect expression  (SIZEOF_MISMATCH)
>>>     Passing argument "buf" of type "char const *" and argument "8 /* si=
zeof (buf) */" to function "decode_addr_size" is suspicious.
523             len =3D decode_addr_size(upl, buf, sizeof(buf), &gra->reg);
524             if (len < 0)
525                     return log_msg_ret("buf", len);
526
527             ret =3D read_uint(node, UPLP_WIDTH, &gra->width);
528             if (!ret)

** CID 510458:  Control flow issues  (NO_EFFECT)
/lib/uuid.c: 269 in uuid_guid_get_str()


___________________________________________________________________________=
_____________________________
*** CID 510458:  Control flow issues  (NO_EFFECT)
/lib/uuid.c: 269 in uuid_guid_get_str()
263     }
264
265     const char *uuid_guid_get_str(const unsigned char *guid_bin)
266     {
267             int i;
268
>>>     CID 510458:  Control flow issues  (NO_EFFECT)
>>>     This less-than-zero comparison of an unsigned value is never true. =
"i < 0UL".
269             for (i =3D 0; i < ARRAY_SIZE(list_guid); i++) {
270                     if (!memcmp(list_guid[i].guid.b, guid_bin, 16)) {
271                             return list_guid[i].string;
272                     }
273             }
274             return NULL;

** CID 510457:    (RESOURCE_LEAK)
/tools/mkeficapsule.c: 934 in genguid()
/tools/mkeficapsule.c: 930 in genguid()
/tools/mkeficapsule.c: 924 in genguid()
/tools/mkeficapsule.c: 944 in genguid()
/tools/mkeficapsule.c: 959 in genguid()


___________________________________________________________________________=
_____________________________
*** CID 510457:    (RESOURCE_LEAK)
/tools/mkeficapsule.c: 934 in genguid()
928             if (!compatible) {
929                     fprintf(stderr, "No compatible string found in DTB\=
n");
930                     return -1;
931             }
932             if (strnlen(compatible, compatlen) >=3D compatlen) {
933                     fprintf(stderr, "Compatible string not
null-terminated\n");
>>>     CID 510457:    (RESOURCE_LEAK)
>>>     Variable "dtb" going out of scope leaks the storage it points to.
934                     return -1;
935             }
936
937             printf("Generating GUIDs for %s with namespace %s:\n",
938                    compatible, DEFAULT_NAMESPACE_GUID);
939             for (; idx < argc; idx++) {
/tools/mkeficapsule.c: 930 in genguid()
924                     return -1;
925             }
926
927             compatible =3D fdt_getprop(dtb, 0, "compatible", &compatlen=
);
928             if (!compatible) {
929                     fprintf(stderr, "No compatible string found in DTB\=
n");
>>>     CID 510457:    (RESOURCE_LEAK)
>>>     Variable "dtb" going out of scope leaks the storage it points to.
930                     return -1;
931             }
932             if (strnlen(compatible, compatlen) >=3D compatlen) {
933                     fprintf(stderr, "Compatible string not
null-terminated\n");
934                     return -1;
935             }
/tools/mkeficapsule.c: 924 in genguid()
918             if (!dtb)
919                     return -1;
920
921             ret =3D fdt_check_header(dtb);
922             if (ret) {
923                     fprintf(stderr, "Invalid DTB header: %d\n", ret);
>>>     CID 510457:    (RESOURCE_LEAK)
>>>     Variable "dtb" going out of scope leaks the storage it points to.
924                     return -1;
925             }
926
927             compatible =3D fdt_getprop(dtb, 0, "compatible", &compatlen=
);
928             if (!compatible) {
929                     fprintf(stderr, "No compatible string found in DTB\=
n");
/tools/mkeficapsule.c: 944 in genguid()
938                    compatible, DEFAULT_NAMESPACE_GUID);
939             for (; idx < argc; idx++) {
940                     memset(fw_image, 0, sizeof(fw_image));
941                     namelen =3D strlen(argv[idx]);
942                     if (namelen > MAX_IMAGE_NAME_LEN) {
943                             fprintf(stderr, "Image name too long:
%s\n", argv[idx]);
>>>     CID 510457:    (RESOURCE_LEAK)
>>>     Variable "dtb" going out of scope leaks the storage it points to.
944                             return -1;
945                     }
946
947                     for (int i =3D 0; i < namelen; i++)
948                             fw_image[i] =3D (uint16_t)argv[idx][i];
949
/tools/mkeficapsule.c: 959 in genguid()
953                                 NULL);
954
955                     printf("%s: ", argv[idx]);
956                     print_guid(&image_type_id);
957             }
958
>>>     CID 510457:    (RESOURCE_LEAK)
>>>     Variable "dtb" going out of scope leaks the storage it points to.
959             return 0;
960     }
961
962     /**
963      * main - main entry function of mkeficapsule
964      * @argc:       Number of arguments

** CID 510456:  Integer handling issues  (NEGATIVE_RETURNS)


___________________________________________________________________________=
_____________________________
*** CID 510456:  Integer handling issues  (NEGATIVE_RETURNS)
/boot/upl_write.c: 432 in add_upl_memres()
426                     ret =3D ofnode_add_subnode(mem_node, name, &node);
427                     if (ret)
428                             return log_msg_ret("memres", ret);
429
430                     len =3D buffer_addr_size(upl, buf, sizeof(buf),
431                                            memres->region.count,
&memres->region);
>>>     CID 510456:  Integer handling issues  (NEGATIVE_RETURNS)
>>>     "len" is passed to a parameter that cannot be negative.
432                     ret =3D ofnode_write_prop(node, UPLP_REG, buf, len,=
 true);
433                     if (!ret && memres->no_map)
434                             ret =3D ofnode_write_bool(node, UPLP_NO_MAP,
435                                                     memres->no_map);
436                     if (ret)
437                             return log_msg_ret("lst", ret);

** CID 510455:  Memory - corruptions  (OVERLAPPING_COPY)
/fs/squashfs/sqfs.c: 971 in sqfs_opendir_nest()


___________________________________________________________________________=
_____________________________
*** CID 510455:  Memory - corruptions  (OVERLAPPING_COPY)
/fs/squashfs/sqfs.c: 971 in sqfs_opendir_nest()
965             if (le16_to_cpu(dirs->i_dir.inode_type) =3D=3D SQFS_DIR_TYP=
E)
966                     dirs->size =3D le16_to_cpu(dirs->i_dir.file_size);
967             else
968                     dirs->size =3D le32_to_cpu(dirs->i_ldir.file_size);
969
970             /* Setup directory header */
>>>     CID 510455:  Memory - corruptions  (OVERLAPPING_COPY)
>>>     Copying 12 bytes from "dirs->table" to "dirs->dir_header", which po=
int to overlapping memory locations.
971             memcpy(dirs->dir_header, dirs->table, SQFS_DIR_HEADER_SIZE);
972             dirs->entry_count =3D dirs->dir_header->count + 1;
973             dirs->size -=3D SQFS_DIR_HEADER_SIZE;
974
975             /* Setup entry */
976             dirs->entry =3D NULL;

** CID 510454:    (SIZEOF_MISMATCH)
/test/cmd/mbr.c: 280 in mbr_test_run()
/test/cmd/mbr.c: 421 in mbr_test_run()
/test/cmd/mbr.c: 351 in mbr_test_run()
/test/cmd/mbr.c: 316 in mbr_test_run()
/test/cmd/mbr.c: 386 in mbr_test_run()


___________________________________________________________________________=
_____________________________
*** CID 510454:    (SIZEOF_MISMATCH)
/test/cmd/mbr.c: 280 in mbr_test_run()
274
275             /* Make sure mmc6 is 12+ MiB in size */
276             ut_assertok(run_commandf("mmc read %lx %lx 1", ra,
277                                      (ulong)0xbffe00 / BLKSZ));
278
279             /* Test one MBR partition */
>>>     CID 510454:    (SIZEOF_MISMATCH)
>>>     Passing argument "mbr_wbuf" of type "unsigned char *" and argument =
"8UL /* sizeof (mbr_wbuf) */" to function "init_write_buffers" is suspiciou=
s.
280             init_write_buffers(mbr_wbuf, sizeof(mbr_wbuf),
ebr_wbuf, sizeof(ebr_wbuf), __LINE__);
281             ut_assertok(build_mbr_parts(mbr_parts_buf,
sizeof(mbr_parts_buf), 1));
282             ut_assertok(run_commandf("write mmc 6:0 %lx 0 1", mbr_wa));
283             memset(rbuf, '\0', BLKSZ);
284             ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
285             ut_assertok(memcmp(mbr_wbuf, rbuf, BLKSZ));
/test/cmd/mbr.c: 421 in mbr_test_run()
415                     ut_assertf(rbuf[mbr_cmp_start + i] =3D=3D
mbr_parts_ref_p4[i],
416                             "4P MBR+0x%04X: expected %#02X,
actual: %#02X\n",
417                             mbr_cmp_start + i,
mbr_parts_ref_p4[i], rbuf[mbr_cmp_start + i]);
418             }
419
420             /* Test five MBR partitions */
>>>     CID 510454:    (SIZEOF_MISMATCH)
>>>     Passing argument "mbr_wbuf" of type "unsigned char *" and argument =
"8UL /* sizeof (mbr_wbuf) */" to function "init_write_buffers" is suspiciou=
s.
421             init_write_buffers(mbr_wbuf, sizeof(mbr_wbuf),
ebr_wbuf, sizeof(ebr_wbuf), __LINE__);
422             ut_assertok(build_mbr_parts(mbr_parts_buf,
sizeof(mbr_parts_buf), 5));
423             ut_assertok(run_commandf("write mmc 6:0 %lx 0 1", mbr_wa));
424             memset(rbuf, '\0', BLKSZ);
425             ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
426             ut_assertok(memcmp(mbr_wbuf, rbuf, BLKSZ));
/test/cmd/mbr.c: 351 in mbr_test_run()
345                     ut_assertf(rbuf[mbr_cmp_start + i] =3D=3D
mbr_parts_ref_p2[i],
346                             "2P MBR+0x%04X: expected %#02X,
actual: %#02X\n",
347                             mbr_cmp_start + i,
mbr_parts_ref_p2[i], rbuf[mbr_cmp_start + i]);
348             }
349
350             /* Test three MBR partitions */
>>>     CID 510454:    (SIZEOF_MISMATCH)
>>>     Passing argument "mbr_wbuf" of type "unsigned char *" and argument =
"8UL /* sizeof (mbr_wbuf) */" to function "init_write_buffers" is suspiciou=
s.
351             init_write_buffers(mbr_wbuf, sizeof(mbr_wbuf),
ebr_wbuf, sizeof(ebr_wbuf), __LINE__);
352             ut_assertok(build_mbr_parts(mbr_parts_buf,
sizeof(mbr_parts_buf), 3));
353             ut_assertok(run_commandf("write mmc 6:0 %lx 0 1", mbr_wa));
354             memset(rbuf, '\0', BLKSZ);
355             ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
356             ut_assertok(memcmp(mbr_wbuf, rbuf, BLKSZ));
/test/cmd/mbr.c: 316 in mbr_test_run()
310                     ut_assertf(rbuf[mbr_cmp_start + i] =3D=3D
mbr_parts_ref_p1[i],
311                             "1P MBR+0x%04X: expected %#02X,
actual: %#02X\n",
312                             mbr_cmp_start + i,
mbr_parts_ref_p1[i], rbuf[mbr_cmp_start + i]);
313             }
314
315             /* Test two MBR partitions */
>>>     CID 510454:    (SIZEOF_MISMATCH)
>>>     Passing argument "mbr_wbuf" of type "unsigned char *" and argument =
"8UL /* sizeof (mbr_wbuf) */" to function "init_write_buffers" is suspiciou=
s.
316             init_write_buffers(mbr_wbuf, sizeof(mbr_wbuf),
ebr_wbuf, sizeof(ebr_wbuf), __LINE__);
317             ut_assertok(build_mbr_parts(mbr_parts_buf,
sizeof(mbr_parts_buf), 2));
318             ut_assertok(run_commandf("write mmc 6:0 %lx 0 1", mbr_wa));
319             memset(rbuf, '\0', BLKSZ);
320             ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
321             ut_assertok(memcmp(mbr_wbuf, rbuf, BLKSZ));
/test/cmd/mbr.c: 386 in mbr_test_run()
380                     ut_assertf(rbuf[mbr_cmp_start + i] =3D=3D
mbr_parts_ref_p3[i],
381                             "3P MBR+0x%04X: expected %#02X,
actual: %#02X\n",
382                             mbr_cmp_start + i,
mbr_parts_ref_p3[i], rbuf[mbr_cmp_start + i]);
383             }
384
385             /* Test four MBR partitions */
>>>     CID 510454:    (SIZEOF_MISMATCH)
>>>     Passing argument "mbr_wbuf" of type "unsigned char *" and argument =
"8UL /* sizeof (mbr_wbuf) */" to function "init_write_buffers" is suspiciou=
s.
386             init_write_buffers(mbr_wbuf, sizeof(mbr_wbuf),
ebr_wbuf, sizeof(ebr_wbuf), __LINE__);
387             ut_assertok(build_mbr_parts(mbr_parts_buf,
sizeof(mbr_parts_buf), 4));
388             ut_assertok(run_commandf("write mmc 6:0 %lx 0 1", mbr_wa));
389             memset(rbuf, '\0', BLKSZ);
390             ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
391             ut_assertok(memcmp(mbr_wbuf, rbuf, BLKSZ));

** CID 510453:  Null pointer dereferences  (FORWARD_NULL)
/fs/squashfs/sqfs.c: 983 in sqfs_opendir_nest()


___________________________________________________________________________=
_____________________________
*** CID 510453:  Null pointer dereferences  (FORWARD_NULL)
/fs/squashfs/sqfs.c: 983 in sqfs_opendir_nest()
977             dirs->table +=3D SQFS_DIR_HEADER_SIZE;
978
979             *dirsp =3D (struct fs_dir_stream *)dirs;
980
981     out:
982             for (j =3D 0; j < token_count; j++)
>>>     CID 510453:  Null pointer dereferences  (FORWARD_NULL)
>>>     Dereferencing null pointer "token_list".
983                     free(token_list[j]);
984             free(token_list);
985             free(pos_list);
986             free(path);
987             if (ret) {
988                     free(inode_table);

** CID 510452:  Null pointer dereferences  (FORWARD_NULL)
/fs/squashfs/sqfs.c: 1676 in sqfs_size_nest()


___________________________________________________________________________=
_____________________________
*** CID 510452:  Null pointer dereferences  (FORWARD_NULL)
/fs/squashfs/sqfs.c: 1676 in sqfs_size_nest()
1670                    printf("File not found.\n");
1671                    *size =3D 0;
1672                    ret =3D -EINVAL;
1673                    goto free_strings;
1674            }
1675
>>>     CID 510452:  Null pointer dereferences  (FORWARD_NULL)
>>>     Dereferencing null pointer "dirs->entry".
1676            i_number =3D dirs->dir_header->inode_number +
dirs->entry->inode_offset;
1677            ipos =3D sqfs_find_inode(dirs->inode_table, i_number,
sblk->inodes,
1678                                   sblk->block_size);
1679
1680            if (!ipos) {
1681                    *size =3D 0;

** CID 510451:    (TAINTED_SCALAR)
/fs/squashfs/sqfs.c: 1612 in sqfs_read_nest()
/fs/squashfs/sqfs.c: 1612 in sqfs_read_nest()
/fs/squashfs/sqfs.c: 1604 in sqfs_read_nest()


___________________________________________________________________________=
_____________________________
*** CID 510451:    (TAINTED_SCALAR)
/fs/squashfs/sqfs.c: 1612 in sqfs_read_nest()
1606
1607                    free(fragment_block);
1608
1609            } else if (finfo.frag && !finfo.comp) {
1610                    fragment_block =3D (void *)fragment + table_offset;
1611
>>>     CID 510451:    (TAINTED_SCALAR)
>>>     Using tainted variable "finfo.offset" as an index to pointer "fragm=
ent_block".
1612                    memcpy(buf + *actread,
&fragment_block[finfo.offset], finfo.size - *actread);
1613                    *actread =3D finfo.size;
1614            }
1615
1616     out:
1617            free(fragment);
/fs/squashfs/sqfs.c: 1612 in sqfs_read_nest()
1606
1607                    free(fragment_block);
1608
1609            } else if (finfo.frag && !finfo.comp) {
1610                    fragment_block =3D (void *)fragment + table_offset;
1611
>>>     CID 510451:    (TAINTED_SCALAR)
>>>     Passing tainted expression "finfo.size - *actread" to "memcpy", whi=
ch uses it as an offset. [Note: The source code implementation of the funct=
ion has been overridden by a builtin model.]
1612                    memcpy(buf + *actread,
&fragment_block[finfo.offset], finfo.size - *actread);
1613                    *actread =3D finfo.size;
1614            }
1615
1616     out:
1617            free(fragment);
/fs/squashfs/sqfs.c: 1621 in sqfs_read_nest()
1615
1616     out:
1617            free(fragment);
1618            free(datablock);
1619            free(file);
1620            free(dir);
>>>     CID 510451:    (TAINTED_SCALAR)
>>>     Passing tainted expression "*finfo.blk_sizes" to "dlfree", which us=
es it as an offset.
1621            free(finfo.blk_sizes);
1622            sqfs_closedir(dirsp);
1623
1624            return ret;
1625     }
1626
/fs/squashfs/sqfs.c: 1604 in sqfs_read_nest()
1598                                          frag_entry.size);
1599                    if (ret) {
1600                            free(fragment_block);
1601                            goto out;
1602                    }
1603
>>>     CID 510451:    (TAINTED_SCALAR)
>>>     Using tainted variable "finfo.offset" as an index to pointer "fragm=
ent_block".
1604                    memcpy(buf + *actread,
&fragment_block[finfo.offset], finfo.size - *actread);
1605                    *actread =3D finfo.size;
1606
1607                    free(fragment_block);
1608
1609            } else if (finfo.frag && !finfo.comp) {

** CID 510450:  Code maintainability issues  (UNUSED_VALUE)
/fs/squashfs/sqfs.c: 1506 in sqfs_read_nest()


___________________________________________________________________________=
_____________________________
*** CID 510450:  Code maintainability issues  (UNUSED_VALUE)
/fs/squashfs/sqfs.c: 1506 in sqfs_read_nest()
1500                    n_blks =3D DIV_ROUND_UP(table_size + table_offset,
1501                                          ctxt.cur_dev->blksz);
1502
1503                    /* Don't load any data for sparse blocks */
1504                    if (finfo.blk_sizes[j] =3D=3D 0) {
1505                            n_blks =3D 0;
>>>     CID 510450:  Code maintainability issues  (UNUSED_VALUE)
>>>     Assigning value "0ULL" to "table_offset" here, but that stored valu=
e is overwritten before it can be used.
1506                            table_offset =3D 0;
1507                            data_buffer =3D NULL;
1508                            data =3D NULL;
1509                    } else {
1510                            data_buffer =3D
malloc_cache_aligned(n_blks * ctxt.cur_dev->blksz);
1511

----- End forwarded message -----

--=20
Tom

--f8VodW7NxKWT2bJ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcEFxkACgkQFHw5/5Y0
tywDWwwAugP6ihrkqZqpPUiKv8ttYPA10KUI5B4/T/iAWxbgo/P27jlykTb+pqwF
MyjW+7q1c/pIHjy/GwnKwZjpodMqTeGkHlt72jpBW1N7vo80LMKCAmRxGv+sqHKX
e486/dXLjZh4uZ/pZgGQsl+z6Z6ttd+df67s8v+G/cPYzG1wohsGjVRJi/wSCrVl
/Ucj2WP5ZK59XYWKufUwtRxNP2SsH4i9OHQNoMqeSAEy2JUdBVjWjKzte1FPbvkV
4/Y0+a5JV8LETSI+6SNjtE2GH0mW18L9RBAr1xQ3qGSfVh7fQp0EG3xwSal0X9OL
YjpBOOut53XIIRdGS1YF17TuMTH9QAdmzf1LiWF6hjgrhuS6E2YqVqIoHBv72oBO
K9ZJEKlRMzSu3Uww99tehwelMyNxqZdDNyAxZYA3PjdYhBIeP6IO+Q4UdBnsBgoT
SOv/oI78W4tJaEBvJmGkYg25WZen/+iCXZXey+JDTcyGTp3+OeQ2yNgZkGWTvh9j
6/KE7PiF
=Am7j
-----END PGP SIGNATURE-----

--f8VodW7NxKWT2bJ1--
