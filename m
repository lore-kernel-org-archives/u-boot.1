Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94CBC4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 10:27:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1953688319;
	Tue, 16 Apr 2024 12:27:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="j86OzdrV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F51D87DB1; Tue, 16 Apr 2024 12:27:02 +0200 (CEST)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD14A882AC
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 12:26:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rwg1d-0003Rw-CI; Tue, 16 Apr 2024 06:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
 From; bh=ypsGyULasiSnxOpar1Ct/gZMnWEDAMvtcHxnZmpwQyM=; b=j86OzdrVH21gilAj3zsu
 Zmc8HrkI/g8U6C1WkjESgQDcrg4jLvvibJJCXLKARIJMjrtJ2rO5WpmYMWIXs9ap/QuEvxncLV56K
 edaKZz/yq3ffrVJmGJsijw7cRHktdBJfpdgR45kZXzSBmFSzjuLJga7G+EDws82FgZNNRHH+EPJte
 dn0kI5rluGKVl9iXy2n6Sa19BJD7nNlpZZEYElNATEl6U8Al4QHCQVIrHyMLb7wX6qc6uBiMnCpyI
 b88gT1u7AG6622dC5/hNGwACJEnfZZ4P9qBGG7jtuSnOyDB+0gMmnXA7hl3NV8fHoaXUAP4sMeInW
 MM9Hdq9HnPGygw==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: ye.li@nxp.com,  u-boot@lists.denx.de,  Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH] imx93: Move SoC and lifeclycle information to debug level
In-Reply-To: <20240415215717.3732484-1-festevam@gmail.com> (Fabio Estevam's
 message of "Mon, 15 Apr 2024 18:57:17 -0300")
References: <20240415215717.3732484-1-festevam@gmail.com>
Date: Tue, 16 Apr 2024 12:26:47 +0200
Message-ID: <87o7a9ob6g.fsf@gnu.org>
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


Hello,

> The following information printed on every boot is not very
> helpful for the users:
>
> SOC: 0xa0009300
> LC: 0x40040
>
> Move them to debug() level.
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Mathieu Othacehe <othacehe@gnu.org>

Thanks,

Mathieu
