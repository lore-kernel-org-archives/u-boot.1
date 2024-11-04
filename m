Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577EAD1CA08
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 22:47:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D9CF8901B;
	Mon,  4 Nov 2024 23:46:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aYdYUc3x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EE7D88F73; Mon,  4 Nov 2024 23:46:28 +0100 (CET)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2535D88E96
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 23:46:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2689e7a941fso2296217fac.3
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 14:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730760384; x=1731365184; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rOSJX2KylyqXjJ2ADZ0wOm3pDYPs3ARvz7MU2uM/e7A=;
 b=aYdYUc3x0yYwrXd57wxVAqyFUIjAHdmNCTJ7GA+4MSLUs+9Nd5KWyQAHZI4eZq5ihM
 Esv5Scu7ATbGpc0W/vhVkue8kKJPLczgARyLnHT46BpjaHu8ueKCa84FLtfv9VWJb+8y
 sQPUQz8nhDitwXgPmeeE4cDppMl6lahC7Yec8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730760384; x=1731365184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rOSJX2KylyqXjJ2ADZ0wOm3pDYPs3ARvz7MU2uM/e7A=;
 b=lM1LCiHS2UGFw4LLVgw4ij00wR/lC31fA7vccB3fe20mTD+6sNmSdWEU/ysvONlay9
 3ylygo3UXXKSJmIHkqgYc4SUGEpZQy8gclsyKXLvoWeqAd/m1uXFtk1WYRqyr11YXCM0
 rHTI1UeTd6vEHf/G2KpDjCpEUkGuz/DWDrtNp17Gt+uic7tDaSOpzF/KmvuNatRF5PvP
 bGB/qdykKNlyVDgIsjJ5+PWI43lakgnVpyTvrYFfjad3YUE2cAtfAg+2mrn4b+aRoWCm
 v6J7TpU/yELjX0/1gWpnw84riJS3AzbafW2DDx1KdShfxWKQdVVxBJNvOj7sSqaWyDSX
 CLyA==
X-Gm-Message-State: AOJu0YywSJuxYwwVQm7UNzHIzcNKcPtuQlVYU6fXOvjAcIN0YEq2fdoN
 AvclBD7Ax6tvIAuOdMZBNg0Ehd+KxGbG4axBnPsOjjP57ZGnFQs60uteousHZOZGQoUqjNtKPwI
 =
X-Google-Smtp-Source: AGHT+IHB1VfL5ZF3vJGN/TzkNcGd26Gweg6q3CcJ0xS55/idxFgCt11BaY2R7VwJ4iKX00mLP4e1rw==
X-Received: by 2002:a05:6871:c707:b0:288:b7f0:f8fc with SMTP id
 586e51a60fabf-294846cd45bmr12893978fac.41.1730760384296; 
 Mon, 04 Nov 2024 14:46:24 -0800 (PST)
Received: from chromium.org ([50.235.115.130])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6a97b009csm25535945ab.4.2024.11.04.14.46.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 14:46:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Love Kumar <love.kumar@amd.com>
Subject: [PATCH v8 09/11] test: Add a section for closing the connection
Date: Mon,  4 Nov 2024 15:45:36 -0700
Message-ID: <20241104224550.677442-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104224550.677442-1-sjg@chromium.org>
References: <20241104224550.677442-1-sjg@chromium.org>
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

This can take a while and involve multiple steps (e.g. turning the board
back off). Add a section for it and show the output.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 test/py/u_boot_console_base.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index 42c81b2d13f..fa9cd57b04b 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -183,7 +183,10 @@ class ConsoleBase(object):
         """
 
         if self.p:
-            self.p.close()
+            self.log.start_section('Stopping U-Boot')
+            close_type = self.p.close()
+            self.log.info(f'Close type: {close_type}')
+            self.log.end_section('Stopping U-Boot')
         self.logstream.close()
 
     def set_lab_mode(self):
-- 
2.43.0

