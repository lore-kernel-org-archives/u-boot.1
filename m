Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA95CD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 18:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2F5F846B8;
	Mon,  4 May 2026 20:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Cp6S5NCF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CAD1846B4; Mon,  4 May 2026 20:57:55 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB37B8467F
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 20:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43fe3e22e33so2452121f8f.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 11:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777921072; x=1778525872; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mLdiKxd4/Gm+Z4pxfe5oIGRD0IVqWNN0nmC/zzE6cIY=;
 b=Cp6S5NCFfsJJztXfMSsJ232t8bHpwNrUOyU31hBRQt+L/UyD0rS+dHQsdvMceYUnq8
 hz9vLdGG+xZJlLwHarEa3OgpRF5mNRNWXCRCOtYe/wMp9aIiem5mw2RXzATzXBX7krka
 kcE2LlsVq/weo0sJGKlut+FLztOTW58CID4bN8tvIWsbK4H/23XmwgvpLD0w8vWSWRZJ
 anxNe976Ixfoex7ElZNHTqpPCC514+vAkI/U9MnaRpb1bMeshxeefW6ZvTnct+rNXhfa
 sYPY9/3naQEgM6Iq0iYzDx9LDhYBgqAJ/hljVvdKDXzJ8mrq8fyZ7f6ZlZKksIZIP5uZ
 Uokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777921072; x=1778525872;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mLdiKxd4/Gm+Z4pxfe5oIGRD0IVqWNN0nmC/zzE6cIY=;
 b=dX384t6QwJh5GhRvWxAtXOQPa/h3T8Z7xb5DUgdb3R1AMLe8ViRk0Ha5CS1aErQ7/r
 6M/peRf4rdzGra1zR9pUp1Pf4skFpNxw9/fA/+s56u8D+FkaxGfIN9IBC7V2ox3JoZV3
 5QAy9Lq8elmRwJO+3aX1e/OUQ4jy7GkB/c4SGhU61lnwaFmuKjaJNj5/jogESx2lIFda
 xs45mxoqFmdv6noRCxVNu8igpomRmnlR2JQ6hgz4fpSWktcrXkBsagQZtJ0ttAUzYcNU
 x9aK+ElM6owifzL+R6QETdFjC9wEC2ZCh39JoGKigLN8rLN5GIdqbkpQiUPC7LmWKkp2
 Wmdg==
X-Gm-Message-State: AOJu0YyjpWQFJuUQOmWrto5q9aSck5wSsRYHNecu1pfM69AMfj4TEX0g
 lTqsrQ5KCSH49mxVow5JPjcw31xEJiJYxKNxSNLLhW5PyfaGBn7dc+XdGTnprN7nnhw=
X-Gm-Gg: AeBDieuzZUpvpXDaeRVwH/kxs2R58Iji65rbB/SMMSK110nTIbUXZc4dcEpSNAY/tBx
 1jmW6rZLynJp8uVOeVM5W417LdZw79n/b/ZV60awTFZydAaDKzc9DCarHSBjvxtcd+XDCQLM073
 2ReQ7zw+QGsrFv5d9vDymoCwynA87N8tPEhdF5hHe9nH93Cu1fmwe6zFMJ9/LfYItHdvSQVWVlc
 ip+YYoL+d7DyBThoLtWrEbUX1k0YiidSzm7c/3rda7QLv+2kRYyFVSTaI+ifhhd/ITJ8wHZ5jkh
 Z9U9rGJX40Xh8DISi0vJqIhOENPFbII6Ksqn3Dh7xTqhUCs4XeNytPvL8URACNaxTQU9UZozonm
 +4Ic4ZzQ9n3Ct2COEfd5lh4BIndOGE7GRbqLTpm7Qs1ft5NAx30U5tOCGSU/rFpaam/wUUw8jID
 OyNRIxYesl3aDbBxMYpvQR3Lss92KBgVFr/z6cSLLnp+dsMsCbDQ6nEE1sIFHg/JABg8lCih9rs
 N8XxSM=
X-Received: by 2002:a05:6000:230e:b0:448:8db5:410b with SMTP id
 ffacd0b85a97d-45005c8124dmr181688f8f.20.1777921072190; 
 Mon, 04 May 2026 11:57:52 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4500f9c2cd5sm2861f8f.23.2026.05.04.11.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 11:57:51 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 04 May 2026 20:57:37 +0200
Subject: [PATCH v2 09/15] soc: qcom: smem: get serial number from socinfo
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-b4-modernise-smem-v2-9-c01ec2ff3886@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1995;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=VALimxUq/VLwKFV82ljv5U4pUSusFIKExlHMx7mRt1A=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhswfb+SlZ/55v/XFsV8qraL+dyKDpe5zPvBbL9E42Uk2q
 +SWxbqFHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAiTT8Z/qcrugpeaL/1cNv/
 JMtWH6b6NfvE3sps3aLzqURuh5VqhT0jw2Jr/k6+hMuRuyJV7nU//i4/WS9p0n8ju7WhXFnPk/M
 CdAA=
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
index 96288d7bcdef..e20523e2cec3 100644
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
@@ -991,8 +993,31 @@ static int qcom_smem_map_global(struct qcom_smem *smem, u32 size)
 
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

