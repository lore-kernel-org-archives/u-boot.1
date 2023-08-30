Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0056EC83F15
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:06:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77E6B86584;
	Wed, 30 Aug 2023 20:05:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U31ljnwU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C41C58656D; Wed, 30 Aug 2023 20:05:51 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8794186545
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:05:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7923ae72111so2516939f.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 11:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693418741; x=1694023541; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o9vwj/d7yXzuj7AawMW6zuPMBZ2WwGQhf+QeJeeKM+c=;
 b=U31ljnwUUkOtTve6ZQtc80VqzX5vvtVCzVBMkNAGTVI+zof4AlDBVvDa7ora6EgFVA
 e+p1F/8vq7g0GwiSf+1mscqc4sccEiYaEUcitnVXWZxXVXyJriVp+5ZRRu76niOlv+iG
 G/0PVWMW+nXB0mFUQ2S35My2se0hd/rs6pM5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693418741; x=1694023541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o9vwj/d7yXzuj7AawMW6zuPMBZ2WwGQhf+QeJeeKM+c=;
 b=AHh7v9AoeWzwj9fN7ZspQB2TKYCCHvfNNjVg9eZ/l/IXReK3U5n1KRkeKYx44fQc/L
 sSnJs0KhrAgVXzrPKTbk2x/Mcmc69cKvdp94wNqqpi3GtFWax82mzktykiTVNlMILx1+
 gMbpiV03z91053pVJplb9kcnriocvnXPkb5q1ztPKySD6MInuFWAGK/2HOEMhEh+h4xh
 9NtqjrCWD3Z6QW1gONFV3WJ0rUXOzBg4wd8m1A8q54lmWhfVUaBo6VsilKnCF58rZyB5
 jangt3gai0RJ2EEU3/vQ3aEi9wHoNAxNq6fkJDHH9D5UBbXVWLNAXcjsYxdHucLXxjJv
 arjQ==
X-Gm-Message-State: AOJu0YwceyDD3MhJilrke79o4IBtO6S599w4X7kxER0I5mezeCiT2fiE
 A9UaXef47cGjdyQGay1THRwxe/R/63HeIg6Cg08=
X-Google-Smtp-Source: AGHT+IFEu9BU0++QuvOxjRr2CE3fwkkxfvRU9QAFf1zTf+bYNb83pazx/Maw2y7Cte9BFOGpSLunlQ==
X-Received: by 2002:a6b:7a07:0:b0:790:fcc2:6e9c with SMTP id
 h7-20020a6b7a07000000b00790fcc26e9cmr3389952iom.12.1693418741137; 
 Wed, 30 Aug 2023 11:05:41 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dk54-20020a0566384bf600b0042bbd3e49b9sm4002224jab.24.2023.08.30.11.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 11:05:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Andy Fleming <afleming@gmail.com>,
 Mario Six <mario.six@gdsys.cc>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nikhil M Jain <n-jain1@ti.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Stefan Roese <sr@denx.de>, Wolfgang Denk <wd@denx.de>
Subject: [PATCH 05/32] spl: mx6: powerpc: Drop the condition on timer_init()
Date: Wed, 30 Aug 2023 12:04:36 -0600
Message-ID: <20230830180524.315916-6-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830180524.315916-1-sjg@chromium.org>
References: <20230830180524.315916-1-sjg@chromium.org>
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

It doesn't make sense to have some boards do this differently. Drop the
condition in the hope that the maintainers can figure out any run-time
problems.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/spl.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 78db9ef5318..3f513b0563a 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -766,13 +766,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 		if (spl_init())
 			hang();
 	}
-#if !defined(CONFIG_PPC) && !defined(CONFIG_ARCH_MX6)
-	/*
-	 * timer_init() does not exist on PPC systems. The timer is initialized
-	 * and enabled (decrementer) in interrupt_init() here.
-	 */
 	timer_init();
-#endif
 	if (CONFIG_IS_ENABLED(BLOBLIST)) {
 		ret = bloblist_init();
 		if (ret) {
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

