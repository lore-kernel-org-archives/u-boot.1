Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7BBCC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 08:02:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 384E46075F;
	Tue, 13 Oct 2026 08:02:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NMQNmTFhZCzI; Tue, 13 Oct 2026 08:02:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7A03260768
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791878564;
	b=rEHlIqeZ/jmkPYCCn923K9SvYf+XWxxPm623lkfvBT4sSODDOoGAPcbO0u8rszuctmWF
	 p6SEhEyg5Hbp/5y0I2Dx3egLd3SKXTo4mKtPYVm5VHmWwKX7+HO/sdkhY4+/AbjZHCJ/i
	 3j6X9PBDOLrO6ec6Laht/pp92FNURPp/n+Bf3TWTwhb+ermmGQs0gvJk8oK5ExnCPjsLW
	 nIdsyS2Zgy54Bu6foQdeIhBnXHmPFUPKkapYdnVjYEjyqVz/GjNbdnY4E9aHsgM+101MF
	 DhdHFF95dsjQk9GtB6W2qu5il0Au40mu/EIzqKhXLebRm7w+6TBNXdoXi//rsp6P3ug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791878564;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3pkN2fZXq7RGg5QDmbJNkLZpgp8XEmuwO1YZvXiHTJc=;
	b=MadrXV/62rPssoc8YF5jGmbH5O97jlL7lxOZMHk8QFxAzgQSpXyc+4zzv575iCCeOan1
	 oDGnWqwZX8QcRIV0KWR/zFm5D+/15+cJi3BFOlYrnXjO/cnFqgQMeljeHGasfYs5XZvad
	 /d1yTr3eWoYSRsIPho7+Nkp8O89A16Mv9af1bIK9XXlsD2NX6ZbLlc4Sfr+S4iCPchDPO
	 zaAd6GIiS5IRTdF0yg6lJmz/lCA5/7E6ye7YdVEKS7a0A1hf0y7YeNOinq4hQS8DN7PC7
	 AGI7nJTJGviVu+xiLXQ8+D3LfIByvc/h6h4SCWaw/kDNLjvR++c8tRTtHcQ+eMLloAg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791878564;
	bh=3pkN2fZXq7RGg5QDmbJNkLZpgp8XEmuwO1YZvXiHTJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z/RhWy/u+9b3ussc2nAmBuciKg6JR/o2jTarL0F7b2ERFmTzcc+2vI2QyMku4eZdi
	 Ic891KQv0wIFC0UtmxADue6KISkYF29vkszqGy8KoXugW4EiN52ijSdH+GcvfVTnto
	 N+2WBhbB+vV/0PCe8PSWeOmVWjEmkgGqCllkINcnpffJGkSozWD87Ns04unjFJUBs4
	 APyaAuKUzIs5wCAcIuui2Gy3LgO+muc4LEFYzQhaMY36b2MN5Fri0rI0vxqCYkQM71
	 4jcfUeR+7QmMVqTH6m78T1xCZTgcnvcIx/mN6j4G3ygxs/PzQJsBRZqbAVkIKpLJyN
	 OTkof4hlqfktw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A03260768;
	Tue, 13 Oct 2026 08:02:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 11E86788
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:02:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0FB8D80AAE
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:02:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X-ON8rjIFtNa for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 08:02:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 783F180742
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791878562;
 b=TL1856LVoWCbMzyz1JJP0FxCIYipbI95TmtnKFW+tqTt2jAuB+Hja3dP2kJhyT/6hj1m
 5OghhMjStejxj1R8siBHYV7DEssipw1kHMqFUqNZwXkgO/44MSH5ibRZ6pivsn7saQRwb
 e484G88ntVG3KRQ2ZOcMTciwXJT6MjHoeG4fAeIoFlQdnAL16J4/cDF2hAPWWaCBdPBds
 jmG7yznwV+C1WwrBteqojOFDnjm9lWY8+P+iSAu1GkLH9SX0D0w1Q5WBe2zy3G9U2YpHz
 R0OzgXtJrnK9Tt51XD9zUBoZWdZl3WnsnTqvYpBtICCEOXSWCWyITmfIyyLK7pRj/jw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791878562;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=3pkN2fZXq7RGg5QDmbJNkLZpgp8XEmuwO1YZvXiHTJc=;
 b=gopiJ3kEi+UJ8fPJiiVxLn211yb+XK1hNFJk4MxOLpkQkoR21PtPsiX2f2QSxxHa2viM
 3y3NG/6nxwQQ6xJgAxRtDncaYMHt5HO3uGzjUpZ/wxuD0RXNBQ6dKpc8CjMdipe5hzaGO
 3uk9pPkIMRwhCzgt6l2DxW5IaYsfGyR/q5ElmGlWmAcM+4UHHX/M7zU3ekMzMMpd2wFa3
 dRP66S38+tlF47ucD5oCB2JPJ4IxTVhgvVmfEsukqEFH/cjttOKJc/axuDyy/TAOWxVH1
 nMSmwI93n7SnaKaZ5v7KKw1a/YsSZf+0tJkbgT6sj6ax+4YEZj6jvzxYaSUL6a67f0w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="HOF2hj/b"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com;
 envelope-from=jim.t90615@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=HOF2hj/b
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 783F180742
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:02:41 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-398a5aad413so1339077a91.3
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791878561; x=1792483361;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3pkN2fZXq7RGg5QDmbJNkLZpgp8XEmuwO1YZvXiHTJc=;
 b=HOF2hj/bUtYLL+oitZaXHn9YuUK7paiIMOHF64xPDYOGrHvo95PNN+Mhg4ZiLEhxJn
 AdLVXOHnnu84dpY+fUidgz6v+tMrGcjdSyHe8TvpFpLi3Slz9Nt0Ag8NKeMgNiOToUVB
 uJ5GFLIqeOWYYxDFgnrY97s8YRN6rQ3JbwDDbs6g9a1vGpLu3OjbyTmpVCjFx52Uz3xi
 hdaaQDokdC5LjaH0XBBGuh8wn+iGq+5LxherqUYCpgDv6ZdqfhJ5ZgKnXnk0DjZVpUXr
 erR6MMSTCS151z3x4C657YF0y60Dv5trJnZtoLW322x9J1RT6kzolWAufB8J71OpwD0D
 ifDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791878561; x=1792483361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3pkN2fZXq7RGg5QDmbJNkLZpgp8XEmuwO1YZvXiHTJc=;
 b=2etv0oeVVI3ZE3SypiRbNU1RiUKUY/rFh+zOPmqmLXEinlwfELFcuMrQ57Vdu0enSL
 e9uUTCDKL93kuYG8Yt8br5oB5f03zKGrUQ6NjaUSQUF2ar+NqcEk+smpMnZPbVqQPLbR
 DqN3Ur/lr8qMZUE5yQIj6tliEU7397WieO/nRMQ5+DU0LcH8hpqxytPRStQ0+j0ROQ4F
 k+X55V+er9r8I4uifodytkEcvL5XcnBCpsFzCUitYMFtnslhrZlRzQTIe0T2eHEcbwD0
 vOn8Ku5et8gVCD4wzNII7SH3v/GfAdDfpedUbaEU0enWoz4HaTypH6jBf7WdcoG2RAvo
 1STw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzoKGtHjalgjvbJchMrRJnqZBwdcmUcTxcLak20aAKuxmNUecz4rMFFkHCj50V2L1Qd2vcOYRs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ5FaCt2JMh1RGvf837Tv3OCbernJJE8/ulY7W4c+/bcFxz/O2V
 azxzlVNGwdNVTiZGw49eOVblIM6ota3fP4LtVe0BbJi0/2gHlS2Yh0Ds
