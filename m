Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6635C4706F
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 21:04:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3082787887;
	Fri, 22 Dec 2023 22:03:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qpxMkNLY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB92787872; Fri, 22 Dec 2023 22:03:33 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3270877DC
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 22:03:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40d3c4bfe45so22420685e9.1
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1703279001; x=1703883801;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7MmvUmQV0CYJ5xeMBDgOVJIx7WYUEYy8T26nZgN7uRk=;
 b=qpxMkNLYT5IIFNVya3ooAP+ui2E213yblsehOAWuwbr+V5gJBwa7fmVRFsOCMb9Kq0
 U0MVRT4MbDNIVpbm9Gh6+d9StRXfX+XCw/RUufFnryhnVBhdmjZ02hblv0QuFwEH7nkY
 /4iNKUiBBaEAHVCnTi/6idhEoIg3fRbSpaUAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703279001; x=1703883801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7MmvUmQV0CYJ5xeMBDgOVJIx7WYUEYy8T26nZgN7uRk=;
 b=kJvv8TrImuETWdpRAzZC5HbKrxve0kltuXUMfyUWFfTJxlZ6P7P4o/+SQVeJZ2t5gW
 qbEhbMlS9XJDH1TKGekKTdNuM+YwcJ4V/+Fc7J4/Br52fSaPhR2+V2PjgqLyqNFt/I1+
 ovCAipWIRw5ofX9wcQYE1pQdNpBGIhLx3qStbIXV4Pc6nztUH0wVQLeHQJb3oHS3sfcr
 pGiJZ8NjSuxylTPXtAzPKKYs8yl8lRu7HeL4mYOpWtX5NfeR0ERmuDQoJnE1eAOZBvRV
 h7pOf2U3coIojPh0UdwsDno0jDy3aYeK9BHZklMqQVSo1tJaOXCJSo1wrXHKj2jQSk7C
 1FkQ==
X-Gm-Message-State: AOJu0YyBwCaCodej9CDH/JNF/qJjC3DuFocQqQT0GJUpB/jyxD3q0YkJ
 NHUcIXwkz7wvrwP/DCZ36VR+W+zt2C2rpHDsC/g1ZJA2wn4=
X-Google-Smtp-Source: AGHT+IH2kehYJNiKoUnYl3ieAljQWM43Whiz71n+HbMac2oh+71VJGwEiQiQLBFzp7LaDC3se6yoPg==
X-Received: by 2002:a05:600c:3847:b0:40c:251a:1017 with SMTP id
 s7-20020a05600c384700b0040c251a1017mr596244wmr.321.1703279001190; 
 Fri, 22 Dec 2023 13:03:21 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 j20-20020a05600c191400b0040b349c91acsm348294wmq.16.2023.12.22.13.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 13:03:20 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>, Marek Vasut <marex@denx.de>,
 Hector Palacios <hector.palacios@digi.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Troy Kisky <troykiskyboundary@gmail.com>
Subject: [PATCH v13 10/24] global_data.h: add GD_FLG_HUSH_OLD_PARSER flag
Date: Fri, 22 Dec 2023 22:02:30 +0100
Message-Id: <20231222210244.91830-11-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
References: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
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

This flag is used to indicate we are using the hush parser.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
---
 common/cli.c                      | 2 ++
 include/asm-generic/global_data.h | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/common/cli.c b/common/cli.c
index 3916a7b10a..e5fe1060d0 100644
--- a/common/cli.c
+++ b/common/cli.c
@@ -268,6 +268,8 @@ void cli_loop(void)
 void cli_init(void)
 {
 #ifdef CONFIG_HUSH_PARSER
+	if (!(gd->flags & GD_FLG_HUSH_OLD_PARSER))
+		gd->flags |= GD_FLG_HUSH_OLD_PARSER;
 	u_boot_hush_start();
 #endif
 
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index e8c6412e3f..0a9b6bd92a 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -697,6 +697,10 @@ enum gd_flags {
 	 * @GD_FLG_BLOBLIST_READY: bloblist is ready for use
 	 */
 	GD_FLG_BLOBLIST_READY = 0x800000,
+	/**
+	 * @GD_FLG_HUSH_OLD_PARSER: Use hush old parser.
+	 */
+	GD_FLG_HUSH_OLD_PARSER = 0x1000000,
 };
 
 #endif /* __ASSEMBLY__ */
-- 
2.34.1

