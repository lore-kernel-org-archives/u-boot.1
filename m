Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2C9CA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 18:48:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A53DA83A2D;
	Thu, 14 Aug 2025 20:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="O+9rylDM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E873683A34; Thu, 14 Aug 2025 20:48:34 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D90EE839C7
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 20:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-88432ccd787so65567639f.0
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 11:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755197311; x=1755802111; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tvgMK/AFyba3sFSYoO27NobTkDmWX1QbH3ELuRrSEvA=;
 b=O+9rylDM5+6MTHc1bNkjasHochTtQObwloJ6SxeSC9diGe2lwQ31TRLJP4T6RmxVOx
 5phWUbNPpOochRj9LKQwAbNc2TB9fwVnHYSTth06heDzXWPO9tCRRy01xRUrFTLqwBH6
 yAINGP527/3NDvdInKDajIBvSbQmALWmRMe48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755197311; x=1755802111;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tvgMK/AFyba3sFSYoO27NobTkDmWX1QbH3ELuRrSEvA=;
 b=qKufpewfvK+Dmy49u1JjPSJoiMbrD4l8VgdBNWidnkBm7UW2D68aoBqhUZMuTLJo75
 4dCRajLBIYqVhd8WXvkklBb95MuKI1iCa4Bsi4NMGBulS3Vz57HRui8vEqnac561NRXE
 ZvH/TKSid7e98PJ4gErWi4mbiHZNf/T5+o98E/mkZBmSPWe5NZJbPpgP4TY6Kq3Kep0Z
 9tthL2Maw+4Zdvo8mku/O64kg8BEbUJXRBs0rV4xbr9h1lMmjCg1uCw0UsK0yDzsvITH
 0WFSrUu1BJq+qnr9PbIJr7jbWC0L3tSZVd9jRFrvuZVGOWG3P8RDosGTjUIjndUPRkYC
 GW4w==
X-Gm-Message-State: AOJu0Yzrr4o+5oJSDrNlvJgpRrxSv2DzCxWes5zCR4JITVwMwgddbJio
 0ujw5p13FXOu5t4/LpOuCRwMUr0j+J+TKVl2gLhj3kXdwNxiOkYicZIrBuTu1w02+FXgEc7yMfX
 3mlC/R1g=
X-Gm-Gg: ASbGncuQjGPvDAqaesjrERW9eV71Id9VPnFwmR5AuHUV4uRN57EcLkz1Ls/fJ0Nv12D
 AwkehVWM/XwB1+M1s/JWVKzrkouTSoX19QaL5wyN9ZMZRWXywK3zV/IW4Awc9FBOpSK0dYelXI0
 gnyVTvGUTtygDAifGOmuXqh1FOnd5pq0+oQM0DWRXSB3SeH/C+yo1oUjiJlP82V3388vwDgWfnz
 k3LsQuX5TeK8N59pXmYtGNAQgMX6m5QhN5AF6xOZajRoTmgrLYOpTjdcECnxzYSkNIgiWAl4tSw
 nwubqCixEPE03aiVThsf2E2FQV3/seZkXVFyrFbyEfAVPdnHizeVYLcs3oR6GcFuHbfOIyeN8j0
 Zwg7Jo7fqIEjBT0zBXsrGyPZ078W8RXcIYqKikVCh17uCPxnAvT40sTU=
X-Google-Smtp-Source: AGHT+IEW7PwaFR92pvtUD/jaIvBiK000V9cbg1lGYPrLpqcke8bBcwrvmHFAboMAHdWbho4j3/gzJQ==
X-Received: by 2002:a05:6e02:188f:b0:3e5:42ec:1372 with SMTP id
 e9e14a558f8ab-3e571e2d63emr70972515ab.19.1755197310888; 
 Thu, 14 Aug 2025 11:48:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50b3d6ff137sm1219762173.41.2025.08.14.11.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 11:48:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250804-e1000-v1-1-2b181911e8a4@linaro.org>
References: <20250804-e1000-v1-1-2b181911e8a4@linaro.org>
Subject: Re: [PATCH] net: e1000: Free temporary buffer on exit
Message-Id: <175519730993.3600102.9886861671435701871.b4-ty@konsulko.com>
Date: Thu, 14 Aug 2025 12:48:29 -0600
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

On Mon, 04 Aug 2025 16:32:51 +0100, Andrew Goodbody wrote:

> In do_e1000_spi_checksum a temporary buffer is allocated but never
> freed. Add code to free on exit. Also refactor the code to make the exit
> code common.
> 
> This issue found by Smatch.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] net: e1000: Free temporary buffer on exit
      commit: 4266b8a2839f4e3eee2d7ce5f61af0c0ed0fe3b9
-- 
Tom


