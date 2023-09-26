Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF2BE7D241
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 07:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06DFF86D74;
	Tue, 26 Sep 2023 09:01:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="edzqbOE9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02F4586D7F; Tue, 26 Sep 2023 09:00:59 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CF2A86D39
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 09:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-277317a0528so931446a91.0
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 00:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695711655; x=1696316455; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BKpoV/S9Mh/um75qWsxIS7qrJrFqiXKSQ4LJ5n5XmHQ=;
 b=edzqbOE9MWsjUbOCqryxyRFBr+rFS2AHa/e2vLrC3R7eNJgKqKhaBs9tKLicX2nQ8A
 nHM9mQcsEKtghyKmb+dbTYaJHKDRDNeDvls31FJbmxtRRkTzW9D1wfrHSPYMDKzeXqY6
 PA5xI8UTep4lDmiRbmZeHG3qRXFg3ANk0yQlGGMDkcWuF/ko+QmY+EUPsEdsw1A9sgOO
 3Sl5niWEpgAS0/JmCrMpBsA92EZr1YFD+qixG7SdGHv/HmgHUxSKVeVscmjzIB1T55h7
 l/hxyuvGKEJOA9Ct7rzA9HktjGJmyvXF80RhcFm5eRXhzhbcPjuYgHOYb+pmZZ5uJJ+K
 8ltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695711655; x=1696316455;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BKpoV/S9Mh/um75qWsxIS7qrJrFqiXKSQ4LJ5n5XmHQ=;
 b=hzaNwM3SIz0QvczGn/+u18IXq51bS9vAAzBmgZ1zKX5KbNDz0ne4kfBwKoDkIWzCW7
 weitx2UQKVKiR1crtbvYxlE1PskMuvy+iTtI1fzU8NhtJetRY0It5sCOYdrl19raP3ZC
 Doag2qBQysgcLaO/r4BssNekUXNb7rZP6OSSRs7A8MyTPZULryfIVj7rzPzUXlRuutnD
 eo4uwfcM0T1apRGVc0XWCFq1w6gN/oJ3Z6Zv4PfWHvzl8lHXbnOPiWsJqhuGYuo8CV13
 eqZ/TTtta4XyTUt2vG+af6DN9Oe9vKG6Edx3lwhZOtAYO9rVKMnvvsE/NzwrCb21I+Ck
 3uiw==
X-Gm-Message-State: AOJu0YwE2SA/MezrSrDfhiyqNTTnsfCVKaZMfDygmXSUrAxQ6HXTIO7A
 Kex5kzFcdoWSC2X/gUn7gbMLGg==
X-Google-Smtp-Source: AGHT+IEq8D6o7vvFBzYS3KqbUK0nXIHSPUK0dTPtt5u3E3vyurMLeo9YrTYMA2Ekkw1KPfQ1nu+1eQ==
X-Received: by 2002:a17:90a:51a2:b0:26d:1f75:7fa3 with SMTP id
 u31-20020a17090a51a200b0026d1f757fa3mr7845257pjh.4.1695711654763; 
 Tue, 26 Sep 2023 00:00:54 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:6585:aea6:5002:a825])
 by smtp.gmail.com with ESMTPSA id
 ge13-20020a17090b0e0d00b0027758c7f585sm3178480pjb.52.2023.09.26.00.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 00:00:54 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 0/4] firmware: scmi: add SCMI power domain protocol support
Date: Tue, 26 Sep 2023 16:00:39 +0900
Message-Id: <20230926070043.738340-1-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This patch series allows users to access SCMI power domain protocol
provided by SCMI server (platform). See SCMI specification document
v3.2 beta 2[1] for more details about SCMI power domain protocol.

The implementation consists of two layers:
- basic helper functions for SCMI power domain protocol
  in drivers/firmware/scmi/pwdom.c (patch#1)
- DM-compliant power domain driver, which utilizes the helper functions,
  in drivers/power/domain/scmi-power-domain.c (patch#2)

[1] https://developer.arm.com/documentation/den0056/e/?lang=en

DT bindings
===========
Standard bindings are applied, i.e.

scmi {
    ...
    pwrdom_scmi: protocol@11 {
        regs = <0x11>;
        #power-domain-cells = <1>;
    }
    ...
}

som-device {
    ...
    power-domains = <&pwrdom_scmi 2>;
}

Test
====
The patch series was tested on the following platform:
* sandbox ("ut dm scmi_power_domains")


Prerequisite:
=============
* This patch series is based on my "Base protocol support" patches[2]
  on v2023.10-rc4.

[2] https://lists.denx.de/pipermail/u-boot/2023-September/531623.html

Patches:
========
Patch#1: Add SCMI power domain protocol helpers
Patch#2: Add power domain driver
Patch#3-#4: Test related


Change history:
===============
RFC (Sep 26, 2023)
* initial release

AKASHI Takahiro (4):
  firmware: scmi: add power domain protocol support
  power: domain: add SCMI driver
  sandbox: add SCMI power domain protocol support for testing
  test: dm: add SCMI power domain protocol test

 arch/sandbox/dts/test.dts                    |   6 +
 arch/sandbox/include/asm/scmi_test.h         |  20 ++
 configs/sandbox_defconfig                    |   1 +
 drivers/firmware/scmi/Makefile               |   1 +
 drivers/firmware/scmi/pwdom.c                | 189 +++++++++++++
 drivers/firmware/scmi/sandbox-scmi_agent.c   | 265 ++++++++++++++++++-
 drivers/firmware/scmi/sandbox-scmi_devices.c |  10 +
 drivers/firmware/scmi/scmi_agent-uclass.c    |  11 +
 drivers/power/domain/Kconfig                 |   7 +
 drivers/power/domain/Makefile                |   1 +
 drivers/power/domain/scmi-power-domain.c     | 197 ++++++++++++++
 include/scmi_agent-uclass.h                  |   2 +
 include/scmi_protocols.h                     | 178 +++++++++++++
 test/dm/scmi.c                               | 107 +++++++-
 14 files changed, 993 insertions(+), 2 deletions(-)
 create mode 100644 drivers/firmware/scmi/pwdom.c
 create mode 100644 drivers/power/domain/scmi-power-domain.c

-- 
2.34.1

