Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F311FC36010
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 17:34:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BD04829C3;
	Fri,  4 Apr 2025 19:34:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qbCkwlMg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CF2A82A0D; Fri,  4 Apr 2025 19:34:31 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DF63807B1
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 19:34:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-60219a77334so1128582eaf.1
 for <u-boot@lists.denx.de>; Fri, 04 Apr 2025 10:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743788068; x=1744392868; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jAfpC9gp1f5rg+4ZGaMtiWJbch1tTCMKwEF1ihem9bg=;
 b=qbCkwlMgvZCGNEpSWOiLM0DkdDxxAcDwWoudHFJDaGCku4kmY5Axv5+G9BAl78wsNo
 v4unLhnyxuGRICFtnyZFF7rklCknrr+uLzjBLKigSXZkRxRst+d8AHy+7ueixLWMnALD
 xpxk5wn9BBAGww9cKbHbeRibWoxzocxQJaaus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743788068; x=1744392868;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jAfpC9gp1f5rg+4ZGaMtiWJbch1tTCMKwEF1ihem9bg=;
 b=HxAO6JNSr94Zk/yCzvOxTdiPZWIq1UUicytR+fZG+yRqSFxgvL/qXgiugRA44Kf3IQ
 pg0OxrBZEbxncAZFjDS1dBxih+SlDDpggI9hqpa8Q+/cRHG9VJ339UZ9HoGOYMUFIoEA
 aRcjCfoQ0LEDs/Z2mAlUVyiM2n4hD487DFEpK7vmdy5fzpio/q56heNqEZsVuo/azeBv
 YTdQy9VGxpgxKraQL/NUixhxlI/5W5JMou7nDVCvDxQekQRKYflmRWRrmZwNE4F9v0pk
 nu533LeBFqP9sW3Wq/AuigdhaICoOYZlxJSVdg4N4AQKFEdmc07+wrgTZ0+3MMpmC71i
 370g==
X-Gm-Message-State: AOJu0YxLjGxeCFmzOUaHRZCFl8MuOxCPKg4bAJae2L+0M217hNdb2Idd
 h5FxiQWW494XSZH9V5lylXDOu7sy+ieJduoyrBwA1n9K0ZLXcaGea1fbculO5D0=
X-Gm-Gg: ASbGncu3JJTq9Oq6v5tCHxmZYc45c5vkMQJRUMmnG5fbo9RdabnKjqhu8Aw+o8UmTtU
 Q9UCS+IC5znIa0B0lAnYhudEOyU9p8GFhnFp1e6HA11uRv9/lcM5h1V18ALfTOzpBacbIQGEz1t
 +KIdcmcAgQKPXF55hr/W5f+xIrXIwYyVe7zApZFwrZe/xWtgFw0JJ9YyL9U/o+wfX+e2OFRxRfQ
 jL1fuaAUUuHYZsz/eZxlD6XmFMXrtNlQtkoHSP8/wZAqz7AjAkgCJ4UZUY7eZKB6uuey/u/mSrU
 hNFVKO0B3/tFVInG5hjbnKiisW8Arv8Zr3gHaDolm6lldf14wZxK20eTIlNRxRdDmaSGDN8obFp
 JpS2n
X-Google-Smtp-Source: AGHT+IFkM4ewC2FeqdqVT5Z4VcQeFYUkb3gPllwWw8sL1UFqKHFoMDmMybJr6/XMM710abi/uKsmfQ==
X-Received: by 2002:a05:6808:221b:b0:3fa:7909:2717 with SMTP id
 5614622812f47-40046687453mr1947834b6e.34.1743788068012; 
 Fri, 04 Apr 2025 10:34:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4003ff742a8sm689170b6e.20.2025.04.04.10.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 10:34:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Rasmus Villemoes <ravi@prevas.dk>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Dragan Simic <dsimic@manjaro.org>, Greg Malysa <malysagreg@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Nam Cao <namcao@linutronix.de>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Raymond Mao <raymond.mao@linaro.org>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Soeren Moch <smoch@web.de>, 
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
In-Reply-To: <20250318152059.1464369-1-sjg@chromium.org>
References: <20250318152059.1464369-1-sjg@chromium.org>
Subject: Re: [PATCH v2 0/7] membuff: Add tests and update to support a flag
 for empty/full
Message-Id: <174378806585.2582470.11273077700960331166.b4-ty@konsulko.com>
Date: Fri, 04 Apr 2025 11:34:25 -0600
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

On Tue, 18 Mar 2025 16:20:41 +0100, Simon Glass wrote:

> The membuff implementation curently has no tests. It also assumes that
> head and tail can never correspond unless the buffer is empty.
> 
> This series provides a compile-time flag to support a 'full' flag. It
> also adds some tests of the main routines.
> 
> The data structure is also renamed to membuf which fits better with
> U-Boot.
> 
> [...]

Applied to u-boot/next, thanks!

[1/7] membuff: Rename functions to have membuf_ prefix
      commit: 4662e5286aa259e158f314157d0d8f2ad213a321
[2/7] membuff: Rename the files to membuf
      commit: 9ca1789ff099a364c6e16dcb6f6ad2e8677f32f1
[3/7] membuf: Rename struct
      commit: 68b0af2127dbd7b304f897f4796c6eb86fd74402
[4/7] membuf: Include stdbool
      commit: f48f1705c357605f05f5a47b84c1c89dc33bec35
[5/7] membuf: Correct implementation of membuf_dispose()
      commit: 44e763bd6624f23fe6d94340efb43c627b5ce4a7
[6/7] membuf: Add some tests
      commit: 142a3cb63c81602ae4f48266a190ebceb483e536
[7/7] membuf: Minor code-style improvements
      commit: da8694a7d2cc9fdfd67e8a039ba1e70bdd543d0b
-- 
Tom


