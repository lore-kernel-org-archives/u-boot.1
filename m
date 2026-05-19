Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD342CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 16:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F0FA846EC;
	Tue, 19 May 2026 18:08:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Bl3Y7u1S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B46C1848BC; Tue, 19 May 2026 18:08:41 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 867A6846CC
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 18:08:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-44a5174670eso2135562f8f.1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 09:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779206919; x=1779811719; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=j6arkGa9hlKYbydJzA7W8P5Uh4SGpLC/p2HQxhFAT0I=;
 b=Bl3Y7u1SVUstMAZGBGDwkfNbRaBebBRP5DxHs0RJaN3//zRaFo+O15KoycX9tjSLnm
 Fr8J8OouV6eFQ+QHEM64kZLR9/5Lp5cgiAP4LHr4wzcC6KjYX07El6eTJOnXEw941v0o
 W6EyQ3wEmTuQx+8qZUkVtK0rmvtZzG9J6M0ICKLkiaLAkQw8zTN6FJAsDZlbc1VyKdlf
 87rGsREuHzjv0uCk/lGkzU5fc05s6OJHuM0+XH1LL9ESTU/VaqvhbzzD4yV6oYhqqLp5
 S6U8U0OE1nV8ocimO/3GhHp6/VmDetAWsktIkLIY7NaIpfzy/28TwOixjM3M4E9nUmSS
 rUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779206919; x=1779811719;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j6arkGa9hlKYbydJzA7W8P5Uh4SGpLC/p2HQxhFAT0I=;
 b=Gcrg6oAvTB1+SCCndoYRYviZ49bXZpl/acMKE9BvzHB/2XaUANIXAFsuRCAbQrx7GU
 hmoA/4MVvfvOk+bPxJyTinG032dDBUui/j+km2Ku0uqKVkyeGpIoKYVBw6oKui0Z5mK7
 4DBxKW21D63vUpBoMMqKutZVNoZaG1unxnTZuChUWhNMMFga3UjKrvgi4rTBshNozOie
 vjwar9+oSS24RYsSbpI4k284dNuUxfm1gZLQPrArvXUqE5IE1YR88SSMcxGNNYsI5Y8P
 KYyDcQ2zDamJwKHdn2Q/iVSWn+mqKY/vZweqIwvZSdyHPFZQBfJXLe8PnZhBxCsf9Qse
 9oJQ==
X-Gm-Message-State: AOJu0Yw0R9Q8vNHLz7Nes93iYNmCkPU5IaBwMf9sUXO69q0dsnxb28w/
 8rGXniYDt6jwVOHQmHWRBOi3EpSF17YJDrHGOh8IHkSZlgHL2p5FwDt9i7ePkpZJwQE=
X-Gm-Gg: Acq92OFuCeRQ8j9xtEPHAV2TwqXb0VKiEW+wedAZka51Om+HwdYczHPGNhe+yO8bsfD
 g4KPw97Dlr0mTfuNf8lOGJyTN6Da8RxtWmmmimuB6Y1KkRtZZAMO9rb/yDk/u6U3pUPDTxb7FDO
 zUBZnoIID98NfYztP0OjSU8jQ0CVUPEJq69aF3s8sah9oGhCMrVK3buGPuuQdQCVtu92an33s/I
 J++J0llSlfEsec9rjLY/ttkpyEmw36sr0GzUUOyn0CbNjnoSC3zbJgQlCPy6n9PfGb0QoCYEuQf
 STnQk5MsHLXLSRHx6Dbu4vIxv0j+CjLPRXqVnsRxI1IzgD3CWM/Tv1BSNK/hnUngyXwVW+8anMv
 5NQy9XbSCyt/ANc4z3mMiWjXsrRyiHhfL9XJWVcP6PbaihTcTowz1ZlCNW3uOAqGG5m26E4jTkx
 IS8V7VYETxmX/hqepDbq7mJ9rHCAxnmnoacZqLQGh2YmoQ
X-Received: by 2002:a05:6000:400d:b0:449:af52:6167 with SMTP id
 ffacd0b85a97d-45e5c58fd33mr33224227f8f.8.1779206918408; 
 Tue, 19 May 2026 09:08:38 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec3ac86sm46328282f8f.14.2026.05.19.09.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:08:38 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] MAINTAINERS: add myself to the list of PCI and NVMe
 maintainers
Date: Tue, 19 May 2026 18:08:33 +0200
Message-Id: <20260519-u-boot-pci-nvme-maintainer-v1-0-363593cbbfdc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAGLDGoC/yXMPQqEMBBA4avI1A6Y+IN6FbGIcbI7gokkUQTx7
 mbX4hVf8y4I5JkC9NkFng4O7GyCyDPQX2U/hDwngyxkU9Siwx0n5yJumtEeK+Gq2MYUeZyNMJW
 UumwbBWmweTJ8/ufD+Drs00I6/o5w3w+9uZw9fgAAAA==
X-Change-ID: 20260519-u-boot-pci-nvme-maintainer-df1f422c386a
To: u-boot@lists.denx.de
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=458;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=kqROBI8sZVyUA7NHjhb11hWyd4LLVTj4VZiuk7G4Ufs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqDIsDsUEL0NIzV73E6ZIUvBixnlof8L9RlB/mae6L
 we0RxdWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCagyLAwAKCRB33NvayMhJ0cE3EA
 CCpJYX0M5yRG9GdRJ6mgdI7mGQ/jmuMuMsw7uVZAPQvOExbODeWDjZwfUHjNIpSvzoGo/sPR2HuVxY
 OR/ciqKYbP42fx2XNfbMyFMZDcIrY9to+A2waKAoqfFD041QAuYMVTSuc5Mr4QqDURqsdfA+hUZxri
 cDGZpMstrnQbu6Fr/7b8pG1Xze/BRf0aWwUyuary4TrPGhtMg0/AeO46yma5csr2TOMH5VPU90HyXQ
 NE2E0CoexL6JeR+ScDjF3RbC4Ot4sR5jQ8S9Xmd7vpX5l62CdnicVz6yp+7xHCDBiBVc5CMI/qomkQ
 0jtfaXZI1smu1EH0JsywlfkPiceNbetfnDUjbvNCFSXbslMI8yR501QNh5x4amNA55HleWr/rbiZLX
 0uw261Km6Kh23ELTzePs3LQgQxiaxb/azWJWNdNx3ylLiwCsm6wyYnXsDLDu2wNfoy7/02tOLvrXCC
 L7IILaC+SUsm1+yHU3Y68KdeteyMn8v/sAV2nLGuUsQAKWN6neLTJ9S1b7Jo0HAF6VBT0X5TIz17O6
 q8Uan9zwdPel8co67gg/5T+Wthp/yfYxvfioixVkZhjn36AfulK7LGmkXa6OH/byCN1ywZxNSbm2WO
 GHVEF1yyS8eJOl8wdlrpSXWGIch6HqzC3pvA+lOKPfKFsmB9wn3fVuJeSWxg==
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

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      MAINTAINERS: Add myself to the list of NVMe maintainers
      MAINTAINERS: Add myself as core PCI maintainer

 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)
---
base-commit: 38dbe637c9dfcadbd1bc201bfbb27f96b2ad525a
change-id: 20260519-u-boot-pci-nvme-maintainer-df1f422c386a

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

