Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B2BD5C0F4
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 15:58:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5EE889300;
	Fri,  8 Nov 2024 16:56:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VxyoyozB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0567788D47; Fri,  8 Nov 2024 14:40:23 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8BF588ECB
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 14:40:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7240d93fffdso1314209b3a.2
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 05:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731073219; x=1731678019; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6q445Jqdj7B+VwHf7FrK/rfBNO7yL6hfJvO3kSZ7kkE=;
 b=VxyoyozBenwB755TBwr6VvN0Fl3oB556sxed1j60X6Xwz3NTKJptKw7q0l4EqFbkdy
 EEeKs0eJOB68fnQ8X8vVO13xdrbtfpc8K+MBMvfVk5mlrSYyx4uCl+WPf/C9Lx44XJ3X
 +7cpla24kdeuvg0sDFHHrm3sSe3hlIoAtzzH7ObPSvN3/MHRgRTxXiDCeJjs5Fnd/hEJ
 I/BZ03Qq6L+kmoYhETJB7aSSRMtNDVY8bhO9HChSwLrBojQZokECjWmHXFDMUujcPXYT
 9MYhr3M7SNbBWPtElsb3p8xKoMSgqZM9VsME96aG8M3Yw+54+Jt122YGKHH6WXo66DAe
 sWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731073219; x=1731678019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6q445Jqdj7B+VwHf7FrK/rfBNO7yL6hfJvO3kSZ7kkE=;
 b=A79l+d3xzGtaAY8rYfUoiGqe5PVYDDqBSXWZa1WshmkK4AZ0G+feIhmkpZaSWCYF0d
 2gaeiHKBSDTIHj2W1saDzMJPdOwv2RJXj/SPj7cGp6cWIpV6M3d0txdK9yWGkQ9nIsjo
 bdHt/xwVYJjed+N2FyGm9Q56HnoAREG9bc0FNB+lY0pimN2XJiGmG32XIMU1Iqj8u0qh
 uziVrzZaN12BVuqCM7S8OTu+tnoxr5ek6EWRDMvGxAAqv1GB8ygF6wC39ijvvm2XZUoe
 aVzIBjhQMtXE+vUkRdTrm7vJYraiRiNrjJD5Y+ef9I/+Gy/RA/JnRuFXQWSkIbn9X6Fk
 HdEw==
X-Gm-Message-State: AOJu0YxZeWg6ti74fDarEukoB+wTGy3fBPoVdGWEDHG16kj5zDGG8/vb
 eyfEyUL9MHUeZJEqCfv8rckGCJqICL6UFAryR/8sonkf+Mrqa1nwSMiEpG7Lnwc=
X-Google-Smtp-Source: AGHT+IHxDqOMHN99LP8lcFLHU0yYUAdwJiOWW575PYPzItf75LzsP38576irg3A920AZxLpUJQnpKA==
X-Received: by 2002:a05:6a20:8402:b0:1db:ff76:99d7 with SMTP id
 adf61e73a8af0-1dc22b5c4f6mr3851974637.35.1731073219321; 
 Fri, 08 Nov 2024 05:40:19 -0800 (PST)
Received: from adriano.. ([190.215.83.227]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc8376sm30296295ad.44.2024.11.08.05.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 05:40:19 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v2 13/15] lib: uuid: display HTTP and IPV4 Config II protocols
Date: Fri,  8 Nov 2024 10:38:48 -0300
Message-ID: <20241108133850.431075-14-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108133850.431075-1-adrianox@gmail.com>
References: <20241108133850.431075-1-adrianox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 08 Nov 2024 16:56:12 +0100
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Add long texts for

* EFI HTTP Protocol
* EFI HTTP Service Binding Protocol
* EFI IPv4 Configuration II Protocol

to the uuid library.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 lib/uuid.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/uuid.c b/lib/uuid.c
index c6a27b7d04..dfc8218fb5 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -174,6 +174,20 @@ static const struct {
 		"Firmware Management",
 		EFI_FIRMWARE_MANAGEMENT_PROTOCOL_GUID
 	},
+#ifdef CONFIG_EFI_HTTP_PROTOCOL
+	{
+		"HTTP",
+		EFI_HTTP_PROTOCOL_GUID,
+	},
+	{
+		"HTTP Service Binding",
+		EFI_HTTP_SERVICE_BINDING_PROTOCOL_GUID,
+	},
+	{
+		"IPv4 Config2",
+		EFI_IP4_CONFIG2_PROTOCOL_GUID,
+	},
+#endif
 	/* Configuration table GUIDs */
 	{
 		"ACPI table",
-- 
2.43.0

