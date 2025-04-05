Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C74CC36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 18:47:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0402482AE2;
	Sat,  5 Apr 2025 20:46:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1743878809;
	bh=md2NIKsiDTT30AjtP/wo/uj0SVS8d5tbokd2N3958N0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GNpUPwvV4CF/RbCnizwM9mzs5IQrYoeuVoou1oyoAv+8616ALxpnTlx2DZDyJWSLH
	 W7+FDXd2Vr643ophBbZR4McAZvFgxhkwfJ3DYdskPbP2YnPqmWB4/WkSx9eDv7kFBE
	 T35Bo6HeGD9XRNieePSWp7S5lAQPFGLeh9RuM+QqZgYzSch6r/AO5kCEOAoc2yTxWu
	 rrdWQ0CSL4L8kxciKvnrgfEUSsxsRIOwx0dRPXFn5dbfqy1NGAaftNAK0GLqQRTF/l
	 Dlcw1Nq4dGkuEi+zyHuCz8rO7Yjf81ttMSgfy8YeSNOrQJAbrIBkbysLWPp+RMdyvq
	 q9OZc0ntB5HQw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1C3682A96; Sat,  5 Apr 2025 20:46:47 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0B6381F45
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 20:46:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="XpcYMRJU"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DFFF610252EFF; 
 Sat,  5 Apr 2025 20:46:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1743878805; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=md2NIKsiDTT30AjtP/wo/uj0SVS8d5tbokd2N3958N0=;
 b=XpcYMRJUO5yaqbpY6yksmNnL+sjRvc0ZWy4e8dHk+SLzGJjKIAAd99j5SRwhfYe1BV0rH4
 Q8L7GZ6usCWydgN5xZwnR113CS4Bd/1RtvP0gz7sxOM7HHKuUbLKwO97I9hQy3y6kShSGe
 fauigWqLgnDSTOtE16ppmaXNcZXc/3BJGpEU9nA3kkHrfyhWRDToFj7x5bV+WtYiTRElvr
 sKDd7SILeB7rzXweZLk9q2OfB3bp3Ae+xrA9VsjUDDht5b2swGGj4PKW2BG81x1VtoO8PN
 rtIHt5sKfC1vXvZVp4gRtHLVYCvQt1y4FImjG3smrVMOnak0DoCnPmo5B+4L9g==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@nabladev.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 4/8] test/py/requirements.txt: remove unittest2 and
 testtools
Date: Sat,  5 Apr 2025 20:46:22 +0200
Message-Id: <20250405184626.22377-5-hs@denx.de>
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

unittest2 and testtools leads in:

Collecting argparse (from unittest2>=1.0.0->testtools==2.3.0->-r /builds/u-boot/custodians/u-boot-i2c/tbottesting/../test/py/requirements.txt (line 26))
  Downloading argparse-1.4.0-py2.py3-none-any.whl.metadata (2.8 kB)

which breaks pytest 6.2.5 with

  File "/home/uboot/.local/lib/python3.10/site-packages/_pytest/config/argparsing.py", line 381, in __init__
    argparse.ArgumentParser.__init__(
TypeError: ArgumentParser.__init__() got an unexpected keyword argument 'allow_abbrev'

Signed-off-by: Heiko Schocher <hs@nabladev.com>
Signed-off-by: Heiko Schocher <hs@denx.de>
---

 test/py/requirements.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/test/py/requirements.txt b/test/py/requirements.txt
index 22315b4ed5..26412ac0b3 100644
--- a/test/py/requirements.txt
+++ b/test/py/requirements.txt
@@ -23,8 +23,6 @@ python-subunit==1.3.0
 requests==2.32.3
 setuptools==70.3.0
 six==1.16.0
-testtools==2.3.0
 traceback2==1.4.0
-unittest2==1.1.0
 wcwidth==0.1.7
 zipp==3.19.2
-- 
2.20.1

