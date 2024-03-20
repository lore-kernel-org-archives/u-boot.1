Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C00C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 14:57:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A0428809E;
	Wed, 20 Mar 2024 15:57:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J9Dp/ix5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF9D188047; Wed, 20 Mar 2024 15:57:13 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 245308808F
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 15:57:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4146af3ebc8so6164635e9.2
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 07:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710946629; x=1711551429; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dJza8irKGD1LCWutbG2pawgU5HuytyqoLzmIGB2jhMo=;
 b=J9Dp/ix5Z1sOzuA/zgE1okZmhSeOGL44GyZ2sfSL6l+RVJIxMk5PpXducrEwCWJB35
 NNm0rWBu9nLR/VAHLIZC0/XiXywvUMGjbLzeEw55UdlNYJ82z5d0noxUgikpVs7vMREe
 6m2zGTX64QHtgHMAV9XeXL9OSjMV1UbPj/FnLtjox6wVs2pU2nJABodAcvY7Q1BGxxyN
 r+wVcL7/oYLw0FqP7Z2FS7d5NQLeXRMiEDAuIG3cBhu+Dk/HeIV4IKtsr/ZVQncWCjbD
 UKeVrZlQEsOVIcn9BA9qIQQg2sCiaqzlS9cCUIkhbrrT5bmvNDUfA2/qUrEk4Or+lL71
 M1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710946629; x=1711551429;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dJza8irKGD1LCWutbG2pawgU5HuytyqoLzmIGB2jhMo=;
 b=bEA3gaB4S54J5QlcJbmzfLHvd0T0DI+grFLMnCT4D2POyo0KeadxqdYjGbGqr+jJ6U
 9iGAfi65Pauy2CzyI4WxHSNgkWbjQTdiiv752yZbitaj7PeazLwYIQZGOUiBoCgNt+l0
 eW0AMeGgFZ4g9sNpFllb5Ggbo1j0ZbZsDGFeukSCFde4cfNmCxD6LTqagIg6h+HB+JKy
 v4OXQvIAxsMlZiB2Xv2n+Rf92sLBDhCnM5/ZDlcYiC3IZY87Xtwc4B/9pM2qVyZM1K47
 xU1uHvc3/7iACNhPy0R0ctBtBZUctd3WKlJCkpjb2xF3iruF8fCpPowB/39wYjm+InzR
 jslw==
X-Gm-Message-State: AOJu0YxB9p5Q8ChMTpw22JybxMNYsgnuN+CZH1+3Rr1Ue8omTFq/QQa3
 3zhoKKN601A7kbce9jVG+r6jQWRfS556T553gzVqdC3NS3MT6uWmlLyiQngOP30=
X-Google-Smtp-Source: AGHT+IHtEKxzfRk9S+cQ9ZeXz3vMca/zaQ/zklI4GXyy75EtWkhEAqxDK00YAT67BmxKf8rFtcNgsQ==
X-Received: by 2002:a05:600c:5494:b0:414:6909:f65f with SMTP id
 iv20-20020a05600c549400b004146909f65fmr2791599wmb.6.1710946629225; 
 Wed, 20 Mar 2024 07:57:09 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bi16-20020a05600c3d9000b0041468f79fd5sm2461268wmb.16.2024.03.20.07.57.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 07:57:08 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 20 Mar 2024 14:57:04 +0000
Subject: [PATCH v4 01/14] mailmap: update Bhupesh's email address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-b4-qcom-livetree-v4-1-d867ab1f06c2@linaro.org>
References: <20240320-b4-qcom-livetree-v4-0-d867ab1f06c2@linaro.org>
In-Reply-To: <20240320-b4-qcom-livetree-v4-0-d867ab1f06c2@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1165;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=XSvtB4NoCXg6pY1Nq/qGGGjasqOo57hNo8/eyKot594=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRfPx0vvFhW0SS1592LvdvuCf9xk7Njz3nSEcxts+EcU
 0plgn1WRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZhIkzzDP4tDfWJ525JZWL8s
 3m9UuTqljMW8pnS7yIX9378rMIRu+cjI0J7futVytu5L94tPhVdeCjm0OOX1er2DdmtSJZ7P1lk
 3eTMA
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

Update Bhupesh's email to his new one.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---

Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index d1f08f3eca8a..f6e0847b2168 100644
--- a/.mailmap
+++ b/.mailmap
@@ -29,8 +29,9 @@ Ashok Reddy Soma <ashok.reddy.soma@amd.com> <ashok.reddy.soma@xilinx.com>
 Atish Patra <atishp@atishpatra.org> <atish.patra@wdc.com>
 Bharat Kumar Gogada <bharat.kumar.gogada@amd.com> <bharat.kumar.gogada@xilinx.com>
 Bharat Kumar Gogada <bharat.kumar.gogada@amd.com> <bharatku@xilinx.com>
 Bhargava Sreekantappa Gayathri <bhargava.sreekantappa-gayathri@amd.com> <bhargava.sreekantappa-gayathri@xilinx.com>
+Bhupesh Sharma <bhupesh.linux@gmail.com> <bhupesh.sharma@linaro.org>
 Bin Meng <bmeng.cn@gmail.com> <bin.meng@windriver.com>
 Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@bootlin.com>
 Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@free-electrons.com>
 Christian Kohn <chris.kohn@amd.com> <christian.kohn@xilinx.com>

-- 
2.44.0

