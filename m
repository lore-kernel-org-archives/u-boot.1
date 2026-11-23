Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391EA606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 23:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bZHio/QO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=n9hLrmRm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=B97IE+YL
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 07207405C4;
	Mon, 23 Nov 2026 23:45:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ass_X-w4idqs; Mon, 23 Nov 2026 23:45:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 58084406D8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795477528;
	b=UlCewvP97UwCi95Ng1vzxt1Hswc6kVEQEY/TKXgS74IW6+W8OQh+F/AvKS+Eg4My4w0R
	 JBZMQXSMvErctCbprvYGVChrpDhPchLPVdL60ELAM1hhMOlP8RRr8gCY4Ht4Vq23+iMt0
	 fOanPW/TVVT+N71m9cBNzwnQSWkzzZdmpEIhEITd5MJum62Fli+A++1fqsv85yEp93cyv
	 sqFmfmRPjgDpBVp2JrSR5EfiJKaTgyfAGtyBPL+pCKjlHGlb/37JZ+tAFBHAu/uD9GfSw
	 fX1pUnMkoEbfa1d3ozSquzcvvEDTG1Z/uguR5ELi+ZuBKgCfrfwU2OpqYHvFFA1W8tw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795477528;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-Source:X-Source-Args:X-Source-Dir:X-SGantispam-id:
	 X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:AntiSpam-DLSRS:AntiSpam-TS:
	 CFBL-Address:CFBL-Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=UPkY6P2ial4XyU2xktQZ80z8BFxA8Cy7x2VlmyFVilk=;
	b=iAP6u6YcKwwURBNPzv+E4MmhzjHVa7PtOa7/HNz+jfS/yMO5TSBGQg5YQQ7VpsBQ0A+u
	 o8fLyz8UsgqR9Tsn86E07mqvEkLOE96M5xeV9hlm16FYVP149nKt0MZyG2Fr/+bhem7bQ
	 2mWVp7Affkitzty7uEAtepMqRH7vJURnWT98/g7yetsiH9nJh1mVq79oUnGdasb7zPMi1
	 NC5Ry0JxiGUPVkJoNGnLnSvK9c4vZjIRX35rYUrOGnIllNBnYV446KpFTPUviP28aFchf
	 y0ZFgaswbGx8m0awtimptVZya2BgKL3YPdnKgeDaPNzG7WMuvOTj5TuS0JlZyb/0yGQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=valla.it;
	dkim=pass header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=n9hLrmRm;
	dkim=pass header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=B97IE+YL;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795477528;
	bh=UPkY6P2ial4XyU2xktQZ80z8BFxA8Cy7x2VlmyFVilk=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bZHio/QOpjacLrHx6ydSuuwoz5nENFT04EtIah9jSOSueoyHFpuDIIBqTmuRepIAu
	 SKfuQqU0VSkWibFq6pD7Bb3AT+xbpMaO13nYaZYQ4xnnlJCx5QF2BmHbW+HsKzuQhQ
	 GTlizgAtaBZ3XV+YXCZpA/AlbNlZD691/2GJ8o33ZIz+xwA64JOjQY5SxW3oSMODVE
	 2uKPcIYS6Wz98zeDYwE0+FGGrxGeLws56RBe09aoELnYCxKOaAtySgj03u31lrWQ5l
	 XFnXoDJozW9gvraH6LOqsimL2/FeJfL4ALbR8dPAKGwXR5KgMfZyWOQhjBXTa99ZLY
	 ImmV2cef9/bGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 58084406D8;
	Mon, 23 Nov 2026 23:45:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B3DF260
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:45:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 01CA4406F7
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:45:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KZLLNOYd3_EM for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 23:45:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DB8F1406D8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=185.56.87.3
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.56.87.3;
 helo=delivery.antispam.mailspamprotection.com;
 envelope-from=francesco@valla.it; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com
 header.i=@antispam.mailspamprotection.com header.a=rsa-sha256
 header.s=default header.b=n9hLrmRm; 
 dkim=pass (1024-bit key,
 unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256
 header.s=default header.b=B97IE+YL
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DB8F1406D8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:
 Subject:From:Reply-To:List-Unsubscribe;
 bh=UPkY6P2ial4XyU2xktQZ80z8BFxA8Cy7x2VlmyFVilk=; b=n9hLrmRmhBXPQMfCcKssJa7XV5
 dgyf8UdLqTfQ4OeZbfEggWeh6MUHJXRjolJWdAuVivp9r661aswLg++fKV/+bcfPC79cVhJuJp/lt
 twbUqxYzRgwsRXQjGth9KfW9KG/DdYpcTKA6rPeWM4XEkOwITHFVMIknhNrA+3Lwq58I=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-4zq2.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <francesco@valla.it>) id 1xVdip-0000000DCwG-0gkK
 for u-boot@lists.u-boot-project.org; Mon, 23 Nov 2026 23:45:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Date:Subject:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=UPkY6P2ial4XyU2xktQZ80z8BFxA8Cy7x2VlmyFVilk=; b=B97IE+YLMpUsS6B7WX/7sAIPvu
 3SUW6M6y0tgURF2VSGE5n8ZMMSkLfgg3HR82tRUBxfQXg7wBlCu3CUGk1xKRwrvGh2BUfUD/opWsl
 8VpfhmZHEdcQC76XKgF2yTyOFuNQnId7+H3GE9gwmOpiI7Y1qurwDg0nM2IHDSqbIXrA=;
