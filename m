Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1B9CC6B3D
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 13:55:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 313ED8127F;
	Thu, 15 Oct 2026 13:55:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ytJOXh6FOiVq; Thu, 15 Oct 2026 13:55:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 304EA8125D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792072539;
	b=m9z35A2cf2g2ikfd1R9o5M2MHhmI3k2LEEWEofy9HNilTyd7NqsJLLpfdzDhpcD3RaxB
	 1H1CDxh1JUQHWMOfUkzL+Esdnu9xeg8IgYPBFxyFB/htpenri5LOFkZjtRM1GMrpIXfQT
	 W5bU9BDgN1Tx/AjAZcKzM8iFM+q5Jqgq+hFOxkJi0HDJkPJQnJkrJvUseH20Mew/+iw4U
	 xoYd99l8GUkHNQaCfZV/Itsszoa6Vjp3Ww6YDDlvs+gpQdXYKTiCZVuI7h4T6ctQwsZIb
	 21fIdEXqt/qO/nVGdbyclg0OKh6n3Zu1ZtEPA8hfQNaBbRjp0bQ2BWl30st729van5A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792072539;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mwblZVX9InkSJ5N8qrXv4bvBoV46bQncKlnXsJoPkJg=;
	b=KppcpQ+nFfQJBjUwkQeJt41M9g5988+8/kLE7I0D6ssMfw2RVHzfY6ne8P+dFtxIPqvr
	 PQ2Q8Z17htbk3MHN2DIrRpHN44OVBaKLo20JpYw4FwBvhhixmy6i6idFYjPb7+1Sxv/f6
	 GLdVXTM9Yq+1LBj8ImzXTk+yn7IF3Z3pj13w3ZwX3UUfyS+o76AAswKuLLZtgVuUPu+K0
	 LGKu81qLEYboQEMcHYKq7DZZg4KEZWscb9TgoH72zWYCyLU/hScQp/frkzq4oB+5A8T8u
	 EdHg3DQtO4G0i1DcLp2SeZUScTm/jqZitGrsZCMwxFcdONUmL+ddPFpxU2rGpZ/cDlQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792072539;
	bh=mwblZVX9InkSJ5N8qrXv4bvBoV46bQncKlnXsJoPkJg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LxoOX7l+ZAp01GKfQIxXjwwDoVX3lYdFnsGfnji2filrhElXE348zWDBsQmjelTgq
	 tB18vgqw0MpYlp45ooRLv50fQQXJrdqxl3PO1csamPt9AejhQXxdr6T1cihnrTw4AR
	 JwYBkRNuzFL5Ycd9o5Zv3jkM9l3Ef5Id89txquLQwuuRc1NO1JGJV75iwH7Tbi4vdX
	 dGAey6mCLpmQR8+WpMfb7dbOmU+22H+Uy4y5WTT09reCxtDd8+LQ4XmvprEVhWiUXE
	 IFqEfneUZRVFBg8TLtTsGWLRLuiR0ov8Zzk/NOP50bB0Q/lXRjiqnIgwZTwp+BtTVj
	 K/uyOtoi7s5jQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 304EA8125D;
	Thu, 15 Oct 2026 13:55:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A4DD235
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0C311403B0
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fOEDhEEK1bh4 for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 13:55:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C58EE40098
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792072537;
 b=NANOlK/nKo40elGSHp4fQWqigqTa9r4h+9hD0cPCpboCrI0yNoJNAefWMGOMFed6G5Wc
 9LUcv9d1zQGV42+OWhpRf5khrQ7UnqK1KTgGQwK348WZrH9lmUqnvXbqhMy/hUleyvvGD
 tFgu376qjxQolk2mmIunt3hXVgb4S5iyqb03SwTwgcu+nilfEMT63KAIOvz1+d04xZAZL
 vcDBY9XUUDYgE/QBkYo66M5ivXz+f/OuT52JfXCmQRN1PtzkNu/AgHHxMsQwmDvbz2Mme
 b9bH656S8xLheoz/ZeoyJJYWz3qm0iTJ1aQ9pGzLwf2DY9T4c7LOgWZIvjuGvXvvR/A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792072537;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=mwblZVX9InkSJ5N8qrXv4bvBoV46bQncKlnXsJoPkJg=;
 b=IU8YcVzeCbgaCtZCfeWidz+dZoI/CbIcND5XE7XUqgtMn2/gjZhBIW0wUQfOld03ddGR
 32ldAGoQXGi7OrBqkwZajJqQKOJlaEhdOO0nFKLtdFU8QDywbvOjvbn7pCuOskTN+COsW
 Ol6549a3p4ZR+zvuCV7wc4I3Kh2gMNuw+CXWL97js9HOLhBoUvuIM+Ga/aYG1Gk0EvGlC
 vIDsG+Vj3lGq21qHw4+4dKxXLcI3CIUneVJV3gTOmwgioh4QIb0GY5KbEH7430BzMFkP4
 dwKs9ZA88IFz6DrB7LCT6xo51t2wIqhYfMNn2wOfXAKKseM5r6SVT+tcdk3+eCI69cw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hpFhirRA; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=hpFhirRA
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C58EE40098
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 74C1E60200;
 Thu, 15 Oct 2026 13:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD78A1F000C4;
 Thu, 15 Oct 2026 13:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792072535;
 bh=mwblZVX9InkSJ5N8qrXv4bvBoV46bQncKlnXsJoPkJg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=hpFhirRA8b3olHNeFvJppeU7MtNR3i4vurHK14UJGXQNDYDzlmZ9jztge5u+1tqHa
 w+ssk2kXWXAXrXN/VgjNPy5t29pJADLlyndd6/6q7AdHJKYRraNfbDiGw/0SYFPYIa
 Vivvn3bWmvCwILBQK6EXAvO9F7opmwG7x+YLSpnsYhsepzgqGCxiddZRSZceGcqsQH
 5UjPcSSUb4XZrgwwIdgLLyiEc3dUv2r2m/oekKpc7RjgruC6aCyNXU98RHBaHmSDWG
 uGrbGCGeaQ1Zyw/XFFI6tE3yBTdSbanrD+b9g1JK8fXvv4HXy1Bdw08zwEgRXWihfo
 32M9Ob0IHxinQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Thu, 15 Oct 2026 15:54:59 +0200
