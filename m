Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5A5C7115B
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 06:58:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 092CB82B0F;
	Wed, 18 Jun 2025 08:58:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fFUpNiJm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF32B82B18; Wed, 18 Jun 2025 08:58:35 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CEDB82977
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 08:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ad891bb0957so1185230166b.3
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 23:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750229913; x=1750834713; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1m4ddvYPVhm6r0uXQ5bFcfykk9LsnQ6Y6xMom5z9k1Q=;
 b=fFUpNiJmP//vbX81J15opGWhmPMXuNyLIpoqp/kNXsx1pXd3wDUqseUA0BYV9NCw4n
 QuBXm/xHIENdUfgLCGw4Y/wDYdtEIcoK/23Cz6cO00LG6KlPt5PTzBarm2+t1kvS40q9
 6ShLkT/1BQoav9v6X1JwB+WVCNIO10ObK8f/2wCRz5Ht4fP2nFZpjlerCL8Wzyd3EIS4
 dsWGDDNjU15dmisypqUsxCiMJGZ4wn5a9ZpDo+IM14/MqAA2sshF+QHIqA448En2k9VW
 Pwq2wLaoS1NgVEiidRVer+PXy8HDKqS4R28BeHZxGDmWnoZ8dtTERmJcQqgVbQgqb3lS
 6SbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750229913; x=1750834713;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1m4ddvYPVhm6r0uXQ5bFcfykk9LsnQ6Y6xMom5z9k1Q=;
 b=hdWsj5XuZC84iQ0y2nblv9sU4dmgv7NZ7QtqW3Au695grtFIy3g32EWOj4V6Hqz5aM
 4cuchRyhuenTHshTal/r7LL/KRDiBV2VdvJjTgfrhd3eCny45SQENDynzYTirzD+o3CT
 cZ2VV6yuY7hP0NpZ+fbxJ3x3o5VMx1LR1X75rwGixBIMnT3aORqc9J2pqQuIR4IQ/1pF
 0ZcVg+OYo4jrtlFmEy3/4efAgXfZGyIblnaJW3IF0fllzPCwQ+Jnd8QHf/R7z7JpXfSp
 P14yIs3HiO7NALu84q70vEnzKwFzDaTwP4mOOuxLrpuyS6TdGfW5ilImrtGQYrSW4xNx
 YbIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzxmPEWL1+D0rw7AFvYKu+6IvUwfZVbWQa2dGDnMoNe1gmfgWVX0f3W4doAyg8S5j1V4zy+fY=@lists.denx.de
X-Gm-Message-State: AOJu0YyNQSQo/FOfASuVabLYOk7JDrpTlw5Bns3/2+R1aoZ1UWrLisZS
 CFDMsBJDUdAaOPuwq/qZWQH5oY4nGHgvHO6vfCnxETLWsUQC/Lw9S1QqHW87WmGJlNQ=
X-Gm-Gg: ASbGncv40xugylZbWH1DZVJhBKwqZfNHEBoMgCE17JsXsBMZxrmrsy0yEG25/SeYkLU
 JCZrT4Ji1hjnCT6mIFx7n+Mh+19BPCBK2ZBANHMnZ3SBCt1tG4bkO4RNZJi3SUpduWrQKmHgFcT
 Edq5v16k8lrANZ79oXTr8Rz960GLFtizS6W4KNpEVjWLvqpy16/r7Klss/mDEsXyoy82ksXDYT4
 OaFQfxRLZFgObBZHDKHZgwm5b3xTpa0ShrddHfwDaZLCaWy9hdJu5WOS/oYzGgcpIry9NFObm+1
 EKFyzDOKMtdZRTWV4Bzw+Vjj9dQ9vUopQIr5I7kuO9dJCvNKeYqUMQy5dqOzLvNc+f2Q87oOkeC
 13dr+jdcRFN2yn0/toKOh+r2qIDT/fGR3
X-Google-Smtp-Source: AGHT+IFLxq+OhJ2YIWXzDBu/1dRd0mLxhIIvUiJU9PmSCMc0bWDllV3pAdpvutgkalQrGpYcuJN/FA==
X-Received: by 2002:a17:907:1c95:b0:add:deb0:8b64 with SMTP id
 a640c23a62f3a-adfad34aef0mr1583621566b.24.1750229912975; 
 Tue, 17 Jun 2025 23:58:32 -0700 (PDT)
Received: from hades.. (ppp089210105145.access.hol.gr. [89.210.105.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adec897bae7sm978322866b.162.2025.06.17.23.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 23:58:32 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: jerome.forissier@linaro.org, mikko.rapeli@linaro.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Liya Huang <1425075683@qq.com>, Boyan Karatotev <boyan.karatotev@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: [PATCH v2 0/3] Fix io accessors for KVM
Date: Wed, 18 Jun 2025 09:58:11 +0300
Message-ID: <20250618065828.1312146-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
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

Instructions that lead ito an exception in the hypervisor can't modify two
CPU registers at once for the ARM ISA.

These instructions cannot be emulated by KVM as they do not produce
syndrome information data that KVM can use to infer the destination
register, the faulting address, whether it was a load or store, or
if it's a 32 or 64 bit general-purpose register.
As a result an external abort is injected from QEMU, via ext_dabt_pending.

Patch #1 prepares some function for the modified macros
Patch #2 modifies the macros
Patch #3 enables the functionality for armv7/8 QEMU

Changes since v1:
- Split the function modification in its own patch
- Don't limit the changes to v8 only

Ilias Apalodimas (3):
  nxp: Prepare macros for KVM changes
  arm: io.h: Fix io accessors for KVM
  qemu: arm: Enable virtualizable IO accesors

 arch/arm/Kconfig             |  12 +++
 arch/arm/include/asm/io.h    | 152 ++++++++++++++++++++++++++---------
 configs/qemu_arm64_defconfig |   1 +
 configs/qemu_arm_defconfig   |   1 +
 drivers/spi/fsl_dspi.c       |   6 +-
 include/fsl_ifc.h            |  24 +++---
 6 files changed, 142 insertions(+), 54 deletions(-)

--
2.43.0

