Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294CCC7EE31
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 14:13:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6041A80E9A;
	Thu, 26 Jun 2025 16:13:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aRwkfiIg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 608B782063; Thu, 26 Jun 2025 16:13:05 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C7B4809A5
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 16:13:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4538bc1cffdso5446425e9.0
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 07:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750947179; x=1751551979; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ccmXvhb/LBv2emtDdIjxKAgTMmHTT2UjI5AJk3RrtUY=;
 b=aRwkfiIg2VHcvd5BQQ14RGUd/dUN/qyQPIbJcIQSeJbzbX8qMw3cH9x9ZfiolwobHC
 KaEPxcOdLUoue0BA1RBdtOLyS73eluMBtEcz5yfMzRwhOx5TMLT8E22a0diHPSCW7H3K
 AypYxliQRHr/2oUrrufz2IdCKnZg88lVLmAUZNqF3BCVDsgsU10M7QUZw8P2wFMWfKbg
 TA+X2EPRRW1yzDRwSnUyUHFIPwCafExC9qZCN5TGW7U3K9RXJptrnaNeX+QJkpDRnY0y
 TDwRjIEDGIeVh+EO7WK33qmMLuB6S+6bUtmsf58VVBtPdFjUfW9LruXXizc7yI6l5+pM
 bPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750947179; x=1751551979;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ccmXvhb/LBv2emtDdIjxKAgTMmHTT2UjI5AJk3RrtUY=;
 b=pkzEdNyh+rT80DgA4K31Alu/kH/hcS8AUVvWat/8WTk4ucHtB33DE4bTBWI7/dJSqS
 Bzj7HPy+hWPhJ8KUxOT4swNvR03+gGk38b0vJ43O/PoI3yor1lCQp9U8g9ULNfT+gxkP
 xGKVUmKr55zDrUsBoN5WdDMONnbYZIGmnwVAC6Wyw1hhzhmZK9AGqICTCcgn5XTWWvYY
 KwhzZPZ2cIjqq+xdLfEroM31kp+hestQdlz1UoINCRDHfW7mEx7SOyGT7a2DgP77rNg0
 8zNHmBjOyesnWAeLrAMDdGGljZQMsmKbpRbo+izsfkcQBMSnLcUVq9y1dfjqlHQnC7Sr
 7Lqw==
X-Gm-Message-State: AOJu0YxGCtHu3Q/uSZ5SFKyaAXZRpTRYH5LOH4X31xPqCjJFW8IVok3p
 wXXMUk8fksOIR8Q6296sPyK58FlAYGmlY4pop+5zVIo1SColBUWYDtOfWidfpsp7E1U=
X-Gm-Gg: ASbGncuKIsFQxLFDCw8zqbQ2P/m72uGyTVQE+wK8gVnEgydBlv2hFnhLhtC1y4trOn/
 XSgKXBjVBsD6RKMQEIEtXLZ3bTTgDFa8LJiUhk/VSfpWy5BtRGMDE1Zv8Om5ccNy4h0tX/sbWIL
 OEkLAx31gyIbG6vQLewrnw/AvpbEv1A60yHGiGOYe0qkZyXb9LtNKsKl7oYA/wsng4qYPnTosyp
 uwVDnSkQ5pBnXB6ziYOuxtjSJhnv3Um3CThjipfdljYAT5eTBfcRPZcLrm7ncCg/oEz9SDgIXCV
 b+nNJ9+yXfy9AOPvSOeh7D8IgLucaeXmHH1TseIeIrJ9X8zg1Zod0VtpIDQb0aFzc8WCe2853AV
 9btjp3lfRwBWB9g==
X-Google-Smtp-Source: AGHT+IGthdx1z+wvYU+dGYgcOuWmLYWjXTSVSd7a7vn6PfLDQyCXWMiWyWxzZUzzFN/mZ1HgbKoWLA==
X-Received: by 2002:a05:600c:8593:b0:453:8ab5:17f3 with SMTP id
 5b1f17b1804b1-4538ab518acmr17194305e9.22.1750947179474; 
 Thu, 26 Jun 2025 07:12:59 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ee3:2301:12b:81c6:a008:45a3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823ad03asm52007735e9.23.2025.06.26.07.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 07:12:58 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 26 Jun 2025 15:12:58 +0100
Subject: [PATCH] cmd: ufetch: Initialise size before first use
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-ufetch_fix-v1-1-025afdb85dc2@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGlVXWgC/x2NQQqDMBBFryKzNpCEJEKvIkWSdDSzaCwzWgri3
 RtdPt5//AMEmVDg0R3A+CWhtTYwfQe5xLqgoldjsNp6HWxQ+4xbLtNMP+VdGpwZjDbOQgtSFFS
 JY83lSt5RNuRLfBjb/n4Zn+f5B6/KVsV1AAAA
To: Casey Connolly <casey.connolly@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

The local variable size is not assigned to before it is used
for the first time. Correct this.

This issue was found by Smatch.

Fixes: 86d462c05d57 (cmd: add a fetch utility)
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 cmd/ufetch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/ufetch.c b/cmd/ufetch.c
index 46bd16824e6..bc5db08eee1 100644
--- a/cmd/ufetch.c
+++ b/cmd/ufetch.c
@@ -93,7 +93,7 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
 	const char *model, *compatible;
 	char *ipaddr;
 	int n_cmds, n_cpus = 0, compatlen;
-	size_t size;
+	size_t size = 0;
 	ofnode np;
 	bool skip_ascii = false;
 

---
base-commit: 903eb123236ccbd8ef05d43507a2a910b785bd56
change-id: 20250626-ufetch_fix-54b741710142

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

