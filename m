Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077B0CD6E4A
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 13:49:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53C53844CF;
	Fri, 29 May 2026 15:49:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="l28f3NCD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7DC9846A3; Fri, 29 May 2026 15:49:18 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9465480087
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 15:49:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 407A13F1D1
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 13:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1780062556;
 bh=gIEm33B39eYY5xzM2TuiDLHpEAz9C3oPi/WSR81J71k=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=l28f3NCDYWAWPCsbj7gC2sdYRQ8xE78K3SiXRKaxFHHNCU0EWjwfxrMmTTy4a4OJp
 dL7V8XukIZ3qUotcVhQkpGU1wc4TFIfng5mCrShN1FtE4VLX+kwxzGCTfjnoB65X4n
 d9vhKT/PF4DuEQS5eUU7+zPgY7CDIj0HbmeQC3v40IV9xGessqB1ZJaeJKlfINo6U7
 GPo+kRsqY+VZRysbcUZ2cvfPmqRba9nanS+g7vrsp4tjLdqvM5V4wRaoodv1mCfx04
 H+B5U965R52JBITN76I6ZKCRYkHx5vb7Gyu83sb2f4wNghvgp/zB7hnWQqBXgxxCaE
 noYSnbbtpzvysOkPasd25Fj0qlIABEQSpCf3ATib41TsvX7U282HXwAMfwbB5GSvz0
 H/nYfPS2Q0Cf980bA3ASGv6G+pdntesBokKXQPX2BekxmxL8PsBcNMcRZ1HaQNcDz4
 dhNv4/MgH0WxmaN+AAO/60v8ZgKb/v+MG8zIBnfXRk1VbWYDsW6ba//Z8XXIDhij7R
 ixjJtV7b6tlyrdXbu6G50oPh2FmhG2++h57OuWoCv0zp7+HX2XlHq7PUpuWGoD5d7S
 QHItIeYA8/HVTskLFJzLJr3puEVqOIQw50Ghc/RURFSrO6ydEYJ8Nc4R7T9IE7eMke
 ZQy2tKGNG0B8YS7JFqlaQrDo=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490a060eb84so2823635e9.0
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 06:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780062556; x=1780667356;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gIEm33B39eYY5xzM2TuiDLHpEAz9C3oPi/WSR81J71k=;
 b=j5KyHlu3V51dVf/0HYm+1/byehkC0PLW7DDzusq6eshFvl7409bXuj8xn933wgwXXP
 ihSle4NQyoQ99PjJwrO9Qvbbw5onZxMLH/ks13v/NXQCa48W84EE67Nqet5TZfmQlxg3
 NmxgklUEShBAOvZwKgHanX4kpZrwPUPobByFEyjLl5NQ9Pp2QXn3lviHe/h+hLZtJyOe
 Q/44YmgyHwrrL+INIy0yYijpNApEZkorXxy/bTZLHpfWzucGfHvFbaGZi/Xezqb2foCj
 rtCjxycWgm297YwKZdPfkXD6r7cfENVPvebaMEp7nx5aA+oTaUQeQPPAJDqun5LPfHNN
 RMag==
X-Forwarded-Encrypted: i=1;
 AFNElJ+64KPyHkQvE9Ia+KHka6+lzQo0KTsqeOMOopHbjFLBaK7TmZxbmTT4JrK9QzjKE4zcZICy+tw=@lists.denx.de
X-Gm-Message-State: AOJu0YzZia4AJe6spy/WgKhSxtpLWKLFmjZNfrKWyCs/eZKJbNKbyfFh
 2zBi/7TKvz9ru45lCY6XLaF1XQSYNEqikNtRHZCWssnqEM1lOmowZ8Exo8cQGASOu10KfzHbfDZ
 9d+yjk+n8agzGDJOuw2KQz7NORfMwN6ARjspw6q0JO+GSI9nLQJ9UoL6JSOKNJ10slRWNqTk=
X-Gm-Gg: Acq92OEjVGDEpCuWE6GdzNNExeCMK9/hfirhTe9sRipxPEU8zul2lfE8K0h9ixuHhto
 nBe5TNULWTslEZz80WGkQi89yoa59doTZeaMZrwG4Bn7He3/PXGx5tmTBJmQr5yt/w3ttljd1/H
 Sf7qTO0vnyeFpUrC83PjJJ8eUSL2kwq2Nzw4OxZoohWNNSIgvnlbD46nSKFW/x8vkVDOJRb0Pn4
 Pf/Jq/LBmL0eEgB5HWKe+U1OBPy0fZBoD/FUBuHIHA4IXqfyz/BjevsdnQQ7xZbn70HKnzad8ED
 EEX+arYYGOFIIujJy4rcfGc2SaatOO4BR8RnOiNi04ZSRjckddHzx4b7K1AN/7YN9r5hOIFXw4D
 QKlhzuFgsq2AhX3IIBP28MSxQS1ZMbRGEVu1qhOVUibeV4RLw11GB2V6Fq9m6ADqxRzUri3A/cv
 9pb5I5taSzIWFLlmD0jOTA9R+Y0s8YZbzuN4JsadFeSB6+auxpvdoJCSF4IOuu
X-Received: by 2002:a05:600c:68c5:b0:490:5074:651e with SMTP id
 5b1f17b1804b1-4909c0c75d8mr40161335e9.25.1780062555897; 
 Fri, 29 May 2026 06:49:15 -0700 (PDT)
X-Received: by 2002:a05:600c:68c5:b0:490:5074:651e with SMTP id
 5b1f17b1804b1-4909c0c75d8mr40160975e9.25.1780062555468; 
 Fri, 29 May 2026 06:49:15 -0700 (PDT)
Received: from workstation5 (ip-176-199-115-125.um44.pools.vodafone-ip.de.
 [176.199.115.125]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c967c6csm49012615e9.2.2026.05.29.06.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 06:49:14 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut@mailbox.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] usb: fix typos in include/usbdescriptors.h
Date: Fri, 29 May 2026 15:49:09 +0200
Message-ID: <20260529134909.301076-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
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

The include for USB descriptors has some typos. Correct these:

%s/heirarchy/hierarchy/
%s/usb/USB/
%s/configuratin/configuration/

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	Add an introductory sentence to the commit message.
---
 include/usbdescriptors.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/usbdescriptors.h b/include/usbdescriptors.h
index db1d6ef791b..6ad831ffefd 100644
--- a/include/usbdescriptors.h
+++ b/include/usbdescriptors.h
@@ -18,8 +18,8 @@
 /* USB Descriptors - Create a complete description of all of the
  * function driver capabilities. These map directly to the USB descriptors.
  *
- * This heirarchy is created by the functions drivers and is passed to the
- * usb-device driver when the function driver is registered.
+ * This hierarchy is created by the functions drivers and is passed to the
+ * USB-device driver when the function driver is registered.
  *
  *  device
  *	configuration
@@ -45,13 +45,13 @@
  * made available to a USB HOST during the enumeration process.
  *
  * The USB HOST will select a configuration and optionally an interface with
- * the usb set configuration and set interface commands.
+ * the USB set configuration and set interface commands.
  *
  * The selected interface (or the default interface if not specifically
  * selected) will define the list of endpoints that will be used.
  *
  * The configuration and interfaces are stored in an array that is indexed
- * by the specified configuratin or interface number minus one.
+ * by the specified configuration or interface number minus one.
  *
  * A configuration number of zero is used to specify a return to the unconfigured
  * state.
-- 
2.53.0

