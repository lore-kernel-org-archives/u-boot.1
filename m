Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A26C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 08:50:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2BBE8876E;
	Fri, 19 Jul 2024 10:50:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721379032;
	bh=FSdudK82cYIFRkYIMHoiQupXSmfKKxMEXWe+Mb4iMCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pA+UYL2xqf3VvtXQ+girhC4kQT2K/z6jyWm4mWonhlLSiqLVdvakLqFY4Jg7Ax3Qz
	 hdHe+S4J96x5aOGNUu1RoLj8ZgYJ2teIlL8wgU3iaNlzq79yDJz4vnUKUaqGEV9bsS
	 1UNGH2iF5ewzTKf956KHPpbrSwi3Z+6xNWSX6WPBwnRs018kkKRnFY12AsnPRuqck8
	 ntk7f7rJCasNMzuiNoNbeefoaabFQzx8BdrPz8KXCLJEv+fSIR5HS5qULtsobgCDQp
	 KzEZkt1rRMDpbdtyp6Oh9eZM2l/V3Kc2bvx/ocXwp8R/P6PVaWASwV+qQwAD8mIXoI
	 tOCJnnWSkiJQw==
Received: from crub (p508b6272.dip0.t-ipconnect.de [80.139.98.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 437808850A;
 Fri, 19 Jul 2024 10:50:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721379031;
 bh=FSdudK82cYIFRkYIMHoiQupXSmfKKxMEXWe+Mb4iMCo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=rrM5XrXAB1T5IRigjNpncY7m/dK9I0uVWBZT3zcz4LN6Uu6eDstowy/zfhN0Yi+kV
 6M5hd4RiK1PTVHc3d+XkbW91U1BChlO2TEfvet0P8ZHZkpsA//gqFK999KJjPaI09s
 OtpTP6oJkPbEm0r38VpTW2/q9b/O80TYnnwtNc0TVOPgTwwFKEEjXj0SAZXbjAfnn5
 kvTmVBMXG1t23BfYuxYmvb2wjh+i0LyFx/H6luKMN3vdpkdbVuvhhPYs99FCc2xUaQ
 y541Md3/XhLxplLkdm7zDXY1bbaDrWsZzw+xsuGjia786Z+R8szPcOmSwGtVNN1XuZ
 b+88imsHimW6w==
Date: Fri, 19 Jul 2024 10:50:16 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Heiko Schocher <hs@denx.de>, Aleksandar Gerasimovski
 <aleksandar.gerasimovski@hitachienergy.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Angelo Dureghello
 <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>, Francis Laniel
 <francis.laniel@amarulasolutions.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Michal Simek <michal.simek@amd.com>, Rainer Boschung
 <rainer.boschung@hitachienergy.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH 01/20] arm: Remove pg_wcom boards
Message-ID: <20240719104612.6ecd9891@crub>
In-Reply-To: <20240718173611.4014274-2-sjg@chromium.org>
References: <20240718173611.4014274-1-sjg@chromium.org>
 <20240718173611.4014274-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Hello Simon,

On Thu, 18 Jul 2024 18:35:52 +0100
Simon Glass sjg@chromium.org wrote:

> These board has not been converted to CONFIG_DM_I2C by the deadline:
> 
>    pg_wcom_expu1
>    pg_wcom_expu1_update
>    pg_wcom_seli8
>    pg_wcom_seli8_update
> 
> Remove them.

Please keep these boards. I got the task to do DM_I2C conversion to
prevent board removal from mainline. Thanks.

--
Anatolij
