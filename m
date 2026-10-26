Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21523606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=B12J6bh4;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=jwHPvPS5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DCADE80E4E;
	Mon, 26 Oct 2026 14:02:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mst-tXUethpc; Mon, 26 Oct 2026 14:02:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C4F6B80E51
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793023368;
	b=dtQloRSMZjQ5MekWsKIcYilXrXpHtoNSLQGzPTsoMGQ/iOK62Qg+n9RhfpxXzKonRwvP
	 E2JcFGzjFUazvU31H22k+iA8mOhLshuFNGLeXUNKaS9Obsl9qohNRbokANvCRUsXeXMOp
	 0bgCY71KcWuxkruTmbc0wDBbPgmfRyRBVaQdQwJKXyR+axWnMyqALW1xWd9rYZlP2CK+o
	 UFflQnVu2gd6XPsErIOfbWKfnn+/wziHokWwYDY9N6qOinc73HgGJYK0ltmG7oUY/3FI5
	 eOyH8p2EwFKgedLbXlOM/w26znRYLjoMS5wjDCv7O0iKngOJzDioUKmW5x7QEzajHQg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793023368;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iKzC6xYzw4HcdrXDrzD9ALB7u/9X1I/SdXWv+tqSyn0=;
	b=IN5h82fTh9kfcp9KRuC3IG27P9Ix8WOwSkKhzcYb44ySWmzFQy+Tr5TqM05HTGHisZ6S
	 X5jk1GQJqfO3GDciMfIieNuvOkugiYq9/Av95mvn3N1HXAUgUp5UnaIzzOqCDG7Cbh6Gg
	 zNGKmQJt2EpzQGL9joiWjZTRdxNp3BMsxSrhOEuGwSFgFOs2cLqhJNv8MjDpCZzONM8dd
	 2AB3cWofgik2f6Io02yQ8rY8fQWCQCOY5yd/7wYZP0p6gPs3PFoFpEXpCgxbSUBj4Kx0/
	 lHTbxNQJM3ov0XAzNLIhJGl0PlywteZxMj7czgqiM8Vr+LcfDXaOldd1SYV6S2sjKzg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=jwHPvPS5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793023368;
	bh=iKzC6xYzw4HcdrXDrzD9ALB7u/9X1I/SdXWv+tqSyn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B12J6bh4FenZ2qMT73rzUzRoRddOZuzEKXLqK/RRtWATpqoEcbJ7pmSn9nDju5uUR
	 X2zQ8zkDTps/MGH02zMgWPdV7bmITWnw+kjyw/CYumuBsT17jUwdxT5FLZvymxvwe3
	 3vHTY0l/d80I7d4AkGzuZujUqxxU89yB8jwHu+6w0+RbjUUAD1uphV1MeMP+NWu2nM
	 4jahUtks77Hb3mqY/fyWLmbLZCsXdGvB83iMR5vGHyCMmKQvs6T0NuzreW4JENDZfv
	 BTz9/O0Qq+N9dYFlcKN7lApumK1v0L/0StYPpO8SUO1B5/Ly1ayI2txggVTNTAJ6Ga
	 nIA/IE17NoNLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C4F6B80E51;
	Mon, 26 Oct 2026 14:02:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E3A31279
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:02:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C24EB80E9B
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:02:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wqPa-MUstM1S for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 14:02:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7A6D680E44
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793023364;
 b=O1lhRB+zNl6q1aAuEPl3i8H99Qs0se7+Ziznvei8FQ6DdK6IYIUVjx3KzMv9vLQ0FpFz
 sTeS5dA7Byuh8JQc2Qis+cV7cp49r6/b9cpcY4FSGnJvdHBd55CugpVNlbPIBbxLH5sEX
 bqs8Pddyb7Fh4L49KcrhH21KP9RiIiB8lJcZt9o1pjIAl5QyBSHcmTQuzgRJgNJAKV5ZS
 +iOiRFuI0JrTlwBgTlDphtEIhiWO/hX3/tIm75dyKneP6Qo0MeFIV0DwUwfthgg3seAA4
 L0yEz8HmB1vjJ5Jie5t4G9GYZAtNL0hbAzvpOc9xBFdphowxkDizumCeyqT59E4uvGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793023364;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
 X-CM-SenderInfo;
 bh=iKzC6xYzw4HcdrXDrzD9ALB7u/9X1I/SdXWv+tqSyn0=;
 b=prVZPzV0kZlWIH/PSQN3w4EzDroLM2MLxR4rsvHA0ays/7ZyxZrLfWB8SAreZ+2HqYsx
 EvQM1UvjdSWtvS6hiCZjmPEhY/MUisHb9z3CbFXkEFOTRTh6gW7YMKjcDkLN6AT1CT2Af
 ZOCFeIw+Vfchv73/Se3rtkE/mei0+hM0haDQj1htO3bdTfgmhCjoW1ngXbWkQRVwxtvaG
 V5CaNDkW4AS/SbxcmcFtNgfY2Oub6TWajZ6AFAcJsdDcD6t5YEcyBINN8i6Qa5ycy89Or
 aTkFYuYZp7sEUtNzNk9UwJAE9h4SWSJWhMJbFekGnaN8hPQkN9IjRK2YNAiacDhJobw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=163.com;
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=jwHPvPS5; 
 arc=none smtp.remote-ip=220.197.31.5
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.5;
 helo=m16.mail.163.com; envelope-from=hyyoxhk@163.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=jwHPvPS5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A6D680E44
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=iK
 zC6xYzw4HcdrXDrzD9ALB7u/9X1I/SdXWv+tqSyn0=; b=jwHPvPS5Me8gC/za3G
 1k/0E3UUQgfC4+dAfJJqdAf1nBjxv6m39s2sc6wGsNxGI37FShtssXYXKtQBU2PB
 BgvPPyfNMKp8DmlJcHzrW8/5WSZQL6qrC0Ohwwt+v6aQxYULU59MJinQm3Jy5f+s
 WJX3HnGOVqZ7VZh4f1gOdb78o=
