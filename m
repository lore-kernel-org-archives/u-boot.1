Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6B7D6ACF7
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 17:24:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 676978980B;
	Wed, 27 Nov 2024 18:23:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nx5E+X3C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E6F989817; Wed, 27 Nov 2024 18:23:10 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76FEA8958D
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 18:23:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b666215645so176382385a.0
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 09:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732728185; x=1733332985; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4d9zKiG9lJgrJu2wdkiWYeM0JLpgVIeclL+/CY3kJFU=;
 b=nx5E+X3Cxx+b580/3FkWU0pqbOnGtyuo3FtX+NLkxU9nX/SNB3N+JCTKlGfQKso6aq
 vZPJCht60XvUqLqtHKHEsBr11gsJ/fMxYi7u9+z10AsTWZ0R89iAcJcClrrGJPA1YhS2
 PmaG8GP3FdaVzJm2xmLZKw6dJI7VZDeDuqR8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732728185; x=1733332985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4d9zKiG9lJgrJu2wdkiWYeM0JLpgVIeclL+/CY3kJFU=;
 b=KSzpTkFnjatHPA6F2MVWAg9H+ivorkuDv0AKt2Hnzu3ZUlbQ9Ar47gNY/UNeKBkTIo
 TsGsq2RrNPmn0i3vbgtrF/3hLlyywMHxLRkKtAtxq07DrKk8JRqrx5sPPrbjupbmoPGY
 rSHNytmWe1IWX3+soUXvIOQxGR8lI/XgebbooiwMkWrEk1Ueeif6BpUCN9K84zGTpfSA
 lAig0Zm8gXVYS6p+YoUaAasQkljnDNd4DJDXO1yWFZKXTSK1Nh7UorN17Y4cwJM/nTH8
 lsJXZgxSLJ0SOzCQ4AQTOKlu+IuVpi+hlqUTeUl7V8MslmyPeGV5mVV/afeK6/uJIL71
 gUhg==
X-Gm-Message-State: AOJu0YwTCuhbE8anCG/lk4RPxp51LCiBALlbBfVZNsmnxMZTKIXkSa7h
 9nNafm0EwEDZe4q+CR6UAW4KdvVMlHoHCJNJJsWOXDgbhUoltOS4S3H9Hir9JeHJDFrtHaOdEcz
 zt8s=
X-Gm-Gg: ASbGncuR1wnsiDfiVaxS7LELT4X8ssONLmf0f7w0f/2ihnKsEkjf0YuTri+Li98QJUh
 JovfWep6lWxYYopvGDGUGO0yYYJWW9/2FZWTV4XJ9scvjfTE3ylfOS8kfk+TUHmdkY6uQ+rY3rc
 JsRkgloMuLJENXbvgOZP/1zbRUDv9x2Vqkz7m06HKEkgz3TChloqT3uKYJXZmx6PuiNPNDr7H1F
 hMmlMoP8Q5Z+gtRr2PsVmcF8BgcnYfTXunUyKWo/KA9UdLsznpGiVAFwgGcXs9AHF3ZXCQE
X-Google-Smtp-Source: AGHT+IGLIeFgYNq7Pio8bU/e5uJ+c8xRDFZfoe21vysiiIhCHR0p6crJBAH7rpXDlVw5spUIjp1NOw==
X-Received: by 2002:a05:6214:27c1:b0:6d4:254f:1c8e with SMTP id
 6a1803df08f44-6d864d9421cmr54148886d6.37.1732728185447; 
 Wed, 27 Nov 2024 09:23:05 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451b23e25sm67160976d6.89.2024.11.27.09.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 09:23:04 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [v6 10/12] docker: Fix LegacyKeyValueFormat warning with PYTHONPATH
Date: Wed, 27 Nov 2024 11:17:28 -0600
Message-ID: <20241127172247.1488685-11-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241127172247.1488685-1-trini@konsulko.com>
References: <20241127172247.1488685-1-trini@konsulko.com>
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

From: Simon Glass <sjg@chromium.org>

Fix a warning due to the syntax used for PYTHONPATH:

   LegacyKeyValueFormat: "ENV key=value" should be used instead of
      legacy "ENV key value" format (line 304)

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
Changes in v6:
- None
---
 tools/docker/Dockerfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 5d3bd4e24ab5..9d10de5b8926 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -315,4 +315,4 @@ RUN /bin/echo -e "\nx86 = i386" >> ~/.buildman;
 
 # Add mkbootimg tool
 RUN git clone https://android.googlesource.com/platform/system/tools/mkbootimg /home/uboot/mkbootimg
-ENV PYTHONPATH "${PYTHONPATH}:/home/uboot/mkbootimg"
+ENV PYTHONPATH="${PYTHONPATH}:/home/uboot/mkbootimg"
-- 
2.43.0

