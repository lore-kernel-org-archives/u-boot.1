Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBB3C27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 19:16:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 823D787EBD;
	Wed, 19 Jun 2024 21:16:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CliRr/TM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D2AA80E9A; Wed, 19 Jun 2024 21:16:14 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42E14883E0
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 21:16:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f6559668e1so693715ad.3
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 12:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718824570; x=1719429370; darn=lists.denx.de;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TsHl11mE6ENbDs6PxJERbx9BKgm3kglIw406b22NJCI=;
 b=CliRr/TMa5AYu1SLgVGyvYxQEOC4v1ounmb/iIjdcp9V1vKbFS1wADObOg6txpVv2O
 eJjcoKaXSwBFxz917Pw2tP0cKcyvyudyPVLOe54fbd2KU+fWwT1J06PFVWlBdyQZoc1j
 Tyk0PEBHnZJeU1exlP7yDZvWhrBzHe7e38wE2wDitStYfMW7ZBisKURvLd3UnaNNtIfj
 Y67ZO21aJO1mHJi7LYobvEXR0HzATwFHMJMWtrsHKdUN2h6OIvUWW99JaU6HlRBu0PBy
 d7C/cGS1pkbG9/Aa7UPwOG/O8inaKhNDX1T140qokxzF81Gl8487BkcM/nOgOggmUW3L
 qKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718824570; x=1719429370;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TsHl11mE6ENbDs6PxJERbx9BKgm3kglIw406b22NJCI=;
 b=RyAWbmTmsNxDLAdnt5PfFUh+dMkLxxMuXj1+iyLGJ7FdwUFFIoYyUU1d52LaNs1kUy
 h+P2RLIFUHHv79bZC0VTRkLsx5WHjGDUV8fhU9TXmjZjMEQJwK9NA2ZtOYFKQwn3NCau
 ZXfEpdRzLIt1BDmAeQunEvBuSGCQk1FiZSXVq/as4sPxn0jy4DDysWIlHA5cpgpAi0ZZ
 fxKpThyN4+2si+2QafhEneyXZIJahsYrw9Ch/v/zA6ykn8RGtdc7TIdY2lfzf0kpAjAi
 p0OB5D2q4j4iwpUnc1thHwQH8x+RbtoDE6V8EymBXYKGOZhCjlSD/r3JjVT0Jac4R8RU
 M/dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTF2HxaDfRm1RmStEiX5v1S4uAF7ckmzgYt4crynHSlJR4iKmTKLcia/gR/c7XeNd/Lp9pkXb0121ZrGe/CbfoH0GF6Q==
X-Gm-Message-State: AOJu0YweEN11WZ1GToZ7Q6I8Tj8+/RjJIowaERCXWe8dxBwUE31g8dY/
 ENf8b37EQCF/m91TBLkS4FmKTOOH7fxNLoojY+0oGPVFbP8S3luyuOWinTrOHL6DIvo5ouzkGdJ
 1g1cNsR5P+xPxIey8teY4Ips6DV19E0TH/AHwkA==
X-Google-Smtp-Source: AGHT+IHdjph+e3ahKT2JXK51W/vs4Ndz4bTK5lp66QEFn0dwsldPYEZnbHQddg+rx3TVcqog1O/gzy3Ixd7PGhS/Wgc=
X-Received: by 2002:a17:902:ec86:b0:1f9:c508:acd5 with SMTP id
 d9443c01a7336-1f9c508b6d2mr4958215ad.5.1718824569519; Wed, 19 Jun 2024
 12:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
 <ZnLk_pXstP2dlRGo@debian>
In-Reply-To: <ZnLk_pXstP2dlRGo@debian>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 19 Jun 2024 22:15:32 +0300
Message-ID: <CAC_iWjL_rytosTAcsW2-3fmwVhjTgkMRAB0LwPuNpq73K=YmcQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] efi: CapsuleUpdate: support for dynamic UUIDs
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

All=C3=B4 Vincent,

Thanks for testing!

