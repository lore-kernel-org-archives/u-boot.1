Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78EC606A321
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 10:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wAoTiE4O;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mIMVaJEC
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A472F81184;
	Fri, 27 Nov 2026 10:32:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j0OeS09W79UC; Fri, 27 Nov 2026 10:32:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0973F81233
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795775528;
	b=aYAr3lmENnlk32FPabzXE9rFn4hRgV89zN0jgYDDGR07K7DAMtsDdDom9Hgj280/2DB0
	 ElmaInHyH33xThSAbEyNQ7+eenzb/Mx3rqrebO+2hmSyYTkMvo2dK5Y//qs7irlTiBotU
	 qinOziaM8sb8hvYA9AWYCD2Hu6VlL7fY7AucJcT5PVpYtfVf9X4d2sUEXOj2Lva7U7Mgk
	 tkKiDNsdxu1Zd5XXg6NJKze5gwkEQnbYK5JuQ0pmuUEQ7qZ2I3fZMhLOR4cYeDPB7ffez
	 mO4o0L+OYlzvPD7OewEjNeBT7R1lmRjvXhYzq8zps+BAikMjiYgI/H6U8g5jWGSWBoA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795775528;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pAvEUGcXibpxAuWQGtR+zlJ9AYCR1+IXa+3ughf27AI=;
	b=E3rvYZhHv70TBSm1+eWUQ84qFNrw2hNvbIYfVujMuR7TewQhp0onGwKwKpCRrvdtgLAD
	 tZ97NT5r9m9Bdh8UWkHc1mqOQc+F+30ODyOiu5DjJtNgC080/mUuzWtVqgSEWv255Ckyf
	 szqoJ3rnP6AH8xcrlx3c27mt3lBQuIT4RNhP8JTJ2bC5WB3vQDO8caZFSrWfRHkJ/z0yk
	 7RAVUtOZSnwm1p2I0sQwA2C1x7TLTX9X0hrge52NEtDHddU70hYd2gDGDZSU/Wh3TVS/g
	 sr3fdHSlhtMmEQZfwzKohCc7Usf1EBN25yJqZIilEHQPtYMRLn13OYsKFZhSz/Ok5+g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795775528;
	bh=pAvEUGcXibpxAuWQGtR+zlJ9AYCR1+IXa+3ughf27AI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wAoTiE4OpCheKxS2kg0UnW2bFF7Rpth27i00vMFxq79Rpjn7jf3C/co82xSvjr9t1
	 MwKs8KlSzyaPm73EPklkI1KfI9bL6EY8ZkZ05owhyUiTsncT1wPlbAS3Dp4V3x/U33
	 we5w16a/6kh40QCh8smVopH5YZQgGX2++T03ly7lfEADfWiJqLmQR4WbwpJz9J3vGP
	 je2eSWhG/pa56zed7wrMfaVn20iIDaZwJ/2QV4at2GdEOROcWIc70xQBEdha41UcoS
	 frVE1liWj+VvqUflGPk1OwaLOZlABAURe8TcZQMPQAmjZR+Az9mgnujlbWrWG/qZSx
	 YOElHWfBLTfjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0973F81233;
	Fri, 27 Nov 2026 10:32:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8610C2BD
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:32:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 77F7340A5A
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:32:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hjcu9l9XJ948 for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 10:32:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B7BDC40A59
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=mIMVaJEC
Received: from mail-dy1-x1334.google.com (mail-dy1-x1334.google.com
 [IPv6:2607:f8b0:4864:20::1334])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B7BDC40A59
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:32:06 +0000 (UTC)
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-33bf40b0c8bso16885357eec.0
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 02:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795775526; x=1796380326;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pAvEUGcXibpxAuWQGtR+zlJ9AYCR1+IXa+3ughf27AI=;
 b=mIMVaJEC5gmDBYr72nieN5d3rq2/1w3GpREPgJ5aKwcCyJnCN8sYbN+rEtOPZE/3gC
 Td2cuUIoy39Sh3PzMPN865o6He8mlAiegWiLmVFCTuThS7HGi/Tc3fDvz22kWTH6+tTP
 2fLvrcPRRH6ewn9R1CAkvrmIyWNtor+h/Q7ZY+ET5uTSfGRXiLEwA2ukIYK7yB98ncxM
 sKf3P3s1On8Z1sQF6B6CMA2hqLqV/dOjvBapIqhWyVijPw707RPT8hyXiKHiwsE6kDtM
 b30vTnU05xrHk/o3prxBLJDZJqZCV1oCieeF4R2/FpqTHRHgoSMwTt+LBvAK2L3n7Puq
 F47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795775526; x=1796380326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pAvEUGcXibpxAuWQGtR+zlJ9AYCR1+IXa+3ughf27AI=;
 b=KI76BtXMnLHbG1retgRyWv5A1MnMuwdUwY8eNho2vtbtvKFk1LNcmmMq5caBNrC4Bp
 8LmJAVI0QSOCSVAdOJbQRmTaXw3ZyLNiECXa456SSAPZOVVISl8A2IHPYOr3WFZ4woRS
 mb7o7kXiPyGJnIqsrNQXBhkQzVz01m2jQI4Rc0sx0EfIPJlB6RWX8lGSpWKfuknrykFQ
 spEAhrwIGQW9xMzAW9oPEIwXQ88ZkB1nXLtV5yK6Sq2RlLFrZhwUBLpyGyxU0NbLfnMR
 o9Mhis8LNjG3uukm/P/kIodgX2IigL8coqs5txjPDo82JyEsTHtNgHqSPFRO0Px33qWH
 qpRg==
