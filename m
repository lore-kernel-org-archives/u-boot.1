Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A492CD13DA
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 19:55:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F5E9844CF;
	Thu, 30 Apr 2026 21:54:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tICipuFI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC02E80433; Thu, 30 Apr 2026 21:29:12 +0200 (CEST)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3A7D80086
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 21:29:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qk1-x741.google.com with SMTP id
 af79cd13be357-8ee9ec26edaso137430485a.2
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 12:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777577349; x=1778182149; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ll7SLmnATBkjqyUObu7V8IUx7+FzP6hu30+5iarwBqc=;
 b=tICipuFIYYQOhg0ITCczK16MQQ1niK1p5bDCCMqVHu7FtAkWq31b96AsLmHQLKgXIi
 yLpwQmq46LLHThOvl1UPdgv5DuZ2MpKonnbmkBTIoAOdilMz2Gl9GAei7TR53VlEbcBz
 Za3oOXr+q4X39X5hFE1hPFVserOX1GEnbzeb0SeikuMojtpnofKBvfsKH2hstzv0DVNm
 BLhiLJ3BgBQt8RoWCJ1FZOHmibZQbGlS0V2wqp4T79SrmokP2/dIabTTtzYW1T+p4081
 KLE0GKd58sV/skaXayMStSW7qy9kHMtRpRJI/wHFiyNg3WOUTFxxlFkT9BRRLdtv/B/D
 OiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777577349; x=1778182149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ll7SLmnATBkjqyUObu7V8IUx7+FzP6hu30+5iarwBqc=;
 b=nJEaJ3Bi/xH2ih+CFKYSorepx69x2F5LcAOTaMOXiGkBHjyHvXaEpW8XwlK5epgIHm
 JDKoTEBIaDoyW1ulXSqm4BoSUdW+V3WbiRkcfKh5mpJ/efEbhMcoZriTuGGjaxm8ewmr
 ofQgCPTcUid36lV6rgSuVxFEnd7R72smMWZbsTMvnU21V74MRhv3YJePQXcTiqHd9Nt3
 7j8hLAsYZt6gpBrQUTUe85Lpw5M97Wp9v1BXHP5caepI2zCyfYNtWX21e6JfTaoiq3Iy
 pFzGtn6D+WMcsqTyYdarifTd5YO9Bev7uij0iGYflWul/W2UOatYoau1x+t7F4TpWmTy
 7jNw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+A1SfOFVRjN9azpLt1mNwfBoYhR8UTS6MhiN4qIBz76UF5P09Dd1kgLPk0KT33g/8cq5qhvXI=@lists.denx.de
X-Gm-Message-State: AOJu0YxkXF6tFNejGl9Qlx2w2808OY/lS834pVxwfycsRq6q0JDQ03pQ
 a8WKLCbUWpKsXrROoMgFrbSq4JamFb8oC4PU5UUfXWJrsT4W7u1UIICK
X-Gm-Gg: AeBDiesUt9brPQ5z+6eWsG9px+kiCMyOVPg7cQYjaDefUfm0Lkqbjl+NybSV2wR5Zf4
 sTk/S9UwW4KAQCKIJz7xB6aX0j3jVKRe4BAFuBaZiZAKtsmkJIOzfnZJT7fmJ/x5+BAuOev41Y8
 P1y6nnpBng8ZY7L9M+QAT02y1CBZFBYvl87N9DjWNG4dHmMwg/hC56jUa3DIHUVaBKSbDPX5WiS
 YHdJ7+XKu3tCAWWW1ChvwbwnmpbYMWaKpou2sj9arfFOoYTMgExpENK6bFkp9NoBEBG1bJTiGzb
 nQ+HytOi6GClzSRZkXO7JWrIOD40Fl4Q4VZEtuIIw0JF9RFpJuuXeghxqsdJsq0uGABZF6AoTeT
 BtilIDKCJNIUzHGl2X0P4lNdV9BKP+f70790aa6ufwyLPIqdvPTOKuKlwEQtU/4/DNakZVNqekS
 NeDiqD1xGbvk/PTfi51gU6iUzFLiFPYxlyxfBTAmMuvGZ0qJr/XevBMzbNGLI=
X-Received: by 2002:a05:620a:3713:b0:8ee:9f5e:e13c with SMTP id
 af79cd13be357-8fa86db7e62mr695864385a.21.1777577348828; 
 Thu, 30 Apr 2026 12:29:08 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fbb4217728sm61805585a.40.2026.04.30.12.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 12:29:08 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: sjg@chromium.org
Cc: caleb.ethridge@analog.com, jcethrid@gmail.com, linux@analog.com,
 malysagreg@gmail.com, philip@philipmolloy.com, trini@konsulko.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v5 14/15] arm: sc5xx: Add fdt_addr_r, kernel_addr_r,
 and ramdisk_addr_r
Date: Thu, 30 Apr 2026 15:29:06 -0400
Message-Id: <20260430192906.4945-1-jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAFLszTi5QJUZ5uKAc7W1nATXSc_yv_WHaFXhzcgrpF2bhupzRw@mail.gmail.com>
References: <CAFLszTi5QJUZ5uKAc7W1nATXSc_yv_WHaFXhzcgrpF2bhupzRw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 30 Apr 2026 21:54:39 +0200
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

Hi Simon,


> The other 32-bit boards in this patch leave ~16
> MiB. Is that intentional?

No, this looks to be a typo in the ramdisk_addr_r, all of the boards 
allocate the same space for the kernel image in the load. This will be fixed
in the next revision.

> How about picking a distinct value now so
> the future booti patch doesn't have to touch every board file again?

I'm not sure I follow your meaning here? Ultimately when booting a user would 
choose to either use the fitImage with bootm or the booti approach with 
everything loaded individually, and there is the potential that once booti
support is added we will deprecate and completely replace the bootm commands with booti
versions.

Also, currently when we build the fitImage, we place the ramdisk and kernel 
offset in the fitImage so that when loaded to CONFIG_SYS_LOAD_ADDR, they would appear
at the addresses from the environment for the ramdisk and kernel. So if you were to 
load the fdt, kernel and ramdisk to these addresses, then create a fitImage with our
build system with those same images and load it at CONFIG_SYS_LOAD_ADDR, nothing in the
RAM would change.

Does this make sense? It would not ultimately matter if you loaded the fitImage or the 
pieces individually, as they would be loaded to the same locations in memory.

Thanks,

Caleb Ethridge
