Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F707C4450A
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 17:56:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B528284D62;
	Tue, 14 Jul 2026 19:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nOpo1fLF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D6D084D5F; Tue, 14 Jul 2026 19:56:14 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E58184D63
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 19:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7e9f1f24cbcso994062a34.0
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 10:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784051769; x=1784656569; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5Kkws0Y3b514ZJiuBWoLAZHIBoZyEVeJv8iPySpnGCE=;
 b=nOpo1fLFDtP3lxJv5xhM9DuyiEsZQOp0yRvJtue1TbDmyqpu++U/KCObrPefn/hfNX
 9lEQy8pZUsvDcIwdn34fHW7+XfnsgGTiFT0N18Jdsga0TEV+5BUvHOTWZZ4qhkOaI4G+
 3+Z6eCc1EdKBpqCnUT8s5Shb0NRwB372OTNlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784051769; x=1784656569;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5Kkws0Y3b514ZJiuBWoLAZHIBoZyEVeJv8iPySpnGCE=;
 b=W7aA7mziGn/or+Zj7kWTzP0hq3gF15/3tWTpn65U7MJ/BrHhbsB6Gq8nUE3Gt1GVBR
 oEAKBR0IG0o1ZSS4ZoHFY2mbK6W3BtmIz+OcIAQQ7EwhtJp+pWhlqq8pdzVxyPxxShM7
 VSZmj/aHMwpJs423THo5jr/QYqN89lo0+jYr38ABDkm5PBEFGYWEzIyP5j6nrFZZl8XH
 826WA4pA9KK1O3ku6+HUV8lL6S5HHxqB9Q8FWZKvMnmaPgAd1TwbR1iRcGTYumZniodJ
 X1qz0IdU7y8hd4WEv1pUoPzXD8U2C2bl2X+57DupY1duk+Uo9UV1Nw1+IxlQgz+uLz50
 lp3A==
X-Gm-Message-State: AOJu0YzZiN+YP1L86yTnGDxn5EdYMKjnyQtyw0ionY09Sevz2v84gzMp
 g8zC0YTW6dCptnW79CV9Wlye1J2FYCYQkqjNUc7Yddy/jMQhDCJbmdbKX3ZIbGa0ycJqVP3amPh
 wpxo+fe0=
X-Gm-Gg: AfdE7ckRAZk+gdyiBh2VGZNiWSDchpKT53l5EEfx0Odm7Fk+tocEa9B+eliwtgOBmqx
 qrQwF2GjjehwnJB/HQ6NZxLKRnFqRyANCc0NGDz1UfIbIU9VS5Cqv/EcP7kszajbr939QXGOaEI
 vw2dmZ0xTl5KTTaTJOkH+vkuaHQKEWeD/4nKuV0kVRnWCkERok62dvXWIl6vOgtgLk/sQkJMk9g
 Yk1/sRM69OZVGEJ9R41fdnOo2exmE8KKI5IhCiS+6tMW1/MUGrW2e+5uhJT+mlPnLZpl6iBGbv7
 R6vD9mMPo8hr2539szPtRgR9G0Ne7/HIVfJjPZVwyaDOWj4Qazj6Vmz+ExiGyVO7pWe2GRJYVXP
 NJCc3X6d2IEsQJ1jxECkedTCHi5QfRLY4HMMPwcskBIRBu47N2S+q3wJ+O3wnydlMGn7hZ+wiiP
 5ld3ddskQLtdkYpT1klOmnaRdrK5KPCnkez9WMg7yRvms4SS3VgoHzO4RlRSKgvspDft01Xfr8C
 knqJV8HHvjl7jbcSxhf9Td4aSdPOx68TSmG
X-Received: by 2002:a05:6830:82ad:b0:7e7:24f9:55c8 with SMTP id
 46e09a7af769-7ec09e176b6mr8169205a34.5.1784051769090; 
 Tue, 14 Jul 2026 10:56:09 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcae206e2sm15597648a34.2.2026.07.14.10.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 10:56:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: sjg@chromium.org, alpernebiyasak@gmail.com, 
 Shiva Tripathi <s-tripathi1@ti.com>
Cc: u-boot@lists.denx.de, praneeth@ti.com, vigneshr@ti.com, 
 n-francis@ti.com, vishalm@ti.com, k-malarvizhi@ti.com
In-Reply-To: <20260630152809.1933616-1-s-tripathi1@ti.com>
References: <20260630152809.1933616-1-s-tripathi1@ti.com>
Subject: Re: [PATCH] tools: binman: ti_board_cfg: Add configurable sw-rev
 support
Message-Id: <178405176753.3971373.5774860360126141096.b4-ty@konsulko.com>
Date: Tue, 14 Jul 2026 11:56:07 -0600
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

On Tue, 30 Jun 2026 20:58:09 +0530, Shiva Tripathi wrote:

> The software revision field in the combined board config binary header
> was hardcoded to 1, preventing independent control from SBL SWREV
> configured via ti-secure-rom's sw-rev property.
> 
> Add support for the optional 'sw-rev' DTS property in ti_board_config
> nodes, which sets the SWREV byte in the header. Defaults to 1 for
> backward compatibility.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] tools: binman: ti_board_cfg: Add configurable sw-rev support
      commit: ab2266aff3622a1cf1a5e76a0702688b2bb538a5
-- 
Tom


