Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1755DCC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 13:05:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D3862605F4;
	Tue, 13 Oct 2026 13:05:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P8EejkwkXM0f; Tue, 13 Oct 2026 13:05:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B05AA60643
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791896736;
	b=oRLkb5Ry4IJm+x/vi2xTY++PAmsImntwGTDIlR01TcPOQFic7Ckx/+5kx02vYIUFzaBf
	 JIn/Eoo88VCfTxoJJSgpViERRxlBvG5ldoADZRpQVEp9w7z+RBLR7LZ0hM+acYpC8ojzr
	 YDzWIWEXMsmL6wBTswgSJ/Z1T+iEUV1JSdCUXfiAHbHD8GWLgON//fxsx7wJdLBkw1xm7
	 48UN9npXbfvirHs1mTjKSFzxdbc7QNFl4RsF1QCzjuLxIub6yBPGKyl085e1Zgpah750o
	 gDHjX3oaJrJFn30ZmFJxNFVAApvmGwiVhBIwm0g6zHY3NDa2PjdTORHE49AOZD/0PLg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791896736;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9kKdoLWrUovSnKqxJyGrfpyMemt8Zj5vVIIfEo5IUio=;
	b=bo+C7sHvmqTyj8Fca2i7RF9AfM5icU5Nw7XtRb6n4Y9zIEuufOEIyks6J7XNo0QZeO6Z
	 CQyMiqLf9uN/Th2YxsBpW8FAfavBqJM/FwoZ8gEhqHaGMSxbn9k+xcnJro16U36DZD0aJ
	 02eT7bTDy33o7WDXi3+T1sAklEGVTX/THKnXcb4Dd1dX81XtjitWnIPxYuqpdZS3Di3sh
	 EqXFW/Rt30U79XBlvAeUASs686PSGqA6d847gIHyceqt0qVOI+14Eqi2JpAyGNuwHPwnT
	 wwKpO1+1QUEsvTHyIjoYvsWx0XqxbaYPRxpxGhxMnIigJNrR+FcnsB0YZFAV96255HQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791896736;
	bh=9kKdoLWrUovSnKqxJyGrfpyMemt8Zj5vVIIfEo5IUio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SI/bt6J5cZWNk1cWJ8nfucsdifN+ZNk1Iv7QIYz2CcrU3g3159IRGriI9mMsVEgUM
	 32yCdWe5bTR4uPoN37VnNX88UUBb4PD+s9dLHQwHpbjMJJl0VVUFUURwwNw06PFtMa
	 FFf/PuQ5sdiyoOp3NpFV7uIWCqwXuM9YcFnll44eVTvKNVYCdpgrJeeyCZNStYWygd
	 cMI8RHWXC2z49xfXZMFmYP2QJoThMmJY5kyDyDPosHvOcBN/SDfaIqAoGLT8tpJfqA
	 o/CnFkQg/++diugEx1CbsOPc74giL+da8i3TeRzyKiYHskTzi1RCwTGGm4WpmpNUCI
	 G2kSfJZImbzDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B05AA60643;
	Tue, 13 Oct 2026 13:05:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E147A235
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:05:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D2BAD80AF1
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:05:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rAYMhk9hGnM8 for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 13:05:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3159380849
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791896735;
 b=pMP07kjAaN57K6b2ShxSHrEtNgDxDDI14uBQf8zrgcSW0tKxEv/Rgyl3XsKP7EDa5H8U
 Lw7PjZM64ul3ZChEe0vkxliGCNihQCW5XWAoSjAScRvJIaN//eY+3risGYIpAOHy6ZmPj
 vIptMLx/wQ6jWDWESVpahwOuPFnCLp5cG+uETyqcZOkNOObTwFUfPQW71MMJD1PBMqXMV
 XtH8fl86azr/5Wb7MGBzOM0YP1UOiSzcfXrFRhOFd1rBMoKUAnqIfEki07W98c+A3Uxxp
 ucm+C/TuIhMZQixdeFHa18Kq519O5PpXAZ0urTTmBLGYuDoS3m8EJS5ZkiBPzP2Opbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791896735;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
 X-Originating-IP:X-CM-SenderInfo;
 bh=9kKdoLWrUovSnKqxJyGrfpyMemt8Zj5vVIIfEo5IUio=;
 b=n/yAST1Bf+8VFmBuEhT7saeDY6zhi0PZRxrNvOXvOpK54b4xujuHXi+G7HuAM8CSSFx9
 AxrhpR63b13izxuS0225vMQqIW1OjooKJjZQ9RiTvPYWIFLwhQx/XytBQjrJAIAAhIc91
 C/em/dXtltzIJcVksDb+iEuudhynic28l+/JVX3uKjcJkyZcx8GiZ5AOXBsjM6LaOJPfs
 iL6+9cnD0kJ9AFx+JTPeeJeD/7qWykVTxxAhu8gADhrB4mr6WwZEEsym2BxcLbfVisuKw
 NfZT7CXR1b1KLo9U7Hzw+WuXNSpg6ZJ54vxgM6qlkJO1OoW0cfrqwQgRPZeqfhL1DUg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=163.com;
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=HmBjkQLN; 
 arc=none smtp.remote-ip=220.197.31.3
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.3;
 helo=m16.mail.163.com; envelope-from=hyyoxhk@163.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=163.com header.i=@163.com
 header.a=rsa-sha256 header.s=s110527 header.b=HmBjkQLN
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3159380849
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=9k
 KdoLWrUovSnKqxJyGrfpyMemt8Zj5vVIIfEo5IUio=; b=HmBjkQLNywsUdLPylD
 9suKSj37tTBDDJHSgK41f1DY9CqCWYyHtgGKHUCdcWWLE0AddF4tXDuFcSfp99+d
 C8uV5kXC9KislfHkUzza3fMM58f3Yq8YdHr/Wrg2HqlTW8TthfPVlPkDApxmkTul
 frMtC4BHWAjigJvST7wN/uhL0=
