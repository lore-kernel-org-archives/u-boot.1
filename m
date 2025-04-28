Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E14C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 19:29:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 502EB82A4D;
	Mon, 28 Apr 2025 21:27:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n2JP2rCU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8816C8209F; Mon, 28 Apr 2025 21:25:00 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BDFA80EFB
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 21:24:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so78434905ad.2
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745868296; x=1746473096; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MvxOlecVI/99KO0pSUGtZ3fQ/eV9xTv4AQMdbrmP1ws=;
 b=n2JP2rCUClJlxVfOt0QSsgeMRczQnXDa64IulP0drHn56ogTIOT1sI/ELidpGhFZxf
 kmIBT03VjQVK+BbwbLuMwjfUBT9x1shBwHDUVM+NEPe9Lmf1ZWttuDDQ2u7dIVJWHINW
 jdVdkt9+C36EgsDlT7BNaZQBP4wk4HOHSxfX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745868296; x=1746473096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MvxOlecVI/99KO0pSUGtZ3fQ/eV9xTv4AQMdbrmP1ws=;
 b=jtEHJv9yKO5+BN4xZGdd78tQjgg9K2QtP65KYkvZ7FV93EiMmy6aWnNCH4BwAEymZc
 covuYSyUFspAZEQYbeUVZ0bdu4m8VEc4cZv6P0AM1P+HJ8zL+vrKDg+JDCczcky1NgpR
 1mmsFt7DWlbqFcufU84mRKa3yp2by9MZ1aTcaKdDB5uNlhbsAZBVpuca6H1hJxi92M8r
 nDRGqNZCpj+xw48/4h9lZGqCZqUsXW7AUMnG9DcgT4ZiHsU45WYJQAlXt0F7qAyB5WNT
 JiisHQfnuJACOGnpbXMIYTMgmiUUNu63fNgM8AR5g129k7nlAQ+y+jXXkDGffMwccJ5j
 trRg==
X-Gm-Message-State: AOJu0YyNl9stYTsXaZa58NaSuIeaXH1VdmRKeiwR49hwfHh8gAOx3Hf8
 Nxez1Hl6WYuNVngOrZjeP7I8SLAGVy2BgciJlRytm0SKSAf2RCPqieXjJOsXCB6DKH7VGSaD7JU
 =
X-Gm-Gg: ASbGnctONC8cVTJS5ZPfQn88u4qdekS8j6UFReD8TolWKUH2MF6J1pv4wx5mkDhACf3
 Rc+rBsPEibRFlKqoStf9AOprDpN3xEQSd/S0XPJI0pXOuHpJdBEMWcgaRPq5ps2Y0zTwNcb6mC0
 +Ax+vLvhVZh9ZXjUA6ju+pZaUSjKWa+tM/T+J3f2RBd+sOzD9PGcIfEIskO2uHpT82paPI1Wd+b
 Y1Zr5Dl8yJKQNolR7CvuSuCj2n7PkCvDcDOGaJuGWxe1VMROi0+Nd4p22UuIcWiyFcFOWFnG0VI
 d4YvoOktjTQQEvQ9MDp2pjLNn4T4J7QyIvTB6g6d9cvjY1oYRAgkOgdcKIiDmm4tYeQjJpYPvsj
 9bw==
X-Google-Smtp-Source: AGHT+IHcl1jyPhYUkbL2hnd8SUj5RpFGpOkXiEDZyARa5SkNqX67CIH1nvgy4AlBLEpf8PrklRz85Q==
X-Received: by 2002:a17:903:2b10:b0:223:668d:eba9 with SMTP id
 d9443c01a7336-22de5ebb11amr12771175ad.10.1745868296584; 
 Mon, 28 Apr 2025 12:24:56 -0700 (PDT)
Received: from localhost (199.24.125.34.bc.googleusercontent.com.
 [34.125.24.199]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22dc60bd15fsm54797335ad.15.2025.04.28.12.24.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 12:24:56 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v3 17/17] cmd: ximg: Support LZ4 compressed images
Date: Mon, 28 Apr 2025 12:24:24 -0700
Message-ID: <20250428192427.3877612-18-swboyd@chromium.org>
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

