Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8EBC021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 17:09:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FB5180ADF;
	Tue, 18 Feb 2025 18:09:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l565OEEM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9977A80F32; Tue, 18 Feb 2025 18:09:02 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3371E80646
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 18:09:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-30761be8fa8so63198931fa.2
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739898539; x=1740503339; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YiY0g45j5j/H5gf+1r+nBgN8zA0JRyM8HdOeqbwuqi8=;
 b=l565OEEMpPPf0SezpGkp7zlY6yKyeih+EAxlQZBgQ4jTFANAeRfWBOezyawNLlKE1c
 37GnEV6w77JjpzEZr6JevfQc4N6dQmyWV0kuMYn7XgYiQk532qz4hqUfSfSnA7hDhl2j
 Ey8hDaC5QUOjY5I8rktnsHHbKYxFr20PjEtoViWT1yK+AVd4VGOAI1zhZraGq1nFuwDK
 Gox0U817UkTkGUHJcdKGfYeJta69PVyacOwQykVteuQdUEMfYc5G1AiNud3NYezWcMyS
 uEbgzN5Ep3lwkmQdRbBtfICPG0PiT5zWi+gKNkqW7IUi+EGyt/lWcb/3wQvdrBjT0jsE
 pBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739898539; x=1740503339;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YiY0g45j5j/H5gf+1r+nBgN8zA0JRyM8HdOeqbwuqi8=;
 b=N7ICRDUgqIU26j5c7MPH1GHZUs9k6Y9vGWk6lg56Z2X6BmQt1t1WVApPHblTHzkxtG
 y1rps+QIKTHQWOBmvzFxtlcP9nm8rpRIYa0gwA24vookOL5SVQ8yNpps0CU6d3x4Whm8
 RH1tglFm0jYAgvYvU8tylH49kLBiclEDPMQpBrGfUVxDRR42sBbmx0a3UoAFtFKZiwE2
 Gtp/sH7Yl+VC+oHglBEBAsnaUC+PUWkKXOSQz7VVXmZoBHvNYbd+fLnXGdIR6rVcI8cq
 Jhe0gPxJRcjztbdazA4ZIYl+WFS3IST62loLcTsAB2Mkuy/mtLa8ED9nChvYlHhe/zn+
 VkBw==
X-Gm-Message-State: AOJu0YyHPOWq8uISbPQlRMJ0C+1kxczdxOo7qpP0K1pO8QnEdwnnv0Ze
 NNekSM/2ky7UIHMiyJ37WtSYgHKQ7S37k3lj5EtRKMNNPonhe6py
X-Gm-Gg: ASbGncsngileaJmCEELi1Zf3pOkbKKfu5Dxt0qRqycocPSTL9/QGXTFtkdtX1Ryp7IT
 VievGnFgl7PAZ8wvg2e8cG2PyBfMqsxnzek/nVPSXFpOsMULwaoNC4W8swQ+olNNpXULgvlVBNr
 k97mSUI4U0OLLf3oiStW+FT7VQO8jWkkqAQ+dXu9xNX+ryJ9lHDQkmIkg8KxW2vV/nDTU4otIrY
 ++G1y4qJgdbXrjEFmbFrFY60JD+ZvopOxEOWfdkaINGlD2u/okrEf+hfjMkqZxawoOLvBmTNt3B
 L8XPbFs=
X-Google-Smtp-Source: AGHT+IEoKbEZp3RhGa/Q56kNmTftfBbw6TJ/nOvQarbqrHWWl0GObrpIA7dp4j/28d7S7u43/DFRrA==
X-Received: by 2002:a2e:914c:0:b0:306:10d6:28b3 with SMTP id
 38308e7fff4ca-30927a429b1mr44740361fa.1.1739898539059; 
 Tue, 18 Feb 2025 09:08:59 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30a266e4968sm10888621fa.77.2025.02.18.09.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 09:08:58 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 0/2] core: ofnode: add of_graph parsing helpers
Date: Tue, 18 Feb 2025 19:08:37 +0200
Message-ID: <20250218170839.5427-1-clamor95@gmail.com>
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

Add a mostly complete list of ofnode analogs of of_graph
parsing helpers.

Commits pass all tests of stage 1 and all but sandbox_spl test of stage 2.
I am not able to track how these commits affect spl, log does not provide
any references to ofnode_graph testes or functions

Here is a link to latest test: https://source.denx.de/u-boot/custodians/u-boot-tegra/-/jobs/1028134

---
Changes in v3:
- fixed missing reg property
- switched to ut_asserteq_str and ofnode_has_property

Changes in v2:
- added tests
---

Svyatoslav Ryhel (2):
  core: ofnode: add of_graph parsing helpers
  test: dm: add ofnode_graph tests

 arch/sandbox/dts/test.dts   |  55 +++++++++
 drivers/core/Makefile       |   2 +-
 drivers/core/ofnode_graph.c | 217 ++++++++++++++++++++++++++++++++++++
 include/dm/ofnode_graph.h   |  90 +++++++++++++++
 test/dm/ofnode.c            |  54 +++++++++
 5 files changed, 417 insertions(+), 1 deletion(-)
 create mode 100644 drivers/core/ofnode_graph.c
 create mode 100644 include/dm/ofnode_graph.h

-- 
2.43.0

