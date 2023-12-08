Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5508FC4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 00:11:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C670A8745E;
	Fri,  8 Dec 2023 01:11:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="D3wUexu4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43B3187250; Fri,  8 Dec 2023 01:11:05 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B12987457
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 01:11:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40c236624edso15978175e9.1
 for <u-boot@lists.denx.de>; Thu, 07 Dec 2023 16:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1701994257; x=1702599057;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OPB+dVAjJ84x6lbHCuhH9Uz3BufP4utHmtnMGSgHsmw=;
 b=D3wUexu4DD2RF71QYSOYTjWGJPHkOEcsBbxLwAJLUsBYtaZ8V9Hjx1sYG77+Yp5R2P
 bw9Lsjref+SQN9u95kdjIXyL5PB338F0udNorGK/8r8JJQQjO3UbRu2Ebu4s10Gra7kA
 z4Ao6UN1YKW9keirLSvPayuI3Mtaxi2eOC6K/U3V3vL6CiaifrcpKt/Is4lKqCeT1hyU
 TQcKNhuquxOHp9at/jkVkQSjXpZRqp/T1ChSHPbBvACKKz5udXXAgZXlUK4bqSVHaTig
 PWJ82/6GKwMt1UqzTpQ7P2gQ8hvwnkeoNGfOUr7sBQ5YWQeZULX4qaCyJ3TS3U3odqq5
 EfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701994257; x=1702599057;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OPB+dVAjJ84x6lbHCuhH9Uz3BufP4utHmtnMGSgHsmw=;
 b=YtD50cRpC+hbf9uNIVZlpbgjbj0PEPi4Ls6fbXzazvKO6QP/67R0XRIDjysW5r06+4
 78Xpkqj5rXOtzTV5hjYgQBW7YDR+X6HVjNy1i/1UTUrX9b79ZwEQEtK4CYz1ckXLSj9L
 OQ4u8VfWwSXM2In69yeGrJHUO5dFK3hz1HGOflgPpm7I+b6BJjefDqJHP1EjljYbif39
 PAgWWJO0tM434ZcYZQeTNGQrilXhpGUQvfy1tYZ+Kzwbti/30jLEjT6ntFrVtgWf2sCP
 2WJiePb5S/4BdvZi8SKMIPCdayDBEOjI/Z0x1GxQ/YpVaIG9VTPjCKBUKJNHg0L7BFEa
 e9jQ==
X-Gm-Message-State: AOJu0YzWYVhhIG1oInqPk9+8BB0GS7X1QnVRnzoRXUjsIqJCYn3a1Gs+
 O23IdRzcdg3Nzy+U4OIr3BEGNQ==
X-Google-Smtp-Source: AGHT+IGLSn2B6/u4m14yRTGSpma9/P6ugWj6I3aSjgFYrZA98LoA9HLQiqGNIGX7X/MU3+waRtZy0g==
X-Received: by 2002:a05:600c:601c:b0:40c:7a1:b2c8 with SMTP id
 az28-20020a05600c601c00b0040c07a1b2c8mr1959268wmb.163.1701994256879; 
 Thu, 07 Dec 2023 16:10:56 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 m14-20020a05600c4f4e00b0040b30be6244sm1074464wmq.24.2023.12.07.16.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 16:10:56 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: marex@denx.de
Cc: bmeng.cn@gmail.com, clamor95@gmail.com, Shantur Rathore <i@shantur.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: [PATCH v2 0/2] usb: Fix USB3 detection
Date: Fri,  8 Dec 2023 00:09:45 +0000
Message-Id: <20231208000947.248849-1-i@shantur.com>
X-Mailer: git-send-email 2.40.1
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


This patch series implements USB 3.0 port reset requirement
before scanning port.


Changes in v2:
- As requested, added fix for regulator-always-on in RockPro64

Shantur Rathore (2):
  common: usb-hub: Reset hub port before scanning
  dts: rockpro64: Disable usb regulators-always-on

 arch/arm/dts/rk3399-rockpro64-u-boot.dtsi | 12 ++++++++++++
 common/usb_hub.c                          |  4 +++-
 2 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.40.1

