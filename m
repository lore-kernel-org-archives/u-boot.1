Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CC2CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 18:14:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B987F84815;
	Fri, 15 May 2026 20:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Yg4cTdw3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CBDF84815; Fri, 15 May 2026 20:14:18 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B6D78482F
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 20:14:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-47bdee5bfc4so18440b6e.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 11:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778868854; x=1779473654; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7lbPZw+mgmp+2mSkKy03RJ5vCav+nRYf3feTo31RHjc=;
 b=Yg4cTdw3GfdiygQiQhAp5lq0mK1qUh0MjaYsM61jwWrkyT0ktCprz9my7ie7GVLswM
 MuVgl8V7O0AT/3jjlMQx10XDlgetijUiZ5sY7N3sJp2+zvR9u7wuApaQzxmBrI5rEQGt
 ESsM+Xg98kFylHEprX24MmyuYh78+75qCdFMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778868854; x=1779473654;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7lbPZw+mgmp+2mSkKy03RJ5vCav+nRYf3feTo31RHjc=;
 b=Y4Zy8DYxGsi3DpIETlTb/iSFSD8rWYCJDK6zyvmF7WihI3icv+0/6r+4nTLGCo31vw
 cDIM4wljpTzWes6ve0qUoDDqsMezRXzJTyw8xiDYSe94JflWJpqeV8m4UlroLoz0gMcu
 xH92cUxcflelVLYuuMUa3UKUbTp890EP6jxtAz69ScMSDbtO1IdlE1/yLW1N4vuGAcVX
 eYdOgxggUM0NxE0uStVpA0NmwxyOGml3Y8+qRYHQx+HKLfZ0nCyXwfsFnsgGP63/zra/
 MHD6prvrDHXxxB1NqE4c2Y27gj/+0H4oA7Vz33qEMzSDtxsSwBjzBQzNLfgsaMO2gxOc
 0DUA==
X-Gm-Message-State: AOJu0Ywnjr6NLmVGSzjZESpDUuWfRSpLCH/sHAiUotk//Iyvx5EoG8cR
 DLslH51TdMCzp1pWeljmq+ZOCpDikh2kB+91axIVIv9S1wttExkRzSZbR82rnrPd9wM=
X-Gm-Gg: Acq92OFiqv4+c0iwsqGLfG6tZgHTtvTCc6Wm7mFwfZyYeFUamGSGIEPUVkI2n6NTT19
 Jl3MasGPCSsdM8TPvaXmT6Bu8WpYKCHJkMOaqGslJCVZUI1I0OLRpTP24s3Qy2qm52giUc3OEEw
 038Uv6rZ+7v9O7FymAk6FZSCYeI6SBfPsrVXDnTp4QyYY6kw3hq8C8WRB6cU33ydoohxoTMycWZ
 TQtXddkkINaYMAdk/7PNve4XDVWPvrf3patAdWgFylt3lvXvD5rxUxsKOAdBlmET2Jxo7CmljSR
 ngnoga9R8KRY7y1v6r2atPb9q7USTQYuoy7mayqH31GTvOxpfH4NHSsCQfhEGeGUxPSK5MwhlHx
 Totfi1b6b/kB5U4GXiS2LfjClHnJdLkEMB7UVLozSWrPTwu0hlm3aLi0nmzxO32beMhCDqVHVAe
 qbICLwVGoF5BHJAvQFr4r0hDNPLGcUKmjyfG6A/sDOp3UOCTpSA8cH31Kobc/cVt7VsTlt8a6gS
 guTGgw4AZedGcB0196+SNAQuEtDeDR0yhK7WX+fz5QGsqdBXg==
X-Received: by 2002:a05:6808:2204:b0:479:ec96:f4de with SMTP id
 5614622812f47-482cb71fed9mr5490490b6e.2.1778868854312; 
 Fri, 15 May 2026 11:14:14 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4749esm1988872a34.23.2026.05.15.11.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 11:14:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, Hiago De Franco <hfranco@baylibre.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@gmail.com>
In-Reply-To: <agbo_Frbw1gfzQ2B@nxa18884-linux.ap.freescale.net>
References: <agbo_Frbw1gfzQ2B@nxa18884-linux.ap.freescale.net>
Subject: Re: [GIT PULL] Please pull mmc-next-2026-05-15
Message-Id: <177886885334.657193.17801109929977590144.b4-ty@konsulko.com>
Date: Fri, 15 May 2026 12:14:13 -0600
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

On Fri, 15 May 2026 17:35:56 +0800, Peng Fan wrote:

> Please pull mmc-next-2026-05-15
> 
> ----------------------------------------------------
> Staticize and constify driver ops patches from Marek
> Check 'no-1-8-v' property in cv1800b_sdhci driver
> Drop unecessary timer initialization for sdhci
> ----------------------------------------------------
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


