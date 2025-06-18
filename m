Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DABBC7115B
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 14:50:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6F0682D4A;
	Wed, 18 Jun 2025 16:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BUVcxs6r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECC2682D4A; Wed, 18 Jun 2025 16:50:23 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2554082D32
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 16:50:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-73a45bb2ac6so2552830a34.0
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 07:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750258220; x=1750863020; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HvqOtCqiXHeKQalzoEX0IqTtTN+wUmnASMzpRMIR3Kg=;
 b=BUVcxs6rr2AaaLzHXj1rPLyOm3Xx7JecGnfQJ3jWHBxKptDN1GWkaZzLcm3zigJMKc
 cXsr1zBU4PlDZeiDnqn3VFwMpsbDw/wxDmTSF6C2VFV85eZpUXniF7ciAp2eDzw9XxLZ
 ZRQc9RC24nJ6+BTjOwdOLMz8wmiE8obBHpPE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750258220; x=1750863020;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HvqOtCqiXHeKQalzoEX0IqTtTN+wUmnASMzpRMIR3Kg=;
 b=uzBzhZE+AtBKOGXaS4xtNwQlswsoo1egJYuErlmT7/bW2rodZ3ArG85M3xu4+ObvbO
 8th/Oost1wct4XRBna0+JmxRpM+8+bFGoHiYy1KERuxFIFptBiqZ5v+jG/j0R3G7zsVt
 szaBb+1rxCqHXQhUk/JevrK72lBTrc8VFXA3Cos3rd0LGC5z82xxM/WvGPl4zbdVb7hu
 OSeGlqP6wPvuYhe8sNoUPoMd6BPJxthu+4NRy5x9m616T/hDp9kgPQdJXYr8mmkaqiLe
 K2BFurQD4OigT85c2SOdqDFDsh1pahpGyXebbeP0vJWHwsRNsTKGgCwPIQMLTJSFzLDm
 ppMw==
X-Gm-Message-State: AOJu0Yw7FlB6nXNgIbJru8ZOvDinSy0v0AQcxy7OtgqOPEIPo9ZProjn
 raJLGsd9PmI2cm6lmzysFdtDwNZxjz5aNFiEEXmTdTzTGqM4AEW1YKvIceO7U13FK7E=
X-Gm-Gg: ASbGnctnuGhz12ySBlpAZZemR/e94R4gKSK5WM3J+7ggJf0Q32n5l1OwqRXzerZnYip
 teATJkiHRuijPgPHhggkM7pH9iMh4q+uVVClizgwKr8MuSYyv2SW+wzdAw/kc6vhJDHPCM9qMFm
 VBgZfi8EHYbiTOc7R+C8o2mHCurtN2eZYKaF+vqyuS2PceFYE84Pv6Jr1KGw5L9oNsapMxvvAeO
 Wvr15sFSi/FWBkgy4Xh7V6CaJSIGiWq6C0TYyXgHw4vQPSTH8f0x79MoAu+7MuiXGsJkNjLATaB
 w099sZbM3b96ogB5mGLEj5cRQIEI637tEZ0DyfL+O4Ko+jAteiLJiFKonAizc9dqXrvf173mxhx
 3Cshuvs5JI7jgAg4/EEr1qrE=
X-Google-Smtp-Source: AGHT+IFelI3/K7dc5Yp3KgVB44R0FU9MaXXVJPVgPuZJ98buXeYRdL8sNZQFwyq9RQes0/frqFszMQ==
X-Received: by 2002:a05:6871:14f:b0:2d4:e101:13dd with SMTP id
 586e51a60fabf-2eaf082785cmr9658556fac.1.1750258219732; 
 Wed, 18 Jun 2025 07:50:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2eab8edbd91sm2783075fac.41.2025.06.18.07.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 07:50:18 -0700 (PDT)
Date: Wed, 18 Jun 2025 08:50:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 mripard@redhat.com, alexl@redhat.com, mkorpers@redhat.com,
 eballetb@redhat.com, mskrivan@redhat.com,
 Alexey Romanov <avromanov@salutedevices.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Maks Mishin <maks.mishinfz@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH v2 0/4] efi_loader: add EFI_PARTITION_INFO_PROTOCOL support
Message-ID: <20250618145016.GF6521@bill-the-cat>
References: <20250618080056.1973311-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pFQ30dL8mpEd2a/O"
Content-Disposition: inline
In-Reply-To: <20250618080056.1973311-1-javierm@redhat.com>
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


