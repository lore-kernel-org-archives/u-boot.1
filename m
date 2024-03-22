Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710A3C54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:45:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FE858821A;
	Fri, 22 Mar 2024 12:43:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711107825;
	bh=J7LtdAyNIQOitk4rWpTatB2SbzFCx+4Ew3iCr1OAOT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wymLJCYGsfe2hpULK2tF6/IX3TMfN+SM8lbYderoUjxc9KzzXLc1mcNEFrAwS2Fze
	 +evW2dMhEJyf/zq8vr3hzx5GVCL6k1v/SRrJktSQFYmKHrR6pjO68AryLk3eIaJdnZ
	 gijC57jCViIity1nVMVnqILqgOa8kDEwgIc9Grysf9ai6Q+Galj9MQIlp/9cSyRdAk
	 pWGqsvOWUAsaU84TGWJ+mzV19D5HDAd3Of64KP0E0uzqFswlb03yKkw3zMJx1C+FEX
	 vwkyjxg79+NjDkFzXT05tLxl1d6C7EWgwPDejplcukRq/rlchvSNMWKX1YWDcchH8i
	 nq3Bwhs3LyTsw==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 918A487B82;
 Fri, 22 Mar 2024 12:43:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711107819;
 bh=J7LtdAyNIQOitk4rWpTatB2SbzFCx+4Ew3iCr1OAOT8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TSw68w0esp2I2ZWQ4oQb5msevZcwysKYg3vrJXLzym1tj7sQdFxkZGWXdg8tAMuJs
 Uo/CvcaXQYpdkcpnbJRJo/yo10kuFBmifwegZwU1ZjJqp08iDB9cf3EkODR4uMg71m
 9DBkkSFjlr5/9sxLe5NlDHETCpCGYZvStQA9PMaO+uibr/ibweE4pqBHSiI8jYP3eQ
 xLx5oJNRmVXs1u8kqaOVh2W6QJnnwPhp93qpLxkPh6r8R5cV9bsoafUv674jNoR2RT
 zDkGA/rEkVmR2mLgglIKt5dVFPZFURUeeT+3AaooOPqh0X1sIww2VlrFZFM+Ao2qol
 xY79zrKGJ1OvA==
From: Lukasz Majewski <lukma@denx.de>
To: Stefano Babic <sbabic@denx.de>,
	u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/12] arm: config: xea: Enable support for multiple DTBs for
 XEA board
Date: Fri, 22 Mar 2024 12:43:12 +0100
Message-Id: <20240322114315.2720727-10-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240322114315.2720727-1-lukma@denx.de>
References: <20240322114315.2720727-1-lukma@denx.de>
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

After this change u-boot proper is able to support two HW revisions of the
XEA board.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---

 configs/imx28_xea_defconfig    | 2 ++
 configs/imx28_xea_sb_defconfig | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/configs/imx28_xea_defconfig b/configs/imx28_xea_defconfig
index 42cbc3d34c..bc8c167b1f 100644
--- a/configs/imx28_xea_defconfig
+++ b/configs/imx28_xea_defconfig
@@ -81,6 +81,8 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_DOS_PARTITION=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIST="imx28-xea-1 imx28-xea-2"
+CONFIG_MULTI_DTB_FIT=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent interrupts"
 CONFIG_SPL_OF_PLATDATA=y
 # CONFIG_SPL_OF_PLATDATA_PARENT is not set
diff --git a/configs/imx28_xea_sb_defconfig b/configs/imx28_xea_sb_defconfig
index 30b3568e7f..691edc2834 100644
--- a/configs/imx28_xea_sb_defconfig
+++ b/configs/imx28_xea_sb_defconfig
@@ -55,6 +55,8 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIST="imx28-xea-1 imx28-xea-2"
+CONFIG_MULTI_DTB_FIT=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent interrupts"
 CONFIG_SPL_OF_PLATDATA=y
 # CONFIG_SPL_OF_PLATDATA_PARENT is not set
-- 
2.39.2

