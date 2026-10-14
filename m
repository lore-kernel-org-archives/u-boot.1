Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3BACC6B2C
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 20:03:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 268A680FF3;
	Wed, 14 Oct 2026 20:03:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3wzgDv8298hm; Wed, 14 Oct 2026 20:03:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 336D480F76
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792008196;
	b=jYapG7FL9rhN+jYUcpnM4/NvXkUEJSqJXdA/5aVQ1ZDaF2HzlJQzHKUgYFObnrEihhtA
	 S4AdgOqPLwvpMqmB/iOG7xjD1IjxNYPsZ5e+UeE6DwRY9wY9PXAR4VDAXypJNKw5Ov/MT
	 d0/p+1pwB/PHIx/e8UV0kqhYgek5bZYN/rUURLODl4vw3HdlSuzg5qf8Z8G6zquJ9F+KO
	 VlXjtyR/hmSOOZx1QrRkhuJaSNHA7Z/7LKJMNgQqZRVEyyhMg5f1T9r21ZZ/4HRh+wR8O
	 bE3fmbWWVPmC+ZyeYYt/KrgX+pH0VUDEfa6hS9KMJJD3+yEy9ngzwWuxVVuRnTWg8Bg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792008196;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=P6sn1xd1inNgwR5FzHRv08TtjfRBHdzUKAXT2LvWoyY=;
	b=c2kNX89s8NG0JqGWyXufuPapcKvYLs4mgGdF5oBEzL09AsN86b1PBBNm9lonXEBkElnS
	 cUtVPIegvO6NMFzVkXAO/JmbeAuTL7FdfedQ/DsPSlBuXZ5Y2XC3OPv/IQQZ17E/WzSQR
	 QH/Wcwzh0UI+7+PPD08E55a/m19FEL8GVVt/+HKbl7AgIndP/SG81vU7AYjik7kbku2LQ
	 qy5maBoiH392gcIVZ7iFdDdu5/NWMA+NllC0WENr50+3AKXhRHox6tayc5LJKQZetGxPm
	 03NpDXk28FVPa7MRWzAh2rp2GFT6v1kw/rQoy5h21IZMebuqoHjJFlU9nDWcpm05dvg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792008196;
	bh=P6sn1xd1inNgwR5FzHRv08TtjfRBHdzUKAXT2LvWoyY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lP6c0Ojbhw5XlJ/u4WXx5BBci8HhfLr3iUYCYwQ51RYmBos3n9qkNwO9LMpyWFW9C
	 lCsuMGUjJfw3dvGYbcET4L4Mh7wj8WwqrHTkXxfBm+umqCOH7VQe3O5/r99UcBFDCo
	 iKHPl+Me8bHSbPSRKJCHG+9pOBB/TqWATYfLPhwS8GYVueCDzU8Wr7/cMS+g6nrSSJ
	 mtkZ7j6lEwBeKyHg7a2ZVaokGPobclzI1vW9fw0gYAcTOqKtLivyAse02Ehtgq4MDp
	 YUSZ89YjEuQdNoP4s+xBBzCEyUKqcjdptgTWM1ytim86X5SFLzvzMESWEDgJpmd2fK
	 Oet3XLJFEchlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 336D480F76;
	Wed, 14 Oct 2026 20:03:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3FB1D4DD
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 255C2407C0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uxX1J_Ki__2x for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 18:23:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7CD21407A0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792002192;
 b=McfAhvOkXBofGUdaElLAVGau+aNbsixEO20xv3PLfrew/5DNih67iQ54Vjs8EHnDLAro
 wKfYRiBHVbIpMf2PeSUDfyUdoQ+zE+KYbiZrdh271720KbmP1T+KlWVcshE40qsTx3gC1
 5bAXuZcNf/fFMBCqsaISGH5p8AMwgjKaLuexhKNCoCZezpdaM4loxRCvmgCRZykikzVJY
 6n49mWos+tEopMYffSW+eLv+x68KeQ+QDWH4pVwrYYvb3okcF7UWCGqOYQrSB9nkFI9ao
 s5EF4G127uCqSIemf0PAB3DtdylJRP7y3GT3j/ENyAuz/OZBAQl+eXgZkzSpXRbe3Sg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792002192;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=P6sn1xd1inNgwR5FzHRv08TtjfRBHdzUKAXT2LvWoyY=;
 b=D/GlqteXRLFXTiwL3KdpFAO2RNp2PJ3EmKIasEOqBrkgb9yLpFA1eBHwmyzYHOWrtMQM
 YJ0vmfzK26sqfW7SRY4HdfgQd2+IgHL3nDSPh2s/xJhmik810VGYYj3j1WRa00il6Tm3A
 H5MjyRVbbtmPn3P4UKykqQN9DNDG1dXiptNZ6GQygwRXbrMFPCj7GSIbxxIm0IYhC1K0+
 SVLdES1td73L6YaTwNYdTGPLUiGQtgqDitoBdkQJvEWlyjE6wDzOYtaYgkVkOKUPXJZBu
 XCxcegVdUYVn2mVkwpdI198q7Qka1rPBVcwiOq/Vn0/3tfiHsJJeubovA4vh+12gOYg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=eOaja992; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=eOaja992
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7CD21407A0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:11 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5128152B;
 Wed, 14 Oct 2026 11:23:07 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF48D3F871;
 Wed, 14 Oct 2026 11:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792002191; bh=g9RwxlryvDtu0d4YK8S7p/nOwJ5z/OqPQD8eY7zGtzY=;
 h=From:To:Cc:Subject:Date:From;
 b=eOaja992YowNg34ggaJidk+EQnahMBpHByTl6CoeGVX7ufoUJi+LFof7ic+kt1n4J
 6K++nVEoeUPPdVcIPt6wRFWeWXWkKjSumd7g9ejSWcBaz1F47hLrWI/IA8OjdNU/UZ
 f3yGnohU3nsjnRhtY4nWaPu84txo4+KpbjxmljlQ=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v6 00/22] arm64: FF-A runtime transport for EFI variables*
Date: Wed, 14 Oct 2026 19:22:40 +0100
Message-ID: <cover.1791981658.git.harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Oct 2026 20:03:15 +0000
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

Additional testing:
- Tested the OP-TEE/non-FF-A QEMU setup by booting Linux through U-Boot
  EFI and mounting efivarfs successfully.

Changes in v6:
  
Address Ilias Apalodimas's review comments:
- Restore the pre-FF-A OP-TEE runtime callback setup when
  CONFIG_ARM_FFA_RT_MODE is disabled.
- Keep the existing common cached-variable runtime callbacks for
  GetVariable() and GetNextVariableName() in the non-FF-A OP-TEE path.
- Keep QueryVariableInfo() and SetVariable() unsupported at runtime in
  the non-FF-A OP-TEE path, matching the pre-FF-A behavior.
- Rename FF-A-specific runtime variable handlers with the _ffa_runtime
  suffix.

Link to v5:
https://mail-archive.com/u-boot@lists.u-boot-project.org/msg05824.html

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
 lib/efi_loader/efi_variable_tee.c             | 796 ++++++++++++++----
 .../efi_selftest_variables_runtime.c          | 715 +++++++++++-----
 test/dm/Makefile                              |   3 +-
 test/dm/ffa.c                                 |   6 +-
 test/dm/ffa_runtime.c                         | 123 +++
 25 files changed, 2039 insertions(+), 527 deletions(-)
 create mode 100644 drivers/firmware/arm-ffa/arm-ffa-runtime.c
 create mode 100644 include/arm_ffa_runtime.h
 create mode 100644 test/dm/ffa_runtime.c

-- 
2.43.0

