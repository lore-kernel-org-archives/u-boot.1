Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1246C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 18:58:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32A0A849A4;
	Tue,  7 Jul 2026 20:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rkqKvNGI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A9A2849B1; Tue,  7 Jul 2026 20:58:29 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E2618498B
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 20:58:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7e9dc546f40so541180a34.1
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 11:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783450705; x=1784055505; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5xeHZnLbCPscJHruKhQOVUDRFsG99C76MC5jzm0mBPQ=;
 b=rkqKvNGISZhHkjTG/BuQHIrU/1bSeNGMH0MY3jAz8kSE56q7x8AWowwABTEAhgivFW
 95tw/BmjDnOesxr3lxGBWga+cwDYfUHLFezoID6wMA6IUsi6mP5gZU0yiCZrOOWnuiXP
 XpV+ilsoV907bjZf/nhFXkiT5LeAZx4medUhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783450705; x=1784055505;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5xeHZnLbCPscJHruKhQOVUDRFsG99C76MC5jzm0mBPQ=;
 b=MWVL0XasCGhjktX3v9SLcRqhuK68nyMovqYjXnnW5tWokDFi9raVmxGPNVMTxEfMbf
 YoEFEMeRhDPYCfsnWYwrjZOo4F9YqlV2j2y5srkXcga3tPT50nHP8t1zMUDeUuExr+8y
 2/zQphBTr34d+vVaeXhnX50HNsZ6s72LyAGKdDvbI2iiHsMHhPp7+j3IMJZZxsJb6EwU
 +NyPLMZ2kGjoumgStOiJ9HOOECr+2G/8u9dkhjRRvEbPua94noEdUMV+n+Yx7vZERxyN
 WIJCsTDiPn8NASDE+7ucBv8O7iocjltQSloDsQrf9OxGIcxGSbgIcQVLu1Qf0S8MMYz4
 5IDw==
X-Gm-Message-State: AOJu0YwX8qXkbbb56L5OTscDIbPG3k7MwymIizZE3IV3e9x/LubSDP4u
 OjIgzRzjpz1lkTdssO42nHEBoCcYtdhid10vU5/IkvrtcSeJE9G+vc10dlc3ZpKpVDKYTeHoX7R
 F4Nt6nnk=
X-Gm-Gg: AfdE7cmMqNPm0AVsNYKzaEXbhF5obf/wlxry/CuNRhE0IqZaa/dDbhDkhkub9a/gOUw
 9skzgN2pOXocegblNojMVDFhhsmgtDpTn27Bx6TdLGLP4V+fQeel0ilvYzwnjAZ97DRO22qqWzO
 yGBUQSwXCz5WMhwUvGqJ23dTOlIgnigiCqKiBL9ZoYof46wiNrfksWROP8pNlwd9um9V27n8f1K
 hQtc3XKs5m2Fa4HUpyeUrIuT/4NUDR+VMgMMs8A8QzkhbIQtKj4fWz+5aa7P+zoTqFwsdlBVNjw
 xiUECdBGLuh/2V+lkLTdQwW9gy+0bxxxIZZFXaP7LNwyPeY2Slf5c2pxYAOz+AgmG5015PVZewY
 C2T/L8DhkZKD+dQcaiX5flCRruGDy43MvImQEkuyO7PY0MQhUhPBJbg5y+uA3BBKJv0Ngdwnaiu
 On3WZxGXfh7X2a6CMzQqvIb1i/XajcUAoinUNFoTRTPM/3ltMgRMbJ6fZ0qqf1MGare1Xdehz5J
 7CkWUk8otCXhSlsZVpXiMZXFKtcE+brhcMxZQ==
X-Received: by 2002:a05:6820:169e:b0:6a1:9a1a:b1eb with SMTP id
 006d021491bc7-6a35c2a5785mr2459295eaf.6.1783450704902; 
 Tue, 07 Jul 2026 11:58:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcaf73c87sm159419a34.7.2026.07.07.11.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 11:58:24 -0700 (PDT)
