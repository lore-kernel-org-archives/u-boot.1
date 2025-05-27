Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90C3C54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 12:15:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E213836C1;
	Tue, 27 May 2025 14:15:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MDfd1i0B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A93283721; Tue, 27 May 2025 14:15:30 +0200 (CEST)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A59318304C
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 14:15:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x544.google.com with SMTP id
 4fb4d7f45d1cf-602039559d8so6552432a12.1
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 05:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748348126; x=1748952926; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=osSrwJJ2u4lPGh84O5dIj2O4u87Xy+Lwet7HUaIuVkI=;
 b=MDfd1i0BDF3NizvWTLOum+Su/P0k62MHqfyxgFXe5HWf0asz8w3ff9geJ53hUY6LFY
 jwO0G6NhPZM8M/dYmLS+RN3goqwgqr8g9zcwtjUB1Ip81DCMABEipZ+nIN9D3ulUKXPz
 ScwuC9QxCDUKV9cTU860Dqpd8hEjjMikD/tRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748348126; x=1748952926;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=osSrwJJ2u4lPGh84O5dIj2O4u87Xy+Lwet7HUaIuVkI=;
 b=ujkkL6Nwgk9NMJKHxe8rSOoKa19Sil06t6Z130SRTAOLDITZpy6ThlYP3tAtDO8MDL
 ShX8r11L0zYq1tf9Vcx1z1UZjjzYn5QInfpSwjQ+lULPe9tyrJKvvRk5yq4mko+85NFF
 AP74hZu3zTju7XQhQ0sY0Ug8RmRTUlV3DudOCO8RGDRBRr7zSSKTbbbbMtwXMsBvUoH/
 1uvAActs3We+8yp3g1lVuXfGh0Fk9O60pk6tCHoXqtS3DRYX2nIcgWqIEmv8/Wff0PGM
 BjXVGUfx6ob+ca7u1ekVfMKMXfOXYaJQajFFW97KIeA9QwIHyq+CfW8H9kFMtO37Y2Y9
 uX9Q==
X-Gm-Message-State: AOJu0YwhW7tUokt5ADqTGSu7YAV1rHdahPHbCGp23O6bM8t8ZlpQ8j4d
 7Zh3yK7WElNuaW8YUyXlFQadBhMsucQrmOJ14Jj4IoMk7ToFVLeB09FLa3BMPhUrHd+/4nciv1N
 Ke5PDk3OvLJzE+1WeQcSD64JFK7RZAT2edbQXDUJRXBZARy7Pt7VlCWMZhK4=
X-Gm-Gg: ASbGncuh2S1GqwdlLGfaYh8lAHyCcvAxAl3i8IiQdyyx/Ym9zJoK7tDpnFjYcnKXG24
 JYWlfJeEmVllON9DqOF4+G3N6cq7cl4O4LuoMVnBCxlOmM3zfje/UL+gSwW0qoUHdSGj0RNfSQm
 nEGfVE1QlDFI+5RvMecKjB0ATZkhYRvFw=
X-Google-Smtp-Source: AGHT+IFmGuSmXge+kbNHETI07NEVczOR3RUvpyG7bykays/Vg9j6mPgXR+ZzhM1/+fL7dSdkMLNOGfTH0598OuKCMOw=
X-Received: by 2002:a05:6402:2111:b0:602:cfab:ea9a with SMTP id
 4fb4d7f45d1cf-602da402afbmr11613877a12.27.1748348126146; Tue, 27 May 2025
 05:15:26 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 May 2025 13:15:14 +0100
X-Gm-Features: AX0GCFtKyk3VHfKCgUwnMU76gXwnGxqHbzZM3aOiLd6r8ux61v0Jf17cLs_IZI0
Message-ID: <CAFLszTitaKMU84qGpu_RqVi6HJ1C5F92vy4eZg17PDoVAGZGWg@mail.gmail.com>
Subject: Please pull u-boot-dm into -next
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

This is for -next

