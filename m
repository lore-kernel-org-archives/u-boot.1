Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F541606A31A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 09:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LEEVsRXs;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mstKs5He
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 69CD540966;
	Tue, 20 Oct 2026 09:26:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TXRBE870-SSa; Tue, 20 Oct 2026 09:26:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5CC63408FF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792488397;
	b=SiHpVAs0jC7mssxN3pNNIaqYwlECz1oPkAvWWrMIsAHw/VIbBlptYofiEli7dsOr1hsd
	 cG+W1gtgxz4eGx6+vXHyP6wtL8Y1b3m5FydqxGqfchwgAea9iQfrNUJ/6hWJ7hFFdqwtg
	 6nRYChNJ33sJZQEf9OwAB7/ixpdc48YP03sH46HgcOYbFMn+O7ywW15kSW0OocDV+C4v/
	 vUykXTOR7pQjUehqAkpJYCwL8W8RPFiA0YkuahGLyM0FAicUKQgkv3Mg5h4ztDK1PZa8w
	 rRNNWKga5ffUN99NnU/QQ36bAZS3/EFy15CGPerSSLeRDxwiIUnpeSXEHt4jSDLQW/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792488397;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OyOyWA9AzLNhxkZEVpdJnfO1B6wg4CERoEEUbXrHnmc=;
	b=HJZzJagtjNjwwBsDwLpNLx6lphf60DqP3DIOONHbr8d1r8UmO/mdoBscjLTfBQ3+J57T
	 15R2yLNqghxvIPgRKldNCAooa3i9ZVrUJQrvnyp6yHc/GCUDam3EZED33V8/JroySu7G/
	 OFnQCzJhLgEY5P9Rk3kaYvOHDxybdxFJ3XijGynyHykMNvJb25NOmN7fZWxqZ2w+3UJFz
	 uMhsXZzJ4MAoB2adz9VdBAKUqy9XM0KOoSmaJYOukr9+S1L60z98HHHMt4KSOCO89ykDi
	 lLSWac0hPaJ+v1YCfId8gnqp0QVYAGRf1nk4AyvCWL7ZWQKkCf+i5lr3WrrxcXiwuQQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mstKs5He;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792488397;
	bh=OyOyWA9AzLNhxkZEVpdJnfO1B6wg4CERoEEUbXrHnmc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LEEVsRXseLKkOpEfMmRtZlTlsW0QlmsZFhnnbeBPSwuClg2kPwCAsNFtk89uKhJ2G
	 YYE5bB/fHeMvTWrwL7PNgQK2Kyj55ud1EH6OpB0ku/pes4yMmOk83VxFbWkNgWZUB7
	 S9DO3r01tZk83OJ14iWURz4YOl9bduDax2w+LzlEN+8spz+xGjU6tide47k/Xyl8ed
	 FoyYAg9HQdBFS4K7rR03S2qxc8ZqgZkkbX5GvnVPp+Sbb/rrQcFEC4Of+yJkCotWKk
	 UbWTfvFUy7F90RmLqT+bQ78oLxkGQ8HYHbcJn0vuVMEi89MZOFcIIwG7HXi8SkBFC8
	 9idIm/WkYh9gA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5CC63408FF;
	Tue, 20 Oct 2026 09:26:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 685733A8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5A137407E3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2rbdo_xMNOBl for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 09:26:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7C79840835
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792488391;
 b=lur+w4rdEDzg4kdEUhwD6xrvLZqHdM6e7KGE+TE4wlsT+eYZwB/VQkU+FxLzAgrYSzFz
 e2d/i0noydIifYysDPG6u+wopolsjm8GQafl3iBi2OkOQVtZnhXpnacTzKONuQkkA7p5k
 FOSp7SX/porv7aSGDj1xmIHeWapK5PQFnuafQ//os20WWPyd9oEMhudd3c6zVWWjR8um1
 HCDxtGpHkkxzagyaTTyyhzUTt4DgD6dDCMXP/l9nf7oSO7iPbJgaGlrYP438ZRdBlCVgT
 iTZvhe3emAcIUfVMJ/Zb7/jPP5PWZaHAuj10GUBAxo4zk7APXRtOTduT+1cDoJEGS+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792488391;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=OyOyWA9AzLNhxkZEVpdJnfO1B6wg4CERoEEUbXrHnmc=;
 b=fe/0YI0Zu6dEKes2hoB8WFyOvALfN+VlhYS9DuH08Ne2mqi3LuBQBhXGFXiBzfxDpHbH
 1bivarKHz21+MxXVm7gs0c519EY4qYB1jGGvTq2yFG/nnM07UvAflBsxilNoD0oUOF6+y
 YSkmwkluQ9Es+sNaZMtphSOh4e2HZOTlxQ+TWQtiaF4qIT3ETD+liAXiBYaPKYrlYH8/u
 rUjs1DU6N5+WRgs0esBEYs4ISLVb4VDtAPqg3w36dET1faC8x+Pj66lbOuUKiict1aLJA
 mj2Yngg2cKXR3S8YYPF8GPemccN8dn7aGFZwS2gv2FopUVJo2GSIsfyjNA5lvB9Wwog==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=mstKs5He; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=mstKs5He
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C79840835
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2155F43910;
 Tue, 20 Oct 2026 09:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F4A1F000C5;
 Tue, 20 Oct 2026 09:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792488391;
 bh=OyOyWA9AzLNhxkZEVpdJnfO1B6wg4CERoEEUbXrHnmc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=mstKs5HeI6RapJfqmympgWMYBnFmb93vlc53ogzIIPhnj/DpN/jj8GPkD8CQ1LW3U
 +MIt9DsU+WC5su05ZHy/SOwXcX237ctRcgtWAUW+76xrwDsVA/gXvvbjteLBsboJd1
 JqnqYj2V5ym4SNJdBx8ocaGXLt+JNLDN/z+n6up7xVDfbbR352pq2EdTMDrgE8I0dh
 llpOz6U5i8PY+4vTq/MgIoqP8en2kYkQol33QUJszbrjPlheCt+O+75J6mhUIkOocV
 Q6sCLNuvwtwUjEY9+4q5Ur2JHIRNwMdo5gXoc2PMqrUK5DUPxxz+yr1nxF4z5G1GkT
 nYMzX7r5cUKbw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Tue, 20 Oct 2026 11:25:58 +0200
