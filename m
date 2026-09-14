Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8789FC88E75
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:17:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1CD7980EE5;
	Mon, 14 Sep 2026 14:17:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cjJie0gQhobX; Mon, 14 Sep 2026 14:17:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 08E8880887
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395475;
	b=qZTVYocDIorzPSm9zuJG3NRdFhPt666EPhaYUYDAGUtSGP8Sr4qN+k3SMwSKjyT5k/6l
	 rvod2wXbrcEqThi7maBJLGghBRFl4bFBwxHaLeJ1P5RF5tvc7J07bVJJ/vWUJTXxNGkM+
	 ko9gol0bgbmSvmbML1byQnejdbWJGBYYL/s2TCQom9vExvcGXIR6tqdoTf9wWLD/RbZVO
	 kozTUJMpA7SgWnVgAxGKJ4ZwDE04AHyiqxYmyrBDZPIrk/U7rLXdw0dWR+94rj9foQbGr
	 ZzWboLRk50Rl4+y36+M1oAT3nhyLlmNz7B9h+/CB8hG75ZcAWi2GVb2VQbc3e0+4xTA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395475;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uvwhEZquEn9DYiSGk4Org8vsaa547KGqm2HVtjaRk24=;
	b=lMfmW4vOUV0lDqM75k6XK6ASdd7jgSmyEwoK1SzSZFA7OA27Kn/4cYKvVKTliaaFYtmK
	 IQUtByccPYqdGlIx1Y4x2cp3jzFxbweJ18z08QMY4e7DQdxmAo+gUsYPZ9z0qMDzcEjoi
	 QecVXzaXTZGWX10obeSFG7Y3jkI2DMn63fKQiGD3OAzLw39G/iMgW1281FdOlB4uHiPlW
	 NmjBOMicooEtyqHL+oxexv8vSFUNXjDLDNRRGvTovPE0jvo0Z0B82l0PS1y2e7m1Dw0tp
	 Z/tP3xpqBrIRHPCVOtGRvkU6Y7dXmQcfr4AxzKlMcifYSQW/lgs+1+6iKEhzY5uTfzA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NgcSpyWA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395475;
	bh=uvwhEZquEn9DYiSGk4Org8vsaa547KGqm2HVtjaRk24=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NlRlZCTwIBn8263ICWGc0ArpKXBQkHpy/jUTQV6n367+DheoFhoCyxyow61QrE9Tn
	 4Tuf80VVkPcpw52ZClE1mmHR+HucmuwAH9r/MKGvDnVzBJCs6thyxIm+rYpctUkBD3
	 XssogE0Td0SJGE2V2VvbYnEgdycQj/xoW7Rn/x5uw0+OM0vxI+9CLDHLNm8C/L61bs
	 MeFDqdPFLndR6sQES5Ps9PgKCYV+g6pzb7WP+dP+4ipVoc3x0LZZQ1d1lb2g4CmiUl
	 PsSdazeohvgxVVSOPyYwBMQ1P4npc9ADapy/UrsZGE4mcUKk/L9e7TsxCMwalPmUN0
	 WlLuluYnD4BKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 08E8880887;
	Mon, 14 Sep 2026 14:17:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7BE64493
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6149080D52
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id auTuR2UPGSB7 for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3B37A80D96
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789384217;
 b=ihiJ5y0MwTVHWKBCqZa+XmUKMcQmhO7BgXLbBIEPVH1+urgXVlgBgAYMu20lyt2Nr+nx
 BmANVRvYrjQS993QRC6fsTnXAaeX51XvJIvXavE96yAo54xLEWFy4WGWpQtEuM7qjdj6s
 uzSa5M11gEMElyEwZLIGQHrjaygdr4yZLmLFBjDuRGa42JTpODYHgObj0LlNRGZVGsQ8B
 DT47/MrTZuh3NOTA2jWuoE61/LZHwY/xlUwx8x7Rmusli+7Wi8GTstH9DO6j+ubCp/Z2d
 MT8M6DM+/su2wbDiZL2dm4wtBYcViwOK3z+xaYncQLs+/s1x8+E6bcDP+lcUM+oo33A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789384217;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=uvwhEZquEn9DYiSGk4Org8vsaa547KGqm2HVtjaRk24=;
 b=FfOhgGb2KMWHLS7JQFkhN22w8yEAAwmmtBY2Pvu9Arwn3uvi/+mcZWYGx3ppk+NSmU4m
 Wwf7fZOE4gR1O4PAglTXkg1Czqq6xyZUoPfRn/ZCYy0FC1eelcB9HMAQIYAMtVRwN3hWE
 qiIRaVcUU1E8wUhrzpv7gvxXea83cXwQ0BSqWNfl5rc+MEvQ2P1Il5z48+ASChWZBTbmJ
 ScdfUUT0sJ6GInK7aULxsB5OBFoQ2TIOENL47wAc4kEStgqTrm2za7C50MlgmDO/JwzI8
 gjhmzvBjbKjaNzRLndFVzN6RCY+UKaoZoo8vAYCk/G4gvWwdRSJY9RT5AXj1M8Z6xVA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=NgcSpyWA; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=NgcSpyWA
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3B37A80D96
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFF521570;
 Mon, 14 Sep 2026 04:01:22 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.49.141])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A3103F86F;
 Mon, 14 Sep 2026 04:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789383686; bh=ZXk2hYYtB8RcOVzZtqyvzUI8QSInjPt8JDZBLgyrwCI=;
 h=From:To:Cc:Subject:Date:From;
 b=NgcSpyWAQmFEJuHtoYYc1gwU7uQDsWcYTnUdUWITh/OMFgqL/s6teLhlUZQMu1TvM
 59E7izaBDEkgZhFK6o+vYkHJ/Mu2N6HPSPlTOF8O8jakBd1nADjZUEHOc75/utdTYS
 cOcbLeDwgaqXIBNUZY3lsGgBGwReIWou5vbcMKkI=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v5 00/22] arm64: FF-A runtime transport for EFI variables
