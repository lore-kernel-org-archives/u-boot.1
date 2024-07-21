Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A978C3DA61
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 10:13:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B61538863C;
	Sun, 21 Jul 2024 12:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VeJVmwDP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3782287F8D; Sun, 21 Jul 2024 12:10:18 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA83B88617
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 12:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4266f344091so23696785e9.0
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 03:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721556615; x=1722161415; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PvKvyMvTE93I437BRPLo2MqSpmJuhBEm8V2Ya07vibE=;
 b=VeJVmwDPBqqgKcDCilGIj4rer5XPeKIYxkAWIT86sD66VXblBrPeQJHpb9lDI9c2c6
 4emtc0RazbSYa51PzxV+NqS7gO4LEhSnkFa7lg7hvyaZjgrMrpSDtmAOSSlnEG6IvWI8
 IlXSukRfzTONhww6r2Knw1giBtaXwflXDzgUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721556615; x=1722161415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PvKvyMvTE93I437BRPLo2MqSpmJuhBEm8V2Ya07vibE=;
 b=iWzHDXMxedYiCif+n9b1aJBGPXZpPaj9G8LYz8d24PRKRHOoF47cR7wEpVUK2e/woi
 MYcgrSfHnruFDoCoSNrhJQVULz8y7JU4bnKFZgUwV3bSEq7xmJW0Bmw9q6jOMXAO1Qrc
 lZNifT3R0NWVadtOUTv9WzyFPy6yzUavZ10kO5RPrHuCGvMXhr6vM0QE7sV8BNbVbpOv
 PBYJ4Cgnzre/sm0+q9EbFMrMXxRlfE84yeoy7IQJdHmhDV6/Us46o4mxDe+KkljIRyIB
 F5mtzSy7TsEQ8PZ5xYGPpFjiMxw7Hm4z7ob4h6ql+8csg4jB+S6n9gmFVD41Gsise25e
 nfJg==
X-Gm-Message-State: AOJu0YyCOOhT9LPixQje+40zf8nPLgieOQ/FSm4/hlCuFl2uLl/fYw/i
 /Z8tOoBCt0BA+tKM0TkCqRCyWNxlnLqRFZ5vj9F3EaJPrsSIOSZlKq5XNisKoghDW7Na29WeLzQ
 =
X-Google-Smtp-Source: AGHT+IGIs7Bt41jHRT+sFyOyrwwxYGlaZe/fdHm9HczeaCErjDltmd68mffA9l+QKp1TuWf9iy7LwQ==
X-Received: by 2002:a05:600c:5103:b0:426:6364:c2c4 with SMTP id
 5b1f17b1804b1-427dc520aedmr20072935e9.14.1721556614948; 
 Sun, 21 Jul 2024 03:10:14 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69013fasm85096265e9.12.2024.07.21.03.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 03:10:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 21/21] upl: Add an end-to-end test
Date: Sun, 21 Jul 2024 11:09:39 +0100
Message-Id: <20240721100940.3202027-21-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721100940.3202027-1-sjg@chromium.org>
References: <20240721100940.3202027-1-sjg@chromium.org>
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

(no changes since v2)

Changes in v2:
- Support CI testing
- Rework to use alist instead of fixed-length arrays

 MAINTAINERS               |  1 +
 test/boot/upl.c           | 29 +++++++++++++++++++++++++++++
 test/py/tests/test_upl.py | 17 +++++++++++++++--
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8842ff8ad91..7f988e0762f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1712,6 +1712,7 @@ F:	doc/usage/upl.rst
 F:	doc/usage/cmd/upl.rst
 F:	include/upl.h
 F:	test/boot/upl.c
+F:	test/py/tests/test_upl.py
 
 USB
 M:	Marek Vasut <marex@denx.de>
diff --git a/test/boot/upl.c b/test/boot/upl.c
index c55f1d297d1..707bc9c9065 100644
--- a/test/boot/upl.c
+++ b/test/boot/upl.c
@@ -398,6 +398,35 @@ static int upl_test_read_write(struct unit_test_state *uts)
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
+	ut_assert_nextlinen("image 1");
+	ut_assert_console_end();
+
+	/* check the offsets */
+	fit = map_sysmem(upl->fit, 0);
+	ut_asserteq_str("conf-1", fdt_get_name(fit, upl->conf_offset, NULL));
+
+	ut_asserteq(2, upl->image.count);
+
+	img = alist_get(&upl->image, 1, struct upl_image);
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

