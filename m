Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE56606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 18:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OtJ6WxWc;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aFJn/n2b
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C0C381313;
	Fri, 27 Nov 2026 18:00:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tID31SqwGg1t; Fri, 27 Nov 2026 18:00:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2D7A581305
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795802422;
	b=eXagjWRfo9qDWDMoYIDvBaONpb1VZtb5yhHUyZ7EYNICBcaMcj1UR7wTa/zLz1QAKpMs
	 LsDNHbkT7NbHDl2AqLRbWGOHFTSSs0ZxeNu1Op0xyp7egLvJcd/hTUA/v/sGuIHK0DEbW
	 PAPciH5oztt7BfXZ4JZRMGOQI0ujkALq9N7l43UFGOmF+ew2dnxKd7F9a/T/fYYT+nEr4
	 noAIy3GZjXqOCvpcHKJKp+MK4Y4B15u9eqWtwTL3aazdxXlektzNuCLDLJwLIU3Yajv3F
	 5PuDRNP0gOAM6Qz8B+ee+BuzYKl1idUeEheuxirveaLIemqkBXAngJbiD6+FpU/mbyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795802422;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9RuQkCv0HIWfG34+/um+zApYHoy4KmDovVGwV6BN/as=;
	b=QWvjIKS4YzKVbCit10sa8C3vGH4zwgiaTWB3veGcmLaZE2Z8oNKwNp7myngscSFQvVV1
	 uP9yLeUMTxJE4KBCPszxGeO4mqSaOwKrsNoCuulmVkU/5rWA4T2MXWZYNc74gUJTzrgxP
	 6PGe+3iPAUllfBUoS1P5+jZJLxZoietqiPzsb7Zuu9x+MJNeF5VB7mu+GOaJUEW+FsFAz
	 SbyaKPRzcJAdZxfobVC0g5snaSzV6XnQaIlcnUEdvSfYWgf2N84MoxaRyAfIOEnVs9Bpv
	 Pail749nLFcq43fww3NruxNLTRINk5EcQ9MAo40sIIwjphS6WVlpz5mJZoXQ+FaGi3A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="aFJn/n2b";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795802422;
	bh=9RuQkCv0HIWfG34+/um+zApYHoy4KmDovVGwV6BN/as=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OtJ6WxWc/DkojYEqreboW6Qh8L//3hf3QnE4NlvFc2SUxT1sKdwAkWELJskwltVWs
	 f6X3cvd7DAUhR2jCBpnMOavfXLkULOuVRT+gx+6s4NnLb2CXNYHDI/5W0d2LDdYQH4
	 UA0AkRqLvk9MwsE5quqqsezgG87wafRbyT+lCvTyEwLqfNkDRj4QpMuZxsjh2xQ4uz
	 KmgNpVKGCioHfmxHEj2b+lG+WKikxZp1+P25V4ZA7BDLz5rzOFte942ptul8yHW+CP
	 CP2tqjyjPePqmf/t7M8Ot2V/EzbipDO0DKgIUB4zE0OnV4SrqQiNSA4iiPlxX1cIaU
	 ay2hQvT6/cn7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D7A581305;
	Fri, 27 Nov 2026 18:00:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A4FA3311
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:00:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8B2BD81196
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:00:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1AwjKxceNsUs for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 18:00:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A6CE9812D6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=aFJn/n2b
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A6CE9812D6
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:00:18 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a00so68770995e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795802416; x=1796407216;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9RuQkCv0HIWfG34+/um+zApYHoy4KmDovVGwV6BN/as=;
 b=aFJn/n2bOXEdDCG55JStweyorwL27SxBkjp99CtAQpcIchkXzLUX6mspSxEtpSNi6+
 V93HtsuvSUhfqVnn2xbCjDVtWu5/nIjKQdMDx0V30bhp5risNCqKirSuWKlsNnDPwYp/
 EctY5sYueT8WqBVuPJMgTuCVNcY9vMKqWm7M1q84lAIn6uGaHSJ4myhGrWTOnI/NWvcs
 GSLrJJnoZ2EZXC5xgwj/sNK1FSE/0YMmPdvEaofMrbfCmTnn9zCn3+h59JAgt3cUT9v5
 ZBom3TjhZ2y3UVUXlVLnGytcr+j79tMzL3sKWUnoc3WojAuTuU8WhZx13LN5rxLReJy/
 MXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795802416; x=1796407216;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9RuQkCv0HIWfG34+/um+zApYHoy4KmDovVGwV6BN/as=;
 b=jKcpCovJXkLEDtW3uTUFPJ2ckwcIUwTRFuJ5bVJVTI8jepsic2EOE0i8aqX0ghuiCD
 imJW+OadXMOJ/KnWyVJuqScAcs3MDc8LcW0br9vdOQ/rEXwsybxaYRGjdJug96XVAI8t
 WOmUeQg+4Tort1Ens2x1jJnpNnO2U3jQ8/EyZlAbr+ygYPXZSm57r3OraEi8+xWZxoyk
 XBHvJpx/cVCPFV0j+zyz/Pvcm1mLe512HJ0nS/ujKP1w61PFnPtDXIdRxEvXfKhoTBvz
 VDfbntVePSuCZlkku3+4+fCA+olfw8Qq/D5vPI1aYtnBjuzYsWwAEgjGSOmeCtJodzYB
 fWzw==
