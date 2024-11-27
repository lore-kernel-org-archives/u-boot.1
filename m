Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DADD609A8
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 07:07:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECD768977E;
	Wed, 27 Nov 2024 08:06:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="P106EV+0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E43E3899E7; Wed, 27 Nov 2024 08:06:50 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09DF78978D
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 08:06:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 15CD441025; 
 Wed, 27 Nov 2024 07:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732691205;
 bh=Aht8cq2l6kB+yTBA58lPgiO8tUOWR7W4VFSJ8cEibJs=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=P106EV+0G7xFo287TGOsm718zTpjrO03U+Bkx0st4wAMOCTWPChH3VIWO5mrgjIFf
 g8/ee+ZzXvQ0ZcUWdlFlMmWOscPG3CGNDLOwiN5H0/y8oY3dMtCNe1e0B2boisyPTf
 /x2ZhztuCYBSLZLDyQ/F407vO8CG4AeAt1qJfLNWe3JBP7zA3F1qBReww5UdGuCFx7
 4nAQ9Gv9X1jVR4DC5WSAp1d9wLID+ZkqQyMZNmSKsjxKtjBFnAtb+f/ULUdMvj3ihZ
 1foj1ne8t8If2oUENBD1Yua94hIlCzlHHbi9F5SKVoQthdUGQLr1FxYSE+LTMi79Xv
 uKta51TOPs80g==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Weijie Gao <weijie.gao@mediatek.com>, Daniel Golle <daniel@makrotopia.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 3/6] CI: xilinx_versal_virt: disable USB_DWC3
Date: Wed, 27 Nov 2024 08:06:28 +0100
Message-ID: <20241127070631.16412-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127070631.16412-1-heinrich.schuchardt@canonical.com>
References: <20241127070631.16412-1-heinrich.schuchardt@canonical.com>
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

The CI uses the following command to launch xilinx_versal_virt_defconfig:

    qemu-system-aarch64 -M xlnx-versal-virt \
    -display none -m 4G -serial mon:stdio \
    -device loader,file=u-boot,cpu-num=0

'usb start' or invoking eth_bootdev_hunt leads to a crash when function
dwc3_core_init() tries to access a register at offset 0xc704 (DWC3_DCTL)
relative to the register start address 0xfe20c100.

Disable CONFIG_USB_DWC3 in the CI until the driver problem is fixed.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	Only disable CONFIG_USB_DWC3 in CI as actual hardware uses it.
---
 .azure-pipelines.yml | 1 +
 .gitlab-ci.yml       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 4ecf76eaa0b..bac577ec008 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -511,6 +511,7 @@ stages:
           TEST_PY_BD: "xilinx_versal_virt"
           TEST_PY_ID: "--id qemu"
           TEST_PY_TEST_SPEC: "not sleep"
+          OVERRIDE: "-a ~CONFIG_USB_DWC3"
         xtfpga:
           TEST_PY_BD: "xtfpga"
           TEST_PY_ID: "--id qemu"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 2164ad79a72..714284a56df 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -508,6 +508,7 @@ xilinx_versal_virt test.py:
     TEST_PY_BD: "xilinx_versal_virt"
     TEST_PY_TEST_SPEC: "not sleep"
     TEST_PY_ID: "--id qemu"
+    OVERRIDE: "-a ~CONFIG_USB_DWC3"
   <<: *buildman_and_testpy_dfn
 
 xtfpga test.py:
-- 
2.45.2

