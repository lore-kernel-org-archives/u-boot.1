Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E42BD591B7
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 21:11:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39E89894F2;
	Mon, 18 Nov 2024 22:09:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jm/dvdpa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4D1F894FB; Mon, 18 Nov 2024 22:09:52 +0100 (CET)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77968894D4
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 22:09:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-295cee3a962so201124fac.3
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 13:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731964189; x=1732568989; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I6J/jJ9dvn6c9mH/15PaKZG+bebrVlbZiJfjD4dggNY=;
 b=jm/dvdpaEnTYus790bferifMnrFY7YvQOMTkZ8UDbAQVep+1DbGsJadtP/KZ/7MvxL
 IQ1txHDai4TjuFSzeuHgEbZ2YIxP0uKqvhzO42zUkPj8SumeYzauolpQplxFs87L/B+K
 RuU581422DEyVNkI/x4kMXXGLq5sr57UijIUgROSgVI+KumNWmqhcvWq3xRlQSA5xfS2
 EBd8gXXEQIJIGpfDabNOxlfEm7a1F5JylQdnf/niKEbqjLBrWoN9icHtJcYLupCMyRks
 G2PK4ZCUMqit5Odbx+DwcawfsvtU29QdqwwrgQO3+lAei8wu8viNq8RqSshp9ICWyZoO
 sCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731964189; x=1732568989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I6J/jJ9dvn6c9mH/15PaKZG+bebrVlbZiJfjD4dggNY=;
 b=kCSLUhkdj+bA4QrXrOHyCzvm1MyIAzYWgkB3QTXmXA7ZZP2eHrE4D+DX/rifyvsUlk
 5AZE27HVq0d60XowGF1dEZsWVEiS/d4QjyzMreuVm4nt6//NQOch2F501ig5n9SgrS7g
 Ir+I75xaA8EytT0h+aPpjEcjPyA+kDDUBPeMlayssRC+XNfPUe3wJlrUzNGOjVHkDJow
 F+CxMHnQjkTVmpzf0MQRPgZTsZdWxdGUSQSUlcEalWhi4m1omuy+5cg6dsyVmJjIg7av
 9BHX0119WMp16neLcSbiK1pioxOMD056c0TlDZRZ4UXs8tpiDJCX6KEtoeHvvo/1LEzi
 Q+KQ==
X-Gm-Message-State: AOJu0YykonnnsuUpRRO20XjgK6TVXDNOY4JR1v7nfEDNhSFs1ZWZgmh7
 TsONjN3s8bCxLTof6+ABhz4FgvGvdpxM75NBVzSwrsHoPoN/bq1cM5QfzVip
X-Google-Smtp-Source: AGHT+IF82eFN0XlnEbTby6oXAdahxcqTM5VFttZ+tOH0wNM+N9bhJqYF652UZlyE+nu2dW2qcm7msA==
X-Received: by 2002:a05:6870:478f:b0:288:2fb6:a385 with SMTP id
 586e51a60fabf-2962dddc686mr12195712fac.20.1731964189298; 
 Mon, 18 Nov 2024 13:09:49 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29651852a7asm2994621fac.3.2024.11.18.13.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 13:09:49 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v4 12/14] lib: uuid: display HTTP and IPV4 Config II protocols
Date: Mon, 18 Nov 2024 18:09:06 -0300
Message-ID: <20241118210908.51196-13-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241118210908.51196-1-adrianox@gmail.com>
References: <20241118210908.51196-1-adrianox@gmail.com>
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

