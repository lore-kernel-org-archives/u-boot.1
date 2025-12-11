Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB94FD41D5B
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 15:34:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D98A835C6;
	Thu, 11 Dec 2025 16:34:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="AZAED0ZX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6156083642; Thu, 11 Dec 2025 16:34:39 +0100 (CET)
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com
 [IPv6:2001:41d0:203:375::ba])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C2BE835B3
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 16:34:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
Date: Thu, 11 Dec 2025 15:33:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1765467273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ka+v9Zc8pwgDc2H1UBovhafwgdE6y987hzE5H0asePg=;
 b=AZAED0ZX1um68THoMttT97xX9M+1LSEYV5ctFQFTFDtDk6iAj6YcRWA6MXFm40HHlgps3p
 R+g8wJv2xwLjGH2ruoGlDEmQ2hzLO5rdcht49ZOlkDw2DxYlVtdqlwO1g1XZpdFmfDIGHr
 cNpnnU5qkPn4UV7jKpetPVtCndCbs27AQPZCCNQ9IFw/6lowW90M8gtoHYQN+dz4vCOr18
 TQF/QJ6kbI9DyRD0pThiIRAfFTIQLNVB/4UKRAQyZZlF0QtnyH8pVlKZJuoqNt4XZficzd
 VWxV4I6aczU/2CBhG3vT0s/e4vXoi1JoZ+ONulNiTVktfR6dVRSFLxXBkY93mw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Viacheslav Bocharov <adeep@lexina.in>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Ferass El Hafidi <funderscore@tauchgang.dev>,
 ~postmarketos/upstreaming@lists.sr.ht,
 Ferass El Hafidi <funderscore@postmarketos.org>
Subject: Re: [PATCH v3 0/2] Support EFI capsule updates across Amlogic boards
References: <20251211-meson-capsule-v3-0-1cf15a2d2498@postmarketos.org>
In-Reply-To: <20251211-meson-capsule-v3-0-1cf15a2d2498@postmarketos.org>
Message-ID: <t7439h.127clgxv5zbcz@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
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

Hello, please ignore this patch, accidentally sent it without R-b tags.

Sorry for the noise.

Best regards,
Ferass
