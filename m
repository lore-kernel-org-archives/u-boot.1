Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DE7C83F09
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 14:10:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD833832F0;
	Tue,  8 Jul 2025 16:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hYYlPNJh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B34B78331D; Tue,  8 Jul 2025 16:10:19 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73A1683297
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 16:10:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2efc0ed41efso1962451fac.1
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 07:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751983815; x=1752588615; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J4SQ3OqcvQyGl4LNtOOU+devulqHeWSw72BcP3hoGkI=;
 b=hYYlPNJhQkYplk8vyo/8FOeV0nxpog+FSbBYlagysHV9DHpB0bM4siUhbe/Wd3KYOY
 befi39cqIlz30PTJ77LwI8zcS3OugfIjdfOsRkPPiTC67vmNPjTt8GfQp21DwrwhR/DJ
 2qU7SV4x0prSGNJnSU9IvHD5nv8STkcJQq05M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751983815; x=1752588615;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J4SQ3OqcvQyGl4LNtOOU+devulqHeWSw72BcP3hoGkI=;
 b=AGvHM8Hep/sIiHdrkRKOVBf498Qt7lUnk6Vf+03QnknIwDf1er/I9OhBiWn8EUr3GN
 xZAUNQLMURkvrdYtsJB/WZj+HKcBMTA7+TN2iUSAI8H08+HZ3ozcBUiRyMrQJdslYAFJ
 lIuKahHQkOqy97ISihuOu9xGMNc8qpNFvTkb7viOGqAxCko6Nn1/IQZN+sfBQrsgH/Ed
 FXohOeS0Cr4XZ4GL46YtbSvtGhsI4xl0P6fa39wPDBQ46Dksco30Yj5w7G5sxi3djQBZ
 bRRnu2jQCDIUuTP0r9pRwJ+cBZM0MxDHjhvG8TKqLTCq0qBk2N8zehTWXOBf2PsqE10B
 KwZQ==
X-Gm-Message-State: AOJu0YxRNxzVlv3QX3KR+AbZfxeKQ4S/zGX/ddXpB/Tgs4yi3QyLDYvS
 O3rWKL5DhmQi+GbgFJSOI7bH2KesEn04TrRwmuRldIP9xnnDrr5eA8VHqJLDdpQzRkvoaY64pEb
 fsGv8G2g=
X-Gm-Gg: ASbGncuhEZMh5Prljetxjd4lMnYVeWEh30Akku11cx63/jC8CQ1RYqi9sd4x8zkq7ZD
 2CCKwNu6kfgYpIz/n4rrxiDRSeav6W6s1t5NOTlngHnj6dixfOOariZ8ZWxPk60xdd8dwEpwuLk
 8tJmCAHwrbcsoG6UhP47xc3o6T2c9EUS81PS4OlPfTg5wrlofuDjQ6hupR8GVlxpgJTcpzcAVgV
 W0etwZdSaaIfLY0QmgTb8hKihFNF5wVO/77ehbCKeyAadwqcI9EeCSkIiWcM5mbuwqpCYY9/uxu
 XUhSxq+gTook8rGsP3UzvmXXk9GR6/aLUnDQDzYPxqtiS2vZ3oZyP9obhx0AZ2NeMMUFszJmH3u
 kbZ1xnqntn6LXxqvATTtr
X-Google-Smtp-Source: AGHT+IHu2DWGfae/dljh5Nx+1szD6x16gukCZkCuk9hIDckvskNqETOeoArSUSvEinCIBgqzEFp4jQ==
X-Received: by 2002:a05:6871:2316:b0:2ea:7963:534e with SMTP id
 586e51a60fabf-2fb6c943bffmr2492853fac.14.1751983814853; 
 Tue, 08 Jul 2025 07:10:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff4c088sm2876419fac.18.2025.07.08.07.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 07:10:14 -0700 (PDT)
Date: Tue, 8 Jul 2025 08:10:11 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Sean Edmond <seanedmond@microsoft.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20250708141011.GT6424@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3yv6Nc6xAuDTb5xc"
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


