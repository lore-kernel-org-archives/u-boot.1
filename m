Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5E4C02193
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 01:56:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D759F805FF;
	Wed,  5 Feb 2025 02:56:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GZJrSYPF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D379807A8; Wed,  5 Feb 2025 02:56:35 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E2A880040
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 02:56:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5f63c89e72bso1452748eaf.1
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 17:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738720588; x=1739325388; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hhZkvW/LkNVAL2E2Rz9Jc4JmnPZlIqxjOA22tYY5Kjk=;
 b=GZJrSYPFqThZs+GJIsy2sN2tN3PW8rcJUnpxHBKRX9VQeBT3QCekTiXnxSOm+7mdgB
 fmncJzl44kCUwYaJsMVdsnMFpkul30qLfoBi6PjbPLycJcvs2jnSHKsSoM1ENeDUtb3e
 S5ee6NY3ZDsLHFVIR2Cbu/Qs3UGO5RyE6Yzv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738720588; x=1739325388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hhZkvW/LkNVAL2E2Rz9Jc4JmnPZlIqxjOA22tYY5Kjk=;
 b=lntGzUfV3OVmo7UJNo9gUxLywKzriVR9H+9eHx91Uyv5JOh3xVtinO5hPLmH/Ev0sH
 6/t3WidlfRHi0Lk5GSlY56l9iQc8RwaVnvf5pVlHQsEwugMFsvzrqWeEgyBT1IHFnhCy
 jz+cQyWI3yx+XHEQH+KeoEnA3Mj7Vc6xOK1LgjMnx0HjtYkILbPUbD0oeAwKjFa4RG03
 1oEywIoaXKwZogCPNLNuRUU8VXmbNOVXSFMgopST5bkdRuagT4Dd0JQPjxkajSXUfx9a
 NhbsuJ/dLUBGWlYGxyd0G+QQHgrzhcqHEyHWwAK3kdFgUefIxuBlmZYsTyxtdOl2N7EF
 SW/A==
X-Gm-Message-State: AOJu0Yyt6qtKkq+PKntHe0Hn3ltfdWHZRJg7zlo6DV1m+/POiyXoU6hi
 2UdoXp9jNhaZkyoxPf0IbgRnB+bCzE82tlvYT3R341dHn4AWQzgeByhzntBF1PVAVVJ3JUaCQbs
 =
X-Gm-Gg: ASbGncvvhLPeoN3iIV8Wu/+tCWFY+K8IRDc/qg+FSPZb0o2ASHccD7pWuAo52x6e5eK
 WRLpDIL86Aun6uj25jxZparPue2PYQ8tfml6OHDZ75ia2unHyvNUHYGHVjsU7sBmkAe5Ma9Dr0w
 VIZJW21Sttv+KsVS7R1ro+YZeU4QpM9KLl4u7txKvPyv1zyHHP1QI7eOWdIq3xmLtW96ab8Y9hZ
 7qJ/qUKyGSh0atPt1fMSb5avrc3+be2cn1pwWELeVRhRzdpmly/beczyWR2U8QUo7AzmqoK0ZLK
 0SyuNw4G35FseZyo3q9R6nVDlM52FnK37jnIDDBr+f+M4dTfG7S9
X-Google-Smtp-Source: AGHT+IFzuRjhHLohNFqgvVe9p6TD8gXm6AL9kXqFuBEJLxenyLTMHYfxVn90NekR6wGcAcTvOqzGsg==
X-Received: by 2002:a05:6820:810:b0:5fa:840b:19aa with SMTP id
 006d021491bc7-5fc47989ed0mr878536eaf.4.1738720588295; 
 Tue, 04 Feb 2025 17:56:28 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc104c2e7asm3543676eaf.12.2025.02.04.17.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 17:56:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/29] spl: Allow VBE to handle xPL size
Date: Tue,  4 Feb 2025 18:54:53 -0700
Message-ID: <20250205015606.2686149-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205015606.2686149-1-sjg@chromium.org>
References: <20250205015606.2686149-1-sjg@chromium.org>
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

When VBE is in use, the size of each phase is obtained by reading it
from a FIT. Avoid using binman symbols unless necessary, i.e. in TPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/spl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 6b75910e243..e7157df1ff9 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -200,6 +200,8 @@ ulong spl_get_image_size(void)
 #ifdef CONFIG_VPL
 	if (xpl_next_phase() == PHASE_VPL)
 		return binman_sym(ulong, u_boot_vpl_any, size);
+
+	return 0;	/* VBE handles this */
 #endif
 	return xpl_next_phase() == PHASE_SPL ?
 		binman_sym(ulong, u_boot_spl_any, size) :
-- 
2.43.0

