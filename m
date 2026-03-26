Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006B810A1E7D
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 11:28:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A6CE83A1B;
	Thu, 26 Mar 2026 12:28:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="kO/Tz5a/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86D9A83CD3; Thu, 26 Mar 2026 12:28:50 +0100 (CET)
Received: from mail-dl1-x122d.google.com (mail-dl1-x122d.google.com
 [IPv6:2607:f8b0:4864:20::122d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59C2A81E18
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 12:28:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-12a80c36350so957880c88.1
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 04:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1774524526; x=1775129326; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0rOdej28lu4ouf2Q5X48i7C8QtCwCOM1yiRcyP99t/Y=;
 b=kO/Tz5a/D/dRJQdL6d1BmxZc1RIdIapyamjikU3KZlcCJOPotvD6wztZEztdTyFPeV
 7sjm+U70Vp9WpYjHVDsJtmsx/wZXX3fJXDLU7yiX9lDhxM4t/10/UPBhQVP/0QpfKhDV
 sVUS8BEsZZ0pMo1WOBIWBBu91B7V9Eut9UHvuKkLZ29NrfxM8WK43Yqc/AAs5zYUaTCm
 XT+AQjbs6/EJvThKPtaemVp/4Za1c7iy2G64Xq+5YGh5hKD9PpNxzo4rtvHGd3biX52V
 opxQMy9VR+5oNYYPEutdTzMm5DKO+C9fsrJrJbgKkYt1MiNh2SkwlT/5KWr2jxb55Hyw
 HHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774524526; x=1775129326;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0rOdej28lu4ouf2Q5X48i7C8QtCwCOM1yiRcyP99t/Y=;
 b=oS1X3IdY7v6ypgNQOorwXdkmBisG1h0E83cWA5CN1XVA9SLpFxPdh9lBufEpXIevN6
 7kU6iInJXynl7pPej4a8x1lsUnvbdkJ6FYpgBhO796Wp5XiKKltskGssO8lNiDQC7J7Z
 q3jSqb7tVE9XoStI3sTw/3HEzM+J+IdoHxeKGLUoq3tdTnhzumCLm9g/rc7+4plltUta
 MydDIXUEqN6xOaHJnbEHRZX/TuFjcQk+tsJLs8T1RImix66+9tvUaNSPnmMoFfm3H/mk
 zB0Y4uPuTAhAmEjU5JfZ8ncHkekUdzVzdQNzDP+oNOSnbREKhQTJnIew1ADS+Q49AGi/
 lpYg==
X-Gm-Message-State: AOJu0YybDCwHxu+j1RjDP0pgXbkqm/JFTmjQ0Bhc6caud3DvgUhuUNXD
 6JPpd6OizLw7sK0At+QZvCbjV/6l/DO87VuUm8DSjA2qhbCoePcVwL/RLrxgvI9zRtOVLWsW6QM
 rVGsT9ShipOm/9pJtLqfudHr+QwxIfaH/pcmz0cCwrFwjCtF9FLZ83oPswo6RqoO9esAaV5dq61
 +rVI2TUBF+KUPy6CYujzn29o0UiQ/hlJsr3AOK3jRrXVE=
X-Gm-Gg: ATEYQzwrkxQTgIj/DAXvfi+PCtLfFLe68ND1M5AkyuSM/Xw3M/8Por5g5Z1gsfNIvd5
 BykTEownPFCnxtWGp5DNGiFdj8EJQxJhI4P8yrmUIswp/NrGOfwDnV73yao3RAFBYi5iQLB08F+
 hcQd4ApOXYSIjMPM+cj94ZSYepOy/BYszLJHbLq6I/Caf7GHK7mWOMJAhZSjefCu7ipExUaNbMd
 G7uixaj5TRaj3ZfS/zY4IUqnKEbo3ATzc0RsYs8A76XbxTi9MGm7WDHSsiM00iH233YRMk3vZr/
 5g8xLFYU6ODUHyHSAwKjms7MV0JLdmIpfke/TGQOaZb0hL8Z1rumW2sC4a4USJX9olTF00ZcCs4
 5/Mg0eR/NgAo6gRyTCuKd3PYz+PT3YC2sVs7HyACw1REMla+6VP1W6teKseme3QQMwsqgtAy6JD
 WNesHqsYZXiH8MBu4FWh+8xDExgevU1HuQAXq4HGUNv4GVfDX7sACkTCMHgtvjCAs/n24oJaGiS
 SKcpWZlflwhIs1ktUypgsb+6XlXmeX2HwZGquWCWRM2jNBRdGA=
X-Received: by 2002:a05:7022:45a1:b0:127:33e0:ea40 with SMTP id
 a92af1059eb24-12a96e7e829mr3626466c88.15.1774524526161; 
 Thu, 26 Mar 2026 04:28:46 -0700 (PDT)
Received: from fedora (cpe-109-60-83-68.zg3.cable.xnet.hr. [109.60.83.68])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-12aa7624247sm3729221c88.11.2026.03.26.04.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 04:28:45 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: u-boot@lists.denx.de, trini@konsulko.com, lukma@denx.de, hs@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, gregory.clement@bootlin.com,
 lars.povlsen@microchip.com, horatiu.vultur@microchip.com,
 jerome.forissier@arm.com, marex@denx.de, daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 01/14] serial: atmel-usart: allow selecting from
 ARCH_MICROCHIPSW
Date: Thu, 26 Mar 2026 12:26:42 +0100
Message-ID: <20260326112830.313874-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.53.0
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

USART driver is reused by a lot of Microchip platforms, in this case we
need it for LAN969x so allow selecting it when ARCH_MICROCHIPSW is used.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index b84cb9ec781..3848c3ca20e 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -665,7 +665,7 @@ config ARM_DCC
 
 config ATMEL_USART
 	bool "Atmel USART support"
-	depends on ARCH_AT91
+	depends on ARCH_AT91 || ARCH_MICROCHIPSW
 	help
 	  Select this to enable USART support for Atmel SoCs. It can be
 	  configured in the device tree, and input clock frequency can
-- 
2.53.0

