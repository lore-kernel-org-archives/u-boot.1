Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700E1C4451C
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 06:55:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2778760632;
	Wed, 22 Jul 2026 06:55:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gzhaoJWC7KCZ; Wed, 22 Jul 2026 06:55:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F9076071D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784703312;
	bh=rh2y7pwHZlfsk0ORldi8+kdew6ii/IOks228Nj5tlGg=;
	h=To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=jRMjYYJEp9lcPHz75y71i66VogpsXLHsSvDP/WOokS/CeLtIJ9aGf2KWlBmCM6EaS
	 Yj5eYInYIbsP5WH7tlUM3SpIZxqZ5xQ/F7jbfrl2XUsAgG8PJ1t+sGAAbRau6mZIg4
	 3G4cK6SLQH+u3UVib+KO8Gaamd27q6DFfaHb//qntzQbSLEbULHixJb7PW/Kp1hgHt
	 Dj5CsFgdCa3+ww6oEqBjvfVI3pEH1TYGTP90zrlX3LkR+eVBbvXlfWn20BbUH48iKE
	 hrixF2xk8dJGp4Ui74wMsh6zLTZO2HXUvlqJP8lBZhJJyNZU1Qt1YTgpfx3tNbtrw6
	 3Vb3EPhQ+vwJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F9076071D;
	Wed, 22 Jul 2026 06:55:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FA9B10A3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:55:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3624D6071D
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:55:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kZ2nZrf7CPeh for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 06:55:08 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2FDC660632
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2FDC660632
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2FDC660632
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:55:08 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D522848BA; Wed, 22 Jul 2026 08:55:06 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B3FE803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 08:55:04 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9269443CFA;
 Wed, 22 Jul 2026 06:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56631F000E9;
 Wed, 22 Jul 2026 06:55:01 +0000 (UTC)
To: Safae Ouajih <souajih@baylibre.com>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, Alexey Charkov <alchark@flipper.net>
Cc: Tom Rini <trini@konsulko.com>, 
 "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>, 
 Guillaume Ranquet <ranquet.guillaume@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260708-image-android-oob-fix-v1-1-a96de8ccd25e@flipper.net>
References: <20260708-image-android-oob-fix-v1-1-a96de8ccd25e@flipper.net>
Subject: Re: [PATCH] boot: android: fix out-of-bounds access in bootconfig
 parsing
Message-Id: <178470329989.163835.6163607000590154751.b4-ty@b4>
Date: Wed, 22 Jul 2026 08:54:59 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784703302;
 bh=rh2y7pwHZlfsk0ORldi8+kdew6ii/IOks228Nj5tlGg=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=ftSPoBK1tJmCvGZ5r3bCGcUt5Kitd5AQAGwcyrZsemX361Wo2QM2SlSKLI09Pyi7E
 6YvsrPwlj2C0vRptPPAkJPZr8M0/UAQg52TXgX+C7Yj5ZDf0V/0DO92oE9O3j0Q83b
 iB0S4rngydtZTRYcoUNfulBHui2OYN5pnuNQSJOpU5fpuyJPZboWRRcZ0GdR2/cz8u
 /+T1k2DrYkj7eYAlVx5Qznvt8DA1aUgibv1ySVwk4l3K/GZ90Z/yZu1NIHBPaUX61e
 nrhmnppK2Ek1URWsRNjgMmSOhDxA9V5nz2kmz/JWwoG7YKtJVm7gd4+CuaVICocHT2
 Iydm1c1GiomEA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ftSPoBK1
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="ftSPoBK1"; 
 dkim-atps=neutral
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
From: Mattijs Korpershoek via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi,

On Wed, 08 Jul 2026 21:32:07 +0400, Alexey Charkov wrote:
> When android_image_get_vendor_bootimg_size is called, its buffer is only
> allocated with enough space for the bootconfig header, but the
> android_vendor_boot_image_v3_v4_parse_hdr helper attempts to append a
> bootconfig trailer to it, causing an out-of-bounds access and heap
> corruption in some cases (e.g. triggered in sandbox test builds when
> extra bootmeths are added, resulting in a segfault of the sandbox
> process).
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] boot: android: fix out-of-bounds access in bootconfig parsing
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/ee3ab6988860d568b0ba0b568e57335cca2809d4

--
Mattijs
