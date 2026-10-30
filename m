Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CFB606A327
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ugZqKabo;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M0gxB3JZ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D634360B0D;
	Fri, 30 Oct 2026 12:59:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vaCDgtQGhWz3; Fri, 30 Oct 2026 12:59:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B944660B07
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793365198;
	b=jCEU9CUzqDHPnwOYib8Bc77EmvvugYJOJAaNX2hpBuzx2+lZA2vpHDmt+w8u0G1nUevO
	 ndHATySU4rwjS71CbHUA4JJZ1Mk7OEttdcyzs71/wnehsh6F/K9aWD3EN6+NG/Xzmjzv0
	 DseFEBhGO3e8T1m3YFJdcDexNeYoZpP9HoyF4Phnnf106+VEYU28YosJKP5QLAEaQCZ6X
	 cP8opJBI+G5QkjLnT0aeoGmNSEXke/o1zbrC0IF3OgrGJ9z6WyDqPZbsNx3I3x6BvcxY/
	 H3z0Z+TIStxDo0jd9E2aW1xSpqX+L7KTiwVLmRavZw1JKjr7OdluTvfb4ZYxkc5OZZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793365198;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7LW+NP8z+78TCibtDkYPHybRWCgy49tzUQr3hSAs9Eg=;
	b=PVsJTczaT9TcwsqtsQSNoCGbY1Whur05/YFMHcG8/8aMtYosUAezio35MvhHAxMM17SX
	 mh/dMnfXHOom8+neH4ASqZpfEREbTwD9GFidK8klGKQIc9YFMN8WAjlE61Fr5p0MzepIF
	 tM3MNw+Gl4dmBThngPC6TIyIr7hSqp+1dOqmP+qlskFIBoTIUnIIlUtUKBfORIlrDTVuV
	 Bsa9QTStN5mk0fwTFyWXCXmHOsF58pjM5Zdm0VKS2BRdL5XrIzSaczmfJ6c12OGtEdZHa
	 DKZxHOu3mHVhrI7bWpcSMjHtu9Pa4k2qziyEPBMruA2Uk9EPGv97g9G1I/W+GIkq6Hg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793365198;
	bh=7LW+NP8z+78TCibtDkYPHybRWCgy49tzUQr3hSAs9Eg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ugZqKabocY7ndyb6R/g+eN3XMTJ+TUk1y4pGOvrdDJLsdN9U1Uk+uznnmtG3uzdyc
	 c067xrZZdG+jXClW1KK1rbJfBjbefWxPETQFHL3V9mt2qXMrxUAna/FFlkRUvkqyiZ
	 HfUfnq4cNupyJM3cPDQhkw1aOXLVEaiRXhoUQQCGCv9Hkflx2wlUr8Ww2mRttgS86a
	 LAqz8G0Jic0XO9/wGyyQ9Bs8WC5Rs8AvHlDvGu+wcF0MfnA+lvZkJGjPH+bpQdYGmI
	 V1IAsRNDGNG8AdyDzMD8gnrfKDNfo7Nj32eeeBRG9CRdWRxaJiWqpKlbfnknd+uKct
	 vYHnZWGWgHzww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B944660B07;
	Fri, 30 Oct 2026 12:59:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A78501DE
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:38:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A4F6240329
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:38:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e9fhWBBcBouv for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 07:38:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C18D6402F6
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793345887;
 b=dQYA4IRVjc5pJKFODxuC/tXjkMjVsgkcMqOmW+h0s3dLIyaU/d2F1L8jg1ol3wTnxRHW
 czySmLKzs7NuFkeVSiuio76ovfpBghOLcWmRZU32yYWxd+pBCKzNQW0uBVDEV5rBNboQ/
 D4diV2hfsRbquXBCForDb0ASY/Vgs74nbM6481JJXQXqByo6X6AUjNDtBhKoqbsC0qIr0
 NaZrhu2aTU6SMxjxjxGUIG7k9OyTSLLhLPTv/65rnmW8CMszdomngEo1LBujtnuZ77ZTm
 yoKRZcaCGoq0cJaKgRAT/uJMfmIh807CjRWYdAqEePRmTuLwWV2bt7uDMiUa5yVo19A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793345887;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=7LW+NP8z+78TCibtDkYPHybRWCgy49tzUQr3hSAs9Eg=;
 b=lHGullVBvKY5milatEZh67tv+FxsiRWIXA73wRHucv5xwAbrjyNTMagxMKwK0ZyAdYzy
 pxT8p3A5gevjDFwhIZKlH+AYvNMn+hqzwBFwqnwAzi2xVdqQZ87ZDGBiknIhONilCPqX3
 9doJwKiVNItSfdhrckPiiFz1YssJ+TDeQJBhT9bhe7yJ0GJB5M34KIW2/GGEZHGSIjey2
 Tr5DbuD3fBeteDFp0IQgYgpiZbG/Nuz/5HmV989Kfn6x4CqER/yXZHda5do+w6++ditVJ
 uEisCO6HQG6/MYXjV7Xj+/6hcUn+rOjmj68O88uPI955U86hvNotFdFKgdlatQPRSxA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=M0gxB3JZ; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=ylcncn@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=M0gxB3JZ
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C18D6402F6
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:38:06 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so3116655e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 00:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793345884; x=1793950684;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7LW+NP8z+78TCibtDkYPHybRWCgy49tzUQr3hSAs9Eg=;
 b=M0gxB3JZjf0WettQ15pBoNNY5C/xlAZH94U6H3A+geSkxGjaqwheHE894Aq0J1mHh7
 nk9xsW/n0dBNpP8kMFRGcCYg9YVkB2XOFkrcETtjM2+UT7gBABguyutxweryV2HLhfVl
 SlJEqrkDGvEAfevU6kpeQd0XnCtTTIVuXDMj7Y28UpxXfv76TRbeJMXXCenxf+mqz3D8
 OBf7oAnA6lQ+UCVGWsHuhyLIdB1IrK5M/PK/91eUw1WHtf+SliR3d+nuRqn2qlwiqFn8
 nKCOpkAb1PBkcvB5j12zDAaVjSJcdLlo/EtGBlN6mmO9T5n0nfuRYxet9NRb4lzZSHWY
 JtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793345884; x=1793950684;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7LW+NP8z+78TCibtDkYPHybRWCgy49tzUQr3hSAs9Eg=;
 b=qfJnMzUbBW3+8j/xCVn56x5lzBDq2zp3HplMTzJDgPiovx2+0PdB+LRU2zcPrYipgk
 qmKrlh6/KTvTVLPWGPZd/sn9o7u1xyejnTHGR+B+lE+joc6MLDQrNMZh22waYBizfKX8
 lfs2TnbVQScOf6mrzciksTqeapbJb16W6YAOkEYUVsW6zh1WQB3hQzTMvOJJ2UCP2Qbm
 vP7Z3gd0NeLUzGHhZ3DMrNpGYlRMECnyECDM6HI2FjbT5Ln4xzyV2dhtLetbAURDy6fb
 249l5FGAPovXFY353XvFNQWC5ixGXSnnDkFhXsVJuD5jIVFHBIXoMPbYPh4SBBhCl6kU
 cPrg==
