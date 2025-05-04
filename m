Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777E2C3ABAC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 13:25:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F87682A64;
	Sun,  4 May 2025 15:24:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XA8SUIP/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68F2682A27; Sun,  4 May 2025 15:24:26 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45D3082A2F
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 15:24:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac3eb3fdd2eso657701466b.0
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 06:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746365062; x=1746969862; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k0TtLxjT7eXo3CfTcgCu90/P/o04AzUd7exTz6Y0Gao=;
 b=XA8SUIP/4fCPszf047xuMI1nbqUY80W4BoomjGrn5udLQXNWn/Z+RqvenKN2XWonq8
 g9AoPoLgUdVDpavLqkt4ct/kbepIedSr7kmbkkiwV/Bu9i0HeFURfboBJD+sP/z10F/v
 t+ni2sdUtERJON7rb+LdalJqzuxT2vZpSzIwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746365062; x=1746969862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k0TtLxjT7eXo3CfTcgCu90/P/o04AzUd7exTz6Y0Gao=;
 b=ARr5qZMKAivwX0uw/PaNTyrnjewhFTEnzj4psH/MqmSS6JB+bCIIXB4yef4Qj+UDy6
 ES+l0iFRu8uhbpccIuDWtkaR4vWcoChO1uYQbYmYxfnB0yN7TQCojs3cM3ghkyoyl72L
 Du98ZcnbSgQFosTHdpd0Gzo0he+YHYplN4CtFwdyZ4JnVsQtf/NV4+iViDq5bCZnHKAH
 GEx0qIeyqsqlwkI6G87aDil4UyZXGZa9h8e5c4BJoPLMZk29xT7gIrdnv8bdYH3CnZbE
 3P5OoOHeOyx/jXoL0v/9YXiqXZAYTHzusbA1DzJ04QQ2Oz3i8CxSAz1xBPZqp2QdlY+1
 wfGw==
X-Gm-Message-State: AOJu0YzBZsepV8+0kMQyiFL0JxrZ4OAreom7oUBFvv14tS6ISDBGU9rh
 b41VE8b728MtKDuHR+TFT3DYiXtf3NgF7iyL+A1jEtNOlmEzMXNSU4jmwUPOH9JJ9RI4DifirUp
 cJrcFISA=
X-Gm-Gg: ASbGncsZ8MZ7VIMBLi32TIDHWjlE6ZDkTcgBI7wraH8RwSeXisPzq+V+sOcHOQUjRSd
 VE6LoeFJhFFE4MGRtyikxRwMtfso4t7OeQbEqR9X3e7LPH0hctKFgDA4pt36FI+SLWGkickSjHJ
 N1boOpFDB4dp3vdaol9O+9BJGj7qQ5/92XW9re4iQERD7ofN/YndDPfR9Ogc4ZX6Bbg1j/xpxL8
 twD4HonYFoZVX9p+2NEghL7xb6P98qMPKd0ioBSIMd8JPUQbzs21siaSDorE+UI1JwKYn9c2TzY
 JBuUBMIr1kaInYRkYGIXZryND7NgXgsdjhOTU7MMzKcPeF0=
X-Google-Smtp-Source: AGHT+IHmmbr6gQ2OHMDB/US0TZVc3XyCcCrCM8/Li5D79COhA17cDpE843qT/PgHrEJkG5trivC4eQ==
X-Received: by 2002:a17:907:869e:b0:ace:f2b7:c9ff with SMTP id
 a640c23a62f3a-ad17b832810mr1015541466b.48.1746365062330; 
 Sun, 04 May 2025 06:24:22 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891f508asm328655666b.85.2025.05.04.06.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 06:24:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 11/30] patman: Rename test_basic() in test_checkpatch
Date: Sun,  4 May 2025 15:23:27 +0200
Message-ID: <20250504132356.2317305-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504132356.2317305-1-sjg@chromium.org>
References: <20250504132356.2317305-1-sjg@chromium.org>
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

This currently has the same name as a test in func_test.py so it isn't
possible to select one or the other with 'patman test test_basic': both
are executed.

Rename this one to avoid confusion.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/test_checkpatch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/patman/test_checkpatch.py b/tools/patman/test_checkpatch.py
index 3bf16febbf6..4e8d163184e 100644
--- a/tools/patman/test_checkpatch.py
+++ b/tools/patman/test_checkpatch.py
@@ -137,7 +137,7 @@ Signed-off-by: Simon Glass <sjg@chromium.org>
 class TestPatch(unittest.TestCase):
     """Test the u_boot_line() function in checkpatch.pl"""
 
-    def test_basic(self):
+    def test_filter(self):
         """Test basic filter operation"""
         data='''
 
-- 
2.43.0

