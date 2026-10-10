Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA608CA9EC0
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 19:10:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8791640994;
	Sat, 10 Oct 2026 19:10:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xz9zNVfZa_M2; Sat, 10 Oct 2026 19:10:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7C1A14095B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791659408;
	b=QqLWLAkCUwL7RLOPJi7mBtEB+F/modyGuF5B7Y6j2abYihcmUTdsnTQA5MdjSwt+ti0Z
	 tI3ZWO5bZcZ08SaeBXbACpLTZy5iNtRESZSiJ/V0LNKxUYeozvho4X82vHW+fFCmWCmDV
	 yEoIwm+J244gRf/aKgEvGuaVOcVZahavcSyrnhAycSiIPl1e+o3VwiarFeNGD4wfteERd
	 DgqiZJHPIhDE6uEVS4A7xrWA2GfNz1v/cY/zOaCw3O4fXehUkHtYCmU55sOyh0UT+KaTQ
	 XGoEyxL0g1lkP+ueKQpVTdeDQl+V6JuhjVQvW75Z94NwS42/OpQlcQhHORiKLl0YIwQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791659408;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=shp0NZX1LOC3/pTg6rP6PdtVAZbnM/kELGrb3ienyDo=;
	b=SojALf+C/BxocmoPhaHfD3C+wJjZw12uKXhRh6UfiJ89RdIpwVgXiTunN++oRDXsfxdh
	 zOEI8Tf/ryslXWW92E+hxeM5u3lydcMMivOKXcIkUOjp7HkMkljmHNiBEwLHQesiMkhO2
	 T95YhSiuj8qkxqL62qEX+oQYdSZ48VmTmwkeOh6U+ZrmnZoT7c0VREu6yfV3lDBlS07C5
	 Z8NHro+r2uayly597VF64C9HM2HR/GqJGS+uLkEkH/RBVYIf3ypgwlN3dmp7YpeUQHX7E
	 dvUpFMLstZLV6RusVDzXGkcL6/+31EAHNFB9VxL2ugRd95VDY3dzdjn7TqSr8E+DQpw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=J03XhoHk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791659408;
	bh=shp0NZX1LOC3/pTg6rP6PdtVAZbnM/kELGrb3ienyDo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=aVhOU7HrHMJjJ1C0T8zITtw+IrUK8sUDE7BM0sL+u/696njm2+4A+LJE2XM8TuzOS
	 hxrzNW0BqlC5ZRg9Vu+68XFZn07GGjnlXC05XfHOo4uHSmicuYtH4R/jF9GoH51eWP
	 v0sLd23YoxzPjtOiY8icl39QetLLg51V5TYA/adOEnsoS7yIA0YEu5PNzRjYBevLuK
	 ueUukXXxBsbJ6dsjhmknrhAivlkxS1J34LkqN6nyAfTPYHuy73Qzvht6DocLHCb7li
	 Lg0rSoyMzaKB1ByGt0+cdZon8DZHACHcugmp9KC1P2F6N09wY9PRMBU5sHDgrU6hQ4
	 Hy4tj+4hqblDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C1A14095B;
	Sat, 10 Oct 2026 19:10:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BA3F21A6
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 14:24:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC685408D3
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 14:24:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iibp29857Og5 for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 14:24:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DFE694087B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791642295;
 b=JH7sC7FFmAyM2F2R6BwF7DPBg6DadNIK0OzqWZ/C5B8e2HHxs7LlH2+ZabzujFXtm3Hj
 f5igu/7RnYPFXjaWWq7Qyu9vPTKO0RnZ/nf8goLEYbQceGAunGDK6Ml8kMDdKgQaBVIoi
 Ti6zwh1M9hoVygkt0DO43tlnV1M5c1Gz8eC5a5EH0HD/Vq/Jbf6K1iR1sogS1f3AVfK+y
 mxc+YStMJ4be/8B43X+Cgj8OVDFxDUPNE0prJUfxndiP7MonIL9pc/CRKVoqq+iHxG3dr
 tce5TW3XjDtQJjzh++Mxn5wkdMPjoWuOmnzQKv9JmkWOQ6x2nOn6YohdOfmMq7oxUGQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791642295;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=shp0NZX1LOC3/pTg6rP6PdtVAZbnM/kELGrb3ienyDo=;
 b=ey9d89DsXOHYJd/A76/ZnCpcEnTfI29vceC/wfbATUCn5xSTJQWakge43gclQHYoUhwm
 3obPTsZSncap1k5cTaA/IGyz92VQpWutOf8ZeJrP7BYoS5zfmFfkD6oGc4MxBTYmVN6NS
 WmT1wSdPfqmp6zIde7S5MLJtRmLk3eSHh/Jeo8IowZqNqM8LNpMNghiVi6ID3K774Bldx
 jPkpcCwBGd5MHgbQE6EyJoRKkdGSLLxR9jC922da8XwhS4E8eb4e60qwZbCf9sPu17inR
 9BUoqK1jIbs6fgVB68hl6SmHPr2MyONMM8233NjmGQKNnpmJI/sEXbbZZ1bSy4h5/dQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=J03XhoHk; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=J03XhoHk
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DFE694087B
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 14:24:54 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 05BB460202;
 Sat, 10 Oct 2026 14:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B01A3C2BCFB;
 Sat, 10 Oct 2026 14:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791642292;
 bh=yMcZN/5VFW1BRdhIhHbJM0VUxnsxMkCczIGV3oY0NB4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=J03XhoHkbwhPPaGFpE1rgdXkJQ/fq02wBN8DI5qeNoK4Xr0d631qT2l3BRRAT7E2k
 1X1RnfJiBiCPhjwMYdrZLkeGFAJASTL1KyLLJegqwt7w2VlbPnIDCcwnGreIHj1zc7
 +E4BLBdlzfx04lR4u7C1xXRnSkM71CwaoWFWwOcOz2Nc3o5Paz+nJJBba/qBcF7bOl
 /dn2sCCHwItH2OGtwV1Oc1hnYUbLrQuFU6W2gtSAXX8VgHWUBI3LThfcrg23B2YI1b
 m7gBbdOBCh8AtCuPeDtM+Q3erEpMUklBsoxDjEao74/Tsy4Dbyg/MY/+SFloXBmQXs
 9eFsWFZhUtn2g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 97CF5CA9EBE;
 Sat, 10 Oct 2026 14:24:52 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 10 Oct 2026 16:24:47 +0200
