Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30966C3DA45
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 14:52:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B96CC88381;
	Thu, 11 Jul 2024 16:52:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X0odFlbY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09A21883CE; Thu, 11 Jul 2024 16:52:27 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1939888049
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 16:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B8C2D61D2E;
 Thu, 11 Jul 2024 14:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD70EC116B1;
 Thu, 11 Jul 2024 14:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720709543;
 bh=uxs+nS4ovmqfmgWsESycOMJFJWQ0CwLd1wPsOwEBxnA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=X0odFlbY5dIyHjNYzn045nZNJFWU8E9nzn6miu+dSG3zu+OueYllnghIspB35e357
 sMVpNsuIjidyxQtsdANax/1yL2+41KSeD4o7zovS2lPhv1Et6b5DaaiFHumvCbstrh
 zgrpJB7CyeLbYSRsCDjDQz6T9kEz86egXaetbHxNt6HfS9jQQ0MhewHpUlvq9Zo1+d
 UC+kXux8lLTAKinJ/YI0Ua4/RRxfVak82bZX/QQpshV8PhrZRzHuYjlh2UBpUFTyiV
 2GiD8Xbi/kvZJQkKyXUoOE87AXpq6PV4tfIwFMKqz/c8EUEGfB0mzcFr0Ldv7WLJNU
 ez27z9z3qcXIw==
Date: Thu, 11 Jul 2024 16:52:20 +0200
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Marek =?utf-8?B?TW9qw61r?= <marek.mojik@nic.cz>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 4/6] powerpc: mpc85xx: use CONFIG_VAL() for
 SYS_MONITOR_BASE in start.s
Message-ID: <7yepxyzp6pw4f7pysdtudl5eel3mbxnnqocqvz66vodw72rmoq@c7bgqj32czzm>
References: <20240606163326.386950-1-marek.mojik@nic.cz>
 <20240606163326.386950-5-marek.mojik@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240606163326.386950-5-marek.mojik@nic.cz>
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
