Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A8FC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 16:47:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07400885EC;
	Thu, 11 Jul 2024 18:46:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V7nWkY+a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BF92886E2; Thu, 11 Jul 2024 18:46:52 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C50188452
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 18:46:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52e97e5a84bso1591460e87.2
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 09:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720716409; x=1721321209; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=scgzXm1AFccc+odGtwAyR3nKXWaw45pRwxsCPyCBhv4=;
 b=V7nWkY+aXwJgioCSSljl3ghCcUUlJLQYKS+Ec2eWGwfc+c04zVpydQAVxkmwQGaXwM
 lYaIHrPBnJHuAFPEjBNL8WUfc3GZOzeCJaxlrBY84ZSWKBVvGKe097pMGGqVcm26LJkv
 SitY7JyDEvMzGVs/rl6kkQSFVKd60ruVxpMUyILbCcUAKAL7ihgZGd578aAhntkxpxRK
 Zf3IfHFP93/Pka9sO8WBg/JzcF3KY/O26/tx6Oaw9JrzsrC6iuPk0E/r+8XZhlALt2LQ
 7qe/804mlrEA2QQBdmzzxjbD3XRulxNJKH7GX/TkQYtDIKWkQYSACeBbrkEZs6pk9KBi
 barA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720716409; x=1721321209;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=scgzXm1AFccc+odGtwAyR3nKXWaw45pRwxsCPyCBhv4=;
 b=E35/WWIzz3pR13ffNOUR6gNqqmitr3AdvLy2Hfo2EilMZe6SdXaGKtKPW8hhCk6Xoy
 UW1gkl1ChphLwpkAunmxbEMEWPWxKE8bs82HTqA7nK/2S0wrsYyloSbDAgTxPecNebxG
 lyuBsRpuRkD9r5wv8kGcBgeE4UltyaHnvfORUC+aOUZCaAxVkfJ3JmxaZ30Q0S8b7Rf5
 MEMwMtN5V7QwkvSRek1ILh/EC6RU08LVU5FsGFJTLLETvjEYyD0RTcA0NM+AL/AV2TgU
 7sVyIouR0kuUOb15050ecl1e1J9hJ6wOiEoWBsPJZGLD39YBrfB+cU5BPB2/8uTn8pZp
 Tr2Q==
X-Gm-Message-State: AOJu0Yyad9Rn3ZFeq/jXJnQX8v+DZ+LlRVEBVOYJxgfZA+uv2756Q1kE
 kWgkjK9otn+OO6PuV5dWoC4LUtE+UtZXTUnHmdQWdZHYXzU+hRMX4QDAa1k72/eAgm5DLPfx51N
 W
X-Google-Smtp-Source: AGHT+IFvQLQ6HTPAZZENk84WBSG6NnmPB3RA6rZYP/XKw7O0STSCvkyiA90Et4A/LaUaRWXFNtc6Fw==
X-Received: by 2002:a05:6512:6c3:b0:52c:e10b:cb33 with SMTP id
 2adb3069b0e04-52eb99d2722mr7395538e87.50.1720716409474; 
 Thu, 11 Jul 2024 09:46:49 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a8545adsm268454166b.159.2024.07.11.09.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 09:46:48 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 11 Jul 2024 18:46:38 +0200
Subject: [PATCH v5 06/23] soc: qcom: cmd-db: adjust for U-Boot API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-b4-qcom-rpmh-v5-6-fbf04ce6a7e8@linaro.org>
References: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
In-Reply-To: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1646;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=TCF1Mvv0YTlcfm0lKGwE5XqQlDbsIfxOAnvqwxvsS9w=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmkAxu6IqmwSfHw4WybnRZgCCY+tUYlx5CUgnIE
 GqJBpr42/OJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpAMbgAKCRAFgzErGV9k
 tvLkD/9ku4STpIpxWQz3Os4rEOFUIN14K1+CbV0qrwj1lQrCVrffQ+W8Uqcsa/NrfK4CTVyV5DH
 b9WSFA4/GJbxRbfABBXWMZVJ1sefz7SwUznfk84KlRvBRbt1sa1ECuWGYgFHo/+3e2JPbL/Z6sP
 oplCxBJef01wC8AvhwlY6ogr7EhRobmoPOdVCq1DvNnd3bLERqxvQtmuZVBz4G1KzKTa5sAsy5I
 4a0z6QluvSJ4rRTZ7GZ9SA/oCVHnN0ynTNbxJIPvqy9we5zEtdISqV5hy5m27p5AD+9hy+zPVb4
 2AM+hUeuuuk1qVE1RT7Y8J+1Jon4yjKkN25ipmorzv5FyLBYUZPvw1mf9kLmWxvd22bAjzvcjdm
 eHR/CK9HNZeqD6xRfLpx/Sc4e1GAVrq4CkBuK83WCk/sJUleomif1gF3ADiECankzKrv0x99MiQ
 sd1iBN+MMQkhbjIh6LdvvPek6XrC2jpHBKTXR2pTEYycEGETDaS5iZ+svcZCQ79a9qe7sfVU8Ym
 lXbuDVmhFvSV+uEZk/92rSz7DM+jbHW2kw1JfiT2kh7b28YvRjZpAabsW2VyRb80RXwPTrfyME4
 YWny5OE9XDHJhNcxwKsWioYlQcvi0x+pR+dx/i7Py3gFSeLU1liLvGM9uNU8dl/f2wPdbGOsFho
 KEqsnkjMzS8I0cA==
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