Date: Tue, 7 Jul 2026 12:58:21 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Daniel Golle <daniel@makrotopia.org>,
 Aristo Chen <aristo.chen@canonical.com>, Sam Day <me@samcday.com>,
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20260707185821.GN749385@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CW2nEgWunRK+gxCH"
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


--CW2nEgWunRK+gxCH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

Here's the report now that next has been merged to master. And part of
this looks like backend updates finding new issues in existing code.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Tue, Jul 7, 2026 at 12:39=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to *Das U-Boot*
found with Coverity Scan.

   - *New Defects Found:* 35
   - 10 defect(s), reported by Coverity Scan earlier, were marked fixed in
   the recent build analyzed by Coverity Scan.
   - *Defects Shown:* Showing 20 of 35 defect(s)

Defect Details

** CID 648967:       Null pointer dereferences  (NULL_RETURNS)
/api/api.c: 545           in API_env_enum()


___________________________________________________________________________=
__________________
*** CID 648967:         Null pointer dereferences  (NULL_RETURNS)
/api/api.c: 545             in API_env_enum()
539     	/* match the next entry after i */
540     	i =3D hmatch_r("", i, &match, &env_htab);
541     	if (i =3D=3D 0)
542     		goto done;
543     	buflen =3D strlen(match->key) + strlen(match->data) + 2;
544     	var =3D realloc(var, buflen);
>>>     CID 648967:         Null pointer dereferences  (NULL_RETURNS)
>>>     Dereferencing a pointer that might be "NULL" "var" when calling "sn=
printf". [Note: The source code implementation of the function has been ove=
rridden by a builtin model.]
545     	snprintf(var, buflen, "%s=3D%s", match->key, match->data);
546     	*next =3D var;
547     	return 0;
548
549     done:
550     	free(var);

** CID 648966:       Memory - illegal accesses  (STRING_NULL)


___________________________________________________________________________=
__________________
*** CID 648966:         Memory - illegal accesses  (STRING_NULL)
/boot/vbe_request.c: 204             in bootmeth_vbe_ft_fixup()
198     				    ofnode_get_name(dest), ret);
199     			if (*result.err_str) {
200     				char *msg =3D strdup(result.err_str);
201
202     				if (!msg)
203     					return log_msg_ret("msg", -ENOMEM);
>>>     CID 648966:         Memory - illegal accesses  (STRING_NULL)
>>>     Passing unterminated string "msg" to "ofnode_write_string", which e=
xpects a null-terminated string.
204     				ret =3D ofnode_write_string(dest, "vbe,error",
205     							  msg);
206     				if (ret) {
207     					free(msg);
208     					return log_msg_ret("str", -ENOMEM);
209     				}

** CID 648965:         (TOCTOU)
/tools/image-host.c: 923           in fit_image_process_verity()
/tools/image-host.c: 923           in fit_image_process_verity()


___________________________________________________________________________=
__________________
*** CID 648965:           (TOCTOU)
/tools/image-host.c: 923             in fit_image_process_verity()
917     		fprintf(stderr, "Invalid hex in veritysetup output for '%s'\n",
918     			image_name);
919     		ret =3D -EINVAL;
920     		goto err_unlink;
921     	}
922
>>>     CID 648965:           (TOCTOU)
>>>     Calling function "stat" to perform check on "tmpfile".
923     	if (stat(tmpfile, &st)) {
924     		fprintf(stderr, "Can't stat temp file: %s\n",
925     			strerror(errno));
926     		ret =3D -EIO;
927     		goto err_unlink;
928     	}
/tools/image-host.c: 923             in fit_image_process_verity()
917     		fprintf(stderr, "Invalid hex in veritysetup output for '%s'\n",
918     			image_name);
919     		ret =3D -EINVAL;
920     		goto err_unlink;
921     	}
922
>>>     CID 648965:           (TOCTOU)
>>>     Calling function "stat" to perform check on "tmpfile".
923     	if (stat(tmpfile, &st)) {
924     		fprintf(stderr, "Can't stat temp file: %s\n",
925     			strerror(errno));
926     		ret =3D -EIO;
927     		goto err_unlink;
928     	}

