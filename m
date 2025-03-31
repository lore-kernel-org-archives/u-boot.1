Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041E8C3600C
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 13:35:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E447581F6B;
	Mon, 31 Mar 2025 15:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FtoJljpr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E378C81F32; Mon, 31 Mar 2025 15:34:49 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91DA381ED8
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 15:34:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so26758075e9.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 06:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743428087; x=1744032887; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Xap0I4xxcEKx4IMBGo/wOQgHetfXOE+krLZEuuyOKs=;
 b=FtoJljpr23qli1SVNU01ML5UtU3Qxhnyq7XcpnVivaTkZGfCgOXS1dEci5KPVhJ1LC
 VDuHzcxhLgWRfflBW/0IK3eAbrgJ1CSIXbwS04ZOiW758sFIv2Qy1CMAe7nkWjOGGc2J
 vsi4BJPuWb9ZPNl4XDs22ZQpZGCqPQAAnbL8zTRGmhWp2F0y+O68s8RSzX8qovXyg76b
 F0KuI0/ZKZVkdVFpkioTJgYXZWmSypAK99l+N+AahlnAAUj+V3/HSjTv+vjMnWkt+jm1
 vW+5RyGZbH0kSwnfU4byZnjeKG3Uoc3HvfOHjcri4dBEzzkHvjpGFkNK4urZZ9b6VYII
 cIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743428087; x=1744032887;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Xap0I4xxcEKx4IMBGo/wOQgHetfXOE+krLZEuuyOKs=;
 b=TQNvrdkhCdMXGG9gBzUrxAJAfEmuCU2PGGzAhDLddLbSFmB2YYZ0K+3fTp5pqGrtO3
 Qg9KOlodnshxHrba7S4nvm8RKz++5wLHcTWVie96YB1eVcmZiZptQ3QCgV6FRFm/odcG
 bcIlvOJFB8k7nWS7/EcDKFKhTH33iv/qqhYJR7TLy5EmqOyzZ2kix+PZESFO8JfS7+Tq
 9ExkZ7j+P9pVLXGXFRoK04SoK80aJSygSiynwlCGa6yXjdg4mGE3mOur0S/FBD7esWno
 T65c3sPtPIOL6YqsS3QZVoLaPWpjWLJaiX3ophQj+BQaSV6XpQhd+1NqUcEd527dsgoK
 B77g==
X-Gm-Message-State: AOJu0YysAVM+Zci04MCXYiFLESr5YgRGLVf7ienK4jT75RF4LT/uRuei
 MvgHVc/W4wrzv0tcA/eQqISlrinWwRqLPt0hmGMLwdvPINMpZJ2JdPUktkF8xq4=
X-Gm-Gg: ASbGnctkS2mOJ155xSzdDDSaUBqJ7SzC6D2p919cSOAdgnM9FcQ+MgfcQ2FOcZt40ad
 f9VpyFUgzPUtDHburnI47/OGXIsigbwVcaclluH0MhRaCbBFC4kd8/V9lvc+XWaPX1ONzqvRhnS
 QjEhw6HTikKGxZia3H9Nnd0nnctN6T53tsvOFWhdn7p0EdyrthLztnGBNTdkwq9/9nJVRHH0yp5
 bUeeD4WurmGOCpjfpcc3f3SBms1EFSKaF79Egv3sx9T/mJdmlMUxxM12odVn2A/lxRs8KyaEHjC
 eg/BwbEkcojZsbFFKSPvzc0cjNQw/EP0vw8dVuOAUraE+CuFVSzWgS/iguEUIX8O8ad2qbpATdv
 koNxfaMD6CB+N
X-Google-Smtp-Source: AGHT+IFhsDCXoee3ahfZdcMGdDAjVikIhCBxSKwKAsQQvPRzV02Clyup5e5e1i5ofOQcFvZQNZWdZg==
X-Received: by 2002:a05:600c:8718:b0:43d:b33:679c with SMTP id
 5b1f17b1804b1-43db62bd881mr82603595e9.14.1743428087041; 
 Mon, 31 Mar 2025 06:34:47 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82efe389sm164266095e9.19.2025.03.31.06.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 06:34:46 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
In-Reply-To: <20250324-sdm845-fixes-fastboot-v1-0-d177a10f336d@linaro.org>
References: <20250324-sdm845-fixes-fastboot-v1-0-d177a10f336d@linaro.org>
Subject: Re: [PATCH 0/4] Qualcomm: fix sdm845 clocks and enable fastboot
Message-Id: <174342808552.411395.15058256698762279836.b4-ty@linaro.org>
Date: Mon, 31 Mar 2025 15:34:45 +0200
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


On Mon, 24 Mar 2025 19:17:36 +0100, Caleb Connolly wrote:
> Fix clock init failures for USB and UFS on SDM845 devices, stub the RPMh
> clock controller, enable DM_USB_GADGET and fastboot support for all
> Qualcomm platforms supported by qcom_defconfig.
> 
> Fastboot isn't super useful yet, but can be used for flashing MMC
> (either internal or sdcard).
> 
> [...]

Applied, thanks!

[1/4] clk/stub: add sdm845 rpmh clock
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/f1db41b320b7
[2/4] clk/qcom: sdm845: add GCC_AGGRE_UFS_PHY_AXI_CLK
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/15cde58aaf5f
[3/4] mach-snapdragon: enable DM_USB_GADGET by default
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/7235dbedfce3
[4/4] qcom_defconfig: enable fastboot
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/af2bc4c21dd1

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

