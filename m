Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482B3C624CF
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 10:23:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF1D880B89;
	Tue,  1 Sep 2026 10:23:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7KTSLRXsQpZh; Tue,  1 Sep 2026 10:23:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788258212;
	bh=PTTx/0mtgbis3nw6Fxr1lg/an/chr3lV3glXNI9KRnQ=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BMeLPgrspdYRGRPnFT4jJT6GFvfoLdDqxrT5Y/k6aqBhWkh1RGTtsCJtu4BHEGRZL
	 YKNVMNPr/yduwyE4Ksh1P1RYb/w23IY+8ZRouOH1W21OG/8k2x9o2bMor5nx9NOwdG
	 cSifS7SweuvctuFi5WORB0Q889dwR6pOlBLAuzvzn4FZKgRijmmdF5SzAXdo8Yr9Ld
	 5ZELoOfFPFZG2wvMtEireKz2WS3PkjYTJxqsOwp47x/wLCekr/aQHsHauXVJmiPEbB
	 VZFTCN4XVsThiksJIw/ox9FkQJ6Uzyj1DjptquAnDoQRWhy7F7ItLuho79XH7+MiOR
	 O5zGV2JRfBUUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E1C580B75;
	Tue,  1 Sep 2026 10:23:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A9786105
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 10:23:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C24180B75
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 10:23:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GmMUbOOHkbwx for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 10:23:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com;
 envelope-from=naveen.osdev@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=j4z8PCtB
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F328D80B5C
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 10:23:30 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-398b3d66515so3398660a91.0
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 03:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788258210; x=1788863010;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PTTx/0mtgbis3nw6Fxr1lg/an/chr3lV3glXNI9KRnQ=;
 b=j4z8PCtBXkD/ZCwKYlbgVRdcAWJYQZtEzQu4hDuD6xPpQ0qLAkP8W7VusDEKQJxTg/
 tJjzNdK8SVsY1sGCiPRLnViJTpzV9AMhjVO2ogi/dgbL+z60hSVNxUHIo48QfKz3/xor
 rf1ofTtSgYB3vth5PTnMrmLHheCDBXC1IA/Xyc0M/heUQBbBnGq7NhgNrlSVbj9e/a+R
 bRsOEDvxyLXAWxEKVM+JxmMpnjX82WFUr6Eie1Uz6GHa1Vmqc2kGhXGaHfN7Bd1/DEYp
 G2wc0MHz3ZkgF5EGsOquCNvHxqE9GKioS0QQCN5ctjVEug5EoUEvzkF22eGQKrcXbuYo
 WBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788258210; x=1788863010;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PTTx/0mtgbis3nw6Fxr1lg/an/chr3lV3glXNI9KRnQ=;
 b=FnFdP+fy/Za2X8qhdjlytZ6soJVaZVqmf8ZvvuSywKNtrmVdk2FybkKYpvNhMNx1sX
 6djJ7huuO/a4dC+IvWM4jo21LkKGhzL9r+ap3GILpqTi00O1g1uQ0Kf7OXqC/yxxhld4
 6vOw3y4FA7JfG0ECJtBSGYbuFFJ18xoYOdE7goo5YUThoeOCaiZfx1wQMY/Y0ok5enNQ
 C5gtnPoTN7oBYZQ6c5lTvv0I48AGzHBKlSLWvLoyr9VT9uUFuZ0ywMTarFb8eW3bIo3l
 HLUdk6avJXsGlrvQ3zmCw/xCQ3vKxSENC3vLAJ2t1hDx53aO+Py7b8fQt3BFb476cICA
 NitQ==
X-Gm-Message-State: AFuF++nJ31u87elLw46Ly1JRcswCi2/2iZwVRxO5od/QEfL+c8cy/3S0
 tZMu4zjXi4pHk7wXL0apKLVgbnKGd/Hlb5B3q8dLJMcBUmpzJF76767Y
X-Gm-Gg: AYBFou2W+l1WmnkgiNkFjDytmbH33ITdCjN4Mx3eYDLjxUCaDZyY3kbkJSsEcjVw972
 9pceuClifHZvhIm52rXPo9v2BwwRHiihPQ/7Dmg25vzJA1ajrgXvCxyLXjlfEMImnLIlRUWucfD
 YYrvsGn0Wv5JOVjWQ3P2zejGhemuLvrYzr7VkJu8G/xigyShI7//xx8zikhVPhDUYF2hDY5sWGj
 h+NL7Mi7LenLGIq7pSNLNysxXrW4yEdhIDpwHBr98tajEBN/VNIKsLlBPngrMtBHqS/iuzNafmc
 7TeHDHWpD2QPo7qM8uGk5z5Z3IEaD2lYj36yOIaEIIDg8+afYBM/CJVo3DXUV6p/DJYi4GkgX7M
 3UVy6rF73Q4ziOouOeR6bhpZhUtVcWccNVqEUmOyaczdrDukqRL/neHVqgsLU+mOFZqVnbMDfka
 5lptkM7uPu6mnFGuVBcFZVNLrFJY+ryd91luGKzmR+dxmE7jBUsRccCUcvO8wj3TD50CsfSmlz
X-Received: by 2002:a17:90b:5284:b0:38e:bfe:81e9 with SMTP id
 98e67ed59e1d1-396d0e5f5ffmr52379745a91.1.1788258207871; 
 Tue, 01 Sep 2026 03:23:27 -0700 (PDT)
Received: from localhost ([2405:201:4027:a919:e2b2:8560:26ea:4d1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396d777c329sm7389983a91.2.2026.09.01.03.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 03:23:27 -0700 (PDT)
Date: Tue, 1 Sep 2026 15:53:25 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH] bootstage: fix unchecked malloc and undersized buffer in
 bootstage_mark_code()
Message-ID: <nsbob67calfo3hn6y23psz2ornx7clha4pvozyify7a2sicqve@gchdniswepfp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

bootstage_mark_code() allocated the label buffer without checking the
result and then dereferenced it, risking a NULL pointer crash on
allocation failure. The length calculation also failed to account for
the "," and ": " separators emitted by the snprintf() calls, so the
assembled string could be silently truncated. Additionally, when file
and func are NULL and linenum is -1, the buffer was passed on
uninitialized.

Account for the separator bytes, bail out on allocation failure, and
ensure the buffer is always NUL-terminated.

Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---
 common/bootstage.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/common/bootstage.c b/common/bootstage.c
index 4532100acea..9e1a8609148 100644
--- a/common/bootstage.c
+++ b/common/bootstage.c
@@ -175,12 +175,15 @@ ulong bootstage_mark_code(const char *file, const char *func, int linenum)
 	if (linenum != -1)
 		len = 11;
 	if (func)
-		len += strlen(func);
+		len += strlen(func) + 2;	/* ": " separator */
 	if (file)
-		len += strlen(file);
+		len += strlen(file) + 1;	/* "," separator */
 
 	str = malloc(len + 1);
+	if (!str)
+		return timer_get_boot_us();
 	p = str;
+	*p = '\0';
 	end = p + len;
 	if (file)
 		p += snprintf(p, end - p, "%s,", file);
-- 
2.43.0

