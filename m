Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5376CC369D9
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 17:11:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D29282161;
	Mon, 28 Apr 2025 19:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="UfRJ7hfw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06AED8215F; Mon, 28 Apr 2025 11:16:29 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F13E080EFB
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 11:16:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39ee5a5bb66so2813147f8f.3
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 02:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1745831786; x=1746436586;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/hpTiR2QRM6TRJhGTpPxEeGIVQs9JadMwGFAnqIzlUo=;
 b=UfRJ7hfwAbBmhl23IGhoHAdTTsEc6XlSxWoqvEtdbndcysZdNp3vIbC80Tet7niq/S
 TRS/2CyMg4gexk980/o6+DNvXY9OdEadJBo3OD3yinG7FV5cJcBWa2ZsXEYKEMIGtRko
 JlIgUNDXR4cL5DTLUZ6eHuOgfjnCiuGUJADyfZKtM+vXiYb5fkXQUlcHhoLWuIDPscWu
 /QKXzU6d/2hYdXlqEy/v0jWRADl6nkxTqnSnqFy+U1eb+q6mg0jHjupqQ6YMXvP7rUnj
 qGnu47UOXcYa9JkglY55BFO8k8yoyky2P3jqWTUiToR2zR3dixiC5Wf1I301e68MLj2H
 888w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745831786; x=1746436586;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/hpTiR2QRM6TRJhGTpPxEeGIVQs9JadMwGFAnqIzlUo=;
 b=vM/NX678QZRwdPZvX9hM9bM8dUT5buDLu2/bjyK2AY2v9bel25eBiW2XJLwcvTYI89
 kOWM567rQ8Cokn+GMHstZK9sCEpLyQMad/HiXzZd+FWlX5VET7tehieIeEHofBTD3JVV
 +D9xFX5fSdOx3jQ/8AZ8UhBydFRn6Rdj0fq0N7xvcXz1lqsVuttGyo8AToXlCef5jSwg
 TkQ//KEiZCwX+TzpuFaR/44TNQTXNx/Vqwu9x9vSNs09GMG1kBqa44Y3vQitMjWqcB0D
 NdckuiHriTKuY0ifcPAYnkJos/13M5bY/3jP5Btjw9LW83ICnSLyuNsGDelEIg4bMRqZ
 hOLQ==
X-Gm-Message-State: AOJu0YxROtW9Vgs+VK2TR3Sw0QlR09QnmfN/DTrd0dbd4sfUBMsR4ZTB
 ivXxawhOvis01pUuGRubMMUs4FJH3nVKJ3j+WWspsk1dgM8h5dlrxEeXScGoA2A=
X-Gm-Gg: ASbGncvmTze1J9DUxILErs+6RfIwETx/pdb1xQ/f4E7TLC5naRW4CNg+rjX04nEfYrq
 0yJzGUSUNa4cRLK1w1lQHKViqIYLrxarIViCqGV5LNPqVVZPKKk9ckv2OM7dMcVLqjs0Er9BLY0
 P1rcAK6Ri0aIqlTxANXNc+itUNebOlIx4AP0p2xs9U2oOYHPliJOU97CzckeEL73WQzVi462aXX
 HDF0tYjZBqf6OeIplFh/IbAhAPEZDGPaA4/De6vL/5QkJGAhfc5irfZeViOYf81iYuPmNOSI8lb
 hlsHiUoMvMqZyrhElt8Gfjdn8i/Dh1OEr97G59I=
X-Google-Smtp-Source: AGHT+IHmcFWwztbNBzOv1sk7NIkOgwksbNVnSZycoVLpDI1vdjFuz9rDm4nkNTYtwWqimd8E1HHj6g==
X-Received: by 2002:a05:6000:2505:b0:391:412b:e23f with SMTP id
 ffacd0b85a97d-3a074e1a1bfmr8847235f8f.15.1745831786346; 
 Mon, 28 Apr 2025 02:16:26 -0700 (PDT)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5da0dsm10345258f8f.88.2025.04.28.02.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 02:16:25 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