Received: from nh50.. (unknown [])
 by gzsmtp5 (Coremail) with SMTP id QCgvCgDnT4brK85qiFBwEQ--.17862S3;
 Tue, 13 Oct 2026 21:02:36 +0800 (CST)
From: He Yong <hyyoxhk@163.com>
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, trini@konsulko.com, alchark@flipper.net,
 daniel@makrotopia.org, jbx6244@gmail.com, quentin.schulz@cherry.de
Subject: [PATCH v2 1/2] image: Bound legacy script parsing by the image size
Date: Tue, 13 Oct 2026 21:02:34 +0800
Message-ID: <20261013130235.3172204-2-hyyoxhk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013130235.3172204-1-hyyoxhk@163.com>
References: <20261013130235.3172204-1-hyyoxhk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: QCgvCgDnT4brK85qiFBwEQ--.17862S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gw13ZrWkCw4UZF47JrW8WFg_yoWxXF18pa
 4Du3WYgws8Jr1fXr93uF4rZr13CFs5JFy5trW7Cas8Jr4aqF4kXF4akF98Za97JrWrZ3sY
 kF1qvFWUCrn5trJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzhFxUUUUU=
X-Originating-IP: [2409:8a62:2b4:2720:a989:5f4f:c438:1387]
X-CM-SenderInfo: pk1105lkn6il2tof0z/xtbCzwxUJ2rOK+wHWQAA3N
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

The legacy script parser ignores its size argument and walks a length
table until it finds a zero word. A malformed image can run this walk
past the image buffer or declare a script longer than the remaining data.

Check known header and payload sizes before CRC verification, bound the
length-table walk by the declared payload, and check the script length.
When the caller does not know the buffer size, as with source, still use
the header's declared data size to bound the length table and contents.

Add C regression tests for both verification settings and for source.

Signed-off-by: He Yong <hyyoxhk@163.com>
---
 boot/image-board.c | 30 +++++++++++++++++-
 include/image.h    |  3 +-
 test/boot/image.c  | 77 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/boot/image-board.c b/boot/image-board.c
