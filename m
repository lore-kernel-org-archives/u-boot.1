Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2429CC54E90
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 13:59:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A210082B6B;
	Sun, 25 May 2025 15:59:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=true.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="key not found in DNS" (0-bit key; secure) header.d=true.cz header.i=@true.cz header.b="bXvw39BO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4D0882BA7; Sun, 25 May 2025 15:59:26 +0200 (CEST)
Received: from smtp-out.xnet.cz (smtp-out.xnet.cz [178.217.244.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA56982A9E
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 15:59:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=true.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ynezz@true.cz
Received: from meh.true.cz (meh.true.cz [108.61.167.218])
 (Authenticated sender: petr@true.cz)
 by smtp-out.xnet.cz (Postfix) with ESMTPSA id 1659F1887C;
 Sun, 25 May 2025 15:59:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=true.cz; s=xnet;
 t=1748181564; bh=SFqgTpSxzpcSOCCAXM88JN79Cdfphq4a3ZKufwWmW5A=;
 h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
 b=bXvw39BO+yHA42RJhJgljzBmPNcyqJDBfpPYc0Jk6AcUdw++RquqCtiL31m89ifa8
 3gkl50Z5o1e7k+y3K9jfqE9B8qhT1JfrgrWqil446Kq+wXib52LHiVeNF8dNV/AJmJ
 tN0JZkldZwwXuOgmr91bxrLNSTeDG1MQyWprYFKw=
Received: by meh.true.cz (OpenSMTPD) with ESMTP id aca171d6;
 Sun, 25 May 2025 15:59:14 +0200 (CEST)
Date: Sun, 25 May 2025 13:59:22 +0000
From: Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Weijie Gao <weijie.gao@mediatek.com>, Daniel Golle <daniel@makrotopia.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] cmd: bootmenu: permit to select bootmenu entry with a
 shortcut
Message-ID: <aDMiOhq6JJiJbcNu@meh.true.cz>
References: <20250525134407.3760-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250525134407.3760-1-ansuelsmth@gmail.com>
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

Christian Marangi <ansuelsmth@gmail.com> [2025-05-25 15:43:58]:

Hi,

thanks for the quick fix!

> Permit to select a bootmenu entry with a key shortcut. This is
> especially useful in production or testing scenario to automate flashing
> procedure or testing procedure.
> 
> The boot entry are changed to append the shortcut key to it.
> 
> Example:
>       1. Run default boot command.
>       2. Boot system via TFTP.
>       3. Boot production system from NAND.
>       4. Boot recovery system from NAND.
>       5. Load production system via TFTP then write to NAND.
>       6. Load recovery system via TFTP then write to NAND.
>       7. Load BL31+U-Boot FIP via TFTP then write to NAND.
>       8. Load BL2 preloader via TFTP then write to NAND.
>       9. Reboot.
>       a. Reset all settings to factory defaults.
>       0. Exit
> 
> 0 is always reserved for Exit to console.
> On pressing the keyboard key 2, the bootmenu entry 2 is selected and
> executed.
> 
> Up to 34 key shortcut (0 excluded as reserved) are supported from 1-9
> and a-z.
> If a shortcut key not present in the bootmenu list is pressed, it is
> simply ignored and eventually the autoboot is interrupted.
> 
> Capital A-Z are converted to lower a-z and the related option is
> selected.
> 
> Suggested-by: Weijie Gao <weijie.gao@mediatek.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v2:
> - Fix spelling mistake
> - Fix case with '0'

Tested-by: Petr Štetiar <ynezz@true.cz>
