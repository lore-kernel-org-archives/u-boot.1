Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6779EC87FD1
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 09:00:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D0048399A;
	Wed,  6 Aug 2025 11:00:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DFamkAlx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 148368346A; Wed,  6 Aug 2025 11:00:18 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 057178346A
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 11:00:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b7920354f9so5909744f8f.2
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 02:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754470814; x=1755075614; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8URlRm8Tt+fESG5MJ+aEX7wjSd3Xn7GAV45NCL49SbU=;
 b=DFamkAlxBsYtUHnF1qvE8ac731C5s7MhmL2Tei29yYoj1bwXYTLf0YBp5Ng/c02DUs
 eqGepaSbPa1kxNWpvgOR+WMz/Lc9nPnhKg+wmesI++U4z8P6GYMS09VZoGBzmWK5mvnM
 xXkFox1ZsPAeo7JsIemBfkDS6zQYz/sOGBdQYZ3k0ntXJaB6VgQZ3Lr0HAEenSlkRmnE
 ZMz6gC1GbIY3JgT4sPp3dVr1ushO97BeEpCEEDKleCW9gRjVUNQwovh8Dm5plJv8qi4n
 60CJ3BXP7t9nFn9a9JbjkDVm6XZOoUe+VPud69XrBsXXgoLO2q5j9XF7uUeLbelIw3Dq
 ffOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754470814; x=1755075614;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8URlRm8Tt+fESG5MJ+aEX7wjSd3Xn7GAV45NCL49SbU=;
 b=M9+g539eInAhUAg1y9OSobOxyQS1K3001TahkKp81R9RZv2CjGnZHIWA+/lluRmE9X
 ws69IT+USriUxVDQrnUdniX9l9FXqpqRnPtqRP6EK9XULkBEZBqQVYVe4FdcU5dmIkcu
 +X2E+a6YMyQv/GmxKaL/K3/stCHFKP2j7YePSBZqH/WbzTaMrJO2/WrseY8eEcm2en2M
 mpFroMFdL+NmPUf2/XCnLHsHwu/EhPKU7eu4ckP+HjpxMzXppYG8/R4S8rt/G/Tv5UqO
 m54dQxmpn6i8SIQ1Dyij69DXiPubMBAxlrjPkHxGYkKK4lYJ6bDqHUQDLifEdaGkBWnF
 HH9w==
X-Gm-Message-State: AOJu0Yy0RhfBZ3n0e1eOil8OI+j2dVFEhGS8/FrCl7/uWk0uvEnyRLCN
 I1WevJpU7iaXd3tznaLjZ5O8sVkToZ3hPlPPK+A3XUFkvHYH7eFpEc2SfrfcFUs2vBy9pqr6s09
 37eQ/MmNjDw==
X-Gm-Gg: ASbGncs8uCRBY3JpXWmjhv6M2w0HAZLYSuHR9ZysF7/y4nLAMOz/ECHEQVdcZfUFpfq
 xREgXsguJ9jaDcXWICtJNMeyHXVa/DickuxOquI7ZJzKZFoeUH0ROebA5JhBPJF5u0oZjffCmiZ
 Fwlq7QLBHVsP5KbPgYwfa5GogWbY6evgaE7EDd2vSd4zZsQNcZeBSyvFWmsjXFPo3LayfUiWhwI
 WYUyX3jEEW/nKne8Kr5AbAYcrvHxZv6lCXQTvyr9AIsQteI9JEBgWemV2VQU0K2LXro6HcjH9mG
 uHyRgU07Xd7BgaH0Qpb8hjGBN8ImNviKoBYdoeJTBj+i/6bjIjKVu69rZ6ZnuJtOMoJwLOWEJAr
 jy4ecZExjjBCaah4CkOtaYXKGj5GV2w==
X-Google-Smtp-Source: AGHT+IFuUw236G6eqH3RJ73M9aEl43yt4P2OIx+FgQmRZ3WHSDWzTc6xN7OQQ6+IBKUucIbBcGUc+A==
X-Received: by 2002:a05:6000:250e:b0:3b7:75e8:bd17 with SMTP id
 ffacd0b85a97d-3b8f4160c6bmr1573871f8f.8.1754470814066; 
 Wed, 06 Aug 2025 02:00:14 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6be:a792:5d93:499f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e0683045sm12686057f8f.41.2025.08.06.02.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 02:00:13 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 0/2] lwip: add Kconfig to decode and print ICMP unreachable
 messages
Date: Wed,  6 Aug 2025 10:58:12 +0200
Message-ID: <20250806085959.2130339-1-jerome.forissier@linaro.org>
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

When using commands based on UDP such as tftp or sntp, if the server is
not reachable or the service is not started on the expected port then
the command ultimately times out. However it often happens that the server
or a router sends back an ICMP Destination Unreachable message. That can
help troubleshooting. Therefore, add support to the lwIP stack and to
U-Boot to handle those packets and print a diagnostic message on the
console.


Jerome Forissier (2):
  lwip: icmp: allow reporting ICMP detination unreachable
  net: lwip: add Kconfig option to show ICMP unreachable errors

 lib/lwip/lwip/src/core/ipv4/icmp.c | 17 +++++++++----
 lib/lwip/u-boot/arch/cc.h          |  7 ++++++
 lib/lwip/u-boot/lwipopts.h         |  4 ++++
 net/lwip/Kconfig                   | 13 ++++++++++
 net/lwip/Makefile                  |  1 +
 net/lwip/icmp_unreach.c            | 38 ++++++++++++++++++++++++++++++
 6 files changed, 76 insertions(+), 4 deletions(-)
 create mode 100644 net/lwip/icmp_unreach.c

-- 
2.43.0

base-commit: ae5711f881100f856ead1e76832c32b92dba93c7
branch: lwip-icmp-unreach
