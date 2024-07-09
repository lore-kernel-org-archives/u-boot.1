Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156D2C3DA42
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 09:36:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE90688579;
	Tue,  9 Jul 2024 11:34:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vP63pJd3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CE6087EBD; Tue,  9 Jul 2024 11:34:56 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43409885D1
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 11:34:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-58c2e5e8649so8779568a12.1
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 02:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720517693; x=1721122493; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JVqOD8ycqWq7Q7oeWryEnvkwn/+zmqbT0+3zsbessWE=;
 b=vP63pJd3qotBpFr0Lopxnrh7lkfB2c37fuE1o8LcHeP9+LxvVwz5RDHLdS8qcvSJkM
 gI6Eflq0Jfj4fEYnhkaC+IMRX2LWHFA0kD5Rd8OTx9xLWsHEjvJdlIlg8gnWp6iTXE/H
 Fx6/vrgea1SckQ9HlJcjkZvwwnzJX3GeZTaZHOemeZh5cJQUZHIcSbZKgxQtIBnxFiMR
 fU2grqAvIEs636RNlTWlM6fqZwyj0PJ+Mfz6/JN+qpv9sEl6LOUzXBmXhxau4DH7wXE4
 gbH58RdrcjBc7I+1GQ1/P6Y0ZRgLmKcawfMfnDZJdy3Na8PtfWUOlKaIfjb4SRSxfaDm
 SUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720517693; x=1721122493;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JVqOD8ycqWq7Q7oeWryEnvkwn/+zmqbT0+3zsbessWE=;
 b=bjGWwV72T9UGXBhtCkaihqlk6MiHMruOaDp97YxdCCYhqmgykZ59mITYHrJn5hjx7z
 w3Kg/K7jbEO0ceBl725UmnYLFBUkTU+mLyJMDRxeLauxVNI0SAUQDEWWi6MwFIf6hGUH
 Y+37jQIhnmLELHFrKw52c0MV5q4UZjX+wZDmmIuBW+uPM49S2zCpKhKKwORpyF9/Y/JF
 dUmSkgJ7dfPtTveVIV1WPqLtu/OrGRl/k3paUdKzuCPowYqiJSVSYl/kTbXhc18rkwBx
 anl4AVxggklIeE2up0BRJxpo9S0W9pnvLqYDOjTYCh1X64vp8IIMhg0DXMeOY7g8Vsee
 J4yg==
X-Gm-Message-State: AOJu0YxV7MIxS0jwR2XP9OB9FOfRsvLjg8RLQmARqmvHIJPVIP9I2E9M
 UEy5wuMYxTz9M/79+/lNhd8SjKA9vQlKuQ6VlyL7ma7lDvlss2c6cmP/OLvPGt4=
X-Google-Smtp-Source: AGHT+IG6QOd7uOw94V6/Qfy9lfyWeMTsSOxcHjy9AS+3udEsLupihFfkAQZFlaEt+2QCJ+ya/O5l0A==
X-Received: by 2002:a17:906:e207:b0:a77:c051:36a9 with SMTP id
 a640c23a62f3a-a780d22e23cmr119052966b.9.1720517692772; 
 Tue, 09 Jul 2024 02:34:52 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a7fefaasm62884566b.140.2024.07.09.02.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 02:34:52 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 09 Jul 2024 11:34:34 +0200
Subject: [PATCH v4 06/21] soc: qcom: cmd-db: adjust for U-Boot API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-b4-qcom-rpmh-v4-6-c06d0a26644a@linaro.org>
References: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
In-Reply-To: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1600;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=X51XRfiFyoAKRpgKqEsBH4aP1WI04/A+0VKgW+JBMI8=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmjQQzGjQ7vJtexevEwLbE9fXgpjHSARMB5ovNn
 rHCG6IhOfmJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZo0EMwAKCRAFgzErGV9k
 tq/zD/9aY/NQHbKeB4v2GBbWLq4zm3UXRUZs3FJL1MTjK7u+JBpVa73qysOipkSa5lqPozw5JX7
 WGV+XMRAt6PKFDd4nyUEGWgyOG5t2p/yrnnkoags4gtJy852BbHLB0DbbqV9GAvJCM0JWC7quUG
 i2MadN/Ri/aSysNRbER5uPwkyHOzur4eABB9YpgyTEJuWrF3A15UhM9UbTBJ3QxS6p91YprkwUd
 l70CWuU4xDk4N+WeNNOBudnHBgjc4QOq9L4Dt9Cjmhls7G/eF7Sk4Xcu7TdQ7cyYyQLEl5P19Fi
 vsTjq1KugqlA75BY7LB4fWjHjvgTS8Lp4vmNwbOJ1M+ApAw0HBKkWXLtM1lTrVIkT1cPTEjF6Q/
 owmaLYPUsH0Y2NgGXUnVGFGVvmqJF+RRL25E8PJUFLru/LYpqdzkdunvrLtRXeedrB7yFvi/Fl0
 Scp2q/TCZmv4Lrpeu6FL4Xk5weeiRgPCMUYPsBaPF3QLa1hfNUTz1+Z0JQyZBRM44xDBxAzKU+L
 HXnmRmxWfrEOaTU7LVY34ZkHc++kYtRHb4pOYY1lxI1f6XDcp3Xphy5bq7rfB9Fwq0gg0uO2T3X
 wGgLcA/2TcrJMWO1NxhDuuEEv2Xhtk/bdlwv4ndsq7dZqT28IEuExb3g0Ep0MCjFx5Ha0ujAwNF
 O6hocsfefn4Svjg==
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

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/soc/qcom/cmd-db.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index 4d3fd4db8852..b852a269ae12 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -104,9 +104,9 @@ static bool cmd_db_magic_matches(const struct cmd_db_header *header)
 
 	return memcmp(magic, CMD_DB_MAGIC, ARRAY_SIZE(CMD_DB_MAGIC)) == 0;
 }
 
-static struct cmd_db_header *cmd_db_header;
+static struct cmd_db_header *cmd_db_header __section(".data") = NULL;
 
 static inline const void *rsc_to_entry_header(const struct rsc_hdr *hdr)
 {
 	u16 offset = le16_to_cpu(hdr->header_offset);
@@ -127,16 +127,12 @@ static int cmd_db_get_header(const char *id, const struct entry_header **eh,
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

-- 
2.45.2

