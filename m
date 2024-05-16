Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22FDC25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 10:55:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F3BB88297;
	Thu, 16 May 2024 12:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715856923;
	bh=9RsnSJs6ni3yNC4r8m9jI4xAvzFon3PNUWFZYCFEQGY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ywo5UmTCn3oQpZ9VhkkG+E/bATEyIL+WryiaCVgRNrUZJ7UQ22eGIS/pYPJcqriKM
	 bBv1z/u0h2wgX9G9vKtjrxhHafhwcgMrB+fQaBZaRdsfy9fTCyxiR1Fsq+2/KgUW5n
	 PAQoF263orQyuM3i8pqpv0U4a6AtpOL8nir/vthOliWRyT9ZPCcx2Y+h9NuGLVOsCp
	 6TbKmx/3t9UR2O0P/fYnwQt0/J10g0FBCbAPni24diOcV32Kuq+j1t+yJxvDR89W0R
	 mGgYGkroODNSI8UdEbURbosRd7mwVYhCEDymwHwQchyAPOzzRUBnwqFcXF76PsOOdy
	 R9nckCJ2L7FXg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8BF2388267;
 Thu, 16 May 2024 12:55:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715856921;
 bh=9RsnSJs6ni3yNC4r8m9jI4xAvzFon3PNUWFZYCFEQGY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DXYyVr1hf8WEiVP9sTd1LGG+vIayZuLHC4kH2huDs4k/6TVjCg5ub27fbqJBtQAhI
 rTmG/zKBfAZ3UY7bmDN4p8xeR1zXFSDD2MO2g3KrpSFkTXj2qlxx/URGBosZltBHJJ
 QWConavJ0nR3iDzweQSQstrCreHpT5fXtVrkJSW7CCj5eRoRuf7lhSKgieQKRFnoai
 Trht62acwuKYICrbF8RGhMLVYF6/jl28apUhK0dlFsarpqgdMUtocFcRCj+pFzCAYf
 KGvpE0KNwP0k4eDb8qc5wMA/d59a9Vz2+A28CP2CHzAT0WoAoYE/+U/KdKqEli21Go
 uxfk4pL5dRJRg==
Message-ID: <87af8311-cd97-4029-a654-266bde702d86@denx.de>
Date: Thu, 16 May 2024 12:23:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2][PATCH 2/2] MAINTAINERS: add USB gadget regex to u-boot-dfu
 tree
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de
References: <20240516-gadget-maintainer-v2-0-23cc916df434@baylibre.com>
 <20240516-gadget-maintainer-v2-2-23cc916df434@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240516-gadget-maintainer-v2-2-23cc916df434@baylibre.com>
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

On 5/16/24 11:15 AM, Mattijs Korpershoek wrote:
> We try to split work with Marek on USB as following:
> - Mattijs handles USB gadget
> - Marek handles the rest of USB
> 
> Add additional gadget patterns to the maintainers file so that I
> get cc'ed more often on USB gadget patches.
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Acked-by: Marek Vasut <marex@denx.de>

You can try and look at the N: instead of F: (see top of MAINTAINERS for 
meaning), but that should be separate clean up patch.
