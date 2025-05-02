Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4294C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 21:40:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1190E81FAB;
	Fri,  2 May 2025 23:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Al/lBFe5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0974820EB; Fri,  2 May 2025 23:40:47 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6071781F7E
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 23:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ac28e66c0e1so267992166b.0
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 14:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746222044; x=1746826844; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=kcHRn4hqs/gjJIcjsWoui/y+ycxJwKBqLuqYdNolDns=;
 b=Al/lBFe57yvxVB4ix15tQ9emhrO+R+zcPehoIOaDAClleLmK7+YEVQn1Sll9NISqyg
 tzBqsUpImQFy3AV3yy9NWwaIaEjAMKq2j+o9Ad4RdgpGN2uoqb7wFLXw/WVqqiKIKSQE
 C1Bu9WYA032x/GBdyRF0bYQHP5uueNBH9CEAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746222044; x=1746826844;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kcHRn4hqs/gjJIcjsWoui/y+ycxJwKBqLuqYdNolDns=;
 b=JUWBRvVkJPxEfeLq3/k3s86CgTEkyvuZKBC1HDChoG5b4BvOzVm2kLDIk5/ub58b5g
 NS1iUtGtsdxqoFXxjZP25cJXKdIVlQzz+CbOf7JyqvhcaEBlVM4mdr+EWPh+mK+JV0j0
 a4EMI9xsb+Wt/ybG5mVI0bWEezjf8I0038QXnC4gJMiRehJt+yOx9Y+bRDJBQ4C+kWpv
 PtazENqFI4hVh/cEypLW9bUTqyJM0IKI9DxXrCj4hIDzjWB97U9ntuM5F21OMLDM80Yo
 ExqzutCfO/OdyPVmsWudFhl8xgciEWbQsCBGu2u9kEo4bDSEVZ3W6Ic4nzxQRxwEeTdW
 E81A==
X-Gm-Message-State: AOJu0Yw5XAfk9vqwkPya4I4vvwEnkwFfpnq6vby3k9dEfKrTrroSbot8
 j+kSiyNXZhMObYp6YMz3wzjrH7SBvKbpDoOB5epe60j8Y0z+G8bIFYVbqnoI7qGSh5VTUGGXVT3
 nXI7/MxJx1gpktcp5A5/son3mZYUb3N8IHMOhkfoOUvwf0oY=
X-Gm-Gg: ASbGncv7YCJVANLlIsrCOKLHhW6QS5/X1Ap190Te5DeW/Fvhv5UaDATgPL6N3Qa8grW
 /n75uc9drNADQeWOhenhxJ8vA19JNgxRwYXuIqwFKcdVdy9p4RAihFMz/LIEo25imbS3NX/PMvu
 xSZPTlAT9xHoO+ptLuy3TpQvM=
X-Google-Smtp-Source: AGHT+IGCfos347kpBbRrtE9BF0OA5Tu6144kqEjJbH0TS6vbCrLJLRAlY7Mp1tC1M/pbjSZxH/fIzjSJ7yCzZUFa2ko=
X-Received: by 2002:a17:907:a587:b0:ac7:3912:5ea5 with SMTP id
 a640c23a62f3a-ad17af80715mr447473266b.58.1746222043775; Fri, 02 May 2025
 14:40:43 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Fri, 2 May 2025 15:40:32 -0600
X-Gm-Features: ATxdqUFOAkp134lo4szSwSjhC04LcxBO03U8Ms8B7vEfdLw5GITQbcJU08j-NAA
Message-ID: <CAFLszTjmTK3n=nqmBMp3_9gONZBm3VctKkqguq3Pb3K3or8Pnw@mail.gmail.com>
Subject: Please pull u-boot-dm
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

https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/26056
https://dev.azure.com/simon0972/u-boot/_build/results?buildId=77&view=results


The following changes since commit 6cc812f8cc55c132458c7da5b9fb7666315cbe8c:

  Merge patch series "video: Enhancements related to truetype and
console" (2025-05-02 13:57:26 -0600)

are available in the Git repository at:

  git://git.denx.de/u-boot-dm.git tags/dm-pull-2may25

for you to fetch changes up to d31d3a2949873b6217036650a449c1a1f74e6244:

  patman: Drop the old status code (2025-05-02 14:54:39 -0600)

----------------------------------------------------------------
patman improved to prepare for new features

- Create a separate module for the 'send' function
- Move to asyncio for patchwork comms

----------------------------------------------------------------
Simon Glass (30):
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

 doc/develop/binman_tests.rst    |   6 +-
 tools/binman/bintool_test.py    |  20 ++--
 tools/binman/cbfs_util_test.py  |  15 +--
 tools/binman/elf_test.py        |   3 +-
 tools/binman/fip_util_test.py   |  11 ++-
 tools/binman/ftest.py           | 106 ++++++++++-----------
 tools/binman/image_test.py      |   4 +-
 tools/binman/main.py            |   4 +-
 tools/buildman/func_test.py     |  10 +-
 tools/buildman/main.py          |   2 +-
 tools/buildman/test.py          |   6 +-
 tools/dtoc/main.py              |   5 +-
 tools/dtoc/test_dtoc.py         |  11 ++-
 tools/dtoc/test_fdt.py          |   2 +-
 tools/dtoc/test_src_scan.py     |  25 ++---
 tools/patman/__main__.py        |  61 +++---------
 tools/patman/cmdline.py         |   8 ++
 tools/patman/control.py         | 223
++++++++++++--------------------------------
 tools/patman/func_test.py       | 143 ++++++++++++++++-------------
 tools/patman/patchwork.py       | 425
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/patman/pyproject.toml     |   2 +-
 tools/patman/requirements.txt   |   1 +
 tools/patman/send.py            | 179 ++++++++++++++++++++++++++++++++++++
 tools/patman/status.py          | 463
++++++++++++++++++++++++++++++++++++--------------------------------------------------------
 tools/patman/test_checkpatch.py |   2 +-
 tools/u_boot_pylib/__main__.py  |   2 +-
 tools/u_boot_pylib/terminal.py  | 105 +++++++++++++++++----
 tools/u_boot_pylib/test_util.py |  29 ++----
 tools/u_boot_pylib/tout.py      |   5 +-
 29 files changed, 1166 insertions(+), 712 deletions(-)
 create mode 100644 tools/patman/patchwork.py
 create mode 100644 tools/patman/send.py

Regards,
Simon
