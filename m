Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C762CCFA1A
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 19:47:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9049383F26;
	Sun,  9 Nov 2025 20:47:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IBvUDG9b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDA1383F2F; Sun,  9 Nov 2025 20:47:08 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 108E183F24
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 20:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4d4Nbs0lmZz9sqV;
 Sun,  9 Nov 2025 20:47:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762717625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jmMxZpFRrtWmqwzLqxkjGOXy6R01ZHnjwHYyxGg9i/o=;
 b=IBvUDG9b2tPlVUiY1ulPMxGnSP1MvQIGsJrE3NAdg+W3kKEPVL0se8Kdjt/mcIezPWUMUI
 urbjXaMMeePPO/FMshR1kfFO7VrOK91LQhUadq4L5trKI68IuMsqAydEtmXuT1uPbxFLHV
 WrXJkcE9mc/IyiQNS8k22dowXiUY6gGmueL20B/aFzgzQ3iKYmQ+AirAdebTa3+rmCyIXA
 E8AZ6hjk719Cplu/m8WZ2g4bXWXIJa7bXIjcYUnUmmnNrTe7VPfV/POC1iz/4CGU0lExP9
 MYFSW6wzLgXD0gaRLgZksQWKZuCG3zNwh5cFX43hLxYU6c1czh/oAHEbBMLpzQ==
Message-ID: <47e110a8-dbf4-4a00-b35d-72ad69d4d7a6@mailbox.org>
Date: Sun, 9 Nov 2025 19:55:06 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/3] Image size checks: Clarify help texts
To: Philip Oberfichtner <pro@denx.de>, u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>,
 Ye Li <ye.li@nxp.com>
References: <20251015012320.2331007-1-pro@denx.de>
 <20251015012320.2331007-3-pro@denx.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251015012320.2331007-3-pro@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 4ef6c95c4e1cebda028
X-MBO-RS-META: 7phu56xn6o6ujexac3thn9k9gjh969e5
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

On 10/15/25 3:23 AM, Philip Oberfichtner wrote:

[...]

> @@ -550,8 +550,8 @@ config BOARD_SIZE_LIMIT
>   	default 1048576 if RCAR_64
>   	depends on HAS_BOARD_SIZE_LIMIT
>   	help
> -	  Maximum size of the U-Boot image. When defined, the build system
> -	  checks that the actual size does not exceed it.  This does not
> +	  Maximum size of the U-Boot image. The build system will throw an
> +	  error if the actual image size exceeds this value. This does not

Simply keep the original text with "check" keyword in it, and drop the 
"When defined" part, since this is now gated by the HAS_... symbols, 
then reuse the same for SPL/TPL/VPL :

"
The build system checks that the actual image size does not exceed this 
value.
"

or this if you want the error out part in there:

"
The build system checks that the actual image size does not exceed this 
value, and fails the build if it does.
"
