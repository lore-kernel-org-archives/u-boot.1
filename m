Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995D4C87FDA
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 05:04:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EA7F835B3;
	Mon, 11 Aug 2025 07:02:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KgTAEizZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BFE2832E6; Mon, 11 Aug 2025 01:38:36 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5753D83278
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 01:38:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-458bdde7dedso24881715e9.0
 for <u-boot@lists.denx.de>; Sun, 10 Aug 2025 16:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754869113; x=1755473913; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mJfz2tG7UdFIx872VL6B0IfIkuQ+AP122wpLTz0/A08=;
 b=KgTAEizZ768XNDp6X/YW3LBFSCmhtcIyjW+3MBZLdq9he1GeFoYOK43ZZbR1nXtmdK
 o0nL2AHJlnaRhijHhkg5q0rzXa86gKYohKlPPInOcjRbCe+4mB7cq6qlkxVCnOVXtnyU
 JkWZ4oXr7yRtHMcDQ235+Ls0Q6sa6Ei+4YQEnrZ/dF7/fsnEAfDIyac7e2zuSSgEn3db
 y3hAH5NpifxTbSO/kHiHeWfXaT/DTD0BYMd29zWeW6T1JLGZTXj53EaqFvQ8yeO5GUJu
 3Rf7Nw7pfFhqBvnGWf2KycpBEA7hnaocgEXe4pPnQ0/Xp0/BrVZTE8Wh5MI1rAZeYBZ6
 n7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754869113; x=1755473913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mJfz2tG7UdFIx872VL6B0IfIkuQ+AP122wpLTz0/A08=;
 b=I/hqZGMVh+q/bgRDYyVbsxgph1tAtz4iHl+LNfnWoEgwpvcFQcvTB+grqSl1LFhgmZ
 oRzFjn7n1eSyUBUvUMx2rkOlfbQHKxUlazYvQAZyo2zUftAYng02KZINj91B38T4MStV
 R+K1xSH5pJ6dbeK4kHFGGVA7szYdtyUq4wNmRa/+AoHoIDB5fcNM8eX/0pkf+c/YQCR3
 tTjvC/yrrW8QytzH8a3wEoo4m0XN0T20Na3umHMwwJdYhFAhFbJ5AIJbwQDEb3n510b2
 QilwJTbZdUZsHNPhtTjumW+ODm7vXheXRmDyyBi2MJnUoxL7RdyCCjQVicIotoyq24I9
 Y6TA==
X-Gm-Message-State: AOJu0YwXowMak9QZan4CJixoIJ9+VkfySZc4MFXUk2qsUU/RnolTAEuu
 kKCtUd3S/t74TfgOvwElMPstSILZ+ajGwI1f2KWhpUmZxkY9vjXRwFGYoj9Erg==
X-Gm-Gg: ASbGncu/EBlR7W6uUqlHqyL5uQRgLb6Ta3AbeMgfZYePZJGMeiPnupY/KmwcgtFF3Rd
 0vJrj3sSvc1gpgDzVymKxG1APA9t61Gtb3JA2uOtvKQ2bEPxehU8RKuyEUOhrAnVYRj8LrkTBJz
 S+ZYf+/kZZIUdQTAqlweeMhNi826Lo8MLx30e31FfRNSKY96WtxxPQsdhpGYfDZ14z0QGV9wbzo
 5CNbNdUt7mD14++ZFsbfgVIZdgnpy43z6x6vK5Oj0p/RsK2tAuzxUy4oMfEKCziuLYNu1GeYu3B
 pIyGxzYusnHx8RjFM+qUyh4UmcccnRDhXQUoN1Sr51p1bnnHycXyZf/OFzVwxrUo0A8Q6hpJtx1
 sm3k7I69SRQ4qI+eBgwlYqeXvmZMtWPo0uBhHzAbY
X-Google-Smtp-Source: AGHT+IGYmgvm8B4wejPSClGmlSIsqZlM5Yi/yE0Rr5SmBdK1MBpL+nqYoTVypYfXRecjfrJR/zhSng==
X-Received: by 2002:a05:600c:4e8f:b0:458:bfe1:4a82 with SMTP id
 5b1f17b1804b1-459f4f0557amr98368485e9.16.1754869113497; 
 Sun, 10 Aug 2025 16:38:33 -0700 (PDT)
Received: from N580G.. ([2001:8a0:c46c:a000:d911:da6:779c:bd3b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e585586esm242339815e9.13.2025.08.10.16.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Aug 2025 16:38:33 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: u-boot@lists.denx.de
Cc: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Subject: [PATCH 09/10] doc: Use a long dash instead in
 tools/buildman/buildman.rst
Date: Mon, 11 Aug 2025 00:37:40 +0100
Message-ID: <20250810233742.51902-10-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
References: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 11 Aug 2025 07:02:48 +0200
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

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 tools/buildman/buildman.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index 7944adcd867..3e41d6ec304 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -1360,7 +1360,7 @@ Using boards.cfg
 This file is no-longer needed by buildman but it is still generated in the
 working directory. This helps avoid a delay on every build, since scanning all
 the Kconfig files takes a few seconds. Use the ``-R <filename>`` flag to force
-regeneration of the file - in that case buildman exits after writing the file
+regeneration of the file -- in that case buildman exits after writing the file
 with exit code 2 if there was an error in the maintainer files. To use the
 default filename, use a hyphen, i.e. `-R -`.
 
-- 
2.48.1

