Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18B0CFA46B
	for <u-boot@archiver.kernel.org>; Sun, 23 Nov 2025 19:03:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ED5083B95;
	Sun, 23 Nov 2025 20:03:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UH9lGQIc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C39A483BC8; Sun, 23 Nov 2025 20:03:12 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3490783B91
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 20:03:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-65727896f35so1861086eaf.2
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 11:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763924588; x=1764529388; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ou03rvE1/iuWktBXsjjFCBMV98MLY65IHffVVXR+ZuU=;
 b=UH9lGQIck8yw3dx6KHCf0FMpHTzDCDVymfEZeDMxzpHGtHXZnEKf3EWE7BFuZOc4tb
 r/7xMGurYza+RQJMptIn8OBMjs3wkv7Vhx5JYKo98qXyfuXx06oknPSuASFEXzRorqhN
 pKmf6DnZHPC8kRvpOP6PXK7v9hVi+zH+yT5qI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763924588; x=1764529388;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ou03rvE1/iuWktBXsjjFCBMV98MLY65IHffVVXR+ZuU=;
 b=UhO+kAxA7oo6IE/IwZG4EkA8h4KgSz7xR26lUTQ9VwWCmfs0WEUpRO34qf1NIhMHJW
 osPbMw49yFIQ/cl67A7voX0Le8Okok42bnhDVvxMifOguZx68MBs7Vq5EFwfvmQvorRJ
 esYOQ6zsEeoKE7tnezhX7IFK8a5/TbOv8+h/WNSscOdU5N067DTslpflLiqJS25Dq1dR
 V7NrX9vFhckTvFtS6tHIpDfAUwR/FOzZzUIQC+09BjJyO7ReK/T2PCw1X56HNsGNXdd+
 NvUA0Xswn7fbbk9Kk/QDNpcBWPazllZ0AjXKbLrM20uQKQ39Jm2jq/MTEKD3a/u2Ux+/
 rXyQ==
X-Gm-Message-State: AOJu0Yx96EBD2Hc8FnLhIJWgcn1+muj4fBS3rSK4wOu8u5ZD+dOgPfdD
 4qQdhwlUXfdx9s4YLIZ0N8LLhPPKyZZWsUCQYAsCCTiO2sIi5ONukwzjzoxro9nRksKykJ31cT/
 5wNHwvq4=
X-Gm-Gg: ASbGncszo1+XuXduyW1zPqGIa5vxFUO5uXihpS3PQuJn6tesKBmU9wbnZ9AwDlhmUmH
 1zV7DPep/7YNV05YPmSq/BJncGYKUlyvtR+zjJCnMaEbq8QkYHQ+r8qxDrwW869qWViXsFtVckK
 1Or37FMir2p6Usj4FU1Pnp2hPnoOr743xhmJFf0kiSUpkgwoPZzu/raP1XQ+5mJUsckELslqPEd
 s1Uhv/84CqIbEzZWxkdDbGeSuJWe98Q8B96CLQsf3/K9EipF4zRjRarWJyuBXP3FjpvcXkLDPQC
 23BYJOYz9VXrfONh8k6kJ5OxNeTAq8d8JZ5ps1/YcmS7VYHF7jsHl8BAJ47qXbw16yim3Y+sPbA
 9mSy8kdHddUtrK/f7bSBzjsLS3yck9LAEnVl13wnjS6pK3NgGIhvt2FRQLR4d5wRRWj+rYNiYgA
 XmmwPIUwsid9plrG5YceC653IZed9Cvr5xaepHd3laZzI9M0FEC7twSzSjc4cw
X-Google-Smtp-Source: AGHT+IHaSMKuPNXUweqyX35UHqrpyDgQew+8yjCwG7ADudsTJvaWTK0g2DB9BJxMucRwsLvsB9Z2OA==
X-Received: by 2002:a05:6820:2d85:20b0:657:5839:fce2 with SMTP id
 006d021491bc7-6579253fd7bmr3082951eaf.6.1763924587705; 
 Sun, 23 Nov 2025 11:03:07 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65782a38448sm3131324eaf.1.2025.11.23.11.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Nov 2025 11:03:06 -0800 (PST)
Date: Sun, 23 Nov 2025 13:03:04 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20251123190304.GI2125796@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9pXu1S5+GL1EnMEf"
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


--9pXu1S5+GL1EnMEf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

Here's the latest report.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Sun, Nov 23, 2025 at 12:28=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to *Das U-Boot*
found with Coverity Scan.

   - *New Defects Found:* 3
   - 2 defect(s), reported by Coverity Scan earlier, were marked fixed in
   the recent build analyzed by Coverity Scan.
   - *Defects Shown:* Showing 3 of 3 defect(s)

Defect Details

** CID 639130:         (CHECKED_RETURN)
/test/cmd/bdinfo.c: 166           in bdinfo_test_all()
/test/cmd/bdinfo.c: 164           in bdinfo_test_all()
/test/cmd/bdinfo.c: 165           in bdinfo_test_all()


