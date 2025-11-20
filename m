Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B04CF8553
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 08:17:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A71CE8405F;
	Thu, 20 Nov 2025 09:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="VYRBU8lK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F1BC84067; Thu, 20 Nov 2025 09:17:06 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25086836D1
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 09:17:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 0CB5D21548;
 Thu, 20 Nov 2025 09:17:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1763626623;
 bh=7FjA/nmFZ23xj0kqG82GZrwEYqmX83/0Uphn0QYZi08=; h=From:To:Subject;
 b=VYRBU8lKXUkT9Q5Qy2iGAHON0ToES1mh4SaIPcRvJSvGykPOG6uf5lW/l4ZMHeJ3R
 yXjYQUvRrIGSn5KVP4bzxVcUZ3YZlGzNg8lasuYtBSRaa1X7htsxTObreKyPhhUdJ4
 OgEwEBJVFevGJHxS/dDI3Utj9yH9ZdMB2XCdzF4NAEhetaeo3X+5PUuZDbJ6AIWO1S
 VnvO48I2hZqEpROFUnyxFgiDVJqhi2ScumeBhqU8jFJFBddmUzQ9q7CF9D4EYLZvPp
 srdn00m8aSSQfbfGBHEwo+TQZTlIOFLkL576Me2NPN9A0BNHkSRg7b2egeAwsFwso6
 5S7KESUg6yu3g==
Date: Thu, 20 Nov 2025 09:16:59 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Neha Malcom Francis <n-francis@ti.com>, "Scholz, Kevin" <k-scholz@ti.com>
Cc: Franz Schnyder <fra.schnyder@gmail.com>, trini@konsulko.com,
 s-k6@ti.com, bb@ti.com, m-chawdhry@ti.com, u-boot@lists.denx.de,
 u-kumar1@ti.com, gehariprasath@ti.com
Subject: Re: [PATCH v2 5/7] arm: dts: k3-am69: ddr: Update to v0.12.0 of DDR
 config tool
Message-ID: <20251120081659.GA12514@francesco-nb>
References: <20251103071035.674604-1-n-francis@ti.com>
 <20251103071035.674604-6-n-francis@ti.com>
 <btgc6fvqwkqlnnmqicvobikkyjpib5lgvda7tfyguwn25bmd2s@hdhibzylbig7>
 <2b1b5496-cbd2-4ac4-85cc-2b8da653bbdd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b1b5496-cbd2-4ac4-85cc-2b8da653bbdd@ti.com>
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

Hello Neha, Kevin

On Mon, Nov 10, 2025 at 09:55:08AM +0530, Neha Malcom Francis wrote:
> On 07/11/25 21:14, Franz Schnyder wrote:
> > On Mon, Nov 03, 2025 at 12:40:33PM +0530, Neha Malcom Francis wrote:
> >> +#define DDRSS0_CTL_178_DATA 0x35000000
> >> +#define DDRSS0_CTL_186_DATA 0x00353500
> >> +#define DDRSS0_PI_275_DATA 0x00F30084
> >> +#define DDRSS0_PI_281_DATA 0x00F30084
> >> +#define DDRSS0_PI_287_DATA 0x00F30084
> >> +#define DDRSS0_PI_293_DATA 0x00F30084
> >> ....
> >> +#define DDRSS1_CTL_178_DATA 0x35000000
> >> +#define DDRSS1_CTL_186_DATA 0x00353500
> >> +#define DDRSS1_PI_275_DATA 0x00F30084
> >> +#define DDRSS1_PI_281_DATA 0x00F30084
> >> +#define DDRSS1_PI_287_DATA 0x00F30084
> >> +#define DDRSS1_PI_293_DATA 0x00F30084
> >> ....
> >> +#define DDRSS2_CTL_178_DATA 0x35000000
> >> +#define DDRSS2_CTL_186_DATA 0x00353500
> >> +#define DDRSS2_PI_275_DATA 0x00F30084
> >> +#define DDRSS2_PI_281_DATA 0x00F30084
> >> +#define DDRSS2_PI_287_DATA 0x00F30084
> >> +#define DDRSS2_PI_293_DATA 0x00F30084
> >> ....
> >> +#define DDRSS3_CTL_178_DATA 0x35350000
> >> +#define DDRSS3_CTL_186_DATA 0x00353535
> >> +#define DDRSS3_PI_275_DATA 0x35F30084
> >> +#define DDRSS3_PI_281_DATA 0x35F30084
> >> +#define DDRSS3_PI_287_DATA 0x35F30084
> >> +#define DDRSS3_PI_293_DATA 0x35F30084
> > 
> > When I compare the updated configuration to the one for our Aquila AM69
> > board, I can observe that you have set an on-die termination at boot
> > frequency only for DRAM3. DRAM, DRAM1 and DRAM2 do not seem to have any
> > termination enabled. Is this a mistake or is it intentional?
> 
> Kevin, could you explain the reasoning for this?

Any update on this?

Thanks
Francesco

