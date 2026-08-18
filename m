Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D5AC5DF7D
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 13:50:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E5644089B;
	Tue, 18 Aug 2026 13:50:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cFBA2x-5HCqx; Tue, 18 Aug 2026 13:50:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 737554087A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787061049;
	bh=/V32QL7KxpWe7fzvif8H5krjhcpItkSX/pSJudFCrn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GyJou49hYBLjnUWVnOOnWY2kE5uJUxRJmdo5OI0EJpsGGxqUDcBmjbIHVLPoTjvlG
	 PH66haqpjOdsT0oCHJ7PKcgFKUK+b8n0sO8SHu6DHiCosSELsuoYBjvhVMoePNUMkW
	 TNkrLmeQAmFm+LuFCK9LGNIf/sjOva06cL/6AS1no0jt5cGEDIEsKxAnqgBr2QzxJF
	 DZwm5CGaLznO4otGdd64mSWpn2e8HXQmq6my49lEUhP1RWvweXr0WColeP4By+hxPb
	 fBViKJToMwXhWl9jmtvJv1lpRVJOu2Mw/Ltm7l0C/geoWGYWxBGlC2BnLvh3hZrG6s
	 I0GkMIpqBBtZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 737554087A;
	Tue, 18 Aug 2026 13:50:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C7E42B2
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:23:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 42A77407F0
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:23:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IZVsIZ-SE_1n for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 13:23:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2BC9C40760
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2BC9C40760
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=GVVq7lhk
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2BC9C40760
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:23:56 +0000 (UTC)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6BBB93F8AE
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1787059435;
 bh=/V32QL7KxpWe7fzvif8H5krjhcpItkSX/pSJudFCrn0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=GVVq7lhkCTp8mjzsaUr3Ok/Pl6OQEysDG/eFa074+EvyhYcjDnteH0SvGkC/jmf6i
 bECmlGWGW8oE12T3QgfwLedgk1tEXiWEcQNdntXUnW3yDEIP1YyrRCOeJZOvkmHjnD
 /afrPv4Smj77kWtFEmPlRiQM9K69DSzXtspipI7XfNHI8b5X8Git2kE90Dw1GrEMtc
 IgnkpBPFPoOxt6ZroXRZpyrsnmIWXx56AtSS4GrbtZJjAG8LAszGnhAMKKlS09LKC2
 sbh+DEv0qYAjxYJhQnA2f+6IF6gO7CVZ1S40zV1yzySyTlNeoxtLii+FEIQ+dO5N7S
 HWMs1qbT/KJo+yBUGcVlgYEEdxgXZGP8Ui0NJSwacfTAbgAiXV/Vh8FrZ5U5VTg5f4
 V0spIiGUeIPYHlC1MwlzBw+z7nddRF6cqpWB9viKRMVQsP+g9giDQOsiCnsGHUiD/Q
 CekJyFZNHd8seFxnvoXpYXrthejgpNnyWNe8PPazxjg71soVXr3jBLKPrA6xnK0X0f
 ZUxqayseX/Y69cKSu53NiVOharpcMRjrpd1OyrUncV1fJhaikg6tiIn164I7h8puSQ
 SYQFu1EQmCDWFj4/TFfjmjnjP2hfsu0Q/pjS+SXTYav03vjo4Zux4fTORtaFwnFG8V
 yw34o0XvflK3IWlVY5GkJTH4=
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-84f0d3ab2f4so3521309b3a.1
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 06:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787059434; x=1787664234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/V32QL7KxpWe7fzvif8H5krjhcpItkSX/pSJudFCrn0=;
 b=fD9CBgnscfCI5i6sS0ClrGEYLrMMoG3OJk6vMPrr9tsv3D2R0vRAbnz9OLrCFqY2wo
 F1pVKY6ysyHEBqr3R5Mmisv+pFedMKNPUSJHiMr+klhNMWMCJSPBNNCv+UHAP4rgrnB6
 yaWQsGtTmiqJj7iiBipy07H/uRouM3XrXGukhT40D9ZiUafLoA4GPPkyB6kdVkGXaSz7
 jd331kiYU+8e+1IkxRFLcyDC6oeqlTfaRZqCGJ4dYEzPsFMx4WoJYnGht8EwMSwbRQWY
 IbxaOpH9/zjOreENeSPp47lsao6yKiAjs/iwjSDIZECRO+5Yr5W7RUtzQCKZudXYBEA9
 awjg==
X-Gm-Message-State: AOJu0YyJ+KtESiVbP+z9xt/0bg+L7msVY1+uO6JbREeZTr6fFByNJU1V
 jNRhcqG6g2YrJH8tUVHMkxIgI5bFhn/vwkLZ9nMPjLxTAGbzuwJLFB3RT8Yz7Kpa4lA1QZh79Me
 Wp5kyHyNvmBUY7f85jXBslCuRlHbIPdnifAtC0HgHOSViVb3bsi/OEf9MkAdgMDhEN+N6amGYRa
 8Ai8wjsXcdbqRsos/gIg==