--pFQ30dL8mpEd2a/O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 10:00:34AM +0200, Javier Martinez Canillas wrote:
> This patch series implements support for the EFI_PARTITION_INFO_PROTOCOL,
> to provide cached partition information for GPT partition types.
>=20
> The EFI specification mentions that the protocol can understand legacy MBR
> partition types, but that's for backward compatibility and not implemented
> by this series. It can be added as a follow-up if needed, to make it fully
> compliant with the spec.
>=20
> Patch #1 moves the logic to get a GPT partition table entry to a helper
> part_get_gpt_pte() function.
>=20
> Patch #2 exposes that helper function to be used by the efi_loader.
>=20
> Patch #3 implements the actual protocol support using the mentioned helper
> to get the GPT partitions table entries.
>=20
> Patch #4 extends the existing block io EFI selftest to also check for some
> cached data provided by the partition info protocol.
>=20
> This is a v2 of the series, the first version can be found here:
>=20
> https://lists.denx.de/pipermail/u-boot/2025-June/592237.html
>=20
> The EFI_PARTITION_INFO_PROTOCOL implementation is added unconditionally,
> because the u-boot-size-test.sh reports the code increase is negligible:
>=20
>     ./u-boot-size-test.sh qemu_arm64_lwip --all
>     ...
>     01: Merge tag 'u-boot-dfu-20250616' of https://source.denx.de/u-boot/=
custodians/u-boot-dfu
>     02: disk: efi: Move logic to get a GPT entry into a helper function
>     03: disk: efi: expose the part_get_gpt_pte() helper function
>     04: efi_loader: disk: add EFI_PARTITION_INFO_PROTOCOL support
>     05: efi_selftest: Add basic partition info check to block io test
>         5    0    0 /5              qemu_arm64_lwip
>     Completed: 5 total built, 5 newly), duration 0:01:32, rate 0.05
>     /tmp/qemu_arm64_lwip/add-efi-part-info-proto-v2/boards.cfg is up to d=
ate. Nothing to do.
>     Summary of 5 commits for 1 boards (1 thread, 8 jobs per thread)
>     01: Merge tag 'u-boot-dfu-20250616' of https://source.denx.de/u-boot/=
custodians/u-boot-dfu
>     02: disk: efi: Move logic to get a GPT entry into a helper function
>        aarch64: (for 1/1 boards) all -64.0 text -64.0
>                 qemu_arm64_lwip: all -64 text -64
>                    u-boot: add: 0/0, grow: 0/-1 bytes: 0/-72 (-72)
>                      function                                   old     n=
ew   delta
>                      part_get_info_efi                          468     3=
96     -72
>     03: disk: efi: expose the part_get_gpt_pte() helper function
>        aarch64: (for 1/1 boards) all +32.0 text +32.0
>                 qemu_arm64_lwip: all +32 text +32
>                    u-boot: add: 1/0, grow: 0/-1 bytes: 200/-164 (36)
>                      function                                   old     n=
ew   delta
>                      part_get_gpt_pte                             -     2=
00    +200
>                      part_get_info_efi                          396     2=
32    -164
>     04: efi_loader: disk: add EFI_PARTITION_INFO_PROTOCOL support
>        aarch64: (for 1/1 boards) all +144.0 rodata +16.0 text +128.0
>                 qemu_arm64_lwip: all +144 rodata +16 text +128
>                    u-boot: add: 0/0, grow: 1/0 bytes: 148/0 (148)
>                      function                                   old     n=
ew   delta
>                      static.efi_disk_add_dev                    636     7=
84    +148
>     05: efi_selftest: Add basic partition info check to block io test
>        aarch64: (for 1/1 boards) all +563.0 rodata +179.0 text +384.0
>                 qemu_arm64_lwip: all +563 rodata +179 text +384
>                    u-boot: add: 1/0, grow: 1/0 bytes: 384/0 (384)
>                      function                                   old     n=
ew   delta
>                      execute                                  36428   367=
96    +368
>                      partition_info_guid                          -      =
16     +16
>     (no errors to report)

Thanks for digging at the size part here. I don't think that amount of
growth justifies a new Kconfig option.

--=20
Tom

--pFQ30dL8mpEd2a/O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhS0iQACgkQFHw5/5Y0
tyx5IQv/c/fHi8sI+7FF8fE1Z9y+QtE6+hodafTWKh2+ynXoIVS5rnX/g2A7niLC
wuMzSaFzPO22xvAq1z3trAcIYjLr1XNfLAT0SY/BLxhTiCvYVJMULYMZDSXbF034
qxfDQhsACncfkbDrytfaEy+yW8rULiWoLwLTu94zt7ahwYrsBloicYJTCGNoe3RR
Lubc1Xjv+XPoGaG25IJEPPptfLnQtgJARI2DRDlH/elJerAp3ef6EBwLWLkFuyri
ytYjL9PNqm10wCwGLOapgQk9v9khUHx56G0TRlCXsupZibRlN3YH7ZnpMRF+uweP
Ew4QGLVp9Ch4Hdmrpmg4hFavTWMwjowHPhqYAW1SwmZoWdqtk4bH1BSXsP29o4X6
f35G/ieEanWiSHGsp6ymZYqZYJQhJDi2e0oRUaLWU+7fGMWmXmR6sGZ8AXd/c77F
gRxN84CAAJGSgZt9mDznH3ld/6BcMeYS8yZuv/s/NnQ5NQQvjfuK/INHw4sPicWh
2w5zf7nY
=BZpb
-----END PGP SIGNATURE-----

--pFQ30dL8mpEd2a/O--
