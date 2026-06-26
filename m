Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2E7CDE008
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 03:50:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F9448496E;
	Fri, 26 Jun 2026 05:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FWC1cvVd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED60C8498B; Fri, 26 Jun 2026 05:50:28 +0200 (CEST)
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com
 [IPv6:2607:f8b0:4864:20::1331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A78708495E
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 05:50:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=naveen.osdev@gmail.com
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-30b6dad2382so1175338eec.0
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 20:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782445825; x=1783050625; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gb2Li+Hg8iHDuDJkSWbMWGqtq5K7gaXTxuR9XSeHpes=;
 b=FWC1cvVdsXnRGDvnBRnvKcnbJysLpHwBVb/B8vMFui3sdAgJOsolIheLq/uiPiDhaS
 CAMOYFglpkD1ASWugUG25lDeiW68X9+U6mxLb2bMS/Ns9jxQruqHXQFAIpE5YT0IOHhQ
 4dE1tVa+LgHOVjwnYGYZZqsyxtBN/p6JrSbcSYVDzSMYtER4uzbM3lUib7CHwTqB6Cpd
 IpnKB+iQ/pEvmxNYisC1D8fgHxTBjjK7GscTCG835ZJ72wVWUo5tWOM6X4GyUxS55u4K
 +LjqKGR5Z577rzUZiTkDNi/JoxqyAeo4ZlbYqJN1LoyEf/U8nAtgKf2586Dv2CxW+H2v
 XApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782445825; x=1783050625;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gb2Li+Hg8iHDuDJkSWbMWGqtq5K7gaXTxuR9XSeHpes=;
 b=ZQsb2Q1B8Ev9N4sTcbZnvnkUE1cVvZKQYJpdDulshlkf+RswkQWgmLjrokbVIFDoco
 zGbbLmAqF+4F40iRVrteSJ/OfEgTPOa1BXCeauMAd4aEHwcrF1gQl3SgEAmSykpgk4SE
 bMuV4dBUOz0sZQimIaCwQG3wIEGcvVQ3kvyK3RW2v/dVYfP7UhxCfoombBL6wFWomD0t
 GB0sElLQn+fRqlB6z4pmm+WCK0iz4ZSMuWMzsEpIEY0rFQd2OqzIIU1hBsUcbiTDl2nB
 HpKZi3e6rFhLF2Kco6+7JeEba80Od8e2z1s2z8f9y6BK3YyuBa/fGeMirvBxcOgdqUCX
 Ibug==
X-Gm-Message-State: AOJu0YxdO3ULAucmxFDyvawhw5VoRn/SQIPKLdEKlPpobTAWCxo461R2
 T/bsfh7EBslUWa4PvHdPAF93AaeR+Y3wSoK4VRS+Cr85PUxRAhtK+YhI
X-Gm-Gg: AfdE7cnSPgfkYHjP2DDOXlhSEZ/wm1OxnmdO4tnan7NRgEEjkb8OI7Kkod/uFbrhJWy
 8LjL+9NOMRVhW+3uoIVQF253uODsXJmhbl7/bnTXMdANfqVn0dtyEVuscPOJjVkVTNyeUu3eHgP
 043d3RXI7Q3OpWSv/eu7XXHhfNSWlE3Q+NKoCm0WY/+shXCW1utnzyxjJwrPHpzTjybj+RkEwS5
 XdaWe3zpP08cVclm5/H62wztL4w+xNMA0wgNY/gYzhzjpi8a6yUyK+KteXFfwqE9aGiEjVo2nmk
 zs8OggTvQcOP0RIX7yyeOYUcQM3m0bGyGqyGcz26EkR36Ddf+PV0JoHAJv+Y+r0KDvRvgz5ywmh
 YyDYnfTddeIBCTRX1pVL2NqanEXLG5X0jasnKr8ya8NCXLi6jorR5KQlgLaWTs7B6G++3+LhKFf
 pG0vr79pZQDyrDow==
X-Received: by 2002:a05:7300:7647:b0:2ed:e12:3769 with SMTP id
 5a478bee46e88-30c84d70176mr4992256eec.31.1782445824967; 
 Thu, 25 Jun 2026 20:50:24 -0700 (PDT)
Received: from localhost ([2405:201:4027:a919:e2b2:8560:26ea:4d1])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1a80sm13160955eec.18.2026.06.25.20.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 20:50:24 -0700 (PDT)
Date: Fri, 26 Jun 2026 09:20:22 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: sjg@chromium.org, bmeng.cn@gmail.com, trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH] cmd: x86: zboot: remove duplicate zboot_setup() call in
 do_zboot_setup
Message-ID: <yyd6c26qxgnlewo7jzibw4ryl6aycp46nfefwanxulmzs3y5k2@wlde6okhi43g>
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

do_zboot_setup() invokes zboot_setup() twice: once with proper error
reporting, and again immediately afterwards with no diagnostic. The
second call re-runs the entire boot parameter setup on the
already-populated zero page, which is at best wasted work and at
worst leaves the structure in an unexpected state.

Drop the stray second invocation; the first call already covers both
success and failure handling.

Fixes: cb19931ee56 ("x86: zboot: Drop intermediate zboot_setup() function")
Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---
 cmd/x86/zboot.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/cmd/x86/zboot.c b/cmd/x86/zboot.c
index 3876d163236..cc7292e10b7 100644
--- a/cmd/x86/zboot.c
+++ b/cmd/x86/zboot.c
@@ -66,9 +66,6 @@ static int do_zboot_setup(struct cmd_tbl *cmdtp, int flag, int argc,
 		return CMD_RET_FAILURE;
 	}
 
-	if (zboot_setup())
-		return CMD_RET_FAILURE;
-
 	return 0;
 }
 
-- 
2.43.0

