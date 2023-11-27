Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA54C46CA0
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 15:59:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68BEE8764C;
	Mon, 27 Nov 2023 16:59:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=nic.cz header.i=@nic.cz header.b="pLEiMgsn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D247987743; Mon, 27 Nov 2023 16:59:05 +0100 (CET)
Received: from mail.nic.cz (mail.nic.cz [217.31.204.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20A5B87538
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 16:59:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.behun@nic.cz
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
 by mail.nic.cz (Postfix) with ESMTPSA id 391EF1C1922;
 Mon, 27 Nov 2023 16:59:00 +0100 (CET)
Authentication-Results: mail.nic.cz;
 auth=pass smtp.auth=marek.behun@nic.cz smtp.mailfrom=marek.behun@nic.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
 t=1701100740; bh=fwO2YoWAnBU/Ho58y9E9oovDURP6ziUJ7BvN4lPCYxU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From:Reply-To:
 Subject:To:Cc;
 b=pLEiMgsn6bu4pq2unemAtqLRRbNVMeKcIiSkcannqKlp9Nn8B5Z943CjcwzUWoleh
 c6ebi9Xb9+N7HFM72QZTuXrdlS/rTsspREuSfrrXm0L3UIGCQUyiAYTsVC/ap/KxMy
 y8xrWJlyCjibl7XCG/vs+ZzZVGX0MLtrhEBtF6UA=
MIME-Version: 1.0
Date: Mon, 27 Nov 2023 09:59:00 -0600
From: marek.behun@nic.cz
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 trini@konsulko.com, goldsimon@gmx.de
Subject: Re: [PATHv11 28/43] configs/turris_omnia_defconfig: enable LTO
In-Reply-To: <20231127125726.3735-29-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-29-maxim.uvarov@linaro.org>
Message-ID: <b8812391be694a24543af07b0461f912@nic.cz>
X-Sender: marek.behun@nic.cz
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 391EF1C1922
X-Spamd-Bar: /
X-Spamd-Result: default: False [-0.10 / 20.00]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_NO_DN(0.00)[];
 WHITELISTED_IP(0.00)[2001:1488:800:400::400];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
 ASN(0.00)[asn:25192, ipnet:2001:1488::/32, country:CZ]
X-Rspamd-Pre-Result: action=no action; module=multimap;
 Matched map: WHITELISTED_IP
X-Rspamd-Action: no action
X-Rspamd-Server: mail
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

On 2023-11-27 06:57, Maxim Uvarov wrote:
> Decrease allowed binary size to fit lwip code.
> u-boot-with-spl.kwb exceeds file size limit:
>   limit:  0xf6000 bytes
>   actual: 0xf8600 bytes
>   excess: 0x2600 bytes
> 
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  configs/turris_omnia_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configs/turris_omnia_defconfig 
> b/configs/turris_omnia_defconfig
> index afcd4a1eb7..4e965c795a 100644
> --- a/configs/turris_omnia_defconfig
> +++ b/configs/turris_omnia_defconfig
> @@ -118,3 +118,4 @@ CONFIG_USB_EHCI_HCD=y
>  CONFIG_WDT=y
>  CONFIG_WDT_ORION=y
>  CONFIG_EXT4_WRITE=y
> +CONFIG_LTO=y

The last time I tried enabling LTO for omnia, the mvneta driver stopped 
working correctly. So this first need to test everything thoroughly.

Marek
