Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B46D6CFAA
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 22:44:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA13483AEE;
	Thu, 22 Jan 2026 23:44:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h5z3GxAr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EC8A83B21; Thu, 22 Jan 2026 23:44:37 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47AC58397D
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 23:44:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d148db5fdcso585278a34.3
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 14:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1769121872; x=1769726672; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zeU0mVze/GJsb/7vCckq5pJCNCYysM++E7rZ/FaJ9IY=;
 b=h5z3GxArJJHPd9tYXaWxz75YFlHlRVUmd3eUV/N0+zUnpmZ9YyAFU6sqqFHFrSCKHV
 sWvvypEsF7hn/9+Zc8Gt1/ZHze/CQSGzQk5BF2nZMszhW1dDeZAA2MtkGK24BBNiPVXp
 4410spgtU6QuIHz2iSJki6ENmRBKc8S2IlIak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769121872; x=1769726672;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zeU0mVze/GJsb/7vCckq5pJCNCYysM++E7rZ/FaJ9IY=;
 b=oRpPc/6Tr1fLCKKayubutsf76LeI/e8NF36yqIGkvTptqQGF66+jc/dBqk5SsMSy11
 dbc0Rb1vqKzJ9GcyXwJ1YlcspGNw7NqLluJnR5DsMo+n+UNnpj/VEqXYyukwpa9Hp/yk
 tuG23cpls0C/gyUWCvqKwDWPpWq5DSCun97zpwGsmImTszF4Cpj58Cls+eYyaT9ULlbP
 ZNGl7MBk9CW9u3V4Ia6IBIMHM/iNFMEpSagr/QdZNBEZCvz2U2pcSBeYLsDozW9/E/ge
 F79QLhcNCj28dn449b1wH9eBCKx57pSaaU/3qou18q1RGf6JX0B8mnEsmw0hcLmQUwJo
 FFrQ==
X-Gm-Message-State: AOJu0YyCVEGD+m5Us0v7HyCxdpCQSga4lQPQxLazgXZyUHBEzWKH/Wvk
 RX66f3uS+xAFB7E5C+JuRrDTZ7HUWhePI2KpszcJqnjZbFgYt7tOG3AuFGyck5F6e280sHUBHlE
 YMHtATA==
X-Gm-Gg: AZuq6aIu214BVo6F8m8NJARqLnr6UhxtumXQs31ZY1mBvEeZZc7+4MXN6RooIL3KuyR
 USLKWVi/aAp9OlazFU/Wn+DSzfdNLy1Nju9xNAaR8Ie1ZtTHSrTRMeqiEdUiqa+EgRcp9TGIjiM
 VcV5cpcrFZYB3AxGe5TVf+mBPppDXMcjQdfpqn38PG5jJgPMDYuvpBgVR1zMGXqzQ7Hx9RlvLc1
 9FQIC8FzD5Yd5tEBiDb6AFYPaLo2StEqp96KkgilMZI6FElQgMK6CYXEbQT42o6apqRUWDrgldE
 ikAm3exWsSEazj3rulCk5s5HbnBSDl0nPeWDr3Il/ifiRzN8E1oOjg/z/KnteD+JOm7xoa5xzY/
 +yQXR60GsZU39dDoHVbowsROxx8Qz3uKd8uGnqyxAsWEnqpAPoSr80AFSx1PxE/6+Zj5lyaG9Nc
 O+lvZa3yiraO2Ky6Ll
X-Received: by 2002:a05:6830:411f:b0:7c7:565c:4ce0 with SMTP id
 46e09a7af769-7d15a5d7902mr630921a34.1.1769121872261; 
 Thu, 22 Jan 2026 14:44:32 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d15b346e35sm464257a34.5.2026.01.22.14.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 14:44:30 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
X-Google-Original-From: Simon Glass <simon.glass@canonical.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Simon Glass <simon.glass@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] binman: Regenerate expired test certificate
Date: Thu, 22 Jan 2026 15:44:10 -0700
Message-ID: <20260122224420.2679336-1-simon.glass@canonical.com>
X-Mailer: git-send-email 2.43.0
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

The test certificate expired on Feb 13, 2024. This just used for
testing, so regenerate it with a 100-year validity period.

Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 tools/binman/test/key.pem | 62 ++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/tools/binman/test/key.pem b/tools/binman/test/key.pem
index 7a7b84a8bba..20bd5a41ab2 100644
--- a/tools/binman/test/key.pem
+++ b/tools/binman/test/key.pem
@@ -1,32 +1,34 @@
 -----BEGIN CERTIFICATE-----
