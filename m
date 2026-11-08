Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510A2606A320
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZiR8ED3a;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=zURWqVDO
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30955406B2;
	Sun,  8 Nov 2026 18:14:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WWuXvV0X8fpt; Sun,  8 Nov 2026 18:14:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 619E3406A0
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794161676;
	b=nBfDVdU4kgZuLxdGNeeXHCOhMxVYBr+fUS3eSN6T9hOz3rNXgAkjn0B+B9lMLV09SB8j
	 QIQmC66VQFcWRLUGxP3PDM2hKD1rr9YKQg/QV8K93BJEbW3Z4Z9TSILrnShSICHiZRG8B
	 p5IKSkmqa1ys80RORhnG02RSlkaXUdQCngiv//pxbvqcVxZHl2m36eb0OKsrMcxvuxYUH
	 OdJ04JcoZyCCU5lTBXNzQjiNAtyBIqa7G2eHOzZiFs5OAVjYWhfZEFi6/CIybkXgMrcs6
	 vF7HGnp14Drs3pwqvE6j5aLgmebimqdssYAobsbahHo+TEnJzmkOYHOZADFEwOuBgSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794161676;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Date:Message-ID:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GpECAj8Z74x1/whnEa8CY4VXnY1e6YDHPOPOaaNPiUI=;
	b=W0kBrsuT0/xyWGQil4LS6wks6f2V7BGZ02eDGGEThUp6kVUaa40mvpjkfNmrV7/Q9TRP
	 odGxctiFNEiFH1cJLWL2zVRAR37Owm1Z/T377gv0BJVXyRDdFiDeoT+NTvAU9ILvRqC/c
	 +vZXFPeV60pCRZ81oBwA4wDMWPsILTlvviD8FU4t9eQB4fEy40dmnYn0sPnDIeowDm0pX
	 luwMDOgxRTWP9L+LJrp1Jsa6PDmDiGdofKzfKVEyLXvvjLMeIOp6erpnppQtpvpp0g+aN
	 avn0SCITbLRaSggcsWs6cDw6+1erR4NTFCz3XD7MjCywqbFTccgcnnQBf0RZMZIhWxQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=michaelmcallister.org;
	dkim=pass header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=zURWqVDO;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794161676;
	bh=GpECAj8Z74x1/whnEa8CY4VXnY1e6YDHPOPOaaNPiUI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZiR8ED3aVhuLWsprHZtqb50QsQGK+20OAD4TERShi98RqK/pFnPf0xQNm2V1dDXyq
	 ty8lTrl8XyBQ7herAV7JxSZUfW8XKb71R0mbqogKY1K38X4fKcx0soFDHsAXxYCVI7
	 3hRiXvotfBTNi4Lb7ydBsTyDHw/uFP0vkAnX44Hy+EzpjLWrDlFXWagTi8l85Hflxf
	 w0RoW8XrDH9Rt5WCYfIOieZCkb2qlO5ZFuC0CY3Kf0QsLthuX74T3qlBwcf0s2wdEv
	 O1O+idcci2GuqP8JUmpBFh8HGsNabgimu8vbRcLbMd4Z6Ik20QGrVdreGo9cQlc4Nm
	 JPWtfvs6p2YRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 619E3406A0;
	Sun,  8 Nov 2026 18:14:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C7FF6111
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 17:24:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AE28340648
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 17:24:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nCwrz7J9dRvK for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 17:24:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D560940631
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=85.9.210.45
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=85.9.210.45;
 helo=mail-06.mail-europe.com; envelope-from=me@michaelmcallister.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=michaelmcallister.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org
 header.a=rsa-sha256 header.s=protonmail2 header.b=zURWqVDO
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D560940631
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 17:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=michaelmcallister.org; s=protonmail2; t=1794158669; x=1794417869;
 bh=GpECAj8Z74x1/whnEa8CY4VXnY1e6YDHPOPOaaNPiUI=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=zURWqVDOX7lRJ6XndggPxXO5pLeaxY/Unli+lgDxPZ1AIOpflfdnilgeOyIbwv6rK
 ubLvRsJaZCgjnzJItZCPbchA/r+ehnlTdQW/ajEetctejSUGfkezSnC+eX4c67Z3tt
 j+WseuIIwCibVS+AzMtWTCyRlsLTUdJ5tE02+V3BtE+8Yt8adiSys+FatGxwmqMdiG
 uis6YqZSaabK+M/MBSlcZ5+BCHYkVvq4qz9iXyYuuRCJ2DFEiGSxu68UxqlKUc/Vv4
 klNXMpyOLCOljqvleM3gHO4AUmjnBrhPuSZVBFsW6ho7M9iTByryzNgaWqR3DjXlIk
 Ihx8/xMZWUZEg==
