Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92FAD3EE75
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 15:45:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5412D8397D;
	Thu, 22 Jan 2026 16:45:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pWv+cbgn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2474E839DF; Thu, 22 Jan 2026 16:45:04 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DC1780077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 16:45:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-45c7f550f46so371197b6e.3
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 07:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769096699; x=1769701499; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LWAgw6piov/158YipxMog4aMV7CR8Q9ARUNt/HUjokA=;
 b=pWv+cbgnF845F83zEcYMduLN5Q+RufU3AU+MAQmbSwNu0xRjRLA2sSgH8Hh+Qg/qhZ
 /dHvcTLGRk7Iac3ZJn3QpRB5KTruwxezId0o7UQNc9iwFl/2so4vDaBKV/bPbizORmmz
 OaFTqCId/VWgBhPo8Xukv8dziWcR4gce9MlOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769096699; x=1769701499;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LWAgw6piov/158YipxMog4aMV7CR8Q9ARUNt/HUjokA=;
 b=FLgqpd8RzJH6nTvOJnv+hHBGF0r0DFdK7T4CKsASOrDwdQCWKjsXvS+WZniH1niIsH
 8qS7uj/iOSfU+Ox9eLB05j1hHbAs8jFPCNyC9NBK4SJ/sXzz0RWvuYw+z34s0Z4jcnGZ
 GDh5eTzDXOQZt8M287MskiRh46v7TLu7GAJmX3KXWo1/1pk+WIh+r7IIXxXjoq/gJv/I
 RLyjo9e+gag1B8ZCC0/uwyFaASwMwItzFe+J82Yyeu7dj1D/pEFSzdhGWpfs3UtaJJwo
 y+XyEvbgHcD9FS0TrYc9Pg2Sk3ebGw8FGC9nAxoiAl+PEm0nuTcLVBElcWyZ7ysQHBTS
 KjQA==
X-Gm-Message-State: AOJu0YyN3WmalmqaJNn/YEQYnjq3i6xtIu2DZRpnYs0NApkbqrI6M/JF
 OQN9dWymgviVJzcfvRHyxSczrdRCmTyFDKXNa1Ad3/gaCwcm11KricOhXb4X40vLjwQ=
X-Gm-Gg: AZuq6aKTKuRjxD6IN1e1DBKZ74Y/tyl+uTilLQ2D62ZwNnJ/Qfm8pag88wm+MNQxiQm
 SyyaFuvshTgA1aTnUgTRuYOeET4mPt26y7sGChBagOJiUfd0HPyQYWxEaGAKYnsvjY1ro96Thkc
 vxEwU1jm0o88GDTUcPqCPwvAuMovzu0Fnbl1Cx08cetm0ztbBa9fNriEc42nP+qVH4d3hqDi6xB
 9p07S40MGDjttdQcRgdQhFdrYElEJW3qBPxJO9JJ0iy8it249ROLdY2s7qwXUBaNULauPlMr7eS
 bQZbDv7OXlrmOKMRRZYOmm9TgY6ZW2GVcFnDwcGx5qQxCrLbDoQtRlog0sw3xlV8SFFzQZYct9U
 JQgn6vM2SRTqPDrcUaZj4a8mQbBe/JfxnplT/08Ug5w5w5UgvNKo6d7+nIZCsEOpCblxqvkNlte
 tspGmtxI+dkiASETd2mh1ehsxvXNMPcuaxOP8CzwdNE0220PurHLDrENW9eCQ4qsOG67n9ETz86
 uy5YXSBkoAwicfCDV3I2R7mUH6AlirzJjT/qwB4MOj3ATaa
X-Received: by 2002:a05:6808:19aa:b0:45e:84f1:7580 with SMTP id
 5614622812f47-45e8a907e39mr5069295b6e.19.1769096699094; 
 Thu, 22 Jan 2026 07:44:59 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4044bd15c79sm13974424fac.10.2026.01.22.07.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 07:44:58 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <aXHeOM344Kqm-6e-@nxa18884-linux.ap.freescale.net>
References: <aXHeOM344Kqm-6e-@nxa18884-linux.ap.freescale.net>
Subject: Re: [GIT PULL] please pull mmc-for-2026.04-rc1-2
Message-Id: <176909669841.770397.15334335129506267213.b4-ty@konsulko.com>
Date: Thu, 22 Jan 2026 09:44:58 -0600
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

On Thu, 22 Jan 2026 16:22:16 +0800, Peng Fan wrote:

> Please pull mmc-for-2026.04-rc1-2
> 
> ----------------------------------------
> mmc: Fix sdhci-cadence6 license
> mmc: Fix sd_get_capabilities retry logic
> mmc: use max-frequency from device tree
> Clean up regulator and build fix
> ----------------------------------------
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


