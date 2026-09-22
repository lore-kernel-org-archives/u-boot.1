Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B67C982F1
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 05:19:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A97E380D49;
	Tue, 22 Sep 2026 05:19:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c72HBQ8WmemE; Tue, 22 Sep 2026 05:19:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8B45580CD9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790054341;
	b=e1GTCc+E55hKdtSgA9mXcss68rm/zW0RF9vbYvD7cEAmHSZmYgk/QIbuLpItSHpc+ue+
	 VzaCxqlDDZ/nCtL5yZDm96AkgzFJOMFhH6ksa3dXp1SesdC3kZpIX/9GAhOiDmRjorOJ4
	 +TiBpL8EbxvMuFsKgOZoMQWtLzZwg+GZebRY5j6A5Sc8o40DFb8lQLo0v1JwkncYO7d6z
	 wzpdBwlttkPTQIsWfZfV2UmThig8150jenTbtRo27fzv5Za91fuLkTChU4s8JPe/3EOoS
	 4WJJZ1H7bGLEVQF15gKoljbY8bgf8xTh+kFsBQhGiEV/8K7FYVtAl3sv+QQRUT2EFgQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790054341;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mJONTZiTQ9DV+CfAeQjXFBHUaaLSd51es4AEHH9urXY=;
	b=l7BZ09iI7MBL6rc2E3nfz3mLEqtBgIG4sB6WZdYgdFWPI0jyziSYwccktpsQGz/kI+PT
	 yCPBCieztkmLh8T1A6+L8YASG+nc0++n6VIN0Y11lrQFttL4CdehtpoQewsc3eFrXVdtJ
	 eov11l5/37HiaIyxyuDKGtmo7zQ4ppV0luvzPyecBRA5KIvxcWG9pv5wsWFfTksdWhVdn
	 b0Z0ev4VfDshAmrNnXo6XqwG3vhc9+2CloQds8r1HNxU//qnlK/7CunKoqbF8EJDNV08o
	 UARHqfmJG3J6u4AxEi524vXNuLGP7+sg3E3JIn4jJct7T3fY+y9zjrNZQeoj7UH9oOw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b="fCyySs/B";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790054341;
	bh=mJONTZiTQ9DV+CfAeQjXFBHUaaLSd51es4AEHH9urXY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iS01F+SjLg1eh68uG9hoY88z4+R/xOp+9HRualf22AdOb8gnYDRDIexY7jC/X21ZD
	 bsy7lF7HiEXy33OnYw5QagrvpyqFi62SFL44F/+HjtoUtAFGMm/3dpGP5OtBewlwaq
	 Gw7c6ocBaovzgUVd+xYuk+niUt7pAyxQmxQItz49fLGqY9H3IjQM3V3YrwdGYKDgQd
	 Cv8sz6hlDrInWEWwT1nGfT/oPck/tpjgGpqTE9m9yJQCrwHEN77BUZ5CZmZE2dXEBD
	 5y5kTpS9+1ApMR6IRwGS9/wQ4fwadtVpgI0XCVrfahv936SoFrFBtzTH0EaK5yMWoV
	 XFkKJAgn9K6Mw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B45580CD9;
	Tue, 22 Sep 2026 05:19:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B5CA7194
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 05:19:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A7A7B80CD9
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 05:19:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qNWnri_6g_VM for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 05:18:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E0C8E80CC4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790054339;
 b=fQiw/VLeHpPjFzCxYNpCk0VBm/6SpiNwCjSbNNmX98UKlKBVdbLI4GANEFu4lBT5Cu+M
 QnZids15bVaEK+exl/jWTpPTH07TsyPKaOthLLUyOwROlC8ptIFJy5ZPIbS5qgJ3Ku2uO
 ovpLxLnCjOxKdhy9X2ZUyoJSZYjYEOuWfqSvocjF99r9kLNJwL+SDQWgmMilUQQX5K8wV
 S9S8Nkwj7uOsqCDGvqf6unKh1XvNKr77z7Y5o3DIbRDslnUBMwYCDAeS63vkUi9vR1Vip
 VEH454K/9SZO+/KjFeShoj3sQlZcLkXjk2Q3cZ70jNXrOtNvMtBxg9OuYDbCalMTFow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790054339;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Last-TLS-Session-Version;
 bh=mJONTZiTQ9DV+CfAeQjXFBHUaaLSd51es4AEHH9urXY=;
 b=dOWpNQCRLIqy5P92xs8UYxTaBYhp+QcbsYuefUlveJj2QLAOTcUqXrP8cNRlraL/+Vr9
 GOvH/uhBZS2hagNXO5RAe1zABchUZ9eEm6YzbARe5FsbzRWToRnFOcg05FaemV/4MB6P9
 ADG041V/XUiKJ3RJmAY1R8TM9hyLSGmLK6vtXcjla7yvZg6iN/ZVsqLaCOerbDwIkwM/k
 Jtwob8JYp7dH3Mo+YbjTvMcsgy8JTv+7utXogCoToV3/Cn7onle5yy9dxZKctExe9YDYU
 FJKNq8teM3KO4bDp1kM8aWB7RlvflODZrACyc3SKePkSrKhxEyw+a56Y39Mfe35r9GA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b="fCyySs/B"; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=fCyySs/B
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E0C8E80CC4
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 05:18:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6456A105634; Tue, 22 Sep 2026 07:18:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1790054331; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=mJONTZiTQ9DV+CfAeQjXFBHUaaLSd51es4AEHH9urXY=;
 b=fCyySs/BV3tXjBzGCLUVvxkhhLvL6PXL1m83yVIXEtSHjeQx3mvxR4TMCg1YoQ06QbuoN1
 snKN8vhJHoO5ogTRGersjWFDRmJRsuEtByr3Nqdzu3KuxWDmezPlZdbiGl8knAaR6mmCSm
 OgUKiXwipJGm8Axh0STSqMV8P4aT5TtTAThz4se4O+cq2Fo0VcYlYaEO1YEQCKVojEaC2W
 dsetH3BTky1CNHW3SvbC1nsee2tFbJYESx5B1L+km5JP7vy296mZmzL9okhFy0ZxxGWZpc
 LGVaTUmrJredDBRNnX0DWKvLF8pGbHefnlLkM/joTYIXjdY8mcg1gNxbieo0DA==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Marek Vasut <marex@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Stefan Bigler <stefan.bigler@securiton.ch>,
 Heiko Schocher <hs@nabladev.com>, Aristo Chen <aristo.chen@canonical.com>,
 James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1] binman: nxp_imx8mcst: allow selecting the SRK table index
