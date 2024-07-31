Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E07C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:42:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF9CB88A8C;
	Wed, 31 Jul 2024 16:41:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XbHVc1/B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3353888A21; Wed, 31 Jul 2024 16:41:24 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C128088A85
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-81f9339e52cso269366439f.0
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722436880; x=1723041680; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=heeNVSuPfmKGlf8ZfBiv+awmb/TEadwE07nfjXnqUpI=;
 b=XbHVc1/BQIsW3gsLgNWwORLrMVK/65wemWcjhgYERIEiVfFOoL/YWQVStghE2Rqh/C
 PqZyJAojXErCgnWCOBKkkNg5JZQ3+f/iKuZE4eqmoZufmNxD2AfHpOjNSR4CHJ9MLbRV
 t3YUqtj0mp5lI4r4v6H44f2aUlE235BpF4fO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722436880; x=1723041680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=heeNVSuPfmKGlf8ZfBiv+awmb/TEadwE07nfjXnqUpI=;
 b=Db7OPO/jt57+ns6ZCDYwi861idhdyoJHvnknk5BjkBxR5Ex9/cLcMVfYZmwrHbUJfL
 6td26BZqQQJ/Sosw3YsK5WLQKo0Uc06RWWsTXOqH4sH9pKB3w/ZF+uKz6k2fjEeNRSuO
 hgV1Yu8YUvkpSSAQMvi59sagdepbapw/2hQZza8aNvQZuO9maZ8mr1lMwPAlF2qJP1aR
 xIbcx9iq3m+NeALic7cxc9f22oixgVGm/71+qprIIBftYpn5wRx3WfT+0/7nXEwAserr
 8JBqx0906nZuhjVM/ZM/ZkVrvRCXlHPvh4UzK1rfQWwkyL4aQdagv9/3o0r+xuQXJOCF
 ZOFg==
X-Gm-Message-State: AOJu0YyjrrDCmC/frXP+ubXzSe93VwxVYvfIuytGcs7HX6jZ4P2xmYj+
 GZKZdou0HPwq9/Wn1yEDix+DnBivglNEkdlDGwws7Vp0Isws5oIyh4gJ8e4H9s3BnFYxRZLpKvs
 =
X-Google-Smtp-Source: AGHT+IF3PbEjltc6a2sfh+Ch3YYWVQCo8f6ZBvFDl/eRDX38quDpmbFoAYFpZBD8xHNXb2yLxrvwug==
X-Received: by 2002:a05:6602:26cb:b0:81f:8e7f:a54d with SMTP id
 ca18e2360f4ac-81f95bce33emr1682967539f.12.1722436880393; 
 Wed, 31 Jul 2024 07:41:20 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c29fc0a569sm3209770173.126.2024.07.31.07.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 07:41:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 4/5] sandbox: Increase cyclic CPU-time limit
Date: Wed, 31 Jul 2024 08:41:11 -0600
Message-Id: <20240731144112.787509-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731144112.787509-1-sjg@chromium.org>
References: <20240731144112.787509-1-sjg@chromium.org>
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

Now that sandbox is using cyclic for video, it trips the 1us time
limit. Updating the sandbox display often takes 20ms or more.

Increase the limit to 100ms to avoid a warning.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/Kconfig b/common/Kconfig
index 87b0ec3ea8f..83c81edac20 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -636,6 +636,7 @@ config SPL_CYCLIC
 
 config CYCLIC_MAX_CPU_TIME_US
 	int "Sets the max allowed time for a cyclic function in us"
+	default 100000 if SANDBOX  # sandbox video is quite slow
 	default 5000
 	help
 	  The max allowed time for a cyclic function in us. If a functions
-- 
2.34.1

