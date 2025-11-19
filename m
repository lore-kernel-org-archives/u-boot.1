Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01AACF34C1
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 14:57:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3571C83FC8;
	Wed, 19 Nov 2025 15:55:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YlXQJ+GX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60B8283FE7; Wed, 19 Nov 2025 15:55:38 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E24D83FC0
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:55:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-450c9057988so1466144b6e.1
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763564135; x=1764168935; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7BcxokQf1Yf/ICzgPmrDOPTr8osqBBy3fNXSUjKTVqU=;
 b=YlXQJ+GXMyMuSp7ZbkLAN3frkZQnI6CnBhip+1LaKoACeS/WdgUaYKoeILZZuXY1pu
 RoPPPc1qUZKkRam39+mY4inJENQli1TyRu9iS8RMyDDfxkhJCZH6p4hTjk0bvYI+g6I/
 71HzKqwNmHcLing9+vH2x/9NSdQTEZ2QtkLR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763564135; x=1764168935;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7BcxokQf1Yf/ICzgPmrDOPTr8osqBBy3fNXSUjKTVqU=;
 b=MPHPMPUbqp9Zbx8zy2AknYjGcBU6Lx9017pNKkAbi32cTDgR7Kw/OSyeTqpQ7PC8t3
 Y2PrUzVyCWDUwa+3L+xvo0rwLwJ3jF3SFr5CfTZXinYJRkVXZhM1H7BNbiMN2c5qAB0W
 5ukftiC0TchC0PgLib9sTk0gCIp4jTPEUWeKzpwcY69kWfjrLTY+MOPt2YXTCteQRudW
 Qret4LdR/x0PuWyBG3T9GO/ym+E27WX2e89BkAeLlB4i7kf2NX5Qv+PeiwlhB78lzhmO
 Th7p9D8RxbvxdO04Jgzl/QuahysrZgVuFGAB8ZWjQBrXG2Y4zNgam5pb1az8TW2WWCZN
 Y6lw==
X-Gm-Message-State: AOJu0Yxct0xD5yxkx1ysBsZfaCSQYW1KAOmFye+r2TkPXyCB9l20ch9m
 /3pvFg5m6mGrdJWeZQ0jcKUZgcsVpBZf4D60lqV7I6u6Hd6M+c2gZCVPrY/pm32679ZSJBQbHJP
 0rW/e+PoYUQ==
X-Gm-Gg: ASbGncv/1/5+K2Hc4GGh76yMeHfiwd645CpZ6CQnttjwAh3peWn3Y5r2Ka2Wmh2XD0W
 FT6T0D1KPkvU0MjKRRiuFNxJpwkanbiwZHEKLN1QRuIjixqZRVgSkSbr70NDQx8sNHCRhB4SeJy
 xoNBTmNcrMJuBkNMCCnmD2t45Q7P6S0Ibt24fHLYEw427jFfYhb6/IXaGT4LLMMFQbb849KPZBz
 y/fPMZXfhfohali14Jdv8qq8tHFSg9MSZ3Om1zH1C3pnQEcBQBlwYHVfqMZjTrSN3EGyUrrWUEC
 cZc92wbwR8vAZ7Mj5rW1gt9CugI+jjm0t9/kdd3WDnMgqaiRoSyMcOyo15ZP39Yao9aX62Wr2U/
 0Mjv3EGtwj9l+nlYE2Aqf4GOdKWZcRbeg99/Me2t9vD9l30Pc69Bn7xxi1VmVPGXOi17sdDDn5Z
 7aJ1Lx3wdZ4a5HpOBluwvNTx/XBImD7M011qo8+kflPsY6XrsBolzdCHss4wQJgFo=
X-Google-Smtp-Source: AGHT+IFgWZSoJ3Cv+YUTGM5OVlbulMg7FTyQW53D6tRM1PMTfqFm+yWMqsMMMAInSbaxrmRYcuMuAA==
X-Received: by 2002:a05:6808:6718:b0:43f:ac46:7ac5 with SMTP id
 5614622812f47-450973bf027mr9261280b6e.13.1763564134907; 
 Wed, 19 Nov 2025 06:55:34 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4508a55548csm6027926b6e.10.2025.11.19.06.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 06:55:34 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: "Albert ARIBAUD (3ADEV)" <albert.aribaud@3adev.fr>
Subject: [PATCH] pcm052: Stop disabling device tree relocation
Date: Wed, 19 Nov 2025 08:55:33 -0600
Message-ID: <20251119145533.843361-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: "Albert ARIBAUD (3ADEV)" <albert.aribaud@3adev.fr>
---
 include/configs/pcm052.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/pcm052.h b/include/configs/pcm052.h
index 34994016c54c..0981b59e10e0 100644
--- a/include/configs/pcm052.h
+++ b/include/configs/pcm052.h
@@ -31,7 +31,6 @@
 /* Extra env settings (including the target-defined ones if any) */
 #define CFG_EXTRA_ENV_SETTINGS \
 	PCM052_EXTRA_ENV_SETTINGS \
-	"fdt_high=0xffffffff\0" \
 	"initrd_high=0xffffffff\0" \
 	"blimg_file=u-boot.vyb\0" \
 	"blimg_addr=0x81000000\0" \
-- 
2.43.0

