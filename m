Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DF9C52D6F
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 04:31:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B486B88905;
	Tue, 27 Aug 2024 06:31:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724733063;
	bh=fdI8AzAfmMNHYexy38p0U09Ebwx12vqCo6arDOrR9q8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pdaHZkAcz3ZIjzFGuJVy60//C6r9ipswr6kDYtTKQLrPkInnsypf3xyXMB9Hr7bMp
	 zuvBWd+FZqgkO8GziqB8n3feAVUGHPoIG90SRc+57n8PjhfiOE+6elQOalhqX6mxYp
	 lazjWHhRNgjOyXX9yEiVcqTFJKkMU2wmgVxpiaWaDh6h9MPj/IlWWyTKwLdss/Ndw4
	 o4GQbbKbsWO/MKV54KXTVW52I9hJWYBdJ2SsUIBIRcJYP5Ybz9I3/s1zsfRha9zffV
	 dJPTP4xCUKEzO3JUN+RncyGkfG4IW1LdPAzrWIcygWEt2+yQgainrGk6+28nPovpBF
	 ECzI/tOtMLlqw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2ED6488770;
 Tue, 27 Aug 2024 06:31:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724733060;
 bh=fdI8AzAfmMNHYexy38p0U09Ebwx12vqCo6arDOrR9q8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=eL/Y6Do+VxEbpEIejiOeSrtTd03Tr0/EXS0XNjt/l8j8UA9yB1Uk87M+cpCMTjsar
 Nkmep1TmXvXGfCKuX9wVKpAgzba48NEByFq0mvYhirNWw/dfOxgDnhY2XkfkAuyB4M
 8Wa+mFgAxB70FCW39yJ5ZzBkq5vDDsirxeMArBGM0lYrCxlc9Tj8330GdqftL27675
 KByEsClMRmQrOSauRYEY0p99gF4teRTjTNrqHYJPUqfFFHhlrYBVNLAHtXmFPBBsFj
 iVzFT3Xu8prOdrgxIYh6YgXB4ClfihS6+U5wNrglSvNhJmgkOnrYGkQ3Sc/rGpzLwJ
 rOMzc/up1tFgw==
Message-ID: <b0c8170d-ba6e-4806-a3d9-c9f07f30b2ff@denx.de>
Date: Tue, 27 Aug 2024 06:30:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] imx: Remove CFG_MXC_USB_PORTSC
To: Fabio Estevam <festevam@gmail.com>, peng.fan@nxp.com
Cc: u-boot@lists.denx.de, tharvey@gateworks.com,
 Fabio Estevam <festevam@denx.de>
References: <20240827005826.2831478-1-festevam@gmail.com>
 <20240827005826.2831478-3-festevam@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240827005826.2831478-3-festevam@gmail.com>
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

On 8/27/24 2:58 AM, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> '#define CFG_MXC_USB_PORTSC     (PORT_PTS_UTMI | PORT_PTS_PTW)' can
> be removed from mx5/mx6/mx7/mx8m board config files as it is the
> default in drivers/usb/host/ehci-mx5.c and drivers/usb/host/ehci-mx6.c.
> 
> Suggested-by: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Marek Vasut <marex@denx.de>
