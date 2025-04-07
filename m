Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A897C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 20:04:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8702830B3;
	Mon,  7 Apr 2025 22:02:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iPdkHBiC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50B7183180; Mon,  7 Apr 2025 22:02:52 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 495CD830F1
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 22:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-391342fc1f6so4260566f8f.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 13:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744056170; x=1744660970; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vCyZRTYLDfmguNjxIS97kTyRoqTJ0HpdK6Xxma5aFOA=;
 b=iPdkHBiCexbzUD7tXt1GS+LKc9wTvsfkR4R2Dkx+J9OAt7/lGJB5WsFFPLSqXIM/+J
 Xzdyg5q4Cedm2cSRegFI2SfEffAk/7pmoIDnA2zabAMb8+tUJ34joqvVQGgPHA/POkBY
 o/OwY/d76CbfJ5gnNGrJGpl6AU4XdfqoMRyXYKNnOzwN2PouxbiBqhaPZs3Oj+10U7Po
 ja1tYGnqy8jBEjl7HTEzP0PEED22opaEKlV/A2gUuPLIt6QXIF0rlPCa7NJSGA8QX5KS
 Rood84De3wusrW1q/9saEs02m9g+pat5YoCYsa09EJSoZBxLPaCDJkQIvpyMjkWlEczO
 MUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744056170; x=1744660970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vCyZRTYLDfmguNjxIS97kTyRoqTJ0HpdK6Xxma5aFOA=;
 b=nvytwBdbK9xu5D9dnCXpfZ9QTn91ZKxv4s8JePpEP3ya4+YwWtWQDn/v700kqNcnwz
 SvCYJnR6XQoTFibfvr2zBS+J0Vcnd++epuB2zFBvCFDWmRHVwpSnIWKFkgqe1pdaHJU+
 PVidqu7AKbK144fJbO3O9Lr0c/nMC9T9XdB64iUkxfzckkB7yx3hnMB5nsGxp/ntXJVt
 5h9Y6HQwC+ic6+1e6DnSaujwFqnuIcYjveIfgman46TsXDpoG0GwwJ4SQ2/DV4uueIEV
 aVeyaDe1fYP0Mn1+c24ttnfj1urPLjPk2VFyiEtdlscN/tZTpeM+krRMWrsIA52fjaw8
 u6oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyB8pYuMV8l0dSCumtVWLN7uGGFHTm+gldFzKA3+LZpW2O7+SqBYGBPnuUeZYnLVvHIUnIwro=@lists.denx.de
X-Gm-Message-State: AOJu0YwxmKHQssNx2oveLCLEhuHcTva6zftxr1sRCALEeCIopl3t1hZ1
 bGBzzrmz/A+iBshg4yDTtwr33G4dqOs3W0nqZVBeq2RX7y4kOh1d
X-Gm-Gg: ASbGncssmSO5NxPNGREOp5k9oL1a4QmuOOgeeQ7X0N+9MPH0KoCcIrimZGc4Qo9Uw0v
 vHbyM/eN54KEqXmSAempE0a/kD5TzJJsprIrRguI238j7li+DS1JraG6Xhozh3oq5PepOoeiht2
 CYDnIH5rtKvtpSRHBq8EQpR3yHoLMh9+a6WR9W9Zq4S8PyucJj7qClSIovYaAOptb9ZNMIqhGrC
 odXyfiQVWikYuS2V8LWWThKUF+2EaNDN80PhEDPe8J661VVDk3G2Semm3YW9x0yG5ImuVPGqtgG
 FlaQ1ciOwlRuTDr74ZfG7zA4zl/aZe8yOaUjyumQRRDOxxZAyghxK7J3NDQBWM1XjKNthaG/Jw1
 Tb9hn2ZmPsbHAVg==
X-Google-Smtp-Source: AGHT+IH5wKfstEqHs1vEEli7JOdFK8BGNabScUTRyYD8LFWSCrLPjWm9UNgJt8qwQkdLggMcwhIxJg==
X-Received: by 2002:a5d:6d81:0:b0:391:2bcc:11f2 with SMTP id
 ffacd0b85a97d-39d0873fccdmr11471469f8f.1.1744056169693; 
 Mon, 07 Apr 2025 13:02:49 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-39c301b9d55sm12723354f8f.42.2025.04.07.13.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 13:02:49 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Bruce Suen <bruce_suen@163.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 14/14] configs: airoha: an7581_evb: Enable Airoha SNFI SPI
 config
Date: Mon,  7 Apr 2025 22:01:58 +0200
Message-ID: <20250407200208.25594-15-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407200208.25594-1-ansuelsmth@gmail.com>
References: <20250407200208.25594-1-ansuelsmth@gmail.com>
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

Enable Airoha SNFI SPI config to enable support for SNAND flash.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 configs/an7581_evb_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
index fa41a4bca97..c74247e13db 100644
--- a/configs/an7581_evb_defconfig
+++ b/configs/an7581_evb_defconfig
@@ -78,3 +78,4 @@ CONFIG_DM_SPI=y
 CONFIG_SHA512=y
 CONFIG_AIROHA_ETH=y
 CONFIG_MMC_MTK=y
+CONFIG_AIROHA_SNFI_SPI=y
-- 
2.48.1

