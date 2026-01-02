Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F1BFC6165
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 23:24:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CACDE842BC;
	Sat,  3 Jan 2026 00:23:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nFv207r3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15AA383B30; Sat,  3 Jan 2026 00:23:50 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01CD883AAD
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 00:23:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3f0cbfae787so10508532fac.3
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 15:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767396227; x=1768001027; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jfsehgAlatI9e1rRhDVBxyKMnZuXB3EWlSCbhKcvqT8=;
 b=nFv207r3Vbogi7zj8j0bqY89pdLEa7VCejXNsTjeMRVRnt6z032UqCmzIVkTmzmiLu
 tSvast2F72ddMlrIvq07OqZ6AYWBWUi4BGIKn+rl81pXQX/hbowX5HAztEgaHxDusiiO
 +aUUMEwcPTMt1LWPeWt92E9m7ZLuyhLDVUQ3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767396227; x=1768001027;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jfsehgAlatI9e1rRhDVBxyKMnZuXB3EWlSCbhKcvqT8=;
 b=Iohf+KMtpjqITsewPzPTgz2p3H8ZQkm7gw536xjkSJGGrrsXh3Y0+CJ/njBksu9B89
 wsHhEsop+SDPiS2bl9jp9Nf+zYgiv64PX/H0Sz4R+xcyAo61U5XbjE4qeFCc7I6BYg2w
 Ru3MJMDrWfPxzJlBoFc9UxcTkHKl748nLNhKSQn91TM0ymwQbIeRwZnWBIlm6dSeY1cZ
 A/pjaRG4AThZ8aU1UtdGwGd2x3Bs+7iq6/KVvHlH1rHviC9Z0FgHRGayHF8Y2920Q51U
 wsGZ+eUX/QDMIci6qxnet1Tyv0mGe0VNW4/jCNuOSytRj+MUOQQdjtq7odc7OA8+wg1G
 +xaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYZkJMwsCAG0CE0Uc0asAnQLfO7cnwQOSYS8/0hzvz1pKTwOa96ICcbxkQnqqUDCHNFToB3ww=@lists.denx.de
X-Gm-Message-State: AOJu0YzqZRpmLspActzsOvcQ6qlvi/EPcNo4vUFSOKYwePrPfleoPNLo
 UzaJ7MjqUcocqdQXAY0oYfyOnyjfNgRy/x/38MaPR2MXK5JNT5ML1tF7IQGvkrPadjw=
X-Gm-Gg: AY/fxX4jXKckWX1OY/75I+ZpbTaqKAbbuxCIRlQlvNYBP/UsO0glU7Je+yqYyEKKREL
 eZuCnbk32maCxlnrW+wNk1fbACuRsRWVT4OsDOnHmr8wW35Xtac4Gag0z4IPbty8tqA7exVWTQy
 Kye+DkP+MbXFfVPI9jj68BiGb0ieDqLAv56aFD8OzqHTuYOYzJeio0u3wjytgywHZ3oLk///i0S
 GL3+nxet3fLsRcTUxgkpBniw4j4/Gil5Ap5Mz5XsJZpJtjhDdDbIjpOUU8R3RAifjPBMwYctIBT
 /slnifzJEOeXiTsawS47rn5I7xxbi2Ap56PBtCQG2/DFdXbPYSY1WMnqz3dEZg9XSsTU4eD6Kpk
 okpG1OOyDh6OGvX4mPXkPyHqBgt4jZIcmMr893OlciFz789qKVDkprAvy+loTn658OxJ1Gkov67
 zS/ebxGcBQE3fnCV4oUQyCm4OGlRW6Na71rQEf6zyq7VOS8j0FnLYGTDT130Kf0VnJjs2hUDwIY
 JL/XuxAKXSQBjePyYvTXKb+mJszK42Gs3vqsw==
X-Google-Smtp-Source: AGHT+IGT/X2RrQ1H9qnYbRhBT5zx3NYQDJj9OKiX99ZpguIv91T/J2Dg7RdX/rUUmeaRXi5C6NRXvg==
X-Received: by 2002:a05:6870:d10e:b0:3f5:4172:25 with SMTP id
 586e51a60fabf-3fda5924993mr21850151fac.58.1767396226632; 
 Fri, 02 Jan 2026 15:23:46 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaa4e0d18sm24711983fac.0.2026.01.02.15.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 15:23:46 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>, 
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
In-Reply-To: <20251216084532.613791-1-ghidoliemanuele@gmail.com>
References: <20251216084532.613791-1-ghidoliemanuele@gmail.com>
Subject: Re: [PATCH v1] toradex: tdx-cfg-block: add pid4 support for new
 modules
Message-Id: <176739622569.296893.9625293977807052788.b4-ty@konsulko.com>
Date: Fri, 02 Jan 2026 17:23:45 -0600
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

On Tue, 16 Dec 2025 09:45:28 +0100, Emanuele Ghidoli wrote:

> Add new PID4 to ConfigBlock handling:
>  - 0217 Lino iMX93 Dual 2GB IT
>  - 0218 Lino iMX91 Solo 2GB IT
>  - 0219 OSM iMX93 Dual 2GB IT
>  - 0220 OSM iMX91 Solo 2GB IT
>  - 0221 Verdin AM62 Dual 1GB ET
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] toradex: tdx-cfg-block: add pid4 support for new modules
      commit: edf95638e20c276f1eb8be16364fa5cce4793a2d
-- 
Tom


