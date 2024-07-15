Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9886BC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:08:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E676588655;
	Mon, 15 Jul 2024 12:08:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Cpk+tP/X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C75E887F3; Mon, 15 Jul 2024 12:08:12 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C307F88639
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:08:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a77b550128dso516733566b.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721038089; x=1721642889; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NW6nLEZDZHvBK/qD3zEo7NY82tibdmVHyrZVVRGfSck=;
 b=Cpk+tP/XuoYFLS0gqUjLH4nLcJIcDlXcJIizwb72S3Oq7aH2eU9kATPk6GgvRxV4fq
 UJsp5z/+V0V+b5bxxXjPajsKMpFF2lOPn+0pLZivT+zzMIlvmVjmEP4FPTGrU5jIGMYp
 1F11mQnCHyXaa3PH9RRmihR6rMy43VoajRR5Fy8apVr8JVVwt02AzbvUJcK0pomlRDv1
 pLAJv/jRv7BRtJxL4/BkAZauIUWJUkJ+QU0Hhlz943v/+iLbdD0cFRfFp/xTI1xmh1tj
 xyoNj6VtEf2nMQ8vzT6UGZikfCGyVavo/ut45j/8FLJfOXDesQ1ASXsqujMjBIfRhO+J
 g8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038089; x=1721642889;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NW6nLEZDZHvBK/qD3zEo7NY82tibdmVHyrZVVRGfSck=;
 b=pvAjVKLRi1n/iernKTWC1qMF7bPEFHPtNqvjOJMMd1g5lAOrJL5fM8vSH6BhPJ7aAG
 ONYNY31dwLtuV7Pq2d/v8k9HtaGJXZeko6trV7VieM/H+sIatdV1n5U5RUsnas19hiTs
 /JcodLxAGxr5KcEkcldGCZRCANHpowkqpe8VKUQwYoqMHPSUwG6F7vMJgxl61EVwByVI
 xOOo2SRhCpA4khiqX5guAISqkWcILxYYlhUaLQOd+C+5vE9Q3LpB07l7qoTQ9kzozVm2
 3DFB257De6W3jU11aWIESAw14BAMZKms3KUWBAOXgUejNxPjSIbenFRSHIj2qpFo7KOQ
 vOWw==
X-Gm-Message-State: AOJu0Yy/3czf9K7L3TzuYJrUNZeTlms35IxV/F/7feCvOnvIj9weCrKR
 /Acn3U4M9u3btucbF50ums3Q2ZzxKmIS7o8SpCdW8T7XtgY4PyUeinKJ7FZDETC8WJ71tTFIwfq
 E/z4=
X-Google-Smtp-Source: AGHT+IH1ZW3YxMTD8Mk5ijANtXmJ75UGUhOG25Uoszd+5k57kRe5UDfyt858nyqQt0j7B0fyb8x9DA==
X-Received: by 2002:a17:906:493:b0:a77:eb34:3b42 with SMTP id
 a640c23a62f3a-a780b689212mr1278483866b.12.1721038089159; 
 Mon, 15 Jul 2024 03:08:09 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5b7eb4sm198102266b.60.2024.07.15.03.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:08:08 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v6 00/24] qcom: rpmh core and regulator support
Date: Mon, 15 Jul 2024 12:07:59 +0200
Message-Id: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP/0lGYC/33Q0WrDIBTG8VcpXs9xcjTHpFd7j7ELPdFGWGNnh
 myUvPtMYaxNYJef8PsrXsXsc/SzOB6uIvsS55imOujpIHi008nLONQtEFADNY10Wn5wOst8OY8
 ycBgUWsZeg6jkkn2IX7fc61vdY5w/U/6+1Uuznv6GzGOoNBKkG1Ap6lF5sC/vcbI5Pad8Emup4
 J820G00Vt05NtQSkG9pp9V/Wq1aEzNx6wx2O63vdb/RumoGGsAikdb7l7d3evuBpa06uACaPVn
 jH+9eluUH79jSF6EBAAA=
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6306;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=7urYku25BdYWs3Pf2f26RONAGs4l81OOy6nfF5Ce3Wg=;
 b=kA0DAAgBBYMxKxlfZLYByyZiAGaU9QSiweMUbQq5ui35A4i8IaaLiIByR5Q/WFHX/tfi520xI
 okCMwQAAQgAHRYhBLZRoUY8ar7QaQxVzQWDMSsZX2S2BQJmlPUEAAoJEAWDMSsZX2S2Iz0P/3UX
 d2/I8YOMRSjifgXACInL2s9mOipxLFaVx0Vzx+GXlP4vrCp8YXX6p4fLrey3uegRAc6doyKlm8Y
 0NoNvNoY9JD83fDKsrp3KAYYabCOU6YXRvtchRmoev3et0udvFrz6TUVB45Ci1igqtGSiBiZGXc
 yuFIme12Ig7kAiBL68jC2TRWzYho/eST8FqEtq4nhT9smU7NjBSW4WiP1TznNCQp8ZO2jsQ7lw2
 QEkp0mbi3JQvMlQczs/aGqE8cLn/jnmVjzJPMjQ/2j0UK1rutR4s3RbHKH+eNV97zvRvzV9l9na
 +IzKbjg/k4bu8UbeiLD7FdnTaTxGPW8iaRx13Wn+PzJhRAftzBDp1IdbN87yRULdfKKpRoZ7bQb
 Ymb/X4CQ6sXubzpU0KIoiB22Yp7pNev7mMtMByHbyXa8UOKwXuYOU3ELaUO7UkiLX21ZCOWg7sE
 aTtuGwvGvoWtlKRIo0yWWEz0V/1a/nZW8xrrau+RiZdNJ9eRK+WrMggQ0qXHngAjwI0vKIoKrZs
 gjrT6C9ZztWWgMXasxdfpwI4v9QkggrJgoLOIB8lJf67XWzDesiq1kXbhGjC8DboJUsnDdMFf02
 Vetwl694d67l3wDRrkFJU8z65jFHdK/KbPLhuRLdPhfu99bxEJySFfUDJeNjiZV+QgHXwRLBrYe
 b8Hoi
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

