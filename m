Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B36606A338
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eGfToDyB;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZIYBZxKU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C1F96078D;
	Mon, 16 Nov 2026 10:59:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id By_xUfVnlDxc; Mon, 16 Nov 2026 10:59:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9ACE9606CA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794826772;
	b=o+cL51s8fblOTET9U0D9o6f6/pIBArvud0ozUJvZ8Jlj4Xs5FV6gwOcgzgzXfq7pu+/z
	 BCjxIhuna9H0VU+IsLtzAABB2S8/LHU/2uKgb5q0nw8HArPJT1n+A8GtLnSHgSoSl7udt
	 QTqYKn7f3E6KH70O2f7A0XloFxSY4tg1X02CeMF33WJcHGcRwsvWjW+sQ9EZpoCoVXyIs
	 k1mu9dh2buMAv/n3i44A7wonj9BBLvRQB44Y+CwnCQdTtOmZKDeGnPYFHarEqA8Yew+IL
	 pedW7uceJyRuhPsY+1CLvKRgUGiDqEfhutC1P2p15MnWMnRliLvlVZjiFBQo+FsXxCQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794826772;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=CUrbYvy8z5OZp9WQikT2IKh0tmwWCBNydE1DPmiJbvw=;
	b=naUwhHee/Pl0pDDZCRoIoPoA7XVCR+CArJynlzJl4fiRhLNwBuAtBDLrYIbCfGtg5udY
	 sPXmxNE0GLOfjinCv/pp9kGXefCXpF8fVC3pD8xnwQ17LtgYQASUwxvIZtiQSZ+wxfS0f
	 TcixVjvRmulZRapa9zSPFTzF9I7YWBRUGSE8ruWl2850KGXmK9av/vOuCUeU8+0NzobMp
	 RDkisAsCP4QpGDeukMnNXpwE47VDrhFGFAGegGh2tVGAU90l68NrCK7AFzZfEecLmgvm7
	 FoRP0bManBgacGoAD73fGRm2m8OkqxwbScMHi0SG73F0i7FCtnI5v9dX0+4RYumLpbA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794826772;
	bh=CUrbYvy8z5OZp9WQikT2IKh0tmwWCBNydE1DPmiJbvw=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eGfToDyBvPCypq4VhaoXW8lUhjiyAg7Anq1Ia+saNgTvw9jIVIQWw3PGbuw3/G+oY
	 x/9gVbHF3SWsS6SRiwNnFUnwb6CfbvmWnziQjcjlBWkdeejYFAGDZ9WvSl/KdeykPV
	 8pMtei3bmKweta068b06nkxCapU6ylEfq9fulin2JbtmV3U9e/OsdyN49RBkPm8oTp
	 5ulk86Sp+1aQoYdY7FYKPQFbFny4uFb/ceiGjwm7P3Qf4zGZYK2poR+ikfShdQflXl
	 ppBIHGZx8BiqfykPkLKWzcyAw1E+TwJe2hbldiiO4f9op7nJIpKt6DT+QGB6uhPc/5
	 jwCNXKsRFthdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9ACE9606CA;
	Mon, 16 Nov 2026 10:59:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BF4E328C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A622F40070
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k4WjXYCVvoYU for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:59:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8969E40068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ZIYBZxKU
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8969E40068
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:25 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4bb666304fdso10711235e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 02:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794826764; x=1795431564;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CUrbYvy8z5OZp9WQikT2IKh0tmwWCBNydE1DPmiJbvw=;
 b=ZIYBZxKUQ67NuNHdo909DVwC/TfZcZH9DE+PwSwehAyD0h/XYqYl21oosqF8zoFPHY
 WAKHO0UCzmpM7k1qy97l50VOR+A8ASIb65TkGZJjVr45+ADNzIbwDDPp7tGPoLSxgntF
 Mn/fYxT/j9YtDV7qfFvYPBu/iZ7zB0ouQ4UoAzgHYdJPBXM2aS0DbtAyP6OWp71ZOTOL
 kY8ponRx955/l5e8l9CqkAr3nx+rFEe0qFp338GXwpplf+JzGO30XpInISEl9fhIygeH
 Ak+JDOq/7BXvK3dxIgUwZgJImcdu67Sj5WvPeZehVGUePz2PndFEzgRdQRAO/5HI1b71
 EIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794826764; x=1795431564;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CUrbYvy8z5OZp9WQikT2IKh0tmwWCBNydE1DPmiJbvw=;
 b=fVeeGheRc+DIAAZCNSSa2jOMGL29ZP8gfRPZUqNFJ5jmPXsUfw4/qjOdR9wMa98WEs
 9tm9Njghu0O7uBfAja7+tc55lAI5Nb/Qgj3iAOFRHqeEIrGI8b9YGKfhKLFxbCBeE6Tm
 52GYFIHmhBV0s1i+qIeY/3P0QgLyQg9h3POvHE12u0/ZJJ69kKk9NNpsN6d1Mjt02FdR
 y9ev2um/Hz2C8P5fPVPSGAsX1/OXh3jasFAq3iC54xee1vlE/kiWhxn0/HbEOXuDEmJq
 FqUdST+x/ZH7gtYCQQUyXc/n+oKVd7PoME1AWvEB3OPOx/MpreF9HrNVs0LSHTQkApEL
 gojQ==
