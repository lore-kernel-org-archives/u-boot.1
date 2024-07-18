Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF292C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 13:41:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB3DF886A0;
	Thu, 18 Jul 2024 15:41:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b6dKMsNF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED62B88758; Thu, 18 Jul 2024 15:41:35 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 857A48818B
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 15:41:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5ce74defe41so458486eaf.0
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 06:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721310092; x=1721914892; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y6rKdsUL7lDBtWnIZYiEPCqwDl1ywNTO0QMEVkKMnf4=;
 b=b6dKMsNFOtUvlkR/kDddMYSWDBaGDS2kXMULTcmiexQHm64zd0MQRVwBdE48dd7juO
 Sf32JBbZL+IizBkX5DUd/dl7Yocf5PuUSkwL2TnGLJpgGpBLh3PRH+/nTk4MOKOBsn2O
 t97GbpsuHRIpW+0495v0kgR/AS61DA7vFmAdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721310092; x=1721914892;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y6rKdsUL7lDBtWnIZYiEPCqwDl1ywNTO0QMEVkKMnf4=;
 b=bY24glVQ4KzGqokitc2dkRP/IQruLmWhH3XxOTr5lbdyp5tyzkH28xc8CwiJnxmoNj
 3XK2DEkrLM4IMzdlP2QikUFOf9srfnTyNmoWx+uGvaG7BlFMh3K+AQBi2QWp02Y0i32a
 eHpDmS0uC5YivpQR8mk9vc85s6u7dSvMSioxxdeHKxEoSjpCxagNY0nnSkS/wowv7AnW
 M4Uj0ugo/JKqcmGAy9aRLlj0eQep9PPSWM2wHgPuQ/PDyZnR6mZFRoGsTwgd2e/5b8oQ
 8VjGl08fCAkS947j9bZ2eP2ZoQToLE8CYMeoHBiqlRFrboc+JJpxwupE+cnl4nEanBbR
 IMRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/MK0ynNQDrhFUVOPZ4PBg36yDcXGGDa2CO+bmcFWpOHmkS4cgDik7WYX1xw7luXYt3szb8Qtog+HNgwRs2dgPi7+fqA==
X-Gm-Message-State: AOJu0Yxi2FE5YX2OpfYK/IWfE5yo2c8O5jtYvfBWRd+E++aDZP0Bixa5
 DTK1O2Cjhb1z+/1H8P37TwhcekcFYfENhbviyuteAWXqhzhGOLjK+mOo+Cy4PMU=
X-Google-Smtp-Source: AGHT+IE1tw7l2IsMiLmgSKKElmHylCd3aA7nEhZKIuD1PMTY2QB5ts2DGpAZZCvHSDDzWiSjsNSnJA==
X-Received: by 2002:a05:6870:f613:b0:25e:c013:a7fb with SMTP id
 586e51a60fabf-260d944deb0mr3934753fac.43.1721310092244; 
 Thu, 18 Jul 2024 06:41:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-260ee947f82sm355303fac.50.2024.07.18.06.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 06:41:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Vitor Soares <ivitro@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, u-boot@lists.denx.de
In-Reply-To: <20240704154932.434266-1-ivitro@gmail.com>
References: <20240704154932.434266-1-ivitro@gmail.com>
Subject: Re: [PATCH v1] verdin-am62: add DFU, USB and UUU fastboot support
Message-Id: <172131009143.1834634.5277914704766018339.b4-ty@konsulko.com>
Date: Thu, 18 Jul 2024 07:41:31 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Thu, 04 Jul 2024 16:49:32 +0100, Vitor Soares wrote:

> Enable USB host as well as USB gadget and DFU support for a53 and r5
> configs. Also, enable UUU fastboot support to download files with
> the UUU tool from a53.
> 
> Additionally, configure usb0 to peripheral mode and add extra
> environment for DFU use.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


