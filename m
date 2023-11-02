Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51459C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 06:47:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98F9B87253;
	Thu,  2 Nov 2023 07:46:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m99/jeRv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD84786E88; Thu,  2 Nov 2023 07:46:39 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE95D87703
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 07:46:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cc5fa0e4d5so5276095ad.0
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 23:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698907592; x=1699512392; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJblxL503HrvYGakGMsGmRKvit2ltsCs9InMyBUP3XE=;
 b=m99/jeRvdAKBEp4IS/lTWcWeNxfYZD3zXU5egclx1h2ELttw579bLLc+VvDnT3G57F
 l6qeIZdhkTKt05lCWPTy/PJYUktA4pdfDPmLaBoergs+UFNLnB1JwQOH7O3UnxYt8Vhx
 eNAWJLhfR3oZZkAYC+obYI+OMdtSiVQPCGxaG1UKIdRkwkRsraxUoNqVFwUumeumz7OL
 DpLGn7soV5ZgG5cTSWNSntvUYOsr31Jah2A4B8HbDP1WMsA0ya+NL1W1sMWZIp/iCgi4
 8+G50sVb1A+Vcei4tYosYFdlc+TScuEUdO+bKYBfgqffr54AEuiKiitahEGGHuWKHMEF
 L8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698907592; x=1699512392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YJblxL503HrvYGakGMsGmRKvit2ltsCs9InMyBUP3XE=;
 b=obtMNAiFNVs1/yKPV7hokPQHYUsGnW8/J1uUZeKzwo+t+b5lLUsluSq3ECO26LVyu+
 2qRU5yN/XzfeNB7X3CAjrA1py7F6uQd42dYR3nRxuNy+6oOJp/bDMWWRuEBpRReGBzg/
 LH4TqKNCvoxTIlfUxjkgsGjK/GtWq+Qk1hueikCvSzSFf1xYuApidbgWzkGC79snmTfg
 CEUVzsikbNBRqHrWRp6dYSqmL0tjXWyRrLV1ajtwFgwUYBYfpbD/EbRX/gtjUL57Votw
 3E6rnwELF+1HiATT4LrZ1w0vxOKu8aQjZlthrAJZP0jbMRvhC3t9jfxv5gUKpM+zaF4I
 xmbg==
X-Gm-Message-State: AOJu0Yx5BjwGQVTAvRKTGiHQ7Et0eAyavpydvwJP2xuHpGDFLRzgxC6j
 WgS4I344dUX8ByPxiPquJhxxmfuvBMqT/t+yq5U=
X-Google-Smtp-Source: AGHT+IEDIXIuf0f3BrWnsn3nP7S03OPzm2WrldJw8b/L3K5ayvGGrt5/e6k5Jox+u4cMzn8dFZB6gw==
X-Received: by 2002:a17:903:2346:b0:1cc:449b:41e2 with SMTP id
 c6-20020a170903234600b001cc449b41e2mr15777009plh.23.1698907592572; 
 Wed, 01 Nov 2023 23:46:32 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 z18-20020a170902ee1200b001cc2bc10510sm2328349plb.128.2023.11.01.23.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 23:46:31 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v9 5/9] efi_loader: add missing const classifier for event
 service
Date: Thu,  2 Nov 2023 15:44:55 +0900
Message-Id: <20231102064459.3466953-6-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102064459.3466953-1-masahisa.kojima@linaro.org>
References: <20231102064459.3466953-1-masahisa.kojima@linaro.org>
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