Date: Tue, 22 Sep 2026 07:18:35 +0200
Message-ID: <20260922051838.526368-1-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Stefan Bigler <stefan.bigler@securiton.ch>

The SRK table installed by HAB holds up to four keys, and the CSF
"Install SRK" section picks one of them via "Source index".

The configuration template hard codes index 0, so an image that has to be
verified against any other key of the table cannot be generated. That is
the normal situation once a key has been revoked and the next one of the
table is put to use.

So make the index configurable the same way as the other properties of
this etype. Add an "nxp,srk-index" device tree property, overridable by
the SRK_INDEX environment variable, defaulting to the previous value 0.

Signed-off-by: Stefan Bigler <stefan.bigler@securiton.ch>
Signed-off-by: Heiko Schocher <hs@nabladev.com>
---
CI Azure build:
https://dev.azure.com/hs0298/hs/_build/results?buildId=212&view=results
is fine.

 doc/imx/habv4/guides/mx8m_spl_secure_boot.txt |  2 ++
 tools/binman/etype/nxp_imx8mcst.py            |  4 +++
 tools/binman/ftest.py                         | 20 ++++++++++++++
 .../test/vendor/nxp_imx8_csf_srk_index.dts    | 27 +++++++++++++++++++
 4 files changed, 53 insertions(+)
 create mode 100644 tools/binman/test/vendor/nxp_imx8_csf_srk_index.dts

diff --git a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
index a3ebd397d82..163e6c600a2 100644
--- a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
+++ b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
@@ -174,6 +174,8 @@ Note that environment variables override DT properties.
 +--------------------+-------------+------------------------------------------------------------------+
 | nxp,srk-table      | SRK_TABLE   | full path to SRK_1_2_3_4_table.bin                               |
 +--------------------+-------------+------------------------------------------------------------------+
