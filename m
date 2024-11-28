Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403CBD70DED
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 19:13:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2CEB89235;
	Thu, 28 Nov 2024 20:13:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZIiVxcDA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E0B989D18; Thu, 28 Nov 2024 20:13:01 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 050CB890D8
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 20:12:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-294ec8e1d8aso758541fac.1
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732821177; x=1733425977; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tb0QjvemW+4s3iFXT6ldsJV8GoYW4g7qZbOhr02N3Hg=;
 b=ZIiVxcDAgD79IjtogjxTjJ3N9NSgOHO3dBH5m9JKCRCPzyYzXHRtGZ+xQYLDhRprzf
 ECI0ZZtRtFX0/BM3ohaAP02EFsYNjUCVTiFeLqYPO7006k1s8fCgdoy/DiNSbFWiGMej
 dXFbTi3UE3P5o1Cxq9JhL3WI69VAWWlr0cc+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732821177; x=1733425977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tb0QjvemW+4s3iFXT6ldsJV8GoYW4g7qZbOhr02N3Hg=;
 b=GdmN0tiixsyIjD0ZvJysW42/tSvrNHAIZhuzcA+DPtiEXeinbujwcSZwjhxTGj/jqG
 o9Fpa/12t7Yp+fwHZ6L1Ii3XDj0ihH3YpeoAqKx7g/LJoeyPiPmttwNS9kcpOCdbYmZk
 xN18M85Ws2nf04QVoobN5SgJnYTRH9+7ArGwUke91jHI6lfiINC6YBWoOi/vY255byj0
 jXoAhd7OZ2YU9rcX9bhJRRihHeb+dCzCyHRro3+ly6SriuJaVXG5lqRNCQ/UeA+FVGSD
 mdvoXcoC9tHBc/JpMPmdGreYhceX4aNHBO3EZtno0N9PeKVv+Mn7UW8BBQT/xgrUr4UG
 bENQ==
X-Gm-Message-State: AOJu0YyPRqYhUjpH3lamEZTpfLWatDR372bkmHDouYLP5nafk3YUc8Nf
 JBSDOlyBt7xhFBOOmdo8EQGOEYa2gxQ6whVrftEApJBijOTGTlL5qh5yxrb9iSpO3zdXFYj9Khk
 =
X-Gm-Gg: ASbGncuOAYCB8EK5wp2/PqilUFY4Cmz+7VFVDiywH4VYmm8d1PB5HuSyFx2bQHqS84F
 ZpkQoZfZSgJTjQ9Sod/izlRd8ygoqcCaCnWMzWlCdtMQqvOn8ztdcL62SW4b2ldYpO1Kwat78VC
 0A1wGo2TrUEXaQmWeyl16l4rHpXu7U+ObSsZ6PzijwBAYAET3WwDnNxYxpBiSgh79GJzClCNfHx
 Qkgrhcn0U11ARxI8mjxOZDQNJVvAzrPF8xqs5RAoCh5pA==
X-Google-Smtp-Source: AGHT+IED1PHmQjz0bOK8MKkufStYGKtzlzEMOmFuWNce7Chh486I7v5LY7VHhFXvfGOxwVVUYByH2Q==
X-Received: by 2002:a05:6870:b254:b0:297:94f:7711 with SMTP id
 586e51a60fabf-29dc432b836mr5978474fac.32.1732821177253; 
 Thu, 28 Nov 2024 11:12:57 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d873esm429521a34.54.2024.11.28.11.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 11:12:55 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v3 02/28] efi_loader: Fix typos in enum efi_allocate_type
Date: Thu, 28 Nov 2024 12:12:18 -0700
Message-Id: <20241128191244.900006-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128191244.900006-1-sjg@chromium.org>
References: <20241128191244.900006-1-sjg@chromium.org>
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

Fix 'indicatged' and 'adress' typos.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

(no changes since v1)

 include/efi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/efi.h b/include/efi.h
index 348ff9efd16..76feefe6c50 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -175,7 +175,7 @@ enum efi_allocate_type {
 	EFI_ALLOCATE_MAX_ADDRESS,
 	/**
 	 * @EFI_ALLOCATE_ADDRESS:
-	 * Allocate a memory block starting at the indicatged adress.
+	 * Allocate a memory block starting at the indicated address.
 	 */
 	EFI_ALLOCATE_ADDRESS,
 	/**
-- 
2.34.1

