Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D53C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 19:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D5CD801BE;
	Fri,  7 Feb 2025 20:12:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G3omXjei";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FAC180207; Fri,  7 Feb 2025 20:12:56 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 442DD8003E
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 20:12:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4678afeb133so33253881cf.0
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 11:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738955573; x=1739560373; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=QdCloZr/XEjHvpzVmd9PxghqZNyi6lQrm3VLygUu9Rc=;
 b=G3omXjeiW5BFSim8n0PKmCvgckoR4nkK1qpJwKWgZpuQxLfMlwhbzpWjt00DtmIJ1x
 Yfh2aQm9fZmY6qyRel6M0+T2n+8Zo2Co4MFJtBiA3abkShZzMJ+c7zpk+QoXJbRZ2lSJ
 TIArC9PF8U0IqLfrJklTmT7qHttHr8wSNSVAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738955573; x=1739560373;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QdCloZr/XEjHvpzVmd9PxghqZNyi6lQrm3VLygUu9Rc=;
 b=NgVI7ttuTqclCD9hZiIbKQPL1XHWpZWbOfOub0z4JHKK04nDzw3IiP8c0L8t7poy1J
 imfB+fz7+5lPRJsibtpUoBg64J4Eip18G61p4ODJsjSFm1lJgut8KbO52/t45LrSVjsW
 nvqV0vhH+lKDer3ExzWxFHRcKzIwbWdDVRzmQ0aEsgqdgTTfGPEl6Qzdsfvpcjsk1Eq+
 eFvTktePHgzthPTzGVipiIMABZEfXnnWesX13c1JEJsRhB0MXcii6WLaOVLsAQ11HzTS
 4PCrYEh3bxTI4Ff2UurAV4wrP+e5mmmI7wuKT+rxydzFOdracAA20L8B9ec4wqd/2Ajz
 JBfw==
X-Gm-Message-State: AOJu0Yy6fMV7IZFMOYD10aG1+o4XInoQS3UbOmdWoL0Z84D9ggvmz494
 nEhFHl+Q74P4kXtXBoPr4qGd5/Dh3XIfkbvIo6u8gZlDxnPrOk0ZayncoHsEbDB0PP5V+UIyw3C
 i
X-Gm-Gg: ASbGnctDnY8QzRf4cnRIiK2GrmYn9KY7Vz8k8hO2ZFHWcpc7qk0nL79rNRY5Pt9vDLy
 ZXYzZAUc98o4c1K6tj6jU//k3CpIf07Jc+5/HEYNXZt+G/kSYpiTYffTNHM5pvDfpFq4Vt7SCEf
 h1T8fZUO7qwbD5pUJcGStCN+jOBtpbotdtYAVhluqyJ4/+2YiLxoynacBWvgCx1jiT4Z8w/27JD
 +cu5qHlvWUT1AbQ/qUyIK7oC/ImwVN5ivoRDKDGOpNYb4cZpMQvdmrtFYHGfX1iRhjiQGWH/25k
 cArs8CcIBiH8Ogxldg==
X-Google-Smtp-Source: AGHT+IHnE5/luIZH9IUf/fbu8QSTzo3bjq/B+5B3zKbjos0RJ1oLm2UTWoSyXAX7trIbt8kwMEf6LQ==
X-Received: by 2002:a05:622a:1823:b0:467:5734:da89 with SMTP id
 d75a77b69052e-470337541b7mr138421201cf.23.1738955572906; 
 Fri, 07 Feb 2025 11:12:52 -0800 (PST)
Received: from bill-the-cat.. ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c041e9f506sm223595485a.71.2025.02.07.11.12.51
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 11:12:52 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] Azure: Add missing "set -e" to docs job
Date: Fri,  7 Feb 2025 13:12:50 -0600
Message-ID: <20250207191250.3173025-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Without setting the shell flag to exit immediately when a command exists
with a non-zero status we can have the situation where the htmldocs
target fails with an error but the job will succeed due to infodocs
passing and being the last build target.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index db471e67107c..bd197cd6e66e 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -89,6 +89,7 @@ stages:
       options: $(container_option)
     steps:
       - script: |
+          set -e
           virtualenv -p /usr/bin/python3 /tmp/venvhtml
           . /tmp/venvhtml/bin/activate
           pip install -r doc/sphinx/requirements.txt
-- 
2.43.0

