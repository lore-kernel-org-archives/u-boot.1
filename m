Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0613FCD0C5
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 07:29:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 638BA841D6;
	Wed, 18 Mar 2026 08:28:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="V7N5gSic";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55D1784238; Wed, 18 Mar 2026 08:28:58 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8A8A83FE1
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 08:28:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id DB2E1C55067;
 Wed, 18 Mar 2026 07:29:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 71CFB6004F;
 Wed, 18 Mar 2026 07:28:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2389B104506E5; Wed, 18 Mar 2026 08:28:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773818934; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=qDmqWQ9KOSTkaXCHu9mFQwXx3G7+ZcXdPNvJlRt3pao=;
 b=V7N5gSicdTu4MKpgygIsY7htiZ25dWoDzeM5DM9guj9Y/AGZDGpo0NFWpbuWvXQvTKkmRV
 IGe0ATR7l4vH6kekAWJezFPKC88WTOlQ6jM0do70Ud/xKQCRrMtxhg+QUaXn8yVyLHLVZJ
 4oPdklRntVw+0y48w+9UNA9QEyOwcIOqKNf8mqKrGiR0WyBg4+XuICJcSC9t9tYGz2Tes9
 G2vVhRYyP4/6e5EULPapu0+gAFd4aKfsy5F1QP9/nIx2Tdl8Wltx0KkGYxn/eJ2i0vHXgV
 4BMD/QQGc4pwqWWpxZEQDoKfEgKr/wf1yZzBfUL7s0bA2boqqjMfq/pZH8zWAw==
Message-ID: <df63f0f9-f6b3-4787-99d1-4a006a3e5394@bootlin.com>
Date: Wed, 18 Mar 2026 08:28:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mtd: rawnand: sunxi: introduce variable user data
 length
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Boris Brezillon <bbrezillon@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
References: <20260309152251.70837-1-richard.genoud@bootlin.com>
 <20260309152251.70837-4-richard.genoud@bootlin.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20260309152251.70837-4-richard.genoud@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Le 09/03/2026 à 16:22, Richard Genoud a écrit :
> In Allwinner SoCs, user data can be added in OOB before each ECC data.
> For older SoCs like A10, the user data size was the size of a register
> (4 bytes) and was mandatory before each ECC step.
> So, the A10 OOB Layout is:
> [4Bytes USER_DATA_STEP0] [ECC_STEP0 bytes]
> [4bytes USER_DATA_STEP1] [ECC_STEP1 bytes]
> ...
> NB: the BBM is stored at the beginning of the USER_DATA_STEP0.
> 
> Now, for H6/H616 NAND flash controller, this user data can have a
> different size for each step.
> And the vendor has chosen a different layout from the one on A10, using
> 8 bytes for step 0 and nothing for further steps:
> [8bytes USER_DATA_STEP0] [ECC_STEP0 bytes] [ECC_STEP1 bytes]...
> (Still with BBM stored at the beginning of the USER_DATA_STEP0)
> 
> In order to be compatible with this layout, the current one for H6/H616
> has to be changed.
> 
> Fixes: 7d1de9801151 ("mtd: rawnand: sunxi_spl: add support for H6/H616 nand controller")
> Fixes: f163da5e6d26 ("mtd: rawnand: sunxi: add support for H6/H616 nand controller")
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>

On Linux ML, it was asked to maximize the user data length instead of
relying on vendor OOB layout, so I'll send a v2 with the same behavior.
cf:
https://lore.kernel.org/lkml/20260317142437.580204-1-richard.genoud@bootlin.com/

Regards,
Richard
