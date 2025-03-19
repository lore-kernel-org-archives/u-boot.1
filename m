Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8470C35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:41:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6980481F44;
	Wed, 19 Mar 2025 15:39:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dAXgSIan";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A04A881F7E; Wed, 19 Mar 2025 15:39:17 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85D3E81E06
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:39:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso31521075e9.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742395154; x=1742999954; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b3lNmG+y/t1B1vYNvf2x4jme5Us1WbBsL/7si2As/3I=;
 b=dAXgSIangNhsoRhUvpCW9mS/QTo+k/KDB5TOmVFLs/5kEHuYi5uy9ipfrinVPTjCwj
 4lsdiuOx4btphqrA4xoVmkZnUDBcjVLMsfMbkOe9T6O+MU+1/5kOaG3Y2wkWeYtwICbs
 5CX2Q3TuGtZ9J3+xChwEN9cWP0NrmNRZL7VwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742395154; x=1742999954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b3lNmG+y/t1B1vYNvf2x4jme5Us1WbBsL/7si2As/3I=;
 b=bw19ebBJ5GsP0NwQjvp04i3qJiyd97rj+rvcr50Et5MdJYD5+YOCPH1VbVDf1FJtzz
 e1ZqqeBQaP4UTk+ZsiW8df3HhNJTGjpOgPrc/jgEUdN+iqPRKM+pvNhRm4/y94zzGbAr
 nfeTcebFlJsUrAPZN1BE+Sq6g7rEPJKWtCVXQjZgHiCMXQo0eK2hl88FKy7BdfbtsR+F
 zwKFngLn6cvAcNCNDic5TynQiqlfsQPSOhp2DnS8OyStlR5hhVJhM12qV67NdnzChH8R
 EKo3+njvhgCk/1wHODZcI71P64qw+19LhmQlOH6Bt3eghiF5rgyGDuTdhS/3y88oQxWQ
 9GdA==
X-Gm-Message-State: AOJu0YwNWP2MPYhbm8YWId+pcrYcIjJpMRgWGnk0ABTZ/nkZJnmo+5IR
 6/pwMWM2M1Cs3b7NiARrxnwGt1ntnddkDFLIWgb8PiyquXP8YD9dMBNRqaSknvlA98LIclh1o5w
 =
X-Gm-Gg: ASbGncsDNzvlWDhSNnQuj9OcAUKkYRf6ehNsLewnVipyVqLbQ44k7fqGgiiLIvM5VKC
 J1NEQfMdGoCO5xNFPTXp6ADw8aKO8hPM8x7yN24Mkf34h2ZqhrcOYxWe+ai2xQ5sZ/KQxQCgjeV
 eBlba0n1wnpv6+qJp64t2sD5/GDthTCVD8bUOtobiXe5c0DeeY2gztzZhKjAazgq5+jVN+JJiN/
 16J0YLtDSPnfQfnDaKIalku1U3wJVZn3dmk7Cg7J/jPsKJwiKy5YPqjvfioja7dB7ZdJ8JOjYa+
 hvMrlgXCNl7+t+e8EQmsnjRLN/hHJs6Uho16RiaD1Q==
X-Google-Smtp-Source: AGHT+IGPXigrUIGXzYqdMxbO2AV/xUlw0wXGhXHMsZVGLRlI9sE6dcJwlEExIQ+w/XfquHcqMkSEKg==
X-Received: by 2002:a5d:47c6:0:b0:390:f832:383f with SMTP id
 ffacd0b85a97d-399739de3c1mr2567678f8f.2.1742395153902; 
 Wed, 19 Mar 2025 07:39:13 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318a80sm21534428f8f.61.2025.03.19.07.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:39:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 17/17] bootstd: Mention FS state in bootmeth_read_bootflow()
Date: Wed, 19 Mar 2025 15:38:11 +0100
Message-ID: <20250319143820.2385092-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319143820.2385092-1-sjg@chromium.org>
References: <20250319143820.2385092-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add a comment to help implementers deal with the need for calling
fs_set_blk_dev_with_part()

Signed-off-by: Simon Glass <sjg@chromium.org>

---

 include/bootmeth.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/bootmeth.h b/include/bootmeth.h
index 8f4706c555c..d25718d9a14 100644
--- a/include/bootmeth.h
+++ b/include/bootmeth.h
@@ -213,6 +213,9 @@ int bootmeth_check(struct udevice *dev, struct bootflow_iter *iter);
 /**
  * bootmeth_read_bootflow() - set up a bootflow for a device
  *
+ * On entry fs_set_blk_dev_with_part() has been called so it should be possible
+ * to read the file without calling that again.
+ *
  * @dev:	Bootmethod device to check
  * @bflow:	On entry, provides dev, hwpart, part and method.
  *	Returns updated bootflow if found
-- 
2.43.0

