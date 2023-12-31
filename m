Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD012C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 15:26:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C387877DA;
	Sun, 31 Dec 2023 16:26:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XOo9mUO5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59339877DE; Sun, 31 Dec 2023 16:26:04 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E1D387225
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 16:26:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7ba9f1cfe94so160390939f.1
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 07:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704036360; x=1704641160; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SZaxNQbbnk7sQSQ7mGoTL86b1NdGA7wi1VtfFFN3wHU=;
 b=XOo9mUO5sb95BT49KSI+IZr+qPgpgAjKFa2/ZxxKXEqm1Sw/ezI34ujP2FfCJqudWK
 7WjnaFyW0/G0L9pO9Z7U8BkxG1Qw07z/gyUeZ63ioBpXOl7MjsSxHiznk1uswp9fZ17f
 sA8yBw4o8Y9D68fY56uQ86ADAJUG7HeZTmHFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704036360; x=1704641160;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SZaxNQbbnk7sQSQ7mGoTL86b1NdGA7wi1VtfFFN3wHU=;
 b=l4LT/xhS+X7atmxpfncoAXUiY378cCVtqE9lLspnjo5ils8Snlg+E3HDoifyFpR2bN
 hDyXiVehC3fQ3cxDRKIdtwsiUMWez99Bp67nCx6bW4EBVCZT+eO5HkxCuosE0kgLDYMs
 CPrVLlSvdnq8fznqTBep7zFVJl9XsHVG+Zh99wDSNlWVNB62uH/hU8eU0LhhdyjcCwoj
 SXIQ5mrDHhKS5uzUBIKoG7iRHCQi9E3ObPejcZo4hXmsc2EcYCJhACBgd1UUxBjwd1VI
 PlDUyK9DRd90Qw7XVn/mB2MjJju1PntH7Fq/ehQOcJ4lrjfkemg8FY8Kg9VAbfxAv4ae
 0LzQ==
X-Gm-Message-State: AOJu0Yzk684EJzeJSpRwaSC0iGbW5P0SWzN4jTYiQrWdLzHca+sRITj8
 wSCatSe2b7fda4w3dByuA6pvr1h96K5CaPvIocS+bhe8urmH
X-Google-Smtp-Source: AGHT+IHy/V9IhCpMrrCYB2BLWs1OR80c5HSvaaUICUVuKw7R+zmLT8u8Igfz+VZaMwzaYGMEPxWTkA==
X-Received: by 2002:a92:c249:0:b0:35f:d638:aebe with SMTP id
 k9-20020a92c249000000b0035fd638aebemr10912422ilo.5.1704036359867; 
 Sun, 31 Dec 2023 07:25:59 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 cz9-20020a0566384a0900b0046b482039ecsm5632625jab.55.2023.12.31.07.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 07:25:59 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Igor Prusov <ivprusov@salutedevices.com>, Nikhil M Jain <n-jain1@ti.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Troy Kisky <troykiskyboundary@gmail.com>
Subject: [PATCH v5 00/12] smbios: Deal with tables beyond 4GB
Date: Sun, 31 Dec 2023 08:25:43 -0700
Message-Id: <20231231152555.464874-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

When the malloc() region extends beyond 4GB on ARM we may end up with
an SMBIOS table in that region.

Add support for writing an SMBIOS3 table, which supports a 64-bit
address.

Note that this problem does not happen on x86 since it requires the
tables to be placed just below 1MB in memory, unless
CONFIG_BLOBLIST_TABLES is enabled.

v5 drops support for SMBIOS2 tables as well. It also adds some changes
to memory mapping which should allow an EFI app (launched from sandbox)
to read the ACPI tables correctly.

Changes in v5:
- Update comment to mention x86 alignment
- Add new patch to drop support for SMBIOS2 tables
- Add new patch to drop support for SMBIOS2 tables with EFI
- Add new patch to rename test dm_test_setup_ctx_and_base_tables()
- Add new patch to write pointers to tables instead of addresses
- Add new patch to correct smbios-table installation

Changes in v4:
- Bring in this patch from Heinrich's series
- Check the start of the table rather than the end

Changes in v2:
- Check the end of the table rather than the start.
- Add a new patch to correct gd_smbios_start()
- Add a note about why unmap_system() is called

Heinrich Schuchardt (1):
  smbios: SMBIOS 3.0 (64-bit) Entry Point structure

Simon Glass (11):
  smbios: Refactor 32-bit code into an else statement
  smbios: Move the rest of the SMBIOS2 code
  smbios: Use SMBIOS 3.0 to support an address above 4GB
  smbios: Correct gd_smbios_start()
  efi: Use the correct GUID for the SMBIOS table
  smbios: Require the caller to align the SMBIOS table
  smbios: Drop support for SMBIOS2 tables
  efi: smbios: Drop support for SMBIOS2 tables
  acpi: Rename test dm_test_setup_ctx_and_base_tables()
  acpi: Write pointers to tables instead of addresses
  efi: Correct smbios-table installation

 arch/sandbox/include/asm/io.h     | 16 +++++++++
 arch/x86/lib/acpi_table.c         |  6 ++--
 cmd/acpi.c                        | 12 +++----
 include/asm-generic/global_data.h |  2 +-
 include/efi_api.h                 |  4 +++
 include/mapmem.h                  | 18 ++++++++++
 include/smbios.h                  | 41 ++++++++++++++++++++---
 lib/acpi/acpi.c                   | 12 +++----
 lib/acpi/acpi_table.c             |  4 +--
 lib/acpi/base.c                   |  4 +--
 lib/efi_loader/efi_smbios.c       | 28 +++++++++-------
 lib/smbios.c                      | 55 ++++++++++---------------------
 test/dm/acpi.c                    | 14 ++++----
 13 files changed, 134 insertions(+), 82 deletions(-)

-- 
2.34.1

