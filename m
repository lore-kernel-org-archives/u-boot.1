Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFEDCA600A
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 08:31:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F1AAD811BE;
	Thu,  8 Oct 2026 08:31:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Jtar8LLYuCm; Thu,  8 Oct 2026 08:31:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 392A9811AE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791448265;
	b=rWySsbtEm8nUcWjpPj8UHUmSzOeRArMS6ea9VDC8X5pABWlStbmocmCGEOH7DbM+Kb94
	 9IRtRrJPGar8tu5QFuQ0BHLsS8ET8y5wyPbuWhZyMLyI/AAfXXe5g0+2aKiOJSv3e0t3U
	 BmVDO6FvCxyVqS9vWqQaAMXUxYcd4jfeF6ZBbjq/nK+kgowk8f4OgV7Z2tCEu2/dSHGo7
	 0wec44wfu61G+PX6frOrqmdtdbCY6/xYd5+Ab6C6MeSl5ba1b03KnIckZBpSfRwsuOhqe
	 GvIOAKDrgP8OhfqBVsc3+OXchI6XLXmMRpQO0yKbhrCZAkwPmoOi03CyJ/kImDIXuog==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791448265;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=edFGPhhamYDENAQVW+GW8qA7UppEPZ6Am+1+ez+n/14=;
	b=bJuYGT0vrwki2h8zuyGkQyd810HHwLJZAnqV3y3daBmRWjgbxHCHC1q9MR8iMz2xXDgs
	 DadNVbRtr92gRhxKovxIsFta3RDOBZaa4qHaq590VqHPY+76ZZRqZ+rqnS9VK+OsC1C0t
	 Bev8FOmGJizgFZjJPt6vzuybUKvfa7AGRckRHDpxRvoZ1eScWoHLF8dmvp9FZcXXh1dS+
	 rXVCmyDvKv6elIHf9IJLGx0ymV9XCRRc4RDok5eIYCDB82XBcw04efMnb7XAfCGB7FmDy
	 56ZUfucwiVL1QKGN3YhFdMX9A2JiWAt9mzE17kAb4en8lVXvon6Uhm6tB1SJE69l9lw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791448265;
	bh=edFGPhhamYDENAQVW+GW8qA7UppEPZ6Am+1+ez+n/14=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dXlMzna1ikE1tZ4sPm9O5Sk7MFcWq7nNjWBFa+7og0IPqavSPT8kf87TJsXBGTm2o
	 bfp2bzlelH9VZjI+bfUJOKSmAfp/lItmAIsGrA+rnrrJcf3E1TbAzAVxQFj1dt97EH
	 5IGAa4u7dNWmcpm9dAO0gI1PM7cyf+WjdZ8D1yvwhMrMUhGpEtj3cFzfoFBdaMF2sw
	 kVOjEUvTG+wi3vynTtF3WiV3GMN6UMuLGmcQxrcPgG7E/QZxeXasg6Z9X/RrmcATHU
	 ptHegEzMi2g/nuetVOhFbKTvVMVeAJlkuhYdUVT24F60iAsMoR3iSE8Io4yItYFr5N
	 yxDHLdzjNJUlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 392A9811AE;
	Thu,  8 Oct 2026 08:31:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 28836338
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 08:31:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 19FBA60792
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 08:31:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h5KbdNllnswS for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 08:31:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3275F60659
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791448263;
 b=sP+PwdP94Vji9A1vjD7c1VtVNLnuDAt4ELr2qhqtJFmz+JQU6o2f9gkGgC9ehCO9xfBs
 HlgZtkO4unWa9tgS0mTqc6r43ug3LgXL54ES7xGEWOh+Pptk3B9uE5kaPVMZ7gJ16bNpI
 Ps2Zr+ScZfW3P77eLaSPmCIcrvD6UJcIkLb+pu9h3ouAGSpKc2uzs3AUN6kGtJADxYLXR
 lPGKwcolci8itXp7hIQEENg2Jt2O9mJfFTSmYYIf4Tc654Jcs6rmtVZoqEIQ8sEnAZ0yC
 XYp2PBqNP8FsA/c80Byy0LQXSHCrhCExRTHjnDU8d99eZTFOE/EGRAdIsyuNNIqnsGA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791448263;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=edFGPhhamYDENAQVW+GW8qA7UppEPZ6Am+1+ez+n/14=;
 b=aGlONXUyfBZ8sGNJ5PjMY+ViB7NR5xsRKcY/vZB2Ll+Z8v6T56P3bk+qZf78jjm+SAss
 zNIB4tkcDgm+lpNvYv4Qu2noIcU1jr8CVGIu9KCByqoe2bPlgd9nR2CD0s5v2SW8r1c59
 MfGIXJn2iJujIa0WLQ/Pnk1BOE+lF8H/5f7/9iEnpZJhPSBDmFWH5ku6HwZapuQlQyvRS
 usWdqIE8Xi0WwHECjgvvu37Qom44MDZoohOWZEl9HB1I41+PSwtiR559Te6cn7B03jRwX
 gh3iKsPjWdl82InDdtMCUmsZmk52uK9ADi4QF1yDheyG26KWx9xQt8efT7vIpejfhMA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ltSVOiDB; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mwalle@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ltSVOiDB
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3275F60659
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 08:31:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1B5C7602C5;
 Thu,  8 Oct 2026 08:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF0A1F000FF;
 Thu,  8 Oct 2026 08:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791448260;
 bh=edFGPhhamYDENAQVW+GW8qA7UppEPZ6Am+1+ez+n/14=;
 h=From:To:Cc:Subject:Date;
 b=ltSVOiDBNL6xU8Usimn0woAGjiZV6bXyq0djJetTH1IvALZU05N1E5i0xO9Ukzq2s
 IU7xfN2c4EeDIuhCRnv/feWSfosnuV3O9RY3u191XzDlYYNSCKoyNJ/8G1FCqvFm9s
 mwde/RH3DGmeG0kzjAy6OArpSQhTyEJ4dsrPsulGjVI4x/sOjjdUm46Vnqk20c+OsT
 Wc+kb4WZtfdPvvjTSMTvRyxdf2YGpjlUFqJSDexxJo9NyvHnnzNoBoAIV8zCQey3va
 wE1G1cwS51/vgYYrxr/Ta9SUqiVVuT2SJhonmqgsVbtzMh7tiJAtvbkOlH7AdkXqn9
 ChXBGE+z+PzMA==
