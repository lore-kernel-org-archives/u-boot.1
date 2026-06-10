Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DFFCD8C90
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 17:08:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F5498486B;
	Wed, 10 Jun 2026 19:08:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZKUeeo0U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39795841C2; Wed, 10 Jun 2026 19:08:48 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E93BF848A1
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 19:08:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=naveen.osdev@gmail.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c8585cd8400so2751192a12.3
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 10:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781111324; x=1781716124; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zjJNUVgV9ZUDJquk9erGhBmI7tsXa1xIfTv6Ud/U4Qo=;
 b=ZKUeeo0UbHYah6fmHlE3Zkh9Blu/cfMUiPzMuFc0ztt46JlKUmExhaUfaAmc6tx86y
 EvqAwiBCKJcj408rgXK0y5f+boTuPj9O96yOyzlFFT845HsPOa4se2tVR5P4NjhSKYrY
 CfJZUpKyuVGviZNHMf/bHwHCP9l737ySocu2XlEN/J3lpwoTnvLIwIsQKaIxK8Lf1d3Y
 mfsoAtd3DR0Wnm/k7c7msCVgOmu2KflLM8W4gksUh329PvFi/sxsB5gp1rWjE4qxlmUM
 8N9Kvxdyvf9VA/MZn8z/8W8vkMA+BeYK3NitWari45h0G32+YG4E/VODw5p1YwABceOp
 U7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781111324; x=1781716124;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zjJNUVgV9ZUDJquk9erGhBmI7tsXa1xIfTv6Ud/U4Qo=;
 b=XfqPEkd6WxPqfhRybDPmwaqxnc+UB8jFmof3TbWJgkApbcff1c/Ph0W9+v9RF5YKpI
 0cfPBf7NCuYFi1DBtiVmf+6/S8aZ77XCscftaiqhv6oyIQ++dixd8px+otYUNJNqfB1+
 BieB4yVOZIpayjqo8YrpyRoBKHANtGgYJzLXqj1cDZpmyxxbSCT0zCkz2SpN8HCCRVOi
 PMkD1UGO/Sfqi+1+Sj7Qr/c7Jd5fR2EPwnKocYx/bAdBUZUklz2CSKCuLlNoHRmKx+wP
 yC6CnAA9OSzE/BHSo+qCJod4bEgyMbDHQuYYeQXYY+pMEy2mNOypR00mlPjNls1iLcyh
 Idvg==
X-Gm-Message-State: AOJu0Yw4qGYVUHhDKGCdth9EYC4moZ4O56QJFwlN5iktvGyBwkumSxpx
 QjRYO5WVFpqsRGrfk0o2h2lbRHtHt6gh2GiJ7fXEO6RXAaz9EP/wFUja
X-Gm-Gg: Acq92OF3FsshrIX7RrIt4aNaRiZCNj7I1WBc8Wg8Yhzwy00MSfGSaS7wGDrGuVlmwPO
 LXf59L+OmDtnapyf7qCKPvzXDmyljH+n4HRnDkCiIA63vZsGbL+WxDNt3fgzfCmQIbALOdmbrm+
 zQ4PnDkY5niDO3oVlfvJNKOukJG5aJYcI/yzPrIE4dzAIAXCO3KI1kFXes/D9JCZQrSeT9e/K4+
 ACA7CwNtJlvEwZ0vNr+raoMWcad2tkMbqdalaqCZRfmzWrFQHgXPmrC5FWKT9bp2cp+8mTHhNSJ
 Y7BI6XkaaApgrl6Iz2Yjbs3ajje0INmGqpaJcnR95cO9IGuRINPNgI8r84j/JQIB8SNu54DPmm4
 wtu7rm2MMHcsIysIEO8lv9nzAg3E6F9y5EOP6hyv9I4/q2Ef1taz01kJxgH900l+VY7rbuvE5e+
 PY7lJhwkAp4xUMFtEfuExlPBoq5WOgapl/QrdnrSccb7ROsQ==
X-Received: by 2002:a17:903:b0b:b0:2b4:6080:d4d0 with SMTP id
 d9443c01a7336-2c1e80ec3b7mr291085765ad.22.1781111324325; 
 Wed, 10 Jun 2026 10:08:44 -0700 (PDT)
Received: from localhost ([2405:201:4027:a919:e2b2:8560:26ea:4d1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c24edc8ad7sm129239675ad.42.2026.06.10.10.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 10:08:43 -0700 (PDT)
Date: Wed, 10 Jun 2026 22:38:40 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: trini@konsulko.com, Tsi-Chung.Liew@freescale.com
Cc: u-boot@lists.denx.de
Subject: [PATCH] rtc: mcfrtc: fix leap year calculation using wrong variable
Message-ID: <oh5i3u3rhl5e2ljpquojthtbqykqs4eykbyneap5gcf6pppx3w@ehi4yimrtn5m>
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

The leap year check in rtc_set() passes the loop variable 'i' (month
index, always 1 when the condition is true) to isleap() instead of the
actual year. Since isleap(1) is always false, February 29th is never
accounted for when computing the day count, resulting in the RTC being
set one day behind for any date after February in a leap year.

Pass tmp->tm_year to isleap() so the leap day is correctly included.

Fixes: 8e585f02f82 ("MCF5301x and MCF5445x RTC")
Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---
Hi,

Though this seems to be pretty old driver, but even if its EOL, as
long as its in the repo, its prone to be re-used and infect. Hence,
lets close the bug.

Regards,
Naveen

 drivers/rtc/mcfrtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/mcfrtc.c b/drivers/rtc/mcfrtc.c
index 9708971c5c4..23ffb2b31a1 100644
--- a/drivers/rtc/mcfrtc.c
+++ b/drivers/rtc/mcfrtc.c
@@ -73,7 +73,7 @@ int rtc_set(struct rtc_time *tmp)
 		days += month_days[i];
 
 		if (i == 1)
-			days += isleap(i);
+			days += isleap(tmp->tm_year);
 	}
 
 	days += tmp->tm_mday - 1;
-- 
2.43.0

