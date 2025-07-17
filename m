Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC931C83F34
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 14:54:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ABA983403;
	Thu, 17 Jul 2025 16:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ijt2J0Fk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 398CB8340A; Thu, 17 Jul 2025 16:54:42 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10372833FC
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 16:54:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-455b00339c8so7745635e9.3
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 07:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752764078; x=1753368878; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KPW7Kilcakbc8ZShxorfV/v0yEftImZ5HPAq3o+LWcY=;
 b=ijt2J0FkLODGjMSfY4GJ8GAN8gOkse1FyYeXZNM0d1KE10r2HwgAG9K9YRj6QnU9zT
 1EjpqyxLqLOaaq2C2JkAMQQ9n8YwRzP/R5wvrElLMEuEGDnWfpSO0gWkkNt+TrxC8ta8
 qHTpp5Dt3UbQPt1Man6XmldVG2eu1QmX12g9J5XGTLoCZtE6ChaRlQrLcorHZcDsMNnz
 zsLf4b/Bac99j/ML5qiG1J44wrG9uDF6gNIi+k6tU5v33vipZ5yeXzUKUrX/ISVQntdp
 MGY16BbUQpKUlReiGM70o3rlyFI0CAKMcgHMjZNAJGkymy5cDCCv+d6HawqdY7sFOb59
 XQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752764078; x=1753368878;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KPW7Kilcakbc8ZShxorfV/v0yEftImZ5HPAq3o+LWcY=;
 b=PJk15YevNNVAgWCcIkZbMzZ0Cq4Bq4qHhFjpzgOrStfvv0HCxBv/A9FfrBhPYfAjQ8
 Vd8zkjit5rS+dCxpuYIXrvcNI5qx5DOzJGrlEtmNy7Ms0hAWNQ/KWCRo1gv9MKHRMJYG
 WC5thGpKjZeV4e+FZITIt8KfC+/LC4cfXyn0luegF12mKB+uaMMSksT6rKR0JdvJL05r
 UZHYDozY6pMwgkz/3Mll5Zlx/HcLZwVvaen8Z7lAUIMp7P4uc5pLy/pIu9xJ3AAF4P5L
 FuVvC7BqcQ20p/uue27LMKq/ZVUolPPqeGf9uHBKrRot7dHSS3l6gir3XbIOFiHa64l0
 hFww==
X-Gm-Message-State: AOJu0YwZPyAJr2oTPdX49fI/kZ/xwTSWt33Xze60jc912VU/sBfdkbQX
 gHcaBzKhvyK5dLYhGBYLs33EK9YgR+Mckcg2z83PeWCeWg7nFLpPneLjE3+/GBAiy+E=
X-Gm-Gg: ASbGnct5U8nEfH1XusCMhoAe6lENXNjWV/dHnzfhB8koWQKUaSQMHFSBeiONpxILrvS
 Wn7ffHPIjNzDG7Z6BlCkf7H97G5ZvSjQmAOB1pFIrNV3wIkF6oug4u9LDvFjSz193DHy3QHePgF
 wysJ83Jov53DH9Ckala/v/j6U/1u6vdFMnS4ryrFvhBP1sngxl6xjRczh0TQuHRdNViT6czVZQE
 IafR0yI9pxVNKoLJrF5vuUj0Ru+0ho5450z/xbKr3m8BafFr4qFDgdY+wfLMQfcmfSCKiIPoj0l
 YTMSHQ18wl3Hg/3Ti39WNo6r/0rRmGTKFG20aTBoShH6U0jVaAMH/7aAPKRmJCof9Nra34qdGD9
 9wpL0GcQtUVkEVKsytEIH1YXkvN6aBjP1mHNcNEuTf/obl3MDxhw=
X-Google-Smtp-Source: AGHT+IHd5bh2zi6KIZGYZTOySFh2xEJfI68QVOchoVWXE1TnvTfnvANAlui8mC3hVfV+oOQxIDW0/A==
X-Received: by 2002:a05:600c:4e8c:b0:43d:4e9:27ff with SMTP id
 5b1f17b1804b1-4562efa4ccdmr55052385e9.7.1752764078282; 
 Thu, 17 Jul 2025 07:54:38 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:eb9:1701:f497:a590:bf80:45c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e8ab642sm52643905e9.36.2025.07.17.07.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 07:54:37 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 17 Jul 2025 15:54:37 +0100
Subject: [PATCH] fs: fat: Prevent possible buffer overflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-fsfat-v1-1-4cfb1d1a77ca@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKwOeWgC/x2NQQqEMAwAvyI5W7CiZPEr4iHtpmsOVklEBPHv1
 j0OMzAXGKuwwVBdoHyIyZoL+LqCOFP+sZNvYWibtm/Qo0uWaHeEGPnje5+wg9IGMnZBKcf5rRe
 ynfUVm3KS8z8Yp/t+AN/LkuRwAAAA
To: Tom Rini <trini@konsulko.com>
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

Instead of strcpy which is unbounded use strlcpy to ensure that the
receiving buffer cannot be overflowed.

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 fs/fat/fat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index 89f2acbba1e..fa34ad7a501 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -1391,7 +1391,7 @@ int fat_readdir(struct fs_dir_stream *dirs, struct fs_dirent **dentp)
 		return -ENOENT;
 
 	memset(dent, 0, sizeof(*dent));
-	strcpy(dent->name, dir->itr.name);
+	strlcpy(dent->name, dir->itr.name, FS_DIRENT_NAME_LEN);
 	if (CONFIG_IS_ENABLED(EFI_LOADER)) {
 		dent->attr = dir->itr.dent->attr;
 		fat2rtc(le16_to_cpu(dir->itr.dent->cdate),

---
base-commit: 3b4604a40b9fd61b87e9d059fc56f04d36f1a380
change-id: 20250717-fsfat-a77ce8151f74

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

