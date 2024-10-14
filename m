Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF286CF2590
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 06:56:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4400588FDC;
	Mon, 14 Oct 2024 08:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wfwOMXGv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4005488FD1; Mon, 14 Oct 2024 08:56:33 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE99B88FF3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:56:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43117ed8adbso42567255e9.2
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 23:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728888986; x=1729493786; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SMAxZaccOs/M9l+7M3eViYH7iC/iePLxm7vdI09tlXU=;
 b=wfwOMXGvxTXaJJ3o5+tuQIvEDxCBLYxURuxccaqWecl8v0/erLtvM4ClfrdqwmORVO
 T3jwePMn4tqUFtkOWEt9HZ3k68ml4eeqb4G7DSWMmw8BbqpXjTeNxVvkBvQUikzNyGfR
 67si3SWXFcPR16cHImC3XHaCoKf2rUV9elFxeKnllV01WoefNARrR+XgtU47NP9MV7xD
 u+WYT1+1K+iIWi7FvxWElr6sx+DkqQ7r4WJlB6YHbnApTJz/WG58MJ2+33auSCP0nIk5
 C0j8Rq47UX6dt1qm/+fT+Z2czihRNIeXi8j7xrkD4GkBhVdYdcLyQ59i2aUIinaUifth
 Fznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728888986; x=1729493786;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SMAxZaccOs/M9l+7M3eViYH7iC/iePLxm7vdI09tlXU=;
 b=qoLiYgkYxEhwLDGGcxoq9bXsbKm8iszmtto3/s0aoOvkdmolkqUb55NjR4+vMb6uM1
 fuHNFeQcLHFuEjxQhwUeAT0yTw7InVB87+deyykrnW72ZAzcad++lNynoH2uxhCsG3sP
 TX1MYnb9Mz65w/yssgBJJ09415Y7Ah7/RfG5ZND7T5G1xAqR8TUkZuXeYo4P9yn+4NhK
 rNU+x7XzeVOKoxC0Y7i/YBMXMKNr/XGsUWBeG5m8jcnynZM+z0jsg01z3LIbK4TruvHi
 89rY9iv1+CPlOFifQgvP7o3aPD8v7hBJvNu0RPLfQeSG2Hxb2stYO/X2tkKoQ++2A/i4
 ChJw==
X-Gm-Message-State: AOJu0Yz25AjuRFeZGXVmAE2obeVZ2EZR0SCyqd3VaJ93SQA/6Rd3h8v0
 BJnZngEmhxulWWel4L0+KtbSnPnFCx/eyUprqmk0wmBHhpXLcK2bdh3KbRxa9VA=
X-Google-Smtp-Source: AGHT+IE1Zwi+QAP3fs0yU+qiIT6+d7QpgB9I6UzGoOARJKc0IcCDWMKI97LtEYAAS22zFAGpFxY6pg==
X-Received: by 2002:a05:600c:6990:b0:42c:bcc8:5882 with SMTP id
 5b1f17b1804b1-431255ce9d5mr79664025e9.7.1728888985981; 
 Sun, 13 Oct 2024 23:56:25 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-430d70b4331sm145900095e9.36.2024.10.13.23.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 23:56:25 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240528-topic-sm8x50-ufs-core-link-startup-again-v1-1-146ca43e80b6@linaro.org>
References: <20240528-topic-sm8x50-ufs-core-link-startup-again-v1-1-146ca43e80b6@linaro.org>
Subject: Re: [PATCH] ufs: core: remove link_startup_again logic
Message-Id: <172888898528.195460.8818667815026924238.b4-ty@linaro.org>
Date: Mon, 14 Oct 2024 08:56:25 +0200
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

On Tue, 28 May 2024 10:36:21 +0200, Neil Armstrong wrote:
> The link_startup_again logic was added in Linux to handle device
> that were set in LinkDown state, which should not be the case since U-boot
> doesn't set LinkDown state are init, and Linux sets the device active
> in ufshcd_init() for the first link startup.
> 
> While it worked to far, it breaks link startup for Qualcomm Controllers v5,
> let's just remove the logic.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-ufs-next)

[1/1] ufs: core: remove link_startup_again logic
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/67e291d147cd40c9b638515dc1bfa3c52d390959

-- 
Neil

