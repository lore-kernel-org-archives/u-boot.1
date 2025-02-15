Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9155BC02198
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 03:23:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF4A480C77;
	Sat, 15 Feb 2025 04:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WtJH9dJR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C235806FE; Sat, 15 Feb 2025 04:23:08 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA48A80756
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:23:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3d1988be53dso4765575ab.3
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739589784; x=1740194584; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sPL7Vldt9UJdiZlFQ/uegNLLoW7ClpYgZA91wThnq2Y=;
 b=WtJH9dJRoPFSgR7d6Iry/f+5pnyC/Ytva8LOSJQM015JN3xZ3wPlIgKJ2jAk9fnaWH
 AwFKqAt1e3OmcY+SG/2PdnWjXl+HvYBgcpg3+/U9tO6FnLwb4jr35zMw1QIiyNHe78s2
 20L6vxYXzpinZQ+a2jjyCA1MQq6LNGqSDQ34A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589784; x=1740194584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sPL7Vldt9UJdiZlFQ/uegNLLoW7ClpYgZA91wThnq2Y=;
 b=fuwJ3iqswydAQI4iNWR7DC3sqM+DT0xlcKnXI4JeAslgxupi6ULX5SiuertQeUm2ki
 HXuDU41Bs+tvV0hURRvAjiWeJm5eM0xZy+Im77bGzd1Gk01TBZ5d4QeTPfGQ9tEsHjro
 7T0BwqSO9UXlMKx3gEcg2auFti3JnknsZyWpz0yjpaYKJ1SPV6NFPM/I5/7O3B+aB+Tk
 Weut+wsvYaRrOe3Sw+vh6lxsC5CxReqVY/zabhWbs/6wkTxrSXG25K86Iu0TeOdd+zxb
 0TSPtUrUdd4HWydjA6AEbOyYm2MhSkTddwAF2t6aqvK8ke08u5/+QHughLn0v0k4qdtS
 mYjw==
X-Gm-Message-State: AOJu0YxXOoU53AYCTtAlJVItKGsPD77AcYTLd7NQE2X4spVIeDMaBM4N
 BkGFls7oqeig9HVx0VTNBmcFjfTEJ7tl0i82w8YX0q9u/MHMkETMDR0nEG9uy04n5jovqefgp34
 =
X-Gm-Gg: ASbGncvcMC6suE4Q2m+ZyjxXqxWhC2W46IR2ctYr778nGD4wkaz4ae47Tn7+XBMMfPq
 Sk4SYbxwPYmE5E8Q09d5N9vignvgbHOCVeeK/kp5QDbwnkR2p6UwFeX/8SbJwg5jPm3cj2Ql9YD
 +RzeGhzIaTdg6u0Mo5lYhjqRChf/oeTNCfoik0hdmUbuwsdNxYjmfmXrcdqW9GDywaGlXZmKWPr
 R+nf6PvmD9E3xj/imTuXT+Myb5kRhyZu3TxZ6s7sqVMQGWzCAbvyKzzX15rHu+Pvx2/STmSspBi
 Fj8H+kFxA7ZGhffOmDeFe38ZXkdSXbhGZqYEVCqwW8dbCL9lqQND
X-Google-Smtp-Source: AGHT+IFf5rJktf33Y/B/OEu3VWgSBWWAU+4+BJb0iwh2mK9K2z9G9x7YugDYu+qGvXIpLvZwjqzRJg==
X-Received: by 2002:a05:6e02:1a8b:b0:3d0:2331:f809 with SMTP id
 e9e14a558f8ab-3d280763e4dmr13436055ab.2.1739589784052; 
 Fri, 14 Feb 2025 19:23:04 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed2819d0f5sm1087697173.67.2025.02.14.19.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 19:23:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bryan Brattlof <bb@ti.com>, Marek Vasut <marex@denx.de>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Peter Robinson <pbrobinson@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 01/29] Makefile: Avoid using TEXT_BASE with the EFI APP
Date: Fri, 14 Feb 2025 20:22:22 -0700
Message-ID: <20250215032254.4121030-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215032254.4121030-1-sjg@chromium.org>
References: <20250215032254.4121030-1-sjg@chromium.org>
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

This value is not available with the EFI app. Add a condition to avoid
introducing errors when linking.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Got back to depending on HAVE_TEXT_BASE

Changes in v2:
- Depend on CONFIG_EFI_APP instead
- Drop change to u-boot-elf rule

 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index b1d3301476d..5c4e03f9ce1 100644
--- a/Makefile
+++ b/Makefile
@@ -1050,8 +1050,10 @@ LDFLAGS_u-boot += -z notext $(call ld-option,--apply-dynamic-relocs)
 LDFLAGS_u-boot += --build-id=none
 
 ifeq ($(CONFIG_ARC)$(CONFIG_NIOS2)$(CONFIG_X86)$(CONFIG_XTENSA),)
+ifdef CONFIG_HAVE_TEXT_BASE
 LDFLAGS_u-boot += -Ttext $(CONFIG_TEXT_BASE)
 endif
+endif
 
 # make the checker run with the right architecture
 CHECKFLAGS += --arch=$(ARCH)
-- 
2.43.0

