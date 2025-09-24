Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A530ECAC5AE
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 15:26:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4A0383622;
	Wed, 24 Sep 2025 17:25:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="N98o3ADn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1373B83510; Wed, 24 Sep 2025 13:31:35 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FBB880107
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 13:31:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b2e66a2fb63so471826066b.2
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 04:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1758713485; x=1759318285; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MnwwmmUvKZSo52JQyghIGRAQpxYKSnjetLDjnptRpfc=;
 b=N98o3ADn//xzCW/UHUA36a9EZTOythTcOsgwPUfP1HDJAS/Hkbbc2tc6YHHnYeFttL
 8rZXNHzapRZKEP8APaAyk8MwoEZvBbSm52FVF9NC2aGIEsSFs3GEwStLc51mVA7rHITm
 8jNOsLGmA9K8hKCsMRFvINduwPjI2Q5aA0WEk8wnf6Vo4NNkRXTylyRoT8qCe3lQ2BOr
 jRF9dNsGq0q5rMLVOeDmsWp4PsQmNBh601avaN+R9NYbK1rgPUZ34pHicUI/n5cPhhv7
 6m/25TVtb/fA9hUAD2ydhcydaldABvIjvAmspRajnTCeohUJQMiyrCVAMDmJ/TPgs3WE
 iRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758713485; x=1759318285;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MnwwmmUvKZSo52JQyghIGRAQpxYKSnjetLDjnptRpfc=;
 b=WmTTlT/a3238FWAwkmZeAYwWHh+T2XKhtQEvkWH8HzkchZwnrd83uRDD/ybcXgikEj
 xcLQ5YiWYhsEdr+bB5wnSlqN0EGuWDPDil6dR++8h0rCEf0xSxteyjH3fzpGviuWGnSv
 hBmv5+Y3ch2FK9UhAiVfWaZPD4U2xaWieJ3kyGpojY4njFibyLUlyXOcPCP6Eh/ybgcM
 CuzBtFrAVxeKSKbIu7N9ZXQ/v8qeq/K0ukvnX8Bcb2yGz1QepCGmD1jDIa327Ae5prL6
 gHXUW7BaDN/gCU+cMFPi9U9eRaESl8dlOZ4pQv5f7bcG6YXLbdUIS4eDFJBxgRGTpqmX
 i4+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0gGLgDnVH6jrvlHmVRoIDA0Uiv5zKFQdLa5UxQH3nyD9lciXawin33PHz6hzIdE20ujjV2aY=@lists.denx.de
X-Gm-Message-State: AOJu0YxWCgLSdM662pXTV+xwM9tdE3sgFhnh7xkrrqHmxN2gqUxPUVll
 H4M8jHu8ELXfj+6jVTvvZmFodM2UAVt0hpmdgDBqo71YchuHNMMw3wIsBKIGj1GXHGs=
X-Gm-Gg: ASbGncsLiCxdchVEQVXGDALgiUFcc30o0qsxxxBN9ApdHg6XRKUyq0++16qN6WhUPyK
 MUy28QdfhmJVjU5Q4vzVvowh1HQDJ6Hzaexxt2FvHLRQCvaY0OpcMwuPDFiieWM38QagEgtz64o
 cbx9944MMxvII74ERfhs4NzHyZNi25pL/8YEe9rN2sZ0ljyAi+4t1q7lbtuK7jVrPbnESpYgICX
 Zz7c/JljryJKo7TEuPAsHdf10dFkLvSHrWZ2QHaXd1nDF/2mYh8H/bs6Ef100v6mO9aFjM9PwN+
 YGyqMEE4yiIi+JO1qD0WGIXiaRrjaruL5rNmjbysoXMYAdD0Hyl1y5qXoQ/6NcUwJNa0OuIYSmk
 oHm9U3ohrKdGqb03B3vgIlpS7YsE0EloY/qaKbD2iqp3nAobtttcV0rL2OztIu+u/kB2D/w==
X-Google-Smtp-Source: AGHT+IHLpSTvLdSDhYkpOgLJd/DQm5qiM+G7v/b1JxYyryvvzVYNX5EfPD1671/Wkf9s5eVL3SVH+w==
X-Received: by 2002:a17:907:7f13:b0:b07:88aa:255b with SMTP id
 a640c23a62f3a-b302689510bmr603703266b.11.1758713485418; 
 Wed, 24 Sep 2025 04:31:25 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3339789812sm96698266b.17.2025.09.24.04.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 04:31:24 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/5] Colorful mix of small fixes and UART improvements for
 Qualcomm
Date: Wed, 24 Sep 2025 13:30:06 +0200
Message-Id: <20250924-2025-10-misc-v1-0-7e75842ca714@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD7W02gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyMTXRBD19BANzezOFk3JdE4ycjY3CzJzMhcCailoCg1LbMCbFx0bG0
 tAMWG3LleAAAA
X-Change-ID: 20250924-2025-10-misc-da3b2376b627
To: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758713484; l=975;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=S4K8swQe0hjrwetubU1simiF7vxnKOBYzxLrTtS59Jw=;
 b=kgZmTeZWH2g5wLHalK379tHoDefCc6l9WsSeSIhoLwfZA47A6qPMgZztyntmZkmuK+O0tsLgC
 PTZOo/oo0GLAbMtd6NN2h9A3mD4WFJ56rJvLqZTPGehRrrlhLZk9DNK
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 24 Sep 2025 17:25:44 +0200
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

Various patches that do not really belong together, but sending them
all separately also feels a bit much. Hope it's okay like this.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (5):
      pinctrl: qcom: sc7280: Fix offset of UFS_RESET
      clk/qcom: sm8250: Remove unused defines
      serial: msm-geni: Update kconfig name for DEBUG_UART_MSM_GENI
      doc: board/qualcomm: Clean up debug options for QUP UART
      board/qualcomm: add debug config fragment for MSM8953

 board/qualcomm/debug-msm8953.config   | 5 +++++
 doc/board/qualcomm/debugging.rst      | 2 --
 drivers/clk/qcom/clock-sm8250.c       | 5 -----
 drivers/pinctrl/qcom/pinctrl-sc7280.c | 6 +-----
 drivers/serial/Kconfig                | 2 +-
 5 files changed, 7 insertions(+), 13 deletions(-)
---
base-commit: 2f2ab7e13a69367cc9b88a45899e24dba02667c6
change-id: 20250924-2025-10-misc-da3b2376b627

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

