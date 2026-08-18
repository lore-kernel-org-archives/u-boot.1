Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBFFC5DF7E
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 13:50:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 703A8810C8;
	Tue, 18 Aug 2026 13:50:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8pU-zA5zrH3P; Tue, 18 Aug 2026 13:50:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A5D2F810B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787061046;
	bh=2rsZCWRaf0AzvuJIMMsJwDLE/n7B67tcvaIvPs+YFu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jFB96N7KvCEkM8/kieqNSsC1d2DMpm+DwFhlVxjamZ6wUWGtDuKzhF4P5OxzqK/+C
	 J57bis8mNs3039NCAEVl/EGFSY8dINkTqFlDB5H0mMNE7oimBzV6U46P0D0hmh/+In
	 ExWSvJY6yFT5tVwXJoyhpYvNHQq/MJciYxiF6OxDyJ8q05AzzKkDgpcxsQzg/4/NiG
	 EhA4xsI7C6ZfCCAEmd4PhExiQ0BplCvuRcadEeN4PAiLA4dSVeQKUQ+JmduPoGfWBn
	 k/IfKOLdxUAnqgaAIpmP0vY2LkWDpJ4Pv043ZyP9btnsFtRLv0nHAgiTXzjHRQckgA
	 mOr5d2Qu5z2vw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5D2F810B7;
	Tue, 18 Aug 2026 13:50:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BEBB6194
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:23:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B0F3D40159
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:23:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MHX3QrOmnbWG for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 13:23:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0A87F400EC
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0A87F400EC
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=Uv8BLcMJ
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0A87F400EC
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:23:52 +0000 (UTC)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B0B963F8AE
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1787059430;
 bh=2rsZCWRaf0AzvuJIMMsJwDLE/n7B67tcvaIvPs+YFu0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Uv8BLcMJMWUtAlaRCft4pLFWYDKf3y+B9CMwlX/TxuVBbtri5W3YrGlenOAB4p0kX
 zFMU0K65/b9QFHEKQgsH8TVElcgqJz/Chd8DC3lIHyAnEZGYkNVU7RnMJSLTWFQAVp
 aN85YBWyP16Q2ABuvQYy12ROijF77A/sNMQLj6G9kVCvmh+XA+dwORlhj/Sosa/Stg
 9BdgQfdJeQli7YQxJNrCD/P/8aoWBtnvGSbVa1ZF8QZK5J83mAcf3ItVeYHl2hrwh2
 lv15ymDkuVJsFpRWv5DBAfdy0rXyrpPwAePiwD41HOwPHGCC52nuB/Ku7pm5oBgiV3
 9Cg8cj24cso2DO5zJAJmTKeeZgUyFD4EtEw/oe/inOxzNEE4s5nhAqUzfzhRIE25zC
 5dbGq2j7UhLrafbEySPEeo8O9oYOj7LR1GMFFtJ0WdBq9ZJO6oLStQxGJs4/OY3d6D
 X16yf45SRNHoPz5YY78oVyTtVrmj9yoRkzH8xCnU5TDjoX/zueOToSi7XznHJbx/Gc
 6M3sErT5l+ZL7H60CcpHtIbinIEwEY0vTPGLzVIKJtg210EvzRf8PFCZCibtFrUoIP
 mFd4NCH6uKq8N3oj2bfyBUVVnJLsPwWo4rqQZ88VyYhlEmrAcPL0Bo/cjQ1RRyeADE
 t5O7xVWwF5HW8qbCn0HgchyE=
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-84870e7f498so4838797b3a.3
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 06:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787059429; x=1787664229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2rsZCWRaf0AzvuJIMMsJwDLE/n7B67tcvaIvPs+YFu0=;
 b=jm0395oapAFK08lEJTmNc6JUNUXtm62mSKdgaZDGI8WdIof4KmVNV88MaHK45+lPBw
 0xtUuLQHWOiWLAJNiwss+eitUiHZNIPbL3YSIWAJenJlbFah+20P9ScR/sEXhxSQqaSy
 62SBVLxMbMHyWUJ4YvORNH78+0jxWbTKST5EMgYJluCTKuOxlJLxlZvNko9yk536Z4+e
 /3Gn+Z/TO1NomRPGp58IvZmJ+XStGM73/a8ElHAKZYuLxsS2NoXqOJmgAB/WP59a5yyr
 veInS+F8be58HX2DaEtvvVQBUUG3iU3OymQa2HxqzdyYFNpZ1DqsTvbce3AuT4ZGqn6J
 nUVw==
