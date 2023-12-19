Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433F2C46CA2
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 09:38:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8115386E65;
	Tue, 19 Dec 2023 10:38:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=nic.cz header.i=@nic.cz header.b="NsMwKYod";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9016586EF3; Tue, 19 Dec 2023 10:38:37 +0100 (CET)
Received: from mail.nic.cz (mail.nic.cz [217.31.204.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84EFC86E5E
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 10:38:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.behun@nic.cz
Received: from dellmb (unknown [IPv6:2001:1488:fffe:6:8747:7254:5571:3010])
 by mail.nic.cz (Postfix) with ESMTPSA id 6FBA81C186D;
 Tue, 19 Dec 2023 10:38:34 +0100 (CET)
Authentication-Results: mail.nic.cz;
 auth=pass smtp.auth=marek.behun@nic.cz smtp.mailfrom=marek.behun@nic.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
 t=1702978714; bh=Bict+13vvTDCGRglCOdA+0zcsBKQCsP9AFZ6E72giGs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From:Reply-To:
 Subject:To:Cc;
 b=NsMwKYod+7shdA51GEUzwN9wQoYR082KQwCSsHDdTYJdJPgO7kyOqAbxE91xF/fNC
 RJwl1k0guDdAl30iYPRUb3IxMvoKj5PsvtKrLJVIQF6PMiJwf7vpDG4+gczUvwD4J6
 d2nXdaBw8mTOBUX2DEyJ7eR7z6aA9ohp+klmu7mM=
Date: Tue, 19 Dec 2023 10:38:33 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 trini@konsulko.com, goldsimon@gmx.de
Subject: Re: [PATHv11 28/43] configs/turris_omnia_defconfig: enable LTO
Message-ID: <20231219103833.2c211ae0@dellmb>
In-Reply-To: <20231127125726.3735-29-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-29-maxim.uvarov@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Rspamd-Pre-Result: action=no action; module=multimap;
 Matched map: WHITELISTED_IP
X-Rspamd-Server: mail
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 6FBA81C186D
X-Spamd-Result: default: False [-0.10 / 20.00]; MIME_GOOD(-0.10)[text/plain];
 WHITELISTED_IP(0.00)[2001:1488:fffe:6:8747:7254:5571:3010];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
 ASN(0.00)[asn:25192, ipnet:2001:1488::/32, country:CZ];
 FROM_EQ_ENVFROM(0.00)[]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]
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

On Mon, 27 Nov 2023 18:57:11 +0600
Maxim Uvarov <maxim.uvarov@linaro.org> wrote:

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
> diff --git a/configs/turris_omnia_defconfig b/configs/turris_omnia_defconfig
> index afcd4a1eb7..4e965c795a 100644
> --- a/configs/turris_omnia_defconfig
> +++ b/configs/turris_omnia_defconfig
> @@ -118,3 +118,4 @@ CONFIG_USB_EHCI_HCD=y
>  CONFIG_WDT=y
>  CONFIG_WDT_ORION=y
>  CONFIG_EXT4_WRITE=y
> +CONFIG_LTO=y

I finally tested it and LTO is currently broken on Omnia:

  Missing DTB
  spl_init() failed: -2
  ### ERROR ### Please RESET the board ###

Marek
