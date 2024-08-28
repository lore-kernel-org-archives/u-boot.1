Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC4FC54747
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 01:46:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 472AB88B6E;
	Wed, 28 Aug 2024 03:45:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bUFhQzhC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DACD288AB1; Wed, 28 Aug 2024 03:45:53 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9946488B1A
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:45:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-39d30564949so23619745ab.2
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 18:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724809550; x=1725414350; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U2gv4ya8jfcdRkmHQkgKZHjRucbwqH8JIXMiPyVMhQA=;
 b=bUFhQzhCrA73aiV3S2OLIv5Icaw2gvrkRMRWGSL0g8oN5DMvZwsN0gaUOwZGUboH7D
 a8CeF2J2kGAU4RBg7Gc+XjtJp+cAd3dnvP2bhjIASDSIU/KUz5558ZpU+dJVSD0j8PgM
 x7jdOApwIIPXBZvtriXhZg03QzyhUvPQFHxYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724809550; x=1725414350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U2gv4ya8jfcdRkmHQkgKZHjRucbwqH8JIXMiPyVMhQA=;
 b=wRsJmQCmxA6zcBBSylpNv5uD7y5O49Xm2s7RDLCsf8/41ZhN13Wp6EvtC1R2Ba3Jiq
 wAiFUfWyGxLftDu0PiEIqVBoX1ADnumv3FQlG06jr+y4nhx3y0S+ameGQqZjRnVmX1rQ
 +tNZO8m38DfH35RVWlqH8t/M/5+aoSaEtOcE74ZeZ3/ZI2CxkoO44ep699VWjRX9aWYi
 xnf5m6Q1oyKRpiwKslj60GceVdD+r3V3Cf+OR3PKgPr2yDe6SpFHlkJqC9T0LZi0vleZ
 cvmez0NfVCpUIyClvBgfuij/voa5dmVPj2/agpsyJLfFyMHOC3ytbbcuyy+KHqscGFia
 8/Jg==
X-Gm-Message-State: AOJu0YzdI9SyMQxljPPoE4Yk2rO0AO9YHLGYaPNVH+o9wl1JyQjCDsF/
 bdo7Dl0wlBqodtLLA7k2oD6hycA5542k6Xa4K25vBfzz926ayd3JDDjGVURitNs472VeqC/vWPA
 =
X-Google-Smtp-Source: AGHT+IF7l4MkjINn0bh21OYeZoDYopEOLbprK3Lbs6MaTlclU94ZBo31PR6CLSx885yo24NKxzcasA==
X-Received: by 2002:a05:6e02:1a4e:b0:396:e8b8:88d with SMTP id
 e9e14a558f8ab-39e3c985fc4mr142922995ab.11.1724809550240; 
 Tue, 27 Aug 2024 18:45:50 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f5ca7csm2898342173.63.2024.08.27.18.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 18:45:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/18] gzip: Correct function comment for gunzip()
Date: Tue, 27 Aug 2024 19:45:22 -0600
Message-Id: <20240828014538.3322013-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828014538.3322013-1-sjg@chromium.org>
References: <20240828014538.3322013-1-sjg@chromium.org>
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

This doesn't describe the length parameter correctly. Fix it and
zunzip() too.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/gzip.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/gzip.h b/include/gzip.h
index 5e0d0ec07fb..304002ffc42 100644
--- a/include/gzip.h
+++ b/include/gzip.h
@@ -28,7 +28,8 @@ int gzip_parse_header(const unsigned char *src, unsigned long len);
  * @dst: Destination for uncompressed data
  * @dstlen: Size of destination buffer
  * @src: Source data to decompress
- * @lenp: Returns length of uncompressed data
+ * @lenp: On entry, length of data at @src. On exit, number of bytes used from
+ * @src
  * Return: 0 if OK, -1 on error
  */
 int gunzip(void *dst, int dstlen, unsigned char *src, unsigned long *lenp);
@@ -39,7 +40,8 @@ int gunzip(void *dst, int dstlen, unsigned char *src, unsigned long *lenp);
  * @dst: Destination for uncompressed data
  * @dstlen: Size of destination buffer
  * @src: Source data to decompress
- * @lenp: On entry, length data at @src. On exit, number of bytes used from @src
+ * @lenp: On entry, length of data at @src. On exit, number of bytes used from
+ * @src
  * @stoponerr: 0 to continue when a decode error is found, 1 to stop
  * @offset: start offset within the src buffer
  * Return: 0 if OK, -1 on error
-- 
2.34.1