** CID 648964:       Memory - illegal accesses  (STRING_NULL)


___________________________________________________________________________=
__________________
*** CID 648964:         Memory - illegal accesses  (STRING_NULL)
/fs/fat/fat_write.c: 1489             in file_fat_write_at()
1483     	debug("writing %s\n", filename);
1484
1485     	filename_copy =3D strdup(filename);
1486     	if (!filename_copy)
1487     		return -ENOMEM;
1488
>>>     CID 648964:         Memory - illegal accesses  (STRING_NULL)
>>>     Passing unterminated string "filename_copy" to "split_filename", wh=
ich expects a null-terminated string.
1489     	split_filename(filename_copy, &parent, &basename);
1490     	if (!strlen(basename)) {
1491     		ret =3D -EINVAL;
1492     		goto exit;
1493     	}
1494

** CID 648963:       Memory - illegal accesses  (STRING_NULL)


___________________________________________________________________________=
__________________
*** CID 648963:         Memory - illegal accesses  (STRING_NULL)
/boot/bootmeth_extlinux.c: 164             in extlinux_read_bootflow()
158     		ret =3D bootmeth_try_file(bflow, desc, prefix, EXTLINUX_FNAME);
159     	} while (ret && prefixes && prefixes[++i]);
160     	if (ret)
161     		return log_msg_ret("try", ret);
162     	size =3D bflow->size;
163
>>>     CID 648963:         Memory - illegal accesses  (STRING_NULL)
>>>     Passing unterminated string "bflow->fname" to "bootmeth_alloc_file"=
, which expects a null-terminated string.
164     	ret =3D bootmeth_alloc_file(bflow, 0x10000, ARCH_DMA_MINALIGN,
165     				  BFI_EXTLINUX_CFG);
166     	if (ret)
167     		return log_msg_ret("read", ret);
168
169     	ret =3D extlinux_fill_info(bflow);

** CID 648962:         (STRING_NULL)


___________________________________________________________________________=
__________________
*** CID 648962:           (STRING_NULL)
/drivers/dfu/dfu.c: 183             in dfu_init_env_entities()
177     		pr_err("\"dfu_alt_info\" env variable not defined!\n");
178     		return -EINVAL;
179     	}
180
181     	env_bkp =3D strdup(str_env);
182     	if (!interface && !devstr)
>>>     CID 648962:           (STRING_NULL)
>>>     Passing unterminated string "env_bkp" to "dfu_config_interfaces", w=
hich expects a null-terminated string.
183     		ret =3D dfu_config_interfaces(env_bkp);
184     	else
185     		ret =3D dfu_config_entities(env_bkp, interface, devstr);
186
187     	if (ret) {
188     		pr_err("DFU entities configuration failed: %d\n", ret);
/drivers/dfu/dfu.c: 185             in dfu_init_env_entities()
179     	}
180
181     	env_bkp =3D strdup(str_env);
182     	if (!interface && !devstr)
183     		ret =3D dfu_config_interfaces(env_bkp);
184     	else
>>>     CID 648962:           (STRING_NULL)
>>>     Passing unterminated string "env_bkp" to "dfu_config_entities", whi=
ch expects a null-terminated string.
185     		ret =3D dfu_config_entities(env_bkp, interface, devstr);
186
187     	if (ret) {
188     		pr_err("DFU entities configuration failed: %d\n", ret);
189     		pr_err("(partition table does not match dfu_alt_info?)\n");
190     		goto done;

** CID 648961:         (STRING_NULL)


___________________________________________________________________________=
__________________
*** CID 648961:           (STRING_NULL)
/fs/squashfs/sqfs.c: 1243             in sqfs_split_path()
1237     		}
1238     		tmp_path[0] =3D '/';
1239     		strcpy(tmp_path + 1, path);
1240     	}
1241
1242     	/* String duplicates */
>>>     CID 648961:           (STRING_NULL)
>>>     Passing unterminated string "tmp_path" to "sandbox_strdup", which e=
xpects a null-terminated string.
1243     	dirc =3D strdup(tmp_path);
1244     	if (!dirc) {
1245     		ret =3D -ENOMEM;
1246     		goto out;
1247     	}
1248
/fs/squashfs/sqfs.c: 1255             in sqfs_split_path()
1249     	basec =3D strdup(tmp_path);
1250     	if (!basec) {
1251     		ret =3D -ENOMEM;
1252     		goto out;
1253     	}
1254
>>>     CID 648961:           (STRING_NULL)
>>>     Passing unterminated string "dirc" to "sqfs_dirname", which expects=
 a null-terminated string.
