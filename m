Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685E6C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 23:31:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78467887E4;
	Tue, 23 Jul 2024 01:30:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dBKynbP6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hv0Mgz3l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C73E87E50; Tue, 23 Jul 2024 01:30:02 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EA8D885F6
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 01:29:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WSc296q0Jz9sjp;
 Tue, 23 Jul 2024 01:29:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721690994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XKI13LChOpByLCX/pZ3Xd1wE9mlpxin5nVWgeNSinH8=;
 b=dBKynbP6mPLPGzyTYIvrZPndgMXS+I9yCdn8P6kpptExLzxVe1LsjRoFfh7lbYSslXdsNz
 f+agRkfD/kuHn9kC0GeohWy9SxUhnU2QkQxH3DDFXrUV/bBfSmWu+kYXw5R5YLUo9o1+lP
 3SnnWFJ1oUg0dSggaJs57NtJRfATTiQeOl44UPAQfKnUKGRnZk4mpeiYXo2AdoEH/HJWF7
 b4TbK5+xpdj9Eqsxy+fAy/kgRX1FnNfi0TCiCWc9gWyqzpQg7ZLrSaeo0V/736J/PNM00R
 Mu8tCSycbP9mFLyoctIcxICL+m1zcccTY/DdeYIX905rWtAghsaj/omMLV5QUg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721690992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XKI13LChOpByLCX/pZ3Xd1wE9mlpxin5nVWgeNSinH8=;
 b=hv0Mgz3li7hVBC959qM1PPh5Z+TQf8WO/MmPfZiWA7y4xjgYmtcrUkJ2nH0uQSxXC/HLEB
 jUOnIKxX9jsNmsSJFEfmkLw9AFTqx+slWhtCWVXhmxWq/JXudsj6Y2g4snz37n55udM2lY
 61ypLY3XPAH+ssQqk59RApy8+7Z7oLhOhVtY1Rk7oRJPUj5LVIWSxqzGGKlAiH1J9Dvimv
 QFKSSlL0rOJkC/mexVsl7HJVJ/FxHAPKRxTyoJ4zFA+HZN/8fQdCqx8IaOUNiVx1yZPlE0
 lB6NK4OZD5haANx/sqGmYqZ5n2EB3kxDzAF+MXykupyRZlFuK2N1/c3hqGFxDA==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 06/15] include: jffs2: Remove duplicate newlines
Date: Tue, 23 Jul 2024 01:28:25 +0200
Message-ID: <20240722232910.91249-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240722232910.91249-1-marek.vasut+renesas@mailbox.org>
References: <20240722232910.91249-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3bebb15f098c72c9c0e
X-MBO-RS-META: u3eeunrb6qeogtffxe8pi3r4ze9kowmx
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 include/jffs2/jffs2.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/jffs2/jffs2.h b/include/jffs2/jffs2.h
index 651f94cf381..e986508c2cc 100644
--- a/include/jffs2/jffs2.h
+++ b/include/jffs2/jffs2.h
@@ -109,7 +109,6 @@
 #define JFFS2_INO_FLAG_USERCOMPR  2	/* User has requested a specific
 					   compression type */
 
-
 struct jffs2_unknown_node
 {
 	/* All start like this */
@@ -212,7 +211,6 @@ enum
 # define DT_WHT         DT_WHT
   };
 
-
 u32 jffs2_1pass_ls(struct part_info *part,const char *fname);
 u32 jffs2_1pass_load(char *dest, struct part_info *part,const char *fname);
 u32 jffs2_1pass_info(struct part_info *part);
-- 
2.43.0

