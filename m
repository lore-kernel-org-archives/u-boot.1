Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D42CC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 04:28:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E216A877A9;
	Fri, 10 Nov 2023 05:27:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b+x2dr11";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB3818778A; Fri, 10 Nov 2023 05:27:39 +0100 (CET)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com
 [IPv6:2607:f8b0:4864:20::931])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF2DF8779C
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 05:27:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-7b6cd2afaf2so746787241.0
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 20:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699590444; x=1700195244; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AkOk14+cUkmTCLZdgvgP050yc2BoHQLrc88kjtUwoA0=;
 b=b+x2dr11TugiLYG35myef0TfumlWq9wFREl2Hp41zFTCn8v4/bmrzhQHX4bWk4SJO6
 5VzsgpwMvkXh5KYSNfTFoPMwSaTG7m6v6Blb3AU5JnAe7d2ivtq9imXuzoYlNi7Ycga/
 GqNi6buaBrK+aHcZ7wTJvQzgf4n+b/IwxDuxVH+ne9DP/uc8BbjPdAyM62wFMxcfi/wX
 aIM/YFE670VJQQ6i1G/1JwJn3AEO5n3ckwB2IEI3hd84emoKHSd8y4WvXKY4P1O9YveI
 bHcIPr8S189175DsmwOSuVuI1mI5KIIyH66lZgjJZmbMD4/vWZp2NRAusG1IgRiz8sU/
 U3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699590444; x=1700195244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AkOk14+cUkmTCLZdgvgP050yc2BoHQLrc88kjtUwoA0=;
 b=MKycuG0fea9N2qBTQGcgiYmqDicIicqaadpfIsSMLDkhVmr5kto2a+n7tSd7oeUQpx
 BXw+yNko+mTVcUBW74CIGmb8jgMeTD4FgA/z/UYBtJDnK3Qu24MIbWIIzPg4ly8H3Hpz
 X8UjcYEx3Wnjg22nVG1xHCZaKBWA0TuYbPFMSkMBCc+92iJFmNTpjzfsfKAdeL5VMyBC
 n5BLhl3pnzMaPiLOn22M75rSFLr58sQD8FgzX/MJ29ntAhevDQpb6yHCAnFgCxyiHkuo
 BNir5+fl6B8CRIVTdzovCCWGE/9U421nMIsGjleOfYp8bd0VCe7YE3e/QgCF5VSK66Am
 VKGg==
X-Gm-Message-State: AOJu0Yyr/e6QJe2jH7hdB3yKWXwyPMPCPnNjRQrhki9BmAaJaLlMaK/K
 xhuFt/1n46GuvbxGnV7Z55FxQRC1zh5h35Nf7zU=
X-Google-Smtp-Source: AGHT+IEE+WhHeWRvyKeVsVB5boOSb9j/UE+HxsGQHug8pHvl5/Yo72pRiVEMCgZrnWKvCX6ktll+5Q==
X-Received: by 2002:a67:c281:0:b0:45f:66ab:f757 with SMTP id
 k1-20020a67c281000000b0045f66abf757mr6793482vsj.6.1699590444422; 
 Thu, 09 Nov 2023 20:27:24 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 k3-20020a170902c40300b001c727d3ea6bsm4378116plk.74.2023.11.09.20.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 20:27:23 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v12 5/9] efi_loader: add missing const classifier for event
 service
Date: Fri, 10 Nov 2023 13:25:38 +0900
Message-Id: <20231110042542.3797301-6-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110042542.3797301-1-masahisa.kojima@linaro.org>
References: <20231110042542.3797301-1-masahisa.kojima@linaro.org>
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

