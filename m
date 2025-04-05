Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF34C36018
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 18:46:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1B5982AAE;
	Sat,  5 Apr 2025 20:46:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1743878806;
	bh=khj4MzsUtOn9cZuGImr0ZhMBQE2Nnhn0EQFFXf/KLic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vSQlgJvFy083ulm6i95+sZFju4o4PaMrA5cS4oj6Fmh235flYS00ZBaJ9qysAEAkI
	 z0PFQrXWu/RWmzQxF49h3M7pmXicW65HQcWx13A5XLSnbjlRt+t6yr/wnnDdSABB4j
	 FpSFWlXxtmEtFJ1mZgzcjcy4SF1nA9Pd4UUc90+vvM0hRyj6456dLXO8+2ikjapaFq
	 czHT7iWYzFXAlG88hY/mQPgl9I0+9imaIgNqRz9ywzWzShEqzZPlkx4gJfLEh6Cjk7
	 /xIxov5iXV+Wof/3ULR+3muGZmDQP9xn/8bEGbGlOzBj/ATgl549Zg6+KEfsHvIPUu
	 yVNKp6UzeHW3Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7756782AAE; Sat,  5 Apr 2025 20:46:45 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8345182A76
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 20:46:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Ct/Y+3gv"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 39A9D10252EF4; 
 Sat,  5 Apr 2025 20:46:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1743878802; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=khj4MzsUtOn9cZuGImr0ZhMBQE2Nnhn0EQFFXf/KLic=;
 b=Ct/Y+3gvwVa5uMroUxvnyaIJg6sM8kaojo5FlJLcBhSDOVQrgK0I/SXyqpHtvoKNNGLpNN
 rX4S8eRqhTLtZB8XIbgIxCq2ElUkYeM9BQl3R/Y9gEFr2QF/jQP3CiWz93AZRfCFtQsTHn
 yX4WUqsJqabAKx0F9WA0ExC1u3oYiRaRgirBnAxSp+IEnzfv1d5syWBRppMJc0RRnMoz9A
 RN3CpM/0GwE6r+8IqP0CxR6tYxKDM/Pn/Z9AnK+ol0/mZMgIAtIYoFK50MDTBXIBYnWcNw
 VjroJuPlKqnWOTEUvtyjZqcLAgCoB6q5vMAfIV5iX5/DebAzoKpumELFJiDXhQ==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@nabladev.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 1/8] test/py/requirements.txt: update coverage
Date: Sat,  5 Apr 2025 20:46:19 +0200
Message-Id: <20250405184626.22377-2-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250405184626.22377-1-hs@denx.de>
References: <20250405184626.22377-1-hs@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Heiko Schocher <hs@nabladev.com>

-coverage==6.2
+coverage==7.6.2

Signed-off-by: Heiko Schocher <hs@nabladev.com>
Signed-off-by: Heiko Schocher <hs@denx.de>
---

 test/py/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/requirements.txt b/test/py/requirements.txt
index 75760f96e5..9b15e97f51 100644
--- a/test/py/requirements.txt
+++ b/test/py/requirements.txt
@@ -1,7 +1,7 @@
 atomicwrites==1.4.1
 attrs==19.3.0
 concurrencytest==0.1.2
-coverage==6.2
+coverage==7.6.2
 extras==1.0.0
 filelock==3.0.12
 fixtures==3.0.0
-- 
2.20.1