X-Gm-Message-State: AOJu0YwLfoPx2duEyL807i850fnaOKSsWRR1kqSGCbFoqxl1edPW9EoA
 4+g6wehnIMygja/Vsp/hzyx7jXmRKkbR+XiWks+gvsfvy17hV+b0OYtYqZthMWgVClCEWRgJwq/
 8gNiXyGk2coo48j+HkbpBIAZKt9xyBPi38P1QRqXPf/dcoKuUiQR/i+kEg4yX31E5W2GhOYDyYU
 PBl98F41mYXbXOmGhjDw==
X-Gm-Gg: AR+sD127GOtbahJcUgGcLOn/2CNB6LbLxLBF5D+y/+2Obpa8kxcF1Os2eMEFDn5L/Ze
 nBNPrsF6hD21RVFY6FtXFDuAYck9DM83+autSD4W8yt1TgZz8cX32AX7qVGJvaZkJpSwezH00sW
 lmVyNDmsVtb3vCcTx+diDCZnqOe+Btw6eVl2eY79wc7UebVGHEXTItZVKc/pLcxVT0+qU92QsCh
 0h/j034CsPwtRLtD6TDVQabuOVGKLrqqqbjmZC0X7l9CETwxzK7AfGzDURyTuUj8VHMfxjLBYXI
 /9o4QCzE3Tinp+5GTYWojLvaQyfG54mAPtJOyb96Z6ankRFv3lo4pfy8S/41/hmmVR4oGASYh8R
 v5EExoGS5mdQYmF/NmHgeTqqRf00X8wbbdGc+9k5tiP8LzvK/
X-Received: by 2002:a05:6a00:9a9:b0:846:a26:8e0b with SMTP id
 d2e1a72fcca58-84fde521a09mr30616690b3a.18.1787059429015; 
 Tue, 18 Aug 2026 06:23:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:9a9:b0:846:a26:8e0b with SMTP id
 d2e1a72fcca58-84fde521a09mr30616593b3a.18.1787059428545; 
 Tue, 18 Aug 2026 06:23:48 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b6fc0e84sm1515818b3a.43.2026.08.18.06.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 06:23:48 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, nora.schiffer@ew.tq-group.com,
 Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/8] bootm: size the noload gzip decompression buffer from
 ISIZE
Date: Tue, 18 Aug 2026 13:23:15 +0000
Message-ID: <20260818132332.324173-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818132332.324173-1-aristo.chen@canonical.com>
References: <20260809042338.63397-1-aristo.chen@canonical.com>
 <20260818132332.324173-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 18 Aug 2026 13:50:44 +0000
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

For a compressed kernel_noload image, bootm_load_os() allocates a
per-image decompression buffer of ALIGN(image_len * 8, SZ_1M). The 8x
multiplier is a heuristic that comfortably covers what zstd and xz
achieve on real kernels, but a highly compressible payload (say, a
run of zeros) can exceed it and fail decompression.

gzip carries the original size in the last 4 bytes of the stream
(ISIZE, modulo 2^32). Where the compressed image is a gzip stream,
read ISIZE and use ALIGN(hdr_size, SZ_1M) as the buffer, capped at
CONFIG_SYS_BOOTM_LEN because the value is attacker-controlled. For
non-gzip streams or when ISIZE cannot be trusted, fall back to the
existing 8x multiplier.

