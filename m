Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01FE606A32F
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CS+5hA+8;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=gwYAVxIH
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E75B660A80;
	Wed, 18 Nov 2026 14:12:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IVyuRkuWk-9Y; Wed, 18 Nov 2026 14:12:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F0C9060A7C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795011129;
	b=rFSmzpmlAIFBiiMs41o7ZJg9SlQSbZGQXjmvs7ojNMexvyCBZ90c1rf5MVYtfcfN83gf
	 s4MN0fiMbQuu0F7ZJn0EnbN1+o/9xNbl/fOzQzAwm1RyNbmWyHkHWSUTJOFbOovxumjZZ
	 OqELM1sC2RWFBrCCm6TLXGmamkeB9CK4FKwhxqf6p5Fx3D6uHIidUuBLPB7TVbd0TDn/g
	 0IulAeyu2spNZHgjLAy1YDyhlsjFpLLY7gH31J088V+wbmH+E/NQJPPve2Cktq5E7hnbm
	 /T0HIqLST8PLwuXcR84y5Oyr6jOjDoHRbpeuHTwNkQWBgXtYEPH5rOLLq9JQdskJ6iw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795011129;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6kSCaWDp2V1V3WvRLFEXFuKc9RSgFWC0XCclwzETQB0=;
	b=YHQZ3P4AVO7DxrTzoQFnVmBQNKALCgNnzuhiri9qFrMSgH28n3y5tCtara8TFSKQ046D
	 YCACY92UxcqKsgL4xbjPoLy0BXC8CasRp33Eky/wwCP8ej6WglikF9NWqllMA2SecBaEV
	 buhK/o06we/XlHrwrBU10n0px/zUpXTVo0mWaVxtaA+TdHvBX9hSl+n5HIniTfs7+6lto
	 Zf3m+HS0WqCIUxEkJ6ZgmqzWQhjrEoTHpMpOm/SbtkxWO0j3/2cqRt/4Gg+g6RpT57bcn
	 Y1EUKjqr8VaF+HBt17eHbBeFjC/P9uAuWCl4qGumZbbK6Nr717Rghdt8/IlSxvbOKdg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795011129;
	bh=6kSCaWDp2V1V3WvRLFEXFuKc9RSgFWC0XCclwzETQB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CS+5hA+8oWaBInVgPVv9AOZPxQ+PVpzyrOvZ2ai71WBfi1VcQ0q+5ZghI41z93L0y
	 HECaoZXwMGuGDsBiqVeJkf1A1wxoubD1LzLLF7eo48rm3C2lbk7Q/+sbb3dbilf3s9
	 HGmpCLG9YBZeumOnhSYqtPRHRhivoV1DV4TK6rkPkMQsajA0coI9xCyyeuImPgMlkQ
	 yoQOyNALo1aHm72j+KEVz2+1PK45ZR/lw44iqusrX62fSm/aPm+2pVZq2UcYgOoHiz
	 RaOKNyVI6pxU2QRZq025FHRGZHySyJrjtIUMs6lVciKpJ4VFCQ+Zkk7OwOxCc/7qv6
	 bYL+NWnGvMtNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F0C9060A7C;
	Wed, 18 Nov 2026 14:12:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 03AFD70B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 14:12:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E32E78121A
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 14:12:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x3xTZqmWNw9X for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 14:12:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8EADB811E0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=gwYAVxIH
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8EADB811E0
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 14:12:05 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-86288992de5so691851a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 06:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795011125; x=1795615925;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6kSCaWDp2V1V3WvRLFEXFuKc9RSgFWC0XCclwzETQB0=;
 b=gwYAVxIHD5VWPmfkc0NRVaMmNEe+C8BRkQZrwzK3CM/tLZT4ZpI0bvqXPhqu3msIXl
 wg7Z8cV5tIQatHiJ+Qm6PxYFmNtXkZn6G4TXlHLXPPbS+yI382pVxOyh2KI0Uq9y+X9W
 8efKBnvBjHabOwsFtKyArrrFoJFtEFOH4I2cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795011125; x=1795615925;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6kSCaWDp2V1V3WvRLFEXFuKc9RSgFWC0XCclwzETQB0=;
 b=SrsqdgxqoROAKp9cRIUroU5o5yrUyEz/im6kBLeXTw28BpxgPTgUlHBsrU2oodXEAL
 tJva5/Ez7OcNrTapNqwcevg3muX5cGYxPuaigeC8XU2BOluUOb11k+ol24uEKpxrZlhX
 A5PwdQumDmcGfbqQlQyu7tuHDhN8L+4DAZrleBUylTVCTf9oUvE/GDfQpswosP/mfApQ
 F67ekIYlYxnXZz7NFjfFtcrv8B6T7l6UQbd1pLPeR0OWz+jrAiEaMH22GLEr1CKHf5f9
 SdHTzbWJ1uhNQoj9l3so8Qr4+ExEoGOqui9xTC2Yx5Ddpk5r0jLI4t1rV5WuM7adsiGz
 t9cg==
X-Forwarded-Encrypted: i=1;
 AL+hErG/Sr9Vo92QVYj/Qryiq5C5+0RRSues5j/Vtu3U1B+xbkf6KLO0tdtGfy81YCuNmSd5Eq6+AXI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/N0syg8wsPscSxx3oLRUJR0fa787GkWWqV/O1e1QvZgZ7Bc4xB
 Ei7DIN397uTJI4e/PdGab7GVHUL7m1y73d4iWHD/OrjaK5k1quhh6fckXIPoVaIU5as=
