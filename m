Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E4CCD3445
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 00:40:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFC7684CE4;
	Sat,  9 May 2026 02:40:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20251104.gappssmtp.com header.i=@wolfssl-com.20251104.gappssmtp.com header.b="Eqa0Qy6M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1238F84E02; Sat,  9 May 2026 02:04:39 +0200 (CEST)
Received: from mail-dl1-x122c.google.com (mail-dl1-x122c.google.com
 [IPv6:2607:f8b0:4864:20::122c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7387084E02
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 02:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aidan@wolfssl.com
Received: by mail-dl1-x122c.google.com with SMTP id
 a92af1059eb24-12db2e415a7so1869579c88.1
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 17:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20251104.gappssmtp.com; s=20251104; t=1778285072; x=1778889872;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nxuCgzKOp0P3yffVO3FtiXYPHygY+ysu+DqXEnnW6Rc=;
 b=Eqa0Qy6MomytG37XymnTeMJQGKrjxxmg/1MpFV6cS+rQ/uHLnD70128/B72FKqnQUb
 FsBJ1+6uHZljl0BKhNYPyArcpNNtbmHPOCGhGsgMDgKDRjmQaGpvuN/qyYduUmymX3AS
 QZQWZ+RlFyAV/ThzfRyREyO1wO9pZzVIvFiKghf+mtYKvz7lkYyTC5ohkkH8dgZkJ4dS
 nZDujeNdB+9r4ibf4pnvErUYNBJVvpcFYJZeDff33eMRAI3lH+GVVwI1r0ojDBuMA6IT
 RfGesYfHDrvpHeBq66e7OzNABN4oRSELm+3ZNOFtXOqjWSbnwFur/qAAUIqYNyv/5wkZ
 n5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778285072; x=1778889872;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nxuCgzKOp0P3yffVO3FtiXYPHygY+ysu+DqXEnnW6Rc=;
 b=fggALi9Ot9fUE3EjoLsOW983+nvCHqiQ7rsIQatw+/rhKudq4mRBtZEEYM3e3WPbci
 Bq7rORM65GlmV/IDbjHBucMwll4067fjp45EG9c1G0nWLq4O23uT6qxEj/tirdbwzl4c
 uWrXxfk2QMn40i/HIhnhfQ+sCWwvgyy18Dy7i16Kjk7w9rYFi8k6SqfEe2OLjMoHCM/S
 aeql1tPFufC5J7DYuPT24LSiB/g8Q6pKH1qKyjC+pJcWJGIeAkbKfSLIkeDe73z2ZwDi
 Au8Vj+QzNlTbDKutpJ5TjB6Grummjid4pIrcTDYqbrQWOZ1bRkaSJzXffmGT8xrxHZsk
 TTew==
X-Gm-Message-State: AOJu0Yw/C4sLw4KJJKPXo/F1nctSCkxhl9y2xVSfenyBF63oAMd/+cau
 VkzCEKUTeZHkDPZI1QYuJc8st2oMLjkII12v13cwZyNt0p7ctjRzIzcyqSdj6zgMMUjTj8XpYRV
 q7T7i
X-Gm-Gg: AeBDievjCrUdCMj50G4zNT5vwXhfP6UM45yYtyWrCyRmPKu5SLC4+tNuT5TvaDyHVXx
 NgN5X8n7EWQt+RfvfHCd2eOztPoCRtzT930NvGxYr/WxkeL2g5cklBlg8g05dDjp7yW3qUkv0U4
 iJYpKKqNEQqaNdyUpZrF63Wcu8zS7L0RKg455IlMJVZYHkjZBFuIB9bQaFyW4Ujw70MxiS/2KXf
 u5gJYfUo+3rgzaB0uRL5MQmjt6oSasxT5lHP3lJ5bUnzMnrrqkZdMwL0PuZ7Dev2Yz1/DNixij4
 6XdlYyjlmlGMg4hVf0kD5aFeiyPvBhyOCwrWUocsjKo10euSmtlai/AdAIEaKLeJk5dG5YKeZdp
 cCE/NMWAMt9d/rU2WaVuqiDdjCYITFzGtuwNdxk4y2pIoEMfsbumOMsP1IiZId+M5HV6HKnKyUu
 QTIawrcGzwCe7SlRvBWuZ6QL7SNgWfGTr8QZ3GDOOdxeGKimX/R0wTxONfLpsRk+vxPcvOh8SOP
 t99OmEhoVm+bGSR26SDRg==
X-Received: by 2002:a05:7022:6990:b0:12c:6e85:505c with SMTP id
 a92af1059eb24-131967d531dmr7744799c88.4.1778285072463; 
 Fri, 08 May 2026 17:04:32 -0700 (PDT)
Received: from localhost.localdomain ([207.231.76.218])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-132787673ffsm5505030c88.15.2026.05.08.17.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 17:04:31 -0700 (PDT)
From: Aidan Garske <aidan@wolfssl.com>
To: u-boot@lists.denx.de
Cc: David Garske <david@wolfssl.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3 00/12] tpm: Add wolfTPM library support for TPM 2.0
Date: Fri,  8 May 2026 17:04:07 -0700
Message-ID: <cover.1778277334.git.aidan@wolfssl.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 09 May 2026 02:40:11 +0200
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

Hi all,

This is v3 of the wolfTPM TPM 2.0 stack integration for U-Boot.

wolfTPM (https://github.com/wolfSSL/wolfTPM) is a portable, GPLv2 TPM 2.0
library that provides a full TPM 2.0 command set, an SPI/MMIO HAL, and
firmware-update support for Infineon SLB9672/SLB9673 hardware.  This
series wires it into U-Boot as an optional backend behind the existing
'tpm2' command, alongside support for QEMU+swtpm, sandbox emulation, and
real Raspberry Pi 4 + Infineon SLB9672 hardware.

Branch (full 14-commit history including the subtree squash + merge):
  https://github.com/aidangarske/u-boot wolftpm-v2-patches

Note on the subtree commits omitted from this email thread:
  The branch above contains 14 commits; the email series is 12 patches.
  Two commits are deliberately not sent to the list:

    * "Squashed 'lib/wolftpm/' content from commit 664db130d57"
        - the parentless squash commit produced by `git subtree add`.
          Its diff is ~3.4MB / ~90k lines and would be rejected by the
          mailing list on size.
    * "Merge commit 'd42fd7b146...' as 'lib/wolftpm'"
        - the corresponding subtree merge commit. Merges have no patch
          form and are routinely omitted by `git format-patch`.

  Please pull from the branch above (or wolfssl/wolfTPM @ 664db130d57)
  to inspect the imported wolfTPM source. Subsequent updates will go
  via tools/update-subtree.sh, matching how mbedTLS, lwIP, and
  dts/upstream are maintained in tree.

Changes since v2:
  - Replaced the lib/wolftpm git submodule with a git subtree import
    (squash + merge), matching the convention used for mbedTLS, lwIP,
    and dts/upstream.  tools/update-subtree.sh is updated to know
    about the wolftpm subtree (path lib/wolftpm, upstream
    https://github.com/wolfssl/wolfTPM.git).
    [feedback: Ilias Apalodimas]
  - Reverted the changes to include/linux/byteorder/generic.h.  The
    redefinition workaround for cpu_to_beXX / beXX_to_cpu now lives
    on the wolfTPM side: include/configs/user_settings.h pulls in
    <asm/byteorder.h> up front so U-Boot's macros are defined before
    wolfTPM's #ifndef-guarded fallbacks in tpm2_packet.h.
    [feedback: Ilias Apalodimas]

Testing:
  - QEMU arm64 + swtpm Python test framework
    (./test/py/test.py --bd qemu_arm64 -k "test_wolftpm and not ut_cmd"):
    19 passed, 2 skipped (matching doc/usage/cmd/wolftpm.rst).
  - Manual QEMU arm64 + swtpm walkthrough per
    doc/usage/cmd/wolftpm.rst section "Building and Running wolfTPM
    with U-Boot using QEMU": tpm2 help/info/autostart/startup/
    get_capability/pcr_read/pcr_print/caps all return expected output.
  - Raspberry Pi 4 + Infineon SLB9672 (real hardware): all wolfTPM
    cmd tests pass, including firmware update path.

v2 thread:
  https://lore.kernel.org/u-boot/?q=PATCH+v2+tpm+wolfTPM

Aidan Garske (12):
  tpm: export tpm_show_device, tpm_set_device, and get_tpm
  include/hash: add SHA384 hash wrapper declaration for wolfTPM
  spi: add BCM2835/BCM2711 hardware SPI controller driver
  dts: add TPM device tree nodes for RPi4, QEMU, and sandbox
  tpm: add wolfTPM build rules and Kconfig
  tpm: add wolfTPM headers and SHA384 glue code
  tpm: add wolfTPM driver helpers and Kconfig options
  cmd: refactor tpm2 command into frontend/backend architecture
  tpm: add sandbox TPM SPI emulator
  test: add wolfTPM C unit tests and Python integration tests
  doc: add wolfTPM documentation
  configs: enable wolfTPM in rpi_4_defconfig

--
2.47.3

