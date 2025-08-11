Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530BBCA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 22:21:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABF6D83335;
	Tue, 12 Aug 2025 00:21:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k6jhb5so";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0082831C5; Tue, 12 Aug 2025 00:21:04 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99764831C5
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 00:21:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3e5429b9c37so22050335ab.0
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 15:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754950861; x=1755555661; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EOTm3prs7jV4+KIcocoxF4tGvA3Rr9Z7CbongYHllEc=;
 b=k6jhb5soSMqICFsvdtJXFEK5xRcX+LK1OUAgUBfGOcE8YJm0H77lV+e0Y4kpwuln1t
 C9mnuI0ZQ19S3aNneLt6rgeZj/2oB55nCrC2wnRaADFHMz5X7kBid0fIsQT/bShKc1kR
 hYQPkdGgebAsrqLDmv3+ZqV0xKj5nK6JDaryI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754950861; x=1755555661;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EOTm3prs7jV4+KIcocoxF4tGvA3Rr9Z7CbongYHllEc=;
 b=lEyUhlCEsF+4lIKxbYG/3+ZRyWudmC9uaM2cLsbccGJsQzUXvw+I10AGkj39XvvSR3
 eVolc4tYSRu0C0iJPS/ItlxQBWS/Lco5ckxb72QQavV4zHwFd2/C4M6tu41oKSCWC7vA
 ukmhZi+DfuDoKbpj+qzIcLAuQlPqUuX71FpEhUog1zPHi9EGt25zpOTP5xN+JXm+T9ru
 dIrg8oQUqqeQw+eE5W8HLCmGNtt3FfAvheg00irKU9220X1eBXJ7fkTmEuW2dOGxyL2c
 7YEXGcXSyD/4vNf/04S3Xq8m/PhWBPRgJKM+ODDP6GGEhh+qPwI4cRwy1yi/QPMgke1X
 EHnw==
X-Gm-Message-State: AOJu0YztHGIuJ69MmJXO5+S44WUWsaGAfHYZcx3hf09G1b6DwMxkW07h
 sDlrUSEACRuHJvXSM+17qTplQsUoTbO/XqSRVUC+CYulzKpx+zLZeuAGtp1ZKzkh8pGZheSr0j4
 19q8WAEM=
X-Gm-Gg: ASbGncsdF6syesU9L504VYd+EfXAMxrMH3ztQuR0lauGH2O5n+o8DvoqYEtD1kmoNZ3
 IuWlToTOXjw9p5mVUW3aFU+X3Gz+vdI8DOLUHKpetJjbci4ludZ34+50TRhppVxEXQF5wFJAeTZ
 +1MkTZjDptlElmiEopHyylEFD0epP0coq4ZMuaMoK1+T/KDDPPjiaC6YEgJ9jA0ffys6+mkw/UR
 21JUGd+Q/S4uCITTvFlD/YM7OX3u4L+pN4potMnMeIDFjG4DXWCYZDtWMyFtTKCK7XsvcRSd00p
 QwJRtMREQXY0wmKLZSpNRk2OOn4stAkUonjnAN1m+swqifFO8DyzTGbPOs435pDqSHnAKHDkhDM
 kCxdyjKkscFozUnwgjalXh8qCl2QOYKfaiEKxX4J6NvRMmtN6yNegtnHt/9xu1yQEUQ==
X-Google-Smtp-Source: AGHT+IHFPoF2eoKz+cRp9i8OcAV/1E4jSZWww8vH0+Flsl61LQ6HfH4BZMMKj5cr3bp9EQCLhahofw==
X-Received: by 2002:a05:6e02:152f:b0:3e5:5a03:c8fb with SMTP id
 e9e14a558f8ab-3e55afb9265mr19521555ab.14.1754950861414; 
 Mon, 11 Aug 2025 15:21:01 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e533cdd3e6sm42092725ab.55.2025.08.11.15.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 15:21:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250723-cdce9xx_clk-v2-1-3ba5a5bdf6b3@linaro.org>
References: <20250723-cdce9xx_clk-v2-1-3ba5a5bdf6b3@linaro.org>
Subject: Re: [PATCH v2] clk: cdce9xx: Fix use of dev_read_u32_default
Message-Id: <175495086051.1657597.18258689363296150245.b4-ty@konsulko.com>
Date: Mon, 11 Aug 2025 16:21:00 -0600
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

On Fri, 25 Jul 2025 11:41:12 +0100, Andrew Goodbody wrote:

> The function dev_read_u32_default does not return an error and the
> variable 'val' is unsigned so testing for >= 0 will always be true. It
> looks like the code was attempting to return -1 if xtal-load-pf was not
> present but that cannot work. Instead use dev_read_u32 which returns an
> error code separately from writing the value into the passed pointer.
> 
> This issue was found by Smatch.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] clk: cdce9xx: Fix use of dev_read_u32_default
      commit: bd644d9613ee0cdc3bd2ac3bc7bcc52b09d821e7
-- 
Tom


