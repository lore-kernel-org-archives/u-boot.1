Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BA8C71153
	for <u-boot@archiver.kernel.org>; Sun,  3 Sep 2023 20:34:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E813B8679F;
	Sun,  3 Sep 2023 22:33:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ItmUGS/I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F364C864E1; Sun,  3 Sep 2023 22:33:58 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65278864E1
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 22:33:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9a2185bd83cso123859766b.0
 for <u-boot@lists.denx.de>; Sun, 03 Sep 2023 13:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1693773235; x=1694378035;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MfgAoKBXdr0ffk+hI2szmkH0t+Jsl/5VVXdkefd/DFM=;
 b=ItmUGS/I+gnRGSL2/8+TdZzJgDHjnv5SJRa1FBm7RkbqAP3jg3wUwK3mMsGjZ6oxSp
 SJXtEMm+NxupqYCVKxD9FZf+y5YHTNS2AGVf8H9xJMz1m0LWqFM1lb4zBNVhwLlp7Lwf
 sBKmLoRhkQ72ZIAzJ48EXfljYbag3RJupvEGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693773235; x=1694378035;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MfgAoKBXdr0ffk+hI2szmkH0t+Jsl/5VVXdkefd/DFM=;
 b=X7+E/Lq32tsAKAdS47kFr9FztoDxFK6HBi1eHX4tpmcXwVye1bo7mVUzAsqKzhSsdw
 lGI/NTctt/8bQD9PNTKjoF4IhO///roI4n4t1GX+CeVWk92nSv4JhyrUmhDqF0vj8+Jl
 s2ued3QrZEtXwmkwFQzRwJSXTitAvGk63wXejBvOepxcKqgH1Ey51JN3orIXAg3dCdXV
 jYbK5sLlo+ix5vwOn7br61Wr+g132ba7S4B9KjansAZjA62cZoMIkHQndnE5pBk0TkU/
 /i5cNDDAeb9+6jN5RUxDJcY2urYpGwFMJZV1ddWnDJz27WkC2navOKslbAYANkNiNgLF
 G/lQ==
X-Gm-Message-State: AOJu0YxjfdVtc4Fkag7BujQhxzh9aaKrVYaJUfw6Ze5MSwldfVYS1ClM
 3G81VpdrPXqg0C254hvgJWB8T2IOXZPGe4quYuALow==
X-Google-Smtp-Source: AGHT+IF62TAhgSU6/v4/MFcYmpj0LkMfWdF7nDE1CEB7CQ0rDA5ykvy6Hu5Ck8d7s1B5MdXOjN49ew==
X-Received: by 2002:a17:906:29e:b0:9a2:23cd:f05a with SMTP id
 30-20020a170906029e00b009a223cdf05amr6745014ejf.76.1693773235591; 
 Sun, 03 Sep 2023 13:33:55 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-79-54-71-141.retail.telecomitalia.it. [79.54.71.141])
 by smtp.gmail.com with ESMTPSA id
 pw9-20020a17090720a900b0098884f86e41sm5103232ejb.123.2023.09.03.13.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Sep 2023 13:33:55 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 0/3] ARM: dts: stm32f429 sync with Linux kernel 6.5
Date: Sun,  3 Sep 2023 22:33:49 +0200
Message-Id: <20230903203352.658691-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
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

This series contains my patches on the device tree for stm32f429 platform
that have already been merged into the mainline of Linux. Since they applied
perfectly, I preferred not to merge them into a single patch, which would have
been less readable.


Dario Binacchi (3):
  ARM: dts: stm32: add CAN support on stm32f429
  ARM: dts: stm32: add pin map for CAN controller on stm32f4
  ARM: dts: stm32f429: put can2 in secondary mode

 arch/arm/dts/stm32f4-pinctrl.dtsi | 30 ++++++++++++++++++++++++++++++
 arch/arm/dts/stm32f429.dtsi       | 30 ++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

-- 
2.34.1

