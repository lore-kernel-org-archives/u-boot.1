Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65592C7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 15:44:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2456882E67;
	Thu, 26 Jun 2025 17:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n8gwslkD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C4D082C4C; Thu, 26 Jun 2025 17:43:20 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46F4982063
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 17:43:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7387f21daadso1201771a34.0
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 08:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750952591; x=1751557391; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZBUMvX2PrvSK8GGsUQTCzkQVUPB+CHTyE1kQKh/dzCI=;
 b=n8gwslkDAjLSEOXIqFetnfnb7Ily20DXcgMs5c4xp/ZFFvtBYc1hyz1Kek2ha+bVtX
 XjKfJGbv3mP4m0TtQKba/PcUcJed3JwRqDRKcIm2FKhalM4r87aACREIh03O0P93Vb/M
 xZsaEJnAzuCL3ZecXUL1osfKnGJoUf0G8jgS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750952591; x=1751557391;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZBUMvX2PrvSK8GGsUQTCzkQVUPB+CHTyE1kQKh/dzCI=;
 b=JWjBDvfytnB6ePgtq7LqE68rw4ilWrRcNh7hOHI3SJZ364ox+OmjG7y1ZfigisQdAd
 ZZWle5RwCqvweuH+BuYvT/TReU+HfosykGGXXT9lDCAKMZHhW1OuVhYf9kROCSx1hxPM
 HdS3BQJtU6o7NVPmmRadazZD/2Nweda9l6WhOKWTqcsucz+OQpwkFFHhrHz9n5JM1D2z
 VkgcNAI4i6OO/yYiLohnV63rLi59Y1m2apvuCVpRp1ZRbF6lTouZO/5ZMHtntfVA5f9C
 Fg1iWGbACxtgxTpkYiMDiIThzLPF5HXllPTcz7c861JHZCI9AbAiXoOc6JEtH4dkjzWn
 24pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWbxAdDnTSIR7j+yU7R6DLEJOPNM99VF+XYSOYLPqJABtBnVsLP4i3P78SJxbSYr0hFMjZP9I=@lists.denx.de
X-Gm-Message-State: AOJu0YzfCj14YpikAovM4N2xvJUt+Osj2vlSXd+j4iWIYHW+NXzTDj2O
 unfiqXLGfKBhUs7CxYjgDOFflwQnnfy3HQvYU8kXVonufuNCmRtdtk1xymQj+Zy3skIhI7YXEC0
 EahkZ1Oc=
X-Gm-Gg: ASbGncvNn1zQlp6fVPoTNWCJPOSHlv5W0gS57d/sf+kfiN/A7n260JxvnP9P/54DIDb
 gIs0msDf3jhfr31A+BLTOxzJeMBihnGa0O9MSWFnBWnFfA4ExPdQPvztyIp3LngWYJPWzfkX85h
 0pgaiVC674nc2CVgEOTcGjo8wifh6sR1Lwc4Z7urfPL9IcEbrIwoHJhyPpHtmUTf9YA+bKzWDdS
 V8Afn+RTVPEifuQe2c54G5cg6heWX/cL4dNoWokb099Ksj+fipwzUZg/VtJlTE8E4FqIGDUr9Co
 CY9TOSHS0EqI93RmdsjJkFnSqdVm93i89+7YCg50l26kKmXRYdWCKoboLGwXMusnG6v/OfolDxb
 +47m5BvFAbxChnpSL9a+IJw==
X-Google-Smtp-Source: AGHT+IFhJWsx+TUhwKThz1mJJbgOd9/QMM54r7XDOIgE+lSNs6jmI1dn9MMjNCeF4SjB2wugf9I00A==
X-Received: by 2002:a05:6830:4909:b0:738:5294:785a with SMTP id
 46e09a7af769-73ae9e015a2mr2224263a34.6.1750952590924; 
 Thu, 26 Jun 2025 08:43:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afaff2429sm20316a34.7.2025.06.26.08.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 08:43:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: b-padhi@ti.com, m-chawdhry@ti.com, afd@ti.com, hnagalla@ti.com, 
 j-choudhary@ti.com, bb@ti.com, nm@ti.com, vigneshr@ti.com, j-keerthy@ti.com, 
 u-kumar1@ti.com, u-boot@lists.denx.de
In-Reply-To: <20250609102706.2434495-1-n-francis@ti.com>
References: <20250609102706.2434495-1-n-francis@ti.com>
Subject: Re: (subset) [PATCH v4 0/3] Add support for K3 BIST
Message-Id: <175095258992.1712035.8213141342652238796.b4-ty@konsulko.com>
Date: Thu, 26 Jun 2025 09:43:09 -0600
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

On Mon, 09 Jun 2025 15:57:03 +0530, Neha Malcom Francis wrote:

> This series implements a driver for the BIST (Built-In Self Test) module
> for K3 devices. The BIST driver must ideally support triggering of BIST
> tests, both PBIST (Memory BIST) and LBIST (Logic BIST) on a core. Both
> tests are destructive in nature. Please see links [1] and [2] for
> further information regarding the two.
> 
> At boot up, BIST is executed by hardware for the MCU domain
> automatically as part of HW POST. So BIST has been checked only for the
> MCU domain when U-Boot comes up in the usual U-Boot to Linux boot flow.
> To facilitate the use-case where some safe firmware is intended to be
> run on a safe core, it is best to have triggered the BIST tests on that
> core. As an example, we take triggering the BIST tests on the MAIN R52_x
> cores. The triggering patch is kept as DONOTMERGE.
> 
> [...]

Applied to u-boot/next, thanks!

[1/3] drivers: misc: k3_bist: Add K3 BIST driver
      (no commit info)
[2/3] arm: mach-k3: j784s4_init: Trigger LBIST and PBIST on MAIN R5 2_0
      (no commit info)
-- 
Tom


