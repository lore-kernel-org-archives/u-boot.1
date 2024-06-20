Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1314C27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 07:43:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5AAC87C7E;
	Thu, 20 Jun 2024 09:43:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="px/lIJNe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89D55809A8; Thu, 20 Jun 2024 09:43:10 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EC2C87873
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 09:43:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52bd48cf36bso646211e87.3
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 00:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718869387; x=1719474187; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=282fyFnlOqpclU9yoXXhdOW9Bq7g6LJgGe3tMA067NA=;
 b=px/lIJNeWl4rfU2QZgG7qYViwg/cQNAVL7bd5JL9I4eN3LW+5FyH3VU2cCdokbEzIk
 9/r8YZfeaQewiTPa2D6qz7NvN8OHBFc1NOzCBkpncXtr0nYrgQeWGNa30nqDjOpIffxy
 7+0BuTPcPGZCr38S49Pp879Gbfkjtna2YXPu5E8/u1P5HYVXNpdk/A3lEJX85V5JY+pH
 ADOqPpibJMGFFOnLyHbL64oj/cm3oOl79U6HKig6a2TXhx1C6+byzc4nF9BrK2MrNNCw
 KEN6NLDfJsVod1hFc/jJsUZqK3uaheNvZ7+HpMNhY+z4/IGiOY177STj23jE3c5VefQy
 rOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718869387; x=1719474187;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=282fyFnlOqpclU9yoXXhdOW9Bq7g6LJgGe3tMA067NA=;
 b=YtFhXMUPycC9F3Gt5FiVnHSU2rg+4Wt4LWoCTb1SIY08UWTAr7KdJX8sAlXnpQIrCj
 pjgfDVT6r8CBNnBlWVgtflypinliwYZqLL9n8w2MLr6okrs50pmsBiZmkKsQMyP2f4y4
 fTJshcdBrHbAlqEAkG1VjqFVKux8bN+Q49W1BHR0tH+edmLfiMn92VWGAnIQ8gX8OKf+
 cMKAz7m1pasSu64GowREQFh+QlBXLsQzBk4YoAwsuEaDAmewc6jOwm6lwPCuG3jaeqwl
 IeTFJAOYeDUrzBqFYX6sOky1tQC27haWsC1vNn2GMzCIKHHHwLaDpH/9kweNU4alcp7O
 SHGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe18BitKgy5buk3CD5X2Je6XvazqJKkOCdbP2HtBlo1iPAnR2M9K537gnj5D/btNnCgpNjpV99nnlHgS72lzrY6vqCcA==
X-Gm-Message-State: AOJu0YzK7cxMM2Zbaen6IUZZGxfZwFRDBrFN6J/smGiC1ygfS/panzOn
 G3Xt2M7yG9LN13r/4B86gq7AAo8ku6EKuUgiHFQ2vRG1zZEE44w29vYxGA6i/vI=
X-Google-Smtp-Source: AGHT+IEfEhXio9e0Lgo6onLFfma6GexW0gLj2sp1fwjvg9O+wizME77LhQOfaTNAm4+Xs6ZblC6/yQ==
X-Received: by 2002:a05:6512:31c7:b0:52c:90ba:9705 with SMTP id
 2adb3069b0e04-52ccaa8862emr3998596e87.49.1718869384872; 
 Thu, 20 Jun 2024 00:43:04 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d0b6402sm15506785e9.10.2024.06.20.00.43.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 00:43:04 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/5] usb: meson: switch to set_mode callback and other
 cleanup
Date: Thu, 20 Jun 2024 09:42:49 +0200
Message-Id: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHndc2YC/43NMQ6DMAyF4asgz3VFQkClU+9RMQRiwBLFKAEEQ
 ty9KSfo+L3hfwcE8kwBnskBnlYOLGOEviXQ9HbsCNlFg061SQv1wAVrkRmXUGO3DTj1Owaa8SO
 OsMnKUjV5q5zVEAuTp5a3q/6uonsOs/j9OlvVb/2vuypMsaiNotaagrL8NfBovdzFd1Cd5/kFz
 CGOT8cAAAA=
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1372;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=BXwVDHRfVU99OIOKma55zPHgrI85ZKsZ9sTjxKJag6c=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmc92F1qDclnH/7unSfuYE9G5eVTkKUYFdFdhHq1/a
 Jr8ZRsmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZnPdhQAKCRB33NvayMhJ0aNhD/
 9vx4Gtf3Q7HNWVlvUc+GTmemplzxDT6J2IICpvDb1HYFZb9Ai500EaemEgYcPdSglyh454Ff8Fc7HV
 ssbj8T2MB7qjdUt5mwamC/tvkrp9mc5YgnudoCZyKole3bZ5rFh/BvgoPXf9OxBP0Jml/qOB6FZwAh
 ibhoV7VOKV43ZaJpG2CUxgXlzxDc6CtrjT4lgFZuMRoxtv3x6mFEwi2DJuwOE5AY5UvAzWFHjEIS/A
 2syP0zLF/Nxz1UbSg47el8zw47O8z6ssgLl9TKObrLQNr1n2iZAiUHCiyITmklbYUD9B2D36X0N1mE
 G8Io1Ssund+55yPCLmL//ZFjL8QvPybibKO7EovOkXHXAtZyl37XaUesd2sirT40Vtn0G6r7BqwhmV
 RklvYtQnreVn5/KBUxK472mSQeKmXtWp8EvCzlbZ0mPGxzsvdg54PWMehQtwlp9NslfB6+a2DLS20q
 BmUTp5+WyMHiXQYZEszJeiCibaDA7lEjnQgVR1agWgm55DjpDmaelPI4OZLlLQvw9850XGLg+0G2zq
 1u4/xgRns/fZni13Lr7yAWsM+rmtuP/HQGUztjmVE4LkP3i9QaI3po9pG0SdhJrMC94kHj2VFQeCM1
 BER0WTBGvuH5y3SbrBwpaYe2yZok7vMvJdYSeJtpfeMjNrVrOb34hUr0upwg==
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

Switch to set_mode callback now it's available and in the same
time make public functions static and drop useless mach-meson
headers that are no more needed.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Update commit message in patch 1 to specify why we use _ in the set_mode callback
- Link to v1: https://lore.kernel.org/r/20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org

---
Neil Armstrong (5):
      phy: meson-gxl-usb2: add set_mode callback
      usb: dwc3: meson-gxl: switch to generic_phy_set_mode
      phy: meson-gxl-usb2: remove phy_meson_gxl_usb2_set_mode
      usb: dwc3: meson-gxl: drop usb-gx.h and make dwc3_meson_gxl_force_mode static
      usb: dwc3: meson-g12a: drop usb.h and make dwc3_meson_g12a_force_mode static

 arch/arm/include/asm/arch-meson/usb-gx.h | 17 -----------------
 arch/arm/include/asm/arch-meson/usb.h    | 12 ------------
 drivers/phy/meson-gxl-usb2.c             | 30 ++++++++++++++++++------------
 drivers/usb/dwc3/dwc3-meson-g12a.c       |  2 +-
 drivers/usb/dwc3/dwc3-meson-gxl.c        | 18 ++++++++++--------
 5 files changed, 29 insertions(+), 50 deletions(-)
---
base-commit: f1de28e67aa9b66bfca0fad3dc18446a6ec0b504
change-id: 20240618-u-boot-usb-gxl-phy-set-mode-c3991c5f1da2

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

