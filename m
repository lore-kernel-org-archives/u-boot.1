Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD7FCCF2C4
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 13:01:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BB09607EB;
	Sat, 17 Oct 2026 13:01:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QlZDAZPRd4Si; Sat, 17 Oct 2026 13:01:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BC9A460686
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792242091;
	b=kVYjTyFw/zseU1ubR6rCtmFxEQ6l0sG5bJ3N5n6lJHYdTiYGtzeT3+YF6nR2ay/1qjcl
	 +57BUSJozyUkq2ItHeMhy6tj6gLuq823CWj/6X8WadGLNH/2yOesGHFNg35Zj1LHqRbRu
	 9lGlwopPMFXbzn5Qic0Klw5AYcr7+TlF6D/ss6wMzsLT3In3GWUhzJRQIOhWufmng516v
	 062Ve4inpSw7Ebsq20vb5B8wjB5TZx3doSPfxlomLLfR0nzWL8weP73+utvnOkPdzZw8C
	 gXjmQWpS6ee0xyKjpFE+RN8FVIhXXMQRKS1/XwJKPnkFHn418ty9B04qJjm0VItiD9Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792242091;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=a+V535JDGToW5DtPUIHXcU7MeP/jRLPveTu8Dx95HEo=;
	b=d3pkhP7dAh285Y1JGfwKVuMO8tdDMKdttKFaRCDSfjxmlNkfTW556ZSyEuxTX7X3YaS+
	 KoUecjAoVSR60BYxa80BYgdZ3vth97CsvPlRiYfhlYuziaswN7N6X4+naImTu2CgkvYuB
	 3wY0X29rVmy2GaW7D/+UBit3GKrgCCIFb188kiBovWAT0kQUMafj1WoXf57IlMOeVQ37Z
	 xdLQJvb3Fs4QYTBpijcrSvb8OxZYsR9MDY67n7dKrpONY2ifyIPQIMDzf12wNNo7cLFLl
	 y6jHd/3bledaisYZCRBGddKEWfgGq4lzJypXfqxGS7nb2dIXvjpERgdVVyhjxXFXHgg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SbSUu3YM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792242091;
	bh=a+V535JDGToW5DtPUIHXcU7MeP/jRLPveTu8Dx95HEo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=KHMO4nE4QWF4Z88qB3jsdL6GaRHvj7nM6xuOcOtFlycGC5R6UfCygTKu25ImFcnBm
	 n79EmFK4ZQT8S6T4zUA9AohEv5T/vgeiLXqKyBtbxNBK9FYpqPwNJK2bI/DDLIWuT3
	 9qCM0PWlIT8MszOEbjUFKXDqtETVADf3Oqhpcgslz5RWVAolhZ0AXNqfG6Dc+lPEFN
	 wGkA94DYb+ujVSitTytvjAgTpPQIKuFIvuKMQ9gMSmljRUvN7xZy0IY9mI7C1H5s26
	 0oy95cxHaBxJR5bCtjhCZVc8o5tyFhhQKxiWzHIJ32HNUQZ4UkcMHWVjPA8DaqXazO
	 9anuWN7QgmxTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC9A460686;
	Sat, 17 Oct 2026 13:01:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B27B1255
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 07:39:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 98695608E0
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 07:39:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SSVjoYw-VzQK for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 07:39:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CF89B6080C
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792222780;
 b=CwbzSZW2dDg5hud9ILKaY2PjxAnYmrd7IjmeYk1oX8zzvNG6FjCGgbtIKeXw6CAqVRNo
 1npDKtpdoNI7xQ4jHOTsE9G3O0kB5eHbBurMcc35D4x0bTZiqUyvY/cb9rAePRYTPCuzT
 ur/i4AO5m1OTKD5+/smZMnVz2zNK8HUxzpccdYxS6c9PYkQA10aXJDt49rgAP5RQFoAhd
 LmBdMhRT/3h6wd22xc2NayfF7NHgXsWH5oazgXPVMWj2eEUBZ2RTxzMP3ADQ9P1/V7ifP
 mwGP6e5gHJMws05Sg8yeMkQCu7UF3EdoDC/4hxTQhUuEkAsFWqhoWe9QlBJIIioSbfA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792222780;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=a+V535JDGToW5DtPUIHXcU7MeP/jRLPveTu8Dx95HEo=;
 b=Qhkf3H/leRiIGBeE40I3yISkXZbHo/NItzAAJyy2cVdiJJUf9Z+L9ie269otWJs7IxOI
 Q5NO+5h8lW3rKReo7MGdkAze5+VJ0748FFboISnv6vmXlUpYH7vTxaCxqLwMeokYzPTd7
 bJhdg102B+Qop7t4ndzrge/CZBX60bSbon97E0vD+AXIzOq/vlCryEXw9l4SgboAdN07c
 eJhgzJPzE/cmPdw0Ng8VphExY+IY5uYbl7FMMTXruy4PnG4PeT3ZK/zhGh122CopPCNFs
 y0/MyLmbTqDJKFbS0/1d4PYF0R37sp3YcBTp8lYfKi4Zy3vEwEnG0WyCgRSGzGdhTCg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=SbSUu3YM; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=SbSUu3YM
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CF89B6080C
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 07:39:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5294D435B6;
 Sat, 17 Oct 2026 07:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33834C2BD00;
 Sat, 17 Oct 2026 07:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792222778;
 bh=g9pFz3bpxBPczSiSSvad1eBu3ikCLEZAGcUmq0UCg4I=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=SbSUu3YMz7YyrzEJujbQK8epGHgBLPdPwFjoVHg87LHrt7B+ZzhHHjmZ0Qd0z/vfz
 1y91KQ+AF2MGQDvusWpyygTqA4cPL7YpuB9n7Zeoqw8CLCOEEHbMF8GTSXliVPu6P8
 Due9ASmJwUl97ZeWqdTjIOjYT7ezxmUwh2bg57wJD8EZsgPEBVJRltPknGReA+TSrf
 b9Brnp0gkk5Xs7aVblFBbGZy5wGCrIO16vy63acGfsTKZDQ8f4kYCvG8WGcRzjaarz
 Bg7Q80y+oQ0TMmclJk0XFdDuTyjKkXJio6c4v2ApPRHxtdIQX/bV2I5QFkOjmiZe6a
 nrAWDnz91EzPw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 2164DCCF2C3;
 Sat, 17 Oct 2026 07:39:38 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 17 Oct 2026 09:39:03 +0200
