Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FAFBD3B7E2
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 19:39:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B4D983B03;
	Mon,  8 Dec 2025 20:39:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sX0U4yKv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64DA283B03; Mon,  8 Dec 2025 20:39:04 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA9F683A57
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 20:39:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4510974a8cdso2593754b6e.0
 for <u-boot@lists.denx.de>; Mon, 08 Dec 2025 11:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765222739; x=1765827539; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bN1GUZ906m6QC80hBlGQuENBBu/fnelA4+DeJ20Dq0M=;
 b=sX0U4yKvl3crjuwISC5LOc8OtdJ3Tpirj6OnOS8QhD6Mp8XKnUHepJhADGZ2QbUoD4
 SHhwHx2nbNldyPvynt33GkdVQE2okQllxywjgZpG1tMtk5zotd+m9xzgJDJ14JVNcg3i
 E5dSxaG1xLg90fdv/IFyGy42tVy1BXexeP1JU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765222739; x=1765827539;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bN1GUZ906m6QC80hBlGQuENBBu/fnelA4+DeJ20Dq0M=;
 b=SF31YSOkb21ikV2bYCoI/WjIs/4eK0mfjJi3olsvx6nS1sUk8pkw4EfF7c7LiECJl+
 3/A/fln3ljcR4W569Ly9tL70bLP47l/UjMwOqsI2GWmsmRebQWIIciBwb5AIeU24p8A6
 lqqQxdRE+wfPOQjeMR5uvQseq/bp6aQbsk48CtBidd8t+ya+K2T7z/3pJ4OOl0hxdsag
 0s7lTx/JDhlrkhqs6BWtzMSaEQrgFFB8Uwg5VgjiK8b5HQCaIo7QnAsoI30vkCMY/Cgp
 vPyEDTEuObgtKHXqu1iLAILjB57EIpR3ja3w6/AB1+niZvC1nJaOJq9Y26HlxkrIK5Nr
 oyyw==
X-Gm-Message-State: AOJu0Yzcjc9tceLTHD82JWqY0PahtdN1uNxIEMzYR/JILcRCUkcB0NfT
 Ba07BG6LEgPLoBsQMZGkrragY7DPuDyz+BukoPEAiOzUNnMgNWUDeWrhDmJS9sFtHPqUuYkv0R4
 WVjMpeIk=
X-Gm-Gg: ASbGnct4xzH00sU92PZCYAdx5NIqdMUUz3jOPOO76nSmkI2ABOuBt/My0jPBhnemRrg
 DMoKwitwBMabUwTT+p1MVfdmD+/W5mrhJtfLNTmNPgVgt+8dq0YKtyh71AmAIfJ3BxqcTdJqvSM
 CUhHLHcOmFTzMCxzkQ5UzOfZwQ8vX5J0+uUSL6d+uX/PI+Ra2kZnGJRC50klgsDQLxw1RWNvskx
 3I2CcNEFWwca64T4bK7BvNdOWDnAxifUwAdOuBSOj8+sK8rCYaz6xaeHbo/iGx1zW0BCyXpLK/5
 CrG4jvijzPwLE0N7qq3ZyU4PaMmNOPze9dfo+ezIJAMivJ4LNQ8wz1XLNSwKsT57SnS3QVcJM/v
 JB5luYBVzw6f6ObU3wG1hPTSUPyo+gpoHH+jLYilvNElqLhF6XuXP7CaSJDI2blYSeThvjx6eXM
 g66NiIzA422+bwsLBuMb9FkRbDhSSWtSZ/3Ff3oquI6W32BkcOwg==
X-Google-Smtp-Source: AGHT+IE6jqpaF7kyIRBRnrpJon+4MI0bnCIIPyveSCVWTDTL7d8l+1ANMepwmTpXgOmaZjFbM7SUtw==
X-Received: by 2002:a05:6808:30a7:b0:453:7a2a:62cd with SMTP id
 5614622812f47-4539e094e5amr3267888b6e.50.1765222739405; 
 Mon, 08 Dec 2025 11:38:59 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4538f742e5asm4967498b6e.4.2025.12.08.11.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 11:38:58 -0800 (PST)
Date: Mon, 8 Dec 2025 13:38:57 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Adriana Nicolae <adriana@arista.com>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20251208193857.GS303283@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5gVvVyXMlSo2Ej3S"
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


--5gVvVyXMlSo2Ej3S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's the latest Coverity scan report. I think the test/dm/clk_ccf.c
report is just a "works as intended" but I'm not sure off-hand about the
fdtdec.c test. Might be the case the previous test in the file also has
this problem, and since it's just test code, might also be fine enough.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Mon, Dec 8, 2025 at 1:23=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to *Das U-Boot*
found with Coverity Scan.

   - *New Defects Found:* 2
   - 1 defect(s), reported by Coverity Scan earlier, were marked fixed in
   the recent build analyzed by Coverity Scan.
   - *Defects Shown:* Showing 2 of 2 defect(s)

