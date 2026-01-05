Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195A7CD0423
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 23:58:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 881B383A7A;
	Tue,  6 Jan 2026 00:58:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mUbK4npM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55A2383D9F; Tue,  6 Jan 2026 00:58:20 +0100 (CET)
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 698CF83A57
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 00:58:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x242.google.com with SMTP id
 5614622812f47-45392215f74so286170b6e.3
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 15:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767657496; x=1768262296; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/tsen6nBbZiXbZdFykSrP66+QV0KSVYxT8hnagu+iPM=;
 b=mUbK4npM9EOo0tSr0IsGuZJs5Y2djftlRjuqx3EE9UgqXzVVPZVv0Bh1UI8FpWHW20
 FhYSar/ct0SwTJqzBvA1IwlVNLwi1BAgF3pusqxvZ+hkly96GXkBMn4J8dhw3JgQNBqD
 AjBjcKxVbJDuAu19LW63Bd5/851BhlWMm3IJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767657496; x=1768262296;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/tsen6nBbZiXbZdFykSrP66+QV0KSVYxT8hnagu+iPM=;
 b=dqJfrHEvrVBuWQZwQ7/YgrjZQmFxN9jvmzZ811HE2LT4z2qPCTrJpUDICzs+udl3JN
 FFjw1eOLGhtc+w7KZgk7UMLStvNLizP2mX82PZgiDNwj+t2FRnM1DnnQTRXHqEmMO1iO
 EdVptFlmd+/mXPgYYuvca5oaBEI6x6gBTYKqCWS8Pu04Jc5yHghEOZVNrm4L6dDj21C2
 +egJdyVRiH8NW0NOyh7UPhQ4OyAz4Wd6tFrYfJqdL4q7qQAjkeToPd5TytPBZUkLQ6Of
 si57L1Mctls760Jax9dSMQ9lw+gXbjaa5wvUWeZjxo1YcqxvXdMvw6JN7fBeWgZSEVZG
 webw==
X-Gm-Message-State: AOJu0YxnyGpTFKWNg3rRrQR7FKNt7nGjPUS8TVmRkIBJTQ6SO8XlAKFo
 YFEKZac49wMSxBlUyVTiVseIQIlAbs+dJGt4Rmnz3O3NTUuPPZS87O/3MDFFIWc+ivMWD7npjWW
 VlD8dxmM=
X-Gm-Gg: AY/fxX55+366xdrWRMXY8jgSIAKR2JcwdmsYHCzguDzeslb6cAHOXtTvYY8i1r8Nyje
 aNBY2cifs5rC1XGQJRLQTS71ot1TIbziiDjHj+qsGDcF8s5Ec6sG2P+37GDfJcjZcPa7JPKBQqS
 JTe1PXdW28/f/fVep9a8tU3ZxEzmpqI3+Y4F8XlJPQbM7f7zYJTptRyPNzeuwQIPGFmiP8fV1KG
 1gKuDqZcNK7bGsjKwzPoUDWtzZqD0JM82gScBiIIUPZM08PaS1QISV7UpIAo7w4UiUvBeRCU+Uu
 qTixcb98UXswuac83b3VhjGrPedD7BSyxZ/IJGRu9Cb0TxyC+WAyB2Bbcmi8YWriOFzhhdZICk/
 UFFM5BBuUotnZdZEGaoNJxqUIXCyzmke1dY5S9cOZjzrswQ47Zn/HVHgvzAKt6XDt/UFJf2qiJG
 ZMh7tggNzPE6RLKYhjGfy6iZSz1sTULdkJ6DVJIc3ll8u+6ElEUVo4PPp2KylIOchiSmUUTvZga
 OcAlz6bt3wGTgDBkxJs1OKJHM43ozJ7eBhiT7AT15AR2vE0dQ==
X-Google-Smtp-Source: AGHT+IH8QWA+I/D0Qgo6s0clmTiLz5Bg5+H7Yj5sKCu8V/sX41kl2rTWEiG87CPbUOdRG7cylc2leg==
X-Received: by 2002:a05:6808:124d:b0:455:db31:a680 with SMTP id
 5614622812f47-45a5b1a4936mr768572b6e.63.1767657496016; 
 Mon, 05 Jan 2026 15:58:16 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45a5e288bc7sm221375b6e.12.2026.01.05.15.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 15:58:15 -0800 (PST)
