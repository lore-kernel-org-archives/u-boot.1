Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89AEC43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 05:06:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1ECB8496E;
	Mon,  6 Jul 2026 07:06:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com header.b="MWBch85Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88269846B4; Mon,  6 Jul 2026 03:45:44 +0200 (CEST)
Received: from sender4-pp-o98.zoho.com (sender4-pp-o98.zoho.com
 [136.143.188.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3566E84105
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 03:45:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhuxu_ran@zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1783302302; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LzpTxBpwq/+ZVsrDwXlGNZxxGrHx5VCDvac62lylI6DnHAO1pkLtCz2GJs/B008KUSZvs3EU8IQsrmeOL8ZZRJ6k26W3JqM9hcgCMo577EGfwBjpch0piQZdY8/aRVyBnhq/3qILNDIgX5/sEso80PYKaVHf4KpMTWDZUqhNKmk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783302302;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=4O6QUAainEBvwtTmp13dHpzsnY0WzeK0lzykjMP5v1E=; 
 b=L7JCxHh8L+cApqQjqHSBM52jzce5vRb3MgaHNTLazSoYtB62Ssk7z831ya8liBzpE7houlCwY8TtclQRtdNs8L0K4fajVNXEyifSUkiZrLTBsJisyW2lZNFPWBpSe7wfjOcVamM0vofDvaoul8Qi5yAUIQo5fkN7gshlRlBUHy0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783302302; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=4O6QUAainEBvwtTmp13dHpzsnY0WzeK0lzykjMP5v1E=;
 b=MWBch85YhW5osTSrwwPpJ8ZSMFmxbj550F1ropAvWLTu46GSU693pZFZTdnOoRhn
 OvF0FwnNCig9XRM1Mx0H7yvwmXnSR1YmZQePuAjc6X1Z62rZPRLDz13IlY0pOF/bxGc
 GKadGbehG9rc5vYzCU1VfAa1O/5GEMJ0X+i9Ihk4=
Received: by mx.zohomail.com with SMTPS id 1783302290405219.57088047795435;
 Sun, 5 Jul 2026 18:44:50 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Mon, 06 Jul 2026 09:43:42 +0800
Subject: [PATCH 2/3] riscv: milkv_duo: Use upstream devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-milkv-duo-upstream-dts-v1-2-8d010ddda7ca@zohomail.com>
References: <20260706-milkv-duo-upstream-dts-v1-0-8d010ddda7ca@zohomail.com>
In-Reply-To: <20260706-milkv-duo-upstream-dts-v1-0-8d010ddda7ca@zohomail.com>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Martin Herren <sputnik@on-the-web.ch>, Michal Simek <michal.simek@amd.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, Yao Zi <me@ziyao.cc>, 
 Andreas Schwab <schwab@suse.de>, Zhuxu Ran <zhuxu_ran@zohomail.com>
X-Mailer: b4 0.15.2
Feedback-ID: zu080112272c0abec4d2f5bf244191af380000f32856d5c965d80f15b97fe909e9d0a8f2d507bc27ee63ba67:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Mon, 06 Jul 2026 07:06:30 +0200
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

Switch Milk-V Duo to the upstream CV1800B devicetree by enabling
CONFIG_OF_UPSTREAM and selecting sophgo/cv1800b-milkv-duo.

The upstream devicetree keeps the Ethernet MAC disabled. Add a
small U-Boot override to keep the existing U-Boot networking
support enabled.

Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
 arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi | 12 ++++++++++++
 configs/milkv_duo_defconfig                  |  3 ++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi b/arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi
new file mode 100644
index 00000000000..158b02a543a
--- /dev/null
+++ b/arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * U-Boot overrides for Milk-V Duo.
+ *
+ * The upstream Linux device tree describes the CV1800B Ethernet MAC, but
+ * keeps it disabled. Enable it here to preserve the existing U-Boot
+ * networking support when using the upstream device tree.
+ */
+
+&gmac0 {
+	status = "okay";
+};
diff --git a/configs/milkv_duo_defconfig b/configs/milkv_duo_defconfig
index f1f3930564b..9d6b80362d5 100644
--- a/configs/milkv_duo_defconfig
+++ b/configs/milkv_duo_defconfig
@@ -4,7 +4,8 @@ CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82300000
-CONFIG_DEFAULT_DEVICE_TREE="cv1800b-milkv-duo"
+CONFIG_DEFAULT_DEVICE_TREE="sophgo/cv1800b-milkv-duo"
+CONFIG_OF_UPSTREAM=y
 CONFIG_SYS_LOAD_ADDR=0x80080000
 CONFIG_IDENT_STRING="milkv_duo"
 CONFIG_TARGET_MILKV_DUO=y

-- 
2.55.0

