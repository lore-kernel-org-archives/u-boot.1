Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A98CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 08:14:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAEB9883C1;
	Thu,  4 Apr 2024 10:14:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ruei3MBJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B1E0883CB; Thu,  4 Apr 2024 10:14:02 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FC8C883BF
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 10:14:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2d85d0c61c7so323721fa.0
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 01:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712218439; x=1712823239; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XkIbFMNiqh9KoafDqAVtwxqt4PYpq/7JBDzWIW8viwk=;
 b=Ruei3MBJrBtO6IZqNdgQmeF1fxQrzTZgudT3ssgmZkg4cIxYoNYtEyvMvbxAKWUUPE
 OIF9zTzD1qQYztiq0Es/1wYbsqGo4t46IYkNQXPnVeF0WFrSFEmxYI3EE40v6AtljCYu
 1MlhmM4UC9bggnmlUOSheK0ALFyE3Ymkfu5vRTHTosPp1G5iR6nMlA0zj4dqNYEd9qTo
 gPGWUWp/Z1Ez86OaNqvsYIhFpDiBudKx22csa7rBz8FpZegPxGwbwWimWxz0RV+uM+tK
 oHcWCLUh0FrtvxUqHAczR9OavqqBwbZK8r1amMQwSnCL0pgAosSu41WD2rRF3C+4wpt2
 ZQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712218439; x=1712823239;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XkIbFMNiqh9KoafDqAVtwxqt4PYpq/7JBDzWIW8viwk=;
 b=vJUbv8PEXXf1rlF7tAYYuaEPl49D4wVbF7x5XTcKCAqJepEzpH1+CWclbQFRVfDO6c
 yy1mpfQmLm49ugBmJD9NQhIc1NbPV/a17cnY7Uq0rbqgC71C0B1WIUVf/5dMbioBYavp
 i3VnzHE34rTdWy49Eizy+i7oi7yQGFdBZiYuNPJtF7MT3moOcyv/CIY02EiJnkhtIGDu
 NzzBf5jldmf4gH78Td9e+mkkwsbeqA71jkTO6BnxYQ+gdKpO4bi4GnDmTKW7c6eJCw4V
 76IGVe1WeNoq9yGrt+SfewtUg5CMxE2eQAwkcqFoIkZ33DmUPkj4MyZtAxC6TLY2SjwN
 K1Xw==
X-Gm-Message-State: AOJu0YwwIIaZ4hEsDe2bpsNeDo6qEvYS6M0QARLQ7SV5LQ+0JpysPT0t
 L6TzPKG9IVCJknSENhMhS9971xY4auUjrvKmhg1jt1F5ztbcfqQTRCPtWgKOVGahVg==
X-Google-Smtp-Source: AGHT+IE3nxvs2Eo06Yjn5eL97XnwwlWV3V6Nhz+CCPkRQCfvJ9tzD195z3B7/ehUGgsPBjvooFMWyA==
X-Received: by 2002:a2e:2e0e:0:b0:2d4:64b1:25e4 with SMTP id
 u14-20020a2e2e0e000000b002d464b125e4mr1227703lju.3.1712218437449; 
 Thu, 04 Apr 2024 01:13:57 -0700 (PDT)
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 u1-20020a05651c140100b002d69b9a6513sm2172531lje.48.2024.04.04.01.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 01:13:56 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng@tinylab.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Sean Edmond <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 0/5] TEE: minor cleanup
Date: Thu,  4 Apr 2024 10:13:47 +0200
Message-Id: <20240404081352.3224643-1-igor.opaniuk@gmail.com>
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

- Address some spelling errors and typos
- Support CMD_OPTEE_RPMB for SANDBOX configurations and add python tests
- Remove common.h inclusion for drivers/tee
- Add calls for closing tee session after every read/write operation.

CI build:
[1] https://dev.azure.com/igoropaniuk/u-boot/_build/results?buildId=31&view=results

Changes in v4:
- Rebased on the latest master and excluded "tee: sandbox: fix spelling errors",
  as it was merged already by Heinrich Schuchardt

Changes in v3:
- Added calls for closing tee session after every read/write operation

Changes in v2:
- Fixed chimp_optee.c:37:9: error: implicit declaration of function 'memset'
- Applied R-b and T-b tags

Igor Opaniuk (5):
  tee: optee: fix description in Kconfig
  cmd: optee_rpmb: close tee session
  cmd: optee_rpmb: build cmd for sandbox
  test: py: add optee_rpmb tests
  tee: remove common.h inclusion

 cmd/Kconfig                        |  4 +++-
 cmd/optee_rpmb.c                   | 23 +++++++++++++++++------
 drivers/tee/broadcom/chimp_optee.c |  3 ++-
 drivers/tee/optee/Kconfig          |  2 +-
 drivers/tee/optee/core.c           |  1 -
 drivers/tee/optee/i2c.c            |  1 -
 drivers/tee/optee/rpmb.c           |  1 -
 drivers/tee/optee/supplicant.c     |  2 +-
 drivers/tee/sandbox.c              |  2 +-
 drivers/tee/tee-uclass.c           |  1 -
 test/py/tests/test_optee_rpmb.py   | 20 ++++++++++++++++++++
 11 files changed, 45 insertions(+), 15 deletions(-)
 create mode 100644 test/py/tests/test_optee_rpmb.py

-- 
2.34.1

