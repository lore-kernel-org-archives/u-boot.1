Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997C5606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 07:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YzdAixtM;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ko1a2I2h
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E43C60705;
	Tue,  3 Nov 2026 07:12:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OlTOqE_Se4Hj; Tue,  3 Nov 2026 07:12:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 48DD760642
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793689972;
	b=Ds9aMaofYWtJfrPE+z84V/2KID8nmOxWOAFrk863WY66RzMWV6T4oSPTstUmpt8Sroka
	 Z209/HaszGkCbtZCJfALGyaXaWbEdfp16VVjQZYpldVXiCTIks1/f9fybVfKQPmvLelB7
	 Bo+Dt8UQ0zHDWAocCva9SxFvcfJRuWIb0dzE1VSNbwiUMNiNilGesU9T0mi59UVW0kvHn
	 dGgYkLZvEUdL4/dw/cHIOEseKkpfEq7+D7yksED7t0m+OR+mAvUj47ZmdG4CAAUUmAcph
	 q+RLC2NBEC3Xcxi8CsggDazMkXeOjwWB3Y5VgXVR0C4DSNiBW81AVNfr4sD4oumOE+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793689972;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=1+BWi7Ri7jiE1IJ6W89j9sHl9J8gYLGS4FwNTNOROZE=;
	b=nrsghqWnbGDxLbOxnr3rxnmpQrM4AfhWkNEO7PFEgqCCiXzD2Z8iPVA3BKeAV3hFfn9N
	 8QT1Uc4Az7EWCQboS8ckRZU3oK9AwZPYxu/oUZOi08cZ0byCqZBsuRgWJXKPuzJjTvgFY
	 SKNC4XuNCJyJrrbFnJZj0jubMjV6rzt9klmMPVEuyM6Uw52PFSwVRX8Sc8pFKGk/IAvVc
	 YgL22jYcTQHY2FXLgby6TYwAzPyfDqncKjJgSrdfORGlwLkJJwWMT6gonh01uZoEL64Wz
	 ZdnH5cnlSYmFGqI9PgN1qf6Qzga8ThUuc5DRUzQnUPet2kRiQ9UhzOjOZ18sWi8jTaw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793689972;
	bh=1+BWi7Ri7jiE1IJ6W89j9sHl9J8gYLGS4FwNTNOROZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YzdAixtMiGbzd0dXy7DvoeC5j8dxcRKgzD4II3hMyxnD/0getVO1e5Dbk3nr7J0OT
	 RuUNI/p/UWhNI+FfygnhkrM0ZagbCLeChYUNZO2pghwz7t1rao98BhAVOek9B3zjKH
	 XHWsy8f8rbW52OehXf47cDgpwucY18qMqIJIPmdx3HGFKgOKgO02pOU1L4Puht6I0w
	 OnMBxoF0bTugHioapTphtYYLq+iXxNH7YsuOGTTbKHEMwWgNwTCAYrE6OZuAbYMRSy
	 52jw/8aG5Yv3djecT2fLAyBL+J3CNlyr+NQ4cnjBDYIV5r5I0CaS8Lmp5yk9KlcZk4
	 d4bV/5AOUQZaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 48DD760642;
	Tue,  3 Nov 2026 07:12:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6960D2AC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:12:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 58B0580D7A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:12:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4EgutcLFYXEu for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 07:12:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0173A80D4A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793689969;
 b=LEAmxWZlRzXOlKy/2+0HHDB2ElKbRgIf8yF1UouYNMGHKdfSRFiuedWtV1IfJNmgvEGg
 WwzCU9wz9FkoaiNKCvZW24ZbqXuBqLYBKwzGlpylfcvgY79zLHJFYlX984t78OKXW2k2p
 MkClxJDmckitWu1xMI+Nn0ob1X2zkjXoSO0ZlpkRSHz8zFzkb69oZpaCseuLoo5T5Y5A2
 qM//pc6/7sGLY3TaUlJ75P4/s8P0NyR209vtw5kmCFFC/0OWP/gNIdoNCoxpDpOPh71VS
 UHD6pMKw9jUNRLxjNc7UBoYm0jhbo7FUHIWBzDkliRbj5HPSUlw5ZxyNd4/99IOHStg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793689969;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=1+BWi7Ri7jiE1IJ6W89j9sHl9J8gYLGS4FwNTNOROZE=;
 b=DdXBXxhXk7cg7eX5MimJ57E6HeZp92ePdVi8nk311GMMEQ8a/7Kp/Jlj/JR3JDVJeMzG
 Y7RXd7lt1tra7mbizQdxZLiqqWxhgieUTPz4lvKbJuVDHys2IiDVz1w1HTblQ+u4csUbt
 lBK23yc9THr4fTBuQtdsU3Aeizy1Qyf3CMGjgCc1zLhs2LWFKoSBhEYMFJ4JeKtZumI0l
 bpu6grn5etoinr06+4l4uOXs8wpAZ7aXXqFTlQNbrGokDPHOYJ6zl42fK27hOtzP7VPQU
 2Chi5Nw4g8jC/g1syfIj4kyGk0QYVnalle0Zp8NZolzX/5lLJpXkClHS/3JNyQ/oK6A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ko1a2I2h; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=ko1a2I2h
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0173A80D4A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:12:48 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so29956625e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 23:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793689966; x=1794294766;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1+BWi7Ri7jiE1IJ6W89j9sHl9J8gYLGS4FwNTNOROZE=;
 b=ko1a2I2h1YShOLOvj38nxv3/DwZ1xOC1YaGVBvQX1zl1MTjuR4L6cNje3uRUG1njrB
 3ZYgWLcHdBpDRz92IqP7vh7JlL5wRcNIPbIZszdA7wmUi2jvQPOi/3k/za1UJ1ecU3+4
 ZQd/qUOY5uN/NVQp4lt2614jnOr/5/O420wrtNSjUNrJ2TXGvd1SenGPGRnDo8IGmqgR
 pY6464chqtOLXrCnptOysJqERDGrM8T6knoJxMs4gEk2wYKaFLvrjVyRjJliiAUv2lV1
 Pk58/ZXBKGiptDeb/VYU3N7YKgEUY3K39gZWNv25iB5kReZq9IATAME5mBm0CgMznrvf
 zC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793689966; x=1794294766;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1+BWi7Ri7jiE1IJ6W89j9sHl9J8gYLGS4FwNTNOROZE=;
 b=BLcahomUWA3SnE4EtsGMdDl1C8Uvx/LuSlfRjIAiky1I+rudfIHi3xcgiDAUTaPY9f
 hfSy5lXcqvXfg+XpX5knvWGVwKQmCO3aY2KbBg9vjBQGs3DEvgSPeRIljcAmbf3Oh7uP
 uvJqFN55gpjcnTtxSkmt3CjLU1RGy+jGsItSadufFYipwSMCpmIvUhv2iMq+bicVBfJ5
 a3/j6DOUpMojwEi3PJHcy4/mwMwEd55XXmV5y7k5Tgm9q3uwQmcvYp4//923Yo/VEWpd
 hHTCxz5uM3w0wtg9lK2dIqh76KgEhmg1CMwmVGySqOuWUjaXXDZaQ6hiZfcXB96s2sTO
 jEPQ==
