Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7C5C3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 16:21:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58968828A2;
	Thu,  8 May 2025 18:21:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="JGumOdy5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3865828BC; Thu,  8 May 2025 18:21:56 +0200 (CEST)
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com
 [91.218.175.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8625C822D7
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 18:21:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1746721313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HF3qtxM4GkzT4fveHtK2OKQDWeTf7B0vIqVn8VNER5A=;
 b=JGumOdy5Jtv+kWoz7HuxgXYP8LmUdY8CCioAcz7CKXSlPEem1Ium//58jz77RwsZoaesS6
 T6Mo8tTiK0MVH/Hnalc7XrrXJyi33p8nHK3fDO4foDRahyi+KUYPNxjpAosfe0qUQnusTR
 D/m6AXdmMHUcGIfAvun52sDsD9yLeghFWm/jo/g3CFHphwJy6U7ClmGJ6tfa9xrouKGnBX
 bz+n3A95mvzcyhg235MNh38dfWs4ypRLe53WNyT0uboi0+z6fMmBDkmzA92AiNrgDt4vXt
 B2tU2UbvI3Gu4aNRVfk5RC4rMF+f88OAnAzgKm3ukx8cbmdkyinYfRAPbfl/tA==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 08 May 2025 16:21:20 +0000
Message-Id: <D9QX0MRWSYW6.3ELRB73BS6PRT@postmarketos.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
Cc: <u-boot@lists.denx.de>, "u-boot-amlogic@groups.io"
 <u-boot-amlogic@groups.io>, "linux-amlogic@lists.infradead.org"
 <linux-amlogic@lists.infradead.org>
To: "Wayne Schroeder" <raz@chewies.net>, "Neil Armstrong"
 <neil.armstrong@linaro.org>
Subject: Re: Odroid n2+ usb broken on reboot
References: <CAEUiLubXaPGZsE6y_X6mBTD1ZK-2w82fbRD5z8+MKvDZtZKOtA@mail.gmail.com>
 <f073dad7-337e-499a-8cb5-9dae0842de17@linaro.org>
 <CAEUiLuYBVyLm4HgJG88r1J8RcUu38uEVPbV5c+-ArqjU4aUOAA@mail.gmail.com>
 <3783aef0-a7a0-489f-add0-21e1fc2bfad1@linaro.org>
 <CAEUiLubVazb4rgfBd-r-5AtyfBVaMFmy89OO_UZB97FM43if7w@mail.gmail.com>
In-Reply-To: <CAEUiLubVazb4rgfBd-r-5AtyfBVaMFmy89OO_UZB97FM43if7w@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
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

On Wed May 7, 2025 at 1:03 PM UTC, Wayne Schroeder wrote:
> It's hard for me to quantify if usb works in u-boot as I'm not loading
> off of any usb storage devices.  It certainly never lets me use the
> keyboard to abort auto boot, and never has.  On reboot, to reliably

You can send bytes via UART to abort boot, if you happen to have a UART
adapter around.
