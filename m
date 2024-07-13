Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77933C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 18:03:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDDE9885A8;
	Sat, 13 Jul 2024 20:03:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cZz86+wP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43AD68860D; Sat, 13 Jul 2024 20:03:26 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 456F88855E
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 20:03:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WLxCZ2Jw4z9stj;
 Sat, 13 Jul 2024 20:03:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720893802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JoATaKDFjZas2rUjvaEOXosOGIl4QjglZECyAb1+ROk=;
 b=cZz86+wPgx/KushKdjV2YnTIxCM08d3gWO0Z3tD/qFLtE+cWrXMb02URNUTpVokAks7fcX
 kvNLxGiSYcZU/WQO6hM2ctet/7w/pBW9ydEKVbmc3oKex3yiMu+aD9V3QPQgtxCGdP3+vN
 5/viy0VJLW/QYBGXyXzNss6V0sHbmn+zeJ5hzyphJSRt3ztx78FBsRQZu9vcao3fD0WvLK
 mRcXU9IEagzAw1FdeORy2dWyjVpDqEWuyY9t0kl++ITw/zJ0MqL5F/HgvCRrLNXUovKtkZ
 f4nJLY9qWNUMe6uOY+WnO2RUs8YFvsTNvs+EGCKT/HE1voB1LIRiJc/FGEZfAg==
Message-ID: <f71513ea-8e13-45c6-a8c5-f6e5a8b84446@mailbox.org>
Date: Sat, 13 Jul 2024 20:03:20 +0200
MIME-Version: 1.0
Subject: Re: [PATCH uboot] dt-bindings: clock: rcar-gen2: Remove obsolete
 header files
To: Geert Uytterhoeven <geert+renesas@glider.be>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, linux-renesas-soc@vger.kernel.org
References: <6355fbaa5e3c40d6790cb5aa6ffc1c573c1f08ed.1720790104.git.geert+renesas@glider.be>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <6355fbaa5e3c40d6790cb5aa6ffc1c573c1f08ed.1720790104.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 6078bff826a4355ec0e
X-MBO-RS-META: g88i6n6sz8pqnxxyk5d4xh7k4tmxedoo
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

On 7/12/24 3:17 PM, Geert Uytterhoeven wrote:
> The clock definitions in <dt-bindings/clock/r8a779?-clock.h> were
> superseded by those in <dt-bindings/clock/r8a779?-cpg-mssr.h> a long
> time ago.
> 
> In fact U-Boot never used <dt-bindings/clock/r8a779?-clock.h>.
> The unused headers, their replacements, and the corresponding
> r8a779?.dtsi files were introduced together in U-Boot v2018.03.
> 
> Fixes: 16b6e4aa3732cee1 ("ARM: dts: rmobile: Import R8A7790 DTS from Linux 4.15-rc8")
> Fixes: edd15fcffba31452 ("ARM: dts: rmobile: Import R8A7791 DTS from Linux 4.15-rc8")
> Fixes: a3fb9ff3b33fae05 ("ARM: dts: rmobile: Import R8A7792 DTS from Linux 4.15-rc8")
> Fixes: 92aa09959271d08f ("ARM: dts: rmobile: Import R8A7793 DTS from Linux 4.15-rc8")
> Fixes: 9a26fc5a73fe2369 ("ARM: dts: rmobile: Import R8A7794 DTS from Linux 4.15-rc8")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks
