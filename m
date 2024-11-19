Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0536D44157
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:19:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73077895A5;
	Tue, 19 Nov 2024 14:19:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eaJUHN1d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81C4989598; Tue, 19 Nov 2024 14:18:58 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E41489596
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:18:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3a777fd574bso3716845ab.1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022334; x=1732627134; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3fcvVvjucfVfd1LnMesT562KY9CrGzv7nigfCTSnEss=;
 b=eaJUHN1dC1oiEcteHR51quXIqHbZzeq/ydZNU1XGlU+V/V7zlJC9h7cmqq0v/d95fK
 mtacd94lzZqiQ/BUa3M8c3E2orw4k1Uf9/36XvF4RVkCT+iYNM3wLykivr6rzgrlNOVC
 o3xWT+5Pw5Pqlbni526VYMZs3dDXIZMNmRjzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022334; x=1732627134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3fcvVvjucfVfd1LnMesT562KY9CrGzv7nigfCTSnEss=;
 b=MBDtL3sHsEbP6wp+OfQ/jwwWzSBWVsgnA1Pk+lpZxxVDt4py7mxni6mz06GZ4uxKpc
 DsfgQbKXovS/BgOvyLssJW1Uiu2vV8eX/tDwSxoKzlv3Mhr5TWOFnjElh9KKMVVR5yon
 ZJ2YC+YycxpwzpjijbleukJuvmSLns0snumFGyFu3tL7GUj4tELjmDBYP6eWGd2PcM3o
 e6bUD1J7MDeaOZuzkeEgM9zExuQdrHUkfEougnZuMBs4HEjDelsRK3p0A9T+ETZO3BCA
 qmyFdwqNbd85SWQp3Ag45SxPvVbW0uFQyRotc1iSK4rymFXmbnynkBFWCYmvNeAkpvbl
 7MEw==
X-Gm-Message-State: AOJu0YwQAdYGW3XC3ePJ9Z/MgqInrDNvJLRJI0V7nNuaEmx0xi8C0BKH
 fb7S54PNRUoExIcQ28xcF1xia/akckjq0HXm2s/ABm2d+pPqIp96sL6rNhqscZPEmy8z6vjeXS0
 =
X-Google-Smtp-Source: AGHT+IEeaODGOQujDY0GWZZzAuXw8LdMIpFk7WPDaaJznOwn/lrXIY2hihgHTJMMRXcNiG9580bo7Q==
X-Received: by 2002:a05:6e02:1b06:b0:3a0:9c99:32d6 with SMTP id
 e9e14a558f8ab-3a7480d5e95mr175495285ab.24.1732022334665; 
 Tue, 19 Nov 2024 05:18:54 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:18:53 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 01/39] x86: Make do_zboot_states() static
Date: Tue, 19 Nov 2024 06:18:06 -0700
Message-Id: <20241119131844.4078144-2-sjg@chromium.org>
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

This function is only called within zboot.c so make the function
private.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/x86/zboot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/x86/zboot.c b/cmd/x86/zboot.c
index 94e602b8a5b..3035172352a 100644
--- a/cmd/x86/zboot.c
+++ b/cmd/x86/zboot.c
@@ -119,8 +119,8 @@ U_BOOT_SUBCMDS(zboot,
 	U_BOOT_CMD_MKENT(dump, 2, 1, do_zboot_dump, "", ""),
 )
 
-int do_zboot_states(struct cmd_tbl *cmdtp, int flag, int argc,
-		    char *const argv[], int state_mask)
+static int do_zboot_states(struct cmd_tbl *cmdtp, int flag, int argc,
+			   char *const argv[], int state_mask)
 {
 	int ret = 0;
 
-- 
2.34.1

