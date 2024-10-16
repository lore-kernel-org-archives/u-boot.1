Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A1BD206A5
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 07:37:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 686F788B70;
	Wed, 16 Oct 2024 09:37:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JTz8Smue";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA4528865D; Wed, 16 Oct 2024 09:37:25 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A52688D10
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 09:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-37d6a2aa748so2080226f8f.1
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 00:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729064243; x=1729669043; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FeB1+nVttJOn5jUccQFg1elV5sNdi6WInEQRTJA8K0s=;
 b=JTz8SmueDRF2zbjZk6Lw0hCW038TIkRrCcDlk6+FpFvyTTkBBtoHrN+FVVa3vg3p7C
 v19LU2PKRP1/TGOgMjnN2b3M+v282vn82tqYqNUi9nXJNmMfzuUBtKLH52VjeGTHb3Uv
 o52J7FbUuKJCH+FRbU+r1dRtHwYV4mc+R7tzcpt/BBwsIpQICVK1EeFk/GjGlGjaBZW0
 PY1bIz4qEJVkEdOt/sHRVSluRc3b1r6ad/w6z3MCsKDSsESz0qkkcv+lmCVQVWGngdeD
 rj1abXzwq/ZsYVT2DqVJran0ySDvtlcfKihN+2MrdD7ZfUBwH3FlelNAECZNw6l72it6
 jeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729064243; x=1729669043;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FeB1+nVttJOn5jUccQFg1elV5sNdi6WInEQRTJA8K0s=;
 b=PRpzZVc8SexsJOKLP+6rqwXk5cbeMPC2V9YnwJR9//8gHTVgtpUdDynCIcScVrZHh/
 f3+ii0kSIkNGdBz2VWU159cwYlg+pJ5n8BpGb75MpnVFywQKruYNcTFabhy6zhbAv7za
 bf/C1pVgBAs1JszjAswqqNHeGxXA2zJetD0moKe43Sa/HXEYW8O0TIT1cDB4ns0yJRbZ
 2qiS9s+2/8a/53Y4v4h6oWpUrWTymHMa8mB0RKyiDuPlN+mG7I9Lij//7ya3N1Y/KfgT
 hZxr7GmvPniXCmIrHvJ+QrbTmmexkpAjs/PQ4aOCReRKBKj1qVZmS+93bXU525HD1rDG
 2dGQ==
X-Gm-Message-State: AOJu0Ywgq4lvkHB9KzaeGpqmVMHTNYJa6zr73IAQAaFpfQJAaly7IsmF
 9TZBDgG8FdULsz+KTAjRpDCsW8jNlOtSTQ5DtJgspvqGYs1DFbj7TeRN1R77fGk=
X-Google-Smtp-Source: AGHT+IETCgfKgXBe+qHK59dcb0LRs8VRvVqYbU+yQG0YQdzK5N71A5YU6mASxg0wCkvwYjTq5r7+YQ==
X-Received: by 2002:adf:e504:0:b0:37d:5338:872c with SMTP id
 ffacd0b85a97d-37d5fec8e0emr8361606f8f.1.1729064242944; 
 Wed, 16 Oct 2024 00:37:22 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a231sm3573946f8f.11.2024.10.16.00.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 00:37:22 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 16 Oct 2024 09:37:20 +0200
Subject: [PATCH] dt-bindings: remove phy/phy-qcom-qmp.h in favor of
 dts/upstream
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-topic-sm8x50-drop-phy-qcom-qmp-local-bindings-v1-1-7928f9cbe8f0@linaro.org>
X-B4-Tracking: v=1; b=H4sIAC9tD2cC/x3NTQ6CMBBA4auQWTvJFCsar2JcQDvAJPSHjjEQw
 t1tXH6b9w5QLsIKz+aAwl9RSbHCXBpwcx8nRvHV0FJrDZkOPymLQw2P7UboS8qY5x1XlwKuIeO
 SXL/gINFLnBRHunZkLJu7ZajNXHiU7f97vc/zB8x32JJ/AAAA
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1216;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=4AUhojM9wBRjQGuaun0tJVoqlQX9ylvXLw8K6UkaWrc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnD20xqBqwpRXoZ9ZPJ3pOk8+b3CScdWu5JaTXK/3B
 qE+mFoiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZw9tMQAKCRB33NvayMhJ0aHiD/
 9+Yizpw+9B8U0f7HeUxrerPt33wqfSO4LXBd9rq2NttFH+TEUZBFdKoWi5bLvVNdQpYlLZSULLmgE0
 10mvDklGiB2tAf8qUa69SotngfnMudBMVMC22zWG+IyMjSX51wZVwMhKKGIbOtCsfogzKXGYtDcnc+
 eTUbF+ihXartcYFna/pvbEN+MTW+QXWUQp+qr3p24N94xvphXuuwGwbmc5Fdn328V3aje6gjlVcmSu
 pIQcRuV7Pu9UFpPKr4U4E53GDMVyi3pcpYMpTkhinx6pr7IuVoNWz7zxye9l4PUH4XiaVKL1L0GNpS
 gLeLxCg7+K1sWdpIKMR9LeDg4z2LAJtjMYuHOZTyZisi4BqR4dSkNYkT0DeiqDhwR9gLVHQTEMNhS4
 7ilj1T8eRkfxaDTd7nD1xMk4zFSM+rxETJOVrFVZ6+GwMJLPr/+t2YhEMDgAPMmlOWQfYZNKrO3rmB
 2H87LfY4Uu28VY3/kxyuSpuXWOWefB+62WZYhoE/5ZmnrxZr4S/VFY76sfB23Rj6mTRL0b1dL/0tUF
 3U/c7gaWaUrijbQIpsqpPM7/bzMs892d10H3PhOboRhhKlkEGYsv8rXY/3c1ikzYdRf3aSlSOcplU3
 9DZDUV7Bg5Zl7xb9r99r0R0H8BigP/itbZCUPnXzwU9GtuDh3BAP0MeFxdJA==
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

The upstream version has new defines use to build DT, drop
it in favor of the dts/upstream more recent one.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 include/dt-bindings/phy/phy-qcom-qmp.h | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/include/dt-bindings/phy/phy-qcom-qmp.h b/include/dt-bindings/phy/phy-qcom-qmp.h
deleted file mode 100644
index 4edec4c5b22..00000000000
--- a/include/dt-bindings/phy/phy-qcom-qmp.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
-/*
- * Qualcomm QMP PHY constants
- *
- * Copyright (C) 2022 Linaro Limited
- */
-
-#ifndef _DT_BINDINGS_PHY_QMP
-#define _DT_BINDINGS_PHY_QMP
-
-/* QMP USB4-USB3-DP clocks */
-#define QMP_USB43DP_USB3_PIPE_CLK	0
-#define QMP_USB43DP_DP_LINK_CLK		1
-#define QMP_USB43DP_DP_VCO_DIV_CLK	2
-
-/* QMP USB4-USB3-DP PHYs */
-#define QMP_USB43DP_USB3_PHY		0
-#define QMP_USB43DP_DP_PHY		1
-
-#endif /* _DT_BINDINGS_PHY_QMP */

---
base-commit: d5cab0d6adc26ec1bbd45c2fed101184d04454ae
change-id: 20241016-topic-sm8x50-drop-phy-qcom-qmp-local-bindings-f036014e174e

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

