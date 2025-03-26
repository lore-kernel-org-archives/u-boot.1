Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F59C3600E
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 17:40:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D7DC81D27;
	Wed, 26 Mar 2025 18:40:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ab7TnJf7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E1F281CFD; Wed, 26 Mar 2025 18:40:48 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53D588070C
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 18:40:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3914aba1ce4so22467f8f.2
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 10:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743010846; x=1743615646; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lbHWV3QzbgWe+QqzC7Q1naPBkyswwhxfK+RbRVhw4Ls=;
 b=ab7TnJf7kOSD+rA2G2YPbFG0PCiHaPCINPdyPvy9h0CwC2vnAJuu8Lj7qsvn3D+XFn
 hPKzhSOrjlGLR6GORiNUZHcGG3EQXRj8raBRFtw+vYO7dxtWngYF95xxY290VaHIwMsy
 /P0Z2hwTXtwcm75jjH/q4z1qaPEjzts5BPQ/v8elFOscIZnFHmcHZKqarKUDn6uEq2Gh
 LYO7ed/RWYFtSqzA7EDj430GCmg/nF+7oQQC7UKl8BjBEU9c2BYcWiWDOcSbBLFK8aXf
 nCN483qnQxLY1eUAF3Agw2HCoHNuk8jjk0oEAWs6COatWuTLLLEyL9CYF8fm2i0GIeW4
 nQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743010846; x=1743615646;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lbHWV3QzbgWe+QqzC7Q1naPBkyswwhxfK+RbRVhw4Ls=;
 b=DXdw9UNoyoteke891xKWmPb/F2K2AFvObkpsBZmiMo7ZgupqNkrMlE2GlNpyQSUZBB
 MSdNI4Y7FUcXHcWX4mhEqdTjMA7qHbsnDnZEBLccOdE5Q511AatQrdyUoT6YAqEQROFC
 XO2ROphXafFlEi7Sn6MrJKFguRnHWObRXqX/jeB92TE4LkAZ6/oQSzvL2DwYdUgVqtzT
 fFMG5f8LEZH43+riHROZF/19eTlFvHWoBYfOvqpRorse7ier7iZIPUZlWTeyBl2anDeB
 11swnmdBkzEbu1CdimlKJB31zkeSHAXb6pywENWLQWipCK3ppj0Hnvw8xOn/Iev5aLB0
 qolg==
X-Gm-Message-State: AOJu0YxWjHWBddluXrRqPF+bnFHAvXNwf+dfF+mTt6YfsdhAG6fdCIds
 ElzC8Pwv03xT4ezO32cymcjHC9sL7rgN4kRZt954yZ1y+rigpaZl6uvm9NUmnhI=
X-Gm-Gg: ASbGncuTO3cvbcUuQMbk/7opcSpKPRFA/ENrDkU54ovgDUCuN0c1kieNwCjwEfBM23f
 Ioer9l/5qJ/EKukXGAbWtvVdr5gcLSzm6faCvNef3CZ3zJXXbaInE7imnghtoHpr8sFqWtQ5lpt
 BxlYjce7CSZIeF0/5PdSLBU9kfUWjdBXMKMhw4IplqymqQp2DqNHgRQE2F0F9BE8nF8o7zSdQEf
 +D/ecGIUjhCloumYuDt31lS4EfkxE0ckP4R+anxDD5DR5IxtiiXQdegfjwxFrRfMraCFBsyt1P6
 Dpg+ZiPv53PwUtivV5THWIBsHhE+GJH90CMbbNIITBa68F3UwWkazFFyg6pCwKtRyN0HjslDMth
 e7Q89/p7ReuWY
X-Google-Smtp-Source: AGHT+IFOw759HAUziFLOJ2W1G4nhwGHpqmNQtsj1nPNuoWWmi6MMDpMwyCBXuTGxcOfGG1lHDsm3nQ==
X-Received: by 2002:a5d:64cc:0:b0:398:fd9b:b935 with SMTP id
 ffacd0b85a97d-39ad1773756mr231810f8f.53.1743010845696; 
 Wed, 26 Mar 2025 10:40:45 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9957d9sm17397321f8f.9.2025.03.26.10.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 10:40:44 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 0/4] Qualcomm: expand capsule update support
