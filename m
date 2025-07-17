Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAA4C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 15:29:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADE8C833F9;
	Thu, 17 Jul 2025 17:29:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Gax/1OEC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77B728340C; Thu, 17 Jul 2025 17:29:25 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37C5D833EC
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 17:29:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4563a57f947so340815e9.1
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 08:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752766162; x=1753370962; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GIctG0veVBF1YHJtONbbLBlVcZVSDekaPK72xZ6pbUU=;
 b=Gax/1OECuyvvhFNvVm6olWuweH3GISymqcEDSHA4JVU2KBxXopuUDHhaaBz8NlTYbX
 wVbRhrJRS6CI1tqiyU8COumC5MQLl/kDRRc6NemnrDmtBo/Z6pvAp4J9YZdRN6yP0bRh
 u3O8ov6rDghZn1pJLhvFTd0wInqRhnHWTtAmKPDGirxRwd67SslKTGwNlK6JCNYvxnfl
 ugAwiEywLd6VsnNhgiiY8eS8w9iIS6pVnqtZuBksPnkXv5eiaS0vGd6l03GcwvG37zWe
 najjstVmv3U5WeBom6pfCb0+0XnVUcXnAnlR9+ngDTPcyhx3U3rPT4uKTYRdelRkORN5
 FLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752766162; x=1753370962;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GIctG0veVBF1YHJtONbbLBlVcZVSDekaPK72xZ6pbUU=;
 b=wCx0wm8uqZX8yzamDrwDo5naXGeudCrWUYLxNx4WDvBr1SvL9CtodFRUBzg4LIAjG1
 O9kqDjYThLC7ed/2QWoMQoPCOQKV1L+RNnVSwfziOtV64tANZxd5tN9aXfvkSv+IhJ+x
 OKEXAlDALwCU1o++PBu4mpH9iKaL49Gn+M+0JNCPp2zNi56kf1zIfvAzhegF7TuNT6ny
 yqmW2p/AC8IGab6Epl+74I2WAm+9S6aIXaJ1SpdZohXnVgRFQI5l6yPcFTfSunUEzTiy
 4zIUtzGSA8jRGAdfEOPwjJ6RV8waI3ErZxYB951F7faYVOGixUkKLwLT5GuL4VBKcYHL
 7Htg==
X-Gm-Message-State: AOJu0YxzMJqllrnwcRW9RaR1VLsFv2dznxws4pzFgr9F8N4VSt5p2Tlu
 VlWB8k0wAhRaCfw3MJuhcuAGO61jmGmn/U198O/Kj8fEoGY9mILKJV3D5Wfd21wmk66SXMCgt24
 A3ELv
X-Gm-Gg: ASbGnctdNBp+G84xa+MnQKK7YxssjmnFuOx5eiToybLx6uJZbIGVBmzHFJbb3na5Hrj
 tmLKOa5zWFn7yWd0XpiMXlBJTM6H4fw4hx5EEGAIDf2VVqyIQ4taKZ3oZCSmymoxY0Yok+4J+Ym
 G78cv1/EjJQm3Wy7SP95A2hsmYX8lC/H+DWeeJ8L4wC7xAPNuJTtulbNtWUV2VBK6dmxoaHYDqr
 Q1Cie0jLZX/piQ1gr7V1oWmAb8EOO8ormVcb7TgrnRHJ7ghzeALAObIbjdv8MIdChC2AgKDQpMM
 6CNfKgecYgHuSeXJ1PCHZEVgCvEa67Ie97D0M4xu7HeSwjTn1UkJZjW4D4SMaoa/IU0t4ph+bEI
 7ueki8MpTZXS1aKSrIcRQfDa6kSIb8N8HHYEavTUQV0KSUAQKJ8w=
X-Google-Smtp-Source: AGHT+IHZNXhawfdwHeATDlqliO9dTWB0OH5TOlN7C9h1qGd06Y7amZmCfzYmON/grE/uLQJt0PEtQA==
X-Received: by 2002:a05:6000:2b02:b0:3a5:8977:e0f8 with SMTP id
 ffacd0b85a97d-3b613aca3e6mr2324996f8f.19.1752766162470; 
 Thu, 17 Jul 2025 08:29:22 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:eb9:1701:f497:a590:bf80:45c8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc3a62sm20890734f8f.40.2025.07.17.08.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 08:29:21 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 17 Jul 2025 16:29:21 +0100
Subject: [PATCH v2] fs: exfat: Remove unused label code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-exfat_label-v2-1-b012eacca67c@linaro.org>
X-B4-Tracking: v=1; b=H4sIANAWeWgC/22Nyw6CMBBFf4XM2hpaeagr/8MQM4UpTIKtmRKCI
 fy7hbXLc29OzgqRhCnCPVtBaObIwScwpwzaAX1PirvEYHJT5rWuFS0Op9eIlkZlXYEuLwjN7QL
 JsBhJWUHfDrvzxjiR7MdHyPFyZJ5N4oHjFOR7VGe9r/8Ds1ZakS6dubquaiv7GNmjhHOQHppt2
 37OW/v/wAAAAA==
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

Smatch reported a possible buffer overflow in exfat_set_label but it
turns out that this code is unused so just guard the function with
'#ifndef __UBOOT__' as well as exfat_get_label that is also unused and
the helper static find_label.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Changes in v2:
- Instead of removing the code just guard it with #ifndef __UBOOT__ to
  make future resyncs easier from upstream
- Link to v1: https://lore.kernel.org/r/20250717-exfat_label-v1-1-e15f28fd6c6b@linaro.org
---
 fs/exfat/exfat.h | 2 ++
 fs/exfat/node.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/exfat/exfat.h b/fs/exfat/exfat.h
index ca6f22b9d58..bd2965c3942 100644
--- a/fs/exfat/exfat.h
+++ b/fs/exfat/exfat.h
@@ -237,8 +237,10 @@ int exfat_rename(struct exfat* ef, const char* old_path, const char* new_path);
 void exfat_utimes(struct exfat_node* node, const struct timespec tv[2]);
 void exfat_update_atime(struct exfat_node* node);
 void exfat_update_mtime(struct exfat_node* node);
+#ifndef __UBOOT__
 const char* exfat_get_label(struct exfat* ef);
 int exfat_set_label(struct exfat* ef, const char* label);
+#endif /* __UBOOT__ */
 
 int exfat_soil_super_block(const struct exfat* ef);
 int exfat_mount(struct exfat* ef, const char* spec, const char* options);
diff --git a/fs/exfat/node.c b/fs/exfat/node.c
index 88b1357189c..b7406fbf3ed 100644
--- a/fs/exfat/node.c
+++ b/fs/exfat/node.c
@@ -1188,6 +1188,7 @@ void exfat_update_mtime(struct exfat_node* node)
 	node->is_dirty = true;
 }
 
+#ifndef __UBOOT__
 const char* exfat_get_label(struct exfat* ef)
 {
 	return ef->label;
@@ -1241,3 +1242,4 @@ int exfat_set_label(struct exfat* ef, const char* label)
 	strcpy(ef->label, label);
 	return 0;
 }
+#endif /* __UBOOT__ */

---
base-commit: 3b4604a40b9fd61b87e9d059fc56f04d36f1a380
change-id: 20250717-exfat_label-bf4af04ea293

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