X-Gm-Message-State: APuU4Z81r4a8fQHiq3NfxaMGFv3BxI3Gjal+4ks0U9MC5gLYsd9uKos2
 6TmO/JCWkArhGg15NwmW7stLyx56VAeABYS+i3ioZFzcNBD+qxU9fOebUz2XseIxsKRWW+Ve
X-Gm-Gg: AYBFou1CunQJ8HBpOxXd8qaIcpV/2YVmdE9XPkeYWQKBTjRi/690hEw6w762DEhB9p4
 K9jQQCB2x3vZvI9nr8Kp2XdMME/GrNsc+kcgLg+roK3zfiBq1WDhjlmQ2KYbd0RxU88DfGcCvjd
 5di7wpFWiOGWYpC6H7rU4tzTlLvoXcmyykoikstgyGoQy5GU72v8Oy0DGQN0n91LtUN+N6H6INo
 CpPAVMeixoL/LsrW2duTrOiwdla8gwBYY7ngs0eaNjw6sokzuT7zgpUKa6FLLbxHbrVvskpJqHE
 l7qvTw5rS/avbaSWRGEZtI8rhbbjY4zant5KsdWsaEyTA/jZH9DwGdaTf3t+osTQedc4ZdebInQ
 jNLvyDE8lZeLa4RdcIocY3086nmK1kFjQvABiIxn80A29tGeVWEUfjYXSr4bbkks33iIboDpv64
 JPgIXmdhfOh2W0ZPlwVxKGwRxm51tnNojeO1qAi0MHxKW7bq4BSJluv5Y+vZx9QYDnzMNdo7DJY
 OGzJNXElXyjC/iFJkUzaGg1WF2VuBD/4a/oc2vxgJglAr9VJzJt1Gs8LmIIeW12lc4OssWUjOv5
 wSIxQzhJejXGsEUPECqeinrd25wZO84=
