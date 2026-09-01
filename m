Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E37C61DD3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 10:20:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D91680B2E;
	Tue,  1 Sep 2026 10:20:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ryORdf2myC_G; Tue,  1 Sep 2026 10:20:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788258042;
	bh=rlr96MT3qMcPb6jpXMKEpixWpxblZLDaISIMFw1pgDA=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ebtQqsxZ7wDMU8fdKSIA3PJVVAnJfVwWHDQa1HLTPB3H4tPk8YPbS6tDFkLx/6SHe
	 /i+HotQ23MoXX1ebXbnU8Yo96bHQFq8rl/PmC5yYwKzNwydqfJgGm8ryALuEWIuNwb
	 KCi81KXUVTcEcGPr5fUDUPd59wudzSP/a98d1zxJlz1puDfCZjRX0JbDNgdnbSMGHU
	 wErbNYlu3t7l7x7C/HLqmSbc4IClcCBDvzEUF6juAeNdtfeXnz2ZUQCbRSXRgFu4pn
	 innQ2YN6le8VNpfc5vM1ILFWWqPsfGW72c7XFeiba9eFBYzuLhRPR6Y2QjjMaXXSzW
	 0C98hK3JM+5nQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AABAE80AD0;
	Tue,  1 Sep 2026 10:20:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 995792FD
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 10:20:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7F60A80AD0
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 10:20:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I8emis0KAoyr for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 10:20:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com;
 envelope-from=naveen.osdev@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RpnP7ncM
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CC7FE80A9F
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 10:20:39 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2d6e954afbdso4389735ad.2
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 03:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788258038; x=1788862838;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rlr96MT3qMcPb6jpXMKEpixWpxblZLDaISIMFw1pgDA=;
 b=RpnP7ncMqCJK5UGSORMJp4EzGRc6lPlVqKsCtLfZow06sZGP2lrNL4Jvvk1AXPPcju
 +TLflPnVfiNx7mKHTFtR9m50EvOEeO8F5RRSQbXzf68S07YiK7n+ww+NU2b6vZRo1hVr
 xo5j2OlFiUNbsEhOW3vdnGjp12pKnjQGr14L6OZMqQuRhXcxaHmo21KzQYhg/Lx/bL24
 6VSq7gwThG9Y4FXSpQcT4hO+9x7migKcqI+qW5MKgnc82yv2iamCk81574f6DNpV4hum
 fip7X3ExFdVGrmfLXpvT3n3d2/17jNejfNteVzF5iCBHri0a9uN0vGHToDh151fGyPqY
 wmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788258038; x=1788862838;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rlr96MT3qMcPb6jpXMKEpixWpxblZLDaISIMFw1pgDA=;
 b=P9fSrOd3E7tcHiGMXpaccGdEy/aXgy2zBo04bWGeLGmBtO2bzUqlJMFYtMCDqeC8lM
 McJL/x6wmHb2IhfW2FGdlpIa+6CaUG6B702ejkSfnE0MYM2o6osrFA5jFAjtAPGKu3vo
 nc1OCYlTmGa351lgqkXgMMYahFh2vvxcpYVue1n7bfFnu9+XFJjlOh32B3zRA7LbutOV
 MtqtzfxXYSDsBd+ybUqhcxxV76XHLBFTVgCH1VeBQfGXUO41+PXdWzU9OsQM6eWHh5sZ
 nzzYi9IwbdIRQGE1J9mHapIP9Sv9dQPKzpkZnQHqifBpE5kwKpUHo3kk8YSq17eUYMdY
 alHg==
X-Gm-Message-State: AFuF++l3OtMxIrt55PCOwCC6xqpmpqw+GoC/pxgmVYNemAANrBvN95YC
 rIekM8ERtd7WaqjdNPcKN8DpWAcRm0id8X3HfVi2gDqG26lXOh0C60mTF1vNeA==
X-Gm-Gg: AYBFou1jIdrLtzC5DRk787CYTh91KJ4jPnFe6AqncQyCadWbutFyxNB8rCrP5iaUUwT
 OzFNDtWUAQAMP3ysuLaLzjFUC2+4L+1IFEfN7Gk9fnaPOpuOScw032URO1DxFonzlDJ1zbEY3U3
 G6xaphr30Bb5eEv6NhPo7MIbe6U779CPupQrDgfU6vc4HVa804lvjHK0o6+9Y6J9Lvad8mGgbvr
 RHJCtcrJGXUJMzboDjrVJmEP4wql4aJk/Re55m+zrVkao28AWJQqUuupEFzDtgXE+3OQ+zw9azv
 mRfE+LtLzQMqi+rPJXi1qJuo8RZvPH/4DOVoJ2naK4e+KwJngXa7/kvykqcmGauGqQ3DJ6vhWLG
 cGyINtRf7b9V1FlUcl9dSvRgGf2WyeKliwZr1dAHW2z0tmdU2trqOGdZ9B6FCM871O8trl9Qhs4
 WM8bdXpbSgQ6r8t0SdPTjx38Pi9fVq2UcKOOe/24ufS90PlvSFQP4qLLJO1JLbu+w=
X-Received: by 2002:a17:903:38c4:b0:2d9:50:a91b with SMTP id
 d9443c01a7336-2d90050c487mr119557955ad.16.1788258038392; 
 Tue, 01 Sep 2026 03:20:38 -0700 (PDT)
Received: from localhost ([2405:201:4027:a919:e2b2:8560:26ea:4d1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d918402fc0sm31554585ad.58.2026.09.01.03.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 03:20:38 -0700 (PDT)
Date: Tue, 1 Sep 2026 15:50:35 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: trini@konsulko.com, sjg@chromium.org
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH] board_f: fix use of uninitialized variable in initf_upl()
Message-ID: <mkv6dosnzm64fr7y57lhsynqhtiy5bhp2gawlk7vstfyjm37cm@tntjqgtdok7m>
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

If the malloc() for the UPL handoff structure failed, ret was checked
while still uninitialized, leading to undefined behavior: either a bogus
error code was returned or, if ret happened to be zero, gd_set_upl() was
called with a NULL pointer. Bail out with -ENOMEM on allocation failure
and only read ret after upl_read_handoff() has set it.

Fixes: 0fc406ab20e ("upl: Plumb in universal payload to the init process")
Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---
 common/board_f.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index 59f1f173a27..ead7b6dd743 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -903,8 +903,10 @@ static int initf_upl(void)
 		return 0;
 
 	upl = malloc(sizeof(struct upl));
-	if (upl)
-		ret = upl_read_handoff(upl, oftree_default());
+	if (!upl)
+		return -ENOMEM;
+
+	ret = upl_read_handoff(upl, oftree_default());
 	if (ret) {
 		printf("UPL handoff: read failure (err=%dE)\n", ret);
 		return ret;
-- 
2.43.0