Subject: [PATCH v2 09/10] test/py: avb: Add sandbox AVB testing with
 dedicated mmc12 device
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-test-avb-fixes-v2-9-997f8f04fd3f@kernel.org>
References: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
In-Reply-To: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10111;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=Lzia9kTc7Lf2jtFdXdRiUV1A1Nqh9KaxAQZpN4Gh4X4=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq1zOvDH3SV2P5ty6BznwLqR8X4DYLMOuyck+rQ
 r/JKGN320CJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCatczrwAKCRAZDR20Zk4Z
 NakbCADdQHgZ1duKd9MwEoVKPvVmBcve/VAhtyZzJLrTc00K0grCd38B7s/lanpce+imbiauORq
 /XvxKufl3OP8pClC6Fo6UgBjheFg4I2n4fRpMLUikc0ifzGbtzOi/plX0Rz40Y9ObOlLPs1OOMK
 e+veo97qok/SGHkmDYFuGOI6URn4tc/D3ROopbwhMU3LVZfQ6reNXfEXVl/1WjB1HaHcgO/sutF
 ZTXIza+DUB7oWY1falJ1aEa/X6kA1Myqf4q9zY5Ge1kwb7VXc21jtElRop7oszgH4xnjoDY9nvF
 epieAZ8li2aSoE0XF7Yg7q93fkk5Y2VTdwmHgttNalo5pqax
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 arch/sandbox/dts/test.dts                   |  8 +++
 test/py/tests/test_android/android_image.py | 15 ++++++
 test/py/tests/test_android/test_abootimg.py | 77 +++++++++++++++++++++++++++++
 test/py/tests/test_android/test_avb.py      | 26 ++++++++++
 4 files changed, 126 insertions(+)

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
index 34cddc485ebc..48fa6ee7cf0b 100644
--- a/test/py/tests/test_android/test_avb.py
+++ b/test/py/tests/test_android/test_avb.py
@@ -13,8 +13,11 @@ For configuration verification:
 - Corrupt boot partition and check for failure
 - Corrupt vbmeta partition and check for failure
 """
+import os
 
 import pytest
+import shutil
+from android_image import setup_android_avb_image
 
 temp_addr = 0x90000000
 temp_addr2 = 0x90002000
@@ -22,7 +25,30 @@ temp_addr2 = 0x90002000
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
+        required_host_tools = ['qemu-img', 'cgpt']
+        for tool in required_host_tools:
+            if shutil.which(tool) is None:
+                pytest.skip(f'tool "{tool}" not in $PATH')
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

