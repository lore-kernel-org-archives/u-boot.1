Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39DDC3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 12:20:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3896F8870D;
	Mon,  8 Jul 2024 14:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GBlCMfGz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1D748871A; Mon,  8 Jul 2024 14:20:29 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 452DE88702
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 14:20:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a75131ce948so464965466b.2
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 05:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720441227; x=1721046027; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=auAQiDihWq3ThsjT1fWRXmKK/xQK8sp1Eli8H22YoF4=;
 b=GBlCMfGzl5sHHwyH3eaClNGDFcmdK2WhSLPgGMPGFdJBmj9kET/MZZv+HP0gapUNYy
 v/RnCN/Mq4q4nZ3UZd7eBvaQnT9m/AXnWdbBvsF3OzSyDcuolfS1APJUH5svHVf4w6pD
 0XC3qQydmEOrNz7GNca0RoKQ2Dr5LEkE4KE5dVM693oe0+t/AtIUIRlR/Bv/S7Vmvk90
 se9i78BrmWp/kTASPsMPNO2A30DTrGNTkoVYT7VFmwyuARg64EoOAnrUQAcoi4ovVkSJ
 RCwH1Fp+K9INSH3DQXg7zlN1O1yYzgh8CAoCLA8ZPm3Ivh+HTTYXsEV9OgGQFij5QEut
 BPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720441227; x=1721046027;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=auAQiDihWq3ThsjT1fWRXmKK/xQK8sp1Eli8H22YoF4=;
 b=Qca0m6X/Y5MWdBRYeS21QnBjyITCQRTw//zt/jTFCjlV/+oCjL9jdzfYdyI8dRVIlK
 6H7WoQo1dn6/UIrR30XZyA518ZdhuVVfQFi1xG1geAtoo9Sx9L9/zdCJA0HN/qZ2fqAl
 0AlNdyvdIeBry00OBGLus5GJ7Fp/WpG2gLPK/TSoDcAcxGM9/3ATAoy8kGaDZ0Zwi5WP
 9+Ch8EkCoXEA7pIZBEarPlSYsRdlEsDr1YFn9BGn0v/00lYMF9mBBgy9vMwoW0chWJ5f
 T33S8VcHtlk32bzZ+7zQRBzT0v0C9k2UJRqNGEsH/Mm2xJWDtnFGhBUHBPe+AKeyD/9O
 qE6A==
X-Gm-Message-State: AOJu0YwEa6lpBuLHKQf2T5B6lmxw75Vjrf3p+A4ZRR2mZvXAa6vu5jlg
 f86q8WgvTXQLPhtHpEmkzYZ9xB/NUTKWqT3GMc9/MYz2DZz/00sXM7Q3IWTL2LdSuvLoNoSji3+
 6goA=
X-Google-Smtp-Source: AGHT+IG0D6Ano7GhrWpK0t1d3RA1b265f1a3CH26d4IIkvsClhITXSHpnDvo6UUfxbEjSK080szGvg==
X-Received: by 2002:a17:907:7212:b0:a77:cf9d:f497 with SMTP id
 a640c23a62f3a-a77cf9df678mr679408466b.40.1720441226642; 
 Mon, 08 Jul 2024 05:20:26 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77e8a7eeafsm188364766b.47.2024.07.08.05.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 05:20:26 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v3 0/5] qcom: rpmh core and regulator support
Date: Mon, 08 Jul 2024 14:20:22 +0200
Message-Id: <20240708-b4-qcom-rpmh-v3-0-846cc6c5b728@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIfZi2YC/13M0QqCMBTG8VeJXbfYznRqV71HdDHn1APp7CxGI
 b57U4iwy++D/29mwRG6wM6HmZGLGNCPaajjgdnejJ3j2KTNQEAmtJS8zvjD+oHTNPS8tW2jwFi
 oMsFSMpFr8bVx11vaPYanp/emR7m+X6jYQ1FywesGlNIVKCfM5Y6jIX/y1LFVivCrC1H+1ZDqs
 raFzrXQLte7elmWD+fyCiXnAAAA
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3771;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=qU2vOmdqqxMs00OV53lgxQ9Bk5hlsiYwz0tPY3T48Lg=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmi9mIatiZnmCl3lBz+IhV88SeMO9CXhmjcO4dc
 LyK7xEvn16JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZovZiAAKCRAFgzErGV9k
 tq4AEACS+5y/rzmYbKKZtfZ2ULotq5/cZx+12RT+gAEoJVzmLrzkNmcdirrdv3ADHmEpmiX9blR
 VROX69flTuK10nwfG9FDoV9nKlNJ2z36364LcVjyvgRNOH5fd/XFz7WbCuzeeQHJxmdFMNDpXdB
 fHN3VAzGS5c3a/hcJQx24yey6kM6HiGy561nRNIIqnpl9z6AwxsYJSPciR89BygoXyFKJtKVBML
 wtgnfRF3SyuOgGqwfXqGPzWHATfW2z2lG8eg8z+peEpQCUE5QpZBcoENZF7hiERCkIXCX/B3Izc
 hpr/IQ1yqO64HgLPWpDPuHjGsgw1letITbazROCVZl1aZ3DPwT77SE8P3g/96QLRm0siL66Zt99
 ZEw9NGmjZzJqoPOY+CHFkXo+RlA4oXyPc9EYm2exD3uuZqFpXO/ChK2lq80ENXng+gC6G7izh5m
 hF7WIQhS9yO/Bfd1aNm9nKSQMleaVWnzqDbEPpfRSW7kfxskzTs2041O3gqwljaTC7I2dvY/x89
 cYGKip6trWOflyt2d97u1VfEqeBms2jvfXQGNGJPGId/j+aFoKyfkSCGxQMA/JvqHJBYchwnPv4
 WMPbt+mxS4fW7YtY7UECJz0iiRpnV/VAG9BE1U5A0f4F1EtKSvb4swgSRzttgvWT9DcpikYQESd
 jcJGlNDUyngw6kg==
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

