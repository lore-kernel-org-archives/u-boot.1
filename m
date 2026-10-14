Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB4ACC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 16:16:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 22D5380E57;
	Wed, 14 Oct 2026 16:16:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ws-WfE8mYesj; Wed, 14 Oct 2026 16:16:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C48A980E59
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791994598;
	b=gdq5AlWwcvLEbflgTJaZI/Ky9sjdS6JT/zcqf0zrg76wmKhNeN3dBa6lMMXL7H7p/bYu
	 7LRzhEHe7E02r8izcpq0+GmBQx2+/Z1VTxoeGRmpsWolMa/jXdH0JX3azP3boCWtLtDML
	 XzWa+VH3OMIz64qmum7LNFyJqUesnkArLAkPocHVVsTJN5FQt9LcaiusZFOymJzlLzcgi
	 WqOppdqD5Roz4xC9JBx8nmeNjdi4CG/fzAc33wduUoxbluZJpjtMghOXhpmLxric6iKPr
	 OKVWmj86f712cXt5P83XJdiI70uT0FMGFUpFbahmY+Ftp11a/eFjExg3Fgyq8zOi/2g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791994598;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=U0EIV+pybWAZdo35lDSdAge4ZYhlRwK2Y4ccMIqDGbo=;
	b=p2jxQCtEslLw6BYi+Bf2U6m/YvgpqOGb72aeR6c1M/6qeINrV1Euz3YNID0QxEnVGEcB
	 MNyT8eeB2HsDwLGFnIsq0aATqLtlMxAIn9ti35oU7M60DngsZ7zkqMeJPj3uKURcBC5l7
	 8v7AkFSvQB8SLmvJ9agOGpJFtrcZFmG1N/+6xI4VQLnaYJNH1aB+TD2Z4szJ1Ci6kPfK3
	 4QbIOtI4jZZ/I/UzrUgTKQ79ulqNRrRQW/LMxWaN0JXZ6j1onhVu7MsoHOQd6QkhsznnO
	 +DhShiOJ5ikgwQa6nmDcZvk8T6X9mcO8gu2oGkLNBLHZTxiz6ihUM1QLR02jTM9TTJQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791994598;
	bh=U0EIV+pybWAZdo35lDSdAge4ZYhlRwK2Y4ccMIqDGbo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h5A6/OdNTeVK+CU/hn7O6/QoZ2JECJsYeiDgcOK6l81XwMv9arVEv1Jbc7xaiD/ns
	 vIAKtHRB1y8Pr84vEGyGLYuqCjYjbhC25Ujvuq0NHqUujT7Pjh8GisKli0uYidc2FH
	 HHo9eNGHHi1aucnDWbhDfScutKntFnir/ytexyDE/sDYn9HtWNTLnn++WUGMEc2AuZ
	 3hBJ7DB5cpR+7MRwM9ERsAn/Uof6UGlwk5H1ymUtm6rBBNKl+148QLkLUcOTBMI/A3
	 XCmpMNnmUN23iSg3wOMrZzAt/bRYlynCVw23TDKHfVWwHG622j1AOBaJU0LNEvY8P2
	 GOy+1gM8Ag76Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C48A980E59;
	Wed, 14 Oct 2026 16:16:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CAAF8769
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:16:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B0AEA401B1
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:16:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WFbyQBO8kRmJ for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 16:16:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EDF3C40189
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791994592;
 b=EilqLyEAsP3aL0jRp39OlMkjtGjUZHn/lpwqP8KFvKzoHyt4kZb+zqYMteSNnM3k9Ybe
 UrE1IDutc6RL83tAbriI8BCoPbUw7B2a/hcdC1XepEIbaVE4IaqldkMtVoGND75Xs4EcH
 niCus0sx2fKPSIX+4Anss/SLQwFxiW16rFcn5cJ0XDorK/2rA70WCSHGlkoYaG1v0E5JO
 /7RLvZ8UGRHDvwjP/XiCPpC1ElizhhT0uIUx/W5fjPE8V9jv6q1f1Yb96lJ7gyjs0mSuc
 xM1JOp/51S55DbUw6FgTthBxNNSsmcrp3jbVobPkGIPiNMHtSddjXq6ilbPQQDUozqg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791994592;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=U0EIV+pybWAZdo35lDSdAge4ZYhlRwK2Y4ccMIqDGbo=;
 b=Nn7YJtqtg8GtqhlD29dRgnT6Pp1N6gsY81qYMFO8QyubXmCMRMZQ5F9iKIrlzn64bOfd
 ck98RojehLNLCx1oVg9EEIqdiHp8338D+4WenHw1T8i/devyzr74K+xcMV+b4LMyVf8Oy
 2b3Pg4Fnei1F5+5TTkzMeMvv4Kw7Gd36yxfEDns0KJfHvkvWdtv4YJzO3kkox96wCX9k+
 2vLCPe04okpfdyNlplH3rNFe0luRrvgz7J1LJ9hhGpF36tnwv1ITuetKIEllzNi6r8vkd
 q/tvONC3Pk77TRcFKfhaLW5kgPNNAm5a3fzKY+bZ49pKK4xJZTn+711Fh90qPji1ivQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=D5i7jBIs; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=D5i7jBIs
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EDF3C40189
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:16:31 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a161d9b8c7so30741145e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 09:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791994589; x=1792599389;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U0EIV+pybWAZdo35lDSdAge4ZYhlRwK2Y4ccMIqDGbo=;
 b=D5i7jBIsJtp3N7vZ8rO8dsArYIxkSoJ7w3EraIQs9k4ok73lEbT1RUHQAUPbdYzPYs
 33bncMva8SnHwli0Z641/WyxuN8V1b6D/mjMjSKGAJxDrfwzYTnxW23CPZgzngAkS7Hp
 w6b4G7xg3kPM4981gM33CyVrYTmP6yNvd5WhVd7XSjN9v0nhoSLZNldyGRHzHYEaEl9o
 Hb2BpvehvIloECBdZPsildkYDZXNnCl06s32HO4tsl4WcmKidy4DsLDwDzSsIlQkh2le
 U5VBfgIek6iQoeHRtgJ17UgIyFLv9pkVgVr5RuwTJ8lcMkt/BInfG81q6mfDa3fPljUa
 4Rew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791994589; x=1792599389;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U0EIV+pybWAZdo35lDSdAge4ZYhlRwK2Y4ccMIqDGbo=;
 b=qiSHe+Gz2u1MIj6YKp1jCJFH4mYdiqzP5VG0qnMLSTa7Z6t3OavfZ3MVzwBF9g4T6q
 UelehkkiBvQsxnLeiNeI4LSd8CK6u7yhqRDx+my7Gnb4VO1+LhawvWq0su9ZOzvw8+UT
 08soJHlMk7JXuL4n/lRZKvN5L3HytnidWYeQp5E0sGXTu545XgtDyJSipYhof8hOseTo
 JL3SEv3nxDrP+BKO/Yo0x06LwRYROu/sJA7MOvSGw7Wt8JflajdHkHp1fDkv5QZOPoc5
 alqq47rj4D/XcxRlCBxmGGmBeBX61/lfF6+jDYM/znkTGn2DHfI9pFQwVYyRJc5CLMBQ
 4URw==
