Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C41DD30013
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:23:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFFDD890C4;
	Fri, 18 Oct 2024 16:23:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xbnHKpvf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C76DE88BB2; Fri, 18 Oct 2024 16:23:23 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7B97887D1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:23:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4315e9e9642so14028625e9.0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729261394; x=1729866194; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wHhsNsS3i0bNroY4M/t+EzuYUrvezlw8l6YJyGkvFnU=;
 b=xbnHKpvf9R7uFUqeuShCFfs09cEKhn6CpiGpxF9bVoFF9AKEmr4Ipj7ZeEdNa1IL3u
 GRfdbCHTj8f4HvQJJEZDnSFRW7RLEG72Ggx4EaNOQFaoFTrENxhH9JQx/siSCSaV/pcW
 rb4gvZx+k9MS4xHMY6VcmIbtq1bCMKoltzkoFgb3opQZXeiXmE9nP5Qxl8IS45ynREzx
 VYpabRVF1M8Ejn7Cld01iRBGCU55EZd1w8Sjaes+R3fXnrR/ikhXxJyfcjHzQBX+ibjb
 JuzUKYpWWroCkL0jmfyDCqHU6/qDPb7nnUfkeXB3N09l22aojzUQuG3wUBEjmNH4vbIw
 g8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729261394; x=1729866194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wHhsNsS3i0bNroY4M/t+EzuYUrvezlw8l6YJyGkvFnU=;
 b=RS1dLfDt5c5Ly3zx7N/ij4qpwgP7ZhvBaTWY/dRHfLqpZgMdhfT6mn1+zHI11NlNfB
 UR7L5r5U8m7R6XzKXtQWb6CFSNHXt9CWSZMuuxYrjfK/bHpV3sgY4RobSNwS257Vl5RA
 rSphYGJP+pyF5cMMRA8ixvMUms9IunGTiFXG2egrVtVwfAQiPSCPWJ8cpyuEsSEJkW2w
 QDMWg+6WxQxUPRq75iBuAJSc3LA67zMFjX33IUE6pk8dMG/SBYdjZSkqBbvqBoXs9t0l
 a/n8GmyE3vbTws4g/r+bg4ul84Yl4mYFAl7zKt5qcL4dMxcz1HwyhoqbTnQUXnHsSpUt
 diAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAAKQ6BctdE/M/45m6TaLyjF3B/ZQb6iIgwVMCw2ALLHXSh45rWdESRGgPVlg2XvHffckXw3g=@lists.denx.de
X-Gm-Message-State: AOJu0Yyhjdbo9LffRZDZd0Swa4dv//PdmBlmPxZy1GruS1glOtXSStD0
 1k2X/Qu9/WpPmCqXtCOHhcFeDsyfZfY22Cw2NdgiV0khYOacTIBay6+AYLgeUD0=
X-Google-Smtp-Source: AGHT+IEih9B4kf6F5FskqefLMvrge4okG2SSfwzx3e0bQ9SuaFC0G1wAyzmvNElPO8580JF5+E1PxQ==
X-Received: by 2002:a05:600c:1c19:b0:42c:acb0:ddbd with SMTP id
 5b1f17b1804b1-43161637396mr19666975e9.7.1729261394316; 
 Fri, 18 Oct 2024 07:23:14 -0700 (PDT)
Received: from localhost.localdomain (ppp176092143132.access.hol.gr.
 [176.92.143.132]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316067dc70sm28781665e9.10.2024.10.18.07.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:23:13 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: jerome.forissier@linaro.org,
	raymond.mao@linaro.org
Cc: xypron.glpk@gmx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 5/6] configs: Enable htts for wget on qemu arm64
Date: Fri, 18 Oct 2024 17:21:59 +0300
Message-ID: <20241018142235.715571-6-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241018142235.715571-1-ilias.apalodimas@linaro.org>
References: <20241018142235.715571-1-ilias.apalodimas@linaro.org>
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

QEMU already has an lwip variant of a defconfig. That defconfig
is also configured with mbedTLS by default. So let's enable the
remaining config options to enable wget for https:// as well
and test that codepath in the CI

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 configs/qemu_arm64_lwip_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
index d3d8ef16e668..754c770c33fc 100644
--- a/configs/qemu_arm64_lwip_defconfig
+++ b/configs/qemu_arm64_lwip_defconfig
@@ -7,3 +7,4 @@ CONFIG_NET_LWIP=y
 CONFIG_CMD_DNS=y
 CONFIG_CMD_WGET=y
 CONFIG_EFI_HTTP_BOOT=y
+CONFIG_WGET_HTTPS=y
-- 
2.45.2