On Wed, 19 Jun 2024 at 17:02, Vincent Stehl=C3=A9 <vincent.stehle@arm.com> =
wrote:
>
> On Fri, May 31, 2024 at 03:50:34PM +0200, Caleb Connolly wrote:
> > As more boards adopt support for the EFI CapsuleUpdate mechanism, there
> > is a growing issue of being able to target updates to them properly. Th=
e
> > current mechanism of hardcoding UUIDs for each board at compile time is
> > unsustainable, and maintaining lists of GUIDs is similarly cumbersome.
> >
> > In this series, I propose that we adopt v5 GUIDs, these are generated
> > by using a well-known salt GUID as well as board specific information
> > (like the model/revision), these are hashed together and the result is
> > truncated to form a new UUID.
>
> Dear Caleb,
>
> Thank you for working on this proposal, this looks very useful.
> Indeed, we found out during SystemReady certifications that it is easy fo=
r
> unique ids to be inadvertently re-used, making them thus non-unique.
>
> I have a doubt regarding the format of the generated UUIDs, which end up =
in the
> ESRT, though.
>
> Here is a quick experiment on the sandbox booting with a DTB using the ef=
idebug
> command.
>
> With the patch series, rebased on the master branch:
>
>   $ make sandbox_defconfig
>   $ make
>   $ ./u-boot --default_fdt
>   ...
>   U-Boot 2024.07-rc4-00028-g1c96225b0b3 (Jun 19 2024 - 15:29:04 +0200)
>   ...
>   Model: sandbox
>   ...
>   Hit any key to stop autoboot:  0
>   =3D> efidebug capsule esrt
>   ...
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   ESRT: fw_resource_count=3D2
>   ESRT: fw_resource_count_max=3D2
>   ESRT: fw_resource_version=3D1
>   [entry 0]=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   ESRT: fw_class=3DFD5DB83C-12F3-A46B-80A9-E3007C7FF56E
>   ...
>   [entry 1]=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   ESRT: fw_class=3D935FE837-FAC8-4394-C008-737D8852C60D
>   ...
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   $ uuid -d FD5DB83C-12F3-A46B-80A9-E3007C7FF56E
>   encode: STR:     fd5db83c-12f3-a46b-80a9-e3007c7ff56e
>           SIV:     336781303264349553179461347850802165102
>   decode: variant: DCE 1.1, ISO/IEC 11578:1996
>           version: 10 (unknown)
>           content: FD:5D:B8:3C:12:F3:04:6B:00:A9:E3:00:7C:7F:F5:6E
>                    (not decipherable: unknown UUID version)
>
> Version 10 does not look right.

So, this seems to be an endianess problem.
Looking at RFC4122 only the space ID needs to be in BE.

>
>   $ uuid -d 935FE837-FAC8-4394-C008-737D8852C60D
>   encode: STR:     935fe837-fac8-4394-c008-737d8852c60d
>           SIV:     195894493536133784175416063449172723213
>   decode: variant: reserved (Microsoft GUID)
>           version: 4 (random data based)
>           content: 93:5F:E8:37:FA:C8:03:94:00:08:73:7D:88:52:C6:0D
>                    (no semantics: random data only)
>
> A reserved Microsoft GUID variant does not look right.

This seems like an existing bug. RFC4122 defines the MS reserved GUIDs
in the variant as
1     1     0    Reserved, Microsoft Corporation backward
compatibility and the existing UUID_VARIANT_MASK is defined as 0xc0...

