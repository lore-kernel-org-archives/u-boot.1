Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20BEC55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 17:19:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CBF4160B36;
	Fri, 31 Jul 2026 17:19:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xL4tL8tnThgX; Fri, 31 Jul 2026 17:19:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A2CED60B25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785518342;
	bh=tT22SCqLyAWDfjYtiGFy0C3Pdf2qZyOmpgVmvH60ghg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dUtwFlhQFcYHseYZi8kBnDAeItfluAn+6Yx8D4DdZMG0I/lKpNm3MCLarWV66OrvA
	 6+vJapsznJL0fwZVn8wtZzTjFeN66xXPNuHTggX8NQVR6VvMTrGPZnwm7yla7V9Eu+
	 eQN98xzCGDg/aVq3b6LosO++1+/Ja+NpQ2YyRTCiIZztanP3Ly8ShUvcZmMOhPZfJg
	 nZAxjgazubY0XXHO404gCvycR6ZHRr8QuYF9fVXD6atNQqvBty2xYxqprZy/FjxBqo
	 xrdYqdBvHvX7eZhc3GBXD69pj5B0YB5Szu8Ce62epKYH4n9/CJ7u0OipqpIbvz4CsV
	 1irjj7PqriAUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A2CED60B25;
	Fri, 31 Jul 2026 17:19:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EE5FD27B
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:11:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D4B4580F2D
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:11:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Xusv13J6cDL for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 17:11:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A8E8280EA3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A8E8280EA3
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A8E8280EA3
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:11:48 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-47db714766aso1423303f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 10:11:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785517907; x=1786122707;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tT22SCqLyAWDfjYtiGFy0C3Pdf2qZyOmpgVmvH60ghg=;
 b=UFm29qyW9bHBR2Fub2YGx5uR9euvY1A5niDAZyTSRY9hfpsit8s38Af5MKd22705+R
 mN9pLGnj5ekpxw4gDd6b4pr3M5xONc++l3xaf0C5jlfvzxE7A6nNNHgnwJpAnWqXKCp/
 TY6YJ1NrDBVlIziAqu1iFzxcY3Lzf5/YHNzTy6K12mCNNUuC0CcMia29TWdRZNywBYS5
 ITmgVoLUYU7DlQZ/ZZaPCTQcgr3zn7FWSZdx52K166WfcKPca9Bt5DJQ/TJ/ZGvtAE5d
 RbJzvKxxAddVaEEb/bd6xGSNRNnHuCXOyb6Xe5XMyrN51wiSxIA+AqnAUpqDwEeOJxX/
 Zo9Q==
X-Gm-Message-State: AOJu0YzdXQ30wC6feQ92OAAT0c6z7ig8bZ37C9CJ5UHk2fa6bndpdrMG
 vWt0vpZvHKLAUko0DZ4GB25dg3jMZ2AU1w7TUhyibGI9k2XUBzeka9AwaWpIM3/wWSY=
X-Gm-Gg: AR+sD100jCv8F2gW2VqPxmSY8AWBGw9Od+/oykwwX1+OpA6UCLEg6cn6JPl+SM3v1qs
 rnKGD1vC/ge7fgI9pHLPyDFkPZdZHFl9Jm+bwljKrcAmFtSylfESx+b//r+jiVQ9gRyO7R6sssm
 W9+gFp/WKens2eXv9ffWIRvXajg/e5I8OPrjLo58aFFGWVgg5cvo0iASM0OJQtgfZVoSVVOKOFl
 4H70pVIq1aZnoB8h0WX10lfWlDm6R88sHpp4lOue4bnHm1lXM5gUd6Xb2VRhKoXTzIL6cXePAJX
 g1VidOB0woCbsKj3zJf6ydpbX0dBjG94vpkjMdzMoCVud+qK6DtTvdTk3Z1tnZMARAoe53gZaTf
 nxqVBZUEcX3b14Xut0292DF+9+CneJAkbLg4BjW4j7jlESXr14DpbiF2g69CciYJv+6g4G//JKa
 dDZ3KMcgJcFadD9YKlIVFs8f1qwZ3lJjNvX8f8+BDv+GmUYQ9VGlUuABjOqaxHDtaxTZBtdtOyF
 vFigRD14B69dv5Ha5jEJ2ousDqYGTgDGjk5snTZKA==