X-Received: by 2002:a05:600c:871a:b0:4a6:44b:2593 with SMTP id
 5b1f17b1804b1-4ac18d68babmr250683565e9.29.1793689966371; 
 Mon, 02 Nov 2026 23:12:46 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d511sm22890630f8f.8.2026.11.02.23.12.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 23:12:45 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heiko Schocher <hs@nabladev.com>, Kyungmin Park <kmpark@infradead.org>,
 Tom Rini <trini@konsulko.com>, Benedikt Spranger <b.spranger@linutronix.de>
Subject: [PATCH 1/6] mtd: ubi: validate data_size in the VID header
Date: Tue, 03 Nov 2026 07:12:44 +0000
Message-ID: <7b51d768-91e2-4f16-b559-a30f1351fc08@gmail.com>
In-Reply-To: <151582f9-d68b-4fc9-9f07-1a8b9b1395dd@gmail.com>
References: <151582f9-d68b-4fc9-9f07-1a8b9b1395dd@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

validate_vid_hdr() never checks that a VID header's data_size fits in a
LEB. Only the LEBs of a static volume other than its last one have their
data_size pinned to the usable LEB size; for the last LEB of a static
volume and for a copied LEB of a dynamic one any positive value passes.
The attach code then trusts it: when two PEBs hold the same LEB and the
newer one is a copy, ubi_compare_lebs() reads data_size bytes of that
PEB into ubi->peb_buf, which holds one PEB, and computes the data CRC
over them. A handcrafted UBI image can therefore make 'ubi part' overrun
peb_buf. The ubi_assert() in ubi_io_read() that would catch the length
is compiled out unless DEBUG is defined.

Linux fixed this in commit 281fda27673f ("UBI: Validate data_size") by
Richard Weinberger, after the v4.2 code that U-Boot's UBI was last
synced with. Apply the same check.

Add a test which writes a static volume of one full LEB on the sandbox
NAND, so that its VID header carries the largest valid data_size, checks
that it attaches and reads back, then sets data_size one byte larger and
checks that attaching fails.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 MAINTAINERS          |   1 +
 drivers/mtd/ubi/io.c |   5 ++
 test/dm/Makefile     |   3 +
 test/dm/ubi.c        | 137 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 146 insertions(+)
 create mode 100644 test/dm/ubi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5052671740d..b2ced485702 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1801,6 +1801,7 @@ M:	Heiko Schocher <hs@nabladev.com>
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-ubi.git
 F:	drivers/mtd/ubi/
+F:	test/dm/ubi.c
 
 UFETCH
 M:	Casey Connolly <casey.connolly@linaro.org>
diff --git a/drivers/mtd/ubi/io.c b/drivers/mtd/ubi/io.c
index 2ec968c85ff..ee92a2be13c 100644
--- a/drivers/mtd/ubi/io.c
+++ b/drivers/mtd/ubi/io.c
@@ -916,6 +916,11 @@ static int validate_vid_hdr(const struct ubi_device *ubi,
 		goto bad;
 	}
 
