Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D65DCD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 18:59:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31E04846DC;
	Mon,  4 May 2026 20:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JFgnZeKb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 120AD846D7; Mon,  4 May 2026 20:57:57 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 502348467A
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 20:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43d77f6092eso2683679f8f.2
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 11:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777921074; x=1778525874; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L3QhoSmltGAVG5n+3Eg5AeyiVEqAAVMRwmgimpQY6Kg=;
 b=JFgnZeKbvFGf36GEWMqKZdPKLUSnz1ZegGNS7yGGieCV2jLcPnCqDz0/sx2fgiKhBl
 Of5a47Q/MM6UKCEyha2wGwBbxFfIVIz9rsDPilK7j+AdDSYUB6OGLwjRHWjB27+EqdQ3
 Dm8vQX9IpxA00WjWh8z9ujyF5GweRyPRnXqRDMKHY1dPB3xkOrNWD6SrTX8A+nU52fZd
 P7P5poL9fYsfyxaw/j3O0TIYHdpV1qM3VmBJYe7xNFCBB41X1Y3Jkzdrvei4gyAOlOYU
 IAsxs9hCuCh9Xv8bMP7Mbk3O4krTpdcKhf8lc9EQ5dNObup4/85ZWGLb2Z31qzyJfj6N
 QXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777921074; x=1778525874;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=L3QhoSmltGAVG5n+3Eg5AeyiVEqAAVMRwmgimpQY6Kg=;
 b=hCukQLLpO7KLrR9M0puduqCnagGZ+Oyska4rSVIgmTAx1v8QteF1sheNRT3KVL2sj5
 OD2bLtX2lVmE+keHRMqBQOKaHJtAjfDolDLVSouMqerintT3suGHBnS0AeePvTF5Uotg
 +j90QEhqcAQd3VFRgZ5WgYXo5FfaQkdwh9VKN/t0Urz7n3UBI2ZsW6YZ8K3dp9MRj4A8
 3g6ZO0P+Mw06vPM81e1vwsHAuzaIqhnOCHGdWPQWQi9DLJhHc0fTpsLwLvgnZU266C98
 x7riKslKLtkgMCBZRn6gjqcmmmdV4HjgJ6jTrhkyVkgF7EGOrER0MiZAoK2xZLPQH7SS
 SY0w==
X-Gm-Message-State: AOJu0YxvFzsO/1xBhNdJ3+TWEDrVKfU01w3LEti/uj6hc0qUe+G6PgdW
 wdW4+N0GHgjuC5ntRrneuv2KiBWUCq+Zzjbn4vST4Uc4q0zPxYo7ujCfDttne/JGqpk=
X-Gm-Gg: AeBDiett6w6kFrniY8gTOcM74YeSlpGHZxvY6WWRUSJtol98IhdTEBCDfBQwSLe8QPm
 VIcMyBmkks8H6VqU/CCeb87UJdofOdN9mTvw0XEKNVwvgLiN/nPSRpbhZSWD2vU/wBH9h9Rzc5u
 DvyWpn8ce58iIKgRvE30Qgqm4XxxmEZegTTwZZUAr2dRuaIjvKKnI1ORV6xXp1sf29AVbef4xrO
 2cuVYzCRLMCDkM4DvsuT10RlYz+lsIy0yO6tPbD3PVlnVAug+lurYCOQ6vPGWQWub4BlJD1xSa2
 5PcwGCzIx8vVC81tqHzmTquap/H2fh1JYt17tJfLxtXieOBZ6yTSvPJEK+nUl0Cf5dfjcFXYoEe
 +gJPguKau/+eVZfGk5rRbCA8Vm3GnUs65y9oiXviq17mwO8y5Ol/CZXMVjYLdJNclWeBMhHptIU
 fDpBlQjwo2DHFRetkI10PT2ay01Lp8ZUAkWaeIIXnPtNDk9kxouIWiELE9vuRKgDCcpKcI4MO/a
 A2pSSk=
X-Received: by 2002:a05:6000:40da:b0:43d:3004:5fef with SMTP id
 ffacd0b85a97d-45003afe8e4mr264544f8f.7.1777921073734; 
 Mon, 04 May 2026 11:57:53 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4500f9c2cd5sm2861f8f.23.2026.05.04.11.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 11:57:53 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 04 May 2026 20:57:38 +0200
Subject: [PATCH v2 10/15] soc: qcom: smem: stub functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-b4-modernise-smem-v2-10-c01ec2ff3886@linaro.org>
References: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
In-Reply-To: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Heiko Schocher <hs@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1326;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=Kpf7oPUZiLsp66tntSnobYX6XDPd7K0gNGokIwI8meY=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhswfb+TrM4Jzb2QbMB0MeVl0RLBMesk95syYaaXPzld2y
 jC9+FXVUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACbSs5fhn+KCft6oi+deXjG6
 xHd69Xqe1feUPzord0916marPOu2jo3hn9mE0068+1i+vDH+GP50sY7tOYlE7sKqP4qfljxa9ue
 KxxQA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Allow smem to be optional for Qualcomm platforms by providing stub
functions.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 include/soc/qcom/smem.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/soc/qcom/smem.h b/include/soc/qcom/smem.h
index 755003807dba..586432412eb8 100644
--- a/include/soc/qcom/smem.h
+++ b/include/soc/qcom/smem.h
@@ -1,16 +1,36 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __QCOM_SMEM_H__
 #define __QCOM_SMEM_H__
 
+#include <linux/err.h>
+#include <stdbool.h>
+
 #define QCOM_SMEM_HOST_ANY -1
 
+#if defined(CONFIG_QCOM_SMEM)
 int qcom_smem_init(void);
 int qcom_socinfo_init(void);
 
 bool qcom_smem_is_available(void);
 int qcom_smem_alloc(unsigned host, unsigned item, size_t size);
 void *qcom_smem_get(unsigned host, unsigned item, size_t *size);
 
 int qcom_smem_get_free_space(unsigned host);
+#else
+static int qcom_smem_init(void) { return -ENOSYS; }
+
+static bool qcom_smem_is_available(void) { return false; }
+int qcom_smem_alloc(unsigned host, unsigned item, size_t size)
+{
+	return -ENOSYS;
+}
+
+void *qcom_smem_get(unsigned host, unsigned item, size_t *size)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+int qcom_smem_get_free_space(unsigned host);
+#endif
 
 #endif

-- 
2.53.0

