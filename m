Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89040C982EA
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 11:51:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B6E580F19;
	Wed, 23 Sep 2026 11:51:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NxIhGyDegORp; Wed, 23 Sep 2026 11:51:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2BC5780F14
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790164274;
	b=iv6qOmLF0+hK/kkqI+rg+2PfiawjLjLSLquczNE9RqJ9j/dB+DQ0XK1ftnduDqNjnqgj
	 YKL+JrrpiP0x61+DqNStH+qrdyjws47pBTXmCG01BARU6dl1+pewH1iGIUMyEW58FO9y1
	 mC1yjC0bpZaZikWW1aoSftyvo+R4GC+ZmgBgTG0bpM+4px/as9YZ9fwRIkhW9fOvuRa4T
	 KoOp8BFwXY5DZScJYe05Q7YGhDHBn7yQi5EohChnxbMB1orAPZku0tKNOd/9eCmB/g84o
	 uN5GqLhYx+izMkjgLl5ygCk9TIIlUnh+qlQl1NCkIxoAp1hRCMq84aMY6zmpIRisg8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790164274;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mIY+ZoKpLI4s8191eMFYZ06+f5bjGNlVPd1JwT+lRmE=;
	b=nYdyeSd4zapudlVb8hRgtXqhw+ofLA1LkTilt+m6xmoNvvbtqkVTG6iD+DTP1JlmYynX
	 W6WcoClSLB9Y8PhRFkQgrjqK8LBlpk/5SmUUmMeD7umm2Y7m9H/6kVA4hTh4sgLqE+cYE
	 9586mg0N5np9dtODCclLE0GsSYp6QfiC0fA+JY59x0XVlML2AFKC3LUEFYr/1GM+ZCK06
	 db2yw30kIrlpkweawYe9ZcfmdlBPCNIZshIOrFNNqUtwbOPp2NX0wwKNlgCNdfSiF/DV6
	 gqkJj64Za5PHEHq+o/a7hAhQlu7QZ0b6LiCUe0CKvp3QAPB/nyLAbrBKHScNrZghHZg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790164274;
	bh=mIY+ZoKpLI4s8191eMFYZ06+f5bjGNlVPd1JwT+lRmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ThI7DCk4244rpyPxGR3V5qpuJDoa6P5/k3QN2MN6F/OKNSuPDqDuRLDXeMb+MKP3z
	 TQHabL3pEcQZgc4QJISQBqlGpkFB3zIzb8bleA1oT7VGdaFtu2cP6g3yT5RryY5rgB
	 9kVWtMIb6FW29Ip9u3Xo1o/eK4Pp+JnaEd2e+xL0T7mmVru/mJVXypYmtacebp6Yd8
	 tB65m8DHcaShZzce0Qd+5i265cGxTnOV999Sihhri7dMOJT/rusGecKinXlD048/9x
	 c5XlO6Nm3ncUEgOdsl1pna6xxyLL2dhvmci+NV8jHUF1UgeV3aO48QSOTWuj9ENpa+
	 UEMirC1xvHJNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BC5780F14;
	Wed, 23 Sep 2026 11:51:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 588C8194
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 11:51:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 49C30406AE
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 11:51:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cf1NBSl99HND for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 11:51:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 001B8406EC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.136.65.227
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790164262;
 b=YMD78csjdFx8bI5pQyoHBDd0A9fzcUJ6hbgqL97Ds1/48WUGZz9gXoYeto8jwckgPYNi
 HcLtOo3MPmNYS5lYe+2iRuX2fdocGgofSaDAeWRWIIhl+PAGqgH5mrX3NUlMwU2ivr1bF
 r5xHtOym0iW2GH8K2zMYuCcDsdIlhmj9wT+kkQwhAt3HqYf7sqUbK+d/zAn9z3v6qDzbD
 aiff1+QzKg4DvX91QQWUZUmlQksGGjsqPSTHlQu2w+sCFISN5oyZ9IjHAvkUQB7/cwuwO
 zlQKhMO/qg+v71vTE42G0MrGILn5q/J6zPKokt1f2Pg0qhA+WrmGkL/twv+ypINhFCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790164262;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=mIY+ZoKpLI4s8191eMFYZ06+f5bjGNlVPd1JwT+lRmE=;
 b=iJDEo9U6TkgE4BIyjCGCyCiD7gTPGNklXzMqMek1Rcx2r3xwSQ9mPg93xW7xhiE2FFK6
 Ma9Ovalim9/Te/r46/18W9adVD2Lh076jhDCjCN+XqNSTAYTC/E/z5Ph0W74mURfvzxTM
 h6fSEUSft0cJnGBScRcVcGC1kPxRavKUZ0IG1ImfWVTH5traxbgjISHodKurQYG8O2Fm+
 478G5v+V9B0S8zTDw4LvaAbS/54iy95k7A6VVp0ogjbCny9cUWvYdrk4zCkXpEJ7L9f+i
 rw7B+zt6ATDZnFk/W1pLma93s672K6ap9fs2MkcYJOHtjGHJd+0+LgrZ3D9jKBggkJA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=Ohi1KveV; 
 arc=none smtp.remote-ip=185.136.65.227
