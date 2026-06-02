Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC8ECD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 00:25:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B2A084915;
	Wed,  3 Jun 2026 02:23:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ZJvrFFJC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A49DF83EF9; Tue,  2 Jun 2026 23:30:30 +0200 (CEST)
Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch
 [109.224.244.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94A5A8485F
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 23:30:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1780435827; x=1780695027;
 bh=YQ/T92u2s+NHFl8+IdsmH5DyE+3HfM7LNmUwrWN1qMo=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=ZJvrFFJCnihoyMbFYRHd2RuUEr+ylrHrceU+fygPAcu06GS8kOzE2q12CXnJZJiFu
 7za8OSNsc9WylD+yzMSgtZdiFYMVE4WZuxLFy15Dy3lopyUBoBlNwOSCPxz4VyYNXS
 mNHSmmVAX0dkS8qGSKKMEckA98Ghxo8p/2LFCfpYzAWpaNL+CVQygEmsNKsiGnBV6V
 k1JzRySsdQSyqHNSZukJpGUyBromSxjaYgu7PJ5rLHx5Cp+uA947F2V+rC86ZpEqn2
 LUrKQtRNyj5kZs9a3ekgR/wOOA65QyfMmpGe6/dHY+N55bbEj01Auoo6BwZF/sFg/0
 fB1DyxHDJxDxQ==
X-Pm-Submission-Id: 4gVPBV0C3cz2ScPK
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v4 3/3] test: hook up test of allowing control DTB to act as
 FIT image
Date: Tue,  2 Jun 2026 23:30:13 +0200
Message-ID: <20260602213013.558064-4-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602213013.558064-1-rv@rasmusvillemoes.dk>
References: <20260602213013.558064-1-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 03 Jun 2026 02:23:44 +0200
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

Add a test demonstrating how one can embed various scripts in the
control DTB.

Verify that the source command can be used with ${fdtcontroladdr} by
itself (invoking the default script), and with :<node-name>
suffix. Check that the scripts themselves can invoke "sibling"
scripts. Also verify that without CONTROL_DTB_AS_FIT set, the control
DTB is not accepted by the source command.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 arch/sandbox/dts/sandbox-boot.sh      |  2 ++
 arch/sandbox/dts/sandbox-inner.sh     |  4 ++++
 arch/sandbox/dts/sandbox-outer.sh     |  4 ++++
 arch/sandbox/dts/sandbox_scripts.dtsi | 24 +++++++++++++++++++++
 configs/sandbox_defconfig             |  2 ++
 test/py/tests/test_source.py          | 31 +++++++++++++++++++++++++++
 6 files changed, 67 insertions(+)
 create mode 100644 arch/sandbox/dts/sandbox-boot.sh
 create mode 100644 arch/sandbox/dts/sandbox-inner.sh
 create mode 100644 arch/sandbox/dts/sandbox-outer.sh
 create mode 100644 arch/sandbox/dts/sandbox_scripts.dtsi

diff --git a/arch/sandbox/dts/sandbox-boot.sh b/arch/sandbox/dts/sandbox-boot.sh
new file mode 100644
index 00000000000..4f7fa661151
--- /dev/null
+++ b/arch/sandbox/dts/sandbox-boot.sh
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+echo "* default script"
diff --git a/arch/sandbox/dts/sandbox-inner.sh b/arch/sandbox/dts/sandbox-inner.sh
new file mode 100644
index 00000000000..b8fc8f7484b
--- /dev/null
+++ b/arch/sandbox/dts/sandbox-inner.sh
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+# Some comment.
+echo "* inner"
diff --git a/arch/sandbox/dts/sandbox-outer.sh b/arch/sandbox/dts/sandbox-outer.sh
new file mode 100644
index 00000000000..40294085433
--- /dev/null
+++ b/arch/sandbox/dts/sandbox-outer.sh
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+echo "* outer 1"
+source ${fdtcontroladdr}:inner
+echo "* outer 2"
diff --git a/arch/sandbox/dts/sandbox_scripts.dtsi b/arch/sandbox/dts/sandbox_scripts.dtsi
new file mode 100644
index 00000000000..c800ec39e87
--- /dev/null
+++ b/arch/sandbox/dts/sandbox_scripts.dtsi
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/ {
+	images {
+		default = "boot";
+		boot {
+			description = "Test boot script";
+			data = /incbin/("sandbox-boot.sh");
+			type = "script";
+			compression = "none";
+		};
+		outer {
+			description = "Script testing recursion";
+			data = /incbin/("sandbox-outer.sh");
+			type = "script";
+			compression = "none";
+		};
+		inner {
+			description = "Another test script";
+			data = /incbin/("sandbox-inner.sh");
+			type = "script";
+			compression = "none";
+		};
+	};
+};
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index ba800f7d19d..bfdc5ee6010 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -20,6 +20,7 @@ CONFIG_EFI_CAPSULE_AUTHENTICATE=y
 CONFIG_EFI_CAPSULE_CRT_FILE="board/sandbox/capsule_pub_key_good.crt"
 CONFIG_BUTTON_CMD=y
 CONFIG_FIT=y
+CONFIG_CONTROL_DTB_AS_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_CIPHER=y
 CONFIG_FIT_VERBOSE=y
@@ -152,6 +153,7 @@ CONFIG_CMD_STACKPROTECTOR_TEST=y
 CONFIG_CMD_SPAWN=y
 CONFIG_MAC_PARTITION=y
 CONFIG_OF_LIVE=y
+CONFIG_DEVICE_TREE_INCLUDES="sandbox_scripts.dtsi"
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_EXT4=y
diff --git a/test/py/tests/test_source.py b/test/py/tests/test_source.py
index 970d8c79869..29ab804f81b 100644
--- a/test/py/tests/test_source.py
+++ b/test/py/tests/test_source.py
@@ -34,3 +34,34 @@ def test_source(ubman):
     ubman.run_command('fdt rm /images default')
     assert 'Fail' in ubman.run_command('source || echo Fail')
     assert 'Fail' in ubman.run_command('source \\# || echo Fail')
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_echo')
+@pytest.mark.buildconfigspec('cmd_source')
+@pytest.mark.buildconfigspec('fit')
+@pytest.mark.buildconfigspec('control_dtb_as_fit')
+def test_source_control_dtb(ubman):
+    output = ubman.run_command('source ${fdtcontroladdr}')
+    assert '* default script' in output
+
+    output = ubman.run_command('source ${fdtcontroladdr}:boot')
+    assert '* default script' in output
+
+    output = ubman.run_command('source ${fdtcontroladdr}:outer')
+    assert '* outer 1' in output
+    assert '* inner' in output
+    assert '* outer 2' in output
+
+    output = ubman.run_command('source ${fdtcontroladdr}:inner')
+    assert '* outer' not in output
+    assert '* inner' in output
+
+    assert 'Fail' in ubman.run_command('source ${fdtcontroladdr}:no-such-script || echo Fail')
+
+@pytest.mark.buildconfigspec('cmd_echo')
+@pytest.mark.buildconfigspec('cmd_source')
+@pytest.mark.buildconfigspec('fit')
+@pytest.mark.notbuildconfigspec('control_dtb_as_fit')
+def test_source_reject_control_dtb(ubman):
+    assert 'Fail' in ubman.run_command('source ${fdtcontroladdr} || echo Fail')
+    assert 'Fail' in ubman.run_command('source ${fdtcontroladdr}:boot || echo Fail')
-- 
2.54.0