X-Forwarded-Encrypted: i=1;
 AKwUvByodxH5xrdE/PA9qs7YX82zpFA2eHjNWtyuVBQ0G0D5L9v0jJL9H1reBDNXXudbqX6ZBqjxa7I=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJNKdLuk4crPSXS/Jb+3JiWcpx+CYh066EqP0K0alBUjpEnmqgz
 lDkI0XYykduYJRF/pcbsVnrK9kS0ddoFfSD9hWqEpgQQfY1TKSUHUbgYqIjDjFjOeHE=
X-Gm-Gg: AYBFou3rh9WR3TQ64Q16qmiDcMHo4IHPGFWJAfVdb/0OjyAh/wa5Otog3on4KEfZCLh
 aqDQs0PoMTBdWvexDxRaghqDFC4SZvrchhMDovCpCnlAONGNe0xFGIL2FsXmsdLtobohF+aHSPA
 7ZgxtLaTt426TymjBWI8eUxh8sa0nH4e7hXoiHJmvvqVHIPt9aIjMmh+77BAkGJC6xXu8kH3xEn
 4OM97m1l+HIKiJVdV3oBQm/5+/tK87Kcim56hxnNwYnHVDHhOKv/TgqPBFOFkbWU4xQlnpV+IaD
 GG2r25umJtelqJ4dWvc1sdbQTGJv2yGB88F/FNUf4jbLQKZOEw/qTIyc7Iq9luP/DHQ2d9ivMln
 Z3GNIQgKTmcuH8bcvVev5ia9PB5sal0ifr7xc94FmNkfS9ZMImDFqkY9I4YSFJNHVO1eakKiuYU
 hd8xeBpLElrAaW0Mf/UoPYk8CB+SvSXBpKIyD1Wn4m7Gci1EA7JcCNK1CzuVbhMGXmLD1051qIU
 l0HSQ1i5mUwoDdXQbQRK2BBL0TdGewS8hIpYiRdH2fDU7FAM3ha9zgmjMWhTiFbSRQ4lvCcJg8m
 FryP9o3KAS8pyJC0uJjLhk2kYEE131WcW5aZ8/Bd/9yDfNu0MyLJqiQ=