Date: Mon, 14 Sep 2026 12:00:44 +0100
Message-Id: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 14:17:12 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi all,

This series adds FF-A runtime transport support so EFI variable runtime
services can communicate with the secure world after ExitBootServices().
It also extends tests, documentation, and Corstone-1000 configuration to
validate the runtime path and keep boot-time behavior aligned with the
runtime flow.

Changes in this series:
- Add EFI runtime-safe memset helper and FF-A runtime transport support.
- Add runtime-safe FF-A direct-message handling and ExitBootServices setup.
- Implement FF-A runtime communication in the EFI variable TEE backend.
- Enable EFI runtime SetVariable(), GetVariable(), GetNextVariableName(),
  and QueryVariableInfo() over the FF-A transport.
- Add sandbox FF-A runtime transport tests.
- Extend EFI selftests for runtime variables and enable bootefi selftest
  on Corstone-1000.
- Document the FF-A runtime transport and runtime-variable selftest flow.

Testing:

Tested on Corstone-1000 FVP with the Trusted Services SMM Gateway SP.
The instructions to build and run the Corstone-1000 FVP are available at:

  https://corstone1000.docs.arm.com/en/corstone1000-2026.05/user-guide.html

The SMM Gateway SP provides the MM variable service and exposes the MM
Communicate endpoint over FF-A direct messages.

The EFI runtime variable selftest was run in two phases. The setup phase
creates a non-volatile runtime variable before reset. On the U-Boot
prompt:

  corstone1000# setenv efi_selftest 'variables at runtime setup'
  corstone1000# bootefi selftest

Then reset the Corstone-1000 FVP and run the verify phase. The verify
phase checks that the variable is available after reset, then exercises
the runtime get/set/append/delete paths. On the U-Boot prompt after
reset:

  corstone1000# setenv efi_selftest 'variables at runtime verify'
  corstone1000# bootefi selftest

Both phases completed with Summary: 0 failures.

Changes in v5:

