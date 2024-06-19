Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E40FC27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 14:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5880C883E0;
	Wed, 19 Jun 2024 16:02:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 700E388415; Wed, 19 Jun 2024 16:02:47 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A838987E06
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 16:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7AAB1042;
 Wed, 19 Jun 2024 07:03:08 -0700 (PDT)
Received: from debian (unknown [10.57.7.74])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EF2C3F6A8;
 Wed, 19 Jun 2024 07:02:41 -0700 (PDT)
Date: Wed, 19 Jun 2024 16:02:38 +0200
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 0/7] efi: CapsuleUpdate: support for dynamic UUIDs
Message-ID: <ZnLk_pXstP2dlRGo@debian>
Mail-Followup-To: Caleb Connolly <caleb.connolly@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
References: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
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

On Fri, May 31, 2024 at 03:50:34PM +0200, Caleb Connolly wrote:
> As more boards adopt support for the EFI CapsuleUpdate mechanism, there
> is a growing issue of being able to target updates to them properly. The
> current mechanism of hardcoding UUIDs for each board at compile time is
> unsustainable, and maintaining lists of GUIDs is similarly cumbersome.
> 
> In this series, I propose that we adopt v5 GUIDs, these are generated
> by using a well-known salt GUID as well as board specific information
> (like the model/revision), these are hashed together and the result is
> truncated to form a new UUID.

Dear Caleb,

Thank you for working on this proposal, this looks very useful.
Indeed, we found out during SystemReady certifications that it is easy for
unique ids to be inadvertently re-used, making them thus non-unique.

I have a doubt regarding the format of the generated UUIDs, which end up in the
ESRT, though.

Here is a quick experiment on the sandbox booting with a DTB using the efidebug
command.

With the patch series, rebased on the master branch:

  $ make sandbox_defconfig
  $ make
  $ ./u-boot --default_fdt
  ...
  U-Boot 2024.07-rc4-00028-g1c96225b0b3 (Jun 19 2024 - 15:29:04 +0200)
  ...
  Model: sandbox
  ...
  Hit any key to stop autoboot:  0
  => efidebug capsule esrt
  ...
  ========================================
  ESRT: fw_resource_count=2
  ESRT: fw_resource_count_max=2
  ESRT: fw_resource_version=1
  [entry 0]==============================
  ESRT: fw_class=FD5DB83C-12F3-A46B-80A9-E3007C7FF56E
  ...
  [entry 1]==============================
  ESRT: fw_class=935FE837-FAC8-4394-C008-737D8852C60D
  ...
  ========================================

  $ uuid -d FD5DB83C-12F3-A46B-80A9-E3007C7FF56E
  encode: STR:     fd5db83c-12f3-a46b-80a9-e3007c7ff56e
          SIV:     336781303264349553179461347850802165102
  decode: variant: DCE 1.1, ISO/IEC 11578:1996
          version: 10 (unknown)
          content: FD:5D:B8:3C:12:F3:04:6B:00:A9:E3:00:7C:7F:F5:6E
                   (not decipherable: unknown UUID version)

Version 10 does not look right.

  $ uuid -d 935FE837-FAC8-4394-C008-737D8852C60D
  encode: STR:     935fe837-fac8-4394-c008-737d8852c60d
          SIV:     195894493536133784175416063449172723213
  decode: variant: reserved (Microsoft GUID)
          version: 4 (random data based)
          content: 93:5F:E8:37:FA:C8:03:94:00:08:73:7D:88:52:C6:0D
                   (no semantics: random data only)

A reserved Microsoft GUID variant does not look right.

With the master branch, the (hardcoded) GUIDs are ok:

  $ ./u-boot --default_fdt
  ...
  U-Boot 2024.07-rc4-00021-gfe2ce09a075 (Jun 19 2024 - 15:35:08 +0200)
  ...
  Model: sandbox
  ...
  => efidebug capsule esrt
  ...
  ========================================
  ESRT: fw_resource_count=2
  ESRT: fw_resource_count_max=2
  ESRT: fw_resource_version=1
  [entry 0]==============================
  ESRT: fw_class=09D7CF52-0720-4710-91D1-08469B7FE9C8
  ...
  [entry 1]==============================
  ESRT: fw_class=5A7021F5-FEF2-48B4-AABA-832E777418C0
  ...
  ========================================

  $ uuid -d 09D7CF52-0720-4710-91D1-08469B7FE9C8
  encode: STR:     09d7cf52-0720-4710-91d1-08469b7fe9c8
          SIV:     13083600744351929150374221048734280136
  decode: variant: DCE 1.1, ISO/IEC 11578:1996
          version: 4 (random data based)
          content: 09:D7:CF:52:07:20:07:10:11:D1:08:46:9B:7F:E9:C8
                   (no semantics: random data only)

  $ uuid -d 5A7021F5-FEF2-48B4-AABA-832E777418C0
  encode: STR:     5a7021f5-fef2-48b4-aaba-832e777418c0
          SIV:     120212745678117161641696128857923655872
  decode: variant: DCE 1.1, ISO/IEC 11578:1996
          version: 4 (random data based)
          content: 5A:70:21:F5:FE:F2:08:B4:2A:BA:83:2E:77:74:18:C0
                   (no semantics: random data only)