X-Received: by 2002:a05:6000:3105:b0:45e:dd32:92fa with SMTP id
 ffacd0b85a97d-47fd32b9e39mr5554402f8f.12.1785517906520; 
 Fri, 31 Jul 2026 10:11:46 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41d1a58sm7541484f8f.7.2026.07.31.10.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 10:11:46 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 31 Jul 2026 21:10:51 +0400
Subject: [PATCH v2 07/10] binman: tests: Add test coverage for a FIT with
 embedded Linux+initrd and /chosen
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-atf-falcon-v2-7-acb97c172993@flipper.net>
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
In-Reply-To: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>, Ronald Wahl <ronald.wahl@legrand.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10530; i=alchark@flipper.net; 
 h=from:subject:message-id;
 bh=j9BdsjJO+QvCmWZy6GUb+0a2VhC5SAy8+PBu74+SpaE=; 
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTlXFcy4m87N+nC56Kn3UmLGEUtnojZnDi9z/YJfxPLw
 aMZj8WTOiayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZjqO3EM//OYH/bNe/TChy3hxC9GgXKuK4aqHd9Od/ZWBsxPOGJ224Thn+r1E9J
 1exZ4PTuUsu3ryyWuzGXCnpJ6x7TzHle/3fz2KR8A
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Fri, 31 Jul 2026 17:18:49 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785517907; x=1786122707;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tT22SCqLyAWDfjYtiGFy0C3Pdf2qZyOmpgVmvH60ghg=;
 b=lWKGSw5xB5XtgYXsfKH9kMRnTSd6ZGKxD/tZlB9s5UiGy09e+c1PBgNIBEcI3C4jha
 0iZJY3W5zRz+HjiC9X5oKibQbk8sf6xBGpJtss9vsgpA5geZp65Lh1QM/6Djk8PU6Nda
 O7YKfnZgUON6r+pb8y07k5MtAUM5LndYY+esY9mYQv9iMfzytWmJPgsmJOONAGrikOIE
 dX/4e5oNLk48bH56lhX/H/1qlu23g5+WDNnaLuSrwcxAGyS3mRkT6DgMPHHMXmXIfoBK
 p7Sy4AwSLwt7Ump9Sa0rhHY54RS2Ha2w1dmCXq5GMobqMFgh8mA+Vcn+YmGJS67mAOFo
 B3Kw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=lWKGSw5x
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add a test for a FIT image with a fake Linux kernel and initrd, and a
valid device tree into which a /chosen node is added (containing a
bootargs property, as is relevant for Falcon mode boot).

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 tools/binman/ftest.py                          | 107 +++++++++++++++++++++++++
 tools/binman/test/fit/fit_chosen.dts           |  62 ++++++++++++++
 tools/binman/test/fit/fit_chosen_no_initrd.dts |  60 ++++++++++++++
 tools/binman/test/fit/fit_chosen_no_load.dts   |  57 +++++++++++++
 4 files changed, 286 insertions(+)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 9553eb6b7366..bc65cb25ef25 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -4397,6 +4397,113 @@ class TestFunctional(unittest.TestCase):
         self.assertIn("default-dt entry argument 'test-fdt3' not found in fdt list: test-fdt1, test-fdt2",
                       str(e.exception))
 
