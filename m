Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8B1C27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 11:59:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAE3688556;
	Thu, 20 Jun 2024 13:58:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718884733;
	bh=iMYZ7AyvnAjnmK4jFlPoEiQ3G4HC+zPhuy1Mpmz4D9E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YYVGB301VJZqfS43tCIccVAenCISf0cEWVgCYriJHa3bnQuuOoqduhD8BUzxfzKiI
	 /7U45/kEAEsoLhf1+BSSLXLzbHlPLUlM3ccoUbrFfBkeh1G4EzyeKevGGMyYK5xTCP
	 izXXbuEURSAk88zaBkb47nAyG2tSsDAnDZ2Wl3weiEx0Mwpu2IVnEspHWxXLxsCWK2
	 u8/3MWlYxtsibsG58Cs4m2kj6w3rlmEmsmj2r0SK34VDTAI/k4ZuS9Kc1VcHgd0TZG
	 4aHf885GN3OMfoaLbOWxkpanpUKRJrbATgiDfkdeps+063D/VPqfGGRRrLUD74huNV
	 kuBuHMJGYcrHQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C578687EBD;
 Thu, 20 Jun 2024 13:58:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1718884731;
 bh=iMYZ7AyvnAjnmK4jFlPoEiQ3G4HC+zPhuy1Mpmz4D9E=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=OmGDnSjBVV7HxdG60D3H75yScObu1m/NXahI1S6aXD+kaxLAqoYqt8MXiMaMLfKnC
 h5q3aIFLeaSPM3oL8Z7cD8eL+rDJGvpjDRigsX8s5ZAP2icurjzW9AAMwrhfBHF8bL
 ScZMvQAUR853FApQQnxknEYUtCPvX5rA2js7z5Uh+vQhlFKrJQkbm0rnbeCnGm3vug
 eOG0NVf3UgYmdCPPIkaPim5/IY0z44RXPmfnboXTzXI/Wu1pYZ1kYXUCjFMDrUv7mB
 TRxk7oAquoTmq17KhtLUX429ncyC8Lza6XP16e+wbchJN5PIDPgJfmiD/UOcjYhJZT
 4nZ9KtqH5iJ2A==
Message-ID: <d6a99eaa-d856-4806-a985-3daac32438d9@denx.de>
Date: Thu, 20 Jun 2024 13:54:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] usb: dwc3: meson-g12a: drop usb.h and make
 dwc3_meson_g12a_force_mode static
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
 <20240620-u-boot-usb-gxl-phy-set-mode-v2-5-b81c027bc02c@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240620-u-boot-usb-gxl-phy-set-mode-v2-5-b81c027bc02c@linaro.org>
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
> Drop this useless usb.h and now make dwc3_meson_g12a_force_mode
> static since only used in the dwc3-meson-g12a.c file.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Marek Vasut <marex@denx.de>
