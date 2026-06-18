Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEB3CD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 11:58:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A418849C9;
	Thu, 18 Jun 2026 13:57:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UwufFssc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1773849EA; Thu, 18 Jun 2026 13:57:16 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA2A38005D
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 13:57:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-490bb83a3f6so5334715e9.0
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 04:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781783834; x=1782388634; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WTxaFyE2qhtnyBQx2cPM39mlRKtlfrEkHE0SKEiXpCk=;
 b=UwufFssc50HXlghhyNaLQexP7aCxdK5c5OKSDuzf0UNwz+/KRMBsarfPOeumCosUlW
 2H3TTX8XWEo69K3kkUI1VJyQh+NY51LogxJPz8hQYFvbP/lVVrTG4CVnW6XlkIeUGbAN
 6t5PwMk9Vh70QFVvyqQ/7f7CVXmEa4egEcv7+ooOrvqxvu43h159d4Mq13okhLl4tYOR
 uGZmzGDZnBQ/T1ClfckkS90ay8c+va2EW1KrBqUwNfUHDPXSFfMO/tDVHhHMAzgBJjPL
 u2H1A0jE2V4XE26YOq3+1kvE3asdyr2/6lG5v9SJOicxkHF/jFiAl33vgQsiMMMlarH9
 JaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781783834; x=1782388634;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WTxaFyE2qhtnyBQx2cPM39mlRKtlfrEkHE0SKEiXpCk=;
 b=l4lKAiwkCtjhVCqBggb0eTGvJcelLG6CB+GpkvNYFQ/IqnrPjRgoIFxjWlNGwr+zZg
 e6KD0C63IBdjuwDoGTf92LB/gox9BxJqJ9IayieKbw7TEQ+wmKoRf6ZoDFH7zjNe7OYj
 uuoAdBTpFT6pYHq3wlB8dUrTOkNKknwc2V9tHvlbFWKauJPMjiOb2RZFjgcv/sRJK6ZR
 cOZ2Rumprm98diLF10r8obqKjWfqNxEm9NmwN/WtCeMSlCvtMBlSoTSglxcpceLyD8cv
 aKMmngW0qzDbYJxOFpz8suyVTdTVu6986DilDiz181jkaM6YFdBYKDFnAp63xzMeBoqB
 A1KA==
X-Gm-Message-State: AOJu0YwNrRoHPLGhbVDGa5S+8vTOWcyAQRbsikoUnRb0ttZGO3TmhoD2
 YaFzUf658eLNU270pW5iPAlFcn1k8439bRNtYtcJIB2iJay9wWXF3BheTrzV271hSFY=
X-Gm-Gg: AfdE7cl8ejH7VqEi6FCtQewykeb9x8mbEBbG0IzICB4WJ88Sz9vRaG99Yj9TpYO0VD7
 Junn1QW5kP2lb6a2r9qm3MZa8aeHPAVwwQeoH3hnJrgBMkvE9GyY2KDE4i9W3V5rBhHRury9HbK
 ReMXsZILkUruFkM2vL9nFFusxAxBbfBrHSpKITWVg3q/nzOFguv6zm4N7rPlbkfP470Wq5g+8Zi
 RPL7xN5fGDNyIUFXp5iHKL7SLNDpEAYRpD94YZb39WsfvvXvANfMJIAtHZJ1OSI6zMkAWCeoUJ3
 ooGUU/DflG9zlTIk2oxibLO4FYuAiJYArF7nEi/sZM2k3FBxSJjeX+6tesdNgK/W//eV9FluGD4
 bI/QuX66K6GuQc+4Ji5Obhn4iR6lLKT8ScFgtxPoQ9towFazZfZICH2kHqj4HYAb0H3uXxm2Xwc
 hHAzf1JOIn+j3persyLhVqkI/Ij6evzNHLq+iNm7CzXE3XifMLPTPP7Tk=
X-Received: by 2002:a05:600c:1395:b0:490:e5c1:b8b9 with SMTP id
 5b1f17b1804b1-4923a8c402emr30969415e9.0.1781783834028; 
 Thu, 18 Jun 2026 04:57:14 -0700 (PDT)
Received: from lion.localdomain (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46289c3b3a3sm14448355f8f.30.2026.06.18.04.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 04:57:12 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 18 Jun 2026 13:56:57 +0200
Subject: [PATCH v3 09/15] soc: qcom: smem: get serial number from socinfo
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-b4-modernise-smem-v3-9-472391477988@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1995;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=B7TNnkjwSQ3jYFv20YwxadVuoGWOjCu7WiCVmzeuxPM=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhizju6z3kurDXQymGbefmcMw67X6tVpH6SlRqXNPXgt/8
 0ZVJmFvRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZhIYQzDT0bHv0fDdbI8Sies
 3vKAN/bJdfffG9nOFs7wqvywUXK562aGv8K182/MNZ+uNW/ZnGu7yw7/m2h2eV/HjnrNSx/eVx7
 RqPEGAA==
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

Implement socinfo support to fetch the serial number if available.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/soc/qcom/smem.c | 25 +++++++++++++++++++++++++
 include/soc/qcom/smem.h |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 7a3c63cdcde2..9d81a31a0e90 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -14,8 +14,10 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/sizes.h>
 #include <soc/qcom/smem.h>
+#include <soc/qcom/socinfo.h>
+#include <env.h>
 
 /*
  * The Qualcomm shared memory system is a allocate only heap structure that
  * consists of one of more memory areas that can be accessed by the processors
@@ -997,8 +999,31 @@ static int qcom_smem_map_global(struct qcom_smem *smem, u32 size)
 
 	return 0;
 }
 
+int qcom_socinfo_init(void)
+{
+	struct socinfo *info;
+	size_t item_size;
+	char buf[32] = { 0 };
+
+	info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID,
+			     &item_size);
+	if (IS_ERR(info)) {
+		log_err("Couldn't find socinfo: %ld\n", PTR_ERR(info));
+		return PTR_ERR(info);
+	}
+
+	if (offsetof(struct socinfo, serial_num) + sizeof(info->serial_num) <= item_size) {
+		snprintf(buf, sizeof(buf), "%u", le32_to_cpu(info->serial_num));
+		env_set("serial#", buf);
+	} else {
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
 int qcom_smem_init(void)
 {
 	struct smem_header *header;
 	int num_regions;
diff --git a/include/soc/qcom/smem.h b/include/soc/qcom/smem.h
index a955db08c0f0..755003807dba 100644
--- a/include/soc/qcom/smem.h
+++ b/include/soc/qcom/smem.h
@@ -4,8 +4,9 @@
 
 #define QCOM_SMEM_HOST_ANY -1
 
 int qcom_smem_init(void);
+int qcom_socinfo_init(void);
 
 bool qcom_smem_is_available(void);
 int qcom_smem_alloc(unsigned host, unsigned item, size_t size);
 void *qcom_smem_get(unsigned host, unsigned item, size_t *size);

-- 
2.53.0

