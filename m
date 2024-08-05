Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4F5C3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 13:55:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7CE588908;
	Mon,  5 Aug 2024 15:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="neLHXhTi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB85488913; Mon,  5 Aug 2024 14:43:34 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AA31888F0
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 14:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bisson.gary@gmail.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6b97097f7fdso69746036d6.0
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 05:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722861811; x=1723466611; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FQyVhTIzmMTYUU1z+kt6zBUymZzDvgQPHeRUvScylrs=;
 b=neLHXhTiLPyPkwHH+ilGXKbs1HJz0MMLcFop3l072JBOObhC/fIkJsQYQLvmsO7D3T
 I9XJwgQQHCNqu+pX+ON9q7jyHB/nI5iFT4OCen/p3tER6aKHkfk4g4N3TIfdF1tokco9
 GscgKzzH1r7lbyU2moK9AcPwot+dhx0WXkbVfGhGOWWLMBNiTVJ94tAaRz12770GUaYm
 hcaVMH1KsVjtQ6VrylQcz+Zmzz6iujSfywtwEf/VA9pNlIu+KI/jLN3jBo6Eaaxma5A4
 qAeyXAmTkpOjFYQhQ538UhCh9A3YEmOiSfnxua3q8t6cXNoR3MQfN3bZpgLwLBP8+xvE
 iMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722861811; x=1723466611;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FQyVhTIzmMTYUU1z+kt6zBUymZzDvgQPHeRUvScylrs=;
 b=fGPhAHDLvlgTaUr3ePe6s0+i3qYkbX/nbio1sJLYndC/v3RQB/e3a5yhN2rrA4UG3g
 ftW2be4IUnqnVk09RBeN8ZRsqqszFZpNIgJi/R/2ZabR5tlLGsMXWnHAtmyfO6HDqdoa
 KpfNFFgGe/3KozErr274R/0drylnGVKgdD+xES1hGqIYy3n1klJRTldr3EFggKhRKuid
 V4xhZmocFGYXVRgx34V2FFHg3V8vFbxmYKTGJlS4xBSv2qd1+uLlJf+2OnpkcPm5hLzZ
 9VLipkcQMuVKQwRj6EquPlapkpNt20RM+zAXyjoHNoz9czOZtG3gGwX9j80CniL+YqO5
 h55w==
X-Gm-Message-State: AOJu0YwqzY45hUWC5lgA6XkhW4axKmvgiS+cNXqoWbbj1cmEhhpsGpRB
 1Ul8UfYVQ2ApwGvHHocwQWAjIJVzQUkCD7wQtyiVHWjJx3f22Xbb1e1gWQ==
X-Google-Smtp-Source: AGHT+IF/N4/xURJulup0oq8q4fZqPek39UFOF7lpg55jA6n4ouiU8fYpp0UP/nSGSUK30XKCaeuhZw==
X-Received: by 2002:a05:6214:3bc6:b0:6b7:a6b2:36b with SMTP id
 6a1803df08f44-6bb9845a1e3mr134152676d6.56.1722861810994; 
 Mon, 05 Aug 2024 05:43:30 -0700 (PDT)
Received: from p1g2.lan (128-78-204-97.abo.bbox.fr. [128.78.204.97])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bb9c87bb90sm34984796d6.130.2024.08.05.05.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 05:43:30 -0700 (PDT)
From: Gary Bisson <bisson.gary@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, festevam@gmail.com, peng.fan@nxp.com,
 uboot-imx@nxp.com, Gary Bisson <bisson.gary@gmail.com>
Subject: [PATCH 0/5] imx: imx8ulp: add binman support
Date: Mon,  5 Aug 2024 14:43:21 +0200
Message-ID: <20240805124326.544310-1-bisson.gary@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 05 Aug 2024 15:54:59 +0200
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

Hi,

This series adds binman support for i.MX 8ULP processors.

It required to update the imx8mkimage tool a bit as well as adding new
container configuration files. But otherwise it is pretty close to what
has been done on other i.MX processors like the 93.

Regards,
Gary

Gary Bisson (5):
  tools: imx8image: fix soc variable for ULP
  tools: imx8image: add upower image support
  spl: binman: Disable u_boot_any symbols for i.MX 8ULP boards
  mach-imx: Add i.MX 8ULP binman support
  imx8ulp_evk: enable binman support

 arch/arm/dts/imx8ulp-evk-u-boot.dtsi    |  2 +
 arch/arm/dts/imx8ulp-u-boot.dtsi        | 63 +++++++++++++++++++++++++
 arch/arm/mach-imx/Makefile              |  4 +-
 arch/arm/mach-imx/imx8ulp/Kconfig       |  1 +
 arch/arm/mach-imx/imx8ulp/container.cfg |  7 +++
 arch/arm/mach-imx/imx8ulp/imximage.cfg  |  9 ++++
 common/spl/Kconfig                      |  2 +-
 common/spl/Kconfig.tpl                  |  2 +-
 common/spl/Kconfig.vpl                  |  2 +-
 configs/imx8ulp_evk_defconfig           |  3 +-
 include/imx8image.h                     |  1 +
 tools/imx8image.c                       |  7 ++-
 12 files changed, 96 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/dts/imx8ulp-u-boot.dtsi
 create mode 100644 arch/arm/mach-imx/imx8ulp/container.cfg
 create mode 100644 arch/arm/mach-imx/imx8ulp/imximage.cfg

-- 
2.43.0

