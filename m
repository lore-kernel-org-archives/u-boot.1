Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECBEC3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 02:39:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 727EE87DCD;
	Mon, 18 Dec 2023 03:39:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wFAIZSjM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A253987DB2; Mon, 18 Dec 2023 03:39:14 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E21F87DB2
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 03:39:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d2eea4af93so6580295ad.1
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 18:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702867151; x=1703471951; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f1xnsDhYxoGq8Q7UUWBB8Cvz7zbisEXPmyyhu/S5S0E=;
 b=wFAIZSjMCOZ/dwX8o0+ioKX1Slx3gu2UYUMW4NO+syIDLBINFJJ8S+563pkLltdhaA
 dbQj/GdprEH6k/hX6XDDdBQ+ALogj7bWt6kAqKEsS1hEFToAHZcZ2gJrf8UOmxE0UFPL
 /oZVh0j/kdUBbnzAlKTpFwki4B6K7hZuY6Af1H42lNMpDVVbprXlhMbjgcAe9Rp3nB+G
 NuQpcFIaPaiN/97bCTjQKv30MspiAFYYEYcJLkbyJL2seFwLhcFVxSONJcRgBGmoT+9i
 9QugaRlIBGKKx3QZ+zmXEiiaAugPUAQ7WWvOr5Z5hNIZwy1AbahwxRuKC6vDOTIlqLVr
 u9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702867151; x=1703471951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f1xnsDhYxoGq8Q7UUWBB8Cvz7zbisEXPmyyhu/S5S0E=;
 b=bu2lKoSXNWl4N8SJFVlH0iFLN0ELsvfa/VnkQkUIKwGwfY5EgIuVCnhLpAMDSzVE7L
 YUpim/6aDCyIq+IlgHLjpBP2/k3jNiXgV/YLXgIlLRjTpno9IZwy4v7MpmS0TMRoWPsF
 WDCT/28Adhi3uoBmtMmyCgNNA4+9DqpcZngNvCB+GT1V8oAi/sdHvc+T4M4P3PbmKd9H
 0QweJSgLBS6FJDjZlQxJDFWfQ6SA4QBwSYN71LwNxFCxE0YwofYGeqUnWq7stWG1jH5s
 RwLdP6cK/xlCUm8h2x0JkMaXkLsXjBCn8AxJngTEjeVYaQJMAQB7VWeljc8TQJvCaGBj
 grRg==
X-Gm-Message-State: AOJu0YzrMb3LRSIRTNKry57Rm1Fb65jDbHRGTmecmNixaxaQqwgbMCvK
 nPHBr1tR5xsOv0N8/kWLYKJbYg==
X-Google-Smtp-Source: AGHT+IF0xkGspX6kSkSdAEUusNK0a/2fAjIGXHBgZjyAhBLdTclUYpoJF4wzGZD7XBX0gjNJ91J3Ig==
X-Received: by 2002:a17:902:b201:b0:1d3:6420:4361 with SMTP id
 t1-20020a170902b20100b001d364204361mr15032444plr.0.1702867150783; 
 Sun, 17 Dec 2023 18:39:10 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:a448:a260:721d:a9f0])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a1709029a9800b001d316770044sm13754305plp.56.2023.12.17.18.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 18:39:10 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: u-boot@lists.denx.de,
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v3 3/4] net: tftp: remove explicit efi configuration dependency
Date: Mon, 18 Dec 2023 11:38:41 +0900
Message-Id: <20231218023842.281336-4-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218023842.281336-1-takahiro.akashi@linaro.org>
References: <20231218023842.281336-1-takahiro.akashi@linaro.org>
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

Now it is clear that the feature actually depends on efi interfaces,
not "bootefi" command. efi_set_bootdev() will automatically be nullified
if necessary efi component is disabled.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 net/tftp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/tftp.c b/net/tftp.c
index 88e71e67de35..2e335413492b 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -302,12 +302,10 @@ static void tftp_complete(void)
 			time_start * 1000, "/s");
 	}
 	puts("\ndone\n");
-	if (IS_ENABLED(CONFIG_CMD_BOOTEFI)) {
-		if (!tftp_put_active)
-			efi_set_bootdev("Net", "", tftp_filename,
-					map_sysmem(tftp_load_addr, 0),
-					net_boot_file_size);
-	}
+	if (!tftp_put_active)
+		efi_set_bootdev("Net", "", tftp_filename,
+				map_sysmem(tftp_load_addr, 0),
+				net_boot_file_size);
 	net_set_state(NETLOOP_SUCCESS);
 }
 
-- 
2.34.1

