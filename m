Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 847C4C369B8
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 21:18:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E011181F7E;
	Tue, 15 Apr 2025 23:18:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NlxMPq7Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79E06808AF; Tue, 15 Apr 2025 23:18:32 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E9A5808AF
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 23:18:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso66316525e9.3
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 14:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744751909; x=1745356709; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=98aEjzoxoMJoGkG7Yru4U6Ly1/QE8ScrxPks+qRCVTQ=;
 b=NlxMPq7ZMQo/OY5slt0pCVs6v0X+jGvZc77AO0AjyVGj0yz0W8oAIQ48Vc6mU0eIqj
 KoIAQXrhHkB9zLM1r5zbApKx/Em6xhRoeIakhLcLv/+YBYKaDlyRtFPzjlIYRiE5KuZ6
 SrmtK0/wAuVdYQIaZdUwq9U8h9icXQLYd3N30y1+KGY7WtjNvNbo7OTmMueWNtCrKD4N
 gyIbLcABUK1ntmUMi54cbUSIwUyRy7j/i2CPLlwpqzMeLVc83CDE7teb+M4LubvSsa++
 P0vUs5Y3r1a6ZYu1kQpMlIIzEvViKTs1fBMgkLRycgAtz0aqoyQAosehA8e6IfIDYtqr
 kA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744751909; x=1745356709;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=98aEjzoxoMJoGkG7Yru4U6Ly1/QE8ScrxPks+qRCVTQ=;
 b=Gnd21nG7ZGuGHmjJILjrxWhtO/rOegntR8BRpcLvDYN5gXzTjYtx0OxzHieXbJJKpT
 kuP6fK/Q7gnCfOrtUbDHt3dhSKIrhQUEG8PrwtKpPl6Yjf5D2pDS/Mpsnvkf5ld1Sd0Q
 BR/xNgjoh6U06Ymt+Qc8NtuseBOFbQLp+iM/noJvkkLNMdV/sM9mlXWWkQzOR9LQR0cB
 XEIPmdXWpMRJXt+ZEDmbGCAGDD2cKzluCZc7cLcANNw0P7EhdbDfdCtgi5EOXRefTgg+
 ynj7EixzrXjQajjqd+x+ROnZc/hSTrLMGVanUQz5HD21BXgdrD9+RaHrZ+fO9tMxBPs+
 0UXA==
X-Gm-Message-State: AOJu0YzTY6f6TX5r0bDruaxX4Wmd9/3Zo6bydtL3ZFH4Rm9GHdccwC0S
 RKjOHI//PwC/HH+gEPOdhmU7LTVuW3uZqoSD53iY6+Am7UnWWjcoJNQhHGQUoq++Y60jHI4d5FY
 Rl4o=
X-Gm-Gg: ASbGncu4ht6dcsyz3sKFVUYuzBCeja/cp2mJDHaQL+N/4ARPFKSgip5ge0pneeMbs22
 FFkmSjOj2TivtjIpPXdeaVGA6evpgyTCiIorKXv4PXkaiHz9H8HcJBhF63bbzMnzc0C4DMBun/I
 7X4noknbms+/FAtC7Hpu0rUj6IGYv74+2Q9ugEUlKTfXs6vbDJ4aCguHVc4+Fo4/U6cANW3Zr6G
 y/QuKnj+D4imU5XFaWf5d42C27pnSaCm/9rn8GG7+jzXl6TvlCrPvO7jcv6wJncZI+/pf0P6sH0
 81GaMJW7xPT+4tdu5mYsxrf1kEv5+xM4zcj/ECRWaiLKtKWr
