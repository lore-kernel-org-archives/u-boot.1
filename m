Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFFAE77188
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF93280771;
	Sat, 11 Jan 2025 01:01:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hLFeGsSl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52FEC80050; Sat, 11 Jan 2025 01:01:46 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3614080763
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:01:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-84cdb6fba9bso185371339f.2
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736553702; x=1737158502; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sg5nkE0DN6pohCK8Ky5lihLFK1ntldKMmd7xrkTjZ3Y=;
 b=hLFeGsSlSA+xxoA/K97MJD3wxT9lqOoyB4iFcgjG2rJH+ylfH9KM98yPGpn8rs2Y2k
 UkShUu5GGgO+Td3sy8s9diohr2MQFD5NBNC2n0UfGjBZDBhEVJkZHzArspfoust0AT6F
 taj14FmVXiJZ8H0M9QwaSUJIWpz3t3pMbKQfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736553702; x=1737158502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sg5nkE0DN6pohCK8Ky5lihLFK1ntldKMmd7xrkTjZ3Y=;
 b=fwUcpdVoc+1jJY0v7wrO1hB7Zn+hIso6hW65EXRyaKiqAFvVNBXdNkcvcUtS76DF1R
 dh+GaFTbssM5Z31qQzOrZX8cm5COSZd0F56ZnZ/ub9r7gcGTZiB9DmHv8JXRelvnQBCT
 rzgpsSKBOzuu/6Zs4f4kVzW5vngg2xhbe9mCBPP3Zfmh/EVdd2+rbZR6vPvHjaazQ8qr
 yx+zvSkFHW51TZ+tF3JE7ebYtR0R4N5bTmFi0nyJZGF8t+ippqpn6C5Q7QX4JRpbJxsi
 seM7C6pIuxI2yTax8lbKKGZZg9ZNspDZyuR/blA93fnCESFSKo90FE9D4kGuxULUS1tI
 3dNA==
X-Gm-Message-State: AOJu0Yxac++m+a/ozctETp3PmdE+3+XoO5OqwRIjUcbwZf551uEh5xZw
 MhTQsj0dPknwqMfle/VbP8dVSJXCOq7+77lzktIvxkrQCTxp37Bl4KWW48Xv0qF4wnGB4TmbuWU
 =
X-Gm-Gg: ASbGnctOKMQKda4YyAvh0NIfyv82SCw1LIrnbaO7De2pe6r4wRDuI01OchmGndDr7Ri
 SZxuJWO+aaAdiAKRt6DK1CbGM9UJ8faRdnTt0T+HyArWzLbUgcvnEs0McnKR0BEJrVfvccQ0A4I
 Xq3heN2LZQY9b7XHW3ZEdbXVLN4Qvo072v+eoGRtyd310IJt1F9TtXeMRJHc5qOGDV1Cn1nehut
 w8ZU0OJGikZ9COVKYKO7GeG3GH83rdiQZAeh0E5lNm6kTigK31ng7o26n2y3Ke8y4LyyKq/taL2
 PlmYpOZugqf9s9xxVw==
X-Google-Smtp-Source: AGHT+IHyhLikqcJ0yv+EcT3oXumFEIVvmFAx8EyVwC69JF8wbUAmso/2Dn3JX5NYjChqYtcYbCe1Ww==
X-Received: by 2002:a05:6602:b8e:b0:84a:7906:21e3 with SMTP id
 ca18e2360f4ac-84ce00c2d93mr1158849839f.7.1736553701719; 
 Fri, 10 Jan 2025 16:01:41 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f93desm1171884173.14.2025.01.10.16.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:01:40 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 23/30] x86: Enable UPL handoff for SPL
Date: Fri, 10 Jan 2025 17:00:22 -0700
Message-Id: <20250111000029.245022-24-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111000029.245022-1-sjg@chromium.org>
References: <20250111000029.245022-1-sjg@chromium.org>
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

Add the GD_FLG_UPL so that a UPL-handoff is created.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/spl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/lib/spl.c b/arch/x86/lib/spl.c
index aad748532d0..7a033505101 100644
--- a/arch/x86/lib/spl.c
+++ b/arch/x86/lib/spl.c
@@ -298,6 +298,9 @@ void spl_board_init(void)
 	if (IS_ENABLED(CONFIG_QEMU))
 		qemu_chipset_init();
 
+	if (CONFIG_IS_ENABLED(UPL_OUT))
+		gd->flags |= GD_FLG_UPL;
+
 	if (CONFIG_IS_ENABLED(VIDEO)) {
 		struct udevice *dev;
 		int ret;
-- 
2.34.1