___________________________________________________________________________=
__________________
*** CID 639130:           (CHECKED_RETURN)
/test/cmd/bdinfo.c: 166             in bdinfo_test_all()
160
161     	ut_assertok(bdinfo_check_mem(uts));
162
163     	/* CONFIG_SYS_HAS_SRAM testing not supported */
164     	ut_check_console_linen(uts, "flashstart");
165     	ut_check_console_linen(uts, "flashsize");
>>>     CID 639130:           (CHECKED_RETURN)
>>>     Calling "ut_check_console_linen" without checking return value (as =
is done elsewhere 166 out of 169 times).
166     	ut_check_console_linen(uts, "flashoffset");
167     	ut_assert_nextline("baudrate    =3D %lu bps",
168     			   env_get_ulong("baudrate", 10, 1234));
169     	ut_assertok(test_num_l(uts, "relocaddr", gd->relocaddr));
170     	ut_assertok(test_num_l(uts, "reloc off", gd->reloc_off));
171     	ut_assert_nextline("%-12s=3D %u-bit", "Build", (uint)sizeof(void *=
) * 8);
/test/cmd/bdinfo.c: 164             in bdinfo_test_all()
158     {
159     	ut_assertok(test_num_l(uts, "boot_params", 0));
160
161     	ut_assertok(bdinfo_check_mem(uts));
162
163     	/* CONFIG_SYS_HAS_SRAM testing not supported */
>>>     CID 639130:           (CHECKED_RETURN)
>>>     Calling "ut_check_console_linen" without checking return value (as =
is done elsewhere 166 out of 169 times).
164     	ut_check_console_linen(uts, "flashstart");
165     	ut_check_console_linen(uts, "flashsize");
166     	ut_check_console_linen(uts, "flashoffset");
167     	ut_assert_nextline("baudrate    =3D %lu bps",
168     			   env_get_ulong("baudrate", 10, 1234));
169     	ut_assertok(test_num_l(uts, "relocaddr", gd->relocaddr));
/test/cmd/bdinfo.c: 165             in bdinfo_test_all()
159     	ut_assertok(test_num_l(uts, "boot_params", 0));
160
161     	ut_assertok(bdinfo_check_mem(uts));
162
163     	/* CONFIG_SYS_HAS_SRAM testing not supported */
164     	ut_check_console_linen(uts, "flashstart");
>>>     CID 639130:           (CHECKED_RETURN)
>>>     Calling "ut_check_console_linen" without checking return value (as =
is done elsewhere 166 out of 169 times).
165     	ut_check_console_linen(uts, "flashsize");
166     	ut_check_console_linen(uts, "flashoffset");
167     	ut_assert_nextline("baudrate    =3D %lu bps",
168     			   env_get_ulong("baudrate", 10, 1234));
169     	ut_assertok(test_num_l(uts, "relocaddr", gd->relocaddr));
170     	ut_assertok(test_num_l(uts, "reloc off", gd->reloc_off));

** CID 639129:       Memory - illegal accesses  (BUFFER_SIZE)
/drivers/clk/clk_scmi.c: 191           in scmi_clk_get_ctrl_flags()


___________________________________________________________________________=
__________________
*** CID 639129:         Memory - illegal accesses  (BUFFER_SIZE)
/drivers/clk/clk_scmi.c: 191             in scmi_clk_get_ctrl_flags()
185     		char name[SCMI_CLOCK_NAME_LENGTH_MAX];
186     		ret =3D scmi_clk_get_attibute(dev, clk->id & CLK_ID_MSK,
187     					    name, &attributes);
188     		if (ret)
189     			return ret;
190
>>>     CID 639129:         Memory - illegal accesses  (BUFFER_SIZE)
>>>     Calling "strncpy" with a maximum size argument of 16 bytes on desti=
nation array "clkscmi->name" of size 16 bytes might leave the destination s=
tring unterminated.
191     		strncpy(clkscmi->name, name, SCMI_CLOCK_NAME_LENGTH_MAX);
192     		if (CLK_HAS_RESTRICTIONS(attributes)) {
193     			u32 perm;
194
195     			ret =3D scmi_clk_get_permissions(dev, clk->id & CLK_ID_MSK, &per=
m);
196     			if (ret < 0)

** CID 639128:       Resource leaks  (RESOURCE_LEAK)
/drivers/clk/clk_scmi.c: 373           in scmi_clk_probe()


___________________________________________________________________________=
__________________
*** CID 639128:         Resource leaks  (RESOURCE_LEAK)
/drivers/clk/clk_scmi.c: 373             in scmi_clk_probe()
367     			return ret;
368
369     		dev_clk_dm(dev, i, &clk_scmi->clk);
370     		dev_set_parent_priv(clk_scmi->clk.dev, priv);
371     	}
372
>>>     CID 639128:         Resource leaks  (RESOURCE_LEAK)
>>>     Variable "clk_scmi_bulk" going out of scope leaks the storage it po=
ints to.
373     	return 0;
374     }
375
376     static int __scmi_clk_set_parent(struct clk *clk, struct clk *paren=
t)
377     {
378     	struct scmi_clk_parent_set_in in =3D {



View Defects in Coverity Scan
<https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>

Best regards,

The Coverity Scan Admin Team

----- End forwarded message -----

--=20
Tom

--9pXu1S5+GL1EnMEf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSNaZQAKCRAr4qD1Cr/k
ClKEAQCcB8qa4gF6DD8oiM97iE4aly6xMRuxwEyGW42r02UbZQD/dbPkmZULs2dP
3Wj5m/A8u9EExerx0C3uV3DHreZWKAs=
=+Ore
-----END PGP SIGNATURE-----

--9pXu1S5+GL1EnMEf--
