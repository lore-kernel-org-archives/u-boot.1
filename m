Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F83606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=o1vpe9IJ;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q0SVQ8Ez
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7E8960681;
	Mon, 23 Nov 2026 19:37:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DVwYltKm8foe; Mon, 23 Nov 2026 19:37:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F287560663
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795462668;
	b=aEWb/BfD+MWUjx8BWgGNiLyJf2YZgp9EfiHfj7fzv5gRl3zklWvYI+POS1y/GvlCTiMl
	 zVh/D9g79l9PuZS/SZ5mVguN/wjM3w84DbIr/abEuF0CLfKeob4KYv0q1rFa7TEY9OPx0
	 IJRUpKaCXTHbNWwrGbRiUeHA6HGC5sOFpAOouLLTopd+B6e+AEXul4M+vavYAMSh5zLin
	 LZXFfv2OFbdet4v1HxWuLdjXuynPFTDvfuk0w3+Bt4IpSxJ1K4Coq1il2pttxWe2yoHPB
	 ea/0PEJa5xST6zpKA9ynqWHPYDyVA13Yw9PD/VNyUP+R2KdT6oMs8gfRFcSsbgZ6gfA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795462668;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wj4O0nUDXpp7Xm2KbHgq9968tuyUIVC1RsoGDYP91bs=;
	b=aRP+GI2plMqpTMFJeQtOGBnHHlgk7olAhPM+JWGwj3KNjPfdw1l4mpVwf7DvTubARyMm
	 An5NArbP4Z/uQuzauxnnGw19na0u6Pglob2Jenq5M2Xotl2WDeXaQuE5URwq7dz4ZxGt5
	 N37f2r2GbUH6obp1r5rJHA+L+fZxjtePEYiV5IcH3tuyqE9MHJbs+mT1SkiPtY//CtinT
	 blgJdENdnJaWcgw2P06gcS8CrL80AHdF7RmNKHl9glwslt00frTZebop9wqfltGFMNvSt
	 OzC2t8AAUgpBXuwiq8fMR8t7D9npfd5d9btkoI606NqaGtHGKj00ys6cwSk1vokNLfQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795462668;
	bh=wj4O0nUDXpp7Xm2KbHgq9968tuyUIVC1RsoGDYP91bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o1vpe9IJTH4acLmP3qy+SYEDIEcHqRxFP56CWbsTCpOHO9Mws28QrKbBT3a96tFnq
	 LDlQGoKqnnN7fWqDfB23NlH0CBN0CoGyrsABq5SlyxjohD/3pvEj91ScxVO9vqSqoG
	 SGMQ6Dufqzxj+aF67j5CeWiQSjpmZ5JJLFPYHHhRwcO9CsAA6TwwQjkwVNxM89ETHT
	 XbTMRR7fEGBJFvrags/iVus48P7yGO5lPSDQUWuTXGuZd61M9sN0WhNd2Zbowbn+c1
	 TwuvW/Ndi2OyqkgRkfOhIOWNA0OMJGVcL8WMae9DrVBsR2EAaJsishLHY82pSXJQL4
	 RU8EFManX/tBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F287560663;
	Mon, 23 Nov 2026 19:37:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FEB2260
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 19:37:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8145B406F7
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 19:37:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NOcJ_OyEabTW for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 19:37:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BFFF140704
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Q0SVQ8Ez
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com
 [IPv6:2607:f8b0:4864:20::1333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BFFF140704
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 19:37:45 +0000 (UTC)
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-38692f62b22so2722832eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 11:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795462664; x=1796067464;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wj4O0nUDXpp7Xm2KbHgq9968tuyUIVC1RsoGDYP91bs=;
 b=Q0SVQ8EzTDCnSXGIjehmB/J8S0Zs3gOb6durEZXSEERETFO3bRZFZG1SZ1+9IIelgx
 qIhdL5fpVDPPW+HOKUs1rsEGYRMh/XxuqjSiS8f6d+XnaPJp/YEF8xwxiPz30aFXenJ/
 qch6a92WrOO8/x6XtWomzSGrrtuZXwSM9Tci1tl7k3vPhlJ91bYwuo2zRgJD3neLEjqM
 oX20gDpM3YxuCzlP7cd6r4qj4E/0SBasjgZIvU8C959yIydjnqXdOJoxH20Aftti6HsK
 7vqbrMxLX+ClYl8woAyXw46zyDHK8HLp96IPTyEvkqYwoNVQerR8F/TIJ/akKYFNtMQ/
 QC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795462664; x=1796067464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wj4O0nUDXpp7Xm2KbHgq9968tuyUIVC1RsoGDYP91bs=;
 b=MovLtKmRFa8jKNFwDTLmAyqjeKJDnBH5JxMafpJlA5ieav2n/mg3iDQF5/iKCxGScv
 gxhZvtV9RB3N9yFAlP9eUNqcpZigEnX6AbKfLBvmbR7DMaKFOfqN3aY+cX96MzwWP82p
 b1flqdcc2Z4GKq6nnYaCYXyB0id+M/URotAit1g0B9n8ZpuZ6GqnVB0wYZTvO1i3P2zw
 u3Dr2wbruIBO+YcRbI12Yi2RjDpe1rUlwyVut8S+9VN/ZF58GuS2yromfVGmvSMqOmkN
 hhhr3eBXwTLtz6dRmzT9rkHvNh0dlFAD7yDp5TVUdGFbNnWUPtmY2EBbkPrBrngswK55
 z0fQ==
X-Gm-Message-State: APuU4Z8uC69E+NA10BTJcl3NJOvbKDa6CmTfxKPp0mg16wYD8oCYBoIL
 4MCKhLm+bhgkmIMLBeYCEjVjg4UVGD9RxeZGCIRuSyQcmBuzMzrtEdrL20PXBw==
X-Gm-Gg: AZFdTZfY0xMWyxEZcg5gALrSi3mbd5T+qSn9Q08H7Rw2yIXHWWYRHkJ4d5gYsFsFlc9
 adC49VKnjEyDyLRLPS7AP01eGgtmgZ0sCZ63kyM0Ly7Ae0pNmIbiM9sn9SCmFLcQ52pFPd8at0X
 +/WIrtLdlgOiuWGnSEGfT+kqQCGPpr9DMiVyFZDa529oY/sz9RssTvr1bQ8xfQoOVmFMEpIqn5j
 hkWASohnuXmKimTYYmTYcDjj8lFgo53mQYwqevfH97hGz86a4V7NklX1tgsQSuSgr8Hchu1dmF0
 7Z8e9cl7RCSLQ8BRs5g1/450bpOq77O01+S19Z4K04OeB4C7Wx7y+feP2ASRGC5meixQ7qyUBGI
 PUeSdDuw1E6Y6zb4z5xK995BTMAHtMyxJl283thUaObHmV8uke4qlzfBWKWGjbi03D9mKGj2jzp
 iRgiy9joYIcWXs8Ii0pl1+kX3nbFACXdNO3X1FzSfJgyM4uxYlfR0cgnVOfvQtIADd+uRXhLT4I
 bnzsH2ENqEC0l0U08pZK59zHy//6/J/GzyPmDwSMpm1ZaeCZSdpKFIkpW2jdor/8JLTTq3KcPgU
 SsbiUPsz4wnkICtKCssEzWJquTZdzQ==
X-Received: by 2002:a05:7300:1899:b0:386:b6e2:9fa1 with SMTP id
 5a478bee46e88-386b6e2a02fmr3940359eec.34.1795462664394; 
 Mon, 23 Nov 2026 11:37:44 -0800 (PST)
Received: from arch-rock5b ([45.112.0.246]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385677c0c1dsm41796268eec.21.2026.11.23.11.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 11:37:43 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Anand Moon <linux.amoon@gmail.com>, Dave Klotz <DaveWK225@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, E Shattow <e@freeshell.de>,
 Yixun Lan <dlan@kernel.org>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Subject: [PATCH v2 2/6] riscv: dts: spacemit: k1-musepi-pro: Drop redundant DT
 overrides
Date: Mon, 23 Nov 2026 19:37:00 +0000
Message-ID: <20261123193714.5096-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123193714.5096-1-linux.amoon@gmail.com>
References: <20261123193714.5096-1-linux.amoon@gmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The upstream MusePi Pro device tree already defines the serial0,
mmc0 and mmc1 aliases, as well as the chosen stdout-path.

Remove the duplicate definitions from the U-Boot-specific device
tree while retaining the console alias.

No functional changes are intended.

Cc: Dave Klotz <DaveWK225@protonmail.com>
Cc: Eric Chung <eric.chung@riscstar.com>
Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: E Shattow <e@freeshell.de>
Cc: Yixun Lan <dlan@kernel.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
index 03cfed10521..ddea04a8e3e 100644
--- a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
+++ b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
@@ -8,11 +8,6 @@
 / {
 	aliases {
 		console = &uart0;
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
 	};
 };
 
-- 
2.56.1

