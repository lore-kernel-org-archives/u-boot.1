Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51CCC61D92
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 01:34:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4281875D6;
	Tue, 21 Nov 2023 02:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oNAkHz+V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52379875A4; Tue, 21 Nov 2023 02:31:39 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ECDC87596
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 02:31:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-28399608b7aso837568a91.0
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 17:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700530255; x=1701135055; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f1xnsDhYxoGq8Q7UUWBB8Cvz7zbisEXPmyyhu/S5S0E=;
 b=oNAkHz+VXft4CccPHHhAlmOkmi5SXPPg5tL+CekyRQEiV7QvAp85UQjUdMzDKSyb2B
 aqwB/eh70FLgQtbMA/kdlcJFyBuGlqqImHyagU7ANw8YmBESLZh8qtW9MjwVOcqlLV4z
 woK2IAlBpxVGt/npWlbgQmygKYiQVmbcYczE9ayFl+qgPUDz+z3knxHFQSW6h5ODe3+9
 Q6Ou8DefuAloGkFbzoxep9P7AYo6Cx7BCtEEaaoZnRBs01d+dR4kPoL6g2r3SKLuJnHh
 0ibnN/N9A3EKQOUIHugcwj3UAj9+LX8kUH2rcmOmsTKTjV2PlN9LjFcfS0ahSL/XomRa
 uGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700530255; x=1701135055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f1xnsDhYxoGq8Q7UUWBB8Cvz7zbisEXPmyyhu/S5S0E=;
 b=truX3/WEcgsqYz/03LuLUpdi68LYmRwz7jEER46ssQoG0JX03ras5dLsdJXsj7tLtX
 97kumDH3iQw0JBqbQepSv3GDhDDg31xYLvbqtcLk8elgwbqUX5990lfp2IJ3HNbPfJmG
 vCNAt512Io0cMVpi7wIZEkQsIm16q5i9MM+nT+l2i1arhl/q/tiNxAk9g0PzY1CAwcZE
 xgtdHe26rYM8b/5izGlOsbbO3z1UKoRBzbGIKMsKM3EuiJH3pyAJ5mQEZXA6Oc1YE3xJ
 y0+MYmmbcKT3YGCHf9ZfIUw26TgtxNkMEOVDQ+64QbIbZe/zhoBmo9V8OYy/+VzAqvSP
 hQZg==
X-Gm-Message-State: AOJu0YyMzf822tkDoN60uMFkIqwt4NV79CUTuO9O8JcIpTG5Sp/EkyFL
 q7CcCMwbdGybQBErlxu8tXHnKw==
X-Google-Smtp-Source: AGHT+IHSTc/J3TPxQb0O0c2r9zagjXA5+FbfJ34I5aoMDXbgF/JxEL84VmTsC9mHSDo+IASmH/K85A==
X-Received: by 2002:a17:90b:370b:b0:283:27b6:f33f with SMTP id
 mg11-20020a17090b370b00b0028327b6f33fmr9339851pjb.4.1700530255623; 
 Mon, 20 Nov 2023 17:30:55 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:f6af:a59c:7ca:897f])
 by smtp.gmail.com with ESMTPSA id
 e9-20020a170902d38900b001c8a0879805sm3612508pld.206.2023.11.20.17.30.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 17:30:55 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: u-boot@lists.denx.de,
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 11/12] net: tftp: remove explicit efi configuration
 dependency
Date: Tue, 21 Nov 2023 10:29:49 +0900
Message-Id: <20231121012950.156539-12-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121012950.156539-1-takahiro.akashi@linaro.org>
References: <20231121012950.156539-1-takahiro.akashi@linaro.org>
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

