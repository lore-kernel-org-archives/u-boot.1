Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90726ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:12:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B21488F65;
	Tue, 10 Sep 2024 11:12:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eyXOmxwZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 859DA88F53; Tue, 10 Sep 2024 11:12:05 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FDCA88F63
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42cacabd2e0so4534435e9.3
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 02:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725959523; x=1726564323; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oZuKX0SaiCvMCDc93c6ZGRD6iIgRSRLleB78AvZJ1+w=;
 b=eyXOmxwZc2vztRZkcjA/pf4xw3aRgknSncGgu7jqMRpC/QjSprI4oXQw49XItWzScN
 xyzxSwQYp8IyEaGr/XlX8xLIhmD8joAE8a2dsYYPJoz5h51R02j+i38YT+Pzryx3gkAQ
 4jbY6AUs39hlsPoWGCPgzp33YWFdMAMgtSkqmKbv5+NBHOr9z3VeBkHcTT0p73uJsT+0
 diBYh93s8Tr/IbIHhFXSMkVnTdZkXwvjUG+YW9DdkAQ061YmtyDu+6wU9jf6vVkD61Vt
 WUOwyLvWpuOWk3zGxSc8q7ambtQLEGLH6mE9rwuZFCK3anh68QVw2EjoytPkjzI6I98B
 RTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725959523; x=1726564323;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oZuKX0SaiCvMCDc93c6ZGRD6iIgRSRLleB78AvZJ1+w=;
 b=OLH62a5CO80vvszdaYKLXc0vjxWuf/LdqJRs++N+uA55yjX+breksh9ArRPZWjEC7v
 o4X39H1ujYkNvfrvojEIsWiJWWJ3BFcKi3hnvDNRTdMnw8q80jk817TdzlG1z1IoxTuW
 hG5p2CX0Oe8fQcbrtJ/gn3fVHaUoro6Z7IaVeTL/m3+Y18YF/o6Hd2x5Z0Z3BbIY/wAo
 Rexi+IXkxAVBpKXk5XjOd8en3UzIT50Wx988ioqL1CMXZ9ldo48E869DINFQon0PnSlL
 9eX0z0mWbjQjB2/04dFdxD1gBig5GoMKm10jptoyB0ruEwGCuB/9slQgS+mYFXru/CUH
 lNqw==
X-Gm-Message-State: AOJu0YwPMwnec2oQ441DaU3UumwaE8m9G/sDq3iuSgiTEj6y/vJP/7md
 xIlfa5+WCEQgGXHrXEMsvK8116iD+5SXVTA39F6TCMMkMmkVNtFED9ssBWaAB7uH/Say0wCWjnv
 x
X-Google-Smtp-Source: AGHT+IHZt/f9ARD6q1Ra+qfDC74uz6rcyb/AxCROXfqp/XxH2y22FDQ3bt4PXT6Sb1tsKHb5Dnmzhg==
X-Received: by 2002:adf:f88c:0:b0:36b:a2bb:b374 with SMTP id
 ffacd0b85a97d-378896c81bfmr8321714f8f.52.1725959522536; 
 Tue, 10 Sep 2024 02:12:02 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895649733sm8294798f8f.8.2024.09.10.02.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 02:12:02 -0700 (PDT)
From: neil.armstrong@linaro.org
Subject: [PATCH 0/2] phy: qcom: add QMP UFS PHY support
Date: Tue, 10 Sep 2024 11:11:56 +0200
Message-Id: <20240910-topic-ufs-qcom-phy-v1-0-21ff4b87b962@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFwN4GYC/x3MQQ5AMBBA0as0szZJWyS4ilhIO2UWtFqEiLtrL
 N/i/wcSRaYEnXgg0smJ/ZqhCgFmHteJkG02aKkr2SqJuw9s8HAJN+MXDPONprS1la5SZWMhhyG
 S4+uf9sP7fg9t9BhkAAAA
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1921;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=xgqAgQP6onANXv7zmYO85wb8PmmvDyYBNBqpl562Sp0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4A1gfoYGdTa/YNwFxhKc/EcBX+z/oP0a+hG0CMoQ
 lfloskmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuANYAAKCRB33NvayMhJ0YjDD/
 wIUZKhvj9uqdwUTVB8J6wkAz/pUzEYUuLO4vGc0b6R/Bipm44S4q6mKsnvnUT/ceZMCHdfGiJS06zj
 LJGUPtz1dQLTJcsAlpo4OXYg/x98+foKaP/pYBtwcd2U7YfzM8cBncZKRwoIrCAlhDzKsRIQQVwz19
 O69aFb9w9u6kocomEQUBhG0ek2JXRexdoVCZ+PqjUZUudMvXUMlYotIxWjdkv3fXuOhUBk7d1g9bLO
 6nlKo8myIoyuYJWGhtcbef8vMME9P9AMBjOyEOvOr5+1wzqbCASdXhRZ3vkOraaiWu439obibG7hEJ
 NmyiQ3BbRjjDiEpQO7os9NHPGtcLFJuAsiALaJdGFcFZQr2Tkv9twGfCbgFKP6vgaarRLMc6W4xOvy
 XbtM2nzqfma261234Pb6MMc+Xicxqmc0kHS8Srl547JXzWQzvMYLql0+dp++ANyx0C0mgDcX/1vCYd
 VGhyCa31hO0fbgML72B8AG9Avw5gXlAoZRJ2O3I1NVOrBkzhVEqBf7JQu2WWMX+Kkc8XtQmHYtFQSg
 RHfZkJ74h0AmMS3n/gBhkYNMMkWYqZKA+/6fdeu4Il0T0q63vzVVWOUB3py37cNQbtDTCj8qHf1SD+
 9AMJ+9rhQ4fHM/WCpq7ejd9GQJiKvCOR7XcfS3OtVhmim/YklfVyNO8z+RlQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

This serie imports the QMP UFS PHY headers then adds
the QMP PHY driver in order to support enabling the UFS
PHY on the SDM845, SM8250, SM8550 and SM8650 platforms.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Bhupesh Sharma (2):
      phy: qcom: Import QMP phy related header files from Linux
      phy: qcom: Add QMP UFS PHY driver

 drivers/phy/qcom/Kconfig                           |    6 +
 drivers/phy/qcom/Makefile                          |    1 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v2.h         |   25 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v3.h         |   21 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v4.h         |   31 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v5.h         |   32 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v6.h         |   38 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-v2.h             |   43 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-v3.h             |  145 +++
 drivers/phy/qcom/phy-qcom-qmp-pcs-v4.h             |  135 +++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v3.h     |  111 ++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v4.h     |  123 +++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v6.h     |   89 ++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-com.h        |  140 +++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-pll.h        |   69 ++
 .../phy/qcom/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |   52 +
 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v3.h    |   68 ++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v4.h    |  233 ++++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx.h       |  205 ++++
 drivers/phy/qcom/phy-qcom-qmp-ufs.c                | 1116 ++++++++++++++++++++
 drivers/phy/qcom/phy-qcom-qmp.h                    |  115 ++
 21 files changed, 2798 insertions(+)
---
base-commit: ca55cf8104c0dd78aae45fa66dd8400ef1b3d0ac
change-id: 20240910-topic-ufs-qcom-phy-c3d5d0f4138d

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

