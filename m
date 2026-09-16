Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFC6C982C1
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 04:47:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A24674071C;
	Thu, 17 Sep 2026 04:47:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fJdBVSVn5T8X; Thu, 17 Sep 2026 04:47:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 91F0740723
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789620434;
	b=eVcyVZDkXrdDRDjnI5gkJ4Qb4Xl/0h11SRo06Y44LIqoc8iC781F4gqU49cpomMYI7yD
	 xzjjUkuBeUmClu2xzA2vcuZxVFxJw8KM4OI6Hejt/p5zRbOph1llYVAEwGxgkoeGaFGfI
	 weWHFzO50SasYUePIpwVG8FiBPlKZbaFaEeLXMw5QPrviUB9efMZ6MSHfIhTx0LnfwCw5
	 RopVd2noeavURYU7ZrWZRykkHKDVVrCGqgwDqsnQhIr7qhKfxwdU2KSEuRfSNgsRMu1wR
	 Rr+2t8s79uoQDzz69YS8z+2MrKEteAGleo9ijaWXh5n3GDHhej2ob7QRQpqToRorLnA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789620434;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:DKIM-Signature:Date:MIME-Version:Subject:To:
	 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-Rspamd-Queue-Id:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=w6KMgFp2H/dTAv//bY9YjuQ6cpGpJEKMaqj325g0TWU=;
	b=oXgti+bWyy6bUNBDP3b+H97P4xt4h454ATnkQCZWUvHcUvcjHqvu81ccmKbIi/iw6ZiL
	 AzEQcaJwsQoqESJGYPNMD1IuFeDy3pjjg+sZ2KDngeW7lun6wioZqErcvN1I1XVSKbtaN
	 LibqsAR8vXrKeCz5/WnJZn9+Wc1RUpMP/vsn7pUZmz74ZZ7z+lnwdIU85CynGhnS/aYRh
	 BdZvxaWvthTQl7C7611TMHgsAgpe+mcmLUrrefWkFarHMIuRrivNBVCVYAJSLNdkVhUZ8
	 gakUpK2fVb01eBm0oaaSylH1/C8ok+S/Vj++YYYDw4BMbf+wGScrF+CWokE2oCuob+g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789620434;
	bh=w6KMgFp2H/dTAv//bY9YjuQ6cpGpJEKMaqj325g0TWU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fN8wnkD5Kd9LjqWVrgdd0QVNv1b86XWHsjAKikOsuIHco0zTiMbH5o5ij7C8pk8bs
	 hS12/fD7+CxvFWkatnZpuK217YS9auBj1mUNqB993oCt80xvuvXumhGFwCMOy90oVE
	 PgrCZrW0GtdPiJD7cyMhjnul8Wcni0Rvx4Gq5sLlagRxKzsOEzVxvTkg9WVRFZijl4
	 yEF525yDpiQq+mJty/GN5rNhvHgNtbueMcmMmtacCLiiWMrUQ0UVqsDiCZ0GHqmgXc
	 qhRfTk7PsMkrPRN3g5Mbbq2Bu1ptaVC1hgAxNrUbLt9bv2IVxjLjLG3JIN5AMK+h7/
	 bwhwAJBhgrN6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 91F0740723;
	Thu, 17 Sep 2026 04:47:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D588E2EB
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 04:47:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BBB9C60629
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 04:47:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hvAZc0T0uzaB for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 04:47:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 51A1C60625
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789620432;
 b=oOh9oCLmdDSqXIyhI1N6kIkmufq5cm8nWND4PRWiG9boPw/0AgmU12DPox1TX/XtiXsr
 2LE5guXMYGx8jIB0EuCo/eu0CcazR4bIxgmEVkL9oBMHeWueBbDekOBmuOCBUAKyTV6OG
 Uer9L+qPnagVUi3FXq4WIxEErUClDL9RcWF10Rbc+QSoTpvWGYbmZcQVxheaxnPX7K2yc
 7SiW1vhiNbG55xZ2js1+z0smDjaSzSnZr30JFUzW1HMK4yb6B05vrxV/fi5k5W7Gqh0Lq
 UlcocrMXl/RaX1V4tHHoeu2diODz0URfcJgTbmF5KSaj3FNe6zTM8crPIOhdvmwsmXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789620432;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:DKIM-Signature:Date:
 MIME-Version:Subject:To:Cc:References:Content-Language:From:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:
 X-MBO-RS-ID:X-Rspamd-Queue-Id;
 bh=w6KMgFp2H/dTAv//bY9YjuQ6cpGpJEKMaqj325g0TWU=;
 b=f6T3nF+bhL+zgs/+rM7s0ddQjbJLLybbMCB6IYjsqGDygKXcSpG1NPu2iln2xudO4TQh
 FgNMw8jLoHACEAssZs2A35p7j/L0QJriHDPwDtNI8ZHf/acybU1YjZssE2XawE5+Zw1EL
 9NfFHrSle2toP22FoTO1mjzZkQ3s5QL9ER53qMCJHb6mW+HHxCiMlNvtPqTc4OQ8NY1bR
 z4z+VMONxYcng4oPFZhBBuJb8icDau78HFOL2rlxcEaFAy4mA+ugifBhCvZYk7WppU+Tc
 n6VCFiMCEByofhgr6o2cnRnnl2jq6/OPTJkBQQt5NNE/6Uo3GgKRAX3pgAaCqnqPg7g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=RSlfK3iM; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=dYmXwcST; 
 arc=none smtp.remote-ip=80.241.56.161
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=RSlfK3iM; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=dYmXwcST
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 51A1C60625
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 04:47:10 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hljsR5kp3zKn5g;
 Thu, 17 Sep 2026 06:47:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789620427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w6KMgFp2H/dTAv//bY9YjuQ6cpGpJEKMaqj325g0TWU=;
 b=RSlfK3iMusjcpV9/HQIHNJo33Yzv6YmGIRGB/GNI7sGBpew5XaDzJuZAJu+fDVyV90Evxq
 yMLwAbgjBevfFAb54gDsZjw98V8LIfWH+jFrQVjQJgT3bU4BR2b/01tPtlmAQUA5NB85UM
 bLDIwWQe7nxtstYcIqB7ZVSGdY6meHnQ3yq4s5eA3Wpkn+QwYGnTjWlhiUlrHtM2Ya8AE0
 3k1ttaJc1w3pw4F0pHY0bx1NPsJBLuau6B/GaBtBx3wvHX6Qx3EmYiOF90FSR1dInP6AxD
 aSRaDb8UFTlOnpBXWW9ttUcEsevoakGVkNB1EZutbLBHjOVe1aklkGH9lHhuIQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=dYmXwcST;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <2c5c498e-3aa6-46f2-a31b-202691694fde@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789620426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w6KMgFp2H/dTAv//bY9YjuQ6cpGpJEKMaqj325g0TWU=;
 b=dYmXwcSTSvyylRuY8t4T3561PVSQ2htiXUey5f+Vx3YhVZJ24Wyb0DOatYCN4BR2mWvm1J
 VBs8Z2PwI7wI8lTSmWZ/Bd2PNcTjm1ERplWEvSuHG3BDLgImpStjkJN5NDB2puIPgzqfEf
 /QR9WPZLcaczaE+gS2mFSJZUrhJLx+SgKHN55DvTJP2xKrfA6RY7lFeUYG4xDVmyxMWqBw
 MZbu8MIbdpoWdJ9CGDCOi3z86ndfEab+hCAD7wxBOZDWiLG64bmmpjAUWFb9hakw0weyvh
 F2xwNRlRS4W7vuJHHoTUxuthwHl6YuDMSE7igpIl505SZ7qLNsQh7MYwDM52gg==