Date: Mon, 5 Jan 2026 17:58:13 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Dmitrii Merkurev <dimorinny@google.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20260105235813.GB3416603@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Kzhc1dwb7uTDXDs2"
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


--Kzhc1dwb7uTDXDs2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

Here's the latest report, now that next has been merged to master. A few
of these are oddly showing up now, despite being in older code that
hasn't been touched and was being built before.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Mon, Jan 5, 2026 at 3:24=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to *Das U-Boot*
found with Coverity Scan.

   - *New Defects Found:* 15
   - 23 defect(s), reported by Coverity Scan earlier, were marked fixed in
   the recent build analyzed by Coverity Scan.
   - *Defects Shown:* Showing 15 of 15 defect(s)

Defect Details

** CID 640423:       Control flow issues  (DEADCODE)
/drivers/fastboot/fb_common.c: 112           in fastboot_set_reboot_flag()


___________________________________________________________________________=
__________________
*** CID 640423:         Control flow issues  (DEADCODE)
/drivers/fastboot/fb_common.c: 112             in fastboot_set_reboot_flag()
106     	}
107     	const char *bcb_iface =3D config_opt_enabled(CONFIG_FASTBOOT_FLASH=
_BLOCK,
108     						   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
109     						   "mmc");
110
111     	if (device =3D=3D -1)
>>>     CID 640423:         Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "return -22;".
112     		return -EINVAL;
113
114     	if (reason >=3D FASTBOOT_REBOOT_REASONS_COUNT)
115     		return -EINVAL;
116
117     	ret =3D bcb_find_partition_and_load(bcb_iface, device, "misc");

** CID 640422:       Error handling issues  (CHECKED_RETURN)
/boot/fdt_region.c: 330           in fdt_include_supernodes()


