Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7F9CD4F26
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 08:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E5FE8341A;
	Tue, 12 May 2026 10:12:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pcc.me.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=pcc-me-uk.20251104.gappssmtp.com header.i=@pcc-me-uk.20251104.gappssmtp.com header.b="I8sSeC5q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B990983015; Tue, 12 May 2026 07:50:46 +0200 (CEST)
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com
 [IPv6:2607:f8b0:4864:20::1331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 987E3803C6
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 07:50:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pcc.me.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peter@pcc.me.uk
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-2ef2a1cc06dso9034338eec.0
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 22:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=pcc-me-uk.20251104.gappssmtp.com; s=20251104; t=1778565043; x=1779169843;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i1z/b325L5JmKiCH9lVXL/5sSt8hqTd6LUis16lpjq8=;
 b=I8sSeC5qPLP5dUxvvmSDfNJfL8BeLgPhzgDQU+sgPkM9op1FLrFRI/CptB3vBg4egq
 Y9v9RhiHdB+07dKF+z7WOO084SAhBcrNIPqLz2p08/7qM/zUhmeYiyTCfsc0cry4giDm
 GK6VxYGSQGTPJ7aXjBVIyu+rx8+W55Fi78Eze0to61X5u3YWb/6kpnIl5laLnqUTRt3V
 On3UEdHB+E7CkX+Pv8ZqhL2o2CkgPTOvAIY8QcJH3CyDPT4BI/nxJhNl02cFcBNfJQQ/
 /MHSZqlQSjlDM09FklHjsnMoWQPxhaeMRdIt6zeanmzMuIyaIoQR9KnxXoBOHB7v1oQH
 bZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778565043; x=1779169843;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i1z/b325L5JmKiCH9lVXL/5sSt8hqTd6LUis16lpjq8=;
 b=DGHnUSbPba/NNbLU7tk2fWrO0aFcNPq35CYKwrnft6EwcmDX+hUX+aYbrlNKBykn+h
 fH22Ruz5eHPlRD8O7eXKnlFoSg1qm774M0i16x2W8nKvc/3IXyAXR9tVv7am5bcCX9YR
 /GPIdhEiIs6+npYF6FEfq1wFzna9iX7goXZY1A+MSxIewoG19tIYLpnHW0gOd5k0dIue
 RqwOQsPI0QrW+V2Zfw6Gm2I/fui3dvWPhLxXsfdewTSsSjH5BtYClYEAolpCNHGAEZuI
 jDHsJU5XJV5hrzi9pCCNoJIKA+9JuhNiWUnjyXsQUHwdqMG7YcLMKVrHqQ9pKbgHeU2+
 Onqg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+TAQ+Jg9DPchqNcUFddei9nMCuJw3QzLQk2A5t0iBXIk0LEihvIL4lJ0oA052khEN7Ql5Je9I=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+i9FSPdmRuZ9iFNKfZtdGOVG8sy7mJ1oFNa8UFkpd0iQMlU+B
 gAGXCsExSUvLmyG+Ex9EaG92y77De33rGQEeoCKWqmbXgZdNDovbbafT2pX0mJ/R6ZA=
X-Gm-Gg: Acq92OFMKfK+Ucn5BHJEp/Ztbr1E5Zzv02ymM2Sr8pWCrq+7U29IeJj8VhgEzx+1bpS
 iWKnFgNarc6mkMB+uHTQMa+IFRtUnIFwv/IenQRSIeaG24ji/fq7R+B6m51/BNgeWK/EILRzJb6
 zbYg+mrMoEhiQXjsVjF4OdNE1b2467qvYRPrbwyHKraPLoVyHxmF6S1ynyS9t3Ht1aoyxx0HWXK
 rwQlYT0y+pk9SAZKGBn8E6ZRRNWN9Cluqkxr+1s+YCSMMrxjDYDuddlv46Uj+UNXimr7QR0I1Kc
 Ebs1iLa5NDvI+rwsa+RYQjgdQEhMKJQoNI15PQ4W9hlHBQkeAXycCiVU3527trvWX0zIucFROrC
 svwfXo/7nySuF/+ngWTpgx9fdkwEiS1RW206eTpgqoS2zMkv9bS0w1Cj91Ca1avAwwVDDZ4QcP5
 4xRcfyuoaXIgp/8jsM7//qzozYhIQ6uCzcc76Rixn00b8VDh52cyNw1mfA2qU3fL+bgg==
X-Received: by 2002:a05:7300:2318:b0:2f5:2556:5acd with SMTP id
 5a478bee46e88-2fb3e7aeff5mr5646142eec.13.1778565042749; 
 Mon, 11 May 2026 22:50:42 -0700 (PDT)
Received: from localhost (c-67-180-161-137.hsd1.ca.comcast.net.
 [67.180.161.137]) by smtp.gmail.com with UTF8SMTPSA id
 5a478bee46e88-2f8884752ccsm16068696eec.17.2026.05.11.22.50.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 22:50:42 -0700 (PDT)
From: Peter Collingbourne <peter@pcc.me.uk>
To: Tom Rini <trini@konsulko.com>
Cc: Peter Collingbourne <peter@pcc.me.uk>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, u-boot@lists.denx.de,
 Kyungmin Park <kmpark@infradead.org>, Heiko Schocher <hs@nabladev.com>
Subject: [PATCH] fs: ubifs: remove dead code
Date: Mon, 11 May 2026 22:50:08 -0700
Message-ID: <20260512055008.9357-1-peter@pcc.me.uk>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 12 May 2026 10:12:36 +0200
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

This code is dead because it appears after an infinite loop; remove it.

Fixes: 4c4477c77008 ("fs: ubifs: fix bugs involving symlinks in ubifs_findfile")
Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
---
 fs/ubifs/ubifs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ubifs/ubifs.c b/fs/ubifs/ubifs.c
index aafbd01a028..3f2e2037745 100644
--- a/fs/ubifs/ubifs.c
+++ b/fs/ubifs/ubifs.c
@@ -608,9 +608,6 @@ static unsigned long ubifs_findfile(struct super_block *sb, char *filename)
 		root_inum = inum;
 		name = next;
 	}
-
-	kfree(buf);
-	return 0;
 }
 
 int ubifs_set_blk_dev(struct blk_desc *rbdd, struct disk_partition *info)
-- 
2.54.0