Date: Wed, 16 Sep 2026 16:29:48 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/7] usb: skip host-only devices when picking the ehci
 gadget controller
To: Stefan Eichenberger <eichest@gmail.com>
Cc: francesco.dolcini@toradex.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, marek.vasut+usb@mailbox.org, lukma@denx.de,
 mkorpershoek@kernel.org, antoine.gouby@toradex.com, alice.guo@nxp.com,
 stefan.eichenberger@toradex.com, sjg@chromium.org,
 emanuele.ghidoli@toradex.com, franz.schnyder@toradex.com,
 pbrobinson@gmail.com, quentin.schulz@cherry.de, jbx6244@gmail.com,
 ye.li@nxp.com, xu.yang_2@nxp.com, bmeng.cn@gmail.com, xypron.glpk@gmx.de,
 hayashi.kunihiko@socionext.com, sean.anderson@linux.dev,
 u-boot@lists.u-boot-project.org
References: <20260914074314.12522-1-eichest@gmail.com>
 <20260914074314.12522-5-eichest@gmail.com>
 <7afa5ce4-060c-4bde-a820-2a579a0fad12@mailbox.org>
 <aqj6TwcnEeDZGQxb@eichest-laptop>
 <425b3ab2-1d26-4641-8f52-714088a2d25e@mailbox.org>
 <aqqP7P-97FcjXdgU@eichest-laptop>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aqqP7P-97FcjXdgU@eichest-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 8h9gggtmc17gpsjtqc5o3p5quna43urr