X-Gm-Gg: AR+sD10OvYewuiWHAkA06OUFCK9IcaBuXnG8Vr+c913W7oJIxZxS4JTlAIz95+SUfOv
 jvrIUEBqILPWPbD4dJbWLgYoR/AltljC1lrefqOoHicsjWONjjKNcxXzkkQjoMPZp0J8ZEuACeA
 ClqLKKBo3F8bhoTwJxQMbKM1lnEjCnvSQ0TY+K6WLpSr9T2Eip+EIbIte1c/Yfx0FxW3LDGEQlD
 /uUtsfzN3HbOHmQzkmPMPilqprTlp95DvFJWGJMhuEuaX8+lmC7mPmKzZDlGv867kHZysQcF5kd
 yUzmoevhNgXOUa1P993UQXs/3823+BhbJlcmmmIYmaMc8+O+1qgVM7VXXGHtCCpwUaFI99brUvc
 cZcqDNlbM71ICyaD47G8LddPjJozh4ohqKAYSi1ClrhqLp+FS
X-Received: by 2002:a05:6a00:1ca6:b0:846:de21:3da4 with SMTP id
 d2e1a72fcca58-84fde367c8emr37938411b3a.3.1787059433804; 
 Tue, 18 Aug 2026 06:23:53 -0700 (PDT)
X-Received: by 2002:a05:6a00:1ca6:b0:846:de21:3da4 with SMTP id
 d2e1a72fcca58-84fde367c8emr37938314b3a.3.1787059433394; 
 Tue, 18 Aug 2026 06:23:53 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b6fc0e84sm1515818b3a.43.2026.08.18.06.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 06:23:52 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, nora.schiffer@ew.tq-group.com,
 Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/8] bootm: size the noload zstd decompression buffer from
 Frame_Content_Size
Date: Tue, 18 Aug 2026 13:23:17 +0000
Message-ID: <20260818132332.324173-4-aristo.chen@canonical.com>
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

Add a small static helper bootm_zstd_uncompressed_size() that returns
the frame's Frame_Content_Size via zstd_get_frame_header(), and wire
it into bootm_load_os() as a new case in the size-hint switch
alongside the existing gzip case.

zstd_get_frame_header() and the frame-parsing code behind it ship
with the zstd decompressor, which is already linked into any board
that enables ZSTD, so calling it here adds no new zstd code to the
image. The returned value is used as an allocation hint only and is
capped by the caller; full validation still runs inside
zstd_decompress() during the actual decompression.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/bootm.c | 44 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index ab787979f2e..e4284fe9844 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -25,6 +25,7 @@
 #include <asm/io.h>
 #include <asm/unaligned.h>
 #include <linux/sizes.h>
+#include <linux/zstd.h>
 #include <tpm-v2.h>
 #include <tpm_tcg2.h>
 #if defined(CONFIG_CMD_USB)
@@ -657,6 +658,31 @@ static ulong bootm_gzip_uncompressed_size(const void *src, ulong len)
 }
 #endif
 
+#if CONFIG_IS_ENABLED(ZSTD)
+/*
+ * Return the zstd frame's Frame_Content_Size, or 0 if the header does
+ * not parse or the size is absent. zstd_get_frame_header() and the
+ * frame-parsing code behind it are part of the zstd decompressor that
+ * is already linked into any board with ZSTD enabled, so the call adds
+ * only the call site. The value is an allocation hint; the decoder
+ * stays authoritative during the actual decompression.
+ */
+static ulong bootm_zstd_uncompressed_size(const void *src, ulong len)
+{
+	zstd_frame_header hdr;
+	size_t ret;
+
+	ret = zstd_get_frame_header(&hdr, src, len);
+	if (zstd_is_error(ret) || ret > 0)
+		return 0;
+	if (hdr.frameContentSize == ZSTD_CONTENTSIZE_UNKNOWN ||
+	    hdr.frameContentSize == ZSTD_CONTENTSIZE_ERROR ||
+	    hdr.frameContentSize > ULONG_MAX)
+		return 0;
+	return (ulong)hdr.frameContentSize;
+}
+#endif
+
 static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 {
 	const struct image_info os = images->os;
@@ -678,12 +704,12 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 	/*
 	 * For a "noload" compressed kernel we need to allocate a buffer large
 	 * enough to decompress in to and use that as the load address now.
-	 * For a gzip stream the trailing 4-byte ISIZE field holds the
-	 * original size modulo 2^32; when it is present and within
-	 * CONFIG_SYS_BOOTM_LEN, allocate exactly that. Otherwise fall back
-	 * to an 8x multiplier, which comfortably covers what zstd and xz
-	 * achieve on real kernels with headroom for well-compressed
-	 * payloads. Use an alignment of 2MB since this might help arm64.
+	 * When the compressed stream records its uncompressed size and that
+	 * value is within CONFIG_SYS_BOOTM_LEN, allocate exactly that.
+	 * Otherwise fall back to an 8x multiplier, which comfortably covers
+	 * what zstd and xz achieve on real kernels with headroom for
+	 * well-compressed payloads. Use an alignment of 2MB since this
+	 * might help arm64.
 	 */
 	if (os.type == IH_TYPE_KERNEL_NOLOAD && os.comp != IH_COMP_NONE) {
 		phys_addr_t addr;
@@ -695,6 +721,12 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 			hdr_size = bootm_gzip_uncompressed_size(image_buf,
 								image_len);
 			break;
+#endif
+#if CONFIG_IS_ENABLED(ZSTD)
+		case IH_COMP_ZSTD:
+			hdr_size = bootm_zstd_uncompressed_size(image_buf,
+								image_len);
+			break;
 #endif
 		default:
 			break;
-- 
2.43.0