Address Ilias Apalodimas's review comments:
- Limit arm64 cache runtime annotations to CONFIG_ARM_FFA_RT_MODE.
- Include MM_SUCCESS in the MM SP response map.
- Guard FF-A shared-buffer references for OP-TEE-only builds.
- Add Corstone-1000 FVP build and test information to the cover letter.

Link to v4:
https://www.mail-archive.com/u-boot@lists.u-boot-project.org/msg01127.html

Link to v3: 
https://lore.kernel.org/u-boot/20260627144421.2067410-1-harsimransingh.tun...@arm.com/

Link to v2: 
https://lore.kernel.org/u-boot/20260514124924.1804332-1-harsimransingh.tun...@arm.com/

Link to v1: 
https://lore.kernel.org/u-boot/20260424173151.371134-1-harsimransingh.tun...@arm.com/

Harsimran Singh Tungal (22):
  efi_loader: add runtime memset helper
  arm-ffa: store boot-discovered runtime data separately
  arm-ffa: add runtime-safe FF-A SMC wrapper
  arm-ffa: add runtime direct-message support
  arm-ffa: reuse direct-message helper at boot time
  arm-ffa: enable runtime context at ExitBootServices
  arm: cache: keep range maintenance available at EFI runtime
  efi_loader: add MM SP status mapping for FF-A variables
  efi_loader: make MM transport selection runtime-safe
  efi_loader: make FF-A MM SP notification runtime-safe
  efi_loader: make FF-A MM communication runtime-safe
  efi_loader: reserve FF-A shared buffer for runtime variables
  efi_loader: enable TEE runtime SetVariable() over FF-A
  efi_loader: enable TEE runtime GetVariable() over FF-A
  efi_loader: enable TEE runtime GetNextVariableName() over FF-A
  efi_loader: enable TEE runtime QueryVariableInfo() over FF-A
  charset: mark u16_strsize() as __efi_runtime
  corstone1000: enable bootefi selftest
  efi: selftest: add runtime variable tests with non-volatile storage
  test: dm: add sandbox FF-A runtime transport tests
  doc: arm64: document FF-A runtime path for EFI variables
  doc: bootefi: note two-phase runtime variables selftest

 arch/arm/cpu/armv8/cache.S                    |   8 +
 arch/arm/cpu/armv8/cache_v8.c                 |  20 +-
 arch/sandbox/include/asm/sandbox_arm_ffa.h    |  16 +-
 configs/corstone1000_defconfig                |   3 +
 doc/arch/arm64.ffa.rst                        |  88 +-
 doc/usage/cmd/armffa.rst                      |  11 +
 doc/usage/cmd/bootefi.rst                     |  31 +
 drivers/firmware/arm-ffa/Kconfig              |  11 +
 drivers/firmware/arm-ffa/Makefile             |   4 +-
 drivers/firmware/arm-ffa/arm-ffa-runtime.c    | 294 +++++++
 drivers/firmware/arm-ffa/arm-ffa-uclass.c     | 114 +--
 drivers/firmware/arm-ffa/arm-ffa.c            |  16 +-
 drivers/firmware/arm-ffa/ffa-emul-uclass.c    |  49 +-
 include/arm_ffa.h                             |  16 +-
 include/arm_ffa_priv.h                        |  22 +-
 include/arm_ffa_runtime.h                     | 191 +++++
 include/efi_loader.h                          |   3 +
 lib/charset.c                                 |   2 +-
 lib/efi_loader/Kconfig                        |   4 +
 lib/efi_loader/efi_runtime.c                  |  20 +
 lib/efi_loader/efi_variable_tee.c             | 751 +++++++++++++++---
 .../efi_selftest_variables_runtime.c          | 715 +++++++++++------
 test/dm/Makefile                              |   3 +-
 test/dm/ffa.c                                 |   6 +-
 test/dm/ffa_runtime.c                         | 123 +++
 25 files changed, 2023 insertions(+), 498 deletions(-)
 create mode 100644 drivers/firmware/arm-ffa/arm-ffa-runtime.c
 create mode 100644 include/arm_ffa_runtime.h
 create mode 100644 test/dm/ffa_runtime.c

-- 
2.34.1

