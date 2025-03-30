Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B09AC28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 09:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A80E81951;
	Sun, 30 Mar 2025 11:01:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gbs/uWA1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4112F8129B; Sun, 30 Mar 2025 11:01:44 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44D998129B
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 11:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e5deb6482cso8312696a12.1
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 02:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743325302; x=1743930102; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KWIkO5HQER/tLcQEsGX2TDkDzxeazu1O5fhxLdCKycM=;
 b=gbs/uWA1FHdTEWPllo7dW16RdFltTw5ufGHEb08s5o52s2H+25GztzpkWRSMfyv1Qx
 AysI7xmRaAVc3hI8QWXw3QeHwTbA1xDGM6GaFDti3+eAoT7UjqXZ+9gTlUcfg8GF+VYu
 AV1Qyx5NSJgHXpU8lETISCfuIOfScnKIKmDzaqd+f2Tmeks6BGEXbefVxtlFK5qhSz4I
 NPc+/ch7sLuaGTvsfnIyMKIjob3cZVxKvKv91rAdiTGLxeDUSjpopg+cpE5nyycAJ0Jl
 Z7QuVNfcX7dQJhT+vmUDm+ac4UzGh+fYWypgW/a/VDqsQcAXWxOu0rWxblCFjl27Jegs
 nT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743325302; x=1743930102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KWIkO5HQER/tLcQEsGX2TDkDzxeazu1O5fhxLdCKycM=;
 b=FKqUtAuNXaLLOj72AxA1V6ZOO3jzwh+LLnjC33KROsjncN66r4R/i8X0x/3r7E7foh
 GHmUYe8qpjZnHc+g7EmM9xW7RQPQ8sln8OtbAxbZtDZmH1HOjrCAhZZw6XZoBjKwtGyy
 vhHW3604fYngkddHW3wt6ra+9/39eQF6q2BCEM/v7jF60EigeIJ11tRwkOayw0ZqgU2+
 wCbl+wFQzaknAAX39dE6dGOAqf5tTnrmKKSPcb5RsxJEUu929meOT7DQfW5kN9mXr1QG
 WjsyxBtrryx6O2qyYNM66yBqJppIRgQALFu1EQDMOHB1nrmOhmArLu1uuoY49ZprDsCC
 j79Q==
X-Gm-Message-State: AOJu0YxOSR6d8++gpNDvFDLQCHKSkPVJm5qBoqQpuhVJjEK6pk1pokmN
 i80nbWPmtTUpIy7NQQp98D/lqjYzb7Ekd5t8AQy5FBb8g+HRhPsp
X-Gm-Gg: ASbGnctXdylKUs+FN7FJvy2oQVx00DotxfMhzryFLJvyKEf/B5tVQ2v4NPORIQnAOQ6
 GKkKPbUiquLF0JuNw6xaq1nnMvWWNfOJ/pVI21g8R2w5REMDDlLF8WOfCK7Q2SRdadbGfUvD8aS
 PzgFx6HNJvc8G3bH2kU4u5YTzvNtWLhu8mtifPvo8QUmM45eGKh2kT+REEv41ck8I6M6+kujJDW
 Qdk07OMcWy6voha3ow+Am9uYArfkHoFzNLb0IOytjwqlcLab96wT2oihYfopxswWoXQA6CqFqYl
 gUB2piLHTb4OITHAEQYx4yEyRusqoxOVoeap
X-Google-Smtp-Source: AGHT+IGFaiPAulslYHV2ibZ4ppRvbKCv0hdWw8gPTbTVxb3qZ+Rsn/7DZDNv1DAVedpN1JX7CfgsWQ==
X-Received: by 2002:a05:6402:5cd:b0:5e5:9c04:777 with SMTP id
 4fb4d7f45d1cf-5edc44cbe91mr7434532a12.6.1743325301452; 
 Sun, 30 Mar 2025 02:01:41 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5edc16aac10sm4172595a12.9.2025.03.30.02.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 02:01:41 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/2] configs: ouya: add missing SPL_HAVE_INIT_STACK option
Date: Sun, 30 Mar 2025 12:01:19 +0300
Message-ID: <20250330090121.8312-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250330090121.8312-1-clamor95@gmail.com>
References: <20250330090121.8312-1-clamor95@gmail.com>
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

Ouya was added and tested right before this config option was added. Add it
to restore proper booting.

Fixes: d6a53f52 ("spl: Add an SPL_HAVE_INIT_STACK option")
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 configs/ouya_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/ouya_defconfig b/configs/ouya_defconfig
index ccd6ae4d36f..d4ae9dbb57c 100644
--- a/configs/ouya_defconfig
+++ b/configs/ouya_defconfig
@@ -26,6 +26,7 @@ CONFIG_SYS_PBSIZE=2084
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80090000
-- 
2.43.0

