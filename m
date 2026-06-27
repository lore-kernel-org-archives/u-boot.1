Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8770CC43458
	for <u-boot@archiver.kernel.org>; Sat, 27 Jun 2026 18:03:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F4178460E;
	Sat, 27 Jun 2026 20:03:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nOVnwNf2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1A648467F; Sat, 27 Jun 2026 20:03:04 +0200 (CEST)
Received: from mail-dl1-x1230.google.com (mail-dl1-x1230.google.com
 [IPv6:2607:f8b0:4864:20::1230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0D99842FC
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 20:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-dl1-x1230.google.com with SMTP id
 a92af1059eb24-139b914bab6so2837300c88.1
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 11:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782583379; x=1783188179; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=v2pEcIU8Gy+4g3deQXv6e1JfEjHuBwhEnSZc4c7nQic=;
 b=nOVnwNf2yFma9oc9NaQhCwxHnDrZLhgq5tye0K2yXvjT7KEWVkK7NY5e3cW+ed7Rpf
 v0z43545Lf1oYuGO8eIrCkhtKIp2e5u13De+tFBJfPE4EvIjeuNsKrxR1TeOR5GKu48o
 6KpCCHn4shcb+3dG/2m5XSMBdPSnYmxgImhAN82az30Ak1trwp5MAEbrFRMIJHp0zwTv
 G4wgNaC9VljF0IRzKhG0QMg4VCsOscE6F0NMOF9mVnapV8LTtXBj56nSeanqP/dsG6zT
 onJ4COUxZDd41zSHF1eTVdvqCh6U5hIMxYgLo5kQMhJoc7Bn8cAwCcmwuXGWB5D91jjW
 y2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782583379; x=1783188179;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v2pEcIU8Gy+4g3deQXv6e1JfEjHuBwhEnSZc4c7nQic=;
 b=cat/1aJDd3SPIaDUj0iM2F91+sqi73Y8Irhpq03pof0WJBG/BySBm9ctCZbm4SsaJR
 zsPXS5VCnC+XUyb9KLpoO00Q3Cly6jOk3lqsWX65R34QC2IC+42A7k/WyZbAMoNXnf6e
 R7UI8/9N7TX35zTZnh3rDXnrWcDmgJ+WXXHRoqzxNv6dVuGFBJ3KD2tLmYSNcgky37TK
 fA9QEYcxc/EBOzGe3cmhLjIsA8eJDsTcIn4aSZDd+lWCBbfFaoC17oR7SYv/fzgEK5e2
 X83VaAbIZaU5ZASBMpzHXjIy5Qf/LnUI5grWc6pUg8jGaAye1piUYVZJYAbwDQeYkt5d
 T26Q==
X-Gm-Message-State: AOJu0YxWoj3V/+KWkKDxHrxPOqmItwT69sGEFhWRhvwbUNctjPsGe/dB
 z9R5S5UuMRv+5TIfs8T3hzTPqiQlEw9AFo0ozNz8of4lwfu04MdwuGIF
X-Gm-Gg: AfdE7cmdCeccLbm75dFWNXrSN9/RZFt71zVrG9nyF4joTlJC9Xn7wDZ/SSBNBWdJTKL
 xCNmxWXaoqvvmuWWxUR1DX1BAF/jE2TQ6YoM60joXvxHHM/d2AD1KzA5gbegegtkqkkED5qFJsO
 uV9bPMk8JnngwonhH5IqFF/uRYH6HrK/oWNSlL0HlqB34pcJ2rzjL7F8vCDIxOJxhZdMwfOYuW8
 9J0eBCxgoQ+Q+c9HcQPqVMnnA43H9w98POzLEsj8Jxjn70bV5z7UmNjvS4qYf0ckgY3XVMiydmz
 nlkwbpm5QDBN6rDCeLNCVFyY05LICrzWS9E5a0HtQtJ4nnpuiIjtDWZYOahTjJhl9YHws8Cw1B1
 nDedEQGNvei5n/bBNca/Mh4QB+rE+MjYxqL2VPEOsSKH/DqObeXGusnjuLcqP4lLAGKsAAJHVYq
 gH9qDnVlQNRuRq4Kiu4vGe8xU/5gY99nS0JkX0AyaTjuE6oqP37V/7y+OicHl3ZCLPYrUSDg==
X-Received: by 2002:a05:7022:60a8:b0:138:5049:cb7c with SMTP id
 a92af1059eb24-139dbbc8305mr9404167c88.36.1782583378990; 
 Sat, 27 Jun 2026 11:02:58 -0700 (PDT)
Received: from fabio-Precision-3551..
 ([2804:1b3:a800:24b8:55ea:47fd:ff91:9f95])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e78317f3sm15192167c88.9.2026.06.27.11.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2026 11:02:58 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, alice.guo@nxp.com, ye.li@oss.nxp.com,
 peng.fan@oss.nxp.com, marex@nabladev.com
Subject: [GIT PULL] Please pull u-boot-imx-master-20260627
Date: Sat, 27 Jun 2026 15:02:54 -0300
Message-ID: <20260627180254.3067829-1-festevam@gmail.com>
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

Hi Tom,

Please pull from u-boot-imx/master, thanks.

The following changes since commit 6902fb4c17faa375003124c451c2550deab5463d:

  Merge branch 'master' of git://source.denx.de/u-boot-usb (2026-06-25 12:32:18 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20260627

for you to fetch changes up to 9b41032699cf8f7c25c883f7c12edba350fed1d8:

  clk: imx: imx8mq: Fix iMX8MQ PLL issue (2026-06-27 14:53:01 -0300)

u-boot-imx-master-20260627
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/30543

- Fix MAC address representation on i.MX9
- Fix iMX8MQ PLL
- Fix SPL trampoline buffer for 1GB DDR on i.MX9
----------------------------------------------------------------
Alice Guo (1):
      imx9: scmi: use 48-bit MAC add instead of incrementing mac[5]

Peng Fan (1):
      imx9: scmi: Correct shutdown checking

Ye Li (2):
      imx9: scmi: Fix SPL trampoline buffer for 1GB DDR
      clk: imx: imx8mq: Fix iMX8MQ PLL issue

 arch/arm/mach-imx/imx9/scmi/soc.c |  75 ++++++++++----
 drivers/clk/imx/Makefile          |   2 +-
 drivers/clk/imx/clk-frac-pll.c    | 199 ++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk-imx8mq.c      |  55 +++++++----
 drivers/clk/imx/clk.h             |   3 +
 5 files changed, 292 insertions(+), 42 deletions(-)
 create mode 100644 drivers/clk/imx/clk-frac-pll.c
