Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE092D3A692
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 19:23:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A75D1891B6;
	Tue, 29 Oct 2024 20:22:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eOVsclOz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0B52891B1; Tue, 29 Oct 2024 20:22:44 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C969F89174
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 20:22:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c96df52c52so7315421a12.1
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 12:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730229762; x=1730834562; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=apWNiKGtUTezi357mxk6DHyTrCacxB1McHI5th0XYxs=;
 b=eOVsclOz58MyyTVFE86Iu/vy68RTGtWLOsgm2ZozZeiCuJxH2FOtjtzS2n5C4nHlmZ
 iqduLu9JaYbUa4sr/hCzu29vrxCBaaB7xdSdxEUb1DQPpnzaj33A1K0REqlNFVvaovjK
 km5JadbBbJc5jAQBRzW4nYaXn2Ro5dRlffwac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730229762; x=1730834562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=apWNiKGtUTezi357mxk6DHyTrCacxB1McHI5th0XYxs=;
 b=iFof0OyWGXi4lbd2CICAgGZ9eGCx/wJcbBlGeJtk1C8UWe2EfAaCPwH2Krwe1cU4BM
 HlR5JyrmZ+volvc3663AmZlqvbsYDbjODRNoheok8lWfHsS1LniDPmMxzDHo9Y1+B3z6
 Bdu2RWFgBnERFUE3xBadnS1JdL8obTqa0ptMjq47iHHim9f7cqXK1t4XH/2uE7hBoTNu
 v96ZqhY2++vVJZjIvVTUQF8fHgzCI1ldVHT1LlBwhDrwmV66F6czLnFUxmXZyJplqUho
 Q2mRJx5Frbl7pying87kHwtYNH3+ojh5UaX5D3zU89OfCH8rgCrAz8f2U8roVTvjTAbh
 qL1A==
X-Gm-Message-State: AOJu0YwO0WhYDk2BeNP5yQlU7aumrVoTbvE1LLSZLVr7ZwvPaiTD0dLE
 +4bnHOysN3y4d3PefYNKe92BkAd6g6mTrs1e9+PokgIhVztu+Jwh8otpXAcpGiR+sdw+r2jM/bL
 Zu03t
X-Google-Smtp-Source: AGHT+IF+J1Dp+dc+/OrChjb+91L2htsv3SvwyOlazLG9PtPBHGa/tdYO0S+5v959x8qdxVljuBW+BA==
X-Received: by 2002:a05:6402:440a:b0:5cb:dcf7:fd35 with SMTP id
 4fb4d7f45d1cf-5cbdcf7fdb7mr6583983a12.13.1730229761783; 
 Tue, 29 Oct 2024 12:22:41 -0700 (PDT)
Received: from chromium.org ([87.215.50.114]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb629f65esm4272770a12.36.2024.10.29.12.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 12:22:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v9 08/11] efi_loader: Drop sandbox PXE architecture
Date: Tue, 29 Oct 2024 20:22:16 +0100
Message-ID: <20241029192222.362445-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029192222.362445-1-sjg@chromium.org>
References: <20241029192222.362445-1-sjg@chromium.org>
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

Rather than returning 0, just return an error, since sandbox is not used
with PXE at present.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v9:
- Add new patch to drop sandbox PXE architecture

 lib/efi_loader/efi_helper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index ab5678eb66c..bf96f61d3d0 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -91,8 +91,6 @@ int efi_get_pxe_arch(void)
 		return 0x19;
 	else if (IS_ENABLED(CONFIG_ARCH_RV64I))
 		return 0x1b;
-	else if (IS_ENABLED(CONFIG_SANDBOX))
-		return 0;	/* not used */
 
 	return -EINVAL;
 }
-- 
2.43.0

