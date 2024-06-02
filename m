Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5096C25B74
	for <u-boot@archiver.kernel.org>; Sun,  2 Jun 2024 18:09:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5D9F81F9A;
	Sun,  2 Jun 2024 20:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gZVeR8Fs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 975A487E0D; Sun,  2 Jun 2024 18:20:26 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA05287DCE
 for <u-boot@lists.denx.de>; Sun,  2 Jun 2024 18:20:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=di.gerasimov@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52b91f655d1so945708e87.1
 for <u-boot@lists.denx.de>; Sun, 02 Jun 2024 09:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717345223; x=1717950023; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q81EzMGpbs+PFUzv96yObKoAH03ZugTvuQ38t/pnd+8=;
 b=gZVeR8FsBX9rYhHcafH7Voda3/EywYxfFXjzi2i8k8OinU3fLudlsItM/MSzJN1ACU
 YMTtouOjD8XhnLE/LUfBTjQxrbg6K5FEEZvDATCMts90imenzZJgHXzsnqQLeBDC6W56
 rNYCCGjoc1oe4TSPuhexI4UQ7yqyZNkOet4QO2nPcZY7Zj5CJv3zDdXcOhhvY32DQP+5
 VYuQifhx3t9ceIXIL1gkVCpdiDvzdkvw1Htvcw7ADwtMK+jP/KOkJs5LyyUxRO8+rZtf
 L4Cz245dc0IW+gIByTxCq5Askor7tXli123dJ+EQLdTgtdJC8JZM2CrPvTQ1E14FzIaF
 0ycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717345223; x=1717950023;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q81EzMGpbs+PFUzv96yObKoAH03ZugTvuQ38t/pnd+8=;
 b=TZb+fuxvosiXyVSUk6JPYgYyFZu4YfTJZ8QRQKUwJvyPKoSM7jxuoHttvBxmThq1uM
 Pw0OBC9pD2bKkO3uqjQ0oFV0l0xtRjklJ32JvR1xi+o2PKqZse9ghCu7wVgpXEV/auLa
 D5TSsBxE6SsTaJBBil49IaKVbcyGZaZXTUwQfOlze0m2kPAJViGhJGJz4HHMflTyJeXy
 oioB4z1lh/Q3rlOHY36UqP6Qmi5hQMBqyvmbphmMQeqfaPSz84h5dqm1O0S7Gi5M7+0e
 /2MVb/joYlx7IfnCeXaejomzeDaZTKC2DL2/ugbPArQT47U1yzrnqEX3DJwJl6lh5SAf
 vJhw==
X-Gm-Message-State: AOJu0YxLiMKFSMbRHDvrCN+0CfdwtSg7zNS6rE0mUJt7wNxqK8haOT5A
 RrfPGdD+G1p89GhVNPuH1s95a5AZuT7OwL9WCrtKb+FHYeksPj1S/8pG0g==
X-Google-Smtp-Source: AGHT+IFW7hikG+2C7reN9quXPMBrdhdF52TfaZwkL4v/kuSzt5mOTUN5QgIhqhWe4JG8QWGJnyQddA==
X-Received: by 2002:a05:6512:3ba1:b0:52b:98b5:938e with SMTP id
 2adb3069b0e04-52b98b5947dmr637712e87.30.1717345222818; 
 Sun, 02 Jun 2024 09:20:22 -0700 (PDT)
Received: from vm.. (c-504770d5.024-75-6762673.bbcust.telenor.se.
 [213.112.71.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52b84d3f653sm965447e87.112.2024.06.02.09.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jun 2024 09:20:22 -0700 (PDT)
From: Dmitry Gerasimov <di.gerasimov@gmail.com>
To: u-boot@lists.denx.de
Cc: Dmitry Gerasimov <di.gerasimov@gmail.com>
Subject: [PATCH v1] imxtract: add support for zstd-compressed images
Date: Sun,  2 Jun 2024 17:25:52 +0200
Message-ID: <20240602152613.32338-1-di.gerasimov@gmail.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 02 Jun 2024 20:08:57 +0200
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

Allow extraction of zstd-compressed images from FIT using imxtract
command. This is especially useful when one has to load an image via
some interface (e.g. SPI) rather that just to the memory.

Signed-off-by: Dmitry Gerasimov <di.gerasimov@gmail.com>
---

 cmd/ximg.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/cmd/ximg.c b/cmd/ximg.c
index 0e7eead8d1..25a15fa184 100644
--- a/cmd/ximg.c
+++ b/cmd/ximg.c
@@ -16,6 +16,9 @@
 #include <cpu_func.h>
 #include <env.h>
 #include <gzip.h>
+#if IS_ENABLED(CONFIG_ZSTD)
+#include <linux/zstd.h>
+#endif
 #include <image.h>
 #include <malloc.h>
 #include <mapmem.h>
@@ -238,6 +241,26 @@ do_imgextract(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 			}
 			break;
 #endif /* CONFIG_BZIP2 */
+#if IS_ENABLED(CONFIG_ZSTD)
+		case IH_COMP_ZSTD:
+			{
+				int ret;
+				struct abuf in, out;
+
+				printf("   Uncompressing part %d ... ", part);
+
+				abuf_init_set(&in, (void *)data, len);
+				abuf_init_set(&out, (void *)dest, unc_len);
+				ret = zstd_decompress(&in, &out);
+				if (ret < 0) {
+					printf("ZSTD ERROR %d - "
+					       "image not loaded\n", ret);
+					return 1;
+				}
+				len = ret;
+			}
+			break;
+#endif
 		default:
 			printf("Unimplemented compression type %d\n", comp);
 			return 1;
-- 
2.45.1

