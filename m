Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52710CCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 09:56:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C825B8352B;
	Tue, 30 Sep 2025 11:56:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zbVglu+c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8CBD83544; Tue, 30 Sep 2025 11:56:08 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A482E83526
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 11:56:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3ee12a63af1so3742674f8f.1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 02:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759226163; x=1759830963; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2i5YbkKpbNJR7US72fqjjCX5LbGr4zi+/HydIu0AeCE=;
 b=zbVglu+c0jjdVxwMg/uL7JSt2krDteknJpgj0bX5S7W4FQms7DN1QI9dALMczjJ/Gd
 sCfFsXYypYdjTyhwsPgaFQjNT4f+dr1lZ2X139MzeTapgSuvjSWaRRcNzMh5BAQBNNHa
 MoqajuIcj/5k3OcpzrpdFX9JevlZ4bXlYFwrO9WILgpUoEwgZWRsgxF7ZqCw46zO6Dt3
 rdLhE/691ueratt8WtE3vu7olLRtrQlb4b87VqoeT4W0ByQyB1DCva5SpvqEW+7Ua2Yr
 CHyLytdwGjmrpPzFSWJvyNEoJXyNUC/tyzAtcM5EgjZHu7T2MOytzULLuEEKi+2oCYxX
 7Pig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759226163; x=1759830963;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2i5YbkKpbNJR7US72fqjjCX5LbGr4zi+/HydIu0AeCE=;
 b=PjgGJucDsdjAavfymYL6bm0CRSQJzpw87RAiClB5FWvuxJKgH8OiJlxHSV/Utd6apm
 2bJ8U18FOuIVlaUz/NHpj8S9w4rKG60253a37aCeMMIVbB7XZ0bJ26NVo4B9L4Ae/2Cn
 PgZBAN9mCNJ6w5kvO9u7FGjjUnu3PtQSh+8kfQQgTOC5i5/NDytR9tHIjRB/8YgTx+/T
 z+xN5FDg3Ji3sLgOBAOslZVqinLP5LOvFdOqqKwVVQhb4pmVDLxptvRlpmuPKAYEE1nd
 SsCA7tGQCvq2GaSAfrpQUKSlMgVCjBs7tDaBWu1dSDjIll/SFzWZ9BDsUeordErf/lkZ
 8VSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWydIhBL0WUgBwSRXDbw4S7qEJmybstr0gtUvWnMbyAXlD1JQUfnQyjTMocZ1Ko2wMuw/6FmOM=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4Z2J89h4NiPnFC3I77lmW05Lf6WvoupNHsRYlkdx4xp5JvcCK
 0i8aiKrLgLBc3lUgFB0BPbUGd9IdBKeJQBTPwMuo8MKq7J+nGQUfgctkHE90De/rwoU=
X-Gm-Gg: ASbGncsB9sja0cz2O/X/VB1A1XnSHeliRtf6pSGjjHwGVwykJcNuww/Ky4YaiY08Ozz
 8wG2CM+nUiv0frtGEBJAbH6Gu2zQcJkvvJgE7bKoYLC6ieGs2MOo/6wQpW0rdsxW06tx5JbC+fy
 Q3XGkl76BGD3M1edhVxj0T5Qvtigk9V7/UjxrppNYjbMZcz+cNbZsvdTphozPWF0puSK0zoSmAy
 TH5RXGPTJPldM4c2RmDOVf5IbUPYYshBa/sdTehINehSAnVJ9vaJLx/2wgYoGhVutYeV8kQ/n8e
 pqCtp9L+XdYuC3Z0AdrkUVKwqM1cq+BipsNYDvFzslC6mTt6qwFNzkZ3hUvdnBtiD6f+HGJeF1p
 xzK0iw4q3Mei6hERSPggKFqClmb9tmMLpSxwljJtsglaRVfZpNxt6Kpr7ytSnliLDIQS8eFzCMA
 ==
X-Google-Smtp-Source: AGHT+IHjtvhgKNP9YnFr5ec1IlZbCh/mqFsxKSa4eH+hVPIELqMIqz8CZZYDTfq4RHb/++pj6wAmsg==
X-Received: by 2002:a05:6000:430c:b0:3ea:80ec:854c with SMTP id
 ffacd0b85a97d-40e4745deb2mr15941310f8f.19.1759226163085; 
 Tue, 30 Sep 2025 02:56:03 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ebd:e301:aed:2018:ed42:d786])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc7d3780asm21986016f8f.52.2025.09.30.02.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 02:56:02 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 30 Sep 2025 10:56:02 +0100
Subject: [PATCH] usb: ohci-hcd: Null check lurb_priv before dereference
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-usb_ohci-v1-1-9efa75e71885@linaro.org>
X-B4-Tracking: v=1; b=H4sIADGp22gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS2MD3dLipPj8jORMXROjNDPDJCMTY8vUZCWg8oKi1LTMCrBR0bG1tQB
 a6fhNWgAAAA==
X-Change-ID: 20250930-usb_ohci-42f61b2439ec
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

When a variable needs a null check before it is dreferenced ensure that
this is done even in the case of assignment on declaration. This was not
happening for lurb_priv so correct it.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/usb/host/ohci-hcd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 234a6f3645d15d72f93eda2ca6945fb16aaa9adb..1d6711ccec43cfd40f6a1e066035089222fa8ebc 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1040,9 +1040,11 @@ static void dl_transfer_length(td_t *td)
 static void check_status(td_t *td_list)
 {
 	urb_priv_t *lurb_priv = td_list->ed->purb;
-	int	   urb_len    = lurb_priv->length;
 	__u32      *phwHeadP  = &td_list->ed->hwHeadP;
-	int	   cc;
+	int	   cc, urb_len;
+
+	if (lurb_priv)
+		urb_len = lurb_priv->length;
 
 	cc = TD_CC_GET(m32_swap(td_list->hwINFO));
 	if (cc) {

---
base-commit: 9710d98e8942151fc0c62d54100d9d27e8263d04
change-id: 20250930-usb_ohci-42f61b2439ec

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

