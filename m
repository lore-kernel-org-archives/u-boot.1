Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21661E7717D
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 00:21:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAD3089486;
	Sun,  8 Dec 2024 01:21:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oafd8Xnt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75A84893D4; Sun,  8 Dec 2024 01:21:30 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45D55893D2
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 01:21:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3ea32c929a3so1003188b6e.1
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 16:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733617287; x=1734222087; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YIqLi+LU0gMp1928vzjIFNBq6//rtBT59aOVqHfPg8M=;
 b=oafd8XntKIi6xkL7dJBB43DFyQBlbOn5mR7V+2WrLM1v7swT0mWwmQ0vzsBgJzdHBR
 3yQJdgU5uat6TmeKtCEchVrhRcNMORemlLSBpesO4WVfZagW/VtKpmNsZRY2+W4sCsc7
 xYcR08YZMw0CoTaObwA4DUwvM0Gd6F/aSxWzjR5ROh6Bu4pXPjQk44izgYH93rvElpeQ
 a/A4DLAIpCE1cA2Zrv4cctMQu0kcuUuJCl07ZjjMJXo2UmfQLMn8+3MlSCkNPWnQ7KP7
 Id8d87SuwrTpeYMDHiiH/1wJt4UufgOwxKROqWuG+Scz6KREIsqE6aqJfAirXp1n4v11
 BkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733617287; x=1734222087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YIqLi+LU0gMp1928vzjIFNBq6//rtBT59aOVqHfPg8M=;
 b=NBOg2qYVPbtiTLg45+rqt0dignexnt7zZb43nT3xRZSue9S3OrTM5mZ3knWN2EhYYs
 CX5NS658jrp3hRcUOLotosAV2BvWz2muE5ulo/B27ufomxLHaIoDlLj05OutVobXfqEj
 tCdnXQShE3GctKeniYbbEU8DMgL06WkYZXySdDDxdvleTu6hJjIGf5KH8lVVFqP57FcL
 Pq+rX8/JZ0PYdkp//0xbpv9++thn7D74/pRNgNRrYELaHpmPdHVKM9SmpowleN8hVugo
 zxVJ29UgduvtfKbNST50U3Jd7DdzEKdo4WL7J3ZF5m7Miwu9wt9wzh19c83NpldiAzW0
 oa5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFrmbXKX0f5glsFuvHlDShdOF6XPuJ/Jd1QhecOOiPd19BH17C+h/F52K1DlpR5U0rYEbC0nE=@lists.denx.de
X-Gm-Message-State: AOJu0YxZWJJuprYT2IDDlCIcY7y+0j9UQaziRzGg9KHzILp/tgKNY+Cv
 Z7jpGAFsK31r66oI9UMl0PDeLrvbXQNeEzBzbVkzPbCFbbnPg2OP3jW7VksP/LA=
X-Gm-Gg: ASbGncvrnkzYpcj5+7Uwh/nAKBBV6tVOGirHJJrfDfhiAvw0OuHGH7qyvf9z8jAAMfS
 TjcXSX+IrCGQJp86dcenfAN95NbVhHym6Z7irHMitYMIp1YQsWp2P0uMGUkNqc++akhaQruPyz0
 u3PeRj5urrpPPgnn75isfnYIURsfan5YTUnbRBueHLD/4rE+/ro6x84pPhHAfrOkGseVYtZNNao
 3xRBbofzOzBm5PvCv/ZvVjxBcDdw/E02y9yq/ZV3gKxsdB5j3x4BiM=
X-Google-Smtp-Source: AGHT+IHY4bu2JMJecjphggw1DozS1wRcLGipB+nst2PzovZJ7NSAv+TYmGWXbE0dD9pyp4qi245+cA==
X-Received: by 2002:a05:6808:1688:b0:3e7:61f6:811a with SMTP id
 5614622812f47-3eb19ed2188mr5187222b6e.35.1733617287017; 
 Sat, 07 Dec 2024 16:21:27 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb40c6009esm300705b6e.28.2024.12.07.16.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 16:21:26 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Subject: [PATCH 3/6] lmb: Make const flag_str[] in lmb_print_region_flags()
 more const
Date: Sat,  7 Dec 2024 18:21:18 -0600
Message-Id: <20241208002121.31887-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241208002121.31887-1-semen.protsenko@linaro.org>
References: <20241208002121.31887-1-semen.protsenko@linaro.org>
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

flag_str[] is a pointer to const. Make it also a const pointer. Improve
a style a bit while a it, to make this line fit 80 characters limit.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 lib/lmb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index ce0dc49345fb..1642ce48bbbd 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -482,7 +482,8 @@ static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 op,
 
 static void lmb_print_region_flags(enum lmb_flags flags)
 {
-	const char *flag_str[] = { "none", "no-map", "no-overwrite", "no-notify" };
+	const char * const flag_str[] = { "none", "no-map", "no-overwrite",
+					  "no-notify" };
 	unsigned int pflags = flags &
 			      (LMB_NOMAP | LMB_NOOVERWRITE | LMB_NONOTIFY);
 
-- 
2.39.5

