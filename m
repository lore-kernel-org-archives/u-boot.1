Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D176BCD484C
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 03:04:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E47908467B;
	Wed, 13 May 2026 05:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XQFAtHGM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC18684663; Wed, 13 May 2026 05:04:33 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BD4B84255
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 05:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gFdbd1mcfz9tCL;
 Wed, 13 May 2026 05:04:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778641469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EwynS6gQBNEzrvLfrausRWFr/MIw4VvFPYfKq0xhRhg=;
 b=XQFAtHGMKEe7l4rEQqLcqzQDPSSXVuLN1uj57/abKY95r3/1Sh6iTV+He4RgC+nhskoaZK
 zWDgBVTGJ8hOWLSGN5URQ+JLNro7KvGd0sGtDjcdg8Yjf01g44dBxJ6BVYoTxI0mCdTnEA
 /Ki1C54lLI8p68hNYg7/y/rlOn6w6TK/JXCKlH/I0iGezXIUALKWLJ3zjoKrC7CLK7b/Pr
 y4d3aRi6aswredMM0rLGBVgdPZJleFjRTlSca99EexGoiyjRI2zBkMpUF9m9k78/syGH3H
 BVjYVnMxG5y/4G8GgMFrgbKcd2M+rIy/LIRQjB+WCxTQMNFo5AE3Ce/WX+sL0w==
Message-ID: <7c6bf6e0-45c8-4220-99e5-3d75b51253e4@mailbox.org>
Date: Tue, 12 May 2026 16:36:04 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] usb: onboard-hub: Add support for Corechips SL6341 USB
 2.0/3.0 hub controller
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>
References: <20260512-sl6341-v2-1-fd5fc55e1f38@flipper.net>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260512-sl6341-v2-1-fd5fc55e1f38@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 1ibm5ix1e1xtzmp1o798xmkzko64h3s7
X-MBO-RS-ID: b9dc22765d6e0717796
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

On 5/12/26 3:55 PM, Alexey Charkov wrote:
> Corechips SL6341 is a 4-port USB 2.0 and 3.0 hub controller. It always
> requires external 1V1 power and can optionally use external 3V3 power
> (or alternatively it has a 5V->3V3 LDO built in to derive 3V3 power from
> VBUS). It also exposes a reset pin.
> 
> Device tree bindings are merged for upstream release with Linux 7.1 as
> commit bfcb86e58f3a ("dt-bindings: usb: Add Corechips SL6341 USB2.0/3.0
> hub controller") [1]
> 
> Link: https://github.com/torvalds/linux/commit/bfcb86e58f3a58d05b95970d81b94cb011982780 [1]
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>

Thanks !
