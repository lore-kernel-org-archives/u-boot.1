Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C46CA0EC4
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 22:22:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9500883280;
	Tue, 12 Aug 2025 00:21:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qy+Vqk7H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89581831C2; Tue, 12 Aug 2025 00:21:06 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AE1583303
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 00:21:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3e55955915aso4426815ab.1
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 15:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754950863; x=1755555663; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GHX971i0Q9fBXsFymsjuwHHpl4dW1IORkz7NGmVFJNM=;
 b=Qy+Vqk7HIHRorQvJ5I1TNHyW83/oKZVOU4VWxmpyiqUyQQQCAz6u/4BxbAa4bEAvXT
 GQM3mVJuHd0iwR8CbFGUKOXRB4MBlaafMmLJ/DuaTS3Mszfqq9EPvbhEoHV3OQLSccGt
 ioFA2ooulUEXtGc453IYi+C8okM8or+w/3IFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754950863; x=1755555663;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GHX971i0Q9fBXsFymsjuwHHpl4dW1IORkz7NGmVFJNM=;
 b=dSqrUq9XIXVhldscax2tXjowsYi/StqYXeME8koP9M52IGQ+lKokxlyyrLwEAfeiqy
 y9p7eHWmI9ityWReOVV9q+b8HO/qAkjBWPrpfz9cT2+kmiGYDPJ9Ym4q3wkvreQN6Cgk
 gbC/acHQ5H7rKdvPraY6XYNu7gqcb/1/2dHWuKZ1P4KKesyx51m3kFIh8sefHKsaa52A
 GFixdI+vWD4NgHJI9fFXi9a204FmsHC5iGDdcvCnEtp9Uk0IaRk9iMiLq0Am/ett+NgV
 NGofKjACEn+Lz6pSKxO2TQJuIuB/U7CvIOcT56nGk6yyO1PM2QeCEOXc6s2deqW6EFs5
 NOcg==
X-Gm-Message-State: AOJu0Yz7JmwmOZBlgUZ0VeF6bqqtnbWYR9BGAYIpeW3nqf2Ph/TvOFlk
 moEYlErjoZGtap1XUmEe5HcNdI+LrqRjWtMXLWuswtnbAhIQdNv+kyVsqx03gyDeYrw=
X-Gm-Gg: ASbGncsphHR5411Ab7khycya7whZMVV1J/vfbLXCTC7vj/5/akZotoZAVHTUjjPvPE1
 hDuemmQGwguQi9X0Hcwnfm9MfFBG3R9eP5UKbxJ/st2LbAOsYmJDFKxh60fDKGnQFDSeBg9pLlf
 kWhusHqq6rPXRvdJIwHtBTtTqLMKABSpk8ZZFP8UWAQsIyCTaZgKyNuXC8MhtPQVvPyLEqnP05H
 3oBm+ZWvv+bVblVq+U9U2Gg+4HjsBYJeqk9uF8fd0eFg9n87LxcLD9LzcHCgsbHLd+OroZa9Vbl
 OeMqiv9Py9tn2wOwgAceQp6Jgg8urzVXeLfzTeZrdXN8Rs3meNsDPYsrWTSNVkEsHbfwTM2nU6t
 WPvnBCkqu2L4gIYMKEGsEmxRFwD/Y+1fH2eYJW40x2Dly0thHWsTi1KU=
X-Google-Smtp-Source: AGHT+IGGFjeBci44hKWlpOEGQ4bDZ2Uwjrqt8AhAMgrqCqT52eQWPxuAIvbgq/7po1LgSoOt3vExew==
X-Received: by 2002:a05:6e02:2168:b0:3e5:3521:46e3 with SMTP id
 e9e14a558f8ab-3e55b079d5cmr19497055ab.23.1754950863325; 
 Mon, 11 Aug 2025 15:21:03 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e533cdd3e6sm42092725ab.55.2025.08.11.15.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 15:21:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Shiji Yang <yangshiji66@outlook.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>, 
 "SkyLake . Huang" <skylake.huang@mediatek.com>, 
 Sam Shih <sam.shih@mediatek.com>
In-Reply-To: <OSBPR01MB1670FAE7E61614CB66C47D79BC5BA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
References: <OSBPR01MB1670FAE7E61614CB66C47D79BC5BA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Subject: Re: [PATCH] arm: dts: mediatek: remove useless SPI property
 must_tx
Message-Id: <175495086240.1657597.2624044413208813101.b4-ty@konsulko.com>
Date: Mon, 11 Aug 2025 16:21:02 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Sun, 27 Jul 2025 13:35:13 +0800, Shiji Yang wrote:

> This property is not documented. And the "mediatek,ipm-spi" SPI
> driver doesn't check it.
> 
> 

Applied to u-boot/next, thanks!

[1/1] arm: dts: mediatek: remove useless SPI property must_tx
      commit: d78130ac5a5be61832e7652ab86f9880012ab5c9
-- 
Tom


