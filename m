Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3177DCAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 16:31:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9592C832F9;
	Mon, 22 Sep 2025 18:31:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="l07dinld";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64F3A83443; Mon, 22 Sep 2025 18:31:08 +0200 (CEST)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 606CF8004F
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 18:31:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1v0jRM-0001YY-Uu; Mon, 22 Sep 2025 12:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
 From; bh=pEuZomBTqjgvfFHfSD3bA3yxuy0i2mTFQaj9AttYupU=; b=l07dinldnNQnh9+5ulZt
 xJYN6GC5DeN2PkTy0Ow5D/lbDvqF2onlQ28gnCfuRN3B3cdoHvXoiVIGVtjKKctMFnDSljChMymn7
 3z8INV5tO8Kyqbp5mC+8NmLtuYCSuROpbWvIkZ1OQWuPp4klSRsD+nrEAeIa1dyJBqkLdzh11xiTd
 rGgE3RaOMGo6MgqyyeuuMVQSkezYbYes1SmaPtELJyXP2ba+9m3r9LQdcDpSh0gs68xUmDACJ7vnh
 3X6919GLDaD9kjH1Dfeyx8jetGti//xwFnbOvLFz5vZQ38Pk/OgkfLdR8nkhu87Yjmm4sUhid0oGh
 1VceVg2NA2HjqA==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: anton.reding@landisgyr.com,  Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Tom Rini <trini@konsulko.com>,  Paul Barker <paul@pbarker.dev>,  Peng Fan
 <peng.fan@nxp.com>,  Sam Protsenko <semen.protsenko@linaro.org>,
 u-boot@lists.denx.de,  Biju Das <biju.das.jz@bp.renesas.com>,  Chris
 Paterson <Chris.Paterson2@renesas.com>
Subject: Re: [PATCH] board: rzg2l: Do not expect a DTB blob from the TF-A.
In-Reply-To: <e66af909-d82b-4f4e-aa41-99a043abee76@mailbox.org> (Marek Vasut's
 message of "Thu, 18 Sep 2025 17:06:46 +0200")
References: <20250918124827.5577-1-othacehe@gnu.org>
 <173f12da-c201-4272-83a1-f70f2d4ca47b@mailbox.org>
 <87cy7nhlk1.fsf@gnu.org>
 <e66af909-d82b-4f4e-aa41-99a043abee76@mailbox.org>
Date: Mon, 22 Sep 2025 18:30:42 +0200
Message-ID: <87zfam30wd.fsf@gnu.org>
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


Hello Marek,

> Until then, I think check for params that are passed in being 0 is the right
> future-proof fix.

OK makes sense, I reworked the proposed patch and sent a v2 that only
checks for NULL pointers.

Thanks,

Mathieu