https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/26346
(note that x86 boards and RISC-V board don't work in your tree at present)

https://dev.azure.com/simon0972/u-boot/_build/results?buildId=79&view=results


The following changes since commit 39b815d02d7ce6af32bcf023d20243c404b75a84:

  Merge tag 'v2025.07-rc3' into next (2025-05-26 16:07:19 -0600)

are available in the Git repository at:

  git://git.denx.de/u-boot-dm.git tags/dm-next-27may25

for you to fetch changes up to ec2482a24ac3a1d0beadae80bcb28c8d89b4c1ab:

  patman: Add basic documentation for new features (2025-05-27 10:07:43 +0100)

----------------------------------------------------------------
Sync up Python tools from my tree

- minor binman tweaks
- terminal improvements in u_boot_pylib
- patman move to asyncio
- patman support for new 'series' subcommand

----------------------------------------------------------------
Simon Glass (84):
      buildman: Add a way to build a particular
targethttps://dev.azure.com/simon0972/u-boot/_build/results?buildId=79&view=results
      binman: Read the skip-at-start value on startup
      binman: x86: Write skip-at-start when end-at-4gb is used
      patman: Move all non-test logic into control module
      patman: Move capture_sys_output() into terminal and rename
      binman: Correct a typo in the toolpath comment
      u_boot_pylib: Allow control of capturing
      u_boot_pylib: Improve ANSI-colour output with backgrounds
      u_boot_pylib: Add a pager
      u_boot_pylib: Avoid concurrent execution of only one test
      u_boot_pylib: Allow disabling colour output
      tools: Plumb in capture control
      patman: Correct a stray quote
      patman: Rename test_basic() in test_checkpatch
      patman: Tidy up the start-up code
      patman: Support extra test features
      patman: Move code for sending into its own module
      CI: Add a dependency file for patman
      patman: Create a module for handling patchwork
      patman: Move Patch and Review to patchwork module
      patman: Add reading of series and patch status
      patman: Rename check_patchwork_status()
      patman: Split up check_and_show_status()
      patman: Split out the processing of find_new_responses()
      patman: Adjust how the fake request() function is provided
      patman: Simplify test_find_new_responses()
      patman: Show patches in yellow
      patman: Add more information to Patch
      patman: Use defaultdict directly
      patman: Switch over to asyncio
      patman: Provide an option to run in single-threaded mode
      patman: Use a pager when outputting status
      patman: Drop the old status code
      patman: Untangle settings from gitutil
      patman: Pass the alias dict into gitutil.build_email_list()
      patman: Pass the alias dict into gitutil.email_patches()
      patman: Pass aliases to Series.MakeCcFile()
      patman: Update Series.ShowActions() to pass alias
      u_boot_pylib: Support a fatal level in tout
      u_boot_pylib: Tidy up quoting of cc and to
      u_boot_pylib: Provide directories to gitutil functions
      u_boot_pylib: Speed up determining the upstream branch
      patman: Add all files to __init__.py
      patman: Allow setting the current directory when sending
      patman: Allow setting a git directory when sending
      patman: Correct use of str in code
      patman: Use itr instead of lines for iterator
      patman: Use .git as the git directory
      patman: Use variables for series ID and title
      patman: Clean up creation of the git tree
      patman: Use git to set up the test config
      patman: Correct some pylint and asyncio issues
      patman: Split parser creation from parsing
      patman: Add tests for help
      patman: Split subparsers into their own functions
      patman: Move arguments for sent into the correct parser
      patman: Move -H out of the send command
      patman: Tidy up function comments in the series module
      patman: Support collecting all lines in the commit message
      u_boot_pylib: Correct pylint warnings in gitutil
      patman: Deal with git safe-directory warning
      u_boot_pylib: Add more functions to gitutil
      patman: Use python3 with /usr/bin/env
      patman: Add a test for collecting a PATCH prefix
      patman: Move common test code into a new module
      patman: Add a fourth series for testing
      patman: Avoid touching the system or local config
      patman: Add a simple database implementation
      patman: Add a helper for managing cseries
      patman: Add a Cseries class
      patman: Update status command support cover-letter info
      patman: Enhance patchwork interface to support Cseries
      patman: Enhance implementation of file-based defaults
      patman: Use -c to show patch comments
      patman: Support returning the parsers to use
      patman: Introduce basic database support in Series
      patman: Improve Series support for patchwork links
      patman: Implement the patchwork subcommand
      patman: Support aliases for commands and subcommands
      patman: Update send function to return whether it sent
      patman: Implement the series subcommand
      patman: Implement the upstream subcommand
      patman: Add tests for Cseries
      patman: Add basic documentation for new features

 arch/x86/cpu/intel_common/intel_opregion.c |    1 -
 arch/x86/lib/fsp2/fsp_init.c               |    2 +-
 doc/develop/binman_tests.rst               |    6 +-
 doc/develop/pics/patman.jpg                |  Bin 0 -> 97131 bytes
 lib/binman.c                               |   16 +-
 tools/binman/bintool_test.py               |   20 +-
 tools/binman/cbfs_util_test.py             |   15 +-
 tools/binman/control.py                    |    6 +-
 tools/binman/elf_test.py                   |    3 +-
 tools/binman/etype/section.py              |    6 +-
 tools/binman/fip_util_test.py              |   11 +-
 tools/binman/ftest.py                      |  106 +--
 tools/binman/image_test.py                 |    4 +-
 tools/binman/main.py                       |    4 +-
 tools/buildman/builder.py                  |    4 +-
 tools/buildman/builderthread.py            |    2 +
 tools/buildman/buildman.rst                |    4 +
 tools/buildman/cmdline.py                  |    3 +
 tools/buildman/control.py                  |    5 +-
 tools/buildman/func_test.py                |   20 +-
 tools/buildman/main.py                     |    2 +-
 tools/buildman/test.py                     |    6 +-
 tools/dtoc/main.py                         |    5 +-
 tools/dtoc/test_dtoc.py                    |   11 +-
 tools/dtoc/test_fdt.py                     |    2 +-
 tools/dtoc/test_src_scan.py                |   25 +-
 tools/patman/__init__.py                   |    9 +-
 tools/patman/__main__.py                   |   67 +-
 tools/patman/checkpatch.py                 |   15 +-
 tools/patman/cmdline.py                    |  527 ++++++++++--
 tools/patman/control.py                    |  424 ++++++----
 tools/patman/cser_helper.py                | 1524
++++++++++++++++++++++++++++++++++
 tools/patman/cseries.py                    | 1165 ++++++++++++++++++++++++++
 tools/patman/database.py                   |  823 ++++++++++++++++++
 tools/patman/func_test.py                  |  544 +++++-------
 tools/patman/get_maintainer.py             |   13 +-
 tools/patman/patchstream.py                |   44 +-
 tools/patman/patchwork.py                  |  852 +++++++++++++++++++
 tools/patman/patman.rst                    |  283 ++++++-
 tools/patman/project.py                    |    3 +-
 tools/patman/pyproject.toml                |    2 +-
 tools/patman/requirements.txt              |    3 +-
 tools/patman/send.py                       |  197 +++++
 tools/patman/series.py                     |  143 +++-
 tools/patman/settings.py                   |   77 +-
 tools/patman/status.py                     |  488 +++++------
 tools/patman/test_checkpatch.py            |    2 +-
 tools/patman/test_common.py                |  254 ++++++
 tools/patman/test_cseries.py               | 3684
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/patman/test_settings.py              |    2 +-
 tools/u_boot_pylib/__main__.py             |    2 +-
 tools/u_boot_pylib/command.py              |    5 +-
 tools/u_boot_pylib/gitutil.py              |  255 ++++--
 tools/u_boot_pylib/terminal.py             |  105 ++-
 tools/u_boot_pylib/test_util.py            |   29 +-
 tools/u_boot_pylib/tout.py                 |   27 +-
 56 files changed, 10659 insertions(+), 1198 deletions(-)
 create mode 100644 doc/develop/pics/patman.jpg
 create mode 100644 tools/patman/cser_helper.py
 create mode 100644 tools/patman/cseries.py
 create mode 100644 tools/patman/database.py
 create mode 100644 tools/patman/patchwork.py
 create mode 100644 tools/patman/send.py
 create mode 100644 tools/patman/test_common.py
 create mode 100644 tools/patman/test_cseries.py

Regards,
SImon
