Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56544C3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 23:42:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA7EB82A59;
	Fri, 16 May 2025 01:42:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZMwn1DlH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 604B482A1C; Fri, 16 May 2025 01:42:05 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E5518277D
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:42:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-72b7a53ceb6so1099408a34.0
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747352522; x=1747957322; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e/K0R+VcFhcZmxNmYPD72Zf3CPYA/pQ5fjyxnPjIix4=;
 b=ZMwn1DlHssplUyPnUlmswN/O23+0/PUGRqUEQF1OReQZxY3nURfjNl3ePmVpiCeiyr
 L3ZEuaRl2aeI5kGruQtkLjb6umRwPfTEIEU2GUYfLcqpSkg3s+ZG7zjY0Q2oweE/dfib
 UkzXdit5PZOFF/12UloXjT/CE0Z7AgqSCyUpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747352522; x=1747957322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e/K0R+VcFhcZmxNmYPD72Zf3CPYA/pQ5fjyxnPjIix4=;
 b=M7TE6LOrZaK46XFY6QZZzhm6QC5Lal4rZ8bfvqTNn/qRVtb8XHz5nz8ENWdIWj5sl3
 pPb/9K9Xb2Y8t1XZA8hkKrIXjVpybXEysAu/fLFw5oslxIRHWC6gctXWAUJsdtzpBJwl
 VKoRUBT5ysuN+Dg+JIiervHEIIjYAcWaZv7pdS23UonxOHwnUZ2AJIEA5l58zwDzkJD+
 nRMiJXZPSzIZCwOgE9ZlWOO5XY62Ag/Kb7gacR89ALQu8jBcgdaenFyT8OF35OH1cR/O
 p1pSP7BrlVof7h+PQtk76xnsKYlGrjHCam/ZzaNJ7nC+cO4FWHnfdRnDK+ZI38VRVMXE
 wZSg==
X-Gm-Message-State: AOJu0Yw1VfeWdk1ZptYQPhNdb5Kjw7P2rqt/eALe2omBnuD6zQ4PaFn3
 sDzTTeGm3/+2930T6FBKk0xMOgq/QZQtkDvlUqwjYeMc7k5y2vzYLW45I6TxyoQaS3GTaNSzVDv
 xQ6rqnJc=
X-Gm-Gg: ASbGncs3anWfZqNITaUloeHj1DxXiAcm8YLT3++Z0sPgoVjCmi+4j8+7Zdvsa2LSqgo
 4yPWqMnK85Exn9uovW+RpvR3Zyc18TO4A74xDLjoSSqRragUj9u02Qbp80sglDzF8CANv32kaJM
 PilsZkA6bfrqNXootLuAuGvjurGZ18U5PcTXBt6T118JalV9y6MNw52pC2oCcbGEXZGfwB7DrIz
 KYt49NGyRlKnOK9/VA1q3jDzNMAMlVe+wLRHfy+1EAviPLw1IrfNXBYKAcnOTxjEaM89TxlM6//
 eRgDCN1TOeEiCvrbgBhMPZQNtuKua+AWOU+SRiLllu7t2j/DqoVDfkijTQAIsXbeTsYikQVvAfX
 CEU+gpbrGxwLV3IM=
X-Google-Smtp-Source: AGHT+IFs9lyH6jXUhHgPEkm4g+c5simn912invFHGlC8wB/cpyB3Xrl3Z2paQAoU9ScBCMHmtItFNg==
X-Received: by 2002:a05:6830:631c:b0:727:2731:d5e5 with SMTP id
 46e09a7af769-734ec7bff52mr3593844a34.12.1747352522078; 
 Thu, 15 May 2025 16:42:02 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b3a9b3sm147559a34.52.2025.05.15.16.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 16:42:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 03/22] dhelectronics: Include env.h to permit reading the
 environment
Date: Thu, 15 May 2025 17:31:32 -0600
Message-ID: <20250515234154.1859366-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515234154.1859366-1-trini@konsulko.com>
References: <20250514225002.15361-1-trini@konsulko.com>
 <20250515234154.1859366-1-trini@konsulko.com>
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

From: Simon Glass <sjg@chromium.org>

This file reads from the environment but does not include the correct
header. Update it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---
Changes in v3:
- None
---
 board/dhelectronics/common/dh_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/dhelectronics/common/dh_common.c b/board/dhelectronics/common/dh_common.c
index 71010803f555..8c052c45007a 100644
--- a/board/dhelectronics/common/dh_common.c
+++ b/board/dhelectronics/common/dh_common.c
@@ -5,6 +5,7 @@
  */
 
 #include <dm.h>
+#include <env.h>
 #include <i2c_eeprom.h>
 #include <net.h>
 #include <u-boot/crc.h>
-- 
2.43.0

