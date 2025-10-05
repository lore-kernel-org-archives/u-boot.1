Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9D7CCA470
	for <u-boot@archiver.kernel.org>; Sun,  5 Oct 2025 23:13:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DF2A807B1;
	Mon,  6 Oct 2025 01:13:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G8jLc8wG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C104680FA1; Mon,  6 Oct 2025 00:13:12 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0604807B1
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 00:13:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so26673595e9.1
 for <u-boot@lists.denx.de>; Sun, 05 Oct 2025 15:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759702390; x=1760307190; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VDTDxypqCBEbqPkv+h2eo24/zDgYpgXdy+++hLeSQqg=;
 b=G8jLc8wG5haqlzdycu0IITTxPiCRKTNLVWBqZ2FlzVt81Q2xRiOGRWtTBEDmwQgwgt
 xZmeEm8U9tKaByBk95JFsgMG0YadJaplHX9MqZzvlyNVgEMLD6OJqKpOY3MjN47b/9sH
 HkKQHljLSsQI8xlrmO+ZsAA7HuV5qUM0ntH7S6lRnRAMCRFu6scPbvh1lhx0O4MCLVLL
 AYyEB4DCQx+lLrE0ezR+IvvrWSRg75QLokIJFf/TL/DEkHfhinhjJHOY2I83MwXOElUa
 pV75yvYWji3naPVhuBrC455jSCD/gpxi0OBOg36Fzo7+yxPOtp7hcplxu+QMoYH2XJRO
 D2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759702390; x=1760307190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VDTDxypqCBEbqPkv+h2eo24/zDgYpgXdy+++hLeSQqg=;
 b=se24fXY48k4jy/ljuAGeSZcSOuurVU0AVTA0nJXqkKYr7uA/62His/bhgReCa6ZmWg
 tc21E3WHXqXN5X1R4KFD30QVn7GCQp4ywLxI9EPPCKHtfDFrBHJxx0Npw/hkj5j6eFaZ
 n6ID5V33HPPNyAxgAf5h8ZHCYCS0TMTrcOpMMf7Xq+uCB8hxtcNebhmLC6IBbsFZ574Y
 ZqmHYvcWFvaifiic+crsV6s/e97nENjVJMJxVkLHkoI47k6VklD0WUDLXe4VE6H8qBDJ
 IW8/kxKT5k9z5otYZgF3KVpRUxvbLmQNaySddcSve4n1u1+2Fxjcqel8j9PNfqIPTf9i
 nu+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzLXejtje7uuLLUZADKpFH5TgpAQ2bDQnnC79fJyE/J4BNGIBJRlok7IsavJWZP4X4acDUUKA=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2qKPmym7ED66o0iwHVpph6D0MebWdDkRLSuU1dk7yKbIsE+e4
 oBPTnzXkJZBw3dg5ZTbesyIt58xu5ozm3xoVDIsvAjMFI+0qv/DmZ+KA
X-Gm-Gg: ASbGncvPam/Mrx/mfF6qRoMsz6D2cVavZUAme8SeRBd7LbEZArr2IrsFaY8sWE5LCYJ
 dDndUQZsg25t/9T+a+TA+UaA02v0+4BscdPOJKLNhA7gU9Wsdkt91fHc2/1YqmxQ3ftsYo/6oPg
 QixKdGPG7rXTD9Yf9ccSPg2R9+Bncph3s8mN4AUAkmQf9jr7N3JbqHzPZqkTdyh+Q/AFqis+RVt
 ACs89NU3nUD6Q+6K6I7EQXiSbEw8nqLkzt4UBnepv0CUv5jOBrcQyABfL6HHxkx10iviqFXoCOj
 Ry9FK2DMA1trEA7D/7hm0ZWhWcjnhWaQw0roON74wwxFQoQdD3R97zngN84NJ36r5SljO2PA0kQ
 XWkWKlUQucTSvmwOGMsTazuVKSyMrJRNCofL3KIkcceN0isZ9Mk3w4Q==
X-Google-Smtp-Source: AGHT+IET9J24Z+VJYoDUG7yGpgDbOVRm9LwKAZ7tfDAA4EDmUsgUj+FjVeqVQXUXUPfCGM5kMDaEaQ==
X-Received: by 2002:a05:600c:37c9:b0:46e:4341:7302 with SMTP id
 5b1f17b1804b1-46e71155b8cmr62467875e9.34.1759702390062; 
 Sun, 05 Oct 2025 15:13:10 -0700 (PDT)
Received: from N580G.. ([2001:8a0:ca4a:300:ec0a:68da:a550:d9c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e72375b31sm137370095e9.20.2025.10.05.15.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 15:13:09 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Simon Glass <sjg@chromium.org>,
 "GitAuthor: Adriano Carvalho" <adrianocarvalho.pt@gmail.com>,
 Udit Kumar <u-kumar1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Andrew Davis <afd@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Peter Robinson <pbrobinson@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Chintan Vankar <c-vankar@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Garrett Giordano <ggiordano@phytec.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, E Shattow <e@freeshell.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 u-boot@lists.denx.de (open list)
Subject: [PATCH v2 7/7] doc: make pdfdocs: Remove redundant "-j" option
Date: Sun,  5 Oct 2025 23:10:14 +0100
Message-ID: <20251005221057.255029-8-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251005221057.255029-1-adrianocarvalho.pt@gmail.com>
References: <20251005221057.255029-1-adrianocarvalho.pt@gmail.com>
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

The "-j" option is specified twice which seems redundant.
sphinx-build's documentation doesn't mention the use of this options
twice. The "-j auto" version has been kept and the other version
removed.

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 doc/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/doc/Makefile b/doc/Makefile
index d0904a9f990..b37071b2803 100644
--- a/doc/Makefile
+++ b/doc/Makefile
@@ -56,7 +56,6 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
 	PYTHONDONTWRITEBYTECODE=1 \
 	BUILDDIR=$(abspath $(BUILDDIR)) SPHINX_CONF=$(abspath $(srctree)/$(src)/$5/$(SPHINX_CONF)) \
 	$(SPHINXBUILD) \
-	-j$(shell nproc) \
 	-b $2 \
 	-j auto \
 	-c $(abspath $(srctree)/$(src)) \
-- 
2.34.1