Received: from [79.28.115.6] (port=61909 helo=[192.168.178.175])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.100.1) (envelope-from <francesco@valla.it>)
 id 1xVdif-00000000MHw-2eC0; Mon, 23 Nov 2026 23:45:09 +0000
From: Francesco Valla <francesco@valla.it>
Subject: [PATCH 0/2] Use k3-j722s-r5 also for the AM67A-based BeagleY-AI
Date: Tue, 24 Nov 2026 00:44:30 +0100
Message-Id: <20261124-am67a-j722s-unify-v1-0-19a83f16d38a@valla.it>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6CMBBA4auQWTOJHf6MVyEsWpjqkFhNhxoJ4
 e5WWH6L9zZQjsIKt2KDyB9ReYUMUxYwPmy4M8qUDXSh1hiq0T7bzuLcESmmIH5FN7mmYs/mWjW
 Qu3dkL9/j2Q+nNbmZx+U/gn3/AfP0QbB1AAAA
X-Change-ID: 20261124-am67a-j722s-unify-bdb53efe1835
To: Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Andrew Davis <afd@ti.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Anshul Dalal <anshuld@ti.com>, Chintan Vankar <c-vankar@ti.com>, 
 Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1255; i=francesco@valla.it;
 h=from:subject:message-id; bh=vSRBTSoqk42vpih+5bpExcTuKOl1zbCO5OgksFgs3g8=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDNks5//OffiZX1Hu1yuOG1eVLJb410/bONsydkPGyo1Ht
 igsinj8s6OUhUGMi0FWTJElZN2Ne3vmmn9L28D4CGYOKxPIEAYuTgGYyEIPhv8pvna7kuI4g98d
 /cnicCX+uzNzd/1n+50+RxIz0z0Ds4UY/nBXNxrsmsoZ6ZfAu1Li0DxP8wXGe7LqtNJMPcovcGj
 w8wEA
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.u-boot-project.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 355d786a24a0528c10784991fe4102df
X-AntiAbuse: ID - 355d786a24a0528c10784991fe4102df
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xVdip-0000000DCwG-0gkK-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-4zq2.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The AM67A and the J722S are the same SoC with a different name for
commercial / market segment reasons. Drop the AM67A-specific dtsi and
use the J722S' instead for its only user, the BeagleY-AI.

The BeagleY-AI gains the following fixes / changes:
  - DM2TIFS secure proxy threads fixed (22/23 -> 28/29)
  - DMA setup in R5 SPL now goes through dm_tifs
  - A53 clock raised to 1.4 GHz (the default for the K speed grade
    silicon)
  - HSM can be enabled in R5F
  - Main clock is not set anymore (as it's set by the ROM code)

Tested on the BeagleY-AI.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
Francesco Valla (2):
      arm: dts: k3-am67a-r5-beagley-ai: Switch to k3-j722s-r5.dtsi
      arm: dts: k3-j722s-r5: Move DMA access configuration to generic dtsi

 arch/arm/dts/k3-am67a-r5-beagley-ai.dts |  2 +-
 arch/arm/dts/k3-am67a-r5.dtsi           | 70 ---------------------------------
 arch/arm/dts/k3-j722s-r5-evm.dts        |  8 ----
 arch/arm/dts/k3-j722s-r5.dtsi           |  8 ++++
 4 files changed, 9 insertions(+), 79 deletions(-)
---
base-commit: ee1b3477e3af6af1ae9b8f98bc84d2cc6f32a3a6
change-id: 20261124-am67a-j722s-unify-bdb53efe1835

Best regards,
--  
Francesco Valla <francesco@valla.it>

