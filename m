Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63953C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 23:04:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D442088207;
	Sun, 21 Apr 2024 01:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713654256;
	bh=xX1J/c9qiGizkJnyu+6r9aL5oeiya1AS7haPg3ciiI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ciff3J2Y/24R9UsqE5ndoLS/rmp/nWcawA/ubv0QXLI1+8GDoB8bbHp0ddgmXKkDi
	 S9wAsEdKsjESC4fvdMjduwPSuqfH07ZWemP+T65GV5sPjLOiHLpw4jHJ2f74iJgKlB
	 FmHnr8/VHlK7y1UUEbtO0HVu8XS6Zr76PM9zrU/PO8CRD3dXIs59t8bDXHx8cUEhzR
	 cjHceej0F7by63Ys4BQRfO5T5DmgPeS+nDAdH4tSB1HmotB0a5zL1b7vo1u9zDZ45K
	 R+dJ4mmI6Dz87po9I5VIK60fIJtJRvFRAZDoEda0sDia+Ts0oRIE3b+F3w4pWXFdMZ
	 oXhE6VYFuPezQ==
Received: from crub (p508b6ab0.dip0.t-ipconnect.de [80.139.106.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1C1D1881FB;
 Sun, 21 Apr 2024 01:04:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713654255;
 bh=xX1J/c9qiGizkJnyu+6r9aL5oeiya1AS7haPg3ciiI8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=E//ZMGHc7H8FHlsCQ15FBpGj5fTibL3VPEv7BLTM2mfUhhhxMqhylUU8wq5PcKwfr
 GFImYJnbWzfwnDkWHy4fk1UrR45GMwfSxnUJsuIePHbPTlr5DPi7/xDAFGxbA9pwfm
 /dRasXXyHwXpFWESRolRGA8iCXN56MxGBbmiq/cMPQc+BCocgMjsLjvApffnagOS22
 ESOgplw0b/iHT0+nrCANYmHNP2zPqmPeIEbNZbqop+62fOPz9LEL4iSAVXmAEWggXc
 D1jB2xy3Al/mnaJjEkjRUQjl/FHpsLpilYE3xwCHC1esJ+IJ3bf9TalBpsQt38Pwmy
 8FEuSYInQ3UAQ==
Date: Sun, 21 Apr 2024 01:03:54 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Anton
 Bambura <jenneron@protonmail.com>, Jonas =?UTF-8?B?U2Nod8O2YmVs?=
 <jonasschwoebel@yahoo.de>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/7] Tegra panel improvements
Message-ID: <20240421010354.4ae1506e@crub>
In-Reply-To: <20240131065721.4245-1-clamor95@gmail.com>
References: <20240131065721.4245-1-clamor95@gmail.com>
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

On Wed, 31 Jan 2024 08:57:14 +0200
Svyatoslav Ryhel clamor95@gmail.com wrote:

> The current patch set improves the logic of existing panels and
> bridge used by Tegra 3 devices and brings support for additional
> DSI panels used by Tegra 4 devices.
> 
> New and existing drivers are fully reusable, contain no device
> specific parts, and are written according to existing datasheets.

Series applied to u-boot-video.

--
Anatolij