Subject: [PATCH 09/10] test/py: avb: Add sandbox AVB testing with dedicated
 mmc12 device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-test-avb-fixes-v1-9-9e5b82644359@kernel.org>
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
In-Reply-To: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9719;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=RfEPK+siuZKcTGg5mCfi+Khgrp+g/RV87TnXOjF3uCQ=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq0Ns/1pHSMI1yUpyQDynyNRY/nPdrVvzSFFQQ3
 JPiXJuI9r+JATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCatDbPwAKCRAZDR20Zk4Z
 NSyuCADoUt3EPe/oH0Z4ye+BTfUZRYCJEaRX5yuClEswVXuy4lbLBy6cfNrrnyKV/F532SLQRyF
 AEvJhdQYcV8bHcRQwv0DdMYzshdmVaQVDF8mjxmrw8ysV+AwBilAKSxWFWNpCEeFal0RqQWJd1+
 RpX9MaHODbIQQvIpchr/pqGOKKuJWvmigEH/L0Cm9aGdBb6MjLd4IH3dXsKMQgEuYXDJyjGEjEn
 geP1MsyzivQ0Bhc28wLoVBtWt5hu7Qa0i0QE1avWGQ7sOME0j0oRXPwqvuxStCu7dAyuqL2F4Mf
 gh0ZOvaaVzNCUppaeYrV6QViB+69HCwJioiW/YB9+WQgUvKY
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
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

Right now, sandbox runs the AVB tests using mmc1.img, which contains a
fedora image.
This does not really make sense. We should test on an mmc device which
has a proper vbmeta partition instead.

Add a new mmc12 in sandbox which contains all required partitions for
proper AVB testing.
Use the mmc12 device in the avb tests only when running in sandbox.
The mmc12 DT node gets enabled by the avb_device_id fixture if CMD_BIND
is available.

