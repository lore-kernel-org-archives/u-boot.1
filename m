Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21772C3DA41
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 14:53:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A13388381;
	Thu, 11 Jul 2024 16:53:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KlXsEd9/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9688C88582; Thu, 11 Jul 2024 16:53:28 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ABE288049
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 16:53:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5F04661B18;
 Thu, 11 Jul 2024 14:53:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B7CC116B1;
 Thu, 11 Jul 2024 14:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720709605;
 bh=uxs+nS4ovmqfmgWsESycOMJFJWQ0CwLd1wPsOwEBxnA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KlXsEd9/q8JvfebQBHL4Y/wxuJutHLzi526txO5TAj0asVCMKaQTKlZzGFpwRymvt
 Uvl8Hi5QNrYfvtocmUy1qSDewo9YQ0EoaS4oj//XZgf8aeyYLPy9ZRccRu/ZShxGB7
 fdTo7eQf4UMy5BnreyAqFlrhhJwttGgXxxyuxTcoBY9LvrZ9UUZOLbU4CfV40+S23m
 wE4ZWQlVyi9+URfrBWrsTm1+nYfYk7Y4SRkky2GdcnCjD+capKEXonsGCGFepY8zWG
 9QBC9PSpzlp9FpfTgnGnfhkaiG3NP1sDRQWBOYrhl7H4ahQqlsHmL98fw2uVio7LQ5
 IhxAG1ZCGEWCQ==
Date: Thu, 11 Jul 2024 16:53:21 +0200
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Marek =?utf-8?B?TW9qw61r?= <marek.mojik@nic.cz>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 6/6] powerpc: Add support for CZ.NIC Turris 1.x routers
Message-ID: <xc7ayvjxj62g3deft5hrs765nuy3425cyru4a7c7as6uhvoydy@yw6syklxsng2>
References: <20240606163326.386950-1-marek.mojik@nic.cz>
 <20240606163326.386950-7-marek.mojik@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240606163326.386950-7-marek.mojik@nic.cz>
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

Reviewed-by: Marek Behún <kabel@kernel.org>
