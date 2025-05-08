Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D89C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 10:32:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E74FA8283E;
	Thu,  8 May 2025 12:32:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KSojA6qX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F60F828A2; Thu,  8 May 2025 12:32:57 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0DD482162
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 12:32:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2B9B543EF5;
 Thu,  8 May 2025 10:32:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06BDC4CEE7;
 Thu,  8 May 2025 10:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746700373;
 bh=lodO20UZI9buRtOdXYVs+v8Zu8ji7yZMccOosqiezn0=;
 h=From:To:Cc:Subject:Date:From;
 b=KSojA6qX9K2LtVIQVtg3Z7lSouaRHlnDR/fhGwmhgvwXenznheQcOYs/45o9LsO0e
 UToSzAFvPaMFlap/Qk+2NflKw1xg8cjZMljOts1g65cZZTur8unfqddz262qtvxW9a
 /+QsVIMNsULNdrahWqFxlZtiQast+G62M8TA9ZFCt6td8N060YzsrlGuVdXxvPcew/
 lMYxuetVlX/SnQpD54JCj8cpYvMrDEWXF8m7yVLReYjDG8T5Oofs4sLWi4S8CbGt4r
 Jwh7bT7gMjFe/XRP8T1VPhJbd96TZK3s/Vqx2uaeYwaVUxj5Hh5SN0GWzxa97K3BY7
 kfA/LY0HSH2IQ==
From: Sumit Garg <sumit.garg@kernel.org>
To: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH] qcom_defconfig: Enable AUTOBOOT_KEYED support
Date: Thu,  8 May 2025 16:02:38 +0530
Message-ID: <20250508103238.230608-1-sumit.garg@kernel.org>
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

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

When debug serial port isn't connected, it is at least reported on RB1
that autoboot gets interrupted. It is probably due to random characters
on the UART RX line when disconnected. Lets try to fix this inconsistent
behaviour via enabling AUTOBOOT_KEYED such that the autoboot gets
interrupted only when the <SPACE> key gets pressed.

Reported-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 configs/qcom_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 36e2f45d22a..e3dac23f1d0 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -15,6 +15,9 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTSTD_FULL=y
 # CONFIG_BOOTMETH_VBE is not set
 CONFIG_BOOTDELAY=1
+CONFIG_AUTOBOOT_KEYED=y
+CONFIG_AUTOBOOT_PROMPT="Hit <SPACE> key to stop autoboot in %2ds\n"
+CONFIG_AUTOBOOT_STOP_STR=" "
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_PREBOOT=y
 CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR=y
-- 
2.43.0