This series introduces support for the RPMh (Resource Power Manager
(hardened)) co-processor and associated regulator driver found on most
modern Qualcomm platforms (since ~2017).

Even though most regulators are controlled via SPMI, the specific
regions on the PMICs for controlling the regulators are restricted and
can't be accessed by the Applications Processor (AP/HLOS). Instead,
these resources are proxied via the RPMh where they can be voted on by
multiple subsystems (Linux, the modem, and the other DSPs). This is done
for security (to protect clocks, power domains, and regulators that are
specifically relevant for the trustzone) as well as to simplify the
management of shared peripherals and to allow for handover of
peripherals like the USB controller.

For U-Boot, our main concern is the regulators. Since all regulators on
the system are controlled via the RPMh, it is necessary to support it to
enable USB VBUS on some platforms, and may be needed for other
peripherals in the future.

Communicating with the RPMh additional requires accessing the cmd-db
shared memory region, this contains key/value maps to determine the
address of specific resources on the RPMh.

Introduce support for the cmd-db, the RPMh framework, and some of the
regulators that are necessary to enable USB VBUS on the RB5 development
board.

These drivers were originally taken from Linux, however they have been
heavily modified and simplified for U-Boot. Since the original Linux
drivers contained heavy optimisations related to multithreading and
asynchronous probing, as well as support for idle and suspend states
which we don't need to deal with here.

The U-Boot version of the driver supports a single TCS and always
requests a response from the RPMh, since we don't need to worry about
having multiple transactions in flight at once.

---
Changes in v3:
- Don't call dm_scan_fdt_dev(), since DM core will scan.
- Link to v2: https://lore.kernel.org/r/20240708-b4-qcom-rpmh-v2-0-8bc765606e56@linaro.org

Changes in v2:
- Implement Neil's suggestions and fixes for SM8[56]50
- Slightly refactor cmd_db_init() for better abstraction.
- Improve logging (printf -> log_err/dev_err)
- Add missing error check in rpmh_regulators_bind()
- Link to v1: https://lore.kernel.org/r/20240617-b4-qcom-rpmh-v1-0-bd2336923e0a@linaro.org

---
Caleb Connolly (5):
      linux/bitmap.h: add bitmap_empty helper
      soc: qcom: rpmh and cmd-db drivers
      power: regulator: add qcom-rpmh-regulator
      qcom_defconfig: enable rpmh regulators
      fixup! soc: qcom: rpmh and cmd-db drivers

 configs/qcom_defconfig                        |   5 +
 drivers/power/regulator/Kconfig               |   8 +
 drivers/power/regulator/Makefile              |   1 +
 drivers/power/regulator/qcom-rpmh-regulator.c | 536 ++++++++++++++++++++++
 drivers/soc/Kconfig                           |   1 +
 drivers/soc/Makefile                          |   1 +
 drivers/soc/qcom/Kconfig                      |  25 +
 drivers/soc/qcom/Makefile                     |   4 +
 drivers/soc/qcom/cmd-db.c                     | 261 +++++++++++
 drivers/soc/qcom/rpmh-internal.h              | 141 ++++++
 drivers/soc/qcom/rpmh-rsc.c                   | 628 ++++++++++++++++++++++++++
 drivers/soc/qcom/rpmh.c                       | 112 +++++
 include/linux/bitmap.h                        |   8 +
 include/soc/qcom/cmd-db.h                     |  42 ++
 include/soc/qcom/rpmh.h                       |  29 ++
 include/soc/qcom/tcs.h                        |  78 ++++
 16 files changed, 1880 insertions(+)
---
change-id: 20240611-b4-qcom-rpmh-fcfd32ac2940
base-commit: 50adc932e7aa34e6d9c738ec13ed09382a9d109a

// Caleb (they/them)

