Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694C0C5DF74
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 13:50:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EABFC81179;
	Tue, 18 Aug 2026 13:50:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xp7PQWnoLFxt; Tue, 18 Aug 2026 13:50:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 464CE81173
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787061057;
	bh=T2/SHatofqd1vmzRqPauXMY1lFop220ukIgqmCgIWtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hIFN5N7+d+i3ALarmMv7MQz6UyWc+9mUs2xPgWbXsmgoQlSlMl0X+6kDnnvxtJdvw
	 KUHy4aR/iTD3tjizSSgZPFuePsr9hDdFCG4Trwx0oxKEamKLcZiTzfueXE1zm6WQ/F
	 ilYxwlpTFtuzHoPBVFslcYNYSl5j8aPRDO1vjtW+yevjSqCg59lZ3ZgBlyfTOySV6N
	 Lp1SJuDQJ31FOv83mKfOpDkd82fkuvdVOf9nIbpdkGJx/7TE9r1JCjekq/Qd+PsTKP
	 NtrhYLEg/3HkXpYgjy/IRTRlG/YdV8xqskHSiRPPSyG+ZtZM6X9irvO3A0VqzFif+f
	 bq7YUoS0VUelA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 464CE81173;
	Tue, 18 Aug 2026 13:50:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C39012EF
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:24:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B5D0C40159
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:24:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dKiX9Iwxwhia for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 13:24:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A69FC400EC
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A69FC400EC
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=naqFgwws
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A69FC400EC
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:24:07 +0000 (UTC)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1C6573FC36
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1787059446;
 bh=T2/SHatofqd1vmzRqPauXMY1lFop220ukIgqmCgIWtA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=naqFgwwsEjWpbL4jdg+Z8YH7qI/mraZFMHxrNu78+p7pDlLuqxB6lH26WVWk0Aknn
 cLy+zOF9pBwp+8k6TcfL5Bh4h+hRqM75iqBFSTTQr8dRItsKQCf3XkpjMvvtnMFLOq
 50wyaYeAAcE5i8cTRv6pU13kIapMtP0wHu8hDH1silmoUdl6XUEQ0+QNRnilvR7uHh
 sxmNwm2/qfDuAMFK58J45SfEldu7VYth8DRzgHeEn6cDSZ1Vk2dWSHQG6nLPinEIpG
 ATRMDRbITNkQE33k+Bmlty8OHzwhPGgLdwFQ71RbbmpHWj/IkX4THCzr12mKZhg94L
 fBmrlRC4vU1nI5kv7cwfS3hI080uW/NeVyGJwtbiWMfiMsY9qg+CBx78iqkK8Eqj9A
 pLISL7ySa+49lRc4StwxTfANt8IkJ2GWVmbcXge7rM0pRGW0XQuVzOJN6v6QYFBYzd
 d0TXLYQ5ofOIzUxKvt8C76OZ7Bmx8qLQRSg5DwwmQSpuKc0REqyB2C2t5DTV+VrfN4
 EkSnjv40hxIm3dD6dfhUrD/QT2IEzmc/ETCb3TBccbXg9a60bEPkV1h8phlqMmi3TU
 WuqndB2JaLc4TFDYM8+OWn/USFfPo7E2z8zKF3B+uRBg3/Phqyuhu1qYfrEBVBuvRr
 vWvLt6uTLNvGzSRDCer4tulM=
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-84f7002f9afso4046057b3a.3
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 06:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787059444; x=1787664244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T2/SHatofqd1vmzRqPauXMY1lFop220ukIgqmCgIWtA=;
 b=TRpKRp/mY4p+q+3CeWe32XO12ukWbF4PZBkp44+UrOBJ7BohU3ddxKJy0qVV8Zzxiz
 MHTPTorzZl6eI82eKwUzbvSMjm7MVg549k5JDDyNIs/E8UgXBxdRlrZboJVaFklvmPoS
 qsjDPxL2ajxN1ozCFQpJM//0MSOFqkCZif/KkYJHOQH0TG5S0s32JE2c9vmBmNjVM5vT
 SJ+BmA8DOqHsFi9VG/fbF81e7V4l/2K44JTvG+ym3jS7qNXC/QjXRVVkck3oC0lVGYKK
 qPAxhr8buxxIZ4ebuYyNG8qOVoDQ7MFKMlaow7fVWz+KfZSyBqGju3AE1EziFJFyUVpZ
 cIZQ==
X-Gm-Message-State: AOJu0YwNB2q9Mj+Ft/IzO9NyWhxajYxxQNcMJbv+KskPVzatq9zWGz+C
 2b6ZxXdX5oDa4KKNodOUcGzp61zr1gV6JFVznfpDVRrgJMHHO3nYif6JSdguvLs8nyu2znGSaFN
 6d02uLKIU/I9+as1iDoJ3slpLGqzRnTiKiAPeTV+juOGPnix3MTMkNiTc/F2kVeMV492SpgEyD8
 LiWmmDwm54hvBGpkMvew==
