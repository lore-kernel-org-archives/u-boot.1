Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610E6C27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 22:04:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D592884F9;
	Sat,  8 Jun 2024 00:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c01gLYff";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FE7E88485; Sat,  8 Jun 2024 00:03:51 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 616CF884FE
 for <u-boot@lists.denx.de>; Sat,  8 Jun 2024 00:03:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-245435c02e1so1352167fac.0
 for <u-boot@lists.denx.de>; Fri, 07 Jun 2024 15:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717797828; x=1718402628; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6ZSzBHzQ9SLkonr9XRgN4s2+hnxER7tfF1IMaL0cshs=;
 b=c01gLYff9kKWyIIjnH0+ADphCWu9X+zeiZtSxUuBcImBURJnxxD8D8HyPYU1lih6M/
 ft5kpq/JAVoai8N4Ty/Jy0LRZFhBz2iqRyS7bqoz2SEiuRTXz577gfSFovJJwdZ7i27C
 ASMEVaXvHcJdTxorkn3+m+fMMCnZLDLWXjcko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717797828; x=1718402628;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ZSzBHzQ9SLkonr9XRgN4s2+hnxER7tfF1IMaL0cshs=;
 b=RwQCMledAaFV7GE/DA0NoMvjF+N+aHzdUuTXPmEpyjRlJaPQo52kZiC7Nt8+AJG2oS
 nz4QpYSk/ZDD4U1snRjMSThs1csTKK03W1i/3QwpuAAoIL4MF2WQLbMcMy6khiK1vYdR
 wXv8tsw59U0EsOkossX/oD1lRmQByPrssTxlwBFXgLi5cz/dDGTL6HsZE9cu8/PmyHnG
 yjCzAXI8OfLAFriqrGRjI6xM2myY3F1fptW8e4vu197QKK+LP6RJI98kgBne+QL1ILv8
 1sx6mVTQRvz8eC5w/6P20AK/ltDoPYktFBUpdNiUckp0TazQCzA0VNp7TBkptINMRjev
 jDfA==
X-Gm-Message-State: AOJu0Yw3YeJZ6yOTQSRMpkiZOt9ttRIp8swVOMz5NgaMiiAulKTJimWD
 RjuPeswQTjNmFC8xrAqtlrPJzn03ePZlsBbGXOTeeWio5OQEBeG/3ETDMxWnLWM=
X-Google-Smtp-Source: AGHT+IGzlzii9bht0Zal1LIbe5BYPBxEAUmNr5HhaiybhlhoFhUk/Mkahibi0LAyQcUmaoHWk/wTsQ==
X-Received: by 2002:a05:6870:d106:b0:24f:e49c:78b0 with SMTP id
 586e51a60fabf-254646b8ffamr4244472fac.49.1717797828060; 
 Fri, 07 Jun 2024 15:03:48 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-254951da4d4sm58415fac.47.2024.06.07.15.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 15:03:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, upstream@lists.phytec.de, 
 kory.maincent@bootlin.com, Daniel Schultz <d.schultz@phytec.de>
In-Reply-To: <20240522072100.602612-1-d.schultz@phytec.de>
References: <20240522072100.602612-1-d.schultz@phytec.de>
Subject: Re: [PATCH] include: extension_board: Increase overlay file name size
Message-Id: <171779782711.4156831.16414700390147685441.b4-ty@konsulko.com>
Date: Fri, 07 Jun 2024 16:03:47 -0600
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

On Wed, 22 May 2024 00:21:00 -0700, Daniel Schultz wrote:

> Upstream overlays like the ARM64 TI
> k3-am625-beagleplay-csi2-tevi-ov5640.dtso can easily have more then
> 32 characters. Increase the overlay length to 64 characters to
> apply overlays with longer names.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


