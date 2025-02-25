Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F562C021B8
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 20:07:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 217ED80FD8;
	Tue, 25 Feb 2025 21:07:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dHxojTYt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C45E80F96; Tue, 25 Feb 2025 21:06:57 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6360580805
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 21:06:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3d03d2bd7d2so57420685ab.0
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 12:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740514013; x=1741118813; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=73txyHh/s4L/6nrqFOA1XpaznEy3rAL0lpPOq5B7fIU=;
 b=dHxojTYt/UpJfP1OnYT87oL1VOfEPT4M0qCzRaL1yhJcB2JJ9kkgJHdJhW+jEnYCdh
 2cWc/TKl1DqWSTMZzjxApdbj47KeUESbmYioa3bzp/E1IVta/WtfwtHeprfoPefNYEEQ
 yIFtkWHgAsVOk2DgXTXUWB1vSF2HqtwsRT2N0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740514013; x=1741118813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=73txyHh/s4L/6nrqFOA1XpaznEy3rAL0lpPOq5B7fIU=;
 b=wlSdu7XgT61ZARFMkJTqWSvh9+QrXo37AtmD6bmOcE/LtZ8QZA+j51aDA9SbBPdUxV
 AhYxFQx7btw2DTEiUpDqcW30hflZTU36cRyrgGnkE5GBC6esCGg5+VEVmWNqVTNm+VdY
 WRSX75gQUZjrQ55oRLdeD6vjNQ9odOlO5jR0rPjVFR3pOjZQQ9Tq9HA++D1gZI0SUynS
 5/RkDBHSM7sqIV31IoSn9zMVjjbCJ3AD5stn7KsHeY8W49AR2+6qZTmpRQmx+HdzTlgE
 uO1VE0O3omhwIflJzaTI+4wlp/gx+pij8uUedka56/sxwGi+JOiXp/9j8oN490Qt3ojK
 lOCQ==
X-Gm-Message-State: AOJu0Ywuf7+92ngKrcCN20AgrCnSj26Hvp4vcqZ2agsV8AwETAhHHcDJ
 AhRCvmyl4yuhvU6tJLVCoGNpWpGibknmOCn9qTE5BkpVdQDFY2S3Cv4H5brZMD8hjuWosCqrdaI
 =
X-Gm-Gg: ASbGnctUOmnoxjwKqsc7zJupXyWyOP0gh41dD/9ch73uvWciINvjFhy+N8mNcwgqOVe
 BhYcAch77uAlpum3VZbBgt/3enaQXpDyqV3bgKJv7TfXQqPsIQcFLwlA9CVeD7FEJhHcu8G9Jht
 lysIZovK01miRbkZVGAS362y6KW/w2YG1oLv/fk8Ajn8UN1rmx8ZFmnehAufK5RuvUAmTgKozXj
 7HwPYt5tSHTRlcATKnMSaYwdZpJJhoBod5rnhwXqmSg2SoArPwjXUA7Dmr6oKRMla1PteOxnJS7
 PZ0RR6Oj+X2L4cTMcgETzOlrterbeWpkOztT1LDpgsIzTdMVoFYUmDXarOa3K5w=
X-Google-Smtp-Source: AGHT+IGvstjo84R6t20WUhzxMRAyUOiSw3nyaSmX5+PdhrZplbSTLP/us/wv5lHy7ZDwuJ335ZyvNw==
X-Received: by 2002:a92:ca0f:0:b0:3d0:1fc4:edf0 with SMTP id
 e9e14a558f8ab-3d3048802e7mr45751895ab.15.1740514013617; 
 Tue, 25 Feb 2025 12:06:53 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d361ca210bsm4653305ab.55.2025.02.25.12.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 12:06:52 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/7] binman: fit: Drop unused code
Date: Tue, 25 Feb 2025 13:06:28 -0700
Message-ID: <20250225200635.3781149-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225200635.3781149-1-sjg@chromium.org>
References: <20250225200635.3781149-1-sjg@chromium.org>
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

The key-name-hint case is not tested so is presumably not used. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/etype/fit.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index b5afbda41b5..4c8ffa9a52e 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -534,8 +534,6 @@ class Entry_fit(Entry_section):
         def _find_keys_dir(node):
             for subnode in node.subnodes:
                 if subnode.name.startswith('signature'):
-                    if subnode.props.get('key-name-hint') is None:
-                        continue
                     hint = subnode.props['key-name-hint'].value
                     name = tools.get_input_filename(f"{hint}.key")
                     path = os.path.dirname(name)
-- 
2.43.0