X-Gm-Message-State: APuU4Z+Z84g2vmX6EYwA5EqzlW3G4w81N6zpxKAhim4+kG5y4rhHlT56
 hrHarBZsjJLP+oWfSKt6zvsjcxyQT47dYv7oFmXY3r+BZtfmCr6phPcNWAI9Hg==
X-Gm-Gg: AZFdTZfYGE5NG599B+tU1428b/02hebG7jbku4tsBM1NOh8ucG1xmhRRtSAuF7LDDgo
 77K9y16ezMv6trk+SoP8VS+yu1X7rFRBKQFozMDZDWL24G4a67PTlentCNDi465G8lDsP0CLOCL
 AiEqPIhn1KEop7PFXuV71qQlv5USXUGF/D1T7dmsXhw85Ray/PcZqgQ+qWw+B4JP2Rasf/cira2
 XBunUTUMri01H/BHMoPF2StRjS8pnbI015IdVu3q8En0zcVgBLyOtHj3Z+yiuOQ76aAh6MSg0i5
 VJIvME56uuXE3ohkvLnxZgk1nUBbyrbnxP/dVMO4sZ3t6Qs14MonwlL0I1vEYJeaaMpAYT0HVTt
 2bjvtRjhwUqCMbzKVT/7DqwlJ2A9jlKofK8bY+0xpvYXuvuu0mi/xYYVO4fuUybKUT+nJUsoMvC
 ESMELcITi64r6jO4EEa4bJUanWfRolTcYdje1PrQKV+xXhxBmh3+Q1peAD0Dku1tIHZPBKlaX2X
 iEpvS7j6Jvw8h3Ci6VyOxzGKvBzpMknK0osH/yXgzoroT+S2LLHB4Uy8xv96Le6hfLfwh1vbK+c
 CdyzFSxnLY1gHvjOSc3B3AOasOYd
X-Received: by 2002:a05:693c:8083:b0:376:6530:248f with SMTP id
 5a478bee46e88-38570a3717dmr28179761eec.24.1795775525406; 
 Fri, 27 Nov 2026 02:32:05 -0800 (PST)
Received: from arch-rock5b ([45.112.0.246]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385666e7fc3sm63369991eec.8.2026.11.27.02.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:32:04 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Anand Moon <linux.amoon@gmail.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Dave Klotz <DaveWK225@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, E Shattow <e@freeshell.de>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 u-boot-spacemit@groups.io
Subject: [PATCH v3 09/13] riscv: spacemit: k1: Adjust SPL stack and malloc
 configuration
Date: Fri, 27 Nov 2026 10:30:08 +0000
Message-ID: <20261127103030.4647-10-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127103030.4647-1-linux.amoon@gmail.com>
References: <20261127103030.4647-1-linux.amoon@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move the configured initial stack pointer from 0x01000000 to
0x01200000 and set the SPL relocated-stack simple malloc
allocation size to 2 MiB.

Trying to boot from MMC2
Transfer data timeout
spl: mmc init failed with error: -110
Error: -110
SPL: Unsupported Boot Device!
Trying to boot from MMC1
alloc space exhausted ptr 100380 limit 100000
Aligned buffer alloc failed
spl: could not find mmc device 0. error: -19
Error: -19

This updates the early boot memory configuration to accommodate
SPL stack and dynamic allocation requirements.

Cc: Dave Klotz <DaveWK225@protonmail.com>
Cc: Eric Chung <eric.chung@riscstar.com>
Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: E Shattow <e@freeshell.de>
Cc: Yixun Lan <dlan@kernel.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 configs/spacemit_k1_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 0f6e9284259..a6d0ba6153c 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -3,7 +3,8 @@ CONFIG_SYS_MALLOC_LEN=0x1000000
 CONFIG_SYS_MALLOC_F_LEN=0x10000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x1000000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x1200000
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="spacemit/k1-musepi-pro"
-- 
2.56.1

