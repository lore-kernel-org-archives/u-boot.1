Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F96D6A224
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 18:14:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBBAE8965B;
	Thu, 14 Nov 2024 19:13:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q/ykJcvy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13B9D89652; Thu, 14 Nov 2024 19:13:33 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDD2A8964E
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 19:13:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c9454f3bfaso1277270a12.2
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 10:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731608009; x=1732212809; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w0YIbW2gaatu51yhHbVD2ZbjY4TSB+PMNYamb4D0Frg=;
 b=q/ykJcvyDGBR1LDqhG3WLUgefRbGfH0I9oJIQqJJRX0xwhw0vJ+g7g7a8gZqIQB8sn
 JE6GVHsEis+PEPyZKbzk3GSmf1fLcd/JUo5T78m0M+bLDNDq6OFWc+7h0uxCsxEMMhrH
 XpsKEMBYbD6CEd2TFISGKdtAQqM/Vrxb+FwpW0etoTHqMlZpS+gkkPZgCwk7m4OqXRGG
 Krm/4byjvXin4CsrX0LvTXz/VpmWyCnn38vezDoM0O5KAHVHiXZIGaJ0RsR76/W9N7vN
 f1UDqGPFwiJDLvQ4g839Iu8BCVwqMtAJdrz7+ui6z5FuVlnaNOIPVTFzgOPoFdFuLPkB
 zXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731608009; x=1732212809;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w0YIbW2gaatu51yhHbVD2ZbjY4TSB+PMNYamb4D0Frg=;
 b=RmMVLChJbA9NGwJV3KejFvc+J69Y6s3uXw8VZEjDAfFv9dibINiejIX/IpjZOgTCLf
 BBxRGBl72ciTrV6pdLFOa7ha+UO0GwDkF3TJ119ZnWKzaLoCjm1Yj7X/1AFiH3bIq8k+
 yJPs7t9bGU4cGJGRS7kMZS0+i2s6ApFbxcAQcEnpe1ODg6d/Vi7PoVGlwJZxOux7tZHK
 FCt/wTeXLiA4joheqQBd/3q1/rp2QZ74aiwuUEpETLcHFdh24SMEbfu6/UFm3BmdL3cC
 mLy+YBZq1yibe4UHIcd2ekMvjxxBidu8ekfMHGz5DpTbam42nhjmBx+XIkMVB9Qqf/LL
 XUyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqyBBghMGQItNNd7SQYNjhVIH3/TCxxg/hg1bhw7I875AtET5KrUUegjsMDvVEYDtR4SdpzJk=@lists.denx.de
X-Gm-Message-State: AOJu0YxpD9Pzi0MHwAuvE/wP3K/dCYDP3yXMZEV+8B9rcODijqsgdvts
 EOsofOolIh4YZk4bbgRvwqRbge+R41N0X4Y7jJNnZSw1fEqvbwzosiHE0FuH0nBV1eta1Wdgano
 6
X-Google-Smtp-Source: AGHT+IHiySV3SC4WGrWlBbXrHKvcHVlXyE9pP3Nabl8XtB+Xf0psiBr08DJ702mqMeqz0hJYNNuFmA==
X-Received: by 2002:a17:907:3e29:b0:aa1:e0ac:db5 with SMTP id
 a640c23a62f3a-aa20cd2e87fmr318640966b.26.1731608009492; 
 Thu, 14 Nov 2024 10:13:29 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20e0860d5sm89590366b.186.2024.11.14.10.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 10:13:24 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20241016-topic-ufs-phy-drop-v2-regs-layout-v1-1-af804ce47060@linaro.org>
References: <20241016-topic-ufs-phy-drop-v2-regs-layout-v1-1-af804ce47060@linaro.org>
Subject: Re: [PATCH] phy: qcom: ufs: drop unused ufsphy_v2_regs_layout
Message-Id: <173160800464.3344230.3458098298731588814.b4-ty@linaro.org>
Date: Thu, 14 Nov 2024 19:13:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14-dev
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


On Wed, 16 Oct 2024 09:43:56 +0200, Neil Armstrong wrote:
> The ufsphy_v2_regs_layout is not used, drop it and fix:
> phy-qcom-qmp-ufs.c:87:27: warning: ‘ufsphy_v2_regs_layout’ defined but not used [-Wunused-const-variable=]
> 
> 

Applied, thanks!

[1/1] phy: qcom: ufs: drop unused ufsphy_v2_regs_layout
      commit: 7b52f3eaa0a188196f607c92f8f472470715393e

Best regards,
-- 
// Caleb (they/them)


