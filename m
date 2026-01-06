Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E72CEFD04
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 20:16:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E635083FEE;
	Tue,  6 Jan 2026 21:16:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hRMHmQG9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E54583FE1; Tue,  6 Jan 2026 21:16:22 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 815C883FD3
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 21:16:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c6e815310aso1105129a34.0
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 12:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767730578; x=1768335378; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nax9NcxffdgcfNya6FbRUfHDPx0w/ZIBqB8CId/N17s=;
 b=hRMHmQG9A906YAnlNOB4KJ6o4WwUnZ7lK6CeMxo2eFE9eInPnOg/48czsVfni2WRRC
 KFytrrpGP4l0n72l64JNNUY7+PokNMywKBVbZIOP02Uc/VKj+WEtm2DMHR3jd3P5wZli
 fO1/DVW+4NztYuDmRgyhj1s3YrEj+3o+Kq14w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767730578; x=1768335378;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Nax9NcxffdgcfNya6FbRUfHDPx0w/ZIBqB8CId/N17s=;
 b=dBw1JmANp4j86bitQ6tiZdVCNrFCtIHAiGpsUXC3pNZ1WpLykjCRaMj8G1Ahk95Uaj
 60pZvD2rT6UAMSrqCWhP6jNInL9wSR87qia2gid2D/24PQYGctUytr4XiE5sEIu87IAo
 LoIyUvwHiTJs1bHp6eo7bzAGn7pxYm1AyjuF9oyHIvsns/1MYeyvKyh7b0/mYuTTdFZh
 wABTyGgEAzefQVSUps9sBXlgYCqD0Q8UpHuNmwpeS/9nbOtgceAlkeP24MjflYIeFVdZ
 IXpsM1ptsrMbNPmCGG90u6Qg3AcIR5bvK/SxKpFPLTbqrX9TTyZQkRJS1OG1oabF0Iv2
 WlTw==
X-Gm-Message-State: AOJu0YxmOPdi31Ucxu/f+DQ1lrS9vx3Xc2IjlkZM2PlME+0N0glq0ZAT
 nBp/O/9dYjqe2yl0sa01IZj3zC5WCHuMhOhMYR9MzfIQTsT9LcHLPIcr4GRzhHos9N8=
X-Gm-Gg: AY/fxX7Y9Nr5k7sg0ahPCGGXra73MnlNtJM4A+xRTWWL/dsvmunj1YGw5HLlUqlzzlL
 5niExv86Ytxuiad51yOKN52dztrYjsgaZDz2hVasPLAYGI3mvSHZIwd7Mm8oRDJHt+jSUGcDogi
 yAwgLtlRZv7abor/f7WmOSVNGMrX30sx3VWIDG7f7xqjQGjmJYUMquQ6NPWtuHe64QBCNlBQ+GN
 AURb48d7oKCAMavugrw07yklJ7x0jBKxEBR/PlLNtDpBWPimM8aGszuyESnjsUVyD5aMzcFBo6T
 YGQ3KuwegEolKn845FvxEfCYZKN6xth5ZX8jOfgp8xDz8wT7y2j3XBXw96WcQyMLmgVI5/nj6XU
 T6fdAH5zNGVSJqv9NpAqj7Wn+Gb7FaMcp2cV2TUeiqJwG+y9dH6Y+AKeN8ASbwMxQCQnOe+lm9q
 Ez9CTq6UcD8vIMh/+ED6jlgv7TfkD1L/FgoN+KuPZ8VIgoJSRu4vc5Bc8jf8v5t1m1ybqBDulJW
 1/uoWCP/KMV5Hxkyv5jCmuDARiQg7zL0wsU3Q==
X-Google-Smtp-Source: AGHT+IF8ysBO3VWWiB219ImWhr2V+NBZEZJi+s16KlIqfBRcUdaqannf7Y2Zg+N8aAcsihdxVL/QnA==
X-Received: by 2002:a05:6830:34a4:b0:7c7:6043:dd87 with SMTP id
 46e09a7af769-7ce50aff2a4mr213260a34.6.1767730578235; 
 Tue, 06 Jan 2026 12:16:18 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce478af63bsm1962355a34.16.2026.01.06.12.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 12:16:17 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: u-boot@lists.denx.de, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com
In-Reply-To: <20251222174256.2455458-1-visitorckw@gmail.com>
References: <20251222174256.2455458-1-visitorckw@gmail.com>
Subject: Re: [PATCH] checkpatch: Add check for space indentation in Kconfig
Message-Id: <176773057754.3765597.891851544595053836.b4-ty@konsulko.com>
Date: Tue, 06 Jan 2026 14:16:17 -0600
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

On Mon, 22 Dec 2025 17:42:55 +0000, Kuan-Wei Chiu wrote:

> U-Boot requires Kconfig options to be indented with tabs, whereas Linux
> allows spaces. Add a U-Boot specific check to warn when spaces are used
> for indentation in Kconfig files.
> 
> To ensure this check is executed, move the u_boot_line() invocation in
> process() to occur before the valid source file check. Previously,
> Kconfig files were skipped by the file extension filter before the
> U-Boot specific checks could run.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] checkpatch: Add check for space indentation in Kconfig
      commit: eea1c6ec4ead013fcdbc1f4ee1a5f595d58ca303
-- 
Tom


