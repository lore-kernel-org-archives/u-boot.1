Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204AFC3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 22:57:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF4CF88B77;
	Fri,  2 Aug 2024 00:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O045HYEY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86E6288B6A; Fri,  2 Aug 2024 00:57:46 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7058388B58
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 00:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3db18c4927bso4139064b6e.1
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 15:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722553063; x=1723157863; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aNeSCElKTAdAB30xq6SD6g6Whd6yohEq0ALPAUY51KQ=;
 b=O045HYEYLqod79oQM0z21f/CsOtncV95TvwHKkxvczdgCeeZ58QIdl2GzkIpaHH1uM
 AlHDSkcplP1lVDB/tUjh0ymWRkQPInrCp4LjHCFTCsMsgOj2RyAr4y87cjvKFca962rh
 q3KdMdo1lch17SyQh7n2dlpqkv12AWa7Kdsz1S8z2fZ63LYun5tfU7gJCIu4XZaCORd2
 AZV83MxI/cUIkqXc12cWyMJsc784Kuqojt5GN1bxHTTsBGFwxGdVGaP43Z8o6dDdhGMu
 gQh7xviX62GwOOCkVpZaOCrBqbYJXGiw5k6Groy/O+mb5ycFsdInasSpadsMp6TrwbJa
 p8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722553063; x=1723157863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aNeSCElKTAdAB30xq6SD6g6Whd6yohEq0ALPAUY51KQ=;
 b=f0uJVcQKjgtlbEHLuQ4bqxo7X5UZow/2Me1/ccqJQSj3loprRAry9RlcN42JWBP9OU
 dZFSNWXlnwOTnYgWXxcXhS0aHgvTRCkva5IZb3XwojrBKoTI6Reyas1On5IqRinC6PV5
 CATTyK5DzoZv3Twgis0ZzYyx0Xms/7ddbeCQQUIkcM/4B7S7oc2sHKGMbMpReYXEoein
 1EUYzH02ZUgGUeXTdT98gkfvEijVy2Ld6ugLCEhsY38EsFQbWgUEP/0M6JI5cHsMa661
 5VwSPcZq2S+82PyqBT0P0qjpvQ+GfLiZYILt8sBMGDp1DTuTmekIF987IQ/WPP5hnNkg
 4j9A==
X-Gm-Message-State: AOJu0YxjUGCwoIxD6T8my+JVCueliGB3MVCmpFZwWnwmbKKPWWkoVAqq
 nmQODHNfmFELFkhA0WMZ+ZTnq4KfsEwaclhMkK0cRDRrhd6Nc5hthdSCrQ==
X-Google-Smtp-Source: AGHT+IGvFhCX3TTeUujM8xRkbWp8gvt0Lsbb5kN5Nv1OXw3SLufvoRNbYn5VmjJrvXLZ401bdu5ezg==
X-Received: by 2002:a05:6871:33a1:b0:260:ee08:8e43 with SMTP id
 586e51a60fabf-26891d48380mr2014624fac.29.1722553062915; 
 Thu, 01 Aug 2024 15:57:42 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2689a67b515sm58039fac.50.2024.08.01.15.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 15:57:42 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, andre.przywara@arm.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 1/9] sunxi: H616: dram: DDR3: adjust settings
Date: Thu,  1 Aug 2024 17:55:11 -0500
Message-Id: <20240801225519.336667-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801225519.336667-1-macroalpha82@gmail.com>
References: <20240801225519.336667-1-macroalpha82@gmail.com>
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

From: Jernej Skrabec <jernej.skrabec@gmail.com>

Adjust H616 DDR3 DRAM settings to be in line with vendor driver.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Tested-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c b/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
index 3faf8d5bd9..26b7eac342 100644
--- a/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
+++ b/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
@@ -24,8 +24,8 @@ void mctl_set_timing_params(const struct dram_para *para)
 	u8 trrd		= max(ns_to_t(6), 4);	/* JEDEC: max(6 ns, 4nCK) */
 	u8 trcd		= ns_to_t(15);		/* JEDEC: 13.5 ns */
 	u8 trc		= ns_to_t(53);		/* JEDEC: 49.5 ns */
-	u8 txp		= max(ns_to_t(6), 3);	/* JEDEC: max(6 ns, 3nCK) */
 	u8 trtp		= max(ns_to_t(8), 2);	/* JEDEC: max(7.5 ns, 4nCK) */
+	u8 txp		= trtp;			/* JEDEC: max(6 ns, 3nCK) */
 	u8 trp		= ns_to_t(15);		/* JEDEC: >= 13.75 ns */
 	u8 tras		= ns_to_t(38);		/* JEDEC >= 36 ns, <= 9*trefi */
 	u16 trefi	= ns_to_t(7800) / 32;	/* JEDEC: 7.8us@Tcase <= 85C */
@@ -64,6 +64,9 @@ void mctl_set_timing_params(const struct dram_para *para)
 	twr2rd = trtp + 2 + tcwl;
 	trd2wr = tcl + 3 - tcwl;
 
+	if (trtp + trp < tcl + 2)
+		trtp = tcl + 2 - trp;
+
 	/* set DRAM timing */
 	writel((twtp << 24) | (tfaw << 16) | (trasmax << 8) | tras,
 	       &mctl_ctl->dramtmg[0]);
-- 
2.34.1

