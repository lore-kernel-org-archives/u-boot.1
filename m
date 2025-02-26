Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818BBC19776
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 22:25:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94B9B814BD;
	Wed, 26 Feb 2025 23:23:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SkX1boUD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECA9A81101; Wed, 26 Feb 2025 23:16:37 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8492A80F88
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 23:16:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-220c665ef4cso3546585ad.3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 14:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740608194; x=1741212994; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L+mkptJpZTJytlNHQ3FsRsgdhfBsDh6QlU83OVKuxC8=;
 b=SkX1boUDvmtqk+2zXE5fgtIQ1Ru+XkRgYyqsNntiIXF8Gl2t8V+i14lH24o3q97tBY
 LbtgLNYiTmgDv0RseDPcLrQCzZWrLsutrY+viX/0TsvQO5xDyIm+iPg3J6ik4/GVAxoJ
 0xkg3BPlHjYK/B0TP7BB8Q3Cq64A1gfGuNk1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740608194; x=1741212994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L+mkptJpZTJytlNHQ3FsRsgdhfBsDh6QlU83OVKuxC8=;
 b=TTecVSO3omb5KObbcOfJv6yLVWZqMGw9kp28r5y8t6YA6K2WRe/bE+LAmO7XlcTSKb
 zQnZWmlz1S7ewZKMQoy7iCgHOSzy0UCEb04655UAAhj+t/VadzId9cKlPy2qx1zvTaUV
 tEKiVBHvGs+rvwW5LxiC5g5YFFqqrWE3LbZMd+agDlevDh+jM0ivaIcZqg8+3k7o22R/
 g7weZBAKNq1LldpEKKieWXuGy5CqzMMb12H0G9vkCBPBa+bc3PO/XHQrP5psVGoVdPBB
 jqso2Se/vurrLc5LX3lQl6bwHxQ3fYf293Gg3nFYneenPhbgBePnoASOIH53Has++Fyk
 95/A==
X-Gm-Message-State: AOJu0YwMjbccnFyXgQuU9v3NiGQ3pUV1Za15paQKPPGUDBH6ImWPiQMw
 pbShhKdgJH6+PF+4+m5yPT+DId80mjDg2RCPg3C+6uDwmZjoDV5tGxFrnjw2rZaGtfVtVZKw5aY
 =
X-Gm-Gg: ASbGncuYnl1muOsU5djMFgyzCLHJM4LuQEdYSWZ+FmBM2XLQJA91TpMWEnzb6wIpspD
 XloDmWCuSV3fbe/ITcO9w6fFviNTslKkryxmdLLKfEmvBaeLe2MaNriLbTfRu6j2Mgg8SnNIOlC
 n0OBCy9D4vIkSBlaxfMWNTk6XOmKaIojarLYCtJvdIgqb01Id+fnQrQKYGqok60pNt5ovha5nkG
 PSMhiLF3NuzckQKNtGTtRHBdSdxMo/OagRCfH9Wt6uCRqDWVwQHDp+Ed2uUuYItgf5buvQle9oy
 L2i23tvGdpnLiiHS5jccHBga7z8dQjNDn7jzJAI45OqRqw1dt+JjcsZqwsBOQahyWA==
X-Google-Smtp-Source: AGHT+IEbNkd1Ps0wlQzGP4bZc8C3wG6InXo1kOME8k5HsLefRdMjBvzN8TYMQHAsEMx0DRFKlcbIfA==
X-Received: by 2002:a17:903:1a87:b0:223:245a:11e2 with SMTP id
 d9443c01a7336-223245a1321mr54370155ad.6.1740608193881; 
 Wed, 26 Feb 2025 14:16:33 -0800 (PST)
Received: from localhost (222.246.125.34.bc.googleusercontent.com.
 [34.125.246.222]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-2235052c83bsm1178195ad.236.2025.02.26.14.16.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 14:16:33 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v2 15/15] cmd: ximg: Support LZ4 compressed images
Date: Wed, 26 Feb 2025 14:16:01 -0800
Message-ID: <20250226221607.1283592-16-swboyd@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250226221607.1283592-1-swboyd@chromium.org>
References: <20250226221607.1283592-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Feb 2025 23:23:35 +0100
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

Add support to decompress LZ4 images. LZ4 is used on more recent
Chromebooks to store the FIT image.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 cmd/ximg.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/cmd/ximg.c b/cmd/ximg.c
index a6341a078019..eed66c776d12 100644
--- a/cmd/ximg.c
+++ b/cmd/ximg.c
@@ -30,6 +30,7 @@
 #include <asm/byteorder.h>
 #include <asm/cache.h>
 #include <asm/io.h>
+#include <u-boot/lz4.h>
 
 static int
 do_imgextract(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
@@ -253,6 +254,18 @@ do_imgextract(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 			}
 			break;
 #endif /* CONFIG_LZO */
+#if IS_ENABLED(CONFIG_LZ4)
+		case IH_COMP_LZ4:
+			{
+				int ret;
+				size_t size = unc_len;
+				printf("   Uncompressing part %d ... ", part);
+
+				ret = ulz4fn((void *)data, len, (void *)dest, &size);
+				len = size;
+			}
+			break;
+#endif /* CONFIG_LZ4 */
 #if IS_ENABLED(CONFIG_ZSTD)
 		case IH_COMP_ZSTD:
 			{
-- 
Sent by a computer, using git, on the internet

