Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788DDC36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 19:06:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A137D82AAE;
	Sat,  5 Apr 2025 21:06:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1743879972;
	bh=mSjum/gV01EbDkmitytL3cAF7NB2/iiGnjWN3q0OO0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y5D19fSUebNIzetB0aNumoTy6SHIrzf+7FFfdR51ThnplIce7z3gWT9J9LYUAUuWG
	 Bt3CkaDgx643GSms+s3/BZJreDL7w0TDgIT0UY1TEX3Y3ZxGYuF0+/e3165QqNYlQr
	 iV9XoOYR5Eq1eq6HF+gart615gTyO3RZIFfNhnvaLRaCSlnx+8x4PLLFRM+JLu0u3C
	 Upoq1NmWfzg4OjMd8eIU+YXy4nM3nv7dpF6G0BV6M7Vu8ENakKK/ZMB903fF83eSfA
	 hYso8Ss/i1OJUVU9GIPnWUxwIMVIfM695FuqIHcsugGwn8FSdn+7GB0Dl4dZbvh5pY
	 X8B8/+Cudn1IQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74F8B82ABB; Sat,  5 Apr 2025 21:06:11 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D8C982A76
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 21:06:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="KDKKHou7"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0A95D10253298; 
 Sat,  5 Apr 2025 21:06:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1743879968; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=mSjum/gV01EbDkmitytL3cAF7NB2/iiGnjWN3q0OO0I=;
 b=KDKKHou7zy4RJbN+/ffwiQIwiUeICaxK9bik3SRiiInS5NkCbTWnQxaFOyVFRR3rlh8yL6
 PcCOXlOw+IcNlHYkyWVQeezjQzD63kq0Mwsd9cvrkhp+LoW5Nb3aiuwCGSfzh+upT0IBgk
 rnTN0+1B9jsplCG6x/E/c71j3XEMwFDtr3WTK62SGfatwEC1xucVEXFbjwulnd6JaNXq6j
 FiexOAT60HLsGMW86p2EaVBhyxwDdgUr48OPY3KRfhq2zJLotBTgunZ82mMzJD2DeqUzOu
 KGKQB0c2lV9GvwLPQVzFAGvVrO+dJDYy7BjIpVtcmpT5jriqRl1hwXUthUpDUA==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/8] test/py/requirements.txt: update coverage
Date: Sat,  5 Apr 2025 21:05:53 +0200
Message-Id: <20250405190600.24081-2-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250405190600.24081-1-hs@denx.de>
References: <20250405190600.24081-1-hs@denx.de>
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
---

(no changes since v1)

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

