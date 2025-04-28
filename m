Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD7DC369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 19:29:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDBAF8290A;
	Mon, 28 Apr 2025 21:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OVc8P5DX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE0938210E; Mon, 28 Apr 2025 21:24:58 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5DE3820F6
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 21:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso7423510b3a.2
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745868295; x=1746473095; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6dEkOebyHIW5sFbRQIjVlRYoEAWWpj+eXL/AHGOvwbs=;
 b=OVc8P5DXvD8/IPqwztMiCGUO8NI8+RXC7guP+Cp+Fv9ITf5h2YB/z9Gr5Fl/Vv3JUs
 2p5jWfRvnpnAPrQY/ZaGDLIu9IJr9qtW2ukBgrc7IzeCTiJeIhpieyQGVK0G/OugSr7G
 ClU+zknsJfw+T6uwwGenNugoBr2kEypADZcBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745868295; x=1746473095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6dEkOebyHIW5sFbRQIjVlRYoEAWWpj+eXL/AHGOvwbs=;
 b=VrnC6+imZgPplDRHZla7znh86Q8aaelK8+aazlG8YUsr5HN5eGZPgdvLFRwN1SBqlP
 nN0jq/y197BPoL6A0UE2Zjtc/hlH4vFV8g4ZIqoaRU5Um0jatm85OmKiCdJdd4eNWqF9
 susFrfqUnSpdWhlv00qGDCh4QppvqbQ6q9ZMFTRXETUuVPXL9j451/IebKowXsVHjCTp
 2FuTdX+28urtXtuMogj5GS6tGLc9q5JUuo8ZIja7Yg6UG/2rMZIwWczq658S5LcaFJUU
 6IRJef6lXa/LFUESh5ffYF+GUfXASrTBxye2U2Y1xug2KtyXYNUOnlPt+YIl+/jRCI2W
 5wGg==
X-Gm-Message-State: AOJu0YypVNhSu9rRg/cwvY4xIRdyRKBjRuThPGfnkRj5ahnX09+y5iaN
 TJYsAPkRD2oiUWHpUnjtc7K6Qyvo2Ce/UBYatjVQysEyg6NLLJU4HowcWkE76CEQ3+6pHMAKsmM
 =
X-Gm-Gg: ASbGncusqaZRo5G2Gos+5sCXy09hHXoIBkrcP+XMAHlTSHkFksLpoknEVxulfyUXsAf
 DTHbdzFICyjP8mhakiVfl7gma5SN4BdWk2F0IK7vy3tprqvdb+9mhDzFcHg4uxi2Qd1y/NA8JDV
 kKsewbX+95GeCZC4yAL0rbgq4cYhSdSsDAxv+2i5sIEJ69E/wj4UOXIacZgTxb307bqQ+YQUw2G
 yMeKxuf7qCMGQJqXVLqPvbXJ1NvPd8lcSFzbGfiSJ1TP1KkT+9t+HkexVc2iRBQoh6IxmtUm0U7
 kxEpbLMwo1H+Gt0lHOd+10oSDpuEpMRQ0JnKRB/DrfbXuxAKfk6zaIBNPlclb8io0djoYSeEVki
 0hw==
X-Google-Smtp-Source: AGHT+IEqpO8wcDw8JHa9ZXGkWIvbBLfyh0fc6kuD6F6wyhKAdoyiprHKb758cUygKvZ42p1+devGPg==
X-Received: by 2002:a05:6a00:4b03:b0:736:34a2:8a18 with SMTP id
 d2e1a72fcca58-73ff73f4b0bmr15922782b3a.24.1745868295121; 
 Mon, 28 Apr 2025 12:24:55 -0700 (PDT)
Received: from localhost (199.24.125.34.bc.googleusercontent.com.
 [34.125.24.199]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-73e25acce16sm8655141b3a.175.2025.04.28.12.24.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 12:24:54 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v3 16/17] cmd: ximg: Support LZO compressed images
Date: Mon, 28 Apr 2025 12:24:23 -0700
Message-ID: <20250428192427.3877612-17-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <20250428192427.3877612-1-swboyd@chromium.org>
References: <20250428192427.3877612-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Apr 2025 21:26:55 +0200
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

Add support to decompress LZO images.

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 cmd/ximg.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/cmd/ximg.c b/cmd/ximg.c
index 29d7c3279b39..a6341a078019 100644
--- a/cmd/ximg.c
+++ b/cmd/ximg.c
@@ -14,6 +14,9 @@
 #include <cpu_func.h>
 #include <env.h>
 #include <gzip.h>
+#if IS_ENABLED(CONFIG_LZO)
+#include <linux/lzo.h>
+#endif
 #if IS_ENABLED(CONFIG_ZSTD)
 #include <linux/zstd.h>
 #endif
@@ -238,6 +241,18 @@ do_imgextract(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 			}
 			break;
 #endif /* CONFIG_BZIP2 */
+#if IS_ENABLED(CONFIG_LZO)
+		case IH_COMP_LZO:
+			{
+				int ret;
+				size_t size = unc_len;
+				printf("   Uncompressing part %d ... ", part);
+
+				ret = lzop_decompress((void *)data, len, (void *)dest, &size);
+				len = size;
+			}
+			break;
+#endif /* CONFIG_LZO */
 #if IS_ENABLED(CONFIG_ZSTD)
 		case IH_COMP_ZSTD:
 			{
-- 
Sent by a computer, using git, on the internet

