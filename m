Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1182EC25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 18:21:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EF5B87D33;
	Mon,  3 Jun 2024 20:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="rPdRb99P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A67087C7E; Mon,  3 Jun 2024 20:21:28 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CC7A8835E
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 20:21:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from [127.0.0.1] (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 93E601F9B5;
 Mon,  3 Jun 2024 20:21:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1717438884;
 bh=C2LAhXWJm8V5phlCXDOC43zLavjs+lgp3iMOEAytz+M=; h=From:To:Subject;
 b=rPdRb99Px0BVMwKYj7Aiob1cnvoNSArn1IFn3A15aFzkeDqHbdy/U/8mPEnLLsOR9
 eyh2yeyGCnM7Ho/W4yOOvqfVf/cbiZCB168W8+mASSwsZksGKsUNSbugcK2XkaeKfa
 91cdzYKSAAcOOZvL39hd2bLoAmWf72zP3+LyvUR7F3+X4PhtwRnj7GqmkAZ6iQJwVP
 YDTa3i5/CguUxpwsantqUrCrCF13j+tLFXu5EtBipxNTRDeLxqvKrmFxj2s8NBTxvA
 BwGMkShfWvibeu63Jdn0nF79p7m1BcVBwIFemlmJK/XLZ2+2hA2AwipxUDY/PwJtZX
 Fyu4f/6ey8N6Q==
Date: Mon, 03 Jun 2024 20:21:18 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Tom Rini <trini@konsulko.com>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/2=5D_net=3A_phy=3A_Replace_P?=
 =?US-ASCII?Q?HY=5FANEG=5FTIMEOUT_with_Kconfig_symbol?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240603174419.GE68077@bill-the-cat>
References: <20240531164733.192105-1-marek.vasut+renesas@mailbox.org>
 <20240531164733.192105-2-marek.vasut+renesas@mailbox.org>
 <20240601092154.GA4383@francesco-nb> <20240603174419.GE68077@bill-the-cat>
Message-ID: <04182B2F-C087-4D5D-BF98-093A579D85FC@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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

Hello Tom,

Il 3 giugno 2024 19:56:07 CEST, Tom Rini <trini@konsulko=2Ecom> ha scritto=
:
>On Sat, Jun 01, 2024 at 11:21:54AM +0200, Francesco Dolcini wrote:
>> Hello Marek,
>>=20
>> On Fri, May 31, 2024 at 06:47:17PM +0200, Marek Vasut wrote:
>> > Switch PHY_ANEG_TIMEOUT to CONFIG_PHY_ANEG_TIMEOUT Kconfig symbol=2E
>> > This removes one more configuration headers option finalizes its
>> > Kconfig symbol conversion=2E No functional change expected=2E
>> >=20
>> > Signed-off-by: Marek Vasut <marek=2Evasut+renesas@mailbox=2Eorg>
>> > ---
>> =2E=2E=2E
>>=20
>> > diff --git a/include/configs/apalis_imx6=2Eh b/include/configs/apalis=
_imx6=2Eh
>> > index 0df3917e200=2E=2E6fd43511ee4 100644
>> > --- a/include/configs/apalis_imx6=2Eh
>> > +++ b/include/configs/apalis_imx6=2Eh
>> > @@ -22,7 +22,6 @@
>> >  #define CFG_SYS_FSL_USDHC_NUM	3
>> > =20
>> >  /* Network */
>> > -#define PHY_ANEG_TIMEOUT		15000 /* PHY needs longer aneg time */
>>=20
>> You should remove also the line before, after removing the define it's
>> just a stale comment=2E
>
>It would be nice, but there's lots of similar garbage remaining from
>other transitions, so to me it's not a deal-breaker here=2E

I see your point, I gonna send a follow-up patch to cleanup what I care th=
e most afterwards if we merge this as it is=2E

Francesco=20