___________________________________________________________________________=
__________________
*** CID 640422:         Error handling issues  (CHECKED_RETURN)
/boot/fdt_region.c: 330             in fdt_include_supernodes()
324     	 */
325     	for (i =3D 0; i <=3D depth; i++) {
326     		if (!info->stack[i].included) {
327     			start =3D info->stack[i].offset;
328
329     			/* Add the FDT_BEGIN_NODE tag of this supernode */
>>>     CID 640422:         Error handling issues  (CHECKED_RETURN)
>>>     Calling "fdt_next_tag" without checking return value (as is done el=
sewhere 12 out of 15 times).
330     			fdt_next_tag(info->fdt, start, &stop_at);
331     			if (fdt_add_region(info, base + start, stop_at - start))
332     				return -1;
333
334     			/* Remember that this supernode is now included */
335     			info->stack[i].included =3D 1;

** CID 640421:       Possible Control flow issues  (DEADCODE)
/drivers/fastboot/fb_block.c: 138           in fastboot_block_get_part_info=
()


___________________________________________________________________________=
__________________
*** CID 640421:         Possible Control flow issues  (DEADCODE)
/drivers/fastboot/fb_block.c: 138             in fastboot_block_get_part_in=
fo()
132     					      CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
133
134     	if (!part_name || !strcmp(part_name, "")) {
135     		fastboot_fail("partition not given", response);
136     		return -ENOENT;
137     	}
>>>     CID 640421:         Possible Control flow issues  (DEADCODE)
>>>     Execution cannot reach the expression "strcmp(interface, "")" insid=
e this statement: "if (!interface || !strcmp(i...".
138     	if (!interface || !strcmp(interface, "")) {
139     		fastboot_fail("block interface isn't provided", response);
140     		return -EINVAL;
141     	}
142
143     	*dev_desc =3D blk_get_dev(interface, device);

** CID 640420:       Incorrect expression  (CONSTANT_EXPRESSION_RESULT)
/env/fat.c: 49           in env_fat_get_dev_part()


___________________________________________________________________________=
__________________
*** CID 640420:         Incorrect expression  (CONSTANT_EXPRESSION_RESULT)
/env/fat.c: 49             in env_fat_get_dev_part()
43     __weak char *env_fat_get_dev_part(void)
44     {
45     #ifdef CONFIG_MMC
46     	/* reserve one more char for the manipulation below */
47     	static char part_str[] =3D CONFIG_ENV_FAT_DEVICE_AND_PART "\0";
48
>>>     CID 640420:         Incorrect expression  (CONSTANT_EXPRESSION_RESU=
LT)
>>>     "strcmp("mmc", "mmc")" is always 0 because ""mmc"" is compared agai=
nst itself.
49     	if (!strcmp(CONFIG_ENV_FAT_INTERFACE, "mmc") && part_str[0] =3D=3D =
':') {
50     		part_str[0] =3D '0' + mmc_get_env_dev();
51     		strcpy(&part_str[1], CONFIG_ENV_FAT_DEVICE_AND_PART);
52     	}
53
54     	return part_str;

** CID 640419:       Null pointer dereferences  (REVERSE_INULL)
/drivers/fastboot/fb_block.c: 144           in fastboot_block_get_part_info=
()


___________________________________________________________________________=
__________________
*** CID 640419:         Null pointer dereferences  (REVERSE_INULL)
/drivers/fastboot/fb_block.c: 144             in fastboot_block_get_part_in=
fo()
138     	if (!interface || !strcmp(interface, "")) {
139     		fastboot_fail("block interface isn't provided", response);
140     		return -EINVAL;
141     	}
142
143     	*dev_desc =3D blk_get_dev(interface, device);
>>>     CID 640419:         Null pointer dereferences  (REVERSE_INULL)
>>>     Null-checking "dev_desc" suggests that it may be null, but it has a=
lready been dereferenced on all paths leading to the check.
144     	if (!dev_desc) {
145     		fastboot_fail("no such device", response);
146     		return -ENODEV;
147     	}
148
149     	ret =3D part_get_info_by_name(*dev_desc, part_name, part_info);

** CID 640418:       Insecure data handling  (TAINTED_SCALAR)


___________________________________________________________________________=
__________________
*** CID 640418:         Insecure data handling  (TAINTED_SCALAR)
/drivers/core/ofnode.c: 2098             in ofnode_copy_props()
2092
2093     		val =3D ofprop_get_property(&prop, &name, &len);
2094     		if (!val) {
2095     			log_debug("Cannot read prop (err=3D%d)\n", len);
2096     			return log_msg_ret("get", -EINVAL);
2097     		}
>>>     CID 640418:         Insecure data handling  (TAINTED_SCALAR)
>>>     Passing tainted expression "len" to "ofnode_write_prop", which uses=
 it as an offset.
2098     		ret =3D ofnode_write_prop(dst, name, val, len, true);
2099     		if (ret) {
2100     			log_debug("Cannot write prop (err=3D%d)\n", ret);
2101     			return log_msg_ret("wr", -EINVAL);
2102     		}
2103     	}

** CID 640417:       Insecure data handling  (TAINTED_SCALAR)
/scripts/dtc/libfdt/fdt_ro.c: 546           in fdt_get_alias_namelen()


___________________________________________________________________________=
__________________
*** CID 640417:         Insecure data handling  (TAINTED_SCALAR)
/scripts/dtc/libfdt/fdt_ro.c: 546             in fdt_get_alias_namelen()
540     {
541     	int len;
542     	const char *alias;
543
544     	alias =3D fdt_path_getprop_namelen(fdt, "/aliases", name, namelen,=
 &len);
545
>>>     CID 640417:         Insecure data handling  (TAINTED_SCALAR)
>>>     Using tainted variable "len - 1" as an index to pointer "alias".
546     	if (!can_assume(VALID_DTB) &&
547     	    !(alias && len > 0 && alias[len - 1] =3D=3D '\0' && *alias =3D=
=3D '/'))
548     		return NULL;
549
550     	return alias;
551     }

** CID 640416:       Insecure data handling  (TAINTED_SCALAR)


___________________________________________________________________________=
__________________
*** CID 640416:         Insecure data handling  (TAINTED_SCALAR)
/scripts/dtc/libfdt/fdt_overlay.c: 739             in
overlay_prevent_phandle_overwrite()
733     			 * will be overwritten.
734     			 */
735     			continue;
736     		else if (target < 0)
737     			return target;
738
>>>     CID 640416:         Insecure data handling  (TAINTED_SCALAR)
>>>     Passing tainted expression "target" to "overlay_prevent_phandle_ove=
rwrite_node", which uses it as a loop boundary.
739     		ret =3D overlay_prevent_phandle_overwrite_node(fdt, target,
740     							     fdto, overlay);
741     		if (ret)
742     			return ret;
743     	}
744

** CID 640415:       Control flow issues  (DEADCODE)
/scripts/dtc/pylibfdt/libfdt_wrap.c: 6728           in
_wrap_fdt_get_property_by_offset_w()


___________________________________________________________________________=
__________________
*** CID 640415:         Control flow issues  (DEADCODE)
/scripts/dtc/pylibfdt/libfdt_wrap.c: 6728             in
_wrap_fdt_get_property_by_offset_w()
6722           resultobj =3D SWIG_Python_AppendOutput(resultobj, buff);
6723         }
6724       }
6725       if (SWIG_IsTmpObj(res3)) {
6726         resultobj =3D SWIG_Python_AppendOutput(resultobj,
SWIG_From_int((*arg3)));
6727       } else {
>>>     CID 640415:         Control flow issues  (DEADCODE)
>>>     Execution cannot reach the expression "new_flags" inside this state=
ment: "new_flags =3D ((res3 >=3D 0 && ...".
6728         int new_flags =3D SWIG_IsNewObj(res3) ? (SWIG_POINTER_OWN |
 0 ) :  0 ;
6729         resultobj =3D SWIG_Python_AppendOutput(resultobj,
SWIG_NewPointerObj((void*)(arg3), SWIGTYPE_p_int, new_flags));
6730       }
6731       return resultobj;
6732     fail:
6733       return NULL;

