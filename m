Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D44C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:23:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B30684A9E;
	Tue,  7 Jul 2026 17:22:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="oOr4DzcU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF65C84AA0; Tue,  7 Jul 2026 17:22:52 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBE3784A4C
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:22:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso4706504a91.2
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783437769; x=1784042569;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jcMEK/A+nhuTPcZIfebG/KXp98LjP85fA8Uj5Lp+9oY=;
 b=oOr4DzcUEkUBTC7j1OiV7MYWaHXYDg6A5dg0sCnH7qS1K6xQkhErYWPFDvyfudG3oy
 8WbQesbTJdJXcqQfMEQjJdXxqJ4ksHvHMUXt8pASfc3awBogX7P+NWzPVomUqzonEFI/
 jTrot4wjzKudFUDDFNMjYqnToDdi5R5qDzhxaiTLNRbnHibVJX36LGwC9wcj5BVzMOL5
 1nQ0XH7rrkJO9urAr7q2yp/oWtEmFqdkSoMFLZ99tsQ1EdZCCIvcFr6Y2arjvKdQPENu
 YU5rGMnyn1h5KFNoZByXk/5pv6/67BvHz/sbLpSFnkgdY/zI642Np4tmKT2uVI6rUQjp
 pqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437769; x=1784042569;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jcMEK/A+nhuTPcZIfebG/KXp98LjP85fA8Uj5Lp+9oY=;
 b=eOo5CBQaDlz5unSYuZFlPD0u0Wk97/Y00MckBrwX4to6IGsqvRTjCN1haHlPA6eu5j
 /+dvbIYXWAsRvZloZxHUyfDE+YVRpMKcPsYA/tTpTK5SdN95i5IGs8SlV8hDFeNSANcA
 dBDIs27I0sICPegxqqyXjy85DR8z+GySCMmmaKcwSjMliGjxVzG6Vb+A7PEDauXo1kKB
 iuXJIU/VJqixSuwihujy0/JVjHytrW6nUC6uC3wgMQEt6WA5OPpuxIRNiYOrF1BuVh/M
 xAhBzzRoemhd3KldC0ChcWPP59FOTvjiO+efoKKTdoFqr3sRfI1+Ww6G+tRyyKrY0Su9
 bs4Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoBO2OwK3bBieXweEoEYv42W/8HFa8o3sr6hbkt2Ffqngstb3DYPe1Km3u2KmS3mHtEZLwqwjg=@lists.denx.de
X-Gm-Message-State: AOJu0YxPD0CBO6XmyavJ0kQIj3BpAdrq9IMTWD0Q1NZgtkOiXtSO3bZC
 od6ybcX0zb63GfDKzk4p1RC9n2k3SYXSe8Y1pPRXcS8KJDC1vwzUG/f13GY7tUpB3+0=
X-Gm-Gg: AfdE7cm/ojkclwf4m2ZR2YZOZ0HgX+qMQ9/DEG/aF7oPfIgRUVHYF4aBapul1pz1Fs1
 NuSxgMAVpKGDBA+bUGemkSJ5eyi995rFxWbZu+H3067zmDHf19SvMZpU3NOstcXp3LcIRGxH6wM
 iuW8wHzSwc+j4THzVt2UaN4FYVWUuzd5G4XpDW9p88m6i5G5R+wqXJ25qfva75hoIn+hLwR7EC2
 oMnOtkDexaCXc8/Qnr03QSHYNJgfeGaAahlpx87LmMmxUNXTGXyMoueDGxC30coWR85r+3AsFo3
 rxDIeozsGUzZTwanbXa1gdf2MewQRkTVPjDhtkHRsM+RMm4sd14PiM4pdRj8NRek4YScR1MTuyf
 jhkc3QBgJv0O7rSoHsSAtEFuodKsz+4CW1PmjnWC99RxIu+KroonvnqEP3dKY19Z77ec6Va37Vo
 AMxhNW50cBkJkLo0LvnyPEHVTVESiQQVBEFbfNtvGKFt0LUCcLHWMHKCfL7PfvpVnF8FQkIN/iD
 pBHQWb7JjL7kBO14ETUppuGbKEjd07Ar/RnMd9bdmUSO9tyKKk0Gg==
X-Received: by 2002:a17:90b:3f0f:b0:381:21ea:9147 with SMTP id
 98e67ed59e1d1-387573afe8dmr5734407a91.13.1783437769331; 
 Tue, 07 Jul 2026 08:22:49 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3117483ddd1sm9594997eec.9.2026.07.07.08.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:22:48 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Tue, 07 Jul 2026 23:21:48 +0800
Subject: [PATCH v4 07/10] MAINTAINER: update Spacemit K1 entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-m4-v4-7-dbd01185f911@riscstar.com>
References: <20260707-m4-v4-0-dbd01185f911@riscstar.com>
In-Reply-To: <20260707-m4-v4-0-dbd01185f911@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong.xu@riscstar.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
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

Update the maintainer for Spacemit K1 from Guodong to Eric.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v4:
- Update the maintainer.
---
 board/spacemit/k1/MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/spacemit/k1/MAINTAINERS b/board/spacemit/k1/MAINTAINERS
index ca994e2a1fb..4b2bc4ecfc1 100644
--- a/board/spacemit/k1/MAINTAINERS
+++ b/board/spacemit/k1/MAINTAINERS
@@ -1,6 +1,6 @@
 BananaPi F3
 M:	Huan Zhou <pericycle.cc@gmail.com>
-M:	Guodong Xu <guodong.xu@riscstar.com>
+M:	Eric Chung <eric.chung@riscstar.com>
 L:	u-boot-spacemit@groups.io
 S:	Maintained
 F:	arch/riscv/dts/k1-*-u-boot.dtsi

-- 
2.51.0

