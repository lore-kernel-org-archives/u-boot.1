Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF26C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 14:51:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BB1C849FB;
	Mon, 29 Jun 2026 16:51:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IMDNTKQL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C44D584A1F; Mon, 29 Jun 2026 16:51:14 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A83B9849FB
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 16:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-495abf0ac86so1016227b6e.0
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 07:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782744671; x=1783349471; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=otS9rp+TXwDegm/JoscP1xI25ICBktjoF3AJJO83jLI=;
 b=IMDNTKQLW6Dpxj7mmGxA5g+LFj8uyb91mx/4cKDzlzISN0rMrTf9NHU6UwbgkGbnAz
 4gpcWGyJ5WikhYlRDi3QxZA4z8tRx/nlRKPShpZzUjAFfsXghChmImeuLaerHDwgnd3u
 rVSJy12BvFRj+4/rizvyGA0+bknN5CoO5zASA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782744671; x=1783349471;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=otS9rp+TXwDegm/JoscP1xI25ICBktjoF3AJJO83jLI=;
 b=ac90W2EhynbQZ+87zaNN/YAkq7a9FdMyadBXtr2rb3LV9Z5z9d8nPTC2iQHUoMcv95
 E65w5lP8ha2JwzXCcQHDC7NFKejggLvCZIZ9TMDSKPnxPz6id8vMrOFe2noG6OFqAVlN
 QoPc3YcURp1IrxUatZ73F5qie01WhF2Z5y4V7elKVDaNrPtQVXxLhRRO7mMzB3iuG3/u
 V6txFmoMVVrG5ySFWEOet6TaFwPzWiB7z/cg02WVtVj1Vm8gJiYXajhuIq1/PdXBVclk
 ETkICUfWOSFDooivrbBr0YyyojlOsrt7aw2cRrbWjicVKjI78VauJZexI45U7uKuokM0
 pOPA==
X-Gm-Message-State: AOJu0Yxqi/xdfuUVtt/0uzoWjId90jBQ/3xfKM75qDnGzOeR6jMfTBNQ
 ns3SkJfzpBZhaiDt0QDk7JiU3grKSZ4LglDrvljsJBOBtC64RHayGCdElKPz1XWnoHjSacMwZQT
 6czFixco=
X-Gm-Gg: AfdE7cmOIkQc/n82duI7gGTapGHrMtzJrJkqCgMwRf5CDbggiUe/JAw3qM11fTVFlg3
 SNn5OhvOA/vPNO9Dz6JWLa5carxGtKhkvLnomCcA46AoJENpr9FsZJQ1dx7PXMk51yhBNrZ1RrL
 md87WkHOO/Ke4QLhA6iZIdLlUAvDoq0VMT+Ex0LxHDB4Po083MRMdfr1oTbE/fq+oB9qQOiLaZG
 SFTlxxowmhlhydx/kxVnadgTTfFwW08IWDz5L0+wU9kU/OpeSdGLvUV5R3HrlYQ3dXN7Mhr+vMA
 7t+KvhXWkUgIsoRvOOYivfcM9KVZ4vknPhCJoNB/Pu5TLQK5kUYbmi4AsrTQkMsDj/CGHOtixFM
 RFXO3X4stMANjZtaJcsi1UGSUXElfCFNNGZQNFtWomIkkOxK1EYdEp6iHoX6jw4XjVtJtmaSutE
 VupyzEspwMf/LZQkovwOVyMy0LxJhsNvqz594DjHSFzL8krM6UKgFLzH6qncU0OybJocFxZYM/L
 /Igd+o3vt4i/foxm1u+o7UL1JxEkDxoV61nM6s=
X-Received: by 2002:a05:6808:bc8:b0:485:11d1:303 with SMTP id
 5614622812f47-49215f4484bmr16210443b6e.12.1782744671432; 
 Mon, 29 Jun 2026 07:51:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4935596d2a9sm6752640b6e.18.2026.06.29.07.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:51:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, alice.guo@nxp.com, ye.li@oss.nxp.com, 
 peng.fan@oss.nxp.com, marex@nabladev.com
In-Reply-To: <20260627180254.3067829-1-festevam@gmail.com>
References: <20260627180254.3067829-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20260627
Message-Id: <178274467074.720974.14350910641627479073.b4-ty@konsulko.com>
Date: Mon, 29 Jun 2026 08:51:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Sat, 27 Jun 2026 15:02:54 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/master, thanks.
> 
> The following changes since commit 6902fb4c17faa375003124c451c2550deab5463d:
> 
>   Merge branch 'master' of git://source.denx.de/u-boot-usb (2026-06-25 12:32:18 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


