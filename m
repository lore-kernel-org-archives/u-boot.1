Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE634C52D71
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 14:17:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2653E88C06;
	Wed,  7 Aug 2024 16:17:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WI7JOc1Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A52688CFB; Wed,  7 Aug 2024 16:17:31 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD1FC88CF0
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 16:17:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=max.oss.09@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5b9d48d1456so1116991a12.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 07:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723040248; x=1723645048; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t9NDOuDsJTL7wW9bIpQJG8cNlTDcg98IkTSnRTuSLnA=;
 b=WI7JOc1Y4CJg2RcjNveaWN0o39DphiS9FU4LUH8bMLw+ngyqiV5huf1tzkWYMK3XpW
 mjpjqUSnWm80oL0OTsR6Rfm7fDP6CXTz9PRvtXQ1GBd00eglCbpwvG/04O89wTPNFQgK
 WvcFxi/h/TB4zmJTiMjni7WnMv40ty+zA2VpcEMNl6qWV7j2Qo2CrEOUErO5fLCBhJ2R
 Miz2Piez/4FuXn5S9KtRZp8YdSZxnQR/frkDhmZfuNDY/Zsm/2wz14G7oVqix39Gs1+c
 0laVTe1YyZEcmrZgTSoIUjXqLlRmuSbzAA0i0xaCSbhfBOFHIqzCfV5NYuUy32ZdAjjV
 PLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723040248; x=1723645048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t9NDOuDsJTL7wW9bIpQJG8cNlTDcg98IkTSnRTuSLnA=;
 b=ox85XIOupw8cshWgQgOQqLDEqX25Jkxekjyfl6mD0sgv7HA5FHM5zDINAyOAw6sUWb
 jv+uUOAm/2mGB2KkmSQW5MBjtCN/ZzmROOlhlwCQ1UY4K6XpEIhwOeexTifVF01Xkzji
 ogruECNKCzr5XJrwHd9ZcgKD658kmrgZPJUZS2oBEspy2Nmxsj+LYlFPb5gJyxZo5+oJ
 AaiYHo9nCSj2VqwBCZKRBD9xqZRGQKwLdUH422xBC0KQEtPZr2Yr49/UDxWdlGuhWf6q
 osHUm7F1jB2aUJFHpW2/BrQnYnVR3tVmtsMrWuTOQ7zggznwDsloloj4qZ0fmn99pbbW
 WxrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkJBnPaAD/LbsR+aej4pvf6TpxS+LvIth7gGeaLZXBOfZePsjM1aAabYR5lLgqVywizcF61azJOou/OkX5zEjxjyh5oA==
X-Gm-Message-State: AOJu0YxsLm+9p9iGIsLhL20LHn+Y4twNdPptz8F7XMzaJOz0lN52q3C6
 ldTP2urB9tC9NiEgDzvYLQrFoIw12HWWMHW+BXJJbsmbOwQuKfVf6u294g==
X-Google-Smtp-Source: AGHT+IHBybp1AjSh6OFSohV9FVnAN6NRXnJPtpwI7E2koQneBvAa5jJy7Np4EjjsNSTR23pvRXAMtg==
X-Received: by 2002:a17:907:e90:b0:a7a:952b:95cf with SMTP id
 a640c23a62f3a-a80791c3a2emr214578566b.32.1723040247939; 
 Wed, 07 Aug 2024 07:17:27 -0700 (PDT)
Received: from toolbox.int.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9ec8dafsm644945766b.220.2024.08.07.07.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 07:17:27 -0700 (PDT)
From: max.oss.09@gmail.com
To: Max Krummenacher <max.krummenacher@toradex.com>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH v1 1/4] board: apalis-imx8: add reset code
Date: Wed,  7 Aug 2024 16:16:17 +0200
Message-ID: <20240807141655.4165667-2-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240807141655.4165667-1-max.oss.09@gmail.com>
References: <20240807141655.4165667-1-max.oss.09@gmail.com>
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

From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

With commit 922d4504bcab ("imx: scu_api: update to version 1.16 and
add more APIs") added the reboot API.

Add the board code to use that.

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 board/toradex/apalis-imx8/apalis-imx8.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/board/toradex/apalis-imx8/apalis-imx8.c b/board/toradex/apalis-imx8/apalis-imx8.c
index 72d67d90d418..570bf2a27d4b 100644
--- a/board/toradex/apalis-imx8/apalis-imx8.c
+++ b/board/toradex/apalis-imx8/apalis-imx8.c
@@ -290,6 +290,14 @@ int board_init(void)
 	return 0;
 }
 
+void reset_cpu(void)
+{
+	sc_pm_reboot(-1, SC_PM_RESET_TYPE_COLD);
+
+	do {
+	} while (1);
+}
+
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
-- 
2.42.0