X-Gm-Message-State: APuU4Z9Sd4gZ8/x3++iS/IjM/z7ykOa0vNPPEjwJHjF/9+fVAIkHGifd
 pZYEZgXlOdbzxt5O2EySEEDaRw2KxRO1RXR2tYr+cC0jOi/yZ6Vf84ykTp5PgRZXkt8=
X-Gm-Gg: AYBFou21V/pnq33zDyV56gO+Lktd2880Ix/H+O7eQx2RbyFkbCFYWve5/OaKmewupvL
 fuj8wi9xjn902ECKsONUsG8cffjOT4PemIca1u3wWkMv2M32fWj9I9JJLCTVhmBGhKuFJ882ZkP
 zdd8ZjkGY7peOGYsgJY3OfSEcjObFHL5G532hUF5WvCPp722axowVU4kd78nN3RU0poy6vHQFns
 vUbMuOopFneamuczwErH7PSfglZ9YOxYw3A5hCC7AVTalDaH+9RLlhP6WvbH8AaWzvNUx4JEVxk
 bjGjBVK4AtE2aFigkQUq48tpmns31ttpzKR6dzGjtKDC+Svj0GOY+Z/gnLw9Yhmay68p4pLUir8
 DAPv/kNV//b0HZNtn1aCwx4kwcm8wvr8mOdfi9H+QBNucyWcqHostjzny69ZXHYpR3c4qOF/mZ4
 z7dAFD3WxQcYQcTLReP9FTbGHWoQC1tG2y/X2FIFLkfEFUEobKpmWlq9UO8XCvPjVHWSJPKV8yP
 FTwAyT5ZPSP0tmfZJlVDovWRacsWYW1vuuhaWBDaBN3S69EF0+Nu6kJhoT7E2SSDzvEu3xnWlMv
 MfUuMuHl8vDJ+Vjht448WY0XelnqV+fU0WLKf/1XaSWNo+9K6A==
X-Received: by 2002:a05:600c:8b38:b0:4a1:c27d:e1a8 with SMTP id
 5b1f17b1804b1-4bb55a7b45bmr232096655e9.10.1794826763717; 
 Mon, 16 Nov 2026 02:59:23 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:ee3:3401:d23b:e87d:8bff:70bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb64ec7b58sm219594065e9.5.2026.11.16.02.59.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 02:59:23 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH v3 00/15] Fix 'make check' errors
Date: Mon, 16 Nov 2026 10:59:20 +0000
Message-Id: <20261116-qcheck_fix-v3-0-b6cf7e96944b@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAji+moC/1WNzQ7CIBAGX6XhLAboD8WT72GMoXRpUVMUKtE0f
 XehvbTH2XwzOyEPzoBHp2xCDoLxxg4R8kOGVC+HDrBpIyNGWEUJE/itelCPmzZfLLXg0JK2FmW
 DovByEM9L7HJd2X+aO6gxFdKiN3607rd8CzTt1nAsb8OBYoI11WXBVSF5Ts9PM0hnj9Z1KJUD2
 7iU7FwWXap4BaSpas3Ezp3n+Q992Tsu8wAAAA==
X-Change-ID: 20261029-qcheck_fix-af97ed0d895b
To: u-boot@lists.u-boot-project.org, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Simon Glass <sjg@chromium.org>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Various tests can be run using 'make check', 'make qcheck' and 'make
tcheck'. These have become broken and need fixing to be useful again.

Running 'make qcheck' fails on the binman test to check the version
numbers of the tools are found as expected. Update the code for the
tools that have been updated and no longer have their version numbers
found by the code.

There are also failures in buildman. First add code to understand 'gcc
-E' as an alternative to cpp. Second add the code to accept an empty
CROSS_COMPILE variable in the environment when testing that
CROSS_COMPILE is not set by the toolchain selection.

