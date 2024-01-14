Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64140C4707B
	for <u-boot@archiver.kernel.org>; Sun, 14 Jan 2024 13:19:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D28D8799D;
	Sun, 14 Jan 2024 14:18:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Gonb/kE1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D780D87968; Sun, 14 Jan 2024 14:18:44 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6BA08785A
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 14:18:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id BEFA141BC5; 
 Sun, 14 Jan 2024 13:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705238321;
 bh=q3y+8Y9q2+DFziiiCOeCuUuWEuiwJtHfmn03URd1Tvs=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Gonb/kE1Bn756s/6p22fdJKNQBEFK71VCVr74jdr10l8PA9kp3ooilIt/n5nQIOVf
 U8DjajleQk5cEPmGhLJ8UsQNIdXVmrHbB1cnR2z51zbyUtvNBUmeha5nb9ttmgtiPL
 LBCSxFfkuizZJ55XV4V/FMTF3hoJi5aI9sCZJo8c8HUFPoDQgsdyPwq7xrTgefS/iu
 vTai734hKskA3DWvY0Vub8qBpHmTh1TIm7/82RWyRD9OYt8apAwz4EzKdTQ3piniEK
 Rg8GMDFPHoi9x8Rs5ioohmcWzxRn3mWzrmFTNKRuvzSzGFn+Iql3b7wYj22C1i9SIQ
 zWMX0+nvgB/pg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Nishanth Menon <nm@ti.com>, Jonathan Corbet <corbet@lwn.net>,
 Oliver Faso <erer1243@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 5/5] doc: update requirements.txt
Date: Sun, 14 Jan 2024 14:18:23 +0100
Message-ID: <20240114131824.68298-6-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240114131824.68298-1-heinrich.schuchardt@canonical.com>
References: <20240114131824.68298-1-heinrich.schuchardt@canonical.com>
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

Update requirements.txt to most current packages as produced by

   python3 -m pip install six sphinx-rtd-theme sphinx-prompt
   python3 -m pip freeze

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/sphinx/requirements.txt | 43 ++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/doc/sphinx/requirements.txt b/doc/sphinx/requirements.txt
index 39ececb96c..840c6cedfd 100644
--- a/doc/sphinx/requirements.txt
+++ b/doc/sphinx/requirements.txt
@@ -1,26 +1,25 @@
-alabaster==0.7.12
-Babel==2.9.1
-certifi==2023.07.22
-charset-normalizer==2.0.12
-docutils==0.16
-idna==3.3
-imagesize==1.3.0
-Jinja2==3.0.3
-MarkupSafe==2.1.1
-packaging==21.3
-Pygments==2.15.1
-pyparsing==3.0.7
-pytz==2023.3
+alabaster==0.7.16
+Babel==2.14.0
+certifi==2023.11.17
+charset-normalizer==3.3.2
+docutils==0.20.1
+idna==3.6
+imagesize==1.4.1
+Jinja2==3.1.3
+MarkupSafe==2.1.3
+packaging==23.2
+Pygments==2.17.2
 requests==2.31.0
 six==1.16.0
 snowballstemmer==2.2.0
-Sphinx==3.4.3
-sphinx-prompt==1.5.0
-sphinx-rtd-theme==1.0.0
-sphinxcontrib-applehelp==1.0.2
-sphinxcontrib-devhelp==1.0.2
-sphinxcontrib-htmlhelp==2.0.0
+Sphinx==7.2.6
+sphinx-prompt==1.8.0
+sphinx-rtd-theme==2.0.0
+sphinxcontrib-applehelp==1.0.8
+sphinxcontrib-devhelp==1.0.6
+sphinxcontrib-htmlhelp==2.0.5
+sphinxcontrib-jquery==4.1
 sphinxcontrib-jsmath==1.0.1
-sphinxcontrib-qthelp==1.0.3
-sphinxcontrib-serializinghtml==1.1.5
-urllib3==2.0.7
+sphinxcontrib-qthelp==1.0.7
+sphinxcontrib-serializinghtml==1.1.10
+urllib3==2.1.0
-- 
2.43.0