Subject: [PATCH v2 4/6] binman: test: Add tests for fit,compress
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-b4-binman-fit-fdt-compression-v2-4-d7e290847543@protonmail.com>
References: <20261017-b4-binman-fit-fdt-compression-v2-0-d7e290847543@protonmail.com>
In-Reply-To: <20261017-b4-binman-fit-fdt-compression-v2-0-d7e290847543@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>, 
 Alexey Charkov <alchark@flipper.net>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792222776; l=3140;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=6IPRRVuoewG+dDLGaql2qM+1Y8ADSTKQ9Qq9kD87Z9g=;
 b=me/eiuxWmJjcbflkZ+6Hp89xwM0tVV+7D3thZ4ahly8Tw9JUAfa5OCNdAB3Ssf0h/TlQdzQnp
 mzvCRGFYKkdCVcjwxlcMQW6Zykrf/Suw6u+d+W+DTFJbRBj7Kq5KzAH
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 17 Oct 2026 13:01:25 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

Check that generated fdt images are compressed and that 'compression'
is set from 'fit,compress', that an unknown algorithm is rejected and
that a missing compression tool is reported.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 tools/binman/ftest.py | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 8caf275d466..fdb22b0965f 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -4357,6 +4357,50 @@ class TestFunctional(unittest.TestCase):
         """Test an image with an FIT with multiple FDT images"""
         self.CheckFitFdt()
 
+    def _FitFdtCompress(self, fname):
+        entry_args = {'of-list': 'test-fdt1 test-fdt2'}
+        extra_indirs = [os.path.join(self._indir, TEST_FDT_SUBDIR)]
+        return self._DoReadFileDtb(fname, entry_args=entry_args,
+                                   extra_indirs=extra_indirs)[0]
+
+    def testFitFdtCompress(self):
+        """Test that fit,compress compresses generated fdt images"""
+        bintool = self.comp_bintools['lzma_alone']
+        self._CheckBintool(bintool)
+        data = self._FitFdtCompress('fit/fdt_compress.dts')
+        dtb = fdt.Fdt.FromData(data)
+        dtb.Scan()
+        for seq, expected in ((1, TEST_FDT1_DATA), (2, TEST_FDT2_DATA)):
+            fnode = dtb.GetNode('/images/fdt-%d' % seq)
+            self.assertEqual('lzma', fnode.props['compression'].value)
+            self.assertNotIn('fit,compress', fnode.props)
+            comp = fnode.props['data'].bytes
+            self.assertNotEqual(expected, comp)
+            self.assertEqual(expected, bintool.decompress(comp))
+
+    def testFitFdtCompressBad(self):
+        """Test an unsupported fdt compression algorithm"""
+        with self.assertRaises(ValueError) as e:
+            self._FitFdtCompress('fit/fdt_compress_bad.dts')
+        self.assertIn("Unknown algorithm 'bad'", str(e.exception))
+
+    def testFitFdtCompressXz(self):
+        """Test that xz is rejected as it is not a FIT compression"""
+        with self.assertRaises(ValueError) as e:
+            self._FitFdtCompress('fit/fdt_compress_xz.dts')
+        self.assertIn("fit,compress 'xz' is not a FIT compression",
+                      str(e.exception))
+
+    def testFitFdtCompressMissing(self):
+        """Test that a missing compression tool is an error"""
+        with self.assertRaises(ValueError) as e:
+            self._DoTestFile('fit/fdt_compress.dts', allow_missing=True,
+                             force_missing_bintools='lzma_alone',
+                             entry_args={'of-list': 'test-fdt1 test-fdt2'},
+                             extra_indirs=[os.path.join(self._indir,
+                                                        TEST_FDT_SUBDIR)])
+        self.assertIn("tool 'lzma_alone' is missing", str(e.exception))
+
     def testFitFdtMissingList(self):
         """Test handling of a missing 'of-list' entry arg"""
         with self.assertRaises(ValueError) as e:

-- 
2.55.0


