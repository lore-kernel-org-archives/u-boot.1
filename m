Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F97FCD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 11:58:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7690E849E9;
	Thu, 18 Jun 2026 13:57:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="p3SJLUE9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87AD8849EA; Thu, 18 Jun 2026 13:57:18 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AFF4849E8
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 13:57:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-490b7866869so7723755e9.2
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 04:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781783836; x=1782388636; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L3QhoSmltGAVG5n+3Eg5AeyiVEqAAVMRwmgimpQY6Kg=;
 b=p3SJLUE9egnyBpuXVA90ERYIrBTXlBRpFbpEHVqAjZqkoufEAQNI6fxHhr0L16GPvY
 LUh9iKGOBypyI+h0vjrHPF6VNFgax9CTIV+0FVOjGfj6V19SFGMN0QHHIAJpE7NJilyN
 YdjtXTkakUDJWkKUJp6LWT+aVf5lf+m8oDFpQNSPkS+LkO6hpx8WU5okPtlwGwiJ/c1q
 yrtSE3+QTqupuB5ozx8ElJ2y+S+M39U0zJdvFJf/+BAJXRI9o81MfT89N5uCEsBvxK2U
 e2HT8zPbaEMXvLXPQZVhyQ4csM2KumZNIPkl18mZxBjHuP8Ay5kjtY9xVS5PWGPhJtLs
 p6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781783836; x=1782388636;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=L3QhoSmltGAVG5n+3Eg5AeyiVEqAAVMRwmgimpQY6Kg=;
 b=Rh4s1Az36Zj6SbxiXZS/O5KDFjXGeI303TgDVTnzNQQf2mCT/COkHtlR4kEPyFzTn4
 t0vG9EiZBZQ/CGDyFOtDjjAo5QnKIgAWrBIQxqL647AZg57Yg74HuywkQDk4nNATrnj3
 H+NGjWk+7Qt0qMpwPxgqTIBXtQZ5EZDrKqbkLVrlyWL7tt1TCPE51C4xX0PdsLIMqG4U
 Og4JzVT7tlQHMOe6/0Jz9r5MUAWuSSDBwH3iOEyTashXSeGTc7F6tNf5JmsbC1KM9LeN
 oRMmEtGjGMAcgBlLm+cXk/z9kuykkrtvNInbiAzca+VPscO7RzkcvyGkk9WHJrLh9Jsw
 dCrw==
X-Gm-Message-State: AOJu0YwFT5kGKov8gL6kCjGgL9N/bZ+3snuSXCmafMcjZ/fBc6PWGlqm
 kc+0+/4P3SZswpbqAENIahIqnsROgZ8Te9bWQQ/aV+7gPvXtHcWo9g0Xm/Vvt2YcHig=
X-Gm-Gg: AfdE7clQLkYxsG7vpKsPaAFVgz0lXVe71wtJQ+MvuQi2o69yx+USkFZdgTmYf2Rrox4
 Ga1NjNGFmHByWrm0xkd+RI3qfbzm6qrTJFDa6pFSMUnylJTZjwN7TOBCSwBoOr8l87+2g3wRTAa
 7T8XLyp3iIvhghI77HT1jpVHRHu5vz8sWoLvad70Cqcf6tC8VJb5SECBpvr8h9UAjOlw3EhwZJu
 zT8RD8MHX66KokNRDhEtjSOPeEahMehoNan2JpkUhOek0vRBnJ8hXjG69x5lDfi0bggqz9XsRa9
 6l7HUijd99Rs21S2Y4gWzvv8Gj5E6FyBZOdnFsHgPz2oJ8cvZQFE62fc9zygMkC9VJ4caB4kAjW
 Ew8LO74bL6ikGZNqQeZHmw9Qm72sSpZ1c0yopOQYH0eZMLcci+LkIQBKuxk+ElTQYCh6qabNW16
 96PowE9OIuTUNtJn0BnbsW/TBiCNwUpzx6uBgw3mttHmgyQBbaX8h8f5s=
X-Received: by 2002:a05:600c:6045:b0:490:7dfd:f7c2 with SMTP id
 5b1f17b1804b1-49234104447mr92028495e9.11.1781783835721; 
 Thu, 18 Jun 2026 04:57:15 -0700 (PDT)
Received: from lion.localdomain (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46289c3b3a3sm14448355f8f.30.2026.06.18.04.57.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 04:57:15 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 18 Jun 2026 13:56:58 +0200
Subject: [PATCH v3 10/15] soc: qcom: smem: stub functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-b4-modernise-smem-v3-10-472391477988@linaro.org>
References: <20260618-b4-modernise-smem-v3-0-472391477988@linaro.org>
In-Reply-To: <20260618-b4-modernise-smem-v3-0-472391477988@linaro.org>
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
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhizju6wrdy9nbfz8625aoNENT+5OsTVJgoVumSk+lr8Ka
 pqaFXs7SlkYBDkYZMUUWcRPLLNsWnvZXmP7ggswc1iZQIYwcHEKwETYnzIyLLdwU3My3/Tu6Lk3
 d1l6IraalEnpS/I4Cec+8xCZ4XJ6ByND+53Kr9a+fGKVi1d1S1WZuPEpzdszveq9zPtKN1k/Zz5
 rAA==
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

