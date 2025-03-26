Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202BDC36005
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 01:47:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7845A8186D;
	Wed, 26 Mar 2025 02:47:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742953651;
	bh=qeA+bjGNo9qf63UPdl6lxB7uZMmHV643cqWKQIwVAIU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sb7D2pYwX5zfS8UgzcCJzz9PIg16QdAhHwl7EkoasdR3MB+aTyxd+/B7rhQQpn03g
	 iaeoKrdCD+yMbLiWkgBgKJF64K/GBLUUKtvuRnaeXjOftrAdR0TitkTrbMHcEbAW9L
	 oXgiecAzBwTDRfCJENpa9LHpCRCuvDdP4Zd8/+AgWpWonzWSIfU7nayYtQAvsVGXUr
	 CNAAjskqS5fNYoC8YTr1E4fsHMS+85NMPtAFlvVo+mDRfkc3Uom885XKFHs9haknXv
	 5gHq2e9cuzeXRiXBD3o9Xaag7biGEFD+ENm4vKfpRb95HxzQudSGhHYpeCLAs6q59c
	 glE92vAgAv92w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6AED8083E; Wed, 26 Mar 2025 02:47:29 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA6C08192A
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 02:47:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="dOqYdhjk"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2B60C1026C8B9; Wed, 26 Mar 2025 02:47:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742953646; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=qeA+bjGNo9qf63UPdl6lxB7uZMmHV643cqWKQIwVAIU=;
 b=dOqYdhjkIAigBCN3jPisX3EUFMxtaed3uGYsdlB7qaIIcjBOKgyJibKehvkWs6Bien1Qpc
 RaH3uv7/riOgd4j3lrezEQdV2ocSZY0rBAJSfYP9GJ4ThEpTtQIniOzS7tLowEHTKTLDaL
 343K4CPSfeFda7HM0slgwMbZpggXsn9/oeHjWLytvvyW+txE9UtkJ7cBj9kz5hrg1bHtj5
 L6j3kwH2+DXArhHXe3D3ptqFwRyScRbP2WliVT/m1H1Cit0p+c4lQYUiADf4n4rIl3xsBb
 v4z6fYJ/jfUOerlBDwzirUt6O4k8YhH9fVJin6h9g4rXzJrqpIdU/vKuwn06Bw==
Message-ID: <a84f63fb-61c2-4f0e-89ed-8046e8eeed85@denx.de>
Date: Wed, 26 Mar 2025 02:24:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/19] pinctrl: nxp: add a pin controller driver based
 on SCMI pin control protocol
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, =?UTF-8?Q?Lothar_Wa=C3=9Fmann?=
 <LW@karo-electronics.de>, u-boot@lists.denx.de,
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
 <20250321-imx95-v1-2-f2c8ba815f89@oss.nxp.com>
 <a180b7e6-6978-4814-97ff-05e34223938f@denx.de>
 <20250325080614.GC27303@nxa18884-linux>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250325080614.GC27303@nxa18884-linux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 3/25/25 9:06 AM, Peng Fan wrote:

[...]

>>> diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
>>> index 7abb2a6f36b..279ebbad440 100644
>>> --- a/include/scmi_protocols.h
>>> +++ b/include/scmi_protocols.h
>>> @@ -24,6 +24,7 @@ enum scmi_std_protocol {
>>>    	SCMI_PROTOCOL_ID_SENSOR = 0x15,
>>>    	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
>>>    	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
>>> +	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
>> If this is the IMX specific pinctrl protocol, please make sure to name it
>> accordingly , SCMI_PROTOCOL_ID_PINCTRL_IMX or something .
> 
> This ID is generic ID, not i.MX specific.
> 
> i.MX SCMI pinctrl follows ARM SCMI spec, but i.MX pinctrl bindings
> are different compared with ARM SCMI generic pinconf bindings, so we
> need a separate driver for i.MX.
But then, why is it using the same protocol ID ?

And I feel I asked this question multiple times now, please do include 
this information in the commit message .
