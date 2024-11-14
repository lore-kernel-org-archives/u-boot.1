Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D71ED6A221
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 18:13:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17B8F89649;
	Thu, 14 Nov 2024 19:13:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aJ8ctpI4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 321F489657; Thu, 14 Nov 2024 19:13:26 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 344C489649
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 19:13:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-53b13ea6b78so1455170e87.2
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 10:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731608002; x=1732212802; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ic1gIaj9DL6c8hYvCbP/xacYZyEJodOL1rcl6EUHV/w=;
 b=aJ8ctpI4Fmuz53m0ulH8CGs7QoT2M3YpEtsoVX/94Vnj+Qyr4+WlDttUn10razTvh8
 lL9J5VMbo/uHnFD4zH2NdX9GauJA2YNWFjWuesuoqBQKJNFlrDGBpRXILX/AnoWctK/z
 C9skhqzfSzt0buTWmpLOzmHepuq/aSsU4kGwZd6myvg84DOTEx3j4szWbGam3O6bvXc2
 hmD5SudwkQlhUA82l2Qd3r/zjV+ykktwJFzYttGEkgJbZGxRXxr2ZCUUOXSiVoiW4Um6
 5X99tJZ7Os6Vcj0w7kAQtkws31a78wOU+Ek03gyxqLtm5I++eAFrYRSRxV0nQxoY4u+c
 RV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731608002; x=1732212802;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ic1gIaj9DL6c8hYvCbP/xacYZyEJodOL1rcl6EUHV/w=;
 b=N0s4yPdcABJUgBlbh4mqXncc0XXI7hSEBIyMZedtd4sc79SsophUxXSvJgHyseNLKM
 HMh3HphqcAiiRLVCnEWoW2dgDknp7R+672FYu34guTVvuhwTWp29s3nYAuM/U8lUVs39
 gJnQiePTT2SOi0k1vkRS2lYRwyoYxxyrY1DGf4pH/IFEOwMYdZ5Kthfjbq+k1jKoZkvC
 6+hdKBHw48tF3TDXgVaLoQ5/ZRS4dsQXkVz6c5feayJrK7zCA+BA5ErcsYLMGyOFMevW
 ljkz7Es2qHPvP96KrX5pQLjGea7MpKHqSH7AAY24geOM1bE7c14nkAk2cxYloPkCSO7X
 tKEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO129duOvYykBn770HmpuE8tOFUjIEC9V0rORGjl88YFMFPcIPEzRbWGttrRDO/WJaGNSdFlU=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2LKQEpLcRPAp005lWz2SvJ/4YgFgF9i8IAijmQknwzLoDxTO9
 3KI/Yo4rcCNVlSIv6ZJAiI9kVMlg8lco0kKBCUSQBFNy2N8oHGPvuVERqkjUXJedjp7jk0LmdCc
 p
X-Google-Smtp-Source: AGHT+IGqq7CTb2CSOsB/Xcui/5VXbMhS5HIaB+DibptGHP/IgmqJCvnZV1oCxn1Wq0zUwd24Sbo1UA==
X-Received: by 2002:a05:6512:ad5:b0:53d:a41c:4ef1 with SMTP id
 2adb3069b0e04-53da5c27a6bmr2505597e87.10.1731608002167; 
 Thu, 14 Nov 2024 10:13:22 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20e0860d5sm89590366b.186.2024.11.14.10.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 10:13:21 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20241016-topic-sm8x50-mmc-vqmmc-v1-1-767af5351d37@linaro.org>
References: <20241016-topic-sm8x50-mmc-vqmmc-v1-1-767af5351d37@linaro.org>
Subject: Re: [PATCH] mmc: msm_sdhci: enable vqmmc at probe if available
Message-Id: <173160800099.3344230.2105692050506658447.b4-ty@linaro.org>
Date: Thu, 14 Nov 2024 19:13:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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


On Wed, 16 Oct 2024 11:17:16 +0200, Neil Armstrong wrote:
> On earlier platforms, the vqmmc regulator was enabled by the
> previous bootloader, but on the newest (SM8650) it's not
> and we need vqmmc to be enabled in order to have the card
> to respond.
> 
> 

Applied, thanks!

[1/1] mmc: msm_sdhci: enable vqmmc at probe if available
      commit: 2d55b9e7319231a72659d620de03a471b92cdef0

Best regards,
-- 
// Caleb (they/them)


