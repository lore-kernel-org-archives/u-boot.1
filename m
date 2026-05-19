Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A273DCD4F3C
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 16:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93A84848DC;
	Tue, 19 May 2026 18:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Gqe+3G4R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BD17848C0; Tue, 19 May 2026 18:22:34 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5811C848C3
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 18:22:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-694891f8f62so2022833eaf.2
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 09:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779207751; x=1779812551; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WYcID9qRP338jK0nk2OP1IhHZ/qtZsk1yObm0L9kOjA=;
 b=Gqe+3G4RttPWHP8kLrPQaXf03qbc6uO50PTIFB6Or0/bXUZV926rm2vN9Yh7Ubwlsl
 ry8P72u4319EX9L0MiNMSBW0ZZQZ759khBmKMpG++1Ybyfd/A+CKhMau3aUbdivLU02Q
 HNU1a59qgXy/VjrKgFrJP9E5DB70uc1NQBauY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207751; x=1779812551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WYcID9qRP338jK0nk2OP1IhHZ/qtZsk1yObm0L9kOjA=;
 b=i0Wz0C2yapNgwm66RvEnbShvUIIn0zdhrP6wCbMclQojVqMK0pAZ2chCGdmToKr7ST
 K9taFef2MOiM0gnld2PRlcGyNwaT2p3VaOtexUiw+6aO/Hc4gx93KV5BpUD4MHfmi/av
 y3ltah0zGQztUo15NO3kpbZA2x73nnxkTV8OroqmIbLMJcH2/3ynifHmJ30E1e43iUW/
 Aq0coq7bBYawOzdI94oX2+YwqxHzZSrOesF/cECl8GuKB3UMOKk7yAUlyTNDNjkR8uib
 1354LtxLAmqJPfiuLZyGiVGv9Kb0eM/X0REBJ/rKzDOw6/ARfYZs3HpsAgW2IvbbZWa0
 P88A==
X-Gm-Message-State: AOJu0YxATklJjL8tQQqFsrMESMPN1THzzB/YLD76mXk/6wFetGVs3tHG
 MG6i/m99pTFhMnBVEsr+HIEmHcsYPGesN/D7rpNeu0z8eix9XhGAB+xa7Ik7g55EjbAxLv9UGCq
 1xaRtGy4hs5d9
X-Gm-Gg: Acq92OFJQVNTlp561/ONdt2tPgCVBpVE/5+1AnVsqpgDfpoXzcHgWnVA83LBmgltsPD
 hTbwPDyDecoGgLJv4JujPPAKu0i0LBTCOlFYd5I+d0Kb1KQWQA32mrj+XRTefrquYP1mN06cnXw
 d8zuT09+MTtuE7UVjD6sCIWPj/7rxgyVwp0BCZm/jlbsaboVa3YsLcAyd2U26+ySeiliALmN6pw
 eZ68SOO/llnpMJ/V6ybG46edDdLZVqQdEf8vsge4jSvfFzV+6FzOlhzO7wagLMcfdCSX3niCGew
 91SC2UMGhG5YWNVkytKHGzoFVojehEFa/Ax3rzJPnc1UVlcE5SaF0gq6W4WQk+0cM2tajQ4HnaN
 foEYK73uCbsZJyl5Qp3un5OHGqx7Lvyq95cgN23CAmWwv5R3kbKvjiC3qkkC7tmObEkVR1/pSkc
 jQqVC4H6ecMFyb8Scm/RnDDcHq6HUEkecEjj4uzH86Z0SvZR1RhvKpwtwaY5aTQuRdND3UJErFK
 iR/XwqodpbLWavKW3rdzZNhQolGnwh3kjEcOcm3DCqO4A5x1LDhKk3wbIGSx4wnvX8v17Keh5Q=
X-Received: by 2002:a05:6820:138c:b0:69b:bf80:2db7 with SMTP id
 006d021491bc7-69c942b4a76mr13525815eaf.2.1779207750959; 
 Tue, 19 May 2026 09:22:30 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-106-235.totalplay.net. [189.203.106.235])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d0462e85esm7500388eaf.6.2026.05.19.09.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:22:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymondmaoca@gmail.com>
Subject: [PATCH v2 1/3] bloblist / handoff: Make this depend on BLOBLIST_FIXED
Date: Tue, 19 May 2026 10:20:54 -0600
Message-ID: <20260519162225.770071-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519162225.770071-1-trini@konsulko.com>
References: <20260514175457.4047707-1-trini@konsulko.com>
 <20260519162225.770071-1-trini@konsulko.com>
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

Currently, the only way we support passing a bloblist from one stage to
the next is via the BLOBLIST_FIXED mechanism. Update the Kconfig logic
to express this constraint.

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 common/spl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 5fa94098e498..cc819344cad2 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -220,7 +220,7 @@ source "common/spl/Kconfig.nxp"
 
 config HANDOFF
 	bool "Pass hand-off information from SPL to U-Boot proper"
-	depends on BLOBLIST
+	depends on BLOBLIST_FIXED
 	help
 	  It is useful to be able to pass information from SPL to U-Boot
 	  proper to preserve state that is known in SPL and is needed in U-Boot.
-- 
2.43.0

