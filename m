Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20561C021AA
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 09:59:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75E1480F7A;
	Fri, 21 Feb 2025 10:59:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="BrNlmzKd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFD558007D; Fri, 21 Feb 2025 10:59:10 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4DFD806FE
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 10:59:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B71E13F467
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 09:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1740131944;
 bh=C8qDqJpC7hkF9X225FSFppulPagS/AmDyIj9AZ2tqIk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=BrNlmzKdSa4HOUuqqLA5DRvN7XuWV5mfvok4kge2ilOUxewVzfY7fbPwRt9/xSewM
 AAmuGJeDib0Nz51CNdSEKv8Ggc8cVBxqxkRLOwP+XCdwR8UwXOwJK46dAViavNexO7
 9QyQW5u8fqSzWOlsmWMaP96cta+4+SqbnvYQTXf3Q6QOEBPpISR1wsA+V1iymdv3Dt
 eqnUYpMTVhAMI7I4q97F0Ac/QQAzPhd3iC47iNeMlb4lPiAsrn+58T5+Pa0hZKq+tx
 mIYyipNqSYeiECUeYvDXaivl06lvaG0/9zR4y1gXWuB/26tRkC/PfMbrFMpEiuEJTE
 5eAgVaVrY/AkA==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4393e89e910so10232375e9.0
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 01:59:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740131942; x=1740736742;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C8qDqJpC7hkF9X225FSFppulPagS/AmDyIj9AZ2tqIk=;
 b=YguVQTv4dUxWtuOiqH3VCABMWwDGmZ0rNsc/o2GT9UuCDev/LCT3qVcGm13AHsxdwG
 61dRaWMGxewgcD2jlP7LL3hbH1+I/QpB5tFGt20+Xny0K8s/GCnqY0cyxC8TAwXzu6vE
 ZhK1AcX7bPtIuHA/Pmvvu0oJz8QXpkHC5X5G4WYyIm5xSmxEWP0fYMs/OnIwCu+bzDGm
 c9J2mcOzfTm9bAzfnjNaqgKlefJqQexyMAaTTWQt0mGZSCzL/tS4498mwJY50Q9Dphio
 9zgGASWiFf1oQv59tsqzHqp/CY1lIIlgukUXSBw8eI0CzkCeGMwLZcOQa8w59uNwwy7z
 P6Kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4vdbPvDY9TcBWYna24PH/gCXO14nKG6GWhEeSgRT36lQfjZanNj5xzskJ8xLIRYqD7XL7FS4=@lists.denx.de
X-Gm-Message-State: AOJu0YxrQ3oafaa70ElnFcnD9wpEMog6BY7O8gT5RgZMJAwJMFV+QpPK
 Z6ubhV6xle4oE7kArDW3jmLhm+tYb0yEqa8gcelvAyQ0Hml33xTqD+VXnGcbFQ1LG/qWZICHFxL
 YKOxWtIR7CHaMfk+zM5VDOpwalJKrY9IDGm4p0AjnX5CC1KvGpQlpYBd3XblwTpFlsBk=
X-Gm-Gg: ASbGnctWhHDefOThz9Py/yeErB+bmuc6l1/iJkJ78l629y/S1oR5xF/QPV7kf1uslk8
 M+/cNeauq+VEPtLzr29ZmDpl0+5h8WeikJUHN+0FJlWy8aMk0wYl9qqdmoS5Q984rLqXJcXZ1Va
 oskz8/bWZc4ZCjbbszw5SEZ+etrjhsPtfP+gMBgQGaImkTOlpQZkFdR5fd7bbN3dZLIYKTWx5j7
 Rc0le4KYlC3eeYDQrtx/aRBmYuQx3ohxBXs+4iLvtU8RaoDrgPRW0Z9+5uIFZzvahGZwLqlsvR3
 3uSTMtm9Mr+WfoFCWpkbpm53emRrxCpvutXPq2Zx8vCyaCzGuDvhmFt1Hx+VPhnFJ/PY+jDnhVI
 tAvnLZg2Nsf99MxQ5RQ==
X-Received: by 2002:a05:600c:3555:b0:439:8c80:6b02 with SMTP id
 5b1f17b1804b1-439ae222903mr21226125e9.31.1740131942334; 
 Fri, 21 Feb 2025 01:59:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0QJhlEZyHa9YElncIPhbJT5i91wSOuRkLrO/6Ox0JWNNRWClmoOHMUhNqG/pN1RU4n6dLLQ==
X-Received: by 2002:a05:600c:3555:b0:439:8c80:6b02 with SMTP id
 5b1f17b1804b1-439ae222903mr21225925e9.31.1740131941958; 
 Fri, 21 Feb 2025 01:59:01 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f69b3ca41sm3287961f8f.27.2025.02.21.01.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 01:59:01 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Simon Glass <sjg@chromium.org>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>, E Shattow <e@freeshell.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>,
 Lukas Funke <lukas.funke@weidmueller.com>, H Bell <dmoo_dv@protonmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 0/4] riscv: dts: starfive: simplify binman config
Date: Fri, 21 Feb 2025 10:58:52 +0100
Message-ID: <20250221095856.36530-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
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

All StarFive JH7110 are supported via starfive_visionfive2_defconfig.
Up to now we have explicitly specified the multi-device-tree FIT
configuration. This more complicated than needed.

Binman can use the information from CONFIG_OF_LIST to automatically
generated a FIT image containing the necessary device-trees and
configurations.

This also removes the non-functional default configuration without a
device-tree that binman added up to now.

Before the patch set booting on an unsupported device would fail in main
U-Boot due to the lack of a device-tree in the default configuration.

With this patch set booting will fail in SPL because there is no
default configuration.

v3:
	Use CONFIG_MULTI_DTB_FIT instead of CONFIG_OF_LIST in the binman
	include for identifying the use case.
	Remove default configuration for CONFIG_MULTI_DTB_FIT in the
	RISC-V binman include instead of a change on board level.
v2:
	do not use a default configuration

Heinrich Schuchardt (4):
  riscv: dts: add OF_LIST handling to binman.dtsi
  riscv: dts: no default configuration for MULTI_DTB_FIT
  board: starfive: spl: strip off 'starfive/' prefix
  riscv: dts: starfive: remove duplicate itb entries

 arch/riscv/dts/binman.dtsi                    | 10 ++-
 .../dts/starfive-visionfive2-binman.dtsi      | 76 -------------------
 board/starfive/visionfive2/spl.c              |  4 +
 3 files changed, 11 insertions(+), 79 deletions(-)

-- 
2.47.1

