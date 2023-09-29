Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EC0E743F2
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 07:55:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D854186813;
	Fri, 29 Sep 2023 09:55:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="quJNNO9i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3216186E9C; Fri, 29 Sep 2023 09:55:44 +0200 (CEST)
Received: from mail-4027.protonmail.ch (mail-4027.protonmail.ch [185.70.40.27])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D5438652B
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 09:55:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vitali64pmemail@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1695974141; x=1696233341;
 bh=+2s90DB22TXsktshPUkJegWDHYvsgs69BGl2w/FVnEI=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=quJNNO9iXyWs8WINAM5wZGnINzDopfmI4XWQrYYYyks1YozS3/pHJqBiLslfM/zci
 AVY8hueJzlstBlA/631exO6dbCyGBd9KbmrPzXuDcR3a9/DpRzLSRKlqKcJWN7A87Y
 aZHFNzxKyoqaxC5C0cBD+sOY9rBeeYidH7wgCyng1s/6aut9WcMWFNJEUQvJlDLi2u
 nrfHhdfzdr3RSskgpzDdZDYb5yquX3Rj2pwf01tqUuLU1UYHAQ3c+PolK6i0LrAbeB
 uJmnI38rzRItTKj9UzFE1Bx/xDo9skxEXneRf05iTTVf2A/u/nZ+nvWRaqfcF1D/Aj
 APziXlgo1kwgg==
Date: Fri, 29 Sep 2023 07:55:31 +0000
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>
From: Ferass El Hafidi <vitali64pmemail@protonmail.com>
Cc: Chanho Park <chanho61.park@samsung.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] spl: Jump to image at end of board_init_r
Message-ID: <CVV8MYJATGY1.17IBLLQ28R1YF@flaptop>
In-Reply-To: <b99750c4-973f-48f4-9c3b-166f0e5e832c@gmx.de>
References: <20230927214415.2224768-1-jonas@kwiboo.se>
 <b99750c4-973f-48f4-9c3b-166f0e5e832c@gmx.de>
Feedback-ID: 37421466:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Heinrich,

On Fri Sep 29, 2023 at 2:57 AM CEST, Heinrich Schuchardt wrote:
> In SPL we are fighting for every byte of binary size.
>
> What is the impact of this change on the code size?
>
> I would expect that your increasing it; especially if only one of the
> CONFIG_OPTIONS is enabled.
>
> If so, NAK to this patch despite all elegance.

Would you prefer removing `spl_board_prepare_for_boot()` instead?
A handful of boards make use for it so I'd say this is a bug if it never
gets ran on those.

Or would it be better if it was enabled with a CONFIG_ option?

Cheers.
>
> Best regards
>
> Heinrich


