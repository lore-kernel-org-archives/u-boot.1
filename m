Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849EEC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 11:08:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FFAC876E7;
	Wed,  8 Nov 2023 12:08:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KHigaRyE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B95D58752A; Wed,  8 Nov 2023 12:08:09 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B4C687700
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 12:08:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6b5cac99cfdso5621299b3a.2
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 03:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699441682; x=1700046482; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AkOk14+cUkmTCLZdgvgP050yc2BoHQLrc88kjtUwoA0=;
 b=KHigaRyEeDqsj33sLvhXJNu9urb+J27led4qHWyCy1hWACiH2mjQDZ3CkBi0PIJf1T
 rJi4qC9dJY/jVfEj6uIcsMCHc87ySBxrbXwVXD/axYo+cHRL1ytn6AcSxXdx6GqpAJ7i
 CEk+NPeejqCuqovvvlkteaWr0K+Zh00p3B/6et/TSlA9P+mjKkQHRZFXEVlo1Cko0NDm
 NnBwyzo6bVhTrpg7/LVqwzhq6iZDoezuhpu2kYI0OcYBIkqo/Tf7Ab10jT5l/KcDeQhL
 4TzCm46J6m/pp/KG4YqK/7EwV7puL/pauPbUUC+2pvWqlfv2XKYP5bIrkqPPkqkk+DiR
 qt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699441682; x=1700046482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AkOk14+cUkmTCLZdgvgP050yc2BoHQLrc88kjtUwoA0=;
 b=CzMeSR4GbCFwAc4ch53NcRKpVxeVp3qcY7UJVna/HIG74waV6+5+qwzoJSTlk5fLUI
 1nsf1gRo1Wic5sOcDM9KFJ+tK1b9eB9DiiJ1GongUYtps95CZcKafld7iZV4naRiOxWR
 C8UudOyUt8QA6vb+Hm92s1WInKeDbwAiCzz51tR2n5SEq2TYbrn+AifwntKg70DlpPaU
 0vsmNQzCAzQU56nfWx5d+1Faj5RIUl5VJDklQa/zYUIKrfWuvyaQNAyURlZRiEb8yAP2
 nF9gLMq73hpvvCC9RCPBmY75/TLztVSmnWMQW+ph0cBthGihcGlVu5XDQFLDH9LQfM49
 Rn2w==
X-Gm-Message-State: AOJu0YzYf8D6oxGPpON4nBn+I30LZM3aGSGb8GSIVOMQqC+/Cbkkj9Xz
 BCXQljyx6SS9sTQHhbn+2XwyIv8jV0pvzYZBWjM=
X-Google-Smtp-Source: AGHT+IHtrVZdX2oH2F/F2BF1qG1wWcFEcHosThmfNFnrJzjYgJ96aXzKLiGdP2OVW37UYk2KY+h0Mw==
X-Received: by 2002:a05:6a20:160d:b0:17b:689e:c757 with SMTP id
 l13-20020a056a20160d00b0017b689ec757mr1658327pzj.11.1699441682510; 
 Wed, 08 Nov 2023 03:08:02 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 y3-20020a170902ed4300b001c5b8087fe5sm1504513plb.94.2023.11.08.03.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 03:08:01 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v11 5/9] efi_loader: add missing const classifier for event
 service
Date: Wed,  8 Nov 2023 20:06:32 +0900
Message-Id: <20231108110637.3691441-6-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108110637.3691441-1-masahisa.kojima@linaro.org>
References: <20231108110637.3691441-1-masahisa.kojima@linaro.org>
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

