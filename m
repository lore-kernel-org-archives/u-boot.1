Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96C4E9D407
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 16:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36CB083015;
	Wed,  4 Feb 2026 17:11:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mnz15pxs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B28448341A; Wed,  4 Feb 2026 17:11:12 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B17E80086
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 17:11:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nathbappai@gmail.com
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-81f4dfa82edso8034b3a.0
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 08:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770221469; x=1770826269; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HOZuHXFvNzDWrqm2bMOpNrlfFX0rKE6Q09v9AQFFZQs=;
 b=Mnz15pxshmTc0prJSIpIDRv0oeo0BEkLB/H1Pv9RDs83wt2dGNB9Ajx5V2KwoPXJuS
 1wJRuo8FC6wNmYyURktzlWqOkjxEXpViVxbJtth0M9dEkkpOcGLT0J0O7+iZNVOUMB+E
 dRvyS6J3WthvrFV2DpkNY1d/9CVU6Z27THgF+FL6rGlTmpDqR4tqxT99yOjUpG3oiIdv
 Wv7nEV3htRnh9rUcUCIMJ2hyPB+Ou4PPG2wR5JVMrxokWT8833AylIrDsLqaNk6wKP6K
 agkNLSva6nlx9mHZWLBodnDSokbq2lxTP2MliGYkD6pRDtNBDY7CK9h0qWy9LxN9/DqV
 ySrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770221469; x=1770826269;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HOZuHXFvNzDWrqm2bMOpNrlfFX0rKE6Q09v9AQFFZQs=;
 b=DRJaDa+WTUDQVqyR5cpFxVOy+cNdt5rukZejeAvuEMtlDppCF719chfCWZaT1Wfq/7
 fUL2tUxutoGnvRihDc8pd5J2hcOc6cKaFzMgY92KoclBh/Bako2jBOtPekdEEEz/dqvY
 0T6VgA0eMZAPay6C5/Myyg5lz3JEiZ3czcS8KUaQ4iqwGpEsLT1KDuJKtZNylPk5arGm
 F2jSkMGEzg0xE6TBb3SeIaCz8Q+e9dYvTsn4+kOQtbYRsOHxgInekGFTyddsFrHSjuls
 pQxZQUvjEw/5BkWrA7rSDI873PHzcoD+inzGJJ2Pr9UGjkaKhT1RnfuPFg8BXcNfmEH7
 UYuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWp5Cy5v87VAM1I53gb7LmU0TMCVR05bGYbPEYY+aDutyZnLPr7JlgHY7e5OBxcuSG2Pl05clM=@lists.denx.de
X-Gm-Message-State: AOJu0Yw5lF+UHH1FFqL1YL4Q8vj/YdyMrV/I2hrpkvoQrdIZ0YUMa7X7
 ZAPakzRrespwY056gxvbRvn3ud2EA9Uth9hAARmFG5ZBuuRkO0baw5Jq
X-Gm-Gg: AZuq6aKMuWFu2CjxIxmablMvCcRkRc7oJl3umEoglUbd2Ja1jIzhCMtWWGhRPGBp9Ef
 /iAc6VnHWi+kVh0iiR8W7QefCIoeqDSo8ckR2gZq3naBLuyInyJcNVV7inTpxWL+J3CP3wMbld8
 OvzjUrlOGbOPvlAmPw8h29DGKVdAFTDkwQi1dhxxYoXNzwjD2IypqLWpzEvEEwca5Ri59kx7oem
 j9cjwAXluuvSZQuS26g6HVbLpjgsODPzg4ckM5hKAfx/C5s6a5HkK2NwZNj3V/EqBYjRZSxQAwa
 hOKrH2IBu/DUVj1twTsXPFRDj2+NimnXH1ZXHMOjWrQbS2ZTjHtzpwigWFt4sL9A9Jyl/3NJiay
 iPM8NEfvEC9jpgqm8NNF2sOC6xnmttvOLgQuHZgW0CS2G/6cOVGLJOTTyRi2E67rGVaJZ02Lqfs
 +3g7q5+kdn7ysX2u0X
X-Received: by 2002:a17:90b:2f90:b0:352:f2a6:334 with SMTP id
 98e67ed59e1d1-35487102a6bmr3326828a91.16.1770221468842; 
 Wed, 04 Feb 2026 08:11:08 -0800 (PST)
Received: from [192.168.0.103] ([43.226.31.128])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-35485efa3d5sm2968364a91.17.2026.02.04.08.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 08:11:08 -0800 (PST)
From: Biswapriyo Nath <nathbappai@gmail.com>
Subject: [PATCH RFC 0/3] Add clk and pinctrl drivers for SM6125 SoC
Date: Wed, 04 Feb 2026 16:10:51 +0000
Message-Id: <20260204-sm6125-clk-pinctrl-v1-0-9cf4c556557a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIwMT3eJcM0MjU93knGzdgsy85JKiHN2UZDNz42QLQxOLVFMloMaCotS
 0zAqwodFKQW7OSrG1tQD4Aw6uaQAAAA==
X-Change-ID: 20260204-sm6125-clk-pinctrl-dc673c8148e5
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Bryan Brattlof <bb@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Biswapriyo Nath <nathbappai@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770221464; l=1129;
 i=nathbappai@gmail.com; s=20260118; h=from:subject:message-id;
 bh=quTIzWb8657LbiMswGwtRSlGaFZ3niI36VWMDWXciMI=;
 b=AGgcqyhn0ZUiDMYMODALWJuhVlAWIh5R73RMWNbTXdic35gooCR4bB+0BSC0SVUf4eaXC7xfQ
 KKxY4GZwbgiBzaIr0AurvI25GewiuNhl3aRCUHZkAA3RGmB3NQiwsQV
X-Developer-Key: i=nathbappai@gmail.com; a=ed25519;
 pk=slmb/9yXbet+KTiT3EYLCp0p0MEOYa3EdjUXP+HXfjg=
X-Mailman-Approved-At: Wed, 04 Feb 2026 17:11:52 +0100
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

This is still RFC because micro SD card does not work with u-boot but it
works in Linux. I do not know how to troubleshoot the issue. Any pointers
would be really helpful.

Changes:
- Add sm6125 clock driver.
- Enable sm6125 clock driver in qcom_defconfig.
- Add sm6125 pinctrl driver.

Signed-off-by: Biswapriyo Nath <nathbappai@gmail.com>
---
Biswapriyo Nath (3):
      clk/qcom: Add SM6125 clock driver
      qcom_defconfig: Enable SM6125 clock driver
      drivers: pinctrl: Add Qualcomm SM6125 TLMM driver

 configs/qcom_defconfig                |   1 +
 drivers/clk/qcom/Kconfig              |   8 ++
 drivers/clk/qcom/Makefile             |   1 +
 drivers/clk/qcom/clock-sm6125.c       | 260 ++++++++++++++++++++++++++++++++++
 drivers/pinctrl/qcom/Kconfig          |   8 ++
 drivers/pinctrl/qcom/Makefile         |   1 +
 drivers/pinctrl/qcom/pinctrl-sm6125.c | 147 +++++++++++++++++++
 7 files changed, 426 insertions(+)
---
base-commit: a8d982e1f1726254ef27bbdf362f98954ee3feb7
change-id: 20260204-sm6125-clk-pinctrl-dc673c8148e5

Best regards,
-- 
Biswapriyo Nath <nathbappai@gmail.com>

