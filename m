Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35881C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 13:36:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40DF78407F;
	Fri, 11 Apr 2025 15:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="p+cZueq2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B270884051; Fri, 11 Apr 2025 15:36:18 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3816B8405E
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 15:36:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso14043185e9.1
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 06:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744378575; x=1744983375; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sORCJjnnYKETdy3TWAB0wtosJHyD5tK1lMWWnal5kl4=;
 b=p+cZueq25IvR35xzAHxKt2Hn3dcv1hhIS/mUQyNHff8QxY1ja0JhckdejQaR2rfDMZ
 FERA/AJ96nRXmy0PI6I1VDWmFx3bhmeIyPMAiJwv7qPKL3VlzhkNAl0zqtzXgCirCQP/
 k3gMCTJxay/P0cGDIIfLBwJQxJ5aVHTHAw+bODWO10I2VkQF9aj1GRbX1bWRtKPBJaSF
 mZydNTPIJFogBnS/vRbt0isRSy/1lliedxdc5SMm7UoaAhmIND4MQXFCqu6Gu9b7+hwP
 OonJBmyAHRQmUaDkZ1d5jz4VTEPTDtE3BRPpdLfIu6CkLTJKQePGwUbGho7QAEDp6CXH
 qSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744378575; x=1744983375;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sORCJjnnYKETdy3TWAB0wtosJHyD5tK1lMWWnal5kl4=;
 b=R2ihXiBI33rcECgoDhI9BI+6TawLj+41k+qeQ3VK2omDgS7+f12kM82S+l2OgacBfg
 VlW4j+BIEJ3uu1oxU7ieZiL4WrhRPiDQd178LuUNyhVR3t6PdIOKkdsWvhvYAWoD1305
 m/zLZCf0FqdT9hNO649PZQiezox2WZYjwF8u0pUzdrmoUdSYo00WaU6r2zwtQSmC2OnZ
 ap8juHaTEruWPmXZDn5IRnlbvpYR9Rk5kH3B7oP7JYvsYzaqG4fW6h1qMlTne57IyUjL
 J6ciccfoaJHdw4QZfoltduwEOdqm0Pyb80EhgXMlPG6UB9oA3oIxFakqVTP+FP7AnBGZ
 RBSw==
X-Gm-Message-State: AOJu0Yyw1TJ8cWXSRFZ4AIOlzFafppb4+EfvA7Ozli3bgEj7yrNoVR73
 TRM4I7ogMVTbXZYMw5/PE4H9WjIFPh1uY21JJlY4/5fq7SCV2ds6ppsM8GJ/PNU=
X-Gm-Gg: ASbGncvAjUGdKc/H4zBAP5ufGCcdgUhI6bzo3jQ8IKrRyEU2zzY2WzpKi3u/zNeL4qN
 2pyXSnz+HAH07x34YRrBwsFa+Y54P3GSdbaiMglYm8bb+exjpxVEgfwwzDsBtUsqFAMK4ee6kiO
 0VkY+4VblnQ0fOd056ojsqCDABRI3GHkza5IDtnO2noh82ZX+n6+ruFBz4D00ULc3dGnaF1E5Zc
 azV+7Pydgu+mF/Q+p9rkHLBggS/sONCT3fJ4LrpFYhRiKXEC0ZWOC5uEge2PnRCso1OsssONMFc
 zQ3lj/okJhlt3GkjOiD/+i3uCyu+yCwhJ6XHGa3jtHktOpoOuDcEi48uPrOS/PW1f6tk/kSQ70K
 YLck02+LjVxGdRqIh4Q==
X-Google-Smtp-Source: AGHT+IG1NS80r9OiPt812HAhKxtJp4Sr5mTJyBMXJfCm7JPGObA2caEBLfd2A6+SURk8XH5WNLwRrg==
X-Received: by 2002:a05:600c:1e14:b0:43d:ea:51d2 with SMTP id
 5b1f17b1804b1-43f3a93f681mr25822675e9.14.1744378574637; 
 Fri, 11 Apr 2025 06:36:14 -0700 (PDT)
Received: from toyger.tail248178.ts.net (35-60-142-46.pool.kielnet.net.
 [46.142.60.35]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233c8219sm83195365e9.21.2025.04.11.06.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 06:36:12 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: neil.armstrong@linaro.org, trini@konsulko.com, alexeymin@postmarketos.org
In-Reply-To: <20250410080027.208674-1-sumit.garg@kernel.org>
References: <20250410080027.208674-1-sumit.garg@kernel.org>
Subject: Re: [PATCH v2 0/2] RB1 fixes
Message-Id: <174437857232.2613234.17852939354900503676.b4-ty@linaro.org>
Date: Fri, 11 Apr 2025 15:36:12 +0200
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


On Thu, 10 Apr 2025 13:30:25 +0530, Sumit Garg wrote:
> The eMMC on RB1 boards supports HS200 mode but currently the msm_shdci
> driver in U-Boot is missing DLL configuration required for HS200 mode to
> work. Hence disable HS200 for now until proper support is in place.
> 
> Apart from that, add a fix for USB PHY power on sequence which got
> broken by recent addition for SM660 platform support.
> 
> [...]

Applied, thanks!

[1/2] qcom_defconfig: Disable MMC HS200 mode support
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/49cf3b29134c
[2/2] phy: phy-qcom-qusb2: Fix USB PHY power on sequence
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/45acd9d2d4ec

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

