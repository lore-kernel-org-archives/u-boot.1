Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BADC02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 18:47:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9284181703;
	Mon, 27 Jan 2025 19:47:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WcbdaI5y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84A208129B; Mon, 27 Jan 2025 19:47:06 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66195812C8
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 19:47:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6d92cd1e811so50898346d6.1
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 10:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738003623; x=1738608423; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PWedrECfpHswe8HWCHMQtQ7IkoeK/j3W1A/fu1hJk4I=;
 b=WcbdaI5yORTTlHZfSJ4Ln2zX4ZeH2YovRQPyiDTAZULmAFhdQmbrGhgM1wce/z9wWS
 /rC3A0h9Rfn973EHLT6DRbb6LHYK1aHxGj85HQdl406d3/HbEdbfOdxB8XY6uVKcpkEc
 gVCkjP3ahYpV/AWufU+FWKAqFidjwVSFZXlBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738003623; x=1738608423;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PWedrECfpHswe8HWCHMQtQ7IkoeK/j3W1A/fu1hJk4I=;
 b=Kfih6poMu/Bd+vN2TBsEmFeLHDSQPikQqgxPH9p1rpRrWe3j3FwoFX16p8QUxuT7AH
 BnnAyoN0Icd+9vU5wprJkmiwa62Rffnsnzbo1T1lGkFG+sWVUnjD4vtUd/xAqYeJ3LsL
 PA1PUMQ4evBgFXEmeWjG4oULMKz6okuhqnnZ6uH7Uv53YUb/KNhXUgrZ/RxxWtBIupSH
 q4leQqPtCx2JQyVG/pjd0VH1C1QvFnmUXPy4cj14It93KitjnWUJJYs+ZVHsLPe7q7Da
 sMLGCHHxGr5DGQynp6y4LQoPaH9OdDkp7weNaVkV5caDSPrjSfA3gp9PoKtG0mA2HyT0
 2Siw==
X-Gm-Message-State: AOJu0YwY22YQVorH5lOMpYINCYMXRXWT/xRJcjyzk7HsBr5IRFLPoYLw
 7kGazMpkuJWTuCdUyK+/9WlSNEgscwuX+xf/3+Yiw6B9AM8AbWCzc8tTuaNyE3DOWvTyf4U2K/F
 f
X-Gm-Gg: ASbGncvG9SD4in8d1cl7bIecErcSFqdXxccaDyep5H/UyxsJLCQ/QGRulQE9Utf0ja9
 fZzK36OosIOMkERUuCDoPVvHR8sjWsa9bvlrasBTW7i2/ehrPkCz15RxoA9FzYfCauyNMlhiTuM
 Nj4JBhsCHYDyBF5sLHvA0ghCE31jEkkxE9lmwizzTbH0MsWYUmvxpgAjHrWD1tgZWmHpQcahWol
 TBgwtXArfPejIl1IbqXZNXrOL5k85/9BvnxV8zUkFm9f93Z/+DxzLbGBRukmNc6hYrFutNhEzhp
 DTk=
X-Google-Smtp-Source: AGHT+IEnh1UaiPNurK1SEW8Puerm11TOQ9doX/hGKvL6ARmvPeudVv8sqxtXS4f7/MEHOu+fEAxHRg==
X-Received: by 2002:a05:6214:1d23:b0:6d4:287d:b8d9 with SMTP id
 6a1803df08f44-6e2366da82amr5942076d6.2.1738003623325; 
 Mon, 27 Jan 2025 10:47:03 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2057a87bdsm36937886d6.77.2025.01.27.10.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 10:47:02 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250127121134.634412-1-festevam@gmail.com>
References: <20250127121134.634412-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20250127
Message-Id: <173800362241.1649283.6197158781638064432.b4-ty@konsulko.com>
Date: Mon, 27 Jan 2025 12:47:02 -0600
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

On Mon, 27 Jan 2025 09:11:34 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/master, thanks.
> 
> The following changes since commit 8162f35a108441b8d7a44ac9266c1a64dbf79fd5:
> 
>   Merge patch series "test: Improvements to ut command and test-suite running" (2025-01-24 14:35:37 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


