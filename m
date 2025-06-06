Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B72C5B549
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 07:22:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D800C82977;
	Fri,  6 Jun 2025 09:22:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wt95zBFN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32C1682977; Fri,  6 Jun 2025 09:22:13 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A65D82B00
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 09:22:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-450caff6336so10387765e9.3
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 00:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749194531; x=1749799331; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sM2ZfKEmSjfAliaO9YFa9oHit56+8uL84aWLS29x2lo=;
 b=Wt95zBFNeOFQlfRYT7L38imqUrd60XrY3O5AW3aA70mMALUjgwGwUoF35o/NjGV58y
 /sUuqRHrH9gD/s+MFRebX2qgYqFJm5YMzjNFiE+ZaXBVO4Y7g9jaIJTtVTijVbDn17kQ
 gFAKu6TIA5S7e1Bu70Sl52qLd7ku71vp/hfpvgc/ZR/nWxljNziwlPwV4B9wZC/iDfNU
 VE/WBk1hOuB2wgRE7XVCZllDGwVcw7Q7Je9hlf1gOulZ4B2YDXi2L5wrJArBT62ddGmR
 /yI12DWKrc0PBsIZzgHqqlBT6RBbsr9aiSrVRu4+x5pHBnEm5B7/ex5pPVWpPOhlGhoI
 CcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749194531; x=1749799331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sM2ZfKEmSjfAliaO9YFa9oHit56+8uL84aWLS29x2lo=;
 b=k2kN9c2qiWWs2khuVGiSfOS22KTj+L2Afs9KldLimrxUDB+HfsSsfNZkKbSJLsIhDa
 TlGoR7plGKUSrbq+VDgiKGHlEvw+IpFoahsTRvNi9N5AT5uVilnUUNmh7OIWi7LLFCu/
 D5un6MR9ne57qczwgP47ECJ/Xh749fx9oMocOkgLapXidncp957ak61n0NB2Q3Gglu3P
 lhr+j5vPEakMOco99+Oa+ItRaoSJm7cbm/IybAqoV1JBVamSMKOutsuGs03PgqmlJF4t
 XdxvOLiPnbF4WN3nrb+MU38k8i0aVjVoU/XuCb1WjUqqd/HVMBBFyjAz+Vb6ff/sHKY7
 UQsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGvONNSZRhdFmtQqDHrlipyAGey6EBzJAZ2GcryUfU5GgRsef9lhfgatj2OQR++fNtH3CEPR8=@lists.denx.de
X-Gm-Message-State: AOJu0YxExPgNqsmjoSgNNSUjPOtPwIo10zwQLAYtGjfo++z9NB/yqUjq
 CQ48jnYLLXbQj2J0/DVMIq8rRbUim212nHH+Kp+k2Lr55i9pEZhTh4Rr
X-Gm-Gg: ASbGnctTbn7LnBZEdatRn8V8auLEVMSZeFXCER62iKqjyiySIsJXKGLb7hez5JH+Gvy
 osixWUB+13Ql3wsJeQ+qlSCo/AA0BMuKSVl33sQGzNI3Xop2viKXsYWJ9ZK7w4K32bqrJWcapJs
 fODw+BhkevkbEe0J3zkuH77FLDTgPsiw3qrqxcje/zB9POMukWGQGwBsoZyraC1Cd/glYEdD/WR
 qfqc9WzioXbLLoCUBktMgTKu9deg9RCK4U//fVXlvIuCIzLe3RWBlsKcPPihPhdxBTVPFRYjsp7
 vPcsOPi2slYbZ1YKnZgc0VYyn/RccVvfZP6Cj0GnEVVQqx0/sTQJqJAMJqjLT1ugDk+SDjAW0E/
 SCH5RRX5mUOBl4nVSVbZqolYvMIcpW5UJle4PwaMGNQ==
X-Google-Smtp-Source: AGHT+IFKyTYmgyrQdWPo9UdhFZ5BC9QILIYqDjbd5Kj1664BlfIzN6p8ZSuroyLeZKbFwrhqPN8bLg==
X-Received: by 2002:a05:600c:3492:b0:451:efb0:a2ca with SMTP id
 5b1f17b1804b1-4520138dcfdmr24665875e9.12.1749194530692; 
 Fri, 06 Jun 2025 00:22:10 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4521375b5e1sm14666295e9.37.2025.06.06.00.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 00:22:09 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 4/5] arm: apple: rtkit: add missing header linux/bug.h and
 linux/bitops.h
Date: Fri,  6 Jun 2025 09:21:33 +0200
Message-ID: <20250606072140.18824-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250606072140.18824-1-ansuelsmth@gmail.com>
References: <20250606072140.18824-1-ansuelsmth@gmail.com>
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

The GENMASK/GENMASK_ULL macro requires inclusion of linux/bitops.h
header. It did previously work as bitfield.h included it indirectly
but now this has changed.

Also raw printf require linux/bug.h header (also previously included
indirectly by bitfield.h)

Explicitly include the headers to fix compilation error.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/mach-apple/rtkit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-apple/rtkit.c b/arch/arm/mach-apple/rtkit.c
index f3561543a35..251c6056cbd 100644
--- a/arch/arm/mach-apple/rtkit.c
+++ b/arch/arm/mach-apple/rtkit.c
@@ -9,7 +9,9 @@
 
 #include <asm/arch/rtkit.h>
 #include <linux/apple-mailbox.h>
+#include <linux/bug.h>
 #include <linux/bitfield.h>
+#include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/sizes.h>
 #include <linux/types.h>
-- 
2.48.1