Subject: [PATCH 3/4] binman: test: Check compression of generated fit fdt
 images
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-b4-binman-fit-fdt-compression-v1-3-4465558758cc@protonmail.com>
References: <20261010-b4-binman-fit-fdt-compression-v1-0-4465558758cc@protonmail.com>
In-Reply-To: <20261010-b4-binman-fit-fdt-compression-v1-0-4465558758cc@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791642291; l=2355;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=5uoc82yqjzMue5G0o5xpNb6IgLiTO164mNPRh9g5zeM=;
 b=KyI/u3jzbRSxYnEbc3LMCb1CpnoH3wheqzQ9La/u2aeHO69OahQP3lvhaNvARYGHg6MFAEhU+
 AaIam2IXGpXBXM+laa7Zfi+4O6Jimg18I8V33Sx8wparWp4722Qd4Ff
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 10 Oct 2026 19:09:53 +0000
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

Add testFitFdtCompressed, which builds a FIT with lzma-compressed fdt
images and checks that each embedded image.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 tools/binman/ftest.py | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index bf98b268ac1..587400ff308 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -4349,6 +4349,35 @@ class TestFunctional(unittest.TestCase):
         """Test an image with an FIT with multiple FDT images"""
         self.CheckFitFdt()
 
+    def testFitFdtCompressed(self):
+        """Test that fdt images are really compressed when asked"""
+        bintool = self.comp_bintools['lzma_alone']
+        self._CheckBintool(bintool)
+        entry_args = {'of-list': 'test-fdt1 test-fdt2',
+                      'default-dt': 'test-fdt2'}
+        extra_indirs = [os.path.join(self._indir, TEST_FDT_SUBDIR)]
+        data = self._DoReadFileDtb('fit/fdt_lzma.dts', entry_args=entry_args,
+                                   extra_indirs=extra_indirs)[0]
+        fit_data = data[len(U_BOOT_DATA):-len(U_BOOT_NODTB_DATA)]
+        dtb = fdt.Fdt.FromData(fit_data)
+        dtb.Scan()
+        for seq, expected in ((1, TEST_FDT1_DATA), (2, TEST_FDT2_DATA)):
+            fnode = dtb.GetNode('/images/fdt-%d' % seq)
+            self.assertEqual('lzma', fnode.props['compression'].value)
+            comp = fnode.props['data'].bytes
+            self.assertNotEqual(expected, comp)
+            self.assertEqual(expected, bintool.decompress(comp))
+
+    def testFitFdtBadCompression(self):
+        """Test an unsupported fdt compression algorithm"""
+        entry_args = {'of-list': 'test-fdt1 test-fdt2',
+                      'default-dt': 'test-fdt2'}
+        extra_indirs = [os.path.join(self._indir, TEST_FDT_SUBDIR)]
+        with self.assertRaises(ValueError) as e:
+            self._DoReadFileDtb('fit/fdt_bad_comp.dts', entry_args=entry_args,
+                                extra_indirs=extra_indirs)
+        self.assertIn("Unsupported fdt compression 'bzip2'", str(e.exception))
+
     def testFitFdtMissingList(self):
         """Test handling of a missing 'of-list' entry arg"""
         with self.assertRaises(ValueError) as e:

-- 
2.55.0


