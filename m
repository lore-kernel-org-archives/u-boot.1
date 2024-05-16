Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7709BC25B79
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 09:15:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4AD188027;
	Thu, 16 May 2024 11:15:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rQSb3mv7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 799F5882D9; Thu, 16 May 2024 11:15:49 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6623B87F52
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 11:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-51f1bf83f06so640873e87.1
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 02:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715850943; x=1716455743;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fBHt+AeSZ0ZZnxdZx32ciK+E5pQ2eTIpHeo7P14lknQ=;
 b=rQSb3mv7GapbWE8yUvUpdoj/QvwZrU2tk6BP2rYM1mcvlj6NjebfcVr5ZQcyZMV5Ai
 WwIZ19klcIqPpFR5JFNK4rV0PD4PqaLiVl+A90Qm+eKm25oig7KWLhVyDp92Olg1s6oa
 jkZ/RhG17sxrDMalO6eupq9nTdrU2mVtC9MmRPUCkBNXxgCJFuCT3z5z7aHaTi0vgQVL
 Igh5VTtfvMOAHvJ85EKaotbDomSwDlyA5Om8tJ1Sj1IjOYtI1V8uiiwM2i44D3eVv4tY
 G+cRdaSa+d1JyM2fbrUY3izo3Rmzsw+VQOYmU62t4dX4D0toEB2wCGVQpHVld7TKB8tf
 8tSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715850943; x=1716455743;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fBHt+AeSZ0ZZnxdZx32ciK+E5pQ2eTIpHeo7P14lknQ=;
 b=Kxx8RZhboMMQvK7Z+yyD2a+v4IcwU3Mem9j6K0OnzCFWho2+779XiANc/s6FjiwQOq
 paqmqin2YuYHMEaya1riLBuPTiRrjT9pU/8AwaqjMDWOttPQ3LaPB79Og+PD5kbSdxj1
 4zcsEhyjnprO2IYzJiJmdPNjDfYOC5hpUNdhy6hv+lMx3yzQiQV2pfDjlFN/2JNFO8Lc
 EfIkkKhQA2StiBk3wx94neZmT/wxUtmiTWdcDCAr6pmPryUhm5yHeQWUHCSAjyUgH8QZ
 jC7pP4hJI4APvr14M6wUwqGglUHSoAAOAUI+a51O2lxBaV/9kqXW5Y47mLSHenIfcyFS
 UxuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkXVKHnT81ganC35gJuscwyQKxKJ8YCeIFPt7Hkxq0EVDEHfwXlanlVZmudkne6CO3U8MprqRfE4mCLqSMysPrmcHWGQ==
X-Gm-Message-State: AOJu0YwVgwsVgu5HK8TM9HxvT9fmmJM88y27ItifSfAEJIj3QzzOgPrc
 SWfJfiynaEI7KBjrMfVmO0the07accpriT02JrS0kfpbTlyKYkPvQmKPUvSSvv0=
X-Google-Smtp-Source: AGHT+IGWGx9OSYgDw82SCVWyEI2TIzWMFg6d50osMRVtoxmITp9CKsu+RDR1Fzunx6dLB0vO3YvrOQ==
X-Received: by 2002:ac2:4a6c:0:b0:51d:4c0a:a512 with SMTP id
 2adb3069b0e04-52210273e3cmr11099714e87.68.1715850942584; 
 Thu, 16 May 2024 02:15:42 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-351d95d47e7sm1072603f8f.117.2024.05.16.02.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 02:15:42 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [v2][PATCH 0/2] MAINTAINERS: updates for fastboot and USB gadget
Date: Thu, 16 May 2024 11:15:40 +0200
Message-Id: <20240516-gadget-maintainer-v2-0-23cc916df434@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALzORWYC/32NQQrCMBBFr1JmbWQSIqIr7yFdJOmkHbCtTEKwl
 Nzd2AO4+Iv34b+/QyJhSnDvdhAqnHhdGphTB2Fyy0iKh8Zg0Fi8aKtGN4yU1ex4yS0kKkSLMUT
 jnbfQdm+hyJ/D+ewbT5zyKttxUfSv/WcrWqHy+orR3PQQEB/ebS/2QuewztDXWr/YlXUPtQAAA
 A==
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.13.1-dev-5d32f
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

I've noticed that I'm missing quite some USB gadget patches such as [1]
since I'm not always cc'ed.

With Marek, we agreed on the following split:
- I take care of USB gadget side
- Marek handles the rest

Update the maintainers file to make sure I get included on gadget
related patches.

While at it, also update FASTBOOT entry to point towards the u-boot-dfu
tree.

[1] https://lore.kernel.org/all/20240412202611.3565052-1-alexander.sverdlin@siemens.com/

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
Changes in v2:
- Updated commit message (s/usb/USB) for patch 2
- Added ch9 include to USB gadget list
- Link to v1: https://lore.kernel.org/r/20240514-gadget-maintainer-v1-0-b170f291dc00@baylibre.com

---
Mattijs Korpershoek (2):
      MAINTAINERS: add tree link for fastboot
      MAINTAINERS: add USB gadget regex to u-boot-dfu tree

 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)
---
base-commit: c8ffd1356d42223cbb8c86280a083cc3c93e6426
change-id: 20240514-gadget-maintainer-cf40fcf2bab4

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

