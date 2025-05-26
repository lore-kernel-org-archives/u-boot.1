Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5B1C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 10:19:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 686FE83826;
	Mon, 26 May 2025 12:16:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VcXogXI4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09B5C836B8; Mon, 26 May 2025 12:16:40 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1AB1837F5
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 12:16:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3dc8265b9b5so17973245ab.1
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 03:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748254595; x=1748859395; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lBEcIS4cZqZU+1bfwRhB5CC3fSwbjLDiFw5yY5ktUDQ=;
 b=VcXogXI44Nen5OlVTzqi41sCyq7PgqFbch5bZ+SRjfNsIBURU+df13ZDA2Fu0LmWh5
 Kb8vuwXCwOFkhzlJaE3PTzC7xkgneUw6hpbSbvGt5cDYEqMECpH5zHqueB3nR0ImNmLw
 M3d9UpELWBsINqFuxVW9DXu6JQxd5U4jei7VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748254595; x=1748859395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lBEcIS4cZqZU+1bfwRhB5CC3fSwbjLDiFw5yY5ktUDQ=;
 b=jflALLj6rjvOATKtXvNmXV8FlXrWVUMsShyx4iucCtl5VQkUfupmcQuuIeFyhGgvs8
 /HSHC8Q0ebItDKdIWWqvd1qHE3KcndT+C8R4EpPmjTS7xQ8OCpdvlFxOKVzSm6dLK6dU
 5GqOVenwDfMWiBvYTeQoR1oYRQeVBNFZ8rB3ugqYKiQWwJTMriV5GfnxaY/V3yWgMlQC
 fCYJcmnTBWMMwTsZ9ax3hK9HMElE7M9pFOngJ6mfCXzasJpQ/IiwJNaBTd2FcBPGMAAq
 xD4N86xS8ocs1uVnLJ/IGf0LMKr5v6r/ic6nDOxn4tufSuroBwfkZo9pXgw0yAkUd9cY
 aNkQ==
X-Gm-Message-State: AOJu0YxBew3NMIom7O57+X9ZKQbxoL1lydryhahQe2Q5h51A4LLIA+wy
 0RECcGlZrSmadC5w8zKcKIKEfHBjZGJVIypicHQQcBQrGtOJpfVXHadM0nvTDbe3YyGoYeKBXHh
 2MgX/gEfr
X-Gm-Gg: ASbGncsrfMwm39zgayhrIbuLQUGmMZs21Icv1C6c3dMdM4g8rI3Sej4pIzd+pcyxFf5
 uWiamRzpt6L4ui9kyhiH+5mFss7wei1dvaEbkWiDQ22EG6ab+IJG+X0StKcJZWudAKngW13N7ih
 MqH5f32YfX/C7/feg0pf67N6thjYVPcv1NDww6iYEfrZudLC2v2xDimzChd4ml+D74GV4g0F4ie
 8jRxvJy2Cg8MK8OQWWdU/P62VRPf6Ina4gsX3Cclkr7hNutLmjDEc7axMcvGFg0C3yKmY3fXOge
 /zkoSFzVhUoStbK9+em8rz7OvOrBrWF6GEWuYXuLcikDQ9vDxsrIbgseeGfAbCr1oK71pbsRvcV
 yEEJKj6lt5DMmLU117ygd1YE=
X-Google-Smtp-Source: AGHT+IF+O20mMPO89ML0nevbsv3F7Z3s7D8go/m8LgiJ/Q87ZC6QT1NZWYaTrHlbtH4NJS5Ef/gonQ==
X-Received: by 2002:a05:6e02:174a:b0:3dc:757b:3fab with SMTP id
 e9e14a558f8ab-3dc9b68e03fmr73152025ab.6.1748254595581; 
 Mon, 26 May 2025 03:16:35 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc3b19aasm4679249173.52.2025.05.26.03.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 03:16:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 19/25] gitlab: Add an VBE board to the sjg lab
Date: Mon, 26 May 2025 04:15:05 -0600
Message-ID: <20250526101541.3254628-20-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526101541.3254628-1-sjg@chromium.org>
References: <20250526101541.3254628-1-sjg@chromium.org>
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

Add a rockchip rk3399 board which runs Verified Boot for Embedded.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 .gitlab-ci.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 7aadd5d8b73..cf8147fbfd5 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -738,3 +738,9 @@ qemu-x86_64:
     ROLE: qemu-x86_64
     TEST_PY_TEST_SPEC: "and not sleep"
   <<: *lab_dfn
+
+# Firefly-RK3399 board running the rk3399-generic build
+vbe:
+  variables:
+    ROLE: vbe
+  <<: *lab_dfn
-- 
2.43.0