The size read is done via a small static helper in bootm.c, wired up
via a switch on os.comp so the same pattern can be extended to other
formats without adding a new public interface. The other formats
U-Boot supports (lzma, lz4, zstd) also carry a size hint and are
added in follow-up patches.

Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/bootm.c | 47 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 3bce8586834..ab787979f2e 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -23,6 +23,7 @@
 #include <asm/cache.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
+#include <asm/unaligned.h>
 #include <linux/sizes.h>
 #include <tpm-v2.h>
 #include <tpm_tcg2.h>
@@ -638,6 +639,24 @@ static int handle_decomp_error(int comp_type, size_t uncomp_size,
 #endif
 
 #ifndef USE_HOSTCC
+#if CONFIG_IS_ENABLED(GZIP)
+/*
+ * Return the gzip stream's uncompressed size from its ISIZE trailer, or
+ * 0 if the buffer is not a gzip stream. Only the two magic bytes are
+ * checked, since a fuller validation happens inside gunzip() during
+ * decompression; the caller uses the return value as a size hint only.
+ */
+static ulong bootm_gzip_uncompressed_size(const void *src, ulong len)
+{
+	const u8 *b = src;
+
+	/* Minimum gzip: 10-byte header + 2-byte deflate + 8-byte trailer */
+	if (len < 20 || b[0] != 0x1f || b[1] != 0x8b)
+		return 0;
+	return get_unaligned_le32(b + len - 4);
+}
+#endif
+
 static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 {
 	const struct image_info os = images->os;
@@ -654,17 +673,36 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 	void *load_buf, *image_buf;
 	int err;
 
+	image_buf = map_sysmem(os.image_start, image_len);
+
 	/*
 	 * For a "noload" compressed kernel we need to allocate a buffer large
 	 * enough to decompress in to and use that as the load address now.
-	 * Allow up to 8x compression: this comfortably covers what zstd and xz
-	 * achieve on real kernels, with headroom for well-compressed payloads.
-	 * Use an alignment of 2MB since this might help arm64
+	 * For a gzip stream the trailing 4-byte ISIZE field holds the
+	 * original size modulo 2^32; when it is present and within
+	 * CONFIG_SYS_BOOTM_LEN, allocate exactly that. Otherwise fall back
+	 * to an 8x multiplier, which comfortably covers what zstd and xz
+	 * achieve on real kernels with headroom for well-compressed
+	 * payloads. Use an alignment of 2MB since this might help arm64.
 	 */
 	if (os.type == IH_TYPE_KERNEL_NOLOAD && os.comp != IH_COMP_NONE) {
 		phys_addr_t addr;
+		ulong hdr_size = 0;
 
-		decomp_len = ALIGN(image_len * 8, SZ_1M);
+		switch (os.comp) {
+#if CONFIG_IS_ENABLED(GZIP)
+		case IH_COMP_GZIP:
+			hdr_size = bootm_gzip_uncompressed_size(image_buf,
+								image_len);
+			break;
+#endif
+		default:
+			break;
+		}
+		if (hdr_size && hdr_size <= CONFIG_SYS_BOOTM_LEN)
+			decomp_len = ALIGN(hdr_size, SZ_1M);
+		else
+			decomp_len = ALIGN(image_len * 8, SZ_1M);
 		decomp_limit = BOOTM_DECOMP_LIMIT_PER_IMAGE;
 		err = lmb_alloc_mem(LMB_MEM_ALLOC_ANY, SZ_2M, &addr,
 				    decomp_len, LMB_NONE);
@@ -679,7 +717,6 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 	}
 
 	load_buf = map_sysmem(load, 0);
-	image_buf = map_sysmem(os.image_start, image_len);
 	err = image_decomp(os.comp, load, os.image_start, os.type,
 			   load_buf, image_buf, image_len,
 			   decomp_len, &load_end);
-- 
2.43.0

