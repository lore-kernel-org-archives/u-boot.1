Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32D5C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:03:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B10588746;
	Tue, 11 Jun 2024 22:02:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iy6utdNU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B1678872D; Tue, 11 Jun 2024 22:02:22 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F310388617
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3747e9f7cceso25102035ab.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136138; x=1718740938; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FA+FlwdkRSMhQxY2MZH+AxkvYhCzQLUcdRiqc88p2+4=;
 b=iy6utdNUXZxhrgs/+6ldj3SBjY1bjtT0e9iuIpKU1jOsgts8U5tACCYan64neVu1Y1
 3ZgYF6KtHoWOw83NHzrKu434R+tuEWwtU2agpolQjd8NE/CldxqBru3OdHGAcr/BdcxW
 pYLAFn0PAagMXvzK611PGDxB7plPQ6CSht2h0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136138; x=1718740938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FA+FlwdkRSMhQxY2MZH+AxkvYhCzQLUcdRiqc88p2+4=;
 b=MJblJNGJV5P2x0cldQi5a8ygXG6CpL7XH3Cgrd7W6ORP5B4Q7wNjIAiMhgmg+vAa3h
 HwbKtNhlh/K/jjzds4MI+ggYAVE2B6lC4jVrzEjOO+9rhdQoTDAYW6NsZD32gJM33qtD
 Ssf6BlCI8Kge8xcQoBgV2tDmwg0GiCV58AUvd5KGhhSi2Ig6ciMhaeVQW0GLC1/g6wi1
 ZUF9s00moveYz+inl+cwOSNbGJtMUlkS3PLEEic+vOOHApwbSqqxIg+buKscbPdtNDfh
 5oh6ZDUVtkd2RbEPlINWwHbMyssh51Q2MTK7fu1DEWtjkkcmR6QC2PCEK3MQBOhaswa6
 3+zA==
X-Gm-Message-State: AOJu0YyfVJq+frlNx/ObPEgU+52iYWcbPzaSHVXdLTD8dudt7mFobYUH
 B0o5tzgkvkoIvyMg3pvPIlYWP6QSRLmTCtg9kdIggDZNIcTfxTKXKZf/8XiosGaNpj8ER6npV1Z
 z4Q==
X-Google-Smtp-Source: AGHT+IGyU95wmmrDVxHAfdhLwtFRnCa6WH/As/Sj4TqoJGOHLpfWoLlTFFN7OQ+VRzbk1U1ioABm1A==
X-Received: by 2002:a05:6e02:216a:b0:374:9b99:752a with SMTP id
 e9e14a558f8ab-3758033c3dfmr168048415ab.14.1718136138620; 
 Tue, 11 Jun 2024 13:02:18 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Marek Vasut <marex@denx.de>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 05/42] binman: Update the entrydocs header
Date: Tue, 11 Jun 2024 14:01:19 -0600
Message-Id: <20240611200156.2245525-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611200156.2245525-1-sjg@chromium.org>
References: <20240611200156.2245525-1-sjg@chromium.org>
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

Reduce the length of the underline for this header, to match the
heading itself.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/entry.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/entry.py b/tools/binman/entry.py
index 42e0b7b9145..2ed65800d22 100644
--- a/tools/binman/entry.py
+++ b/tools/binman/entry.py
@@ -812,7 +812,7 @@ class Entry(object):
                 as missing
         """
         print('''Binman Entry Documentation
-===========================
+==========================
 
 This file describes the entry types supported by binman. These entry types can
 be placed in an image one by one to build up a final firmware image. It is
-- 
2.34.1

