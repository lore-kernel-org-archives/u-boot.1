Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A87CF58DD
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:14:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECF4A8940F;
	Fri, 20 Sep 2024 10:13:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PAR44V5/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0776589452; Fri, 20 Sep 2024 10:13:38 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FFA7893FE
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:13:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c25f01879fso2148076a12.1
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726820011; x=1727424811; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tnVxSmVd39vZkuV8QBZP65OCoMo6U+JFZsETny2GllI=;
 b=PAR44V5/nlgANvWvqn6fAT8gt3/RvCebAKtwxgRl/lx4jOs5eEz8i5l5YAAqwYHW2m
 0VmoBR2AIlZjwB8896uSjVWL3G6cPqULSeKSYQgeRa4671+6tfGGusG9vTSoFu7xsmAf
 innAooG1q+ArdxfFxDzuujV6KfTvgA1a/XSts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726820011; x=1727424811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tnVxSmVd39vZkuV8QBZP65OCoMo6U+JFZsETny2GllI=;
 b=edG8oy77Dib2ulKTzypMifkw1YuVI4GqkkuQ1WemiBvC8wlrYv04v4+7mDHlciUsjq
 Eam+FuWzTlh8RL9Mgc759tQof6LsBTMcuw5BHi0W1pIVCJItkui8FHgi1XRjyrpqycLG
 l+ohkX8spVFV34bDoFNwBYeyAlqMcyH0JJ73k5S+Xx3QLyhSz2r/dlLUlSgDERCUQsJt
 BsttTPMvLuj4jBXAHODmtPoFYHhP+qtrmsytCqSzAq4+e+184LPVvDvqAJP6bNZNvxSM
 /E2cLsU5ngcJrSdKoW+CWImRC3Srh3py+KHrQBnHwpdVY4RjtDEEb3ubRQZk/UuKwWVc
 RZAw==
X-Gm-Message-State: AOJu0YxT9Y75HNvbjxwFI9JdZNI0DR9oQ/IgZso2CTjTZxExuvuatA7T
 cgX7Otodqy8Vsw6cBJCresaOMzsPndz+rwc6N+ZedTwcTTs4X/UJDAY60poIIC8Px+7uNTjUy5d
 QAzfS
X-Google-Smtp-Source: AGHT+IE739+SjSOWxlaT80zAhza3R0RW+EDNI7R9vw3/8zoPymDrfnAtHxZZPka2N21bPOBg53kHQw==
X-Received: by 2002:a05:6402:1ec1:b0:5c2:7727:6109 with SMTP id
 4fb4d7f45d1cf-5c464a7f49emr1118771a12.30.1726820010836; 
 Fri, 20 Sep 2024 01:13:30 -0700 (PDT)
Received: from chromium.org ([83.68.141.146]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bc88cf7sm6804447a12.90.2024.09.20.01.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:13:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Gary Bisson <bisson.gary@gmail.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 07/18] Support setting a maximum size for the VPL image
Date: Fri, 20 Sep 2024 10:12:46 +0200
Message-ID: <20240920081309.140426-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920081309.140426-1-sjg@chromium.org>
References: <20240920081309.140426-1-sjg@chromium.org>
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

Add a size limit for VPL, to match those for SPL and TPL

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/Kconfig.vpl | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/common/spl/Kconfig.vpl b/common/spl/Kconfig.vpl
index 3dc0e95e09f..eb57dfabea5 100644
--- a/common/spl/Kconfig.vpl
+++ b/common/spl/Kconfig.vpl
@@ -237,6 +237,14 @@ config VPL_TEXT_BASE
 	help
 	  The address in memory that VPL will be running from.
 
+config VPL_MAX_SIZE
+	hex "Maximum size (in bytes) for the VPL stage"
+	default 0x2e000 if ROCKCHIP_RK3399
+	default 0x0
+	help
+	  The maximum size (in bytes) of the TPL stage. This size is determined
+	  by the amount of internal SRAM memory.
+
 config VPL_BINMAN_SYMBOLS
 	bool "Declare binman symbols in VPL"
 	depends on VPL_FRAMEWORK && BINMAN
-- 
2.43.0

