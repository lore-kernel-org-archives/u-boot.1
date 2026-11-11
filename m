Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C7F606A897
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ssUvNhuZ;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=BoHVVxt1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 58FCF6089E;
	Wed, 11 Nov 2026 14:43:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TfybdWueLs15; Wed, 11 Nov 2026 14:43:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3BD2760793
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794408183;
	b=QJoKWOZfnCnBR1Pwgfi/faqdDXWCSHCzVWhCRw2xldAhx01F16KBkJfnG9p+o2VFTwXz
	 sP008M1tmCYN7+wuhOdJvf1NYAioGbRpvfnJL0QARkwgd4SHkvfUBvUScYXPuBIudp2Iu
	 /hAOsFaZIiWOt08G1RkIsJeoPQss/qI/ssBsD9Pg4KahNxK2012OzB1AR2zslMWh+OFDU
	 1BWyj9K0O2kKOWyvcniXaUiQPWGeXp8ybOX9eQO4OKbC7aQo2rTD2l69cOz9gd08YMIaL
	 lqeNzSZEH8ek3c1rfDuhJ2Vdpex6zel/GMFn5KpLkuEIvdaibf5NqT7hHCYbq/LZIJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794408183;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lsFxdcIR32kre0dBZq8xbFCAvq7cJYad8nyiKVzKO/A=;
	b=T1eti5qF4O4A1ZHB6MqbrW0/UO1/AipOrOAG+zDBNEBqWW31cXOUsB0TafHmXgcZNDLb
	 QGn9zFw1tY+4Wdcer99U6URWaxSTyibdDP7fd18Gmm57KDViNPflTZBCE+Su34vu9Kf/7
	 zQi7FKdxkOjzf6xb2J4yb7oaNJy6a4OsUmu560b1M3dKXuGObPYSaSsKU2fWbx5OexYzC
	 Dg+gM3x2Ad/SJQhzcxiMCkLWF5PG1UuMFoM245NykHYs2R9z5tGA3iaQC+UhYDLiQZ/ja
	 JRNxB5z5+RJ0DfHv/3/AiQnpKjjujiiqakWTUHjfc/ektBCcK/fPbK1uY+ktoqrqbKA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794408183;
	bh=lsFxdcIR32kre0dBZq8xbFCAvq7cJYad8nyiKVzKO/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ssUvNhuZpmr0ascthSTNBA9CO3DgVy+lo4+TuS89Xti84YF9NshK/IpY6YGMi2US0
	 WqNAbRVWzfiUhVUzkRcJZ53jB37Iozv9cOlCifmXGNLmaJGdMxFMvRgw20JO1fYaNq
	 1KoivOvnBFgPlJtI+yqyurJuOV3rGUj1TYTWOhrkt9ZTYSlwBHYf6wTvOJIyD1VqCL
	 MHHFUFlc7HuVFePqtI83itFp8Z4AD3IzaYcPjwsMSdqkSR/3mLNKPPbmET5jUOeX5e
	 bs4CTG225Fjs+WWGOdPs/YnZOcvHNYiVxI4L34vDAsjzxc/Z87xg1h5mvuuJ1G0vW0
	 058jcrG0VtRWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3BD2760793;
	Wed, 11 Nov 2026 14:43:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0AC622FE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:43:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E4A214096C
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:43:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2hUIzNQuIEWf for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 14:43:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D7D6340967
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::;
 helo=mail-oo2-x00.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=BoHVVxt1
Received: from mail-oo2-x00.google.com (mail-oo2-x00.google.com
 [IPv6:2607:f8b0:4864:31::])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D7D6340967
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:43:00 +0000 (UTC)
Received: by mail-oo2-x00.google.com with SMTP id
 46e09a7af769-84e8a9fae57so1644496a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 06:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794408179; x=1795012979;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lsFxdcIR32kre0dBZq8xbFCAvq7cJYad8nyiKVzKO/A=;
 b=BoHVVxt1VDXePwvB47dVA0Kp5W9ezc/SoItbLcXyJtOLDqp7J5+O2x+E7v3nq0UNgM
 o2L8qWjUZNABbtwMdAtKk9/Ru4ocIMpTADwUapfkfv/hAXBFkJh6ypZOxSjnC5lEoIsc
 yIZADB/b1mpggGW4xxGWRM+/F9EhhbWJwEz7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794408179; x=1795012979;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lsFxdcIR32kre0dBZq8xbFCAvq7cJYad8nyiKVzKO/A=;
 b=xHJeo4i6Ux6VFR3oWtIq1U32sOY/KgECWp22+yf5Sq4xZIvgm+FBC1odkabmfTvluR
 dCbENU93jjjdjjRYmpyKQolCf6jNehzWzjtaDDif6ko2Fi9gFv+VD5HCQFJq2XPktD33
 8qaKglR+9H5L+Ma1TL2gI8sWz8m8MY80TFLQjWbGHpIJljaP1ivH3eeAKNqpNEe/BIdE
 iryWpX1yA10Wv9UXTAsCD+RHt2C3GltLr49/MNhJtbHua0iANcMz05ueTXCCbCjNHwtq
 zCuqwxJccSiwkCT2DYBobQto1B9H1Xksl0BSAAx3Lh2PobsDDPz5lVpUj9mVtwxrnn46
 4stQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHLPO10O6OK808FdWs9UlYRlL7AIKIsO9gV78/2VkbLIFRR3Ci+yaNw07sBsqs0eZhPkqw+IfQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/JSe9qHPd+tNmLda4FlpA04Irka4vAsWE848Z0ZnwI0IwlP8xt
 U6FnoSXX1rgp/Y3kaKiGJBxA0eL4zfaD7roKnxznz4DvokHnH+Pz0fsnPHwjwRabN6c=