X-MBO-RS-ID: 8e51c435d827b126573
X-Rspamd-Queue-Id: 4hljsR5kp3zKn5g
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 9/16/26 2:47 PM, Stefan Eichenberger wrote:

Hello Stefan,

[...]

>>> In this scenario I assume the ordering is correct so
>>> ums 1 would select the dwc3 host only controller.
>> The ordering should respect the aliases enumeration, so ums 0 ... is CI HDRC
>> and ums 1 is DWC3 . Can you check the U-Boot control DT /aliases node to be
>> sure the ordering there is as expected ?
>>
>> => fdt addr $fdtcontroladdr
>> => fdt print /aliases
> 
> aliases {
>          can0 = "/soc/bus@44000000/can@443a0000";
>          can1 = "/soc/bus@42000000/can@425b0000";
>          eeprom0 = "/soc/bus@44000000/i2c@44350000/eeprom@50";
>          ethernet0 = "/soc/system-controller@4cde0000/pcie@4ca00000/ethernet@0,0";
>          ethernet1 = "/soc/system-controller@4cde0000/pcie@4ca00000/ethernet@8,0";
>          i2c0 = "/soc/bus@44000000/i2c@44350000";
>          i2c1 = "/soc/bus@42000000/i2c@42540000";
>          i2c2 = "/soc/bus@42000000/i2c@42530000";
>          i2c3 = "/soc/bus@42000000/i3c@42520000";
>          i2c4 = "/soc/bus@42000000/i2c@426b0000";
>          mmc0 = "/soc/bus@42800000/mmc@42850000";
>          mmc1 = "/soc/bus@42800000/mmc@42860000";
>          mmc2 = "/soc/bus@42800000/mmc@428b0000";
>          rtc0 = "/soc/bus@44000000/i2c@44350000/rtc@32";
>          rtc1 = "/firmware/scmi/protocol@81";
>          serial0 = "/soc/bus@42000000/serial@42690000";
>          serial1 = "/soc/bus@42000000/serial@426a0000";
>          serial2 = "/soc/bus@44000000/serial@44380000";
>          serial3 = "/soc/bus@44000000/serial@44390000";
>          serial4 = "/soc/bus@42000000/serial@425a0000";
>          usb0 = "/soc/usb@4c200000";
>          usb1 = "/soc/usb@4c010010";
>          eeprom1 = "/soc/bus@42000000/i2c@42540000/eeprom@57";
> };
> 
> I think I found what I missed. When I was originally testing it, the
> CI_UDC driver was not a driver model driver, therefore the alias for
> usb2 (alias usb0) did not work. Now with the driver model driver, it
> indeed works:
> Verdin iMX95 # ums 0 mmc 0
> UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0x3b48000
> \
> 
> Verdin iMX95 # ums 1 mmc 0
> UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0x3b48000
> No USB device found
> Couldn't init USB controller.
> 
> So I can drop this patch with the next series, thanks a lot!
That is nice, well done.