X-Received: by 2002:a05:600c:19ca:b0:4a1:7e76:d02f with SMTP id
 5b1f17b1804b1-4a18e4ac650mr327194875e9.14.1791994589225; 
 Wed, 14 Oct 2026 09:16:29 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-8434-7c41-c701-8278-849f-666b-c282.rev.sfr.net.
 [2a02:8434:7c41:c701:8278:849f:666b:c282])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd9934eesm2204315e9.10.2026.10.14.09.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:16:28 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 14 Oct 2026 18:16:45 +0200
Subject: [PATCH v2 2/3] power: domain: mtk: add MT8365 power domain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-mt8365-add-power-domain-v2-2-dfc3e6eadfd5@baylibre.com>
References: <20261014-mt8365-add-power-domain-v2-0-dfc3e6eadfd5@baylibre.com>
In-Reply-To: <20261014-mt8365-add-power-domain-v2-0-dfc3e6eadfd5@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Irving-ch Lin <irving-ch.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.16.0
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

Add power domain support for MT8365.

The domain tables and bus-protection sequences mirror the Linux
mt8365-pm-domains.h data available at commit ffeebf7587f5
("pmdomain: mediatek: Convert all SoCs to new style regmap retrieval")

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/power/domain/Makefile              |   1 +
 drivers/power/domain/mt8365-power-domain.c | 236 +++++++++++++++++++++++++++++
 2 files changed, 237 insertions(+)

diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
index 66c448033ee..3b816ed3bed 100644
--- a/drivers/power/domain/Makefile
+++ b/drivers/power/domain/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_TARGET_MT7623) += mt2701-power-domain.o
 obj-$(CONFIG_TARGET_MT7622)$(CONFIG_TARGET_MT7629) += mt7622-power-domain.o
 obj-$(CONFIG_TARGET_MT8188) += mt8188-power-domain.o
 obj-$(CONFIG_TARGET_MT8189) += mt8189-power-domain.o
+obj-$(CONFIG_TARGET_MT8365) += mt8365-power-domain.o
 obj-$(CONFIG_TARGET_MT8366) += mt8366-power-domain.o
 endif
 obj-$(CONFIG_QCOM_RPMH_POWER_DOMAIN) += qcom-rpmhpd.o