+	if (data_size > ubi->leb_size) {
+		ubi_err(ubi, "bad data_size");
+		goto bad;
+	}
+
 	if (vol_type == UBI_VID_STATIC) {
 		/*
 		 * Although from high-level point of view static volumes may
diff --git a/test/dm/Makefile b/test/dm/Makefile
index 1b3a20aa932..29e3db05a48 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -149,6 +149,9 @@ obj-$(CONFIG_UT_DM) += tag.o
 obj-$(CONFIG_TEE) += tee.o
 obj-$(CONFIG_TIMER) += timer.o
 obj-$(CONFIG_TPM_V2) += tpm.o
+ifeq ($(CONFIG_CMD_UBI)$(CONFIG_NAND_SANDBOX),yy)
+obj-y += ubi.o
+endif
 obj-$(CONFIG_DM_USB) += usb.o
 obj-$(CONFIG_VIDEO_SANDBOX_SDL) += video.o
 ifeq ($(CONFIG_VIRTIO_SANDBOX),y)
diff --git a/test/dm/ubi.c b/test/dm/ubi.c
new file mode 100644
index 00000000000..81654b33f1e
--- /dev/null
+++ b/test/dm/ubi.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for attaching UBI to the sandbox NAND
+ */
+
+#include <malloc.h>
+#include <mtd.h>
+#include <ubi_uboot.h>
+#include <dm/test.h>
+#include <linux/err.h>
+#include <linux/mtd/mtd.h>
+#include <linux/string.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+#define UBI_TEST_MTD	"nand2"
+
+static int ubi_test_erase_peb(struct unit_test_state *uts,
+			      struct mtd_info *mtd, u64 off)
+{
+	struct erase_info ei;
+
+	memset(&ei, 0, sizeof(ei));
+	ei.mtd = mtd;
+	ei.addr = off;
+	ei.len = mtd->erasesize;
+	ut_assertok(mtd_erase(mtd, &ei));
+
+	return 0;
+}
+
+/*
+ * Set data_size in the VID header of LEB 0 of volume 0, with a valid header
+ * CRC, by rewriting the PEB that holds it. @peb holds one eraseblock.
+ */
+static int ubi_test_set_data_size(struct unit_test_state *uts,
+				  struct mtd_info *mtd, u8 *peb, u32 data_size)
+{
+	struct ubi_ec_hdr *ec_hdr = (struct ubi_ec_hdr *)peb;
+	struct ubi_vid_hdr *vid_hdr;
+	size_t retlen;
+	u64 off;
+
+	for (off = 0; off < mtd->size; off += mtd->erasesize) {
+		if (mtd_block_isbad(mtd, off))
+			continue;
+		ut_assertok(mtd_read(mtd, off, mtd->erasesize, &retlen, peb));
+		if (be32_to_cpu(ec_hdr->magic) != UBI_EC_HDR_MAGIC)
+			continue;
+		vid_hdr = (struct ubi_vid_hdr *)
+			(peb + be32_to_cpu(ec_hdr->vid_hdr_offset));
+		if (be32_to_cpu(vid_hdr->magic) == UBI_VID_HDR_MAGIC &&
+		    be32_to_cpu(vid_hdr->vol_id) == 0 &&
+		    be32_to_cpu(vid_hdr->lnum) == 0)
+			break;
+	}
+	ut_assert(off < mtd->size);
+
+	vid_hdr->data_size = cpu_to_be32(data_size);
+	vid_hdr->hdr_crc = cpu_to_be32(crc32(UBI_CRC32_INIT, vid_hdr,
+					     UBI_VID_HDR_SIZE_CRC));
+
+	ut_assertok(ubi_test_erase_peb(uts, mtd, off));
+	ut_assertok(mtd_write(mtd, off, mtd->erasesize, &retlen, peb));
+
+	return 0;
+}
+
+/* Find the test MTD device and erase it all */
+static int ubi_test_erase_mtd(struct unit_test_state *uts,
+			      struct mtd_info **mtdp)
+{
+	struct mtd_info *mtd;
+	u64 off;
+
+	mtd_probe_devices();
+	mtd = get_mtd_device_nm(UBI_TEST_MTD);
+	ut_assert(!IS_ERR_OR_NULL(mtd));
+	put_mtd_device(mtd);
+
+	for (off = 0; off < mtd->size; off += mtd->erasesize) {
+		if (mtd_block_isbad(mtd, off))
+			continue;
+		ut_assertok(ubi_test_erase_peb(uts, mtd, off));
+	}
+	*mtdp = mtd;
+
+	return 0;
+}
+
+static int ubi_test_vid_hdr_data_size(struct unit_test_state *uts)
+{
+	struct mtd_info *mtd;
+	int leb_size;
+	u8 *buf;
+
+	ut_assertok(ubi_test_erase_mtd(uts, &mtd));
+
+	buf = malloc(mtd->erasesize);
+	ut_assertnonnull(buf);
+
+	/* A static volume whose only LEB is full: data_size is the LEB size */
+	ut_assertok(ubi_part(UBI_TEST_MTD, NULL));
+	leb_size = ubi_devices[0]->leb_size;
+	ut_assertok(ubi_create_vol("vol0", leb_size, false, 0, false));
+	memset(buf, 0xa5, leb_size);
+	ut_assertok(ubi_volume_write("vol0", buf, 0, leb_size));
+	ubi_detach();
+
+	/* It attaches again and reads back */
+	ut_assertok(ubi_part(UBI_TEST_MTD, NULL));
+	memset(buf, 0, leb_size);
+	ut_assertok(ubi_volume_read("vol0", buf, 0, leb_size));
+	ut_assertnull(memchr_inv(buf, 0xa5, leb_size));
+	ubi_detach();
+
+	/* One byte more than the LEB holds is a corrupt header */
+	ut_assertok(ubi_test_set_data_size(uts, mtd, buf, leb_size + 1));
+	ut_asserteq(-EINVAL, ubi_part(UBI_TEST_MTD, NULL));
+
+	free(buf);
+
+	return 0;
+}
+
+static int dm_test_ubi_vid_hdr_data_size(struct unit_test_state *uts)
+{
+	int ret;
+
+	/* UBI holds the MTD device: release it before and after the test */
+	ubi_detach();
+	ret = ubi_test_vid_hdr_data_size(uts);
+	ubi_detach();
+
+	return ret;
+}
+DM_TEST(dm_test_ubi_vid_hdr_data_size, UTF_SCAN_FDT | UTF_LIVE_TREE);
