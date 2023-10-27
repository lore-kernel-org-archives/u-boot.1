Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58470C25B48
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 17:46:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A09D86E64;
	Fri, 27 Oct 2023 19:46:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KQa5OYUA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EAC986E64; Fri, 27 Oct 2023 19:46:10 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FD5F86E09
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 19:46:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=troykiskyboundary@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1cc0d0a0355so16315115ad.3
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 10:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698428765; x=1699033565; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eUspjkzisIurxZqn0rckoKw60pb1Kb85MlC/N2XCKAg=;
 b=KQa5OYUAdhV3TieQcPXP532/J26tSg+kS4sfkeDi7HxLRzJ0oYz80OlV6phSQA7E7A
 +ZkWpKcgz/vElutyq+6t3j0ocJ36r3b5jl4Ac9LMTEJdP9tbzHr1oACdCNN7DPioGn9o
 CLjvuA0Bpi7uRRPxvGtYb+YEtQhBkhR8pZGDahTVZEwKFN/yvD8It8HtSIzT8Yq1lIYe
 xLCzbaNQQ4Y14nul8gXzvHEu72UgShBOjB5mt123XiA1SBQbm78QRMEBppFAKoIIf6Ue
 U2AhavQi6lhfFNaC/Z/G9zItx7UubtjdHtYHFE4GrRpW2PD9wLyaOD0h+ZalqqdJvSeF
 pASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698428765; x=1699033565;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eUspjkzisIurxZqn0rckoKw60pb1Kb85MlC/N2XCKAg=;
 b=PhguSgiZHIeXcAgJZDUFen12JtchrLYU67E37MduTYYBVcI7zcMWyQD3MpVyBa0JKe
 2Q0x0EWWVmMtNL51ddoZVnD7JoORwCIDGjiig1LFLQ5/c/XB3t+ah1IR/nOm5AGos7nY
 YC7x+0X09A1rEhtxfal1QZOecwIHEnKXR6XyYHEN2CWmSVYdHFnPzt0oQi/zy5nfFVTg
 GlDitwUDWIqnEPAkjoNEZz3/KIaNIc4TIovHVLYhDMz4TbxohWPNP6225oVryEg3ht5g
 KqTIJqe4UoeXjyVDO+hPc+uXiZ0aCbmn9tCvH4y2MwzdzCMRDn6jnRVkXR4TCJ9Vk6Q3
 H6bg==
X-Gm-Message-State: AOJu0YzwqfK8m9Vgwo0c0rI8J3DJQPxYEmGws6fgyNY4Lj0LUgyivuv1
 YCskKO++/APGChjGLjq8F4vRJL7EbMg=
X-Google-Smtp-Source: AGHT+IGEeMWDayZFFUECz6yAd8/RiNZVB2sYgsSmoTSzSiA5bxDfEls0w/0Pk4//r6GImnOo2fJlKA==
X-Received: by 2002:a17:902:c412:b0:1c9:bca1:d70c with SMTP id
 k18-20020a170902c41200b001c9bca1d70cmr4693888plk.30.1698428765519; 
 Fri, 27 Oct 2023 10:46:05 -0700 (PDT)
Received: from OS2.boundarydevices.com. (wsip-184-189-120-117.oc.oc.cox.net.
 [184.189.120.117]) by smtp.gmail.com with ESMTPSA id
 v8-20020a63b648000000b00565e96d9874sm1127461pgt.89.2023.10.27.10.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 10:46:05 -0700 (PDT)
From: Troy Kisky <troykiskyboundary@gmail.com>
To: sjg@chromium.org,
	trini@konsulko.com,
	u-boot@lists.denx.de
Cc: gary.bisson@lairdconnect.com, Troy Kisky <troykiskyboundary@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Hoyes <Peter.Hoyes@arm.com>
Subject: [PATCH v5 0/1] CONFIG_IS_ENABLED vs IS_ENABLED
Date: Fri, 27 Oct 2023 10:45:56 -0700
Message-Id: <20231027174557.2993782-1-troykiskyboundary@gmail.com>
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


This patch set gets ready to checks the usage of
CONFIG_IS_ENABLED/IS_ENABLED.

After the set has been applied, you can delete
test/usage_of_is_enabled_todo.txt
and run test/usage_of_is_enabled_commit.sh

The script test/usage_of_is_enabled_check.sh
checks for new questionable uses of
CONFIG_IS_ENABLED/IS_ENABLED and is added
to .azure-pipelines.yml, and
.gitlab-ci.yml

version 5 changes:
	rebased on denx/next and updated todo with

rm test/usage_of_is_enabled_todo.txt
test/usage_of_is_enabled_check.sh >test/usage_of_is_enabled_todo.txt

And delete the last 2 lines
sed -i '$d' test/usage_of_is_enabled_todo.txt
sed -i '$d' test/usage_of_is_enabled_todo.txt

version 4 changes:
	Down to just one patch, other issue fixed by other means
	Added the following new configs to todo
ACPI
DM_CLK
FEC_MXC
FWU_MULTI_BANK_UPDATE
IMX8M_VDD_SOC_850MV
MCFTMR
PANEL
SANDBOX64
SPLASH_SCREEN
SPLASH_SOURCE
SPL_LOAD_FIT
USB_ETH_RNDIS
VIDEO
VIDEO_BPP16
VIDEO_BPP32
VIDEO_BPP8
VIDEO_LOGO
X86_32BIT_INIT

version 3 changes:
	Dropped changes to puma-rk3399 and ringneck-px30
	in favor of Quentin Schulz's patch
https://patchwork.ozlabs.org/project/uboot/patch/20230301-tsd-env-nowhere-kconfig-v1-1-d5c08e096906@theobroma-systems.com/
https://patchwork.ozlabs.org/project/uboot/patch/20230301-tsd-env-nowhere-kconfig-v1-2-d5c08e096906@theobroma-systems.com/
Please apply them before this series.

	Drop gateworks: venice: Always define setup_fec and setup_eqos
	Drop arm: cpu: armv7: ls102xa: fdt: remove eth_device support
	Simon's patches took care of these

	Add to todo list, these new questionable uses that snuck into the code.
	PARTITION_TYPE_GUID
	PHY_ATHEROS
	RTC_SANDBOX

(no changes since v1)

Troy Kisky (1):
  CI: add test/usage_of_is_enabled_check.sh

 .azure-pipelines.yml                |  11 ++
 .gitlab-ci.yml                      |   5 +
 test/usage_of_is_enabled_check.sh   |  19 +++
 test/usage_of_is_enabled_commit.sh  |  12 ++
 test/usage_of_is_enabled_correct.sh |  50 ++++++
 test/usage_of_is_enabled_exempt.txt |   9 ++
 test/usage_of_is_enabled_list.sh    |  86 +++++++++++
 test/usage_of_is_enabled_splcfg.txt |  21 +++
 test/usage_of_is_enabled_todo.txt   | 232 ++++++++++++++++++++++++++++
 9 files changed, 445 insertions(+)
 create mode 100755 test/usage_of_is_enabled_check.sh
 create mode 100755 test/usage_of_is_enabled_commit.sh
 create mode 100755 test/usage_of_is_enabled_correct.sh
 create mode 100644 test/usage_of_is_enabled_exempt.txt
 create mode 100755 test/usage_of_is_enabled_list.sh
 create mode 100644 test/usage_of_is_enabled_splcfg.txt
 create mode 100644 test/usage_of_is_enabled_todo.txt

-- 
2.34.1