X-Gm-Message-State: APuU4Z8Bj9tZM4Cj0cVXPYyUjVUMHWZmbRbfTfD0kO6Nbc7jfd88NLtJ
 n/g18K0tHCBJJtihmKbWTX6beq6bMsYfh7d6XrEoW9U4grLlCT557ZnP
X-Gm-Gg: AZFdTZfHtSR/eQAK+FhSr2dXuRF1ONXHn9BrH4xW3EeLV0zyEoEhxQXgWcXg2QrzgS5
 8jfxbQNadfkeBqYOFzvw2/wuaSX5liPXmxv+ij1ePsUh0PqZdbvjzdxp3bTcfR3QFMojcJ9I/el
 4cuJ5gSrIXkpJl5+3GBfihfm9VertrPb02cfN5TizyxRbB1CRV8JbLDjnTgmoQq2zMamqnreVkt
 SPkjMo3sn6iceLxeF4qz5tHYrIQxRMaYJ1zSmcBsC+nppbs7rBJXZLKmTqts3hO8FxPSXWq2apF
 6bMfX/yxGiIzMCA67bMcJNnOt1ezcGRC4OACgpAnF7Vp1vMXeEQib0cKh9vlIkI6GmTZWk/Qetd
 M15X1rP7i+nVtHaE3mAe3+dBc78o0JonqHJ2PAmW3sub7eSjhGjm0wSDV5rGTmSAk3et1RHkFTL
 a1rICoC49QjEUTmX9a2axyEIaqmroF+XZk/eO56Km0KadcBYcHpg2psO0JVJUNYMignd/zJAnsR
 /JQ+eaL2SGr0Y+xYKS3s9bXjvJh0WAw/VsxgRr3pVFJmKtVzlcbDv5DZNJHpsVN8GiiAsD5VsFs
 lA0ROfpUlTS27wXg/T3nx8YNjMDkAs/Yv9q8CWY=
X-Received: by 2002:a05:600c:3e0e:b0:4bb:6a5a:783d with SMTP id
 5b1f17b1804b1-4bb88929c63mr464508385e9.18.1795802416288; 
 Fri, 27 Nov 2026 10:00:16 -0800 (PST)
Received: from [127.0.1.1] ([151.71.203.75]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853368d3sm695638385e9.1.2026.11.27.10.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 10:00:16 -0800 (PST)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Fri, 27 Nov 2026 19:00:10 +0100
Subject: [PATCH v4 1/4] ram: rockchip: improve SDRAM type config selection
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-ddr-multi-v4-1-c66608f3e06f@gmail.com>
References: <20261127-ddr-multi-v4-0-c66608f3e06f@gmail.com>
In-Reply-To: <20261127-ddr-multi-v4-0-c66608f3e06f@gmail.com>
To: u-boot@lists.u-boot-project.org, Quentin Schulz <u-boot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The PX30 RK3399 and RV1126 SoC SDRAM drivers' code has compile-time
options based on SDRAM type, and selected through Kconfig options.
However, not all three SoCs support all the SDRAM type configuration
options named in the Kconfig: improve clarity adding SoC dependencies
to each option.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 drivers/ram/rockchip/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
index d707d09c1c8..fc948e82993 100644
--- a/drivers/ram/rockchip/Kconfig
+++ b/drivers/ram/rockchip/Kconfig
@@ -26,26 +26,26 @@ config RAM_ROCKCHIP_DEBUG
 
 config RAM_ROCKCHIP_DDR4
 	bool "DDR4 support for Rockchip SoCs"
+	depends on ROCKCHIP_PX30 || ROCKCHIP_RV1126
 	help
-	  This enables DDR4 sdram support instead of the default DDR3 support
-	  on Rockchip SoCs.
+	  Enable DDR4 sdram support on Rockchip SoCs.
 
 config RAM_ROCKCHIP_LPDDR2
 	bool "LPDDR2 support for Rockchip SoCs"
+	depends on ROCKCHIP_PX30
 	help
-	  This enables LPDDR2 sdram support instead of the default DDR3 support
-	  on Rockchip SoCs.
+	  Enable LPDDR2 sdram support on Rockchip SoCs.
 
 config RAM_ROCKCHIP_LPDDR3
 	bool "LPDDR3 support for Rockchip SoCs"
+	depends on ROCKCHIP_PX30 || ROCKCHIP_RK3399
 	help
-	  This enables LPDDR3 sdram support instead of the default DDR3 support
-	  on Rockchip SoCs.
+	  Enable LPDDR3 sdram support on Rockchip SoCs.
 
 config RAM_ROCKCHIP_LPDDR4
+	depends on ROCKCHIP_RK3399 || ROCKCHIP_RV1126
 	bool "LPDDR4 support for Rockchip SoCs"
 	help
-	  This enables LPDDR4 sdram code support for the platforms based
-	  on Rockchip SoCs.
+	  Enable LPDDR4 sdram support on Rockchip SoCs.
 
 endif # RAM_ROCKCHIP

-- 
2.34.1

