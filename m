Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE333CD37BF
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 20:04:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AE5583DAE;
	Wed, 12 Nov 2025 21:03:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YdimHr05";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2028883DD8; Wed, 12 Nov 2025 21:03:32 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A4DD83D4A
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 21:03:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-3e83314cbe9so540133fac.3
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 12:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762977809; x=1763582609; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7OJO4y+K99hO5v4llAit1FJSqdO8FBocOfWbgmp6R48=;
 b=YdimHr05QwKBTgSf8Gwu6dNRprAGVv9PIdTy7k1YQM6djC7tWcZZ2MZp+jQavn2/Y/
 yxPNDV7KbrSfi6i8gazkgwEu4Pdwpenvh6480l2tsWauQjZCCaAA4g3K1pbkkyyAiBOX
 B2sI41/GkFfDDT/g0MY97SNbDHRSMbHoh34c0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762977809; x=1763582609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7OJO4y+K99hO5v4llAit1FJSqdO8FBocOfWbgmp6R48=;
 b=cwBLFxqDP25XKpEf6ReShZ6ERZXEwAyDnZ4gYfFeqCX1digrCUiZ05D/b3HBaBRb3e
 PtbH4TDkFIKCRhJlRZStVgcADSg4abEmprJlVUDwCxDKopDfTNRrzXaGHdfKFF2hm2aX
 dUx+5lFq02Al0PLnZbmZ8LsreB38AFyKJZPOxeUhJGZa+Hx3l74s4sIORzWNsPrmVkaQ
 DN5SMRHby9JbzU9l2ZyN+aB6lfOKCBv3ttPx44ifVnu0kg6L7HXguNQvQDHSj+OKlJ3l
 WVP3IlsubL6OjWzUw9OiPujfIw/7Ru1VzDZY5jrrluNLj8qdb2vRN7iicJB2UuFvAvEo
 uCSA==
X-Gm-Message-State: AOJu0Yy8sLUdxgmX+WrZSYTWE8NESovmP9105DVpWed3o0Riw4SsTYMB
 W6gvKzdC0GyiLI66uY6GaVHx8Vw9GvQd/e3GqfN9pnGJv9ja24SB2j+0mZ8MRuIoeGID77yP3G8
 Ei565Y6kl5A==
X-Gm-Gg: ASbGncv/zvsSnylwhiFTy8AkxFqWc/ZOWA28I2HlgaMtOkPfQfE0eDihhU512glMOhU
 eolLNUnq6OsQsxtlwX1G+e6ww9wvV0Xb6sfXVFrcdsrdsIOzftcroVj8qT0Dzi2Qc/SeLfDjpql
 3Y1PMeh5PpAdlF5o29rkBJmQ8CnAB4Q1Xs0RESBrGJi4dGk3j3H+sWHzDHG0Nh1I2mCL38JMfyN
 LYGH/xJcWlWJoYaDbCw5Is/Uyr4bjDjSAPJRe+FU0+2U1EYZ37Fj1nlwsPc11dafqp+bW5RqBq+
 YVmOa45yCuZk/k7q6UGWExt3qRHcyqgxrF1LGqhEM09vt95jfspfT7FjjVuuI1PH9UEIMWTVq6Y
 OrLZ9gND3xFeJUQ4z1E+Psh53B/7EYaWT9XzNcp2huFVsmGmGWZwfX6mnUIAmQEWcmETG740NlQ
 WALJOwuWC9EXsEjRZZgxy0CxnVzHd0ZmtIZOcBVFcsKi+i2DH5G8WX
X-Google-Smtp-Source: AGHT+IHnQvpd0XCxOUzg1ilScIl6gw3HmQvSOm76Ye2TQMwqf+W9Ed1SpBw2tNkhUDPTtieO0o1gqQ==
X-Received: by 2002:a05:6870:7014:b0:3e7:eadf:4eb9 with SMTP id
 586e51a60fabf-3e8341d008emr2074798fac.46.1762977808753; 
 Wed, 12 Nov 2025 12:03:28 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e83281c9bbsm2169596fac.18.2025.11.12.12.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 12:03:27 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
Subject: [PATCHv2 6/7] video: sharp-lq101r1sx01: Do not make use of 'z' for
 printing non-size_t
Date: Wed, 12 Nov 2025 14:00:07 -0600
Message-ID: <20251112200315.1111980-7-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112200315.1111980-1-trini@konsulko.com>
References: <20251112200315.1111980-1-trini@konsulko.com>
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

The debug macros in this driver make use of the z prefix when printing
regular, non-size_t variables and this results in a warning. Drop 'z'.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/video/sharp-lq101r1sx01.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/sharp-lq101r1sx01.c b/drivers/video/sharp-lq101r1sx01.c
index 4fdf0da8a94c..1c7cef777c30 100644
--- a/drivers/video/sharp-lq101r1sx01.c
+++ b/drivers/video/sharp-lq101r1sx01.c
@@ -40,14 +40,14 @@ static int sharp_lq101r1sx01_write(struct mipi_dsi_device *dsi,
 
 	ret = mipi_dsi_generic_write(dsi, payload, sizeof(payload));
 	if (ret < 0) {
-		log_debug("%s: failed to write %02x to %04x: %zd\n",
+		log_debug("%s: failed to write %02x to %04x: %d\n",
 			  __func__, value, offset, ret);
 		return ret;
 	}
 
 	ret = mipi_dsi_dcs_nop(dsi);
 	if (ret < 0) {
-		log_debug("%s: failed to send DCS nop: %zd\n",
+		log_debug("%s: failed to send DCS nop: %d\n",
 			  __func__, ret);
 		return ret;
 	}
-- 
2.43.0