X-Google-Smtp-Source: AGHT+IFM+m/xv0G8eA2MVAtBP7sn0SLTb1kEsVPl5fzG6961T3UiMCMYjaHEVkSRmQ63xj9gi06hHw==
X-Received: by 2002:a05:6000:381:b0:391:4052:a232 with SMTP id
 ffacd0b85a97d-39ee276fd0fmr643496f8f.55.1744751909554; 
 Tue, 15 Apr 2025 14:18:29 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6ebc:6ce:770e:95f9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf43cce3sm15530917f8f.74.2025.04.15.14.18.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 14:18:29 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Boon Khai Ng <boon.khai.ng@intel.com>,
 Christophe ROULLIER <christophe.roullier@foss.st.com>,
 Hanyuan Zhao <hanyuan-z@qq.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mario Six <mario.six@gdsys.cc>, Markus Gothe <markus.gothe@genexis.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Philip Oberfichtner <pro@denx.de>, Ramon Fried <rfried.dev@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Romain Naour <romain.naour@smile.fr>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v2 00/11] lwIP sandbox tests
Date: Tue, 15 Apr 2025 23:17:35 +0200
Message-ID: <20250415211819.1254435-1-jerome.forissier@linaro.org>
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

** Note ** I am resending essentially to have Simon's R-b tag on all
commits in patchwork; no review requested. Sorry for the noise.

This series enables most of the driver model tests for network features
with NET_LWIP (test/dm/eth.c and test/dm/dsa.c).
- Patches 1-4 fix a few bugs (device selection) and add missing features
(sandbox timer, restart support) to NET_LWIP
- Patch 5 decouples the sandbox ethernet driver from NET
- Patch 6 adds missing static IP addresses that NET_LWIP needs
- Patches 7 and 8 update the tests to use a common interface to send
  ICMP packets (do_ping(...) instead of net_loop(PING))
- Patch 9 enables DM_DSA and the associated tests with NET_LWIP
- Patch 10 adds a sandbox64 configuration with NET_LWIP=y
- Patch 11 adds that configuration to the CI

Changes in v2:
- Rebase on master and therefore drop patch "net: lwip: do_ping() should
  return CMD_RET_FAILURE when no device" which is merged already
- Apply Simon's Reviewed-by: tag to each and every commit

Jerome Forissier (11):
  net: lwip: fix initialization sequence before a command
  net: lwip: provide net_start_again()
  net: lwip: add restart support to ping
  net: lwip: use timer_early_get_count() when CONFIG_SANDBOX_TIMER=y
  drivers: net: sandbox: add support for NET_LWIP
  sandbox: provide static IP addresses for eth{2,3,5,6,7}
  net: ping: make do_ping() available via <net.h>
  test: dm: eth, dsa: update tests for NET_LWIP
  net: lwip: allow DM_DSA=y when NET_LWIP=y
  configs: add sandbox64_lwip_defconfig
  CI: add sandbox64_lwip

 .azure-pipelines.yml             |   2 +
 .gitlab-ci.yml                   |  11 ++
 board/sandbox/sandbox.env        |   5 +
 cmd/net.c                        |   3 +-
 configs/sandbox64_lwip_defconfig |   5 +
 drivers/net/Kconfig              |  14 +-
 drivers/net/Makefile             |   1 -
 drivers/net/sandbox-lwip.c       |  85 -----------
 drivers/net/sandbox.c            | 240 ++++++++++++++++++++-----------
 include/net-common.h             |  15 ++
 include/net-legacy.h             |   3 -
 include/net-lwip.h               |  10 +-
 net/Makefile                     |   2 +-
 net/lwip/dhcp.c                  |   3 +-
 net/lwip/dns.c                   |   3 +-
 net/lwip/net-lwip.c              |  86 +++++++++--
 net/lwip/ping.c                  |  11 +-
 net/lwip/tftp.c                  |   5 +-
 net/lwip/wget.c                  |   6 +-
 test/dm/Makefile                 |   2 -
 test/dm/dsa.c                    |   8 +-
 test/dm/eth.c                    |  77 +++++-----
 22 files changed, 350 insertions(+), 247 deletions(-)
 create mode 100644 configs/sandbox64_lwip_defconfig
 delete mode 100644 drivers/net/sandbox-lwip.c

-- 
2.43.0

base-commit: a08425586799374ccded78eb5fdef6e2235e1ad9
branch: lwip-sandbox-tests
