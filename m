Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE78C369C2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 13:27:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBC7B82D32;
	Thu, 17 Apr 2025 15:27:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J97mT8Hz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E70088303B; Thu, 17 Apr 2025 15:27:31 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C725D82CA8
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 15:27:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39c1ef4acf2so525111f8f.0
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 06:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744896449; x=1745501249; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R7SEH6nJ8xB7rWVP/10oxAuEY7gkBPpgWzfowgTgTSA=;
 b=J97mT8Hzo0rk3T5vgBFaJy2lhj207fudFdKfWmUIOZ79ZRmUwElT+SjjYuNg5mi8mm
 Owu9fcCIAXWni7CMHp9z+7DdWZc2U6+nlUXJB+0MzYXfLzP+y0fi7xNqSqn4d8oIbY0+
 iHTLAbFACNhN5kXkkdoH4tfyikkMGPjKeCx2bDynIxsIEIyrrznbinETE0OLjfIcQnKx
 toyekmV0UiJ6zXcvz7gjbZQ+gR9lOZdUrxU0JmJDERu+HTcUGvT8E6DRqlwQaYsc/6Au
 9E36JtQ5dasgQ81Vy9ZMDFwnDoxwLyfvX9eubJNDrpr+4DglZMazFdU+uf4LbrKZBGZk
 13Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744896449; x=1745501249;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R7SEH6nJ8xB7rWVP/10oxAuEY7gkBPpgWzfowgTgTSA=;
 b=V2sl6hqJtwWK0q+TOJ2wyyglR1rAWh973NTh+UsDlLMxfyqQxRB/uPbmJFvkh7kYVm
 wQJVbt4pUOhGBGbWCgn4sjYxVkSyuhWB2JmPHDzwDDzMzpZfqdbxvM4jpT/n5Gz9nwNg
 0A4piOUTMYOkF1dqb6YycAyf/U3IkhN+VmYKflNXRtsywJahTvlpvuD8qGu5+upjVEez
 mVfIoxgHHax0P3q6RA8sP8lPrujDiPx21cGnDB1E3Dgx4eNFxvGSGo/v296hKqv0z6tq
 ASq5510FXHezaQOK1sKnXmg2H9ixyYxc07aYU+PDVxSb/Y4hyVEYTVPAhATH69xzGLQ0
 asSA==
X-Gm-Message-State: AOJu0Yy6pcDOBvpihs+DqyqXbMHV/yF0kIVYMOJqS2W5Sk4+PMkPXvFg
 Auo0HRXF8fqDJfk1WLN7ng2YNZN6Cw2Ml2jY49RVy3NSpi3mzscVI1qnyg8PJSCRfgUozgpbHIv
 ehDY=
X-Gm-Gg: ASbGncsvqiTN/01wTcQyRlEFhrkCI68rLpwD02bbYuoBMWMwBrj3YoeIJZEbAB2vYnb
 kPyRXKzPkDHlfOlbeU1bpHbbVa82ViA5M5UcAdgbY/NIPkGfa0XPU3mATVNQmzYDXLj7k0U0dcd
 VptdoneaWhjU0FKkV0VM3mql8cjFEJVyks0FQ+37OJ800JVxiyher0SvBgVIZ/apPzX0SOr1b6f
 +B+HrZqGMM4Bm8rTjX6bsRjp7AlCWPk4VLMJa5IqE5Ei5NFuAeuEFPJkR5ArNOCeoKKDNNmX4dR
 2lRTV/LKEbHwmksfZBzjp6MZeaY7kYhyJEYeWm4YAvIaApHLQWIrRZTRLBOP
X-Google-Smtp-Source: AGHT+IFSk39LPvb4Gi3Ls3pFeoCqOypaw5jqxYuTgbTGBjH0O404ctXgfLTYUaajjND8bM4whx2XMA==
X-Received: by 2002:a5d:5f49:0:b0:390:eebc:6f32 with SMTP id
 ffacd0b85a97d-39ee5bade02mr5500576f8f.48.1744896448955; 
 Thu, 17 Apr 2025 06:27:28 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:a07e:3f08:7eef:b036])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae977513sm19951605f8f.42.2025.04.17.06.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 06:27:28 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 0/4] NET_LWIP LMB fixes
Date: Thu, 17 Apr 2025 15:26:56 +0200
Message-ID: <20250417132718.2023555-1-jerome.forissier@linaro.org>
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

Two small patches fixing issues with tftp and wget when the network
stack is NET_LWIP and LMB is enabled. Plus one prerequisite patch
fixing a problem with wget that does printf()/puts()/putc() when
called from EFI which is not allowed (messes with the console output)
and a small refactoring in net/lwip/wget.c.

Changes in v5:
- See changelog in the individual patches

Jerome Forissier (4):
  net-lwip: change static function wget_loop() to be wget_do_request()
  net, net-lwip: wget: suppress console output when called by EFI
  net-lwip: wget: add LMB and buffer checks
  net-lwip: tftp: add LMB and buffer checks

 doc/usage/cmd/wget.rst                        |   2 +-
 include/net-common.h                          |   2 +
 lib/efi_loader/efi_net.c                      |   2 +-
 .../src/apps/altcp_tls/altcp_tls_mbedtls.c    |   8 +-
 net/lwip/tftp.c                               |  56 +++++++--
 net/lwip/wget.c                               | 117 +++++++++++++-----
 net/wget.c                                    |  23 +++-
 7 files changed, 159 insertions(+), 51 deletions(-)

-- 
2.43.0

