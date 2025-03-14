Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACC1C35FF1
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 16:10:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB57281DF6;
	Fri, 14 Mar 2025 17:10:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b3TDTEHG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01B8F81E25; Fri, 14 Mar 2025 17:10:12 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D35281D0B
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 17:10:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso15904995e9.2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 09:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741968609; x=1742573409; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9QvWNjdxy7EGe4NvWVloL0aAugxc6ORiiEV7er9sZlw=;
 b=b3TDTEHGOoIWxnH79mJloUB0Hy42zRfJ7h6o2NjK2uvNElp5RYx9L4PwfQvV5XgHYw
 8i7FPBV8AN3hHy+vk8eShjEJJDoOSx7R4kp3EQGMjcEviV6zJaOGyKHoIZnN4CWSDRJN
 9Qv1GUFPa4mlFy9et1ZLXCp2JyBmMrkcBt9eMQ2sPIAMwr40GDuVGxFy1SkW0YwaAQMm
 Bum2woUMXd2IwOIvS4on0W9x/quVCeF/WsYnCTOG0cmNVeJpUYC2yTcbADaBRDm5KQWy
 Eo/+jkZQ4UHv1KT8Jqcq5t5FRtY4wgjOQp5VUMrDKTCWhGIvQlkfhfPzaan88UyqsdeC
 /UwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741968609; x=1742573409;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9QvWNjdxy7EGe4NvWVloL0aAugxc6ORiiEV7er9sZlw=;
 b=hdtYSfyIcPP+WWc+4lj65mw0uHC7PghM6ZK4tLoI93UolNBDMiXoroZiNpMQybn9qy
 2s7t6fVH4usMQcdtq13NjzNkJydN3zZWCpHMA7SJkbFsQqh32FYdSZadW7GgVobuwfBw
 TkfNO4aIvSgK9NDLZdM95xm/ssetJF82BuLwd2pGw62fcXEjz9gPXXZm98q7bUMhTPgO
 LhGZBB3CYdTjSHfziS9i9EjyZdAsd1VKGJftCMGrpQs7tcQSQOnK+T8mHMYQ4ImDVkRI
 IoYHYWTSh48YCXkQyt0B36jK/Qy+OG53odTbfxl50Eu0D93gln7uD9M+JXr71SdJtNBD
 E2sQ==
X-Gm-Message-State: AOJu0Ywsq3imH/iQ180hXiRp027MECFjv4dPix5PM7XMvOK+5DLSFz4E
 jdqrqsSOmRvuRivaYB8GBwf95vtNXXvpaePbH+hhWVdHne4L+9aypC1nCIW/jEk=
X-Gm-Gg: ASbGnctRwzweCDk+bqVlj0hzh9qhn4ZCau/dUZmXgqEBCrI1OS0EQwR/lzXlEHkUghN
 6H3yROe4hPzVPStHnW1syI++Ym0jPidPtWJ9/STAcqlEqdA7FSEt0xW9AXFfdnu+ZmFSO0eIiH+
 Ql9pwpF0NuUNw1+aKtH0sMSz9o2GqVIT/jf7WG1hW8LnRq0dpkBooGcFIOX/cYSn+ykbK9ian96
 ERhY7lbdCL/tFPFH3zRbsTz5pPPuZ+Jak1mUcWPtO78d4QRBL2iRwGrPJrPqlvbYXVbD2UuMWiQ
 P+DCY/kC2dt5sSR1lG9RsC5tdEOecSjxh5ENLk4/PzOQ9ztpTevd6eBGKawQ
X-Google-Smtp-Source: AGHT+IESIIW5VQ2l/tqh4XP6R7TIPevPs6HriuMJPW/3GeNm3cYuosNOHypCbQDHc5YgDeB/TF2F9Q==
X-Received: by 2002:a05:600c:358c:b0:43c:f513:958a with SMTP id
 5b1f17b1804b1-43d1ecc3969mr41643175e9.13.1741968608644; 
 Fri, 14 Mar 2025 09:10:08 -0700 (PDT)
Received: from toyger.powerhub ([2a0a:ef40:1d11:ab01:2b81:563b:c694:c380])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fdda29esm22035015e9.7.2025.03.14.09.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 09:10:08 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 0/3] Qualcomm: implement support for GENI firmware loading
Date: Fri, 14 Mar 2025 16:09:43 +0000
Message-Id: <20250314-geni-load-fw-v1-0-587f25f2812f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMdU1GcC/z2N0Q6CIBiFX8Vx3d8QcKJrrfdoXiD8GEulwKzN+
 e6Rbl1+Z+d8ZyERg8NI6mwhAWcXnR8T5IeM6JsaOwRnEhNGWUF5LqDD0UHvlQH7BopaCc6skJU
 mafIIaN1n012bnQM+X8k67SEZMEa1Wevs9JdGXTJJYfABQfde3yPMOVBAZQohZKm5xEvvRhX80
 Yfu/PtqVUxlPwxuqrNK0oKz3FiDLWnW9Quf4kEb2AAAAA==