** CID 640414:       Resource leaks  (RESOURCE_LEAK)
/drivers/interconnect/interconnect-uclass.c: 320           in icc_path_init=
()


___________________________________________________________________________=
__________________
*** CID 640414:         Resource leaks  (RESOURCE_LEAK)
/drivers/interconnect/interconnect-uclass.c: 320             in icc_path_in=
it()
314     		path->reqs[i].node =3D node;
315     		path->reqs[i].enabled =3D true;
316
317     		/* Probe this node since used in an active path */
318     		ret =3D uclass_get_device_tail(node->dev, 0, &node_dev);
319     		if (ret)
>>>     CID 640414:         Resource leaks  (RESOURCE_LEAK)
>>>     Variable "path" going out of scope leaks the storage it points to.
320     			return ERR_PTR(ret);
321
322     		node->users++;
323
324     		/* reference to previous node was saved during path traversal */
325     		node =3D node->reverse;

** CID 536550:       Resource leaks  (RESOURCE_LEAK)
/scripts/dtc/fstree.c: 57           in read_fstree()


___________________________________________________________________________=
__________________
*** CID 536550:         Resource leaks  (RESOURCE_LEAK)
/scripts/dtc/fstree.c: 57             in read_fstree()
51     				fclose(pfile);
52     			}
53     		} else if (S_ISDIR(st.st_mode)) {
54     			struct node *newchild;
55
56     			newchild =3D read_fstree(tmpname);
>>>     CID 536550:         Resource leaks  (RESOURCE_LEAK)
>>>     Failing to save or free storage allocated by "xstrdup(de->d_name)" =
leaks it.
57     			newchild =3D name_node(newchild, xstrdup(de->d_name));
58     			add_child(tree, newchild);
59     		}
60
61     		free(tmpname);
62     	}

** CID 536369:       Resource leaks  (RESOURCE_LEAK)
/scripts/dtc/flattree.c: 681           in flat_read_property()