X-Gm-Gg: AR+sD11AuPVI12/ACD0qX0PMLLbLsbbTa/gbvA5ai7dM1fCTHPRJ53zIWI8DPIui9yD
 6q6gzIm4ZZuCYPk/OzTrZUBHv9Ttxmh/a9yCdzKq5nZPSu0cnwPu/bXh/8wOKpe2tSGgTvcMzi+
 95wm5MQqURQsI84IFN8vXZiyZPHQjPaIhux6zuNnX2sUlPj0tp6719os02BQHyM3rYpYE+3cw6Z
 UKrlSVGd2Fi2vKF3QENqJBSZBmB0kEkYNgYDqrCEOIw9jZLPf59T8tuEGysUNUH6sOZGNSDtu1P
 NNSGdk3KjW7Lmxvv8Oos+1lhplrS4p8zDZvb8a1cyMzUNjHKfcWBqM2+D9gel4yY+8TBbec/kQM
 eIpKy4rKpRYgb4gmWtslwcPSp+MIZe8m6eOjAZRpq0my0/gko
X-Received: by 2002:a05:6a00:4299:b0:847:93f3:a4b6 with SMTP id
 d2e1a72fcca58-84fde24b8f1mr38469448b3a.17.1787059444483; 
 Tue, 18 Aug 2026 06:24:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:4299:b0:847:93f3:a4b6 with SMTP id
 d2e1a72fcca58-84fde24b8f1mr38469374b3a.17.1787059444094; 
 Tue, 18 Aug 2026 06:24:04 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b6fc0e84sm1515818b3a.43.2026.08.18.06.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 06:24:02 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, nora.schiffer@ew.tq-group.com,
 Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 7/8] bootm: size the noload lzma decompression buffer from
 the header
Date: Tue, 18 Aug 2026 13:23:21 +0000
Message-ID: <20260818132332.324173-8-aristo.chen@canonical.com>
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

Add a small static helper bootm_lzma_uncompressed_size() that reads
the uncompressed size out of the .lzma-alone header, and wire it
into bootm_load_os() alongside gzip, lz4, and zstd.

The .lzma-alone format keeps the uncompressed size in a fixed 8-byte
field right after the 5-byte properties block; a marker of all ones
means the size is unknown, and the caller falls back to the 8x
heuristic in that case. Streaming encoders (xz-utils' 'lzma' shim,
Python's lzma.FORMAT_ALONE) write the unknown marker, while LZMA SDK
style encoders record the real size.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/bootm.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/boot/bootm.c b/boot/bootm.c
index c5bdc909053..758edeb964c 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -26,6 +26,7 @@
 #include <asm/unaligned.h>
 #include <linux/sizes.h>
 #include <linux/zstd.h>
+#include <lzma/LzmaDec.h>
 #include <tpm-v2.h>
 #include <tpm_tcg2.h>
 #if defined(CONFIG_CMD_USB)
@@ -658,6 +659,28 @@ static ulong bootm_gzip_uncompressed_size(const void *src, ulong len)
 }
 #endif
 
+#if CONFIG_IS_ENABLED(LZMA)
+/*
+ * Return the uncompressed size recorded in the lzma stream header, or
+ * 0 if the buffer is too short or the size field carries the "unknown"
+ * marker (0xff..ff). The .lzma-alone format keeps the size in a fixed
+ * 8-byte field right after the 5-byte properties block; nothing else
+ * is validated since the value is only an allocation hint.
+ */
+static ulong bootm_lzma_uncompressed_size(const void *src, ulong len)
+{
+	const u8 *b = src;
+	u64 usize;
+
+	if (len < LZMA_PROPS_SIZE + 8)
+		return 0;
+	usize = get_unaligned_le64(b + LZMA_PROPS_SIZE);
+	if (usize == U64_MAX || usize > ULONG_MAX)
+		return 0;
+	return (ulong)usize;
+}
+#endif
+
 #if CONFIG_IS_ENABLED(LZ4)
 /*
  * Return the lz4 frame's Content_Size, or 0 if the buffer is not an
@@ -752,6 +775,12 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 								image_len);
 			break;
 #endif
+#if CONFIG_IS_ENABLED(LZMA)
+		case IH_COMP_LZMA:
+			hdr_size = bootm_lzma_uncompressed_size(image_buf,
+								image_len);
+			break;
+#endif
 #if CONFIG_IS_ENABLED(LZ4)
 		case IH_COMP_LZ4:
 			hdr_size = bootm_lz4_uncompressed_size(image_buf,
-- 
2.43.0

