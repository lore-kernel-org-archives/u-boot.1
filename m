Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADBAC87FD3
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 12:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65FAB846E9;
	Fri,  8 Aug 2025 14:00:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GAq+o8Af";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDCAF846F4; Fri,  8 Aug 2025 14:00:27 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D809846CE
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 14:00:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3b79bd3b1f7so1020100f8f.1
 for <u-boot@lists.denx.de>; Fri, 08 Aug 2025 05:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754654425; x=1755259225; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6wilMPOCsdLC3ObspjZDUu226yHwrcfPZ8oAAml++zw=;
 b=GAq+o8AfMviwMTNe25mbUM2akqNmdxCwJuJopEPDuF8gSbujeMMsk2/CFbUl0hDO3p
 oI1gqWWfHcng0zislegza8sKr3j1tnOHR7pPlHmPBAls+AfvK3YVSQGoLTKUmCR36y0b
 JUKjEc74/6ztjRrBwB5X+5WMtBcl2tQlihAXOd3aYGowjmLMTlCexJTY63zEyjXN6eS3
 eLXF2z7atmo7o6r1g8MWgPwvhZediBWZpnbc6O6/mAocO5toJKhEa1Z1JeLtfOWURBgO
 ivsPldBDwfogqjHuDg+QMGSrn+Fu1zg6pG5W1dIfVKE6lUF204WkxqkqJVL3ehxLiu28
 l3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754654425; x=1755259225;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6wilMPOCsdLC3ObspjZDUu226yHwrcfPZ8oAAml++zw=;
 b=X7+q94Elh4o49vXbyJ7xzqhObwqzNqK3/0qYpLN7MDwyslH9YJZ2r5UXoNs4KtdoG6
 G5R7UWuVRR//+OO6pAYjFsnUtDm464B3Q7ssT0t9zvn42dsCcrZanbuWidysG/nexDI8
 Dw/D+6IjGzqV6RCjNT2SxcN4Xs34b+YVp33vAVr8aobWC/tkqM5Mr1UWfFOBpBMugqMc
 rJV9X2Qx8bMLg7yJAAgVctqzT+vCtrljdyGHSQgrtf0eKhi8oUpu/l8xkLMSdpjg8Tlc
 Beu16yLOEd6jqKPfY5Ws9T5EZd5jIFee5zaBFRlJJzaiy9d61olUZiLeTTHP1rpDSMq8
 DCkA==
X-Gm-Message-State: AOJu0YxfzpGI7G860orsTsaXRZIeEM10vdEozNjdfhVnwsPz+991NlQN
 0KAdmywocYlmHviEJFq2x560rUPQ6kUL5kFZ6rhgm5gQVHIdDbmX3iS1h3RcwXd3MufIPn1mOJU
 N5pU5
X-Gm-Gg: ASbGnctF3LWX7NXtVEbG+FaB6zHdq+cgOTnFuKYeY9CMvLGAbMuxWKXbSkfHX0Oaj2J
 5QRk2VK0QHJzVfGqLjqy19X93nf0Swxg6Q3KNudca8wnH6u+pcscffAs15N445JTwqGroYXoPS8
 9o4ZyUmfTznYf+ZYkWBTYirFsGALlnddxUkahBqyj/PBP1SJJDlalq3tnkdB6d2IMivq1ssQ4mC
 1D7JYV5ufkRALtdDrydDEffFiZBhQdaJ5ANg8wxOq1GUWbVdLAVPbyKkDqZi1yaYFL/TukNuBim
 PIvTXR7rUyTTndoeTn+lcOnwTg5wD9Fzo2Z5g0AFGSf1zsyHpGu9P+MG4BvV/7diTMWlMvozlQG
 UB/R4/JAmjMYWS/LvMVreVxlOIK5949cXeilr738GgVTDGSfDJrs=
X-Google-Smtp-Source: AGHT+IEtGLcvXuPBKCVTRZSOmK+i58Gv9LVtyoMGf9dL9vqM7co/BWNFi3BglhS/NNHlO3dc7wdkFQ==
X-Received: by 2002:a05:6000:40c9:b0:3b7:792c:e8d9 with SMTP id
 ffacd0b85a97d-3b900b319bbmr2330605f8f.14.1754654424730; 
 Fri, 08 Aug 2025 05:00:24 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:e7fc:9a8d:4024:d186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5c84b8csm69962645e9.4.2025.08.08.05.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 05:00:24 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/2] remoteproc: k3: Fix two Smatch issue reports
Date: Fri, 08 Aug 2025 13:00:21 +0100
Message-Id: <20250808-remoteproc_tik3-v1-0-f7dae0b177b2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANXmlWgC/x2N0QqDMAwAf0XyvELnUIu/MoY0Nc4gtpIUEcR/X
 93jcRx3gpIwKfTVCUI7K6dY4PmoIMw+fsnwWBhqWzfWWWeE1pRpkxSGzMvL2KntEFt0zdhBqdA
 rGRQfw3x3q9dMcotNaOLjv3p/rusHJuZW/noAAAA=
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Smatch reported two issues, firstly attempting to compare a u8 to a 16
bit macro and secondly a potentially uninitialised variable.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (2):
      remoteproc: ti_k3_arm64: Cannot set or compare u8 to 16bits
      remoteproc: k3-r5: Ensure ret is initialised

 drivers/remoteproc/ti_k3_arm64_rproc.c | 2 +-
 drivers/remoteproc/ti_k3_r5f_rproc.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 123cd77122a13288e1552b5d9b7c22a6f19e2e02
change-id: 20250808-remoteproc_tik3-0f67bb6b85d7

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

