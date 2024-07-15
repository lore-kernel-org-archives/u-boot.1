Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDB6C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:09:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA05F88837;
	Mon, 15 Jul 2024 12:08:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AwOursey";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D028887EB; Mon, 15 Jul 2024 12:08:20 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EF91887FE
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:08:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a77b60cafecso489476766b.1
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721038098; x=1721642898; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RHqpSx9PbuP1dN/L/vtPhpQ9a+6UvvgJ8uEY9WKCVS8=;
 b=AwOursey5cO/AzSr9jPKSMp/xxYQOM+RxRuGxF7JlXeuf9OvxzLYKcMcYhnyjeIooh
 iENy6ua5dOFR/wjF+8lupy2yArz1jQ7e1Neo5TwyDIoMMeORVIi8bMwNJQp9b5yqCfO5
 xPLa+MxoysyXF+eE8s3KP7RXXAl7JEIgPFgR0UgemPCGGjKXBJDcxj0ROGzy40qd7qOE
 UgwzapXXd+LbF0MIG5B/Z+G8mTqdo8f1GFSW/KvQtYgwEPzBQjXw8+460kUZAFmfa3AP
 R7aShyNm2JIu7ZCwjQvCyr6Xfbk7NhtIWWMIktmq+HBHR/OSyPNkbPSBHjKMzjW5SYXM
 +sdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038098; x=1721642898;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RHqpSx9PbuP1dN/L/vtPhpQ9a+6UvvgJ8uEY9WKCVS8=;
 b=kYgLvl6agVr0dE2oRCn4wHScvwypftzht7tLoGNkaWUaKl8ReP8eQmN/ltEoduYSYW
 UkYUG9V/wRpo92z+Gph3B/Ub5RcDSeB12/JKHnZKVMJMq9/UkBOEnzhvFtoyZV/at7mo
 YVxQlBhHcy5mCFYv7tj8mgsbXCxOlErmaGzrrxDxPdKg8r7OYunwCmzs/DG9NApgqgPy
 FFspsj7fC7ZstDyJMV6DwqeAwfy2/LYaOhaBKJbfhNNc0dP2JGor8m3srlnYsfykiJRU
 RNnkW1SehatgqPydJYNHcVDhdAW2ghnJs6dTtXVaNjcu+DWsaXx84oh8q+UjIRiJX/1W
 x25Q==
X-Gm-Message-State: AOJu0YzMuk5Hhagy075KdpGguwafe7+EOCjOfKOYKIdjbOs7VXPyeG1R
 im1+0fzqiQSNlH9YebHVtEnYtTv/c2hYpF93IHodG9/T/wGHHVFtD1pibpaKJy0=
X-Google-Smtp-Source: AGHT+IHl63GbZfjhE/92Nl9OOmlqdtmZS0UYj7ZuJng4xAioR/U1aKBK8asVyBJo6yzaZ6AQa+oFJg==
X-Received: by 2002:a17:906:378b:b0:a77:dd1c:6270 with SMTP id
 a640c23a62f3a-a780b688911mr1220668566b.5.1721038097904; 
 Mon, 15 Jul 2024 03:08:17 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5b7eb4sm198102266b.60.2024.07.15.03.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:08:17 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 15 Jul 2024 12:08:06 +0200
Subject: [PATCH v6 07/24] soc: qcom: cmd-db: adjust for U-Boot API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-b4-qcom-rpmh-v6-7-0c948a25d018@linaro.org>
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
In-Reply-To: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1904;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=bTTuKRxBXP5aXiwFaAEhLtRRXg5TW/UvCLhmytDgYzo=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmlPUFtF0QSNzCcQmzyK10IpMRj4+5pl3QRWNqb
 e/jsEPdgO+JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpT1BQAKCRAFgzErGV9k
 tqZaD/wLtT6L5J75nkLeTKZBXAwzzv20qKKBhAUgyL55U/jDSjlQ5cuiWSegaxfvgkXCSmSvAfT
 cDAq95ahZ/dvtgtsDeDpyFdol9FajWYVqMi3x4D2iTs2EhfSZcsvlH7Z3hYwFlfhJVquNfMInHs
 Dd7yN17IT599NsjnmktJT6D/+CSgm4zd+p/bMjoLSQZ/7AJ+M93zi1qNvRHTV8ct11YOOPxsf3P
 15ZAVzOqhVZsQNRNLQRjQCeLUKv4zFH9/a4Ow6Kn1nrz19w1sE3r+lLhmVokcUHH2Ura9hqeLsm
 mXYv6kBTWzi/hgryvGc3hylF/YO6i0J2sYDDF1vfIMNJTthn2JIrfqbyedlXrc9srz+h6Lp6M/L
 VJ7WeDyxT+GQFNdI3fvMUlua4p6QCwqob58ESqYGgzLOPhq+COk90GRvTKzm/xH4VLmdqEtZufY
 qcQ4ld5SLEqDKNx0jjC8X5sSTZXar0If7kfS4KSp/GIOypcz3zAINhXuyReKHgfIeNsI6E3VSmI
 sqh2aqSKxHjBGS9wUK/GtCkR9EZP5UNlgprkeui4fcubQkZoYoDf4KgTqwXaV4Mt4gG9unWyvQ0
 r912phoBxICOp7EJvzV34wBylRlaFmZEU7H4WcwirBH6HBigXuLBr62jzWOWGH1stTMwZGR0tkt
 MEihvyi/6wQWrCw==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
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

Keep the header pointer in the .data section so we don't initialize it
again after relocation, adjust cmd_db_get_header() to work with the
U-Boot API, and skip validating the header since all cmd-db users are
children of the rpmh-rsc and those children will only probe if cmd-db
initializes successfully.

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/soc/qcom/cmd-db.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index f707aed59adf..08736ea936ae 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -128,16 +128,12 @@ static int cmd_db_get_header(const char *id, const struct entry_header **eh,
 			     const struct rsc_hdr **rh)
 {
 	const struct rsc_hdr *rsc_hdr;
 	const struct entry_header *ent;
-	int ret, i, j;
+	int i, j;
 	u8 query[sizeof(ent->id)] __nonstring;
 
-	ret = cmd_db_ready();
-	if (ret)
-		return ret;
-
-	strtomem_pad(query, id, 0);
+	strncpy(query, id, sizeof(query));
 
 	for (i = 0; i < MAX_SLV_ID; i++) {
 		rsc_hdr = &cmd_db_header->header[i];
 		if (!rsc_hdr->slv_id)
@@ -172,8 +168,15 @@ u32 cmd_db_read_addr(const char *id)
 {
 	int ret;
 	const struct entry_header *ent;
 
+	debug("%s(%s)\n", __func__, id);
+
+	if (!cmd_db_header) {
+		log_err("%s: Command DB not initialized\n", __func__);
+		return 0;
+	}
+
 	ret = cmd_db_get_header(id, &ent, NULL);
 
 	return ret < 0 ? 0 : le32_to_cpu(ent->addr);
 }
@@ -213,9 +216,9 @@ static const struct udevice_id cmd_db_ids[] = {
 
 U_BOOT_DRIVER(qcom_cmd_db) = {
 	.name		= "qcom_cmd_db",
 	.id		= UCLASS_MISC,
-	.probe		= cmd_db_bind,
+	.bind		= cmd_db_bind,
 	.of_match	= cmd_db_ids,
 };
 
 MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Command DB Driver");

-- 
2.45.2