X-Gm-Gg: AYBFou22JlXP15fyXtmA9I7LrO9bB2rmrkWPPInsxcDfEYZC5OMP+V09BoiFX7Y8Qx5
 gpjBrNy1RIh9FTWpmQ2FpYM8T2JZDjDoaSSyyQSJbxnT0Ug39T3CiGy0xtrt0LWxXhNDlib3RQJ
 Y3i9VHHaM2VgMQULQlPF1Ih8/JiGE3pTxUBoibTH4SsiOBpczLWyO9EUxrEj9dmeZDE4u9HES7s
 A96GrteZ5IbiMRvh/E7hz5nNa+8jg6yBGMFvP9+pMmf9Q4mNwCtJ27XO17ELADFJHcgtPoHCIuS
 xtGn3XxL9VUWKSmBaLTOmBwXve3tYG027MuIDFfGStXGZZo1LPXRBTHOKPzfb6sNtYiYNuV1PKD
 AgkYVNFhsM3UFilwNXau4/WLE95aEimz1w//Qef2FLEhKdgqiaaJTattKu0PaRmdOu2FMrDkNP6
 oIYal9jTxWbKoQV2niAsKbAQ1JaTWAzUgE4/7Y37iiC2WZdN8TApXoUGNbD5M7Z7NIXrIMHmVP9
 6thtz2c
