Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5AEE77373
	for <u-boot@archiver.kernel.org>; Sat, 30 Sep 2023 13:13:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 029BF86FD3;
	Sat, 30 Sep 2023 15:13:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="GEScnC4w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0B9F87019; Sat, 30 Sep 2023 15:13:34 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32B3F86FC7
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 15:13:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
 s=s31663417; t=1696079611; x=1696684411; i=frank-w@public-files.de;
 bh=SQlqkZ0SeeXLQLn5xpSLU5VB7QBCeuflgwKgmjyRFg0=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=GEScnC4w4mb5t05/Un8iB23ygRl2R1C0A5e1v8gdFBA+aTpIyC/tAZ2lZLD1eVLROQus8YlKveO
 X0IzivuJIzNNiqdiHIwb4nIBLTdzgF8QCfEVB2aL8o9HbXIGutltAVo1x3yOyPkhrCuP5c9Gk/9V1
 /qu0rTRYr2q9nOq2vU3qMZ81G5yEzjDCVSGKiQVnSlgy7LNKvMCyCtgoe4zvEtDJT86U1wJfhGSw5
 T5rrioUyHo5O0uopGFgjCBtBzW/oGKRp17WSH+KGF8SP7Mp5b1bkcsGWWKTEkTTahgnan9P+HaWG7
 SvF43u7teyzufoX/iPAeLULmxJUZjKo26ZPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.152.33] ([217.61.152.33]) by web-mail.gmx.net
 (3c-app-gmx-bs36.server.lan [172.19.170.88]) (via HTTP); Sat, 30 Sep 2023
 15:13:30 +0200
MIME-Version: 1.0
Message-ID: <trinity-bf8ba9b5-b264-497a-b0b2-6af0ff5c1a7f-1696079610910@3c-app-gmx-bs36>
From: Frank Wunderlich <frank-w@public-files.de>
To: Tom Rini <trini@konsulko.com>
Cc: "u-bootlists.denx.de" <u-boot@lists.denx.de>
Subject: github dependabot alert on py / pytest
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 Sep 2023 15:13:30 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:WtbqZfJ5kkOA0Kfhk5TozzoKLBLP2Rb7zUoCZ4w3aYaKZyMu0CbGBJHAUK7lsG26zYpZe
 rT3V3n1kaq7oIJ1+mwQVWsDUnxxDpyy/5i8/aNX6CHrHXCn7wQbWHC4HanL82aI3FLjNZLPBsLZ/
 irU9VYd9qhJXDxNm96kJof73KtZn8/VmY1tVN+9BVeTA3mqv3XiH8MeY+kcowcAMGgCL1zIrgWuw
 wgohYWxUOjbY5JVv4oQm4yGN3lDuDqSLEv2tScq0bFU0+xpoWI3V4aGQkC3wGoJsW2PG95cvZ09d
 Bk=
UI-OutboundReport: notjunk:1;M01:P0:z5GhfHAU0l4=;dWr7aiyWzb8kNsjkuCXhxwD8Ozp
 tB0v332bVjf5orps4mdz3j9lfq5PWQQemJ2zWDDemK+0zF/BDfjSwnuyyeblw/eT+/MgjcW0i
 M1HP/rBrUIMW89gEDNg/Xi8ihoKXnW3IpQcWiwwd9wiCPbO8h9uoTSR00xzUKvtRfVOyIBNkz
 DFJUYYK2Q9GFi4lynxwXnJJNUJ/C3XQ4lk/jfQHshF0cc7yQXfMAQLurPkhf8ZxHiNBSTCNJu
 SrR62iVT5mgwWrLnpw5zMJO1ZrL82j6YSdBk5tgVbodiPomrStLucS4oj9lDWIuGXMu7kG+Il
 vqFtrybiYi5Tmrztgy6uXeLLZgYL7vEgi1hW+K2Gg1lptB/5dntIJsZnYf8b9zByoPBasoIsC
 8Q1cWq7Aee4wSytIgNiI2GGGROYO38sNh8wsMtgs3hBKdEproO7SYSN+0ELu5XnnZMD1Ceb10
 QRn852I7R3zRhWadcOhQvu5lJLzImvyIKUqi8/xKc5PZA6aVpazPMT44Hi5aSg4Ili7UHrIyD
 xMBO/hAMdmQWio8JO3/u8HIDP4vb3Q7YCfoXiE6BPg4q6tgHV7WtrMxmbppQvimTmuImyfMsd
 z08yLfcEbIanui3OgL2Tw/lD7iy9SDtuV5Vn9f5tiPWbFEfSHC9XYVrlNqoXWrsXraEZccUUn
 VOM2azU0i0+L/iX/kSIUudnlq0KEWW2pSIWy8cAlwhDYEcjX2FTc0kXdwUHzv9UhybJVGntzz
 nItuDo8COfgt50x9i8Z03IfPkIlcQRO3uqFFi4ukoxAuANks2je9peyiHOS1kydsDsmi1tuuI
 0LvMTmax+O0Qgkcu80Fp4BSpJ0gKX8Ubhcw0P6euw5+rU=
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

Hi,

dependabot reports a high security issue

https://github.com/frank-w/u-boot/security/dependabot/1

it seems it is not yet fixed in master and next as there py is still in and pytest==6.2.5

I have not yet seen any topics for this...are you aware of this? I know tests are run in
isolated environment through gitlab-pipeline, but maybe this can have still a risk.

regards Frank

