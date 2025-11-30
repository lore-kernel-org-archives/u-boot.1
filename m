Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76260CFD376
	for <u-boot@archiver.kernel.org>; Sun, 30 Nov 2025 13:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97DC983849;
	Sun, 30 Nov 2025 14:58:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="onlf+LQo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7E3683885; Sun, 30 Nov 2025 14:58:11 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBF2D8312A
 for <u-boot@lists.denx.de>; Sun, 30 Nov 2025 14:58:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c75b829eb6so2277992a34.1
 for <u-boot@lists.denx.de>; Sun, 30 Nov 2025 05:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764511088; x=1765115888; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mLbimmiDsVcH9H6/G05aerjB/sfOEpjGpmiESfHn3pw=;
 b=onlf+LQomWHDyCqxUQEqJrtD8i6KeEVaGpVRRx5vt5HX4pVKXdacE4KU0lzi1OYLkt
 VGO8/tLI3ITPS0LMKeGVhX5mX8jBAn/uqscB8Fjs+HiXT1IxMmPF+IP+yu3Fia+8U7pL
 qLKSd2NydjF/UlcbG1ICksB5kCalbtgcuJBSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764511088; x=1765115888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mLbimmiDsVcH9H6/G05aerjB/sfOEpjGpmiESfHn3pw=;
 b=odUh/pmif9lcUjB/PnquTzuuakpHFurF+JR1pje5TR9e4nB1S2T+yEmWvoVrCJKu7S
 8xK08PHISAN0P4/z3bg64p6vWCJ+YKn9JUS2/Fy9pomEeETl3YjT31NJAuocXBh4babS
 QRvAwQ3RhvHGBDm4FXHp4ZJBch0e49wdiWT+ojdW0mNYtYLOk351Zb2cTzprhVC37a/5
 mfKq7uVaJkgWKAkhj+nCq0AcJ7bLHIJhfVi1zHs3+vCgc+FKZQnygj9TiVVx3m3xr9JV
 9IsjXEmreewb1pJdFrdUpveaC5ZdT9LNp3wzvkqyKL4gCH4Fav7AeZA5xlOFb5aKX35H
 l3vA==
X-Gm-Message-State: AOJu0YwxT4JOpdqmDDUmj+B5a3QAXsead3fnS5fmRUHIyLX2XY22cc34
 G112/5FN2fmH0mtZhtgpC95V+V36C3H8wrzs4+i5Yt2gmgC/lU/hZRYxwAK1ZF81j5P438jGapQ
 MWIe9wgY=
X-Gm-Gg: ASbGncvlUi+RrWX6V6YKHd1CoaKV28KovVKKvb+nYKgrpYhqA9WXyS0SdoLb4F6h1kC
 rjrF8K9LUmRirqBaQUr3nWRUu9D7YJS5A1gdyPr6jLh70gvIqr0X90FJc1toUVTUF+8c9ZfQJm7
 1GCygQZ4D9I6c66le/nYte4i46FkSAhTYWg3lIAZMAH58tlVAz/ninQfJmxqHoC5tlsUUNNJvh+
 JuuAQRIym56MdPyRMiG7cXTZR1nDBmSZrA1F4wazuhnfUfCKd/vhFlERrh4wqhWUO4v8PaF0s/u
 6lu11Tmt/JpCVE6/o0QVa4s59k28oVOW1b1xJZGe6QU5qFPN78cpW5EYD9hue6j7p+VohQKybYL
 VurCt+vbBlFo2p10ZueEEPP/fS+EIUygRiWBatleDFTkIAM3JJijf307TaoOvJa10NqqLPC/4l5
 bn8Jx+HmQB9GwLbwUgna1Yd+ipn+QCRUCSwnouM44s6m9cgUaMIC4N6o+kbU2SilY=
X-Google-Smtp-Source: AGHT+IEMQjFfV68//YiyX4NdVU/RxKS7Mb829EOpvtNTEnFaTxXixg1CDnDsKza831GqOmRESoxYoQ==
X-Received: by 2002:a05:6808:1441:b0:44d:a429:e816 with SMTP id
 5614622812f47-45115b8c89cmr13405582b6e.53.1764511088391; 
 Sun, 30 Nov 2025 05:58:08 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-453169b3ea7sm2919966b6e.1.2025.11.30.05.58.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Nov 2025 05:58:07 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Subject: Re: [PATCH v2 0/2] Add support for two RTCs
Date: Sun, 30 Nov 2025 07:58:05 -0600
Message-ID: <176443215473.486823.14730750782485796708.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117103315.2212686-1-mwalle@kernel.org>
References: <20251117103315.2212686-1-mwalle@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Mon, 17 Nov 2025 11:32:49 +0100, Michael Walle wrote:

> I'll soon post support for the Kontron SMARC-sAM67 u-boot support.
> I'm still waiting for the linux device trees to be merged (in -next
> right now) and then to be synced to the u-boot tree. That board
> features two different RTCs and this will already support for these.
> 
> You can find the device tree at [1]. RTC nodes are in the overlays,
> though there is none for the RV3032 at the moment.
> 
> [...]

Applied to u-boot/next, thanks!

[1/3] drivers: rtc: convert tristate to bool
      commit: aa2f8e35326276c81f94919b8173e386a6f6968f
[2/3] drivers: rtc: add PCF85063 support
      commit: 1c2a2253f7980355ecaec76e45a5901635f00621
[3/3] drivers: rtc: add RV3032 support
      commit: 788f2d3800e3d7e66a42aaffcb6cbc44390353d2
-- 
Tom

