Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35E3C4167B
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 11:42:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71A2087073;
	Mon,  6 Nov 2023 12:41:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k00+xSLK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDB1587030; Mon,  6 Nov 2023 12:41:00 +0100 (CET)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DD9687026
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 12:40:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6b2018a11efso4514785b3a.0
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 03:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699270846; x=1699875646; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AkOk14+cUkmTCLZdgvgP050yc2BoHQLrc88kjtUwoA0=;
 b=k00+xSLKQTnfMc64iB0eaK5BwIgE3sw/asvxdVlJ7kdq6nLedwE6cExcDp/qXwEQ0Y
 6tS7eANlib/RSSxxDN7QZMCgXOwKV4gvP1VnOf7i236M+iKs438YiNRD4F0R3i68hZTd
 BSDdBj/nMF0llvnU4pLYuEz3M49bQPUk10Tuq8UDo9DuOMOi1FXe+FcQ3StZg9jquaE5
 VIwad/8N+9ZMwb1y4mpJACO19VQaz++rrQipO9QUrv5NafIlVsDJjlNUfLSLsZjPAXDM
 dscE9cpb12583C01UXgUgTVo64qEY8OmcKRFvrWi2kTvEMR0y5yD8qLGAob0OOd1dn3n
 YNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699270846; x=1699875646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AkOk14+cUkmTCLZdgvgP050yc2BoHQLrc88kjtUwoA0=;
 b=g+Uy8dP3ZXueXSxJW2cyB+Mcxjl/MB4JZQbtZ96wB25DOPfVXAulWmtOyaXbzofKmc
 dL5vUdJeQvYGYIZGXJp+LJFo/yKsuXX654QfSKDBYwu2MPz3fZ2LJ3J31vjGHyHC0I3Q
 zTXDlUZ6JzWyh7D7nuwZmHFBL/xrLW1e14Y+lS4fSLooNMfdK/bRzxXWQn/r/cJCI9y5
 IhvzAdVl/DGP2sL0xbrZdZ3QHDSD3LYY1JxtSQtiiQTBkwjnnYXlsc4jD6OYT3BzuiLT
 T9DAX0VGZDb4DMlaOiWqrzd1wP8jIjWlc/FOR+C9Y3cjsf5Sn/m2XudXKKDFUZFQdMgj
 A1UQ==
X-Gm-Message-State: AOJu0YzVTbEciZR5mL4QOoGbmZ2I/p6gS0GpZv8Jq9duuojKEAd85BBk
 be4k9SrJ0h9WVyo48foFMPyxLmNLDypwM88v700=
X-Google-Smtp-Source: AGHT+IFPz4cuSHjx25zdwPUcvr0GaF3d19iFUShm303zIaUuKHmqcV+FP9CXUAk5Ii1Av6oVF/mZhA==
X-Received: by 2002:a05:6a20:7348:b0:17a:eddb:ac6a with SMTP id
 v8-20020a056a20734800b0017aeddbac6amr38052000pzc.6.1699270845877; 
 Mon, 06 Nov 2023 03:40:45 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 6-20020a17090a018600b0028009de5c65sm5836999pjc.39.2023.11.06.03.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 03:40:45 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [RESEND PATCH v10 5/9] efi_loader: add missing const classifier for
 event service
Date: Mon,  6 Nov 2023 20:39:16 +0900
Message-Id: <20231106113920.3631591-6-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106113920.3631591-1-masahisa.kojima@linaro.org>
References: <20231106113920.3631591-1-masahisa.kojima@linaro.org>
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

const classifier is missing in EventGroup parameter of
CreateEventEx(). Fix it to remove the compiler warning.

NotifyContext parameter of CreateEventEx() is also defined
with const in UEFI specification, but NotifyContext parameter
of CreateEvent() is defined without const.
Since current implementation calls the common efi_create_event()
function from both CreateEventEx() and CreateEvent() services,
NotifyContext parameter leaves as is.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 include/efi_api.h             | 2 +-
 include/efi_loader.h          | 2 +-
 lib/efi_loader/efi_boottime.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/efi_api.h b/include/efi_api.h
index 8f5ef5f680..c2d6964467 100644
--- a/include/efi_api.h
+++ b/include/efi_api.h
@@ -192,7 +192,7 @@ struct efi_boot_services {
 					struct efi_event *event,
 					void *context),
 				void *notify_context,
-				efi_guid_t *event_group,
+				const efi_guid_t *event_group,
 				struct efi_event **event);
 };
 
diff --git a/include/efi_loader.h b/include/efi_loader.h
index e24410505f..e164e6067d 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -685,7 +685,7 @@ efi_status_t efi_create_event(uint32_t type, efi_uintn_t notify_tpl,
 			      void (EFIAPI *notify_function) (
 					struct efi_event *event,
 					void *context),
-			      void *notify_context, efi_guid_t *group,
+			      void *notify_context, const efi_guid_t *group,
 			      struct efi_event **event);
 /* Call this to set a timer */
 efi_status_t efi_set_timer(struct efi_event *event, enum efi_timer_delay type,
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 0b7579cb5a..f9b10a9763 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -712,7 +712,7 @@ efi_status_t efi_create_event(uint32_t type, efi_uintn_t notify_tpl,
 			      void (EFIAPI *notify_function) (
 					struct efi_event *event,
 					void *context),
-			      void *notify_context, efi_guid_t *group,
+			      void *notify_context, const efi_guid_t *group,
 			      struct efi_event **event)
 {
 	struct efi_event *evt;
@@ -790,7 +790,7 @@ efi_status_t EFIAPI efi_create_event_ex(uint32_t type, efi_uintn_t notify_tpl,
 							struct efi_event *event,
 							void *context),
 					void *notify_context,
-					efi_guid_t *event_group,
+					const efi_guid_t *event_group,
 					struct efi_event **event)
 {
 	efi_status_t ret;
-- 
2.34.1