Defect Details

** CID 639831:         (TAINTED_SCALAR)


___________________________________________________________________________=
__________________
*** CID 639831:           (TAINTED_SCALAR)
/test/dm/fdtdec.c: 153             in dm_test_fdt_chosen_smbios()
147
148     	blob_sz =3D fdt_totalsize(gd->fdt_blob) + 4096;
149     	blob =3D memalign(8, blob_sz);
150     	ut_assertnonnull(blob);
151
152     	/* Make a writable copy of the fdt blob */
>>>     CID 639831:           (TAINTED_SCALAR)
>>>     Passing tainted expression "gd->fdt_blob->totalsize" to "fdt_open_i=
nto", which uses it as an offset.
153     	ut_assertok(fdt_open_into(gd->fdt_blob, blob, blob_sz));
154
155     	/* Mock SMBIOS table */
156     	entry =3D map_sysmem(gd->arch.smbios_start, sizeof(struct
smbios3_entry));
157     	memcpy(entry->anchor, "_SM3_", 5);
158     	entry->length =3D sizeof(struct smbios3_entry);
/test/dm/fdtdec.c: 153             in dm_test_fdt_chosen_smbios()
147
148     	blob_sz =3D fdt_totalsize(gd->fdt_blob) + 4096;
149     	blob =3D memalign(8, blob_sz);
150     	ut_assertnonnull(blob);
151
152     	/* Make a writable copy of the fdt blob */
>>>     CID 639831:           (TAINTED_SCALAR)
>>>     Passing tainted expression "gd->fdt_blob->size_dt_strings" to "fdt_=
open_into", which uses it as an offset.
153     	ut_assertok(fdt_open_into(gd->fdt_blob, blob, blob_sz));
154
155     	/* Mock SMBIOS table */
156     	entry =3D map_sysmem(gd->arch.smbios_start, sizeof(struct
smbios3_entry));
157     	memcpy(entry->anchor, "_SM3_", 5);
158     	entry->length =3D sizeof(struct smbios3_entry);
/test/dm/fdtdec.c: 153             in dm_test_fdt_chosen_smbios()
147
148     	blob_sz =3D fdt_totalsize(gd->fdt_blob) + 4096;
149     	blob =3D memalign(8, blob_sz);
150     	ut_assertnonnull(blob);
151
152     	/* Make a writable copy of the fdt blob */
>>>     CID 639831:           (TAINTED_SCALAR)
>>>     Passing tainted expression "gd->fdt_blob->size_dt_struct" to "fdt_o=
pen_into", which uses it as an offset.
153     	ut_assertok(fdt_open_into(gd->fdt_blob, blob, blob_sz));
154
155     	/* Mock SMBIOS table */
156     	entry =3D map_sysmem(gd->arch.smbios_start, sizeof(struct
smbios3_entry));
157     	memcpy(entry->anchor, "_SM3_", 5);
158     	entry->length =3D sizeof(struct smbios3_entry);

** CID 639830:       Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/clk_ccf.c: 68           in dm_test_clk_ccf()


___________________________________________________________________________=
__________________
*** CID 639830:         Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/clk_ccf.c: 68             in dm_test_clk_ccf()
62     	ut_asserteq(CLK_SET_RATE_NO_REPARENT, clk->flags);
63
64     	rate =3D clk_get_parent_rate(clk);
65     	ut_asserteq(rate, 60000000);
66
67     	rate =3D clk_set_rate(clk, 60000000);
>>>     CID 639830:         Integer handling issues  (INTEGER_OVERFLOW)
>>>     Expression "_val1", where "rate" is known to be equal to -38, overf=
lows the type of "_val1", which is type "unsigned int".
68     	ut_asserteq(rate, -ENOSYS);
69
70     	rate =3D clk_get_rate(clk);
71     	ut_asserteq(rate, 60000000);
72
73     	ret =3D clk_get_by_id(CLK_ID(dev, SANDBOX_CLK_PLL3_80M), &pclk);



View Defects in Coverity Scan
<https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>

Best regards,

The Coverity Scan Admin Team

----- End forwarded message -----

--=20
Tom

--5gVvVyXMlSo2Ej3S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTcpUAAKCRAr4qD1Cr/k
CuNyAP9ISqq6sozFFgR47Rxxi4vu5WPKBMxyCW1QDfL6j4C7mwD/ZYCqI2aRCbIe
zkYNpkTEQkoPieQQCLWKHCqMgy21jgU=
=Nfrf
-----END PGP SIGNATURE-----

--5gVvVyXMlSo2Ej3S--
