Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0572C677C4
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 16:23:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03ED682B7C;
	Tue, 10 Jun 2025 18:23:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Mz18M/fi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4291D82B70; Tue, 10 Jun 2025 18:23:38 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30AFF82B07
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 18:23:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a4f71831abso5344880f8f.3
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749572615; x=1750177415; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kElFpxRBeyeZiY/aYu0982n1eQTM20vSv2BhBqSNe/c=;
 b=Mz18M/fidmvZiZ930LbmBQIOW7sQqbQZN2a/W9UmRPI43dRlmMLWQrDxvxb9NTlaBN
 hCs6Ssw9tNZ9NVtYt05V9vFj06JFG6nTqs77+bZior/MPdYqXlJUu2+TXD7dnPnWeibB
 7aMWoRZtaaTB4R344qTE8i+t8wJ6ihWThBTQTwtHwYfZQcrmgQOJLYSqmw6KHWRsu7D/
 3XxhWgj9M3yahQbrNqSoyRyfv+6u4hHySua3lZ8MHkF1hHu6Y057XIBH3T8ady+VUzBK
 9GQ2mIhVvXRNA/dwBoRmi6BKUMHbjbhJwAGjukOOVf/MZ89cCpB2ITkf1bEFP1FiGIaD
 WpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749572615; x=1750177415;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kElFpxRBeyeZiY/aYu0982n1eQTM20vSv2BhBqSNe/c=;
 b=BeRJEUMa/zExKn+9BZJ2+NG+NljkAjOUVsqZm8eqih84jhwtPcY9Q4Lj9fCIHrj2sd
 lIeluCzb/pjTMV1upmSKGqJdbcKNHP4XmuBETW7o0d+5zX7P5KZlV2PssXj46XHrW5Mk
 KJLoQPeSYGzL+Tzvvx4PYCQkvqvyQAk7PoJpazbRCcoTY6nre6TdO89symrKideUUX0q
 UIfEKcpcRDSNh2LY/u67ASbGRv10OjPMutWoG3dRIf8p8W9mJV+OFAHsRql3VUmPa5Ni
 kuuBYo9tPu/grRnDpgll3ricu05FI02TtYDvxObOQ2sXupv9Ir08wpRPJqjAotMoUwu3
 b3aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTeMg4KSN3NRY/c0KA0IXRGsIkxFtfMRpdEQ0N0clwTdNAfMbI5UWHG9dGIj8mXfNb4Bk06DY=@lists.denx.de
X-Gm-Message-State: AOJu0YyMwSeFjYJb20erPUQ5yLBPBsJ6pqQaKEklXZcltrpVTa3FRef7
 cEYeQe5XllNnxtXxgFX/WaZHPbz8yZGxm/brQ7Cwy8bmXDbIb+GZExo2j7PJ3BFxy7I=
X-Gm-Gg: ASbGncsGLij4sPtLMVfAa3JDJmvirU6pj7HXLczJ0S8utVhlkfAwMaQ07+k/arbww9H
 KL1qjXJSOyQH/Ma37+yzG+gI/HXFP+ZVIOYxvyHMleJq9AkwHM9VvfH7bTl2hOggjhSw0lwoifX
 4CTQQ0qil2Enju03Lp73ydbw6hAvst3JjF8Da3jfT4TUQpIKv6wVPmD/iBLAnhNfJPHYzRLSKXY
 z16sL+sVed/ov7qWfYbjLthX1EsU3Iokapk4TJTmJh4CJcCGLTVVV9Nrv44JGrZKM1FVAqpiWhC
 JanMlJYb9JlCP8VF5P5iaLFeXNurQqtvTLDbLjoGAjsmRnrbnH0OzfqNiYx9liE39+ky4A==
X-Google-Smtp-Source: AGHT+IF5ODjUnDQ7O89ucJrF6HZFhEMk0Xt4Hg5i7TZy3WEe7h52OmDUuBJGCfMUJNIknJ62ugYbjw==
X-Received: by 2002:a5d:5f48:0:b0:3a5:2ef8:34f0 with SMTP id
 ffacd0b85a97d-3a53188da81mr15844663f8f.22.1749572615599; 
 Tue, 10 Jun 2025 09:23:35 -0700 (PDT)
