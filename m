Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C0FC02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 14:13:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E01F807D9;
	Fri, 17 Jan 2025 15:11:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZlmfwW/i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5490180737; Fri, 17 Jan 2025 11:46:02 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EECBE806D8
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 11:45:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhang971090220@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21619108a6bso32169715ad.3
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 02:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737110758; x=1737715558; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=otWAEIpGBrK8yuULADl597iMnXT7134R2g5KBzNd/Zc=;
 b=ZlmfwW/if69giofJvouEVrkhIoNQvy06cAcPl6aPbYGZiJt9e2bhKP2qlYyiJHTLJr
 DuCBtpJ9GRzvC/8J7hrVJWYouJOo2Owzx2LDYFFiOMoGQsQSQ3oVEsWMPGoLX7oQ+4g4
 YcZIMXmwGaVDuP5873P4oLHmewtArHGZL3fZQQlVnx+xBXIj8v+/ORLQ03H3VDbhH8uZ
 z++WAIlrt/jdweO5CHGozCsYjuDwwgUCwnuPigYMpvboRnXelXsWbA5UJkYuso0JqtRp
 lVjNwdLGAnwBY5LFAA7HJubvRl5319r6/OMfMH7KEdGlEitzckAPFYTtptQEqtgkzTeA
 naGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737110758; x=1737715558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=otWAEIpGBrK8yuULADl597iMnXT7134R2g5KBzNd/Zc=;
 b=BZ3cT+UbtrpFV+BdvtTnm3YotkUqPFWW0Ctx2vsI5oVtJN4Kc4VlQUyFSOpHmIZ/nh
 HStlD2oBgiPmm0rH3NzD6vEh6jhXpZsQE+PsDC9mwLpc+eb2Yge8qOJC7mjo3FnhYf8n
 SNqID3v3RaOhbt4MzMZQter5Vjm/6B9S7bsGi0ryd4Ikvdlw1Wsv+6cXWKWSQ0Qj6IaI
 Z22VZMtGijC1b/v49PyPxGY1/k8d461WieES68WDCuESQWRbXFbZqOBXfe8bLnhH+usc
 XFXQjQUIaygG0SbW7HtcFNeaHu5O+PBY/Zm+WliZBLWYTjUkb/qPsLW7V/UZaf9mkcA7
 8Zcw==
X-Gm-Message-State: AOJu0YyyBUoozd6L02jGwlUH15pT3tsU+CJLX7iviXwsfcpXofyb9eGE
 L5UV04SYv51ZCGIUdA8VpPlzEc+Rr7TkDTfVw6WifOiuDM0fBvZt
X-Gm-Gg: ASbGnctUDinNe+qaXej94pgB8838XtIc036VSVKTVZdY2KZdZtDyTLQiQGE+4giKE1f
 kHdpBwKgXEBpCf+UP0XI8wQ2JcF2ao1lI0ee4VQhcHgpLmKXrY0xPbJzxmtrAnhoDuJbCdV241A
 MoZwHLVfUX58rCDBEc/5jx+ACyjpgYXnstMbcQA3+aV0zjkohqaFMevPgvG1l/WCSYmEyYthSxv
 TjgT1wp1XrVwQBp7W36CBt8vRZZjEjv9ppo+rUOeyujw5gpACdbj3um1/1K8Ogm3nPMvVDs1uWd
 NKm0gS9Jr56ehvz1+ikxON6zfRG5
X-Google-Smtp-Source: AGHT+IHcglQqaIiQ/zphkowy5K+qdf4pMcNUkw5l24i6HkoEV8kKkawadkLw+qLfUVUnCECSjQ6VKA==
X-Received: by 2002:a17:902:ebcd:b0:212:6187:6a76 with SMTP id
 d9443c01a7336-21c354016c5mr40728595ad.14.1737110758438; 
 Fri, 17 Jan 2025 02:45:58 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d4028d6sm12972885ad.226.2025.01.17.02.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 02:45:58 -0800 (PST)
From: Michael Chang <zhang971090220@gmail.com>
To: trini@konsulko.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 zhang971090220@gmail.com, yschu@nuvoton.com, JJLIU0@nuvoton.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 1/3] ARM: dts: nuvoton: Add bitbang delay through dts
 properties.
Date: Fri, 17 Jan 2025 18:45:38 +0800
Message-Id: <20250117104540.1580343-2-zhang971090220@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250117104540.1580343-1-zhang971090220@gmail.com>
References: <20250117104540.1580343-1-zhang971090220@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Jan 2025 15:10:59 +0100
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

Add bitbang delay through dts properties.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
Signed-off-by: Michael Chang <zhang971090220@gmail.com>
---
 arch/arm/dts/nuvoton-npcm845-evb.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/nuvoton-npcm845-evb.dts b/arch/arm/dts/nuvoton-npcm845-evb.dts
index 0d3aaa0fff..1535defe38 100644
--- a/arch/arm/dts/nuvoton-npcm845-evb.dts
+++ b/arch/arm/dts/nuvoton-npcm845-evb.dts
@@ -190,6 +190,7 @@
 	snps,mdio-gpio = <&gpio2 28 GPIO_ACTIVE_HIGH>;    /* gpio92 */
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 1000000>;
+	snps,bitbang-delay = <1>;
 	snps,reset-gpio = <&gpio2 29 GPIO_ACTIVE_LOW>;    /* gpio93 */
 	status = "okay";
 };
-- 
2.34.1