Date: Wed, 26 Mar 2025 18:40:33 +0100
Message-Id: <20250326-b4-qcom-capsule-update-improvements-v1-0-afe2e3696675@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABE85GcC/x2NywqDMBAAf0X23AWzVgv9ldJDTDZ2oXk0q1IQ/
 72hx4Fh5gDlKqxw7w6ovItKTg3MpQP3smlhFN8YqKexH2jC+YoflyM6W3R7M27F27VZsdS8c+S
 0KpophNvsyBtP0EqlcpDv//J4nucP6QC22HUAAAA=
X-Change-ID: 20250326-b4-qcom-capsule-update-improvements-16ff7bc2d1d2
To: Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2104;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=EajohAMycOKYak3MdC+0pV+eulP9UppaN531o0tJWto=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn5Dwb+HckjkQnag0NVbwJQ2HiIxTGqG9inlhD1
 1kKLLkE4SyJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ+Q8GwAKCRAFgzErGV9k
 tq3rD/0faBGNk138Y1xXTgbjjvqqfldbArTTPCuAAXalooynmC7tN6G+4O4bNo2UkYH031a9BC7
 EoWLYl7NTX+BL05NEw+uc3bIzHD9/O1s/uiMgmsaJn9NgUJrPUo5nZcC8iPBnAB7G3YoFnMjSS+
 kPQwCxq/sBbOn/O50CvnGoPOw5bB3fhELwxjYe35bMCntvggf0oS5yV1W1GJ4T6nPqc/PabW+ai
 ynsFPlrcGsHhikdFMf0VulAkQuhj2y+XGZGLa1i5jMlwwQy568WjeQ5pUCkrzz9TvkGoiHM+6Ft
 cWLbbRXhXCH3hq5Abs4gHvhPkVydmLYkCpLKgg7BGYVar4/WjzwRn4T94FvsF/riVOWVN5WE77C
 p0ib6v8DoGgiFofPdWmcaUM+XJ1BGEdcOCfA6cLUd2Mtb1Pz8epSeVM367KyIa5qhSVgpVpvsCP
 OtU3BtCFAXkmqSAFmPYTo6K2M/+ugW6bhF4PEZe/oCXgCCpjqHaIrSfFweb46vlLecuTs4pbym8
 G6QyKoJmQgxC9CSjFQHcubSoHnVhwDiX1Qw4Qd2YVjf9IIxJcF5NXw5jY/01CTczZZz7fynnMSZ
 y55IBO1bC1oRA07lIi7qMo6ARzigJW/Ilu/dqzdk3rnhJ3wGClIMRxVHRusYgx9DOl9flY6Gaww
 G0eRt5lcITkKSEw==
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

The initial capsule update support only worked on the RB3 Gen 2 and made
a lot of assumptions specific to that board.

Implement the logic necessary to update U-Boot no matter where it was
flashed to, independent of any particular board.

First, we keep track of how U-Boot was loaded, specifically if we had a
valid external FDT (even if we didn't use it) this indicates that we
were booted via the Android bootloader, in this case the target for
capsule updates is the boot partition. Otherwise, we target the uefi
partition (if it exists) or the xbl partition. We handle A/B support for
all 3 (currently we always flash to the currently active partition with
a minor exception for the uefi partition).

We introduce two new fw_name strings to differentiate the GUIDs based on
the target partition, this means one board can support multiple boot
methods with capsule update support for all of them (typically this
would be chainloading OR flashing U-Boot to XBL).

Lastly, the call to scsi_scan() in dfu_scsi.c is removed. Since
scsi_scan() unbinds all scsi devices it breaks device handles maintained
in the EFI layer for the duration of the capsule update process and
causes the EFI filesystem access to delete the capsule file after the
update to fail.

Boards should instead be responsible for calling scsi_scan() before
initiating DFU.

---
Caleb Connolly (4):
      mach-snapdragon: track boot source
      mach-snapdragon: CapsuleUpdate: support all boot methods
      dfu: scsi: don't call scsi_scan()
      qcom_defconfig: enable capsule update support

 arch/arm/mach-snapdragon/board.c          |  25 +++
 arch/arm/mach-snapdragon/capsule_update.c | 256 +++++++++++++++++++++++-------
 arch/arm/mach-snapdragon/qcom-priv.h      |  14 ++
 configs/qcm6490_defconfig                 |   6 -
 configs/qcom_defconfig                    |   3 +
 drivers/dfu/dfu_scsi.c                    |   5 -
 6 files changed, 245 insertions(+), 64 deletions(-)
---
base-commit: 68ac813c70d991ec518d0fd815efdb10a05958c0

Caleb Connolly <caleb.connolly@linaro.org>

