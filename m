Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9FDC54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 23:00:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E713183420;
	Sat, 24 May 2025 01:00:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AxwuYdpg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46DC783340; Sat, 24 May 2025 00:58:53 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17C048334D
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:58:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-742c5f3456fso411099b3a.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748041129; x=1748645929; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qwIxKDQaEvHVl64FWnDS9OedBXtOLe+lLdJ5CCVW/48=;
 b=AxwuYdpgnOX0kAi1fgPy8rSg42EMYMPk0/Ql1JlH9fGe583O7olIwYTQ+z39I69qNI
 hfjbpTnv96zCkp4HZyk+yXTomQyQjQ1/FOx6h8qLjJk0W0wqy6TsNe4WpX40OyBTLhrn
 Db15Kva0RKowvWfS+NJvUtUAIeGRYCtnRC8nI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748041129; x=1748645929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qwIxKDQaEvHVl64FWnDS9OedBXtOLe+lLdJ5CCVW/48=;
 b=u9pa5Ykr3nNGjAa8eIpsTyx7xsSAgRQZwI657V0jrvM72vraQoHjlKzQaZnse9iS4e
 4PgOMjt0DuECCrq8PNZoECKI27MtJ70WV591lJrFeX3ssRHoiM7k7Ao4+1jr+upbDBSC
 EN8CHPgGpFBTmczCX7cxuuv1CxhaWyKYQ7MC2Uzlreip0rv7+QRfFMjWYVu4MDwLRmtO
 dysFfNZzDCGXdsFMc1da7dwj0F7IppzeOPdPxqyg2Y/7SLsGAZn/H5Cn26tldTKjkTyv
 n2U1P6GuoGjGCK7l4dTrbUf8VJNk0ImjWVkZbKcu/SOI1rGEWB6NlqCWAfdCEmtFceAt
 Z7jA==
X-Gm-Message-State: AOJu0Yx7a8AyAWqMMB+p79GxuW2D56mNfGN4Db+vGdNv2sc3s9Wq9IfC
 Xtdt7BB+XXmNWqH5PcFslN36eZaoOkPIzEC5kUOSRO6dh9+r6035yzB+TB4GjcGcY21bcsbBSLR
 7fVU=
X-Gm-Gg: ASbGncscFOU2fBPhIkQgEYSFtDILd0ROsxRLrnWhPIeg5jLd89ccIIxfb4voOf2zJDe
 HWuF+3fO+StNY3l6q/y0Ee581pCk8/ZJCOo5XPi24Cn6q5YVGnoeOk0Nc3cAl5M+YTG/RzI1ufV
 on9GV0LuYPJTfmPKemrY9LUIdDWwTlny2crrGjtvsL/xUEh5RRcHHnqxKnE2gxuTKsiVMziPOB2
 GJ+5h7S3aCQCyfFbLVFavy4LMBm7BPmuy076lEJRUZXYV609Ej/qKyRei/N9GuYR0lLSYU9FHou
 ufKH47Dhmf5IDCYVdowI1PCjXdIzGl2nTThxq/kInDiR6XKTzJSdnneai7ly+llRn05Zop/Uhb7
 BDTAWRs3EnMjACBoJBjP+/3q1kQ==
X-Google-Smtp-Source: AGHT+IEkEXZtHLcT9aqgpokC/HRzyAcOEi5k47IYMacr1PaC/H51F4GTcFk4IBjJrI+YQdeAEtt9gA==
X-Received: by 2002:a05:6a21:4a4c:b0:1f5:6b36:f57a with SMTP id
 adf61e73a8af0-2188c3b32afmr1666321637.39.1748041129266; 
 Fri, 23 May 2025 15:58:49 -0700 (PDT)
Received: from localhost (188.139.125.34.bc.googleusercontent.com.
 [34.125.139.188]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-b270808b57esm10000215a12.75.2025.05.23.15.58.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 15:58:48 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v4 01/28] bootstd: cros: Return negative error code
Date: Fri, 23 May 2025 15:58:16 -0700
Message-ID: <20250523225845.2311989-2-swboyd@chromium.org>
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

This should be negative EFAULT to indicate an error code.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 boot/bootmeth_cros.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/bootmeth_cros.c b/boot/bootmeth_cros.c
index c7b862e512a0..d4c4ed328bd0 100644
--- a/boot/bootmeth_cros.c
+++ b/boot/bootmeth_cros.c
@@ -340,7 +340,7 @@ static int cros_read_kernel(struct bootflow *bflow)
 
 	/* Check that the header is not smaller than permitted */
 	if (priv->body_offset < PROBE_SIZE)
-		return log_msg_ret("san", EFAULT);
+		return log_msg_ret("san", -EFAULT);
 
 	/* Read kernel body */
 	num_blks = priv->body_size >> desc->log2blksz;
-- 
Sent by a computer, using git, on the internet

