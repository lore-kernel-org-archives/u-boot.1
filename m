Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206D8D16260
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 13:18:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E988891D0;
	Mon, 14 Oct 2024 15:13:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Z3V7oBOD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37068891E1; Mon, 14 Oct 2024 15:13:14 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE52A891B3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4305413aec9so41513165e9.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 06:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728911591; x=1729516391; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o0y2fOVyD+icRBtf7f6CfcDIS1ruayl7XHPLwSR33SU=;
 b=Z3V7oBODZBklfMRLwJ6SSWsLDrWK77gvgbmsg9nkIodhbLCL/Ep3DyzeRoeQrCpZOs
 uWa/NM+EQmlZdU/dlqKXarsQVL0/jElXrvED0Nl5dFf5eLO58Ie2p8+xwj+O/jDjixOA
 GNyCEwUIYLcZdhuiZ/AJrfujVEZ/6yCBRgHEI9xeSCLW7FzD2l/F9er1xi63Xp3IQWpU
 OKqc6AH4LXs4P3vY9EDVdWJx8MhzQDyvWAshAZ6hnA3RvfLXa0DADWT5bVD2qgWbnK2X
 CYt9Ja+cMguDn4aecJPIPYu2j9apQO+km3q5Wr0T5d8SrIlCo4c577j5C/7yOlZhDvg2
 gIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728911591; x=1729516391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o0y2fOVyD+icRBtf7f6CfcDIS1ruayl7XHPLwSR33SU=;
 b=IeRx15G4ay0nBDjW1TbKqlGfgg85TgJa0+4p5eXNjqTF7XJCT9P8HEnLnsSXw8NnzJ
 tiTrra5CQKfTL4OfChEeFxdD6H4JHD+TVKwO4HLKddX1m2blEiioDDquJuraqO/oTADO
 0VwDrQxf3bouG5GE8uNIAm8fDXV/MYLCebvl/pkO8zhWU6NGKR+G5pNGqvgXyArQdLJk
 jqJ082fqVikSRiRfMOwSHhBn33314YPNzo3X2rEp8GjHFrbMToTol4cH+VuarKEVTRPE
 6MPNbPUTrthPjKYz1QVxXYczBGvg94gQ01fteBFk1bRIxnyNgLS/38as7EUPrP7Cmnym
 VTcw==
X-Gm-Message-State: AOJu0Yy1NPTYJMyzPOXmx5qepA4STKIaN8MxWWVb6UcYoLF3j/+PxNus
 j8QkA5s1J5YTfjDb0/UI0FdpuGnEEC/I3UCg1wuWJxGHRLXm2wqsvjh+xgKGUd6y5C3QCOGCLD1
 f
X-Google-Smtp-Source: AGHT+IHOoYlvcJQ1pnE65pzpw5C0GkcYdH9az4L45bbIkQ5nmWMsFzKU2Vv84I9vMO9ZCIXC0xd/FQ==
X-Received: by 2002:a05:600c:3588:b0:428:f0c2:ef4a with SMTP id
 5b1f17b1804b1-4311ded3f5fmr110753755e9.13.1728911591199; 
 Mon, 14 Oct 2024 06:13:11 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d605c197bsm7103718f8f.38.2024.10.14.06.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 06:13:10 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 35/37] bloblist: Fix use of uninitialized variable
Date: Mon, 14 Oct 2024 15:10:51 +0200
Message-ID: <20241014131152.267405-36-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014131152.267405-1-patrick.rudolph@9elements.com>
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
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

Initialize addr to zero which allows to build on the CI
which is more strict.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 common/bloblist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 2008ab4d25..cf1a3b8b62 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -499,7 +499,7 @@ int bloblist_init(void)
 {
 	bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
 	int ret = -ENOENT;
-	ulong addr, size;
+	ulong addr = 0, size;
 	/*
 	 * If U-Boot is not in the first phase, an existing bloblist must be
 	 * at a fixed address.
-- 
2.46.2

