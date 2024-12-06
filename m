Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D13E77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 17:19:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A49989737;
	Fri,  6 Dec 2024 18:18:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JODsz0lJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C3B989739; Fri,  6 Dec 2024 18:18:58 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BF5D8964E
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 18:18:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-215770613dbso15465305ad.2
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 09:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733505534; x=1734110334; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q3WLB+VlvJaVRRB41n4OyNGHxrF+25PmuihgMN9TPJ4=;
 b=JODsz0lJ4K1A3J+/IwQ8Iv1zWkRBuid6Pr41wKlRc3Q6TuuBqrTNeI5FaGotXpSshd
 +2PNM5ZhUW7CdxGMWsDFSHherVTkZNrpasI4zY+kvEB2y+gjpw6mRxTc1aFLXz3Ym16x
 kzJg+mLpyf3ZCz3DwQI+5zkmRjW+kM9fgCOb0TT4j4zGQnvTKerL9YSHVtdQ5mcqYBaj
 W7Xx4GXcPjMI8KRJ7479HGCP8krA8nM/Wpw+9KOWthJImkjlkNg2nDu5dwNzcmd1HVi/
 6FG7OqHkv7+OSycJRves4kFpDQqln82Vw752+PVh7XW2wrsExUmOMBIQqi1BtN+FE65y
 mq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733505534; x=1734110334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q3WLB+VlvJaVRRB41n4OyNGHxrF+25PmuihgMN9TPJ4=;
 b=fkIGwRdJpDuSYSXhOdq5/oMoW2WO3ONNVuMsniG0ZAC15zNH+fRcxGVozGRVE8GiZw
 HFIuVHc5K+8qP5uH33XZcRpXhkgZ6FNPfS5wjfE0L5D1S9oLPQCH6rLLiedscVOTvyTd
 TpTzzzn2F87AkhUQ0XwLOae+laW6l+bRrvNFSRDeRVOaRQFi8ZHmdpjl2XBSHC3FagQf
 P3ABMkLF37QwnrsrrIb7fRBd7kHpMtiAj0cuxSdtP0TzvP9v1iHvjXj6RKfVbY7k36Ms
 rV7Kg9JF+6z/kf8dXUwdoNwrEt7E+fGjqwD12arf2BJHrbE28vrQhAr7BjRKteLB7Kcc
 pKJQ==
X-Gm-Message-State: AOJu0Yz67GK1EuSQMIegypjWIWXVkHx+Qd70RpswRpzvx0GJ+wmybFGW
 uT+eshq4r07SD+VPezugC9U28KmyqzBj1YO6TgoUDYzwrj4b2wJdHIhueed5rHs=
X-Gm-Gg: ASbGnctz+geQ5GPekkmNRbhz7SBEELxvUfVrRU00e9EA8qNtR9c8hcp9GqqCdrC45jb
 wIRTYM7ti7uKYl9WNCOjaAX3QZLlV5WtCX4+QAZs6YAwVpuW1EK1TvcFhf1iSfnFEz2cUhD4o5U
 /6P1FMDtMOz06Ij/+9Cq8p+RsSxyk9Ph9jLEeUXeNtyXCGfcHYBZuCVyxRam/f4V7/quSuCbb0+
 z2es2YfhcsjHu60WtMrYJkiUH/WXa0J7jzPGzEf+EsO5KhNQrX/tgO4eA==
X-Google-Smtp-Source: AGHT+IF/siAyyfmZYXu6jacj4iS6W36hdYvkb4HUWeDSpCJWt6VyC+5DVFYBTNFRTTI7oMC/SIaNfg==
X-Received: by 2002:a17:902:d4cb:b0:215:b8b6:d2e2 with SMTP id
 d9443c01a7336-21614da9da0mr58725785ad.40.1733505533093; 
 Fri, 06 Dec 2024 09:18:53 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8f263b9sm30970025ad.226.2024.12.06.09.18.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 09:18:52 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v2 1/2] efi_loader: Expose efi_reinstall_protocol_interface in
 efi_loader.h
Date: Fri,  6 Dec 2024 14:18:34 -0300
Message-ID: <20241206171835.2403418-2-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206171835.2403418-1-adriano.cordova@canonical.com>
References: <20241206171835.2403418-1-adriano.cordova@canonical.com>
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

This is done so that the device path protocol interface of the network
device can be changed internally by u-boot when a new bootfile gets
downloaded.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2: added commit message

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