X-Gm-Message-State: AFq9FYKgWOsGUcPcc7SiIwz6NxZnba0DvnErVCN1YLBga2saWimzR4U0
 /ZlfsMyHeHQtLCGL9MABdHtMZAWBGIcftDK5oAKNV7IJU17LobAoxxKO7w5tC5sEsIw=
X-Gm-Gg: AYBFou0hRisakFQjTLBrvLzd8A1DllDnXHSc1Kqlcjxi4ba66YNTEY2Ywl/0O9pI0vL
 /WxRImaw87QUxXZa/ZlDhGBD7wcux8Fr3GY8E2nMG6VXlUhAHtcQ99Jlqf9rSLa/igvDsYoM/4Y
 Cto82E0fdxE6KbQwjQ/kd5lPGx6LN1c8BsrpDo64dn9qnwKPeeZlmWFCA5I+XHWewhi5j+kk4+Y
 Y008Z19K22mmoU0CudF++WxBQAleENQm6fN2cP2I6TQWFMxq4hzyyVpPQoDe9C9OhW2Z9/0E9qE
 L2I8F4hkeMrhtWH5yH3P7dA/g2qXBBGHObiExj3B+JQ4TsXiNHo+c3N5UXi6AiUqrkD99QoV7Jl
 QqyKeEQeSTStutyRoHuy06WI45ujM+8/KenisgTsTbhQ1vRH7DmNp4W6fQmIzZ3nVkRIK44zC6O
 PVVxCZcXQad5rqCk5FTpFJZaTR/TgKmAUexHuQkhT1/9GT5ZeFBXEBUXa8/NnZFpY2yexQ3gkJX
 r8d2O9TXScdFNaxuGTehIcYaEGoH7tAv41JIrv2+KIm/D16IA9H/pgiVctBlFvtb9CXuS1VFM0D
 XXBnnEGBIUmKNFGWuq4VuIUwkZkVDLlQENw=
