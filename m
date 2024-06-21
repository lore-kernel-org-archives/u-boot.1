Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A637C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 13:14:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82CAD88528;
	Fri, 21 Jun 2024 15:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n7AvEJCd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88C1E8853B; Fri, 21 Jun 2024 15:14:30 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74A0E8834D
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 15:14:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-7ea0b5e0977so81116739f.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 06:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718975667; x=1719580467; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Mv2z8VdDkE/D666PtSVwNsBKvgq2g5YlfbxzU0Pdis=;
 b=n7AvEJCdIgpUjOT9NLus7toTZ7umC6L7s6L9UjtCCjAHsGbLAMdt1MU5ZjZXJJwTgU
 i3WTVjphzvj6llHnjeDsfxRIiJSd3uQ61kgAxCa2ozdMBa2qnvE+yArkAJ53p4VOEDZI
 g6PQxqWy8+8UXARfycde5bKbjEWXoQvXTK6YU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718975667; x=1719580467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Mv2z8VdDkE/D666PtSVwNsBKvgq2g5YlfbxzU0Pdis=;
 b=gKdr/WroaB4s0gnTqzWaqPPdhPcMYpHjn73AMLapYJoWKUwr4HolMYhTz/zxOL8WlT
 NlAEkJ7Lk5Ee9fso3dkesWpOp7QINQdGMzXO0yhKHqabdLfuBhoFw4qM52k8gFF3Ddyv
 Uacqyl7ufLEkRHf3LZKK5lhJN7FvN3Lg9kB835HR5Wi9QhGAMOlp6mqU0uxdobEckHb4
 YuWXXIZpCJDZ2F6Qwop617g4jCMkG08FJhp1yKTQxXL07AnfE2NF/Thj2sQYqgMpSSh1
 7DNVc7jI5HK/ThwR5FSlvve4Wl1Wa4kpfKJ49yLYTY2jjnJ4AoZJVI9IDR6t5ikGlBRM
 GI6g==
X-Gm-Message-State: AOJu0YxoIpgwnIKogrEZH/NFzGZNq4Cd9z/JN6SuJMySkKhfww6RVPE+
 xPNOlah+7pYbve6u77oFJWSPhyOTA9DaAItl5SBFZEGbRECa9BOA4PLLD5wTjEx+gJ3e5BY5i7C
 VCg==
X-Google-Smtp-Source: AGHT+IEixZ/sNzGx6+MxVuNhNasFgXB6vaKkQGgmnJeavRLTNav5lsxFjeRqujcZU9uHD47TWN/YMw==
X-Received: by 2002:a05:6602:6c15:b0:7eb:6cbc:8856 with SMTP id
 ca18e2360f4ac-7f13edb1690mr943909839f.2.1718975667135; 
 Fri, 21 Jun 2024 06:14:27 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d12496fdsm346881173.163.2024.06.21.06.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 06:14:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: [PATCH v2 1/6] buildman: Add python3-coverage
Date: Fri, 21 Jun 2024 07:14:17 -0600
Message-Id: <20240621131423.2363294-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621131423.2363294-1-sjg@chromium.org>
References: <20240621131423.2363294-1-sjg@chromium.org>
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

Add this package so we can run code-coverage tests for Binman.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add to buildman requirements instead

 tools/buildman/requirements.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/buildman/requirements.txt b/tools/buildman/requirements.txt
index 4a31e69e4cb..564e54898a4 100644
--- a/tools/buildman/requirements.txt
+++ b/tools/buildman/requirements.txt
@@ -1,3 +1,4 @@
+coverage==6.2
 jsonschema==4.17.3
 pyyaml==6.0
 yamllint==1.26.3
-- 
2.34.1

