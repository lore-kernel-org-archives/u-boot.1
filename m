Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8561BF54ACD
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 15:33:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9E1180212;
	Tue, 24 Mar 2026 16:33:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3Ewq10Pb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4EAD80517; Tue, 24 Mar 2026 16:33:45 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A359680087
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 16:33:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-486fd5360d4so16092145e9.1
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 08:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774366423; x=1774971223;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TOiDhle0PnY0wck/VOrs74zYzASRvEfrRyQ8rF9/ZA8=;
 b=3Ewq10PbTnWq2ZvITq6QIBylFhamuxLS5Oj61JEUfVZxhr29ixawOg/PM8In7XBKJe
 0ieJkz85L96KnsBMDAvOpyEmmyq+/DMrQnVjj5/Sct72LoDo8RiXkjMmyGQECHHs8KKo
 O4jX6vgJiCobvNFRouaPVXW2SsLCZpF91FFuHuM2EwPi4R4C0qGjcuCObdDoJ42GBWrM
 zflYRddehLt+5K/ysRLywXZH9VmNLXLJ8WCekDqRD32FfaAlC5he2ggtEVVFnua8TK8N
 LG4BT9vCtL5rLWEloDcqe6ekZnuPh62OTsqUGybK0kC55xijEhaqu+WC6F7OwUxByvsw
 9aQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774366423; x=1774971223;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TOiDhle0PnY0wck/VOrs74zYzASRvEfrRyQ8rF9/ZA8=;
 b=e7+lX/m0cpU9oftLpW6GlDln0IqG4hCz9QtEXq7vZvQRnQ1YliZEfTTbE0YwV4/gxR
 lPUNZLo8wL6sZzW5QVgzojezZ7zksi83ylA3RgDkwwlbXzX1QAVk98RnTxwE1pvbFNdD
 rrVqd2kv74gN4ATpXqN/VwDmCG3nNlLsVj2BFznQBM4wuvDBNpZPu/5qH6kEWntFT9O8
 D5gzAF1N9j3fTF208ZSxYGNGLjrkDZTIPXy26/yxFtFjMBE9T0s0viGfKhGwCGQkO/pQ
 AfIr2Lq2cf8N9BrBTtHyBdp84bHYp0cyf0PqrvFCC7ygs1OKo+h89V3I/XclcMzpcUQx
 K6Bw==
X-Gm-Message-State: AOJu0YwR4P/942BRaLtKSa3aMMncVyMmmOgfp6jLNLwEmwBnaBSKpWK9
 k1akCF8KO4hEWT3zoSIUP89Hx8hDhaDtxF7CsYjQLw4JaOBRmmVbPJ3KewEHTbY1+6o=
X-Gm-Gg: ATEYQzwQJQUmydy52zV+r3RA5sTkB1V0203ir2BCM8CdBdAF7tH9AnSCNGe5POa+1Oi
 IXKdKfQz7jxw+Y37r237PzRc0K8p4I42A+/y+fbBBtZDU8eNkPcwywBl1hHV9elxnYzhRXDHITR
 3ZBiSFnSTb/wQ3p9t7L9goYEqHj9WbwnevEMoCz6vaTGRNMYtx9PPpS6GQKshJokmWSjbm58nw+
 2yJ4fOpu6SYwg0EOzoASfIpGcRvvgZv6zOuV33sF/KMbk0wLpRTcXtxzAMOoxycwXeN8wTbcgK5
 r3YpYV6l+bT7hdof6zsl0TVhPuhNwGl6tJa3iFYU8zxFJsG2GR3IdyKlWhsshAu7S5zBVfs9CyL
 lm4Zzbt1VArmkPjWrntdm21iLMN5Vr5ceo63dIZk5ERzza5QhKMd4nAOD1bDNpXcnDPhMYvWAvp
 uZ6K1QSS8s0ha81Td2Qt3/fGdfgkgQ6CFeMdcgktAONYG3WVypJmbkYggirXJzRfJeQYBQ/JsMI
 X/uvxlEtTPRtG2B6qJwNEJlVDEcc/oQ4lmrFoSS7Quei03HMoFShz1f58LXXy0F9iMVygSu/eYr
 WSm1Sk0=
X-Received: by 2002:a05:600c:1e8f:b0:487:36c:f5ab with SMTP id
 5b1f17b1804b1-48715fe70f2mr3178925e9.10.1774366422901; 
 Tue, 24 Mar 2026 08:33:42 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644ae619sm39934003f8f.5.2026.03.24.08.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 08:33:41 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 24 Mar 2026 16:33:45 +0100
Subject: [PATCH] boot/fit: remove useless else branch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260324-boot-fit-fix-8-byte-alignement-for-overlays-v1-1-257b132b6bda@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NwQrCMBBEf6Xs2YUkLVr8FfGQ6LQu1EQ2pbSU/
 rurhzm8gTezU4UKKl2bnRSLVCnZwJ8aerxiHsHyNKbgwtm1oeNUysyD/LJyz2mbwXGSMeONbG1
 RLgt0ilvltvfJRX9JQweyxY/CrP/b7X4cXx3kQhZ9AAAA
X-Change-ID: 20260324-boot-fit-fix-8-byte-alignement-for-overlays-381b0a17bf4e
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

The assignment of load = data is already performed before the
if–elseif logic, making the additional assignment in the else
branch unnecessary.

Remove the redundant statement to simplify
the control flow and improve readability.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
While doing some debug on overlay loading, I notice this useless else
branch in fit_image_load(). Let's just remove it.
---
 boot/image-fit.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index e7c7212195f..a0864bd0906 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2281,8 +2281,6 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 
 		printf("   Loading %s from 0x%08lx to 0x%08lx\n",
 		       prop_name, data, load);
-	} else {
-		load = data;	/* No load address specified */
 	}
 
 	comp = IH_COMP_NONE;

---
base-commit: 1ffc541eafc96d5eebcf837ab892dccec3b93568
change-id: 20260324-boot-fit-fix-8-byte-alignement-for-overlays-381b0a17bf4e

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>