These drivers are taken from Linux, then modified and simplified for
U-Boot. The original Linux drivers contain heavy optimisations related
to multithreading and asynchronous probing, as well as support for idle
and suspend states which we don't need to deal with here. This unused
code is removed before finally adjusting the drivers to properly build
for U-Boot and use its device model.

The U-Boot version of the driver supports a single ACTIVE_ONLY TCS and
waits for it to be cleared after use. We don't support programming
low power states.

To: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Cc: u-boot-qcom@groups.io

Changes in v6:
- Use the driver model for cmd-db
- Extend dm_extended_scan() to scan nodes under /reserved-memory so that
  cmd-db will be bound.
- Link to v5: https://lore.kernel.org/r/20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org

Changes in v5:
- Add Kconfig / Makefiles after introducing drivers to avoid breaking
  compilation when bisecting (Thanks Neil).
- Link to v4: https://lore.kernel.org/r/20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org

Changes in v4:
- Denote original Linux version in bitmap.h patch
- Rebased on Linux 6.10-rc6 and re-apply U-Boot changes preserving git
  history. Allowing for future changes to the Linux drivers to be ported
  over more easily.
- Add missing check to wait for the TCS to be cleared after use (seems
  we were just racing the RPMh before, oops!).
- Fix missing n_modes in pmic5_pldo regulator.
- Link to v3: https://lore.kernel.org/r/20240708-b4-qcom-rpmh-v3-0-846cc6c5b728@linaro.org

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
Caleb Connolly (24):
      dm: core: scan reserved-memory nodes
      linux/bitmap.h: add bitmap_empty helper
      soc: qcom: import rpmh and cmd-db drivers from Linux
      soc: qcom: cmd-db: adjust headers for U-Boot
      soc: qcom: cmd-db: drop unused functions
      soc: qcom: cmd-db: adjust probe for U-Boot
      soc: qcom: cmd-db: adjust for U-Boot API
      soc: qcom: rpmh-rsc: drop unused multi-threading and non-active TCS support
      soc: qcom: rpmh-rsc: adjust headers for U-Boot
      soc: qcom: rpmh-rsc: adjust probe for U-Boot
      soc: qcom: rpmh-rsc: remaining U-Boot API changes
      soc: qcom: rpmh: adjust headers for U-Boot
      soc: qcom: rpmh: drop unused functions
      soc: qcom: rpmh: U-Boot API changes
      soc: qcom: add build infrastructure
      power: regulator: import qcom-rpmh-regulator from Linux
      power: regulator: qcom-rpmh-regulator: adjust headers for U-Boot
      power: regulator: qcom-rpmh-regulator: port over lineage_range helpers
      power: regulator: qcom-rpmh-regulator: adjust structs for U-Boot
      power: regulator: qcom-rpmh-regulator: remove unused regulators
      power: regulator: qcom-rpmh-regulator: port ops to U-Boot
      power: regulator: qcom-rpmh-regulator: adjust probe for U-Boot
      power: regulator: qcom-rpmh-regulator: add build infra
      qcom_defconfig: enable rpmh regulators

 configs/qcom_defconfig                        |   5 +
 drivers/core/root.c                           |   3 +-
 drivers/power/regulator/Kconfig               |   8 +
 drivers/power/regulator/Makefile              |   1 +
 drivers/power/regulator/qcom-rpmh-regulator.c | 544 ++++++++++++++++++++++++++
 drivers/soc/Kconfig                           |   1 +
 drivers/soc/Makefile                          |   1 +
 drivers/soc/qcom/Kconfig                      |  27 ++
 drivers/soc/qcom/Makefile                     |   4 +
 drivers/soc/qcom/cmd-db.c                     | 225 +++++++++++
 drivers/soc/qcom/rpmh-internal.h              | 138 +++++++
 drivers/soc/qcom/rpmh-rsc.c                   | 505 ++++++++++++++++++++++++
 drivers/soc/qcom/rpmh.c                       | 110 ++++++
 include/linux/bitmap.h                        |   8 +
 include/soc/qcom/cmd-db.h                     |  30 ++
 include/soc/qcom/rpmh.h                       |  28 ++
 include/soc/qcom/tcs.h                        |  81 ++++
 17 files changed, 1718 insertions(+), 1 deletion(-)
---
change-id: 20240611-b4-qcom-rpmh-fcfd32ac2940
base-commit: 834df20b4ef50cda26936fbc435689fa0c5d47b1

// Caleb (they/them)

