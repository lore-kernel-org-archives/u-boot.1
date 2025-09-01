Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B5FCA0FF0
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 17:48:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FE6583A3A;
	Mon,  1 Sep 2025 19:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KXLQyQ70";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC7B183A28; Mon,  1 Sep 2025 19:48:02 +0200 (CEST)
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com
 [IPv6:2607:f8b0:4864:20::a2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50F7E83990
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 19:48:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-544b58831c8so308776e0c.0
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 10:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756748879; x=1757353679; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=aabHYnN18Kr36Ervx3AMxVKBnnaeqGQPKgWA307VgzU=;
 b=KXLQyQ70pZ2YkD0VXhhOyjyFvAHzKwY4kcFNcLh604IXqzQvUUysZKQVn2jmBVtIkY
 /Ng6A77+VEhJxPIPkhtOh/37GnTSlURbpZc1ca+bqksl+8gSPG2+6aulEYpvvVlTmhMm
 65doHFlqPBUEdTQpOsSpKZapco4poWIpBPrGqXAXwzGyAup7MRe1U7EPeHrZbNax9Lht
 Yc+TVrNTbNNabOF1BumZYnyWm3LojfxLuKyrSDJiHJMe+dg31Xh0lz/Top70oRpQLetn
 T47xhKJygor7mgE2MAofNpTI3y6QEHzg+ge/3AZtQgOFuGI0oIhs/a6feSEChPTe4nAV
 jltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756748879; x=1757353679;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aabHYnN18Kr36Ervx3AMxVKBnnaeqGQPKgWA307VgzU=;
 b=KzZeafjML6TQEPyNlMX4mTb/6ZN48a+G52xIZ6Kl1pDSQlnq+zx7scV1Q0j1RMvBE0
 4IVV+y9WxcoNBbo38PbHld1tR0LZa+ODSdJ8eYcK27UdAFWxsYK+s1OWjf3AHA+fuiyj
 u1jKnMKmTDo27BnkWpDK8UfDt9K3gcykhLRfX/d1QrCelDGR0Cqli4H4F5JTt2NH2e+r
 GtslkW4CgRb354MdxV9VaWR/2Ll/Enva9AG3BNPnhAF1H9SaKpOy6q0hdMi4AbbLODBr
 Ng4I7BFiSdTEn+r/tiEGhUntC4tox8XiwS13QznUG5T5qeTjH8vaLUKc746w1PkkFmRX
 mDaQ==
X-Gm-Message-State: AOJu0YwQXqAz6K2T9p8rI6x8+Z2ULZH44jLSrkQ+xBaQXdnRiayaYhXO
 wZeWbo3+vQFidZT7TDzIQPLGK4SchuEYCePwXucrP4GaJJDtkKITkuhRSCJbmuLCC+2Rbwj9PrI
 d6XaX
X-Gm-Gg: ASbGncsuhDRp9/r5rItgjUV8RqlTbYUJ+OfSkbmgTrjfj5fAXXFp9ERSGyH+ykwXBid
 MD9xMGbbBQ7l01cxEjYOD6CZhaXm8NgRqjGyjXMgegL5LMT73Iimxs05WbpReq1xixMis88izQe
 y5g8SVsGrFgQR06wvARrKMts4nCXyesozuD39iE5dORXMI09r4BpUV9143S+fq9/ApV7WmsdXeZ
 wfF8bzIEAYipNsv0aYnk6CTVeMlULaO/0nPURNc4bUw7wIitPM50NptmUvfqQ9JuHTWb0daWfsD
 fo+xYl3Okeq6Dl5eAIfx3wgUXvttmbsm+abYc5ai9p48gPcLT5sVLQDl0m/5j2dsuZqS9kV8/ZT
 H9J/lEbxbTczfjVs8MQI6Hc940nMfcJczm2kV2mhhsldT/p+T
X-Google-Smtp-Source: AGHT+IFmmEaHMxuHk6h9xkk+H6voQQOuFCARVqRdA5zD+dsdQesOZtRwr0umE0/+FPat0XHsJh7RaQ==
X-Received: by 2002:a05:6122:1789:b0:542:2912:664f with SMTP id
 71dfb90a1353d-544a028d9c2mr2547954e0c.10.1756748878907; 
 Mon, 01 Sep 2025 10:47:58 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e ([177.93.10.181])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-54491464aebsm4670495e0c.14.2025.09.01.10.47.58
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 10:47:58 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de
Subject: [PATCH v1 v2 0/4] Modernize U-Boot code formatting with clang-format
Date: Mon,  1 Sep 2025 11:47:51 -0600
Message-ID: <20250901174757.166162-1-javier.tia@linaro.org>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset="utf-8"
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

This patch series modernizes U-Boot's code formatting infrastructure by
transitioning from the legacy scripts/Lindent tool to clang-format, aligning
with current Linux kernel practices and providing a more robust and
comprehensive formatting solution.

Changes in v2:

- Replace Lindent with clang-format before remove it

v1: https://lore.kernel.org/u-boot/20250829233951.547352-1-javier.tia@linaro.org/

- Removal of the obsolete scripts/Lindent wrapper
- Documentation updates for the coding style guide
- Migration of existing tools to use clang-format
- Copy .clang-format from Linux kernel v6.16 tag

v0: https://lore.kernel.org/u-boot/20250829190058.GY124814@bill-the-cat/

Javier Tia (4):
  clang-format: Add configuration file
  tools: zynqmp_psu_init_minimize.sh: Switch to clang-format
  Lindent: Remove wrapper around indent tool
  doc: Update U-Boot coding style guide with clang-format usage

 .clang-format                     | 804 ++++++++++++++++++++++++++++++
 .gitignore                        |   1 +
 doc/develop/codingstyle.rst       |  40 +-
 scripts/Lindent                   |  18 -
 tools/zynqmp_psu_init_minimize.sh |   2 +-
 5 files changed, 844 insertions(+), 21 deletions(-)
 create mode 100644 .clang-format
 delete mode 100755 scripts/Lindent

-- 
2.51.0