___________________________________________________________________________=
__________________
*** CID 536369:         Resource leaks  (RESOURCE_LEAK)
/scripts/dtc/flattree.c: 681             in flat_read_property()
675
676     	if ((flags & FTF_VARALIGN) && (proplen >=3D 8))
677     		flat_realign(dtbuf, 8);
678
679     	val =3D flat_read_data(dtbuf, proplen);
680
>>>     CID 536369:         Resource leaks  (RESOURCE_LEAK)
>>>     Variable "name" going out of scope leaks the storage it points to.
681     	return build_property(name, val, NULL);
682     }
683
684     static struct reserve_info *flat_read_mem_reserve(struct inbuf *inb)
685     {
686     	struct reserve_info *reservelist =3D NULL;

** CID 449815:       Memory - illegal accesses  (OVERRUN)
/lib/sm3.c: 252           in sm3_final()


___________________________________________________________________________=
__________________
*** CID 449815:         Memory - illegal accesses  (OVERRUN)
/lib/sm3.c: 252             in sm3_final()
246     	unsigned int partial =3D sctx->count % SM3_BLOCK_SIZE;
247     	u32 W[16];
248     	int i;
249
250     	sctx->buffer[partial++] =3D 0x80;
251     	if (partial > bit_offset) {
>>>     CID 449815:         Memory - illegal accesses  (OVERRUN)
>>>     Overrunning array of 64 bytes at byte offset 64 by dereferencing po=
inter "sctx->buffer + partial". [Note: The source code implementation of th=
e function has been overridden by a builtin model.]
252     		memset(sctx->buffer + partial, 0, SM3_BLOCK_SIZE - partial);
253     		partial =3D 0;
254
255     		sm3_block(sctx, sctx->buffer, 1, W);
256     	}
257

** CID 432237:       Null pointer dereferences  (NULL_RETURNS)


___________________________________________________________________________=
__________________
*** CID 432237:         Null pointer dereferences  (NULL_RETURNS)
/scripts/dtc/checks.c: 1618             in check_interrupt_map()
1612     	if (node->addr_cells < 0) {
1613     		FAIL(c, dti, node,
1614     		     "Missing '#address-cells' in interrupt-map provider");
1615     		return;
1616     	}
1617     	cellsize =3D node_addr_cells(node);
>>>     CID 432237:         Null pointer dereferences  (NULL_RETURNS)
>>>     Dereferencing a pointer that might be "NULL" "get_property(node, "#=
interrupt-cells")" when calling "propval_cell".
1618     	cellsize +=3D propval_cell(get_property(node, "#interrupt-cells")=
);
1619
1620     	prop =3D get_property(node, "interrupt-map-mask");
1621     	if (prop && (prop->val.len !=3D (cellsize * sizeof(cell_t))))
1622     		FAIL_PROP(c, dti, node, prop,
1623     			  "property size (%d) is invalid, expected %zu",

** CID 328724:         (TAINTED_SCALAR)
/scripts/dtc/fdtoverlay.c: 55           in apply_one()
/scripts/dtc/fdtoverlay.c: 69           in apply_one()


___________________________________________________________________________=
__________________
*** CID 328724:           (TAINTED_SCALAR)
/scripts/dtc/fdtoverlay.c: 55             in apply_one()
49     	bool has_symbols;
50
51     	/*
52     	 * We take copies first, because a failed apply can trash
53     	 * both the base blob and the overlay
54     	 */
>>>     CID 328724:           (TAINTED_SCALAR)
>>>     Passing tainted expression "fdt32_ld(&((struct fdt_header const *)o=
verlay)->totalsize)" to "xmalloc", which uses it as an allocation size. [No=
te: The source code implementation of the function has been overridden by a=
 builtin model.]
55     	tmpo =3D xmalloc(fdt_totalsize(overlay));
56
57     	do {
58     		tmp =3D xrealloc(tmp, *buf_len);
59     		ret =3D fdt_open_into(base, tmp, *buf_len);
60     		if (ret) {
/scripts/dtc/fdtoverlay.c: 69             in apply_one()
63     				fdt_strerror(ret));
64     			goto fail;
65     		}
66     		ret =3D fdt_path_offset(tmp, "/__symbols__");
67     		has_symbols =3D ret >=3D 0;
68
>>>     CID 328724:           (TAINTED_SCALAR)
>>>     Passing tainted expression "fdt32_ld(&((struct fdt_header const *)o=
verlay)->totalsize)" to "memcpy", which uses it as an offset. [Note: The so=
urce code implementation of the function has been overridden by a builtin m=
odel.]
69     		memcpy(tmpo, overlay, fdt_totalsize(overlay));
70
71     		ret =3D fdt_overlay_apply(tmp, tmpo);
72     		if (ret =3D=3D -FDT_ERR_NOSPACE) {
73     			*buf_len +=3D BUF_INCREMENT;
74     		}



View Defects in Coverity Scan
<https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>

Best regards,

The Coverity Scan Admin Team

----- End forwarded message -----

--=20
Tom

--Kzhc1dwb7uTDXDs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVxQEQAKCRAr4qD1Cr/k
CpGQAQDSZVO+9G4cnasF/x7+8aYDMkDRGgknHlqXBukI3+rUgAD/UZ2HABTheat0
XMxGGb18KBiRfuFxozkPGWSIZXRQWAk=
=M0cq
-----END PGP SIGNATURE-----

--Kzhc1dwb7uTDXDs2--