1255     	dname =3D sqfs_dirname(dirc);
1256     	bname =3D sqfs_basename(basec);
1257
1258     	*file =3D strdup(bname);
1259
1260     	if (!*file) {
/fs/squashfs/sqfs.c: 1256             in sqfs_split_path()
1250     	if (!basec) {
1251     		ret =3D -ENOMEM;
1252     		goto out;
1253     	}
1254
1255     	dname =3D sqfs_dirname(dirc);
>>>     CID 648961:           (STRING_NULL)
>>>     Passing unterminated string "basec" to "sqfs_basename", which expec=
ts a null-terminated string.
1256     	bname =3D sqfs_basename(basec);
1257
1258     	*file =3D strdup(bname);
1259
1260     	if (!*file) {
1261     		ret =3D -ENOMEM;

** CID 648944:       Memory - illegal accesses  (STRING_NULL)
/cmd/gpt.c: 60           in extract_env()


___________________________________________________________________________=
__________________
*** CID 648944:         Memory - illegal accesses  (STRING_NULL)
/cmd/gpt.c: 60             in extract_env()
54     		return -1;
55
56     	s =3D strdup(str);
57     	if (s =3D=3D NULL)
58     		return -1;
59
>>>     CID 648944:         Memory - illegal accesses  (STRING_NULL)
>>>     Passing unterminated string "s" to "strlen", which expects a null-t=
erminated string. [Note: The source code implementation of the function has=
 been overridden by a builtin model.]
60     	memset(s + strlen(s) - 1, '\0', 1);
61     	memmove(s, s + 2, strlen(s) - 1);
62
63     	e =3D env_get(s);
64     	if (e =3D=3D NULL) {
65     #ifdef CONFIG_RANDOM_UUID

** CID 648943:         (STRING_NULL)


___________________________________________________________________________=
__________________
*** CID 648943:           (STRING_NULL)
/fs/fat/fat_write.c: 2013             in fat_rename()
2007     	if (!old_path_copy || !new_path_copy || !old_itr || !new_itr) {
2008     		log_debug("Error: out of memory\n");
2009     		ret =3D -ENOMEM;
2010     		goto exit;
2011     	}
2012     	split_filename(old_path_copy, &old_dirname, &old_basename);
>>>     CID 648943:           (STRING_NULL)
>>>     Passing unterminated string "new_path_copy" to "split_filename", wh=
ich expects a null-terminated string.
2013     	split_filename(new_path_copy, &new_dirname, &new_basename);
2014
2015     	if (normalize_longname(l_new_basename, new_basename)) {
2016     		log_debug("FAT: illegal filename (%s)\n", new_basename);
2017     		ret =3D -EINVAL;
2018     		goto exit;
/fs/fat/fat_write.c: 2012             in fat_rename()
2006     	new_itr =3D malloc_cache_aligned(sizeof(fat_itr));
2007     	if (!old_path_copy || !new_path_copy || !old_itr || !new_itr) {
2008     		log_debug("Error: out of memory\n");
2009     		ret =3D -ENOMEM;
2010     		goto exit;
2011     	}
>>>     CID 648943:           (STRING_NULL)
>>>     Passing unterminated string "old_path_copy" to "split_filename", wh=
ich expects a null-terminated string.
2012     	split_filename(old_path_copy, &old_dirname, &old_basename);
2013     	split_filename(new_path_copy, &new_dirname, &new_basename);
2014
2015     	if (normalize_longname(l_new_basename, new_basename)) {
2016     		log_debug("FAT: illegal filename (%s)\n", new_basename);
2017     		ret =3D -EINVAL;

** CID 648942:       Memory - illegal accesses  (STRING_NULL)


___________________________________________________________________________=
__________________
*** CID 648942:         Memory - illegal accesses  (STRING_NULL)
/boot/bootmeth_android.c: 414             in avb_append_commandline()
408     static int avb_append_commandline(struct bootflow *bflow, char *cmd=
line)
409     {
410     	char *arg =3D strsep(&cmdline, " ");
411     	int ret;
412
413     	while (arg) {
>>>     CID 648942:         Memory - illegal accesses  (STRING_NULL)
>>>     Passing unterminated string "bflow->cmdline" to "avb_append_command=
line_arg", which expects a null-terminated string.
414     		ret =3D avb_append_commandline_arg(bflow, arg);
415     		if (ret < 0)
416     			return ret;
417
418     		arg =3D strsep(&cmdline, " ");
419     	}

** CID 648941:       Memory - illegal accesses  (STRING_NULL)


___________________________________________________________________________=
__________________
*** CID 648941:         Memory - illegal accesses  (STRING_NULL)
/fs/fat/fat_write.c: 1738             in fat_unlink()
1732     	itr =3D malloc_cache_aligned(sizeof(fat_itr));
1733     	if (!itr || !filename_copy) {
1734     		printf("Error: out of memory\n");
1735     		ret =3D -ENOMEM;
1736     		goto exit;
1737     	}
>>>     CID 648941:         Memory - illegal accesses  (STRING_NULL)
>>>     Passing unterminated string "filename_copy" to "split_filename", wh=
ich expects a null-terminated string.
1738     	split_filename(filename_copy, &dirname, &basename);
1739
1740     	if (!strcmp(dirname, "/") && !strcmp(basename, "")) {
1741     		printf("Error: cannot remove root\n");
1742     		ret =3D -EINVAL;
1743     		goto exit;

** CID 648940:       Memory - illegal accesses  (STRING_NULL)
/common/cli_hush.c: 2169           in set_local_var()


___________________________________________________________________________=
__________________
*** CID 648940:         Memory - illegal accesses  (STRING_NULL)
/common/cli_hush.c: 2169             in set_local_var()
2163
2164     	name=3Dstrdup(s);
2165
2166     	/* Assume when we enter this function that we are already in
2167     	 * NAME=3DVALUE format.  So the first order of business is to
2168     	 * split 's' on the '=3D' into 'name' and 'value' */
>>>     CID 648940:         Memory - illegal accesses  (STRING_NULL)
>>>     Passing unterminated string "name" to "strchr", which expects a nul=
l-terminated string. [Note: The source code implementation of the function =
has been overridden by a builtin model.]
2169     	value =3D strchr(name, '=3D');
2170     	if (!value) {
2171     		free(name);
2172     		return -1;
2173     	}
2174     	*value++ =3D 0;

** CID 648939:         (STRING_NULL)


___________________________________________________________________________=
__________________
*** CID 648939:           (STRING_NULL)
/boot/bootmeth_script.c: 110             in script_read_bootflow_file()
104     		return log_msg_ret("read", ret);
105
106     	ret =3D script_fill_info(bflow);
107     	if (ret)
108     		return log_msg_ret("inf", ret);
109
>>>     CID 648939:           (STRING_NULL)
>>>     Passing unterminated string "bflow->subdir" to "bootmeth_alloc_othe=
r", which expects a null-terminated string.
110     	ret =3D bootmeth_alloc_other(bflow, "boot.bmp", BFI_LOGO,
111     				   &bflow->logo, &bflow->logo_size);
112     	/* ignore error */
113
114     	return 0;
115     }
/boot/bootmeth_script.c: 101             in script_read_bootflow_file()
95     		return log_msg_ret("try", ret);
96
97     	bflow->subdir =3D strdup(prefix ? prefix : "");
98     	if (!bflow->subdir)
99     		return log_msg_ret("prefix", -ENOMEM);
100
>>>     CID 648939:           (STRING_NULL)
>>>     Passing unterminated string "bflow->fname" to "bootmeth_alloc_file"=
, which expects a null-terminated string.
101     	ret =3D bootmeth_alloc_file(bflow, 0x10000, ARCH_DMA_MINALIGN,
102     				  (enum bootflow_img_t)IH_TYPE_SCRIPT);
103     	if (ret)
104     		return log_msg_ret("read", ret);
105
106     	ret =3D script_fill_info(bflow);
/boot/bootmeth_script.c: 101             in script_read_bootflow_file()
95     		return log_msg_ret("try", ret);
96
97     	bflow->subdir =3D strdup(prefix ? prefix : "");
98     	if (!bflow->subdir)
99     		return log_msg_ret("prefix", -ENOMEM);
100
>>>     CID 648939:           (STRING_NULL)
>>>     Passing unterminated string "bflow->fname" to "bootmeth_alloc_file"=
, which expects a null-terminated string.
101     	ret =3D bootmeth_alloc_file(bflow, 0x10000, ARCH_DMA_MINALIGN,
102     				  (enum bootflow_img_t)IH_TYPE_SCRIPT);
103     	if (ret)
104     		return log_msg_ret("read", ret);
105
106     	ret =3D script_fill_info(bflow);

** CID 648938:       Error handling issues  (CHECKED_RETURN)
/cmd/fastboot.c: 108           in do_fastboot_usb()


___________________________________________________________________________=
__________________
*** CID 648938:         Error handling issues  (CHECKED_RETURN)
/cmd/fastboot.c: 108             in do_fastboot_usb()
102
103     	while (1) {
104     		if (g_dnl_detach())
105     			break;
106     		if (IS_ENABLED(CONFIG_CMD_FASTBOOT_ABORT_KEYED)) {
107     			if (tstc()) {
>>>     CID 648938:         Error handling issues  (CHECKED_RETURN)
>>>     Calling "getchar()" without checking return value. This library fun=
ction may fail and return an error code. [Note: The source code implementat=
ion of the function has been overridden by a builtin model.]
108     				getchar();
109     				puts("\rOperation aborted.\n");
110     				break;
111     			}
112     		} else if (ctrlc()) {
113     			break;

** CID 648937:         (TAINTED_SCALAR)
/boot/image-fit.c: 259           in fit_image_print_dm_verity()
/boot/image-fit.c: 259           in fit_image_print_dm_verity()
/boot/image-fit.c: 268           in fit_image_print_dm_verity()
/boot/image-fit.c: 268           in fit_image_print_dm_verity()


___________________________________________________________________________=
__________________
*** CID 648937:           (TAINTED_SCALAR)
/boot/image-fit.c: 259             in fit_image_print_dm_verity()
253     		printf("%s  Verity algo:  %s\n", p, algo);
254
255     	bin =3D fdt_getprop(fit, noffset, FIT_VERITY_DIGEST_PROP,
256     			  &len);
257     	if (bin && len > 0) {
258     		printf("%s  Verity hash:  ", p);
>>>     CID 648937:           (TAINTED_SCALAR)
>>>     Using tainted variable "len" as a loop boundary.
259     		for (i =3D 0; i < len; i++)
260     			printf("%02x", bin[i]);
261     		printf("\n");
262     	}
263
264     	bin =3D fdt_getprop(fit, noffset, FIT_VERITY_SALT_PROP,
/boot/image-fit.c: 259             in fit_image_print_dm_verity()
253     		printf("%s  Verity algo:  %s\n", p, algo);
254
255     	bin =3D fdt_getprop(fit, noffset, FIT_VERITY_DIGEST_PROP,
256     			  &len);
257     	if (bin && len > 0) {
258     		printf("%s  Verity hash:  ", p);
>>>     CID 648937:           (TAINTED_SCALAR)
>>>     Using tainted variable "len" as a loop boundary.
259     		for (i =3D 0; i < len; i++)
260     			printf("%02x", bin[i]);
261     		printf("\n");
262     	}
263
264     	bin =3D fdt_getprop(fit, noffset, FIT_VERITY_SALT_PROP,
/boot/image-fit.c: 268             in fit_image_print_dm_verity()
262     	}
263
264     	bin =3D fdt_getprop(fit, noffset, FIT_VERITY_SALT_PROP,
265     			  &len);
266     	if (bin && len > 0) {
267     		printf("%s  Verity salt:  ", p);
>>>     CID 648937:           (TAINTED_SCALAR)
>>>     Using tainted variable "len" as a loop boundary.
268     		for (i =3D 0; i < len; i++)
269     			printf("%02x", bin[i]);
270     		printf("\n");
271     	}
272     #endif
273     }
/boot/image-fit.c: 268             in fit_image_print_dm_verity()
262     	}
263
264     	bin =3D fdt_getprop(fit, noffset, FIT_VERITY_SALT_PROP,
265     			  &len);
266     	if (bin && len > 0) {
267     		printf("%s  Verity salt:  ", p);
>>>     CID 648937:           (TAINTED_SCALAR)
>>>     Using tainted variable "len" as a loop boundary.
268     		for (i =3D 0; i < len; i++)
269     			printf("%02x", bin[i]);
270     		printf("\n");
271     	}
272     #endif
273     }

** CID 648936:         (STRING_NULL)
/fs/squashfs/sqfs.c: 1417           in sqfs_read_nest()


___________________________________________________________________________=
__________________
*** CID 648936:           (STRING_NULL)
/fs/squashfs/sqfs.c: 1408             in sqfs_read_nest()
1402
1403     	/*
1404     	 * sqfs_opendir_nest will uncompress inode and directory
tables, and will
1405     	 * return a pointer to the directory that contains the requested =
file.
1406     	 */
1407     	sqfs_split_path(&file, &dir, filename);
>>>     CID 648936:           (STRING_NULL)
>>>     Passing unterminated string "dir" to "sqfs_opendir_nest", which exp=
ects a null-terminated string.
1408     	ret =3D sqfs_opendir_nest(dir, &dirsp);
1409     	if (ret) {
1410     		goto out;
1411     	}
1412
1413     	dirs =3D (struct squashfs_dir_stream *)dirsp;
/fs/squashfs/sqfs.c: 1417             in sqfs_read_nest()
1411     	}
1412
1413     	dirs =3D (struct squashfs_dir_stream *)dirsp;
1414
1415     	/* For now, only regular files are able to be loaded */
1416     	while (!sqfs_readdir_nest(dirsp, &dent)) {
>>>     CID 648936:           (STRING_NULL)
>>>     Passing unterminated string "file" to "strcmp", which expects a nul=
l-terminated string. [Note: The source code implementation of the function =
has been overridden by a builtin model.]
1417     		ret =3D strcmp(dent->name, file);
1418     		if (!ret)
1419     			break;
1420
1421     		free(dirs->entry);
1422     		dirs->entry =3D NULL;

** CID 648935:       Integer handling issues  (INTEGER_OVERFLOW)
/test/boot/fit_verity.c: 257           in fit_verity_test_bad_blocksize()


___________________________________________________________________________=
__________________
*** CID 648935:         Integer handling issues  (INTEGER_OVERFLOW)
/test/boot/fit_verity.c: 257             in fit_verity_test_bad_blocksize()
251     	struct bootm_headers images;
252     	int images_node, conf_node, confs_node, img_node, verity_node;
253     	fdt32_t val;
254     	int ret;
255
256     	ret =3D fdt_create_empty_tree(buf, FIT_BUF_SIZE);
>>>     CID 648935:         Integer handling issues  (INTEGER_OVERFLOW)
>>>     Expression "_val2", where "ret" is known to be equal to -18, overfl=
ows the type of "_val2", which is type "unsigned int".
257     	ut_assertok(ret);
258
259     	images_node =3D fdt_add_subnode(buf, 0, "images");
260     	ut_assert(images_node >=3D 0);
261
262     	img_node =3D fdt_add_subnode(buf, images_node, "rootfs");

** CID 648934:       Memory - illegal accesses  (STRING_NULL)
/common/iomux.c: 58           in iomux_doenv()


___________________________________________________________________________=
__________________
*** CID 648934:         Memory - illegal accesses  (STRING_NULL)
/common/iomux.c: 58             in iomux_doenv()
52     	i =3D 0;
53     	temp =3D console_args;
54     	for (;;) {
55     		/* There's always one entry more than the number of commas. */
56     		i++;
57
>>>     CID 648934:         Memory - illegal accesses  (STRING_NULL)
>>>     Passing unterminated string "temp" to "strchr", which expects a nul=
l-terminated string. [Note: The source code implementation of the function =
has been overridden by a builtin model.]
58     		temp =3D strchr(temp, ',');
59     		if (temp =3D=3D NULL)
60     			break;
61
62     		temp++;
63     	}

** CID 648933:       Memory - illegal accesses  (STRING_NULL)
/fs/squashfs/sqfs.c: 316           in sqfs_tokenize()


___________________________________________________________________________=
__________________
*** CID 648933:         Memory - illegal accesses  (STRING_NULL)
/fs/squashfs/sqfs.c: 316             in sqfs_tokenize()
310     	char *aux, *strc;
311
312     	strc =3D strdup(str);
313     	if (!strc)
314     		return -ENOMEM;
315
>>>     CID 648933:         Memory - illegal accesses  (STRING_NULL)
>>>     Passing unterminated string "strc" to "strcmp", which expects a nul=
l-terminated string. [Note: The source code implementation of the function =
has been overridden by a builtin model.]
316     	if (!strcmp(strc, "/")) {
317     		tokens[0] =3D strdup(strc);
318     		if (!tokens[0]) {
319     			ret =3D -ENOMEM;
320     			goto free_strc;
321     		}

** CID 648960:         (TAINTED_SCALAR)
/test/boot/image_fdt.c: 53           in test_boot_fdt_add_mem_rsv_regions()


___________________________________________________________________________=
__________________
*** CID 648960:           (TAINTED_SCALAR)
/test/boot/image_fdt.c: 80             in test_boot_fdt_add_mem_rsv_regions=
()
74
75     	/* Cleanup */
76     switch_fdt:
77     	boot_fdt_add_mem_rsv_regions(old_blob);
78     	gd->fdt_blob =3D old_blob;
79     free_blob:
>>>     CID 648960:           (TAINTED_SCALAR)
>>>     Passing tainted expression "*new_blob" to "dlfree", which uses it a=
s an offset.
80     	free(new_blob);
81     	return ret;
82     }
/test/boot/image_fdt.c: 53             in test_boot_fdt_add_mem_rsv_regions=
()
47     	ut_assert_console_end();
48
49     	/* Loading a new_blob device tree should be allowed */
50     	fdt_sz =3D fdt_totalsize(gd->fdt_blob);
51     	new_blob =3D malloc(fdt_sz);
52     	ut_assertnonnull(new_blob);
>>>     CID 648960:           (TAINTED_SCALAR)
>>>     Passing tainted expression "fdt_sz" to "memcpy", which uses it as a=
n offset. [Note: The source code implementation of the function has been ov=
erridden by a builtin model.]
53     	memcpy(new_blob, gd->fdt_blob, fdt_sz);
54
55     	nodeoffset =3D fdt_path_offset(new_blob, "/reserved-memory");
56     	if (nodeoffset < 0)
57     		goto free_blob;
58



View Defects in Coverity Scan
<https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>

Best regards,

The Coverity Scan Admin Team

----- End forwarded message -----

--=20
Tom

--CW2nEgWunRK+gxCH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak1MSgAKCRAr4qD1Cr/k
CkJ3APsGnVLnILaxHpMf9N23zUGAo8094URw6G5OxlFEr345AAEAkkEN01f59lzN
5CAvGFs24fSPZzu4hW6AiRWNYqewsA4=
=e1uZ
-----END PGP SIGNATURE-----

--CW2nEgWunRK+gxCH--
