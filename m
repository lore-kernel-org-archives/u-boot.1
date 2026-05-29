Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D1BCD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 20:17:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9038A847C4;
	Fri, 29 May 2026 22:17:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="KeT3Iw+4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9007846A5; Fri, 29 May 2026 21:46:37 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98500805D7
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 21:46:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bd56d108454so2523662866b.2
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 12:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google; t=1780083995; x=1780688795; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AowJ9WjqjCNO6UqBWTemgGYXNR+DfFxx/2tVYN8Qd84=;
 b=KeT3Iw+4fEzMJCD4f1zSHwst0rKHV1bljxqp99SFP4uk32lV6Wt7DBUb1yF6qOPs97
 WhTpr0suRweahMjgdov2eaa5ec9StpJsSCefHZSr7OUftvQkZ2Ne2tJ3GF+G/73aR38h
 w+hKlc3MEsuXObHgszs4XLIcZd1EtX6/xhJZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780083995; x=1780688795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AowJ9WjqjCNO6UqBWTemgGYXNR+DfFxx/2tVYN8Qd84=;
 b=inmf4F6WwFN3mmSY6aPlhWpJaW1D6MeFm1Cggays67GvQ8gERMRTs/L8gr4ksV9hSN
 63jeED85FjHm8Yo7qxcA7sW1ziFUJGIN35YOIKVefnYb9oOhZT0QiHOLRHv/46a7rsee
 xdmN1CJfeowxrwPZrSK4UMpTb1jtPZSCdFrPYIE4CGkCtCgZ0B+k+9vcF81Xm9NHMuzM
 6ukkJeCLcZPifVZ2l8mwnOWOzy0Kb8ectVew1EGpTR1Th++nsfkgf7KCM+eqjsmO0X4R
 pEYubWSTf+lVfy86ZLRIyMObtM3InqJprid8W8IlRxgwfgoq6yDmxv3A2AtBG8nJDUVw
 5hYw==
X-Gm-Message-State: AOJu0YwChRl84Mw7aV4mTcP/rfKoSfezBy7BD6IMYdWcbaNYH/Q0PobV
 j0nAFK4R1wZ5B6nrC8TiPhWnBoFJes2nT75UhtWuHP047+95XE7KmDaoZO1MxOI17QFh8rlzTey
 hExhpxJk=
X-Gm-Gg: Acq92OEHUoJXwlhaazsqignc9oaHGTG8pYKAlEI8SyLK/Y/lvB10SOK7SF/JFtrLSp8
 NKMahcXGBh91TBPx7aR/cSc9PSLr1W30n5jEghiR0iQ76Y1dECOun5US7QE7+1Ka4SzqBAntjzG
 6DzfGBo+SFNuFbMqBQzhhCrZhx9YFnRD52YQ42l8nfWPP9FArYqK02M8QbXQfxKZJtQcibzj5PF
 plUQ2eB6ObTsvAAAtEhPVsvCuNrsAQySmpXS4uDuEx7I7UIVR02NRnjgfgxDFrn7lo6mLYWYGl/
 Oi3wNaRcAQiRKGzRvVa4+ZOVvW+z5bAyuQQO55dDKfM3f52Y780606thmVQu57Eew14BzrgLg9p
 TkZfQ3qYP4vabLCPr7cfTH3J7WxUdpJ7dF4oJnqwdhQYBtw4U56tHbC9RJNEKu2nn1BCmWXCOiU
 fKj0aQsYg1YLOEtLuPfRyOPcMXkpgZzykiMJH90acRLg6Ed7fRO6NUEv9gloViwFyq
X-Received: by 2002:a17:907:3e16:b0:bd4:6c96:f87b with SMTP id
 a640c23a62f3a-beab2082093mr60716966b.28.1780083994879; 
 Fri, 29 May 2026 12:46:34 -0700 (PDT)
Received: from localhost (77.33.185.121.dhcp.fibianet.dk. [77.33.185.121])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-be9d27f2222sm96070366b.7.2026.05.29.12.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 12:46:33 -0700 (PDT)
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v3 3/3] test: hook up test of allowing control DTB to act as
 FIT image
Date: Fri, 29 May 2026 21:46:21 +0200
Message-ID: <20260529194621.1470583-4-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529194621.1470583-1-rv@rasmusvillemoes.dk>
References: <20260529194621.1470583-1-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 29 May 2026 22:17:03 +0200
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

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 arch/sandbox/dts/sandbox-boot.sh      |  2 ++
 arch/sandbox/dts/sandbox-inner.sh     |  4 ++++
 arch/sandbox/dts/sandbox-outer.sh     |  4 ++++
 arch/sandbox/dts/sandbox_scripts.dtsi | 24 ++++++++++++++++++++
 configs/sandbox_defconfig             |  2 ++
 test/py/tests/test_source.py          | 32 +++++++++++++++++++++++++++
 6 files changed, 68 insertions(+)
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
index 970d8c79869..f453e9be1a9 100644
--- a/test/py/tests/test_source.py
+++ b/test/py/tests/test_source.py
@@ -34,3 +34,35 @@ def test_source(ubman):
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
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_echo')
+@pytest.mark.buildconfigspec('cmd_source')
+@pytest.mark.buildconfigspec('fit')
+@pytest.mark.notbuildconfigspec('control_dtb_as_fit')
+def test_source_reject_control_dtb(ubman):
+    assert 'Fail' in ubman.run_command('source ${fdtcontroladdr} || echo Fail')
+    assert 'Fail' in ubman.run_command('source ${fdtcontroladdr}:boot || echo Fail')
-- 
2.54.0

