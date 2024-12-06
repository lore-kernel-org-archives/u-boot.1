Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AD4E77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 12:27:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4806895D8;
	Fri,  6 Dec 2024 13:27:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NEp3vud2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9D1C8962F; Fri,  6 Dec 2024 13:27:37 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 603F0895D7
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 13:27:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2154e3af730so16200305ad.3
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 04:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733488053; x=1734092853; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N06pj13TYRomTn2SuAs7SNbfqX3oTigQ8Usx7WqR3bY=;
 b=NEp3vud2JSj+yzfisnaodwnQu7lYi9/mYB/e9mDz8bnXgX9/zMSpvLWAYWjfo791eU
 rZ/ck7syO69egGM33JmvdGZZa58aNPEgSQYB9Zl3W0a1mRyMeRu1tboLiHOOsWgUAQUS
 KXdvOAPJMQtM4/RjTaywP1uMBukvpSuD8d4cFXLhTB9r4UbkjDr2PvSeOhgXjfWPSR4j
 nbjCtcm/wGWc8Izpx69LP/JiWTYLV7kOunjtRXisI6o2bB2szbyrJ4XcQ0JODkAHwJ3k
 xuclcKk8mCDVdq1VHDUSkTzxyHOVxUoJgKMFK9ZMbDjC303BiDStgBZfV8vHDVpB3d4o
 zjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733488053; x=1734092853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N06pj13TYRomTn2SuAs7SNbfqX3oTigQ8Usx7WqR3bY=;
 b=ZBaVaiz/iKf2WiVwr6I+oRCs8y6+siqOuOwJ3dHDLhrXfjVMvPrtrORLx7dmOEu1ua
 mZFP/fcB0LcYvObbbFBhX/4jYmcxeqQKXY1pCNZ7KUpamIMfge9r1cKMQ7U9D1fQXIy0
 E5eEbvCRGGoXiiADiYGGcFD1zeOh8UCoPCBRuWj4VwBDNaEkkWw+EiEaI78XOR6cYOL7
 xU4pHE4q/V+jC4OMn76ipUZcdMfmPwTsMcc1TBIrp3LTkYyTGVJehI0wzInQ0kFV2Ael
 Ui20QOk6wlVAOSSfMJ7/+UxUhagUld+55WP9VAeLJpbTKpGaLUi0hCkIbb/5J2I8yaic
 0npQ==
X-Gm-Message-State: AOJu0YyPLqUtnvQdIEJC1buKj6dr+7CNx7K3V18yC5c+a425XwGAqmBK
 Br6V+TW6JFWzMyn9sAXpWwJV67sqA2o3pAjUxV7A8XQyFVRSYkEh0+M7AHdH2H0=
X-Gm-Gg: ASbGncsixJ/jh0cB4flLVqTPxnJ+hfbjI+bcJtEAb/5fP3xbzJ9NIXklsqFMeDwSnaN
 F/LCoZ+1JdkbVUlDSBw1qflbLd8eUEQMSt26NfHo/5robnvfTLzyzYk0p2aZ5Bv2sknB03Jieg/
 OCdhVlSyPxxKTrly7t/Q7RSANAPKLI2P2aC+BxdVCVkTvvna3rgyT60YKmSbLm0uK0quz2Nh+mc
 BE9xMMJGSk7QOTBWxun3YZjys2eqKogJTpcb5dJApL6BsgJJIF0sl0Qjg==
X-Google-Smtp-Source: AGHT+IGgfRetW3q4bFNVL5C4Ui3zzfp9NFVM/tqR2ZaSLMr855drL5hvU+O/ZjigtzIKvw/FxAIcXQ==
X-Received: by 2002:a17:903:946:b0:215:609f:3f9e with SMTP id
 d9443c01a7336-21614db2bd5mr43198525ad.40.1733488052868; 
 Fri, 06 Dec 2024 04:27:32 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a2ca6725sm2821011b3a.151.2024.12.06.04.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 04:27:32 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 1/2] efi_loader: Expose efi_reinstall_protocol_interface in
 efi_loader.h
Date: Fri,  6 Dec 2024 09:27:13 -0300
Message-ID: <20241206122714.2365114-2-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206122714.2365114-1-adriano.cordova@canonical.com>
References: <20241206122714.2365114-1-adriano.cordova@canonical.com>
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

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 include/efi_loader.h          | 5 +++++
 lib/efi_loader/efi_boottime.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 9afbec35eb..0d858c1e12 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -711,6 +711,11 @@ efi_status_t efi_search_protocol(const efi_handle_t handle,
 efi_status_t efi_add_protocol(const efi_handle_t handle,
 			      const efi_guid_t *protocol,
 			      void *protocol_interface);
+/* Reinstall a protocol on a handle */
+efi_status_t EFIAPI efi_reinstall_protocol_interface(
+			efi_handle_t handle,
+			const efi_guid_t *protocol,
+			void *old_interface, void *new_interface);
 /* Open protocol */
 efi_status_t efi_protocol_open(struct efi_handler *handler,
 			       void **protocol_interface, void *agent_handle,
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 080e7f78ae..58716fa795 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -3733,7 +3733,7 @@ out:
  *
  * Return: status code
  */
-static efi_status_t EFIAPI efi_reinstall_protocol_interface(
+efi_status_t EFIAPI efi_reinstall_protocol_interface(
 			efi_handle_t handle, const efi_guid_t *protocol,
 			void *old_interface, void *new_interface)
 {
-- 
2.43.0

