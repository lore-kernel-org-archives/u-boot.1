Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB34C83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 16:32:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AA4A82E34;
	Tue, 29 Jul 2025 18:32:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W8TEhIC4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C24C182F00; Tue, 29 Jul 2025 18:32:09 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17F2682BCD
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 18:32:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-73e88bc3776so2219222a34.1
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 09:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753806726; x=1754411526; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nfvu1ChhGPFCnjKqOLp7BOVdhE6UggcwtipxDxyRmUI=;
 b=W8TEhIC4B+uJZHvLI90EW0m2jqGvRW7j5FePbSYGOqew0bdn7zJzIMxs4iOzXufqsV
 4cXdO1dcT5D7O2obG2VbjzQBQd6QwGtgl7EAoUaEPIMYNGhDCvjXKpa/uXK6KzTOTGpU
 BH/2htAydLfky3F3k4rZhjitbtcQd/ccEZLyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753806726; x=1754411526;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nfvu1ChhGPFCnjKqOLp7BOVdhE6UggcwtipxDxyRmUI=;
 b=jxYx11MNp7S75SbQk04acXLpDPMDylk0g4KkbZuoNxENNT8zjaayQxsaROxTKBgiXG
 upHMWDzRGsabdmPrLjEpDQUfCzHw3Bwtvreainl7dfuWts1Fbf8xjfxm9kBMmScwZxqE
 8PKNTkoVd7F3Qw7+6vgbC/rShwbtIqdQ8GInuUP3tUls4UVegnqxa0gErGX8Igo88M7P
 XaAfxRnkUBeQ9TZ+epgjaff2iY3SS2SGlh40PnSaOVmrjoUuT/QNsDPblrPg7XfLPzTv
 dJoy9vMIlAQO/5cP2g0CyNotAboDsrzdT2tTTIK3nJKXz9FjQyo+4D0cNY//Q4QzSjCP
 cflQ==
X-Gm-Message-State: AOJu0YxqXGZDaWpdfFL5//6dS5DqtsHb17x6rOhACp2u0+wV7yyORM8f
 vZSMPfJOCDNVUW+q8y4l3rKaiPraMxc6gZ02sdWoqB7HDo1ELEzAC5dVlGw2MRwAfj4mSZAY/bk
 X3EfQDmg=
X-Gm-Gg: ASbGncsgpddc111ydtfEaPKK5cMVcvMkrqi0SSakIQOBepvHXT7ZBk3omdrubo5vLOA
 PM4F+tygHF/MCCOhkjrgB8YsAEtUPtAr8LEY2CP1K015hG/goPN/k5LR74hmuuUhjbMbspOzZT7
 MUhaxhMHp8kM28MF9Cl2xLL3j06ucQJVDTI7P7SE+3Pv5LOqtRcFZRyJ23bg6qgMfUWcmXH6hBC
 TIk9ULgC5naF8gbxB3XsnzMQ0+8x7/j8yvQ3s0V0d/SSAmydFYS1079k7bf1lKtQ+KPrA5wMMw0
 DVB7Xnd9j6YyFpAd4Fu20tSWmayjbvlYsR//bhmAppSo8kv0ap/Xe/5xWi0KmKRS1Nk2W5VKdgv
 CryUhUMzHwF/awRYVzeirb1Hm6fFSteo/QRCinaH9QVdEhRBT8mqoDov0
X-Google-Smtp-Source: AGHT+IEcudmpjhlio6XbCOcwDGyolg4eUe0O+SFZDZokvxul4wcgMAtELfuW5YIfkqM0z761ht24Kw==
X-Received: by 2002:a05:6830:6f4b:b0:73e:9ee1:3d5f with SMTP id
 46e09a7af769-74177cacd4cmr393915a34.25.1753806725726; 
 Tue, 29 Jul 2025 09:32:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-74148246f0fsm1495382a34.51.2025.07.29.09.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 09:32:05 -0700 (PDT)
Date: Tue, 29 Jul 2025 10:32:03 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heiko Schocher <hs@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20250729163203.GM1807455@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YSoUulFi3JouSYvX"
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


--YSoUulFi3JouSYvX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

So I ran Coverity with the newest scan version and this is good news.
Only a few newly found issues in existing code.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Tue, Jul 29, 2025 at 10:04=E2=80=AFAM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to *Das U-Boot*
found with Coverity Scan.

   - *New Defects Found:* 3
   - 12 defect(s), reported by Coverity Scan earlier, were marked fixed in
   the recent build analyzed by Coverity Scan.
   - *Defects Shown:* Showing 3 of 3 defect(s)

Defect Details

** CID 583415:       Integer handling issues  (INTEGER_OVERFLOW)
/cmd/i2c.c: 369           in do_i2c_write()