Note: the vbmeta.img has been generated using:

    $ ./avbtool.py add_hash_footer \
                   --image boot.img \
                   --partition_name boot \
                   --partition_size 4194304

    $ ./avbtool.py make_vbmeta_image \
                   --key test/data/testkey_rsa4096.pem \
                   --algorithm SHA256_RSA4096 \
                   --include_descriptors_from_image boot.img \
                   --padding_size 4096 --flags 1 \
                   --output vbmeta.img

     $ gzip -9 vbmeta.img
     $ xxd -p vbmeta.img.gz > vbmeta.img.gz.hex

Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 arch/sandbox/dts/test.dts                   |  8 +++
 test/py/tests/test_android/android_image.py | 15 ++++++
 test/py/tests/test_android/test_abootimg.py | 77 +++++++++++++++++++++++++++++
 test/py/tests/test_android/test_avb.py      | 20 ++++++++
 4 files changed, 120 insertions(+)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 25c99ef81472..80f505083cd9 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -50,6 +50,7 @@
 		mmc9 = "/mmc9";
 		mmc10 = "/mmc10";
 		mmc11 = "/mmc11";
+		mmc12 = "/mmc12";
 		pci0 = &pci0;
 		pci1 = &pci1;
 		pci2 = &pci2;
@@ -1398,6 +1399,13 @@
 		filename = "mmc11.img";
 	};
 
+	/* This is used for Android AVB tests */
+	mmc12 {
+		status = "disabled";
+		compatible = "sandbox,mmc";
+		filename = "mmc12.img";
+	};
+
 	pch {
 		compatible = "sandbox,pch";
 	};
diff --git a/test/py/tests/test_android/android_image.py b/test/py/tests/test_android/android_image.py
index abdc6cd28744..72725ac9044c 100644
--- a/test/py/tests/test_android/android_image.py
+++ b/test/py/tests/test_android/android_image.py
@@ -83,7 +83,22 @@ def setup_android_v2_image(ubman):
     ]
     create_gpt_image(ubman, 8, required_parts, images)
 
+def setup_android_avb_image(ubman):
+    """Create mmc12.img: boot image v2 with vbmeta.img."""
+
+    required_parts = [
+        {'num': 1, 'label':'boot', 'size': '4M'},
+        {'num': 2, 'label':'system', 'size': '4M'},
+        {'num': 3, 'label':'vbmeta', 'size': '4M'},
+    ]
+    images = [
+        (1, 'boot.img', test_abootimg.img_hex),
+        (3, 'vbmeta.img', test_abootimg.vbmeta_img_hex),
+    ]
+    create_gpt_image(ubman, 12, required_parts, images)
+
 def setup_android_image(ubman):
     """Create disk images with Android partitions."""
     setup_android_v4_image(ubman)
     setup_android_v2_image(ubman)
+    setup_android_avb_image(ubman)
diff --git a/test/py/tests/test_android/test_abootimg.py b/test/py/tests/test_android/test_abootimg.py
index ff54a8318a12..a54e09bb09ba 100644
--- a/test/py/tests/test_android/test_abootimg.py
+++ b/test/py/tests/test_android/test_abootimg.py
@@ -49,6 +49,18 @@ using the same steps above :
                 --pagesize 4096  --vendor_ramdisk ./ramdisk.img \
                 --header_version 4 --vendor_boot ./vboot.img \
 
+3- vbmeta.img
+    $ ./avbtool.py add_hash_footer \
+                   --image boot.img \
+                   --partition_name boot \
+                   --partition_size 4194304
+
+    $ ./avbtool.py make_vbmeta_image \
+                   --key test/data/testkey_rsa4096.pem \
+                   --algorithm SHA256_RSA4096 \
+                   --include_descriptors_from_image boot.img \
+                   --padding_size 4096 --flags 1 \
+                   --output vbmeta.img
 """
 
 # boot.img.gz hex dump
@@ -81,6 +93,71 @@ fae68747835d6dec42bc0df6d74d1fc5a0bfac6e89331797b9564926663a
 000080fa912fcae854c55adbeb2769d4ab34c9ad4d16963f010000000000
 a88d2fb468951800500000"""
 
