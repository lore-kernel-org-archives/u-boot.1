Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27B7CA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 21:57:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E27728323A;
	Wed, 10 Sep 2025 23:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BpArkqP8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BB2A83253; Wed, 10 Sep 2025 23:57:48 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9B29831D5
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 23:57:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-723bc91d7bbso1042667b3.3
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 14:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757541464; x=1758146264; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+aAwMfabDFfFO2vg+XnvA04PztQNFMs2s8imjba364Y=;
 b=BpArkqP83UCWqwRNcSpbQa0IH7L2hRazBbF2Ms1c1lBH9gXEjuTgFEFvtW2c9VgWNQ
 uc9/NhF7QHOxiSOu0Prm/iUifgaNc6BDKon5JrtNCxb/1U4sYjsWjRcclnzo7wEyfS+2
 0kw8ydvo8IBWt//sRSBJPPObmZhHzQOnkepperuJ//naAo2qzxhCmL8B4xPDhKwpGEga
 Ox2BCWb64CdKyPvR6WvPmwYMRtNZk6m52Z3iGkO+IJeG1W3L5nSZnuJ+KIUsN/rO3YWj
 ax45CbWyaTdlq4Ox8iWG6JB0HJMro1ynk4J9O4REklnKjwi6wTXIoFNdcofQvenqN3LY
 QoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757541464; x=1758146264;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+aAwMfabDFfFO2vg+XnvA04PztQNFMs2s8imjba364Y=;
 b=Xdq+3XoTKN+wuZeEvmegtbrD1ZkhjtaiKt/Z6fMgyAhlFded8jTmXQTTXGiW8PmI/0
 VeWuSL+8jHvYWEdlBVB7i91cQcBh9gesQV3PZR3GzEVueudfdmvzcFWGLNWt4VJOD9H5
 PA725zu1DA2won0zKHisWGGA4UwUVcg1uNjzrCa6KCrEbMn+4q7FkhFgMV5Q+s72Uy3I
 fHUEO1AxS0TBRe0kzDEBCtPaQ71Qsk/DJjg+D4bPSichaF6UQk5v0Xqibxw5qftJpONX
 eWRIha4FbGiHOtJUfw+xnGcJGgbIeqPkM+NW4mRFa9XhfEPcKGo/B3pARW02M9Z8E5BV
 HizQ==
X-Gm-Message-State: AOJu0YxTb7Iy/4TsNc2mF9aYNaaCwB5/DXVYjeu7c7BMYOZPu0x0pBeV
 NR2m15Cr7i6VnOiY7vftR7Dqa4SZQ/l07mp4cBQ1Z8WU1LD64BfWQ5y7
X-Gm-Gg: ASbGncuCd16j8y2g1PY9LdfDvGwGak438xHgpC8RAtcKo3UDEuo5Z4l3nKj6MHqO6+8
 sKCJl6I61Bw05CRBnJA5E2gNBxaR3M1Y3CRwWTKJyfSkNVu/G8ufgXI7bjn03dsXDdvSRLwXLG+
 Ek7U0OE/VnRIhpBUTRT5cWl7cbldeILf6BiqlYvb1cQvPx7RHam/Hp2UBFvF54bMO5d6D03qbsJ
 r9jAGE+cN7LVc435U9KSE47cZtuuxByfdygZdySB3sQqBGHXNc121ixrBCj0orEExinxDbH90XC
 /PQuFQbG1vuCeD3/p/OpfCxAA1p/Xv3s/evdOJ/9xxZTjV7R6ibomzRVcz8UKL+K+QSu1x9Odhf
 3io08zeK4+45aSQTGmTp1b8q//cGFJG2xst4tQOEJgnbvBW8BJGbVRum7OkgpyjeH3Ht3HVda7r
 eSmx4WVnMbSA==
X-Google-Smtp-Source: AGHT+IGnmC+GcJZ0O5HH2yUqYERg5h0cPorNI4XygYUfRcvJT8haeAYBb3E4jRr6vqq3BwsphAzEVw==
X-Received: by 2002:a05:690c:620d:b0:721:28ef:8b5a with SMTP id
 00721157ae682-727f4d614d8mr158460327b3.31.1757541464386; 
 Wed, 10 Sep 2025 14:57:44 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-72f16e3d7ffsm1289407b3.60.2025.09.10.14.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 14:57:43 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH] doc: ext4fs: update documentation for Ext4 Write configuration
Date: Wed, 10 Sep 2025 14:56:03 -0700
Message-ID: <20250910215702.15576-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.47.3
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

Update documentation for how to configure Ext4 Write when using large
partitions.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 doc/README.ext4 | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/doc/README.ext4 b/doc/README.ext4
index 8ecd21eee3b..ca9f19953d2 100644
--- a/doc/README.ext4
+++ b/doc/README.ext4
@@ -40,6 +40,17 @@ Also relevant are the generic filesystem commands, selected by:
 This does not automatically enable EXT4 support for you, you still need
 to do that yourself.
 
+Lastly, the current u-boot implementation for Ext4 write requires a lot
+of memory to run successfully. The following enable support for
+large Ext4 partitions:
+
+	CONFIG_EXT4_MAX_JOURNAL_ENTRIES
+	CONFIG_SYS_MALLOC_LEN
+
+The number of journal entries and dynamic memory allocation are proportional
+to the partition capacity. For example, an ext4 4TB HDD partition could
+require approximately 500 entries and more than 128 MB heap space.
+
 Some sample commands to test ext4 support:
 
 1. Check that the commands can be seen in the output of U-Boot help:
-- 
2.47.3

base-commit: 80fe882d6c51c785e9a899a64b612187ebbdc788
branch: master