+    def testFitChosen(self):
+        """Test patching /chosen (bootargs + initrd) into generated FIT FDTs"""
+        kernel = b'\x01\x02\x03\x04 kernel'
+        initrd = b'initramfs-contents'
+        self._MakeInputFile('test-kernel.bin', kernel)
+        self._MakeInputFile('test-initrd.bin', initrd)
+        entry_args = {
+            'of-list': 'model1 model2',
+            'default-dt': 'model2',
+            'linux-kernel-path': 'test-kernel.bin',
+            'linux-initrd-path': 'test-initrd.bin',
+        }
+        testdir, _ = self.SetupAlternateDts()
+        data = self._DoReadFileDtb(
+            'fit/fit_chosen.dts', use_real_dtb=True, update_dtb=True,
+            entry_args=entry_args, extra_indirs=[testdir])[0]
+        fit_data = data[len(U_BOOT_DATA):-len(U_BOOT_NODTB_DATA)]
+        fit = fdt.Fdt.FromData(fit_data)
+        fit.Scan()
+
+        # ramdisk is loaded at 0x1000 (see fit_chosen.dts)
+        rd_start = 0x1000
+        rd_end = rd_start + len(initrd)
+        for seq in (1, 2):
+            fnode = fit.GetNode('/images/fdt-%d' % seq)
+            self.assertIsNotNone(fnode)
+            dtb = fdt.Fdt.FromData(fnode.props['data'].bytes)
+            dtb.Scan()
+            chosen = dtb.GetNode('/chosen')
+            self.assertIsNotNone(chosen)
+            self.assertEqual(b'console=ttyS0 root=/dev/ram\0',
+                             chosen.props['bootargs'].bytes)
+            start = int.from_bytes(chosen.props['linux,initrd-start'].bytes,
+                                   'big')
+            end = int.from_bytes(chosen.props['linux,initrd-end'].bytes, 'big')
+            self.assertEqual(rd_start, start)
+            self.assertEqual(rd_end, end)
+            # The initramfs region must be reserved in the FDT
+            fdt_obj = dtb.GetFdtObj()
+            self.assertEqual(1, fdt_obj.num_mem_rsv())
+            _, addr, size = fdt_obj.get_mem_rsv(0)
+            self.assertEqual(rd_start, addr)
+            self.assertEqual(len(initrd), size)
+
+    def testFitChosenNoInitrd(self):
+        """Test a Falcon-mode FIT where the optional initramfs is not supplied"""
+        self._MakeInputFile('test-kernel.bin', b'\x01\x02\x03\x04 kernel')
+        entry_args = {
+            'of-list': 'model1 model2',
+            'default-dt': 'model2',
+            'linux-kernel-path': 'test-kernel.bin',
+            'linux-initrd-path': '',
+        }
+        testdir, _ = self.SetupAlternateDts()
+        with terminal.capture() as (stdout, stderr):
+            data = self._DoReadFileDtb(
+                'fit/fit_chosen_no_initrd.dts', use_real_dtb=True,
+                update_dtb=True, entry_args=entry_args,
+                extra_indirs=[testdir], allow_fake_blobs=False)[0]
+        self.assertRegex(
+            stderr.getvalue(),
+            "Image '.*' is missing optional external blobs but is still functional: linux-initrd")
+
+        fit_data = data[len(U_BOOT_DATA):-len(U_BOOT_NODTB_DATA)]
+        fit = fdt.Fdt.FromData(fit_data)
+        fit.Scan()
+
+        for seq in (1, 2):
+            # The node is still emitted and still listed as a loadable, as is
+            # already the case for an optional OP-TEE which was not supplied
+            # (see testFitFirmwareLoadables), but it carries no data
+            cnode = fit.GetNode('/configurations/config-%d' % seq)
+            self.assertEqual(b'kernel\0', cnode.props['firmware'].bytes)
+            self.assertEqual(['ramdisk'],
+                             fdt_util.GetStringList(cnode, 'loadables'))
+            self.assertEqual(b'', fit.GetNode('/images/ramdisk')
+                             .props['data'].bytes)
+
+            # bootargs is still patched in, but the initrd properties are not
+            fnode = fit.GetNode('/images/fdt-%d' % seq)
+            dtb = fdt.Fdt.FromData(fnode.props['data'].bytes)
+            dtb.Scan()
+            chosen = dtb.GetNode('/chosen')
+            self.assertEqual(b'console=ttyS0\0', chosen.props['bootargs'].bytes)
+            self.assertNotIn('linux,initrd-start', chosen.props)
+            self.assertNotIn('linux,initrd-end', chosen.props)
+            self.assertEqual(0, dtb.GetFdtObj().num_mem_rsv())
+
+    def testFitChosenNoLoad(self):
+        """Test a fit,initrd image which is missing its load address"""
+        self._MakeInputFile('test-kernel.bin', b'\x01\x02\x03\x04 kernel')
+        self._MakeInputFile('test-initrd.bin', b'initramfs-contents')
+        entry_args = {
+            'of-list': 'model1 model2',
+            'default-dt': 'model2',
+            'linux-kernel-path': 'test-kernel.bin',
+            'linux-initrd-path': 'test-initrd.bin',
+        }
+        testdir, _ = self.SetupAlternateDts()
+        with self.assertRaises(ValueError) as e:
+            self._DoReadFileDtb(
+                'fit/fit_chosen_no_load.dts', use_real_dtb=True,
+                update_dtb=True, entry_args=entry_args,
+                extra_indirs=[testdir])
+        self.assertIn("fit,initrd image 'ramdisk' has no 'load' address",
+                      str(e.exception))
+
     def testFitExtblobMissingHelp(self):
         """Test display of help messages when an external blob is missing"""
         control.missing_blob_help = control._ReadMissingBlobHelp()
