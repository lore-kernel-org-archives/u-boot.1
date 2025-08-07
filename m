Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74CBC87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 14:29:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F173384514;
	Thu,  7 Aug 2025 16:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JhLZXfk+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0D868458B; Thu,  7 Aug 2025 16:29:06 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50A5083C64
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 16:29:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3b78b2c6ecfso568448f8f.0
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 07:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754576943; x=1755181743; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ixLzX6pWANm+tdBvk18d0iphsP6RWtHNc15Vp1MskDo=;
 b=JhLZXfk+19//3WCRG/qGmHq3usxlKzZQZpoe6rBBkXw7iZ15y1VakQ5tdT8gl1CQ18
 Dehb35eAbH9p0Zx0h7RqqviSTs/0TB9Cv6mln+F/QJVNyT39rp3Zz/Om3BibtDGBOv0q
 VsXjBjXd9U/Jv5HnPwVSU2BfGOc4vUdFOj2RIkT0Ic6PB81J6zIQrpDl4NxLwuGx2j29
 7Jr2e35+8bQBhdBC0Ecf87P2b6CrhWleDHFfaRNzLmbxZ5TUe0qp8nWqVTWJTqn780MK
 5e0oxy6iTvyA22twrEAZK7bpJJcpd85pTh9GS9tvYS6PXwYhWlS87tqBTh0WnVo7hzaH
 wuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754576943; x=1755181743;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ixLzX6pWANm+tdBvk18d0iphsP6RWtHNc15Vp1MskDo=;
 b=oWEDa+jc+lzmTEf/iavxh/HO7aJw4Aa4XPQ7Cgs/vhr0qMbGOWzktSX25Yn7p/N0cb
 WZ7OgwG5fg5NsYn+plx2eSEH8LvatnIc8mWcdbw2mIBOko4mzRbm6D8blFEAl9tKPOCk
 q4vgJ1YzzqoLcaXP5IwlA0ViJJTPq8d9xXu/X5v6qBm1MX3+Ww/fV06UsLM7l5mgsBtT
 /ISeGEKigkVVi3+qoDOsnG9TbMk6mfZRN/frCm8TDsUecuBwl4qWOCLHvOF6awSjQnNB
 s9YLR78d4jqC0uk+hbgYet44BHiPBB1Ix0nB2QiR1AfMEpSSwscg3sswdsJQCh5WpDmJ
 degg==
X-Gm-Message-State: AOJu0YxESfxOiTO773rz/eDWRusWFlp+hHLYrbBD5IALsiqLICIzEBwV
 OivzKQNcTD62dVoRDV9xmIk+wx3h5vtlgoRJ5WSZ3VHty3D83HMaGvabx7oY1XVPe9g=
X-Gm-Gg: ASbGncvlEOmMoNr1e94NJh01fvqOaavVaYc5vNnAOUZyKsghve3LpwGowz46FAtBepP
 onMGlxkno/LQmAFAdKodb3qnWarnArxBTLcHlvcHiuyK+xovh9f8jkGrlGPybEaiT/FHosOKVku
 RUEDi+UhxabSYKX/RvPTbJ37QK01Np2N4sZJoVbrIUlKSHM1c3D56x5oTlP8x+JEde4Ef+6/y63
 fKXTNiSx+/fCTm6iJ2bUuxgNpjcmewpB9MrA27olOhRvYLA4ahvibbxdlN7HlRhIBXIDTminwM5
 emuXQzyCdh/+tNZqkdDuAiB6Hz2ZbaPsajrmUT9EU5S3uPOb0WxHzADebYwMp8CB3stDX70Cg1R
 wGhzYYv5knbUfTeaL8TDQikp1NudQILYCW1ZFEjQJd78SPFLYMAk=
X-Google-Smtp-Source: AGHT+IGn1Dij+NlDJFYYw5YzKg0w23oIUfdAmmB3dAfG9iN9nsqOdEYutxOWTNf74aGaIeIubYL5ng==
X-Received: by 2002:a05:6000:26cb:b0:3b7:8c83:db1e with SMTP id
 ffacd0b85a97d-3b8f41ab660mr6337527f8f.33.1754576942689; 
 Thu, 07 Aug 2025 07:29:02 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c453ab0sm27349027f8f.44.2025.08.07.07.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 07:29:02 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/2] power: Address two Smatch reported issues
Date: Thu, 07 Aug 2025 15:28:56 +0100
Message-Id: <20250807-power_misc-v1-0-2ac672f15461@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACi4lGgC/x2NQQqDMBAAvyJ7NhCjNsWvSJFNuq17MMquVEH8u
 7HHYRjmACVhUuiKA4R+rDynDFVZQBwxfcnwOzM461r7tN4s80YyTKzRPOoWo/Oh8T5ADgIqmSC
 Y4ngnE+pKcotF6MP7/9K/zvMCpggDmnUAAAA=
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Smatch reported issues with two power drivers due to redundant code and
an unitialised variable.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (2):
      power: axp: Remove redundant code
      power: power_i2c: ret is uninitialised if not DM_I2C

 drivers/power/axp818.c    | 2 --
 drivers/power/power_i2c.c | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)
---
base-commit: 3526f990b77fca1c933f1d8b24eb9385010a05bf
change-id: 20250807-power_misc-635ac27b477b

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

