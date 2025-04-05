Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9C1C36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 19:06:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2B1A82B07;
	Sat,  5 Apr 2025 21:06:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1743879974;
	bh=31hXHkdSrIaDNTb0zoWlRZZykubwV+BjN0Oc1L9tGfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sN5dlQooBAD0JNKDPRDNbvTtG+MBy+e+PDXvBZH/QSGpZ7io/W19zkx4Ey7k5W+oi
	 egU2KVPVnTuhhToN9ZAFtCoKzcz8GuRP8ZVI5KigUYz+kF+5wlwFRs+8ReNvX15Z0z
	 miy/o919AdDx7tvHB99VlQwPecgDqgYcSENZHns9+Domb78IEk/9CeTQTLYLb01ilP
	 BeIOeY0igCYbQ9uNJmkWXnwpLzkCuuTHIWZeb8+Gn5PMUr7OdUJkum8mKLegI1itG2
	 n5nZgx6TrrIl4DCPRA5Eu6tL4A6QOZWFm4dSPL7MVIHM0CB4Olvf9uAwXjWXYElTOe
	 OHK4nFDNX9F0Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7213482AAF; Sat,  5 Apr 2025 21:06:13 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B49782AC1
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 21:06:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="d5TpOHVx"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 89B7110253298; 
 Sat,  5 Apr 2025 21:06:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1743879971; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=31hXHkdSrIaDNTb0zoWlRZZykubwV+BjN0Oc1L9tGfQ=;
 b=d5TpOHVxp7rbApRF8VikSHJc5xHsoJ/CxcsS2fdUk0LgDX8CRDhk/L1aoPBzzXFks44/TC
 O0HvO2NRaUPW+1NHHYASOc7UKTElLjVdNx1wCs03fkez7CGo7WvEzCrlHeBsHz+O7H+gyn
 eJfkAdB4uMVhtzJBYej+M9IXA4nU4h54NSTRV7GC9WOdjn+6r052q8eb0mUSyJcHtq7ia1
 yRMJrxIFIke5gDrq8NUZQw/Zk0Uviq4cSPZDZmadDP60rvjFZKfaNoMve+ow1k4ploTWxN
 SdGR7TK+Az8ZgKFPognctNDa31jYdOukbGzi+4gslk8sECnwHyKqzVR9YRPzBQ==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 4/8] test/py/requirements.txt: remove unittest2 and
 testtools
Date: Sat,  5 Apr 2025 21:05:56 +0200
Message-Id: <20250405190600.24081-5-hs@denx.de>
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

unittest2 and testtools leads in:

Collecting argparse (from unittest2>=1.0.0->testtools==2.3.0->-r /builds/u-boot/custodians/u-boot-i2c/tbottesting/../test/py/requirements.txt (line 26))
  Downloading argparse-1.4.0-py2.py3-none-any.whl.metadata (2.8 kB)

which breaks pytest 6.2.5 with

  File "/home/uboot/.local/lib/python3.10/site-packages/_pytest/config/argparsing.py", line 381, in __init__
    argparse.ArgumentParser.__init__(
TypeError: ArgumentParser.__init__() got an unexpected keyword argument 'allow_abbrev'

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---

(no changes since v1)

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

