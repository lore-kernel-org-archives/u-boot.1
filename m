Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73FFCD1297
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 04:29:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 942FC88229;
	Thu, 11 Apr 2024 06:29:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="n+qWO1Xs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29E5288227; Thu, 11 Apr 2024 06:29:03 +0200 (CEST)
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::af])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F54C88229
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 06:29:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1712809740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7mIJlPD/fYwcElW7PtXXO+XgsDkwy8SYfxHm/zU86nk=;
 b=n+qWO1XsR0asjtUNaQIbZyV7w2bNZ6MRNQNN6EjQ5coYLJOSkvbjl2Nce1EB2Nxa+8bEMR
 jCdjt+6W1qbjCLO2NkHGbAVSBcKBjHvTl4bY/wbZR15EGKpA5AwPvTfMw6Ls60RHmIwEpm
 TN/c0LImFKcqfAZCl6NCzpZXScjfBflWRliAbkVlxiDEpP8pXHyfcgQtmizxQ6rtaQZBdh
 Dmy4ZrKDHUoxzsxsHWdtePolGptzI/qFLj7DvHI3mgLDYuxlLI8nn/qAZ0O9hzfm6m3q6V
 eFnRj9IWOwlSK9ULlrzBfrQKkGdUiuqqenW1jBXPUkMZA/h82vbL6P01iPUzCg==
From: John Watts <contact@jookia.org>
Date: Thu, 11 Apr 2024 14:25:32 +1000
Subject: [PATCH RFC 15/15] spl: Support loading FIT images in UBI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-spinand-v1-15-62d31bb188e8@jookia.org>
References: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
In-Reply-To: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1712809597; l=2116;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=p32ZDMbTt+1k+r9iLkbLQ+GXhRsHxSBhxzI9xAFqIAo=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAC4WZkakmxAMkzrmuW3sI5At
 V6XkSVjAsRsXSULDIzM9iJixbAsH9HrF22mQlDwEDXHz28wG3p3Htp4HY/tzHBgUAAOmK
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:6LBQmZH5u7i/edmEZXzCTwCrpSevs/ZshZxNmlD1thY
X-Migadu-Flow: FLOW_OUT
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The FIT loader doesn't support access through UBI, so load the FIT
image ourself in to memory then boot it normally.

Signed-off-by: John Watts <contact@jookia.org>
---
 common/spl/spl_ubi.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/common/spl/spl_ubi.c b/common/spl/spl_ubi.c
index 72b4b195ed..b64f595160 100644
--- a/common/spl/spl_ubi.c
+++ b/common/spl/spl_ubi.c
@@ -12,6 +12,16 @@
 #include <ubispl.h>
 #include <spl.h>
 
+static ulong ram_spl_load_read(struct spl_load_info *load, ulong sector,
+			       ulong count, void *buf)
+{
+	char *ubi_contents = load->priv;
+
+	memcpy(buf, ubi_contents + sector, count);
+
+	return count;
+}
+
 int spl_ubi_load_image(struct spl_image_info *spl_image,
 		       struct spl_boot_device *bootdev)
 {
@@ -69,10 +79,11 @@ int spl_ubi_load_image(struct spl_image_info *spl_image,
 		puts("Loading Linux failed, falling back to U-Boot.\n");
 	}
 #endif
-	header = spl_get_load_buffer(-sizeof(*header), sizeof(header));
+	/* Ensure there's enough room for the full UBI volume! */
+	header = (void *)CONFIG_SYS_LOAD_ADDR;
 #ifdef CONFIG_SPL_UBI_LOAD_BY_VOLNAME
 	volumes[0].vol_id = -1;
-	strncpy(volumes[0].name,
+	strlcpy(volumes[0].name,
 		CONFIG_SPL_UBI_LOAD_MONITOR_VOLNAME,
 		UBI_VOL_NAME_MAX + 1);
 #else
@@ -81,8 +92,23 @@ int spl_ubi_load_image(struct spl_image_info *spl_image,
 	volumes[0].load_addr = (void *)header;
 
 	ret = ubispl_load_volumes(&info, volumes, 1);
-	if (!ret)
-		spl_parse_image_header(spl_image, bootdev, header);
+	if (ret)
+		goto out;
+
+	spl_parse_image_header(spl_image, bootdev, header);
+
+	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) &&
+	    image_get_magic(header) == FDT_MAGIC) {
+		struct spl_load_info load;
+
+		printf("Found FIT\n");
+		load.priv = (char *)header;
+		load.read = ram_spl_load_read;
+		spl_set_bl_len(&load, 1);
+
+		ret = spl_load_simple_fit(spl_image, &load, 0, header);
+	}
+
 out:
 #ifdef CONFIG_SPL_SPINAND_SUPPORT
 	if (bootdev->boot_device == BOOT_DEVICE_SPINAND)

-- 
2.44.0

