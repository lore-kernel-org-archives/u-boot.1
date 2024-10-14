Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F49CCF2590
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 06:57:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C3BF89018;
	Mon, 14 Oct 2024 08:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VlLL5MAO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0998789011; Mon, 14 Oct 2024 08:56:37 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6EA288FC8
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-539d9fffea1so2586945e87.2
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 23:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728888993; x=1729493793; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ExOgr6Sa1pH0EdLmTljmsdznTxP6PBIrQ204c6oevI=;
 b=VlLL5MAOkxdtMom3do6aZnYXIwYLizYnwMyO+XfafQtxaYZsAwr9N4O0Kcuz34kHgI
 ELY0raXRISV5I3t0wx4xDifisMsFS1Jitgloi79nNDlO/CYWGwKymhsG3rSkKVA1fvqj
 FLL+/nlKP0K89CGuGr6kpLTeTnlNqCLE+QTm7XZl0eXdjM7l4vsddF1U/fiOMM8DuAEx
 WvfXI9BuE+69TrLc6dHuWJ5hA/EqJdrkSCDIZy38zZA0mwfbU0Oy92ewxwe+amZS8o4T
 vbVeZgWr2GhEOGPGWqoiwqSJtZhjRkp2fzdo/92vEe2UbnGT7tCq+wcncBSn+8LqxTrA
 sLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728888993; x=1729493793;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ExOgr6Sa1pH0EdLmTljmsdznTxP6PBIrQ204c6oevI=;
 b=hi4WwkTdBTvzB41vlAm2FBw/7BFgyWnYdm1wQCqocaLn2xo93s2T2JD/mN4z/EMh2q
 JRX54gGSNDaD61GBDQDyFW5siWDcRgVUh7BaNqoikLDmLXy0ot1u0jsuWHuxsHTBYxtj
 frAQRjhKt1ZBJo8bCbcIat9YE7bcFVdl8/YcrSs9cIilEv4XmNvKnOY7zA2KM4yp9vLs
 VXFFWdSQj4ZCEiBUXTqAYjA/R2XdT6RPhe1M3mc8JE6KKBABu4AdGlQQxenfKG46k53P
 ycHr5pRVJbQyAwBNSkPRv/E0t05d6a7q1Ghgrj4LNu4MZFlk2FO4MRZBB1MS4vunTlqP
 XFjQ==
X-Gm-Message-State: AOJu0YxHLr0yduYg7CxNUS5ghTtNUs68RLAzzDDDUouPLb81XL/g2vNy
 tNQTwYTh+St+jp/ux/JDW40lOLGimXaoXsBR6lc9rovTEhs6YWv6ydB9NLmdnEzwrBNOWv8U2E2
 92mU=
X-Google-Smtp-Source: AGHT+IG3Iz1kz9RE16QMQJJD4hWq2D6fEICIRasbCvOb4h09KuYhe11jCE5nMi09wK7Hse83r+EGGA==
X-Received: by 2002:a05:6512:2350:b0:539:f760:6031 with SMTP id
 2adb3069b0e04-539f76062b6mr718408e87.4.1728888993128; 
 Sun, 13 Oct 2024 23:56:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-430d70b4331sm145900095e9.36.2024.10.13.23.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 23:56:32 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
In-Reply-To: <20240910-topic-ufs-qcom-controller-v1-0-54c0d2231b10@linaro.org>
References: <20240910-topic-ufs-qcom-controller-v1-0-54c0d2231b10@linaro.org>
Subject: Re: [PATCH 0/4] ufs: add support for Qualcomm UFS Controller
Message-Id: <172888899107.195460.2874852527006773457.b4-ty@linaro.org>
Date: Mon, 14 Oct 2024 08:56:31 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1
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

Hi,

On Tue, 10 Sep 2024 11:50:09 +0200, Neil Armstrong wrote:
> This iass Add Support for the Host Controller driver for UFS HC
> present on Qualcomm Snapdragon SoCs.
> 
> It adds 2 ops to allow more control on the UFS device.
> 
> It has been successfully tested on SDM845, SM8250, SM8550 ant SM8650 SoCs.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-ufs-next)

[1/4] ufs: add device_reset callback
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/182e19225bbf66bae2280173a177c569e131c0dc
[2/4] ufs: add get_max_pwr_mode callback
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/b3f89c1d6ed47b7c7a6eaf854d3289dbfe31f332
[3/4] ufs: allow UFSHCI version 4.0
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/690db792cfe06ee072c35cc930be6f0155282eea
[4/4] ufs: Add Support for Qualcomm UFS HC driver
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/0c9c501a87e0070b944ffcd8f0d9942353048f41

-- 
Neil

