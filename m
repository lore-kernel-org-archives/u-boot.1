Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8907C282EC
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 01:29:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15DB8820E8;
	Sat, 15 Mar 2025 02:29:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gzfqPNPy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60BFA820B0; Sat, 15 Mar 2025 02:29:11 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 550138213D
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 02:29:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7c081915cf3so347553885a.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 18:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742002139; x=1742606939; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=LvFZqUbn7+5n6prAdEyZkFhN4y6mw+D75enNmIWijhA=;
 b=gzfqPNPyxBT1d2WM3EggSSKqll/lXRirA6oQ+35uiGlrjA/eVilav6oVfxp3UJ9N1T
 KQ7GftskwnYBvrFC12j6EkwAUhr1khPfSbcP9Az1K8yq9rVumjboC9eHF6SO+r4MBn8c
 LOn3qsTrNj80cShi6CGhYzxxyJM7CtaTGCsxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742002139; x=1742606939;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LvFZqUbn7+5n6prAdEyZkFhN4y6mw+D75enNmIWijhA=;
 b=Pg7dP8nvxjt0F2FZwPzwAlccLo3EuaYXlkqWZIIQA6cmyY5HyhfztisEcrcqxVWXrN
 Bl28+5ZqjLYs4iTwNo/zzmv6/M2C/aVqWOKTCIpCfI8EfKxUCsqdnwZy3tuPYPSFgDSe
 hHIDoh9Cj9Ye+yFd2TNCF6TLs3QnJUjoMV0cPqRQhcu7Fveyj4oFqz16x8Y9VLYk36ao
 j6z87iSdWBtkG41o0GI3T0ZBFCnSgl29oKGOtcHvtw3jMqn2e5n99UHlMD0Fns1NAAbM
 R9I/pmu6RMm38Ow3YNEVfap5O8xFUmimrs0ytmIfOUHM8xUQF+wkFa5eOnp3VjXApipP
 Kb0w==
X-Gm-Message-State: AOJu0YxjmoIM64TdI1R9XYi3/ARzE10oFFjWlAUrVUtxqrJ74gC2zm7f
 qGe8zgKBzc/AP0zhFxZUvauXRm47NmLmzmjsfrOxds2fyETThGNGHfHDBa51hTuutZWvJHbSGGQ
 F
X-Gm-Gg: ASbGnctnKDoMU6xuCSlCdw+/pKE96f+y7nkHNSypohOaOfu2TiHIupCCM6Z/BcXr44X
 3Blh3/sEsAJbOIAXUemPX89AFiG8T4zJYWWB2ouQYB5E18RJ6iGYCEcL0LgBpP150TFdrmLCHF1
 Wl9gd0cdX4ySQ6EGYXc8vqJpTVlcjs0GmIHkKfB3PKtlCLPIp96/MbbthfGXtkG1YLQMwIpW1NA
 fbCs65Vp6TGRyRZAwjdvlJBSh/3lruG4CuxY0lCBcGjgy4jkLj9CvHYAsEkF4da0qGGZsXW3boY
 EDdIFlzqGf/kXSj9dm759JetEefXwgM4DnB7ZLl6+xRYEP8x
X-Google-Smtp-Source: AGHT+IHGiBnDPw2dPqyvr1HTxO32cUYkiNEAujcbsoOml4qZa4hDYCCAJq5nE0XXCt3IEdR4lij9Lw==
X-Received: by 2002:a05:620a:2947:b0:7c5:5800:ddba with SMTP id
 af79cd13be357-7c57c7d46d6mr706867885a.22.1742002139244; 
 Fri, 14 Mar 2025 18:28:59 -0700 (PDT)
Received: from bill-the-cat.. ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573d89448sm321165885a.90.2025.03.14.18.28.57
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 18:28:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] cmd: Correct dependency for CMD_LINK_LOCAL
Date: Fri, 14 Mar 2025 19:28:56 -0600
Message-ID: <20250315012856.399360-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Given how LIB_RAND is handled now, we should be depending on one of the
implementations and not selecting one of them.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 cmd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index cd391d422ae2..aaebdfdd0c1c 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2062,7 +2062,7 @@ config CMD_SNTP
 
 config CMD_LINK_LOCAL
 	bool "linklocal"
-	select LIB_RAND
+	depends on (LIB_RAND || LIB_HW_RAND)
 	help
 	  Acquire a network IP address using the link-local protocol
 
-- 
2.43.0

