Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97480C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 21:43:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F595876A1;
	Tue,  7 Nov 2023 22:42:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dYYYfcrU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E80CB876A1; Tue,  7 Nov 2023 22:42:19 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF02D87655
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 22:42:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40853c639abso44874875e9.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 13:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1699393327; x=1699998127;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7MmvUmQV0CYJ5xeMBDgOVJIx7WYUEYy8T26nZgN7uRk=;
 b=dYYYfcrUig48fUUANi/Wp6zPsdnWSUuL14gEc0oMqLboAiEiMsSah7sL+dKsox0OEs
 h+Wa2N40wA3zmdJUbLkh1Zd87dvQO75Z6E7t8BQ7LW8u6tMBS4zJiCSc8ggtCyTuNEhp
 N/DV80yXcaJduS4CdV4WF+4AoPYnR3BHhx1Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699393327; x=1699998127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7MmvUmQV0CYJ5xeMBDgOVJIx7WYUEYy8T26nZgN7uRk=;
 b=SWpTghA3gXhTG2I6ImP8DVwVipEsfPc7fXE3kTeOQ+J9WdIw4ifGLFR/kZsd2u7lV+
 w12cAjmTAALdUiS/a5vE2FwAKaDeji5kYiEiXwPg74VQCLE4JJ+YBnqqtgBJmVrUG5g5
 C1+8Ab1dpIGJqlguz3YsAp/p1qGhjOGQrUJikIICUqXioeg/62EotkxFvhJl5oHHqYnK
 OPEkIq9sMwkZTzNM1ee3arEOVJ1T2XaJrNn3wRkejlyJH2ociHwGWdJGlf6eYgO6+mov
 CsucZ4vofpVf63Z+bJu7VPn10skP95HVs0/AZkRXNqh3me1o7PKlSXX1bsz6idGaLYkK
 ldZA==
X-Gm-Message-State: AOJu0YyFofRant7BFdGINuv50WnOkrmVq2m7h0v0MeuzfUJdGBWuYJ0L
 FPyajU+tnN46UikmWV/iDIKywsgPbqq2GtsviFg=
X-Google-Smtp-Source: AGHT+IG6Yg2kQhUetvlj6G+IrvFAwgSQ5181ZqxE6X3XLbX54jwNzz0b4nQbWcdrK3Rki5AtQnhu0A==
X-Received: by 2002:a05:600c:4e86:b0:401:b53e:6c3b with SMTP id
 f6-20020a05600c4e8600b00401b53e6c3bmr186711wmq.6.1699393327674; 
 Tue, 07 Nov 2023 13:42:07 -0800 (PST)
Received: from pwmachine.numericable.fr ([86.120.35.5])
 by smtp.gmail.com with ESMTPSA id
 u10-20020adff88a000000b0032f7f4089b7sm3306437wrp.43.2023.11.07.13.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 13:42:07 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hector Palacios <hector.palacios@digi.com>, Marek Vasut <marex@denx.de>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>, Stefan Roese <sr@denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Devarsh Thakkar <devarsht@ti.com>, Nikhil M Jain <n-jain1@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v11 10/24] global_data.h: add GD_FLG_HUSH_OLD_PARSER flag
Date: Tue,  7 Nov 2023 23:41:07 +0200
Message-Id: <20231107214121.132079-11-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107214121.132079-1-francis.laniel@amarulasolutions.com>
References: <20231107214121.132079-1-francis.laniel@amarulasolutions.com>
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

