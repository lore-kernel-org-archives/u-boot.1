Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B78C3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:30:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E17E88B6E;
	Thu, 15 Aug 2024 22:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LN678Is2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 103B088BC2; Thu, 15 Aug 2024 22:26:06 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D65288BB0
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-39834949f27so5319715ab.2
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753558; x=1724358358; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z6bSvxh5YsAo9K1KEny+ZEyBZdSO0dvTxg/3C1drF9A=;
 b=LN678Is2KymcXVF50jKjtXTvAmeRPdocL3kR0fbwWu+CURt1v6jbdBwHE3bahAA0xK
 POpnYg9CgYnf8cQ40sQKfCZl16XltF+JTwkLm52iXPuUn7HiuOJEUxR5ocQox5Oi4Mw6
 82GJpN1Y4t5X3zyNQRZD00wTeFJca5eQ3mm3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753558; x=1724358358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z6bSvxh5YsAo9K1KEny+ZEyBZdSO0dvTxg/3C1drF9A=;
 b=ND8ZdmnRGaxD5FcVknMrgtk9Zw5mjDHz4UvVpBnHiZLWiNOETyupctC30E+ckKwTcl
 gCBw83i4NAhKTitIkxBDvAOUiDtyzu91+nkFggnfo8laHC4sufEdQwnd1DofxOx1myGe
 7VcKHqcZABJYIGT6YG1H7lmKepU+7tILdO0rXBtf9fpKxKmpbFhnzAIKU2tGsLFSgQdv
 U1vve71s3FJSchDaUF2juh1RJ3npbmyR5C7bws2OK6zrjwEXzBMmOlZEobZWTmL5thJK
 QZlzgkH0k9yc5M8a/Ee9h8kHy1eNsMEHzuPytipRQkS4D0kZKOrly9FTXJhWRyvIzTtd
 pFmA==
X-Gm-Message-State: AOJu0Yw8uCTpWALmNioEA+VUdGsn+9uDSH+eGxgZd30/vAlDb0zjn7Rv
 k+RvBisllrXcVOqODmLIX/2W+NOZy7oLvT9VuOKiYECyYRkiBFYVzou97Df3pURRAfPq7IjH37P
 sIQ==
X-Google-Smtp-Source: AGHT+IGQDVKDEPSb+cgi5xkF1Apt9fAwYJzOiJWCUT48ILmMMXkiBAp4+6Qe3oAfi1B54dXArUqWZg==
X-Received: by 2002:a05:6e02:1d89:b0:39a:e9e5:62b with SMTP id
 e9e14a558f8ab-39d26cde859mr14161925ab.3.1723753558572; 
 Thu, 15 Aug 2024 13:25:58 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d1ed5db5bsm8014235ab.64.2024.08.15.13.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:25:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 21/24] test: mbr: Unmap the buffers after use
Date: Thu, 15 Aug 2024 14:25:32 -0600
Message-Id: <20240815202535.767869-22-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815202535.767869-1-sjg@chromium.org>
References: <20240815202535.767869-1-sjg@chromium.org>
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

This tests maps some local variables into sandbox's address space. Make
sure to unmap them afterwards.

Note that the normal approach with sandbox is to use a fixed memory
address in the RAM, to avoid needing to create a map for transient local
variables.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 04291ee0aba ("cmd: mbr: Allow 4 MBR partitions without need...")
---

Changes in v3:
- Add a Fixes tag

 test/cmd/mbr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
index 1a35ba3351c..8a4d61b2928 100644
--- a/test/cmd/mbr.c
+++ b/test/cmd/mbr.c
@@ -461,6 +461,9 @@ static int mbr_test_run(struct unit_test_state *uts)
 			"5P EBR+0x%04X: expected %#02X, actual: %#02X\n",
 			ebr_cmp_start + i, ebr_parts_ref_p5[i], rbuf[ebr_cmp_start + i]);
 	}
+	unmap_sysmem(mbr_wbuf);
+	unmap_sysmem(ebr_wbuf);
+	unmap_sysmem(rbuf);
 
 	return 0;
 }
-- 
2.34.1

