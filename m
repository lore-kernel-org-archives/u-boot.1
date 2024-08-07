Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C3EC3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 22:51:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD9FD88B22;
	Thu,  8 Aug 2024 00:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K7DU+WKb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38D1888BA6; Thu,  8 Aug 2024 00:48:25 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF79D88B14
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 00:48:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-396675b83afso1972235ab.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 15:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723070901; x=1723675701; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NEubK/T5LfRgBROgtTNER/25E6npggmwMrVrdDnH57A=;
 b=K7DU+WKbn9ssjtHTkYOC9BxXZpGj3jUNsv++K+Xv9q+IGniGd5ABgWoiSNwnJxNXrL
 C36um6G81j04lMLPAUX3EoKgdoJznB3bHpO4gtNcJg9aM0k3O7LhANXn0ZUzw1MgXkZm
 DExSzCwl5TR/niQzuLd/GMEL+5tmP+r3ZWqg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723070901; x=1723675701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NEubK/T5LfRgBROgtTNER/25E6npggmwMrVrdDnH57A=;
 b=sTDXOAPT/Gsb937yFyg6Un/VqR0RsdoIRMVnTwd94JkapVKiaM4Goi4uHx8sbzlMLo
 5YJlyLLtK154XZfhVBRIz+mZkVLdcfVPDl1J9iY8Lvz9ONrCwPqhrGnqeyvD99Kvq9e2
 BkBMGQyONWMpuRNwKsqfSs0gcPuNs3PJ9KtCAs5+wnU48SjST4ORazgs4/PV9YfacCq9
 yJRm4DzE8jA3/qrjBq2JK2MiSeNvjWdgPFpsGmGaWb/wGTELgcdLHcuqgFHr/jBuHaJW
 LHRZuu924O0QS83xz51ACrkVZ50bo9BzHiMucLZxEhuG+E1TRZI3p2YMi/58z67TSh5Z
 gpIA==
X-Gm-Message-State: AOJu0Yx2x2HDD5G2XuP1QTjOVtO+cOn2NUPq1e2xvQkTxfvqQtMh62F/
 QqTa4AUMwGN/uL0WdloH42Oq8JRk2wt81HpJgmpElLn/XB5mVwDUeIovV2i6UIqp4/5c1kOg7Uo
 =
X-Google-Smtp-Source: AGHT+IGB2sGgHHRnsBYaAPRhS1KeaSdwB77T14g4EpG3OiukWYeNtC/IQIPz5wonqVzoUoFTDxFMyw==
X-Received: by 2002:a92:c566:0:b0:375:a5de:5d46 with SMTP id
 e9e14a558f8ab-39b5ec71c3cmr906985ab.5.1723070901467; 
 Wed, 07 Aug 2024 15:48:21 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20af1528sm48275205ab.80.2024.08.07.15.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 15:48:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 21/21] upl: Add an end-to-end test
Date: Wed,  7 Aug 2024 16:47:39 -0600
Message-Id: <20240807224739.3858517-21-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807224739.3858517-1-sjg@chromium.org>
References: <20240807224739.3858517-1-sjg@chromium.org>
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

Changes in v4:
- Rebase to -next

Changes in v2:
- Rework to use alist instead of fixed-length arrays
- Support CI testing

 MAINTAINERS               |  1 +
 test/boot/upl.c           | 29 +++++++++++++++++++++++++++++
 test/py/tests/test_upl.py | 17 +++++++++++++++--
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 215ffd02b45..44e9c2f03f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1720,6 +1720,7 @@ F:	doc/usage/upl.rst
 F:	doc/usage/cmd/upl.rst
 F:	include/upl.h
 F:	test/boot/upl.c
+F:	test/py/tests/test_upl.py
 
 USB
 M:	Marek Vasut <marex@denx.de>
diff --git a/test/boot/upl.c b/test/boot/upl.c
index 056ae54831b..364fb0526e4 100644
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

