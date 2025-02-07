Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB17C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:32:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9132F8092B;
	Fri,  7 Feb 2025 19:31:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IlKCtpeX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6CA3807D9; Fri,  7 Feb 2025 19:31:54 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D60B801BE
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:31:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-8550803e1afso20655839f.1
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738953111; x=1739557911; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=whUYdBT2fyo1K6w6ZvhNiMjrgsT+5lkmwjBeSoaWuBo=;
 b=IlKCtpeXavlhri9MO2DfI2oe37cTZJ4JOO1RmK+BHIKav2oVPtniFux6EFIC6tN1QL
 M5PUtk3u/OmyLBtjmjz6thDzsHpyWbuVHrBKd2jGY6B11sCo5Iuin7WJVKzgQvIhGAgA
 zduVCpMGWq7XvwijS98hqboaObQmsh9ib3dYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953111; x=1739557911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=whUYdBT2fyo1K6w6ZvhNiMjrgsT+5lkmwjBeSoaWuBo=;
 b=MkSdEld1Yc2iCeG+kpGbrj5HBp38hzxJin3H4kvPeyxS2k1rj2iGUFMxURayJhDxSz
 /bwU2CjbA0ep13kHXQxbmIItntw5+HteDnw7/2QN8FcEYkUci7w4K73hglO6aotSz+Sm
 eGvZ5cxXLCCpTfWweRr1KjdM58Y2lD3DoWH/rsL1Op05FIV50Db7yQuos96RIJZ6p+Gy
 UUBPTyZgwC7R92J0GMXbk3C6VyuAP5Bcv7jw0Tk4PYgwYJfrM3gTRuAmSnbza5VZJZi3
 t8uGoBJKDNc47PQfSzHv3+4h4weGn6CPWrc6h93q4R4iYXRbIdZu+nGpvrGXV8IEA7Ln
 gV0g==
X-Gm-Message-State: AOJu0YzLYzxukmWAkQ1fsazqPIvOqlHWbkdtQqWBywjICdbvrUzgxTiX
 dpenVfKMpscSu2AaAHXaXTuvRoFTDs1vTwlXUS8W0Gt+7c7oHW9ON+iUzGqIQDVuFoQpO2JBVzY
 =
X-Gm-Gg: ASbGnct9BUVIC+auPuHtAz3kmbHHP8BBXIZ/7EHgeSJLwi/3bnG7dmAnNNFtFznXCCM
 t4PvdhLacByHcp8Q/xZZH/hUc4y1999LOploT7U3NHZc0FiDZ8ox6wgiuMzDnJ0fQIRmdIjISK8
 Xl3nUu19QKfXTFN3pmt2qhwoBxcnSIRqZv7/V3FgF2tX3JHcWRDiGnoNJ2JS/cH+PVaT+ul++Vf
 86PjfletiQV0MLgdElTgwGMLFUoQ4UvsjIBXQKUuKVPf9Ip9x6jRhOjnb+8xkx0pYnPG9pO39N5
 +ekohwzpsinOQce3mxlJHs3RZx+dgk3pmZMFJFUOIAYn0GWP53hD
X-Google-Smtp-Source: AGHT+IFZ2N8bdakZqumjfl/r3RAS8+SqF/omueF2uoAJSH2EGc4OvoCJbLSxkXD/o6KI7OHAMidwdA==
X-Received: by 2002:a05:6602:3713:b0:83e:418c:8a28 with SMTP id
 ca18e2360f4ac-854fd8b32c6mr506325239f.7.1738953110779; 
 Fri, 07 Feb 2025 10:31:50 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854f67bc3ecsm74850439f.47.2025.02.07.10.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:31:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 10/29] test: Move optee-test rule into test/
Date: Fri,  7 Feb 2025 11:30:41 -0700
Message-ID: <20250207183121.117663-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207183121.117663-1-sjg@chromium.org>
References: <20250207183121.117663-1-sjg@chromium.org>
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

The Makefile rules for tests should be within test/Makefile so move the
'optee' rule over.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 Makefile      | 1 -
 test/Makefile | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 74eafdeb646..e0f58cccd00 100644
--- a/Makefile
+++ b/Makefile
@@ -893,7 +893,6 @@ ifdef CONFIG_POST
 libs-y += post/
 endif
 libs-$(CONFIG_$(PHASE_)UNIT_TEST) += test/
-libs-$(CONFIG_UT_OPTEE) += test/optee/
 libs-$(CONFIG_UT_FDT_OVERLAY) += test/fdt_overlay/
 
 libs-y += $(if $(wildcard $(srctree)/board/$(BOARDDIR)/Makefile),board/$(BOARDDIR)/)
diff --git a/test/Makefile b/test/Makefile
index 17716ef384a..5ef8c379cb2 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -14,6 +14,7 @@ endif
 ifneq ($(CONFIG_HUSH_PARSER),)
 obj-$(CONFIG_$(XPL_)CMDLINE) += hush/
 endif
+obj-$(CONFIG_UT_OPTEE) += optee/
 obj-y += ut.o
 
 ifeq ($(CONFIG_XPL_BUILD),)
-- 
2.43.0

