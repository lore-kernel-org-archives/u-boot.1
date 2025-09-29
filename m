Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A4BCAC5B9
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 20:39:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38204833E9;
	Mon, 29 Sep 2025 22:39:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jRjFccOd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4192C82A9E; Mon, 29 Sep 2025 22:39:53 +0200 (CEST)
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com
 [IPv6:2607:f8b0:4864:20::a32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0E9D82A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 22:39:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-54aa6a0babeso4440547e0c.0
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 13:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759178389; x=1759783189; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kEWEooFP+mEP+YiciZ2bfqPxYH100NyZVq3UrIc7E+8=;
 b=jRjFccOdLMn+6sqLIVmCobHVfMSa2LZ3AOFNxproGu8xmkxFXQRyCLv0jS3g2kBSlD
 mQeoobmMqpandc0ez5tK0fsY53rT6Y8rZCfYNazBz2DAp/ZJMgYhS/Tomxg15y/EzGo0
 S1cYws425ZZXTcSMzqW8ex+V02SO13dji7t8JMOxUYgzkHx60L10ByYlVWODSRX7VZoV
 yBu/FT2S/VIDDpqaFA7x4hvDmnIGh+XuZ23Qrk7U4jhXtY64PzMoI0zFKfLpM/YeSVIu
 jsLLsxyTq6tvkkh8yisYkJiUt5kRpg64Bus0cv9j6Q6ADBVJ688D76Kdm+BPM296+FXg
 LLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759178389; x=1759783189;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kEWEooFP+mEP+YiciZ2bfqPxYH100NyZVq3UrIc7E+8=;
 b=eVaizY2kiY/DZt8sXTe5o7fX3u+8Hk1ruW+L5HVyLZuMOsRLQIeTi/MNsMD/pIx7hW
 Ph1QPvTEevWJbdryfFQQGA85LW1jqM/nJTvJKoke26wExKL1U2mW54ykMQlUSbCB9KLl
 cUSN81LB9nV/LifzRj6SNekUmZve2R1b7MwTucciG8YNjIPly8ope1MnILAFQF0LrLRd
 1plHflGXnmZtYsNYSHQvncSNoEyAWESTi42lwj3RTlI6ps3+b424lhP8inLbdUrFr241
 D+egMGS+llqNg4hlkGSqJ2oN2Cujo4n7dBeoJNcUVwP6T6nfLunzAv8iSEDH1IIO1FDc
 kQ2A==
X-Gm-Message-State: AOJu0YxDk2rHykFwp94aLJUDG2Kq6HH9rZKcE+SGyUW67e3Ws3DQdurz
 VMXBXOPCAgUXZGBqNxufxSo2/w+v3Vy49M1WJlnm3SvF+TM9AJ/sY9GKHIFG8qQd019w6CfeMf6
 WJBir
X-Gm-Gg: ASbGncuOQ5sasaidV/FgvF6FnpDYOwip/y4k9fchVc4G6Yy8HuOmD8knDWSrmFtWdjb
 1RmhYCYjRtxOdEK9RjMeN4GaqsPoVYOlPDpgz1P6hVSlEHtp2ogbhSMGAPqvaaoEl86Rx1vcBc0
 mTaD3PRddQX6W+R/RMgLBdyoPm5yzFVBzI3d3tvdwKeErZQVQuSbMWbbmsIlxyuQm6GSZrkb5RX
 CDqHPb7qDt6uOX5/agVJb5kDlPRo45NT2jVVRHxAeM2/vAs6dY1JlH2EXo2ktEM8S58pYK5vt99
 fxxTeROhBPGQ+EQPxuGNphHfYgPTp25N1STN4KZFp7GqWG+I0InTYJPeRsf7VwLdv387KnV0exp
 XP5j2cDholRsM9DmgZ8Zs/4J9tdRWJFIADUJw99IXMrZ9Ki9uvo43WYHelFTNd7a3JZc=
X-Google-Smtp-Source: AGHT+IEEjJv212xLTPvmZBjgzBeTKpwhoKc+LbJLXp1jxQsGjhisd6O2OO5ST+YAYHHzJZBOpXnTrw==
X-Received: by 2002:a67:f70c:0:b0:5ca:714b:2dcd with SMTP id
 ada2fe7eead31-5ced714bfd2mr874573137.10.1759178389588; 
 Mon, 29 Sep 2025 13:39:49 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e.local ([177.93.10.188])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-916d1518f84sm2651076241.6.2025.09.29.13.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 13:39:49 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
Subject: [PATCH 0/2] docs: Adopt b4 as default patch submission workflow
Date: Mon, 29 Sep 2025 14:39:27 -0600
Message-Id: <20250929-b4-docs-v1-0-a56c1a1856c5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH/u2mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyNL3SQT3ZT85GJdM4OURFNTM4M0A7NEJaDqgqLUtMwKsEnRsbW1AKR
 0aThZAAAA
X-Change-ID: 20250929-b4-docs-60da5560f06a
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Javier Tia <javier.tia@linaro.org>
X-Mailer: b4 0.14.2
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

This small series updates U-Boot's contributor guidelines and
configuration to sync with current best practices around Linux kernel
patch submission.

The first patch updates doc/develop/codingstyle.rst to recommend the b4
tool instead of patman as the standard workflow for preparing and
sending patches. The revised documentation explains how to create and
manage series, run style checks, handle cover letters, discover mailing
list recipients, and collect review tags. This reflects widespread
adoption of b4 in the Linux kernel community and ensures U-Boot
contributors follow consistent, upstream-friendly practices.

The second patch simplifies the project’s .b4-config by removing custom
overrides for maintainer discovery. The upstream defaults in b4 already
invoke scripts/get_maintainer.pl with appropriate arguments, making the
redundant configuration unnecessary and reducing long-term maintenance.

These updates should make contributing smoother for new developers,
reduce duplication with upstream tooling, and ensure our workflow
evolves alongside improvements in b4.

Both patches were tested by preparing and sending patch series using the
updated configuration, confirming that maintainers and reviewers were
collected correctly and the emails were generated as expected.

Signed-off-by: Javier Tia <javier.tia@linaro.org>
---
Javier Tia (2):
      doc: Update coding style to recommend b4 for patch submission
      b4-config: Simplify configuration by relying on default b4 maintainer

 .b4-config                  |  6 ++---
 doc/develop/codingstyle.rst | 54 ++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 51 insertions(+), 9 deletions(-)
---
base-commit: 26efc940c865a04d345ac9d39f71746fc2821da6
change-id: 20250929-b4-docs-60da5560f06a

Best regards,
-- 
Javier Tia <javier.tia@linaro.org>

