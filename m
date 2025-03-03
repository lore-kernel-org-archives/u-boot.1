Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087D9C282C6
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 20:20:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15E6181249;
	Mon,  3 Mar 2025 21:19:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="crbz/L6R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB2D180786; Mon,  3 Mar 2025 21:19:46 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2BA6811C1
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 21:19:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6fd3b6a6a24so33186167b3.3
 for <u-boot@lists.denx.de>; Mon, 03 Mar 2025 12:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741033183; x=1741637983; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xY4t0JHPagdy6TlwnURiQjR0Ms0Om/CjYuWKPsZbrR8=;
 b=crbz/L6RvzEok309K/sjjlF+g8HBVF/GTmg2+IeF1KxC9f2X34/jAbis6tsvDSBhFm
 gLDtAE/zZ/alDHJmr5RyJrkQVPUMsTdN/J6/CSy8Ne2ZY5/+/mt/SxYNHfMm0vDP42t4
 0SDFD5iVCjV0YGn2i/K7y+K6SV+N8TSelr4RM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741033183; x=1741637983;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xY4t0JHPagdy6TlwnURiQjR0Ms0Om/CjYuWKPsZbrR8=;
 b=rItNTMwWCVK7A1r5XRNqPQJc6VUpJ7jmYCUX2aXnGaPk9c6/LbqS3IQgmm0ylvri+7
 8wA3W67M2vdvpIgLkn0ajA8FmFZTBNIENm+R9GZWUfLELwaGglF4tK1j+xHklehGC9UZ
 zLZwPeSgCi513usXi1ADYv/O/hfwjQhSLhAH/p9ONJ1SVTypfgkegic6Bn9sSiyyNoNZ
 QV4n7R89UCzI2CYvpHww8kMf5I3htCtOcOPMLDGT0HAwXPF7uz0JqTEvXRrCD3A+IeZb
 TRztfcGEYnBFKUXR0hebG/NeHfpYcRQG27xQ+tpYiNdMNS12BZ1alPSSGdxlheqEZVxk
 D+hQ==
X-Gm-Message-State: AOJu0YxNnR5PPMCG3r4HrtKisgN4wOy0isryIRau/6cYsaRd37XlLpva
 LCXXOzeRVRQptRvLgh2w4vSH8eTGOjrJaHP1KF4XE2k9kR24ZS9H/lshRZUBn3Y=
X-Gm-Gg: ASbGncveSAZw5JllTWSedCKPZcpjNUWOD3Aos03SI0cO3LUPEy4eznSUGH8Ro8GIqba
 8QXHwnZ4SxV2T++gfxJI4CV4qaPl60cUK1htq5LK/HKsKzrkgof75SH2UGfFfAffUde4oXIjfnI
 cOOEIjWgysNwZ4z3eWYaH+7gbpog8oTsk4DRm+RG+C4Ewj46NYm6TXS83kRpgNFNvA+Jev+FdE0
 weR2e3J5/gOf+VKX0IAsGxusjSMGxHjHh6HpydPllQ3gADrb7RX3kN9hO51/5tf+qzx6rxgF6lT
 dGzKXhIiz/SbT1w1I/1KDq06KEr7U2DL4AKeDZimvw==
X-Google-Smtp-Source: AGHT+IE4y4Weq09YXEgH9pj7p/s79wLSwhFTDAfke41c6QZJsVXcfVFxOJ3dNgO3NdFdHZTJxVxVqw==
X-Received: by 2002:a05:690c:6c01:b0:6fb:9280:5bf4 with SMTP id
 00721157ae682-6fd4a0c3d12mr201159237b3.30.1741033183662; 
 Mon, 03 Mar 2025 12:19:43 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fd3ca0ef34sm21389077b3.6.2025.03.03.12.19.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 12:19:43 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20250221203243.672465-1-sjg@chromium.org>
References: <20250221203243.672465-1-sjg@chromium.org>
Subject: Re: (subset) [u-boot-test-hooks PATCH 1/3] labgrid: Deal with
 strange Python error
Message-Id: <174103318277.1518351.1970213948242640285.b4-ty@konsulko.com>
Date: Mon, 03 Mar 2025 14:19:42 -0600
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

On Fri, 21 Feb 2025 13:32:40 -0700, Simon Glass wrote:

> Add a way to work around an unexplained Python message which appears
> sometimes with Python 3.12.3
> 
> Make the file executable while we are here.
> 
> 

Applied to u-boot/u-boot-test-hooks.git/master, thanks!

-- 
Tom


