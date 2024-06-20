Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20302C2BA18
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 11:59:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2095A88548;
	Thu, 20 Jun 2024 13:58:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718884733;
	bh=Ckv938oyX0IOVxDn0bJFGF+At0up/fn1D3tp9a0koZY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SOIWYlqY59I7XViyKgtwfd0h9UP+aQgfUHYhR2hCT2FzEBdroXW70sl2PUpEEN+qe
	 ay0tyh0OOEMpwAZj+LmnL6IfwKp2/IYUvujL9fkHUpAmCzLV/HgEP9+JZsjOVfOV7g
	 0V3i2K/NXt3VqAgUJPscPObuKSRDlZ0kbJtST4S/dNk00jlZ+awEJHhyzcd7ZDBHda
	 QphQskdE9iVfbaCM7ZBl98oioTh6KtRC8gTSU7kCBrjFhoZ7/s2jjD5OsXsv9Lpfzb
	 DH1fO2ieAIRgRdcWkqjqxP+feLLKSWZpPPJOBLMFGWb8eVQtV2chEFQImAkTAdhF/U
	 HfpRxpXyLqQaQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 94BCB883A6;
 Thu, 20 Jun 2024 13:58:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1718884729;
 bh=Ckv938oyX0IOVxDn0bJFGF+At0up/fn1D3tp9a0koZY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=y7uW0dH7u9Y4lR5lVOe/wahs3puyr5cESe9fc8b3VOaoDNMsoM1omI1d/6c8ZwsC1
 f0fK9O2lncY3v68AV/QAX51kI6saQstvDVxm2iyMLTc9un/gH6DL4sH3xTmy6PSvYG
 aXoPvBXzLKs5cvtp8ENqOrRSR0ilUoAkFGus/kg20ISaiJgOtwYaqcLjldmTF4IZ1T
 2b7FacDG7KA1WoBX6f22lrZMDMl7c7PYkii//OIkq7dUDgyoxhiywlMGeAgrWXYO9X
 pfY4z0/YXSF6GX8H7Rv5gbZtYvNGNO6p3+JYN9FxTKxHYnkYSl5MUDcHePUib5LX4B
 5RnqXkMg0qepw==
Message-ID: <e4dc1747-d381-4ff1-9302-c1a0c171a6f1@denx.de>
Date: Thu, 20 Jun 2024 13:54:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] phy: meson-gxl-usb2: remove
 phy_meson_gxl_usb2_set_mode
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
 <20240620-u-boot-usb-gxl-phy-set-mode-v2-3-b81c027bc02c@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240620-u-boot-usb-gxl-phy-set-mode-v2-3-b81c027bc02c@linaro.org>
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

On 6/20/24 9:42 AM, Neil Armstrong wrote:
> Remove the public phy_meson_gxl_usb2_set_mode and move
> the implementation in the the set_mode callback.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Marek Vasut <marex@denx.de>

> -static int _phy_meson_gxl_usb2_set_mode(struct phy *phy, enum phy_mode mode, int submode)
> -{
> -	if (submode)
> -		return -EOPNOTSUPP;
> -
> -	switch (mode) {
> -	case PHY_MODE_USB_DEVICE:
> -		phy_meson_gxl_usb2_set_mode(phy, USB_DR_MODE_PERIPHERAL);
> -		break;
>   
>   	case PHY_MODE_USB_HOST:
>   	case PHY_MODE_USB_OTG:
> -		phy_meson_gxl_usb2_set_mode(phy, USB_DR_MODE_HOST);
> +		val |= U2P_R0_DM_PULLDOWN;
> +		val |= U2P_R0_DP_PULLDOWN;

btw this could be a one-liner val |= macro1 | macro2 ;
