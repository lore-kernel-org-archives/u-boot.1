Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26F4C88E7B
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 21:33:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64F3980C0C;
	Mon, 14 Sep 2026 21:33:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8sQuBKFa3Lzd; Mon, 14 Sep 2026 21:33:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8587F806FF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789421619;
	b=eKERPeh+Zyd3Ykjr0xPV6Z32+OiHo4RUiHSRSnYho8fCzmW6ELEwnWkr35oX31eyh2cL
	 jW/1l2s5gZMDMaaNVqPChLbuQS5DJ/fe21m6y8sWAA4/vB+3tK/IyAdyKlu4Tz4URZmny
	 ugsUlfyC17Olb6zslV7MetUnUC2UGYwv+1qJ4uPNiqvsraAxSLU1Dow+IFQ2VEtrEhrQm
	 3HhqDD85Qy8DJxIWTgctWcAtaYSoGTe+86kOxyNRo5IHM65E5GdA5sI5huXzNGV1USlb0
	 woicSz0iWYL9PsmgIndGZuTM7RHJ2c7NpvxydBcSTfdVjSAFuDgy061SvNpjxZmkQKQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789421619;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nko5PKMmgVKuF5Xni5BSj6WukofxW9eJ750XjAXhB4A=;
	b=XYze2isalDY9DtwK+QJ5GJPFCZazZ42BlKE7aLuXmWALnAUAPM9pCj8rNmgIvsDMWiCR
	 sozI26S0sScgIQK0idWvqp2maCu9yDMQuxOUQGJRvYmTjWbK3DSEDs2a+tcfBxAAk2Ecf
	 PEGHTAlneiRl60Sxurb7k1/hLK9Avih7/5oi690LFI3spET1/fl0SuPTp9t+MEXFTw/f4
	 SMSmigSppHMKv6FVs8uE/XyMNFEA+80rEsOtWOlQDgsNtSnm93wNNLSQ2ESRiOwLZibKJ
	 JTZPC2QfZ8iHLFg5iSGYUQpUbIi+3e/8nHwhjYnQAcVBNsMTe7jTBPAzCvIAlTihmDA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789421619;
	bh=nko5PKMmgVKuF5Xni5BSj6WukofxW9eJ750XjAXhB4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zf66s0og1V5v5DYTH+lJIsOTizWR+gh83X77Rl+HoBedwg9fHicVwT5CSqURxXPBO
	 G7FMythJ2dP7no7ijMoZ4yybdMk/yRZmWb6vj/84K+ZHZLeUGBntMmhCP4Tg89F+7D
	 nvfn9jWEpRpzwPnzr4vtaTWZsNd7vOV0Ef6Y+nXfbXk55Y/RqEkLJoDjr5YEuWf01K
	 qPofj4Pi+YNbH/Qcgmulo08UAh0PTzo2uWq8k8vTZ5M62mRwO97gwZ05DePfzmQV7N
	 AYK5kPLsJtHFTaXK+N+Nd/RTFn2MTgqdCQOXk2Kup/a4e7HfKtSALu5LzxNgGP1LWh
	 3TqyrnUnHYeMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8587F806FF;
	Mon, 14 Sep 2026 21:33:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A641259
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 21:01:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8096B605E5
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 21:01:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z48Oak06zXGl for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 21:01:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AC8176061E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789419662;
 b=DZlpP25VPKI/VcUTTeNE6bQKCyCm6mnroeNH/PwiMoVeAdzC0b3KMCS76UnH1urz1nZA
 /RTVzc00bENtOApu+pudO9a6yI9SVMmLmrt7nbRoXpY5HvzbJrJY6C9cEhf+lBm4+ctkN
 fX0sArqcckapDtQSjp4TSQsh8+tvEXMFgJzFKht76guAtpVmTyZBSJIYP08bqFY08zAM2
 M1bL8KCle59hTjhsLUoMDxEzBDLoU+AwXHBnIvZh+sgkYSYeiZ3g7+Qaj8o+b/MeHaPET
 qf9kew5C9sSfe1Z4t6j1mC+c/yURaWbqkNZ6YPECBujJqkhsoE4gVcDND2DSINBw42g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789419662;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=nko5PKMmgVKuF5Xni5BSj6WukofxW9eJ750XjAXhB4A=;
 b=TVi65K9jd+6OaAe60vxeAM7kBZlqg3xD1QyWlwx6qim+f3XERdOaMkRvVTQ+6tkrDueG
 WoGtjvENt97/3kJNMvsbWDvrsoIoD5EqqI06kUSxbibwiDjEH7MsXn5BRzRAhqILtDxp/
 8g3ZO+G+xaXAkMFo7Rha8OA5HVicyE7kvAH7e/NHnVi2u3Hn050Ae3acHbgtP4bmwHPw7
 qU6z1ha2opVslD8xypE8KLKGz01dM7nOeQTBiGRsW3pJqkbxtklQmMXbcFX4zOddraTuk
 ImylYwiIUu7/JXpT0iurFNW5LB9IU3WT7DG9aayXcYNLG9VWX2bXwNH07gyVgoh+Z9g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=KDlxT7oE; 
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com;
 envelope-from=0xiviel@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=KDlxT7oE