X-Gm-Gg: AYBFou3XGsiEtHMMLym0oLelZOq8JSm+SSeCotKBcIha0rPtkEvKg/OvOT6Y4muU9is
 Sczb8oRkmdI6U6GsysqGm1IChBoNmODF6hd7ILdFhL8AmqE9FMRJarewl/xm5Bxs6Mws9lDvxpP
 nQxrbs+zdU7pCsPxbiELRi86VzrvP9PbyC0lhzI/xZvKpevj82zUlpajNwCqvewFnaf6sPJyfTc
 Tnj8b1QoYjExvU5fGihcviu3MxLFyf2VPDv6aJB4tru1INhJhQN6vEEOuz6jWMirn4vLUUIelnC
 3Qj05YJKvnxnrrHSk1bpGNrl5J6kx3SqLS1WQDbsg3MYIqL0lR5i2TtZnsYdGESeTtj9+nch5tQ
 44Cxx++HisDQctisvpgGlj6rhRpHhCajvFhVTThqtG1KeCOVuppr4yWWuwLT2DJB4UwO5KzGbL9
 vkT3BTuQZWRB1svs/hNuLjRxeY+TtIg2SYi4wcWd2WLb2oNOvVrXMRpEjKDkbxj7PbQIsWbcikw
 vtf02AJJvhoYNoxUtCWaD7OP+3afh8IgzFCxIk72seyNmHaG+v1Gpqk1s7+itskrI6Fe7mhvAvL
 fiOg8vXJsbxeD6JIoJLjc99SQQSVTSIuBpiCjdADHz5x/44n0hhnepmK4iG+agt0aCL5QEJAvQu
 +PVbEGkCwSJR3b8hb7WJHPMsONdYYiaHjjlX28zxsx092zdGAM3fmd7IArqZumMDRrEX33W8LST
 Pmia/RVaocd0J+4U9I3I5mC8lnbaB6H78=
X-Received: by 2002:a05:6820:1caa:b0:716:bbe7:1ca2 with SMTP id
 006d021491bc7-71917850bd8mr1574858eaf.26.1794408179191; 
 Wed, 11 Nov 2026 06:42:59 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-718a9a459f1sm4044506eaf.9.2026.11.11.06.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 06:42:58 -0800 (PST)
Date: Wed, 11 Nov 2026 08:42:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Frieder Schrempf <frieder@fris.de>, Martin Schwan <m.schwan@phytec.de>,
 u-boot@lists.u-boot-project.org, Aristo Chen <aristo.chen@canonical.com>,
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marex@nabladev.com>, Michal Simek <michal.simek@amd.com>,
 Francesco Valla <francesco@valla.it>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: Re: [PATCH v2 00/12] bootstd: rauc: Fixes, partition names and
 built-in boot command
Message-ID: <20261111144255.GB255403@bill-the-cat>
References: <20261102-main-v2-0-4537bcb19d66@kontron.de>
 <4ce05817-10e0-47cf-a252-51638f75f3d3@kontron.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d0siIkW/Abpc7VcT"