Also, this is what to expect for a v5 UUID [1]:

  $ uuid -d a8f6ae40-d8a7-58f0-be05-a22f94eca9ec
  encode: STR:     a8f6ae40-d8a7-58f0-be05-a22f94eca9ec
          SIV:     224591142595989943290477237735758014956
  decode: variant: DCE 1.1, ISO/IEC 11578:1996
          version: 5 (name based, SHA-1)
          content: A8:F6:AE:40:D8:A7:08:F0:3E:05:A2:2F:94:EC:A9:EC
                   (not decipherable: truncated SHA-1 message digest only)

Best regards,
Vincent.

[1] https://uuid.ramsey.dev/en/stable/rfc4122/version5.html

> 
> The well-known salt GUID can be specific to the architecture (SoC
> vendor), or OEM. It is defined in the board defconfig so that vendors
> can easily bring their own.
> 
> Specifically, the following fields are used to generate a GUID for a
> particular fw_image:
> 
> * namespace salt
> * board compatible (usually the first entry in the dt root compatible
>   array).
> * fw_image name (the string identifying the specific image, especially
>   relevant for board that can update multiple images).
> 
> == Usage ==
> 
> Boards can integrate dynamic UUID support as follows:
> 
> 1. Adjust Kconfig to depend on EFI_CAPSULE_DYNAMIC_UUIDS if
>    EFI_HAVE_CAPSULE_SUPPORT.
> 2. Skip setting the fw_images image_type_id property.
> 3. Generate a UUID and set CONFIG_EFI_CAPSULE_NAMESPACE_UUID in your
>    defconfig.
> 
> == Limitations ==
> 
> * Changing GUIDs
> 
> The primary limitation with this approach is that if any of the source
> fields change, so will the GUID for the board. It is therefore pretty
> important to ensure that GUID changes are caught during development.
> 
> * Supporting multiple boards with a single image
> 
> This now requires having an entry with the GUID for every board which
> might lead to larger UpdateCapsule images.
> 
> == Tooling ==
> 
> This series introduces a new tool: genguid. This can be used to generate
> the same GUIDs that the board would at runtime.
> 
> This series follows a related discussion started by Ilias:
> https://lore.kernel.org/u-boot/CAC_iWjJNHa4gMF897MqYZNdbgjFG8K4kwGsTXWuy72WkYLizrw@mail.gmail.com/
> 
> ---
> Changes in v3:
> - Add manpage for genguid
> - Add dedicated CONFIG_TOOLS_GENGUID option
> - Minor code fixes addressing v2 feedback
> - Link to v2: https://lore.kernel.org/r/20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org
> 
> Changes in v2:
> - Move namespace UUID to be defined in defconfig
> - Add tests and tooling
> - Only use the first board compatible to generate UUID.
> - Link to v1: https://lore.kernel.org/r/20240426-b4-dynamic-uuid-v1-0-e8154e00ec44@linaro.org
> 
> ---
> Caleb Connolly (7):
>       lib: uuid: add UUID v5 support
>       efi: add a helper to generate dynamic UUIDs
>       doc: uefi: document dynamic UUID generation
>       sandbox: switch to dynamic UUIDs
>       lib: uuid: supporting building as part of host tools
>       tools: add genguid tool
>       test: lib/uuid: add unit tests for dynamic UUIDs
> 
>  arch/Kconfig                                       |   1 +
>  board/sandbox/sandbox.c                            |  16 ---
>  configs/sandbox_defconfig                          |   1 +
>  configs/sandbox_flattree_defconfig                 |   1 +
>  doc/develop/uefi/uefi.rst                          |  31 +++++
>  doc/genguid.1                                      |  52 +++++++
>  include/sandbox_efi_capsule.h                      |   6 +-
>  include/uuid.h                                     |  21 ++-
>  lib/Kconfig                                        |   8 ++
>  lib/efi_loader/Kconfig                             |  23 +++
>  lib/efi_loader/efi_capsule.c                       |   1 +
>  lib/efi_loader/efi_firmware.c                      |  66 +++++++++
>  lib/uuid.c                                         |  81 +++++++++--
>  test/lib/uuid.c                                    |  88 ++++++++++++
>  .../test_efi_capsule/test_capsule_firmware_fit.py  |   2 +-
>  .../test_efi_capsule/test_capsule_firmware_raw.py  |   8 +-
>  .../test_capsule_firmware_signed_fit.py            |   2 +-
>  .../test_capsule_firmware_signed_raw.py            |   4 +-
>  test/py/tests/test_efi_capsule/version.dts         |   6 +-
>  tools/Kconfig                                      |   7 +
>  tools/Makefile                                     |   3 +
>  tools/binman/etype/efi_capsule.py                  |   2 +-
>  tools/binman/ftest.py                              |   2 +-
>  tools/genguid.c                                    | 154 +++++++++++++++++++++
>  24 files changed, 538 insertions(+), 48 deletions(-)
> ---
> change-id: 20240422-b4-dynamic-uuid-1a5ab1486c27
> base-commit: 2e682a4a406fc81ef32e05c28542cc8067f1e15f
> 
> // Caleb (they/them)
> 