Received: from toyger.lan ([2a01:170:117e:fc:3626:366e:4bd3:97c8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5324364c9sm12962890f8f.51.2025.06.10.09.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 09:23:34 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH 0/3] Set fdtfile variable from DT
Date: Tue, 10 Jun 2025 18:23:32 +0200
Message-Id: <20250610-b4-fdtfile-from-dt-v1-0-aec4df0fa53e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAARcSGgC/x3MSQqAMAxA0atI1gZindCriAs1qQacaIsI4t0tL
 t/i/we8OBUPbfKAk0u9HntEliYwLcM+CypHgyFTUpURjgVaDlZXQeuODTkgjVw3OQ1cmQlieDq
 xev/Trn/fD79g8IVkAAAA
X-Change-ID: 20250610-b4-fdtfile-from-dt-0bd7930ad62c
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2383;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=ozKJJwXEV0KLO87HQIPcppUUKe45latOQ6lKC3s38ho=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoSFwFcGCsTmdH01I6nHcjwDAF0HPOiEuyMsPdp
 eOC291Ig8+JAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaEhcBQAKCRAFgzErGV9k
 tqnKD/0cRTI+fVXLYhqqhwxRQVtcgKhUGDIhz8KAJk9NnZUQGY43plzWwUjUYsC3cHJ7BUU8lCH
 CTwTcawaNfT3qZ6AO+VqrvSGXO7rtJxucZX7tvc0Iv0AqwhgI8AkcBWbtNTP0JZLHWTz9Keoa3l
 0y72WJR+ajXo6O/znWiijPj+OnTeI33ysojGe3Q2zYFmfGUaDNI4LYb1PDNfNCiPwK6O85Ml/p3
 pXJebSiYhIP7V4+xQdq41RlHy7eVCThPe9F3h+xqGVGE1rzpmadqyEnBw+H9TmZYVXm5+LpEZEv
 +7OBlAI/GWM/r3lmRGIP8CuBJzMz/ZnFtO2ub6fOsLl0DETIEFFeaVYBldShJxKtRpmOkeQiByn
 sUXMikqkPnbTI46thQSz6EKKmIIDJmJy1oTi/Ck35G7aKbVdp83f19GNsF4UndkXWLmgCuJW7Gv
 gJsMLtxOq1kBISNw+CA2Pf54fJntOawi0qSsqAbXWNnC/kd9h5l6wAzuj90gtI4zog2ozRvz8bh
 TsMJKz7HdS5iSWbTuEPcxfniYUzlhy/gSUmI/Tj54+2AtnvJ2tApSElmNx1PWM4yF8a3TqBB9OX
 tAVIfKP2EpqaRx0EGeMcMzWfldnqmu3s+AfmxrE43xO7elDWrKPti7TGxlI/mTOuObuGYLCK0Y/
 5vfIk7G7l1X+xLQ==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

This series introduces a new devicetree property in /chosen named
"fdtfile". This string array contains the upstream relative path to the
devicetree (e.g. "qcom/qcs4690-rb3gen2.dtb") and may in the future also
list the overlays in use. It is set at build time for OF_UPSTREAM builds
where we know the correct path.

Then we read out this property at runtime and set the fdtfile variable
in U-Boots environment.

This provides a fully consistent way to set fdtfile so that U-Boot or
another OS Loader could find the correct devicetree file associated with
the kernel version being run, since it isn't always preferable to pass
to the devicetree from U-Boot.

Currently, U-Boot searches some subdirectories in the ESP for the
fdtfile when booting with EFI, and uses it when booting with extlinux.
However today with EFI booting it is impossible to find the DTB when
there are multiple kernel versions available, for this we need to
integrate with the OS loader.

In the future, the fdtfile variable should be exported as an EFI
variable which can be appended to a devicetree-directory property in the
OS loader configuration to find the correct devicetree for the kernel
version being booted.

This will allow users to safely roll back their kernel and devicetree
together if there is a bug in a new kernel release.

Ideally devicetree would be stable for all platforms and none of this
would be necessary, but this is unfortunately not yet the case. This
series attempts to make the best of this bad situation by providing the
safest possible user experience.

Feedback is welcome on how to implement the EFI variable part of this,
as I'm not sure where it belongs. I didn't want to hold the rest of the
series back since I'm sure it will be useful elsewhere.

---
Casey Connolly (3):
      dts/upstream: write fdtfile path to /chosen/fdtfile
      env: set fdtfile environment variable from /chosen/fdtfile
      mach-snapdragon: skip setting fdtfile if already set

 arch/arm/mach-snapdragon/board.c |  5 +++++
 common/board_r.c                 | 35 +++++++++++++++++++++++++++++++++++
 scripts/Makefile.lib             | 15 +++++++++++++++
 3 files changed, 55 insertions(+)
---
base-commit: 87e02cbb78a2897d43db0f732e926b73d9c0823e
change-id: 20250610-b4-fdtfile-from-dt-0bd7930ad62c

Casey Connolly <casey.connolly@linaro.org>

