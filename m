Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23176C4450A
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 23:25:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC6F484DEE;
	Fri, 17 Jul 2026 01:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TzpTm766";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87D1C84E02; Fri, 17 Jul 2026 01:25:18 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B0EA84D9C
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 01:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-448de0cc236so4269411fac.2
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 16:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784244315; x=1784849115; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jwq/TX/tML7nzvajaBlJltLcUygHdpTWQ5VQYG6HmZA=;
 b=TzpTm766WnngWTMMzYDp87rAKBupntwx20KnTflqbP2EB+hz+1vxfTy00z4y1gppOY
 NG9zwhXqwBcjIfP4aQ+wA+ofHTtQDUp5E2MBGsBMwmiUZVbAHRwovrSY1qH7i9ND8IZ2
 1o0Mm4OhLwxmSp86tVGIKROIhffcJzHaFd/jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784244315; x=1784849115;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jwq/TX/tML7nzvajaBlJltLcUygHdpTWQ5VQYG6HmZA=;
 b=ix2rfwkrjtNh9UTMd7UH4WCws4eb2HOPOYfUTVpezMrsy1jRH0kAeE3P+32wixSpmC
 l1Y70Er/bT67Xch63ZfT05bUUq5yVhq3IgxtulfZhvHg6CCrkGX9ZzQABZv5u5kQYVpL
 n6ffmi5TXfsyKngvhtfFC6Yz0bR4lADHk7vlPBNEN+AEcwXXmCue2wLO5fWj08t3aA+C
 j1JMDvGCGl13+vm9mcsqW0mxE2jQHrElMdsp+gGT0I+lsSqGXIx+56GRtywbYGo+8+Q0
 sC5lJmDq+fydnWZgi8FmMFbRVtOqq99ctMkEnjvIzQkiBAZ7tsL4mFv17iiuYJger1Kr
 yKEA==
X-Gm-Message-State: AOJu0YyfJJQDdnZGq6St39432xSSKQ3+QrPPfX9UUU1ZP+upujia6BBm
 C5bVUQSIIIhJl86IBCzAGExRfxgveqoIBV5VofbvZPX0RX1LCdIYLbJQiwzRDVG+v1A=
X-Gm-Gg: AfdE7cmD/yeNAa2+oxu85vwITTVSeHau244BTQZ9gQFFbtGhUU7jj8S++yuBXLdUn9o
 5s7YwSADvUOsphd9g77WdreGWlpitukH8XhkC144FghgjUhsQC1h4zrEmUylfPzU+nLhLcNtswq
 Ne4LXvX98abOw+QbaNrim+x0sebDRbTGlSOuTl1HGJAuJcU3TmLFT1vIJxTbqdRY8Z8Vaz3xumG
 +cEAtW1NHfmuG48BwAJoODa04qe34e1yUb1K5A5prscff8yqXc/fdlfBlsv9h0DfOYwxDpQ2nKc
 jXHZ9eRSPnhwsyBlWCQeJnOhGLfVjrwq3dDgiykWQMrAw41UYkQlupxT5D36cYOCGz6QgT3VpbH
 e91TSpiH6+z9DgPE2P3L5C3HB21Dw+bREcntiJNfvC2ccwVSSc6GNcDecKVKF/qNGHiQVUjRjO2
 /5jXdIhAX/D1SMx24y6jDJ4TQ7axbTeHVQIA/Wnl3PafiR3KNo6/bTsUwghtzVpYj3uC7v8SJYF
 mgPxB3lPGGYnaEp7McJnScO9A==
X-Received: by 2002:a05:6871:c8c5:b0:449:bccd:79fb with SMTP id
 586e51a60fabf-455f8023b9bmr9851964fac.24.1784244315133; 
 Thu, 16 Jul 2026 16:25:15 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4568da4ab47sm27308fac.0.2026.07.16.16.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 16:25:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Aristo Chen <aristo.chen@canonical.com>
In-Reply-To: <20260705034414.2247-1-aristo.chen@canonical.com>
References: <20260702071425.9204-1-aristo.chen@canonical.com>
 <20260705034414.2247-1-aristo.chen@canonical.com>
Subject: Re: [PATCH v3 0/3] vbe: bound FIT external-data reads against the
 firmware area
Message-Id: <178424431412.1470194.13819143783454179058.b4-ty@konsulko.com>
Date: Thu, 16 Jul 2026 17:25:14 -0600
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

On Sun, 05 Jul 2026 03:44:08 +0000, Aristo Chen wrote:

> vbe_read_fit() loads a firmware-phase FIT from a fixed firmware area on
> a block device and then issues a follow-up blk_read() to pull in the
> image, and optionally an FDT, referenced by the FIT's image node. The
> source offset on the device and the read length both come from the FIT
> itself, via data-position or data-offset and data-size. Those properties
> live on mutable boot media and can be controlled by an attacker with
> write access to the firmware area. On the TPL or VPL path, and on the
> bootmeth bootflow path reached via abrec_read_bootflow_fw() and
> vbe_simple_read_bootflow_fw(), the follow-up blk_read() runs before any
> signature or hash check on the loaded phase.
> 
> [...]

Applied to u-boot/main, thanks!

[1/3] sandbox: vbe: size firmware1 area to fit the binman fw-update section
      commit: a8fc408cdfcbc3d8a04b493510a54d852f60550d
[2/3] vbe: bound FIT external-data offset and size before blk_read
      commit: a84c7670a698c1d42a6da7e713afdeaaa51eae46
[3/3] test: vbe: cover vbe_read_fit() external-data bounds checks
      commit: 9fa00f563bea7ac4a4fda3220e05b21ebd4a242f
-- 
Tom


