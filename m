Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E15CC98300
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 19:43:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4119836AC;
	Fri, 16 Jan 2026 20:43:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pk51lHnN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 726D1838A5; Fri, 16 Jan 2026 20:43:31 +0100 (CET)
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com
 [IPv6:2001:4860:4864:20::44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B92078367F
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 20:43:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x44.google.com with SMTP id
 586e51a60fabf-40413188553so1668945fac.1
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 11:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768592607; x=1769197407; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p6fN1XGEG+5SSbTDhP2lFsM2rtc6KsRD99NmypKjhAw=;
 b=pk51lHnNjSoOsjg08p3GoQ+PrNZE6mYzc2BDBFb/7of1ERv9CVyzAogQJYVAsT1/7X
 DKpZgoPGo050pLs74f+36vjxtfFxkOMnr1ifaDG2U7yzPgRJ9YoZQKBfT7bAdnpWVxSp
 4tddCsile18OjY9kAGOSaIx8p2JSdQEu8hlIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768592607; x=1769197407;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p6fN1XGEG+5SSbTDhP2lFsM2rtc6KsRD99NmypKjhAw=;
 b=TJX4Wa+3lpFgNigwtQA/Mpwzjhv/OD36X1Ei7As6TiIJf9LrB1BmlsUMc0YTDABCzh
 F2Vf1ygo7YQlKBDu+lBddh+/0Mhq4HJ+4LfUnWv4MpZTVXY7IVHDtcwvy+bjSO+QMYJW
 YdEmAr8rHN7jykaeORojhDgcUDM2rUIrDZKOsG2BIWu9oA+m9RxPr7V1WdqWISw6w0aE
 ufUBZfWGhnMCrEZYv9tg9w2753ZxJzYF142xh36R0MNQPeuob3+Aw/bYSTvoMt+FYkvA
 yL6RL1JMNNiZV32XtR+vhsZgZpjaBZ2iHMBdNCtqRBLQqzml0TZTGTgH18Z70FtBitJI
 AXig==
X-Gm-Message-State: AOJu0YzTmiMiQXpEc6LXkbHS4vB6pc3MWRc45NpSuV89B9Yaz/rCFVgA
 5hXmlsGh4+01DBYLBCYzYNPFR/c7ZCno2vdlddx1n85AVNivDmf+nEPsYWURn337u2lLpO8KZnk
 LPmqG7aE=
X-Gm-Gg: AY/fxX7khSKMX1QKLp/TrTJlljN2skCqC2lMapr/ZgeIVzGfBo40N+kWYUI7upFPlgs
 Ty9Ev58ZvEZLg/dEQsiXg/9Yjby9LdGhiPQcWvDWOLPe6wWOzdMvSCVKq/7alpq7ZB5Ul0O1aEl
 rTt1INwBzyN7RRvt7rSUEN+aUlhMbbP+7IgHS+yGBO3ARivF7DmXkZXqvo1ke344pn3btdYkJbL
 aqwf2AilROUdxSQXJBGByLSx512RvXiVzMdxiAgNgDxKnnvm+z1VDy6TT2GvKcSK2gAeAj2O4oP
 QIDJ11BTF58TmIyt6qp+iWzxXBECW0b8e2ba8Zph8MPNLsO09lgnkL/oJOg9vFMfLA3reoiwqFi
 WeKNhBhNi+WzI4mQdrjdeMMA0tU0dt1O3dRH1NMyOw9v1jmAT8GFLw/GdBeLdHhov3iBY2G5iXF
 LA24N0A+JgmpAVm6ikOfpQmBrB/Ltt+ZdCnUT0C3ORbmpWf2mjxigk/Uocwwq4gM5SboaS9hj0L
 cGHypTS0b/Z7CBds21Ac9vdjx5GaObjaFX5qPU=
X-Received: by 2002:a05:6808:1a0e:b0:44f:8f02:cf5e with SMTP id
 5614622812f47-45c9bf58363mr1857928b6e.18.1768592606459; 
 Fri, 16 Jan 2026 11:43:26 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45c9dec3567sm1682430b6e.1.2026.01.16.11.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 11:43:25 -0800 (PST)
Date: Fri, 16 Jan 2026 13:43:23 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20260116194323.GP3416603@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iYfVw4DwQkRV4/ep"
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


--iYfVw4DwQkRV4/ep
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

Here's the latest report from Coverity scan. For the LZMA ones, the
_pad_ stuff seems to be a false positive (the _pad_ byte is just for
padding and not refernced) and the flow control one is how that's
written for whatever reason the upstream author wanted it like that.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Fri, Jan 16, 2026 at 1:06=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to *Das U-Boot*
found with Coverity Scan.

   - *New Defects Found:* 7
   - 2 defect(s), reported by Coverity Scan earlier, were marked fixed in
   the recent build analyzed by Coverity Scan.
   - *Defects Shown:* Showing 7 of 7 defect(s)

Defect Details

** CID 641431:         (TAINTED_SCALAR)


___________________________________________________________________________=
__________________
*** CID 641431:           (TAINTED_SCALAR)
/boot/image-android.c: 434             in android_image_get_kernel()
428     		if (*newbootargs) /* If there is something in newbootargs, a
space is needed */
429     			strcat(newbootargs, " ");
430     		strcat(newbootargs, img_data.kcmdline_extra);
431     	}
432
433     	env_set("bootargs", newbootargs);
>>>     CID 641431:           (TAINTED_SCALAR)
>>>     Passing tainted expression "*newbootargs" to "dlfree", which uses i=
t as an offset.
434     	free(newbootargs);
435
436     	if (os_data) {
437     		if (image_get_magic(ihdr) =3D=3D IH_MAGIC) {
438     			*os_data =3D image_get_data(ihdr);
439     		} else {
/boot/image-android.c: 433             in android_image_get_kernel()
427     	if (img_data.kcmdline_extra && *img_data.kcmdline_extra) {
428     		if (*newbootargs) /* If there is something in newbootargs, a
space is needed */
429     			strcat(newbootargs, " ");
430     		strcat(newbootargs, img_data.kcmdline_extra);
431     	}
432
>>>     CID 641431:           (TAINTED_SCALAR)
>>>     Passing tainted expression "newbootargs" to "env_set", which uses i=
t as an offset.
433     	env_set("bootargs", newbootargs);
434     	free(newbootargs);
435
436     	if (os_data) {
437     		if (image_get_magic(ihdr) =3D=3D IH_MAGIC) {
438     			*os_data =3D image_get_data(ihdr);
/boot/image-android.c: 434             in android_image_get_kernel()
428     		if (*newbootargs) /* If there is something in newbootargs, a
space is needed */
429     			strcat(newbootargs, " ");
430     		strcat(newbootargs, img_data.kcmdline_extra);
431     	}
432
433     	env_set("bootargs", newbootargs);
>>>     CID 641431:           (TAINTED_SCALAR)
>>>     Passing tainted expression "*newbootargs" to "dlfree", which uses i=
t as an offset.
434     	free(newbootargs);
435
436     	if (os_data) {
437     		if (image_get_magic(ihdr) =3D=3D IH_MAGIC) {
438     			*os_data =3D image_get_data(ihdr);
439     		} else {
/boot/image-android.c: 433             in android_image_get_kernel()
427     	if (img_data.kcmdline_extra && *img_data.kcmdline_extra) {
428     		if (*newbootargs) /* If there is something in newbootargs, a
space is needed */
429     			strcat(newbootargs, " ");
430     		strcat(newbootargs, img_data.kcmdline_extra);
431     	}
432
>>>     CID 641431:           (TAINTED_SCALAR)
>>>     Passing tainted expression "newbootargs" to "env_set", which uses i=
t as an offset.
433     	env_set("bootargs", newbootargs);
434     	free(newbootargs);
435
436     	if (os_data) {
437     		if (image_get_magic(ihdr) =3D=3D IH_MAGIC) {
438     			*os_data =3D image_get_data(ihdr);
/boot/image-android.c: 433             in android_image_get_kernel()
427     	if (img_data.kcmdline_extra && *img_data.kcmdline_extra) {
428     		if (*newbootargs) /* If there is something in newbootargs, a
space is needed */
429     			strcat(newbootargs, " ");
430     		strcat(newbootargs, img_data.kcmdline_extra);
431     	}
432
>>>     CID 641431:           (TAINTED_SCALAR)
>>>     Passing tainted expression "newbootargs" to "env_set", which uses i=
t as an offset.
433     	env_set("bootargs", newbootargs);
434     	free(newbootargs);
435
436     	if (os_data) {
437     		if (image_get_magic(ihdr) =3D=3D IH_MAGIC) {
438     			*os_data =3D image_get_data(ihdr);
/boot/image-android.c: 434             in android_image_get_kernel()
428     		if (*newbootargs) /* If there is something in newbootargs, a
space is needed */
429     			strcat(newbootargs, " ");
430     		strcat(newbootargs, img_data.kcmdline_extra);
431     	}
432
433     	env_set("bootargs", newbootargs);
>>>     CID 641431:           (TAINTED_SCALAR)
>>>     Passing tainted expression "*newbootargs" to "dlfree", which uses i=
t as an offset.
434     	free(newbootargs);
435
436     	if (os_data) {
437     		if (image_get_magic(ihdr) =3D=3D IH_MAGIC) {
438     			*os_data =3D image_get_data(ihdr);
439     		} else {

** CID 641430:         (TAINTED_SCALAR)


___________________________________________________________________________=
__________________
*** CID 641430:           (TAINTED_SCALAR)
/cmd/abootimg.c: 244             in abootimg_get_ramdisk()
238     				      &rd_data, &rd_len))
239     		return CMD_RET_FAILURE;
240
241     	if (argc =3D=3D 0) {
242     		printf("%lx\n", rd_data);
243     	} else {
>>>     CID 641430:           (TAINTED_SCALAR)
>>>     Passing tainted expression "rd_data" to "env_set_hex", which uses i=
t as an offset.
244     		env_set_hex(argv[0], rd_data);
245     		if (argc =3D=3D 2)
246     			env_set_hex(argv[1], rd_len);
247     	}
248
249     	return CMD_RET_SUCCESS;
/cmd/abootimg.c: 246             in abootimg_get_ramdisk()
240
241     	if (argc =3D=3D 0) {
242     		printf("%lx\n", rd_data);
243     	} else {
244     		env_set_hex(argv[0], rd_data);
245     		if (argc =3D=3D 2)
>>>     CID 641430:           (TAINTED_SCALAR)
>>>     Passing tainted expression "rd_len" to "env_set_hex", which uses it=
 as an offset.
246     			env_set_hex(argv[1], rd_len);
247     	}
248
249     	return CMD_RET_SUCCESS;
250     }
251

** CID 641429:       Insecure data handling  (TAINTED_SCALAR)


___________________________________________________________________________=
__________________
*** CID 641429:         Insecure data handling  (TAINTED_SCALAR)
/boot/image-android.c: 307             in android_image_get_data()
301     			printf("Incorrect vendor boot image header\n");
302     			unmap_sysmem(vhdr);
303     			unmap_sysmem(bhdr);
304     			return false;
305     		}
306     		android_boot_image_v3_v4_parse_hdr((const struct
andr_boot_img_hdr_v3 *)bhdr, data);
>>>     CID 641429:         Insecure data handling  (TAINTED_SCALAR)
>>>     Passing tainted expression "vhdr->bootconfig_size" to "android_vend=
or_boot_image_v3_v4_parse_hdr", which uses it as a loop boundary.
307     		android_vendor_boot_image_v3_v4_parse_hdr(vhdr, data);
308     		unmap_sysmem(vhdr);
309     	} else {
310     		android_boot_image_v0_v1_v2_parse_hdr(bhdr, data);
311     	}
312

** CID 641428:         (TAINTED_SCALAR)


___________________________________________________________________________=
__________________
*** CID 641428:           (TAINTED_SCALAR)
/boot/image-android.c: 658             in android_image_set_bootconfig()
652     		total_size +=3D params_len + BOOTCONFIG_TRAILER_SIZE;
653
654     	/* Map Dest */
655     	ramdisk_dest =3D map_sysmem(ramdisk_addr, total_size);
656
657     	/* Copy data */
>>>     CID 641428:           (TAINTED_SCALAR)
>>>     Passing tainted expression "img_data.vendor_ramdisk_size" to "andro=
id_boot_append_bootconfig", which uses it as an offset.
658     	ret =3D android_boot_append_bootconfig(&img_data, params, params_l=
en,
659     					     ramdisk_dest);
660
661     	unmap_sysmem(ramdisk_dest);
662     	free(params);
663     	free(new_bootargs);
/boot/image-android.c: 658             in android_image_set_bootconfig()
652     		total_size +=3D params_len + BOOTCONFIG_TRAILER_SIZE;
653
654     	/* Map Dest */
655     	ramdisk_dest =3D map_sysmem(ramdisk_addr, total_size);
656
657     	/* Copy data */
>>>     CID 641428:           (TAINTED_SCALAR)
>>>     Passing tainted expression "img_data.bootconfig_size" to "android_b=
oot_append_bootconfig", which uses it as an offset.
658     	ret =3D android_boot_append_bootconfig(&img_data, params, params_l=
en,
659     					     ramdisk_dest);
660
661     	unmap_sysmem(ramdisk_dest);
662     	free(params);
663     	free(new_bootargs);
/boot/image-android.c: 658             in android_image_set_bootconfig()
652     		total_size +=3D params_len + BOOTCONFIG_TRAILER_SIZE;
653
654     	/* Map Dest */
655     	ramdisk_dest =3D map_sysmem(ramdisk_addr, total_size);
656
657     	/* Copy data */
>>>     CID 641428:           (TAINTED_SCALAR)
>>>     Passing tainted expression "img_data.boot_ramdisk_size" to "android=
_boot_append_bootconfig", which uses it as an offset.
658     	ret =3D android_boot_append_bootconfig(&img_data, params, params_l=
en,
659     					     ramdisk_dest);
660
661     	unmap_sysmem(ramdisk_dest);
662     	free(params);
663     	free(new_bootargs);

** CID 332278:       Control flow issues  (UNREACHABLE)
/lib/lzma/LzmaDec.c: 720           in LzmaDec_TryDummy()


___________________________________________________________________________=
__________________
*** CID 332278:         Control flow issues  (UNREACHABLE)
/lib/lzma/LzmaDec.c: 720             in LzmaDec_TryDummy()
714       UInt32 code =3D p->code;
715       const Byte *bufLimit =3D *bufOut;
716       const CLzmaProb *probs =3D GET_PROBS;
717       unsigned state =3D (unsigned)p->state;
718       ELzmaDummy res;
719
>>>     CID 332278:         Control flow issues  (UNREACHABLE)
>>>     Since the loop increment is unreachable, the loop body will never e=
xecute more than once.
720       for (;;)
721       {
722         const CLzmaProb *prob;
723         UInt32 bound;
724         unsigned ttt;
725         unsigned posState =3D CALC_POS_STATE(p->processedPos,
((unsigned)1 << p->prop.pb) - 1);

** CID 252901:       Uninitialized variables  (UNINIT)
/lib/lzma/LzmaDec.c: 1295           in LzmaDec_AllocateProbs()


___________________________________________________________________________=
__________________
*** CID 252901:         Uninitialized variables  (UNINIT)
/lib/lzma/LzmaDec.c: 1295             in LzmaDec_AllocateProbs()
1289
1290     SRes LzmaDec_AllocateProbs(CLzmaDec *p, const Byte *props,
unsigned propsSize, ISzAllocPtr alloc)
1291     {
1292       CLzmaProps propNew;
1293       RINOK(LzmaProps_Decode(&propNew, props, propsSize))
1294       RINOK(LzmaDec_AllocateProbs2(p, &propNew, alloc))
>>>     CID 252901:         Uninitialized variables  (UNINIT)
>>>     Using uninitialized value "propNew". Field "propNew._pad_" is unini=
tialized.
1295       p->prop =3D propNew;
1296       return SZ_OK;
1297     }
1298
1299     SRes LzmaDec_Allocate(CLzmaDec *p, const Byte *props,
unsigned propsSize, ISzAllocPtr alloc)
1300     {

** CID 252579:       Uninitialized variables  (UNINIT)
/lib/lzma/LzmaDec.c: 1327           in LzmaDec_Allocate()


___________________________________________________________________________=
__________________
*** CID 252579:         Uninitialized variables  (UNINIT)
/lib/lzma/LzmaDec.c: 1327             in LzmaDec_Allocate()
1321         {
1322           LzmaDec_FreeProbs(p, alloc);
1323           return SZ_ERROR_MEM;
1324         }
1325       }
1326       p->dicBufSize =3D dicBufSize;
>>>     CID 252579:         Uninitialized variables  (UNINIT)
>>>     Using uninitialized value "propNew". Field "propNew._pad_" is unini=
tialized.
1327       p->prop =3D propNew;
1328       return SZ_OK;
1329     }
1330
1331     SRes LzmaDecode(Byte *dest, SizeT *destLen, const Byte *src,
SizeT *srcLen,
1332         const Byte *propData, unsigned propSize, ELzmaFinishMode
finishMode,



View Defects in Coverity Scan
<https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>

Best regards,

The Coverity Scan Admin Team

----- End forwarded message -----

--=20
Tom

--iYfVw4DwQkRV4/ep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWqU1AAKCRAr4qD1Cr/k
Cn5lAQDyVEkH+tfPjFMagOgTPvwXJKbUBr+CDTbgLxwrOacbuQD9GThk+YvPiK7b
bB9zYUr72ANNIMSYQXAkZnW665Mw6g8=
=fsdm
-----END PGP SIGNATURE-----

--iYfVw4DwQkRV4/ep--
