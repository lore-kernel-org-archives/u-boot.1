Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651BCD1D493
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 20:29:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5C1E84324;
	Thu,  8 Jan 2026 21:29:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CHNc1DUX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F24684370; Thu,  8 Jan 2026 21:29:07 +0100 (CET)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE1F684158
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 21:28:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x643.google.com with SMTP id
 a640c23a62f3a-b83122f9d78so601387966b.0
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 12:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767904139; x=1768508939; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A6/wAsQPJhKW7+RHmtuPzsg2cI5nkLWhGL3Uj862Xl0=;
 b=CHNc1DUXTufj60ud/MXpBDgIZzn+27wNT15n3YTQeUASKIsvUHWpGpa3R1QC1cMwGg
 s6QMUDIyQzjfyRzqPEvaSyjD8G9lEatlshHYluDg/Uet9YSI3mAaM7Z932ZYyOghgvKI
 tFvzVY+p3rtKMZeErOjW4PstrRKBU/vubU/GLfo2OW6aqTwDMqbrjOEHvTHHP3a0LrPF
 U9Cky4M1H2Op821ahCOPmkIBTU3DozyvtCsEiTqEW6NbuJcEaGhoEs0azOJJxZKGRYa8
 O90btFWPNfMO/vND3AwIslLmPxp4m1QiAkjhDzX2dKRHsJDjeO7bOeu+v4iEGI1EwSrV
 n4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767904139; x=1768508939;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=A6/wAsQPJhKW7+RHmtuPzsg2cI5nkLWhGL3Uj862Xl0=;
 b=fJ5RBsThgzkdcpRITIXkgjgaKJEPKEFjutVK4afz5APDl2b9IcqXsW56Jlj7cz+EX/
 1kYSG/JuT2L6bijbvFHqsGoNVDybu/RaRj3YtESZdLZ1ZKnhOZ9kI9sSQQcz8OXM+QsU
 W4r0h2tYLdTdb7mlgTAzca8yu6SISSFO7MWc//qARhmiwEo88Ml9YckIA+qsjhz2p67r
 8n80+6u6b7BEKrxqz6kfm7u2aFDQh3xbty/tk2DWBpHiX6vvQKdjH9uoNp61ZIuDmjH3
 nDykXJYpGZLeXFOiNhg019D615lGkh0oJShFsscoK3W0jZqCt3N/SH0Yf599SU/ANRUV
 xwlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJyx5cegsT10IE6tyoJX83K5Mw/Jt0ANgz2JbhxitIIR4Xr5wrg4R1eLZ22hDDaIZBdFRsdKY=@lists.denx.de
X-Gm-Message-State: AOJu0YwZRLaiiKdnlYldWO7ksr2jmciD+3nAP6qvsADDDsbghEQO2GfI
 f17I65mXvFHq2OEhn1/lS+jNGsG0MBd8wnqnYypR4NFI6zNQP1yjsJmb7fKxHWNznWQ=
X-Gm-Gg: AY/fxX5Rg6KJwb47KT+uJ1JSSJQT2hrkq/Xv2+Qwvz0Pho+5N/5xvP7Q1+IGFAhBywa
 le7KKvdOt6LxV7Y7LbcmMEZVfFU5hGuVU2DjBzQCEmS57L1SKdk9urS4hJFXz+Ej3xL95KpYjiv
 tngX1SrOPheyPUMvcFaiSoECpWNAXMPc8Huf88KTyo500DwqdKSO2LRMXNLzirC4baIMdl0f2tO
 US+DMSgOKq2gPAVj7zylDk2mXN3kaC0ohus3VOEaB4mL2vnZ/T/YE+uUuP4fTpxucqOh9WXUQW6
 B/mr84poEF6vUYELY3LcCS0cHZBFEPZ4+WWAVqwYQ3l/I6YZioIT7jWCuD73PrKXf7k3HxWdEgY
 9pYzsxd3FvNe57byamNL26gmacLr7DmP3wJsGWMFTOk/KM/cxZrAU8j8iNqZ1MD0I34iJSRbvxS
 zwtZ7uS4klyWiDIKNVTSkI83vCBn+KVF9kP1kAYPuPLa6OR45borMtHg==
