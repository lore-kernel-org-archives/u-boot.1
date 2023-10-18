Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53835CDB483
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 10:51:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E69886380;
	Wed, 18 Oct 2023 12:51:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697626293;
	bh=6xa8+MEnlikDM5EFrCOGha/EFm7lp7cCH+sIonxwPSY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LXJJsgkEW1076cNYsynysCSSXLW2e6ouMHU0DgYupUoCUj57xdzVgOLDfFGvPEhrZ
	 bIUrQI6bvZDs9N9llslSN4h4Sv/rLvn+S9AlU+cblcMvFupTZcGsN0Wd/SxJ6F27Nf
	 cJ98j0KM5NGQXNxdcJhOh3k7Uu0vyjJpfRLZfPlHP8EIkZlp4xUJyjrMP8iMsx2oxK
	 7aTo7/VP/qZfUWu+8nQMDu7QrhZ3Wz4/kDl/3nEbYMY/CAOQK4fsYG27+PeSI47JAe
	 dOpBmcXRjuRXPzrtAxj3I7ta4iysgIr5q29tYVTLzIbv6uLHuUh9x4W8EVjtROSZhK
	 pOo1oEZ2s4Zhw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9B5F386F65;
 Wed, 18 Oct 2023 12:51:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697626291;
 bh=6xa8+MEnlikDM5EFrCOGha/EFm7lp7cCH+sIonxwPSY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=zkOAQT5JEEAswaW5UhNuo5X47x5wsMK6Y4P6cGUbk2COPWXBbhyoZWXclJRQt2WbN
 /rnz/RVhuVfWHMgbotCXbuV2SpZ2l9NYYHIuCYLCds1QEtGo7P8KB0k0xZe/GQ+zOB
 X3rW3+C1sVlPqYr2P0JSwWxwRexl/8ytDb9L3nv0LRscARu5VDNX2HqC2FnMP71RcY
 qrEmH3/qZwH5RT78v/B/Zw6tvmP+tUGaRCJhFYOqLhLerFV4AbI7yt5onV0K4zWTjo
 T74WP6QDXvr4xreC3k1jRVdIsTDyq6Zag0xdgMaOcYtaw18oYCCYdoXPgkAiutqHGL
 liBfdNiZFbMlg==
Message-ID: <39894d06-4bbc-4d8b-9b85-940159b614b3@denx.de>
Date: Wed, 18 Oct 2023 12:51:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] MAINTAINERS: usb gadget: add Mattijs
Content-Language: en-US
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de
References: <20231005-mattijs-usb-v1-0-7e79ab31ca49@baylibre.com>
 <20231005-mattijs-usb-v1-1-7e79ab31ca49@baylibre.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231005-mattijs-usb-v1-1-7e79ab31ca49@baylibre.com>
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

On 10/5/23 15:04, Mattijs Korpershoek wrote:
> It seems that Lukasz and Marek could get some help in maintaining the
> usb gadget drivers.
> 
> Assign myself as maintainer.
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Acked-by: Marek Vasut <marex@denx.de>
