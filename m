Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99B6C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 16:27:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF70A875A4;
	Tue, 21 Nov 2023 17:27:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dNNFqikS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8916E875A4; Tue, 21 Nov 2023 17:27:46 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8994F8746A
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 17:27:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40859dee28cso29561225e9.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 08:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700584064; x=1701188864;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Db8/nsVHwKw+NzLLtvfgULed7pDNHXmN1WACJyufdN4=;
 b=dNNFqikSzUCgwFf0bFVW3mde8/zHVftVg+ZZ6IqLV3clxlW7F0QQT6lBLg4NjjB7Yq
 RQgdCdACT/ujuPE1r1gBQ7TGJWzTelxQBzZVoCH3B0h6G0a7sLqwjLFir469mvTvz4Fh
 LdbJbZ1XLSikXsKuuiJnYfX2NLiIoTxIspko8Zd2Im2YarpLlNce3deakzWejeSz9a73
 7DHOATKQEr2c9eXDZN8SQoTWeEfHfGsDMPTT81uFNitBB8rltXeRgDcibU/wkKGS8ZWh
 2lEfhp63LJMFQMamgKbx1ba9iF09h4toWPbtxeUmyv8O1O0D+bMWYJBkyzP1m+Ye9INm
 SPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700584064; x=1701188864;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Db8/nsVHwKw+NzLLtvfgULed7pDNHXmN1WACJyufdN4=;
 b=jN2u0lSeZKnB8oHc9RzvYQeiwY5n7kfUZBLNXJEIY338W/9g5Sp2KMBBCy0qwSinQr
 hMbd5DWWdVfV2F3jryrinLOFpoFfG3SKBvCjLHXnv1sjRlbeEVcdwG0MKwJ/HWg2am/N
 BAOmFWCFMwkE707/sjxwJl6eWK1ZKggHX6fjy7Xwn9ENn2w8VwiC0lMAZAWogOG/OklJ
 r1VOtiT8hk+BgQhZnqovfAypiAQKezcAyUTB4q63R1O8M5tq7oxElDKyUEia821Ekm2v
 YE5doH54NBV0ApqPvYHriHJa9865LZWQARgyonZoOzcGb+mroZfc0puHelUf+N+AZE7I
 BNoA==
X-Gm-Message-State: AOJu0Yw78TT1vDgD1w+T7CUVrA6kSzTkul+GxEjemiAmEw3e4me0NvCf
 auNiNPdXIIe6q40Nh+3bfhM9Cg==
X-Google-Smtp-Source: AGHT+IFoqHsEvk7tlQyX9K1MPfTNWSskkf9z2PcXtXnPHwaR/2UT3nerl6P7g79s3x40UIGqdhDt1g==
X-Received: by 2002:a05:600c:4f07:b0:40b:2a69:6c37 with SMTP id
 l7-20020a05600c4f0700b0040b2a696c37mr1607228wmq.4.1700584063845; 
 Tue, 21 Nov 2023 08:27:43 -0800 (PST)
Received: from [192.168.2.81] ([82.66.159.240])
 by smtp.gmail.com with ESMTPSA id
 t14-20020a05600c450e00b003fee567235bsm22371455wmo.1.2023.11.21.08.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 08:27:43 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Tue, 21 Nov 2023 17:27:38 +0100
Subject: [PATCH] doc: sending_patches.rst: s/Superseeded/Superseded
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-doc-superseeded-v1-1-dfeb0c3549c3@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAHnaXGUC/x3MMQqAMAxG4atIZgtNRQSvIg7S/GqWVhoUQby7x
 fEb3nvIUBRGY/NQwaWmOVVw21Dcl7TBqVRT8KFjDuwkR2fngWKAQJwwVu/7KMsAqtVRsOr9H6f
 5fT/6+UD2YQAAAA==
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.12.4-dev-6aa5d
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

This is a common typo listed in scripts/spelling.txt. Fix it to match the
patchwork status, which is superseded.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 doc/develop/sending_patches.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
index ba73d0d11b46..5a6962f1021c 100644
--- a/doc/develop/sending_patches.rst
+++ b/doc/develop/sending_patches.rst
@@ -363,7 +363,7 @@ A Custodian has additional privileges and can:
 
    * Awaiting Upstream
 
-   * Superseeded
+   * Superseded
 
    * Deferred
 
@@ -399,7 +399,7 @@ today. Not all states are used by all custodians.
   and has not merged yet to master, or has queued the patch up to be submitted
   to be merged, but has not yet.
 
-* Superseeded: Patches are marked as 'superseeded' when the poster submits a
+* Superseded: Patches are marked as 'superseded' when the poster submits a
   new version of these patches.
 
 * Deferred: Deferred usually means the patch depends on something else that

---
base-commit: 9e53e45292ee2f1d9d2ccc59914b161bef9b10d7
change-id: 20231121-doc-superseeded-d1ef005cda7e

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

