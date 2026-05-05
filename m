Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E349CD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 14:14:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41D7E84956;
	Tue,  5 May 2026 16:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OGCW7iIJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3900B8495E; Tue,  5 May 2026 16:14:31 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B6AE84954
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 16:14:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso45037935e9.2
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 07:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777990468; x=1778595268; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XpWVbqQDchzyYJa3dPNcHuAtM4NXvXVy0CshiIL6qdw=;
 b=OGCW7iIJzeOxlWgfXuOXxaKvepxDDbaTNV3cuC15ZppSZ7t5rX1osv35MheObNy7Uc
 EBEM1EC61/FfmQF+1GTckuND3lmRvsbVR/yMdDTnaW9I1p2AhAmU1h4soAydpSE92s3O
 j3DB3maOrAPeVbAi9gad5MAjqHbJOZd3iLuJEC+A2M3sKIelR2zqohcb7WknpSZ40a6J
 cBaWTS5XUWwO9qG5O+h1LGEHwlg+jeRWoO8svmS6DUNe4oZ0AbIkP6thAjZ+rHCZ7jMW
 PA4Lsw42y6cBOi205MP2dmt6TUKVy5HMB3LCm2xnVYxbJYk+/meUxJ+dIv8vQrmJnnjb
 xNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777990468; x=1778595268;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XpWVbqQDchzyYJa3dPNcHuAtM4NXvXVy0CshiIL6qdw=;
 b=OmHSzSmaDUPNo9a+f6u+P/MDtnPFeN2N7y7m8vQ0PpS4d/HqvVcZEkx3cQfNLzCSE3
 UoBXoreKWpbAGEozbTI0dBPQNopQ88sJaZOMu5BBbNVCRC/vd41s700jnd+iIHJsFH7/
 mJccY0GvSR/NVh5IvvEsoLx4v6N9dApwo4FhTzVGus9yEEnN5W/Zlk4FKIPB8fLlFYdd
 m8mF0EgC0cbmVo89VcH7LOFFtlSfWb+tJa6Hl1lm+ap4C1C89xADizukWTCjQorLroKw
 FwF7GPp6Mzr42VmtwkzW/sZbMqKQcBNxS6dY3N09idfrl7Cj02KX6I5Y/QivgwCaMOzk
 qfUA==
X-Gm-Message-State: AOJu0YzySAbyHr5C0mlS0sTyM4Ssjnpo2yUQEZuOZLVc6BlMZAxre99T
 NjjFsDp4r1pCJAIjprr+33cAYIjW0jVScXEqR9Lv0Wn4kEQoP3qifYyBRLmGxr6QQZo=
X-Gm-Gg: AeBDieudlEqh7mRhLZSB98GD7Gs0x1ur4frOy5SjMkMoz7SfwXo/+TpMaGhKrNTGXme
 g433WqFiZ29+OYDGgc5W7WhlXPOKvm924xMm9VVKlkk2DJgsV/YZyzGRxxWkW4mPEf6ooukPwJA
 W2/VcxNT2XJJOF7jwLKPjyvE1+OoR15kS/WfGK4Y3hTDRXYn0bQBf6ubmefXbAv+vKHw0OCse0R
 hld3bDJGZK3NcMDF5SLeA+AjRNAUy81wYd0Q6bUixIWIxqy98ayHkNgjOKfIyDw2SCee8E2IhSB
 18Fy30ApZsZlKPLyHfh9AhTXlZ8ejzyVcy2ZvR0th7riVn2C5o39SKOEJDQg6VRv7Azd/IoPowq
 sX4pHuP/EQfsdyOBHHTd1BUc+KPhSlqiNLtUcNAFp4Cy4vTtj9FEQkqT3wKU3eZmR95It90zDsJ
 Vfr+rVjPH/ZktZUZ4TxbpjuIuUikUv2XjTD2uhN9kByKwiopBbHJt6X84oNVQmX/8ljcoeFfDSB
 dpZnDPYtfuM4GjcYw==
X-Received: by 2002:a05:600c:35c5:b0:488:a977:8d6 with SMTP id
 5b1f17b1804b1-48d18be4578mr58283415e9.19.1777990468012; 
 Tue, 05 May 2026 07:14:28 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eb3427fsm581408135e9.0.2026.05.05.07.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 07:14:27 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>
Cc: neil.armstrong@linaro.org, trini@konsulko.com, 
 aswin.murugan@oss.qualcomm.com, u-boot-qcom@groups.io, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>
In-Reply-To: <20260424104237.968195-1-sumit.garg@kernel.org>
References: <20260424104237.968195-1-sumit.garg@kernel.org>
Subject: Re: [PATCH v2] dts: lemans-evk-u-boot: add override dtsi
Message-Id: <177799046708.839461.5305062197937898253.b4-ty@b4>
Date: Tue, 05 May 2026 16:14:27 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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


On Fri, 24 Apr 2026 16:12:37 +0530, Sumit Garg wrote:
> Add initial support for the lemans EVK platform based on lemans SoC.
> Define memory layout statically.

Applied, thanks!

[1/1] dts: lemans-evk-u-boot: add override dtsi
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/fbd377377038

Best regards,
-- 
// Casey (she/they)