Subject: [PATCH v4 0/6] watchdog: at91sam9_wdt driver enhancement
Date: Mon, 28 Apr 2025 11:16:22 +0200
Message-Id: <20250428-wdt-v4-0-bb7d1c7c051a@hifiphile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGZHD2gC/12Oy07DMBBFf6Xythg5fqQxq5YuukEVEhVCIBYmG
 cdTNQ+c4LSq8u84YQNsRrrSnHvPlXTgETpyt7gSDwE7bOoY5M2C5M7UJVAsYiacccVksqJD0dP
 CpCplefLBVUbiZ+vB4nlueXuP2fqmor3zYGZ2u1nuLp/wujc20bJ+cdtzeE4fHu29OgIqHw77r
 +GpXO7KtB0UO4jjZl0ZPN2W882bahpx2PWNv8ymgU9Tf6UCp4xKrYUuQK4EJGuHFluHJ5grJrE
 gfnE8++FE5LLUslwVmueC/+fGcfwG/P4uEScBAAA=
X-Change-ID: 20250417-wdt-da6560c1b258
To: Eugen Hristev <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, Zixun LI <admin@hifiphile.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Mon, 28 Apr 2025 19:10:16 +0200
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

This patch series includes some code refactor and adds new device support
for at91sam9_wdt driver.

Instead of add a new driver like Linux kernel, at91sam9_wdt driver is
extended as new watchdog variant is similar to existing one, especially
for the function subset used by u-boot.

1. Remove typedef struct and rename variables for readability.

2. Add SAMA5D4 compatible, it has the same watchdog as SAM9260 except a
new lockout feature is added. Currently this feature is unimplemented.

3. SAM9X60, SAM9X7 and SAMA7 series have a new watchdog variant, some
bitfields bof MR register shifted their position, a new register is added
for timer value.

4. Add DT node to SAM9X60-Currently board

It has been tested on SAM9X60-Currently board:
- Start & stop
- Set timeout from DT node
- Reset kick in with a while(1) loop

Changes in v4:
- Move 'timeout-sec' to at91-sam9x60-curiosity-u-boot.dtsi

Changes in v3:
- Merge relevant commits into one
- Match DT node with Linux
- Move default timeout from board dts to sam9x60.dtsi

Changes in v2:
- Fix SPL build

Zixun LI (7):
  arm: at91: wdt: Remove unused at91_wdt struct
  arm: at91: wdt: Rename regval in priv data to mr
  watchdog: at91sam9_wdt: Rename priv to wdt
  arm: at91: wdt: Add SAM9X60 register definition
  watchdog: at91sam9_wdt: Add SAM9X60 support
  ARM: dts: sam9x60: Add watchdog DT node.
  ARM: dts: at91: sam9x60-curiosity: Enable watchdog node

 arch/arm/dts/at91-sam9x60_curiosity.dts    |  5 ++
 arch/arm/dts/sam9x60.dtsi                  |  7 +++
 arch/arm/mach-at91/include/mach/at91_wdt.h | 25 ++++++----
 drivers/watchdog/at91sam9_wdt.c            | 55 +++++++++++++++-------
 4 files changed, 68 insertions(+), 24 deletions(-)

--
2.49.0

---
Zixun LI (6):
      arm: at91: wdt: Remove at91_wdt struct
      arm: at91: wdt: Rename regval in priv data to mr
      watchdog: at91sam9_wdt: Rename priv to wdt
      watchdog: at91sam9_wdt: Add SAM9X60 support
      ARM: dts: sam9x60: Add watchdog DT node
      ARM: dts: at91: sam9x60-curiosity: Enable watchdog node

 arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi |  4 ++
 arch/arm/dts/at91-sam9x60_curiosity.dts         |  4 ++
 arch/arm/dts/sam9x60.dtsi                       |  8 ++++
 arch/arm/mach-at91/include/mach/at91_wdt.h      | 25 +++++++----
 arch/arm/mach-at91/spl.c                        |  4 +-
 drivers/watchdog/at91sam9_wdt.c                 | 55 ++++++++++++++++++-------
 6 files changed, 73 insertions(+), 27 deletions(-)
---
base-commit: 10f48365112b164bee6564033ab682747efcb483
change-id: 20250417-wdt-da6560c1b258

Best regards,
-- 
Zixun LI <admin@hifiphile.com>

