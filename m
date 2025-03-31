Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC92C3600C
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 13:34:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46E218171B;
	Mon, 31 Mar 2025 15:34:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G4WM350x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B414B81EBB; Mon, 31 Mar 2025 15:34:46 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 642648144A
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 15:34:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so30694705e9.0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 06:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743428084; x=1744032884; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bWhXrhx0dMNq18OtsUpGUsFsF/ZpNIC9r2tybnVkLmM=;
 b=G4WM350xl6ZngZgVtP3aFnpMDRFwed6DGaBRGAHzS240B3sAq5hbhdRlXYjykWatuc
 y/VtqrnO10R9nGSdI31RP17uzQezbZeK7dmZqK6nCExOWecIZELPgLoqsNAxbwnNneej
 DUUfu7QB/D/B2KlEGO6YU471cm+IP56NGZ42pOal/yNaNyerEXp+/pSKKjCMuMdVJIs/
 wnDLBIDVPC3SO4O1ngQvyXEYbQdQP3hLaydesjQ/7/Mmq81ZxxkIiyUe22x0hlztIiyE
 rVXTNXHBv+tIMTtfvuhcnfMg3prFP9/r4IBJgi/Q4BZ3ROcr3itVFR67TWrQ1c8nU78L
 E/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743428084; x=1744032884;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bWhXrhx0dMNq18OtsUpGUsFsF/ZpNIC9r2tybnVkLmM=;
 b=Zdo9NQo7sGfq1LAt/aDI4MCxa0cYNuvSh/hqaBJv3mGml+4JG2crjGXRDbnqRuVP+F
 bnf4dTobya65EeQC/EyS2o+IxitWAJUOCD9znhZ3UIWGgJt/GIZrDo3RJzMcY+uiN1bc
 bshOWE+4aHhBwa0OIsmqv4wl6B4wpB4206rKzznVSiYOOrnEL0xDAVfIAofpwDctyXub
 0U3ncUTuK0sfT0UCTvsYIXl30xmkcdk415d8DS4hewc728IJs8v2/f5WtKCohn2iK6YM
 gOZsZtjzaVIPLmEtbYgwbj2FT72lC0I41/X3jeOxy1VugQKIePQ39UPBB3lD3h4rHuWN
 R5ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4Y0FwjfhUKI8xxnv4l7w1GXBBg/1hBVzfpQtU7YFMJOlWorBO0KBbKZD1hN1WmrwirIIXmAE=@lists.denx.de
X-Gm-Message-State: AOJu0YxDe6EPhyGQKddwc0k78IixYDF3EPsIDZH/lxU5UZRmEm/GfogI
 HdVCGJAVQVIG1v2CaPfb7xy19DbL2UQCLSsxD6Pqy3A8IL2pN8EbVb+QcBg9Y/c=
X-Gm-Gg: ASbGnctDt1FFvsU1pfeK1Svz2HIAeyNkmmSmjCu4g8+2RdtQItg3m55GvoI4A0a2YFa
 DArKS5CNJW7qP2Cx397+t/i7Ihwo9dkNPnY3H+uXuqBF7hfmXEWZSiiocMs6G2mV9cjnud33CUS
 IWmpX4OZwNkCdGwDL6SXil5yM2gggXptMwztykIZo6wbzEIStf5xxA6jPy7RoUxy50m9mKUITUX
 1FIbWrF1WUyAAm9n3mRxk9/7+zOO8ZOUexWsuMk8vh8jaG/cjnYd9u8QA74La/TZscH0G1N59gf
 islVWKTvQ0P0QeUrqP01yfQp2ipL6BlvDsGWdStV8nW0XHiqE4hrKtlQqlj+/BZcBOBgsuctzOF
 lrw1LgpPr90Ps
X-Google-Smtp-Source: AGHT+IFVCGuv6M9fKviR7X3ByOHLqD1Y+S9oFCvLfQGz2s2/v47TPQMy0HKLGXgcrGFc8rRTecnSjw==
X-Received: by 2002:a05:600c:378c:b0:43b:bfa7:c7d with SMTP id
 5b1f17b1804b1-43d910185a9mr101031105e9.2.1743428083818; 
 Mon, 31 Mar 2025 06:34:43 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82efe389sm164266095e9.19.2025.03.31.06.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 06:34:41 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Alexey Minnekhanov <alexeymin@postmarketos.org>
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>, Tom Rini <trini@konsulko.com>, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250325083713.2425430-1-alexeymin@postmarketos.org>
References: <20250325083713.2425430-1-alexeymin@postmarketos.org>
Subject: Re: [PATCH] phy: Add SDM660 support to Qualcomm QUSB2 phy
Message-Id: <174342808146.411395.14895213242162875515.b4-ty@linaro.org>
Date: Mon, 31 Mar 2025 15:34:41 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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


On Tue, 25 Mar 2025 11:37:13 +0300, Alexey Minnekhanov wrote:
> Imported from Linux driver.
> 
> Note that already existing but previously unused member of
> struct qusb2_phy::has_se_clk_scheme is now utilized for it's
> purpose.
> 
> 
> [...]

Applied, thanks!

[1/1] phy: Add SDM660 support to Qualcomm QUSB2 phy
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/bc443ad7d6f3

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

