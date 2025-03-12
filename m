Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F5EC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 17:59:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95C758141D;
	Wed, 12 Mar 2025 18:59:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kJpXRFNc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAC3C81335; Wed, 12 Mar 2025 18:59:23 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3AC08003E
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 18:59:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac297cbe017so234342066b.0
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 10:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741802361; x=1742407161; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gq+VsdPqBGeTYI61kSHnHwYZNaklFWdluLjgXEWOGdw=;
 b=kJpXRFNcNRwapRncoo671LuEs0qQ0hiMpaJd7jmfrvkd+sZW3iGX25TCcqqZzPqobs
 WzOpur5FwmPJvEy7jvChuqUZIWliet2BtJo0lB22bkCk3YRXXaCoM+6nXrf6Usk0Syuw
 DOz90qMkp/xz9EYfOCpz0GmveoMBcz+Y43sc15tUH9L/7kxt5q2DGMz/gjHoNS65Rtsj
 kcmPyAZG48ZAw2j6zkJpZpriSPpLZ9jDNeyuef3IQ96xmtnvEhOneggJLQi4OLl/GvzZ
 fyJ3U6v1OVdE03UoRMBbhnRvDZbJYJXTBsMULF4/gnhv2vWswWLynF8vsJh7apcBPrHe
 lVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741802361; x=1742407161;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gq+VsdPqBGeTYI61kSHnHwYZNaklFWdluLjgXEWOGdw=;
 b=G511Blid4AX8faDlqsY5AR3GTm1Dgnz+B4E+h2kh6SJAolIrmWCTXOfKzs2JZ2bRnN
 x87LX3l35l5plS7guSAvl7AEcodySXQ9rapJRj0zR0C488Jt4mgxQfPRCUuWnS5bkZn7
 TGM043z4aCYx+U3THD3yfFq0/pWxE7MRuplKTTUs0MqCEdnfg7xzOXB3bu/5SlulfN8h
 uUqDZlw+SbeOLskclHYssBDjWbqgGtXF+IXNxxh8rc4XReffNVp6MK22vhPEyhHQ/weG
 8xKNp9CBJQSy0v904TwE6U80ABxzcwX8X0KdbWoVw3/urgJH7ccZnk6U13W9XWwfzasP
 sC2A==
X-Gm-Message-State: AOJu0Yxgc7xCRkzMfzkV4BwlbSJlKs3NETeBUdzC3rJtrB/2xxUCQVxt
 rjF82c5QQYC1TBZLM0ICmCvSy3qjV3ovq7b7bWC2xcNKNEexIoTo
X-Gm-Gg: ASbGncu3ouroiIANQhA2AWeDS3CYroUizTXkM0tcvUijj9w4WJSZjrgYDGkqAGfDisp
 s3zmJ8JuZdhr4e8BrZkSHSLGQwW7eFIaC+Wg3VOSBq0f7IzlGFDhXwqbNcq6PZTqr6krkxbGwZ8
 FQBgCsPebuxsh2F+Xr03ZJCPHxWejRux1PUVp0EJLoFZ1HkRCJF9etVWqh7Cpg2l3O5a7RvlmrV
 F8YYBIm7FDwZA+wQEaJq0Uijfv0FW0yOAkl+oFC0xlKsKs9Et2rXDSvOL77VRN060akHSJqDwAj
 HawZoAGzSj5JANXEUw7OxEVJgi8htnQSMT0BM9R9yjiy1/A=
X-Google-Smtp-Source: AGHT+IFYi4tyYnbjLivZPA4cBt1hCUr8D8T3XHVBQi8j+4BSzXl8pToJgJb1e+//4twsgkHUKf79SA==
X-Received: by 2002:a17:906:9c8e:b0:ac2:d2de:b183 with SMTP id
 a640c23a62f3a-ac30aa6be48mr72784566b.5.1741802361047; 
 Wed, 12 Mar 2025 10:59:21 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac2394825adsm1125291166b.56.2025.03.12.10.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 10:59:20 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 00/10] video: tegra: migrations, HDMI and HOST1x
Date: Wed, 12 Mar 2025 19:58:47 +0200
Message-ID: <20250312175857.120313-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Migrate DC and DSI to support video bridge UCLASS and OF graph bindings.
Add HDMI and basic HOST1X bus drivers. Move DC driven PWM backlight
into DC node.

Svyatoslav Ryhel (10):
  video: tegra20: implement a minimal HOST1X driver for essential clock
    and reset setup
  video: tegra20: provide driver support for the HDMI controller
  video: tegra20: dc: add video bridge support
  video: tegra20: dc: convert to use of_graph
  video: tegra20: dc: get DSI/HDMI clock parent if internal DSI/HDMI is
    used
  video: tegra20: dc: remove unused video operations
  video: tegra20: dc: support binding child devices
  video: tegra20: pwm-backlight: convert into DC child
  video: tegra20: dsi: convert to video bridge UCLASS
  video: tegra20: dsi: respect speed mode used for DSI commands transfer

 arch/arm/include/asm/arch-tegra/dc.h        |  46 +-
 drivers/video/tegra20/Kconfig               |  16 +-
 drivers/video/tegra20/Makefile              |   2 +
 drivers/video/tegra20/tegra-dc.c            | 233 +++++--
 drivers/video/tegra20/tegra-dc.h            |   3 -
 drivers/video/tegra20/tegra-dsi.c           |  12 +-
 drivers/video/tegra20/tegra-hdmi.c          | 623 +++++++++++++++++++
 drivers/video/tegra20/tegra-hdmi.h          | 652 ++++++++++++++++++++
 drivers/video/tegra20/tegra-host1x.c        |  86 +++
 drivers/video/tegra20/tegra-pwm-backlight.c |  12 +-
 10 files changed, 1603 insertions(+), 82 deletions(-)
 create mode 100644 drivers/video/tegra20/tegra-hdmi.c
 create mode 100644 drivers/video/tegra20/tegra-hdmi.h
 create mode 100644 drivers/video/tegra20/tegra-host1x.c

-- 
2.43.0

