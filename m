Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCFBCDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:58:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A4A686501;
	Sun, 15 Oct 2023 09:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JwZq0DcX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0E3D8071F; Sun, 15 Oct 2023 09:58:34 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D30E8071F
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 09:58:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-77575233633so256220485a.0
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 00:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697356710; x=1697961510; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KwOXVTETS9AXgAZYe2CykrfJiB9rPPPB9f/a8PCWRbc=;
 b=JwZq0DcX8qTgh8jTTjolYGu6xtFtrQetgEE7HlqHUs+m9IYxWdOvzWAs0XeHd6FCVO
 X+WOR/OO450MbScFH48hEKMX22s8hJgKu4kcwf6w3V71rMpdkQ4IwrR5fhrb79PO9RP4
 /H9fDsPVzT3bgbggXWLvvvm5TKooMuZNKAfB47tfXwZ/qcYOZuq0MHESX8Snhe4RYM3z
 Lcb2c8a90BFxSa8Pg7Eue/EwPqEqdakUknLmhzL9PHk8G7NOBTN41t5Y/GDk343DJsJw
 la3YSOQEjVhfz6AyfYywOA10177PVEjRaSL0Bna3DFkR0LsTT5/4XdKwbndPkDNU1Hvg
 LZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697356710; x=1697961510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KwOXVTETS9AXgAZYe2CykrfJiB9rPPPB9f/a8PCWRbc=;
 b=rsx+C1a5UN9LDI1Oaj3WsXyOZsXlE/2b06GFXG1jApZjilFKeohwn0O+7V1GAI0Orj
 5GlUNR2x7yigO4O7UsATMgqQJgZcvI38s16aNVyfq4Z8J1Z/R8UQRktikBbyCz+FPBJ5
 h/atpM0ENEBGyR1RByDFBldxq2Oo3lYOsoWoFnCxwE/V9VYGr9co+RKl11jpbNTilVoY
 9n+/4cRMVHjj20qfGPOGHJUPesmC+AlyyXO0v58Lfk+qsnKFoYbjOhe/SSs+7F/3AVRh
 DKZ5MDFGM40SzFMlMjDL7r2xXvyIPRPYoBtXv1mlShNbwK0m48sO2TDoZMwDqxGWokI+
 YECQ==
X-Gm-Message-State: AOJu0YyZ4uAqrq7GaXFITGXPGcBxKUbcS3NZds1djnbpylDK3ZCBYJGk
 ieHc1jqg2vDPKHb8msqeRIMHCQT3CViOjg==
X-Google-Smtp-Source: AGHT+IGjNC+lEVdqRwhZWC1AzFhKIdzXKrQRnna/TBgJi53ldLLXmXTJl110JWpI/SVMXuIHAVrU8g==
X-Received: by 2002:a05:622a:42:b0:418:1071:7303 with SMTP id
 y2-20020a05622a004200b0041810717303mr37743783qtw.31.1697316510348; 
 Sat, 14 Oct 2023 13:48:30 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 z10-20020ac87caa000000b00419cce4a5ffsm1739101qtv.82.2023.10.14.13.48.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 13:48:30 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 20/29] sandbox: Support -T in spl
Date: Sat, 14 Oct 2023 16:47:56 -0400
Message-Id: <20231014204805.439009-21-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231014204805.439009-1-seanga2@gmail.com>
References: <20231014204805.439009-1-seanga2@gmail.com>
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

The test devicetree is only compiled for U-Boot proper. When accessing it in
SPL we need to go up one directory.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v2:
- Compare to PHASE_SPL in sandbox_cmdline_cb_test_fdt for clarity
- Split off from fs test

 arch/sandbox/cpu/start.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/sandbox/cpu/start.c b/arch/sandbox/cpu/start.c
index 2c8a72590b5..2589c2eba73 100644
--- a/arch/sandbox/cpu/start.c
+++ b/arch/sandbox/cpu/start.c
@@ -13,6 +13,7 @@
 #include <log.h>
 #include <os.h>
 #include <sort.h>
+#include <spl.h>
 #include <asm/getopt.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
@@ -202,10 +203,14 @@ static int sandbox_cmdline_cb_test_fdt(struct sandbox_state *state,
 {
 	char buf[256];
 	char *fname;
+	char *relname;
 	int len;
 
-	len = state_get_rel_filename("arch/sandbox/dts/test.dtb", buf,
-				     sizeof(buf));
+	if (spl_phase() <= PHASE_SPL)
+		relname = "../arch/sandbox/dts/test.dtb";
+	else
+		relname = "arch/sandbox/dts/test.dtb";
+	len = state_get_rel_filename(relname, buf, sizeof(buf));
 	if (len < 0)
 		return len;
 
-- 
2.37.1

