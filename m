Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58BBCA0EFA
	for <u-boot@archiver.kernel.org>; Sat, 23 Aug 2025 21:14:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01359800D7;
	Sat, 23 Aug 2025 23:14:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UKiG35L9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1BAB82998; Sat, 23 Aug 2025 23:14:49 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8500580077
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 23:14:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3e6666a4f55so31955935ab.3
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 14:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755983686; x=1756588486; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1NzNCdngSLuq48FAxVcY+8saPER/R2JqWqr5OphEYQY=;
 b=UKiG35L9X2e2BshxRkSoQCABFuHHJvhvrDp/1GG9XIvAPBxV75em3gGD1v5Zw2GYZ4
 Devg8LtQRKdIc0JyB3KcP0CLnQmP7XRk0HI4jakEhU7+cWNnOBfbzpLhkyQ1sNEbIAke
 pwOh3Ffw/FMhvYUQYaO7wbUKGerSoZ55B7Pgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755983686; x=1756588486;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1NzNCdngSLuq48FAxVcY+8saPER/R2JqWqr5OphEYQY=;
 b=RHJJI9AIUXE+S41ZFcpAwJP0EAxrl5d+59REG6tSTFY8fOun8EwJtNBqUWy5VP6C5W
 avvGugRmullhaOL3lP9/JyNA4qiOukq+3MaIdci7bZ+LnEPqAsHW0kJa836EIWeQFYKF
 7c/7PA4nDcq8aUph74e3iH21WS6niiW1BsXXXG53EZIdimJXo+JF/bRYnbfwheqKWnRI
 KSDVNhZmd1Ju9WJTpXrT86uhzojOraLinnskd5pOQiuozfvoi8Q4ztahQjO80Cy4sz9G
 ZOWfD2oAtff5HyDC7iBxS1fbUyIR+F6t6A+NNaE4LgENmu+MUT+8c4Yq3f2ArUOin/YD
 nFdg==
X-Gm-Message-State: AOJu0YzTcIaijL6b3T+CHzr5m/7DIKjr2sYlEPEIoTjqKwAoaSamkkZ8
 TfBnQbnX/vCE1mVS4KIODS0CF8ABwrMTDhDO4XsagVxjCROjCT89erSEDOLZZ6CkwLU=
X-Gm-Gg: ASbGncvDj1L/529S9qMD9F9ABug90eK7x8W9qzo2hh7g/jXtkMp5IcL4JENyP4Y6xPE
 Ut1nVcCyEJ4sd3PgGXquunlIweAXIYyV0u7ElUq7ltTY8LOv9EUiYd9g6FsjJC/sEuxt2ehiegy
 bvR/wanIfNL3WvX46NwCSTNH9m5W/eMUR/zs3hB40JVWyKBSHuQpxmo9mXgIJQ4Sn4kqV2Q7Y38
 0PWm/2VdlMBQR63F77RmIP1s2oygurLUSmbXIQlrqcc57VCurZ2rhdpp+xi+3Xx0ISIYn6+sGwc
 cUwlA59rZl+zkT3ZKib8DubZBcm6srPBVPHuehi5aYMcJv3LX47UWuSU1Krwp9K1KZwVthmKsYN
 EeUcrHha+Y0tjDUKn6a7rUFV3BDSMD0sbMqj4jCbhD6VmqhtgUGqvbdQ=
X-Google-Smtp-Source: AGHT+IHbFZhuF8/SRqp8aaEX2RsThzytSaLUIVRY2O05IYO3kNordg+54wRSQm5Zv6XTxcsbhED1HQ==
X-Received: by 2002:a05:6e02:3790:b0:3e6:6b01:eb1 with SMTP id
 e9e14a558f8ab-3e921f3b624mr104161645ab.17.1755983686230; 
 Sat, 23 Aug 2025 14:14:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3ea4c28624bsm21423305ab.18.2025.08.23.14.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Aug 2025 14:14:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250823193307.290885-1-festevam@gmail.com>
References: <20250823193307.290885-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20250823
Message-Id: <175598368464.1246629.15870696307418930173.b4-ty@konsulko.com>
Date: Sat, 23 Aug 2025 15:14:44 -0600
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

On Sat, 23 Aug 2025 16:33:07 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/master, thanks.
> 
> The following changes since commit 94e690c44a03959c39f0f5a44a9b89c851af3b60:
> 
>   Merge patch series "bootstd: rauc: Fix segfault when scanning device with unsupported layout" (2025-08-21 15:05:15 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


