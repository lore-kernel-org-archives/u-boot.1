Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1196C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 15:52:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 366A580C6F;
	Sat, 15 Feb 2025 16:52:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UaSkIA0S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF44E80C98; Sat, 15 Feb 2025 16:52:17 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B99BD80756
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 16:52:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-54529eeb38aso1764106e87.2
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 07:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739634735; x=1740239535; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nxRUtoIBmgmrV0vbk0ZqJzEaqL9L9SvA3u1KdGCEfvU=;
 b=UaSkIA0STDHuBuVuLuxOMYNsvOPMrhQRaELFw3/iKgLdqwHNzVFJjfPGvEoopZJYyS
 sFpBT7tI+jAYyUGLsDi8V48/ZNp5XJgbKGPR02ViiUDNtoJLWJS4JLR1V7kEAlO4Qhht
 4zngbrCv85mqWQyrEfpH8ojE58EElau/x/hn1DxH/ssFg5l3Yt8MjT3nLFHN47BHP/G+
 G3J9Mb7uZOJX7f/D3q0bmj7N5decwVIKW48lkM+8SwjeqElDk4HWOqzMcbjEiNnOv9iU
 NrOa2vajFLd/oxZuNqob123t7Ep/IgMsYNwb7MuWZJeWARv2vh7iNhm1hyJLsEcZ4ep1
 kzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739634735; x=1740239535;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nxRUtoIBmgmrV0vbk0ZqJzEaqL9L9SvA3u1KdGCEfvU=;
 b=PmZT06vdZgin8pXV3qEmyLNN9HUKB+fpGYWVj1nyC8hLjGlPh+GHcUQReZsL7ZjARA
 7XXaG/4lomxUGpr38zvrEwCvyXKYiZmjmQMhhmAFjuLfhTaSbLvKmrAPgHvQ98u9IcKk
 1t5Wq+U0KK6EjztH26CZzbFERILKSqhUcLujGtawgz3OK/VGGz7DCy2rKmGgTPi+zvdZ
 giiyhDSZdlBIN/f1i+opMyuZqwWyQsIuStSHckOMmmEV//MQSin8aIe0sSdAHnHH1kt6
 pKWMr4i4z6MBP68LiWFxP5RWxbRxbj2ucZrIKNFvllWKv6SkoP+UDYUZzFMIjL5FJF8V
 Z35Q==
X-Gm-Message-State: AOJu0YziTvc/k5TRI+rTQFr2Mh+e2Lz4wNJNVi4kCd2hNSRNUBjGdWLa
 TB+MYeuryojZQnB95zx7DEHes+F1MOXWEZtFGDKW6Ng7MbhLoeEA
X-Gm-Gg: ASbGncteD9VU2QYeftGQpGQkTe8A+LS+XCK7GyyytteLHjNoTpTkiLj1F38KECFZKS8
 om3uAfBFSeRnbIoAtLj4rESl2+ZWpGEEieYm3wGsq0d+I3xTIXP2okVPNHEkL2EO7E/dtYSOL6r
 Muw8ZUu4NSY8P+tIbr5Xuy+yyNEGANgfoBx+iG+wa1UM4xqoUfMAsHNX7TRypzH5QzytqCV4X6O
 B94TkI80YtPrjCuvhLAZGHdrOzBWJX1RLU36IfHm1UoaPVxb+QXgLzbi5yYOuF7Z8ygYBugmgAR
 n5VySAk=
X-Google-Smtp-Source: AGHT+IH731PEwRFOXB7kI8Axz17uypq1Eq7QT1Eb7md9hjIfuul2zOCgNqy2cBV9/JFFsmMCQxfCIw==
X-Received: by 2002:a05:6512:ba6:b0:545:ab8:2be4 with SMTP id
 2adb3069b0e04-5452fe5bee8mr1175201e87.27.1739634734698; 
 Sat, 15 Feb 2025 07:52:14 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5452faeea50sm358471e87.151.2025.02.15.07.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 07:52:14 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/1] video: bridge-uclass: add get_display_timing ops
Date: Sat, 15 Feb 2025 17:51:54 +0200
Message-ID: <20250215155155.152271-1-clamor95@gmail.com>
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

Add get_display_timing ops for internal bridges linked to
panels that do not support EDID (MIPI-DSI panels for example)
or have EDID not routed.

Svyatoslav Ryhel (1):
  video: bridge-uclass: add get_display_timing ops

 drivers/video/bridge/video-bridge-uclass.c | 11 +++++++++++
 include/video_bridge.h                     | 18 ++++++++++++++++++
 2 files changed, 29 insertions(+)

-- 
2.43.0

