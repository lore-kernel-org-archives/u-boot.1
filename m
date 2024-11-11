Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD71AD41D44
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 02:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7398893CF;
	Tue, 12 Nov 2024 03:47:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EoJHAgkw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FADC89395; Mon, 11 Nov 2024 22:10:36 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFFE689393
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 22:10:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20ca388d242so50045415ad.2
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 13:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731359432; x=1731964232; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mw2ippmZW0vYgqiVj/sFq1p1Ot4Z1dBJg2mzOJvBl3U=;
 b=EoJHAgkwvQAOQM9wpAtQaGFMCBCKPk77/6iBFQeru6FGNFeB96nnXtaRjtSH3g7lY7
 noJ1NHeUccBNsjvWIoUwClkxGcYM1Yeol/BxrfpKldL6IBT6V6x/RUO1qklJhEI0vkiK
 RrBcwR7pq3W3lLVB/dnbelW+QBtB7iOAdfNToo6xbqwD+K6l5epbGuTQ6Oar7qUAxVrv
 vvp4EpsX9xHCv8MiElh8kxGrAxJ2QRDP0nkj7GEVjm8KMmLIVRCDVB/qSaHPAiWPrAib
 blCNpcZm/7soeCgpY3OgV94HzqMY8R4SBj3BM991HKBXdAHC2zXh3tagx7chzg0S+nJG
 s74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731359432; x=1731964232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mw2ippmZW0vYgqiVj/sFq1p1Ot4Z1dBJg2mzOJvBl3U=;
 b=qzIG+xfG93H+GH3+akb6OiMHb6hFJHZJcErw0IymPee3DEdNG6F+OokTwg0kwlqis2
 x0XwwmFkohZ8S3CXBfCfAKZqeBmfMyh420hcaqScz7760QIfw7sm4fn0y5xHkN8/Pc6O
 NpkfcXo867i4EkMaliJorAir7HmxGUyoZ8EL89wRr+wxgUrrRoRdwrLQd6fuwzMLhGtp
 ilOuzXfm0O1T8fr+W9gasRIVwdGjeXmOFrQzYXDQ7I9XFc8em7o8tFiuVe7eAtq5Kp2N
 fHsE0Tw+9MKcXyooLLUayPh7B9DDeLlC0t9q3QLvcXYn0t7DRm7UfcBT+UN0Ia5ICC6k
 kGDw==
X-Gm-Message-State: AOJu0Yz1DWKFOPaIZtQ2db/6jlE4NdBUgoAgu9UxlVp7pvBTCwJbVQC6
 IlhvW1Q+PWv/FlwauZ3REO9tlhzAYywnJCXO5pPmW/cHVSdtpFO23mKdwOYf
X-Google-Smtp-Source: AGHT+IG4qtsj5o7K6opUuCtTJxptXX8h40V+ksDJ3keHLKx62dV3nvgH290UPsAbvRWUh76M1m7ixQ==
X-Received: by 2002:a17:902:d2cf:b0:20c:af5d:2ed8 with SMTP id
 d9443c01a7336-21183e12195mr201827945ad.36.1731359432148; 
 Mon, 11 Nov 2024 13:10:32 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc9e25sm80031165ad.27.2024.11.11.13.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 13:10:31 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v3 13/15] lib: uuid: display HTTP and IPV4 Config II protocols
Date: Mon, 11 Nov 2024 18:09:57 -0300
Message-ID: <20241111210959.560738-14-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241111210959.560738-1-adrianox@gmail.com>
References: <20241111210959.560738-1-adrianox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 12 Nov 2024 03:47:02 +0100
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

(no changes since v2)

 lib/uuid.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/uuid.c b/lib/uuid.c
index c6a27b7d04..3b2cf60fe1 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -174,6 +174,20 @@ static const struct {
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

