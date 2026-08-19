Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B351CC5DF6D
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 03:57:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F54280EB9;
	Wed, 19 Aug 2026 03:57:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id osN9rS_Xzic9; Wed, 19 Aug 2026 03:57:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787111830;
	bh=tzgrJk5Y7gKVddrLGm5lxAUqFBwGwO6BSzvfQeA+Oas=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rV6xYarWX4iDFnImBQMqPSKN+SCZmLKAicwjU6HWT77jQKZwGzQxHFgimTrUnXJ88
	 l+yft0AiUnA2y/cWxU0rLsBN2xaUeiGZQ24bulFhQpyw4tash+uLj6Ofbl1j8lEZix
	 Axg+Dh7r7Mi7VLccsoG0r2gDvHf+aoURFcyIPkPVq9fNLG7QhkhM6h69S6ZN8E5cXp
	 w6nM0PO8xrzNg4xZyuWohw/8OJqXYyeoPHMFYBTH4qeTTQR9qXfanN5FQtuNub+2KA
	 99D0a57yNsd0vF3EO0wRU6puFnOHS9i3rUZsXcbwTG8K0ycGAaenxmoH9RW6DnIWRr
	 yzLQUM+Lm/H8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9E8F80E57;
	Wed, 19 Aug 2026 03:57:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D6E339E
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:57:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6334E80C31
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:57:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jDiyqrO7P5oF for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 03:57:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=Oqmh1tKJ
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9557B80E57
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:57:08 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2d560775ca2so4629615ad.1
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 20:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787111828; x=1787716628;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tzgrJk5Y7gKVddrLGm5lxAUqFBwGwO6BSzvfQeA+Oas=;
 b=Oqmh1tKJpjwKsjBThx4A8L2qYalV1OdUtQEsDtkSSAoA6Iwl+2RSOXg2U6I5GHy3i5
 0OjTUN3KlE5EEkDoOVFjRDSt/zqRF79GrBrVsXrw7i/Dsc7dVyUnYshG2k2YLNV1QFRW
 kR99M6fsEX5vpwRGDS+GVEm28nC9H7d2n1ioA+Jj61APYZEQKCeGHBx2Z/pASGf1fJKM
 AcWXOGcGoLF+jsl8WjAU6xUb3bKZ8wWdUhqwhjat83ZgPeN4Bumefq8CiP0WsJmRF2Wa
 6Nl0loPaEpxGPVLMoWCuRTRGnJ0HqyzInd4DdYp2+n7SHsoCcc3qBPniR1Ta81NfgiTP
 8NOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787111828; x=1787716628;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tzgrJk5Y7gKVddrLGm5lxAUqFBwGwO6BSzvfQeA+Oas=;
 b=q8FWT5/AFICzCFXLfJtifPHF8ch/LhtXAqkXyn1GUbPFfsA1zxlQO8mzmBwSYktGAb
 MZiZxduCvbPJ5uEWo/G2fQx+0/47TJSYfTftJcar9utLGx95QNyqybv3hPSiLAdJE2I7
 E22IN9KcYNUbOqC8Nz3E2Jh/A7bN0ThqCdXCUNjaqDf0y4qQSLsB98qI/SnM+Mo5bsFt
 Pb4tpU1q/ydISbiv3DHP671SqmvAnTdz26uvHz3RDCQFelV12T0q4ib72u6yfF3Pop6X
 UurvmVa9xMAMredM5f52GFu4C1W1LyWlcg+Yc4U2Ggxgt322yYd0JgQxOo1sJZzkfqT9
 lkaw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp0hum/wVBlxMO8Btil6+HcTrdhIbvrBEdxYy933cvVRS4sYUHWqfwt7gEVM3U0F9fNulrqZn8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YznmPeHIKYwvtnD+gIWRaUzsvI5hItLoHYvYkv08sYOMObqX8kg
 qyXTZI34+xhBqptQJ7VQiVFb1EOlecsQ3e+WSeWWPB3UAN/XNfOymQyn8tXGl0bu4Rs=
X-Gm-Gg: AR+sD13yYXvskbk15NL3fvB6Ww6srO6avGEphLbBSGWWSrQoDsQbsBYctJPzPkzv+b5
 EJiIBp7kIKM72CodEt3II/cpnaTN9o1gy6Hojtreat+hDHQ9BFtQJPHs7r9T5Iv0dSEHtJujbpJ
 v5KlzPuBdclhJd7GheLo8vO3MJaSxhFiWMn4KS9kPDgfLtgcwMT+fLgAGlHk5FGHC0CKfsNF47v
 KnEWloQglIP7U5+SQ3pRU1sxhMIwg/HrGDpEBPSeLfy2vr1D+h6eRhc5en6bkPpg3v9ii9Jd+wY
 5XTg95woqOZxklKTPiwF/WS8/e9aLZc8Slv6r6SDIaJlWoNJiYctOumZpN98oBsoCtuxxClYM45
 WjT3uhFH+lJBDT3xTw7OXzMvc5DYjifIB+RlCAeBKmLBCb3F25Brjh+wX7L521g1BOCnRjJ4eZN
 zg2fdsOYErhNMCpiTJ3HN2QV6fgS1THNa5J4Ai7Hzdr4TdcDCry/R6oRo/pmGahuq+/57kuhZEj
 baZPTtI468tgpKSJILrS5TMv4DNsZojUJTzTvc/crhgMVlsPuSvENW50I+N5KY+Tdn65OS+mBmg
 7xzcRrnJsYO8MPGYHBcozjg/VQ==
X-Received: by 2002:a17:90b:584b:b0:38d:eaec:4396 with SMTP id
 98e67ed59e1d1-3958110c322mr3247814a91.11.1787111827661; 
 Tue, 18 Aug 2026 20:57:07 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad53874sm2912408c88.4.2026.08.18.20.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 20:57:07 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 19 Aug 2026 11:54:55 +0800
Subject: [PATCH v9 13/19] riscv: dts: spacemit: k1-musepi-pro: set default
 console baud rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-m4-v9-13-6e66016392b9@riscstar.com>
References: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
In-Reply-To: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
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
 Johan Jonker <jbx6244@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Eric Chung <eric.chung@riscstar.com>, Andre Heider <a.heider@gmail.com>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.15.2
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

From: Andre Heider <a.heider@gmail.com>

Allow serial output with the same uboot/opensbi settings so the
console works without providing a cmdline.

Signed-off-by: Andre Heider <a.heider@gmail.com>
Reviewed-by: Yixun Lan <dlan@kernel.org>
Link: https://patch.msgid.link/20260513071958.29574-7-a.heider@gmail.com
Signed-off-by: Yixun Lan <dlan@kernel.org>

[ upstream commit: f125c6085fd775f09a316f61cc89a0ae86826895 ]

(cherry picked from commit 5a2fd40a11e3de8b4308b739971ab1dd4ed9ae5d)
---
 dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts b/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
index 898b537ba0bc..4aef287353ca 100644
--- a/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
+++ b/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
@@ -22,7 +22,7 @@
 	};
 
 	chosen {
-		stdout-path = "serial0";
+		stdout-path = "serial0:115200n8";
 	};
 
 	leds {

-- 
2.51.0

