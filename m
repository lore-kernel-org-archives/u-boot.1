Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48540C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 15:09:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36C2E87172;
	Sun, 29 Oct 2023 16:09:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698592180;
	bh=nLzj0HQvQ0kugvi5Azh8voz2GIBIOX8JKqFe4cd02mc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UGpzSLbK/sA00L31b/tz8/w8biAOxcdMrQZ+PY7+GoNqcJC/CUDHrecclaZ++wVPr
	 t5vP+GSogbUArYqFTqO/t0jz54emLP5tpHeGsuB3qImWune1Er9R95eCAli4PBqAs6
	 QueQz4ljN22AjxP7yQFTMDPRziFJP7PcfGMd+UcNG6X9DnGkCXIi39LYEBO3tc1ae7
	 MJE790EpX4d3U3GNo0PwkWPlejg7mEoI3HEpJBIzsE1z5qgahQX6ybmDkbzPnC24KK
	 4xnUCxp608ZPX3Dm2fK2QsLnP/Cd/p3IFdGaiccJ5+HkGQoLh+bJOh1Vbq+1xk4pBD
	 ulrFFEJD0CE6w==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B3A94870E2;
 Sun, 29 Oct 2023 16:09:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698592179;
 bh=nLzj0HQvQ0kugvi5Azh8voz2GIBIOX8JKqFe4cd02mc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=uq5jAD+nI+ndyntT6A/Yg6C3slYFwswuKBQLUq//RFKSE0jzFih7KEGUaBXS0gtUi
 ofUxf42QwkT3Aju6O+eqvZCjIYeq5Yhx/Wl4z6kZRzQ0CcIzrjREHhNs9jzzfFQItR
 I4ZYAgkVCZ/Pk8MYp3SC79nAChrsdgjtrwzWCj4HxbhxiGh1ugyuD7cc5L9Mo4PGBT
 wfiD6Gg1+4vDn+n7WH2P7P+EFa4D284X0S11sC5wXiaereVM935DKFIhfJaxZIMVqQ
 Y3tmr1oIH+dHVf4f2TU+CF8xInT7D2Flt2otRqRsnRmKFKcF4GemHaNKFOX3TlDjtS
 ezFXK/ZKYiczw==
Message-ID: <20a48b48-6077-464a-8550-9a00e695cd44@denx.de>
Date: Sun, 29 Oct 2023 12:35:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] USB fixes: (Re)implement timeouts
To: Hector Martin <marcan@marcan.st>, Bin Meng <bmeng.cn@gmail.com>
Cc: Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>,
 u-boot@lists.denx.de, asahi@lists.linux.dev
References: <20231029-usb-fixes-5-v1-0-54bb13001f54@marcan.st>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231029-usb-fixes-5-v1-0-54bb13001f54@marcan.st>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/29/23 08:36, Hector Martin wrote:
> A long time ago, the USB code was interrupt-driven and used top-level
> timeout handling. This has long been obsolete, and that code is just
> broken dead cruft. HC drivers instead hardcode timeouts today.
> 
> We need to be able to specify timeouts explicitly to handle cases like
> USB hard disks spinning up, without having ridiculously long timeouts
> across the board (which would cause endless waiting when things go
> wrong anywhere else). So, it's time to rip out the old broken nonsense
> and actually pass through timeouts to USB host controller drivers, so
> they can be implemented properly.

I like this.

[...]
