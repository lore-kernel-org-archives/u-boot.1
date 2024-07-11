Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD82BC3DA41
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 14:52:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49367882DC;
	Thu, 11 Jul 2024 16:52:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="u8Rc1/eO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89D16882DC; Thu, 11 Jul 2024 16:51:59 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C50388049
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 16:51:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id E9FECCE17ED;
 Thu, 11 Jul 2024 14:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E412C116B1;
 Thu, 11 Jul 2024 14:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720709515;
 bh=uxs+nS4ovmqfmgWsESycOMJFJWQ0CwLd1wPsOwEBxnA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=u8Rc1/eOnT/mx43fj9CAbdgVhoLS8oPFacTBFyCMW2PljMQdS/RiI91MQosngz46d
 qFMMPKJFmXBL3+JjRUJdodQj1sEtOouzvfnlbBDvouNsDEZmU9z+9++gTH799OLnYC
 5aurnnoUzS2GCoqnD1iXuU6VLcnM3/kx4hBWIOLV5P8KxfmQ/OoVTUsha2PXCEG4wW
 slokBCris+dXOER77zjuIIZCLMyJmczUR8zWFzNePx9Ea5zZ9GxuzuRzNtuViRwtnO
 dm0nNNepjS/AFmRxOEVSPpoGCaN8Ij63zMwV64vjv3cGJCxfvCbMNanTGKo7o4hjaA
 1kWby3lXNZGuQ==
Date: Thu, 11 Jul 2024 16:51:51 +0200
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Marek =?utf-8?B?TW9qw61r?= <marek.mojik@nic.cz>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 3/6] powerpc: mpc8xxx: Extend find_law() to
 find_law_by_addr_id()
Message-ID: <3cylucb6nlgd72odxtjqptl6zyaoc7q3b2yoc7z6jir7xtgotp@dhffvj24j3lv>
References: <20240606163326.386950-1-marek.mojik@nic.cz>
 <20240606163326.386950-4-marek.mojik@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240606163326.386950-4-marek.mojik@nic.cz>
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