+| nxp,srk-index      | SRK_INDEX   | index of the key in the SRK table, default is 0                  |
++--------------------+-------------+------------------------------------------------------------------+
 | nxp,csf-crt        | CSF_KEY     | full path to the CSF Key CSF1_1_sha256_4096_65537_v3_usr_crt.pem |
 +--------------------+-------------+------------------------------------------------------------------+
 | nxp,img-crt        | IMG_KEY     | full path to the IMG Key IMG1_1_sha256_4096_65537_v3_usr_crt.pem |
diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
index 29a7451678d..1f83dd9b251 100644
--- a/tools/binman/etype/nxp_imx8mcst.py
+++ b/tools/binman/etype/nxp_imx8mcst.py
@@ -67,6 +67,7 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
     Properties / Entry arguments:
         - nxp,loader-address - loader address (SPL text base)
         - nxp,srk-table - full path to SRK_1_2_3_4_table.bin
+        - nxp,srk-index - index of the key in the SRK table, default is 0
         - nxp,csf-crt - full path to the CSF Key CSF1_1_sha256_4096_65537_v3_usr_crt.pem
         - nxp,img-crt - full path to the IMG Key IMG1_1_sha256_4096_65537_v3_usr_crt.pem
         - nxp,fast-auth - enable fast authentication method
@@ -85,6 +86,8 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
         self.srk_table = os.getenv(
             'SRK_TABLE', fdt_util.GetString(self._node, 'nxp,srk-table',
                                             'SRK_1_2_3_4_table.bin'))
+        self.srk_index = os.getenv(
+            'SRK_INDEX', fdt_util.GetInt(self._node, 'nxp,srk-index', 0))
         self.fast_auth = fdt_util.GetBool(self._node, 'nxp,fast-auth')
         if not self.fast_auth:
             self.csf_crt = os.getenv(
@@ -169,6 +172,7 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
         # Load configuration template and modify keys of interest
         config.read_string(CSF_CONFIG_TEMPLATE)
         config['Install SRK']['File']  = f'"{self.srk_table}"'
+        config['Install SRK']['Source index'] = f'{self.srk_index}'
         if not self.fast_auth:
             config.remove_section('Install NOCAK')
             config['Install CSFK']['File'] = f'"{self.csf_crt}"'
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 5f0de4c74a7..bbdfdc53908 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -8130,6 +8130,26 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
                                         new=fake_cst_run_cmd):
             self._DoTestFile('vendor/nxp_imx8_csf.dts')
 
+    def testNxpImx8mCSTSrkIndex(self):
+        """Test that nxp,srk-index selects the SRK key used for signing"""
+        ivt_data = struct.pack('<I', 0x412000d1)
+        ivt_data += b'\x00' * 20
+        ivt_data += struct.pack('<I', 0)
+        ivt_data += b'\x00' * 36
+        self._MakeInputFile('imx8m-ivt.bin', ivt_data)
+        with terminal.capture() as (_, stderr):
+            self._DoTestFile('vendor/nxp_imx8_csf_srk_index.dts',
+                             force_missing_bintools='cst')
+        err = stderr.getvalue()
+        self.assertRegex(err, "Image 'image'.*missing bintools.*: cst")
+
+        cfg_fname = glob.glob(
+            tools.get_output_filename('nxp.csf-config-txt.*'))[0]
+        config = configparser.ConfigParser()
+        config.optionxform = str
+        config.read(cfg_fname)
+        self.assertEqual('2', config['Install SRK']['Source index'])
+
     def testNxpImx8mCSTBintool(self):
         """Test the cst bintool run() and fetch() methods"""
         cst = bintool.Bintool.create('cst')
diff --git a/tools/binman/test/vendor/nxp_imx8_csf_srk_index.dts b/tools/binman/test/vendor/nxp_imx8_csf_srk_index.dts
new file mode 100644
index 00000000000..3c1c6d850cf
--- /dev/null
+++ b/tools/binman/test/vendor/nxp_imx8_csf_srk_index.dts
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		nxp-imx8mcst {
+			args;
+			nxp,loader-address = <0x10>;
+			nxp,srk-index = <2>;
+
+			blob {
+				filename = "imx8m-ivt.bin";
+			};
+
+			imagename {
+				type = "section";
+
+				u-boot {
+				};
+			};
+		};
+	};
+};
---
base-commit: 75df64103873fac09642860cedadaffb8cf6b2c7
branch: binman-srk-index-v1

-- 
2.55.0