+vbmeta_img_hex = """
+1f8b0808f36fcf6a020376626d6574612e696d6700edd369301bea1a07f0
+7062dfb758521a55b4b650722807572d41ab2d5a6a4b90a225b64aad69c5
+d67063b968a9725b91632bb12fb11faa45c4762c8928557b7a6c557b0fee
+ccd9e69e993b77eecc9db91feef87df9bfcfbcf3cefbe5f99b385cd10400
+006c803fb0ffe5d7e4f86500fc19e4cff9c775efaf01e4fe2d8701ff5aef
+3f9d7ff9d323d413131888866869e8686802fef7025c122d02b16f9c05b1
+3fd89904c6054cb993631550b20e3d36f0fc97a5fab3e3ab1813c7059894
+3024ec1e6a4c412f9d71de37ebb3132b8f25858b29e0a98d19820724a8ad
+11ef74e93b156edc57630f18b6788530b0de2f661a5f755bda6b28cc5367
+f41f67dc7c008db14b0f961539b149a94adc44317ab0f55f257d50addbb2
+6ca967eb2f0240832e33ad34f0165457652a752b30e1a9ea60bb64458785
+4d17bf22cc1fc07b777210d3f3e139b0377020d02b59ac2d84ccb5f3ac4a
+eeb60e1322f9445a259a6b3c79f2a563e7e16a9c54886ac6323659f8ef85
+82e36fd1b7728f1d645495422df053249da0d2c58fe44b24a250cb8f7306
+faa26fb8231abdb6ce657cf416e183cb4a111de2a8363c1d8a61b5673f86
+01ef83ddc1059b3a370c8a23a5560bd9433d664dde352db09412cab2272f
+5a145b363c347439a13b1ecc535e95f53ea79c401b48efa277065eb21467
+6f104b19d15d8f4790cce128dd673132db7edc29bb63b0899e25ab1778ce
+f14622bd6d9ff0e486336968f432b3c107e9e0fa75044c19e8474936cfec
+c85b0a1cad94ac579b390a995d312280a6d3b0dc2224da514ef5965f2749
+4733a4324d40ec6bb8b8c7ec2d0bbad1a8ffdbf3743231b1125be6ffe07d
+bbf14e2e7c3c7cba09be7b0486e22b708b40cc39d88176eb190bcbb9905c
+09cf1c8dbd282817c483f5b7f7b1cc6147f935fb65c5b7d42ad70b5cb49a
+667f3d51fd70d38a5dcb017c8df917df58c27485c47fb846bf1781f27b3d
+42ee795c827dfb6fdf007feb11e4bfdd61cfc0404cc5d6f032473f5cc44e
+f49025bc09950a607ad7114cf1da446413f27b3fc1c875231c6ba6c5d629
+179c169fd52add2237fc48f17ee770a9b15ca6ade3094e1c001006dc9e04
+9219c0caf9d178f4638124c3aee451d1db2ccfbecf42081ae841991956cd
+cbfa693d4815d0c2b921c6657fede06ed3854870fcf34486cff70a07c557
+df5b0bede94b55dc2a9138ae2297c3980664e5d6ca9551a8aece84ad2ada
+59999ec559e947c1510f35ebaa136a6d5ebf7e03d291a12cf71c1ef08495
+6567fe6456310469ddc4894c29f0c3839bfc27a2dce1789043666397ca8b
+aa6b6cfc9a8c4cfce65a00a15dd365b7a8721a873547a4a56722cc8e29b1
+5ceb11d40ead10cf3bf303ddad5d22b244eb8e63e547c45d1809417def08
+35daec737be2bb5fe95dbc36405923229b731364c6792a9e5e3718ea77ed
+8bc0edd18aac4b7c19a35a2207bbec281519f511196f30c8a4ad6dcfe607
+eb45652b64f49d7965f5c53e6f413b3d90de57d04ff6c64b47ac0284a213
+23c2fce49b6b4a0500e7d42e5ba2c441d4b66b4cae141cc650e760918560
+1809522a81a6ccc4ba2d1c024739f89af56baccca1f01e0113e36c9c8d71
+677d4b10b258b7d2f29ca8b9c68e103e632e9eed4054485ce2fc6052ce7a
+53b7645090c4a7f677e8b39eb5dbea20fc570739f3b28a4b0b88f4357b6f
+44db1a7949f4b2405cdf8a1f5abd70bddbd9bb22399b2e80b6ead9e9ced0
+22f0ac6b334b751baca4f605ddcd7bb5d337208ec2ede1ea714a13548f03
+e86c0787a69db3e81940b11b0dabf1f6198164b069aa8198064c09d4eae6
+940ee4359aeec1cce4bb6283cb525ed79988accaa5fc2c1e9b713dce97d7
+0f867063b9d292672e8f58bb2051a5776779fbf928ced8377c4bedc704a1
+473aa9ecde18363435b41cebc30d3596295273af3d61a65044f901d1b49b
+44d7bbc439e425afbebcf6095e31fc772ae6707eea95d8c324afe5a4bab4
+3db92585c26127dd880cfaa0e1d13c916f089d90eff5c5f59d350a19a0af
+af42f06d80b6ecd75cf56c954957f49ebf4f75b7e2dbfd6bbb51a87d5764
+0950f2e1e72fdf7882136aaa3670120d63d73f04974fa900c7eae49bbd1c
+1c570ee30b1e890956d25fdc5121c5c4a7f0e4fb76b64cee3c296f7be8c1
+b3946c1856b3a6095900c866af74f400c0f2d5a065131f8d55bdd645701d
+a78256f019ab8150ebd06f53484904ebc86d7caf8490eee55d7f9cf4866b
+89f720181421ff81aea5d92d3fade3f2a38caa91dbde272a476a63bf9546
+fefc76b1a5b4701eb078fb02a637100551b538af242d3ba2a6e5ef7cb180
+b3a8c684c6ab9cc593550ef70abf67fb7c8251a49e3fb43a87d98a9dcf9e
+7c3cb6cf17646a581d958d9be8a74bb7a2f88e6c128f7dca29b49b8df76a
+5d26e4147f467e9752ad8dadb562330ebe2d68dbeca174f869b17ee5f5d0
+40d6ab894ea47d3a996306b26ccb7479e6b3b6bd7ec52b488c2f48fc4cdf
+ac3415b9231b7415cd8959add708fb88219272f2135e7e2e673c069c3a75
+ead4a953a7feeffd03523602d400100000
+"""
+
 # Expected response for "abootimg dtb_dump" command
 dtb_dump_resp="""## DTB area contents (concat format):
  - DTB #0:
diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_android/test_avb.py
index 34cddc485ebc..75abf5d1b1c7 100644
--- a/test/py/tests/test_android/test_avb.py
+++ b/test/py/tests/test_android/test_avb.py
@@ -13,8 +13,10 @@ For configuration verification:
 - Corrupt boot partition and check for failure
 - Corrupt vbmeta partition and check for failure
 """
+import os
 
 import pytest
+from android_image import setup_android_avb_image
 
 temp_addr = 0x90000000
 temp_addr2 = 0x90002000
@@ -22,7 +24,25 @@ temp_addr2 = 0x90002000
 @pytest.fixture(scope='function')
 def avb_device_id(ubman):
     """Returns the device id number for AVB
+
+    On sandbox, creates mmc12.img and binds the disabled mmc12 DT node.
+    On other boards, defaults to device 1.
     """
+    if ubman.config.buildconfig.get('config_sandbox'):
+        if not ubman.config.buildconfig.get('config_cmd_bind'):
+            pytest.skip('CMD_BIND required for AVB on sandbox')
+
+        mmc_dev = 0xc
+        fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
+        if not os.path.exists(fname):
+            setup_android_avb_image(ubman)
+            ubman.restart_uboot()
+
+        ubman.run_command(f'bind /mmc{mmc_dev} mmc_sandbox')
+        # Run mmc list to ensure that mmc_sandbox driver is probed
+        ubman.run_command('mmc list')
+
+        return mmc_dev
 
     # default mmc id
     return 1

-- 
2.56.0

