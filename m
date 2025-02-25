Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB99C021B8
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 20:07:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6DF08081A;
	Tue, 25 Feb 2025 21:06:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HHaYY/FP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1F6580F9E; Tue, 25 Feb 2025 21:06:55 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BBE580FC8
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 21:06:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3d2f5a93a32so11428575ab.0
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 12:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740514010; x=1741118810; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y8BXo26xR/4bNcij/9ueR0A5BFhzz72UuPU5ifwWIsM=;
 b=HHaYY/FPD1lRzuXbii0XN7ZQAW4Vox/IT0rcyceUtoc5ATc3nDWFvkPYHkScoc2OE7
 1a+LAGqVR2RE685EkPVlVrr6oEwKsXfzvlm54HdvuSCPXitVtd38YF8ScVimeg6hnhC9
 lbdx8/t5qFcF/ao9UYYvx4HE98asmjsqX9X7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740514010; x=1741118810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y8BXo26xR/4bNcij/9ueR0A5BFhzz72UuPU5ifwWIsM=;
 b=OaxsMPgEsJyChKCi4d/z0nrskA6C6cRbxU5DA7lnbFtdrd+yYbJ3eyIf9VTgUOmfGR
 UVS5DeialGqVD9wonL5g05l//MYUok1b8WLGDvpKMGW/clLiufdNkrtQAGxfseKdMkYq
 rRNsquNc2z0AtZhhSfgfhuiTdY1Rqd3zArQeOK1xilTF38txRmIwOm4zOf4eTOtWLRAf
 EIoasuffJ2FwhzNdg19CLcpZFlOuRYJiKulRBcnujRJtPoKt+ur8woQR68ufElZ3xeHF
 LJw5mROUrwoyQvhCJurdS0IBrO4rK83AViCKtFsrrko3u9ERg8W1V7XHdGlLUFVwZis9
 33PA==
X-Gm-Message-State: AOJu0YxpUAnKnWZbvUwpCFM1i19/FwIuZKwB3q0O/IPJYM8qlj2nauUZ
 iQn6US9MGLk8ORtitBwDu+YRDG/3i9ErPit4an9+gy1vLt07Nn4GKGh2zXfXsp8BXtyozUf5itA
 =
X-Gm-Gg: ASbGncvGchysVEdTOPXpff6/1+pUDE9Q2pi1JeFGkT2/Ekhhjkih2IgAqrCMMJCXPwe
 5kYhen0nRxoevxHWhEJYXObrryYnchWbOEO9K5RyaQw0TyxCOxVSo+t6qCBEIS7t/0KHDxffnwe
 IIYBjhDqvH4oeb/AjxItoVPzvGForcv79RxGNt6Ko4AT6P9hd0rpachGTA3s9hzB3ab9eRrtt80
 LvHNQXAyKCU58TZ6kvCSIiSiUWTdVyGBSAfGjpdh4HWmYoz1L9Tk9PWdcQtj8tHwoDRpgfEWJbu
 ZvmBTdVEYUuTev/WHbdpHmS8EfNFelE9/OHLDmPix0UmQljKJYDhwDjqZH5poLo=
X-Google-Smtp-Source: AGHT+IHe6L9dZ1pJhwrrJ9Nq5RhVDb4WbP11SUngkrPcp3YrkFnWo7p03NUSEglWU5TepHYpycjm8w==
X-Received: by 2002:a05:6e02:4904:b0:3d3:d067:73f8 with SMTP id
 e9e14a558f8ab-3d3d1f4f181mr8043315ab.11.1740514009844; 
 Tue, 25 Feb 2025 12:06:49 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d361ca210bsm4653305ab.55.2025.02.25.12.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 12:06:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/7] binman: Drop GetRootSkipAtStart()
Date: Tue, 25 Feb 2025 13:06:27 -0700
Message-ID: <20250225200635.3781149-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225200635.3781149-1-sjg@chromium.org>
References: <20250225200635.3781149-1-sjg@chromium.org>
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

This method is not called anymore, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/etype/section.py | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/tools/binman/etype/section.py b/tools/binman/etype/section.py
index 5c371397ffb..1d50bb47753 100644
--- a/tools/binman/etype/section.py
+++ b/tools/binman/etype/section.py
@@ -666,23 +666,6 @@ class Entry_section(Entry):
         else:
             raise ValueError("%s: No such property '%s'" % (msg, prop_name))
 
-    def GetRootSkipAtStart(self):
-        """Get the skip-at-start value for the top-level section
-
-        This is used to find out the starting offset for root section that
-        contains this section. If this is a top-level section then it returns
-        the skip-at-start offset for this section.
-
-        This is used to get the absolute position of section within the image.
-
-        Returns:
-            Integer skip-at-start value for the root section containing this
-                section
-        """
-        if self.section:
-            return self.section.GetRootSkipAtStart()
-        return self._skip_at_start
-
     def GetStartOffset(self):
         """Get the start offset for this section
 
-- 
2.43.0

