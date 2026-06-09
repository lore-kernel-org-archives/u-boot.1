Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51E8CD8C92
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 12:49:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 269328486D;
	Tue,  9 Jun 2026 14:49:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CQ1tHb5f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C302A84878; Tue,  9 Jun 2026 14:49:21 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 799E784704
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 14:49:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-691c5776f95so3592793a12.3
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 05:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781009359; x=1781614159; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ES6fdPS+lsBWpcctKzeQLWtyfchFEkLlvc6FkKjHN2M=;
 b=CQ1tHb5f+mZ0o3wqeoMi5y2fH5xFBfYhB03RMmoFsuanUzCN8sed1AT4hsQNrvqGdL
 8P4R9UVizCyy9OML//XcQD4QX+7vvPWYVrLa88CUxBUCI5blnwhRvkLf2l+YOCiyaxpy
 Tqwslxmv+9koA9CsZbUCF5Hmy6usrwa9QStS0f/VnvQVOpXDNMJVvlIRcO4e/CyX/EdG
 WGz0MuR6Ek1Mf7YZrv1RwAsrcpuhXRfE4CSOihm93swhhTHnGHMTaCeIcJMY4uNQv0gq
 6d4liuwbZd7/2aLNxC5RAg0wly3wxbxqPb2ZErcTgUV9ygMhT/rHMbm7qK9QN3+LdkfF
 uplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781009359; x=1781614159;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ES6fdPS+lsBWpcctKzeQLWtyfchFEkLlvc6FkKjHN2M=;
 b=H7dj1IxPQb67cfgCSFojZRBrcdTKmr9nil7c4XrDWXrGGgl0vlWTCqvY5rJvFkv/SN
 VdkgNtR8PPjQD+RKX4Jq8ldFyygsAgT4iyrrGozgDnp+vcUZG0ZJ2AL1rhOIRLH93mBQ
 cc6ZcRb3DGHdUXvCNss9fA+QvHGtdM1Fn5XRCcRQEn/vxjQYDWRMkfSK73GUl2vtFNB+
 RbmdmOoUaZnyWevEbm13YwlC+4s8xwWE+BPlGa8ghvBOul3E5qc0LxbCLzIDYK+6vQrK
 w4N0uu5dFZBzoIQqociWyN1CQheh8a2al5uCewndhLFVs3VE5cvcGvEfd+FSdpsWJGQh
 wPFg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ZuEdq7kWsNXN3lFrwx/tcaitWk6X0+8DLIYtcqyMA9QuqTwLtxPDc7k/WG8NAhCPkarzCyRA=@lists.denx.de
X-Gm-Message-State: AOJu0Yzgli/V0dqgczCJlegx5WKG0lIYTQGxiwok9IqLiRdDP/h+Q7PG
 GWDEJrYKEJ6E05XrXnuBLyOQbBMIA3ztQfFJsUbaH7rEwSyrrkzCH9p0OfKQzhPMT6A=
X-Gm-Gg: Acq92OGNtxLmKwvIcggCt/hbYeN1okYRvTLNoWUkF3rx5O3dai0wlKKu7/LlNegI2BH
 seMBk4O/V6bP59sc12pPFXh4GZB5MIdDtEEyQUb9oCwNFZt2mHpHHU9RXyM1JrG1qXwJscPcuJV
 xJuZq2WsgLUutqVlZOcKWQIhV7IN9qteHtERapuXxm8MT+ZSweNkRwqpn/+/g+2S7XBf4jAX/n9
 kPjNc1Y6OcN7sypsrhHraoG9nJl1EcEPdt2cn/dY/BHMB9KEiNOI4mYtliuuzNjGD7R+PQlsuwA
 4OsFt/1i3jFbplyZnGh94TzUO4QZrH7DjNrgGcQOOz75+t0fC/9+hvouMRCYLhHQ+Hw2pxmWgpC
 EnV7m+9Jts5gGunnwBvjWeGzLISkCNnrqhTgFk8rXDWCpF5n5+tshL1ZQn+FszkrWoYqEUCrzbm
 FtFOIgxGpGtWHvWiHa6CBhWno95pQJ0mbMUlDeMdlijEGO0yHazxrMSI0X5eCs4mLGeUaS4a1Uc
 fB9
X-Received: by 2002:a05:6402:4344:b0:691:af08:a9fd with SMTP id
 4fb4d7f45d1cf-691af08b98fmr4895334a12.11.1781009358979; 
 Tue, 09 Jun 2026 05:49:18 -0700 (PDT)
Received: from lion.localdomain (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e65b55d81sm8689526a12.27.2026.06.09.05.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 05:49:18 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Petr Hodina <petr.hodina@protonmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Rui Miguel Silva <rui.silva@linaro.org>, 
 phone-devel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 David Wronek <david.wronek@mainlining.org>, 
 Jens Reidel <adrian@mainlining.org>
In-Reply-To: <20260605-qcom-gpio-v2-1-c34093041c66@protonmail.com>
References: <20260605-qcom-gpio-v2-1-c34093041c66@protonmail.com>
Subject: Re: [PATCH v2] gpio: qcom_spmi_gpio: move PM8998 GPIO from legacy
 pmic driver
Message-Id: <178100935799.3342853.7861840004609212943.b4-ty@b4>
Date: Tue, 09 Jun 2026 14:49:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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


On Fri, 05 Jun 2026 17:09:07 +0200, Petr Hodina wrote:
> Move the "qcom,pm8998-gpio" compatible from the legacy driver
> qcom_pmic_gpio.c to qcom_spmi_gpio.c. Enables on PM8998-based boards
> (sdm845: SHIFT 6mq, Pixel 3, OnePlus 6, Poco F1, Sony Xperia Akatsuki)
> the Volume UP gpio-key.

Applied, thanks!

[1/1] gpio: qcom_spmi_gpio: move PM8998 GPIO from legacy pmic driver
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/6e522e428575

Best regards,
-- 
// Casey (she/they)


