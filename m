Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDE7CDB482
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:51:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F55486F65;
	Sun, 15 Oct 2023 09:42:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HIpFYAy1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B98C86FEB; Sun, 15 Oct 2023 09:41:28 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08C9586BCF
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 09:39:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3ae2ec1a222so2172701b6e.2
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 00:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697355560; x=1697960360; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+0s2rYrOn50ORv8bxURdRwIMEamxg+cdrM1StGe8z6Q=;
 b=HIpFYAy14TLt/L2t9oaQWZSb0XlKwCKjHJHdXAl00I52sF0B32emVHe5lq2V0Vub3O
 UsFr0N6eE3DnHVxwP7Z8SCK0LQJ3AP8ujgeRGEN9A8UPUUTHqcxhoCQFrnzDgeMWmGIh
 I3fvsigja0x8v7RMLQ+XBj8vTJ36wL6alJ+kuabBshAaC2u1Pjjh3WFwJd7LlVXDA/ra
 TeJ11CGPYLivVokTL3ax0fQHz3zjoxVWDue7buMA2QvksSC+kvQe2WgbTSXBUIbxiDFV
 I+L4Ybp15bWFPanAeRN0NJ03L20sXtlTaVulGvccdZNR3cAKL5N//XVucozqj1ETl5lS
 vYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697355560; x=1697960360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+0s2rYrOn50ORv8bxURdRwIMEamxg+cdrM1StGe8z6Q=;
 b=wMi1RrjHpmBNdXRv2qjnbpd8xKaa7HH01WVwp3LY4ENk/k+9M0417FnYJmpD/pCsMK
 TTsvkLForuoGNznNp6usF35TQImm1h+8mGqSAakB746VAbrAu+bEGUKWrORl1YjOJiJf
 sLbz5U1I7+TEakO5qg6Iwc3aNLumAqJjYbcSgJeu2QllFENZphgVppXlWRj9OFwFXke+
 n4ODm2YyXBd9A2ZYf7I8aFC/8d/dL8W0wHjPwJJNm8WuUEvnRNr+ofZOJsEF9WlyUFX2
 /d8MygesOITUj1CDh3c2mfddQy5T1vL9baObl4leze80ZulL7FMAYd7cXV7KRdrpnzGm
 Bepw==
X-Gm-Message-State: AOJu0YwAMxS7sMYfN4or/numACvucck6naLXZGsyiDeN/p78NL3QExyX
 cvs05MEDSzBREmp4pDPQkSP2+dAU5YoYKg==
X-Google-Smtp-Source: AGHT+IG0Zk5Wzy+7v+Hp0UpUOg/uxp1abZ+6nNH/BRnpzc6TBKeEM0KYHZSDw2CDMszWn0xROSlkyw==
X-Received: by 2002:ae9:f712:0:b0:775:6e1f:df5b with SMTP id
 s18-20020ae9f712000000b007756e1fdf5bmr28210281qkg.38.1697316501736; 
 Sat, 14 Oct 2023 13:48:21 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 c18-20020a05620a11b200b0076ee973b9a7sm1731724qkk.27.2023.10.14.13.48.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 13:48:21 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 12/29] fs: Disable sandbox filesystem in SPL
Date: Sat, 14 Oct 2023 16:47:48 -0400
Message-Id: <20231014204805.439009-13-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231014204805.439009-1-seanga2@gmail.com>
References: <20231014204805.439009-1-seanga2@gmail.com>
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

Don't bother compiling the sandbox filesystem in SPL for now, as it is not
needed.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v2:
- Disable sandbox filesystem in SPL instead of compiling it in

 fs/fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fs.c b/fs/fs.c
index cfc781bbb8d..4cb4310c9cc 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -237,7 +237,7 @@ static struct fstype_info fstypes[] = {
 		.mkdir = fs_mkdir_unsupported,
 	},
 #endif
-#ifdef CONFIG_SANDBOX
+#if IS_ENABLED(CONFIG_SANDBOX) && !IS_ENABLED(CONFIG_SPL_BUILD)
 	{
 		.fstype = FS_TYPE_SANDBOX,
 		.name = "sandbox",
-- 
2.37.1

