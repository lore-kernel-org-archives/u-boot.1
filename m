Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390B1606A31C
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OehUhdwl;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=Shsh09Mn
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F45680E55;
	Sun,  8 Nov 2026 17:50:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r3CEI8JV90u8; Sun,  8 Nov 2026 17:50:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 71CD580E83
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794160203;
	b=bmtME1pYDlgTiOj48/pN6KoolGsi8FrOnQYaYNKvSFXN7+PaaSqmqmfYmqN9+oTLUS4J
	 DZ7nMXilIIEXXZARoXAfhqDX99y6wRQ2NySLhMMPv86gHOXO+zbhzLDkF55Y2D/kv6DC7
	 X91aXsQAkZHRh4MVBxbA3657tQOZf5wHrXsTmPo9bWaWj8Pv94+QrHutQ6KoSay7ukVCJ
	 sg+wS1tEsBIQfDcd+5eLlg1X73WlfrDXx4liUqBwIG+6J4g6UAK3xWa8ULgQiDKi9A0r9
	 8Mcr/FNjA48eRffYbXZRrSO7Z/7fnx2IW0xzk2hXqVtMhkwSVs1ZtA6+Y+VNW0TTZbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794160203;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3ZnMrO4H9UwcYgt0NP24pBgVACZnnPSIc3AQfjlbGkQ=;
	b=NfUyGJJ5zdndeRBnv74A+e/oW56+8DvLIWw4A6Q50wBBwsO2QoUL8CCKB/K845+uk9m0
	 J4HlpXzwV3C+Enp5q2kv9lSVSQ5sZWNwL5UsC/zaBdw/9YH4sFKddo3YBKlb+XoKu5eWX
	 3exE8ctsRarYoxhHQf83pVjOv/lRU7iso41Lrh8X37rLpnxwbjRGxrU+GmqgpPjKhplsK
	 dytZnUmDRsI+x4Pd701mVuyto+LcyW7ZaghUTL+cKbOMlk1oYoJeiQjdUlBBSvMqZJtH1
	 nCVrWvZWKz6RZ5JaS/p/8rWoj4C9cuBGwzYOT6bGaahZVTIHjTWZgW+bCdcZLAscY3A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794160203;
	bh=3ZnMrO4H9UwcYgt0NP24pBgVACZnnPSIc3AQfjlbGkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OehUhdwlDhp+y/LI6D0g8UH2aFaf5TLSoX5Mh9ZmS03R8FRG2TtKm0nYZf11ggJ39
	 s21NhQ0p47Nrh6lfErAL2p/K/0I4jCyGfL5wS4/XyF5WFMc+RLjD4V2H7z8Vm2TSji
	 8xsbmhQoe2246inbflkm9KSCzo1duM3SEB8vBMEej9Fwit+GDhOZK27m1J+h0s7HbQ
	 KdX1M6wzAG2nT4BHeF1evOZYT1QyEwV/13mkjoOUFOqn4uGhdf5CQfKZz4jcvqLiJS
	 SWHovdL7G2xpYK9HpSNjm7ZLEOYaZ+bxUE7DWuMwO3/NbQs2TXsUzqOCumks5KNkgI
	 83Gv1hszzBZRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71CD580E83;
	Sun,  8 Nov 2026 17:50:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 343311E3
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 17:50:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 19127606A2
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 17:50:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UJb7f80SLYgO for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 17:50:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0693E6061D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=Shsh09Mn
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0693E6061D
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 17:50:00 +0000 (UTC)
Received: from L30177.local (unknown
 [IPv6:2a01:e0a:ac2:22b0:41ba:50da:6236:7eea])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id D307CB00535;
 Sun,  8 Nov 2026 18:49:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1794160197;
 bh=PIfY0VNpydbXM7t8bplxqwSqm2w3pxa8xW/NQKBoyHU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Shsh09MnbT+6TPZEKz/Vfzt0RJr7rFvQlBf5IY+OqAyWFa1vdJ97H0JyGMrPuOAn2
 nQWNEY+3pBWixAGwAfsxl05eSqCWr4C5hsVMPjpalPIGB8+qUIW21HFA+QLByMnKGD
 t378WIb+Cl/FG4ojT4ggdMa4XFa4ATpF3+Pjnkt1nj5vbaDJ79/BxJPsMIoSzOxmzk
 NU5NEeh8WCQtssLEF1mXbMFarfekRc34LgPNZ0r3GAq/39LLASuoxv0mnZlNdKjiwa
 2KJ8wV47WfQDZv7zLtufZPWc7aVz0Lb4oTPkR65F+Wt8o8PGIK7ON/HBhoqXc454zh
 sUK1YTmrCb+iQ==
Date: Sun, 8 Nov 2026 18:49:47 +0100
From: Vincent Jardin <vjardin@free.fr>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org,
 Suraj Kakade <suraj.hanumantkakade@amd.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Denis Mukhin <dmukhin@ford.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 0/3] dts: build the DTS from a directory outside the
 tree
Message-ID: <avC2OzAeGxqVsJ2v@L30177.local>
References: <20261108155019.1485598-1-vjardin@free.fr>
 <434743b6-17af-477d-a09f-d110d565f023@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <434743b6-17af-477d-a09f-d110d565f023@mailbox.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

> Upstream your hardware support and you won't need external DTs.

Even upstream, how does it solve the Yocto's and Buildroot's related
issues ? Both did try to workaround despite they are all upstream.

thank you,
  Vincent