X-Change-ID: 20250314-geni-load-fw-0eca432f489c
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2267;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=acHcfyafrdPrAsilVBLEDesZIdhyw+KxTZ6jeLfQjok=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn1FTfbLJcilnpBbOCuDZaXl220uydFh4WaF1rf
 nzsuHOipFOJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ9RU3wAKCRAFgzErGV9k
 tlVwD/0dW60dO+ZQ1GwEmDuChedGiwoySvaffP6inSRpTytuEBrdZ5rE21Nf2asQ9jY3Xjf9egj
 5oG6rEUZeLXEFTfAJ7gb8f8zOsSSU+I7p3BHL39IDw2hE4gJi+4EN2e9vbjskDUFESW8myJnb4h
 6vpAtIFnLySA9XjINVHdL7Qpy53y9tRicI5Tlv9JBpH9RXaFo1kRy5fHRqECH2eWrWfowo57392
 cM/qy8PDe8CoHto/4We4o8D2Vd1BgyfvRDkthi7ycOCxXeBcf0jGxZiAcEk5DYNmm9BApK4KhS4
 zR3spxdJF2IXULPVfZu4wdMbuPRVX3OEi9JDUrzU7SIXJaANbkxNVtD7Z7RW+MQQs3cmbYecPjQ
 IQoxCHUoPIshvTJ9SiaRKloE80f9Jb8IuuH3mN/UUSqsAq2h8T3LWtb5JgtwFCuqqeCHQoaWme7
 3f5ExtNtoh24GCK1dhBDmjaMza9SMVuEQ5xuCWKHnW0EhRrWpMXDiKJll9ctKFToz+hPIGlR/eJ
 WDJtyZBszOgVpOVUMEhqYuTPHtIxTieOr2KySSO0NX/XDYiSXOS4evToZ8pgMTv52aMvmS+me6r
 isTQ23CiCG4GCfN1eUMol2T9RMkLoh9cN3/x2QPmnDJg0JykNC29b4nib0FpCp6kFZmZKTwdukA
 g5bF7wodOQ+brlA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

The GENI block on Qualcomm platforms contains many Serial Engines (SEs),
these are general purpose hardware blocks capable of implementing any
low speed protocol (UART, SPI, I2C, etc).

The protocol implementation is provided in the form of firmware which is
programmed in to the peripheral, typically by the EDK2 bootloader. Up
until now we have primarily been chainloading U-Boot, and therefore
haven't had to deal with this problem.

However, when running U-Boot as the primary bootloader it is necessary
to handle loading and writing the firmware.

Support for doing this in Linux is also in progress [1], this series is
largely based on that one, however the Linux patches expect the firmware
to be provided in /lib/firmware, and will only exist on newer kernels.

Since we may want to use peripheral (e.g. EEPROM) inside U-Boot it is
still useful to implement firmware loading in U-Boot.

The approach taken here is to bind all peripheral devices which don't
need firmware loading (e.g. the serial port), then wait until
EVT_LAST_STAGE_INIT to handle loading the firmware from storage and
probing the remaining peripherals. We forcefully probe them so that they
will trigger firmware loading and will be available to Linux.

For testing on the RB3 Gen 2 [2] is needed so that the i2c peripherals
can be probed.

[1]: https://lore.kernel.org/linux-arm-msm/20250303124349.3474185-1-quic_vdadhani@quicinc.com/
[2]: https://lore.kernel.org/u-boot/20250314-sc7280-more-clocks-v1-0-ead54487c38e@linaro.org/

---
Caleb Connolly (3):
      i2c: geni: fix error message wording in clk_disable
      misc: introduce Qcom GENI wrapper
      i2c: geni: load firmware if required

 arch/arm/Kconfig                 |   1 +
 drivers/i2c/geni_i2c.c           |  14 +-
 drivers/misc/Kconfig             |   9 +
 drivers/misc/Makefile            |   1 +
 drivers/misc/qcom_geni.c         | 576 +++++++++++++++++++++++++++++++++++++++
 drivers/serial/serial_msm_geni.c |  13 -
 include/soc/qcom/geni-se.h       |  36 +++
 include/soc/qcom/qup-fw-load.h   | 178 ++++++++++++
 8 files changed, 811 insertions(+), 17 deletions(-)
---
base-commit: 9805321dfdeb5225fe5c5e0721abf49c0875637e

Caleb Connolly <caleb.connolly@linaro.org>

