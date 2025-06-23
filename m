Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95796C77B7F
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 23:51:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CE8B82F10;
	Tue, 24 Jun 2025 01:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NfRUw0pE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EC1D82E35; Tue, 24 Jun 2025 01:49:49 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC9B882E5A
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 01:49:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a365a6804eso2563857f8f.3
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 16:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750722585; x=1751327385; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=evfgZLlvNIepP2MeT4NPYh0kdvrmHWYLBsV9lKWpcmY=;
 b=NfRUw0pEd95ZO8d7DvrcT4zdOBG3O98TN1FkP8++/Y3s5+GJm+q5XHvdbtrfMSz3h7
 JDCt5yUW6nfnUjXtvvr/606C2VuZm/O1cfr7DDNJihfu/qP95F1Xf2oojYyCizruXbc0
 f8to1oPi6hqesmYDnn9a8mKfGKE6MbiO4y94w8+Tik9gysocnrrVA1HO7ppX6gCrWNd+
 RgZz570HwQ8qWNxe16tMCs9eqzpREewm52Rb3zVlvYx15T/q0zdzxmEMDHe3126BeMlt
 wwHWkJeYvZdrIXhanN9sipSaEsJutSF0WPSX4W1FUV2KCOMpspGv3qytkYEF99Y0oouA
 Cq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750722585; x=1751327385;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=evfgZLlvNIepP2MeT4NPYh0kdvrmHWYLBsV9lKWpcmY=;
 b=Q6GcWGoVR7gnpVJT+FR6qtM2VkoQfkP+I9Usq6At7BFvbnL7wVyIaOOyIjIFe7LZuM
 VBc6IzT8SF7mk3lZxcC5TLqxesidovh85rsWkCaIshFDP+5oIL4dnMLrnH2hcKwjQPOc
 OhbKXWs71BFtwFims0uey8o65zGMG3ym4saQKP1KQQY4bAvb/NtZ06AeYfgsMJg8rTab
 dB2o2OzP/PlmGpyGd62axC+SuIsOkb37RVQweQO5W5oAk1xmgwC2ybsrvVbMBmb3UKTa
 vOyyXs1efTZPPddGQajgtsXgQ06WgaLaAAcAhlYMIkAvUWKQ0j25D5K6nsSQFVMNMpJL
 8WWQ==
X-Gm-Message-State: AOJu0Yxd78xdGE9TD7JMm2ZQ3MPsEuPSvCtp94V92UORbvheEls/pgZC
 wZfYXdATQHBikS2RO0sa+peJvSiYnwv0ju8WW3y2dljidyUcyvz+5PCoS9I20jYeMHU=
X-Gm-Gg: ASbGncuz9pdG6K8RM79NdfPGDiJfo7+rkGiKWrB8Wizo1BN6hTYjVIa9Mrym/exjV21
 EVtxSXocLL3/yGyQJcF36uTb8taWhof0EM3akwC04Pauk6BLmhCqSm5y+137n/YwsasiKw6Y7wU
 /Rvr6nACkbEeIOUgXGqqm3yUdpFO+Rl2oiAg5HpkFAYIZ0RMpt43l3SnZdmK4XpYKqLpdRGYqkj
 mF5Yql7KzX0ihmxCz8pbM5e8oSPFUFn7QlswtdIi7ai4Gu5wGwZf42SAq2PFYNHFW5kNWxNjM0P
 8bP8WB6bYBMXXEDBPjpImihqHNpHjLKl0YZpJkBD61qsI5fqJjAhTThfoPkboZEEcmoYpETTeUu
 /9rPkslpPKbg=
X-Google-Smtp-Source: AGHT+IGF2hNXjItfQnseNY8Q9NBhqEPFv/DgMGr/TJanf7mwbWvI9ZuDS95kl5008jBBJ9zJygPaQw==
X-Received: by 2002:a05:6000:38e:b0:3a5:2653:7308 with SMTP id
 ffacd0b85a97d-3a6d1331afcmr12338341f8f.57.1750722585086; 
 Mon, 23 Jun 2025 16:49:45 -0700 (PDT)
Received: from toyger.tail248178.ts.net ([213.240.182.16])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e7fb5716sm432284f8f.0.2025.06.23.16.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 16:49:44 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20250411-b4-qcom-capsule-update-improvements-v2-0-27f6b2fcc4a9@linaro.org>
References: <20250411-b4-qcom-capsule-update-improvements-v2-0-27f6b2fcc4a9@linaro.org>
Subject: Re: [PATCH v2 0/4] Qualcomm: expand capsule update support
Message-Id: <175072258362.128390.17900423317490210088.b4-ty@linaro.org>
Date: Tue, 24 Jun 2025 01:49:43 +0200
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


On Fri, 11 Apr 2025 17:03:33 +0200, Caleb Connolly wrote:
> The initial capsule update support only worked on the RB3 Gen 2 and made
> a lot of assumptions specific to that board.
> 
> Implement the logic necessary to update U-Boot no matter where it was
> flashed to, independent of any particular board.
> 
> First, we keep track of how U-Boot was loaded, specifically if we had a
> valid external FDT (even if we didn't use it) this indicates that we
> were booted via the Android bootloader, in this case the target for
> capsule updates is the boot partition. Otherwise, we target the uefi
> partition (if it exists) or the xbl partition. We handle A/B support for
> all 3 (currently we always flash to the currently active partition with
> a minor exception for the uefi partition).
> 
> [...]

Applied, thanks!

[1/4] mach-snapdragon: track boot source
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/41feef758d18
[2/4] mach-snapdragon: CapsuleUpdate: support all boot methods
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/e0208fc4195c
[3/4] dfu: scsi: don't call scsi_scan()
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/a4c413862b8f
[4/4] qcom_defconfig: enable capsule update support
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/c4b9eb6abb9c

Best regards,
-- 
Casey Connolly <casey.connolly@linaro.org>

