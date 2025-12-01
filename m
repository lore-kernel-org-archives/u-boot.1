Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D913D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 10:22:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE29283AAB;
	Mon,  1 Dec 2025 11:21:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ljS0jq+E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CDC083AAC; Mon,  1 Dec 2025 11:21:58 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22F3D83AA4
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 11:21:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4779a637712so23342785e9.1
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 02:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764584515; x=1765189315; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Szu8Aqpo/RhN2qFO/tJkUyo9vVpk7u4HM5Kxu9WHtp4=;
 b=ljS0jq+Eywu7atN6fxy1Dp3WUCwGmMDx7IqIDzmZobrAM2GttvVa8QWTEjvlHDgR0S
 b/dXpzFBJrJ4JtuMsM5XLJhlyz9EhicQBfWoELbVGgT7cpcZiLQdrR719b5ONqr31tpw
 ro5tzj9yAhPkDXVDlYSCZIbXmpDziYaFviun3T0KE1tyyRuMZ4OHanbJtuAKlEepLgEc
 bESL+VIT596haUBOTv0+Bb0HTYZ9o/bJQn0Ru4xKUEeeBQpw42hOWSaRQ3yFk3CysTlW
 qOfTumwd/KyX80U2flJW5op+7HuVhLrH/3PgyZWg6b7N9G3TV9DM6buQr9sfp7kZh459
 VFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764584515; x=1765189315;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Szu8Aqpo/RhN2qFO/tJkUyo9vVpk7u4HM5Kxu9WHtp4=;
 b=Ank93KXfPSuPCGwFISdBobcl24qPZ39dKetXclOJUt0mf2adj/8KjhFBms43ldmkY0
 3PztEAu0bNeZUDhjZ4Gbtg6RgLDzaEF8xxIrzdITa/MTX5vlIwobYA/OCx5ff961Hc+Q
 PNzJzTTP0elf3/CKPLvXotlL8FpWb2tUGqCP2g6t1o69XE17W/UIqWraDxAF3FtEr8n+
 Q0Dz3eVF4U4JZpEovyg5Ayqfc6OGAjXlXgWpYOhpL5MzcfBEcYVMWjKXwgzpgV8Oqd7D
 PPc71/8lYyrfGif2zFQbvsavq+bAvZ3UUTFceslou8k5UozlDv94Qh/V3120pCVm/UOV
 EFRA==
X-Gm-Message-State: AOJu0YzkmlnlwMlZHQDaD9/L0r7pdnzFbB5jm2u6JaMQLkE+w+Xq+uNU
 Y7KHhKCTkKuFuTzeLtf9kehttRjHZ5M+a7H5F8csoMdqvDT1LREGoFkCphSd0IXqswFy0Qmu/uE
 kuWn2
X-Gm-Gg: ASbGncsBu99CF9TKItIeChmqSr+WXO83Jl86vKuSTINQBqU9uvF94iJJ4OnWJNY2rl8
 /YAax0ZhlOOKigySEYCXj4KnSHAYxGvaccG0bIcMCqaAnw+mM/QYCbcCDijAcyHcvos+H/K/5ej
 9Ta3ohHhxx2gLasVktr4G7xv6sDanxz7H5YEld0M2XM6s2B3ejeoCC6UCdNT+xqjlHP8Irmizhg
 Hl9+g2FmBhKyg8eDvGGWgAWzG2pTTGhTuzzOr7dgB6LhLwgsg6TyNbsFCY8yXEs7Lhxu0oY+Z9F
 hP7hRx3Hn/gGPYmO7fZLrmXnt8PWep+9KYcrHrYusNPa5U9EIzCkQHN81bGgCyg8QqLQbiYecOR
 ll80HcFPbOfcA1YM6sDD2rWWgTjTW3gsHe0nwU6g9L3Oa+fIJ6fTUOfzB0V+VYmKlewIlizwcmQ
 vzrjtjKvREh2GEb3s7Gpi4LB7qgppOkoYewMKlBzGEMLO4/exAuRaGTbYhZAEzxy2svA==
X-Google-Smtp-Source: AGHT+IFrkSwtpY91AB+k7fiAZhP09w/3GRwNyxB9H9hwuAvqoFYFQYXjYm/4tp7M9cir7SDP0pXl8A==
X-Received: by 2002:a05:600c:1f8f:b0:477:3e0b:c0e3 with SMTP id
 5b1f17b1804b1-477c01eba39mr358695845e9.32.1764584515529; 
 Mon, 01 Dec 2025 02:21:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:72ad:24ac:eba1:9535?
 ([2a01:e0a:3cb:7bb0:72ad:24ac:eba1:9535])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790b0c3a28sm308257605e9.9.2025.12.01.02.21.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Dec 2025 02:21:53 -0800 (PST)
Message-ID: <d84da9bc-2aa9-4222-9fe7-73095eb11e9a@linaro.org>
Date: Mon, 1 Dec 2025 11:21:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Jerome Forissier <jerome.forissier@linaro.org>
Subject: Please pull net-20251201
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

The following changes since commit 31bf4a1c308773895a8e7ea047b3cea037e4c922:

  Merge tag 'rpi-2026.01-rc3' of https://source.denx.de/u-boot/custodians/u-boot-raspberrypi (2025-11-28 08:26:44 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20251201

for you to fetch changes up to 7c1b99bd60185c24d2c78862c3345895ffcd1d71:

  net: phy: broadcom: fix RGMII delays for BCM54210E (2025-12-01 09:52:33 +0100)

----------------------------------------------------------------
Pull request net-20251201

net:
- phy: broadcom: fix RGMII delays for BCM54210E
- phy: dp83869: fix STRAP_OPMODE bitmask

----------------------------------------------------------------
Michael Walle (1):
      net: phy: broadcom: fix RGMII delays for BCM54210E

Thanh Quan (1):
      net: phy: dp83869: fix STRAP_OPMODE bitmask

 drivers/net/phy/broadcom.c | 8 ++++----
 drivers/net/phy/dp83869.c  | 5 +++--
 2 files changed, 7 insertions(+), 6 deletions(-)

CI link: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/28567

Thanks,
-- 
Jerome
