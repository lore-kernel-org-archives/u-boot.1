Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372D3C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:46:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0938880815;
	Mon,  3 Feb 2025 18:44:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M3MP+qWf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D0BF800B3; Mon,  3 Feb 2025 18:44:13 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9F7580834
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:44:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3eba5848ee4so1171511b6e.3
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604649; x=1739209449; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+HegFQfN1ciZ+L07ZDDFDM/hj89dk0ZGmDlxBPYrFHA=;
 b=M3MP+qWfZI1JeUiZOHlz9pJe5VWw2UZWJcrEHm420dRxIfSEMQO1BSylcLfmJpuH95
 dZfp8SavoJ7vdgOl3dYXAWXTrv92eGX0FOtF7AQSfxmsV1tX3T+7Rld9A7WzBzqpETWS
 4NKdoMavi5kxeC560uuULdDQeL3QChuEjtqHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604649; x=1739209449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+HegFQfN1ciZ+L07ZDDFDM/hj89dk0ZGmDlxBPYrFHA=;
 b=PSufEXXrGcrUirkMkUCclzX+QO5i9KQwwvuemlsonDgvslbZCQmJGn0lsZ7QYdeLVD
 hiHY61jGXaPLYdrr6tirjMHDKatKuKaQiF4xa3DJa9gRs7Gtqw/Qt3qRJGkpXJSfWE9p
 cVReWMrrEpQmiTnzuSYdDngs46S7IhE5rO3mF8pOMmXOCoMd/UJPe98+xIyeAUT9IQFl
 09Oid9nKWrGQHvrY9hiPckyI4kBNNaLyOmsev1VCqa3Cm10gf3MklWYeBiYlEuC+KCXI
 6C+aNnuTqzjzGecR5dB1ZI7FJD4T0TPI7J4SX66BYZlHilvGDLSjPOyjiRvhdEXQ2Hhg
 GP0Q==
X-Gm-Message-State: AOJu0Yyz7b/NsndFuP80U9PRGH5qyq6mSd2L0CiwVmDM1yP4wN6sYLoE
 uRlBezib7MNJNiLQFzFzf46m4whcRQnsa6vTljj3HchH+adWoj5K27Ho1nBqvm6WXe3Fcy1v0Jc
 =
X-Gm-Gg: ASbGncvw1afnoMNtIAv67T5YTnNSYVNStgevhnT/RJ3kEsRMI8BUs82/PB2iK5RdBvy
 IxFjVdWDLoqt0AgcWChr9n8rko9LVX64mwCzIUO2uUyxECl0O2SAH1svj/Nw+CucYj239aZGaPF
 P+hWbsoPyMY/R4mtzvG9PQoYMWpBeUXF+euU5q2/nc11zIfrlRQnPA68oD3mHMXJ4ed5OBboh7g
 KoyDYEp6QjNm8zD1wkikWY+zjaMMZN5McQ2QY533wvoddj77KKOwTEvtmeVUX1c3Bp1MKbecpai
 m4eI3DYDfbOZ3hdd17SkZIDBpeYQpeFV8hNnmHn1BRRQ1zzlCKsY
X-Google-Smtp-Source: AGHT+IERONbqtBN9KzHGLPk/UD/hqhtYiznJuvJnXMYNJ4dieHpEukqP77uXWUYsDKRo2By262wwmQ==
X-Received: by 2002:a05:6808:2013:b0:3eb:556e:dde8 with SMTP id
 5614622812f47-3f323b3d8fdmr16332064b6e.30.1738604648763; 
 Mon, 03 Feb 2025 09:44:08 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:44:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 21/32] efi: arm: Drop exception code when running as an EFI app
Date: Mon,  3 Feb 2025 10:42:14 -0700
Message-ID: <20250203174245.1331464-22-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203174245.1331464-1-sjg@chromium.org>
References: <20250203174245.1331464-1-sjg@chromium.org>
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

This code cannot be used since EFI is in charge of managing exceptions.
Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/cpu/armv8/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
index 2e71ff2dc97..7bd6cf21b19 100644
--- a/arch/arm/cpu/armv8/Makefile
+++ b/arch/arm/cpu/armv8/Makefile
@@ -13,7 +13,7 @@ ifndef CONFIG_$(XPL_)SYS_DCACHE_OFF
 obj-y	+= cache_v8.o
 obj-y	+= cache.o
 endif
-ifdef CONFIG_XPL_BUILD
+ifneq ($(CONFIG_XPL_BUILD)$(CONFIG_EFI_APP),)
 obj-$(CONFIG_ARMV8_SPL_EXCEPTION_VECTORS) += exceptions.o
 else
 obj-y	+= exceptions.o
-- 
2.43.0