___________________________________________________________________________=
__________________
*** CID 583415:         Integer handling issues  (INTEGER_OVERFLOW)
/cmd/i2c.c: 369             in do_i2c_write()
363     			return i2c_report_err(ret, I2C_ERR_WRITE);
364     	} else {
365     		/*
366     		 * Repeated addressing - perform <length> separate
367     		 * write transactions of one byte each
368     		 */
>>>     CID 583415:         Integer handling issues  (INTEGER_OVERFLOW)
>>>     Expression "length--", where "length" is known to be equal to 0, un=
derflows the type of "length--", which is type "uint".
369     		while (length-- > 0) {
370     #if CONFIG_IS_ENABLED(DM_I2C)
371     			i2c_chip->flags |=3D DM_I2C_CHIP_WR_ADDRESS;
372     			ret =3D dm_i2c_write(dev, devaddr++, memaddr++, 1);
373     #else
374     			ret =3D i2c_write(chip, devaddr++, alen, memaddr++, 1);

** CID 583414:       Memory - corruptions  (OVERRUN)
/cmd/eficonfig.c: 334           in eficonfig_append_menu_entry()


___________________________________________________________________________=
__________________
*** CID 583414:         Memory - corruptions  (OVERRUN)
/cmd/eficonfig.c: 334             in eficonfig_append_menu_entry()
328
329     	entry =3D calloc(1, sizeof(struct eficonfig_entry));
330     	if (!entry)
331     		return EFI_OUT_OF_RESOURCES;
332
333     	entry->title =3D title;
>>>     CID 583414:         Memory - corruptions  (OVERRUN)
>>>     "sprintf" will overrun its first argument "entry->key" which can ac=
commodate 3 bytes.  The number of bytes written may be 11 bytes, including =
the terminating null.
334     	sprintf(entry->key, "%d", efi_menu->count);
335     	entry->efi_menu =3D efi_menu;
336     	entry->func =3D func;
337     	entry->data =3D data;
338     	entry->num =3D efi_menu->count++;
339     	list_add_tail(&entry->list, &efi_menu->list);

** CID 583357:         (INTEGER_OVERFLOW)
/lib/zlib/deflate.c: 1714           in deflate_slow()
/lib/zlib/deflate.c: 1706           in deflate_slow()


___________________________________________________________________________=
__________________
*** CID 583357:           (INTEGER_OVERFLOW)
/lib/zlib/deflate.c: 1714             in deflate_slow()
1708
1709                 /* Insert in hash table all strings up to the end
of the match.
1710                  * strstart-1 and strstart are already inserted.
If there is not
1711                  * enough lookahead, the last two strings are not
inserted in
1712                  * the hash table.
1713                  */
>>>     CID 583357:           (INTEGER_OVERFLOW)
>>>     Expression "s->lookahead", where "s->prev_length - 1U" is known to =
be equal to 4294967270, underflows the type of "s->lookahead", which is typ=
e "uInt".
1714                 s->lookahead -=3D s->prev_length-1;
1715                 s->prev_length -=3D 2;
1716                 do {
1717                     if (++s->strstart <=3D max_insert) {
1718                         INSERT_STRING(s, s->strstart, hash_head);
1719                     }
/lib/zlib/deflate.c: 1706             in deflate_slow()
1700             if (s->prev_length >=3D MIN_MATCH && s->match_length <=3D
s->prev_length) {
1701                 uInt max_insert =3D s->strstart + s->lookahead - MIN_M=
ATCH;
1702                 /* Do not insert strings in hash table beyond this. */
1703
1704                 check_match(s, s->strstart-1, s->prev_match,
s->prev_length);
1705
>>>     CID 583357:           (INTEGER_OVERFLOW)
>>>     Expression "len", where "s->prev_length - 3U" is known to be equal =
to 4294967267, overflows the type of "len", which is type "uch".
1706                 _tr_tally_dist(s, s->strstart -1 - s->prev_match,
1707                                s->prev_length - MIN_MATCH, bflush);
1708
1709                 /* Insert in hash table all strings up to the end
of the match.
1710                  * strstart-1 and strstart are already inserted.
If there is not
1711                  * enough lookahead, the last two strings are not
inserted in



View Defects in Coverity Scan
<https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>

Best regards,

The Coverity Scan Admin Team

----- End forwarded message -----

--=20
Tom

--YSoUulFi3JouSYvX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIj3ggAKCRAr4qD1Cr/k
CqbMAP9y1QC/Ug1JpAnBQqmhx9cdTU5EQH7TwgxgllFv8c5QxAEAgJ66KyVmYwGX
Zg9d5Jvd6SU9U7QWpV52IcJ+h1x15AI=
=cyhP
-----END PGP SIGNATURE-----

--YSoUulFi3JouSYvX--
