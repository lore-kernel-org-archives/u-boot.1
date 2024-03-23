Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF8EC6FD1F
	for <u-boot@archiver.kernel.org>; Sat, 23 Mar 2024 16:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 054AA879F4;
	Sat, 23 Mar 2024 17:59:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SK7AoY9Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E42487C78; Sat, 23 Mar 2024 17:59:19 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 247E9879F4
 for <u-boot@lists.denx.de>; Sat, 23 Mar 2024 17:59:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id DA1A9CE03F5;
 Sat, 23 Mar 2024 16:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB5DC433F1;
 Sat, 23 Mar 2024 16:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711213153;
 bh=S8piLtXtqnMa3GdgyIQ5WDcHfyQoi++uXO/SHY+sB2I=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=SK7AoY9YBvDyZiSeH4xoI1Nt6W04GyZEiYykTlzC+Of0k5VfM6haOaFYIAvwpzl+r
 Vp4e3S3J8aIzKQYnGQLh5ZheMdNWCf+Cgdi1AM7RSYm6aoP9xkjl6nDXZ959ge+UjV
 AXEOK+VayOkhTDNQLwOI5TjS/IXwzwfgliGVZPvndnX9VyHiPIiYORxkSSKpankBeR
 s21eV+ifcoHlYdJYylcZ4z1n0v+oPNl1dgCNo1WxPGOuErJXVPSyjUouBix0j+FPho
 mF/zPGUAouVURbx0mDJASYKoI7yTfmMLESsl8tczsdHtGXVcVfkClkFx7juCXbZjmV
 W5TMkz4SAUleg==
Date: Sat, 23 Mar 2024 17:58:56 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH u-boot-mvebu 0/4] Turris Omnia - New board revision support
Message-ID: <20240323175856.7a81859f@thinkpad>
In-Reply-To: <20240304152148.3847-1-kabel@kernel.org>
References: <20240304152148.3847-1-kabel@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.39; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Hello Stefan,

I've been doing some work on this and will be sending version 2 of this
series.

Marek
