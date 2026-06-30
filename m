Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF98C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 12:55:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AFDA84A4F;
	Tue, 30 Jun 2026 14:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QPiBTYpM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5827784A5A; Tue, 30 Jun 2026 14:51:27 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FE9084979
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 14:51:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-47122683cf3so1783863f8f.0
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 05:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782823884; x=1783428684; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T4FJD50kvPybgstDDX7AkfAoA21GWnAbo8l+EGc2Y/0=;
 b=QPiBTYpMmBGCgl/Sqs/8LDhIQZYjmui05DL87a0PIPEs9Zhk7hdEjWVZyeovRxvRkF
 e3juGmUAkovc/ijrvOzAlMq5W98kfu/ma4GMNITlaItdFD+0NYCdhkYLRgZgCxiDket0
 qsAKeKn/9zt9SzWpqlVn/29d1x/b/LrFVTQ/m9HQI7sB6aZk2/CqeyJiy5zIy1s2bgI2
 SHB8JkybZ7c63ejxsdW0QQEkPKEMcd/EDOKEfvxmtV0ZVHjNQTABUQfps7DJdhntF5Is
 t9mwDMg4l/Vk1b9HYciPWml++rQ4IPCQ1XFSBEa0J0JzXUpZUYp9P+7ZNRHpKta2gqDG
 n1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782823884; x=1783428684;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T4FJD50kvPybgstDDX7AkfAoA21GWnAbo8l+EGc2Y/0=;
 b=Xk/HNtelf5F2vuVEEWHgs78d/LqyCIWv1WJx//VwMXvyE2LDQtHHxBSPDtmjpqBR2G
 fAC1JziqrQ5/hGWjPpap2iDEX7j1FnJAv0B6YGva7FfLdVmdPaF9YtSqiWdgc88L3Fml
 GkxVk41ms7ccMXalLKnBfiAyiz3wwxQn0qnGkdvTSjxlrKMabtnGenBpyUFgCJuky56f
 V+u5RDluqqnyKn2Ih0lGXRU08QB2aImZ/eHS2n75DIxLVTB6g4lOtGr8R5awGTBAynoS
 tKfBKK1UmUKtS2P4DKyayKsx3EXJmNk1VaXeTfMvXj1s7E0cEDS/qfeUGhkTCgy/c2D0
 ZoCg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoTrNBdO4vVr3Ix9A88LCNfQQ/PH/Rx30ZmHaVwdhDEwdJEnWoVIFxPqofcEqvkvIq8q/FtI+w=@lists.denx.de
X-Gm-Message-State: AOJu0YwO/lqFcNBo4XUMvpqwd6UX7A7Gfm+gFbQJD9nQ8Df8CRD7qpQh
 F6Bmi6lXyf0sSnBQL0/O/qwtrwK8FZP6xmcx6sEIHpMKey92bbzhWtKXJEVMv+EJM7M=
X-Gm-Gg: AfdE7cnmk3EpXSW39wiUzxQaSe+3la6cpHnf57wcD6tN2b0t4g8+IJytrDnSkrdueZx
 lo4BDG4YXXsUVRdf7IAqghDYwTWor1I3pL6LoZj8d2ckYFx9HvgrgJ2tnvexWVQHXUxNSSqVsiq
 IuQsAuCbiRbN1Ai/j+yHvCKPQi1StPj5iCVe1uAw3RKerDjIhYLv/lSOubR+Eq5ya63yEm7R9xf
 m3Rgroi7jX/EvB1R0v2EBZh1t4I9NPNST9drmZufdIRYegL87FShhK2/VeF40hps6Z3rbmgB9h2
 mYSPhIMkxRGl+R4HFG3DqAWqtq/v4z+VEze5ERi2wnFMRZGSdn06GmDT1s/0t69pgKF+CxSiCsN
 UrPvBSeYJ862jQc85fvR+iAAXFc50mxMQp9Vj8eo7n95gpr4KJhxvoAVq+5UyhqtLXMMnTYCJ5g
 YTnUwcHqVyQyIPyjVoH4Fhr77ZK8nFZNkU7bdv4Q==
X-Received: by 2002:a5d:5886:0:b0:475:f0f0:9eee with SMTP id
 ffacd0b85a97d-475f0f0a144mr2718953f8f.51.1782823883732; 
 Tue, 30 Jun 2026 05:51:23 -0700 (PDT)
Received: from toyger.tail248178.ts.net ([195.76.196.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-475643ce016sm7676494f8f.16.2026.06.30.05.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 05:51:22 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: Sumit Garg <sumit.garg@kernel.org>, neil.armstrong@linaro.org,
 Luca Weiss <luca.weiss@fairphone.com>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PULL] Please pull qcom-fixes-2026.07
Date: Tue, 30 Jun 2026 14:36:59 +0200
Message-ID: <20260630125057.100816-2-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.54.0
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

Hi Tom,

A last minute fix for the release, the UFS controller on the new Milos
SoC (used in the Fairphone Gen. 6) needs a stub driver for it's ref
clock (similar to SM8650 before) and a handful of other clocks to get
the UFS controller probed.

This change shouldn't impact any other platforms.

CI: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipelines/30574

The following changes since commit a3f393c02cf10f44310c6ddf3dedf354c2e877a0:

  Merge tag 'u-boot-imx-master-20260627' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2026-06-27 14:09:17 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git tags/qcom-fixes-2026.07

for you to fetch changes up to e4f83e403ad4f7b6c08ee83378e4887aaa153b1a:

  clk/qcom: milos: Add TCSRCC clocks (2026-06-30 13:04:59 +0200)

----------------------------------------------------------------
Luca Weiss (2):
      clk/qcom: milos: Add remaining UFS clocks
      clk/qcom: milos: Add TCSRCC clocks

 drivers/clk/qcom/clock-milos.c | 73 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)
