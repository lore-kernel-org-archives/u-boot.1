Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B844DD4415C
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:21:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14E74895A1;
	Tue, 19 Nov 2024 14:19:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dQkwXV++";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDFB089592; Tue, 19 Nov 2024 14:19:35 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9987895A1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:19:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3a761e21ddeso10788885ab.3
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022371; x=1732627171; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ug/aMDAv5UKJvSIQ/woN8tbRHrK7zTAhQAazAfv+1S8=;
 b=dQkwXV++WS/iqByDcfR/yiZOJ0jQS+pgfE/1vFnQ/auI8yq2ELQLJtI4XsXyKVBKSt
 I0G5ljr7F+O6ga8BrAHdxYY1vTAg1ju+/kzWgWMl0TRBAkx8IK1X7KIbc5CNkLIs/UKu
 5fsbU1DRtPTbxarP9miDa2yRgz+mMe/yQ0N6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022371; x=1732627171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ug/aMDAv5UKJvSIQ/woN8tbRHrK7zTAhQAazAfv+1S8=;
 b=mxnFWNMXm4pcjAvKnUvGoc9C1ivzotKinXiO7Mk4ue18Y0uuRGkOQDoTQoXT9cOh6u
 xWTDs/xWVMGuo42T1jZp8hTbpPgcNRPJusZ4HpKbkHmgMHYcP56oGNECoKNJ7yckYrsN
 lWAoSkXCnYnjs3H2jMUgSqbRUlvp/0zM/IxISBhLPLAoMGcc1AA79NDfsV8wMZanxJaF
 wPsTeTeVu7fbMODTWEI+mNN7XLwOCfv7JLAkTaR8hks2HytYIWeILEybaAw5CgkEfUm1
 p5wmwM4YZ1oj2XA1s7Z5i0FgAxOUpQ8qwx89buBkmUVMzyGGnXFvjbwsbX1316aX2Chy
 6X1A==
X-Gm-Message-State: AOJu0YwlDYfU9XY0PwEPtBeoYNX068ORWZoSF/b425gGyspg5renUTSA
 a6tCzFtRIvVZLDVtYoAPO6w8CoRymK67hjeD+1p9yw8zWfBhziIJ3Jcx54aCpCTPvtiZyXEzXKM
 =
X-Google-Smtp-Source: AGHT+IGQWq8dI+n4GIrd2MS0JPL7wwF8NfWns3HqOCE+IZNEwVGUxFH6Yh0iQuNvaHeDyWTaTz8+xA==
X-Received: by 2002:a05:6e02:1a4b:b0:3a7:776e:93fb with SMTP id
 e9e14a558f8ab-3a7776e9634mr36619215ab.8.1732022370154; 
 Tue, 19 Nov 2024 05:19:30 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:19:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 15/39] net: Keep the bootstage functions together
Date: Tue, 19 Nov 2024 06:18:20 -0700
Message-Id: <20241119131844.4078144-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119131844.4078144-1-sjg@chromium.org>
References: <20241119131844.4078144-1-sjg@chromium.org>
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

Move the bootstage_mark() function just before net_loop(), so that the
IPv6 code is not in the way.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/net.c b/cmd/net.c
index c90578e1b9f..d3e566752d1 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -411,8 +411,6 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 		return CMD_RET_USAGE;
 	}
 
-	bootstage_mark(BOOTSTAGE_ID_NET_START);
-
 	if (IS_ENABLED(CONFIG_IPV6) && !use_ip6) {
 		char *s, *e;
 		size_t len;
@@ -426,6 +424,8 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 		}
 	}
 
+	bootstage_mark(BOOTSTAGE_ID_NET_START);
+
 	size = net_loop(proto);
 	if (size < 0) {
 		bootstage_error(BOOTSTAGE_ID_NET_NETLOOP_OK);
-- 
2.34.1