X-Received: by 2002:a05:600c:e48b:b0:4a1:d291:d863 with SMTP id
 5b1f17b1804b1-4aa8a1e90demr89430225e9.4.1793345884274; 
 Fri, 30 Oct 2026 00:38:04 -0700 (PDT)
Received: from thinkpad.hgw.local ([159.146.110.109])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba2415sm1822713f8f.50.2026.10.30.00.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 00:38:03 -0700 (PDT)
From: =?UTF-8?q?Yal=C3=A7=C4=B1n=20Can?= <ylcncn@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>,
 Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] clk: rockchip: rk3066: set up the PLLs in U-Boot proper
 without TPL
Date: Fri, 30 Oct 2026 10:37:56 +0300
Message-ID: <20261030073756.165229-1-ylcncn@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 30 Oct 2026 12:59:42 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The PLLs are set up by TPL. When U-Boot proper is started straight by the
boot ROM after a vendor DRAM init (no TPL), GPLL is still in slow mode and
the peripheral clocks run from the 24 MHz oscillator.

Also run rk3066_clk_init() in U-Boot proper when GPLL is found in slow
mode.

Tested on an MK808B (RK3066) with the vendor DRAM init and U-Boot from the
NAND ID blocks.

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
Signed-off-by: Yalçın Can <ylcncn@gmail.com>
---
 drivers/clk/rockchip/clk_rk3066.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk_rk3066.c b/drivers/clk/rockchip/clk_rk3066.c
index f7dea785..d48e4818 100644
--- a/drivers/clk/rockchip/clk_rk3066.c
+++ b/drivers/clk/rockchip/clk_rk3066.c
@@ -657,7 +657,13 @@ static int rk3066_clk_probe(struct udevice *dev)
 	priv->cru = map_sysmem(plat->dtd.reg[0], plat->dtd.reg[1]);
 #endif
 
-	if (IS_ENABLED(CONFIG_TPL_BUILD)) {
+	/*
+	 * Normally TPL sets up the PLLs. When U-Boot proper is started straight by the
+	 * boot ROM after a vendor DRAM init (no TPL), GPLL is still in slow mode: do it here.
+	 */
+	if (IS_ENABLED(CONFIG_TPL_BUILD) ||
+	    (!IS_ENABLED(CONFIG_XPL_BUILD) &&
+	     FIELD_GET(GPLL_MODE_MASK, readl(&priv->cru->cru_mode_con)) == PLL_MODE_SLOW)) {
 		rk3066_clk_init(priv->cru, priv->grf);
 
 		/* Init CPU frequency. */
-- 
2.47.3