X-Greylist: delayed 64 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 23 Sep 2026 11:51:00 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=Ohi1KveV
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.65.227;
 helo=mta-65-227.siemens.flowmailer.net;
 envelope-from=fm-1328817-202609231149528cef46a8cd0002074d-zywxat@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 001B8406EC
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 11:50:59 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 202609231149528cef46a8cd0002074d
 for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 13:49:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=mIY+ZoKpLI4s8191eMFYZ06+f5bjGNlVPd1JwT+lRmE=;
 b=Ohi1KveVtW46bim/Sszl+ot2EfMX1STChXechLw9GPDSk/qdkNq6W0+nwp5BR7teVJaxvE
 77VdVYgLZaXUNFWgwYNrqe5o3CdOjOpNRyiQ3jRYGQ9jyHFMJm/jBD48MLHzqVgJiKV/BVt+
 SzsshZkrNo1IjOe7iY1FBerW49li/0A+OwWUh8Brwmq+J8JlejFB5QqNSYwH+BqHz0h4r5In
 IX6jvaa0aGSuyNJs0TmGfziOZJj6172D0+WeFTwMuNKxrf3ZMJ1SWS+/d4ADSUy0LjG4SKW/
 bWwHXdY0AiSzOK/j3nwhIXuqGFl0QEK3998LvG3qZY5/8Kw9VRaWMQxw==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymondmaoca@gmail.com>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH v10 1/7] qemu-arm64: merge built-in DT
Date: Wed, 23 Sep 2026 13:49:28 +0200
Message-ID: <20260923134933.v10.1.5f8ce2dc2b00328d29e64be2684b10d9f52c6a7b@changeid>
In-Reply-To: <20260923114940.349985-1-ludwig.nussel@siemens.com>
References: <20260923114940.349985-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
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

The keys trusted for FIT signature verification are supposed to be
embedded in the device tree built into u-boot. When running in Qemu it's
convenient to use the device tree provided by the VM which doesn't know
about signatures though. So merge both device trees at startup.

Make sure CONFIG_OF_OMIT_DTB is not set in qemu_arm64_defconfig to take
advantage of the feature by default.

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
Reviewed-by: Simon Glass <sjg@chromium.org>

---

(no changes since v8)

Changes in v8:
- fix smbios test

Changes in v7:
- add guard for OF_LIBFDT_OVERLAY

Changes in v6:
- fix comment style and typos
- fix error message
- return error from board_fdt_blob_setup() if dt couldn't be resized or
  merged. Unfortunately fdtdec_ret_to_errno() is static elsewere so
  -EINVAL has to suffice
- mention CONFIG_OF_OMIT_DTB in commit message

Changes in v4:
- mention arm in subject
- correctly change defconfig