X-Received: by 2002:a17:90b:5708:b0:3ab:e588:c286 with SMTP id
 98e67ed59e1d1-3abe588f9b3mr4400851a91.17.1791878561143; 
 Tue, 13 Oct 2026 01:02:41 -0700 (PDT)
Received: from cs20-buildserver.. ([2402:7500:502:876d:a213:c5a0:c1ea:6547])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab3962f771sm9175090a91.2.2026.10.13.01.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:02:40 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	jim.t90615@gmail.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Stanley Chu <yschu@nuvoton.com>
Subject: [PATCH v3 3/6] board: nuvoton: arbel: Configure GFX interface
Date: Tue, 13 Oct 2026 16:01:51 +0800
Message-Id: <20261013080154.1942483-4-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013080154.1942483-1-JJLIU0@nuvoton.com>
References: <20261013080154.1942483-1-JJLIU0@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Stanley Chu <yschu@nuvoton.com>

Select GFX_PLL as Pixel clock source

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 board/nuvoton/arbel_evb/arbel_evb.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/board/nuvoton/arbel_evb/arbel_evb.c b/board/nuvoton/arbel_evb/arbel_evb.c
index 17728f8435a..aa2bda25e79 100644
--- a/board/nuvoton/arbel_evb/arbel_evb.c
+++ b/board/nuvoton/arbel_evb/arbel_evb.c
@@ -6,10 +6,14 @@
 #include <dm.h>
 #include <event.h>
 #include <asm/io.h>
+#include <linux/bitfield.h>
 #include <asm/arch/gcr.h>
 #include "../common/uart.h"
 
-#define SR_MII_CTRL_SWR_BIT15	15
+#define NPCM_CLK_BA	0xF0801000
+#define CLKSEL		0x4
+#define PIXCKSEL_GFX	0
+#define PIXCKSEL_MASK	GENMASK(5, 4)
 
 #define DRAM_512MB_ECC_SIZE	0x1C000000ULL
 #define DRAM_512MB_SIZE		0x20000000ULL
@@ -22,6 +26,18 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+int board_init(void)
+{
+	u32 val;
+
+	/* Select GFX_PLL as PIXCK source */
+	val = readl(NPCM_CLK_BA + CLKSEL);
+	val &= ~PIXCKSEL_MASK;
+	val |= FIELD_PREP(PIXCKSEL_MASK, PIXCKSEL_GFX);
+	writel(val, NPCM_CLK_BA + CLKSEL);
+	return 0;
+}
+
 phys_size_t get_effective_memsize(void)
 {
 	/* Use bank0 only */
-- 
2.34.1