Content-Disposition: inline
In-Reply-To: <4ce05817-10e0-47cf-a252-51638f75f3d3@kontron.de>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--d0siIkW/Abpc7VcT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 01:38:11PM +0100, Frieder Schrempf wrote:
> Hi Tom,
>=20
> On 02.11.26 17:20, Frieder Schrempf wrote:
> > This series fixes some issues in the RAUC bootmeth and adds two
> > options to make it safer to use on real devices, together with tests.
> >=20
> > Patches 1-4 fix bugs in bootmeth_rauc.c: an uninitialised pointer when
> > a bootflow has no block device, a leak of the active slot name, a stack
> > buffer overflow with long slot names in BOOT_ORDER, and a leak of the
> > boot script when a boot attempt fails and is retried.
> >=20
> > Patch 5 makes the RAUC test restore the bootdev order also if it fails.
> > Before, a failing check left a static array in std->bootdev_order,
> > which was then passed to free() and aborted sandbox. Patch 6 adds a
> > test that boots the same RAUC bootflow twice.
> >=20
> > Patch 7 makes the bootmeth set its BOOT_ORDER and BOOT_x_LEFT variables
> > only for a device with a RAUC system, instead of for every MMC device it
> > scans.
> >=20
> > Patches 8 and 9 make the bootmeth safer to use on real devices, without
> > changing anything for existing users:
> >=20
> > - CONFIG_BOOTMETH_RAUC_PARTITIONS can give the partitions by their GPT
> >   names instead of their numbers. The bootmeth then only claims a
> >   device which has the partitions of all slots. With numbers, it claims
> >   any MMC device whose partitions happen to fit the configured layout,
> >   such as a standard distro installed to eMMC, and writes its variables
> >   to the environment. This allows to use BOOTMETH_RAUC safely alongside
> >   other bootmeths.
> >=20
> > - The new option CONFIG_BOOTMETH_RAUC_BOOTCMD, empty by default, sets a
> >   command built into U-Boot that boots the slot instead of running
> >   boot.scr from the boot partition.
> >   Nothing authenticates that partition, and signing the script is not
> >   a reliable fix, as the environment must stay writable for the RAUC
> >   variables and setting verify=3Dno there skips all checks. With this
> >   option, U-Boot executes nothing from the boot partition.
> >=20
> > The bootmeth keeps both options in its platform data, which is set
> > from Kconfig when it is bound. The tests in patches 11 and 12 change
> > them at runtime, so sandbox_defconfig keeps the default configuration
> > and all tests run on it. As partition names need GPT, patch 10 adds
> > GPT support to DiskHelper in fs_helper.py for a second RAUC test image.
> >=20
> > ---
> > Changes in v2:
> > - Patches 1, 5 and 10: Add Reviewed-by tag from Simon.
> > - Patch 2: Look up the slot in find_active_slot() and return it
> >   instead of a strdup() copy of its name (Simon). This also catches an
> >   unknown slot in BOOT_ORDER before its BOOT_x_LEFT counter is
> >   decremented.
> > - Patch 3: Print an error for a too long slot name in
> >   CONFIG_BOOTMETH_RAUC_BOOT_ORDER, document the 32-character limit and
> >   pass on the return value of boot_left_name() (Simon). Rebase on the
> >   changes in patch 2.
> > - Patch 4: Reset the bootflow state before loading the script again
> >   and move freeing the image list into bootflow_free_images() in
> >   bootflow.c, used by bootflow_free() as well (Simon).
> > - New patch 6: Test booting the same bootflow twice (Simon).
> > - New patch 7: Set BOOT_ORDER and BOOT_x_LEFT only for a device with a
> >   RAUC system (Simon).
> > - Patch 8: Give the partition names in CONFIG_BOOTMETH_RAUC_PARTITIONS
> >   instead of the new option CONFIG_BOOTMETH_RAUC_PART_NAMES (Bastien),
> >   and only use a device which has the partitions of all slots (Simon).
> >   Renamed from "Optionally check the partition names".
> > - Patches 8 and 9: Keep the options in the platform data of the
> >   bootmeth, set from Kconfig when it is bound, so that tests can change
> >   them at runtime. The boot script code is now always built (Simon).
> > - Patches 11 and 12: Set the options in the tests instead of
> >   sandbox_defconfig, so that the default configuration is still tested,
> >   and drop the #ifdefs. Keep the RAUC test image (mmc10) on MBR with a
> >   boot script and use a second GPT image (mmc13) for partition names.
> >   Also check matching names, a slot with missing partitions, that MBR
> >   is rejected and that no variables are set for an unused device
> >   (Simon). Patch 11 is renamed from "Test the RAUC partition name
> >   check".
> > - Link to v1: https://patch.msgid.link/20261029-main-v1-0-b5a878627107@=
kontron.de
> >=20
> > ---
> > Frieder Schrempf (12):
> >       bootstd: rauc: Initialise desc in distro_rauc_scan_parts()
> >       bootstd: rauc: Fix leak of the active slot name
> >       bootstd: rauc: Fix overflow of the BOOT_x_LEFT name buffer
> >       bootstd: rauc: Free the boot script of a failed boot attempt
> >       test: boot: Restore the bootdev order if the RAUC test fails
> >       test: boot: Test booting a RAUC bootflow twice
> >       bootstd: rauc: Only set the RAUC variables for a RAUC device
> >       bootstd: rauc: Optionally find the partitions by name
> >       bootstd: rauc: Optionally boot with a built-in command
> >       test: fs_helper: Support GPT in DiskHelper
> >       test: boot: Test finding the RAUC partitions by name
> >       test: boot: Test the RAUC built-in boot command
>=20
> With the bootstd subsystem being orphaned now, is there any chance to
> get at least the fixes (patch 1-5) upstream?

I'll pick this series up shortly. And figuring out what we're going to
do with bootstd moving forward is on the list of things that need doing.

--=20
Tom

--d0siIkW/Abpc7VcT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavR+7wAKCRAr4qD1Cr/k
CnNpAPwJpbezy/W/gbhVHYANZGmkr6OMRRTc0HRCbteGCYZupQEA2LqAExqzS4R8
hUbo3iK955ziV3iT6Wleb6DTlXSmeww=
=UCrK
-----END PGP SIGNATURE-----

--d0siIkW/Abpc7VcT--
