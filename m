Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77945C87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 16:43:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D42A84379;
	Wed,  6 Aug 2025 18:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uTqxqxGP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9097184368; Wed,  6 Aug 2025 18:43:33 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB427842AB
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 18:43:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-459ddada9b1so1289595e9.0
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 09:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754498607; x=1755103407; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=czum2DCIb06/sLAdUyhUsXevqmuDqCTlv2mYJhmeUpc=;
 b=uTqxqxGP2mFpCQZ8X3Nmy/WwAVOzcViPBvlgwsnUJLsEht3u5HAUAHQrPriLDV+72l
 yqxoHcN6tcOVqx682paBV/7B8KznSBUqO/EaL64WKmF6SRFRgjLues2HvPqRK2TQKvJN
 c50z7+2e7hU2T5LA/ckBTh8C5KmlU/L098/KTHGFp9OpMXHzQjkF/h1FbDCM/Sh0Xvnz
 EFXXme5exRqFoqtaiArB44NOJigkvppJPQLP9mahRauZFTxwgyrNo0l65pms9J3eDA+d
 GFw5mtowcuPwA5km8K9WUy454tIyk0+cBfX4tl1b8oNP1JD/aN/qbRul0d0AsHRgyqk2
 +i9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754498607; x=1755103407;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=czum2DCIb06/sLAdUyhUsXevqmuDqCTlv2mYJhmeUpc=;
 b=PHW5G5NY9Hb2GIGckOPSUvoDJYjLvXL09+t78gtB2QoQnTl2pFMaAQB0x4iW7cnHKy
 /HsEclsnnXHuj8t/oHtL87HOi3H96bCvi9xkOh2Q/tihfCnqfiLqTk4RrwfifXsGkSAF
 i+ZDNaG6GnNk+gtZE9zI3tvltRn5jA/AgJDryTwrQB8O7X8JV80tn/+3h+Co9TGgjclr
 imwvMShXcyEAfBAweEqCs+EY5+wdCZmBE4OnxypTH9qxGERj+rZCoAWq9LI8Ng4qZDcR
 JKjPsCnUnetzbgYKiFSKXMcIGC8DqjPY5hwmt6D5s2hsrwkcVNQPKHnA9/EFbhOR4tLw
 aTgA==
X-Gm-Message-State: AOJu0YzTRCGxDkrTwDTkelb5Hw+IVBN3KyoroFqUxrkhZq1Zp8sfU8m3
 IoBdP4xOTQCosMXwIu0I2NLttO5wAfJv/tWkbVp/RwEVhpCFRyIsBRzelHTzlRS2Jbl5daYnYdl
 MKGya
X-Gm-Gg: ASbGncvM2aTj9lnWkVCpD2EvHvdfSksYgHE+xonE4zEt+FhiyAADwGOvGthmuucgcOF
 oRmevTQv+awpKAHciHtq6YL+EIAKusd6Z1yGmiESI05RqHTFgVc8e+8uld44l09ggs8ykzixkvy
 eK5x4a1YAqkJGk++5jLLP5LUEeGEALzOkEkvnWXHhMtIlRk//Ga/emMOg/JwDPOsPcxqKgmU5bE
 vEj9GcFSk02rFTG74QVt0uppb+fzh5KDX87LpvwlYTrFWkoOwF21Pb+/Wg7WAUTzW5e50tgd4cP
 xjiFcmLq941HJ7Eg5E9pghdn9LfTMf+rpfwzsBF1uTA5KdUMG5WDloW2RQF++DvyFwmx4AT5+xu
 jg5dzNVlDhhGb/VYR0oIqjbOFdoDhELu1s2aIdOQ3/gYPXs5oeGIh7fWWQSD1vg==
X-Google-Smtp-Source: AGHT+IHAl4PfgubGTklbs//VXlBiWOGozz4Fn9kyI1xWGWiZHjI/RHSJ7IIFMEBeCpaSz3WEU6M7Pw==
X-Received: by 2002:a05:600c:444d:b0:459:dfde:3329 with SMTP id
 5b1f17b1804b1-459e74b7c5emr33370815e9.31.1754498606806; 
 Wed, 06 Aug 2025 09:43:26 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:6501:9a0d:7129:a02b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5868fd7sm61287685e9.18.2025.08.06.09.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 09:43:26 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/2] phy: marvell: Fix two Smatch reported issues
Date: Wed, 06 Aug 2025 17:43:23 +0100
Message-Id: <20250806-phy_marvell_comphy-v1-0-ad9f4e789d5b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACuGk2gC/x3N0QqDMAyF4VeRXK9Q3drJXmWIxJqtAVslGbIhv
 vuqlx+Hn7OBkjApPKoNhFZWnnNBfakgRMxvMjwWQ2MbZ1vrzRJ/fUJZaZr6MKdC43x9u18dtR4
 9lHBAJTMI5hCPNKF+SI5hEXrx93x7dvv+B3uDusV9AAAA
To: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>
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

Smatch reported incorrect limit checks and testing unsigned values for
being negative.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (2):
      phy: marvell: Fix off by 1 limit checks
      phy: marvell: Cannot test unsigned field to be negative

 drivers/phy/marvell/comphy_core.c | 4 ++--
 drivers/phy/marvell/comphy_core.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)
---
base-commit: 007610da2cca405ea7739fc120d90085be4b6ac2
change-id: 20250806-phy_marvell_comphy-5614735e86a6

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

