Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B26BC6FD1F
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 16:53:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76C2887E49;
	Sat, 30 Mar 2024 17:53:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cRLaPfvS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E848B87E95; Sat, 30 Mar 2024 17:53:28 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C31187D37
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 17:53:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1e0e89faf47so7434005ad.1
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 09:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711817605; x=1712422405; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uMn8uDtjq5k7k2oIgxnsB+oiIqK16EQxi+9XraBY9GY=;
 b=cRLaPfvSu9TdLFHe8L92GB+hLPdKgLKIVj/f/nqEeAZh8JoRK2Ti1TjFbD/B1YfdeK
 /ObQlnYgUoaz00KoOFt3DkMYTZ6J1+INeVPdTwC3DfRk97bYyHvlDJLcAoWshNeWo1iW
 7xVb+I8bfwMakg3ZkZeFcTR4uuhxMeVy8oCrLc4Fs4l5myzbBvWZBmR5fYp4qgvUDkCb
 odXuvjuJ9QZAR/A2wpiXGtt6zjPlreqyCcMx3l7JqJgV8wahveFtbsPR4h8IqZ6CSPRl
 8sR8eVI+9RoXa3+ERzpIkcuZZLEH2YCt42d+J7FtkszLqfuXAt9px9GCni/H4EsOI5eG
 l80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711817605; x=1712422405;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uMn8uDtjq5k7k2oIgxnsB+oiIqK16EQxi+9XraBY9GY=;
 b=g61xR/GKmM9lmbNlbv0U9ooonqE0Cv8SF4RGprWhmVOC7YlW41zEedbJcKuvfwUvFz
 GZi2XB0ZUOoJA9YJrvkxXIAqWIYmoSY5Btidw3pt/GQqMfLN1xOkhHhzjoEqIoQkeva/
 D7vQH5cKHDAnvpRTv8WND3YfIPvYp/Ldhnz5JyLVNxrObTStQrG614DIxfRRUjvsbnOd
 1x7vpMpN0AZZ8THyTsBab0ZFOt3+lviQDw8thlHv7Sop7h9/LPMhBVChvWo8KaokyrZJ
 AkEE2XyoChlTIBTpoQgZb26BgJpmJxxAmBVauZ6IyixaeBrjBEGDbxlo8caZLE/osaSB
 BJAw==
X-Gm-Message-State: AOJu0Yz6hPXSPLBVEKNM4dn/enGPYOO+vQOc3YOucIFLs5CoRVMTa+Gq
 GP3bCB9u4ibZM3N6xPJJtAyKEUKiWWhT/+pN/vK9NNmiWuX49/DYTbNsi9pT
X-Google-Smtp-Source: AGHT+IG+ByfRGxBc0xCC2/bjMBEUWvjgd1cV8SCcXZOiBrS7p04Iz0zo+nEKVGni1OIDaSzuOFf78g==
X-Received: by 2002:a17:903:503:b0:1db:ce31:96b1 with SMTP id
 jn3-20020a170903050300b001dbce3196b1mr6010572plb.6.1711817604940; 
 Sat, 30 Mar 2024 09:53:24 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3bdf:3f7c:9329:bd24])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a170903111200b001db5fc51d71sm5499413plh.160.2024.03.30.09.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Mar 2024 09:53:24 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20240330
Date: Sat, 30 Mar 2024 13:53:21 -0300
Message-Id: <20240330165321.2767621-1-festevam@gmail.com>
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

Hi Tom,

Please pull the following fixes from u-boot-master-imx, thanks.

The following changes since commit 9468bf3a69b05bda05adb06f954b089ace301afc:

  Merge tag 'doc-2024-04-rc6' of https://source.denx.de/u-boot/custodians/u-boot-efi (2024-03-28 16:01:03 -0400)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20240330

for you to fetch changes up to fc07cac02adebc87b69cd82f6ca6f0283d11cd5a:

  mx6cuboxi: Convert to watchdog driver model (2024-03-30 09:49:53 -0300)

u-boot-imx-master-20240330
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/20122

- Fix reset regression on mx6cuboxi and warp7.
- Fix Fix board revision detection on mx6cuboxi.
----------------------------------------------------------------
Fabio Estevam (3):
      mx6cuboxi: Fix board revision detection
      warp7: Convert to watchdog driver model
      mx6cuboxi: Convert to watchdog driver model

 arch/arm/dts/imx6qdl-hummingboard2-emmc-som-v15-u-boot.dtsi | 10 ++++++++++
 arch/arm/dts/imx7s-warp-u-boot.dtsi                         | 10 ++++++++++
 board/solidrun/mx6cuboxi/mx6cuboxi.c                        | 13 +++++--------
 configs/mx6cuboxi_defconfig                                 |  3 +++
 configs/warp7_defconfig                                     |  3 +++
 5 files changed, 31 insertions(+), 8 deletions(-)
