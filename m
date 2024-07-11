Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707B3C3DA45
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 14:51:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D022D88381;
	Thu, 11 Jul 2024 16:51:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HsNXSA24";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AA3D88387; Thu, 11 Jul 2024 16:51:24 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D118882DC
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 16:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id E1CA3CE17ED;
 Thu, 11 Jul 2024 14:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617E5C116B1;
 Thu, 11 Jul 2024 14:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720709480;
 bh=uxs+nS4ovmqfmgWsESycOMJFJWQ0CwLd1wPsOwEBxnA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HsNXSA24Xx7X+7t0+43Xx3+sI1DKvsB8xnd80jhb+wlwDqCPj5IcXKBwjuCCMjvK+
 ZG1wna2vedS9SoUq8E/sWM34Beudi5cdjBumRwQ1LGCs2HYEVdMca98xhdrpP8YTXN
 bbFN5eEKPAA0/IJNh+iwANVux2ohcEq88bc0Y0qKGQa3NWhZcAtnvkVi8q/rwocgGu
 ppfy3y3PU+6l7usy0sow21PV+RGASXAdgCSu2VsgtYs9cZdRfX3mPY2gwhsLUwalrZ
 Z7Lqzqvbv3QTuEJ+ynhS9yRbO07uKrZbkQUr2Rodft2AYXdbwZ39lqZvIP+qeJxNsU
 8zxMonWXIfLSg==
Date: Thu, 11 Jul 2024 16:51:16 +0200
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Marek =?utf-8?B?TW9qw61r?= <marek.mojik@nic.cz>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 2/6] board: freescale: p1_p2_rdb_pc: Add weak function
 p1_p2_rdb_pc_fix_fdt_model() for fixing DT model string
Message-ID: <ybqhom4dat2ojfbmd7ykztesdwoxqc3tpdb2dgurj2bqoib3ug@zcowvlx32szl>
References: <20240606163326.386950-1-marek.mojik@nic.cz>
 <20240606163326.386950-3-marek.mojik@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240606163326.386950-3-marek.mojik@nic.cz>
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
