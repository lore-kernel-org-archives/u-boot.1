Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FDEE810CC
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 10:55:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D285686D7A;
	Wed, 27 Sep 2023 12:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="OGOeXlFP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EEFB86D80; Wed, 27 Sep 2023 12:55:00 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D54B86CC9
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 12:54:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
Received: from [192.168.0.125] (unknown [82.76.24.202])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id C0E7A6603102;
 Wed, 27 Sep 2023 11:54:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1695812098;
 bh=ZW33GXAUpDCHzVYY5MvwUzHtz58VxDbRRoLgfR+V730=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=OGOeXlFP0XE1AS+SES5bxlN5qQlhqjbgXnRZ/ZWi9XUZa+ui6FriT7EvERhxEGBXt
 NZHMn19P4JEdDLg3gGIuZ6f9Xxiu6Ylu2TiDDv65Kz9+iTidPKfrZ35Zx7MbOepdiX
 JyMUA+FB/yguk3EEKiDkUvkNl+XSq2fjqfSO1Fm/a60CaD86DOJlBpaupwmtZLjwdN
 I477kOxpgPtRKgARioCWTK+lJvzXZ22iYJgz5cT3mL+GJYgTmwYiU3o5UL6rMw8tQf
 dHJB+SEeJFrZU8xiJzXFBa0GkG84jX+QL/424cIuqMpaNJ/ZSB28BCdz3e12ufqWM7
 t7kGfyeN+nnag==
Message-ID: <d29c79cd-2551-9674-24ac-858b2de94851@collabora.com>
Date: Wed, 27 Sep 2023 13:54:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Enable thumb on AT91?
Content-Language: en-US
To: Sean Anderson <sean.anderson@seco.com>,
 Eugen Hristev <eugen.hristev@microchip.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Aubin.Constans@microchip.com
References: <4c2dec59-dd2b-049b-9a4b-71c437234ed6@seco.com>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <4c2dec59-dd2b-049b-9a4b-71c437234ed6@seco.com>
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

On 9/27/23 01:15, Sean Anderson wrote:
> Hi Eugen,
> 
> I noticed that several AT91 boards are quite close to their SPL size
> limit. For example, sama5d27_wlsom1_ek_mmc is just 173 bytes short of
> its limit and doesn't even git with older GCCs. I looked at the
> datasheet for that processor, and noticed that it has thumb support.
> Have you considered enabling SYS_THUMB_BUILD? This shrinks SPL by around
> 30%. I don't have a board to test with, so I don't know if there are any
> technical reasons blocking this.
> 
> --Sean

Hello Sean,

Thumb should be fine for the AT91 architecture.
+ Nicolas and Aubin in CC.
The change would require testing.

Eugen
