Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E072C982E4
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:03:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6360F83952;
	Fri, 16 Jan 2026 19:03:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sWPEU2aD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AACA82BF2; Fri, 16 Jan 2026 19:03:09 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 404F7833C6
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:03:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-64b9230f564so3135832a12.1
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768586586; x=1769191386; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0K07tYhAmjEJjE/t2YQ6ZnNDpNGs2H7F6EsM/PcDqdU=;
 b=sWPEU2aDiWMMDLXpMnID+1o5auGXHusuHnGpag02jEGVVP1C2Uwk5McisUdSzwZvto
 AojEG9J+oqFOfotJ1j4qMBH05k4TXO+MoSUOgX6DoQy9rjstJrqbeYJ3SHMiRD91hLzV
 dBooVZh1uEh7KM/1jD0kZjfUEhL85Clx9YvaVWfw6QRaLEhT2hEmu11Q1XHbj87VKdSI
 eCHuCrd0bjSnt1fsl+CcdNm+Nw4Yd1iA3gJoQ56/cUNuyluQ4hjVsmQetB16FZdCB9f6
 tjGmu/nhdsrehUoYqoKH12azi7TfUuMJU6nZbcC6WRii1qXSlUXpabBiJ8V8VWkhId+e
 uTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768586586; x=1769191386;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0K07tYhAmjEJjE/t2YQ6ZnNDpNGs2H7F6EsM/PcDqdU=;
 b=kRgoIQ3p2QIp+2chjVeT71pBOA8XkI4rgeIdy+/MaJhXNUpgjZpDq50WjyoPiEe7zy
 jctb5BkjtdoFFM5B4G5UWCx1ZeQVntzQu6iiuTFSsTICIoYL8Ssoly4/OTGaLPg76VAR
 3AjLf2CTHfARf0rEFzQz+8rx4oq3w7t6EeFHvWjujTP7AD7dKd4zfjxq5JRPacwt4cEk
 4TM21DmodjoEZCF9GLwESd8GVNsYbwrKDNJeU5xbMbb1oHtg/jdUmraTbvsib5IN8z3J
 6qE1naFcQNnGfS2PHgqBxbwgeS4i3lYyaABQtg/uSWCZR2CvsR9xmRZqmMB2J2BN9ne4
 e1Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyu7U87KBp1r3PciqWSXpjCEyxPeh9VrspSN4RWIaRI04Mo6oecW7czrRsoWtxpVtvXpqJnw4=@lists.denx.de
X-Gm-Message-State: AOJu0YwSmS9vn2xrvUavRHlzn9OI5vM9mMUWfQvw8i31m6FMW8eKYKVr
 cR58bB4utk31uDzCCqowHSZ0AN09PdW/nEybQ7UEwgwdRB3p2c10iiWwwvB+Al9HKow=
X-Gm-Gg: AY/fxX7SRitCJ+9eOmGYqdI6nW1AFkUVAS36KSd4AWjlCwmQ+caIUCUx+S+Fg7YRzP+
 bUIe/AYP5iZRaeN8y4kIbJ2XXZm2FjKeLdxtMeGrP0+2b60RjTAI5v1FyTrwmEU5YKoP6TTRIbr
 rlHvQgHdZ4Ki84brzgmzDYuoE4kku/xHICT43lq3U2xUvF1Ja92CXnucDwJmfBZGm4erAQ4OLMD
 PJn0G/6VEFl10qR3u7QlEUqDks8YxAZ9ZzQV+w4GxejfBldIiP4fi+YpQJS0S/JHFjhtSTUx8yZ
 LLNSCweCPKlCX5cY8xU0jhH0EZJtuRcoHKrvb+SCipFb3FlOk1XcWsA28Bfjxuj6V7PotXwLNW3
 HfwDSJXSs1zqzm0To3KpXfKIkMvzDtwu09FFYiXXEWpXpuk9XbSTJbreePPplrOq4WCjFfCgHCD
 oXj4sqrBNuvL5xXRDraGpTGAW68NilRfwe1LxBumUCI3IUduQi4sO27CcyA03a3L0Q
X-Received: by 2002:a05:6402:51d0:b0:647:a636:76c with SMTP id
 4fb4d7f45d1cf-65452cd7767mr2701576a12.31.1768586585618; 
 Fri, 16 Jan 2026 10:03:05 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc5e1sm2932712a12.19.2026.01.16.10.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:03:04 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: marex@denx.de, trini@konsulko.com, mkorpershoek@kernel.org, 
 s-vadapalli@ti.com, patrice.chotard@foss.st.com, jan.kiszka@siemens.com, 
 u-boot@lists.denx.de, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20250627045244.2225303-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250627045244.2225303-1-balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH v2] usb: dwc3: qcom: Add delays in UTMI clock selection
 for Qscratch
Message-Id: <176858658411.3399278.17491928613536640303.b4-ty@linaro.org>
Date: Fri, 16 Jan 2026 19:03:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
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


On Fri, 27 Jun 2025 10:22:44 +0530, Balaji Selvanathan wrote:
> Added delays before and after setting the PIPE_UTMI_CLK_SEL and
> PIPE3_PHYSTATUS_SW bits in the Qscratch GENERAL_CFG register
> during UTMI clock selection for DWC3 on Qualcomm platforms.
> 
> These delays help ensure proper timing and stability of the UTMI
> clock switching sequence, potentially avoiding race conditions or
> unstable PHY behavior during initialization.
> 
> [...]

Applied, thanks!

[1/1] usb: dwc3: qcom: Add delays in UTMI clock selection for Qscratch
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/fba8fc4a9620

Best regards,
-- 
// Casey (she/they)


