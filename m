Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB19EE7716B
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 03:07:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C805C89671;
	Wed,  4 Dec 2024 04:06:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b9+9YCdK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C758E896B1; Wed,  4 Dec 2024 04:06:08 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 915C189251
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 04:06:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21561af95c3so31738735ad.3
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 19:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733281565; x=1733886365; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DnHbHGlJWUiYgezLBM2Aq4CWOJkpg/UKZAcbPihDpGk=;
 b=b9+9YCdKixbfFsW8pZsDftutH1QEc5x7nAwRXCpHlgt1uBB7fMjNLqy+bAbOySIgEz
 QC4oz9FlpbQrs7Xo3X3pppoojDtD2yrMWqOxYWbJp8CnDaVou+vLTfZDQxs7QTitJAA0
 X2cA9jx4uJIvVcituoRfsLeP72YCZZS2yzxV80BhKLe+c1aIXyo93gWwgRUBtTMSELx/
 hHwIwWMkunBZlrkcXxHBtDyaScveIzSZXDFgtg9OHd9rGcfJiqwt5fWppinwakjetLPx
 nkgkuSQcPMMxodiMiC6abC2wGg3Oal+ymLfo1eo6uEG+O2kvG2eBDIJAnpF1olLTq6hd
 5Oqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733281565; x=1733886365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DnHbHGlJWUiYgezLBM2Aq4CWOJkpg/UKZAcbPihDpGk=;
 b=A+i8aV676JeDPou43KdyGDIGrUfVZ1EsBEG4ROuyuBfTF+mZPZv9fVN43WAfbXR0UA
 mISXTlCVJD/op01f5XUmetnquuZ27SWME3K78GpKAbd3no0f5QNzD9B+OncEFWm6fxKO
 yLOB4iw+PWyDkKAdu3KNRTiC0/Is6V70ZqsUE3HNAfsiks0QXRQmt0Uf22PAhtAfP9nU
 ASaovC1Y051vvpdGVrdaEXs2cNbkDve9W6/Rz+KOBrMSQgxEQRC/TIWz0kYLacyEmBK8
 I/1wq/+2A7TEyRtQtC6pWNgostKGO8V6i6dMRJGorEAjzF8ASQMlCuD64Z312LvRZMu7
 3oqA==
X-Gm-Message-State: AOJu0YwCwYc1W3ozPvU8Sy0hb5TuXZ4zkcq9L06snAZDLEaCKIv7MWPK
 lGrrXn8KHoqJ+tn66jym15lD8BUYih2fntR4XjV1FSrogJwK1DoY2fJB6N8KIYg=
X-Gm-Gg: ASbGncuvZ1jpcdL5i9vgg5il15ve00M9D8mDc4QXuhRN0eHOn24ckVlIeK4R0WrTJ9v
 H34yu3FljQIUBm3yRsp0xJ/ZvbyAg86bkJ/Dv6IFi+7UXmUdu66hyijc90Mi/XoZcaIKHqYZPpC
 OQ+knGDJentgFct/O2qxR2K0Q0+mfVMbXe2QucfrP2UjTJSq9rpsmR7nOSU0zMpbqiQwDRa1coI
 r0zqZJvgWA+aONWjL9Ktr/VaWUYeZ+CqBhiM62JiTo=
X-Google-Smtp-Source: AGHT+IHO/Vkua5H6vv1xoSSO2ACyaSyd4xNvM7iBPxYovMdqAEM26VpiFlkP7/tEXgSMGqlTai7r4w==
X-Received: by 2002:a17:903:2342:b0:211:7156:4283 with SMTP id
 d9443c01a7336-215bd11c441mr71515805ad.43.1733281565083; 
 Tue, 03 Dec 2024 19:06:05 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215714b4f77sm56196335ad.202.2024.12.03.19.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 19:06:04 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v7 12/14] lib: uuid: display HTTP and IPV4 Config II protocols
Date: Wed,  4 Dec 2024 00:05:27 -0300
Message-ID: <20241204030530.2099776-12-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204030530.2099776-1-adrianox@gmail.com>
References: <20241204030530.2099776-1-adrianox@gmail.com>
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Add long texts for

* EFI HTTP Protocol
* EFI HTTP Service Binding Protocol
* EFI IPv4 Configuration II Protocol

to the uuid library.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v2)
 lib/uuid.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/uuid.c b/lib/uuid.c
index 538a1ba6aa..97388f597a 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -175,6 +175,20 @@ static const struct {
 		"Firmware Management",
 		EFI_FIRMWARE_MANAGEMENT_PROTOCOL_GUID
 	},
+#if IS_ENABLED(CONFIG_EFI_HTTP_PROTOCOL)
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

