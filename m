Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9470ECA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 12:53:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E07260852;
	Tue, 29 Sep 2026 12:53:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RVw-ICci42yK; Tue, 29 Sep 2026 12:53:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org ED773607EB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790686395;
	b=eQSXBBGikIBeac7pXZZmcgz9Do2tv/mjCOOPaV/l1LNehmyj0AerFrC/HD2+sMT++1rN
	 agiEVCWs4ikL6VLT4YiJqOCbohkEaAO1/JGZSTeJpSd/KVEL5TcBreuCgURuKWkyUaIsn
	 l0sqlYXUevoyWUA3p7Mu7T3v7nNF5veED6KGk/RqK9Ud7PfLZn4gnMh6mp6fJDkRCWY6P
	 6KXwfF0jCCdcaCKsBajAysPjTdJZi4aOdvmVYRqsfGOL53f1LpV0/1FmYCTDfJyiJNkxh
	 q0Ow+k9XISEilQkIqieW51F7oiaTxI5cxrkhc6ZFtEZy5wMwRmViz9otFGVcGWwE+MA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790686395;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nQJhDMDyrmDxrYd419fN2B+cTagaTOP++9NVlHlX0J0=;
	b=WUbXqrw8YD1b6Lp4XiN592EyYIy3YAyshDPwCZWCwbV9M20AOl3LmhZYMJBCJ3fifYLW
	 de/RU+lL2S282fFIGVjMyVJTaU5mZWeQ7DEqPTmgtq3NyKlC3nwCrdEl95as1CuNfNwsF
	 gW3HbqdOarUKGBVtYJ0FdtxOIhIrwXuVv4UYE8f7tFOdJixIfNP1oTRmCchTz3v9pxrxO
	 mRkw3HsVN+aObXDGs6AikxS8T9nGCfPLX/awNeqUZ60Mp6tdnR/VsIs89ta/376LTaYgn
	 PiOBevLZM9dJZhmz+EZPBXjZ7fSFlWt2v5L4frQyUwtxrEtLHka+iwtpxzpltQeXI8g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790686395;
	bh=nQJhDMDyrmDxrYd419fN2B+cTagaTOP++9NVlHlX0J0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rgc4BYhJOcmErn5qARghMD9jId4fPL/eubN35Lx8BvO8Fl4zPXF8tE50naGZLMvKN
	 fERj8lwXYocjjEGzrTgUv9a8SRLdkLs1E0lsZMUDZDBaSlaYF4ULCBX3JXmo0va/Sw
	 3dl74Of1PbdAPKo2BIFXv3oqEMj4ejILZ3JguGKngId/odjAUOITTLIbPsLTEv5uHp
	 VdV0xH0VNXAp4qnpWII1g2PfJgTXIMTzHkudsqLLan3QXOVM6Xe6qNZdwgbRB21Zhy
	 s73KeXcQfJ6KTbhl9xB0tHV2RU8LQYMaXW1Hc0SWaeTSzI5Hx/PEKTDL/xTBeWIL7p
	 NLfliu8wS+6mw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED773607EB;
	Tue, 29 Sep 2026 12:53:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 526F52E5
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:52:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2ED9C40714
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:52:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Jhts3VUqcak for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 12:52:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 266CC40703
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790686336;
 b=BljSsXeMu2F7fegv3TONggzyz4caz1Q+GGtLuMjYTmEU8xHu9xstmnd/d6oYMDuGw+0Y
 iI6v/t2j8RYZaeW5OF2E5RZcFC9a0ZAp2acfVMvx+XXBsMqZZTMLOjmtBdXtNkV3BPVf9
 voS/MNXjxzUe5oqit+R1V88O3p3SqkUvZNM5sJ5ZhdmxpBGk+aNYaPvH8p5kavzpMkGo0
 aQZm6o9BRsS1PDasVQCG3/Hr332b1GfA/CSP3KoSiz57YACgWmANjzwOJviB3iraeqiaH
 9gvbUlvOOs3Rpheg5XFMvic1R9XYTLXrRs0ft8KOhrEeMSay4n+DwIHrWzx1z0bXI/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790686336;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=nQJhDMDyrmDxrYd419fN2B+cTagaTOP++9NVlHlX0J0=;
 b=oIl/IkfLnOK5qqGJYUOeQ9JEFU5YcJZTYj456+a+cCZIG3udFqK8amz9t0CeXEwaAhzf
 oeuTsEk+U+uKo4KlWKQo/IQLcicnHqX0v2GofLhmxjFw1Ba1m/17t+ok08xKx7UqZh/3G
 x992YwQgPPCnm6ARGl8KZE5WH31SiPHol/Ag/IT7TIbQikSL1N3yK1BVMhtiufhyqOqXy
 wlrGV9wVk7xjrgAGNCrEFfE8GVtfl7FoFOwevxlyus0A9jMEDiYY7g/cJEkkKbdMjrJAm
 lcg+GvreQ1V4pwUpQpq0uzakK4hHmCd1a2Vvhms55IbFSZvhkS/2WioF6o7isb8OigQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=KEdWUaRY; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mwalle@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=KEdWUaRY
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 266CC40703
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:52:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EEB4E600E2;
 Tue, 29 Sep 2026 12:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599A41F000FF;
 Tue, 29 Sep 2026 12:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790686332;
 bh=nQJhDMDyrmDxrYd419fN2B+cTagaTOP++9NVlHlX0J0=;
 h=From:To:Cc:Subject:Date;
 b=KEdWUaRYeWW//p/iS3wKSpZ/I2H/IDrc2AF3w8O6yEyjn3BV4UM9b7WpBg8jdyK7e
 Ha9jIPRJfshYxTdk2sM+QlK4i1f91ZEUapnycZKR482p0R1EM729y+QiJa1aURfgs6
 o2h/GR9IvNfuzlga18CzMYLXyIzKTXTQygmXw/MT0CvFGgFPWfwp6BwvAMtg3Oj82k
 zVh1WydGCrfb3ToI54Z+OTv0TzHcfhbyaiUZxN/nP/Ux/brM13JM8XhiI3BGXnliIb
 G4M8VgCrVJM9ZLUonqR9TqcNBrUewHw/dtbYb/JiBtGypc51slWfR9GSTdRRWnoUeb
 r1xWeWN1a7+pw==