index 7602f5bfaaa..069b94d28cc 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -988,15 +988,26 @@ int image_locate_script(void *buf, int size, const char *fit_uname,
 	int noffset;
 	int verify;
 	ulong len;
+	uint remaining;
 	u32 *data;
 
 	verify = env_get_yesno("verify");
 
+	/* Format detection checks the FDT header, not just its magic. */
+	if (size && size < sizeof(struct fdt_header)) {
+		puts("Truncated script image\n");
+		return 1;
+	}
+
 	switch (genimg_get_format(buf)) {
 	case IMAGE_FORMAT_LEGACY:
 		if (!IS_ENABLED(CONFIG_LEGACY_IMAGE_FORMAT)) {
 			goto exit_image_format;
 		} else {
+			if (size && size < sizeof(*hdr)) {
+				puts("Truncated script header\n");
+				return 1;
+			}
 			hdr = buf;
 
 			if (!image_check_magic(hdr)) {
@@ -1009,6 +1020,13 @@ int image_locate_script(void *buf, int size, const char *fit_uname,
 				return 1;
 			}
 
+			remaining = image_get_data_size(hdr);
+			if ((size && remaining > size - sizeof(*hdr)) ||
+			    remaining < 2 * sizeof(*data)) {
+				puts("Truncated script data\n");
+				return 1;
+			}
+
 			if (verify) {
 				if (!image_check_dcrc(hdr)) {
 					puts("Bad data crc\n");
@@ -1035,7 +1053,17 @@ int image_locate_script(void *buf, int size, const char *fit_uname,
 			 * component, so seek past the zero-terminated sequence
 			 * of image lengths to get to the actual image data
 			 */
-			while (*data++);
+			do {
+				if (remaining < sizeof(*data)) {
+					puts("Truncated script length table\n");
+					return 1;
+				}
+				remaining -= sizeof(*data);
+			} while (*data++);
+			if (len > remaining) {
+				puts("Truncated script contents\n");
+				return 1;
+			}
 		}
 		break;
 	case IMAGE_FORMAT_FIT:
diff --git a/include/image.h b/include/image.h
index 5248ca98d41..efb0e0e68c7 100644
--- a/include/image.h
+++ b/include/image.h
@@ -840,7 +840,8 @@ static inline void fit_verity_free(struct bootm_headers *images) {}
  * image_locate_script() - Locate the raw script in an image
  *
  * @buf: Address of image
- * @size: Size of image in bytes
+ * @size: Size of image in bytes, or 0 if unknown. Legacy length tables and
+ *	script contents are also bounded by the data size in the image header.
  * @fit_uname: Node name of FIT image to read
  * @confname: Node name of FIT config to read
  * @datap: Returns pointer to raw script on success
diff --git a/test/boot/image.c b/test/boot/image.c
index 2c6d9dcbc22..c056b42df4a 100644
--- a/test/boot/image.c
+++ b/test/boot/image.c
@@ -6,7 +6,11 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
+#include <command.h>
+#include <env.h>
 #include <image.h>
+#include <mapmem.h>
+#include <u-boot/crc.h>
 #include <test/ut.h>
 #include <linux/libfdt.h>
 #include "bootstd_common.h"
@@ -100,3 +104,76 @@ static int test_image_phase(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(test_image_phase, 0);
+
+/* Recompute checksums after changing the legacy length table or payload. */
+static void script_checksums(struct legacy_img_hdr *hdr)
+{
+	image_set_dcrc(hdr, crc32(0, (void *)image_get_data(hdr),
+				  image_get_data_size(hdr)));
+	image_set_hcrc(hdr, 0);
+	image_set_hcrc(hdr, crc32(0, (void *)hdr, sizeof(*hdr)));
+}
+
+/* Bound both known buffers and source's unknown-size images by their header. */
+static int image_legacy_script_bounds(struct unit_test_state *uts)
+{
+	struct {
+		struct legacy_img_hdr hdr;
+		u32 lengths[2];
+		char script[4];
+	} image;
+	struct legacy_img_hdr *hdr = &image.hdr;
+	char *data;
+	uint len;
+	int size, verify;
+
+	if (!IS_ENABLED(CONFIG_LEGACY_IMAGE_FORMAT))
+		return -EAGAIN;
+	for (verify = 0; verify < 2; verify++) {
+		ut_assertok(env_set("verify", verify ? "yes" : "no"));
+		memset(&image, 0, sizeof(image));
+		image_set_magic(hdr, IH_MAGIC);
+		image_set_type(hdr, IH_TYPE_SCRIPT);
+		image_set_size(hdr, sizeof(image) - sizeof(*hdr));
+		image.lengths[0] = cpu_to_uimage(sizeof(image.script));
+		memcpy(image.script, "true", sizeof(image.script));
+		script_checksums(hdr);
+		ut_assertok(image_locate_script(&image, sizeof(image), NULL,
+						NULL, &data, &len));
+		ut_asserteq(sizeof(image.script), len);
+		ut_asserteq_ptr(image.script, data);
+		ut_assertok(cmd_source_script(map_to_sysmem(&image), NULL, NULL));
+
+		/* A known size must bound reads before header/data CRC checks. */
+		for (size = 1; size < sizeof(image); size++)
+			ut_asserteq(1, image_locate_script(&image, size, NULL,
+							   NULL, &data, &len));
+
+		/* Missing terminator: do not walk into the script or beyond it. */
+		memset(image.lengths, 0xff, sizeof(image) - sizeof(*hdr));
+		script_checksums(hdr);
+		ut_asserteq(1, image_locate_script(&image, sizeof(image), NULL,
+						   NULL, &data, &len));
+		ut_asserteq(1, image_locate_script(&image, 0, NULL, NULL,
+						   &data, &len));
+		ut_asserteq(CMD_RET_FAILURE,
+			    cmd_source_script(map_to_sysmem(&image), NULL, NULL));
+
+		/* A terminated table cannot name a script beyond the payload. */
+		image.lengths[0] = cpu_to_uimage(sizeof(image.script) + 1);
+		image.lengths[1] = 0;
+		script_checksums(hdr);
+		ut_asserteq(1, image_locate_script(&image, 0, NULL, NULL,
+						   &data, &len));
+
+		/* Reject a payload too short even for the length and terminator. */
+		image_set_size(hdr, sizeof(u32));
+		script_checksums(hdr);
+		ut_asserteq(1, image_locate_script(&image, 0, NULL, NULL,
+						   &data, &len));
+	}
+
+	return 0;
+}
+
+BOOTSTD_TEST(image_legacy_script_bounds, UTF_DM | UTF_SCAN_FDT);

