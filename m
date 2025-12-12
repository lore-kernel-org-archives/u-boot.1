Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0D2D49232
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 14:46:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E16E98334F;
	Fri, 12 Dec 2025 15:46:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qj/nFGEj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E0D4835B3; Fri, 12 Dec 2025 15:46:49 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47F5683106
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 15:46:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-656d9230ceaso465929eaf.2
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 06:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765550806; x=1766155606; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7OlOF0ky5gAwHTVPo8Ib6emP1XnMzwbpTIhrOYfayME=;
 b=qj/nFGEj6wZLpnxI74OS2dz8hml9Z/tIrdd5SRI7hm116RCk+SKPJSiVWFsJXxldUn
 AxSRbOpKoSwiCVDivMeTmMIlTq7W4vIZVIYKP+mds1fZSUaFBHDynFNkgJ6rVitKcLfb
 JnU9ZtJoVY9c+jwfwV7SfZfxagVbbH5g/AfNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765550806; x=1766155606;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7OlOF0ky5gAwHTVPo8Ib6emP1XnMzwbpTIhrOYfayME=;
 b=J37+LtBYoTdUVHcuh//wwz7vjxt21gEupcN6jjccvr9QuRwdvZHbMOPcfESwf0owVD
 5CEoLJ5HLe2FRuumd9j7jesDhCtMqskUx24whFT79mH2mbxwHntqecw3kck1+HxRCbZI
 9xEyKonbEurcmWP0W56A2nL1/TBVyPHI4xHBgEIbIhRvCMBytarY4iZuF0h0KGy7sZNe
 MwZGV7ODnMn2QiPoFXzaxhM/IRSViinOlnQ5TqfpVjuLs935m5UgPycMmPMLxLs8b6Eg
 Fecd9EtQL5LNeeornK6sQnnYRQIj71vxnULt6oPckBrYvl8dvEkBH8mDXIp48JWPQPAf
 WZ8g==
X-Gm-Message-State: AOJu0Yws36Lnozt2vc4GET2Yz79PiWKKP+L/KSqNL3zAumDNZxqZuIpr
 KoKTsnC0aHKUt316rTNVymofSRVMhhV1s3orxjQPfZCRvWnmfH8jOlc9DDPMqn1bAgg=
X-Gm-Gg: AY/fxX6npPB5kyDr7vvvxYMA2SYzsBfA+6iVD2BnJY9rE/ishBsN+QzTwXWMdeAltD+
 pKENMyN+4cWx3S9mD5EYQnp/7UsK2QB1BQLyda3KSjhu+T7YJSROjgTeVRAmIzchEhw+DxK9mJ5
 r0v+6Se6jTDoUw0NH0vdknS31s1FJUx9LYvPtpi1fgXtWd+rr/xcH5XmTcClrj8Lkk36BQhdWzk
 up28mCnfuz7C20vgsYr9QlTAET7YK66mnNDDtfUMkj+eaG+yoRElHDWCvWPYJY6StBZeNyhDQ2W
 wrMuTwt+aWDZhY+sTNXFF5t1vcZ7sza9i2ojCIfVBUiIyMqYQc5f3dtAbbGySYyuy6LCAvWDgQm
 0S/sU3y7qgLQFlyiDRmp8MqW9P8lV8AB7lWif9nhlqIlm0hmAgw2n/4LZM1a28Kk2J5a8Q1YEHD
 T5ZUnen9rEXioLQakG2Gyk+h7ibKTwi4maHDPrhemdUlI5qMhr
X-Google-Smtp-Source: AGHT+IFAEgAswh4UrvS/3MCfxFITHhmJzPuDL6kKsgmfzGmYJDUkBWu8wgIDpgD+tr915qh7m+8ZFg==
X-Received: by 2002:a05:6820:1caa:b0:659:9a49:90a7 with SMTP id
 006d021491bc7-65b451c2f92mr964320eaf.38.1765550805942; 
 Fri, 12 Dec 2025 06:46:45 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65b360aaeb9sm2769896eaf.10.2025.12.12.06.46.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 06:46:45 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, Nishanth Menon <nm@ti.com>
In-Reply-To: <20251212011906.865419-1-trini@konsulko.com>
References: <20251212011906.865419-1-trini@konsulko.com>
Subject: Re: [PATCH] Revert "clk: Return value calculated by ERR_PTR"
Message-Id: <176555080490.1014228.3111210213892957247.b4-ty@konsulko.com>
Date: Fri, 12 Dec 2025 08:46:44 -0600
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

On Thu, 11 Dec 2025 19:19:06 -0600, Tom Rini wrote:

> While this change was intended to fix a mistake in the code, of calling
> the ERR_PTR macro but not making use of the result, it seems that
> functionally platforms depend on the loop not existing here. The TI K3
> families of platforms for example were broken by this commit.
> 
> This reverts commit fe780310cfa8bf5a093894b5cd7fe85c6b02fd91.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] Revert "clk: Return value calculated by ERR_PTR"
      commit: aff0f4d30ec6d7968578fc05fc6df6b5700d9913
-- 
Tom