Changes in v3:
- enable CONFIG_OF_OMIT_DTB=n in defconfig
- add error returns
- document decission about dt merging direction

 board/emulation/qemu-arm/qemu-arm.c | 51 +++++++++++++++++++++++++++--
 configs/qemu_arm64_defconfig        |  1 +
 test/py/tests/test_smbios.py        |  3 +-
 3 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
index 38f0ec5f2fb..590a336380b 100644
--- a/board/emulation/qemu-arm/qemu-arm.c
+++ b/board/emulation/qemu-arm/qemu-arm.c
@@ -144,10 +144,57 @@ int dram_init_banksize(void)
 	return 0;
 }
 
+/*
+ * QEMU loads a generated DTB for us at the start of RAM.
+ * When using signatures we may have a built-in FDT that contains
+ * our known public keys nevertheless. So merge the built-in FDT
+ * into QEMU's. We cannot merge the other way around (e.g. in
+ * fdtdec_board_setup()) or board_fix_fdt() at this stage as U-Boot
+ * might be started from a ROM location. At the same time U-Boot
+ * needs QEMU's FDT to initialize serial devices even before
+ * relocation.
+ */
 int board_fdt_blob_setup(void **fdtp)
 {
-	/* QEMU loads a generated DTB for us at the start of RAM. */
-	*fdtp = (void *)CFG_SYS_SDRAM_BASE;
+	void *qemu_fdt = (void *)CFG_SYS_SDRAM_BASE;
+	int ret;
+
+	if (fdt_check_header(qemu_fdt) != 0) {
+		log_err("Invalid QEMU FDT at %p\n", qemu_fdt);
+		return -EINVAL;
+	}
+
+	if (!CONFIG_IS_ENABLED(OF_LIBFDT_OVERLAY))
+		goto out;
+
+	if (fdt_check_header(*fdtp) != 0) {
+		/* this was a perfectly normal condition before
+		 * (CONFIG_OF_OMIT_DTB was set for qemu). So to avoid
+		 * breaking existing configs don't error out. This
+		 * might mean that we don't have keys in case
+		 * FIT_SIGNATURE is on. We can't know though as
+		 * existing setups might have injected them into
+		 * QEMU's FDT already.
+		 */
+		goto out;
+	}
+
+	log_debug("Found built-in FDT at %p. Merging into %p...\n", *fdtp, qemu_fdt);
+
+	ret = fdt_increase_size(qemu_fdt, 1024 + fdt_totalsize(*fdtp));
+	if (ret) {
+		log_err("Failed to grow QEMU FDT: %s\n", fdt_strerror(ret));
+		return -EINVAL;
+	}
+
+	ret = fdt_overlay_apply_node(qemu_fdt, 0, *fdtp, 0);
+	if (ret) {
+		log_err("Failed to apply FDT overlay: %s\n", fdt_strerror(ret));
+		return -EINVAL;
+	}
+
+out:
+	*fdtp = qemu_fdt;
 
 	return 0;
 }
diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index ae6dd770f3e..e5969e4f747 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -39,6 +39,7 @@ CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TPM=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_SPAWN=y
+# CONFIG_OF_OMIT_DTB is not set
 CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_AHCI=y
 CONFIG_SCSI_AHCI=y
diff --git a/test/py/tests/test_smbios.py b/test/py/tests/test_smbios.py
index 3b85a7cc661..607cd3d8cba 100644
--- a/test/py/tests/test_smbios.py
+++ b/test/py/tests/test_smbios.py
@@ -49,7 +49,8 @@ def test_cmd_smbios_sysinfo_verbose(ubman):
     assert 'DMI type 0,' in output
     assert 'Vendor: U-Boot' in output
     assert 'DMI type 1,' in output
-    assert 'Manufacturer: linux' in output
+    # QEMU fdt shows up as emulation, fallback in u-boot is linux
+    assert ('Manufacturer: emulation' or 'Manufacturer: linux') in output
     assert 'DMI type 2,' in output
     assert 'DMI type 3,' in output
     assert 'DMI type 7,' in output
-- 
2.43.0