--3yv6Nc6xAuDTb5xc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

Good news, Coverity Scan resumed putting information in the email
report. Bad news, 20 new issues now that next has been merged.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Mon, Jul 7, 2025 at 5:39=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to *Das U-Boot*
found with Coverity Scan.

   - *New Defects Found:* 20
   - 6 defect(s), reported by Coverity Scan earlier, were marked fixed in
   the recent build analyzed by Coverity Scan.
   - *Defects Shown:* Showing 20 of 20 defect(s)

Defect Details

** CID 569500:       Incorrect expression  (UNUSED_VALUE)
/boot/bootflow_menu.c: 158           in bootflow_menu_add()


___________________________________________________________________________=
__________________
*** CID 569500:         Incorrect expression  (UNUSED_VALUE)
/boot/bootflow_menu.c: 158             in bootflow_menu_add()
152
153     	if (!label) {
154     		free(key);
155     		return log_msg_ret("nam", -ENOMEM);
156     	}
157
>>>     CID 569500:         Incorrect expression  (UNUSED_VALUE)
>>>     Assigning value from "priv->last_bootdev !=3D bflow->dev" to "add_g=
ap" here, but that stored value is overwritten before it can be used.
158     	add_gap =3D priv->last_bootdev !=3D bflow->dev;
159
160     	/* disable this gap for now, since it looks a little ugly */
161     	add_gap =3D false;
162     	priv->last_bootdev =3D bflow->dev;
163

** CID 569499:       Null pointer dereferences  (NULL_RETURNS)
/lib/efi_loader/efi_memory.c: 719           in efi_realloc()


___________________________________________________________________________=
__________________
*** CID 569499:         Null pointer dereferences  (NULL_RETURNS)
/lib/efi_loader/efi_memory.c: 719             in efi_realloc()
713     	old_size =3D alloc->num_pages * EFI_PAGE_SIZE -
714     		sizeof(struct efi_pool_allocation);
715
716     	new_ptr =3D efi_alloc(size);
717
718     	/* copy old data to new alloced buffer */
>>>     CID 569499:         Null pointer dereferences  (NULL_RETURNS)
>>>     Dereferencing a pointer that might be "NULL" "new_ptr" when calling=
 "memcpy". [Note: The source code implementation of the function has been o=
verridden by a builtin model.]
719     	memcpy(new_ptr, *ptr, min(size, old_size));
720
721     	/* free the old buffer */
722     	efi_free_pool(*ptr);
723
724     	*ptr =3D new_ptr;

** CID 569498:       Code maintainability issues  (SIZEOF_MISMATCH)
/lib/efi_loader/efi_debug_support.c: 163           in
efi_core_remove_debug_image_info_entry()


