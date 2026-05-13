Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B896CD4F21
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 00:28:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2478084686;
	Wed, 13 May 2026 02:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20251104.gappssmtp.com header.i=@wolfssl-com.20251104.gappssmtp.com header.b="Loy2fqs6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10BBB8468B; Wed, 13 May 2026 02:27:15 +0200 (CEST)
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com
 [IPv6:2607:f8b0:4864:20::1331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A07E8838BB
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 02:27:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aidan@wolfssl.com
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-2f0ad52830cso9054647eec.1
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 17:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20251104.gappssmtp.com; s=20251104; t=1778632030; x=1779236830;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FSbm3BYKjj/cpG3o00jJwUkXkTlTXHKDjVO5RPs0mhE=;
 b=Loy2fqs6/9tNem5MOnf7ryDypC/6emBJog8Z+BOdlhEDJfanjA1q0A+iZAA7TKBqMh
 0QgFvSNnBiYSIaarIVBiMVplywcLiCaaquk3LIuckgrbnW3thRGBUax5Q6kgnNE7MbEI
 13Qc5vK46mjmTpQIbL/vZHpHLjEt53AURKxlMHTz1vlAACVX5m2w+5Odn6W+fTeitrOo
 B0dEZPtCWEjqmahKn1ABzlyIHHVJ1Rpsn4VC46rxZhH1h2T7Hr4B5BY30h0dmrm8Z7Pb
 dUTyWRzxJQ/QpxTLYowtPr3jaIU0WaBzr3aj15Hpo7fkwiin77JD9lfcgADCvptlKBWc
 nhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778632030; x=1779236830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FSbm3BYKjj/cpG3o00jJwUkXkTlTXHKDjVO5RPs0mhE=;
 b=DB49zEElCFM0kw3jdEKP7nljB4kjVuZc+zD610r9IS6+1wEEwIka/m1/DCbCvLfzyi
 RUa+cPxPTeoiIW+c+CckkI6CVvsTyihMZN+5n4ssVnzBgDUHkdIdiDY8ysxkl9Eb6CNH
 rSUm9kjJCzvbTXUsBtiHtz+tMhjrOvcgA6fKANXYrEpy3zLEdzv+uxRVWBw/eszwUAkT
 eeB5PmjpwklyQ4mBa+bLkW79ISp0rrWfus6B7kDOlhEdYodJVVOaXz1BX5brDt0Tp1Jb
 AWJNFeOw5IYNEoGZYCXBpq0pmRB81CjaUHC0BFJbft9BGsgxP+zrr+AXpu9M+FhdGohF
 CHPg==
X-Gm-Message-State: AOJu0Yzha3mgSWKsdvuU5Zh5DxVd6GU5Rz59yiOCYteGg1/VmOT9W8PT
 ktKmH8IhILmBuLTik9dqJrGep116dGl71YYm3fJP51d8hZv49DQaUZxLK1cyGe94yxRV820A7t/
 h4Zy/zuE=
X-Gm-Gg: Acq92OHfnZTZC7r+M5XeqXz/2MIdKo4JfTyQo7RKCWGhM9m3xkcnV8doYTW7YZNS49A
 vB7nif+LjPkYezcIGxIrPITmPgC2WEaNQpzh9gm6mICn74cqfrywS2RUKb9BqKmPs/XeEA0E08V
 NmUOzVX/kU5UDMUFB0EUfIGmNgOz2nwKDeCpIXv9LgZ8280vC+lFF9UecdE1hUE5S/ZeSt1Xhhe
 +i3WlcG73xaPpmosrrk8++DfEETfAdgjUUO/GTUwd+wX4B6gl2gCA9vrxL4kmPFjmOK/wgEAvDk
 PtT6aP+vXMKX479y9DVJNVGOkgeFoF3a91xDftFofWsBycxDXorXdiGcFEmTsXJ+80gDuwGSmDv
 wlVNwGTzFrMCF6xX3SPORSzPlvFLkzEcWRbvn782nktQb3/ifgSCGfQ4b3JPyD68Uj0c+0BdcKY
 V/GkloYf/BdwqKyLn5sEkNLIrNc1+SzdCpDnUcjgTgUipjtKzayr16tzyaSBFsYnCojlLmWZz7W
 6h8YApKq6fP8uTOVbaW+6liWWUReFz2
X-Received: by 2002:a05:693c:2d96:b0:2ea:b85c:153d with SMTP id
 5a478bee46e88-30119f6d4damr690159eec.27.1778632029356; 
 Tue, 12 May 2026 17:27:09 -0700 (PDT)
Received: from localhost.localdomain ([207.231.76.218])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8884752ccsm19547827eec.17.2026.05.12.17.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 17:27:08 -0700 (PDT)
From: Aidan Garske <aidan@wolfssl.com>
To: u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, David Garske <david@wolfssl.com>,
 Aidan <aidan@wolfssl.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jerome Forissier <jerome@forissier.org>,
 Philip Molloy <philip.molloy@analog.com>
Subject: [PATCH v4 13/14] doc: add wolfTPM documentation
Date: Tue, 12 May 2026 17:26:17 -0700
Message-ID: <20260513002625.76915-13-aidan@wolfssl.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1778619453.git.aidan@wolfssl.com>
References: <cover.1778619453.git.aidan@wolfssl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 May 2026 02:27:36 +0200
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

From: Aidan <aidan@wolfssl.com>

Add documentation for wolfTPM integration, commands, and testing.

doc/usage/cmd/wolftpm.rst:
  Comprehensive RST documentation covering:
  - All wolfTPM tpm2 subcommands with usage and examples
  - Infineon TPM firmware update step-by-step guide (extract
    manifest/firmware, load to RAM, perform update, recovery mode)
  - Build instructions for RPi4 and QEMU targets
  - Enabling debug output (U-Boot log system + wolfTPM library)
  - Complete test suite documentation with test coverage table
  - Python test framework setup (QEMU + swtpm instructions,
    helper scripts, verified test results)

README.wolftpm.md:
  Quick-start guide with overview, feature comparison vs standard
  U-Boot TPM, command reference, build instructions, hardware
  support details, and file listing.

README:
  Add CONFIG_TPM_WOLF reference in the configuration options
  section alongside existing CONFIG_TPM entries.

Signed-off-by: Aidan Garske <aidan@wolfssl.com>
---
 README                    |   3 +
 README.wolftpm.md         | 154 +++++++++
 doc/usage/cmd/wolftpm.rst | 685 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 842 insertions(+)
 create mode 100644 README.wolftpm.md
 create mode 100644 doc/usage/cmd/wolftpm.rst

diff --git a/README b/README
index 20a73bab802..b9bfe14a1c7 100644
--- a/README
+++ b/README
@@ -361,6 +361,9 @@ The following options need to be configured:
 		CONFIG_TPM
 		Support TPM devices.
 
+		CONFIG_TPM_WOLF
+		Enables support for wolfTPM library.
+
 		CONFIG_TPM_TIS_INFINEON
 		Support for Infineon i2c bus TPM devices. Only one device
 		per system is supported at this time.
diff --git a/README.wolftpm.md b/README.wolftpm.md
new file mode 100644
index 00000000000..cdebe96ecb1
--- /dev/null
+++ b/README.wolftpm.md
@@ -0,0 +1,154 @@
+# wolfTPM Support for U-Boot
+
+This fork adds [wolfTPM](https://github.com/wolfSSL/wolfTPM) support to U-Boot, providing full TPM 2.0 command support using wolfTPM APIs and the wolfTPM library.
+
+## Overview
+
+wolfTPM is a portable, open-source TPM 2.0 library that provides:
+
+- **Native TPM 2.0 API** - Direct access to all TPM 2.0 commands
+- **Wrapper API** - Simplified interface for common TPM operations
+- **Hardware SPI Support** - Direct communication with TPM hardware via SPI
+- **Firmware Update** - Support for Infineon SLB9672/SLB9673 firmware updates
+- **No External Dependencies** - Standalone implementation without kernel TPM stack
+
+## Why wolfTPM vs Standard U-Boot TPM?
+
+| Feature | Standard U-Boot TPM | wolfTPM |
+|---------|---------------------|---------|
+| API | Basic TPM commands | Full TPM 2.0 + Wrapper API |
+| PCR Operations | Basic read/extend | Full PCR management |
+| Firmware Update | Not supported | Infineon SLB9672/9673 |
+| Capabilities Query | Limited | Comprehensive `caps` command |
+| SPI Communication | Via kernel driver | Native wolfTPM TIS layer |
+| Library Integration | N/A | wolfSSL ecosystem compatible |
+
+## Command: `tpm2`
+
+When wolfTPM is enabled, the `tpm2` command uses wolfTPM APIs instead of the standard implementation. The command interface is compatible with the standard `tpm2` command, with additional wolfTPM-specific features.
+
+### Basic Commands
+
+```bash
+tpm2 autostart          # Initialize TPM, startup, and self-test
+tpm2 init               # Initialize TPM software stack
+tpm2 info               # Show TPM device information
+tpm2 caps               # Show TPM capabilities (wolfTPM enhanced)
+tpm2 self_test full     # Run full self-test
+```
+
+### PCR Operations
+
+```bash
+tpm2 pcr_read <pcr> <addr> [algo]      # Read PCR value
+tpm2 pcr_extend <pcr> <addr> [algo]    # Extend PCR with digest
+tpm2 pcr_print                          # Print all PCR values
+tpm2 pcr_allocate <algo> <on|off>       # Configure PCR banks
+```
+
+### Security Management
+
+```bash
+tpm2 clear <hierarchy>                           # Clear TPM
+tpm2 change_auth <hierarchy> <new_pw> [old_pw]   # Change password
+tpm2 dam_reset [password]                        # Reset DAM counter
+tpm2 dam_parameters <tries> <recovery> <lockout> # Set DAM params
+```
+
+### Firmware Update (Infineon Only)
+
+```bash
+tpm2 firmware_update <manifest_addr> <size> <firmware_addr> <size>
+tpm2 firmware_cancel
+```
+
+## Building
+
+### For Raspberry Pi 4
+
+```bash
+git clone https://github.com/aidangarske/u-boot.git
+cd u-boot
+git checkout rpi4-wolftpm-uboot
+git submodule update --init lib/wolftpm
+
+export CROSS_COMPILE=aarch64-elf-
+make rpi_4_defconfig
+make -j$(nproc)
+```
+
+### Configuration Options
+
+Enable in `menuconfig` or defconfig:
+
+```
+# Core TPM support
+CONFIG_TPM=y
+CONFIG_TPM_V2=y
+
+# wolfTPM (replaces standard tpm2 command)
+CONFIG_TPM_WOLF=y
+CONFIG_CMD_TPM=y
+
+# For Infineon hardware
+CONFIG_WOLFTPM_SLB9672=y
+
+# For QEMU/swtpm testing
+# CONFIG_WOLFTPM_LINUX_DEV=y
+```
+
+**Note:** The `tpm2` command frontend (`cmd/tpm-v2.c`) is always compiled. The backend is selected at build time: when `CONFIG_TPM_WOLF` is enabled, `cmd/wolftpm.c` provides the wolfTPM backend; otherwise, `cmd/native_tpm2.c` provides the native U-Boot backend.
+
+## Hardware Support
+
+### Tested Hardware
+
+- Raspberry Pi 4 Model B
+- Infineon SLB9670 TPM (LetsTrust HAT)
+- Infineon SLB9672 TPM (with firmware update support)
+
+### SPI Configuration
+
+The TPM is configured on SPI0 CE1 (GPIO7), matching the standard Raspberry Pi `tpm-slb9670` overlay:
+
+```
+SPI0 Pins:
+- SCLK: GPIO11 (pin 23)
+- MOSI: GPIO10 (pin 19)
+- MISO: GPIO9  (pin 21)
+- CE1:  GPIO7  (pin 26)
+```
+
+## Documentation
+
+- **Full Guide**: [rpi4-wolftpm-uboot](https://github.com/aidangarske/rpi4-wolftpm-uboot)
+- **Firmware Update**: See `doc/usage/cmd/wolftpm.rst`
+- **wolfTPM Library**: [github.com/wolfSSL/wolfTPM](https://github.com/wolfSSL/wolfTPM)
+
+## Files Modified/Added
+
+```
+cmd/tpm-v2.c                     # Shared tpm2 command frontend (dispatch table, help)
+cmd/native_tpm2.c                # Native U-Boot backend (when wolfTPM is OFF)
+cmd/wolftpm.c                    # wolfTPM backend (when wolfTPM is ON)
+cmd/tpm2-backend.h               # Backend function declarations
+lib/wolftpm/                     # wolfTPM library (submodule)
+lib/wolftpm.c                    # wolfTPM library glue code
+include/configs/user_settings.h  # wolfTPM configuration
+include/wolftpm.h                # wolfTPM header
+arch/arm/dts/bcm2711-rpi-4-b.dts # Device tree with SPI/TPM config
+configs/rpi_4_defconfig          # RPi4 build configuration
+drivers/spi/bcm2835_spi.c        # BCM2835 SPI driver
+doc/usage/cmd/wolftpm.rst        # Command documentation
+```
+
+## License
+
+- U-Boot: GPL-2.0
+- wolfTPM: GPL-2.0
+- This integration: GPL-2.0
+
+## Author
+
+Aidan Garske <aidan@wolfssl.com>
+wolfSSL Inc.
diff --git a/doc/usage/cmd/wolftpm.rst b/doc/usage/cmd/wolftpm.rst
new file mode 100644
index 00000000000..f16f8d8b0f4
--- /dev/null
+++ b/doc/usage/cmd/wolftpm.rst
@@ -0,0 +1,685 @@
+wolfTPM Support For Das U-Boot
+==============================
+
+wolfTPM provides experimental support for U-Boot with the following key features:
+
+- Utilizes SOFT SPI driver in U-Boot for TPM communication
+- Implements TPM 2.0 driver functionality through its internal TIS layer
+- Provides native API access to all TPM 2.0 commands
+- Includes wrapper API for common TPM 2.0 operations
+- Supports two integration paths:
+  - ``__linux__``: Uses existing tpm interface via tpm2_linux.c
+  - ``__UBOOT__``: Direct SPI communication through tpm_io_uboot.c
+
+wolfTPM U-Boot Commands
+----------------------
+
+The following commands are available through the ``tpm2`` command (powered by wolfTPM):
+
+Basic Commands
+~~~~~~~~~~~~~~
+
+- ``help`` - Show help text
+- ``device [num device]`` - Show all devices or set the specified device
+- ``info`` - Show information about the TPM
+- ``state`` - Show internal state from the TPM (if available)
+- ``autostart`` - Initialize the TPM, perform a Startup(clear) and run a full selftest sequence
+- ``init`` - Initialize the software stack (must be first command)
+- ``startup <mode> [<op>]`` - Issue a TPM2_Startup command
+  - ``<mode>``: TPM2_SU_CLEAR (reset state) or TPM2_SU_STATE (preserved state)
+  - ``[<op>]``: optional shutdown with "off"
+- ``self_test <type>`` - Test TPM capabilities
+  - ``<type>``: "full" (all tests) or "continue" (untested tests only)
+
+PCR Operations
+~~~~~~~~~~~~~~
+
+- ``pcr_extend <pcr> <digest_addr> [<digest_algo>]`` - Extend PCR with digest
+- ``pcr_read <pcr> <digest_addr> [<digest_algo>]`` - Read PCR to memory
+- ``pcr_allocate <algorithm> <on/off> [<password>]`` - Reconfig PCR bank algorithm
+- ``pcr_setauthpolicy | pcr_setauthvalue <pcr> <key> [<password>]`` - Change PCR access key
+- ``pcr_print`` - Print current PCR state
+
+Security Management
+~~~~~~~~~~~~~~~~~~~
+
+- ``clear <hierarchy>`` - Issue TPM2_Clear command
+  - ``<hierarchy>``: TPM2_RH_LOCKOUT or TPM2_RH_PLATFORM
+- ``change_auth <hierarchy> <new_pw> [<old_pw>]`` - Change hierarchy password
+  - ``<hierarchy>``: TPM2_RH_LOCKOUT, TPM2_RH_ENDORSEMENT, TPM2_RH_OWNER, or TPM2_RH_PLATFORM
+- ``dam_reset [<password>]`` - Reset internal error counter
+- ``dam_parameters <max_tries> <recovery_time> <lockout_recovery> [<password>]`` - Set DAM parameters
+- ``caps`` - Show TPM capabilities and info
+
+Firmware Management
+~~~~~~~~~~~~~~~~~~~
+
+- ``firmware_update <manifest_addr> <manifest_sz> <firmware_addr> <firmware_sz>`` - Update TPM firmware
+- ``firmware_cancel`` - Cancel TPM firmware update
+
+Infineon TPM Firmware Update Guide
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+**WARNING: Firmware updates are risky. A failed update can brick your TPM.
+Only proceed if you have a valid reason to update (security patches, new features)
+and understand the risks.**
+
+The firmware update commands are for Infineon SLB9672/SLB9673 TPMs only. The process
+requires extracting manifest and firmware data from Infineon's combined ``.BIN`` file.
+
+**Prerequisites:**
+
+- Infineon firmware file (e.g., ``TPM20_16.13.17733.0_R1.BIN``)
+- wolfTPM's ``ifx_fw_extract`` tool (in ``lib/wolftpm/examples/firmware/``)
+- Your TPM's KeyGroupId (shown by ``tpm2 caps`` command)
+
+**Step 1: Get your TPM's KeyGroupId**
+
+Run ``tpm2 caps`` to find your TPM's KeyGroupId::
+
+    U-Boot> tpm2 caps
+    Mfg IFX (1), Vendor SLB9672, Fw 16.13 (0x4545), FIPS 140-2 1, CC-EAL4 1
+    Operational mode: Normal TPM operational mode (0x0)
+    KeyGroupId 0x5, FwCounter 1255 (255 same)
+    ...
+
+In this example, KeyGroupId is ``0x5``.
+
+**Step 2: Build the extraction tool (on host machine)**
+
+::
+
+    cd lib/wolftpm/examples/firmware
+    gcc -o ifx_fw_extract ifx_fw_extract.c
+
+**Step 3: List available key groups in firmware file**
+
+::
+
+    ./ifx_fw_extract TPM20_16.13.17733.0_R1.BIN
+    Found group 00000005
+
+Verify your TPM's KeyGroupId matches one in the firmware file.
+
+**Step 4: Extract manifest and firmware data**
+
+Use your KeyGroupId (0x5 in this example)::
+
+    ./ifx_fw_extract TPM20_16.13.17733.0_R1.BIN 0x5 manifest.bin firmware.bin
+    Found group 00000005
+    Chosen group found: 00000005
+    Manifest size is 3229
+    Data size is 925539
+    Wrote 3229 bytes to manifest.bin
+    Wrote 925539 bytes to firmware.bin
+
+**Step 5: Copy files to SD card**
+
+Copy ``manifest.bin`` and ``firmware.bin`` to your boot partition (FAT)::
+
+    cp manifest.bin firmware.bin /Volumes/bootfs/   # macOS
+    cp manifest.bin firmware.bin /boot/firmware/     # Linux
+
+**Step 6: Load files into memory**
+
+In U-Boot, load the files from SD card into RAM::
+
+    U-Boot> fatload mmc 0:1 0x10000000 manifest.bin
+    3229 bytes read in 32 ms (97.7 KiB/s)
+
+    U-Boot> fatload mmc 0:1 0x10100000 firmware.bin
+    925539 bytes read in 86 ms (10.3 MiB/s)
+
+**Step 7: Perform firmware update (CAUTION!)**
+
+Convert file sizes to hex:
+
+- manifest.bin: 3229 bytes = 0xC9D
+- firmware.bin: 925539 bytes = 0xE1F63
+
+Run the firmware update::
+
+    U-Boot> tpm2 firmware_update 0x10000000 0xC9D 0x10100000 0xE1F63
+    TPM2 Firmware Update
+    Infineon Firmware Update Tool
+        Manifest Address: 0x10000000 (size: 3229)
+        Firmware Address: 0x10100000 (size: 925539)
+    tpm2 init: rc = 0 (Success)
+    Mfg IFX (1), Vendor SLB9672, Fw 16.13 (0x4545)
+    Operational mode: Normal TPM operational mode (0x0)
+    KeyGroupId 0x5, FwCounter 1255 (255 same)
+    Firmware Update (normal mode):
+    Mfg IFX (1), Vendor SLB9672, Fw 16.13 (0x4545)
+    Operational mode: Normal TPM operational mode (0x0)
+    KeyGroupId 0x5, FwCounter 1255 (255 same)
+    tpm2 firmware_update: rc=0 (Success)
+
+**DO NOT power off or reset during the update!**
+
+**Step 8: Verify update**
+
+After the update completes, verify with::
+
+    U-Boot> tpm2 caps
+
+The firmware version should show the new version.
+
+**Recovery Mode:**
+
+If the TPM enters recovery mode (opMode shows 0x02 or 0x8x), the firmware update
+command will automatically use recovery mode. You may need to run the update again
+to complete the process.
+
+Canceling a Firmware Update
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+If an update is in progress and needs to be abandoned (opMode 0x01), use::
+
+    U-Boot> tpm2 firmware_cancel
+    tpm2 init: rc = 0 (Success)
+    tpm2 firmware_cancel: rc=0 (Success)
+
+**IMPORTANT: After running firmware_cancel, you MUST reboot/power cycle the system
+before running any other TPM commands.** If you attempt to run commands without
+rebooting, you will get ``TPM_RC_REBOOT`` (error 304)::
+
+    U-Boot> tpm2 firmware_update ...
+    tpm2 init: rc = 304 (TPM_RC_REBOOT)
+    Infineon firmware update failed 0x130: TPM_RC_REBOOT
+
+After rebooting, the TPM will return to normal operation and you can retry the
+firmware update or continue with normal TPM operations.
+
+**Note:** If no firmware update is in progress, ``firmware_cancel`` returns
+``TPM_RC_COMMAND_CODE`` (0x143), which is expected and harmless::
+
+    U-Boot> tpm2 firmware_cancel
+    tpm2 firmware_cancel: rc=323 (TPM_RC_COMMAND_CODE)
+
+Enabling wolfTPM in U-Boot
+--------------------------
+
+Enable wolfTPM support in U-Boot by adding these options to your board's defconfig::
+
+  CONFIG_TPM=y
+  CONFIG_TPM_V2=y
+  CONFIG_TPM_WOLF=y
+  CONFIG_CMD_WOLFTPM=y
+
+  if with __LINUX__:
+    CONFIG_TPM_LINUX_DEV=y
+
+Or use ``make menuconfig`` and enable:
+
+Enabling Debug Output
+~~~~~~~~~~~~~~~~~~~~~
+
+wolfTPM commands use U-Boot's logging system (``log_debug()``). To enable debug
+output, you must first enable the logging subsystem in your board's defconfig::
+
+    CONFIG_LOG=y
+    CONFIG_LOG_MAX_LEVEL=7
+    CONFIG_LOG_DEFAULT_LEVEL=7
+
+Or via ``make menuconfig``:
+
+- Console → Enable logging support
+- Console → Maximum log level to record = 7
+- Console → Default logging level to display = 7
+
+Log levels:
+- 7 = DEBUG (to show wolfTPM command debug output)
+
+**Note:** Without ``CONFIG_LOG=y``, the ``log level`` command will not exist
+and ``log_debug()`` calls will produce no output.
+
+wolfTPM Library Debug
+^^^^^^^^^^^^^^^^^^^^^
+
+For lower-level wolfTPM library debug output (TPM protocol messages), edit
+``include/configs/user_settings.h`` and uncomment::
+
+    #define DEBUG_WOLFTPM           /* Basic wolfTPM debug messages */
+    #define WOLFTPM_DEBUG_VERBOSE   /* Verbose debug messages */
+    #define WOLFTPM_DEBUG_IO        /* IO-level debug (SPI transfers) */
+
+After enabling, rebuild U-Boot::
+
+    make clean
+    make -j4
+
+Menuconfig Paths
+^^^^^^^^^^^^^^^^
+
+The following menuconfig paths are useful for wolfTPM:
+
+- Device Drivers → TPM → TPM 2.0 Support
+- Device Drivers → TPM → wolfTPM Support
+- Command line interface → Security commands → Enable wolfTPM commands
+- Console → Enable logging support (for ``log_debug()`` output)
+
+Building and Running wolfTPM with U-Boot using QEMU
+---------------------------------------------------
+
+To build and run wolfTPM with U-Boot using QEMU and a TPM simulator, follow these steps:
+
+1. Install swtpm::
+
+     git clone https://github.com/stefanberger/swtpm.git
+     cd swtpm
+     ./autogen.sh
+     make
+
+2. Build U-Boot::
+
+     make distclean
+     export CROSS_COMPILE=aarch64-linux-gnu-
+     export ARCH=aarch64
+     make qemu_arm64_defconfig
+     make -j4
+
+3. Create TPM directory::
+
+     mkdir -p /tmp/mytpm1
+
+4. Start swtpm (in first terminal)::
+
+     swtpm socket --tpm2 --tpmstate dir=/tmp/mytpm1 --ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock --log level=20
+
+5. Start QEMU (in second terminal)::
+
+     qemu-system-aarch64 -machine virt -nographic -cpu cortex-a57 -bios u-boot.bin -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock -tpmdev emulator,id=tpm0,chardev=chrtpm -device tpm-tis-device,tpmdev=tpm0
+
+6. Example output::
+
+     U-Boot 2025.07-rc1-ge15cbf232ddf-dirty (May 06 2025 - 16:25:56 -0700)
+     ...
+     => tpm2 help
+     tpm2 - Issue a TPMv2.x command
+     Usage:
+     tpm2 <command> [<arguments>]
+     ...
+     => tpm2 info
+     tpm_tis@0 v2.0: VendorID 0x1014, DeviceID 0x0001, RevisionID 0x01 [open]
+     => tpm2 startup TPM2_SU_CLEAR
+     => tpm2 get_capability 0x6 0x20e 0x200 1
+     Capabilities read from TPM:
+     Property 0x6a2e45a9: 0x6c3646a9
+     => tpm2 pcr_read 10 0x100000
+     PCR #10 sha256 32 byte content (20 known updates):
+      20 25 73 0a 00 56 61 6c 75 65 3a 0a 00 23 23 20
+      4f 75 74 20 6f 66 20 6d 65 6d 6f 72 79 0a 00 23
+
+7. Example commands::
+
+     => tpm2 info
+     tpm_tis@0 v2.0: VendorID 0x1014, DeviceID 0x0001, RevisionID 0x01 [open]
+     ...
+     => tpm2 pcr_read 10 0x100000
+     PCR #10 sha256 32 byte content (20 known updates):
+      20 25 73 0a 00 56 61 6c 75 65 3a 0a 00 23 23 20
+      4f 75 74 20 6f 66 20 6d 65 6d 6f 72 79 0a 00 23
+
+8. Exiting the QEMU:
+   Press Ctrl-A followed by X
+
+Testing wolfTPM
+---------------
+
+wolfTPM includes a comprehensive test suite based on the existing TPM2 tests.
+The tests are located in:
+
+- ``test/cmd/wolftpm.c`` - C unit tests (based on ``test/dm/tpm.c`` and ``test/cmd/hash.c``)
+- ``test/py/tests/test_wolftpm.py`` - Python integration tests (based on ``test/py/tests/test_tpm2.py``)
+
+Running C Unit Tests
+~~~~~~~~~~~~~~~~~~~~
+
+The C unit tests use the U-Boot test framework and can be run in sandbox mode
+or on real hardware. To run all wolfTPM tests::
+
+    # Build sandbox with tests enabled
+    make sandbox_defconfig
+    # Enable wolfTPM in menuconfig
+    make menuconfig
+    make -j4
+
+    # Run U-Boot sandbox
+    ./u-boot -T
+
+    # In U-Boot sandbox, run the unit tests
+    => ut cmd
+
+Individual tests can be run by name::
+
+    => ut cmd cmd_test_wolftpm_autostart
+    => ut cmd cmd_test_wolftpm_init
+    => ut cmd cmd_test_wolftpm_self_test
+    => ut cmd cmd_test_wolftpm_caps
+    => ut cmd cmd_test_wolftpm_clear
+    => ut cmd cmd_test_wolftpm_pcr_read
+    => ut cmd cmd_test_wolftpm_pcr_extend
+
+Running Tests Manually in QEMU
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+You can also test wolfTPM commands manually in QEMU:
+
+1. Start swtpm::
+
+     mkdir -p /tmp/mytpm
+     swtpm socket --tpm2 --tpmstate dir=/tmp/mytpm \
+       --ctrl type=unixio,path=/tmp/mytpm/swtpm-sock --log level=20
+
+2. Start QEMU with TPM::
+
+     qemu-system-aarch64 -machine virt -cpu cortex-a57 -m 1024 \
+       -bios u-boot.bin \
+       -chardev socket,id=chrtpm,path=/tmp/mytpm/swtpm-sock \
+       -tpmdev emulator,id=tpm0,chardev=chrtpm \
+       -device tpm-tis-device,tpmdev=tpm0 \
+       -nographic
+
+3. Run wolfTPM commands at the U-Boot prompt::
+
+     => tpm2 autostart
+     => tpm2 caps
+     => tpm2 pcr_read 0 sha256
+     => tpm2 pcr_print
+     => tpm2 self_test full
+     => tpm2 clear TPM2_RH_LOCKOUT
+     => tpm2 dam_parameters 3 10 0
+
+Test Coverage
+~~~~~~~~~~~~~
+
+The test suite covers the following wolfTPM functionality:
+
++---------------------------+------------------------------------------+
+| Test Name                 | Description                              |
++===========================+==========================================+
+| wolftpm_autostart         | TPM initialization and startup           |
++---------------------------+------------------------------------------+
+| wolftpm_init              | TPM device initialization                |
++---------------------------+------------------------------------------+
+| wolftpm_self_test         | Full TPM self-test                       |
++---------------------------+------------------------------------------+
+| wolftpm_self_test_continue| Continue incomplete self-tests           |
++---------------------------+------------------------------------------+
+| wolftpm_caps              | Read TPM capabilities                    |
++---------------------------+------------------------------------------+
+| wolftpm_clear             | Clear TPM state                          |
++---------------------------+------------------------------------------+
+| wolftpm_pcr_read          | Read PCR values                          |
++---------------------------+------------------------------------------+
+| wolftpm_pcr_extend        | Extend PCR with digest                   |
++---------------------------+------------------------------------------+
+| wolftpm_pcr_print         | Print all PCR values                     |
++---------------------------+------------------------------------------+
+| wolftpm_pcr_allocate      | Reconfigure PCR bank algorithm           |
++---------------------------+------------------------------------------+
+| wolftpm_dam_reset         | Reset DAM counter                        |
++---------------------------+------------------------------------------+
+| wolftpm_dam_parameters    | Set DAM parameters                       |
++---------------------------+------------------------------------------+
+| wolftpm_change_auth       | Change hierarchy password                |
++---------------------------+------------------------------------------+
+| wolftpm_info              | Display TPM info                         |
++---------------------------+------------------------------------------+
+| wolftpm_state             | Display TPM state                        |
++---------------------------+------------------------------------------+
+| wolftpm_device            | Show/set TPM device                      |
++---------------------------+------------------------------------------+
+| wolftpm_startup_clear     | TPM2_Startup with CLEAR mode             |
++---------------------------+------------------------------------------+
+| wolftpm_startup_state     | TPM2_Startup with STATE mode             |
++---------------------------+------------------------------------------+
+| wolftpm_startup_shutdown  | TPM2_Shutdown command                    |
++---------------------------+------------------------------------------+
+| wolftpm_get_capability    | Read TPM capabilities by property        |
++---------------------------+------------------------------------------+
+
+The following commands are implemented in ``cmd/wolftpm.c`` but do not yet have
+test coverage due to special requirements. These have been tested locally on 
+hardware but dont have test suites due to different build configurations.
+
++---------------------------+------------------------------------------+------------------+
+| Command                   | Description                              | Notes            |
++===========================+==========================================+==================+
+| pcr_setauthpolicy         | Set PCR authorization policy             | Requires         |
+|                           |                                          | wolfCrypt        |
++---------------------------+------------------------------------------+------------------+
+| pcr_setauthvalue          | Set PCR authorization value              | Requires         |
+|                           |                                          | wolfCrypt        |
++---------------------------+------------------------------------------+------------------+
+| firmware_update           | Update TPM firmware (Infineon only)      | Requires         |
+|                           |                                          | Infineon HW      |
++---------------------------+------------------------------------------+------------------+
+| firmware_cancel           | Cancel firmware update (Infineon only)   | Requires         |
+|                           |                                          | Infineon HW      |
++---------------------------+------------------------------------------+------------------+
+
+**Note:** The ``pcr_setauthpolicy`` and ``pcr_setauthvalue`` commands require
+``WOLFTPM2_NO_WOLFCRYPT`` to be undefined (i.e., wolfCrypt must be enabled).
+The ``firmware_update`` and ``firmware_cancel`` commands require Infineon
+SLB9672/SLB9673 hardware.
+
+Testing on SLB 9672 on Raspberry Pi 4 Hardware
+----------------------------------------------
+
+For testing with real TPM hardware (e.g., Infineon SLB9672 TPM HAT on
+Raspberry Pi 4), use the dedicated ``rpi_4_wolftpm_defconfig`` added by this
+series.  It enables the BCM2835/BCM2711 hardware SPI driver, the wolfTPM
+backend, and the Infineon SLB9672 chip-specific bits, and leaves the stock
+``rpi_4_defconfig`` untouched for users who do not want wolfTPM.
+
+1. Build U-Boot for Raspberry Pi 4::
+
+     make distclean
+     export CROSS_COMPILE=aarch64-linux-gnu-
+     export ARCH=arm
+     make rpi_4_wolftpm_defconfig
+     make -j$(nproc)
+
+2. Backup current boot configuration::
+
+     sudo cp /boot/firmware/config.txt /boot/firmware/config.txt.backup
+
+3. Copy U-Boot to boot partition::
+
+     sudo cp u-boot.bin /boot/firmware/
+
+4. Edit ``/boot/firmware/config.txt`` and add::
+
+     # U-Boot for wolfTPM testing
+     enable_uart=1
+     kernel=u-boot.bin
+     arm_64bit=1
+     dtparam=spi=on
+
+5. Connect serial console (recommended) - USB-to-serial adapter on GPIO 14/15
+   (pins 8/10) at 115200 baud.
+
+6. Reboot and test at U-Boot prompt::
+
+     U-Boot> tpm2 device
+     U-Boot> tpm2 info
+     U-Boot> tpm2 autostart
+     U-Boot> tpm2 caps
+     U-Boot> tpm2 pcr_read 0 0x1000000 SHA256
+
+7. To restore normal Linux boot::
+
+     sudo cp /boot/firmware/config.txt.backup /boot/firmware/config.txt
+     sudo reboot
+
+No extra build steps are required: ``rpi_4_wolftpm_defconfig`` already
+enables everything ``tpm2 <subcommand>`` needs at runtime - SPI / DM_SPI /
+BCM2835_SPI (hardware SPI controller), TPM / TPM_V2 / CMD_TPM (TPM uclass
+and frontend), CMD_WOLFTPM / TPM_WOLF / WOLFTPM_SLB9672 (wolfTPM backend and
+the Infineon chip-specific bits), plus the rest of the vanilla
+``rpi_4_defconfig`` boot stack (USB, MMC, video, etc.).  ``make
+rpi_4_wolftpm_defconfig && make`` and you are done; nothing in this
+section needs to be added by hand.
+
+The TPM device-tree node lives in
+``arch/arm/dts/bcm2711-rpi-4-b-u-boot.dtsi`` rather than in the Linux-derived
+``bcm2711-rpi-4-b.dts``, so it is visible to U-Boot's bundled FDT but never
+pollutes the upstream Linux DT or a SystemReady firmware-provided FDT.  It
+targets standard SPI0 pins matching the Linux ``tpm-slb9670`` overlay:
+GPIO 11 (SCLK), GPIO 10 (MOSI), GPIO 9 (MISO), GPIO 7 (CE1).  If your TPM
+HAT wires the chip-select to a different GPIO, edit the ``reg = <1>;`` /
+``pinctrl-0`` entries in the ``-u-boot.dtsi``.
+
+Running the C unit tests on real hardware
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+``rpi_4_wolftpm_defconfig`` does **not** enable the unit-test framework, since
+that is developer/CI configuration and not what a typical board user wants
+shipped.  To run ``ut cmd wolftpm`` directly on Raspberry Pi 4 (the same way
+QEMU+swtpm runs it from the Python framework), you need to turn on two extra
+Kconfig knobs **before** building:
+
+- ``CONFIG_UNIT_TEST=y`` - registers the ``ut`` command and pulls in the
+  ``ut_lib`` / ``ut_log`` / ``ut_unicode`` / ``ut_env`` test groups.  Without
+  it the ``ut`` shell command does not exist.
+- ``CONFIG_HEXDUMP=y`` - the wolfTPM tests' diagnostic output uses
+  ``print_hex_dump``.
+
+Either edit ``configs/rpi_4_wolftpm_defconfig`` locally to add those two
+lines, or set them via ``menuconfig`` after running ``make
+rpi_4_wolftpm_defconfig``::
+
+     make rpi_4_wolftpm_defconfig
+     scripts/config --enable CONFIG_UNIT_TEST --enable CONFIG_HEXDUMP
+     make -j$(nproc)
+
+Then on the Pi, at the U-Boot prompt::
+
+     U-Boot> ut cmd wolftpm
+     ...
+     Tests run: 18, 4495 ms, average: 214 ms, failures: 0
+
+(Tested on Raspberry Pi 4 Model B + Infineon SLB9672 HAT, May 2026.)
+The full ``ut cmd`` run also includes 3 generic command tests for 21 total.
+
+Python Test Framework
+~~~~~~~~~~~~~~~~~~~~~
+
+**Why QEMU+swtpm is required (not sandbox):**
+
+The native ``test_tpm2.py`` tests run directly in sandbox because the native
+TPM backend uses U-Boot's driver model, which has a built-in sandbox TPM
+emulator. wolfTPM bypasses driver model entirely and communicates with TPM
+hardware directly via its own SPI/MMIO HAL layer. This means there is no
+sandbox emulator for wolfTPM to talk to. Instead, wolfTPM Python tests require
+QEMU with swtpm (software TPM emulator) which provides a real TPM device
+interface that wolfTPM can communicate with via MMIO.
+
+**Prerequisites:**
+
+Install swtpm and QEMU::
+
+    sudo apt-get install -y swtpm qemu-system-aarch64 pytest
+
+**Running wolfTPM Python Tests with QEMU+swtpm:**
+
+1. Build U-Boot for QEMU arm64 with wolfTPM and autodetect enabled::
+
+     make qemu_arm64_defconfig
+     scripts/config --enable CONFIG_CMD_WOLFTPM --enable CONFIG_TPM_AUTODETECT
+     make olddefconfig
+     make -j$(nproc)
+
+2. Create the test helper scripts in the U-Boot root directory:
+
+   ``u-boot-test-flash`` (no-op for QEMU)::
+
+     #!/bin/bash
+     exit 0
+
+   ``u-boot-test-console`` (starts swtpm + QEMU)::
+
+     #!/bin/bash
+     SWTPM_DIR=/tmp/mytpm
+     SWTPM_SOCK=${SWTPM_DIR}/swtpm-sock
+     mkdir -p ${SWTPM_DIR}
+     if [ ! -S "${SWTPM_SOCK}" ]; then
+         swtpm socket --tpm2 --tpmstate dir=${SWTPM_DIR} \
+             --ctrl type=unixio,path=${SWTPM_SOCK} --log level=0 &
+         sleep 1
+     fi
+     exec qemu-system-aarch64 -machine virt -nographic -cpu cortex-a57 \
+         -bios u-boot.bin \
+         -chardev socket,id=chrtpm,path=${SWTPM_SOCK} \
+         -tpmdev emulator,id=tpm0,chardev=chrtpm \
+         -device tpm-tis-device,tpmdev=tpm0
+
+   ``u-boot-test-reset`` (no-op)::
+
+     #!/bin/bash
+     exit 0
+
+   ``u-boot-test-release`` (cleanup)::
+
+     #!/bin/bash
+     pkill -f "swtpm.*mytpm" 2>/dev/null
+     exit 0
+
+   Make them executable::
+
+     chmod +x u-boot-test-flash u-boot-test-console u-boot-test-reset u-boot-test-release
+
+3. Run the wolfTPM Python tests::
+
+     export PATH=".:$PATH"
+     ./test/py/test.py --bd qemu_arm64 --build-dir . -k "test_wolftpm and not ut_cmd" -v
+
+**Verified output (QEMU arm64 + swtpm, 19 passed, 2 skipped):**
+
+::
+
+    test_wolftpm_autostart PASSED
+    test_wolftpm_init PASSED
+    test_wolftpm_self_test_full PASSED
+    test_wolftpm_self_test_continue PASSED
+    test_wolftpm_caps PASSED
+    test_wolftpm_clear PASSED
+    test_wolftpm_change_auth SKIPPED (requires wolfCrypt)
+    test_wolftpm_dam_parameters PASSED
+    test_wolftpm_dam_reset PASSED
+    test_wolftpm_pcr_read PASSED
+    test_wolftpm_pcr_extend PASSED
+    test_wolftpm_pcr_print PASSED
+    test_wolftpm_info PASSED
+    test_wolftpm_state PASSED
+    test_wolftpm_device PASSED
+    test_wolftpm_startup_clear PASSED
+    test_wolftpm_startup_state PASSED
+    test_wolftpm_startup_shutdown PASSED
+    test_wolftpm_get_capability SKIPPED
+    test_wolftpm_pcr_allocate PASSED
+    test_wolftpm_cleanup PASSED
+
+The native ``test_tpm2.py`` tests can be run directly in sandbox::
+
+    ./test/py/test.py --bd sandbox --build -k test_tpm2 -v
+
+Enabling Debug Output
+~~~~~~~~~~~~~~~~~~~~~
+
+To see debug messages, enable logging before running::
+
+    # At U-Boot prompt
+    => log level 7
+
+Or enable in defconfig::
+
+    CONFIG_LOG=y
+    CONFIG_LOG_MAX_LEVEL=7
+    CONFIG_LOG_DEFAULT_LEVEL=7
+
+For wolfTPM library-level debug, edit ``include/configs/user_settings.h``::
+
+    #define DEBUG_WOLFTPM
+    #define WOLFTPM_DEBUG_IO    /* Shows SPI transfer details */
-- 
2.49.0

