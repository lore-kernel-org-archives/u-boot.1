Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8B5C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 00:06:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84FB886FE8;
	Tue,  7 Nov 2023 01:06:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lllkGs7/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E0C18701B; Tue,  7 Nov 2023 01:06:10 +0100 (CET)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0BAB86CB1
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 01:06:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5b982ba3604so190846a12.0
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 16:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699315566; x=1699920366; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TLZGFZEZKIkpx/JXLOfYq15up/+MQMxqu143WlDu9/c=;
 b=lllkGs7/1xL/xJlO311LO3UmDGMjUCDc1//ukCxlT+qyU4ciwMgyT8ISUUsllKI80P
 LHPNEkDNFhIpB0AFyjy9woEdcaq3Z8u3keQhBMkDFMxtDfYAeLf0debsAunHmEWGt1jP
 4l0Jy6OTmMnCJf0dR+m40Rig62Qik+ISB+bq4lGNl8B/H5ibAZilmAN6kbny9IUeZweF
 8Rh9LdU4h7brec3kVuU/+ztDQHmGmh2B8K+HZlM10aXGpi1cKZqVCyXrcyS3NkGDA7l7
 syMOPCi86M3uII3vW2y7qTpChKaqO/fI+NamySChj/b08kpqlEy33I4SNYRf4VLq3I1V
 Sung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699315566; x=1699920366;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TLZGFZEZKIkpx/JXLOfYq15up/+MQMxqu143WlDu9/c=;
 b=g5R0YsydySM+08/Hhn0jBSRN4Rf437DPY+319G0Mi+8LEqxE/0xlgOuNA4MNSfsQCM
 6BE6lDLzH8z9tk+A8jfsaDpcggRXTt4SUUMLCgfQSSvMc3LzAlS5rt9nZIv+PfL7DNwG
 8DkHS3Pdm61UsgfyZQqdislrtNr5LcaveGNx0+f1kgcTMXi8TeFIQwaCby40A/tZzRns
 KKLWpJgwlekMze9ZlnHly5YFJEuPCXAqDSVwjbw4RfJnTmznp/RNbV9zXE/7iJ1BUIl/
 AKN0LHDaaAArMYLrxxp3BkalZcZog8Jy34t5drAHLNHqThK3PZNG97PoCDAshrN1Y7w8
 Fgkw==
X-Gm-Message-State: AOJu0Yxcpwyohs/0wg0mOWpILRXxAWjz5N395PiNTh0gIRSmq/5yedgB
 Macjjign69tLkYweIxBZchwebuy8P7pM3m6Zc21rLQ==
X-Google-Smtp-Source: AGHT+IFUfyzfKFOmZrIc8OC595LrKdu9mtgg1AyXt/afMTg/ibYwu3eqCT+XOCsmtnMn8B+8/xIGfQ==
X-Received: by 2002:a05:6a20:e687:b0:15d:f804:6907 with SMTP id
 mz7-20020a056a20e68700b0015df8046907mr34674583pzb.0.1699315566046; 
 Mon, 06 Nov 2023 16:06:06 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:2624:f827:e7fb:10a7])
 by smtp.gmail.com with ESMTPSA id
 o187-20020a62cdc4000000b0068fd026b496sm6377573pfg.46.2023.11.06.16.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 16:06:05 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de,
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH] firmware: scmi: correct a validity check against power domain
 id
Date: Tue,  7 Nov 2023 09:05:47 +0900
Message-Id: <20231107000547.182072-1-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

A power domain id on sandbox should be in the range from zero to
ARRAY_SIZE(scmi_pwdom) - 1. Correct the validity check logic.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Fixes: CID 467401
Fixes: CID 467405
---
 drivers/firmware/scmi/sandbox-scmi_agent.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
index 9f5f497e0a6c..d13180962662 100644
--- a/drivers/firmware/scmi/sandbox-scmi_agent.c
+++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
@@ -576,7 +576,7 @@ static int sandbox_scmi_pwd_attribs(struct udevice *dev, struct scmi_msg *msg)
 	domain_id = *(u32 *)msg->in_msg;
 	out = (struct scmi_pwd_attrs_out *)msg->out_msg;
 
-	if (domain_id > ARRAY_SIZE(scmi_pwdom)) {
+	if (domain_id >= ARRAY_SIZE(scmi_pwdom)) {
 		out->status = SCMI_NOT_FOUND;
 
 		return 0;
@@ -613,7 +613,7 @@ static int sandbox_scmi_pwd_state_set(struct udevice *dev, struct scmi_msg *msg)
 	in = (struct scmi_pwd_state_set_in *)msg->in_msg;
 	status = (s32 *)msg->out_msg;
 
-	if (in->domain_id > ARRAY_SIZE(scmi_pwdom)) {
+	if (in->domain_id >= ARRAY_SIZE(scmi_pwdom)) {
 		*status = SCMI_NOT_FOUND;
 
 		return 0;
@@ -653,7 +653,7 @@ static int sandbox_scmi_pwd_state_get(struct udevice *dev, struct scmi_msg *msg)
 	domain_id = *(u32 *)msg->in_msg;
 	out = (struct scmi_pwd_state_get_out *)msg->out_msg;
 
-	if (domain_id > ARRAY_SIZE(scmi_pwdom)) {
+	if (domain_id >= ARRAY_SIZE(scmi_pwdom)) {
 		out->status = SCMI_NOT_FOUND;
 
 		return 0;
@@ -686,7 +686,7 @@ static int sandbox_scmi_pwd_name_get(struct udevice *dev, struct scmi_msg *msg)
 	domain_id = *(u32 *)msg->in_msg;
 	out = (struct scmi_pwd_name_get_out *)msg->out_msg;
 
-	if (domain_id > ARRAY_SIZE(scmi_pwdom)) {
+	if (domain_id >= ARRAY_SIZE(scmi_pwdom)) {
 		out->status = SCMI_NOT_FOUND;
 
 		return 0;
-- 
2.34.1

