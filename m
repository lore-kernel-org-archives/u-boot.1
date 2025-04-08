Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A0EC369A4
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 15:36:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F38A82115;
	Tue,  8 Apr 2025 17:36:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="HJLok5CP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6912F82125; Tue,  8 Apr 2025 17:36:17 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 561EC820B0
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 17:36:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9495D3F479
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 15:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1744126574;
 bh=itPNXvwE9ll+F/40wqUka+NWHi/DHfZmul/8H92n3kw=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=HJLok5CPK8mPx//nIO6MCGAOmsIyws4i48xaDOFkcSQLPAWK0sWZ2NH5Y1Hwd3tvB
 uCIvgGQ19ux3+Y/5RKODptgjPXV9RluZ/WW+FcoWCo0NFzWGB/l2UkVxSlgQZGCIkM
 mZdCgN02A0sh1k12nshkcKZmf19K2MAa8GnI6jJN9G9RwC90F5we4RoqIteQ8XmISu
 Dj99kXVPHG7oNfFAT/xbSHK7/F6cuXDM4ix4jQ4bzs+Uh49w21NXYT4mnjplPbBfTT
 QvlggnHvyQjXT9iBjZAgMRSOaKTcOoQ2+9SuYUhIODDJc6fZtHCBlWpfetEXeHMrEa
 q0mPYV2mkEH+Q==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d51bd9b45so39577005e9.1
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 08:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744126573; x=1744731373;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=itPNXvwE9ll+F/40wqUka+NWHi/DHfZmul/8H92n3kw=;
 b=FcQylEqFXE7w7KtpxVQ8zsg23CZ9w5vuuI9KtE1DswkUsJxS32gSVe9Smbpn/vcEf2
 tcsAuSQ4OpPMbThRxKKRq3Prhc91hTWMdPkjzDVsgNHFbhfouUGRzw86Reeoa18OlGpG
 GJfz46I6ofSLE7CrmmSz/hSRPvIGrF/SoWA4uLRghkNnRAh2izKV3Wdg6O1Ev1GX8jrT
 Q2Q+cam/yer6DSbxFFQUpnbuYLTfuJFLMLk01Iibo2wWM3HkYvnb30Tug8c6ubiNNaxA
 lQlu0Yj0qPXLJy2Wb4dtZlsIsKXCuav6V5jvrfsNAO/RcxVf5dOkoK2Wfdv+s3T97qmP
 6h2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCuVnzuYiUuHdUdmGSUR7/IF9vzbaFLjT0m3nQ3eXrZEy4TnmpCs9bKYMwuEmLVF6AzzPj1GA=@lists.denx.de
X-Gm-Message-State: AOJu0Ywc6gAbMo8LokDewRNSeq8Slx6P/6dqk8EgvB0s57VESXaIkXJl
 EBDO0giPpdpomM50E/BKBP7GX+FdlDFAsOH4DOYQDFNNy702/WINSsx7lFqIh0eFoZkfsLUeKdN
 5cENQEUCKHNtxb/dkg/IElBlqAbSWYR+/K8A/YOyBYX5UKK7R2f05DvljM6Lk8Gk5HLE=
X-Gm-Gg: ASbGnctwlG0DtXeQdGF8wOQr413W5kt7pfa0hdxEbWBgWhnQINmoaGTbNPbQJ9q1yQ6
 E2rNGyjcQFbfXCQa4SsSTEGlMWQHi3rxo+UAyXR9zmhp37T7Bm65w4qNUvYJxL7YnIPdDihS0eT
 BWpIZctw3KoxbKaLQQ2YILseHLhFmwvA4bdyUd1LyQhcYxJqY2/u7GFG+xHvUlHs4XFli/GlJjd
 0OnFDeMZjp0eu1kR2JeAGRXBLDecPg6SxsGE/39h/xRGmZmu8d2epn5NQtHjSNKDe/uDpzAsvEx
 cYS+NNvWar0x6bVwK4/9pqZlE7JzFc5XWiP4wFq4wFosPLBk7k4xX2K8Ohku1vtOFUmajdtN1Cq
 hpZ4ajo/e15w6fuGqwg==
X-Received: by 2002:a05:600c:3ecb:b0:43d:7588:66a5 with SMTP id
 5b1f17b1804b1-43ecfa06563mr176417585e9.31.1744126573420; 
 Tue, 08 Apr 2025 08:36:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9pvDOFoFw+TkL80xtEAQXE5xUiTsWE+ydiRkxuYBvAFYxo/cgFXn0v305Pag4ZLOJ28HP1A==
X-Received: by 2002:a05:600c:3ecb:b0:43d:7588:66a5 with SMTP id
 5b1f17b1804b1-43ecfa06563mr176417205e9.31.1744126572989; 
 Tue, 08 Apr 2025 08:36:12 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30226f1fsm15374845f8f.95.2025.04.08.08.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 08:36:12 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: update Python requirements
Date: Tue,  8 Apr 2025 17:36:06 +0200
Message-ID: <20250408153606.118149-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

Update the Python dependencies to the newest releases.
This addresses CVE-2024-56326, CVE-2024-56201, CVE-2025-27516 for jinja2.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/sphinx/requirements.txt | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/doc/sphinx/requirements.txt b/doc/sphinx/requirements.txt
index 13e0327c0f6..01a9d287a7a 100644
--- a/doc/sphinx/requirements.txt
+++ b/doc/sphinx/requirements.txt
@@ -1,21 +1,21 @@
 alabaster==1.0.0
-babel==2.16.0
-certifi==2024.8.30
-charset-normalizer==3.4.0
+babel==2.17.0
+certifi==2025.1.31
+charset-normalizer==3.4.1
 docutils==0.21.2
 idna==3.10
 imagesize==1.4.1
-Jinja2==3.1.4
+Jinja2==3.1.6
 MarkupSafe==3.0.2
-packaging==24.1
-pip==24.2
-Pygments==2.18.0
+packaging==24.2
+pip==25.0.1
+Pygments==2.19.1
 requests==2.32.3
-six==1.16.0
+six==1.17.0
 snowballstemmer==2.2.0
-Sphinx==8.1.3
+Sphinx==8.2.3
 sphinx-prompt==1.9.0
-sphinx-rtd-theme==3.0.1
+sphinx-rtd-theme==3.0.2
 sphinxcontrib-applehelp==2.0.0
 sphinxcontrib-devhelp==2.0.0
 sphinxcontrib-htmlhelp==2.1.0
@@ -23,4 +23,4 @@ sphinxcontrib-jquery==4.1
 sphinxcontrib-jsmath==1.0.1
 sphinxcontrib-qthelp==2.0.0
 sphinxcontrib-serializinghtml==2.0.0
-urllib3==2.2.3
+urllib3==2.3.0
-- 
2.48.1

