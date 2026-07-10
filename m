Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D500C44506
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 15:22:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3F9484B73;
	Fri, 10 Jul 2026 17:22:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qQHBnSfI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C05284B74; Fri, 10 Jul 2026 17:22:22 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E25B84B72
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 17:22:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=naveen.osdev@gmail.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7eb1dc6bd53so662185a34.2
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 08:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783696939; x=1784301739; darn=lists.denx.de;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3F2rmjgFrPvsUA2l5UFzAc8nH4bLet+eLiLs2Mg44u0=;
 b=qQHBnSfIe45C5sZzmdkeECIK71XgImK8Xc7JLpiPOJCYAu4ZQzOEGyawxQWAqdVdC9
 NS7hjIEL4Pp5P7GwEmM+FqRr+4qyVQlUVy2WBUwgRIYdov0Px98dtHsQUvcvWznAdith
 Nt6AwvB+yQanHawsdGvjFXCi+D4wz/2nyufwvNpwZT34BcggoeI32yKRC0M6eox2fIgn
 Q+lUTWOM6dGflyxPfewwv/YrIijQ5tcCpF0esgIWqE5cxkur4UazK5mM1+RPX5+8B4Pa
 epW1pktMPdj4Yon/Mrmi3xRjyoKIL8og2Z+NKhmviM2NDxxXfuoDcU2k/s/XHZosF7QS
 SrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783696939; x=1784301739;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3F2rmjgFrPvsUA2l5UFzAc8nH4bLet+eLiLs2Mg44u0=;
 b=BqncwyXZ/pbJY6rg2jLUvTLH0tDI6+p6M9clzgQWN2/p7WZqlSbNKC+4DIq5oAusXr
 M1JzmI9moS8SAnSNXkfMGb5+m9aY23mVodnSGKpdhxzGQXYlcPhiirhhp76a0lPybJ3u
 tm/JjUywcV6+hPzyhd1l8TC0bL/BhZveNirdTEJytAQV4q1bG99VgS5OGDoDpER3qcL/
 mXwTx6/+OGTrW0VIwNEQQiqcwf7soUCIP4JXlJbEBDOPgC0ve0nwIyxfkwRs5/KpIZCE
 vxW5ccU/Yuu/Fu8pur7StI702lmEiS8nn1fLvBmlUmQvCnOZJ0r7/OjAN8a6BKtQyGq5
 6Wzg==
X-Gm-Message-State: AOJu0YwCGnxm31HyAmM9h2YyA2slmeEKLc8AJ5XfNq9b36N5vDxeZWFN
 /5URif/US8rtm3GNF9aVJWfzuOfMGW6YYkOSuXBzri+dYLuZMTwcL0v+WcYvLg==
X-Gm-Gg: AfdE7cncNsFWvHycmc/SZS/w7Te3vsu/gdZfKpcS0GoQG1smMJDbl39EKvDFAGWv8WO
 QRCjTqtD/ZfU+sWjbl3qsfdnWp9wVwkSEW1cJBazbKffv8Y5dSYrt6oIuxvfBQxI6sY5FmxZ0bV
 LtJJ+JKeT2vRSFp/IvhYEyOaRkr/qyd5PHMnVzzN1LzmXVCUO3S/tquvS6BisKGA6N0MeMCIFml
 1Bq7aEdPLFwSV89kNNwk/UKAtRM+9rWouSTue+n4QUXLr3+FZXC8DyejMMC9yu0tlKUIxskGG3A
 LzwXhDfdiFMgm/7XvBVK+d537ksyE3pJNyHQeeK8ZC+aaTUOOuPN8wS/ZJ9YN9bsnpdfzBxt3v+
 m4K8a7UYJIDchBiWHPrzJzy/rakfi71UQb/5QuAk09rcm3491Is874jwq/vAtNNcWmPVR/xNjQ9
 vzFBTAnUoXhg==
X-Received: by 2002:a05:6830:3154:b0:7ea:fc52:839c with SMTP id
 46e09a7af769-7ebd02f9482mr8845656a34.25.1783696938830; 
 Fri, 10 Jul 2026 08:22:18 -0700 (PDT)
Received: from localhost ([49.36.187.33]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcb262da7sm6535489a34.17.2026.07.10.08.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 08:22:18 -0700 (PDT)
Date: Fri, 10 Jul 2026 20:52:15 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH] cmd: mbr: return false instead of NULL from bool found_key()
Message-ID: <do7oqauhs54jgjz7h6zaajwmxzhdcppmm4dt65zxjx5onwn2xr@iufsnhhebnkx>
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

found_key() is declared to return bool but returns NULL when strdup()
fails. NULL is a pointer constant; while it happens to convert to
zero (i.e. false) it is a type mismatch that trips stricter
compilers/static analysers.

Return false to match the declared return type.

Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---
 cmd/mbr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/mbr.c b/cmd/mbr.c
index 7fe6c9e103a..b282b68d50e 100644
--- a/cmd/mbr.c
+++ b/cmd/mbr.c
@@ -73,7 +73,7 @@ static bool found_key(const char *str, const char *key)
 
 	strcopy = strdup(str);
 	if (!strcopy)
-		return NULL;
+		return false;
 
 	s = strcopy;
 	while (s) {
-- 
2.43.0

