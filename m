Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A0AEEAA7D
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 00:25:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B64C86A3A;
	Fri, 15 Sep 2023 02:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hLYXIrIV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C66286886; Fri, 15 Sep 2023 02:23:02 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B23D86996
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 02:23:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7928ba24936so55856639f.0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 17:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694737379; x=1695342179; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MzaDUBeU36MWB7q4QzHr0PJVHDoOPYWWkILJFGKh+gw=;
 b=hLYXIrIVMjetLLeUQfGApxWUDC4zxGpLsX0MM5DXpObhTIJqXXziOSnZp72Y5pY2R+
 T8oPS3KXBAGOvXZfctokpNbeLg07ferS1BuRkx94UYownRcEnT2Gytffd1QsAJcdekcN
 ddmzwkSPnlJTzDl29E6w9xLuktHS798Jtz1BA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694737379; x=1695342179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MzaDUBeU36MWB7q4QzHr0PJVHDoOPYWWkILJFGKh+gw=;
 b=KK0iD+JGawzoZDega8Hc7vojpyIeqYLEBLt2DFGVQCpw/yEiGTC/cnDEwVd/k+rnc7
 7CPylaZ5Hhd6vNFbNHgLbIiHeY+shlzbxT1t1JWfwqjUyOJ/BqTMff8yEYWwL9iw2nlk
 U8DTpKbyynkNzwSuy1OPzfIOHDKtazdZ4NO6ROOs2jL9XjBai0HSttH3pSoVC4R3O0aP
 Smst1XYbGlR4jSwsaZixJF2FDBDuWGk377ON5SF2cCKqCAXm31vfZhtuI9Du5IqTGU2E
 vxkPXiTth5xH2LeTOY25YYuolQKQ+ypBEe1cFWu1zLbcdym0a6jRClXD5amHQaa4edCa
 E9Bw==
X-Gm-Message-State: AOJu0YzGDTcojgTasU6rrTP3WIFd9t86qk1S9QRcv+pIyKAqTwqbxRQ+
 SdruijreZnOrQptqKjI499nOdgB2qo7jDUS2CNY=
X-Google-Smtp-Source: AGHT+IECn8SNaMNsVVot32d7XBL1soOrXhjCu9ZHUVmQMuliocrXWNg7qQv+fpjLvxrJAJ0pHtZnLQ==
X-Received: by 2002:a5e:8716:0:b0:787:1c51:ff99 with SMTP id
 y22-20020a5e8716000000b007871c51ff99mr63882ioj.11.1694737379076; 
 Thu, 14 Sep 2023 17:22:59 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 i23-20020a5e8517000000b007836e9ff198sm744796ioj.55.2023.09.14.17.22.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 17:22:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 15/27] moveconfig: Use an encoding with open()
Date: Thu, 14 Sep 2023 18:22:17 -0600
Message-ID: <20230915002236.798760-16-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230915002236.798760-1-sjg@chromium.org>
References: <20230915002236.798760-1-sjg@chromium.org>
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

Fix pylint warnings about needing an explicit character encoding.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index d46433c6d8f5..9b716596956b 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -1457,12 +1457,14 @@ def do_scan_source(path, do_update):
 
     # Write out the updated information
     if do_update:
-        with open(os.path.join(path, 'scripts', 'conf_nospl'), 'w') as out:
+        with open(os.path.join(path, 'scripts', 'conf_nospl'), 'w',
+                  encoding='utf-8') as out:
             print('# These options should not be enabled in SPL builds\n',
                   file=out)
             for item in sorted(spl_not_found):
                 print(item, file=out)
-        with open(os.path.join(path, 'scripts', 'conf_noproper'), 'w') as out:
+        with open(os.path.join(path, 'scripts', 'conf_noproper'), 'w',
+                  encoding='utf-8') as out:
             print('# These options should not be enabled in Proper builds\n',
                   file=out)
             for item in sorted(proper_not_found):
-- 
2.42.0.459.ge4e396fd5e-goog

