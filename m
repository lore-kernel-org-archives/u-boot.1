Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EEEC3DA41
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 14:53:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D13688452;
	Thu, 11 Jul 2024 16:52:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F/qzFUHI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1081C88496; Thu, 11 Jul 2024 16:52:58 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15E8588049
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 16:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 6FFB9CE18D7;
 Thu, 11 Jul 2024 14:52:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7118C32782;
 Thu, 11 Jul 2024 14:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720709573;
 bh=uxs+nS4ovmqfmgWsESycOMJFJWQ0CwLd1wPsOwEBxnA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=F/qzFUHIqXR7We7T9yVWY2ef43nUPauSJPTSZBLoUmJ+MGhAHbkfcFqvfXKUx0IH9
 G8fGJNfPGAVgWoWrjZbL5iF5ajx+XZuAXvPIenbMemnsRExzr2yY+UTgokOSeI/++o
 PrBkMloEpEQ25s2bPA0jDMWYEfWVJZYvaD/IIEy9ARLoBrsFR0uItXzXQ+grAvZdrA
 LXjsKHED6Bd72yLyU3gJXuUJKg6KUBuAM6T/SPmQ4BEmo6ZW6KEQzDemfsJLyrg6Jd
 VAwOePQZPXZ8mPB4I7xiAg4fczUzfyDNHAZOBZVo02RQQQSofsMe1+Np+CP0KgHxIG
 heq2Y5xNSEhAQ==
Date: Thu, 11 Jul 2024 16:52:50 +0200
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Marek =?utf-8?B?TW9qw61r?= <marek.mojik@nic.cz>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 5/6] powerpc: use CONFIG_IS_ENABLED() when checking for
 DM_SERIAL in include/asm/config.h
Message-ID: <ilgzjpsga6kkpppjqadascdny5tjmtat5kjwu6yuk73shw4ima@kxugjzaa46kl>
References: <20240606163326.386950-1-marek.mojik@nic.cz>
 <20240606163326.386950-6-marek.mojik@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240606163326.386950-6-marek.mojik@nic.cz>
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
