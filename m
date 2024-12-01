Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92831D4977B
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 18:45:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4283188D4F;
	Sun,  1 Dec 2024 19:45:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1733078715;
	bh=qtzmSK2d7/zU7G+l+Fol35zBf4YjuFfezIoRhVGfxgc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V5fBsKyY6/4ci/ZKIij/kVtWby3qFrxZFshnuH4s4Jwj95Nx6MSCIG2xtMSqmfhTB
	 0BBOp4NTHr5UDOaWNZET7FWRRLtUOfPUG+ZqDOaftxe0oOHIuJ35YkQSrxo6y3BuYc
	 0pgFpR3fRgWrHdQcoHgnfNLuRPFsX3v5Hl2gN9R/Nb1Sgait/Fr/XIhuhmtE+rDmb6
	 c0blHBbjHCF4ZcTb4FxVpxT30dPDSopQp5FgrabvChCVTA8I2pfGn3BxPOE2qHF1Lu
	 9KF0MimDcU/KwdL/Qhp04Blk7/vAVEZj3+/vpHmFOWy1R2MTB//SW2i/0VzufjYtJ/
	 DzhC6BUHRPQvg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B617788B64;
 Sun,  1 Dec 2024 19:45:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1733078713;
 bh=qtzmSK2d7/zU7G+l+Fol35zBf4YjuFfezIoRhVGfxgc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jcJ6Yl/yz0D5fz11e4jHqn4fs36huQva5ZWuJnOx+L/KRGlsRCPsTA9VpwgohK+KN
 mlvHD6d4mFXPcsanccYLnn2wubWg86Jv3WU37EsFriX54HaEWvbKkrWFj92s0nS/Yb
 Kxb+8QMIhoivYA7tzyk8dtm4tMMjsFJT8lydfi5S3uw97DNBqaBCWSN/QY9BzC5Ovj
 MTKaa1BB+s3lVgE55sb7dT7BCipCJuhAFDWaI8QOpvU4Nv/4aPPEStcRauyS5JGQGX
 GQiNzBvjnnfAviOo1KCwM3SI5+swZpESeCKlBKta0gpTXxojYT0oDPafwPx0yCJnc8
 KV9DaLQpbNuog==
Message-ID: <3b1359d9-2be2-452f-be56-b7ac2c4b50d7@denx.de>
Date: Sun, 1 Dec 2024 19:20:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 3/4] board: dhelectronics: Sync env variable
 dh_som_serial_number with SN
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 u-boot@lists.denx.de
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
References: <20241128142020.35386-1-cniedermaier@dh-electronics.com>
 <20241128142020.35386-4-cniedermaier@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241128142020.35386-4-cniedermaier@dh-electronics.com>
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

On 11/28/24 3:20 PM, Christoph Niedermaier wrote:
> The env variable "SN" is used to store the serial number on DH electronics
> SoMs. New SoMs will use the variable "dh_som_serial_number". To ensure
> compatibility, these env variables are synchronized. This is achieved
> using callback functions.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> ---
> V3: - Add this patch to the series
> V4: - Remove the recursion prevention from the callback functions
>        => The recursion prevention will be generally solved in the
>           callback function call in a separate patch
This has to be the last patch because it only works correctly with the 
last patch applied. If the ordering is not correct, git bisect will not 
work correctly either.
