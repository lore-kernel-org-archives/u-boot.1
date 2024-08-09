Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A263AC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 04:36:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFF3088B86;
	Fri,  9 Aug 2024 06:36:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q2G2LaQU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB744889D2; Fri,  9 Aug 2024 06:36:53 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA18688A44
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 06:36:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3db130a872fso1154001b6e.2
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 21:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723178210; x=1723783010; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cx/11QQnCcL/sUgWWmvqS7UE5y+xZGIzn9sfdhU54lU=;
 b=q2G2LaQUMFQ0Tg55jSnt+cWw/qGJcg1bZ0YGr0rRUfHgP2yX2oM/eFReLuAMwEqQL+
 XUkcn+TTm6vmTyafN5Wd9VVcPH0FzcCUdazsmRPAkREEfzK87RAwMf8WEU+37SaUfLTI
 vXK/LW5/qNCVCbaDxg1Smw/rasDE+dRigsTGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723178210; x=1723783010;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cx/11QQnCcL/sUgWWmvqS7UE5y+xZGIzn9sfdhU54lU=;
 b=CX+B9QjwHyg+cMz58OWodfP6XXtTMuJaY1Ld9g24nii3YCBo0Cn2Gml8PUA+6cXRNG
 A5lfw2N9yKkoQAs4pisccjv8YuIW4rutz03a0p0eaZHW8mbXf0s5Lo+obiQqEVwKgxiJ
 zB/wurc4JB1kYgE+5pHBB3pj/Te9JdbYqLSOL7liIS6YcJwAg+TlPl83sicCL2ojhXgx
 D7qdU9rmKbnFBkejwu6NBoL+9ZSZ9ou9dTIqaqLksN5ozf/ReDNPP0FpZ0TRF/b6zy04
 IZQ2tgQsKMZmQBvUxFs1h6XJYipQZxbthf3ZplW8kBGV3KsRiWMoxv02hNdmQ1suvlhu
 Nfmw==
X-Gm-Message-State: AOJu0YxtU/Z1or60j3zCIgme0N0YtQiOzMRQ/4AyXWaOWe9QOzZ29eDQ
 rkZ69zwsykOb3u/lq1/rq16A+v6BeShsvDYEPVuIQD72NzMznmLU3pp60NCs7N8=
X-Google-Smtp-Source: AGHT+IHznFgCkeIG/qt10uMZ/DXQEKaLH3/f4AvXdt3pz0J7roY2rtMl+8jyZVTOoUQElm/IevO9Gg==
X-Received: by 2002:a54:4e9a:0:b0:3da:ac2c:4c92 with SMTP id
 5614622812f47-3dc4168a086mr289343b6e.23.1723178210365; 
 Thu, 08 Aug 2024 21:36:50 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-236.totalplay.net. [187.191.8.236])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db56361a0csm5352679b6e.3.2024.08.08.21.36.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 21:36:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Nishant Menon <nm@ti.com>, Dhruva Gole <d-gole@ti.com>
Cc: u-boot@lists.denx.de, Neha Malcom Francis <n-francis@ti.com>, 
 c-shilwant@ti.com, m-chawdhry@ti.com, vigneshr@ti.com, 
 Robert Nelson <robertcnelson@gmail.com>, Vibhore Vardhan <vibhore@ti.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, t.remmet@phytec.de, 
 mkorpershoek@baylibre.com, Daniel Schultz <d.schultz@phytec.de>
In-Reply-To: <20240805142937.443737-1-d-gole@ti.com>
References: <20240805142937.443737-1-d-gole@ti.com>
Subject: Re: [PATCH V8 0/7] Low Power Mode: Package TIFS Stub in BeaglePlay
Message-Id: <172317820876.1900468.9410775003497057644.b4-ty@konsulko.com>
Date: Thu, 08 Aug 2024 22:36:48 -0600
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

On Mon, 05 Aug 2024 19:59:30 +0530, Dhruva Gole wrote:

> This series aims to add documentation around the boot flow and tispl
> packaging details regarding the TIFS Stub. While at it, also refactors the
> k3 common docs to add more labels to provide more granularity on how we
> include chunks from common docs into SoC specific docs.
> 
> This series also includes the binman related changes required to package
> TIFS Stub to support Low Power Modes on BeaglePlay and phycore-am625 SOM.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