The patch below should work for you (on top of Calebs')

diff --git a/include/uuid.h b/include/uuid.h
index b38b20d957ef..78ed5839d2d6 100644
--- a/include/uuid.h
+++ b/include/uuid.h
@@ -81,7 +81,7 @@ struct uuid {
 #define UUID_VERSION_SHIFT     12
 #define UUID_VERSION           0x4

-#define UUID_VARIANT_MASK      0xc0
+#define UUID_VARIANT_MASK      0xb0
 #define UUID_VARIANT_SHIFT     7
 #define UUID_VARIANT           0x1

diff --git a/lib/uuid.c b/lib/uuid.c
index 89911b06ccc0..73251eaa397e 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -411,9 +411,9 @@ void gen_uuid_v5(const struct uuid *namespace,
struct uuid *uuid, ...)
        memcpy(uuid, hash, sizeof(*uuid));

        /* Configure variant/version bits */
-       tmp =3D be32_to_cpu(uuid->time_hi_and_version);
+       tmp =3D uuid->time_hi_and_version;
        tmp =3D (tmp & ~UUID_VERSION_MASK) | (5 << UUID_VERSION_SHIFT);
-       uuid->time_hi_and_version =3D cpu_to_be32(tmp);
+       uuid->time_hi_and_version =3D tmp;

        uuid->clock_seq_hi_and_reserved &=3D UUID_VARIANT_MASK;
        uuid->clock_seq_hi_and_reserved |=3D UUID_VARIANT << UUID_VARIANT_S=
HIFT;

Can you give it a shot?
What I am afraid of is breaking existing use cases using a different
variant mask....
If that's the case we might need to keep the buggy existing
UUID_VARIANT_MASK and use the new one only on v5 and newer code

Thanks
/Ilias


>
> With the master branch, the (hardcoded) GUIDs are ok:
>
>   $ ./u-boot --default_fdt
>   ...
>   U-Boot 2024.07-rc4-00021-gfe2ce09a075 (Jun 19 2024 - 15:35:08 +0200)
>   ...
>   Model: sandbox
>   ...
>   =3D> efidebug capsule esrt
>   ...
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   ESRT: fw_resource_count=3D2
>   ESRT: fw_resource_count_max=3D2
>   ESRT: fw_resource_version=3D1
>   [entry 0]=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   ESRT: fw_class=3D09D7CF52-0720-4710-91D1-08469B7FE9C8
>   ...
>   [entry 1]=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   ESRT: fw_class=3D5A7021F5-FEF2-48B4-AABA-832E777418C0
>   ...
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   $ uuid -d 09D7CF52-0720-4710-91D1-08469B7FE9C8
>   encode: STR:     09d7cf52-0720-4710-91d1-08469b7fe9c8
>           SIV:     13083600744351929150374221048734280136
>   decode: variant: DCE 1.1, ISO/IEC 11578:1996
>           version: 4 (random data based)
>           content: 09:D7:CF:52:07:20:07:10:11:D1:08:46:9B:7F:E9:C8
>                    (no semantics: random data only)
>
>   $ uuid -d 5A7021F5-FEF2-48B4-AABA-832E777418C0
>   encode: STR:     5a7021f5-fef2-48b4-aaba-832e777418c0
>           SIV:     120212745678117161641696128857923655872
>   decode: variant: DCE 1.1, ISO/IEC 11578:1996
>           version: 4 (random data based)
>           content: 5A:70:21:F5:FE:F2:08:B4:2A:BA:83:2E:77:74:18:C0
>                    (no semantics: random data only)
>
> Also, this is what to expect for a v5 UUID [1]:
>
>   $ uuid -d a8f6ae40-d8a7-58f0-be05-a22f94eca9ec
>   encode: STR:     a8f6ae40-d8a7-58f0-be05-a22f94eca9ec
>           SIV:     224591142595989943290477237735758014956
>   decode: variant: DCE 1.1, ISO/IEC 11578:1996
>           version: 5 (name based, SHA-1)
>           content: A8:F6:AE:40:D8:A7:08:F0:3E:05:A2:2F:94:EC:A9:EC
>                    (not decipherable: truncated SHA-1 message digest only=
)
>
> Best regards,
> Vincent.
>
> [1] https://uuid.ramsey.dev/en/stable/rfc4122/version5.html
>
> >
> > The well-known salt GUID can be specific to the architecture (SoC
> > vendor), or OEM. It is defined in the board defconfig so that vendors
> > can easily bring their own.
> >
> > Specifically, the following fields are used to generate a GUID for a
> > particular fw_image:
> >
> > * namespace salt
> > * board compatible (usually the first entry in the dt root compatible
> >   array).
> > * fw_image name (the string identifying the specific image, especially
> >   relevant for board that can update multiple images).
> >
> > =3D=3D Usage =3D=3D
> >
> > Boards can integrate dynamic UUID support as follows:
> >
> > 1. Adjust Kconfig to depend on EFI_CAPSULE_DYNAMIC_UUIDS if
> >    EFI_HAVE_CAPSULE_SUPPORT.
> > 2. Skip setting the fw_images image_type_id property.
> > 3. Generate a UUID and set CONFIG_EFI_CAPSULE_NAMESPACE_UUID in your
> >    defconfig.
> >
> > =3D=3D Limitations =3D=3D
> >
> > * Changing GUIDs
> >
> > The primary limitation with this approach is that if any of the source
> > fields change, so will the GUID for the board. It is therefore pretty
> > important to ensure that GUID changes are caught during development.
> >
> > * Supporting multiple boards with a single image
> >
> > This now requires having an entry with the GUID for every board which
> > might lead to larger UpdateCapsule images.
> >
> > =3D=3D Tooling =3D=3D
> >
> > This series introduces a new tool: genguid. This can be used to generat=
e
> > the same GUIDs that the board would at runtime.
> >
> > This series follows a related discussion started by Ilias:
> > https://lore.kernel.org/u-boot/CAC_iWjJNHa4gMF897MqYZNdbgjFG8K4kwGsTXWu=
y72WkYLizrw@mail.gmail.com/
> >
> > ---
> > Changes in v3:
> > - Add manpage for genguid
> > - Add dedicated CONFIG_TOOLS_GENGUID option
> > - Minor code fixes addressing v2 feedback
> > - Link to v2: https://lore.kernel.org/r/20240529-b4-dynamic-uuid-v2-0-c=
26f31057bbe@linaro.org
> >
> > Changes in v2:
> > - Move namespace UUID to be defined in defconfig
> > - Add tests and tooling
> > - Only use the first board compatible to generate UUID.
> > - Link to v1: https://lore.kernel.org/r/20240426-b4-dynamic-uuid-v1-0-e=
8154e00ec44@linaro.org
> >
> > ---
> > Caleb Connolly (7):
> >       lib: uuid: add UUID v5 support
> >       efi: add a helper to generate dynamic UUIDs
> >       doc: uefi: document dynamic UUID generation
> >       sandbox: switch to dynamic UUIDs
> >       lib: uuid: supporting building as part of host tools
> >       tools: add genguid tool
> >       test: lib/uuid: add unit tests for dynamic UUIDs
> >
> >  arch/Kconfig                                       |   1 +
> >  board/sandbox/sandbox.c                            |  16 ---
> >  configs/sandbox_defconfig                          |   1 +
> >  configs/sandbox_flattree_defconfig                 |   1 +
> >  doc/develop/uefi/uefi.rst                          |  31 +++++
> >  doc/genguid.1                                      |  52 +++++++
> >  include/sandbox_efi_capsule.h                      |   6 +-
> >  include/uuid.h                                     |  21 ++-
> >  lib/Kconfig                                        |   8 ++
> >  lib/efi_loader/Kconfig                             |  23 +++
> >  lib/efi_loader/efi_capsule.c                       |   1 +
> >  lib/efi_loader/efi_firmware.c                      |  66 +++++++++
> >  lib/uuid.c                                         |  81 +++++++++--
> >  test/lib/uuid.c                                    |  88 ++++++++++++
> >  .../test_efi_capsule/test_capsule_firmware_fit.py  |   2 +-
> >  .../test_efi_capsule/test_capsule_firmware_raw.py  |   8 +-
> >  .../test_capsule_firmware_signed_fit.py            |   2 +-
> >  .../test_capsule_firmware_signed_raw.py            |   4 +-
> >  test/py/tests/test_efi_capsule/version.dts         |   6 +-
> >  tools/Kconfig                                      |   7 +
> >  tools/Makefile                                     |   3 +
> >  tools/binman/etype/efi_capsule.py                  |   2 +-
> >  tools/binman/ftest.py                              |   2 +-
> >  tools/genguid.c                                    | 154 +++++++++++++=
++++++++
> >  24 files changed, 538 insertions(+), 48 deletions(-)
> > ---
> > change-id: 20240422-b4-dynamic-uuid-1a5ab1486c27
> > base-commit: 2e682a4a406fc81ef32e05c28542cc8067f1e15f
> >
> > // Caleb (they/them)
> >
