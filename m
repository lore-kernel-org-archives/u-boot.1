Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A67DC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 17:27:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 928AE886B9;
	Thu, 18 Apr 2024 19:26:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vyHqI+oq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9B2D886AF; Thu, 18 Apr 2024 19:26:34 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D35228869D
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 19:26:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3454fbdd88aso817027f8f.3
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 10:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713461192; x=1714065992; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hee65EIpC2V4d77ZgGX2p62UO991ymcdUjAytLH517Q=;
 b=vyHqI+oqfhHFwkG30uo+BCg4hJpHMWDutHwBo8UwYmK+HbivGGhn9BFG/8GFuZ22GH
 ZR8I3aScNI8NTjs4I9sN1dKA4DGJMaqS2khRBNHcyE7MpvpomLApMR22LBElXkMHj4Zp
 JXT++1bfVyrHm/2PGnGuw3pK/2koovFs/6vqUe1KDdE7BtKCiuKVxbdwtnESKEolyjg3
 3UBFr8IpsiXpxKlKdxLV6nlCmpZH0pfbuqsm5+BOsMO8bMU0ImOK2n+J8wcjVYZ1yMmf
 YFb12XvD8juEhwM/XvpNZ3kqs7GYBoQtARdpSkKhr5HwDHzGfUzaakLgd1btFzUfDrGH
 ao2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713461192; x=1714065992;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hee65EIpC2V4d77ZgGX2p62UO991ymcdUjAytLH517Q=;
 b=kwvse07WfyOujS3y093psGb1AtgSjBbA5PRCvKh+bTloi7dPm8Z9dNBGd5alGm0qAB
 ENBitsoYfHrkuSa13ycB3K+5ekn0bJIg0Vwm5mz4OCWatJouM6RrQKMjV4239R30qz+E
 SbAwxYNJDZ3JSG6wzxcd/o8yYkpp/EXkHNHAqbTFyVNrb8m2Wr8epfSYouXSIo4ckPlB
 n11KxssV8UPcIhPjyFTOK/HuffAQCeLdbx7iGCv5XDZVILg0qnj8HhzmfCDB5XeBuk4d
 b9mbpL2GgncU8xlx93F5y783kSDrnGkOZrBwIpwr8JrUn3MojvMQoiUnB7oJl08NqNhG
 eafg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiCwkxwUJr+LSMoidsIrEaqPdH7C6ebKzI0pc1kcv6vznw48dIEStFZlS91XrqFjj7zeXC2C0bE73IvJ566ZPtpfPciA==
X-Gm-Message-State: AOJu0YwGkNH0whQU0QYMwRJIWGKUkLout70S0BlDJprHYiBYIy1zkTWT
 8WLwEhYsbemNvp2kjF+aQQFSSXKz9CTlHf508ONkOsUDuo7qqmqWPdolg4rL93o=
X-Google-Smtp-Source: AGHT+IFfK4wXP106jp3dJkdPmWNJKDqOjId3IHg5rL5ZVN0XWQN7/7vg1eZgN2Q5yy9QnOdsBggLpA==
X-Received: by 2002:a5d:69c5:0:b0:343:e02f:1a46 with SMTP id
 s5-20020a5d69c5000000b00343e02f1a46mr2412643wrw.2.1713461192425; 
 Thu, 18 Apr 2024 10:26:32 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c19d100b00416b163e52bsm7166057wmq.14.2024.04.18.10.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 10:26:31 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 18 Apr 2024 18:25:52 +0100
Subject: [PATCH 9/9] qcom_defconfig: generate SMBIOS tables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-b4-qcom-rbx-fixes-v1-9-f5f19d52969e@linaro.org>
References: <20240418-b4-qcom-rbx-fixes-v1-0-f5f19d52969e@linaro.org>
In-Reply-To: <20240418-b4-qcom-rbx-fixes-v1-0-f5f19d52969e@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=756;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=04rYvVgrujXen6xBauiwx/qT8sudWdK57JfzlMz1wW8=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjTF8P3l2v513EfYLT/1Z1w/tL8w2uZaNWca34ekslzOm
 R1CT9Q7SlkYBDkYZMUUWcRPLLNsWnvZXmP7ggswc1iZQIYwcHEKwE0WY2RoODFn0VyTP9kqS1+b
 XbkruuMff8aMDZ/XtlziUdGwf868mOF/RslPZnGnkp3Mi+XuvV78XeD4yZNxXLn+oed5ttjyXJ+
 5EQA=
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
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

EFI initialisation fails without this, and with proper SMBIOS v3 support
in (and automatic generation of useful tables) there's no reason for us
not to do this on qcom platforms.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 41545fd72fcc..7919aeb9755d 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -104,6 +104,6 @@ CONFIG_VIDEO_FONT_16X32=y
 CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_NO_FB_CLEAR=y
 CONFIG_VIDEO_SIMPLE=y
 CONFIG_HEXDUMP=y
-# CONFIG_GENERATE_SMBIOS_TABLE is not set
+CONFIG_GENERATE_SMBIOS_TABLE=y
 CONFIG_LMB_MAX_REGIONS=64

-- 
2.44.0