From: Michael Walle <mwalle@kernel.org>
To: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Alice Guo <alice.guo@nxp.com>
Cc: Michael Walle <mwalle@kernel.org>,
	u-boot@lists.u-boot-project.org
Subject: [PATCH v5] binman: imx9image: respect BINMAN_INDIRS for external files
Date: Thu,  8 Oct 2026 10:28:45 +0200
Message-ID: <20261008083044.3622658-1-mwalle@kernel.org>
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
BINMAN_INDIRS. The append case only handles external files, thus we can
use that helper unconditionally.

While at it, update and extend the test case for this image format.
That is, first create the image in the input directory and then check if
there is actually an append command with that image name in the resulting
.cfgout file. To cover the not-found path also add a missing external
image.

Signed-off-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v5:
 - add a missing blob in the test dts, to cover the else branch in
   the test

v4:
 - reword commit message
 - update test case
 - (RESEND) to the new uboot mailing list address.

v3:
 - emit the command strings

v2:
 - forgot to add second lookup. add the same fix

 tools/binman/etype/nxp_imx9image.py    | 22 ++++++++++++----------
 tools/binman/ftest.py                  |  9 ++++++---
 tools/binman/test/vendor/nxp_imx95.dts |  1 +
 3 files changed, 19 insertions(+), 13 deletions(-)

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
diff --git a/tools/binman/test/vendor/nxp_imx95.dts b/tools/binman/test/vendor/nxp_imx95.dts
index 3fc2de44b4a..36495792282 100644
--- a/tools/binman/test/vendor/nxp_imx95.dts
+++ b/tools/binman/test/vendor/nxp_imx95.dts
@@ -20,6 +20,7 @@
 			container;
 			image0 = "a55", "bl31.bin", "0x8a200000";
 			image1 = "a55", "image.bin", "0x90200000";
+			image2 = "m33", "m33_image.bin", "0x1ffc0000";
 		};
 	};
 };
-- 
2.47.3

