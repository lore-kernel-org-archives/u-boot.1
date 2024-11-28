Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477F3D69113
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 14:46:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69E9E89D3A;
	Thu, 28 Nov 2024 15:44:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eDKwDeY9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BA2C893D5; Thu, 28 Nov 2024 15:44:52 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22C5889CE7
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 15:44:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2e9ff7a778cso1518743a91.1
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 06:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732805088; x=1733409888; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DnHbHGlJWUiYgezLBM2Aq4CWOJkpg/UKZAcbPihDpGk=;
 b=eDKwDeY9trpTA9ghplfTg8X+6qpMqlj+Ul0toJHRLjDAKYCsTrLV11BNgYHoPoxfx2
 cgOpa1obSedhdTsYGgTL3hKnJJclGOxZjPIWmTMPeJJNdv7bM9fZwHMWYCUmKNB8ASUn
 BKQaSvo/Cj/TkNcmycRJLzUfrdznbHWkZXrmShgL/frPLcfv/kiimg3+tbhu+5l+fIin
 Ja/HF72ZOQea4P26m2pQ9BGeb6wkunPGrylYRGSemapy45BucY4ffRJlLtmOLFqhmWu/
 eAi6HV1C5ZdeWRy0z8QE77xrSqnVFDydeXJvEYFEstQo36KJzCx83UljyrYh1lPvOujb
 pqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732805088; x=1733409888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DnHbHGlJWUiYgezLBM2Aq4CWOJkpg/UKZAcbPihDpGk=;
 b=ekXscdxryeliQd9BhYzPPugTydtrSo1aPdDgS5fA8i8mdUUItkOFi54wKjKMB9YKm2
 a2nCm2XP+Y1SA4fIxYRXF8Wy3CesIgOSRW78lAuWGXQdbJZIXuEmNkMWJGhmZJa6unD3
 AvGf9l4KMlO3WGv65fGL1R/zMLM72GZ2oSnE3cEgzs4EHayIon12VLpWsql0JmXBQSfH
 xaFqYg4tnxNQGx+Q0aH2jagzvph8aeFkUUkuk3TfiY5e3L4/tfRsBEEJ2qjFsCqQ3IVl
 k/ngZUJ7sJFhmgMV8fMAFrHN7pHDBwXlY3294oYS0A4SH7Hv5gLaH4UNkP0PTsP7Zx+5
 ZWNQ==
X-Gm-Message-State: AOJu0YzYhx2IyfiNQICfoD5/R19WibIbY8INDexi7MR7KI8kyTkU0WZ8
 v9NfXIKobvDk3Acm/6tcA+jOAcPol/SL8gLdGqlyCzweE7e7bKK7kQT8DlYsnZ4=
X-Gm-Gg: ASbGncuPSbH4qrxJLF3i2ddUq6p+WQM6SpW1qQczs8tA5ovZiNi3EfKQyf40OLLIsM/
 G+Ai0cjA82bZKNwmOldP5clPo6/Pr98fHxWNzHdkIXCm7DSVTvbYJrkOlbsGLjPROAjkGBOJ0uL
 ETwVgIYYvn5GePcHTGYTSZ/LumxPL4yDDqbJ7+xT1/RjaS+UJXRcaCbAMlIu15Wu5ioF0vPds4C
 +oqF3AfPp6p3VNZpLIeaJXsr2z754reywYeExMFgJg=
X-Google-Smtp-Source: AGHT+IF9p6DL40b6Kedb/ZcVaLQ+/8TIeQeQGPk5OJG+Xt3OAteo7jNWqJvJWG3wwIUSWHkmzyUU3A==
X-Received: by 2002:a17:90b:3b45:b0:2ea:8197:fa92 with SMTP id
 98e67ed59e1d1-2ee259da8f6mr5646957a91.0.1732805088602; 
 Thu, 28 Nov 2024 06:44:48 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ee2aff1b77sm1532202a91.11.2024.11.28.06.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 06:44:48 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v6 12/14] lib: uuid: display HTTP and IPV4 Config II protocols
Date: Thu, 28 Nov 2024 11:44:14 -0300
Message-ID: <20241128144416.604126-13-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128144416.604126-1-adrianox@gmail.com>
References: <20241128144416.604126-1-adrianox@gmail.com>
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

