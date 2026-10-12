Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C31CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 05:37:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69D7080D29;
	Mon, 12 Oct 2026 05:37:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6-FrDhMYexe4; Mon, 12 Oct 2026 05:37:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 91ACA80D18
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791783428;
	b=TcITyCcmdqYJRPVktzgvpLVj2I1ABQtX506KCC7Nv3y7aK+3mHdclp5doFR7S1RzWq8I
	 3z3ixH3EjJB/U0oNkxXoAyRz+Jzqo0ASU/SK+oDP9KMsXAJH6xcreZUDBj7HKRywMUcQu
	 yHatt6IqmrKk7UKTSQJtllhnsUrGPRgzewtJwWxW+POIlxO+FGOaXzXRjM8bW6DgsFX4v
	 Bp8JQFoL6Ax5O+x+8i5vm6NlTfcxLBrN3wplGAzPldO8EEivRprSSZpXTV4YP+2jAnvUb
	 4o2yBh5RrgHFiTzOGhywC6Xz3LKB8fu5u4EqUaeasnqPvAwLLncjl9qc2JMUthgIrzw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791783428;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XmcmvSkOCRhtbMJVgER2omyf0lh3XxCcboCSbGebE/4=;
	b=KjdPHp7/8fJPFuOFrLo/QAHszfiK70/9uCm89HIABMdjxsO3Xb7NYjaI6sXM5dAe0xOq
	 QcosnbRoD5bOAZ63X8CYPEcOencVQ0DSEnISa4Lpm5fl93DwMVvpLLH7f5xNl09EEcW0+
	 ByL/Rp8LOJ4HKmud19P3uYwRR3mYV5V1rc+h8aQdJXBeWuFRud7NQ5tblUns0e1y0dnpK
	 G2ay+5T2QVnA/N2k5KN1pYr0P2rUQUDxzgGs0yqOEMImjhcnbjaZFU64GAhUmwKIj8Hwv
	 SRrEVFqQJ6pE/j5bDAKMJDd5CMEg9TF2P2/DHcUnM0NOKJDcepSBXK19OtGvnoR8Sjw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791783428;
	bh=XmcmvSkOCRhtbMJVgER2omyf0lh3XxCcboCSbGebE/4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AC/YWKwWiNCKcWoxTzTK+C8sCM1RYpKrtCpB8yxjwJkGL6Xda5zDwrNppkoQEizb9
	 nJ1hYsUoLjbFnkgVIsh1TcHxcyypehDd0SmLvLmxBV2KkQOuVO/RNT3Kz7l3D0VIYk
	 +HqV88oHwkeLyTJDf9Ix1NSb2GN4Cz2rYAsFFDJZFQ8/rPcI3D7IqxCqp+6JXpOjVl
	 n2mXNUN8zO+Gnmcd3nXNJG7CVMMfTaAYZujgTwqPJtZEchtK/5r2KASwvi4oykKT/e
	 EuIT3ZYMmA3Mi9jLLLi2CmqVHQo1PBrUKAkANHkLqBD2zKvn/bvSI5pxbPWFHdPjxk
	 ayg1OP1I74izA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91ACA80D18;
	Mon, 12 Oct 2026 05:37:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A738E9CF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 04:28:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 98E8B400D8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 04:28:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L2TXn0Cv_Z_P for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 04:28:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D54E24002B
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791779328;
 b=ewgz7wt92XFIGciCRbRzgdcRwIAigx1d94pt3gaEGp3nMeaXYN2OiVXBQhpK+RcSqy6X
 AucJjbh6hz9dEBMY+EWR62UosZZvd2NlIzdxF/KRmpz4hE8cU8i5VyxFUXJReqMWN8J+g
 BqVRTT2f8Dr9EKxvc5ERcvcr82a/maothHfBaiKnlHFyIiEz66cW3QEaHjfAEyWzLpQ89
 /GE/QQy+pZqg7J7N/Qf/UYI72pEl9EDkXVYI6NToxSmUXVtwWph6dn4kjrmICdq3+Lzgx
 EF3g73bV253c5dAMd3aStae3+n70wEeH/E2XO6iQmWIU0KDaCizdn8/hgM3gIKQOyWA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791779328;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=XmcmvSkOCRhtbMJVgER2omyf0lh3XxCcboCSbGebE/4=;
 b=q/wGjiBmX6eHG0hnxHH+OtHBX0suYyE+3bqaKc/cWeojUx5My3JDEJj/Mm8YWI34CrKB
 ylq6yfIA10AUSxNf7Dn2Tra8YuRWHI/vuGWr8n3AvyUgj2vRdM+azULgxVaJk13MoAyRX
 AWeBTZMphNsIs4RcSPCI08/x9B4UiojzinKdRo3YaTAcJqnqKqUN14oJDGfCrhD4OvTUo
 A1yBRdsyI5xCYmYmdxIcfsWrE9g6ZH9v3vQfBjQcaRw6vEHPnClvC3noBXkFd674AVr1C
 GYtwPj4cy4XF3TvuZIA01bi02lUkNq6RIyjM06+t4IFkU0+aNEjA3paCAYImFDf6oGw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=zohomail.com;
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=MsvoVwe8; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.95;
 helo=sender5-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=MsvoVwe8
