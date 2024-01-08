Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946F0C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 16:45:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A6B487536;
	Mon,  8 Jan 2024 17:45:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DTV4sYST";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ED3787A21; Mon,  8 Jan 2024 17:45:24 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7792087536
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 17:45:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ccbf8cbf3aso25629371fa.3
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 08:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704732321; x=1705337121; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MaAA3UtOoe4sHh8tqB/tXE0pZrOzRuAeqpwNAJRhb9A=;
 b=DTV4sYSTpIJAwmxt47oIooqPrQKsw+KYfyXn+d6IQnUbYkSlX7vs7O4hzE+c4NOfCO
 ApYETpGf0LXhXYybbnEHrMdosvrI8sS2SL/7XbLBwtDvRXEpQ8R4skNChLFGRq4bKSqW
 z5ZuGF2OcmG2z5nDniC36w/STgpu4RVSnF3eMdEMWpYIksGoBCjjONLMLIGJR5Ro6ycf
 J0jAjWikuiFI5is/0gzMOo3MBfTCdzvAoO2u9Sn8qbNQ/TU+3p6AXwsVuCMr8G0CMrSL
 QEHBFsvSQljP1Stc4oIR2cuTlMdebTMxm0Zyo2gbXTynDli93F8NP+ArNnILntUewbcf
 U3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704732321; x=1705337121;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MaAA3UtOoe4sHh8tqB/tXE0pZrOzRuAeqpwNAJRhb9A=;
 b=UeM2ygocgpaDk1nKx3xK5kSDoIuIeAgYSWvice7Bg6Icz0i7djdS0l6JVUq7Iv6HkE
 O76LP47p+1bGxeT7Ec2AW/uXiYR2fl0a35uAY5fplu2OqzA5yjLV0CbqsoTVRPFJmwsn
 mRrolBmvTcYaODUv60NBsRe7tPg+SQH4qnPt6Sn2+MKcE4lBM9+UHSkhT2uK0J3Ewf3U
 E17NEt7+rKGThXLx6f1RaR7jWi65VcGrp+7VQrU2/XxRE3XCeEawEycHGDOW6NZrEg8q
 GZW/N4zyrEM1gi5K3wtJHpOIvErBdkUYJo7d9XcOIfDRCljRy/kLMDR8kjf88tmLIJb6
 kcIA==
X-Gm-Message-State: AOJu0YxFIx7G1KRTxq5wryDdiVFvhkZ51J2wJpv59t3jJzI2IWB7nI17
 XfrOun4RVDIcvsT6/SXvROQ/2FSxN3EDOO0A
X-Google-Smtp-Source: AGHT+IEOuysecoUXuPG8xqUhkCNPrPVafgYKAXODhSHNQaaPISnqrvIStBLcyPn2KrhKTwGOfspUdw==
X-Received: by 2002:a2e:2a04:0:b0:2cd:3485:868e with SMTP id
 q4-20020a2e2a04000000b002cd3485868emr1764166ljq.5.1704732321296; 
 Mon, 08 Jan 2024 08:45:21 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 x8-20020aa7cd88000000b0055751515a84sm26684edv.51.2024.01.08.08.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 08:45:20 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/2] Simple panel improvements
Date: Mon,  8 Jan 2024 18:44:59 +0200
Message-Id: <20240108164501.4660-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Simplify platform data pass to simple DSI panels by direct
asigning in udevice_id struct. 

Support EDID searching in case device tree provides no
specific timings or device has different panels (like paz00).

Svyatoslav Ryhel (2):
  video: simple_panel: simplify platform data pass
  video: simple_panel: add EDID support

 drivers/video/Kconfig        |  2 +
 drivers/video/simple_panel.c | 87 +++++++++++++++++++++++++-----------
 2 files changed, 63 insertions(+), 26 deletions(-)

-- 
2.40.1