diff --git a/drivers/power/domain/mt8365-power-domain.c b/drivers/power/domain/mt8365-power-domain.c
new file mode 100644
index 00000000000..a90af237c06
--- /dev/null
+++ b/drivers/power/domain/mt8365-power-domain.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 MediaTek Inc.
+ * Copyright (C) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+#include <dt-bindings/power/mediatek,mt8365-power.h>
+#include <linux/bitops.h>
+
+#include "mtk-power-domain.h"
+
+#define MT8365_SPM_PWR_STATUS			0x180
+#define MT8365_SPM_PWR_STATUS_2ND		0x184
+
+#define MT8365_INFRA_TOPAXI_PROTECTEN_SET	0x2a0
+#define MT8365_INFRA_TOPAXI_PROTECTEN_CLR	0x2a4
+#define MT8365_INFRA_TOPAXI_PROTECTEN_STA1	0x228
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_SET	0x2a8
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_CLR	0x2ac
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_STA1	0x258
+#define MT8365_INFRA_TOPAXI_SI0_CTL		0x200
+#define MT8365_INFRA_TOPAXI_SI2_CTL		0x234
+#define MT8365_INFRA_NAO_TOPAXI_SI0_STA		0x0
+#define MT8365_INFRA_NAO_TOPAXI_SI2_STA		0x28
+#define MT8365_SMI_COMMON_CLAMP_EN		0x3c0
+#define MT8365_SMI_COMMON_CLAMP_EN_SET		0x3c4
+#define MT8365_SMI_COMMON_CLAMP_EN_CLR		0x3c8
+
+#define MT8365_INFRA_TOPAXI_PROTECTEN_MM_M0			BIT(1)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_MM_M1			BIT(2)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_MMAPB_S			BIT(6)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_AP2CONN_AHB		BIT(13)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_CONN2INFRA_AHB		BIT(14)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_MFG_M0			BIT(21)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_MFG_M1			BIT(22)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_MM2INFRA_AXI_GALS_SLV_0	BIT(10)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_MM2INFRA_AXI_GALS_SLV_1	BIT(11)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_INFRA2MFG			BIT(25)
+
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_MM2INFRA_AXI_GALS_MST_0	BIT(16)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_MM2INFRA_AXI_GALS_MST_1	BIT(17)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_CONN2INFRA_AXI_GALS_MST	BIT(18)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_CAM2MM_AXI_GALS_MST	BIT(19)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_INFRA2CONN_AHB_GALS_SLV	BIT(21)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_APU2AP			BIT(2)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_APU_CBIP_GALS_MST	BIT(20)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_PWRDNREQ_INFRA_GALS_ADB	BIT(24)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_PWRDNREQ_MP1_L2C_AFIFO	BIT(27)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_AUDIO_M	BIT(28)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_DSP_M		BIT(30)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_DSP_S		BIT(31)
+
+#define MT8365_INFRA_TOPAXI_SI0_WAY_EN_MMAPB_S			BIT(6)
+#define MT8365_INFRA_TOPAXI_SI2_WAY_EN_PERI_M1			BIT(5)
+#define MT8365_INFRA_NAO_TOPAXI_SI0_CTRL_UPDATED		BIT(24)
+#define MT8365_INFRA_NAO_TOPAXI_SI2_CTRL_UPDATED		BIT(14)
+
+#define MT8365_BUS_PROT_INFRA_WR_TOPAXI(_mask)			\
+	BUS_PROT_WR(INFRA, _mask,				\
+		    MT8365_INFRA_TOPAXI_PROTECTEN_SET,		\
+		    MT8365_INFRA_TOPAXI_PROTECTEN_CLR,		\
+		    MT8365_INFRA_TOPAXI_PROTECTEN_STA1)
+
+#define MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(_mask)		\
+	BUS_PROT_WR(INFRA, _mask,				\
+		    MT8365_INFRA_TOPAXI_PROTECTEN_1_SET,	\
+		    MT8365_INFRA_TOPAXI_PROTECTEN_1_CLR,	\
+		    MT8365_INFRA_TOPAXI_PROTECTEN_1_STA1)
+
+#define MT8365_BUS_PROT_SMI_WR_CLAMP_EN_PORT(_port)		\
+	BUS_PROT_WR(SMI, BIT(_port),				\
+		    MT8365_SMI_COMMON_CLAMP_EN_SET,		\
+		    MT8365_SMI_COMMON_CLAMP_EN_CLR,		\
+		    MT8365_SMI_COMMON_CLAMP_EN)
+
+static const struct mtk_scp_domain_data mt8365_scp_domain[] = {
+	[MT8365_POWER_DOMAIN_MM] = {
+		.sta_mask = PWR_STATUS_DISP,
+		.ctl_offs = 0x30c,
+		.pwr_sta_offs = MT8365_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8365_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_cfg = {
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_MM2INFRA_AXI_GALS_MST_0 |
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_MM2INFRA_AXI_GALS_MST_1),
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
+				MT8365_INFRA_TOPAXI_PROTECTEN_MM_M0 |
+				MT8365_INFRA_TOPAXI_PROTECTEN_MDMCU_M1 |
+				MT8365_INFRA_TOPAXI_PROTECTEN_MM2INFRA_AXI_GALS_SLV_0 |
+				MT8365_INFRA_TOPAXI_PROTECTEN_MM2INFRA_AXI_GALS_SLV_1),
+			BUS_PROT_WAY_EN(MT8365_INFRA_TOPAXI_SI0_WAY_EN_MMAPB_S,
+					MT8365_INFRA_TOPAXI_SI0_CTL,
+					MT8365_INFRA_NAO_TOPAXI_SI0_CTRL_UPDATED,
+					MT8365_INFRA_NAO_TOPAXI_SI0_STA),
+			BUS_PROT_WAY_EN(MT8365_INFRA_TOPAXI_SI2_WAY_EN_PERI_M1,
+					MT8365_INFRA_TOPAXI_SI2_CTL,
+					MT8365_INFRA_NAO_TOPAXI_SI2_CTRL_UPDATED,
+					MT8365_INFRA_NAO_TOPAXI_SI2_STA),
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
+				MT8365_INFRA_TOPAXI_PROTECTEN_MMAPB_S),
+		},
+		.caps = MTK_SCPD_STRICT_BUS_PROTECTION,
+	},
+	[MT8365_POWER_DOMAIN_CONN] = {
+		.sta_mask = PWR_STATUS_CONN,
+		.ctl_offs = 0x032c,
+		.pwr_sta_offs = MT8365_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8365_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = 0,
+		.sram_pdn_ack_bits = 0,
+		.bp_cfg = {
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
+				MT8365_INFRA_TOPAXI_PROTECTEN_AP2CONN_AHB),
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_CONN2INFRA_AXI_GALS_MST),
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
+				MT8365_INFRA_TOPAXI_PROTECTEN_CONN2INFRA_AHB),
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_INFRA2CONN_AHB_GALS_SLV),
+		},
+	},
+	[MT8365_POWER_DOMAIN_MFG] = {
+		.sta_mask = PWR_STATUS_MFG,
+		.ctl_offs = 0x0338,
+		.pwr_sta_offs = MT8365_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8365_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(9, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+		.bp_cfg = {
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
+				MT8365_INFRA_TOPAXI_PROTECTEN_INFRA2MFG),
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
+				MT8365_INFRA_TOPAXI_PROTECTEN_MFG_M0 |
+				MT8365_INFRA_TOPAXI_PROTECTEN_MFG_M1),
+		},
+	},
+	[MT8365_POWER_DOMAIN_AUDIO] = {
+		.sta_mask = BIT(24),
+		.ctl_offs = 0x0314,
+		.pwr_sta_offs = MT8365_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8365_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(12, 8),
+		.sram_pdn_ack_bits = GENMASK(17, 13),
+		.bp_cfg = {
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_PWRDNREQ_MP1_L2C_AFIFO |
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_AUDIO_M),
+		},
+	},
+	[MT8365_POWER_DOMAIN_CAM] = {
+		.sta_mask = BIT(25),
+		.ctl_offs = 0x0344,
+		.pwr_sta_offs = MT8365_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8365_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(9, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+		.bp_cfg = {
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_CAM2MM_AXI_GALS_MST),
+			MT8365_BUS_PROT_SMI_WR_CLAMP_EN_PORT(2),
+		},
+	},
+	[MT8365_POWER_DOMAIN_DSP] = {
+		.sta_mask = BIT(17),
+		.ctl_offs = 0x037C,
+		.pwr_sta_offs = MT8365_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8365_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+		.bp_cfg = {
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_PWRDNREQ_INFRA_GALS_ADB |
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_DSP_M |
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_DSP_S),
+		},
+	},
+	[MT8365_POWER_DOMAIN_VDEC] = {
+		.sta_mask = BIT(31),
+		.ctl_offs = 0x0370,
+		.pwr_sta_offs = MT8365_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8365_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_cfg = {
+			MT8365_BUS_PROT_SMI_WR_CLAMP_EN_PORT(3),
+		},
+	},
+	[MT8365_POWER_DOMAIN_VENC] = {
+		.sta_mask = BIT(21),
+		.ctl_offs = 0x0304,
+		.pwr_sta_offs = MT8365_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8365_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_cfg = {
+			MT8365_BUS_PROT_SMI_WR_CLAMP_EN_PORT(1),
+		},
+	},
+	[MT8365_POWER_DOMAIN_APU] = {
+		.sta_mask = BIT(16),
+		.ctl_offs = 0x0378,
+		.pwr_sta_offs = MT8365_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8365_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(14, 8),
+		.sram_pdn_ack_bits = GENMASK(21, 15),
+		.bp_cfg = {
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_APU2AP |
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_APU_CBIP_GALS_MST),
+			MT8365_BUS_PROT_SMI_WR_CLAMP_EN_PORT(4),
+		},
+	},
+};
+
+MTK_SCP_SOC_DATA(mt8365, mt8365_scp_domain);
+
+static const struct udevice_id mt8365_power_domain_ids[] = {
+	{
+		.compatible = "mediatek,mt8365-power-controller",
+		.data = (ulong)&mt8365_scp_soc_data,
+	},
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(mt8365_power_domain) = {
+	.name = "mt8365_power_domain",
+	.id = UCLASS_POWER_DOMAIN,
+	.ops = &mtk_power_domain_ops,
+	.probe = mtk_power_controller_probe,
+	.of_match = mt8365_power_domain_ids,
+	.priv_auto = sizeof(struct mtk_scpsys),
+};

-- 
2.56.0

