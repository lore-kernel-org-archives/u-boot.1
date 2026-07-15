Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93360C44507
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 01:03:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26AF484C4F;
	Thu, 16 Jul 2026 03:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="24267tGL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 813F184C12; Wed, 15 Jul 2026 17:17:52 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6858984A3A
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 17:17:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c15c7d22070so731585566b.2
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 08:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1784128670; x=1784733470; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=P0U1LVD1q8bu+SLLEmQx6WL3w79Ged+41Hx+a1iAXR4=;
 b=24267tGLcp6Dx5hIiqnJP8u6Ghs2jED4oAPYgjSJWGpZHNHm1v4KqO8AzrFc1qFaYr
 3q0vHK6sun1OxluN8JlfzQHQtH0DryOV3GsylwbUs3lOxWHmD8lT0ikRCfptdSSZQZYf
 q1S6kfkcnoLfu3xoClQqK40a+4ejEXx2A8+MEWdPixBSD3ewUjzBhdetlYZDH0hoil7W
 XbfDqmZro+y8Y3grArdosQ9N1tGyVdfr96YsdBfct/hIQcMUzSuo8BXnNH8FhkNY+jDI
 TdrkCgmK6Lvp22QmMPA7kmSPeLqYAtrMkCCLdUMMT+j3gZo056Q8lg738SPZLjA8DlH+
 eWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784128670; x=1784733470;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=P0U1LVD1q8bu+SLLEmQx6WL3w79Ged+41Hx+a1iAXR4=;
 b=oT2P5jMKkH2gDtE/aYjeLy7led975apCzyU5/zCsToqsWQlr5Ky3hDJ382+sG7GZob
 cNMaB1tEAVqKv95y9hVOqxMtaBGzGbXFbMT+dxCP1+OF+ApUdK4rIazAzSXRBzJG+33E
 JFUkrd+Y5JhCxYYgxLeN0y/CVRiRTSbnaNJ6ISMVP68xDkiGOoELYj7K6GjSf2vghSqQ
 96XIDzBWDaCvMujQwemEMFv15s2myNNz5pYdzG/LidZZFETwxiur5sjW4OVe5Naj4EAZ
 Ax5MrAFpSOnpZbo4Nh4ykQ9732/Y0RGqhPHvEyxBc1v7xD6m9sgKlLgQRFGcDNXdl8UL
 qOsw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq/vbT2rVG4sz3M0nuoehWG1NErMqHBk/GEiISDLd9Xqo2QRgks/aPt9uJ+dEA4V8wHr+hw5Xw=@lists.denx.de
X-Gm-Message-State: AOJu0YxKkzX8BgArM9ajCv8u/0673Qj9W+4SW2ivOdnMh+nCFz+kwKYT
 zIydPUL7ht7QIQywaLrISwX1dI0P502GknSGg0ptFh9/PSO/X+2lOWvKNia/fwS9MOM7FJo5kO0
 H48sN
X-Gm-Gg: AfdE7cms1VZZcu4LOVlCVUTXNCQHS0MKua66JN2YsPlKtuGcB/KIXRu0f06kvpr3EU5
 c2FhXv1Aubc3u5srnPJhKl7eMVPYzFroSDeaZGUrGJD2No8ClM0LY0qP9cxUQTVZD+tNjGxrzQ1
 8EmMhPcfk9kOImenycsi9DT83nFUsj/QrFWuhcHH1HsQiLC7CGnaWQ2Ph4YaYnkw5TKjOhN5t+3
 tnsEKAN0hqfm5w96QrbgZRQM7PXT1VXvKp0M/RIvmA23eg3kU2UEQy5wagXjv6Ee8VFvaE1LUZu
 H5Y9eCVGQAnH8JEhNycsmAAgxFHHmoEYH/b8RzGFrhdR7JvChUql7Tx4tIVfgOh2bulniSoVvXA
 CH379unZWmwAGrVeCT3QllLtxbCKDTY5x40I/1xyqxaZpxdPj6zbjL1BRp9yqeih/F/DvMMbkuN
 udCRaMplme50Arzr/+IkiRWC+H5CP8XZxnrPFtspDrdlN/z7wRHlx7d0pwkz7fmdauvrg=
X-Received: by 2002:a05:6938:a093:20b0:c16:76a5:fa9b with SMTP id
 a640c23a62f3a-c1676a5fbeamr177748266b.13.1784128669693; 
 Wed, 15 Jul 2026 08:17:49 -0700 (PDT)
Received: from [172.16.240.102] (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c168716f6dbsm59145766b.15.2026.07.15.08.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 08:17:49 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/4] Initial MSM8953 support
Date: Wed, 15 Jul 2026 17:17:39 +0200
Message-Id: <20260715-msm8953-basic-v1-0-bc4cb5099d8e@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw5AMBBA0V+RWWtSmnr9ili0NRiJRzqIRPy7Y
 nkW917A6AkZqugCjwcxLXNAEkfgBjP3KKgNhlSmmcwTLSaeilIrYQ2TE8q6Vqu8lCbTEJrVY0f
 n96ub37zbEd32TuC+H47NKhpxAAAA
X-Change-ID: 20260715-msm8953-basic-3bcd53790a65
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Biswapriyo Nath <nathbappai@gmail.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784128669; l=1732;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=MWaD/VhgExeY4sz8uM+N32gYS0yiB8yHaqyrWBvAtfg=;
 b=t58RzkAshigtwZGK1/MA87j+9aNfmXLYPIh61LYYs2GalQxwnrm0caca4qrojGkXgYvcujWUE
 7omKfy+8bxbCiAfnfwQdRCXtoZ2128bTCVJs/knoKnakVAGvRVnwvYi
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Thu, 16 Jul 2026 03:03:52 +0200
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

Add clock and pinctrl drivers for the MSM8953 SoC, and activate reserved
memory carveout for MSM8953 and its sibling SDM632.

Note, that to boot successfully some more changes/quirks are needed:
* Decrease CONFIG_SYS_MALLOC_LEN to e.g. 0x1000000, default value
  crashes u-boot.
* Disable prng in msm8953.dtsi, crashes u-boot.
* Optionally disable probe of psci-sysreset driver, not functional on
  msm8953 and prohibits the pshold driver from getting active and
  working.
* Optionally add simple-framebuffer to sdm632-fairphone-fp3.dts,
  together with some lk2nd parameter this makes framebuffer somewhat
  functional. Have not played around too much to get that working 100%,
  since booting via lk2nd anyways is maybe one bootloader too much.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (4):
      clk/qcom: Add MSM8953 clock driver
      qcom_defconfig: Enable MSM8953 clock driver
      drivers: pinctrl: Add Qualcomm MSM8953 TLMM driver
      mach-snapdragon: Do reserved memory carveout for MSM8953/SDM632

 arch/arm/mach-snapdragon/board.c       |   6 +-
 configs/qcom_defconfig                 |   1 +
 drivers/clk/qcom/Kconfig               |   8 ++
 drivers/clk/qcom/Makefile              |   1 +
 drivers/clk/qcom/clock-msm8953.c       | 141 +++++++++++++++++++++++++++++++++
 drivers/pinctrl/qcom/Kconfig           |   8 ++
 drivers/pinctrl/qcom/Makefile          |   1 +
 drivers/pinctrl/qcom/pinctrl-msm8953.c |  80 +++++++++++++++++++
 8 files changed, 244 insertions(+), 2 deletions(-)
---
base-commit: 501d76ca801343cce6dafb17740a8b679ed17072
change-id: 20260715-msm8953-basic-3bcd53790a65

Best regards,
--  
Luca Weiss <luca.weiss@fairphone.com>

