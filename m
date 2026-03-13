Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311E1107BCEA
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 23:40:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FA248439E;
	Sat, 14 Mar 2026 00:39:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YjPeFJM7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B9C5843D0; Sat, 14 Mar 2026 00:39:55 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9A2084348
 for <u-boot@lists.denx.de>; Sat, 14 Mar 2026 00:39:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d75d698ee6so1589081a34.3
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 16:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773445190; x=1774049990; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PBjpN/MeB38MKNUT9w9RbCURUejXCIKEkqRbkp7NaQw=;
 b=YjPeFJM7CIHBF5G7K6ufcaB7LtIHvr86MOsZYHdUUspz09J1ywZXbqL+IlYE2GuuMR
 HNSQo6Csafui03ge2JlVPoTMPrCoeRykNpHGoWEC+yDNGdavQ5f5nQiRaKFii+q4lmKV
 MA6bGnpz2kdVuyye//5chsvXkFBwuTo0RpOqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773445190; x=1774049990;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PBjpN/MeB38MKNUT9w9RbCURUejXCIKEkqRbkp7NaQw=;
 b=obpGAVwU7KRDLGzl2fyP4rQ6UIUHMWJ6FPe/vdwZt8rwTspvVkeryAv+8gr5dieHeT
 hVb1tPMyqdDkUs3GC4R2kUu1XAhhg8KvEFSeNMvMcIdJD8/bOByZ/b4TP27/4VF16NNp
 a4Zwt5C1PwgXCiIXhchj5oUpa9jpavLOk+aO8goFtFcvIQCaq+zQGqQpjE9+PwcSOM1b
 ugtsoecARJHUjAG4VB0xX1vOiFC+8TFlQC69vq3AYiHIbixRjwvwlLhsls52RwxrKAPW
 /udw+h31pPWcBSRdW72svmV+zA7v5G6296hXkE30h08Sln394YOi4Ju2aV0NJWcEE8P/
 hGbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHhtCbRL1jkTwrzBhG7CSFPhfsX+wNzcNG+giBJuzZqEt/hFGB2k8eF4xOoZhaHQJq5xZkwVU=@lists.denx.de
X-Gm-Message-State: AOJu0YyHJfFeaPGHl6v7XU3WlJi8t3I6O1MIGM+MBv+DcDa2fsaOqYZW
 OgDocYkelJINmC6DjhzYIknMfRDdap1imaxEuqflgAwXvXMZi60IFXTjamGkfS2tyQtC9VJETel
 uITPflfw=
X-Gm-Gg: ATEYQzy3eNKPHDGkqi70OOTF82lLOvMhOn495tpHmP7hNVYMmq1GnGuA3ijmnVEO7hC
 Fxjzhkjxr4a784PtLNXZOdJthBCwoiZJFNvXelqGw9H05OhAWFzLgA3GVJNdXvfcWlqKb2f8YXt
 dyHK8ZHXsYxuRxYieQ1zcCj0WL7/ENOi4GbAwXe62A3/rs73LP0oo8jPTS4zIkFAP4X25CXccTU
 b5+m8gRmaxEWmjmoN7c1V3C/mRS65kmJCMfUV1tN9Chj/zVdA3d/rDC4kEL/lhYUXWV8gtBZ2Oo
 GaF6mgNZsrf+6ZpH2BdArYsozSBJ84/IV95JyDfFb2O9DWmhz/n44pE9NTOhvQcp3kAf6Lw2ZZX
 p/8XbZ+SsO2MkIkUGjV4KJgFHAoXD/EBCBiIilR/+XUhiIm32axd0wZjVn72K/slcP6/KRzktt4
 tbo2byrzsIomGi9hlbTj8nfUbqgOSDxmNJ61a9BS9EQ8EzEqMb0AQT88VawUbzNm0MFWiOlk3UE
 No7prDdCtg4thXSCBmM0AsuCGsnDgBFpoUaT7dXURVla9g=
X-Received: by 2002:a05:6830:3805:b0:7cf:db31:1b7d with SMTP id
 46e09a7af769-7d782449a47mr3742429a34.5.1773445190666; 
 Fri, 13 Mar 2026 16:39:50 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76aec4c8bsm8096892a34.25.2026.03.13.16.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 16:39:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Harsha Vardhan V M <h-vm@ti.com>, Bryan Brattlof <bb@ti.com>, 
 u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20260226-k3_fuse_fixes-v1-0-86c81c298bc5@ti.com>
References: <20260226-k3_fuse_fixes-v1-0-86c81c298bc5@ti.com>
Subject: Re: [PATCH 0/4] Minor fixes for the k3_fuse driver
Message-Id: <177344518937.1178192.39614125846686116.b4-ty@konsulko.com>
Date: Fri, 13 Mar 2026 17:39:49 -0600
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

On Thu, 26 Feb 2026 11:18:11 +0530, Anshul Dalal wrote:

> This series adds some minor *non-critical* fixes to the k3_fuse misc
> driver in U-Boot.
> 
> Regards,
> Anshul
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/4] misc: k3_fuse: Fix printing of error codes
      commit: e98e9b1ec9be918c9c607a414e6121f3163adc49
[2/4] misc: k3_fuse: Check readback on fuse prog
      commit: 494782b6e0e5cfe12274f57ef7a8028a665957e9
[3/4] misc: k3_fuse: Enable fuse Sense support
      commit: b533d457aee435b4c19505617ce5a05be6e7255b
[4/4] misc: k3_fuse: Limit writes to 25bit values
      commit: 34c7bcacfab4a7efe83e0bad259fadc145be0046
-- 
Tom