Received: from nh50.. (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wD3N95qXd9qrufGCw--.5946S3; 
 Mon, 26 Oct 2026 22:02:20 +0800 (CST)
From: He Yong <hyyoxhk@163.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 1/4] image: Bound FIT script checks by the image size
Date: Mon, 26 Oct 2026 22:02:15 +0800
Message-ID: <8226cb148063df42865fb3f0bdc832d747b8beea.1793020986.git.hyyoxhk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793020986.git.hyyoxhk@163.com>
References: <cover.1793020986.git.hyyoxhk@163.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3N95qXd9qrufGCw--.5946S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxKF18ZryUGF4xCFWDuFy5XFb_yoWxKF18pa
 4kua1a9rZ5CF1rX3s3X3WrZr1S9r1rJFy5GayfC345AFsIqFZ5XF4akFyUWa17Wrs5Aw15
 Gr90vayUCr1DKrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UAEfOUUUUU=
X-CM-SenderInfo: pk1105lkn6il2tof0z/xtbC8gwF12rfXWxkwQAA3N
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

FIT verification can follow malformed metadata or external-data offsets
beyond a buffer whose size is known to the caller.

Pass the known buffer size to fit_check_format() so FIT_FULL_CHECK
validates the complete structure against the actual buffer. Reject
external data in all subimages of known-size FITs before verification,
even when verify is disabled. Keep these checks in the shared parser so
filesystem and raw-partition scripts receive the same protection. Leave
unknown-size FIT handling unchanged.

Add C regression coverage with verification enabled and disabled, plus
source coverage. Clear verify even when a test helper assertion fails.

