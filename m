Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D2DD41C02
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 05:59:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76462894B9;
	Wed, 13 Nov 2024 06:59:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=codewreck.org header.i=@codewreck.org header.b="X+qum1As";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D28E894DF; Wed, 13 Nov 2024 06:59:03 +0100 (CET)
Received: from submarine.notk.org (submarine.notk.org
 [IPv6:2001:bc8:3310:100::1])
 by phobos.denx.de (Postfix) with ESMTP id 695008935F
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 06:59:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=asmadeus@codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
 by submarine.notk.org (Postfix) with ESMTPS id 20EFE14C1E1;
 Wed, 13 Nov 2024 06:58:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
 s=2; t=1731477540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=qai2R3g4jfEr1/pzQkv0elU3wIOXS3oOYIVz6ia3arM=;
 b=X+qum1AsFQHRuS7jQgOBBXCuqGeIWnGyajlO1nEo6xC4pLIXL0kQJrAqz/2Rh3PIsRifQ2
 RdB+ulhV2VQlc1yQMK+P+AiXDV9NZrOvH3v+dhZRBGsWuz7wv99DoKN+FI++sli9spY6aU
 os8WavcfSj9ez9JwZvOkiXofgWJxaHS2iWHUJ6QVGLaAUspmMTUYCRA0zizR021nP4A2bv
 DhGEQLbmzTDv8wm4ImdjmyKvNR+8htmIFOVdWC7wsZK1V7sZVWARr327P6fq1ZwCVVs/R1
 IqumASm4hvD2ct5atAI+Ry7Av82Bh5TSlSkIqC4hZsdjvuZ9YI8K7zjAzpn4jA==
Received: from localhost (gaia.codewreck.org [local])
 by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 14ab8819;
 Wed, 13 Nov 2024 05:58:57 +0000 (UTC)
Date: Wed, 13 Nov 2024 14:58:42 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, Qu Wenruo <wqu@suse.com>,
 Tom Rini <trini@konsulko.com>
Cc: Dominique Martinet <dominique.martinet@atmark-techno.com>,
 linux-btrfs@vger.kernel.org, u-boot@lists.denx.de
Subject: Re: [u-boot PATCH] fs: btrfs: hide 'Cannot lookup file' errors on
 'load'
Message-ID: <ZzRAEgQYS46yM7Ct@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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

Dominique Martinet wrote on Wed, Nov 06, 2024 at 09:56:42AM +0900:
> Running commands such as 'load mmc 2:1 $addr $path' when path does not
> exists historically do not print any error on filesystems such as ext4
> or fat.
> Changing the root filesystem to btrfs would make existing boot script
> print 'Cannot lookup file xxx' errors, confusing customers wondering if
> there is a problem when the mmc load command was used in a if (for
> example to load boot.scr conditionally)

Ugh, sorry, I was a bit quick on checking with an updated u-boot on
this... our tree is *cough* slightly *cough* old and that was the case
at the time, but since somewhere in 2020 there is a warning in fs/fs.c
in case load fails.

That doesn't change the fact that this patch is useful to avoid the
message being printed twice, but I'll need to update my scripts anyway
to use `size` first instead (as a first approximation of `test -e`)

Please let me know if you want me to resend this with an updated commit
message; otherwise I'll let this sleep.

-- 
Dominique
