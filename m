Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F575C3DA60
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 17:41:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 873F988A7C;
	Wed, 17 Jul 2024 19:41:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="knZTRwhr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA69588A93; Wed, 17 Jul 2024 19:41:23 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAF0787B8D
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 19:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-25e171122fcso12528fac.0
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 10:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721238080; x=1721842880; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Lu9Y0IJYw4AWObisFhzC75yojGtQX/MLu9/CbDFib74=;
 b=knZTRwhrDHcBdjp/jeU5qcSCqQ7XWacpk25EvFgoCVnxmU6TZM9tujzn1Aj7ViOwfO
 RNDU26ukf089arOBdMI0uMwl8da3eW9de3wcwTKHBNdxD0KRK4L+kuk9zgo3OuqMD/gc
 JzvvS1ckgcnKRBjr6lrPP7ISMsEbE58RVOCsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721238080; x=1721842880;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lu9Y0IJYw4AWObisFhzC75yojGtQX/MLu9/CbDFib74=;
 b=F0KaMENPqy9nd/uvk+3KvYvBZFrtVOPfQIlr/wIEVPQPSTIWyRQYeHRKuMKAM3JebF
 z41F4k5oW+k2qAZsgbmNmgD3snVnBNeGGTL4rE0VQ1tZ5lQ836i9Uae8Piqtq2bQjn/H
 hvAw4LlmNOkbH0zKylTJsyeKrZml1JklFrxTDRJU7Tj7l1OLFtoqp3E0LroQ3Cqs77CG
 iLUouo96PrQCpY3L6IXqEVV4qwV5QA3RxImrWLZYhMK9bjy5+p+KYlZHTiDRVwv9HeUO
 muhRIIfnS46xjAwe5ma27Z7+OSagSIZ0vODUUUZ7EOZpIeAuVSu4YOn2u1BzySwXjh05
 xFFg==
X-Gm-Message-State: AOJu0Yy166Q6tH1fjwIefx974xoXv2xBO1NgZdNLafyQGBartYxrRu6j
 VWx5iq2Oe3qp6pouuuYa2N9K19tzK6xRnc1Pf+ahZAlU9Lq2hhdcvOFJSguC87gRoa4kEShrmZ7
 p
X-Google-Smtp-Source: AGHT+IHBgX0FKkOkecZeYHK52J7j+UNecVKPwkmscWbsEHNjCq0plC5ppcIyBVprwtcvetLB4WnEfg==
X-Received: by 2002:a05:6870:4599:b0:260:25ef:c5a0 with SMTP id
 586e51a60fabf-260ef0fc421mr27341fac.5.1721238080399; 
 Wed, 17 Jul 2024 10:41:20 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-189-203-103-45.totalplay.net. [189.203.103.45])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-260ee759636sm16339fac.29.2024.07.17.10.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 10:41:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Sebastian Kropatsch <seb-dev@mail.de>
Subject: [PATCH 1/1] test/py/requirements.txt: Bump setuptools to 70.3.0
Date: Wed, 17 Jul 2024 11:41:18 -0600
Message-Id: <20240717174118.845390-1-trini@konsulko.com>
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

There is some potential security issue resolved by upgrading to v70.0.0
here and the latest is now v70.3.0.

Reported-by: GitHub dependabot
Suggested-by: Sebastian Kropatsch <seb-dev@mail.de>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 test/py/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/requirements.txt b/test/py/requirements.txt
index 6d3030cf90cd..2b1489808c00 100644
--- a/test/py/requirements.txt
+++ b/test/py/requirements.txt
@@ -21,7 +21,7 @@ pytest-xdist==2.5.0
 python-mimeparse==1.6.0
 python-subunit==1.3.0
 requests==2.32.2
-setuptools==65.5.1
+setuptools==70.3.0
 six==1.16.0
 testtools==2.3.0
 traceback2==1.4.0
-- 
2.34.1

