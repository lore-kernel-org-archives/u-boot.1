Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9200C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 20:01:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D1CA80714;
	Wed, 15 Jan 2025 21:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736971293;
	bh=DXAmOFJ7fEXXBRSn3nEbV5c02Zd8GbqAcYkcqa3OYo0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EnTL9Nd0+Uaf8tawjNMECFKH96puTd7kooNILORM2rvc96nhW+aQTOeCyTDDo7wKf
	 mrXUYtjB996Fiiqv4gnpwjSITrtGWma3jLsdNWOIIG5y3UHHJthjOgR/iUKGkTvDNS
	 jIiYkJL3j1J1ptu4QdpXS5rgWJ0L5GC8+SXUPJ+S5IFasW3MgGCr5UqOPwFBZcl5sj
	 +RmnwKgdkIl+7uAAPHBsgIKV/b/gc+4wzjyiMWpH6dKCC/DJMXq0Y45v+CzF/E0/jG
	 OZVdVTxbTb/58mdneVe08ARTBu+xFhgkVzYVLTR/QJg4QHs5PDhh5DHSy5UXDz15l1
	 qkhypDVRO43Qw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5FE4806FB; Wed, 15 Jan 2025 21:01:30 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0F038060C
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 21:01:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Llz475jw"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 972F8108882FB; Wed, 15 Jan 2025 21:01:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736971288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DXAmOFJ7fEXXBRSn3nEbV5c02Zd8GbqAcYkcqa3OYo0=;
 b=Llz475jwlCMZ5gVr63KIq01G28WZAv9CdnEgMCU1uctSbWuu2SCBVqrnAql/Y0YFTM6StG
 g1TX6cmGgmB4gZBhwZvk6gnqCZk7c2fkZ2LUkXQdkCkjsDVnJ302HkO5hx0wdsVTouAA14
 uMy5J7dAMPZxnMu/iio48qc9nM9BtaI7MnIN3TRuGWUY/eG1J593zk5KlEUxplT7dk+YgC
 nhoN2tiW12eM9q/tmrDndA8KFB3+SkfVeEwccF3WZClauREvS1OEvytt/4lxy8j63Zgd6I
 An3qduePySQEsbC/HiVpn85vTvv/X0UzPKSZEWi8pr+JCns46gcfMHsIEhFi1g==
Message-ID: <21b58bc6-df13-4639-86e8-8f44c6439e5d@denx.de>
Date: Wed, 15 Jan 2025 20:29:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] dw3-generic: Add dependencies whith SYSCON and
 REGMAP
To: Patrice CHOTARD <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sjoerd Simons <sjoerd@collabora.com>, Tom Rini <trini@konsulko.com>
References: <20250114144528.1612168-1-patrice.chotard@foss.st.com>
 <20250114144528.1612168-7-patrice.chotard@foss.st.com>
 <de9e66e1-ab5a-4d46-9ec9-b19627f4ea9b@denx.de>
 <cbb93a24-4b4e-4254-b031-39c1abfa67ba@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <cbb93a24-4b4e-4254-b031-39c1abfa67ba@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 1/15/25 11:43 AM, Patrice CHOTARD wrote:
> 
> 
> On 1/14/25 15:54, Marek Vasut wrote:
>> On 1/14/25 3:45 PM, Patrice Chotard wrote:
>>> Since addition of STiH407 support in dwc3-generic, SYSCON and REGMAP
>>> support are needed.
>>>
>>> Add dependencies with SPL_REGMAP and SPL_SYSCON for:
>>> qcm6490, imx8mp_evk, phycore-imx8mp, librem5, qcom,
>>> xilinx_versal_net_virt, amd_versal2_virt, xilinx_zynqmp_kria
>>> xilinx_zynqmp_virt.
>>>
>>> Add dependencies with SPL_REGMAP and SPL_SYSCON for am57xx_hs_evm_usb.
>>>
>>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>> Cc: Marek Vasut <marex@denx.de>
>>> ---
>>>
>>>    drivers/usb/dwc3/Kconfig | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
>>> index 0100723a68b..ef82a3e9626 100644
>>> --- a/drivers/usb/dwc3/Kconfig
>>> +++ b/drivers/usb/dwc3/Kconfig
>>> @@ -26,6 +26,10 @@ config USB_DWC3_OMAP
>>>    config USB_DWC3_GENERIC
>>>        bool "Generic implementation of a DWC3 wrapper (aka dwc3 glue)"
>>>        depends on DM_USB && USB_DWC3 && MISC
>>> +    select SPL_REGMAP if SPL
>>> +    select SPL_SYSCON if SPL
>>> +    select REGMAP
>>> +    select SYSCON
>> Why was this not needed so far ? Or is this a bugfix ?
> 
> My comment lacks of detail.
> By adding stih407 support, i am using syscon_regmap_lookup_by_phandle() which
> need that REGMAP and SYSCOn support are enabled.
I suspect this will now be specific to the stih glue driver , right?
