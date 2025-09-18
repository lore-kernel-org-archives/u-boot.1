Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F930CAC59A
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 14:33:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B32E782ADA;
	Thu, 18 Sep 2025 16:33:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="QLTfqFZf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2FFF82C84; Thu, 18 Sep 2025 16:33:55 +0200 (CEST)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CF1581E13
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 16:33:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1uzFhk-00037T-Ip; Thu, 18 Sep 2025 10:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
 From; bh=fBuT9pAHkOG+B47oXSOd62fRwFSTsdtrSOj0PKuwBuM=; b=QLTfqFZfGAy/I5WmLV47
 5rEdqUZa961ToKFyS7F9Sy2yr8W20G+TkJo0Zkv64WpowO4He044vOYpZs+XdT5jXfMQUTMB5B/FH
 4nCdr0dBWkOsM4kSzuJeOFdl8MxFur6Y/WBdKrDRopQanQT381W7hNoL6gRMdME/H37+n6Y7Hdyqo
 xcXEBGJKWNYCSRbjo7FPiYcqJE6PKFukaOFP2dzy664MK7gDzi0azy17FoVrRV6LNhs1Shn6SwpMK
 HvUsPnRtV2BJmeZmNNMPVmgBYiTvVxXbIujuvH9HNH0EfyC4L3PNFwrI/nS3Fgn6aM367EPs0s4XO
 Zs1Wr2p+k18+Sg==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "marek.vasut@mailbox.org" <marek.vasut@mailbox.org>,  "paul@pbarker.dev"
 <paul@pbarker.dev>,  Chris Paterson <Chris.Paterson2@renesas.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "anton.reding@landisgyr.com" <anton.reding@landisgyr.com>
Subject: Re: RZG2L and DTB blob from TF-A
In-Reply-To: <TY3PR01MB11346A6D8FCB6909AFD4EC5D18616A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 (Biju Das's message of "Thu, 18 Sep 2025 13:11:07 +0000")
References: <87plbqd0kk.fsf@gnu.org>
 <56857fb6-e3d4-4069-afde-57b43c4d2442@mailbox.org>
 <TY3PR01MB11346F452EAE530A0931C9D228614A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <87plbnhqe5.fsf@gnu.org>
 <TY3PR01MB11346A6D8FCB6909AFD4EC5D18616A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Date: Thu, 18 Sep 2025 16:33:44 +0200
Message-ID: <87h5wzhltj.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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


Hello,

> For RZ/G2L that did not happen for some reason.
>
> I suggest 
>
> push a version TF_A that works with mainline u-boot in github first.

That seems like something that can be done first, so that at least
there's a way to have Renesas TF-A + U-Boot mainline to work together.

> mainline the TF_A first for RZ/G2L, So that the mainline U-boot inline with TF-A.

That would be the ideal but it will take more time, so starting by
option 1. would at least cover the transition period.

I can propose a patch on Renesas TF-A to pass a DTB blob on the RZG2L
platform as well. From the snippet you sent me, it looks like you may
have one ready somewhere though?

Thanks,

Mathieu
