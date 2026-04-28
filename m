Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76B2FF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 12:42:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F20984669;
	Tue, 28 Apr 2026 14:41:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="bqplg1om";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20414842C7; Tue, 28 Apr 2026 10:52:27 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94C668426E
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 10:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 14F511A346D;
 Tue, 28 Apr 2026 08:52:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D858E601D0;
 Tue, 28 Apr 2026 08:52:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 01D3810728547; 
 Tue, 28 Apr 2026 10:52:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777366343; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=SBJ5N1E2wJOTfY1ybNEoiefegW3G1GxhqvtvWKCRxvk=;
 b=bqplg1omRUKMTPKsHTVzxYYpEgevnYUu3n3liBvxP1prbhLGPxC4DWNoirj/ristWKay7N
 iF+k92+7vwqs+taFTki8FzLNR5BBJR9jEUCNq3Xz/9MMybKRMLLbbgS7yAS4r/6brQkLrP
 4omfLDJR3kyQrN9NmUMdImCRnekMoC13f5+AFcEC2PQHrmDRG42kbMv4N/N+qJpJno2Aj/
 sdAGvotjfvBxOmW9wDYlYGzYkyPJ8cjxNLJRCqLF0Z4KGYMNRnTV6AT3Kta8UOItIT0kBv
 9js2BPrJgBoCsTUPxudSxOqN7s0HrA3CajD7VRJv1kddqNrFM+wjbWZGbnHH7Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: <u-boot@lists.denx.de>,  GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>,  Tom Rini <trini@konsulko.com>,
 "Vignesh R" <vigneshr@ti.com>,  Takahiro Kuwano
 <takahiro.kuwano@infineon.com>,  "Marek Vasut"
 <marek.vasut+renesas@mailbox.org>,  Tudor Ambarus
 <tudor.ambarus@linaro.org>,  Jeffrey Yu <jeyu@issi.com>,  Christoph Reiter
 <christoph.reiter@evk.biz>,  Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>,  Shiji Yang <yangshiji66@outlook.com>,
 "Bernhard Messerklinger" <bernhard.messerklinger@at.abb.com>,  Vaishnav
 Achath <vaishnav.a@ti.com>,  Prasad Kummari <prasad.kummari@amd.com>
Subject: Re: [PATCH 6/6] mtd: spi-nor-ids: Add support for Winbond
 W25Q256JV/W25Q512JV
In-Reply-To: <5be181eabf090169f9df89d86d34347a8b4bd276.camel@mediatek.com>
 (Weijie Gao's message of "Tue, 28 Apr 2026 16:37:02 +0800")
References: <cover.1777345877.git.weijie.gao@mediatek.com>
 <a953087c1d0ff8429d64aa014ddb5612d2799b50.1777345877.git.weijie.gao@mediatek.com>
 <871pfzfs03.fsf@bootlin.com>
 <5be181eabf090169f9df89d86d34347a8b4bd276.camel@mediatek.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 28 Apr 2026 10:52:17 +0200
Message-ID: <87jytreabi.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 28 Apr 2026 14:41:00 +0200
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


>> > +	{
>> > +		INFO("w25q512jv", 0xef7020, 0, 64 * 1024, 1024,
>>=20
>> This is JV-M (here and above).
>
> Of course. I didn't test the -Q version but I already saw related parts
> like w25q512jvq existed.
>
> Perhaps naming these -M series with 'm' suffix is better.

I'm fine with both, I prefer -m in this case, because there are letters
in between:
- 2 or 3 letters for the package type
- I or J for the temperature range

>> These chips also happen to conflict with W25QxxRV-M chips. Is this
>> support for these new chips that you are targeting?
>
> I didn't use RV series now. w25q256jv/w25q512jv are tested on
> MediaTek's filogic platform.

This is worth mentioning in your commit log.

>
> As winbond doesn't provide the actual contents of the SFDP table, I'm
> not sure if there's a way to distinguish between these two families.

There is one, I will contribute it to Linux/U-Boot soon, but both are
very similar in their behaviour, so it's okay like that.

Thanks,
Miqu=C3=A8l
