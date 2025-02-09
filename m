Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DBFC0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:15:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F21780AE1;
	Sun,  9 Feb 2025 22:15:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FUEy1MyF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB07280A0A; Sun,  9 Feb 2025 22:15:31 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87C4980836
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:15:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3ce87d31480so12363785ab.2
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135727; x=1739740527; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i4Wm0QpKZi6GrGA9+Tg2b5GfK+s3SVTAgyDY5yDezs0=;
 b=FUEy1MyF34Yz/fnMX5qgv5iA6BAFtMsYSji0jx69Dcc1b251jPZ6ytwvIxtgyUcXIs
 J4k4qo1l3EiyCYt0VvGrtI0p/PMIRavTt/Sn8LR/6dfBp1HoEmrRH2Dv7YasWQCnpj3g
 kZ8lHPCIzOsZeXpRYt9YGxpP/VmgkER2r5+Cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135727; x=1739740527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i4Wm0QpKZi6GrGA9+Tg2b5GfK+s3SVTAgyDY5yDezs0=;
 b=wXs2HWfYzQ5+CHi26jWTW33CpLIyIJGbnLnEay7Yxn4KJ4T82a4LyCwrmZvDCAK8SL
 8lGLNb/xgTFq/VMjnm2JXzgzZnwQQFVobaRR3DvCFQbSQgFhWQtDzmTZiAFE6EQzU9dZ
 RTusQtTOH0LoQXt8IhyM35NCMOj8IWUv6FG8KWAVdxqQkkuVyiHOxyv1Eky5am+xEQao
 bA+2OfUwEJ0pN2LL55kBo1oOsMQbtbrDawvx6HM/JwX4S2e7jdTJ7WNmHMXU0AO/PCcQ
 3hDAoSxJvxxxTW/311edxP2AR7tee+AMqA5a1C7zEhYau24VpDoQ9p6GvrINdf++5sz2
 lUYA==
X-Gm-Message-State: AOJu0YxAusVLOSXj8zlPy4kE0KOsLwt8vYCNUeKEtjSOg+7t1TM1t4dF
 tzznvDDrM3YMbVDI/HkQuUOHN1467Ns0jgUkgn5HkiNPYdHBb2Hu35GVgK5xlqpaH881MAI7qUI
 =
X-Gm-Gg: ASbGncuz2Mm6wD+mxXM+71xC8A363ktZpqskLc/Z0QvGmvZoaM2lJ4yg2csfvS7IQFe
 srwiUm7k1hwTtGzLhY04NSq1AUJMVm3jxj7h7CRmM4cP4mo+GMG9edWEYIBEsQU4USE5ZPgRVz+
 5rjvvd/EtBjx08RL+57nKD1zgByyodfc5wy4QbY5z6D4Qx0Q3ADuyQ4bysFexjip5SQOo+pNXoA
 WPi+4pnNvGAmIYcIdFP/cnD6lVqrWHdDxDw4o9cQtuFA/TSKp3zgrKUCwy8Rglio8LQdm6M7jc+
 BNeZ/bHhyTXPWKtL6JpSkA+tDgQW0V1tC64Syu5qC4YtTubF0VXb
X-Google-Smtp-Source: AGHT+IHwnWK5oU1URaL0eHXb3zUMaGGQypm5KfPv0vSLkiRB/QRU6Ic3cC3Nlfkpkl+Lzgoms0m/Vw==
X-Received: by 2002:a05:6e02:3421:b0:3d0:4d38:4e5b with SMTP id
 e9e14a558f8ab-3d13df3d6d7mr104173585ab.22.1739135727037; 
 Sun, 09 Feb 2025 13:15:27 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e96f245sm18978655ab.51.2025.02.09.13.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:15:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Gary Bisson <bisson.gary@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 04/35] arm: Support a separate stack for VPL
Date: Sun,  9 Feb 2025 14:14:25 -0700
Message-ID: <20250209211502.2299245-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209211502.2299245-1-sjg@chromium.org>
References: <20250209211502.2299245-1-sjg@chromium.org>
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

VPL has the same needs as TPL in situations where the stack is at the
top of SRAM. Add an option for this and implement it for arm

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Reply on existing CONFIG_VAL() to select the VPL stack
- Correct reference to TPL when VPL was intended

 common/spl/Kconfig.vpl | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/common/spl/Kconfig.vpl b/common/spl/Kconfig.vpl
index cf6b36c8e38..4abb96221bb 100644
--- a/common/spl/Kconfig.vpl
+++ b/common/spl/Kconfig.vpl
@@ -266,6 +266,20 @@ config VPL_MAX_SIZE
 	  The maximum size (in bytes) of the TPL stage. This size is determined
 	  by the amount of internal SRAM memory.
 
+config VPL_HAVE_INIT_STACK
+	bool "VPL requires a initial, fixed, stack-pointer location"
+	help
+	  Enable if the VPL phase should not use inherit its initial
+	  stack-pointer from the settings for U-Boot proper, but should set
+	  its own value.
+
+config VPL_STACK
+	hex "Address of the initial stack-pointer for the VPL stage"
+	depends on VPL_HAVE_INIT_STACK
+	help
+	  The address of the initial stack-pointer for the VPL stage.
+	  Usually this will be the (aligned) top-of-stack.
+
 config VPL_BINMAN_SYMBOLS
 	bool "Declare binman symbols in VPL"
 	depends on VPL_FRAMEWORK && BINMAN
-- 
2.43.0