Received: from mail-pz2-x10.google.com (mail-pz2-x10.google.com
 [IPv6:2607:f8b0:4864:3b::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AC8176061E
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 21:01:02 +0000 (UTC)
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-85469b35601so1287528b3a.3
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 14:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789419662; x=1790024462;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nko5PKMmgVKuF5Xni5BSj6WukofxW9eJ750XjAXhB4A=;
 b=KDlxT7oEbMHnvlSEzO8Vu9++Il0EW/VarR3PvvubsJFthocjeJ0RjB246iLtPMnkcV
 fZcIHPAQog7qUg3BwzaF1B2lq9TVRdhrqQ0rTYhd+7LNKjJfTTQ8tIF+3b1HLW16pc14
 wgMQJgVL90rluRURS+T/D3ALwpbYMSVD4ci+ZIz7ALrsc0maO3vitupzCc4nvh9SZzXT
 JmPSekztPTMOWroz1UuAhPc8toQ3oQ9kMw6TWGtbPcvI3S1AeO+1ukRGfjQ/+t9QHjy+
 M1hfhFI7pxOX4aUWLlgnoEnkGq9uf+oJaDKcIkNDaiqfx361cy6ZSqWdzqJgkLhhLgxT
 x0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789419662; x=1790024462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nko5PKMmgVKuF5Xni5BSj6WukofxW9eJ750XjAXhB4A=;
 b=auGZ5fpPP1Vp26Q7IHZpmpO+ILruZHQm3XH7PEMdzUpCNCqd+RBLN7oncTsyLK5H7M
 1vUcbJraiV1jTJTGEtzpXbzxJppmsZJ0ueJQP1rMyR+SN6pZMgWVeBGJxsKSBzdBcaHS
 l9JhMEgg1ZD0pyqFrHaMGXBQkdgXhTkEFhSY94bqYtl9fvUDfvuMEPFBMP1FLyj4Ltvs
 nWzLIEHb9Ms8sw3xIO4g+c1Oe54lm3l0GTJSZMOB7U4/DQILLg0pYd0ys2/rK81LJvZp
 MQ9uWi2ACKFNKG4R24O9AniHVhbyZjj6fkTt876XmqIe/U1sAozvAgvgB6jvOrm1hbHG
 j9LQ==
X-Gm-Message-State: AFuF++kSnsM1G1Djbqb1i6fyGT+z/ntvIftusZAiCKP2PUL3NMGVVM3q
 9+aXMO90AyX+v/Ys7YQ2QffKd7cMTFZs2s98AJWocMqpGVe9Oc3WtPvs
X-Gm-Gg: AYBFou1N9cwzlHlpiBYICkqDlIhasMJfohq0879UQs/ZONu/DJqqZA05ooGdO7PxcID
 epVu5hY2nwyG/qHBKatLfPaAXMv+PxnVIGYeIt1TjXjyfDoHck5KZt02hn2dazz4OPT6LCjVGb1
 Q407Yto/fzT7kJbM0psu/Xd+KRtiesREryUbxTng1/Rq8ZTe1KrAjxlfb+SvsvwC34UWhOYfIO4
 lqkqsVGBV/qZmZa1OXajd4Btspy1kStKYhf37WO3ihcACLGuuNEadB40lF2GJnBpL96SwgFZGL1
 pD0vVOuxcXdGEksLpwD5PsAqsUEe9otv2HmPZhbFSyANaf2SP+VztifpbZxhwIq+MHnhGSDQJlF
 P1ZdRaHDR9ZeTruaUhfJxzR9U/nJUB2U5tDTOS2B8TibH6b2BMVpg0Yh6aaC04pC1JbQuNU/WkH
 07KGVrSnjH1KMLhZj0g8APAKUd7E0mNI72uS97k7V2Hq7GlbVyRtCmoU6VMwyNxkeSVJVyDFLrH
 4lJ7r0OTouBRbNPaVg+erf36Wyveriwssa99vGCTOgnbVQcHZbm4z0dXz4gs9aIaRqARoGiT8qt
 stkC8Y9DXGV7nHokdXCgEw4WG0aMWc7AFAFTbvPeP5su
X-Received: by 2002:a05:6a00:22d4:b0:86c:b39b:66f1 with SMTP id
 d2e1a72fcca58-86f84d108d0mr8157576b3a.17.1789419661489; 
 Mon, 14 Sep 2026 14:01:01 -0700 (PDT)
Received: from 0xiviel.ip (122-63-135-80.mobile.spark.co.nz. [122.63.135.80])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b5674bc2dsm5263328b3a.59.2026.09.14.14.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 14:01:01 -0700 (PDT)
From: Eva Crystal <0xiviel@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org, sjg@chromium.org, daniel@makrotopia.org,
 jbx6244@gmail.com, ludwig.nussel@siemens.com, anton@binarly.io,
 jonas@kwiboo.se, Eva Crystal <0xiviel@gmail.com>
Subject: [PATCH v2 2/2] test: vboot: add coverage for a control FDT with no
 /signature node
Date: Tue, 15 Sep 2026 08:58:40 +1200
Message-ID: <20260914205840.360734-3-0xiviel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914205840.360734-1-0xiviel@gmail.com>
References: <20260914205840.360734-1-0xiviel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 21:33:29 +0000
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

Build a control devicetree with no "/signature" node and an unsigned
FIT, then check that the boot is refused when
CONFIG_FIT_REQUIRE_CONFIG_SIGS is enabled, and that the historical
fail-open behaviour with a quiet console is kept when it is not.

Signed-off-by: Eva Crystal <0xiviel@gmail.com>
---
 test/py/tests/test_vboot.py | 96 +++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index fd91b3f10a..a864a541f2 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -846,3 +846,99 @@ def test_fdt_add_pubkey(ubman, name, sha_algo, padding, sign_options, algo_arg):
     # keys created in test_vboot test
 
     test_add_pubkey(sha_algo, padding, sign_options)
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('fit_signature')
+@pytest.mark.requiredtool('dtc')
+@pytest.mark.requiredtool('fdtget')
+@pytest.mark.requiredtool('openssl')
+def test_vboot_no_sig_node(ubman):
+    """Test a control FDT which contains no /signature node.
+
+    Both required-signature gates in fit_image_verify_required_sigs() and
+    fit_config_verify_required_keys() look up the "/signature" node of the
+    U-Boot control devicetree. When that node is absent there are no keys
+    marked 'required', so nothing downstream can fail the image, and a FIT
+    whose signatures are absent or invalid verifies successfully.
+
+    With CONFIG_FIT_REQUIRE_CONFIG_SIGS the missing node is an error and the
+    boot must be refused. Without it the historical fail-open behaviour is
+    kept, so that boards using FIT_SIGNATURE only for image hash integrity
+    keep booting and keep a quiet console.
+
+    This works using sandbox only as it needs to control the device tree
+    used by U-Boot.
+    """
+    sha_algo = 'sha256'
+
+    def run_bootm(test_type, expect_string, boots):
+        """Run a 'bootm' command in U-Boot.
+
+        Args:
+            test_type: A string identifying the test type.
+            expect_string: A string which is expected in the output.
+            boots: True if the image is expected to boot, False if the boot
+                    is expected to be refused.
+        """
+        ubman.restart_uboot()
+        with ubman.log.section('Verified boot %s %s' % (sha_algo, test_type)):
+            output = ubman.run_command_list(
+                ['host load hostfs - 100 %s' % fit,
+                 'fdt addr 100',
+                 'bootm 100'])
+        assert expect_string in ''.join(output)
+        if boots:
+            assert 'sandbox: continuing, as we cannot run' in ''.join(output)
+        else:
+            assert ('sandbox: continuing, as we cannot run'
+                    not in ''.join(output))
+
+    tmpdir = os.path.join(ubman.config.result_dir, 'no-sig-node') + '/'
+    if not os.path.exists(tmpdir):
+        os.mkdir(tmpdir)
+    datadir = ubman.config.source_dir + '/test/py/tests/vboot/'
+    fit = '%stest.fit' % tmpdir
+    mkimage = ubman.config.build_dir + '/tools/mkimage'
+    dtc_args = '-I dts -O dtb -i %s' % tmpdir
+    dtb = '%ssandbox-u-boot.dtb' % tmpdir
+
+    bcfg = ubman.config.buildconfig
+    require_config_sigs = bcfg.get('config_fit_require_config_sigs', False)
+
+    # Create a kernel image filled with zeroes
+    with open('%stest-kernel.bin' % tmpdir, 'wb') as fd:
+        fd.write(500 * b'\0')
+
+    # We need to use our own device tree file. Remember to restore it
+    # afterwards.
+    old_dtb = ubman.config.dtb
+    try:
+        ubman.config.dtb = dtb
+
+        # Compile the control devicetree. sandbox-u-boot.dts holds no keys,
+        # and mkimage is deliberately not asked to add any, so the resulting
+        # blob has no /signature node at all.
+        dtc('sandbox-kernel.dts', ubman, dtc_args, datadir, tmpdir, dtb)
+        dtc('sandbox-u-boot.dts', ubman, dtc_args, datadir, tmpdir, dtb)
+
+        # Confirm the premise of the test: no /signature node is present.
+        out = utils.run_and_log(ubman, 'fdtget -l %s /' % dtb)
+        assert 'signature' not in out
+
+        # Build a FIT whose configuration signature has no 'value', i.e. it
+        # is unsigned.
+        ubman.log.action('%s: Test unsigned FIT with no keys in control FDT'
+                         % sha_algo)
+        make_fit('sign-configs-%s.its' % sha_algo, ubman, mkimage, dtc_args,
+                 datadir, fit)
+
+        if require_config_sigs:
+            run_bootm('no signature node', 'No signature node in control FDT',
+                      False)
+        else:
+            run_bootm('no signature node', 'Verifying Hash Integrity', True)
+    finally:
+        # Go back to the original U-Boot with the correct dtb.
+        ubman.config.dtb = old_dtb
+        ubman.restart_uboot()
-- 
2.53.0

