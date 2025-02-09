Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613B9C02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 11:52:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65E67807D7;
	Sun,  9 Feb 2025 12:52:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="UpTtyRNd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1B0680834; Sun,  9 Feb 2025 12:52:40 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB2E280141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 12:52:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1B2603FE64
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 11:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1739101958;
 bh=m0a2bOtlh8rmqwcmZyiZV0nuBkbsCZQivcj1Zi1lNP0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=UpTtyRNdqOYzngQEtbpuNmjJkc+JwHF6f+JvY9wobx58FRzY6asfknbFf8m7yj1hW
 QpBX5hR2+/osOxU1KcJMuuLNfHUaNGVJ+f41ZFR2izXIVS9yB6vkblAdzKKNTpMvxz
 /8n3qD5ZCZKamVIGJHqteYd31nrv79bmCjBGXONQooql6GeEhNbLB1vrHugK25Ljil
 9T9I1LUOl6+52QCFPrzIDaZEe0Y4jlGqHPXIhOn4Nvd9uZ1TN8OLxYhizPTG5yL/0V
 fCv5WzaWhcGjXFgz3PmxOEeIac/VRTJ5D6lA83U22PSli9PiNqOkBKPdFK4Sytl0aG
 UqvrtvN2Vt5Nw==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4393ed818ccso2089075e9.3
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 03:52:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739101957; x=1739706757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m0a2bOtlh8rmqwcmZyiZV0nuBkbsCZQivcj1Zi1lNP0=;
 b=h1MbKmTX15i/XD6HoAgb3+kwAHtcVXxCdMf7HrGUTIZsOr3m9+j674G62iEwY28fpy
 XcX58cvnnN4mLvjsyOss9BRLAtOZMTx8mKPd+mmVc319cFqw6NK5X0SvWLR1PZpgOydX
 cmGLpRuwgyvdZKg0tCDCUudu4LrZYTqFgN1pO5OQG0MVzbJtrRWhaOytLpyI6Rn36y7K
 v4sTtpmv/fklShJOGeONLNsLiuEXq+sdUokX7FgtaMOq6XGoiQySEu6VP4EcKvXNyAdB
 2CyeEPj46QZkrJWFg9BssXVdILTa7YeW4xS+JluBcWAqswtTdacGdWsayChvX7/51BgC
 op1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQLgsc77cpQmW+d5oP4WQN14r034EivpZL+a5wXv5NtVteOswxcOcDGRH6ViYSQ2KIkjDpoK0=@lists.denx.de
X-Gm-Message-State: AOJu0YzxXtv/ZL/C1RCl0uBIIsdbiAq5P6mzZHEIXFhLoPy6h0mKXvZl
 oqFd2GnokQT+Theo9HY5NcJ3f9uE/w/BO53zn5hnus1x8TK6nCiNZGP0bUlyTFbo7GDM06mkErB
 X/70EolLREwIiawciP7UFz1yjRuWifDYXzve8VJVCgj6zysUoAo0sRYZMj89GJg+Y1FE=
X-Gm-Gg: ASbGnctt/rSqA2j/JXTEtj1E1CUyj+GfeKSOZTQUArr6ev7bFJNWMijSkfL3V1lcUz0
 BLEOkkYWaoKEVgI+5qQIijDFC1Mo6XXG8eQft4BDjfFS0QHQIl9cgJ/LAwGGQH1oSDMaZQSRKre
 K+xjdAOmPjc0N0/xNDoFnXz8gnDELAj3I/gGac2JwvmlDOxTJyXkwz37PhZkNLAazFFDfwRi5rq
 a+w4fn+4f+Csyki0a3m9BIlm+q1ZHyeI/l4BVsDOvF7uoiJ0YdV2q/Tu1Ar11V5eHJ5ypCOVmsC
 OVodqPnuqSFqKkInCfCcrdCmli8m3+KFuKweh8L0VU4c0NbRnWcTpd6sER+t4wAETcO9KoMOAX7
 vGd5ZvLE=
X-Received: by 2002:a5d:4d42:0:b0:38d:bd82:2f9 with SMTP id
 ffacd0b85a97d-38dc935122cmr6029821f8f.43.1739101957568; 
 Sun, 09 Feb 2025 03:52:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhoTizo19oJUahZHVTNViwuEvfcqXegv78Qvg+SdlFsVqIXXsQbIoRscTAGk8fsSQ4T8M+fA==
X-Received: by 2002:a5d:4d42:0:b0:38d:bd82:2f9 with SMTP id
 ffacd0b85a97d-38dc935122cmr6029807f8f.43.1739101957213; 
 Sun, 09 Feb 2025 03:52:37 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dfd84b9sm111772795e9.39.2025.02.09.03.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 03:52:35 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jean-Jacques Hiblot <jjhiblot@ti.com>,
 "Franklin Cooper Jr ." <fcooper@ti.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] boot: correct error message in fit_find_config_node()
Date: Sun,  9 Feb 2025 12:52:17 +0100
Message-ID: <20250209115217.85250-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250209115217.85250-1-heinrich.schuchardt@canonical.com>
References: <20250209115217.85250-1-heinrich.schuchardt@canonical.com>
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

If the description property is missing in a configuration of a FIT image,
relating to it as 'FDT description in DTB' is misleading. Provide a
message indicating which configuration node has an issue.

As this situation is not fatal anymore, decrease the default SPL size by
making this a debug message.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 boot/common_fit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/boot/common_fit.c b/boot/common_fit.c
index 4c134e0e86f..7b5bea1dfde 100644
--- a/boot/common_fit.c
+++ b/boot/common_fit.c
@@ -54,8 +54,8 @@ int fit_find_config_node(const void *fdt)
 		name = fdt_getprop(fdt, node, "description", &len);
 		if (!name) {
 #ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
-			printf("%s: Missing FDT description in DTB\n",
-			       __func__);
+			log_debug("Missing description in config %s\n",
+				  fdt_get_name(fdt, node, NULL));
 #endif
 			continue;
 		}
-- 
2.47.1

