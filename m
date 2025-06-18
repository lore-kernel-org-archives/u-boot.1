Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D587C7115B
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 06:59:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02BD582B18;
	Wed, 18 Jun 2025 08:58:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="co28iaPc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A58882B18; Wed, 18 Jun 2025 08:58:50 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7493A82977
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 08:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ade76b8356cso1313200066b.2
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 23:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750229928; x=1750834728; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jeh0DbXF/4CDe+sbD8rPJN3EUBTcrZlc4Cr5BlGaqWE=;
 b=co28iaPcxQFQRziPSDODh6xOFp9n53kVgx8ofTrOBCJw/jfj3DssU/Hk3c19ngxnvU
 yDSKt38zCq2yXL06WMaVKrN7iAOTqy5RlO728dG/KriC3fh4MVqvrg58Wz5++ZjVGG3B
 OrGQ0qEluFr2tsgPKsX/aLvne8GG5HxgUouon2X1xzS8zHyN+zy22lpy2+ZaeI/R2KjM
 Il/2Dqdlodv7qXExg9bimR5i5X4pnuH7EMpbfdctJWmzw4vWzlKY/t8NUOgPVld0g5mB
 bpKSGpMowJsHqfolyMoYEUI3/6XEo6xqtNV1AXjs4kkn8/LEKsOaj98g7vL1JuRpsHaW
 4APA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750229928; x=1750834728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jeh0DbXF/4CDe+sbD8rPJN3EUBTcrZlc4Cr5BlGaqWE=;
 b=YmcJZnsYqxknbNsXFgwSheexl32j/4rklKXu0GkLXNjuh/PHyx8N2gEHJEJ57Mr3j3
 M4e+kdWZ3qoE0Hqeq3mQ1XafKSXTPIN1gCYKA3p1G4JXHgmfZWwA96Ln174WkrxhGN9Q
 qX7Qe1xOBlYTX6/GFikSXMOen71Vjbo1tHA9lMTmNVUhx/rTPHebygTG8O6TZTGlJWVC
 +YuafIs3qepXEPieYwTqI7vWayG89DTNo+mgBcHkfWzkNFeAu1HPiteTl1vhqbl+41wy
 JISP5SRdHuFm5b6FyF6RvhiL8C6/wueG8JnKKilc6EK3jWkAupgYbZxBn+ytdSGBXead
 9XKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDx7CPPvO+LAWDUdF6crPJCppKi7aBctEX3ocU9DwbX4PEY1l1RZQ9ycnRMHOMSuzIKc8XFV8=@lists.denx.de
X-Gm-Message-State: AOJu0Yy54t/yThY0giQJsgh0Sai0khcNBSfuTYxQ0kGrQm2SymoCQb7z
 WrviM7542ftRUYffu8T7Ul5NTOTJJw6kk2AAFXXds9U6QKZZaXJHvD5QdTa32B0kz7U=
X-Gm-Gg: ASbGncteTfvUkDoxBF3TrrVWmnj64rUzNkEa0NjbN7aMOxHdlaljDkAD+De8ylt6Ipd
 iIIkmnrlxGt7D2xOBD1hj3i5JFbaDs1FIwTBpvBCmchJ1bJv3Kb0jj2C5VR4nho2MRDw9wN6mWN
 hVkGlOj1sY0Xf4Ks89mdnlRYF+d41tWEqtcEBS5tA1rNjZaeYQQZteyrPYYbhAXccVgPwrOEAnI
 CBtAv1xjDVqESIQ1gqGYdzwp1X0FRImo25EgNzCetPCDTxwFQpu7k3ef2hrtM2WfqPhAC1d9tMb
 nwRgWkhKA22EsuYBz3erOUNtEQodJ9bhoifTFW1fCZacoiXYqjvwvk2VHtgqKTKO7G273XWPV6P
 NlsyhTb47t3K9502kbakz2Q==
X-Google-Smtp-Source: AGHT+IE5KlGgg6o55pkovIa2g+xP9uJoyni0/JCSM1VLxyWThlP0z1rxWRH3XeDtHm6YuM3yRi58KQ==
X-Received: by 2002:a17:906:7310:b0:ad8:a41a:3cd2 with SMTP id
 a640c23a62f3a-adfad434544mr1555917966b.16.1750229927871; 
 Tue, 17 Jun 2025 23:58:47 -0700 (PDT)
Received: from hades.. (ppp089210105145.access.hol.gr. [89.210.105.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adec897bae7sm978322866b.162.2025.06.17.23.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 23:58:47 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: jerome.forissier@linaro.org, mikko.rapeli@linaro.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Boyan Karatotev <boyan.karatotev@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>,
 =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Liya Huang <1425075683@qq.com>, Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: [PATCH v2 3/3] qemu: arm: Enable virtualizable IO accessors
Date: Wed, 18 Jun 2025 09:58:14 +0300
Message-ID: <20250618065828.1312146-4-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618065828.1312146-1-ilias.apalodimas@linaro.org>
References: <20250618065828.1312146-1-ilias.apalodimas@linaro.org>
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

We recently added IO accessors that will work with KVM for any MMIO
access that casues an exception to the hypervisor. Enable them by
default for QEMU.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 configs/qemu_arm64_defconfig | 1 +
 configs/qemu_arm_defconfig   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 72bd255eafa3..39afb837e411 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -1,4 +1,5 @@
 CONFIG_ARM=y
+CONFIG_KVM_VIRT_INS=y
 CONFIG_ARCH_QEMU=y
 CONFIG_SYS_MALLOC_LEN=0x1000000
 CONFIG_BLOBLIST_SIZE_RELOC=0x2000
diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
index f13001390d4d..92ba48f6af97 100644
--- a/configs/qemu_arm_defconfig
+++ b/configs/qemu_arm_defconfig
@@ -1,4 +1,5 @@
 CONFIG_ARM=y
+CONFIG_KVM_VIRT_INS=y
 CONFIG_ARM_SMCCC=y
 CONFIG_ARCH_QEMU=y
 CONFIG_SYS_MALLOC_LEN=0x1000000
--
2.43.0

