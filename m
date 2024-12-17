Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB37E77187
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 16:01:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 553048022F;
	Tue, 17 Dec 2024 17:00:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Jjk8T2fE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6755F8022E; Tue, 17 Dec 2024 17:00:05 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D85680107
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 17:00:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so10006165e9.3
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 08:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734451202; x=1735056002; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0TYbeviN3Gl5UA/4oy3xhhzbJvw4nPLpSEYt0xrV1bE=;
 b=Jjk8T2fE7EDn0lK+tujGFnjlNZJNkVUUR5jfoWVOZSQ/WRxQgUbpAGa9qDpl9NG2HS
 Jag/PCctJT30K6sTPV2fr2dlR2DRiSaGT/1U0wWi8sxU/A2fayhmCiunxKvbCHrZhjri
 4Mgb++xv5feBWVfxBO+IoVe3tKOoNdUfXh1k2Y8yDZNoDO0cEumIDewcoA1LD8ysQPT+
 nOc1cyuuU2z0/9N+DA6WQrWh5ITAA9gy0+VxnokQw5N4v8iX1/bJrBQqRJtoiwq3BcOh
 FGfI2EabUqUeBHb55wpSRMFgLfOL9Ypdw/+rQKtDvkBZBFA7hUb6nGADbUFXG1N+HITe
 sWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734451202; x=1735056002;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0TYbeviN3Gl5UA/4oy3xhhzbJvw4nPLpSEYt0xrV1bE=;
 b=T27IqmzGOtKOGvhYZDpu6k/xpA9iJIN0s9WVBqEobY08e7P6IToq/+Fix83o4cyJ6i
 XY2eUqF279SJ9D796b3IL2knln4dJuMEsANzaV6esu/2qBC59t4E4NrgxzHk+77/A4cn
 Xs7Ylflspn8qchW9SrJkMCAwhswJMga100dI48faH1IZUF/UVfn4h0EGTIYA6RSTC8Ze
 c5CiIWV7M5USoNrYoFqDOlf9NOrLhIpHLXAFIsRUCXsf0o5Xs/dVV12QsuUkOO/ngE35
 idd4kLm6mGa0fGwjwQIyl6wai1bQ1rAzHSsX+GYcH9mKBw6h4sjiSddtBOQhBKUJjP8V
 qAUQ==
X-Gm-Message-State: AOJu0YyOyuZMTckMYY9BqavwpvEQfgy9Ng1v0kbeGeWPqh3e4jUMklrv
 HtEk6DEiiRdxh/HjSDGCJqqg00cjV6c/4/HInsa4gw+L0TloC9ygWfdVjrs5lZdwqnMRZKFOQRx
 nBOc=
X-Gm-Gg: ASbGncud7AMwqSRLbjkyaFLH3PNKHjaEIEwp3orvVtY8ixV2UHOBaBxzIgAYFskRwKF
 J6g4BZsb0Yi9qC73m0qdhhz8BsctbyTAr7SKFWLbbxgLaliDno5mBQRsOdHypyHlK780b+A8aun
 nF4t4tp0E3R1GyAB3tz5/OZuwn+Kh1MXQNAuqKMg85zyTJbIkshR2C47QmEqzTq9ktKhhXHPKgD
 IrW70chyCVW1AuBuP/RWfmXzzIMxPlwqPRvqghVezn05QWs9J+qiZLYfiEp70i2SA==
X-Google-Smtp-Source: AGHT+IE4ff8EPJjPfUH/YeSdG29/Nf6CuUbl+H6Ah3wBEJmLYtd3gjI6DyuI2zf/J9PAEQxZZLosAA==
X-Received: by 2002:a05:600c:6058:b0:434:fd15:3ac9 with SMTP id
 5b1f17b1804b1-4362aa97487mr126723815e9.22.1734451202241; 
 Tue, 17 Dec 2024 08:00:02 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c801ad9asm11390181f8f.58.2024.12.17.08.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 08:00:01 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH 0/5] Static initcalls
Date: Tue, 17 Dec 2024 16:59:31 +0100
Message-ID: <cover.1734448827.git.jerome.forissier@linaro.org>
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

This series replaces the dynamic initcalls (with function pointers) with
static calls, and gets rid of initcall_run_list(), init_sequence_f,
init_sequence_f_r and init_sequence_r. This makes the code simpler and the
binary slighlty smaller: -2655 bytes/-0.25 % with LTO enabled and -1344
bytes/-0.12 % with LTO disabled (xilinx_zynqmp_kria_defconfig).

Execution time doesn't seem to change noticeably. There is no impact on
the SPL.

Jerome Forissier (4):
  board_init_f(): use static calls
  board_init_f_r(): use static calls
  board_init_r(): use static calls
  initcall: remove initcall_run_list()

Michal Simek (1):
  common: board: Simplify array with function pointers with
    CONFIG_IS_ENABLED

 common/board_f.c            | 213 +++++++++++++++----------------
 common/board_r.c            | 244 ++++++++++++++----------------------
 include/initcall.h          |  43 +++----
 lib/Makefile                |   1 -
 lib/initcall.c              | 102 ---------------
 test/py/tests/test_trace.py |   8 +-
 6 files changed, 218 insertions(+), 393 deletions(-)
 delete mode 100644 lib/initcall.c

-- 
2.43.0

