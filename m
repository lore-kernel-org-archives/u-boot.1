Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA2DC54E90
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 13:02:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B90E882B27;
	Sun, 25 May 2025 15:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=true.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="key not found in DNS" (0-bit key; secure) header.d=true.cz header.i=@true.cz header.b="p4Gsvu1s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63A8082B31; Sun, 25 May 2025 15:02:17 +0200 (CEST)
Received: from smtp-out.xnet.cz (smtp-out.xnet.cz [178.217.244.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E56882B0F
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 15:02:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=true.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ynezz@true.cz
Received: from meh.true.cz (meh.true.cz [108.61.167.218])
 (Authenticated sender: petr@true.cz)
 by smtp-out.xnet.cz (Postfix) with ESMTPSA id 924E6187DB;
 Sun, 25 May 2025 15:02:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=true.cz; s=xnet;
 t=1748178134; bh=O9YozLL4dkK7Ft6f+rwW1M5a5jB4G+IbpNDgAMbBILM=;
 h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
 b=p4Gsvu1sfpsz/q0ZZIL9toNxoKV5LAh1mMp8WhKGzBJ1IggvLEmvMdcMkLbsnnViH
 TbXoGJ8VshcKtmpMokfxqtg/EYmGXGMo5dQnUInHWSUivd88aB0j3MMk/2M/S7gJbm
 PmzNnHy6APJcCxaPLMtGDGo1ROxnue2gipO3GTw8=
Received: by meh.true.cz (OpenSMTPD) with ESMTP id 580f9b13;
 Sun, 25 May 2025 15:02:05 +0200 (CEST)
Date: Sun, 25 May 2025 13:02:13 +0000
From: Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Daniel Golle <daniel@makrotopia.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] cmd: bootmenu: permit to select bootmenu entry with a
 shortcut
Message-ID: <aDMUzv2QIOdG+97H@meh.true.cz>
References: <20250524221313.10249-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250524221313.10249-1-ansuelsmth@gmail.com>
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
Reply-To: Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Christian Marangi <ansuelsmth@gmail.com> [2025-05-25 00:12:52]:

Hi,

thanks a lot for your upstreaming efforts!

> Permit to select a bootmenu entry with a key shortcut. This is
> especially useful in production or testing scenario to aitomate flashing

aitomate -> automate

> 0 is always reserved for Exit to console.

BTW this is the only shortcut key which currently doesn't work :-) See below.

> +		case BKEY_SHORTCUT:
> +			/* invalid shortcut, regenerate menu */
> +			if (cch->shortcut_key >= menu->count - 1)

IMO it should be:

			if (cch->shortcut_key >= menu->count)

Considering menu with 4 items and user presses '0':

 * bootmenu_conv_shortcut_key() returns 3 (menu->count - 1), so shortcut_key = 3

 * With the original condition
     if (cch->shortcut_key >= menu->count - 1)
     if (3 >= 3) → true, so it returns NULL (bug)

 * With the fixed condition
     if (cch->shortcut_key >= menu->count):
     if (3 >= 4) → false, so it correctly proceeds

> +				return NULL;
> +			menu->active = cch->shortcut_key;
> +			fallthrough;

Cheers,

Petr