dtoc was not achieving 100% code coverage so add a new test to rectify
that.

Disable event_dump tests that are broken on newer versions of binutils.

Build mkeficapsule in the tree that is used for testing the tools.

'make tcheck' was not achieving 100% code coverage and needs to know the
location of the built tools to resolve.

'make check' tests of the file system had errors due to ext4 file
systems being created with an orphaned file but were marked clean.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Changes in v3:
- Split fix of test_basic tests into two.
- Just remove the empty arg from lzma_alone version check instead of
  messing with run_cmd_result() and move this commit to become 2/15
- Add explanation and error log to commit message of 9/15
- Update commit to accept more preprocessor possibilities. 13/15
- Update the commit message for 11/15 and remove the change of PATH that
  fails to address this same issue.
- In 4/15 update the buildman test to cope if DTC is set externally.
- In 8/15 minor update to test file
- Add 5/15 and 6/15 to insulate binman and buildman tests from a DTC
  variable being set externally
- Picked up tags and trimmed Cc list
- Link to v2: https://patch.msgid.link/20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org

Changes in v2:
- Added commit 7/12 to address intermittent failure for binman to get
  version string from lzma_alone.
- Added commit 8/12 to address a test failure due to the build tree not
  containing the built version of mkeficapsule and using the system
  version instead.
- Dropped a space from the beginning of a line in a new file in 5/12 to
  quiet checkpatch warning and remove most of the content as not needed
  for test as suggested by Simon Glass.
- Fix 'make tcheck' binman code coverage test by passing in location of
  tools built from this tree in 9/12.
- Fix typo in tools/Kconfig for TOOLS_MKEFICAPSULE config item in 10/12
- Cope with CPP="gcc -E" in buildman in 11/12
- Ensure fsck can be run and use it to force clean ext4 file systems on
  creation to remove orphaned file. 12/12
- Picked up some rb tags from Simon Glass
- Link to v1: https://patch.msgid.link/20261102-qcheck_fix-v1-0-f1f547c4a731@linaro.org

To: u-boot@lists.u-boot-project.org
To: Kory Maincent <kory.maincent@bootlin.com>
To: Linus Walleij <linusw@kernel.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Anshul Dalal <anshuld@ti.com>
Cc: Alexey Charkov <alchark@flipper.net>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Carlo Caione <ccaione@baylibre.com>
Cc: Yao Zi <me@ziyao.cc>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Marek Vasut <marex@nabladev.com>

---
Andrew Goodbody (15):
      binman: btool: lz4: Update version regex
      binman: bintool: Do not add empty argument
      binman: btool: lzma_alone: Update version function
      test: Do not set DTC environment variable
      buildman: Use mock environment to ignore DTC variable
      binman: Use mock environment to ignore DTC variable
      buildman: Cope with empty CROSS_COMPILE in tests
      dtoc: test: Fix coverage by adding test
      test: Disable running event_dump test for make check
      test: Build mkeficapsule in tree used by tests
      test: Pass location of built tools to binman code coverage test
      tools: Fix typo in name of command mkeficapsule
      buildman: Cope with CPP="gcc -E"
      test: Fix test_basic file system tests
      test: Ensure ext4 file system is truly clean on creation

 configs/sandbox_spl_defconfig                          |  1 +
 test/py/tests/fs_helper.py                             |  4 ++++
 test/py/tests/test_fs/fstest_helpers.py                | 12 +++++++++---
 test/run                                               | 10 +++++-----
 tools/Kconfig                                          |  2 +-
 tools/binman/btool/lz4.py                              |  2 +-
 tools/binman/btool/lzma_alone.py                       |  2 +-
 tools/binman/ftest.py                                  | 16 ++++++++++++----
 tools/buildman/boards.py                               |  4 ++--
 tools/buildman/func_test.py                            | 11 +++++++++--
 tools/buildman/test.py                                 | 12 ++++++------
 tools/dtoc/test/dtoc_test_include.dts                  | 13 +++++++++++++
 tools/dtoc/test/newinclude/dtoc_test_include_file.dtsi |  7 +++++++
 tools/dtoc/test_fdt.py                                 |  7 +++++++
 14 files changed, 78 insertions(+), 25 deletions(-)
---
base-commit: 3cb2cbbc75aa7fe2391f662607d6b2f46c1292a7
change-id: 20261029-qcheck_fix-af97ed0d895b

Best regards,
--  
Andrew Goodbody <andrew.goodbody@linaro.org>

