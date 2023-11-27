Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C17DC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:03:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DA86875BF;
	Mon, 27 Nov 2023 14:00:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vI0rpld+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85C36875BA; Mon, 27 Nov 2023 14:00:39 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4444D875A0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:00:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50ba73196b1so3110570e87.0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090034; x=1701694834; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EDvrCmEs4AowbUl/thMcgKJCloHgFxRz4FWB3a/1gSQ=;
 b=vI0rpld+MQjXUnnRC9os9hScsWTB56MK6GmsbfgTJ/trabyaXBk2xuOUCAZXaR78Ye
 zS3A600Zg4297Mq3wX/P04gYM0Mf/zwDkqZN+9Csj3rRf/bFLjFJmx3GhTuls5YGGUNY
 KGO/sV1m+HYWynIKivLgvDCsJypyMgB4KK2lYjXADCAF2lRneDPtP1fvKxYkg8Y9/yPI
 M/HC2NmjNbUI3cuoGEvHQqoaCzWY7eVZvt0ytaiaqlDhIwHY1i5o40pOqPClYPDCnc0i
 JH5Lsvix37PiN12jtgWWribpQwmCeonS9NbvbZKXrZuyMQDnjlHPgpf5I1tJAS+s9xFY
 4lxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090034; x=1701694834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EDvrCmEs4AowbUl/thMcgKJCloHgFxRz4FWB3a/1gSQ=;
 b=UlJHtUtM7eFB8wVWdrZ8qoi7yQpztpgI62pyZ1VDgn89nGAuH+xeD2b7/f5gzKoX8V
 K+7lAHDvXE7EJP8DdV6FbVLscfhH4u4n4T9gxfBFtgs3UyFRF+Dv7qpI565sa7tpuYaB
 1C0IJfW0HngjNtqWUeicpNUDJsMjLjjUF5jpCThPB8MQ6FkJregNXRL99pm7wmxwJe3l
 SsNk50ULwzJ9ub8tEF6x0rubXsL5jwAArkZmZt79wSLybpXnQQdU4GGwWcVxZ+CeN4n9
 DykcHSVUcCg3DGwr7z0FoKv8toL5xWZAj08LpknEvwxpURTxAW0uwnwIs0DWP+IdADLk
 z5ew==
X-Gm-Message-State: AOJu0YwF3v7JVjxazP/k75FBGkUTVmKvJ77s9eWPqY8zeEDd+jqh9KEI
 BBfGKP8Mm9bL9frsHfm1MN1tXwGhp8lXHJfJuiZzRA==
X-Google-Smtp-Source: AGHT+IEGJA3VcoBB+Q7t6Y9yrMaQSzq40v/NeneMVj9X3EEcGCtmAONEC9tbDv7z9wtnfAjcKD9KOQ==
X-Received: by 2002:a05:6512:3044:b0:509:49fc:c261 with SMTP id
 b4-20020a056512304400b0050949fcc261mr9310940lfb.51.1701090034034; 
 Mon, 27 Nov 2023 05:00:34 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:00:33 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 11/43] net/lwip: update .gitignore with lwIP
Date: Mon, 27 Nov 2023 18:56:54 +0600
Message-Id: <20231127125726.3735-12-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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

ignore lwIP library code and reused files from the lwIP.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 net/lwip/.gitignore | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 net/lwip/.gitignore

diff --git a/net/lwip/.gitignore b/net/lwip/.gitignore
new file mode 100644
index 0000000000..7b5dacce90
--- /dev/null
+++ b/net/lwip/.gitignore
@@ -0,0 +1,8 @@
+lwip-external
+apps/ping/ping.c
+apps/http/http_client.c
+apps/http/http_client.h
+apps/tftp/tftp.c
+apps/tftp/tftp_client.h
+apps/tftp/tftp_common.h
+apps/tftp/tftp_example.h
-- 
2.30.2