From: Michael Walle <mwalle@kernel.org>
To: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Alice Guo <alice.guo@nxp.com>
Cc: Michael Walle <mwalle@kernel.org>,
	u-boot@lists.u-boot-project.org
Subject: [PATCH RESEND v4] binman: imx9image: respect BINMAN_INDIRS for
 external files
Date: Tue, 29 Sep 2026 14:51:05 +0200
Message-ID: <20260929125203.592014-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

We have the BINMAN_INDIRS for any external binaries, so they don't have
to be copied into the source/build directory of u-boot. This is
especially important for image builders like buildroot.

Use the get_input_filename() helper which will also look up the paths in
BINMAN_INDIRS. The append case only handle external files, thus we can
use that helper unconditionally.

While at it, update and extend the test case for this image format.
That is, first create the image in the input directory and then check if
there is actually an append comand with that image name in the resulting
.cfgout file.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
v4:
 - reword commit message
 - update test case
 - (RESEND) to the new uboot mailing list address.

v3:
 - emit the command strings

v2:
 - forgot to add second lookup. add the same fix

 tools/binman/etype/nxp_imx9image.py | 22 ++++++++++++----------
 tools/binman/ftest.py               |  9 ++++++---
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/tools/binman/etype/nxp_imx9image.py b/tools/binman/etype/nxp_imx9image.py
index e0e806f2b7f..1a1465d7e7b 100644
--- a/tools/binman/etype/nxp_imx9image.py
+++ b/tools/binman/etype/nxp_imx9image.py
@@ -50,21 +50,23 @@ class Entry_nxp_imx9image(Entry_mkimage):
 
                 if key.startswith('image') and isinstance(value, list) and len(value) == 3:
                     file = value[1]
-                    image_path = os.path.join(tools.get_output_dir(), value[1])
-                    value[1] = image_path
-                    combined = ' '.join(map(str, value))
-
-                    if file in external_files and not os.path.exists(value[1]):
-                        print(f"file '{image_path}' does not exist. flash.bin may be not-functional.")
+                    if file in external_files:
+                        value[1] = tools.get_input_filename(file, allow_missing=True)
+                        if not value[1]:
+                            print(f"file '{file}' does not exist. flash.bin may be not-functional.")
+                            continue
                     else:
-                        f.write(f'image {combined}\n')
+                        value[1] = os.path.join(tools.get_output_dir(), file)
+
+                    combined = ' '.join(map(str, value))
+                    f.write(f'image {combined}\n')
                 elif isinstance(value, str):
                     if key.startswith('append'):
-                        file_path = os.path.join(tools.get_output_dir(), value)
-                        if os.path.exists(file_path):
+                        file_path = tools.get_input_filename(value, allow_missing=True)
+                        if file_path:
                             f.write(f'append {file_path}\n')
                         else:
-                            print(f"file '{file_path}' does not exist. flash.bin may be not-functional.")
+                            print(f"file '{value}' does not exist. flash.bin may be not-functional.")
                     else:
                         f.write(f'{formatted_key} {value}\n')
                 elif isinstance(value, bool):
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index bf98b268ac1..48c5a08b4eb 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -8126,12 +8126,15 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         image_path = os.path.join(testdir, 'image.bin')
         with open(image_path, 'w') as f:
             pass
-        container_path = os.path.join(testdir, 'mx95b0-ahab-container.img')
-        with open(container_path, 'w') as f:
-            f.write(bytes([0x87]).decode('latin1') * 32768)
+        self._MakeInputFile('mx95b0-ahab-container.img', bytes([0x87] * 32768))
         with terminal.capture():
             self._DoTestFile('vendor/nxp_imx95.dts', output_dir=testdir)
 
+        fname = tools.get_output_filename('u-boot-container.cfgout')
+        with open(fname, 'r') as fd:
+            data = fd.read()
+            self.assertRegex(data, "append .*/mx95b0-ahab-container.img\n")
+
     def testFitSignSimple(self):
         """Test that image with FIT and signature nodes can be signed"""
         if not elf.ELF_TOOLS:
-- 
2.47.3