-MIIFcTCCA1kCFB/17qhcvpyKhG+jfS2c0qG1yjruMA0GCSqGSIb3DQEBCwUAMHUx
-CzAJBgNVBAYTAk5aMRMwEQYDVQQIDApDYW50ZXJidXJ5MRUwEwYDVQQHDAxDaHJp
-c3RjaHVyY2gxITAfBgNVBAoMGEludGVybmV0IFdpZGdpdHMgUHR5IEx0ZDEXMBUG
-A1UEAwwOTXkgQ29tbW9uIE5hbWUwHhcNMjMwMjEzMDM1MzMzWhcNMjQwMjEzMDM1
-MzMzWjB1MQswCQYDVQQGEwJOWjETMBEGA1UECAwKQ2FudGVyYnVyeTEVMBMGA1UE
-BwwMQ2hyaXN0Y2h1cmNoMSEwHwYDVQQKDBhJbnRlcm5ldCBXaWRnaXRzIFB0eSBM
-dGQxFzAVBgNVBAMMDk15IENvbW1vbiBOYW1lMIICIjANBgkqhkiG9w0BAQEFAAOC
-Ag8AMIICCgKCAgEAkgyzB6tScN1Phh9sLrUhq0+F4bOWMu7oUf6wzorik1t85FXX
-0iJYsntzZ8K5f5zVBcxCfuLfwIg2iUJOSnXUwCZzpMOUmAbxbEw4TEeBx+gMn82m
-lZfgABjoOC18GcxmCp3IDmObumcjAUsx8aMyZpqKmGgiIuCL9lWUWcNWDwaE+rL9
-/EUEhE+XIv4PvPUn2/OWTxz7ujy5c2U7nxvsswISA7CLzabdmJQp0NU6qGcV7M7c
-TdWyiD+vMb5QEB0gAfPseMtLWDxNSFE9QytthTIM+YsgaepLBWqiNOnyE7SYzyht
-d8/LF14G+P6yeSNJYbJ9ckrB0NMy8Pwl+C2tv1TANAcOhixUYbv6zsnKin5sC5tu
-WxMVfMS+pcBaIcW8wUIGK/d7oxhckAFwQzqYb2XHVz9whwHBFYlUY67AVjc/MMn+
-1/IdhSFNepAHd9FrrKY5pxrr0Wehp0jQ1TtrWxCr8JIOpYmFsuCF7VnL6KDLZIWM
-rxbnXMUT4MRFE0NNG4mHyefbpKg+yIck+6atW2QwlZwLenVFD1mbra2wWnLMiE7N
-NYcoj8bwAEO10aCJ5ltQy6h2foAiVGCdE2ogCPAJp48qTFkVKNfZdMyID3b2vBCf
-ps/pChbGbM6NZ8LsUC+6FElAm9IXwdpN1sTbYQYt0KbKVCj7SsHiIPSE7SMCAwEA
-ATANBgkqhkiG9w0BAQsFAAOCAgEAJAJoia6Vq4vXP/0bCgW3o9TOMmFYhI/xPxoh
-Gd7was9R7BOrMGO+/3E7DZtjycZYL0r9nOtr9S/BBreuZ4vkk/PSoGaSnG8ST4jC
-Ajk7ew/32RGOgA/oIzgKj1SPkBtvW+x+76sjUkGKsxmABBUhycIY7K0U8McTTfJ7
-gJ164VXmdG7qFMWmRy4Ry9QGXkDsbMSOZ485X7zbphjK5OZXEujP7GMUgg1lP479
-NqC1g+1m/A3PIB767lVYA7APQsrckHdRqOTkK9TYRQ3mvyE2wruhqE6lx8G/UyFh
-RZjZ3lh2bx07UWIlyMabnGDMrM4FCnesqVyVAc8VAbkdXkeJI9r6DdFw+dzIY0P1
-il+MlYpZNwRyNv2W5SCPilyuhuPOSrSnsSHx64puCIvwG/4xA30Jw8nviJuyGSef
-7uE+W7SD9E/hQHi/S9KRsYVoo7a6X9ADiwNsRNzVnuqc7K3mv/C5E9s6uFTNoObe
-fUBA7pL3Fmvc5pYatxTFI85ajBpe/la6AA+7HX/8PXEphmp6GhFCcfsq+DL03vTM
-DqIJL1i/JXggwqvvdcfaSeMDIOIzO89yUGGwwuj9rqMeEY99qDtljgy1EljjrB5i
-0j4Jg4O0OEd2KIOD7nz4do1tLNlRcpysDZeXIiwAI7Dd3wWMsgpOQxs0zqWyqDVq
-mCKa5Tw=
+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
+wg==
 -----END CERTIFICATE-----
-- 
2.43.0

