Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC86C369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 19:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69C4A84236;
	Fri, 11 Apr 2025 21:16:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nX9vMQTo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F5FC8422F; Fri, 11 Apr 2025 21:16:50 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92EDA8422F
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 21:16:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3f6dccdcadaso1437616b6e.2
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 12:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744399006; x=1745003806; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQdBuKovRB8JgnlXkp3FBhuzQ1H6omaa6003+i4/qWw=;
 b=nX9vMQToD8vqYxZGY9pUH/pbTAB1IczyGnWA+qktypalO9vytdErWZ9HVcIFzSq71U
 xQ+HQ3fNs6aL6e2IzoMbHC71JIQNRB3SDlolwsFzhhULp8KBO/1EKxaN0Xr94OH/DjyC
 YmyXhi+2wAWZM1BMb8W6/BSUS45zCJYEQ6PLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744399006; x=1745003806;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CQdBuKovRB8JgnlXkp3FBhuzQ1H6omaa6003+i4/qWw=;
 b=Zqe/r6id1A4rZlpgdtsEVln50uO39HE/90i07lJYXJYVaHgZjLqO02/Zhw09OfQ+qQ
 F+QO8GckksLg6VmSRpYa6vm3MIMSeB8O2ArXMYg7Y0ffuSRlR6Qzic7ygfFLeQTkHIoH
 uz4BmuIfVF6MKqtJVozSS0/jY4buIsVwLUWRSpSnzBXovU3f+NTQTO7vRH5fCcuammQA
 nAyV7swOwdAYPQ6/PODVgh9eLvawLnhvXYw8BEMCpMk73S/22jM2SxWPE6fZbzCRNJOo
 CGLUWKsatsPXg5C0+ZVGjpr1ArIAuQsZ/uUyVAMTYBMR7psMaXjM88SoFO+QhoiKSyqF
 kEdQ==
X-Gm-Message-State: AOJu0YzFq07zr6UTd2h25Z3wzL4k4LhuWYxCSFNHCTRwXVS0qKC3Zv76
 HbHNjtWEBTOHyxjI9pkcGtruHubxDZ7HB2WA1nGwF9lGiiG6xNS7NptIZHErhdY=
X-Gm-Gg: ASbGnctqGT284/zovY3V+Y+e1SMevpi1QU56cIoiy5afqNuF19OlOYUV7i5Ltw2I3hq
 TT8FHJiEhx9lqKsim9tx8sVD91gYKx5wd20ckPDIgmZzAnFNXZEejdD5VexKvuS3qcrda4tNQ1f
 FQfFuO6HOFZHmbHd7MihqbQxwd+PbPnjEtRw0Sj10EjMzJrvZtJ2CT+ov+n+hHV7KJbW1DImHPA
 Z93ci/5cJDMD7BUhyAME/wxaS3P8NPYIQfSB0X/wHgQwbYlrEH2nNJ3K5QlU8KEsH+nPHJMW2WK
 fHuSVEPDQOkAK4UyEklY9uO2I91KdhxgLbeCZ1vUxBfrRNXjAz95FB/fA+KIBsWgRbtZhcGycLB
 B
X-Google-Smtp-Source: AGHT+IGMtU6qDC+wHLpj0Bpy1twKROEbZ2MuVS8fpiR3eV3TvlGxYeIcmRcrqBA+Q/ky5c0upjZkqQ==
X-Received: by 2002:a05:6808:10c3:b0:3f6:77d3:2546 with SMTP id
 5614622812f47-40085042da2mr2302771b6e.14.1744399006340; 
 Fri, 11 Apr 2025 12:16:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-400762cc752sm1043970b6e.20.2025.04.11.12.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 12:16:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Leonard Anderweit <l.anderweit@phytec.de>
Cc: sjg@chromium.org, festevam@gmail.com, marex@denx.de, 
 upstream@lists.phytec.de
In-Reply-To: <20250401084642.216933-1-l.anderweit@phytec.de>
References: <20250401084642.216933-1-l.anderweit@phytec.de>
Subject: Re: (subset) [PATCH 1/2] Dockerfile: install byacc
Message-Id: <174439900529.3262324.12771408961407370638.b4-ty@konsulko.com>
Date: Fri, 11 Apr 2025 13:16:45 -0600
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

On Tue, 01 Apr 2025 10:46:41 +0200, Leonard Anderweit wrote:

> Install byacc required to build cst from source.
> 
> 

Applied to u-boot/master, thanks!

[2/2] CI: Build missing binman tools before binman tests
      commit: 1e5e45983d80776426d4b4e467531b29f52cbc4b
-- 
Tom


