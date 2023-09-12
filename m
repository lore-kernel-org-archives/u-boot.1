Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3C6CA0EC3
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 09:47:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F00F86E4D;
	Tue, 12 Sep 2023 11:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PORTLzUn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FCE486E4C; Tue, 12 Sep 2023 11:47:36 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 2135A86B33
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 11:47:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id 211BB212BC0F;
 Tue, 12 Sep 2023 02:47:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 211BB212BC0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1694512052;
 bh=Fk6R3UsOhroUNNkS7iWjxNrONthTVDLT+PaPVhTaLqs=;
 h=From:To:Cc:Subject:Date:From;
 b=PORTLzUnwHuBayikMHbdT304VuGn0Be9p+i+dcB1pyG5x2+AR7I1NiIAcWmWUnbL0
 muK8ADKXyGx7mrdwt9EnldxWc0tgeN/U1M8Gu7ZBfe93bLK3YFGisx+cYsQpgI9CVn
 IK79SJdzzHKjNbyfQgA2wh05Ch1mqHKdPCFRdkk8=
From: seanedmond@linux.microsoft.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, stcarlso@linux.microsoft.com, ilias.apalodimas@linaro.org
Subject: [PATCH 0/5] Add anti-rollback validation feature
Date: Tue, 12 Sep 2023 02:47:23 -0700
Message-Id: <20230912094731.51413-1-seanedmond@linux.microsoft.com>
X-Mailer: git-send-email 2.40.0
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

From: Sean Edmond <seanedmond@microsoft.com>

Adds Add anti-rollback version protection. Images with an anti-rollback counter
value "rollback" declared in the kernel FDT will be compared against the current device 
anti-rollback counter value, and older images will not pass signature 
validation. If the image is newer, the device anti-rollback counter value will
be updated.

The "rollback" value is stored/retrieved using the newly added security driver.
A "TPM backed" and "sandbox backed" security driver have been provided as examples.

Adds new configs:
- CONFIG_DM_ROLLBACK : enable security device support
- CONFIG_ROLLBACK_SANDBOX : enables "rollback-sandbox" driver
- CONFIG_ROLLBACK_TPM : Enables "rollback-tpm" driver
- CONFIG_FIT_ROLLBACK_CHECK : enable enforcement of OS anti-rollback counter during image loading
- CONFIG_FIT_ROLLBACK_CHECK_GRACE : adds a one unit grace version to OS anti-rollback protection

changes in v2:
- arbvn -> rollback_idx
- rollback-tpm is a child of TPM device
- tpm_rollback_counter_init() tries to read NV index, defines and writes 0 if it fails
- tpm_rollback_counter_init() moved to tpm-v2.c
- Use tpm_auto_start()
- No error checking in rollback_idx_get()/rollback_idx_set() (intelligence is in fit_image_verify_rollback())
- assume "rollback" of 0 if FIT property not found
- "grace period" -> "grace version"
- drop "dm_" prefix in header
- Fix for tpm2_nv_define_space() (add "auth" parameter)
- Make NV index consistent across APIs (define/read/write/lock).  IS THIS CORRECT?!
- Add documentation

Sean Edmond (1):
  dm: test: Add a test for security driver

Stephen Carlson (4):
  drivers: security: Add security devices to driver model
  drivers: security: Add TPM2 implementation of security devices
  common: Add OS anti-rollback validation using security devices
  common: Add OS anti-rollback grace period

 MAINTAINERS                         |   9 ++
 arch/sandbox/dts/test.dts           |   8 ++
 boot/Kconfig                        |  19 +++
 boot/image-fit-sig.c                |  94 +++++++++++++++
 boot/image-fit.c                    |  23 ++++
 configs/sandbox_defconfig           |   3 +
 drivers/Kconfig                     |   2 +
 drivers/Makefile                    |   1 +
 drivers/security/Kconfig            |  25 ++++
 drivers/security/Makefile           |   7 ++
 drivers/security/sandbox_security.c |  65 +++++++++++
 drivers/security/security-tpm.c     | 173 ++++++++++++++++++++++++++++
 drivers/security/security-uclass.c  |  30 +++++
 include/dm-security.h               |  44 +++++++
 include/dm/uclass-id.h              |   1 +
 include/image.h                     |   4 +
 include/tpm-v2.h                    |   1 +
 test/dm/Makefile                    |   1 +
 test/dm/security.c                  |  78 +++++++++++++
 19 files changed, 588 insertions(+)
 create mode 100644 drivers/security/Kconfig
 create mode 100644 drivers/security/Makefile
 create mode 100644 drivers/security/sandbox_security.c
 create mode 100644 drivers/security/security-tpm.c
 create mode 100644 drivers/security/security-uclass.c
 create mode 100644 include/dm-security.h
 create mode 100644 test/dm/security.c

-- 
2.40.0

