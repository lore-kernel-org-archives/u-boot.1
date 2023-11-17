Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106DAC54FB9
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 22:52:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43AA886F1F;
	Fri, 17 Nov 2023 23:52:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Kl880yTz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99BB486F1F; Fri, 17 Nov 2023 23:52:28 +0100 (CET)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B25D86ECA
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 23:52:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-45da94f4b90so971411137.3
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700261536; x=1700866336; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6ciua6Hc41YHJabaXnKKw/2sOSXf33u+WMuyrvwP+Xo=;
 b=Kl880yTzKl51DonFAcaIvTwdHnq+JrPlIIuMswJ4CCiyTB0fIuZzzl3XXuyIdqC0Tl
 kZWhai1SNbWqqogOE8nrX6Vg6raImkhrT0uEG3tCU4Se8s3TS2FUJQt1tWf1ozeu1gGQ
 2SqZWzNBskAkY07gTcak4j0lVj7FXGOpEM5Ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700261536; x=1700866336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ciua6Hc41YHJabaXnKKw/2sOSXf33u+WMuyrvwP+Xo=;
 b=aZ6ZWb/yd8s0r8BVnTKpZyL7n3FSZuimw1h0IqlsbMnY2GfPLfpYLAWal8usqTUoEC
 STvba+rqP4Hm0h7rigQE2HE+he7tAr+EnKo+gExur2RrVCUFBDUkVIRJJr0FwSS5b+tq
 eb2Iq4+SKCOxwBcgcrcXuHRO1s1Wjl3C1+QWaUfEMFPByhEiQOT4Xybq+kE0ujNlgWEj
 VUouoTjYVfWGTtQ1ePZtMHQeBHMb22JofSnihtrAo+QWNBblr+t9kBuJ0Z3n1zTJ7AG/
 gMsbhrEaAVa3ICRkHjgqf2qti8GOfBvjOeaAh8bocXbO8+gMufiHZ1ocm5q7JIOMTWzL
 XC3w==
X-Gm-Message-State: AOJu0Yz7T+KZ88IlelHKcY2/+832fuorMBS+hOHLBBrl/f5Y6GIxNxnn
 gKLChc91Tr+Ybq5vQNfLWPtyli4wvdChg/WHQIK9Ag==
X-Google-Smtp-Source: AGHT+IHgKC7+DW5Ot6eqTxnFVn+YlWsahwyhsm+sKLaC6kt2pTKiL01rLyShQSOuc7zpu9Zc7HpXug==
X-Received: by 2002:a05:6102:2f6:b0:45d:9e12:a9eb with SMTP id
 j22-20020a05610202f600b0045d9e12a9ebmr927127vsj.11.1700261536000; 
 Fri, 17 Nov 2023 14:52:16 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-dbd8-aafa-ccfe-bf84.res6.spectrum.com.
 [2603:6081:7b00:6400:dbd8:aafa:ccfe:bf84])
 by smtp.gmail.com with ESMTPSA id
 f21-20020ac840d5000000b0041cb8732d57sm895425qtm.38.2023.11.17.14.52.15
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 14:52:15 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/2] doc: Update board_best_practices.rst to talk about dts
 files
Date: Fri, 17 Nov 2023 17:52:14 -0500
Message-Id: <20231117225214.2144414-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117225214.2144414-1-trini@konsulko.com>
References: <20231117225214.2144414-1-trini@konsulko.com>
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

We do need to list device tree overlay files in a Makefile, to ensure
they are built. However, everything else should be handled via one of
the CONFIG options.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 doc/develop/board_best_practices.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/develop/board_best_practices.rst b/doc/develop/board_best_practices.rst
index f44401eab7d4..a5930be10f78 100644
--- a/doc/develop/board_best_practices.rst
+++ b/doc/develop/board_best_practices.rst
@@ -24,3 +24,7 @@ which are specific to creating a new board port.
 
   Kconfig fragments should reside in the board directory itself rather than in
   the top-level `configs/` directory.
+
+* A board may list device tree overlay files in `arch/$(ARCH)/dts/Makfile` but
+  all device trees themselves should be listed in `CONFIG_DEFAULT_DEVICE_TREE`
+  or `CONFIG_OF_LIST`.
-- 
2.34.1

