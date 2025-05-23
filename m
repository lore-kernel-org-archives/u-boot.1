Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D406C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 23:04:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07F9683692;
	Sat, 24 May 2025 01:00:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E+Ig46M1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 870678333D; Sat, 24 May 2025 00:59:30 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58CAB8334D
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:59:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-30ea8e2bbaaso380546a91.2
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748041167; x=1748645967; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MvxOlecVI/99KO0pSUGtZ3fQ/eV9xTv4AQMdbrmP1ws=;
 b=E+Ig46M1Oqw5t9OK5+YeX5NhfMSV2nugc2ea3YQeKGWh6WFl+FWyMansEyMSh+L2Cg
 388v0FRb9Si3TEPcEQvFotyNeQCcd4v6iPyvwfG/09zauCdpXVVA6W9lAG/9GxOoHhQ+
 FMXShObIN0Zk0pX/4w/q4tpkeAtAbwbmfMPeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748041167; x=1748645967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MvxOlecVI/99KO0pSUGtZ3fQ/eV9xTv4AQMdbrmP1ws=;
 b=BSe0zflN1IoWa7CUOHs/XwNpjKyaZqjbSOZGD33p8Yc38V4YzRW5WOrOO6dpnfCXPj
 qZEgmdcGo3WVC8KT4/T+GVSqV+ElJQgFbZQ3Q2PdLQFUE5SHe+6uCtXx+fFzczCVQNSW
 GX5bn8EY/Q62JxrTffiL28QCsnV+D05mHN5ETusOuBetrRoH6DcQUtHwDqs6y35tSJgD
 dN+xduaySA8UdE6XMV1e5xXy0OVqCV1VpXxARAKrKdZEpYJGWzMYxbpo/hWl/ZoMwpQj
 Mfj3z0r7BXvHiqGDo8fEZqz3OD03/BvhIPfqI682MOkNapLNQjGsGGOAWimyCOLDvFUW
 t0IA==
X-Gm-Message-State: AOJu0YyKsggFCaiDMOZk1CuEhIBW6jw8Vq6OoqAX9wCkUSmWAviotsdg
 ZSpsdWEjoKwJdWKd7hqyiQM4BjQuboDU4RjrokePbSisX17uOGVvui+41kIdddIX6a/jjbO6uN/
 EsoA=
X-Gm-Gg: ASbGncte3NlJ2owcPBNtSTcdQm7QSPPabpIDQxCco+FBUYuz2EmGC00ZJb45GibufxZ
 8FMOqG2t2aCilsjG5AqVyxxYirWQ9UfrBZ6tYTDIPU6/CN/LSin4FPBejxtxCO6uxGTuTUQqRy/
 X/OtD7kErAv2RDsc9QqFetWc+vn+1XC6HUNH4evlXtHW8h5+F8Guq/biG1UBtVyZI9tUUU+/VUh
 +6nM1ylY1p8e+6pbXR7RmB4RcBXP4buhZXOdiGWCc36eyDBvLuLDqjjooH570CCrJeV77GB1EEj
 Fm2n52fBS+WVjaQgU1bmivCgLzRWWtD+I2rFOO325cFVVbKbWfUei3Fju9oLaqJrb8wI6tImAb5
 2wqE9a/6yfWAEf6M=
X-Google-Smtp-Source: AGHT+IGrlJmiKDP+I8ps7/O0ktskhABNfb1/JM5TFqT3RAc4dTaZCrYH+JFS5PtF2l6OgSlm/OYmcw==
X-Received: by 2002:a17:90b:1d81:b0:2ee:edae:780 with SMTP id
 98e67ed59e1d1-311100d874bmr1406941a91.15.1748041166720; 
 Fri, 23 May 2025 15:59:26 -0700 (PDT)
Received: from localhost (188.139.125.34.bc.googleusercontent.com.
 [34.125.139.188]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-30f365f3487sm7829731a91.42.2025.05.23.15.59.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 15:59:26 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v4 26/28] cmd: ximg: Support LZ4 compressed images
Date: Fri, 23 May 2025 15:58:41 -0700
Message-ID: <20250523225845.2311989-27-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
In-Reply-To: <20250523225845.2311989-1-swboyd@chromium.org>
References: <20250523225845.2311989-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 May 2025 01:00:29 +0200
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

Reviewed-by: Tom Rini <trini@konsulko.com>
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

