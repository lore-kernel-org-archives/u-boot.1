Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E723C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 12:34:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 854398118B;
	Mon, 27 Jan 2025 13:34:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bA0cIZJd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52B448076E; Mon, 27 Jan 2025 13:34:54 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A497805DA
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 13:34:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-216634dd574so50352595ad.2
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 04:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737981290; x=1738586090; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zc8DgEJuDC/yC4YB89uKtyJgwBeJWTjFNJz/Nhq9CTI=;
 b=bA0cIZJdbjlw75AkQp5TDolfNTQnLRN9u5nUNhXRW9Pi20wnPdp6j9hiI7VkDh2swB
 5ZGwzv8zbo78uG13s3nC09+S1jEqc8CnZb4yKRhdiCn/qI+9gfDYjw/I6/A6Ktevmd6h
 TVbQ/KRLL2/fc7NZJTZfF8874+iOGT0VkedjhGBC20ZlZTbgVx+t3OnZ4Wu0nyWWaza8
 RXjerY108PAF3hSPMLTp+5meLdfB1dy2hWsnPi81xKLIDbPOzYBH8voq1//ZcY+43PPX
 oY35d5sukBRY8sCCzqWRtrKi0bJTWZLVoEfpXvIlj/Aytq3hIirN5JVykgMPqPyUeCL8
 FNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737981290; x=1738586090;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zc8DgEJuDC/yC4YB89uKtyJgwBeJWTjFNJz/Nhq9CTI=;
 b=k4OOfi3KrcymC+u8JOZesi5FtLSL8acMsfBIT4Kl1S1fcl3Yge3ZMB7M6sunOe/U54
 FjZq4Ms3MD386wQevdi3Co9xF+s+6EacFYl8XnBvVMJq3r8sd9ihTPmV+KpQedHXQt5H
 dOD5nokuLxxr3yf/he3skcu6nEMIYF5PleYHSKYKy29NjFhWy8p3crBu8c4S14KYrQ67
 4XzaRJmfPjFngzXTvuha8yj6Sb+i0r6TJCFn4bzIEwcoTcIhg2VlWzYtNSE5RrSQ/6Xe
 PxLur6fd8yU8i8X3/Plyko66DUrG6/YrzX/6//YJ6xWC6zyjrDqJM0r9+1RRDTenhcSB
 kq0Q==
X-Gm-Message-State: AOJu0Yx24jE85l/ALb7aX1qWqHwAbe68kkmZegSfJbUHe+/0bpqZ6dVp
 8ex3WjOeO73Ibe+En1zF03LN+b5aTC2ylqMrzpRYR/JExitHoRgqs0rNfCKq
X-Gm-Gg: ASbGncsrZAvxHtf3rrRaGOk3gkajiA/Hza2A3N8SPQ2IaHoccZeJZJD/kddSiiG3Co7
 wanKxlFO+zoyGc1c7tQk+Xvc1P0j3u9zjkPeEdeya7NRwFAgS1UCPAK7ttklFfJUQlsrYVUnk1j
 KFv5HybqCdkrR4Trw/SJFxcNsXfRyX4dfjLhusW05HDYuVY5WQA1RygnMYU8Q3cc/ccvPD1TC4a
 rPrBzZHbggGHtnHdANF0rEiAaTJ9ItZltVeXJjZppcAtwwcvAXPxkttBQndqSWslz47wyVCAj+E
 Gv90KYAeBaxP
X-Google-Smtp-Source: AGHT+IE8nbwab6kzEg5xvTTyqs5lZ2JSHwc6upnFhsWudB2YdafF95ATPXXLzwxzhD6ZYn/jvKhSng==
X-Received: by 2002:a05:6a00:c92:b0:725:e499:5b8a with SMTP id
 d2e1a72fcca58-72dafa9ac70mr51643057b3a.15.1737981290365; 
 Mon, 27 Jan 2025 04:34:50 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a6b51e7sm7222630b3a.69.2025.01.27.04.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 04:34:50 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v3 1/2] efi_loader: Expose efi_reinstall_protocol_interface in
 efi_loader.h
Date: Mon, 27 Jan 2025 09:34:44 -0300
Message-ID: <20250127123445.1040480-1-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.43.0
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
---
(no changes since v2)

Changes in v2: added commit message

 include/efi_loader.h          | 5 +++++
 lib/efi_loader/efi_boottime.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 9afbec35ebf..0d858c1e12e 100644
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
index 080e7f78ae3..58716fa7953 100644
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

