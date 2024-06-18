Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BFDC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 11:57:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86036882D4;
	Tue, 18 Jun 2024 13:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c+qAXd2I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61F2588271; Tue, 18 Jun 2024 13:57:34 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84227882D4
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 13:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a6ef46d25efso657253566b.0
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 04:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718711852; x=1719316652; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=94Ze6tFaJ5ul94+SDh7lAIZhe6d7Boc+Cq9dPBdSzD0=;
 b=c+qAXd2IdiJFHrv4fze1BWeqQ4JklBa4ab9QsMntwooj+NKzrbKaRPHN03ZBLroFPT
 AQ0QiOxh8/HMKSQeZaWBau3ZsgTWATQkjK2dbZSBAOvtR1CrpSh/lNRUZ/HrlEludOg0
 W8tm3SQl1cw4R3bk6wSIMZ22xEtQbyFJC6K/IarYbfFTPUVBMz3+bt9Nnl4bAcl/hmwo
 ElEwqMqqj3bAw3cGIy1opM+OtIrEol9N3o0HXqozTqQ1V91+OvZduLBcjeQ+Op/6tEea
 k6smdl23quyY5f2Z2CzC1B6/kb6QlL8YhZhB94msRZ+am1TnsaINKca5r0JGQQ7ug7Cm
 6x8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718711852; x=1719316652;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=94Ze6tFaJ5ul94+SDh7lAIZhe6d7Boc+Cq9dPBdSzD0=;
 b=h95XqJ1xDhIUHQP7fPngZMu7jkR+mwS4wj5H48j/1EgUniUI4pMeRdBkbHt97AuQC2
 3Qz50vRYNqxNHrDPKgrbIpWuKHsiRMaoTPpR++taCvw2H1/RRJKtWaPC+kvV917qycFL
 RAeDOZgXVNMaCcXMIQgBAxaSac2KJKHnsQ9pN++Ax34BNYxv7DXAGleaQN+XFKDbwutX
 qeW8U8Q2oO6NjteOEwCPsbNUapxQCsiE1x2P74Lmp6a+56KhxaZOitLCDfxkAwC/DRDG
 Lj60bV7tN1OijN2MW0jQN1UkWifuyksOjH+AfqWWCBsx5fDug2K8g9A3KfGthaziLilx
 FbPw==
X-Gm-Message-State: AOJu0Yz4UYAlQvQHUNWJVnnKllrjHuQqc4FKK6uqsEcQFQ8jgUkjzBA5
 TSKpt5/i+bkdUpGkUvO7wHJ8u9E5uGD1ZxGe2QyFB6SPM4IEeu2BqiJbKA==
X-Google-Smtp-Source: AGHT+IHahsFJMGPrB0xnmf9/qWk1zx/nwoznVE8//wNEwgfEsVmHUpFQpV+lQRBHjWWOBKYtDMwnqg==
X-Received: by 2002:a17:906:b00b:b0:a6f:e36:aba8 with SMTP id
 a640c23a62f3a-a6f60d398f6mr676050666b.33.1718711851802; 
 Tue, 18 Jun 2024 04:57:31 -0700 (PDT)
Received: from xeon.. ([188.163.112.69]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56db6759sm611451466b.63.2024.06.18.04.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 04:57:31 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/1] video: tegra: dc: improve DC id detection
Date: Tue, 18 Jun 2024 14:57:20 +0300
Message-ID: <20240618115721.41374-1-clamor95@gmail.com>
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

Use dedicated property to detect DC rather then use device name.

Svyatoslav Ryhel (1):
  video: tegra20: dc: use nvidia,head property to identify DC controller

 drivers/video/tegra20/tegra-dc.c | 6 ++----
 drivers/video/tegra20/tegra-dc.h | 4 +---
 2 files changed, 3 insertions(+), 7 deletions(-)

-- 
2.43.0

