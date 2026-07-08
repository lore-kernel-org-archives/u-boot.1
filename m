Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFE4C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 14:33:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E287849BA;
	Wed,  8 Jul 2026 16:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BSt+kMxt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 385A2849F6; Wed,  8 Jul 2026 16:33:14 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACFA384994
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 16:33:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=naveen.osdev@gmail.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-92e855da580so61094285a.1
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 07:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783521187; x=1784125987; darn=lists.denx.de;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1STqlnG3vcbsY6Btad2kydtNcUu9mCo4ztAB4D/4i2U=;
 b=BSt+kMxtsSaR3hl5kQlS9urqomVJv+v+2dFpgCT7dp1Iuz3MKFGPCV1LGiS1Q8En3t
 Pbt1QihcHWE/hGK7LDMLUzpNC0QIpdZpEGWFBbtrnCWfC+HlUiir1mNrIpduuvGnL9xa
 lwR9UqPaMLI74p5cJ5Mdr4FdGWwyKfovRjuf5RVgoAtmPam56tw50IB1ML7EyloT8xTS
 hcIBSZvXKaldf/JCtxwswqWiGM347Cj/xHUBHb5zwEsXSExSVYwpeWK11NkBLCdXaqXi
 0H1Iao7LHbvG4HFys9L5+N4ccMgSrSeuerlA8EJ0rCtiky6knpLxFymjl6ajTXjWIR7Z
 uQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783521187; x=1784125987;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1STqlnG3vcbsY6Btad2kydtNcUu9mCo4ztAB4D/4i2U=;
 b=N/51wrQKx7BtoJM+nR0q2deVlhPFaMPdkOerrro+hSpuIu8G4mDVnmfzJr+fcJvMG+
 qa6jEiRoQwaNgIGdaByd79FXq5is7A09MzcfXzt3wMwfKdtwZ50pzXCVI7UXPFU/wW8b
 0W1kAoaM3zZ1XOojIyxXp4x8xZfkKK829qAly7vg5dryXLH0fAIk/cZfOs4+2bJrm2nY
 Se1YD8V2YU1YIdksUUBoEGMvA1ltlCDYSMN01IbHtO3z6osPw8MaRsP+f58RKg2C3vcn
 29D7LY/0ZmAt9WCBifaTEhwkuLwIoYMRqo1cW5yb1+daUKjv8u0pq1f4s1selcKinN45
 +AGg==
X-Gm-Message-State: AOJu0YxxFiAwGmLMwbQhWxOHrlXjqgRTQp3H8BfE4HS9cFW6om5ejVnL
 /oYyAPbT6ePuuXG8EHm2xfIHulrSSk0lXtvfLJQmvEb/qYuSWLSYE1heLJVvtg==
X-Gm-Gg: AfdE7cnOTq3vkQARoNcRT6LvGvba5he+iRg7rSUAMF8eAJYblguTaIsCGQSQ5adgpjO
 R1H8KJnC6m0sqG8WR7L3CO0w4TvJOKrmegalVQl8+0s27hs+rwEC614ob/jCOp5Qiv3dpEOxHCO
 00HP22YPE+Pb2hYtxJJdWadHNxnIzR2qhgjHjMqEcgd+haW4Ed7SXBhlJ2G9rWxGZVEEg0e4DlG
 BV0A+mJ0Q4mk1dF24uOQhEtKLyZW8soQHbQwthccENuLfvRJja0NkU2sD06465dJQ0etiZOvu9q
 B8UZqT+DO33MxilwcBIci0+h+up1iiYJgf/vvWEbU06hQ1RvLAGfeiPHMd2tHt2bO7LXcHXHHfg
 EOlDM5LNgcYKSO8qKzHCeFBA7bKm2cl9kZZxYgnR4mfVBSaXFvuKi7erAyWzbuhpzbKINvKo033
 qGHj8bFA5ypw==
X-Received: by 2002:a05:620a:2802:b0:90f:9cde:977e with SMTP id
 af79cd13be357-92ecf4cd698mr255432085a.0.1783521187513; 
 Wed, 08 Jul 2026 07:33:07 -0700 (PDT)
Received: from localhost ([49.36.187.33]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e90b800efsm1372393185a.4.2026.07.08.07.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 07:33:07 -0700 (PDT)
Date: Wed, 8 Jul 2026 20:03:04 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH] cmd: read: fix unsigned overflow bypassing range check
Message-ID: <ex5nk6rhdq2xmoebwmbxtc3xxepoq42qlqb3u6ve3rd4inpxul@tuqk6be3rl22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The bounds check in do_rw() was written as:

    if (cnt + blk > limit)

with cnt and blk declared as uint (unsigned int) and limit as ulong.
C's usual arithmetic conversions are applied per binary operator, so
"cnt + blk" is evaluated entirely in unsigned int and wraps modulo
2^32 before the result is widened for the comparison against limit.
With cnt = 0xFFFFFFFF and blk = 1 the sum wraps to 0 and the guard
passes, allowing blk_dread()/blk_dwrite() to be issued with a 4 GiB
transfer count that runs past the partition (or, when no partition
is selected, the entire device).

Rewrite the check as two comparisons that do not overflow:

    if (blk > limit || cnt > limit - blk)

The subtraction is performed in ulong (limit's type), so no truncation
occurs, and the two sub-conditions cover both "start block past end"
and "count would push us past end" failure modes.

Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---
 cmd/read.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/read.c b/cmd/read.c
index 8e21f004423..efc255ce85d 100644
--- a/cmd/read.c
+++ b/cmd/read.c
@@ -46,7 +46,7 @@ do_rw(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		limit = ~0;
 	}
 
-	if (cnt + blk > limit) {
+	if (blk > limit || cnt > limit - blk) {
 		printf("%s out of range\n", cmdtp->name);
 		unmap_sysmem(ptr);
 		return 1;
-- 
2.43.0

