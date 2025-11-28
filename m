Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E412D116EA
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 05:09:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEDCF83B9D;
	Fri, 28 Nov 2025 06:09:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uKlXhFl7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C66EF83BA1; Fri, 28 Nov 2025 06:09:23 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A38C283B8C
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 06:09:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dHhDC6KLwz9tMq;
 Fri, 28 Nov 2025 06:09:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764306555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RP2YVVawQw1VGLegHC9FQqubbAPOOF8lBlJkSw1bZAo=;
 b=uKlXhFl7nOYmBg4EdL5hUGzhqxJ77n2gdIh/hlrCGFpqYruiGewXTA3Yb/6aiD43o83bY8
 neeWKBfsDZDy5+GkdSNb5zgfhNHTCjXYQyyBMrjGF6+IzZBvxZQVIVK+7Cw5797qwRYEMc
 Lud6qG5QQeeN8BkM07/E43FuZtNH9hE/fkWfA75o3Y9VWX7wdbrZ6uTgbUEy6EH+j7wpYu
 x8Raa47RkEWjf3R3KcG3eQQMcZIxJsBykh/QiRhMVIGo3Lep3DHyVbhk0GkHBcXXJKr+EY
 qfjMsp8Vd2cZsGclu2jirynQr51JMG9Yc9HRqjmJCFiKYsNngN7xa6Za2wkbzg==
Message-ID: <b44cb7cd-1c07-477c-8233-03d029266b7e@mailbox.org>
Date: Fri, 28 Nov 2025 06:09:12 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] imx: container: Eliminate IMX_PQC_SUPPORT
To: Ye Li <ye.li@oss.nxp.com>, u-boot@lists.denx.de
Cc: fedor.ross@ifm.com, =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <joao.goncalves@toradex.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
References: <20251127192633.79935-1-marek.vasut@mailbox.org>
 <3da2565f-523d-47df-8202-0624bf0a445c@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <3da2565f-523d-47df-8202-0624bf0a445c@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: adadfde1df0cf05de31
X-MBO-RS-META: e4qdkh33na7wdrf7rgi3jshmadxe5et6
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

On 11/28/25 4:26 AM, Ye Li wrote:

Hello everyone,

>> +static inline int container_hdr_alignment(void)
>> +{
>> +    if (is_imx94())
>> +        return 0x4000;    /* PQC */
>> +
>> +    if (is_imx95() && (soc_rev() >= CHIP_REV_2_0))
>> +        return 0x4000;    /* PQC on i.MX95 B0 and newer */
>> +
>> +    return 0x400;    /* Non-PQC on i.MX95 A1 and older */
> 
> 
> I understand you want to use single uboot and spl image for A0 and B0. 
> But A0 is not production. Only early customers get few A0 samples. NXP 
> marketing has notified these customers to replace A0 to B0. Are you 
> still using A0 board? Is it necessary to do such change as we want to 
> remove A0 to simplify the codes?

I have both A0 and B0 device.

I do not see why we need to have a Kconfig option for something we can 
trivially auto-detect, hence this patch.

> Eliminate IMX_PQC_SUPPORT config is not a good way. When adding new SOC, 
> developer has to update the container_hdr_alignment, then it will be a 
> long list in this function. Actually only iMX95 is the exception. If you 
> insist keeping A0, I prefer change like below and retain IMX_PQC_SUPPORT.
> 
> #if IS_ENABLED(CONFIG_IMX95)
> static inline u32 container_hdr_alignment(void)
> {
>      if (is_imx95() && (soc_rev() >= CHIP_REV_2_0))
>          return 0x4000;
>      else
>          return 0x400;
> }
> #else
> static inline u32 container_hdr_alignment(void)
> {
> #if IS_ENABLED(CONFIG_IMX_PQC_SUPPORT)
>      return 0x4000;
> #else
>      return 0x400;
> #endif
> }
> #endif
This adds even more ifdeffery and makes the code even worse, so no.

But if you are sure that every new SoC will have the PQC alignment, then 
the condition in this patch can be inverted this way:

static inline int container_hdr_alignment(void)
{
	if (is_imx95() && (soc_rev() < CHIP_REV_2_0))
		return 0x400;	/* PQC on i.MX95 A1 and older */

	return 0x4000;	/* PQC is the default */
}

Are you sure every new SoC (at least in the foreseeable future) will be 
like that ?