___________________________________________________________________________=
__________________
*** CID 569498:         Code maintainability issues  (SIZEOF_MISMATCH)
/lib/efi_loader/efi_debug_support.c: 163             in
efi_core_remove_debug_image_info_entry()
157     		    table[index].normal_image->image_handle =3D=3D image_handle) {
158     			/* Found a match. Free up the table entry.
159     			 * Move the tail of the table one slot to the front.
160     			 */
161     			efi_free_pool(table[index].normal_image);
162
>>>     CID 569498:         Code maintainability issues  (SIZEOF_MISMATCH)
>>>     Passing argument "&table[index]" of type "union efi_debug_image_inf=
o *" and argument "(efi_m_debug_info_table_header.table_size - index - 1) *=
 8UL /* sizeof (union efi_debug_image_info *) */" to function "memmove" is =
suspicious. In this case, "sizeof (union efi_debug_image_info *)" is equal =
to "sizeof (union efi_debug_image_info)", but this is not a portable assump=
tion.
163     			memmove(&table[index],
164     				&table[index + 1],
165     				(efi_m_debug_info_table_header.table_size -
166     				 index - 1) * EFI_DEBUG_TABLE_ENTRY_SIZE);
167
168     			/* Decrease the number of EFI_DEBUG_IMAGE_INFO

** CID 569497:       Null pointer dereferences  (FORWARD_NULL)
/lib/efi_selftest/efi_selftest_esrt.c: 73           in
efi_test_fmp_get_image_info()


___________________________________________________________________________=
__________________
*** CID 569497:         Null pointer dereferences  (FORWARD_NULL)
/lib/efi_selftest/efi_selftest_esrt.c: 73             in
efi_test_fmp_get_image_info()
67     	if (package_version)
68     		*package_version =3D 0xffffffff;
69     	if (package_version_name)
70     		*package_version_name =3D NULL;
71
72     	if (*image_info_size < sizeof(*image_info)) {
>>>     CID 569497:         Null pointer dereferences  (FORWARD_NULL)
>>>     Dereferencing null pointer "descriptor_count".
73     		*image_info_size =3D *descriptor_size * *descriptor_count;
74     		return EFI_BUFFER_TOO_SMALL;
75     	}
76
77     	for (int idx =3D 0; idx < TEST_ESRT_NUM_ENTRIES; idx++)
78     		image_info[idx] =3D static_img_info[idx];

** CID 569496:       Integer handling issues  (INTEGER_OVERFLOW)
/drivers/usb/emul/sandbox_hub.c: 298           in sandbox_child_post_bind()


___________________________________________________________________________=
__________________
*** CID 569496:         Integer handling issues  (INTEGER_OVERFLOW)
/drivers/usb/emul/sandbox_hub.c: 298             in sandbox_child_post_bind=
()
292     static int sandbox_child_post_bind(struct udevice *dev)
293     {
294     	struct sandbox_hub_plat *plat =3D dev_get_parent_plat(dev);
295     	struct usb_emul_plat *emul =3D dev_get_uclass_plat(dev);
296
297     	plat->port =3D dev_read_u32_default(dev, "reg", -1);
>>>     CID 569496:         Integer handling issues  (INTEGER_OVERFLOW)
>>>     Expression "plat->port + 1", where "plat->port" is known to be equa=
l to -1, overflows the type of "plat->port + 1", which is type "int".
298     	emul->port1 =3D plat->port + 1;
299
300     	return 0;
301     }
302
303     static const struct dm_usb_ops sandbox_usb_hub_ops =3D {

** CID 569495:       Integer handling issues  (NEGATIVE_RETURNS)


___________________________________________________________________________=
__________________
*** CID 569495:         Integer handling issues  (NEGATIVE_RETURNS)
/tools/fit_image.c: 921             in fit_handle_file()
915     	do {
916     		if (copyfile(bakfile, tmpfile) < 0) {
917     			printf("Can't copy %s to %s\n", bakfile, tmpfile);
918     			ret =3D -EIO;
919     			break;
920     		}
>>>     CID 569495:         Integer handling issues  (NEGATIVE_RETURNS)
>>>     "size_inc" is passed to a parameter that cannot be negative.
921     		ret =3D fit_add_file_data(params, size_inc, tmpfile);
922     		if (!ret || ret !=3D -ENOSPC)
923     			break;
924     		size_inc +=3D 1024;
925     	} while (size_inc < 64 * 1024);
926

** CID 569494:       Control flow issues  (DEADCODE)
/lib/efi_selftest/efi_selftest_config_table.c: 129           in execute()


___________________________________________________________________________=
__________________
*** CID 569494:         Control flow issues  (DEADCODE)
/lib/efi_selftest/efi_selftest_config_table.c: 129             in execute()
123     		return EFI_ST_FAILURE;
124     	}
125     	if (counter !=3D 1) {
126     		efi_st_error("Notification function was not called.\n");
127     		return EFI_ST_FAILURE;
128     	}
>>>     CID 569494:         Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "if (table_count !=3D sys_ta=
bl...".
129     	if (table_count !=3D sys_table->nr_tables) {
130     		efi_st_error("Incorrect table count %u, expected %u\n",
131     			     (unsigned int)sys_table->nr_tables,
132     			     (unsigned int)table_count);
133     		return EFI_ST_FAILURE;
134     	}

** CID 569493:       Insecure data handling  (TAINTED_SCALAR)


___________________________________________________________________________=
__________________
*** CID 569493:         Insecure data handling  (TAINTED_SCALAR)
/lib/efi_selftest/efi_selftest_esrt.c: 276             in execute()
270     		efi_st_error("ESRT mismatch in new entry count (%d),
expected (%d).\n",
271     			     entry_delta, TEST_ESRT_NUM_ENTRIES);
272     		return EFI_ST_FAILURE;
273     	}
274
275     	for (u32 idx =3D 0; idx < TEST_ESRT_NUM_ENTRIES; idx++)
>>>     CID 569493:         Insecure data handling  (TAINTED_SCALAR)
>>>     Passing tainted expression "esrt->fw_resource_count" to "lib_test_c=
heck_uuid_entry", which uses it as a loop boundary.
276     		if (!lib_test_check_uuid_entry(esrt, &static_img_info[idx])) {
277     			efi_st_error("ESRT entry mismatch\n");
278     			return EFI_ST_FAILURE;
279     		}
280
281     	return EFI_ST_SUCCESS;

** CID 569492:         (DC.WEAK_CRYPTO)
/net/bootp.c: 442           in bootp_timeout_handler()
/net/bootp.c: 441           in bootp_timeout_handler()


___________________________________________________________________________=
__________________
*** CID 569492:           (DC.WEAK_CRYPTO)
/net/bootp.c: 442             in bootp_timeout_handler()
436     			bootp_timeout =3D retransmit_period_max_ms;
437
438     		/* Randomize by adding bootp_timeout*RAND, where RAND
439     		 * is a randomization factor between -0.1..+0.1
440     		 */
441     		srand(get_ticks() + rand());
>>>     CID 569492:           (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security-related applications, becaus=
e linear congruential algorithms are too easy to break.
442     		rand_minus_plus_100 =3D ((rand() % 200) - 100);
443     		bootp_timeout =3D bootp_timeout +
444     				(((int)bootp_timeout * rand_minus_plus_100) / 1000);
445
446     		net_set_timeout_handler(bootp_timeout, bootp_timeout_handler);
447     		bootp_request();
/net/bootp.c: 441             in bootp_timeout_handler()
435     		if (bootp_timeout > retransmit_period_max_ms)
436     			bootp_timeout =3D retransmit_period_max_ms;
437
438     		/* Randomize by adding bootp_timeout*RAND, where RAND
439     		 * is a randomization factor between -0.1..+0.1
440     		 */
>>>     CID 569492:           (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security-related applications, becaus=
e linear congruential algorithms are too easy to break.
441     		srand(get_ticks() + rand());
442     		rand_minus_plus_100 =3D ((rand() % 200) - 100);
443     		bootp_timeout =3D bootp_timeout +
444     				(((int)bootp_timeout * rand_minus_plus_100) / 1000);
445
446     		net_set_timeout_handler(bootp_timeout, bootp_timeout_handler);

** CID 569491:       Error handling issues  (NEGATIVE_RETURNS)
/tools/file2include.c: 56           in main()


___________________________________________________________________________=
__________________
*** CID 569491:         Error handling issues  (NEGATIVE_RETURNS)
/tools/file2include.c: 56             in main()
50     	if (!count) {
51     		fprintf(stderr, "File %s has length 0\n", argv[1]);
52     		return EXIT_FAILURE;
53     	}
54     	rewind(file);
55     	/* Read file */
>>>     CID 569491:         Error handling issues  (NEGATIVE_RETURNS)
>>>     "count" is passed to a parameter that cannot be negative.
56     	buf =3D malloc(count);
57     	if (!buf) {
58     		perror("calloc");
59     		return EXIT_FAILURE;
60     	}
61     	count =3D fread(buf, 1, count, file);

** CID 569490:       Null pointer dereferences  (FORWARD_NULL)
/lib/efi_selftest/efi_selftest_esrt.c: 73           in
efi_test_fmp_get_image_info()


___________________________________________________________________________=
__________________
*** CID 569490:         Null pointer dereferences  (FORWARD_NULL)
/lib/efi_selftest/efi_selftest_esrt.c: 73             in
efi_test_fmp_get_image_info()
67     	if (package_version)
68     		*package_version =3D 0xffffffff;
69     	if (package_version_name)
70     		*package_version_name =3D NULL;
71
72     	if (*image_info_size < sizeof(*image_info)) {
>>>     CID 569490:         Null pointer dereferences  (FORWARD_NULL)
>>>     Dereferencing null pointer "descriptor_size".
73     		*image_info_size =3D *descriptor_size * *descriptor_count;
74     		return EFI_BUFFER_TOO_SMALL;
75     	}
76
77     	for (int idx =3D 0; idx < TEST_ESRT_NUM_ENTRIES; idx++)
78     		image_info[idx] =3D static_img_info[idx];

** CID 569489:       Integer handling issues  (INTEGER_OVERFLOW)
/lib/efi_selftest/efi_selftest_bitblt.c: 83           in notify()


___________________________________________________________________________=
__________________
*** CID 569489:         Integer handling issues  (INTEGER_OVERFLOW)
/lib/efi_selftest/efi_selftest_bitblt.c: 83             in notify()
77     	/* Increment position */
78     	pos->x +=3D 5;
79     	if (pos->x >=3D WIDTH + gop->mode->info->width)
80     		pos->x =3D 0;
81
82     	width =3D WIDTH;
>>>     CID 569489:         Integer handling issues  (INTEGER_OVERFLOW)
>>>     Expression "pos->x - 200UL", where "pos->x" is known to be equal to=
 0, underflows the type of "pos->x - 200UL", which is type "unsigned long".
83     	dx =3D pos->x - WIDTH;
84     	sx =3D 0;
85     	if (pos->x >=3D gop->mode->info->width) {
86     		width =3D WIDTH +  gop->mode->info->width - pos->x;
87     	} else if (pos->x < WIDTH) {
88     		dx =3D 0;

** CID 569488:       Control flow issues  (NO_EFFECT)
/tools/fit_image.c: 913           in fit_handle_file()


___________________________________________________________________________=
__________________
*** CID 569488:         Control flow issues  (NO_EFFECT)
/tools/fit_image.c: 913             in fit_handle_file()
907     	 * signatures. We do an attempt at estimating the expected
908     	 * extra size, but just in case that is not sufficient, keep
909     	 * trying adding 1K, with a reasonable upper bound of 64K
910     	 * total, until we succeed.
911     	 */
912     	size_inc =3D fit_estimate_hash_sig_size(params, bakfile);
>>>     CID 569488:         Control flow issues  (NO_EFFECT)
>>>     This less-than-zero comparison of an unsigned value is never true. =
"size_inc < 0UL".
913     	if (size_inc < 0)
914     		goto err_system;
915     	do {
916     		if (copyfile(bakfile, tmpfile) < 0) {
917     			printf("Can't copy %s to %s\n", bakfile, tmpfile);
918     			ret =3D -EIO;

** CID 569487:       Insecure data handling  (TAINTED_SCALAR)


___________________________________________________________________________=
__________________
*** CID 569487:         Insecure data handling  (TAINTED_SCALAR)
/boot/cedit.c: 474             in cedit_write_settings()
468     	}
469
470     	ret =3D fdt_end_node(fdt);
471     	if (!ret)
472     		ret =3D fdt_end_node(fdt);
473     	if (!ret)
>>>     CID 569487:         Insecure data handling  (TAINTED_SCALAR)
>>>     Passing tainted expression "fdt->size_dt_strings" to "fdt_finish", =
which uses it as an offset.
474     		ret =3D fdt_finish(fdt);
475     	if (ret) {
476     		log_debug("Failed to finish FDT (err=3D%d)\n", ret);
477     		return log_msg_ret("fin", -EINVAL);
478     	}
479

** CID 569486:       Incorrect expression  (SIZEOF_MISMATCH)
/lib/efi_selftest/efi_selftest_console.c: 242           in efi_st_printc()


___________________________________________________________________________=
__________________
*** CID 569486:         Incorrect expression  (SIZEOF_MISMATCH)
/lib/efi_selftest/efi_selftest_console.c: 242             in efi_st_printc()
236     					break;
237     				case 'U':
238     					print_uuid(va_arg(args, void*), &pos);
239     					break;
240     				default:
241     					--c;
>>>     CID 569486:         Incorrect expression  (SIZEOF_MISMATCH)
>>>     Passing argument "va_arg (args, void *)" of type "void *" and argum=
ent "16 /* 2 * sizeof (void *) */" to function "printx" is suspicious.
242     					printx((uintptr_t)va_arg(args, void *),
243     					       2 * sizeof(void *), &pos);
244     					break;
245     				}
246     				break;
247     			case 's':

** CID 569485:         (DC.WEAK_CRYPTO)
/net/bootp.c: 837           in bootp_request()
/net/bootp.c: 838           in bootp_request()


___________________________________________________________________________=
__________________
*** CID 569485:           (DC.WEAK_CRYPTO)
/net/bootp.c: 837             in bootp_request()
831     	extlen =3D bootp_extended((u8 *)bp->bp_vend);
832     #endif
833
834     	/* Only generate a new transaction ID for each new BOOTP request */
835     	if (bootp_try =3D=3D 1) {
836     		if (IS_ENABLED(CONFIG_BOOTP_RANDOM_XID)) {
>>>     CID 569485:           (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security-related applications, becaus=
e linear congruential algorithms are too easy to break.
837     			srand(get_ticks() + rand());
838     			bootp_id =3D rand();
839     		} else {
840     			/*
841     			 *	Bootp ID is the lower 4 bytes of our ethernet address
842     			 *	plus the current time in ms.
/net/bootp.c: 838             in bootp_request()
832     #endif
833
834     	/* Only generate a new transaction ID for each new BOOTP request */
835     	if (bootp_try =3D=3D 1) {
836     		if (IS_ENABLED(CONFIG_BOOTP_RANDOM_XID)) {
837     			srand(get_ticks() + rand());
>>>     CID 569485:           (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security-related applications, becaus=
e linear congruential algorithms are too easy to break.
838     			bootp_id =3D rand();
839     		} else {
840     			/*
841     			 *	Bootp ID is the lower 4 bytes of our ethernet address
842     			 *	plus the current time in ms.
843     			 */

** CID 569484:       Insecure data handling  (INTEGER_OVERFLOW)
/drivers/core/uclass.c: 339           in uclass_find_next_free_seq()


___________________________________________________________________________=
__________________
*** CID 569484:         Insecure data handling  (INTEGER_OVERFLOW)
/drivers/core/uclass.c: 339             in uclass_find_next_free_seq()
333     	}
334     	/*
335     	 * At this point, max will be -1 if there are no existing aliases =
or
336     	 * devices
337     	 */
338
>>>     CID 569484:         Insecure data handling  (INTEGER_OVERFLOW)
>>>     "max + 1", which might have overflowed, is returned from the functi=
on.
339     	return max + 1;
340     }
341
342     int uclass_find_device_by_seq(enum uclass_id id, int seq,
struct udevice **devp)
343     {
344     	struct uclass *uc;

** CID 569483:       Control flow issues  (DEADCODE)
/boot/bootflow_menu.c: 178           in bootflow_menu_add()


___________________________________________________________________________=
__________________
*** CID 569483:         Control flow issues  (DEADCODE)
/boot/bootflow_menu.c: 178             in bootflow_menu_add()
172     	preview_id =3D 0;
173     	if (bflow->logo) {
174     		preview_id =3D ITEM_PREVIEW + seq;
175     		ret |=3D scene_img(scn, "preview", preview_id,
176     				     bflow->logo, NULL);
177     	}
>>>     CID 569483:         Control flow issues  (DEADCODE)
>>>     Execution cannot reach the expression "SCENEMIF_GAP_BEFORE" inside =
this statement: "ret |=3D scene_menuitem(scn, ...".
178     	ret |=3D scene_menuitem(scn, OBJ_MENU, "item", ITEM + seq,
179     				  ITEM_KEY + seq, ITEM_LABEL + seq,
180     				  ITEM_DESC + seq, preview_id,
181     				  add_gap ? SCENEMIF_GAP_BEFORE : 0,
182     				  NULL);
183

** CID 569482:       Control flow issues  (DEADCODE)
/tools/fit_image.c: 914           in fit_handle_file()


___________________________________________________________________________=
__________________
*** CID 569482:         Control flow issues  (DEADCODE)
/tools/fit_image.c: 914             in fit_handle_file()
908     	 * extra size, but just in case that is not sufficient, keep
909     	 * trying adding 1K, with a reasonable upper bound of 64K
910     	 * total, until we succeed.
911     	 */
912     	size_inc =3D fit_estimate_hash_sig_size(params, bakfile);
913     	if (size_inc < 0)
>>>     CID 569482:         Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "goto err_system;".
914     		goto err_system;
915     	do {
916     		if (copyfile(bakfile, tmpfile) < 0) {
917     			printf("Can't copy %s to %s\n", bakfile, tmpfile);
918     			ret =3D -EIO;
919     			break;

** CID 569481:       Control flow issues  (MISSING_BREAK)
/lib/lmb.c: 763           in lmb_alloc_mem()


___________________________________________________________________________=
__________________
*** CID 569481:         Control flow issues  (MISSING_BREAK)
/lib/lmb.c: 763             in lmb_alloc_mem()
757     		return 0;
758
759     	if (!addr)
760     		return -EINVAL;
761
762     	switch (type) {
>>>     CID 569481:         Control flow issues  (MISSING_BREAK)
>>>     The case for value "LMB_MEM_ALLOC_ANY" is not terminated by a "brea=
k" statement.
763     	case LMB_MEM_ALLOC_ANY:
764     		*addr =3D LMB_ALLOC_ANYWHERE;
765     	case LMB_MEM_ALLOC_MAX:
766     		ret =3D _lmb_alloc_base(size, align, addr, flags);
767     		break;
768     	case LMB_MEM_ALLOC_ADDR:



View Defects in Coverity Scan
<https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>

Best regards,

The Coverity Scan Admin Team

----- End forwarded message -----

--=20
Tom

--3yv6Nc6xAuDTb5xc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhtJsAACgkQFHw5/5Y0
tyxiJQv0D5JNFTqp5zu5RjyrxIZn76fmflFPOcw9cRJKnbGx51XiUaLwN4UrMo0M
qC+aMOXOuPHp9nvpWWYw7Btl5DX9lx1XAlrq5VIRlfOddW40qEke+58HIGNOdBkB
2XmQN1ETFw3t91KttSvDzVjHDHEfSr8Kq2yhpnb74KKLn4mYUaV3HZFFJd7glqJc
WEpW5RkFaPBccynMpuKQ7mZS3fVttXKfgfwpUzMnETNBlZrxZoIENLGnnJd382Tl
Tv1BpEm36gMQEwuSZgrEg6wc3/ah5wSEIBkbok+WDo6JNx0FH6Rb1p5gNWTz+oSA
mSuEXfxBo9l2E43KixbmHV/8MwRFOMAv6VObGF9hK9bJ1O7+OAWrxET5VWZ7UFA7
3rcTTqW9imr7ttqQr/nHkZ2AhnyQURTQPBN1FUTH5/hB6fNjLfliixn+pL7HmfXP
Wu4Sbk2Uh2ZhTthDu294UvDNzSshQGuLsJKj3hISrykZ7oRpLGypXzs+dK3L793Z
rfsrvGc=
=OzbN
-----END PGP SIGNATURE-----

--3yv6Nc6xAuDTb5xc--
