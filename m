Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E439EC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 23:07:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D78B87135;
	Tue, 14 Nov 2023 00:07:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zeQBUOa9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D37E8715B; Tue, 14 Nov 2023 00:07:07 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AB438711A
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 00:07:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40a48775c58so28477505e9.3
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 15:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699916824; x=1700521624; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GdJkpDly7nQ59xxNV/FNlK/pF6HAa6URM9A2hmrPmJE=;
 b=zeQBUOa9I+k5grTAbgPe6ufhG4ymmySafs/y65ItP5KZMPWhEyqHwxHASSwhdnIoyX
 z+FP7XgQO0Zak1kTB2qk/EkvgHneC9666NU4P5O7fdu8r7695y2bxKhVRX9RJe2MAVB0
 WsgINmRZVBOZTEaz2yFX7Sm534PQjSbmlhpzxMqjzfPDtIe6/gE/zQ8vLidanLmiuUOs
 oJh07wmS3f0Wq3QZRBerVTMQpSi2lfjfTshQ/GajiQATnhVGOcMdbty60D/JU7eeR5Kr
 bVvOIWGK7zConuo+g2tYLsXE4dkHjTak+Jh8gnIkw2adjBWhR8m9m73vB0OjgfX8B7Z8
 i8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699916824; x=1700521624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GdJkpDly7nQ59xxNV/FNlK/pF6HAa6URM9A2hmrPmJE=;
 b=Na/7rHeRUhu4Zot46c0JihfSyFFPMXqFTz5ZzeTH7MZZdQEZOT0zlAiB/s/AcTFKdA
 0Otq/KQKRwj4eV2iIRQXIYAquSaIWH1d5b0HDuakGZF34Ue+yvSVEm1QmMvsQSKEE1qy
 ywTgw1KtrOUmX1VAJisTL0QY6SbMqz4hbjmq36edyh4W83PxU/CWY5dtuIMKI3jsVJGI
 QiDp+cpCPV99SnA2OUS56VvSrLEgxllxtj4+DxQK6ye2Cf6vHZ0PiXFTXBwKH4GX17ZM
 X7YZkpDq0eWpSigqnSrZc8me7RPx4HN1r/HvLfvRZE0Kg2bGHFOZxVF1sIoF/iCWK+pp
 Wsrw==
X-Gm-Message-State: AOJu0YxWrhqip81WAtbDta+hza6yAXOI9Jc1oRDyoQMfF4kKQekNmL+q
 sxfz8gdjeW+5YDFuh94mhbEJ/g==
X-Google-Smtp-Source: AGHT+IE9y1BXhA2Er1wkvZVnreZItpI2Xxa4Am8PVk1GNqnG8ofynBe41IM7pts2vPbHkyxPwHMC8A==
X-Received: by 2002:a05:600c:4ba4:b0:408:4918:590e with SMTP id
 e36-20020a05600c4ba400b004084918590emr6676386wmp.39.1699916823990; 
 Mon, 13 Nov 2023 15:07:03 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 fm14-20020a05600c0c0e00b003fee8793911sm9286475wmb.44.2023.11.13.15.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 15:07:03 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Luka Perkov <luka.perkov@sartura.hr>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@linaro.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v4 0/7] arm: mach-snapdragon: Qualcomm clock driver cleanup
Date: Mon, 13 Nov 2023 23:06:24 +0000
Message-ID: <169991598626.263291.4130847777956287757.b4-ty@linaro.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231107-b4-qcom-clk-v4-0-82bbaf1a796d@linaro.org>
References: <20231107-b4-qcom-clk-v4-0-82bbaf1a796d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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


On Tue, 07 Nov 2023 12:40:58 +0000, Caleb Connolly wrote:
> This series begins making some headway towards cleaning up Qualcomm
> platform support in u-boot. The following is a rough overview of the
> changes:
> 
> * Move the Qualcomm clock drivers out of mach-snapdragon and into clk/qcom
> * Introduce per-platform clock driver configs to decouple Qualcomm platform
>   support from mach-snapdragon targets.
> * Add the IPQ4019 clock driver, removing it from mach-ipq40xx and introducing
>   the reset map.
> * Merge the qcom reset driver is into clk/qcom and rework it to be
>   compatible with upstream devicetrees.
> * A callback model is added so that multiple clock drivers can be
>   compiled in at once.
> * SDM845 gains support for enabling/disabling all gate clocks (CBC's) by
>   way of a new "gate_clk" abstraction.
> * Preperatory cleanup work is done to simplify the bringup process for
>   new platforms.
> 
> [...]

Applied, thanks!

[1/7] clk/qcom: move from mach-snapdragon
      commit: 5bb0df6d39dcd6fb1256535bd0b1eac747b711b1
[2/7] clk/qcom: move ipq4019 driver from mach-ipq40xx
      commit: 67d532d6354bbb0e0a03446fa0ab7b4996cf643d
[3/7] clk/qcom: handle resets and clocks in one device
      commit: d993573e5084a595a8ffcc01ac471d5fadaa634f
[4/7] clk/qcom: sdm845: add register map for simple gate clocks
      commit: 6985e30ee0310de9bbc083dd03847327691dd2d6
[5/7] clk/qcom: use function pointers for enable and set_rate
      commit: 839739c4f10f7ac0c43cffe06d3e402ccabe37e4
[6/7] clk/qcom: add mnd_width to clk_rcg_set_rate_mnd()
      commit: b49a6531738b2875f3d3b22c8d28b9dbdc5573ef
[7/7] clk/qcom: fix rcg divider value
      commit: 45b9e9165409691b02cd761fa44c8dcc5974cf29

Best regards,
-- 
// Caleb (they/them)

