Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD4EC54E60
	for <u-boot@archiver.kernel.org>; Sat, 16 Mar 2024 21:50:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA19887DDD;
	Sat, 16 Mar 2024 22:50:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KFuBzBTa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACC8788074; Sat, 16 Mar 2024 22:50:30 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1432F87F6F
 for <u-boot@lists.denx.de>; Sat, 16 Mar 2024 22:50:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 948AC60304;
 Sat, 16 Mar 2024 21:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C0D4C433C7;
 Sat, 16 Mar 2024 21:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1710625826;
 bh=0caR6IowKIC3WRFSSUBQFWOvCpJJuJBPn6aXt3qfr7w=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=KFuBzBTafky+jl4sCgrP7lDrbiQ8w1kaWno84TbKEcKZwK8WieLJOJQo9v7aBuQBz
 4pUQG6sBPNV/vNail8wRt9P8R5eIHv8clT3szwqW81FHzq9GHoSY+lliBWHKCt8aTq
 h5yR+edgAcS/6F03PzdMCtzzqR2zHorsSLVrwrC1kU+FlyDn4ZXvGaB0cq17y5kQNZ
 Trg28jYCuqch73K0QIteb7cJN7zi1IjtpdiZ5InG+Q3ekzYQOZ3BH4yt+EYYubue69
 O70NNqXbWe0U01PSV03NDCxcKZNp5P8RkXipjL0lPZe/DcaTtlrmASF0/qz7TnFTfk
 djVzePAdXzE+Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 28C30C48BF6;
 Sat, 16 Mar 2024 21:50:26 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Subject: [PATCH v3 0/7] video: Add UTF-8 support for UEFI applications
Date: Sat, 16 Mar 2024 22:50:17 +0100
Message-Id: <20240316-vidconsole-utf8-uefi-v3-0-4e8a3d349447@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABkU9mUC/4XNywrCMBCF4VcpWTuSS6+ufA9xkSYTG5GkJG1QS
 t/dtBtxIS7/A/PNQiIGi5GcioUETDZa73KIQ0HUIN0NwerchFNeUsYaSFYr76J/IMyTaWFGY8F
 ILvpSqrrSNcmnY8jrc2cv19yDjZMPr/1LYtv6B0wMKFSiM43CpjR9d75L5+R8dDiRTUz8o3BGf
 yg8K22rqNB9TTXyL2Vd1zfL4fRn/wAAAA==
To: Anatolij Gustschin <agust@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>, 
 u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3165; i=j@jannau.net;
 h=from:subject:message-id; bh=0caR6IowKIC3WRFSSUBQFWOvCpJJuJBPn6aXt3qfr7w=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhtRvIvLr8taVr1d+bPXCkvd3x1aldV5ujw0c5O00m5c62
 wYud+3oKGVhEONikBVTZEnSftnBsLpGMab2QRjMHFYmkCEMXJwCMBFpUUaG7lqWuZVTDh+pe1k9
 oVw45Wd9uFCbwAyGx85RF5mdfJo7GBmWnbxQxRZjslht85I9EndfdynyeRZOb2V6/+m70bMKi9k
 MAA==
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/default with auth_id=62
X-Original-From: Janne Grunau <j@jannau.net>
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
Reply-To: j@jannau.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Andre submitted 2 years ago DM_VIDEO improvements for UEFI applications
using UEFI's EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL but did not follow with
suggested changes. This series takes care of the UTF-8 support which
required to draw symbol and box drawing characters used by UEFI
applications like grub2 and sd-boot correctly.

Compared to Andre's version this version has the following changes:
- use and extend existing conversion functions from lib/charset.c
- convert to Unicode code points for truetype console support
- conversion is conditional on CONFIG_CHARSET
- use escape sequences in tests as proposed by Heinrich

Link: https://lore.kernel.org/u-boot/20220110005638.21599-1-andre.przywara@arm.com/
Signed-off-by: Janne Grunau <j@jannau.net>
---
Changes in v3:
- added Reviewed-by tag
- removed unnecessary u8 casts
- limited utf-8 conversion buffer to 5 bytes as documented
- added missing console_utf_to_cp437() documentation
- adapted EFI text output self-tests according to review comments
- dropped wait after EFI text output self tests
- added StrToFat EFI self test to ensure Unicode code points which map
  to code page 437 code points 1-31 are converted to '_'
- Link to v2: https://lore.kernel.org/r/20240210-vidconsole-utf8-uefi-v2-0-88c03db60de2@jannau.net

Changes in v2:
- use "CONFIG_IS_ENABLED(CHARSET)" instead of EFI_LOADER
- rewritten commit message for mapping CP437 cp 1-31
- extended utf8_to_utf32_stream() documentation as suggested by
  Heinrich
- Link to RFC: https://lore.kernel.org/r/20240117-vidconsole-utf8-uefi-v1-0-539f7ce74fb9@jannau.net

---
Andre Przywara (2):
      efi_selftest: Add international characters test
      efi_selftest: Add box drawing character selftest

Janne Grunau (5):
      lib: charset: Fix and extend utf8_to_utf32_stream() documentation
      video: console: Parse UTF-8 character sequences
      lib/charset: Map Unicode code points to CP437 code points 1-31
      efi_selftest: Add geometric shapes character selftest
      efi_selftest: Update StrToFat() unit test after CP473 map extension

 drivers/video/console_normal.c                    |  6 ++-
 drivers/video/console_rotate.c                    | 16 ++++---
 drivers/video/console_truetype.c                  |  8 ++--
 drivers/video/vidconsole-uclass.c                 | 18 +++++---
 drivers/video/vidconsole_internal.h               | 19 ++++++++
 include/charset.h                                 | 16 +++++--
 include/cp1250.h                                  | 12 ++++-
 include/cp437.h                                   | 12 ++++-
 include/video_console.h                           | 10 +++--
 lib/charset.c                                     |  9 ++--
 lib/efi_loader/efi_unicode_collation.c            |  2 +-
 lib/efi_selftest/efi_selftest_textoutput.c        | 54 +++++++++++++++++++++++
 lib/efi_selftest/efi_selftest_unicode_collation.c | 12 +++++
 13 files changed, 162 insertions(+), 32 deletions(-)
---
base-commit: 866ca972d6c3cabeaf6dbac431e8e08bb30b3c8e
change-id: 20240117-vidconsole-utf8-uefi-fa23b4ac65d6

Best regards,
-- 
Janne Grunau <j@jannau.net>