X-Pm-Submission-Id: 4jN0CJ0HcVz1DF6x
From: Michael McAllister <me@michaelmcallister.org>
To: u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Subject: [PATCH] board: qualcomm: add Moto G10 configuration and boot
 instructions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Date: Sun, 08 Nov 2026 17:24:26 -0000
Message-ID: <179415866631.52076.3385909914110437826.uboot-capri@michaelmcallister.org>
X-Mailman-Approved-At: Sun, 08 Nov 2026 18:14:32 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Select the Capri device tree and ARM64 load offset. Document header-v3
packaging alongside the other Qualcomm phones.

Signed-off-by: Michael McAllister <me@michaelmcallister.org>
---
Hi,

I've got U-Boot booting Linux on the Moto G10 (SM4250/capri). This adds
a small config fragment and build/packaging instructions alongside the
other Qualcomm phones.

I tested the documented header-v3 recipe using fastboot boot, with no
ramdisk and vendor_boot/dtbo left as-is.

This depends on the G10 DTS [1] being imported from Linux, I used a local
copy for testing

Thanks,
Michael

[1] https://lore.kernel.org/linux-arm-msm/179305261664.94591.2492105022681928417.capri-dts-v3-3@michaelmcallister.org/

 board/qualcomm/motorola-capri.config |  3 +++
 doc/board/qualcomm/board.rst         | 30 ++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 board/qualcomm/motorola-capri.config

diff --git a/board/qualcomm/motorola-capri.config b/board/qualcomm/motorola-capri.config
new file mode 100644
index 0000000..e2300db
--- /dev/null
+++ b/board/qualcomm/motorola-capri.config
@@ -0,0 +1,3 @@
+# Motorola Moto G10 (capri), chainloaded by the stock Android bootloader.
+CONFIG_DEFAULT_DEVICE_TREE="qcom/sm4250-motorola-capri"
+CONFIG_TEXT_BASE=0x80080000
diff --git a/doc/board/qualcomm/board.rst b/doc/board/qualcomm/board.rst
index eb800f8..c1aba2b 100644
--- a/doc/board/qualcomm/board.rst
+++ b/doc/board/qualcomm/board.rst
@@ -57,6 +57,36 @@ The DTB is called:
 
 More information can be found on the `Google Pixel 3 page`_.
 
+Motorola Moto G10 (capri)
+^^^^^^^^^^^^^^^^^^^^^^^^
+
+The SM4250-based Moto G10 uses ``qcom_defconfig`` with the
+``motorola-capri.config`` and ``qcom-phone.config`` fragments::
+
+    make CROSS_COMPILE=aarch64-linux-gnu- O=.output \
+        qcom_defconfig qcom-phone.config motorola-capri.config
+    make CROSS_COMPILE=aarch64-linux-gnu- O=.output -j$(nproc)
+
+With an unlocked stock bootloader, package ``u-boot.bin`` (including its
+board DTB) in an Android boot image with header version 3. Pad the payload
+to the memory footprint in its ARM64 image header before packaging::
+
+    python3 - <<'PY'
+    from pathlib import Path
+    image = Path('.output/u-boot.bin').read_bytes()
+    assert image[56:60] == b'ARM\x64'
+    size = int.from_bytes(image[16:24], 'little')
+    assert size >= len(image)
+    Path('.output/u-boot-padded.bin').write_bytes(image.ljust(size, b'\0'))
+    PY
+    mkbootimg --header_version 3 --kernel .output/u-boot-padded.bin \
+        --output .output/boot.img
+    fastboot boot .output/boot.img
+
+No Android ramdisk is needed for this U-Boot image. Keep the existing
+``vendor_boot`` and ``dtbo`` partitions; the generic ``erase dtbo`` step
+below does not apply to this device. See :doc:`phones` for the boot menu.
+
 starqlte
 ^^^^^^^^
 
-- 
2.50.1 (Apple Git-155)

