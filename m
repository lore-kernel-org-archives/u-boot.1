Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F50C2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 15:30:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFE6D883BB;
	Tue, 18 Jun 2024 17:30:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718724619;
	bh=bnXSq4qgYCeDiG2el3QtpR29POX0rdfR6AvVfB7SxT8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GheQWBlgIENvvRmaeG/1kSyQWAOkcQz8o8ReVRJaGSPTnTKqTdMHO8OdOwpMGyCRx
	 vrRYlJX4yqoi0p3jif0nSBQhuYTmeo8Qc7mAuMMuHkn1ZlHtmQTRlRkSd4yEy+0Qq+
	 YsZnpV//Lprr9U614mQKCYG0YNxHEoEk996px/U9bvm6XUv5B7QVL0HqujR4nAaQSg
	 U2DeX8Vjt7oT6LJ52J0XhtWEbNY7+8lUH1okJRh+pWuZSATe/jeIXt8he0hFpDiSUs
	 /AZNdjOBRzhbX9S9sbynSqKy8ktj6QG98exDL9wRtXFcR76PHpZ5yL/+eG6jbC3SLY
	 ApInESPMWvHXw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9AE798838E;
 Tue, 18 Jun 2024 17:30:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1718724617;
 bh=bnXSq4qgYCeDiG2el3QtpR29POX0rdfR6AvVfB7SxT8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=M6fNbCu3XgdMVPnc9P74vm88g6WAe69OE/3joYNIFLV+zfBNakExeX25bvbEIPq5X
 5+7Vrcus2173zxvH4OxhP0Bn6YsAv8Hw4MF+aUMrpgsvxlAiprdU/kFU/0K3umEVF+
 lHivB+4FSNomwpw6+aFONIHFUnxifWyQvzX7rfjT7Bbpfjm4LSrLl3rD8u2YcR2R6l
 LtAdTlfFbHEzbTY0npyW96a0FEUGUIJDXCdf/pztPX9p7ycebEcEq5kJfjIy2SgraP
 h0pwgo5iKZqbu5KoJAsyMitKSCB7g/zjfiJpsQ6PJavXKVxv+1512fOl3vSFHPFV8d
 PBms30EO2TMWA==
Message-ID: <54c7dcab-8925-4b20-b455-413a9bee8fda@denx.de>
Date: Tue, 18 Jun 2024 16:56:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] phy: meson-gxl-usb2: remove
 phy_meson_gxl_usb2_set_mode
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org>
 <20240618-u-boot-usb-gxl-phy-set-mode-v1-3-6b41efa46e35@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240618-u-boot-usb-gxl-phy-set-mode-v1-3-6b41efa46e35@linaro.org>
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

On 6/18/24 9:55 AM, Neil Armstrong wrote:

[...]

> @@ -205,7 +188,7 @@ static int phy_meson_gxl_usb2_power_off(struct phy *phy)
>   struct phy_ops meson_gxl_usb2_phy_ops = {
>   	.power_on = phy_meson_gxl_usb2_power_on,
>   	.power_off = phy_meson_gxl_usb2_power_off,
> -	.set_mode = _phy_meson_gxl_usb2_set_mode,
> +	.set_mode = phy_meson_gxl_usb2_set_mode,

Oh, I see you did rename it here, so please ignore my comment on 1/5 . 
Maybe just mention in the 1/5 commit message that the rename is 
happening in follow up patch , if you are doing V2 at all .
