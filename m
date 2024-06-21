Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA41C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:55:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A381885EC;
	Fri, 21 Jun 2024 21:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ndeXSXFR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 487E3885B3; Fri, 21 Jun 2024 21:52:26 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EC8D8858C
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3748ebe7e53so9487095ab.1
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999543; x=1719604343; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lq3h+GuSAudu1LsYAUPVwxxmFzpl9EXiEjgaRzLffT0=;
 b=ndeXSXFRcqGFrE1CSIXnfSOjOSN6k/lPMng8wl1O82lOmW2p2huRhk5uFk7HIOCuVB
 3W0IvSy1A0NDo6cHZEw97cuHAjklFKxp2poBWAhgQBFSQJ2v7Na0JLZtnAZxqfxhj1Qi
 WhnqwHfhHRKeuC/ql8woQkXudnJNWJL4zJ0hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999543; x=1719604343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lq3h+GuSAudu1LsYAUPVwxxmFzpl9EXiEjgaRzLffT0=;
 b=w5s1aimcilA6MRXOCdrQdfIog8fBTMTRUcr2N5LcQYnNUzU0z6hRUkZUYmmcvo0M0J
 iPyaWrZiONGpGhejQsET1NcjhE/BrvsRqqkiVXQFKbYS6XuMYD8BZVcXqGjmWp98wfAB
 pMsAXhpbvV1CRJHT/AN3ufD/x/KWQnLN6YaZoAU8XIan33COkKKyq06OyfxJikoSLjcP
 Yyu9HXsHlZB8+CAMGH8ZUOz68QvuxQESe5mDm9uxv2q7exZ5RktPyjitBEj5P7rfgFXF
 wQ/hAd+6RGPVnj40sQfOe7XLd+senNqojXqaYeYsIxHvwqOaGzsfNLPf/DXjynWrVVJ3
 dx1Q==
X-Gm-Message-State: AOJu0YwWBjNgoTlLRCZxBwJrvX1yAZPNlpdjztUn05dJRUoKxW8la06w
 2qWvOY5/zuGbL/dJVxJOn64Zg+X967Yw0HZuEqxSoEV/qqe/asfSTLQLcQ4Be3IBuTp4k4uzbtq
 1Qg==
X-Google-Smtp-Source: AGHT+IFt9oOMKIMYbuImc0NrNpGB4dtSHhXkHfxenoiBn0GyxdaBo7WZs7r/AbVvylZZ+Owp+asj1g==
X-Received: by 2002:a05:6602:2c8c:b0:7eb:c85b:f19b with SMTP id
 ca18e2360f4ac-7f13edd0004mr1104253839f.7.1718999542731; 
 Fri, 21 Jun 2024 12:52:22 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 16/43] sunxi: Mark scp as optional
Date: Fri, 21 Jun 2024 13:51:37 -0600
Message-Id: <20240621195204.2675252-17-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621195204.2675252-1-sjg@chromium.org>
References: <20240621195204.2675252-1-sjg@chromium.org>
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

This binary does not prevent the system from booting. Mark it optional
so that U-Boot can be built without it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/dts/sunxi-u-boot.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/sunxi-u-boot.dtsi b/arch/arm/dts/sunxi-u-boot.dtsi
index 0909a67883e..e1a9a7f5d4c 100644
--- a/arch/arm/dts/sunxi-u-boot.dtsi
+++ b/arch/arm/dts/sunxi-u-boot.dtsi
@@ -90,6 +90,7 @@
 					scp {
 						filename = "scp.bin";
 						missing-msg = "scp-sunxi";
+						optional;
 					};
 				};
 #endif
-- 
2.34.1

