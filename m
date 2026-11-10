Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057FD606E47B
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eRsqXud2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=FOUAYBF1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9D5081281;
	Tue, 10 Nov 2026 13:05:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O7gZrWoNhgs5; Tue, 10 Nov 2026 13:05:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7CAE6812E6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794315931;
	b=FLGotLWWc5RithoSeNoZ1Houw7vGhFQHwfR55IgOfwODHTjsnww2t8W4TFe9o5jJYjiW
	 dDQSsn5ZbCXEwp5AKWZA/OcXSV0OeTBGlucbtdGM5GJVRosx0KNfeniTKfx0llUI+t8QP
	 FrJ8D1tapAFMbvzgHyYCmxmulke1fX4fjflcU2oi0PVGNnZU9dGJEwkxr/XGL2UXn0yvg
	 180snJNMsSmsAgeRf09OCkKXH9q+pnPJhLT0vJhaBoZiPA1Xk5GcM5qx+MZgbQHdHJv2o
	 Agw32kB0P5qIE7COCFHZVHxs3QIzzYyFBlJZUp6Ho8DSHmpgIF3TdXyr6iVwna9CfSw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794315931;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IW5JSWu2B5yp0K6aw4vZnZy1Bl6NawaKj7FCZv6eBrs=;
	b=CjSMdtpONQ++QQZNyDEmNM5Gax5sGqyWH1LS9omGj9QnXopzkpA6FzpknO2dHdFeEfwe
	 X4ptuv6Lsmd3th8oU8GFNUGIwH7hPKHhN1GuRDojBZcdbyIkb+CMGwrjPezTF7U0///Gi
	 00qHrjcm9w2GQL4yi4mgN73qIA3aCV6os+g5B2kyND1u44vu8xn2wak0Vzz8JefMRVm9O
	 IgL2wDV49EkR+MMU2ewvHiNkzxrKmsAwT3lRSdhzDX02mIKpi/o8QxRpPMSLAxvDIa14H
	 6GjLgiGcHBj5w6mhJLBWNu598tnOavVSO+jm9Kwxm5vEy4u6PTpgGSxZorkmIoN28KQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794315931;
	bh=IW5JSWu2B5yp0K6aw4vZnZy1Bl6NawaKj7FCZv6eBrs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eRsqXud22k0ZW/qMEOHdEokRFQxSVeB7OlkjAS+o9m/FCKlUOrPvOamJCZYvop4E2
	 g5uP4ViKQcdKV/BvY9ZttGbRAYGB3Wb1YruiKmpe8XZCgdOM28r59znabbXmwcnsbP
	 9XgN7zZO6UrVH0PRwUEWQlb1yRDR7CrokiFvmyBaEa1//v28oBso7OTVa8aDImw2z+
	 ubAJ8F9s7DwpFuwf0YHCGGfaeWrhmrQhcTJsSbYBzxbjgY8eRDffku3aMOiFXkzWT/
	 uO8wEEjP9/TcymJdvvB1sGUWi6xCbPemf0CVrmNPLrdZ015w/2lMztfXN+IcMPZXcD
	 bCQnNJAkZaTSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CAE6812E6;
	Tue, 10 Nov 2026 13:05:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 718A4731
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 60F6D4082F
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TLPrkFQJuRtG for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 09:58:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C4487409C5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=FOUAYBF1
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id C4487409C5
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:13 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FC241516;
 Tue, 10 Nov 2026 01:58:09 -0800 (PST)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F41153F632;
 Tue, 10 Nov 2026 01:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794304692; bh=rPe9P5uhOKiYOlEfl7z7+t8ir0KfFMFFGDImCN6P+CE=;
 h=From:To:Cc:Subject:Date:From;
 b=FOUAYBF1r5N0mofclOnBdd1mWTCQ4c+oXQCN/rllIq9dEL1zGDcnA1R88eXf3pBJM
 ywwk5nwFFx2KQXzrSDfqc6JDOhueyuSj5owCWvAl8euROOgRCa3hWuBXZv74+g9bH+
 p+VRfSiWC02dM8SkPVVdj1svuJ6VaUHKJ0cF2Zfs=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v7 00/22] arm64: FF-A runtime transport for EFI variables
Date: Tue, 10 Nov 2026 09:57:41 +0000
Message-ID: <cover.1794221712.git.harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 13:05:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

Additional testing:
- Tested the OP-TEE/non-FF-A QEMU setup by booting Linux through U-Boot
  EFI and mounting efivarfs successfully.

Changes in v7:
  
Address Ilias Apalodimas's review comments:
- Rebase the series on top of U-Boot main.
- Fix per-patch buildability of the runtime variable patches.
- Move the u16_strsize() runtime annotation before runtime callbacks are
  installed.

Link to v6:
https://www.mail-archive.com/u-boot@lists.u-boot-project.org/msg09457.html

Link to v5:
https://mail-archive.com/u-boot@lists.u-boot-project.org/msg05824.html

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
  charset: mark u16_strsize() as __efi_runtime
  efi_loader: enable TEE runtime SetVariable() over FF-A
  efi_loader: enable TEE runtime GetVariable() over FF-A
  efi_loader: enable TEE runtime GetNextVariableName() over FF-A
  efi_loader: enable TEE runtime QueryVariableInfo() over FF-A
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
 lib/efi_loader/efi_variable_tee.c             | 780 ++++++++++++++----
 .../efi_selftest_variables_runtime.c          | 715 ++++++++++------
 test/dm/Makefile                              |   3 +-
 test/dm/ffa.c                                 |   6 +-
 test/dm/ffa_runtime.c                         | 123 +++
 25 files changed, 2031 insertions(+), 519 deletions(-)
 create mode 100644 drivers/firmware/arm-ffa/arm-ffa-runtime.c
 create mode 100644 include/arm_ffa_runtime.h
 create mode 100644 test/dm/ffa_runtime.c

-- 
2.43.0