Signed-off-by: He Yong <hyyoxhk@163.com>
---
Changes in v3:
- Replace the legacy parser changes with shared known-size FIT validation.
- Reject external data before verification and cover both verify settings.

 boot/image-board.c |  19 +++++++-
 test/boot/image.c  | 118 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+), 1 deletion(-)

diff --git a/boot/image-board.c b/boot/image-board.c
index 7602f5bfaaa..15a79aa513e 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -1043,11 +1043,28 @@ int image_locate_script(void *buf, int size, const char *fit_uname,
 			goto exit_image_format;
 		} else {
 			fit_hdr = buf;
-			if (fit_check_format(fit_hdr, IMAGE_SIZE_INVAL)) {
+			if (fit_check_format(fit_hdr,
+					     size ? size : IMAGE_SIZE_INVAL)) {
 				puts("Bad FIT image format\n");
 				return 1;
 			}
 
+			if (size) {
+				int images, node;
+
+				/* Reject external data before any verification reads. */
+				images = fdt_path_offset(fit_hdr, FIT_IMAGES_PATH);
+				fdt_for_each_subnode(node, fit_hdr, images) {
+					if (fdt_getprop(fit_hdr, node,
+							FIT_DATA_OFFSET_PROP, NULL) ||
+					    fdt_getprop(fit_hdr, node,
+							FIT_DATA_POSITION_PROP, NULL)) {
+						puts("External FIT script data is not supported\n");
+						return 1;
+					}
+				}
+			}
+
 			if (!fit_uname) {
 				/* If confname is empty, use the default */
 				if (confname && *confname)
diff --git a/test/boot/image.c b/test/boot/image.c
index 2c6d9dcbc22..17b1a4055da 100644
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
@@ -100,3 +104,117 @@ static int test_image_phase(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(test_image_phase, 0);
+
+/* Known-size FITs must be structurally valid and contain all their data. */
+static int check_fit_script_bounds(struct unit_test_state *uts)
+{
+	static const char script[] = "true";
+	static const char * const external_props[] = {
+		FIT_DATA_OFFSET_PROP, FIT_DATA_POSITION_PROP,
+	};
+	char fit[1024] __aligned(8), bad[1024] __aligned(8);
+	const void *expected;
+	char *data;
+	uint len;
+	int images, node, confs, conf, hash, size, i;
+
+	ut_assertok(fdt_create_empty_tree(fit, sizeof(fit)));
+	ut_assertok(fdt_setprop_string(fit, 0, FIT_DESC_PROP, "Script test"));
+	ut_assertok(fdt_setprop_u32(fit, 0, FIT_TIMESTAMP_PROP, 0));
+	images = fdt_add_subnode(fit, 0, "images");
+	ut_assert(images >= 0);
+	ut_assertok(fdt_setprop_string(fit, images, FIT_DEFAULT_PROP, "script"));
+	node = fdt_add_subnode(fit, images, "script");
+	ut_assert(node >= 0);
+	ut_assertok(fdt_setprop_string(fit, node, FIT_TYPE_PROP, "script"));
+	ut_assertok(fdt_setprop(fit, node, FIT_DATA_PROP, script, sizeof(script)));
+	hash = fdt_add_subnode(fit, node, "hash");
+	ut_assert(hash >= 0);
+	ut_assertok(fdt_setprop_string(fit, hash, FIT_ALGO_PROP, "crc32"));
+	ut_assertok(fdt_setprop_u32(fit, hash, FIT_VALUE_PROP,
+				    crc32(0, (const u8 *)script, sizeof(script))));
+	confs = fdt_add_subnode(fit, 0, "configurations");
+	ut_assert(confs >= 0);
+	ut_assertok(fdt_setprop_string(fit, confs, FIT_DEFAULT_PROP, "conf"));
+	conf = fdt_add_subnode(fit, confs, "conf");
+	ut_assert(conf >= 0);
+	ut_assertok(fdt_setprop_string(fit, conf, FIT_SCRIPT_PROP, "script"));
+	ut_assertok(fdt_pack(fit));
+	size = fdt_totalsize(fit);
+	node = fdt_path_offset(fit, "/images/script");
+	ut_assert(node >= 0);
+	expected = fdt_getprop(fit, node, FIT_DATA_PROP, NULL);
+	ut_assertnonnull(expected);
+
+	/* Exercise configuration lookup, direct image lookup and source. */
+	ut_assertok(image_locate_script(fit, size, NULL, NULL, &data, &len));
+	ut_asserteq(sizeof(script), len);
+	ut_asserteq_ptr(expected, data);
+	ut_assertok(image_locate_script(fit, size, "script", NULL, &data, &len));
+	ut_assertok(cmd_source_script(map_to_sysmem(fit), NULL, NULL));
+
+	/* Structural validation follows fit_check_format() configuration. */
+	if (CONFIG_IS_ENABLED(FIT_FULL_CHECK)) {
+		ut_asserteq(1, image_locate_script(fit, sizeof(struct fdt_header) - 1,
+						   NULL, NULL, &data, &len));
+		ut_asserteq(1, image_locate_script(fit, sizeof(struct fdt_header),
+						   NULL, NULL, &data, &len));
+		ut_asserteq(1, image_locate_script(fit, size - 1, NULL, NULL,
+						   &data, &len));
+
+		memcpy(bad, fit, size);
+		fdt_set_totalsize(bad, sizeof(bad) + 1);
+		ut_asserteq(1, image_locate_script(bad, sizeof(bad), NULL, NULL,
+						   &data, &len));
+
+		/* A valid header does not imply a valid structure block. */
+		memcpy(bad, fit, size);
+		*(fdt32_t *)(bad + fdt_off_dt_struct(bad)) = cpu_to_fdt32(0xffffffff);
+		ut_assertok(fdt_check_header(bad));
+		ut_asserteq(1, image_locate_script(bad, size, NULL, NULL, &data, &len));
+	}
+
+	for (i = 0; i < ARRAY_SIZE(external_props); i++) {
+		ut_assertok(fdt_open_into(fit, bad, sizeof(bad)));
+		node = fdt_path_offset(bad, "/images/script");
+		ut_assert(node >= 0);
+		ut_assertok(fdt_delprop(bad, node, FIT_DATA_PROP));
+		ut_assertok(fdt_setprop_u32(bad, node, external_props[i],
+					    0xfffffffc));
+		ut_assertok(fdt_setprop_u32(bad, node, FIT_DATA_SIZE_PROP,
+					    sizeof(script)));
+		ut_asserteq(1, image_locate_script(bad, sizeof(bad), NULL,
+						   NULL, &data, &len));
+
+		/* Reject external data even in an unselected image. */
+		ut_assertok(fdt_open_into(fit, bad, sizeof(bad)));
+		images = fdt_path_offset(bad, FIT_IMAGES_PATH);
+		ut_assert(images >= 0);
+		node = fdt_add_subnode(bad, images, "external");
+		ut_assert(node >= 0);
+		ut_assertok(fdt_setprop_u32(bad, node, external_props[i],
+					    0xfffffffc));
+		ut_asserteq(1, image_locate_script(bad, sizeof(bad), NULL,
+						   NULL, &data, &len));
+	}
+
+	return 0;
+}
+
+static int image_fit_script_bounds(struct unit_test_state *uts)
+{
+	int ret, verify;
+
+	if (!IS_ENABLED(CONFIG_FIT))
+		return -EAGAIN;
+
+	for (verify = 0; verify < 2; verify++) {
+		ut_assertok(env_set("verify", verify ? "yes" : "no"));
+		ret = check_fit_script_bounds(uts);
+		ut_assertok(env_set("verify", NULL));
+		ut_assertok(ret);
+	}
+
+	return 0;
+}
+BOOTSTD_TEST(image_fit_script_bounds, 0);
-- 
2.43.0