diff --git a/tools/binman/test/fit/fit_chosen.dts b/tools/binman/test/fit/fit_chosen.dts
new file mode 100644
index 000000000000..ae2e4a084af6
--- /dev/null
+++ b/tools/binman/test/fit/fit_chosen.dts
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		u-boot {
+		};
+		fit {
+			description = "test-desc";
+			#address-cells = <1>;
+			fit,fdt-list = "of-list";
+
+			images {
+				kernel {
+					description = "Linux kernel";
+					type = "kernel";
+					arch = "arm64";
+					os = "linux";
+					compression = "none";
+					load = <0x100>;
+					entry = <0x100>;
+					linux-kernel {
+					};
+				};
+				ramdisk {
+					description = "ramdisk";
+					type = "ramdisk";
+					compression = "none";
+					load = <0x1000>;
+					linux-initrd {
+					};
+				};
+				@fdt-SEQ {
+					description = "fdt-NAME.dtb";
+					type = "flat_dt";
+					compression = "none";
+					fit,bootargs = "console=ttyS0 root=/dev/ram";
+					fit,initrd = "ramdisk";
+					hash {
+						algo = "sha256";
+					};
+				};
+			};
+
+			configurations {
+				default = "@config-DEFAULT-SEQ";
+				@config-SEQ {
+					description = "conf-NAME.dtb";
+					firmware = "kernel";
+					loadables = "ramdisk";
+					fdt = "fdt-SEQ";
+				};
+			};
+		};
+		u-boot-nodtb {
+		};
+	};
+};
diff --git a/tools/binman/test/fit/fit_chosen_no_initrd.dts b/tools/binman/test/fit/fit_chosen_no_initrd.dts
new file mode 100644
index 000000000000..82468e94dcdb
--- /dev/null
+++ b/tools/binman/test/fit/fit_chosen_no_initrd.dts
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		u-boot {
+		};
+		fit {
+			description = "test-desc";
+			#address-cells = <1>;
+			fit,fdt-list = "of-list";
+
+			images {
+				kernel {
+					description = "Linux kernel";
+					type = "kernel";
+					arch = "arm64";
+					os = "linux";
+					compression = "none";
+					load = <0x100>;
+					entry = <0x100>;
+					linux-kernel {
+					};
+				};
+				ramdisk {
+					description = "ramdisk";
+					type = "ramdisk";
+					compression = "none";
+					load = <0x1000>;
+					linux-initrd {
+						optional;
+					};
+				};
+				@fdt-SEQ {
+					description = "fdt-NAME.dtb";
+					type = "flat_dt";
+					compression = "none";
+					fit,bootargs = "console=ttyS0";
+					fit,initrd = "ramdisk";
+				};
+			};
+
+			configurations {
+				default = "@config-DEFAULT-SEQ";
+				@config-SEQ {
+					description = "conf-NAME.dtb";
+					fit,firmware = "kernel", "ramdisk";
+					fit,loadables;
+					fdt = "fdt-SEQ";
+				};
+			};
+		};
+		u-boot-nodtb {
+		};
+	};
+};
diff --git a/tools/binman/test/fit/fit_chosen_no_load.dts b/tools/binman/test/fit/fit_chosen_no_load.dts
new file mode 100644
index 000000000000..7a3d393dd210
--- /dev/null
+++ b/tools/binman/test/fit/fit_chosen_no_load.dts
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		u-boot {
+		};
+		fit {
+			description = "test-desc";
+			#address-cells = <1>;
+			fit,fdt-list = "of-list";
+
+			images {
+				kernel {
+					description = "Linux kernel";
+					type = "kernel";
+					arch = "arm64";
+					os = "linux";
+					compression = "none";
+					load = <0x100>;
+					entry = <0x100>;
+					linux-kernel {
+					};
+				};
+				ramdisk {
+					description = "ramdisk";
+					type = "ramdisk";
+					compression = "none";
+					linux-initrd {
+					};
+				};
+				@fdt-SEQ {
+					description = "fdt-NAME.dtb";
+					type = "flat_dt";
+					compression = "none";
+					fit,initrd = "ramdisk";
+				};
+			};
+
+			configurations {
+				default = "@config-DEFAULT-SEQ";
+				@config-SEQ {
+					description = "conf-NAME.dtb";
+					firmware = "kernel";
+					loadables = "ramdisk";
+					fdt = "fdt-SEQ";
+				};
+			};
+		};
+		u-boot-nodtb {
+		};
+	};
+};

-- 
2.54.0

