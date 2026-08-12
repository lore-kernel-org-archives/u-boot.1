Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6B6C5AD5A
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 07:48:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0247C81199;
	Wed, 12 Aug 2026 07:48:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b1oXVrCqpX9O; Wed, 12 Aug 2026 07:48:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2885C8119D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786520901;
	bh=BF66oNfPgRH1RKbiUG7vY/0uWPFzQYJA1PkY/sRVikg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cA5TtMiFKe/seM06hHYKplDsmYJODp2BB+2PxvvTjVYSMfDOo4bfqdv+z7p9btjkx
	 MRsTB/eqrH5pr6M7WI+Y/34aXugcybaOD3QHd4T/dX9o/reGa0Q214Q2sEvlXn6k/L
	 kk1iHVhFTV7XNgXelpM5l7Ltc8WaDsp7w7AQ2fZbf/tP0Et72QRaUgC2+Q5OQUG5xJ
	 ik57GSG5yxg/M3a4FCjqTKcsweuYwweznxTG27EiQBPXC2Trzka8md69p7js3ibzrr
	 jHIKsY+bRNqkdwPpZ2DJs9kN0Zim/zPkABhf3+EabuhVPHsZqx+v0uuNWLLBPxnvj/
	 GuW5BYt08kqoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2885C8119D;
	Wed, 12 Aug 2026 07:48:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0FC04259
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 07:48:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 015838119D
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 07:48:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FW3whQCcIRqp for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 07:48:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1CC3081199
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1CC3081199
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1CC3081199
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 07:48:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 587EC60A7E;
 Wed, 12 Aug 2026 07:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777BD1F000E9;
 Wed, 12 Aug 2026 07:48:15 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Julien Masson <jmasson@baylibre.com>, u-boot@lists.u-boot-project.org, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Cc: Argus <argus@byteray.co.uk>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
In-Reply-To: <20260729-b4-android-bootmeth-oob-v1-1-31c3450ae0be@byteray.co.uk>
References: <20260729-b4-android-bootmeth-oob-v1-1-31c3450ae0be@byteray.co.uk>
Subject: Re: [PATCH] bootstd: android: bound the boot image read by its
 partition size
Message-Id: <178652089345.239806.17329637437699875380.b4-ty@b4>
Date: Wed, 12 Aug 2026 09:48:13 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1786520896;
 bh=BF66oNfPgRH1RKbiUG7vY/0uWPFzQYJA1PkY/sRVikg=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=EZkhUOZyiSdYxXZDUSzgHfzHqA5ym0qP2ZsEfxq0odT5WviYqbRkt5ZCVNwg53zhb
 BOp6N670x2p8dasN1cd1GO+V/+1rRVeAYpRyYzK9SWksqskbWnZ0/KldGCpt9xu1NP
 HCfgUmRVoSUYrrS542ZeV/Mq9suHp0ufw6j6XzGuZYlvxkl7oeFhnx/PhK9/CjpQU4
 rsLsDM8a4yMHPGR48dwwRF1OgBQSo5uOOAStY1UEcKCEowW+Z8pC10gIBMYuQDhzWW
 wH4qeXQMuGuBOnGU8pWzcSbra5OZQqN4naP9Z+ZADC98YIAN8FpyulVE3gTQNaYvXD
 YEA19O1/Lr9LA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=EZkhUOZy
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi,

On Wed, 29 Jul 2026 21:02:09 +0200, Shahriyar Jalayeri wrote:
> read_slotted_partition() loads an Android boot/vendor_boot image into the
> load address, sizing the read from the image header:
> 
> 	num_blks = DIV_ROUND_UP(image_size, desc->blksz);
> 	...
> 	blk_dread(desc, partition.start, num_blks, map_sysmem(addr, 0));
> 
> [...]

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] bootstd: android: bound the boot image read by its partition size
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/35432ef6fe2c79ab72709966e64815a45eb55c76

--
Mattijs
