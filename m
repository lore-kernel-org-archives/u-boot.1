Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A40606A32E
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LNBHM71M;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=XAF5Kxw3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6467060D66;
	Wed, 11 Nov 2026 14:21:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pIT7SdoNVkcg; Wed, 11 Nov 2026 14:21:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4B20260D86
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794406889;
	b=BujT//Ab0gJ35ICRL2O+3I7xHioRLOpsCNyTDT9aTZ4afjuK5xIUgCCm/oqhijLuMj/e
	 KpFj6vcOiTBYCtHUsOSG1x3IjH29aIe00rWXureTErxTFHRgfHoZXbw+THuAa5Gz0biCQ
	 fPxQRjdoABUTUwsPw9FYyReuNJsWRZBAOYy3jj7mrFt0AxJsk/WJhF9m5Mn84ElWGLftj
	 TDoRMG2Q1eQsHPLC28ikp7IGsarHBsWUeZQruDVeYwn2LTbJhxXxKM/OJnq1zkZlmLTp/
	 kzOvN3RCIyUFucq1HVWzF8pNDGcXED/EdNzB8Pi4YLgME+VbOmt6h8BrFCZKmHIiO0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794406889;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sZrcXSun2MEWbHp1FMBIyVRHouIeEmDzg+R6vknJFFA=;
	b=dzBQDxylnGfNnzzVfWXvb13AP7ZKuxv1heKb/9HJBUTs6Te3Li5A/Y2Nc5Pjz+lKjmK5
	 AhU/RlSgqoQcUKS42Cf4mDRD1y8gaRlxbASpKIMwRP2aScoafL01tg26G3pwtJRKf4IW/
	 YOyO/Tba7x/HUeAYYCcsiidj54ceLQkgBP67AYFhT42fHylCk/B8FFrA5n0Xwo5Xrr2XJ
	 HfjoohWFd5HNfSqO81SqrWW7J+hXOk1OmV+HUffjbrwHj2ymeYcslhZVCX7SV/kDzt/CA
	 Vz1uX1ZWXO+/WwdHzMLee6xWxZDZkPZLFF/yzR+UVrReaTO4lpf8ksTCQJpQAw8h4cQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794406889;
	bh=sZrcXSun2MEWbHp1FMBIyVRHouIeEmDzg+R6vknJFFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LNBHM71MxgB1Qh3MmW2B/NQbXGg4Nf/Ubs7teTLzN5A2DP8Sg789K/JkqBUxInP8Z
	 ixjzU3y9UqZLg6zPoPc+lgh2lVeffdiYDRZ2qGn3HFslpMBb2ydpDY4DSwe2gjg8no
	 2J9SkOnG1FtHJUSAZ0FFZ9dMqsAu7WgH1QtADic7F0N2ZuSr1XkL/Dxi518hB9y/8y
	 mc87jXE4Ly9O9iaD7+qild6o3CNjcmje+HRt6dxSZiqv7840NXcCM/ZMCn513K/cAD
	 Si4NTYKZzYwvP1VxsZ0aTZTIG2mmGMwXEvmdgVhNamYHahwTasI57w5yZr1Lqnl9lk
	 nVlFky++GZexg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B20260D86;
	Wed, 11 Nov 2026 14:21:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 54F61731
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 468A7812AF
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 77OEejcjc0li for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 14:21:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 908988122F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4b7e:0:8::81"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:4b7e:0:8::81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=XAF5Kxw3
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 908988122F
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:19 +0000 (UTC)
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 867D22312C;
 Wed, 11 Nov 2026 15:21:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1794406875;
 bh=sZrcXSun2MEWbHp1FMBIyVRHouIeEmDzg+R6vknJFFA=; h=From:To:Subject;
 b=XAF5Kxw3wv2+Iq+CMLBdfyfubREtUcjWdQjwReFRrGZ2+OD15r3rACWyGcFQ20N7w
 zYQhTAfa1h/fTklrn/C1hvye8SPznIs29txQp3CvD6ujtpxsQ77kdXboJUpcox+zWa
 cIhRU/EMv5V0xHdfJe2iH0nkIfxsVW/WqMf9ysElkeK0zsInbVyPC4xMyUCYV8VUyV
 X54XWuOv9j7Ozh03yfuQYc9/0Kqwi985bnzvxpdbHbHVXmmaLrsNUyRgiTdwNg9aUx
 dDD9YsiYRUgb8zZeKYsU9vYN5zNhpMNJc7cuMlQ+4lvre4+4CSSwCcQS7BmXiT6WX2
 h8CZcSsEHBNQA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 10/15] board: toradex: apalis_imx6: remove dead
 ldo_mode_set()
Date: Wed, 11 Nov 2026 15:20:58 +0100
Message-ID: <20261111142104.109139-11-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111142104.109139-1-francesco@dolcini.it>
References: <20261111142104.109139-1-francesco@dolcini.it>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Francesco Dolcini <francesco.dolcini@toradex.com>

CONFIG_LDO_BYPASS_CHECK is never defined by any Kconfig/defconfig in
the tree; it's leftover from the NXP freescale board template this
file was copied from at initial import. The guarded stub has never
been compiled in.

Fixes: 592f4aed6db7 ("arm: imx: initial support for apalis imx6")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 board/toradex/apalis_imx6/apalis_imx6.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/board/toradex/apalis_imx6/apalis_imx6.c b/board/toradex/apalis_imx6/apalis_imx6.c
index 542c7ba4608d..e0cc4498d8a9 100644
--- a/board/toradex/apalis_imx6/apalis_imx6.c
+++ b/board/toradex/apalis_imx6/apalis_imx6.c
@@ -781,14 +781,6 @@ int misc_init_r(void)
 	return 0;
 }
 
-#ifdef CONFIG_LDO_BYPASS_CHECK
-/* TODO, use external pmic, for now always ldo_enable */
-void ldo_mode_set(int ldo_bypass)
-{
-	return;
-}
-#endif
-
 #ifdef CONFIG_XPL_BUILD
 #include <spl.h>
 #include <linux/libfdt.h>
-- 
2.47.3

