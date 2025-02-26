Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD211C19776
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 22:25:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4920E8144F;
	Wed, 26 Feb 2025 23:23:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d4JK5cv9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2B7880FF2; Wed, 26 Feb 2025 23:16:36 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72649810F2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 23:16:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2fcf3a69c3cso515165a91.1
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 14:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740608193; x=1741212993; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GkCk9s66H5MAQxkQC968DIQ6WwGy0ru+4g1+OGhmQ/8=;
 b=d4JK5cv9SfZk9z4meoWrcn4A67Is3idLK3I1tDn37Ti6dpyVxNmXK/dXn256dqPTAO
 NQU9/MbmFWER2inu2j7juYL+TIoBjjAvCU0p8pTvTtyCLQKxZt5DV1mDSJtdu8xpLDBI
 JqHgtRo86GN7V8+myCWW7d/lzwf2WnemJIBPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740608193; x=1741212993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GkCk9s66H5MAQxkQC968DIQ6WwGy0ru+4g1+OGhmQ/8=;
 b=jgbXM7PH0QpeLmqUHG9Z3YJIemT4I7UW8hgfWj6/2W7Z70amnD76/tziyl1S4cwG8q
 iGn3f1g0RH9uvcxiNZ2TVMtNK/4I0qwfQ6KgM38vZQlDUFpp75wPMgHvUeWv+oHBXzl0
 oM6gQlxCfgjqBt8CZuM2XipmQNxGWlKbtvJ8DNs+0cmIczRLKaYZ5D556tdkSbiEkyOI
 GjPFgb3c9WAOpVdhKmbZ+q3UCNl4C4ZnyP7bibgEsXVlJ5bRs6/kraQbRkDIIW75s92s
 oNHd+gXY6xn/QGcw0ApDehEiElMrD6sG+aBWVipg7bAydn4hxYQ3YXgKW8iloxtyYqpD
 lcrQ==
X-Gm-Message-State: AOJu0Yy/LBR3OhK7mCNJrN7QqwLD+fjQO7NnW9sfx/yZUymegg96FzNi
 uut+ZpUGTqdsgHcn+yTydVVvmJsP5STAb/w3Vvg2QWohklA6PzIBZ3m9VsE7wjXh+cB2DEJrEQA
 =
X-Gm-Gg: ASbGncuA1vvYqhXXIuNHre1YbwnDxM2/a0D8E5+1lEzhd/9bPpkyxgrHo1jKloszVCn
 LIvO6EVxVzkd0AZqUVdlRsSurLKguEBiHjHcf4hQTFe5ILWEfR2eZMNRVilfcDoZ3UhqndVpQe5
 IdTuboTUkPvffePIRw5wbC0KAjOya1jnFKUt7B7Mq/zrMHod4+JrhpZ4J0wW+jaUCVrs9op8ejF
 HEoauLW5oj/hYp1koYA2X1ou8hlBPgn/FOS9E/k9B6mMf/pUgOGZlc01vIf1UUAZnqkuCl2rFWg
 xHwyYw9Ud/Fql+Yp4BI6WLPSfadDtFSPnhEy9rqI0T55F76WWr5GOYwYVsp7w4zNVw==
X-Google-Smtp-Source: AGHT+IFDOX+0E2Z9BfqZ/WIHpsCxBdTzwu0Xh0GO+4FDTQFRIWXxBfdiBZhumWgRzyC47kvRR710XA==
X-Received: by 2002:a17:90a:c88d:b0:2ee:96a5:721c with SMTP id
 98e67ed59e1d1-2fe7e312395mr7519382a91.21.1740608192573; 
 Wed, 26 Feb 2025 14:16:32 -0800 (PST)
Received: from localhost (222.246.125.34.bc.googleusercontent.com.
 [34.125.246.222]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2fea698ff95sm40017a91.43.2025.02.26.14.16.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 14:16:32 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v2 14/15] cmd: ximg: Support LZO compressed images
Date: Wed, 26 Feb 2025 14:16:00 -0800
Message-ID: <20250226221607.1283592-15-swboyd@chromium.org>
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

Add support to decompress LZO images.

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

