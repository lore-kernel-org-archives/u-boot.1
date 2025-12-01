Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDD0D116F5
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 12:12:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0222D83A28;
	Mon,  1 Dec 2025 13:12:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xV8mcguM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C415883A98; Mon,  1 Dec 2025 13:11:59 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F1DE830A0
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 13:11:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so38427315e9.3
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 04:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764591117; x=1765195917; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AD0OKVHyQuCouXMSNlo1D0ekyqejWVegmH+8e9a4m2w=;
 b=xV8mcguMeX2u7ElPgWIufhPS9XlMPuEkWw3xn0WqX/krcWeBe97Y3Iq8de3QCrEssB
 OhDg6fs/RTRdP5QM0WohDdNpxjso5fLnz2alaGuq0DRnP4sD8f7qlEk0TDOKQ3krc3T2
 I/gDGX8dM7irwRMxTnQtnSLQVzc8M/s/WAbSsXvJ02EcN7vSGCMufTI5p21oaE5JJxeu
 DTkyA8GIK70QRRSKZSRuY5DG14w5VgIs+UcV16x+h20nDlXxsqB6tkPGcAXBvLZ+ZHaU
 TfhvPtOA4Wfm9nWAjI/46JnWLtok8N55IhNQdYWgludjXr/3z6r9Qnq4pOtpToMfY+Ad
 mVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764591117; x=1765195917;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AD0OKVHyQuCouXMSNlo1D0ekyqejWVegmH+8e9a4m2w=;
 b=ImgE2jx9lsgfw2acejurQJPrVE6iLNEmdF1NvAMNLE53l7j8fLY4ZYARIxZEChUz4K
 sE/gbSasLQsNmGBZtKy1uJL0MHpbs/PC65rCyewTCPgJmWRSMLiv3VfLfiVjr7kzhx2S
 NwH63p5owlft238pWwnPX7BvbtMssAnkoUxJMGXtLHAByiXfVIubnACtw7EkLUtoi0B5
 RAWbGrhD8SdQ42FDOLgTcsBnhMwKZBl/hdTWCqipK3jBIHwJsfy5PUA7uEF1Aq50ivoh
 wufuWHO4sMhlCsBTS17W/qsSHcUBNRQ5p9/iuTv9RJtva4fB1slycukrbINgIZwhNeQ4
 DP5g==
X-Gm-Message-State: AOJu0Yw4OtILJvRN7CGmRug2F86lkNIejSqxLivEnYeStT5IMMHwnIqh
 hNPh/VpCNk6nQpzBCCUMRIfpv5/XWsSPZmJiSCX4214A+c3P4i+LnnbIyBEqK/n+HnW4geHFZj1
 xCMcw
X-Gm-Gg: ASbGncuSvwxRQHpS6TW06V5ZpjZHzriRTNNbWHcyufeW9HPArizvh+9mb42vXJn3Ljc
 /L5DTVxHBIcuqn8cQ4hHHm9NN5NqbbxICIwuV6N0bKn9Xi5qqoLF4sAvYt0f3a2aKGqqVmDVj6+
 1nvwVKyuwcEBSj7TiTyyGViZpkZdzpWYfkFIj8qXTbHzwn+5QBIAoEKnNpWxMLJPX6UOGrNoDoH
 z68K8f6hxzJMUBlu26hEsS1c5yfVgdpgHbEZAaxeE19zgcrLq536gw/sUPnTzS8Ab9cyYqO+CnX
 rO9pSrPAqo3T90zw4z4U4ubG110ve30omNfrKGm2Z4jdsfvexxiLBnsI4fuNc7lhQ8oZp5ILSW6
 vvIVrU92bsCdBVHP4mLevzx1nooR1bvsgXpkboXbegpu5vFbUmaN2J2cP45VKRed/I/WpdsyIol
 /1qoxRLZNXEjW2F2kmvqYfIDySWaR3YH/nniYRd62p43T27dWhOTjVBzD8qmMSJ5qACw==
X-Google-Smtp-Source: AGHT+IG4kT+CgvTDrYduoHGDyq/m5gz4KEq2ZcVlE8NXLIbdsVCMJcPomAbV7FIvtgOnSsCW3/WNTg==
X-Received: by 2002:a05:600c:4f46:b0:477:fcb:226b with SMTP id
 5b1f17b1804b1-47904ac44c0mr268975035e9.2.1764591116754; 
 Mon, 01 Dec 2025 04:11:56 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:72ad:24ac:eba1:9535?
 ([2a01:e0a:3cb:7bb0:72ad:24ac:eba1:9535])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47903e5fae6sm163603585e9.0.2025.12.01.04.11.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Dec 2025 04:11:55 -0800 (PST)
Message-ID: <def8f892-abc8-485b-9916-c3c1c7318226@linaro.org>
Date: Mon, 1 Dec 2025 13:11:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Jerome Forissier <jerome.forissier@linaro.org>
Subject: Please pull net-next-20251201
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Tom,

The following changes since commit 65a131531077d75eaa01f8376d8f7f04c146a457:

  Merge tag 'u-boot-imx-next-20251129' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx into next (2025-11-29 15:39:36 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-next-20251201

for you to fetch changes up to c10e1c2eded4783b8f4650da879ebae2beffcce6:

  net: tftp: Remove tftp_init_load_addr error path (2025-12-01 10:37:06 +0100)

----------------------------------------------------------------
Pull request net-next-20251201

net:
- phy: Add the Airoha EN8811H PHY driver
- airoha: bind MDIO controller on Ethernet load
- phy: Disallow PHY_MSCC and PHY_VITESSE under COMPILE_TEST
- phy: aquantia: refactor firmware upload helpers
- phy: aquantia: use generic firmware loader

net-legacy:
- tftp: Remove tftp_init_load_addr error path

----------------------------------------------------------------
Beiyan Yun (2):
      net: phy: aquantia: refactor firmware upload helpers
      net: phy: aquantia: use generic firmware loader

Christian Marangi (1):
      net: airoha: bind MDIO controller on Ethernet load

Leonard Anderweit (1):
      net: tftp: Remove tftp_init_load_addr error path

Lucien.Jheng (1):
      net: phy: Add the Airoha EN8811H PHY driver

Tom Rini (1):
      net: phy: Disallow PHY_MSCC and PHY_VITESSE under COMPILE_TEST

 drivers/net/Kconfig                 |   1 +
 drivers/net/airoha_eth.c            |  32 ++
 drivers/net/phy/Kconfig             |  27 +-
 drivers/net/phy/Makefile            |   1 +
 drivers/net/phy/airoha/Kconfig      |  11 +
 drivers/net/phy/airoha/Makefile     |   3 +
 drivers/net/phy/airoha/air_en8811.c | 805 ++++++++++++++++++++++++++++++++++++
 drivers/net/phy/aquantia.c          | 101 +++--
 net/tftp.c                          |  18 +-
 9 files changed, 918 insertions(+), 81 deletions(-)
 create mode 100644 drivers/net/phy/airoha/Kconfig
 create mode 100644 drivers/net/phy/airoha/Makefile
 create mode 100644 drivers/net/phy/airoha/air_en8811.c

CI link: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/28573

Thanks,
-- 
Jerome
