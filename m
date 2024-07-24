Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8508BC3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:48:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADC02889B0;
	Wed, 24 Jul 2024 17:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JWmtvNLz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A13A8899A; Wed, 24 Jul 2024 17:48:20 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 695C48896B
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:48:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3687f8fcab5so3376755f8f.3
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721836096; x=1722440896; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xU6GH4rBNYgtdIxkuxaThFhZlxBSTxh+RgbiqtOiwmI=;
 b=JWmtvNLzahw6dgxlD7g3OQ8FLs1zmEtv1p876hGbhIan0gRjBBzoQwwTaSGHZqnnrZ
 7e5tZe2TdidbMtwHjh5GWbei656gnml+arIbjekQ++4T4olWeEP+G/a1GGbsya1Wbi2e
 ft3hzGrJiSY7tH2dxGgNblnGUC5jUkNSU6sujO4+5HdG2DG4KwM9gK3hI3aZgoP2ILST
 0jMkdBMcb1EG6fxaCkLp7v7ZEyDlMYRj+LxeGQ336jp0cHZnioSjgbsdjGBTs4t3WVPb
 k4mnglN04kB2vK36ckvI8I5Nn65JXVlg7TgqciVdGuw6BXRz0TvIWV+/QZnIQG/mn31M
 1r5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721836096; x=1722440896;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xU6GH4rBNYgtdIxkuxaThFhZlxBSTxh+RgbiqtOiwmI=;
 b=KnwXDH57I+Tg5yq9gzbkok1fT58JwmOnuWC2LpUv9UIEgPOz/f7SbzzaJehvFHz/IO
 JzDr1sZwK5hMEAN2eGM4Ad/S2ltI4Lq9pS6k0gDFUos90RaeOxuYRJdPVidEyz0YZ445
 B8vpFVbrLQ6hgbf40PuGGs3PNnkgdTMzp0WFqqWwZFOAMDNjLUSLKzx7m2lKwys42yH7
 XNpoWBfeIrF0zRssChwz6CZX892K3VZeqdfCtrwfCJ4Fsi5eZKIHnIiuH3P0gr4KsZ6B
 MNv/DlsPXwNbqMssHPOMVKnItT4u9xD6fWa90DtXnRr56ZDOyhub0YOneGyRDyEKFAvJ
 Uqzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDD9ofcR8j+4NvBydWBZTvbWbrZdrxCIi9ZS3AYvufXkS0rSjg9+fJtQZlg25P6Fqfiy3a+J+MapJBcFQ27+Rsaajpzw==
X-Gm-Message-State: AOJu0YzpJPf2sZ2CwBA4kjsrotLixIEd5Ri7n/5e6r14UNFdEVb/OlxK
 GTn4RH9i4N9ZFU6p95T+46ub4RoebiIhX8JPKyjS5uMeXnK9qKFzflJ5aiplDY8=
X-Google-Smtp-Source: AGHT+IHDMuM2+KtX97n+Nhc/s7zu568apccGknbZgHhJm5l1Gr/aEoIjbhiQdWuVRd0gpLTVbcx5AA==
X-Received: by 2002:a05:6000:10cb:b0:368:3b83:65be with SMTP id
 ffacd0b85a97d-36b31ace001mr20281f8f.26.1721836094519; 
 Wed, 24 Jul 2024 08:48:14 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f93aabdasm33633015e9.36.2024.07.24.08.48.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:48:13 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/3] dwc3: gadget: properly fix cache operations
Date: Wed, 24 Jul 2024 17:48:08 +0200
Message-Id: <20240724-u-boot-dwc3-gadget-dcache-fixup-v2-0-65836d699a71@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADkioWYC/42NTQ6CMBCFr0Jm7Zi2yJ8r72FYjGUokxhKWkAN4
 e5WTuDufe8l39sgchCOcM02CLxKFD8mMKcM7ECjY5QuMRhlLqrSDS748H7G7mVzdNQ5TtmSHRh
 7eS8TMmluTFXUZZlDskyB03A83NvEg8TZh89xuOpf+7971aiwqKnolSmZar49ZaTgzz44aPd9/
 wLh7XqnzwAAAA==
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1207;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=PzpEHyjfTrWU4Za7X/keyR/kXsEo2L0X3pbjY4rjJS8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmoSI7lnN6VDIpaSvtdC3gbqrIBCxh55s5Iev+zmET
 IG7srDOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZqEiOwAKCRB33NvayMhJ0YnGD/
 9Tou8SgNmnpnGyVnAI8PxeZMuvQ0mJCrxD4TdjpOrkbCpqdcEuQ2Mdxgmp7ND2UzkZnbKjOXeJeyLZ
 Kz0iPoBbuBjIsNDCe98vJvPTN78DQgR6JSLF0eO2HQqFZFn1seq3fnbf0IepDNhRlOkLd8XBW6EgJJ
 oxtT0GI5JJTGpEmnuxTg17q+mz81yJzOlIlWUzD0RDR7R5RlgdVKVEtZo8S1l/UhbMXormDtFFFeNB
 dn4BfRL3OFKIiuMPKPkCPxCIScPnMZZwcTj2za4+NT/OuDwSIarM85FWbasR9zZfIQw1eUv0PyTQU1
 5uNB3rl5RO0fPLO/FEZGwD8HLHmbHxdAKXxowDvepI/oW8zqb/61FEt3geIChnnpBX/QxfQR1ipcp6
 q6iHiQN1TJP2yE/KhoqMU0G0yThWwAuX2XIxDJeH+aMltPERjX9x8+n2G2DnakObf6bmdvEzZAneeL
 XiI3vdvsU2DzMfyoavGCVshBkevRcqkbiEqCtbAxUXubmLXTYY/K/Siv/RslGewhq1EXaz7k9LCLMF
 CmGVO5aolzVSlQLMqbWC2IwLPBVyAUDSft4X8aODv7xlKu2fVTE8kUOwqHG6hWS2agaLJFB4NWpOju
 pWFKXhws4QlOtvfl/SV81zU/ZUYv9RWvJy4uKMtaJ/R+2qlFtr7j+bcdwRWg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

We experience huge problems with cache handling on Qualcomm
systems, and it appears the dcache handling in the DWC3 gadget
code is quite wrong and causes operational issues.

This serie fixes the dcache operations on unaligned data,
and properly invalidate buffers when reading back data from
hardware.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Fix typo in drivers/usb/dwc3/core.h and rewrite patch 1 commit message
- Link to v1: https://lore.kernel.org/r/20240719-u-boot-dwc3-gadget-dcache-fixup-v1-0-58a5f026ea8e@linaro.org

---
Neil Armstrong (3):
      usb: dwc3: allocate setup_buf with dma_alloc_coherent()
      usb: dwc3: fix dcache flush range calculation
      usb: dwc3: invalidate dcache on buffer used in interrupt handling

 drivers/usb/dwc3/core.h   |  2 ++
 drivers/usb/dwc3/ep0.c    |  6 ++++--
 drivers/usb/dwc3/gadget.c | 10 ++++++----
 drivers/usb/dwc3/io.h     | 13 ++++++++++++-
 4 files changed, 24 insertions(+), 7 deletions(-)
---
base-commit: 3f772959501c99fbe5aa0b22a36efe3478d1ae1c
change-id: 20240719-u-boot-dwc3-gadget-dcache-fixup-ea1e92758663

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

