Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66B5C3ABD9
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 07:44:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2185C81DD6;
	Wed, 14 May 2025 09:44:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MVTUxn4t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60BA6829E7; Wed, 14 May 2025 09:44:20 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78AF380107
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 09:44:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so4259075e9.1
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 00:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747208658; x=1747813458; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5crBh6AjEgqcB6cKe8aN1vu2AB/Iwjt6rDhZmFjYpGg=;
 b=MVTUxn4tBj9r7QtkXZZdkJcMm8u9Ekyt+as96sVVRTdRlLtdvGRCg6fpdQr/IgAcRw
 cNwC+sPINKOH78iQ2qRfD5zBHbdzvmNZlEt1cluxo5iHBBGhUFBRlDSlzDgdzIdmpXmE
 R16rkCP/ddDFt19IofmorEYM63xkeVbYsRmY35DADlPIw7Fi1tV/P9MmZxLMYd7YL6UD
 C5oNPif7zXeDYQbycLejBkGjccTjgZ86S+FmAb5gC6DAB78T3fr/5leoaK91Fe7v9umO
 wWPrFzJinQwkionBCSdQ8gDGJGwCtexVhErjW4khzjZoIQnEVEKNKCKEUJV5hx5Vjfot
 6SWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747208658; x=1747813458;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5crBh6AjEgqcB6cKe8aN1vu2AB/Iwjt6rDhZmFjYpGg=;
 b=QYMYFALHDfNW1F59Fs2iX/qQBMEKCZJ2Frg3Jn5k2p+7HqqeUwvpxeUCVRgyuF4rgI
 TXgO7qJrFH7cb8ObSvXAC0fnMa439VgJV6CizRz9F+Fo85TBTTj5Fi7gT57ijOoleEpn
 ORYCSiOEdnje53/1Mopwc6UE14oIzsQNcEM1TIqjV+OrBw8fivQdwXZ9HuCP41WG5GQa
 DRYFR4mAckOfKqWi4vxZYroGkcMoT2j/LIqGRIHMB2KAldNU1hS6Y8MfaTl0mbCwgM1w
 zJtU3965121bFW2nMIonRi7wN2F1IwqL75gXXI5+qAX6Rf49/CGgGXI0qW8Jeb6CqEJ2
 +uuQ==
X-Gm-Message-State: AOJu0Ywphx3XilxEfOQUwchvJ23VjO1PDQvm14u9fgQpyHJxXk0mEB4I
 EdSDSjgdb/b6mhKXUkLsgpYpsjdygZKnNHbVKKVliccOLEwfSxQNmqKpy6GyHOw=
X-Gm-Gg: ASbGncvU7XDdbfjorn0z1vpLe5U8wLkXUCDl6Yc8w+BRf+VBIaHnDgGKZIe8boPaezR
 jY3Zz+ifu0LLEjdWtSFmas2eM2ITHIcJCIaidxu8hbrU/7XLHdOOzvFMKd+QQyIC+73yilJRjRi
 C+/COEmkRUUv/Fi443kye/0kwUqTAIi2s/1E1iQKq78HOxlpG50q719OsYpqXfCtpmlGimCVIUo
 jLR5v2ShBohwyl5qSPVca2804kTb0g74Bgb8p53Xp8kIpUvNPPyp41vlGryc/mb96OQJba/papx
 mdYThT6IRm37LPv/rMbpgoz1bvs39KES7vsv9KshHwRxBw62xnt+LmybFsrJoA==
X-Google-Smtp-Source: AGHT+IF0rmScTwJgcCX0GhjqTg5jUPrwDjJMoKI3mGDTxIF7Ugh/TWaYbb99gNn1vnmNRsPB/Mq+VQ==
X-Received: by 2002:a05:600c:4689:b0:43d:fa5f:7d30 with SMTP id
 5b1f17b1804b1-442f1ada4e2mr19826035e9.16.1747208657591; 
 Wed, 14 May 2025 00:44:17 -0700 (PDT)
Received: from adriano.. ([213.157.19.150]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f337db30sm18085895e9.11.2025.05.14.00.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 00:44:16 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, jerome.forissier@linaro.org,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v2 0/3] test/py: enable HTTP testing
Date: Wed, 14 May 2025 03:45:10 -0400
Message-ID: <20250514074513.3562063-1-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
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

Enable HTTP server in CI to support HTTP tests in pytest

QEMU does not emulate an HTTP server, unlike other services like DHCP or TFTP.
To enable HTTP  tests during CI runs, start a simple Python HTTP server
on port 80. This allows tests that require HTTP access to run.

The HTTP server is launched on the host. For QEMU environments launched with
'-netdev,user' this means that the HTTP server runs together with DHCP at
10.0.2.2. For other test environments the HTTP testing may need to be explicitly
disabled with env__efi_helloworld_net_http_test_skip = True.

We also default `WGET=y` in `ARCH_QEMU` configurations so that these HTTP tests
are included automatically when using QEMU in CI.

Adriano Cordova (3):
  CI testing: add http server to CI tests
  cmd/Kconfig: select CMD_WGET if ARCH_QEMU
  py/tests/test_efi_loader.py: execute HTTP testing

 .azure-pipelines.yml             | 11 +++++++++++
 .gitlab-ci.yml                   | 11 +++++++++++
 cmd/Kconfig                      |  2 +-
 test/py/tests/test_efi_loader.py |  2 +-
 4 files changed, 24 insertions(+), 2 deletions(-)

-- 
2.48.1

