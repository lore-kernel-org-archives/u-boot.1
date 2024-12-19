Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED72FE7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 21:43:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 425398021A;
	Thu, 19 Dec 2024 22:43:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="joAwrKvA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC68B8021D; Thu, 19 Dec 2024 22:43:30 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD1C780383
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 22:43:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6d8f916b40bso17434396d6.3
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 13:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734644606; x=1735249406; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ro3Qg9KFVtcfoTkzhXIbtWbCvRjXgeYhg3Jaqjwujxw=;
 b=joAwrKvAB9rxoUoJ1/cjHv7EeSaslkx1+Jyo33gzsLfkNKoqvYJxqk9iQ5FxDRzHjf
 4iZIwB3pE9sZ2+YQHXOC9DcVsIUK/pE/xl49RoGxW57TsSWKzzUcpVoSCJ7EDKn0N4AV
 57BguOryH9kYtDlzlO6PdZKqShRNCsbG3MvoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734644606; x=1735249406;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ro3Qg9KFVtcfoTkzhXIbtWbCvRjXgeYhg3Jaqjwujxw=;
 b=FclQb1gZty2Poo3P5FgxWP4BMgzFM3/Shn7tXzcJHIQudUo3mS4w+XZelwtXMzHXA8
 WdDd8/5PGQqFziIiXnFoOtpePk/27U9Vji3/6Kgg27T9VPdSeh+KRR39Kgv6KVI3jUtW
 dLg1A9L9WE2eqSQTU2vpD+4GDLfxVTvDMd3fCZAy0ta3awvUNQdJcY8bSOa0mcTlm/I+
 KXape4h14x02iq0wzSEbk5gPWBNj1VHoeJm67UyhZ6GnwW661OrHuY6jAr6aaDiJ29B2
 /DrSjTOoYimUrf7FW4GRXkmfwGGeMrpEdGHR/+HbhCwPLUH47TLmv55tbQaoPx9XhYSY
 Vksw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCPkPA3ZALVipEI4I13xVnlOJByrt3ab8i1butZ+tR+zZixIssgyev13DGbzBHAKXNlWRKPPw=@lists.denx.de
X-Gm-Message-State: AOJu0YzWYcWSt8Ex1W+9s7qfCssMkyjjEBm0C3jEb3HXOcHcjwIIoemh
 BtLH3ZN2e0PzYf8MVGpCjAOFYwQB/eJzMaMjsXIsKIv/cwPiagXsOyr7J5S1mqc=
X-Gm-Gg: ASbGncsjOdh2nQln1MfS4HGLfoxcCMzPho4X43VxulYG5aVgsnq363yGq5YyRKTQFQC
 E8JD0Zj8S7Yc2hQYfi/ZHFegZsDucxNhMr5BG8M2N9xYOU5fU8MThQL8yGy07i0tqH6jlUtDKv5
 /HLshaHFRHne+7bba1OsvSAmGVYSaGb4MtsgSy5yGc4kj6R7mSpbVEBw5g0q1YJu/tBRNTAhsZj
 g7mRMWkJTTNGw+OMLjjLbfA6VMG9/6JQF1LTXB5vWLl4WNedEFZoNI=
X-Google-Smtp-Source: AGHT+IE+28Oq7qLTSPF83wgWyk1p+P4f1rp8ni/Pu0I8x+6naNNS9j6YJ1qBaUJwUECLBZep39GrNQ==
X-Received: by 2002:a05:6214:1316:b0:6d8:87cc:73a5 with SMTP id
 6a1803df08f44-6dd2338d1demr10229826d6.38.1734644606653; 
 Thu, 19 Dec 2024 13:43:26 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd180ea824sm10410196d6.4.2024.12.19.13.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 13:43:25 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Vitor Soares <vitor.soares@toradex.com>, 
 Paul Geurts <paul.geurts@prodrive-technologies.com>, 
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
In-Reply-To: <20241218090007.692815-1-ilias.apalodimas@linaro.org>
References: <20241218090007.692815-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] imx: Fix usable memory ranges for imx8m SOCs
Message-Id: <173464460397.3661439.4836285542089614702.b4-ty@konsulko.com>
Date: Thu, 19 Dec 2024 15:43:23 -0600
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

On Wed, 18 Dec 2024 11:00:06 +0200, Ilias Apalodimas wrote:

> commit e27bddff4b97 ("imx8m: Restrict usable memory to space below 4G boundary")
> tried to adjust the usable memory limits on a 4GB boundary.
> 
> ram_top is described as 'top address of RAM used by U-Boot' and we want
> to preserve that. This is defined as a phys_addr_t and unfortunately
> its size differs across architectures. This has lead us to a weird
> state where 32bit boards define it 'SZ_4GB - 1' and 64bit boards as
> 'SZ_4GB' unless it was otherwise defined.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


