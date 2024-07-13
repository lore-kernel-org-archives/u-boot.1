Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17250C3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 07:07:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89B9088850;
	Sat, 13 Jul 2024 09:04:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A5h8EvuD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB8C78886A; Sat, 13 Jul 2024 09:04:03 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B38F8885D
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 09:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4266f344091so19964405e9.0
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 00:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720854239; x=1721459039; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OwQcwQiMLm1pWH2PRS4awLZz7iFtQTU0UAdA7MWuk1g=;
 b=A5h8EvuDmimcC9L70wiPV651Cd6uRtYpoNv666DrqAT/CDwAWENJ0JSqGEwF65X00l
 qDKjfkh63iJKaXFxK1K+HkcKGGUHphSi36n9DbC07+bXaFk0UlZ0yOiijQcae+jD07gG
 yImrAD8k4itk5dht/bbtXG3Cbbz/Z/y/qYMyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720854239; x=1721459039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OwQcwQiMLm1pWH2PRS4awLZz7iFtQTU0UAdA7MWuk1g=;
 b=iWkr5bkn2bIYOhF8l/8qtY/DFwY6F55AL0S6W80kwJwR3TwcJtAtyH0RHVskflt/yq
 ADarA940A3E513+Hz8yQXPH85e5VzGQrb4DfmSIYYTPD0tZVX3bxjyoOML1rrVr8SSyS
 ltsseAGg1GeYJ4IjPjKnPkmtL3oSlAIkXwaNVp2ueUCDJNQJxsGVzUwdiGXxOkX101CL
 KuvuyLiBRt/QVAgZsEW5Z+XCypUeX+zpJrfQNWdilQdlbxBgMz/nBrnKBJiDMlAW8OGR
 8wDH/Th6icTGdhtEgr0BPKg3OMD070oVo24R/BP9txY+1EZ4Z7kvx+0JCHPddWOuYJFK
 lfgw==
X-Gm-Message-State: AOJu0Yy83TqjV/2hFrZ5yUnwnvND4PBV37ypc1q2xhu0MOmk9NdblXgA
 LGXSAGJ/blJjPdFOZtyohx+Ksr1aXicnjtjOfj7f3SYzfMNHhYolNfqRiMWCH1DE3bOMV5bhDCU
 =
X-Google-Smtp-Source: AGHT+IGS6iZQl/ijJUyYFVR3l4RUMfaycdMz0iiq3zamWjA9tokFrlqNgV2Age9JPnMn2tEFqJY7MQ==
X-Received: by 2002:a05:600c:6d4:b0:426:6b85:bafb with SMTP id
 5b1f17b1804b1-426707db6e7mr77958535e9.20.1720854239516; 
 Sat, 13 Jul 2024 00:03:59 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef550asm9973165e9.46.2024.07.13.00.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jul 2024 00:03:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 21/21] upl: Add an end-to-end test
Date: Sat, 13 Jul 2024 08:00:55 +0100
Message-Id: <20240713070055.2172883-21-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713070055.2172883-1-sjg@chromium.org>
References: <20240713070055.2172883-1-sjg@chromium.org>
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

Now that sandbox_vpl supports UPL, add a test that checks that the
payload can be loaded by SPL and the handoff information passed through
to U-Boot proper.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Support CI testing
- Rework to use alist instead of fixed-length arrays

 MAINTAINERS               |  1 +
 test/boot/upl.c           | 28 ++++++++++++++++++++++++++++
 test/py/tests/test_upl.py | 17 +++++++++++++++--
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96faa9e1acc..e89d166709d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1705,6 +1705,7 @@ F:	doc/usage/upl.rst
 F:	doc/usage/cmd/upl.rst
 F:	include/upl.h
 F:	test/boot/upl.c
+F:	test/py/tests/test_upl.py
 
 USB
 M:	Marek Vasut <marex@denx.de>
diff --git a/test/boot/upl.c b/test/boot/upl.c
index c55f1d297d1..9ec2540f455 100644
--- a/test/boot/upl.c
+++ b/test/boot/upl.c
@@ -398,6 +398,34 @@ static int upl_test_read_write(struct unit_test_state *uts)
 }
 UPL_TEST(upl_test_read_write, UT_TESTF_CONSOLE_REC);
 
+/* Test UPL passthrough */
+static int upl_test_info_norun(struct unit_test_state *uts)
+{
+	const struct upl_image *img;
+	struct upl *upl = gd_upl();
+	const void *fit;
+
+	ut_assertok(run_command("upl info -v", 0));
+	ut_assert_nextline("UPL state: active");
+	ut_assert_nextline("fit %lx", upl->fit);
+	ut_assert_nextline("conf_offset %x", upl->conf_offset);
+	ut_assert_nextlinen("image 0");
+	ut_assert_console_end();
+
+	/* check the offsets */
+	fit = map_sysmem(upl->fit, 0);
+	ut_asserteq_str("conf-1", fdt_get_name(fit, upl->conf_offset, NULL));
+
+	ut_asserteq(1, upl->image.count);
+
+	img = alist_get(&upl->image, 0, struct upl_image);
+	ut_asserteq_str("firmware-1", fdt_get_name(fit, img->offset, NULL));
+	ut_asserteq(CONFIG_TEXT_BASE, img->load);
+
+	return 0;
+}
+UPL_TEST(upl_test_info_norun, UT_TESTF_CONSOLE_REC | UT_TESTF_MANUAL);
+
 int do_ut_upl(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	struct unit_test *tests = UNIT_TEST_SUITE_START(upl_test);
diff --git a/test/py/tests/test_upl.py b/test/py/tests/test_upl.py
index 171079f8dba..3164bda6b71 100644
--- a/test/py/tests/test_upl.py
+++ b/test/py/tests/test_upl.py
@@ -10,6 +10,15 @@ import u_boot_utils
 
 @pytest.mark.boardspec('sandbox_vpl')
 def test_upl_handoff(u_boot_console):
+    """Test of UPL handoff
+
+    This works by starting up U-Boot VPL, which gets to SPL and then sets up a
+    UPL handoff using the FIT containing U-Boot proper. It then jumps to U-Boot
+    proper and runs a test to check that the parameters are correct.
+
+    The entire FIT is loaded into memory in SPL (in upl_load_from_image()) so
+    that it can be inpected in upl_test_info_norun
+    """
     cons = u_boot_console
     ram = os.path.join(cons.config.build_dir, 'ram.bin')
     fdt = os.path.join(cons.config.build_dir, 'u-boot.dtb')
@@ -17,9 +26,13 @@ def test_upl_handoff(u_boot_console):
     # Remove any existing RAM file, so we don't have old data present
     if os.path.exists(ram):
         os.remove(ram)
-    flags = ['-m', ram, '-d', fdt]
+    flags = ['-m', ram, '-d', fdt, '--upl']
     cons.restart_uboot_with_flags(flags, use_dtb=False)
 
     # Make sure that Universal Payload is detected in U-Boot proper
     output = cons.run_command('upl info')
-    assert output == 'UPL state: active'
+    assert 'UPL state: active' == output
+
+    # Check the FIT offsets look correct
+    output = cons.run_command('ut upl -f upl_test_info_norun')
+    assert 'Failures: 0' in output
-- 
2.34.1

