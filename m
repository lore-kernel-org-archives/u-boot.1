Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13BCCE7717F
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 10:53:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70CDA89515;
	Sun,  8 Dec 2024 11:52:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FY6gCDCz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BD6B89515; Sun,  8 Dec 2024 11:52:48 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D2A38954B
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 11:52:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a9a68480164so447443666b.3
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 02:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733655165; x=1734259965; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iMp5c3d4w227EBQRr8iv9j9OVqGRaUTFIpDzyMLlBVk=;
 b=FY6gCDCzAugb3eYYtNcCGLeq2PQewYJgZngDZ4v4CbbdLF0TCm1oB51MxHZ0itFEH8
 YxSklHb6mkTZo2EZOrjvYK1JqLvMKYAFZnUm5zamfsk3Y/TIbPRivCoaxS/DhUrImbKZ
 Oh2DP2aBI32dBDhz0fK15U+B5vCYNjqDudRRYe/UWN+9lcjubcNjKA5DJcF9NiBCov6H
 oY7W99pD0SxpGk/Eu7SDVs0UqjB5JbTHzEpks2L9ebGRlh6GnY2dVFbZr4XG7rIq5P2w
 Zen7F5M/Vi3dLEZZtleKRqJ+HnpLwEZQRaHh3YBsO69nirdbw+YQtUmK55sHYvY75JqG
 zCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733655165; x=1734259965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iMp5c3d4w227EBQRr8iv9j9OVqGRaUTFIpDzyMLlBVk=;
 b=JFZQFPtfPzAwl4/j0twjfGItZv2HWRpQ6AmDBjxXCGzCdj02kMdCqDpUa/cDM2fRJm
 7yC8ll59e6O5ZUv2EvAb37F9FerjpLTKG955uUjsxxLom0VhUB3EaaEZ1V32Xeb/mWu+
 1OvWsmni95VCCvc3sEyUUwjofoGz1uGGq6rkwRaoi4M9pI5dYHEMLoOXJvzuTgARQxN6
 GSoqqUhy7JqLYtlq0unImLjjcwSLO3tiiXuJ+lWEpwQcnXK7FZVZydnK+81v3EzOklIP
 sS2afz3ugBh+cM5FV2eUs/rNY3LaE5B/WXQgFSo9tSsNL0LZu6SiqgVMU7Iz1aelKXDi
 v6Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6qLzFjWkLA2zSX3u6kkTveXvbmPZshYQq12mpS3vHEBdgjPAn1VfCbthl1WKfOcwgnK06OlM=@lists.denx.de
X-Gm-Message-State: AOJu0YxEKSaTZVVwiyCgN1vUsYM29AAUDmmdMbsJ07Mo05UCxaWDXX0j
 LnCz+KcGDHLDngnO86EZslfwFDCYCgUCkA4IK02d1Me4wVu2p5djaO42nnHLJvg=
X-Gm-Gg: ASbGncs8Oo5tL90e9KrllVyGhehCs8LhdxI3iMIkXabjmfVVgZtLK+dqSLT0v8ACD6t
 hWrHZIiZ4/X4/9xJPQ7VJ0sqzCLR+WX9y30z/j71vzmvzIrsMzNRtJO1hL6QbfHSo/R4O4nCHiy
 NE4ca9T18zVi0T36hQ8ZOMsfpwHQdT2IVcgf6iaYk3KFUXvnb7SjBk5aq/0GLtgJgANIhMI2yKK
 AzqLo+xkYELbyzfrUjaQdGMMyOgulUsYpoSnlMRtESvdpA/kKULAyaPQVKUQonPh3JxMj6m2FoZ
 l6rSgDFzFAy/Dr5fyJuDuONvMU4=
X-Google-Smtp-Source: AGHT+IGbbLcFrnXnMi3OVX7yDwWBb0eRwDpfM51wDDIJdTqLRtBjn+FhEbpLAnMzsKVPNIaHhjrh1Q==
X-Received: by 2002:a17:906:1da1:b0:a9a:161:8da4 with SMTP id
 a640c23a62f3a-aa63a2432c6mr699458266b.55.1733655165437; 
 Sun, 08 Dec 2024 02:52:45 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa625e92fe3sm517768566b.51.2024.12.08.02.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 02:52:45 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Nam Cao <namcao@linutronix.de>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Janne Grunau <j@jannau.net>, Caleb Connolly <caleb.connolly@linaro.org>,
 u-boot@lists.denx.de
Subject: [RFC PATCH 2/7] lmb: Simplify lmb_addrs_overlap()
Date: Sun,  8 Dec 2024 12:52:05 +0200
Message-ID: <20241208105223.2821049-3-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241208105223.2821049-1-ilias.apalodimas@linaro.org>
References: <20241208105223.2821049-1-ilias.apalodimas@linaro.org>
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

There's no point subtracting -1 from the calculated addresses and then
check for a <= b. Just remove the -1 and check for a < b.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/lmb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index a7ecbb58831f..c7bf5120696f 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -36,10 +36,10 @@ DECLARE_GLOBAL_DATA_PTR;
 static long lmb_addrs_overlap(phys_addr_t base1, phys_size_t size1,
 			      phys_addr_t base2, phys_size_t size2)
 {
-	const phys_addr_t base1_end = base1 + size1 - 1;
-	const phys_addr_t base2_end = base2 + size2 - 1;
+	const phys_addr_t base1_end = base1 + size1;
+	const phys_addr_t base2_end = base2 + size2;
 
-	return ((base1 <= base2_end) && (base2 <= base1_end));
+	return ((base1 < base2_end) && (base2 < base1_end));
 }
 
 static long lmb_addrs_adjacent(phys_addr_t base1, phys_size_t size1,
-- 
2.45.2