X-Google-Smtp-Source: AGHT+IFieG7z/dbprBfPj6YNUzqzpp8vskw5b91/oF8L0RbOYFrmURPzMmNWMiTt7HtIkAnz5V7vIg==
X-Received: by 2002:a17:907:3da0:b0:b83:95c7:e984 with SMTP id
 a640c23a62f3a-b84453ab79emr698563566b.49.1767904139135; 
 Thu, 08 Jan 2026 12:28:59 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a564e05sm930264366b.65.2026.01.08.12.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 12:28:58 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 08 Jan 2026 21:28:44 +0100
Subject: [PATCH 2/6] soc/qcom: rpmh: document rsc registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-rpmh-regulator-fixes-v1-2-d1b5b300b665@linaro.org>
References: <20260108-rpmh-regulator-fixes-v1-0-d1b5b300b665@linaro.org>
In-Reply-To: <20260108-rpmh-regulator-fixes-v1-0-d1b5b300b665@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15-dev-52d38
X-Developer-Signature: v=1; a=openpgp-sha256; l=1606;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=GRcIcdRCE9AggfZzavTVGVhgiuErtrmCBeevVyxhUJI=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhswE4fbV/y7q7/nWoPJGdsHfyc+4j2fFf03zUctuf13+v
 1ba/fHUjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjARv/0M/8Ojz1cqronhs2qS
 NV4V8PtabOWJrbrC6e61T80vsLvfvsHwT6Ni6vRPy30NtO9nx+TwSnwNjqy+5RH8YkPvnaAlnFK
 zTwMA
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

Add some comments explaining a few of the RSC registers

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index bc0c3dd005ac..f51ef0b4af9c 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -35,17 +35,33 @@
 
 enum {
 	RSC_DRV_TCS_OFFSET,
 	RSC_DRV_CMD_OFFSET,
+/* DRV HW Solver Configuration Information Register */
 	DRV_SOLVER_CONFIG,
+/* DRV TCS Configuration Information Register */
 	DRV_PRNT_CHLD_CONFIG,
+/* Offsets for common TCS Registers, one bit per TCS */
 	RSC_DRV_IRQ_ENABLE,
 	RSC_DRV_IRQ_STATUS,
-	RSC_DRV_IRQ_CLEAR,
-	RSC_DRV_CMD_WAIT_FOR_CMPL,
+	RSC_DRV_IRQ_CLEAR,	/* w/o; write 1 to clear */
+/*
+ * Offsets for per TCS Registers.
+ *
+ * TCSes start at 0x10 from tcs_base and are stored one after another.
+ * Multiply tcs_id by RSC_DRV_TCS_OFFSET to find a given TCS and add one
+ * of the below to find a register.
+ */
+	RSC_DRV_CMD_WAIT_FOR_CMPL,	/* 1 bit per command */
 	RSC_DRV_CONTROL,
-	RSC_DRV_STATUS,
-	RSC_DRV_CMD_ENABLE,
+	RSC_DRV_STATUS,	/* zero if tcs is busy */
+	RSC_DRV_CMD_ENABLE,	/* 1 bit per command */
+/*
+ * Offsets for per command in a TCS.
+ *
+ * Commands (up to 16) start at 0x30 in a TCS; multiply command index
+ * by RSC_DRV_CMD_OFFSET and add one of the below to find a register.
+ */
 	RSC_DRV_CMD_MSGID,
 	RSC_DRV_CMD_ADDR,
 	RSC_DRV_CMD_DATA,
 	RSC_DRV_CMD_STATUS,

-- 
2.51.0