X-Gm-Gg: AYBFou24clCEicgawtDi64a8Yqg6+uFqSVyDzMoNCjfFculO12W6zZwPZSsyO5qrpT3
 nzNYmlMNCxOlIXBhSjMlVybuSZHTlwQEiaoJTshfGr/uv8oD39Vmxa4URIlkYxX5Cep7iy+yf/R
 9c90HdCKg8kwj+I8jjbOtE6YAYCVwhkXFpqzgxQMpdAI5PHkTZm9WegQKchNDed6fO6lAYs2c1S
 FZ/VyUQVmCV5LWYbZSsjFSrH2YmDQYiXn3nkA52kn4e6hWxegr7y5huHarqk18bTD3YRo/WyDOh
 kC3tjsCT8yb2SKjCXT9zdShODq+HvRI8YfrsW5rHLA+oeTMeAU3gLsdDRYV3k7XpJLZwTxpBVvu
 DONQ5xrF8bukIJdl2N6P7ZyWzzHHxrW+TKU+EaD9dirSPtcAPmcrAVBOrWQhNkaT2cpGsccWiQu
 Fg8606gz/Ns+nLELaV+FG2i1E0cV6d6XGvFDbNUjGN5Ayu0vpsjD5qTAVBJV71GicuPkCri/NDY
 T24cjIvR/JplMB1l3mi5zHiJb+kM/cjOnMlRb8VVCIRI2v3zl1bCdkODNsarge/X36ZUz+wxV+z
 JXkHkYBAOlUENFPic8Ye/lRu6NGdhAivKwy24SQrkyHARvPbHKj+LBE15FLjL3Ta05JxB6GBWcR
 h6C8SRtdBBfetoF5awMoTnhwHAnNnfAFyZp8AZkknxOieCLq/BheYYRyoTYIrKhXo7SshvqPEfr
 MtTPsuzCRmLIGzhepuiSuiuMlAZDwLCpk=
X-Received: by 2002:a05:6830:44a6:b0:862:cac9:8ed5 with SMTP id
 46e09a7af769-862f078f09amr1690469a34.2.1795011124893; 
 Wed, 18 Nov 2026 06:12:04 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862f021aae9sm2083478a34.18.2026.11.18.06.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 06:12:04 -0800 (PST)
Date: Wed, 18 Nov 2026 08:12:01 -0600
From: Tom Rini <trini@konsulko.com>
To: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
Cc: Manorit Chawdhry <m-chawdhry@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v7 00/20] Introduce resume for J7xx SoCs
Message-ID: <20261118141201.GU554944@bill-the-cat>
References: <20261118131807.135859-1-richard.genoud@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="drpZ5pfZMCdEPu3A"
Content-Disposition: inline
In-Reply-To: <20261118131807.135859-1-richard.genoud@bootlin.com>
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


--drpZ5pfZMCdEPu3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 02:17:47PM +0100, Richard Genoud (TI) wrote:
> This series allows J7200/J721s2/J784s4/J722s to resume from suspend.
>=20
> On those SoCs, a magic value is set in a PMIC register by the DM
> firmware just before suspend, then everything but the PMIC and DDR is
> powered off.
> At resume/boot time, the magic value has to be read back by U-Boot SPL in
> order to know if we are indeed in a resume situation.
> That's the purpose of j7xx_board_is_resuming() introduced here.
>=20
> Then, if the SoC is resuming, the DDR has to be brought out of
> retention, at full speed and get out of low power mode.
> Between those steps, the DDR_RET pin has to be de-asserted. But the
> DDR_RET pins of all DDR chips are tied together on a single GPIO, so
> it's impossible to resume one DDR chip after the other, they must be all
> resumed at once.
> That's why it's orchestrated from board_init_f() and not in the k3ddrss
> driver.
>=20
> Once the DDR is fully functional, the next steps are:
> - retrieve the LPM memory region from DTS
> - authenticate certificates from LPM memory region and apply firewalls
> - ask TIFS to restore TFA and its own minimal context
> - start TFA on remote proc
> - load and jump to DM
>=20
> Disclaimer:
> ---------
> There's a potential attack vector in this sequence, because OPTEE could
> be modified before being reloaded.
> Also, if the certificate replay is skipped, then TFA can be read from
> MSMC.
>=20
> Patches 1-3 add LPM helpers for all SoCs
> Patch 4 adds the resume detection for all SoCs
> Patch 5 adds common code for DDR retention pin
> Patch 6 enables GTC at resume
> Patch 7 detects IO+DDR resume state for j7200/j784s4
> Patch 8 stores the wakeup reason in MCU_PSRAM0_RAM for j7200/j784s4
> Patch 9 sets the PMIC NSLEEP triggers
> Patches 10-12 add the DDR resume sequence for all SoCs
> Patches 13-16 add the resume flow for all SoCs
> Patch 17 updates the pm-cfg and schema to a new version
> Patch 18 removes now unneeded background firewall on DDR for j7200/j784s4
> Patch 19 extends the firewall for ATF region to TIFS
> Patch 20 add the resume flow documentation
>=20
> Tested on J722s HS-FS, J7200 GP, J784s4 GP, J721s2 GP
>=20
> https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html#tisc=
i-msg-min-context-restore
>=20
> It needs lpm_memory_regions described in DTS [updated to v6]:
> https://lore.kernel.org/lkml/20261117130737.141993-1-richard.genoud@bootl=
in.com/

Please let us know when this has landed in Linus' tree. I assume the dts
stuff will need to be cherry-picked. Thanks!

--=20
Tom

--drpZ5pfZMCdEPu3A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCav2yMAAKCRAr4qD1Cr/k
CuCDAQCp1HvzXWwO9yUbOAJ+5Brv0daBC9eTzhWh2388hFq4yQD+IT42gzuts4+J
SKtq5ZOl/W+tm1cFgGARQS/T3yOKOwo=
=t7Mn
-----END PGP SIGNATURE-----

--drpZ5pfZMCdEPu3A--
