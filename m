Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692FCC2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 15:15:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C77C982E31;
	Wed, 21 May 2025 17:15:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZmXYcAgl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9613882F5A; Wed, 21 May 2025 17:15:53 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1651F82E0A
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 17:15:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a366843fa6so2837330f8f.1
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 08:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747840550; x=1748445350; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pQAsiMCLgmCmjjkqj1IELtUevZ40uVlgd7V9cqkrego=;
 b=ZmXYcAglf4YqAmYLKGvtKB4bPPRKZIelcVYRwfIfRAjmjaB4nbW8St/yTBLT0XvQr2
 N8OSdEUrIzs/myEeeJxxnrueYxTzmByUJiOBgnAAlWPeiO3p6xn1fzfbbjT+iHu8LRlz
 UxfLRclKZqFj9cdktkXNedn1yao9h0p7/EA60gnYiEfPS1bdkXYUnqKEjXWfJ+awasDG
 5LB+UZUSREJzzNyadLAEvw1FQnuCeqJkD6QbQyjBHhDcXUUjs661xFzAoNX2PfoDxUUd
 7QxquuPQ8DSyk5QSH5voK3H2cmOfbB+/3fIYM6Z7Yh5XLtr6Brvl4wAHPeeMaoTGzdY1
 LDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747840550; x=1748445350;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pQAsiMCLgmCmjjkqj1IELtUevZ40uVlgd7V9cqkrego=;
 b=J3Vf2j8S6Xm+f55lf+qDBGBlgZTjhYPKeL7GofN5htVn4l38Dtvwqm7frmGDH2fg8u
 N9YJKB9oYyCzDhPu+a7dLBWJiDH5nMJXGjcRda0UDbVbko24P74mMm8BB8cORKLt8VNN
 w2/sDeFFzU/7vlxCvCHBZeKilflU3yvQJmVtK/SQD0yEBmvloGQsJ/IjO5nrT0INF5lR
 4tvYIWxhw/Mg+41MSSIQdaPeMZGZKtzjYRs0551PBaTI0kSsEe50R38DoQjM2j4PD99i
 KOvCRbKck7kv8HjCISsBAk5wrIW/cQxSWdD7Csek01PYlJekB4VmF5DbVuWSKaliWqbn
 1QuA==
X-Gm-Message-State: AOJu0YzOkA31DWNn4PgNifMF7K0VzYoKu5LRFyx9y8EYVtjdbxCMvI4a
 B35eZTLx949PnAbPU1S8BIZtQwSN9ZSSbRb5r/zpFSQ35xL/XFiUeuNE1pJiJvcwvuxN1yNjlTS
 12iHwk+0=
X-Gm-Gg: ASbGncufhVN63APfzm5QyZKqCTMpIXjNYxBTi4IZeu0C2lWNhFeHpPa+hGcjB4568+5
 rn4KkoYYuX2TNq74Wli/DQvHSbHExiGfMgQi82Mn3lXCS+QYJzPKKvTau9fiG+nYkK473/YH4Gq
 oxSqovtcMvW2LjeYwP51VOKsTKemQDVZ9P9NQi1b49Zqkb8DeEia7FzYWck0AF+mYIUhOPvb6wB
 Q9GdHmdqX+e3xncy9wFGKeLKuRKtYiCfMmobY5CaqHM22c6QOLTfcVuIi0RTjAAcCHimnkY0Lhg
 3tPTMGftbaRTvECTdNJQ3WxDYSpt8Cki7mNu+cRIaylDX8bnaGZYm+Vz6Ykl
X-Google-Smtp-Source: AGHT+IGn1wWrrkfie6uuPenGSbsKLnRvzzsuRrumxT738mECxwXvYxJHn2etyMk0hgoMFT1lKOP/7g==
X-Received: by 2002:a05:6000:1ac5:b0:3a3:7bed:8020 with SMTP id
 ffacd0b85a97d-3a37bedc732mr6075068f8f.5.1747840550303; 
 Wed, 21 May 2025 08:15:50 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:f65b:56f4:360e:9fce])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a3632a2bffsm18505226f8f.32.2025.05.21.08.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 08:15:50 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Peter Robinson <pbrobinson@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH 0/3] sntp for NET_LWIP
Date: Wed, 21 May 2025 17:14:40 +0200
Message-ID: <20250521151516.16729-1-jerome.forissier@linaro.org>
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

Implement the sntp command with lwIP (CONFIG_NET_LWIP=y). SNTP is
supported as an app in lib/lwip/lwip/src/apps/sntp/sntp.c so this is
mainly about adding that file to the build and writing do_sntp() to use
the sntp_*() API and run the receive & timer loop. There is a patch to
extract a small bit of common code from net/sntp.c to avoid duplication.
The QEMU arm64 lwIP defconfig is updated to provide the sntp command by
default for convenience.
I could not test the case when the NTP server IP is provided by DHCP. If
someone has access right away to such a configuration and in case it
does not work, please let me know.


Jerome Forissier (3):
  net: extract function net_sntp_set_rtc() from sntp_handler()
  net: lwip: add sntp command
  configs: qemu_arm64_lwip_defconfig: enable CMD_SNTP

 cmd/Kconfig                       |  13 +--
 cmd/net-lwip.c                    |   5 ++
 configs/qemu_arm64_lwip_defconfig |   1 +
 include/net-common.h              |  13 +++
 lib/lwip/Makefile                 |   1 +
 lib/lwip/u-boot/arch/cc.h         |   4 +
 lib/lwip/u-boot/lwipopts.h        |   4 +
 net/lwip/Makefile                 |   1 +
 net/lwip/sntp.c                   | 128 ++++++++++++++++++++++++++++++
 net/net-common.c                  |  28 +++++++
 net/sntp.c                        |  23 +-----
 11 files changed, 195 insertions(+), 26 deletions(-)
 create mode 100644 net/lwip/sntp.c

-- 
2.43.0

base-commit: eeb5ff1a468b2303efa9deb2483b5edbebb568c6
branch: lwip-sntp