Received: from sender5-pp-o95.zoho.com (sender5-pp-o95.zoho.com
 [165.173.182.95])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D54E24002B
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 04:28:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791779242; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dgDSvRAh+hBGslfNneGJQaGewFZJLiaIoXzZ7BCpHWDx5U1rWEr39tfBqVkx75o43ApXKE38dNioYj4OCPhnBcEGEKUjy/XKsLSIJvNhQVgEBrWuau1sGx/tioUOxzEZRfNY95+XWqm9bu2dni20lm9vNRcYzaA/sLZbYiIRNDQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791779242;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=XmcmvSkOCRhtbMJVgER2omyf0lh3XxCcboCSbGebE/4=; 
 b=hJJhtXQGf/zywHOaUN43mlRwE4NKOfv2QV0u6gduJSg+gF0rFAe2Ru7G1d1GRkpNY06h8jJVALvrwvTvWu8D2vRPO22e/tgkVGkvMaiMbdWxTWN2mEnMI3pyhpiPFH2JqUg538ieyyysY/cJKxGpb/u3SwPQWqZRzKwH42SvECY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791779242; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=XmcmvSkOCRhtbMJVgER2omyf0lh3XxCcboCSbGebE/4=;
 b=MsvoVwe8GFsACWPdYe16aUnb5WgtSue8lzWjwgPdcQ6WiHRoDDHYKaStSlKVeKZe
 A0SGBcjIzr/JaEYk8O3aNXp8Y/ABrUS6hvsdQA91ykTbW4X9Pdpr9yLmcNjQAKR3yQi
 jWgQnOCN1SBk242+YsBFDLAOOBC3e9w+peC1Jo8A=
Received: by smtp.zohomail.com with SMTPS id 1791779240356833.9144860788139;
 Sun, 11 Oct 2026 21:27:20 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Mon, 12 Oct 2026 11:47:34 +0800
Subject: [PATCH v5 2/3] riscv: sophgo: Enable RTC-backed system reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-cv18xx-rtc-sysreset-v5-2-413de1605cb4@zohomail.com>
References: <20261012-cv18xx-rtc-sysreset-v5-0-413de1605cb4@zohomail.com>
In-Reply-To: <20261012-cv18xx-rtc-sysreset-v5-0-413de1605cb4@zohomail.com>
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>, 
 Johan Jonker <jbx6244@gmail.com>, Alexander Koch <akoch@initse.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Leo Yu-Chi Liang <leo.liang@sifive.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Heiko Stuebner <heiko@sntech.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marex@nabladev.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>
X-Mailer: b4 0.15.2
Feedback-ID: zu0801122755241f188d073a39b7b7a2b70000be4fb1871c5d5fb30eafd314767ed90b261c320bf6efc4fbda:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Mon, 12 Oct 2026 05:36:56 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Enable the CV1800B RTC driver for Milk-V Duo, Milk-V Duo 256M,
and LicheeRV Nano. Remove the board-level sysreset binding on
Milk-V Duo now that the RTC driver binds the sysreset child from
the devicetree node. Reset register access is unchanged here.

Reviewed-by: Hiago De Franco <hfranco@baylibre.com>
Reviewed-by: Yao Zi <me@ziyao.cc>
Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
 board/sophgo/milkv_duo/board.c         | 5 -----
 configs/milkv_duo_256m_defconfig       | 2 ++
 configs/milkv_duo_defconfig            | 2 ++
 configs/sipeed_licheerv_nano_defconfig | 2 ++
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/board/sophgo/milkv_duo/board.c b/board/sophgo/milkv_duo/board.c
index 34339c42925..3423f54012e 100644
--- a/board/sophgo/milkv_duo/board.c
+++ b/board/sophgo/milkv_duo/board.c
@@ -3,15 +3,10 @@
  * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
  */
 
-#include <dm/lists.h>
-
 #include "../common/ethernet.h"
 
 int board_init(void)
 {
-	if (IS_ENABLED(CONFIG_SYSRESET_CV1800B))
-		device_bind_driver(gd->dm_root, "cv1800b_sysreset", "sysreset", NULL);
-
 	if (IS_ENABLED(CONFIG_NET_LEGACY))
 		cv1800b_ephy_init();
 
diff --git a/configs/milkv_duo_256m_defconfig b/configs/milkv_duo_256m_defconfig
index fda0baa3277..f15b41e1451 100644
--- a/configs/milkv_duo_256m_defconfig
+++ b/configs/milkv_duo_256m_defconfig
@@ -38,6 +38,8 @@ CONFIG_MMC_SDHCI_CV1800B=y
 CONFIG_DM_MDIO=y
 CONFIG_DM_MDIO_MUX=y
 CONFIG_ETH_DESIGNWARE=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_CV1800B=y
 CONFIG_MDIO_MUX_MMIOREG=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
diff --git a/configs/milkv_duo_defconfig b/configs/milkv_duo_defconfig
index 9d6b80362d5..77c8d89701d 100644
--- a/configs/milkv_duo_defconfig
+++ b/configs/milkv_duo_defconfig
@@ -35,6 +35,8 @@ CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_CV1800B=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_ETH_DESIGNWARE=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_CV1800B=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SPI=y
diff --git a/configs/sipeed_licheerv_nano_defconfig b/configs/sipeed_licheerv_nano_defconfig
index 21b8fece201..75229787d2f 100644
--- a/configs/sipeed_licheerv_nano_defconfig
+++ b/configs/sipeed_licheerv_nano_defconfig
@@ -40,6 +40,8 @@ CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_CV1800B=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_ETH_DESIGNWARE=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_CV1800B=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SPI=y

-- 
2.56.0

